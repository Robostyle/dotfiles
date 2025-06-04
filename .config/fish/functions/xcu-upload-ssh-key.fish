function xcu-upload-ssh-key
    argparse 'i/ip=' 'd/delete=' get -- $argv

    if not set -ql _flag_ip
        echo "Need an IP-address"
        echo ""
        echo "Usage: xcu-upload-ssh-key -i | --IP=IP-ADDRESS [--get] [-d | --delete=ID]"
        echo ""
        echo "Examples:"
        echo "Get list of public keys allowed"
        echo "  xcu-upload-ssh-key --ip 10.1.0.222 --get"
        echo ""
        echo "Upload the user's id_ed25519.pub key"
        echo "  xcu-upload-ssh-key --ip 10.1.0.222"
        echo ""
        echo "Delete the key with a given ID"
        echo "  xcu-upload-ssh-key --ip 10.1.0.222 --delete fc60dfdf-b349-4710-8631-a56298dfe77b"
        return
    end

    if not set -ql _flag_get
        if set -ql _flag_delete
            set -f payload $(jq -cn --arg id "$_flag_delete" '{$id}')
            set -f request -XDELETE
            set -f extra_args "-d$payload"
        else
            set -f payload $(jq -cn --arg key "$(cat ~/.ssh/id_ed25519.pub)" --arg label "$(hostname)" '{$key, $label}')
            set -f extra_args "-d $payload"
        end
    end

    echo $extra_args

    curl $request $extra_args \
        -H 'Content-Type: application/json' \
        --digest \
        -s \
        -u Admin:Admin1234 \
        "http://$_flag_ip/api/ssh-keys" | jq
end
