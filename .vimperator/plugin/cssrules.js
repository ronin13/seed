/*
 * cssrules.js
 *
 *  Vimperator plugin to manipulate CSS style sheets & rules.
 *
 *  @author Konstantin Stepanov <milezv@yandex.ru>
 *  @version 0.1
 *
 *    Copyright 2008 Konstantin Stepanov <milezv@yandex.ru>
 *    Compatible with Vimperator 1.2pre or higher.  Requires Firefox 3.
 */

/*****************************************************************************

USAGE

    :cssrule body=color: red !important; background-color: navy
		change CSS style of body, setting color and background color,
		if CSS rule for body doesn't exist throw an error

    :2cssrule td#cell p.info -= border; padding
		remove border & padding CSS attributes from definition
		with selector "td#cell p.info" on 2nd stylesheet

	:cssrule! #header=white-space: both
		change CSS rule for "#header" selector, if the rule doesn't
		exist, create it

	:5cssrule p a
		show CSS rule with "p a" selector on 5th stylesheet

	:cssrules
		display all CSS rule, use "quick" rendering (only basic coloring
		will be applied)

	:2cssrules! td {.*border: black
		display all CSS rules matching given regexp on 2nd stylesheet,
		use "slow" rendering (styles will be shown in full color)

	:1rmcssrule body.grid
		remove CSS rule with "body.grid" selector from 1st stylesheet

	:cssheets domain.example.net
		show list of style sheets for the page with "domain.example.net"
		in URL

	:cssdump ~/styles.css
		dump all stylesheets on a page into local file

	:set dcss=1
		disable only the first stylesheet

	:set dcss+=2,3
		disable 2nd and 3rd stylesheets in append to already disabled ones

	:set dcss-=1
		reenable first stylesheet

	:set dcss=all
		disable all stylesheets for the page

	:set dcss=
		enable all stylesheets for the page


COMMANDS

:cssrule
:css

    Change/create CSS rule definition. Works like :set for CSS rules.

    Syntax:
        :[count]cssrule[!] selector=attr1: value1[; attr2: value2 [...]]
		:[count]cssrule selector-=attr1[; attr2 [...]]
		:[count]cssrule selector

    Notes:
		The simpliest form of :cssrule sets given CSS attributes for first
		met rule with given selector. Attribute-value pairs are seprated
		by "; " symbols (note space after semicolon).
		You can use "!important" part after value (before "; " separator)
		to make set CSS attribute's priority.

		If rule doesn't exist the commands return error. To create new
		rule use :cssrule! form. The rule by default it created in 1st
		stylesheet met on page. To make :cssrule create rule in given stylesheet,
		use count. New rules are appended to the end of stylesheet.

		If "-=" operator used command takes "; "-separated list of attribute
		names and removes them from rule definition.
		If only selector is given, :cssrule shows definition of a rule with
		this selector.

		Command looks for the rule in all stylesheets attached to the page
		in order of appearance on page and operates on the first rule
		with given selector (see :cssheets command for a list of all rules).
		You can use count to designate stylesheet to look rule for.

		This command have autocompletion which completes argument with
		all available selectors of all CSS rules on page.

:rmcssrule
:rmcss

	Remove CSS rule definition from stylesheet.

	Syntax:
		:[count]rmcssrule selector

	Notes:
		Use this command to delete whole rule with given selector.
		Without count it looks for rule in all page's stylesheets
		in the order of appearance.

		You can use count to make the command operate on given
		stylesheet only.

		This command have autocompletion which completes argument with
		all available selectors of all CSS rules on page.

:cssrules

	Display list of CSS rules for current page.

	Syntax:
		:[count]cssrules[!] [filter]

	Notes:
		This commands allows fast search of a rule. Filter is a regular
		expression which matches against every single rule definition
		(CSS rule for the comparison is used in its full form with selector
		and curly brackets around attribute list), and if rule matches filter,
		it will be displayed.

		Command makes lookup in all stylesheets on page (in order of appearance).
		You can use count to set stylesheet to look for rules.

		RegExp-based renderer of rules, which translates them into form
		convinient for human's perception (i.e. indention and syntax coloring)
		have to modes: quick (only selectors are highlighted in bold and
		attributes are indented) and slow (attribute names & values are highlighted
		in different colors). Quick method is about twice as fast as slow one,
		so :cssrules uses quick rendering method to show rule definitions.

		If you have small set of rules, so speed is not concern for you, and you
		want candier look'n'feel of rules, you can use :cssrules! form to make it
		use slow rendering mode and see CSS rules with colorized syntax.

		All color definitions in form of "rgb(...)" are always appended with color
		patches so you can see color definitions in place: I tested this regexp
		and found only small difference in performance with and without this
		conversion.

		:cssrule always use slow rendering mode for rule displaying as it shows
		only one rule definition at a time, while :cssrules in its natural
		form shows full list of *all* rule definitions for current page,
		which can be slow to build, so I decided to use quick redering mode
		for it by default.

:cssheets

	Display full list of stylesheets for current page.

	Syntax:
		:cssheets [filter]

	Notes:
		Use this command to get full list of stylesheets used on current page.
		You can use filter to show only stylesheets with given string
		in their URL (so use ":cssheets example.net" to show only stylesheets
		from example.net and its subdomains).

		Filtering is done based on simple string matching (if filter string is
		contained in stylesheet's URL), not regular expressions.

		Disabled stylesheets (see 'disabledcssheets' option below) are displayed
		striked-through. Stylesheets embedded in document, not via @import rules
		or <link> tag (and as this doesn't have separate URL) are named
		"Embdedded Styles". All rules are numbered, and you can use these
		numbers as a count for almost all commands included in the plugin
		to designate stylehseet to work with (see separate commands description
		to see what effect count will bring to it, although it usualy just
		makes command work with this given stylesheet and not with all stylesheets
		on page).

		All commands from this plugin enumerate stylesheets in order of appearance
		in a list, displayed by this command.


:cssdump
:cssd

	Save stylesheets into local file.

	Syntax:
		:[count]cssdump[!] filename

	Notes:
		This command saves (dumps) all rules from all stylesheets used for current
		page into given file. If count is used, it dumps only rules from only one
		given stylesheet.

		If file exists, it is not overwritten and error is displayed. Use :cssdump!
		form to override this behavior and overwrite existing file.

		All rules are correctly indented, every stylesheet's is content is separated
		with comment line in format "*** <stylesheet url> ***" from other rules.

		Embedded stylesheets are given with "Embedded Styles" name instead of URL.

		This command have autocompletion which completes argument with file names
		available on user's file system.

OPTIONS

'disabledcssheets'
'dcss'

	Set disabled stylesheets for a page.

	Syntax:
		:set dcss
		:set dcss[+|-]=<stylesheets numbers list>
		:set dcss=all

	Notes:
		Use this option to disable/enable stylesheets for current page.
		The value of the option is list of numbers of stylesheets
		(see :cssheets command to get numbers of stylesheets for given page).

		This option is "local": it rebuilds its value every time it is queried,
		so it always have actual list of disabled stylesheets, even if stylesheets
		were enabled/disabled with any other tool, e.g. Web Developer extension.

		You can use this option just like any other option of stringlist type:
		adding a number to the option disables stylesheets, removing number -
		enables it.

		There's special value "all" which can be the only value of the option,
		so you can only write :set dcss=all, not dcss+=all or dcss-=all.
		If you set disabledcssheets to "all", it is automatically filled with
		a list of all available stylesheets on the page, effectively disabling
		all CSS rules on page (except for embedded in HTML via "style" HTML attribute
		in tags, of cause).

		You can set it to empty value to enable all stylesheets at once.


KNOWN ISSUES

		* Regexp with parses argument for :cssrule is incomplete, so some complex
		  selectors with something like [attr^=value] are not recognized.

		* Completer of :cssrule command doesn't make out selector part from
		  CSS attributes part.

TO DO

		* Rewrite argument parser of :cssrule to make it recognize complex CSS
		  selectors.

		* Make :cssrule completer more clever, so it can complete not only CSS
		  selectors, but attributes (and maybe values) as well.

		* Implement :cssload command to load stylesheets from local files.

		* Make :cssrule behavior closer to :set, so "=" operator will completely
		  replace whole rule definition (not it only changes attributes
		  mentioned in it) and "+=" will modify only given attributes
		  (current default behavior for "=" operator).

		* As order of attributes inside of rule definitions is not important
		  (internally it all integrated in short form, so later defined
		  CSS attributes rewrites already defined ones for any given single
		  rule), but order of rule definitions matter (as it defines rule precedence
		  when applying them to HTML), make some way to move rule definitions
		  inside stylesheets and (maybe) between stylesheets.
		  Currently we can only append rule to given stylesheet (first by default).

*****************************************************************************/

liberator.plugins.cssRules = function () {

	function getStyleSheets() {
		return liberator.tabs.getTab().linkedBrowser.contentDocument.styleSheets;
	}

	liberator.commands.addUserCommand(
		["css[rule]"],
		"Sets CSS rule for current page",
		function (args, special, count) {
			//                             1                         2   3           4 
			var matches = args.match(/^\s*?([-a-zA-Z0-9_#. +>:@,]+?)(\s*([-+^])?=\s*(.*))?\s*$/);
			var ruleName = matches[1];
			var setValue = !!matches[2];
			var operator = matches[3];
			var ruleValue = matches[4];
			if (count > 0) count = count - 1; else count = -1;

			var rule = liberator.plugins.cssRules.getRule(ruleName, count);
			if (!rule) {
				if (special) {
					rule = liberator.plugins.cssRules.addRule(ruleName, count, -1);
					if (!rule) {
						liberator.echoerr("Failed to add CSS rule '" + ruleName + "'");
						return;
					}
				} else {
					liberator.echoerr("CSS rule '" + ruleName + "' was not found (add ! to create one)");
					return;
				}
			}

			if (!setValue) {
            	liberator.commandline.echo(liberator.plugins.cssRules.HTMLRule(rule, false), liberator.commandline.HL_NORMAL, liberator.commandline.FORCE_MULTILINE);
			} else {
				liberator.plugins.cssRules.setRule(rule, ruleValue, operator == "-");
			}
		}, {
			completer: function (filter, special, count) {
				return [ 0, liberator.plugins.cssRules.listRules(filter, count > 0? count - 1: -1) ];
			}
		}, true
	);

	liberator.commands.addUserCommand(
		["rmcss[rule]"],
		"Remove CSS rule for current page",
		function (args, special, count) {
			var args = args.replace(/^\s*/, "").replace(/\s*$/, "");
			if (args.match(/[^:\[\]"'^*~|= #.,a-zA-Z0-9_>+-]/)) {
				liberator.echoerr("Not a CSS rule name: '" + args + "'");
				return;
			}

			if (count > 0) count = count - 1; else count = -1;
			var rule = liberator.plugins.cssRules.getRule(args, count);

			if (!rule) {
				liberator.echoerr("CSS rule '" + args + "' was not found");
				return;
			}

			liberator.plugins.cssRules.rmRule(rule);
		}, {
			completer: function (filter, special, count) {
				return [ 0, liberator.plugins.cssRules.listRules(filter, count > 0? count - 1: -1) ];
			}
		}, true
	);

	liberator.commands.addUserCommand(
		["cssrules"],
		"Lists all CSS rules for current page",
		function (args, special, count) {

			var ss = getStyleSheets();
            var list = ":" + (liberator.util.escapeHTML(liberator.commandline.getCommand()) || ":cssrules") + "<br/>" +
                       "<table><tr align=\"left\" class=\"hl-Title\"><th colspan=\"2\">--- CSS rules ---</th></tr>";

			var from = 0;
			var len = ss.length;
			var filter = /./;

			if (count > 0) {
				from = count - 1;
				len = count;
			}

			if (args) {
				filter = new RegExp(args);
			}

			for (var i = from; i < len; i++) {
				var href = ss[i].href;
				var disabled = ss[i].disabled? " style=\"text-decoration: line-through\" ": "";

				if (href)
					href = "<a href=\"#\" class=\"hl-URL\"" + disabled + ">" + liberator.util.escapeHTML(href) + "</a>";
				else
					href = "<span class=\"hl-InfoMsg\"" + disabled + ">Embedded Styles</span>";

				var rules = "";
				for (var j = 0, lenj = ss[i].cssRules.length; j < lenj; j++) {
					if (ss[i].cssRules[j].cssText.match(filter)) {
						rules += liberator.plugins.cssRules.HTMLRule(ss[i].cssRules[j], !special) + "<br/><br/>";
					}
				}
				if (rules) {
					list += "<tr align=\"left\"><th>" + (i + 1) + ":</th><th>" + href + " <span style=\"color: #999999\">(" + ss[i].cssRules.length + " rule" + (ss[i].cssRules.length == 1? "": "s") + ")</span></th></tr>";
					list += "<tr><td> </td><td>" + rules + "</td></tr>";
				}
			}
			list += "</table>";

            liberator.commandline.echo(list, liberator.commandline.HL_NORMAL, liberator.commandline.FORCE_MULTILINE);

		}, {}, true
	);

	liberator.commands.addUserCommand(
		["cssheets"],
		"Lists all CSS stylesheets for current page",
		function (args, special, count) {

			var ss = getStyleSheets();
            var list = ":" + (liberator.util.escapeHTML(liberator.commandline.getCommand()) || ":cssrules") + "<br/>" +
                       "<table><tr align=\"left\" class=\"hl-Title\"><th colspan=\"2\">--- CSS stylesheets ---</th></tr>";

			var filter = /./;
			if (args) {
				filter = new RegExp(args);
			}

			for (var i = 0; i < ss.length; i++) {
				var href = ss[i].href;
				var disabled = ss[i].disabled? " style=\"text-decoration: line-through\" ": "";
				var displayHref = href || "Embedded Styles";

				if (displayHref.match(filter)) {
					if (href)
						href = "<a href=\"#\" class=\"hl-URL\"" + disabled + ">" + liberator.util.escapeHTML(href) + "</a>";
					else
						href = "<span class=\"hl-InfoMsg\"" + disabled + ">Embedded Styles</span>";

					list += "<tr align=\"left\"><td>" + (i + 1) + ":</td><td>" + href + " <span style=\"color: #999999\">(" + ss[i].cssRules.length + " rule" + (ss[i].cssRules.length == 1? "": "s") + ")</span></th></tr>";
				}
			}
			list += "</table>";

            liberator.commandline.echo(list, liberator.commandline.HL_NORMAL, liberator.commandline.FORCE_MULTILINE);

		}, {}, true
	);

	liberator.commands.addUserCommand(
		["cssd[ump]"],
		"Dump CSS stylesheets into local file",
		function (args, special, count) {

			var fileName = args.arguments[0];
			var file = liberator.io.getFile(fileName);
			if (file.exists() && !special) {
                liberator.echoerr("E189: \"" + filename + "\" exists (add ! to override)");
                return;
			}

			var ss = getStyleSheets();
			var text = "";

			var from = 0;
			var len = ss.length;

			if (count > 0) {
				from = count - 1;
				len = count;
			}

			var list = "";
			for (var i = from; i < len; i++) {
				var href = ss[i].href || "Embedded Styles";

				var rules = "";
				for (var j = 0, lenj = ss[i].cssRules.length; j < lenj; j++) {
					rules += liberator.plugins.cssRules.textRule(ss[i].cssRules[j]) + "\n\n";
				}
				if (rules) {
					list += "/*** " + href + " ***/\n";
					list += rules;
				}
			}

            liberator.io.writeFile(file, list);
		},
		{
			argCount: 1,
			completer: function (filter) { return liberator.completions.file(filter, false); }
		}, true
	);

	liberator.options.add(
		["disabledcssheets", "dcss"],
		"Set disabled CSS stylesheets",
		"stringlist",
		"",
		{
			validator: function (value) {
				if (value == "" || value == "all") return true;

				var arr = value.split(",");
				var sslen = getStyleSheets().length;
				for (var i = 0; i < arr.length; i++) {
					var num = parseInt(arr[i]);
					if (!num || num < 1 || num > sslen) return false;
				}

				return true;
			},
			setter: function (value) {
				var arr = value + ",";
				var ss = getStyleSheets();

				for (var i = 1; i <= ss.length; i++)
					ss[i-1].disabled = value == "all" || arr.indexOf(i + ",") >= 0;

			},
			getter: function () {
				var ss = getStyleSheets();
				var value = "";

				for (var i = 1; i <= ss.length; i++)
					if (ss[i-1].disabled) value += "," + i;

				value = value.substring(1);
				this.value = value;
				return value;
			},
			completer: function (filter) {
				var ss = getStyleSheets();
				var cpt = [["all", "All StyleSheets"]];
				for (var i = 0; i < ss.length; i++) {
					cpt.push([(i + 1), ss[i].href || "Embedded Style"]);
				}
				return cpt;
			}
		}
	);

	return {

	getRule: function (filter, num) {
		filter = filter.toLowerCase();
		var ss = getStyleSheets();
		var from = 0;
		var len = ss.length;

		if (num >= 0) {
			from = num;
			len = num + 1;
		}

		for (var j = from; j < len; j++) {
			for (var i = 0, leni = ss[j].cssRules.length; i < leni; i++) {
				if (ss[j].cssRules[i].selectorText.toLowerCase() == filter) {
					return ss[j].cssRules[i];
				}
			}
		}

		return null;
	},

	setRule: function (rule, ruleValue, remove) {
		var rulesList = ruleValue.split("; ");
		if (remove) {
			for (var i = 0; i < rulesList.length; i++) {
				var data = rulesList[i].match(/^\s*([a-zA-Z-]+)\s*$/);
				if (data) {
					rule.style.removeProperty(data[1]);
				}
			}
		} else {
			for (var i = 0; i < rulesList.length; i++) {
				var data = rulesList[i].match(/^\s*([a-zA-Z-]+)\s*:\s*(.*?)\s*;?$/);
				if (data) {
					var important = data[2].match(/!\s*important$/);
					if (important) data[2] = data[2].substring(0, data[2].length - important[0].length);
					rule.style.setProperty(data[1], data[2], important? "important": "");
				}
			}
		}
	},

	addRule: function (name, num, place) {
		var ss = getStyleSheets();
		var newPlace;

		if (num >= ss.length) return null;
		if (num < 0) num = 0;

		if (place < 0) place = ss[num].cssRules.length;

		try {
			var newPlace = ss[num].insertRule(name + "{}", place);
		}
		catch (e) {
			return null;
		}

		return ss[num].cssRules[newPlace];
	},

	listRules: function (filter, num) {
		filter = filter.toLowerCase();
		var ss = getStyleSheets();
		var from = 0;
		var len = ss.length;

		var allRules = [];

		if (num >= 0) {
			from = num;
			len = num + 1;
		}

		for (var j = from; j < len; j++) {
			for (var i = 0, leni = ss[j].cssRules.length; i < leni; i++) {
				if (!filter || (filter && ss[j].cssRules[i].selectorText.toLowerCase().indexOf(filter) >= 0)) {
					allRules.push([ss[j].cssRules[i].selectorText, ss[j].cssRules[i].style.cssText]);
				}
			}
		}

		return allRules;
	},

	rmRule: function (rule) {
		var ss = rule.parentStyleSheet;
		var num = -1;
		for (var i = 0; i < ss.cssRules.length; i++) {
			if (ss.cssRules[i] == rule) {
				num = i;
				break;
			}
		}
		if (num < 0) return false;

		try {
			ss.deleteRule(num);
		}
		catch (e) {
			return false;
		}

		return true;
	},

	HTMLRule: function (rule, quick) {
		var html = rule.style.cssText;

		if (quick) {
			html = html.replace(/; /g, ";<br/>").replace(/(rgb\(\d{1,3}, \d{1,3}, \d{1,3}\))/g, "$1<span style=\"background-color: $1; border: 1px solid black\">&nbsp;&nbsp;</span>");
		} else {
			html = html.replace(/! important;/g, "<span style=\"color: red\">! important</span>;").replace(/(^|; )([a-z-]+): /g, "</span>;<br/><span style=\"color: green\">$2</span>: <span style=\"color: blue\">");
			html = html.substring(13, html.length - 1).replace(/(rgb\(\d{1,3}, \d{1,3}, \d{1,3}\))/g, "$1<span style=\"background-color: $1; border: 1px solid black\">&nbsp;&nbsp;</span>") + "</span>;";
		}

		return "<span style=\"font-weight: bold\">" + rule.selectorText + "</span> {<div style=\"margin-left: 2em;\">" + html + "</div>}";
	},

	textRule: function (rule) {
		var text = rule.style.cssText.replace(/; /g, ";\n\t");
		return rule.selectorText + " {\n\t" + text + "\n}";
	}
	};

} ();

