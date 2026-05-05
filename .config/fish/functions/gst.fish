##? gst - launches gstreamer connecting to a RTSP stream with low latency.
function gst
    argparse 'i/ip=' v/verbose 'l/layout=' 'p/pip-offset=' -- $argv
    or return

    if not set -ql _flag_ip
        echo "Error: Need ip address of RTSP source"
        echo "Usage: gst -i IP [-l grid|pip] [-p PIP_OFFSET] [URL1] [URL2...] [-v]"
        return
    end

    set -l urls $argv
    set -l num_streams (count $urls)
    set -l verbose_flag ""

    if set -ql _flag_verbose
        set verbose_flag -vvv
    end

    set -l layout pip
    if set -ql _flag_layout
        set layout $_flag_layout
    end

    set -l pip_offset 20
    if set -ql _flag_pip_offset
        set pip_offset $_flag_pip_offset
    end

    if test $num_streams -eq 0
        echo "Error: No stream URLs provided."
        return
    end

    # --- Build URIs ---
    set -l uris
    for url in $urls
        set -a uris "rtsp://$_flag_ip/$url"
    end

    # --- Low Latency Settings ---
    set -l rtsp_opts "latency=200"

    # --- Single stream ---
    if test $num_streams -eq 1
        gst-launch-1.0 $verbose_flag \
            rtspsrc location=$uris[1] $rtsp_opts ! \
            rtpjitterbuffer ! decodebin ! \
            videoconvert ! queue max-size-buffers=1 leaky=downstream ! \
            fpsdisplaysink sync=false
        return
    end

    # --- Probe all streams ---
    echo "Probing $num_streams stream(s)..."
    set -l widths
    set -l heights
    for uri in $uris
        set -l discovery (gst-discoverer-1.0 $uri 2>&1)
        set -l w (echo $discovery | grep -oP 'Width: \K[0-9]+')
        set -l h (echo $discovery | grep -oP 'Height: \K[0-9]+')
        if test -z "$w" -o -z "$h"
            echo "Warning: Could not probe $uri, assuming 1920x1080"
            set w 1920
            set h 1080
        else
            echo "  $uri -> "(string join x $w $h)
        end
        set -a widths $w
        set -a heights $h
    end

    set -l comp_props "background=black start-time-selection=0"
    set -l chain ""

    if test "$layout" = pip
        set -l bg_w $widths[1]
        set -l bg_h $heights[1]
        set -l pip_w (math "round($bg_w / 4)")
        set -l pip_h (math "round($bg_h / 4)")

        set comp_props "$comp_props sink_0::xpos=0 sink_0::ypos=0 sink_0::zorder=0"
        for i in (seq 2 $num_streams)
            set -l idx (math "$i - 1")
            set -l px (math "$bg_w - $pip_w - $pip_offset")
            set -l py (math "($i - 2) * $pip_h")
            set comp_props "$comp_props sink_$idx::xpos=$px sink_$idx::ypos=$py sink_$idx::zorder=$i sink_$idx::width=$pip_w sink_$idx::height=$pip_h"
        end
    else
        # Grid mode
        set -l cols (math --scale=0 "ceil(sqrt($num_streams))")
        set -l rows (math --scale=0 "ceil($num_streams / $cols)")
        echo "Grid: "(string join x $cols $rows)

        set -l col_widths
        set -l row_heights
        for c in (seq 1 $cols)
            set -a col_widths 0
        end
        for r in (seq 1 $rows)
            set -a row_heights 0
        end

        for i in (seq 1 $num_streams)
            set -l idx (math "$i - 1")
            set -l col (math "$idx % $cols + 1")
            set -l row (math "floor($idx / $cols) + 1")
            if test $widths[$i] -gt $col_widths[$col]
                set col_widths[$col] $widths[$i]
            end
            if test $heights[$i] -gt $row_heights[$row]
                set row_heights[$row] $heights[$i]
            end
        end

        set -l col_offsets
        set -l running_x 0
        for c in (seq 1 $cols)
            set -a col_offsets $running_x
            set running_x (math "$running_x + $col_widths[$c]")
        end

        set -l row_offsets
        set -l running_y 0
        for r in (seq 1 $rows)
            set -a row_offsets $running_y
            set running_y (math "$running_y + $row_heights[$r]")
        end

        for i in (seq 1 $num_streams)
            set -l idx (math "$i - 1")
            set -l col (math "$idx % $cols + 1")
            set -l row (math "floor($idx / $cols) + 1")
            set -l px $col_offsets[$col]
            set -l py $row_offsets[$row]
            set comp_props "$comp_props sink_$idx::xpos=$px sink_$idx::ypos=$py"
        end
    end

    for i in (seq 1 $num_streams)
        set -l idx (math "$i - 1")
        set chain "$chain rtspsrc location=$uris[$i] $rtsp_opts ! rtpjitterbuffer ! decodebin ! videoconvert ! queue max-size-buffers=1 leaky=downstream ! comp.sink_$idx"
    end

    eval "gst-launch-1.0 $verbose_flag compositor name=comp $comp_props min-upstream-latency=0 ! videoconvert ! fpsdisplaysink sync=false $chain"
end

# vim: ft=fish ts=4 sw=4 expandtab
