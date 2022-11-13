# minidlna-custom-icon
MiniDLNA in docker, compiled with custom icon support

The official MiniDLNA source code (https://sourceforge.net/projects/minidlna/)
with the archlinux custom icon patch (https://aur.archlinux.org/packages/minidlna-custom-icon).


As an example, add these lines to /etc/minidlna.conf, supposing your icons are located in /usr/share/minidlna/icons/:

    icon_png_small=/usr/share/minidlna/icons/icon_x48.png
    icon_png_large=/usr/share/minidlna/icons/icon_x120.png
    icon_jpeg_small=/usr/share/minidlna/icons/icon_x48.jpg
    icon_jpeg_large=/usr/share/minidlna/icons/icon_x120.jpg



## environment variables

This docker image uses the following environment variables:

MINIDLNA_CONFIG, defaults to /etc/minidlna.conf
MINIDLNA_EXTRA_ARGS, defaults to -S



## example

run:

    docker run -dit --name minidlna buffertly/minidlna
