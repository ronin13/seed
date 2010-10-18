let INFO =
<plugin name="feedSomeKeys" version="2.2.3"
        href="http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/feedSomeKeys_2.js"
        summary="Feed some defined key events into the Web content"
        xmlns="http://vimperator.org/namespaces/liberator">
    <author email="teramako@gmail.com">teramako</author>
    <license href="http://www.mozilla.org/MPL/MPL-1.1.html">MPL 1.1</license>
    <project name="Vimperator" minVersion="2.3"/>
    <p>
        keyイベントをWebコンテンツ側へ送る事を可能にするプラグイン。
        GmailやGreasemonkeyでキーを割り当てている場合に活躍するでしょう。
    </p>
    <item>
        <tags>:fmap :feedmap</tags>
        <spec>:f<oa>eed</oa>map <oa>-depath=<a>frameNumber</a></oa> <oa>-vkey</oa> <oa>-event=<a>eventName</a></oa> <oa>lhs<oa>,<oa>frameNumber</oa>rhs</oa></oa></spec>
        <description>
            <p>
                Feed to the Web contents <oa>lhs</oa>.
                If specified <oa>rhs</oa>, feed <oa>rhs</oa> key events when hit <oa>lhs</oa>.
            </p>
            <p>The following options are interpreted.</p>
            <dl>
                <dt>-v<oa>key</oa></dt>
                <dd>仮想キーコードでイベントを送る</dd>
                <dt>-e<oa>vent</oa></dt>
                <dd>
                    以下の<oa>eventName</oa>が設定可能
                    <ul>
                        <li>keypress (default)</li>
                        <li>keydown</li>
                        <li>keyup</li>
                    </ul>
                </dd>
            </dl>
        </description>
    </item>
    <item>
        <tags>:fmapc :feedmapclear</tags>
        <spec>:fmapc</spec>
        <spec>:feedmapclear</spec>
        <description>
            <p>clear fmap entries</p>
        </description>
    </item>
    <h3 tag="combine-fmap-with-autocmd">Combine fmap with autocmd</h3>
    <code><ex>
:autocmd LocationChange .* fmapc
:autocmd LocationChange 'example\.com' fmap a b c
    </ex></code>
    <h3 tag="fmap-examples">fmap examples</h3>
    <p>
        At first, you need to write following code
        <code>:autocmd LocationChange .* :fmapc</code>
    </p>
    <h4 tag="fmap-example-gmail">Gmail</h4>
    <code>
:autocmd LocationChange 'mail\.google\.com/mail' :fmap c / j k n p o u e x s r a # [ ] z ? gi gs gt gd ga gc
    </code>
    <h4 tag="fmap-example-ldr">Livedoor Reader</h4>
    <code>
:autocmd LocationChange 'reader\.livedoor\.com/reader' :fmap j k s a p o v c &lt;Space> &lt;S-Space> z b &lt; >
    </code>
    <h4 tag="fmap-example-googlereader">Google Reader</h4>
    <code>
:autocmd LocationChange 'www\.google\.co\.jp/reader' :fmap! -vkey j k n p m s t v A r S N P X O gh ga gs gt gu u / ?
    </code>
    <h4 tag="fmap-example-googlecalendar">Google Calendar</h4>
    <code>
:autocmd LocationChange 'www\.google\.com/calendar/' :fmap! -vkey -event keydown t a d w m x c e &lt;Del> / + q s ?
    </code>
</plugin>;

var origMaps = [];
var feedMaps = [];

