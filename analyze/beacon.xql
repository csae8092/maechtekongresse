xquery version "3.1";
declare namespace functx = "http://www.functx.com";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";
import module namespace config="http://www.digital-archiv.at/ns/kongress/config" at "../modules/config.xqm";
import module namespace app="http://www.digital-archiv.at/ns/kongress/templates" at "../modules/app.xql";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace gefx = "http://gexf.net/data/hello-world.gexf";
declare namespace util = "http://exist-db.org/xquery/util";

declare option exist:serialize "method=text media-type=text";

let $root := "https://maechtekongresse.acdh.oeaw.ac.at/"

let $prefix := 
"#FORMAT: BEACON
#MESSAGE: VIAF authority file link list for eminent people mentioned in the treaties of Aachen (1818), Troppau (1820), Laibach (1821) und Verona (1822), generated from TEI data of the digital edition
#CONTACT: Stephan Kurz <stephan.kurz@oeaw.ac.at> &#10;"

let $nl := "&#10;"
let $items :=  
    for $x in doc($app:personIndex)//tei:person[starts-with(./tei:idno/text(), 'https://viaf.')]
        let $ownId := data($x/@xml:id)
        let $url := $root||'pages/hits.html?searchkey='||$ownId
        let $entry :=$x/tei:idno/text()||'|'||$url
    return $entry
let $beacon := string-join(($prefix, $items), '&#10;')
    return $beacon
