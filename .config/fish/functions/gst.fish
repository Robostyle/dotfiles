##? gst - launches gstreamer connecting to a RTSP stream.
# -i, --ip        The ip address
# -u, --url       The media url (defaults to 'video-1.encoder-1')

function gst
    argparse 'i/ip=' 'u/url=' -- $argv
    or return

    if not set -ql _flag_ip
        echo "Need ip address of RTSP source"
        echo "Usage: gts -i | --ip=IP-ADDRESS [-u | --url=URL]"
        echo "Examle:"
        echo "    gts -i 10.1.0.222 -u videoenoder/1/ [-u | --url=URL]"
        return
    end

    set --local url video-1.encoder-1
    if set -ql _flag_url
        set url $_flag_url
    end
    echo $url

    gst-launch-1.0 playbin "uri=rtsp://$_flag_ip/$url" uridecodebin0::source::latency=100 video-sink="fpsdisplaysink"
end

# vim: ft=zsh ts=4 sw=4 expandtab
