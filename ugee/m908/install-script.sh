# cd to current path
dirname=`dirname $0`
tmp="${dirname#?}"
if [ "${dirname%$tmp}" != "/" ]; then
	dirname=$PWD/$dirname
fi
echo $dirname
cd "$dirname"

# close driver if it running
AppDir=ugeeTablet

#Copy rule
sysRuleDir="/lib/udev/rules.d"
appRuleDir=$src/App$sysRuleDir
ruleName="ugee4-1.rules"

mkdir -p $out/lib/udev/rules.d

#echo "$appRuleDir/$ruleName"
#echo "$sysRuleDir/$ruleName"

if [ -f $appRuleDir/$ruleName ]; then
	str=`cp $appRuleDir/$ruleName $out$sysRuleDir/$ruleName`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's rules in package"
	exit
fi

#install app
sysAppDir="/usr/lib"
appAppDir=$src/App$sysAppDir/$AppDir

#echo $sysAppDir
#echo $appAppDir

if [ -d "$appAppDir" ]; then
	str=` mkdir -p $out$sysAppDir \
				&& cp -rf $appAppDir $out$sysAppDir`
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's files in package"
	exit
fi

# install shortcut
sysDesktopDir=/usr/share/applications
sysAppIconDir=/usr/share/icons/hicolor/256x256/apps
sysAutoStartDir=/etc/xdg/autostart

appDesktopDir=$src/App$sysDesktopDir
appAppIconDir=$src/App$sysAppIconDir
appAutoStartDir=$src/App$sysAutoStartDir

appDesktopName=ugeetablet.desktop
appIconName=ugeetablet.png


#echo $appDesktopDir/$appDesktopName
#echo $sysDesktopDir/$appDesktopName
#echo $appAppIconDir/$appIconName
#echo $sysAppIconDir/$appIconName

if [ -f $appDesktopDir/$appDesktopName ]; then
	str=` mkdir -p $out$sysDesktopDir \
	&& cp $appDesktopDir/$appDesktopName $out$sysDesktopDir/$appDesktopName`
	chmod +0555 $out$sysDesktopDir/$appDesktopName
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's shortcut in package"
	exit
fi

if [ -f $appAppIconDir/$appIconName ]; then
	str=`mkdir -p $out$sysAppIconDir \
			&& cp $appAppIconDir/$appIconName $out$sysAppIconDir/$appIconName`
	chmod +0555 $out$sysAppIconDir/$appIconName
	if [ "$str" !=  "" ]; then 
		echo "$str";
	fi
else
	echo "Cannot find driver's icon in package"
	exit
fi

#if [ -f $appAutoStartDir/$appDesktopName ]; then
#	str=`cp $appAutoStartDir/$appDesktopName $sysAutoStartDir/$appDesktopName`
#	chmod +0444 $sysAutoStartDir/$appDesktopName
#	if [ "$str" !=  "" ]; then 
#		echo "$str";
#	fi
#else
#	echo "Cannot find set auto start"
#fi

#Copy config files
chmod +0555 $out/usr/lib/ugeeTablet/ugeeTablet
chmod +0555 $out/usr/lib/ugeeTablet/ugeeTabletDriver.sh
chmod +0555 $out/usr/lib/ugeeTablet/ugeeTabletDriver
confPath="$out/usr/lib/ugeeTablet/conf"

chmod +0777 $confPath

if [ -f $confPath/Ugee_Tablet.xml ]; then
	chmod +0666 $confPath/Ugee_Tablet.xml
fi

if [ -f $confPath/language.ini ]; then
	chmod +0666 $confPath/language.ini
fi

if [ -f $confPath/name_config.ini ]; then
	chmod +0666 $confPath/name_config.ini
fi

if [ -f $out/usr/lib/ugeeTablet/resource.rcc ]; then
	chmod +0666 $out/usr/lib/ugeeTablet/resource.rcc
fi


# Symlink the actual binaries
mkdir -p $out/bin
ln -s $out/usr/lib/ugeeTablet/ugeeTablet $out/bin/
ln -s $out/usr/lib/ugeeTablet/ugeeTabletDriver.sh $out/bin/
ln -s $out/usr/lib/ugeeTablet/ugeeTabletDriver $out/bin/

echo "Installation successful!"
echo "If you are installing for the first time, please use it after restart."
