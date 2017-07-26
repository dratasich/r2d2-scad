#!/usr/bin/python
"""Converts igs to stl files using FreeCAD library.

Adapted from:
https://gist.github.com/slazav/4853bd36669bb9313ddb83f51ee1cb82

"""

import sys

# path to FreeCAD.so
FREECADPATH = '/usr/lib/freecad/lib'
sys.path.append(FREECADPATH)

if len(sys.argv)<3:
   print "Usage: {} <in_file> <out_file>".format(sys.argv[0])
   sys.exit(1)

iname=sys.argv[1]
oname=sys.argv[2]

# support only stl as output format
# determine format from extension
if oname[-4:]==".stl":
   type="stl"
else:
   print "Output file should have .stl extension"
   sys.exit(1)

import FreeCAD
import Part

# this should read any type of file
FreeCAD.loadFile(iname)

# iterate through all objects
for o in App.ActiveDocument.Objects:
   # find root object and export the shape
   if len(o.InList) == 0:
      o.Shape.exportStl(oname)
      sys.exit(0)

print "Error: can't find any object"
sys.exit(1)
