# gunter

Service for Updating Game Settings in Raycity RCRB

- Graphics Settings: Update graphics settings such as screen resolution, texture quality, 3D settings, etc.

- Sound Settings: Adjust sound settings including volume levels, sound types, and audio device settings.

- Inviting Friends: Update methods for inviting friends to play the game or manage invitations from friends.

Let me know if you need any more help!


# Add Config
----------------------------------------------------------------------------------------------------------------------
windows/CMakeLists.txt

SET_TARGET_PROPERTIES(${BINARY_NAME} PROPERTIES LINK_FLAGS    "/MANIFESTUAC:\"level='requireAdministrator' uiAccess='false'\" /SUBSYSTEM:WINDOWS")

----------------------------------------------------------------------------------------------------------------------
windows/runner/main.cpp

#include <bitsdojo_window_windows/bitsdojo_window_plugin.h>
auto bdw = bitsdojo_window_configure(BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP);

----------------------------------------------------------------------------------------------------------------------

# Environment
GOOGLE_SHEET=<you code>
JWT_ACTIVATE_SECRET=<you code>
ENCRYPT_SECRET=<you code>
ENCRYPT_IV=<you code>


git remote add origin git@github.com:benz45/rc-setting.git

test-reset