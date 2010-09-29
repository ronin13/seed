# Author: lavaramano <lavaramano AT gmail DOT com>
# Improved by: BaSh - <bash.lnx AT gmail DOT com>
# Ported to Weechat 0.3.0 by: Sharn - <sharntehnub AT gmail DOT com)
# This Plugin Calls the libnotify bindings via python when somebody says your nickname, sends you a query, etc.
# To make it work, you may need to download: python-notify (and libnotify - libgtk)
# Requires Weechat 0.3.0
# Released under GNU GPL v2
#
# 2010-02-20, Aron Griffis <agriffis@n01se.net>
#     version 0.0.5: Add nick_separator, don't call show_notification twice on
#     privmsg, fix spelling s/nofify/notify/, use nick as "summary" for privmsg
#     notification, fit in 80 columns, tweak vim modeline.
# 2010-01-24, David Rubin <davidrub+weechat@gmail.com>
#     version 0.0.4.2 Fixed issue with self notifications when used with out "smart_notification"
# 2010-01-19, Didier Roche <didrocks@ubuntu.com>
#     version 0.0.4.1: add private message sender name
# 2010-01-19, Didier Roche <didrocks@ubuntu.com>
#     version 0.0.4: add smart notification:
#     be notified only if you're not in the current channel/pv window (off by default)
# 2009-06-16, kba <unixprog@gmail.com.org>:
#     version 0.0.3: added config options for icon and urgency
# 2009-05-02, FlashCode <flashcode@flashtux.org>:
#     version 0.0.2.1: sync with last API changes

import weechat, pynotify, string
weechat.register("notify", "lavaramano", "0.0.5", "GPL", "notify: A real time notification system for weechat", "", "")

# script options
settings = {
    "show_hilights"      : "on",
    "show_priv_msg"      : "on",
    "nick_separator"     : ": ",
    "icon"               : "/usr/share/pixmaps/weechat.xpm",
    "path"               : "~/logs/me.log",
    "urgency"            : "normal",
    "smart_notification" : "off",
}

urgencies = {
    "low"      : pynotify.URGENCY_LOW,
    "critical" : pynotify.URGENCY_CRITICAL,
    "normal"   : pynotify.URGENCY_NORMAL,
}

# Init everything
for option, default_value in settings.items():
    if weechat.config_get_plugin(option) == "":
        weechat.config_set_plugin(option, default_value)

# Hook privmsg/hilights
weechat.hook_print("", "irc_privmsg", "", 1, "notify_show", "")

# Functions
def notify_show(data, bufferp, uber_empty, tagsn, isdisplayed,
        ishilight, prefix, message):
    """Sends highlighted message to be printed on notification"""
    try:
        if (weechat.config_get_plugin('smart_notification') == "on" and
                bufferp == weechat.current_buffer() and focussed()):
            pass

        elif (weechat.buffer_get_string(bufferp, "localvar_type") == "private" and
                weechat.config_get_plugin('show_priv_msg') == "on"):
            show_notification(prefix, message)

        elif (ishilight == "1" and 
                weechat.config_get_plugin('show_hilights') == "on"):
            buffer = (weechat.buffer_get_string(bufferp, "short_name") or
                    weechat.buffer_get_string(bufferp, "name"))
            show_notification(buffer, prefix +
                    weechat.config_get_plugin('nick_separator') + message)
    except ex:
        writetofile(weechat.config_get_plugin('path'),prefix,message,str(ex))

    return weechat.WEECHAT_RC_OK

def show_notification(chan,message):
    # beep.pl will handle this
    #print('\a')
    pynotify.init("wee-notifier")
    writetofile(weechat.config_get_plugin('path'),chan,message)
    wn = pynotify.Notification(chan, message, weechat.config_get_plugin('icon'))
    wn.set_urgency(urgencies[weechat.config_get_plugin('urgency')] or
            pynotify.URGENCY_NORMAL)
    wn.show()

def writetofile(path,chan,message,exception=""):
    import os
    import datetime
    fullpath = os.path.expanduser(path)
    file = open(fullpath,"a")
    file.writelines(str(datetime.datetime.now().ctime()))
    if exception:
        file.writelines("\n\n --------> "+exception+"<------------\n")
    file.writelines(" \n\nWeechat priv:==============>\n")
    file.writelines(str(chan+" : "+message+"\n"))
    file.writelines("<==============\n\n")
    file.close()



def focussed():
    import subprocess
    import re
    # tmux display-message -p and xdotool getactivewindow getwindowpid 
    x,y=subprocess.Popen("\
            [[ `xdotool getactivewindow getwindowpid` == `pidof urxvtd` ]];\
            echo -n $?",shell=True,stdout=subprocess.PIPE).communicate()
    if(x == 0):
        current,discard = subprocess.Popen("tmux display-message -p",shell=True\
            ,stdout=subprocess.PIPE).communicate()
        if re.match(".*weechat.*",current):
            return True 
    return False

# vim: autoindent expandtab smarttab shiftwidth=4
