Bump Map Technical Summary
==========================

Bump Map was programmed using Cocos2d-X (http://www.cocos2d-x.org/), a C++
game engine framework. Since one of the project's primary goals was to deploy
to multiple platforms (iOS, Android, and Playstation Vita), C++ was a better
choice than Objective-C for its portability. The majority of the game's
sprite animation is handled by library functions from Cocos2d-X.

Cocos2d-X provides the abstraction of a scene as the rough equivalent of an
iOS view controller (one "screen"). Although this abstraction is commonly used
in iPhone games to handle common problems like screens for title, game over,
and gameplay, Bump Map avoids the scene abstraction altogether. Instead of
using Cocos scenes for the screen transitions within the game, the game over,
gameplay and title screens are all contained in one scene. This scene uses
a state machine system to handle switching between the various modes of
interaction. As such, many of the touch-handling methods include top-level
switches on the current global state of the app (ie, is the app currently in
titlescreen mode or gameplay mode?).

Though the majority of sprite animation is handled by Cocos2d-X, the motion
blur on finger indicators and targets was written on top of the library. The
motion blur works by keeping copies of several different renderable textures
alive throughout execution. Each frame, the motion-blurred sprites are copied
into the earliest texture while keeping copies in the other textures from
several frames prior. This results in, at a given frame, four different
textures each containing an image of the sprites at their positions over the
last four frames. These textures are rendered with increasing opacity to
provide the appearance of blurry motion.

Much of the game's global state is handles by a singleton object. This
decision was made early on to ensure that all important data was globally
accessible to any class that needed to know about it. For example, the current
state of the state machine handling screen transitions is stored in this
singleton to avoid passing around values representing states and risking their
corruption.

The structure of this repository is such that the core game code need not be
duplicated across multiple projects. The fingerrace-core repository holds this
game code, and the Android and iOS project repositories inclue this core code
as a git submodule, symlinking to its files. This way, the most updated code
is always just a pull away regardless of the target platform.
