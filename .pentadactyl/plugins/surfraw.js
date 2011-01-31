
/* *******************************************************************************
 * the unix utility surfraw provides "... a fast ... command line interface to
 * a variety of popular WWW search engines and other artifacts of power";  it
 * also includes a text-based bookmark facility with keyword lookup.
 *
 * this is a pentadactyl plugin;  it provides a command-line interface to
 * surfraw from within firefox/pentadactyl
 *
 * Stephen Blott (smblott@gmail.com)
 */

/* *******************************************************************************
 * ome preliminaries ...
 */

"use strict";

XML.ignoreWhitespace = false;
XML.prettyPrinting   = false;

/* *******************************************************************************
 * pentadactyl/plugin documentation ...
 */

var INFO =
    <plugin name="surfraw" version="0.12"
            href="http://code.google.com/p/dactyl/issues/detail?id=320"
            summary="Open a URI suggested by surfraw."
            xmlns={NS}>
        <author email="smblott@gmail.com">Stephen Blott</author>
        <license href="http://opensource.org/licenses/mit-license.php">MIT</license>
        <project name="Pentadactyl" min-version="1.0"/>
        <p>
            The unix utility <o>surfraw</o> provides "... a fast ... command line interface to a
            variety of popular WWW search engines and other artifacts of
            power".  It also includes a text-based bookmark facility with keyword lookup.
        </p>
        <p>
            This plugin makes surfraw callable from the Firefox/Pentadactyl
            command line.
        </p>
        <item>
            <tags>:sr :surfraw</tags>
            <spec>:surfraw <a>surfraw-arguments</a> </spec>
            <description>
                <p>
                    Pass <a>surfraw-arguments</a> to <o>surfraw -print</o> and
                    open the resulting URI.  If surfraw fails to suggest a URI, then instead
                    just pass <a>surfraw-arguments</a> to the built-in <ex>:open</ex> command.
                </p>
            <example><ex>:surfraw wikipedia firefox</ex><k name="CR"/>
            </example>
            <p>
             Look up <ex>firefox</ex> on Wikipedia, <ex>wikipedia</ex> being
             one of standard surfraw elvi (of which there are many; try
             <o>surfraw -elvi</o> on the shell command line to see a list of
             those available on your
             system).
            </p>
            <example><ex>:surfraw surfraw-bookmark</ex><k name="CR"/>
            </example>
            <p>
             Open a surfraw bookmark with keyword <a>surfraw-bookmark</a>.
            </p>
            <example><ex>:surfraw some search terms</ex><k name="CR"/>
            </example>
            <p>
             In general, surfraw will not know what to do with <ex>some search
             terms</ex>, so they are passed to <ex>:open</ex> (which in turn
             will likely pass them on to your favourite search engine).
            </p>
            <example><ex>map o :surfraw</ex><k name="CR"/>
            </example>
            <p>
             Use <ex>:surfraw</ex> instead of <ex>:open</ex> (after all, it'll
                     just call <ex>:open</ex> itself if it can't figure out what to
                     do).  The disadvantage of this is that completion for <ex>:open</ex> is
             more extensive than it currently is for <ex>:surfraw</ex>.
            </p>
            </description>
        </item>
        <item>
            <tags>:tsr :tsurfraw</tags>
            <spec>:tsurfraw <a>surfraw-arguments</a> </spec>
            <description>
                <p>
                    As above, except that the URI is opened in a new tab (or
                    <a>surfraw-arguments</a> are passed to the built-in
                    <ex>:tabopen</ex> command).
                </p>
            </description>
        </item>
    </plugin>;

/* *******************************************************************************
 * messages ...
 */

var mess0 = "Cannot find surfraw on your PATH\n(consider installing it and then restarting this plugin)";
var mess1 = "Available Elvi (completion is not currently available for bookmarks):";
var mess2 = "Completion is not currently available on elvi arguments or other functions";

/* *******************************************************************************
 * check whether we do indeed have surfraw installed ...
 */

var surfraw_path = io.pathSearch("surfraw");
var null_command = function ( args ) surfraw_path || dactyl.echomsg(mess0);
null_command();

/* *******************************************************************************
 * elvi completion ...
 */

var title = [       "ELVI",              "DESCRIPTION" ];
var keys  = { text: "elvi", description: "desc"        };

 var  elvi  = io.system("surfraw -elvi").split("\n")
        .map
        (
            // for each line, generate an associative array:
            //   ["elvi"]: the name of the elvi
            //   ["desc"]: its description
            function(line)
            {
                 var  parse = line.split(/\s+--\s+/);
                return { elvi: parse[0], desc: parse[1] }
            }
        )
        .filter
        (
            // keep only real and useful elvi:
            //   1. if e["desc"] is undefined, then it's no an elvi
            //   2. skip the "Activate Browser" elvi (W), it's not useful here
            function(e) e["desc"] && e["elvi"] != 'W'
        );

var elvi_completer = 
    function ( context )
    {
        if ( ! context.cache.offset )
            context.cache.offset = context.offset;

        if ( context.offset != context.cache.offset )
        {
            context.message = mess2;
            return context;
        }
                
        context.message     = mess1;
        context.title       = title;
        context.keys        = keys;
        context.completions = elvi;
        return context;
    };

/* *******************************************************************************
 * the io.system() interface changed at some point in late 2010;  this plugin
 * (currently) works with both the old-style and the new-style io.system()
 * interface
 *
 * do we have an old-style or a new-style io.system() interface?
 */

 var  use_new_style_system = io.system("false").returnValue;

 var error_code = 
    use_new_style_system
        ?   // new style
            function ( result )
            {
                return result.returnValue;
            }
        :   // old style
            function ( output )
            {
                if ( /\nshell returned (\d+)$/.test(output) )
                    return RegExp.$1;
                else
                    return 0;
            };

 var the_uri = 
    use_new_style_system
        ?   // new style
            function ( result )
            {
                return result.toString();
            }
        :   // old style
            function ( output )
            {
                return output;
            };

/* *******************************************************************************
 * the main function
 */

 var surfraw =
    function ( where, args )
    {
        if ( isArray(args) )
            args = args.join(" ");

        var result = io.system("surfraw -print " + args);
        dactyl.open( error_code(result) == 0 ? the_uri(result) : args, { where: where } );
    };

/* *******************************************************************************
 * finally, register the actual new commands ...
 */

 var desc_cur = "Open a URI suggested by surfraw";
 var desc_new = desc_cur + " in a new tab";

 var register_surfraw_command =
    surfraw_path
    ?   // install the real command
        function ( command, description, tab )
            commands.addUserCommand
            (
                [ command ],                                      // command name
                description,                                      // description
                function (args) { return surfraw(tab, args); },   // the command's implementation
                { argCount: "+", completer: elvi_completer,  },   // extra stuff
                true                                              // replace current implementation
            )
    :   // install a dummy command
        function ( command, description, tab )
            commands.addUserCommand
            (
                [ command ],
                mess0,
                null_command,
                { argCount: "+"                          },
                true
            );

register_surfraw_command( "surfraw",  desc_cur, dactyl.CURRENT_TAB );
register_surfraw_command( "sr",       desc_cur, dactyl.CURRENT_TAB );
register_surfraw_command( "tsurfraw", desc_new, dactyl.NEW_TAB     );
register_surfraw_command( "tsr",      desc_new, dactyl.NEW_TAB     );

/* vim:se sts=4 sw=4 et: */

