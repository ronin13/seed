/*
Copyright (c) 2008, anekos.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
    3. The names of the authors may not be used to endorse or promote products
       derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.


###################################################################################
# http://sourceforge.jp/projects/opensource/wiki/licenses%2Fnew_BSD_license       #
# に参考になる日本語訳がありますが、有効なのは上記英文となります。                #
###################################################################################

*/

let PLUGIN_INFO =
<VimperatorPlugin>
  <name>Maine Coon</name>
  <name lang="ja">メインクーン</name>
  <description>Make the screen larger</description>
  <description lang="ja">なるべくでかい画面で使えるように</description>
  <version>2.2.3</version>
  <author mail="anekos@snca.net" homepage="http://d.hatena.ne.jp/nokturnalmortum/">anekos</author>
  <minVersion>2.0pre</minVersion>
  <maxVersion>2.0pre</maxVersion>
  <updateURL>http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/maine_coon.js</updateURL>
  <license>new BSD License (Please read the source code comments of this plugin)</license>
  <license lang="ja">修正BSDライセンス (ソースコードのコメントを参照してください)</license>
  <detail><![CDATA[
    == Requires ==
      _libly.js
    == Options ==
      mainecoon:
        Possible values
          c:
            Hide caption-bar
          a:
            Hide automatically command-line
          f:
            Fullscreeen
          C:
            Hide caption-bar
            If window is maximized, then window maximize after window is hid.
          m:
            Displays the message to command-line.
            (e.g. "Yanked http://..." "-- CARET --")
          l:
            Large mode (Hide status line)
        >||
          :set mainecoon=ac
        ||<
        The default value of this option is "am".
        === note ===
          The C and c options probably are supported on some OSs only.
    == Global Variables ==
      maine_coon_targets:
        Other elements IDs that you want to hide.
        let g:maine_coon_targets = "sidebar-2 sidebar-2-splitter"
      maine_coon_default:
        The default value of 'mainecoon' option.
        >||
          let g:maine_coon_default = "ac"
        ||<
    == Example ==
      === The mapping for large mode (l) ===
        >||
          :noremap <silent> s :set mainecoon!=l<CR>
        ||<
    == Thanks ==
      snaka72 (hidechrome part):
        http://vimperator.g.hatena.ne.jp/snaka72/20090106/1231262955
    == Maine Coon ==
      http://en.wikipedia.org/wiki/Maine_Coon
  ]]></detail>
  <detail lang="ja"><![CDATA[
    == Requires ==
      _libly.js
    == Options ==
      mainecoon:
        以下の文字の組み合わせを指定します。
          c:
            キャプションバーを隠す
          a:
            自動でコマンドラインを隠す
          f:
            フルスクリーン
          C:
            キャプションバーを隠す
            ウィンドウが最大化されているときは、隠したあとに最大化し直します
          m:
            コマンドラインへのメッセージを表示します。
            ("Yanked http://..." "-- CARET --" など)
          l:
            ラージモード (Hide status line)
        "c" と "f" の併用は意味がありません。
        >||
          :set mainecoon=ac
        ||<
        デフォルト値は "am"
        === 備考 ===
          C c オプションはいくつかの OS でのみ有効です。多分。
    == Global Variables ==
      maine_coon_targets:
        フルスクリーン時にの非表示にしたい要素のIDを空白区切りで指定します。
        >||
          let g:maine_coon_targets = "sidebar-2 sidebar-2-splitter"
        ||<
      maine_coon_default:
        オプションのデフォルト値を設定します。
        >||
          let g:maine_coon_default = "ac"
        ||<
    == Example ==
      === ラージモード(l) 用のマッピング ===
        >||
          :noremap <silent> s :set mainecoon!=l<CR>
        ||<
    == Thanks ==
      snaka72 (hidechrome part):
        http://vimperator.g.hatena.ne.jp/snaka72/20090106/1231262955
    == メインクーン ==
      http://ja.wikipedia.org/wiki/%E3%83%A1%E3%82%A4%E3%83%B3%E3%82%AF%E3%83%BC%E3%83%B3
  ]]></detail>
</VimperatorPlugin>;

let tagetIDs = (liberator.globalVariables.maine_coon_targets || '').split(/\s+/);

