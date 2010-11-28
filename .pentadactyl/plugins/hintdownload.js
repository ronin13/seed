
hints.addMode('d',"Download the link", function(elem){
    var url = elem.getAttribute("href");

    if (!url || /^javascript:/.test(url))
         return;
    url = services.get("io").newURI(url, null, util.newURI(elem.ownerDocument.URL)).spec;

   dactyl.execute('silent !shellrun download '+ url + ' &');
   dactyl.execute('silent !~/bin/notify-send Pentdactyl Download ' + url + ' started');  

});

// vim:se ft=javascript sts=4 sw=4 et: 
