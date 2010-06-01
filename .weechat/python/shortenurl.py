# -*- coding: utf-8 -*-
#
# Copyright (c) 2010 by John Anderson <sontek@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sys
import re
import weechat
from urllib import urlencode
from urllib2 import urlopen

SCRIPT_NAME    = "shortenurl"
SCRIPT_AUTHOR  = "John Anderson <sontek@gmail.com>"
SCRIPT_VERSION = "0.1"
SCRIPT_LICENSE = "GPL3"
SCRIPT_DESC    = "Shorten long incoming and outgoing URLs"

ISGD = 'http://is.gd/api.php?%s'
TINYURL = 'http://tinyurl.com/api-create.php?%s'

# script options
# shortener options:
#  - isgd
#  - tinyurl

settings = {
    "color": "red",
    "urllength": "30",
    "shortener": "isgd",
}

octet = r'(?:2(?:[0-4]\d|5[0-5])|1\d\d|\d{1,2})'
ipAddr = r'%s(?:\.%s){3}' % (octet, octet)
# Base domain regex off RFC 1034 and 1738
label = r'[0-9a-z][-0-9a-z]*[0-9a-z]?'
domain = r'%s(?:\.%s)*\.[a-z][-0-9a-z]*[a-z]?' % (label, label)
urlRe = re.compile(r'(\w+://(?:%s|%s)(?::\d+)?(?:/[^\])>\s]*)?)' % (domain, ipAddr), re.I)


if weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE,
                    SCRIPT_DESC, "", ""):

    for option, default_value in settings.iteritems():
        if weechat.config_get_plugin(option) == "":
            weechat.config_set_plugin(option, default_value)

    # Hooks we want to hook
    hook_command_run = {
        "input" : ("/input return",  "command_input_callback"),
    }

    # Hook all hooks !
    for hook, value in hook_command_run.iteritems():
        weechat.hook_command_run(value[0], value[1], "")

    weechat.hook_print("", "", "", 1, "hook_print_callback", "")


def command_input_callback(data, buffer, command):
    """ Function called when a command "/input xxxx" is run """
    if command == '/input return':
        input = weechat.buffer_get_string(buffer, 'input')
        input = match_url(input, buffer, True)

        weechat.buffer_set(buffer, 'input', input)
    return weechat.WEECHAT_RC_OK


def hook_print_callback(data, buffer, date, tags, displayed, highlight, prefix, message):
    if 'notify_message' in tags.split(','):
        return match_url(message, buffer, False)

    return weechat.WEECHAT_RC_OK

def match_url(message, buffer, from_self):
    new_message = message
    for url in urlRe.findall(message):
        if len(url) > int(weechat.config_get_plugin('urllength')):
            if from_self:
                short_url = tiny_url(url, None)
                new_message = new_message.replace(url, short_url)
            else:
                tiny_url(url, buffer)

    if from_self:
        return new_message
    else:
        return weechat.WEECHAT_RC_OK 

def tiny_url(url, buffer):
    shortener = weechat.config_get_plugin('shortener')
    if shortener == 'isgd':
        url = ISGD % urlencode({'longurl':url})
    if shortener == 'tinyurl':
        url = TINYURL % urlencode({'url':url})
    try:
        if buffer:
            shortenurl_hook_process = weechat.hook_process(
                        "python -c \"import urllib2; print urllib2.urlopen('" + url + "').read()\"",
                        10 * 1000, "process_complete", buffer)
        else:
            return urlopen(url).read()
    except:
        return  url

def process_complete(data, command, rc, stdout, stderr):
    url = stdout.strip()
    if url:
        color = weechat.color(weechat.config_get_plugin("color"))
        weechat.prnt(data, '%s[%s]' % (color, url))

    return weechat.WEECHAT_RC_OK