(function () {

  let U = libly.$U;
  let mainWindow = document.getElementById('main-window');
  let messageBox = document.getElementById('liberator-message');

  function around (obj, name, func) {
    let next = obj[name];
    obj[name] = function ()
      let (self = this, args = arguments)
        func.call(self,
                  function () next.apply(self, args),
                  args);
  }

  function s2b (s, d) !!((!/^(\d+|false)$/i.test(s)|parseInt(s)|!!d*2)&1<<!s);

  function hideTargets (hide) {
    tagetIDs.forEach(
      function (id)
        let (elem = document.getElementById(id))
          (elem && (elem.collapsed = hide))
    );
  }

  function getWindowInfo () {
      let box = mainWindow.boxObject;
      let x = screenX < 0 ? 0 : screenX;
      let y = screenY < 0 ? 0 : screenY;
      let width =  box.width;
      let height = box.height;
      let adjustHeight = box.screenY - y; // maybe caption height?
      let adjustWidth  = (box.screenX - x) * 2;
      return {
        x: x,
        y: y,
        width: width,
        height: height,
        adjustHeight: adjustHeight,
        adjustWidth: adjustWidth,
        state: window.windowState
      };
  }

  function delay (f, t){
   // setTimeout(f, t || 10);
   setTimeout(f,3000);
  }

  function refreshWindow () {
    // FIXME
    let old = window.outerWidth;
    window.outerWidth = old + 1;
    window.outerWidth = old;
  }

  function getHideChrome ()
    s2b(mainWindow.getAttribute('hidechrome'), false);

  function hideChrome (hide, maximize) {
    hide = !!hide;
    if (getHideChrome() === hide)
      return;
    if (hide)
      windowInfo = getWindowInfo();
    mainWindow.setAttribute('hidechrome', hide);
    delay(function () {
      window.outerWidth = windowInfo.width;
      window.outerHeight = windowInfo.height + windowInfo.adjustHeight;
    });
    if (maximize && windowInfo.state == window.STATE_MAXIMIZED)
      delay(function () window.maximize());
    refreshWindow();
  }

  function setFullscreen (full) {
    full = !!full;
    if (full === !!window.fullScreen)
      return;
    window.fullScreen = full;
    delay(function () {
      hideTargets(full);
      document.getElementById('status-bar').setAttribute('moz-collapsed',
                                                         options.get('mainecoon').has('l'));
      document.getElementById('navigator-toolbox').collapsed = full;
      if (!full)
        window.maximize();
    }, 1000); // FIXME
  }

  function nothing (value)
    (value === undefined);

  let echo = (function () {
    let time = 40;
    let remove;

    return function (message) {
      if (remove)
        remove();
      let doc = window.content.document;
      let style = highlight.get('StatusLine').value +
                  U.toStyleText({
                    position: 'fixed',
                    zIndex: 1000,
                    left: 0,
                    bottom: 0,
                    opacity: 1
                  });
      let elem = U.xmlToDom(<div style={style}>{message}</div>, doc);
      doc.body.appendChild(elem);
      let count = time;
      let handle = setInterval(function () {
        if (count <= 0) {
          if (remove)
            remove();
        } else {
          elem.style.opacity = count / time;
        }
        count--;
      }, 100);
      remove = function () {
        doc.body.removeChild(elem);
        clearInterval(handle);
        remove = null;
      };
    };
  })();

  let setAutoHideCommandLine = (function () {
    let hiddenNodes = [];

    return function (hide) {
      hide = !!hide;

      if (hide === autoHideCommandLine)
        return;

      autoHideCommandLine = hide;

      if (hide) {
        let cs = messageBox.parentNode.childNodes;
        hiddenNodes = [];
        for (let i = 0, l = cs.length, c; i < l; i++) {
          c = cs[i];
          if (c.id == 'liberator-commandline')
            continue;
          let style = window.getComputedStyle(c, '');
          hiddenNodes.push([c, c.collapsed, style.display]);
          if (c.id != 'liberator-message')
            c.style.display = 'none';
          c.collapsed = true;
        }
      } else {
        hiddenNodes.forEach(function ([c, v, d]) [c.collapsed, c.style.display] = [v, d]);
      }
    }
  })();


  let useEcho = false;
  let autoHideCommandLine = false;
  let windowInfo = {};

  {
    let a = liberator.globalVariables.maine_coon_auto_hide;
    let d = liberator.globalVariables.maine_coon_default;

    let def = !nothing(d) ? d :
              nothing(a)  ? 'am' :
              s2b(a)      ? 'am' :
              'm';

    autocommands.add(
      'VimperatorEnter',
      /.*/,
      function () delay(function () options.get('mainecoon').set(def), 1000)
    );
  }


  {
    let last;
    messageBox.watch('value', function (name, oldValue, newValue) {
      try {
        if (autoHideCommandLine
        && useEcho
        && /\S/.test(newValue)
        && messageBox.collapsed
        && last != newValue
        && newValue != 'Press ENTER or type command to continue') {
          echo(newValue);
        }
      } catch (e) {
        liberator.reportError(e);
      }
      last = newValue;
      return newValue;
    });
  }

  {
    // for multiline input
    let cmdline = document.getElementById("liberator-commandline");
    messageBox.inputField.__defineGetter__("scrollWidth", function() {
        return cmdline.clientWidth;
    });
  }

  around(commandline, 'open', function (next, args) {
    messageBox.collapsed = false;
    return next();
  });

  around(commandline, 'close', function (next, args) {
    if (autoHideCommandLine)
      messageBox.collapsed = true;
    return next();
  });

  options.add(
    ['mainecoon'],
    'Make big screen like a Maine Coon',
    'charlist',
    '',
    {
      setter: function (value) {
        function has (c)
          (value.indexOf(c) >= 0);

        document.getElementById('status-bar').setAttribute('moz-collapsed', has('l'));

        if (has('f')) {
          hideChrome(false);
          delay(function () setFullscreen(true));
        } else if (has('c')) {
          setFullscreen(false);
          delay(function () hideChrome(true));
        } else if (has('C')) {
          setFullscreen(false);
          delay(function () hideChrome(true, true));
        } else {
          hideChrome(false);
          delay(function () setFullscreen(false));
        }

        setAutoHideCommandLine(has('a'));
        useEcho = has('m');

        return value;
      },
      completer: function (context, args) {
        context.title = ['Value', 'Description'];
        context.completions = [
          ['c', 'Hide caption bar'],
          ['f', 'Fullscreen'],
          ['a', 'Hide automatically command-line'],
          ['C', 'Hide caption bar (maximize)'],
          ['m', 'Displays the message to command-line'],
          ['l', 'Large mode. Hide status-line'],
        ];
      },
      validater: function (value) /^[cfa]*$/.test(value)
    }
  );

  // XXX obsolete
  commands.addUserCommand(
    ['fullscreen', 'fs'],
    'Toggle fullscreen mode',
    function () setFullscreen(!window.fullScreen),
    {},
    true
  );

})();

// vim:sw=2 ts=2 et si fdm=marker:
