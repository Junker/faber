_faberfile_comp() {
    if [[ -f "faberfile" ]];
    then
        local opts
        opts="`faber --summary`"
        reply=(${(s: :)opts})
    fi
}

compctl -K _faberfile_comp faber

# alias fb=faber
