#!/bin/bash

rsync -e "/usr/bin/ssh" -av $HOME/.attract fatavatar@arcade.thelucks.org:~/mirror
rsync -e "/usr/bin/ssh" -av /opt/retropie/configs fatavatar@arcade.thelucks.org:~/mirror
rsync -e "/usr/bin/ssh" -av /opt/retropie/emulators fatavatar@arcade.thelucks.org:~/mirror
