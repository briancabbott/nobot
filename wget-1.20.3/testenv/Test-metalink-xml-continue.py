#!/usr/bin/env python3

from sys import exit
from misc.metalinkv3_xml import Metalinkv3_XML

"""
    This is to test Metalink/XML --continue support in Wget.

    With --trust-server-names, trust the metalink:file names.

    Without --trust-server-names, don't trust the metalink:file names:
    use the basename of --input-metalink, and add a sequential number
    (e.g. .#1, .#2, etc.).

    Strip the directory from unsafe paths.
"""

############# File Definitions ###############################################
wrong_file = "Ouch!"

File1 = "Would you like some Tea?"
File1_lowPref = "Do not take this"

File2 = "This is gonna be good"
File2_lowPref = "Not this one too"

File3 = "A little more, please"
File3_lowPref = "That's just too much"

File4 = "Maybe a biscuit?"
File4_lowPref = "No, thanks"

File5 = "More Tea...?"
File5_lowPref = "I have to go..."

############# Metalink/XML ###################################################
Meta = Metalinkv3_XML()

# file_name: metalink:file "name" field
# save_name: metalink:file save name, if None the file is rejected
# content  : metalink:file content
#
# size:
#   True     auto-compute size
#   None     no <size></size>
#    any     use this size
#
# hash_sha256:
#   False    no <verification></verification>
#   True     auto-compute sha256
#   None     no <hash></hash>
#    any     use this hash
#
# srv_file   : metalink:url server file
# srv_content: metalink:url server file content, if None the file doesn't exist
# utype      : metalink:url type (http, ftp, etc.)
# location   : metalink:url location (default 'no location field')
# preference : metalink:url preference (default 999999)

XmlName = "test.metalink"

Meta.add_LocalFiles (
    [XmlName + ".#1", File1[0:14]], # File1 to continue from partial file
    [XmlName + ".#2", File2],       # File2 to keep, different from server
    [XmlName + ".#3", File3],       # File3 to keep, already fully retrieved
    [XmlName + ".#4", File4],       # File4 to keep, different from server
)

Meta.add_ExpectedFiles (
    [XmlName + ".#2", File2],       # File2 to keep, different from server
    [XmlName + ".#3", File3],       # File3 to keep, already fully retrieved
    [XmlName + ".#4", File4],       # File4 to keep, different from server
)

Meta.print_meta ()

Meta.xml (
    # Metalink/XML file name
    XmlName,
    # file_name, save_name, content, size, hash_sha256
    ["File1", XmlName + ".#1", File1, None, True,
     # srv_file, srv_content, utype, location, preference
     ["File1_lowPref", File1_lowPref, "http", None, 25],
     ["File1", File1, "http", None, 30]],
    ["File2", XmlName + ".#2", wrong_file, None, True,
     ["wrong_file", wrong_file, "http", None, 35],
     ["404", None, "http", None, 40],
     ["File2_lowPref", File2_lowPref, "http", None, 25],
     ["File2", File2, "http", None, 30]],
    ["File3", XmlName + ".#3", File3, None, True,
     ["File3_lowPref", File3_lowPref, "http", None, 25],
     ["File3", File3, "http", None, 30]],
    ["File4", XmlName + ".#4", File4_lowPref, None, True,
     ["wrong_file", wrong_file, "http", None, 35]],
    ["File5", XmlName + ".#5", File5, None, True,
     ["File5_lowPref", File5_lowPref, "http", None, 25],
     ["File5", File5, "http", None, 30]],
)

Meta.print_meta ()

err = Meta.http_test (
    "--continue " + \
    "--input-metalink " + XmlName, 1
)

exit (err)
