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
(/etc/webiopi/config)
```
[GPIO]
7 = OUT 0
8 = OUT 0
11 = OUT 0
```

Finally apply the changes in my fork:
https://github.com/euchkatzl/rpi_wordclock (Commit : 0846e15d1ce63b189e55d58257882202ac61cf84)

# iOS
After changing Settings in the App you should now be able to control your Wordclock.  
For Raspberry Ip Setting you have to insert your local raspberry ip with the WebIOPi port.(192.168.2.1:8000)

# Web
Move the content of the Web folder of this repository to your htdocs folder of the WebIOPi installation. 
You can set the htdocs folder also in the WebIOPi Config File ! (/etc/webiopi/config)
```
rsync -r {PATH_OF_WEB_DIR} {PATH_OF_HTDOCS_DIR}
```
 
NOTE : This only works if your left your virtual Pins on 7,8,11. Otherwise you have to modify /app/wordclock/index.html.  

After that you should be able to access the page via WebioPi : {IP_OF_RASPBERRY}:8000.  
For further intructions look at http://webiopi.trouch.com/INSTALL.html (Access WebIOPi over local network)  
Then click on "Control Wordclock".

