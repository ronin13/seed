/*
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <maglions.k at Gmail> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.       Kris Maglione
 * ---------------------------------------------------------------------------
 * <phk@FreeBSD.ORG> wrote this license.  As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.   Poul-Henning Kamp
 * ---------------------------------------------------------------------------
 *
 * Documentation is at the tail of this file.
 */
"use strict";

let browser = update({
    __proto__: Object.create(gBrowser),
}, {
    groupId: 0,
    addTab: function addTab(uri, params, charset, postData, ownerTab) {
        if (!isObject(params) || params instanceof Ci.nsIURI)
            params = { referrerURI: params, ownerTab: ownerTab };

        let currentTab = tabs.getTab();
        let tab = addTab.superapply(this, arguments);

        if (!params.ownerTab && (params.referrerURI || params.relatedToCurrent))
            params.ownerTab = currentTab;
        if (params.ownerTab)
            tab.dactylOwner = Cu.getWeakReference(params.ownerTab);

        tab.dactylGroup = browser.groupId++;
        if (params.ownerTab && (params.referrerURI || params.relatedToCurrent)) {
            if (params.ownerTab.dactylGroup == null)
                params.ownerTab.dactylGroup = tab.dactylGroup;
            tab.dactylGroup = params.ownerTab.dactylGroup;
        }

        // This is a hack to deal with session restore.
        if (uri === "about:blank" && params.skipAnimation && Object.keys(params).length == 1)
            return tab;

        let location = options["tabopen"][
            params.fromExternal ? "external" :
            params.referrerURI  ? "link"
                                : "orphan"];
        if (uri == null || location == null)
            return tab;

        let visible = tabs.visibleTabs;
        let index = visible.indexOf(currentTab);
        if (/left$/.test(location))
            ;
        else if (/right$/.test(location))
            index++;
        else if ("start" == location)
            index = 0;
        else if ("end" == location)
            index = visible.length;
        if ("groupleft" == location)
            while (index > 0 && visible[index].dactylGroup == currentTab.dactylGroup)
                index--;
        else if ("groupright" == location)
            while (index < visible.length && visible[index].dactylGroup == currentTab.dactylGroup)
                index++;
        tabs.move(tab, index);

        return tab;
    },
    removeTab: function removeTab(tab) {
        if (tab == tabs.getTab()) {
            let tabList = tabs.visibleTabs;
            let idx = tabList.indexOf(tab);
            for (let val in values(options["tabclose"])) {
                if (val == "opener" && tab.dactylOwner && tabs.allTabs.indexOf(tab.dactylOwner.get()) >= 0)
                    tabs.select(tab.dactylOwner.get());
                else if (val == "previous" && tabs.alternate)
                    tabs.select(tabs.alternate);
                else if (val == "left" && idx > 0)
                    tabs.select(idx - 1);
                else if (val == "right" && idx < tabList.length - 1)
                    tabs.select(idx + 1);
                else
                    continue;
                break;
            }
        }
        return removeTab.superapply(this, arguments);
    },
});
for (let [k, v] in iter(browser)) {
    Object.getPrototypeOf(browser)[k] = gBrowser[k];
    gBrowser[k] = v;
}
function onUnload() {
    for (let [k, v] in iter(Object.getPrototypeOf(browser)))
        gBrowser[k] = v;
}

options.add(["tabclose", "tc"],
    "Tab closure options, in order of precedence",
    "stringlist", "left,opener,previous,right",
    {
        completer: function (context) [
            ["left", "Select the tab to the left when closing"],
            ["opener", UTF8("Select the tab’s opener, if available")],
            ["previous", "Select the previously selected tab"],
            ["right", "Select the tab to the right when closing"]
        ]
    });
options.add(["tabopen", "to"],
    "Placement options for new tabs",
    "stringmap", "link:right,orphan:groupright,external:end",
    {
        completer: function (context, extra) {
            if (extra.value == null)
                return [
                    ["external", "Tabs opened from an external application"],
                    ["link", "Tabs opened by clicking links and the like"],
                    ["orphan", "Tabs opened by any other means"]
                ].filter(function (e) !set.has(extra.values, e[0]));
            return [
                ["end", "Open new tabs at the end of the tab bar"],
                ["groupleft", "Open tabs to the left of the current group"],
                ["groupright", "Open tabs to the right of the current group"],
                ["left", "Open new tabs to the left of the current tab"],
                ["right", "Open new tabs to the right of the current tab"],
                ["start", "Open new tabs at the start of the tab bar"]
            ]
        },
        // Fixme: validateCompleter needs to handle stringmaps
        validator: function (newVals) {
            let keys = set(this.completer(null, {}).map(function ([k, v]) k));
            let vals = set(this.completer(null, { value: "" }).map(function ([k, v]) k));
            return Object.keys(newVals).every(function (k) set.has(keys, k)) &&
                   array(values(newVals)).every(function (k) set.has(vals, k));
        }
    });

XML.ignoreWhitespace = false;
XML.prettyPrinting   = false;
var INFO =
<plugin name="tab-options" version="0.2"
        href="http://dactyl.sf.net/pentadactyl/plugins#tab-options"
        summary="Tab options"
        xmlns={NS}>
    <author email="maglione.k@gmail.com">Kris Maglione</author>
    <license href="http://people.freebsd.org/~phk/">BEER-WARE</license>
    <project name="Pentadactyl" minVersion="1.0"/>
    <p>
        Adds extended tab options, including relative placement of new
        tabs and more sensible focus changes after tab closure.
    </p>
    <item>
        <tags>'tc' 'tabclose'</tags>
        <spec>'tabclose' 'tc'</spec>
        <type>stringlist</type> <default>{options.get("tabclose").defaultValue}</default>
        <description>
            <p>
                Tab closure options, in order of precedence. The
                first item for which a valid tab exists is used.
            </p>
            <dl>
            { template.map(options.get("tabclose").completer(), function ([k, v])
                <><dt>{k}</dt> <dd>{v}</dd></>) }
            </dl>
        </description>
    </item>
    <item>
        <tags>'to' 'tabopen'</tags>
        <spec>'tabopen' 'to'</spec>
        <type>stringmap</type> <default>{options.get("tabopen").defaultValue}</default>
        <description>
            <p>
                New tab placement options. The keys in the <t>stringmap</t>
                refer to the ways the tab was opened, while the values define
                where such tabs are placed. The following keys are applicable:
            </p>
            <dl>
            { template.map(options.get("tabopen").completer(null, {}), function ([k, v])
                <><dt>{k}</dt> <dd>{v}</dd></>) }
            </dl>
            <p>As are the following values:</p>
            <dl>
            { template.map(options.get("tabopen").completer(null, { value: "" }), function ([k, v])
                <><dt>{k}</dt> <dd>{v}</dd></>) }
            </dl>
        </description>
    </item>
</plugin>;

/* vim:se sts=4 sw=4 et: */
