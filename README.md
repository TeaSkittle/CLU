# CLU
Date Started: 2-7-2020 (v0.1)  
Version 1.0 completed on: 2-26-2020  

### Description
This script is used for calling other files / functions to ease the proccess of setting up new devices after installing Windows 10, imaging new systems, setting up a new device in the field, and cleaning up older PCs.  

### Why CLU?
It is a name taken from the Tron films, the character CLU was designed to create the perfect system, as is this program :smirk: Name also inspired by tronscript ( https://github.com/bmrf/tron )  
Quote from Tron Legacy:  
&nbsp;&nbsp;&nbsp;&nbsp; Kevin Flynn: You are CLU.  
&nbsp;&nbsp;&nbsp;&nbsp; CLU: I am CLU.  
&nbsp;&nbsp;&nbsp;&nbsp; Kevin Flynn: You will create the perfect system.  
&nbsp;&nbsp;&nbsp;&nbsp; CLU: I will create the perfect system.  
&nbsp;&nbsp;&nbsp;&nbsp; Kevin Flynn: [embracing CLU] Together we're going to change the world, man.  

### Instructions
Near the top CLU.bat are varaibles the user should change for the proper automation:
* defip   - default IP address ( this is just for display, not an actual address )
* defsub  - default subnet mask
* defgate - default gateway
* defdns  - default dns ( this is set to google's 8.8.8.8 )
* deftime - Default timezone ( used to force windows updates )
* dest    - Destination folder for downlods and logs
* down[]  - Array of URL's for file to be downloaded
* apps[]  - Install/run files downloaded from down[]
* step    - Size of array ( used for looping through array )

#### Download and run ( as admin ):
```
$ git clone https://github.com/TeaSkittle/CLU.git
$ cd CL*
$ CLU.bat
```

### WARNING!!!
Be sure to read the batch files before running and make sure that all varables listed above are changed to your needs. This is designed for my own use and has not been tested on a wide variety of machines. As always, use caution when running scripts found online!
