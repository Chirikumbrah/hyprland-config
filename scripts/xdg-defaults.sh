#!/bin/bash

export IMAGE_VIEWER=qimgv
export PDF_VIEWER=qpdfview
export VIDEO_PLAYER=mpv
export BROWSER=chromium
export EXPLORER=pcmanfm-qt

# img/vid
xdg-mime default $IMAGE_VIEWER.desktop 'image/jpg'
xdg-mime default $IMAGE_VIEWER.desktop 'image/jpeg'
xdg-mime default $IMAGE_VIEWER.desktop 'image/png'
xdg-mime default $IMAGE_VIEWER.desktop 'image/gif'
xdg-mime default $IMAGE_VIEWER.desktop 'image/pjpeg'
xdg-mime default $IMAGE_VIEWER.desktop 'image/tiff'
xdg-mime default $VIDEO_PLAYER.desktop 'video/mp4'
xdg-mime default $VIDEO_PLAYER.desktop 'video/x-matroska'

# browser
xdg-mime default $BROWSER.desktop 'x-scheme-handler/http'
xdg-mime default $BROWSER.desktop 'x-scheme-handler/https'
xdg-mime default $BROWSER.desktop 'text/html'
xdg-mime default $BROWSER.desktop 'x-scheme-handler/chrome'
xdg-mime default $BROWSER.desktop 'application/x-extension-htm'
xdg-mime default $BROWSER.desktop 'application/x-extension-html'
xdg-mime default $BROWSER.desktop 'application/x-extension-shtml'
xdg-mime default $BROWSER.desktop 'application/xhtml+xml'
xdg-mime default $BROWSER.desktop 'application/x-extension-xhtml'
xdg-mime default $BROWSER.desktop 'application/x-extension-xht'
xdg-mime default $BROWSER.desktop 'x-scheme-handler/http'
xdg-mime default $BROWSER.desktop 'x-scheme-handler/https'
xdg-mime default $BROWSER.desktop 'text/html'

# documents
xdg-mime default $PDF_VIEWER.desktop 'application/pdf'

# file explorer
xdg-mime default $EXPLORER.desktop 'inode/directory'

