# RaspberryWordclock-iOS
An iOS App to control the Raspberry Wordclock

# Prerequisites
In order to control your raspberry with this App you have to install WebIOPi (http://webiopi.trouch.com/).  
Follow the install instructions here :
http://webiopi.trouch.com/INSTALL.html  
NOTE: You dont have to access your Raspberry over the Internet. So you can skip Weaved Configuration  

# Install
The App works with 3 virtual GPIO Pins that are mapped to your standard GPIO Pins at the clock (Default : 7,8,11).  
You can define this 3 virtual Pins in the App and the Raspberry Software.

In Order to work with this app you have do add the following changes to the Config File of WebIOPi:
```
[GPIO]
7 = OUT 1
8 = OUT 1
11 = OUT 1
```

Finally apply the Wordclock.patch included in this Repository to your Wordclock Repository on the Raspberry Pi.  
  
After changing Settings in the App you should now be able to control your Wordclock.  
For Raspberry Ip Setting you have to insert your local raspberry ip with the WebIOPi port.(192.168.2.1:8000)

