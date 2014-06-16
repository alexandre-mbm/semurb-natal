#!/bin/bash
#
# Copyright (c) 2014 Alexandre Magno <alexandre.mbm@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function list() {
    count=1
    while read LINE; do
        printf " %2d " "$count"
        sed -n ${count}p names.txt
        count=$(expr $count + 1)
    done < links.txt
}

function download() {
    nlinks=$(wc -l links.txt | cut -d' ' -f 1)
    [ $1 -ge 0 ] && [ $1 -le $nlinks ] || exit 1
    link=$(sed -n ${1}p links.txt)
    pdf=$(echo "$link" | sed "s/^.*\/\([^\/]*\)$/\1/")
    directory=$(echo "$pdf" | sed "s/\.\w*$//")
    mkdir -p "$directory"
    wget -U firefox -O "$directory/$pdf" "$link"
}

function convert() {
    nlinks=$(wc -l links.txt | cut -d' ' -f 1)
    [ $1 -ge 0 ] && [ $1 -le $nlinks ] || exit 1
    link=$(sed -n ${1}p links.txt)
    pdf=$(echo "$link" | sed "s/^.*\/\([^\/]*\)$/\1/")
    directory=$(echo "$pdf" | sed "s/\.\w*$//")
    if [ -f "$directory/$pdf" ]; then
        echo "Converting $pdf ..."
        pngfile=`echo "$pdf" | sed 's/\.\w*$/.png/'`
        inkscape "$directory/$pdf" -z \
            --export-dpi=320 \
            --export-area-drawing \
            --export-png="$directory/$pngfile"
        echo "Converted to $directory/$pngfile"
    else
        echo "There is no job for the directory $directory."
    fi
    echo "All jobs done. Exiting."
}

function info() {
    if [ $1 ]; then
        nlinks=$(wc -l links.txt | cut -d' ' -f 1)
        [ $1 -ge 0 ] && [ $1 -le $nlinks ] || exit 1
        link=$(sed -n ${1}p links.txt)
        pdf=$(echo "$link" | sed "s/^.*\/\([^\/]*\)$/\1/")
        directory=$(echo "$pdf" | sed "s/\.\w*$//")
        pdfinfo "$directory/$pdf"
        if [ -f "$directory/$directory.cal" ]; then
            echo "Calibration present"
        else
            echo "No calibration"
        fi
        echo "Directory $directory"
    else
        for link in $(cat links.txt); do
            pdf=$(echo "$link" | sed "s/^.*\/\([^\/]*\)$/\1/")
            directory=$(echo "$pdf" | sed "s/\.\w*$//")
            if [ -f "$directory/$pdf" ]; then
                i=$(grep -n "$link" links.txt | cut -d':' -f 1)
                p=$(pdfinfo "$directory/$pdf" | \
                            grep ^Pages | cut -d' ' -f 11-
                )
                cstr=$([ -f "$directory/$directory.cal" ] \
                        && echo "   cal" || echo "no cal"
                )
                pstr=$([ $p -eq 1 ] && echo "page " || echo "pages")
                idir="${directory:0:5}.."
                printf " %2d %3d $pstr  $cstr  $idir  " "$i" "$p"
                sed -n ${i}p names.txt                
            fi
        done
    fi
}

function help() {
    echo
    echo "Help"
    echo
    echo " semurb-pdf list"
    echo " semurb-pdf info [n]"
    echo " semurb-pdf download <n>"
    echo " semurb-pdf convert <n>"
    echo
}

case "$1" in
    list)
        list
        ;;
    info)
        info "$2"
        ;;
    download)
        download "$2"
        ;;
    convert)
        convert "$2"
        ;;
    *)
        help
        ;;
esac

exit 0
