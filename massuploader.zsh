#!/bin/zsh

#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, get one on http://www.gnu.org/licenses/gpl-3.0.txt


LEVEL=9
TEMPORAL="/tmp/uploads/"
if  [ "$1" =  "" ]; then
    DIRECTORY=`pwd`
    USER=''
    PASSWORD=''
    /bin/echo "I have not detected any specified folder, i will upload automatically your files located on your current folder"
else;
    DIRECTORY=$1
    cd $DIRECTORY
fi
if [ -d "$TEMPORAL" ]; then
    /bin/echo 'The temporal directory for uploads already exist.'
    /bin/echo 'I will start zipping all your contents on: '
    /bin/echo 'on the folder:'
    /bin/echo $TEMPORAL
else
    /bin/mkdir -p $TEMPORAL
    /bin/touch /tmp/upload.txt
    /bin/echo 'I have created a temporal directory on:'
    /bin/echo $TEMPORAL
fi

echo 'Start zipping contents'
for file in $DIRECTORY/*; do
    if [ -d "$file" ]; then
        /bin/cp $HOME/Documentos/uploaded_for_free_culture.txt "$file/"
        /bin/cp $HOME/Documentos/subido_para_la_cultura_libre.txt "$file/"
        filemon=`echo $file|sed "s=${DIRECTORY}/=="`
        #~ /bin/echo $filemon
        /usr/bin/zip -rj$LEVEL "/tmp/uploads/$filemon.zip" "$file"
        /bin/echo "$filemon:"  >> /tmp/upload.txt
        /usr/bin/plowup -v0 -a $USER:$PASSWORD -d "$filemon" "/tmp/uploads/$filemon.zip" megaupload >> /tmp/upload.txt
        /bin/echo '------'  >> /tmp/upload.txt
        #~ /bin/rm filemon
    fi
done
/bin/echo 'The list of links has been written to /tmp/upload.txt'
#~ /bin/less /tmp/upload.txt
#~ rm /tmp/upload.txt
exit 0
