#!/usr/bin/env python3

import sys
import os.path
import xml.etree.ElementTree as ET

# userplaces_path = '/home/pkleczek/.local/share/user-places.xbel'

# userplaces_path = '/home/pkleczek/temp/user-places.xbel'

username = sys.argv[1]

userplaces_filename = 'user-places.xbel'
userplaces_in_path = os.path.join(sys.argv[2], userplaces_filename)
userplaces_out_path = os.path.join(sys.argv[3], userplaces_filename)
print('Read file:', userplaces_in_path)

ET.register_namespace('mime', "http://www.freedesktop.org/standards/shared-mime-info")
ET.register_namespace('bookmark', "http://www.freedesktop.org/standards/desktop-bookmarks")
ET.register_namespace('kdepriv', "http://www.kde.org/kdepriv")

tree = ET.parse(userplaces_in_path)
root = tree.getroot()

trash_node = None
trash_node_index = None
for child_inx, node in enumerate(root):
    if node.tag == 'bookmark' and node.attrib['href'] == "trash:/":
        trash_node = node
        trash_node_index = child_inx


def prepare_custom_place_node(path: str, title: str, id_: str) -> str:
    return ET.XML("""<xbel xmlns:mime="http://www.freedesktop.org/standards/shared-mime-info" xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks" xmlns:kdepriv="http://www.kde.org/kdepriv">
         <bookmark href="{path}">
          <title>{title}</title>
          <info>
           <metadata owner="http://freedesktop.org">
            <bookmark:icon name="inode-directory"/>
           </metadata>
           <metadata owner="http://www.kde.org">
            <ID>{id}</ID>
            <IsHidden>false</IsHidden>
           </metadata>
          </info>
         </bookmark>
        </xbel>""".format(path=path, title=title, id=id_)).find('bookmark')


documents_node = prepare_custom_place_node(path='file:///home/{user}/Documents'.format(user=username),
                                           title='Documents',
                                           id_='1548158379/1 (V2)')

downloads_node = prepare_custom_place_node(path='file:///home/{user}/Downloads'.format(user=username),
                                           title='Downloads',
                                           id_='1548141294/0 (V2)')

root.insert(trash_node_index + 1, documents_node)
root.insert(trash_node_index + 2, downloads_node)

# Biblioteka ElementTree nie wspiera wielu przestrzeni nazw - trzeba dodać "ręcznie"...
root.attrib['xmlns:mime'] = "http://www.freedesktop.org/standards/shared-mime-info"
root.attrib['xmlns:kdepriv'] = "http://www.kde.org/kdepriv"

with open(userplaces_out_path, 'wb') as f:
    # Biblioteka ElementTree nie wspiera 'DOCTYPE' - trzeba dodać "ręcznie"...
    f.write('<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE xbel>\n'.encode('utf8'))
    tree.write(f, encoding='utf-8', xml_declaration=False)
    # tree.write(f, encoding='utf-8', xml_declaration=True)

# # DEBUG
# with open('out.xml', 'wb') as f:
#     # Biblioteka ElementTree nie wspiera 'DOCTYPE' - trzeba dodać "ręcznie"...
#     f.write('<?xml version="1.0" encoding="UTF-8"?>\n<!DOCTYPE xbel>\n'.encode('utf8'))
#     tree.write(f, encoding='utf-8', xml_declaration=False)
#     # tree.write(f, encoding='utf-8', xml_declaration=True)
