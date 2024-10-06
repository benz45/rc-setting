# RC Setting

[![Developer](https://rebirth-rc.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2FLogo-size180.6c8f1426.png&w=96&q=100)](https://rebirth-rc.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2FLogo-size180.6c8f1426.png&w=96&q=100)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

## Features

Service for Updating Game Settings in RebirthRC

- Graphics Settings: Update graphics settings such as screen resolution, texture quality, 3D settings, etc.
- Sound Settings: Adjust sound settings including volume levels, sound types, and audio device settings.
- Inviting Friends: Update methods for inviting friends to play the game or manage invitations from friends.


## Configuration

windows/CMakeLists.txt

```
SET_TARGET_PROPERTIES(${BINARY_NAME} PROPERTIES LINK_FLAGS "/MANIFESTUAC:"level='requireAdministrator' uiAccess='false'" /SUBSYSTEM:WINDOWS")
```

windows/runner/main.cpp

```
#include <bitsdojo_window_windows/bitsdojo_window_plugin.h> auto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);
```
## Environment (.env)

``` sh 
GOOGLE_SHEET=${YOUR_CODE}
JWT_ACTIVATE_SECRET=${YOUR_CODE}
ENCRYPT_SECRET=${YOUR_CODE}
ENCRYPT_IV=${YOUR_CODE}
```
## Plugins

Dillinger is currently extended with the following plugins.
Instructions on how to use them in your own application are linked below.

| Plugin | README |
| ------ | ------ |
| Dropbox | [plugins/dropbox/README.md][PlDb] |
| GitHub | [plugins/github/README.md][PlGh] |
| Google Drive | [plugins/googledrive/README.md][PlGd] |
| OneDrive | [plugins/onedrive/README.md][PlOd] |
| Medium | [plugins/medium/README.md][PlMe] |
| Google Analytics | [plugins/googleanalytics/README.md][PlGa] |




## License

GPL-3.0 license

**Let me know if you need any more help!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