function init(keys, useVkey){
    destroy();
    keys.forEach(function(key){
        var origKey, feedKey;
        if (key instanceof Array){
            [origKey, feedKey] = key;
        } else if (typeof(key) == 'string'){
            [origKey, feedKey] = [key,key];
        }
        replaceUserMap(origKey, feedKey, useVkey);
    });
}
function replaceUserMap(origKey, feedKey, useVkey, eventName){
    if (mappings.hasMap(modes.NORMAL, origKey)){
        var origMap = mappings.get(modes.NORMAL,origKey);
        if (origMap.description.indexOf(origKey+' -> ') != 0) {
            // origMapをそのままpushするとオブジェクト内の参照先を消されてしまう
            // 仕方なく複製を試みる
            var clone = new Map(origMap.modes.map(function(m) m),
                                origMap.names.map(function(n) n),
                                origMap.description,
                                origMap.action,
                                {
                                    flags:origMap.flags,
                                    rhs:origMap.rhs,
                                    noremap:origMap.noremap,
                                    count: origMap.cout,
                                    arg: origMap.arg,
                                    motion: origMap.motion
                                });
            origMaps.push(clone);
        }
    }
    var map = new Map([modes.NORMAL], [origKey], origKey + ' -> ' + feedKey,
        function(count){
            count = count > 1 ? count : 1;
            for (var i=0; i<count; i++){
                feedKeyIntoContent(feedKey, useVkey, eventName);
            }
        }, { flags:(Mappings.flags ? Mappings.flags.COUNT : null), rhs:feedKey, noremap:true, count:true });
    addUserMap(map);
    if (feedMaps.some(function(fmap){
        if (fmap.names[0] != origKey) return false;
        for (var key in fmap) fmap[key] = map[key];
        return true;
    })) return;
    feedMaps.push(map);
}
function destroy(){
    try{
        feedMaps.forEach(function(map){
            mappings.remove(map.modes[0],map.names[0]);
        });
    }catch(e){ liberator.log(map); }
    origMaps.forEach(function(map){
        addUserMap(map);
    });
    origMaps = [];
    feedMaps = [];
}
function addUserMap(map){
    mappings.addUserMap(map.modes, map.names, map.description, map.action, {
        flags:map.flags,noremap:map.noremap,rhs:map.rhs,count:map.count,arg:map.arg,motion:map.motion
    });
}
function parseKeys(keys){
    var matches = /^\d+(?=\D)/.exec(keys);
    if (matches){
        var num = parseInt(matches[0],10);
        if (!isNaN(num)) return [keys.substr(matches[0].length), num];
    }
    return [keys, 0];
}
function getDestinationElement(frameNum){
    var root = document.commandDispatcher.focusedWindow;
    if (frameNum > 0){
        var frames = [];
        (function(frame){// @see liberator.buffer.shiftFrameFocus
            if (frame.document.body.localName.toLowerCase() == 'body') {
                frames.push(frame);
            }
            for (var i=0; i<frame.frames.length; i++){
                arguments.callee(frame.frames[i]);
            }
        })(window.content);
        frames = frames.filter(function(frame){
            frame.focus();
            if (document.commandDispatcher.focusedWindow == frame) return frame;
        });
        if (frames[frameNum]) return frames[frameNum];
    }
    return root;
}
function feedKeyIntoContent(keys, useVkey, eventName){
    var frameNum = 0;
    [keys, frameNum] = parseKeys(keys);
    var destElem = getDestinationElement(frameNum);
    destElem.focus();
    try {
        modes.push(modes.PASS_THROUGH);
        events.fromString(keys)
              .forEach(function (event) {
            var evt = content.document.createEvent('KeyEvents');
            if (useVkey && event.charCode in events._code_key) {
                event.keyCode = events._key_code[event.dactylKeyname || String.fromCharCode(event.charCode)];
                event.charCode = 0;
            }

            evt.initKeyEvent(eventName, true, true, content,
                             event.ctrlKey, event.altKey, event.shiftKey, event.metaKey,
                             event.keyCode, event.charCode);
            (destElem.document.body || destElem.document.documentElement || destElem.document)
                .dispatchEvent(evt);
        });
    }
    finally {
        modes.pop();
    }
}

// --------------------------
// Command
// --------------------------
commands.addUserCommand(['feedmap','fmap'],'Feed Map a key sequence',
    function(args){
        if(!args.string){
            liberator.echo(template.table("feedmap list",feedMaps.map(function(map) [map.names[0], map.rhs])), true);
            return;
        }
        if (args.bang) destroy();
        var depth = args["-depth"] ? args["-depth"] : "";
        var useVkey = "-vkey" in args;
        var eventName = args["-event"] ? args["-event"] : "keypress";

        args.forEach(function(keypair){
            var [lhs, rhs] = keypair.split(",");
            if (!rhs) rhs = lhs;
            replaceUserMap(lhs, depth + rhs, useVkey, eventName);
        });
    },{
        bang: true,
        argCount: "*",
        options: [
            [["-depth","-d"], CommandOption.INT],
            [["-vkey","-v"], CommandOption.NOARG],
            [["-event", "-e"], CommandOption.STRING, null, [["keypress","-"],["keydown","-"],["keyup","-"]]]
        ]
    }
);
commands.addUserCommand(['feedmapclear','fmapc'],'Clear Feed Maps',destroy);
var converter = {
    get origMap() origMaps,
    get feedMap() feedMaps,
    setup: init,
    reset: destroy
};

// vim: fdm=marker sw=4 ts=4 et: