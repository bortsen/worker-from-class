Worker from Class
=================

Allows you to create ActionScript Workers from Class definitions instead of loading or embedding a bulky SWF file.

Requires Claus Wahlers' excellent [as3swf library](https://github.com/claus/as3swf) for some SWF magic.

Prerequisites:
- download worker-from-class
- download [as3swf](https://github.com/claus/as3swf) and copy its /src/com folder into the worker-from-class /src folder
- download the 11.4 playerglobal.swc (available at the [Adobe labs](http://labs.adobe.com/downloads/flashplayer11-4.html))
- add the 11.4 playerglobal.swc to the build path
- set the compiler options -swf-version=17 and -target-player=11.4

Usage:
- use WorkerFactory.getWorkerFromClass(ClassReference, swfByteArray) to create a new Worker based on the ClassReference. The swfByteArray must be a valid SWF file ByteArray (e.g. loaderInfo.bytes)
