=================================
Load Packages for Static Analysis
=================================

:Go: af2bc6de6203608f26217d59db0d1a31549272e6
:Tools: 21861e6be56e68c27f11d9e6932c02be7f46284a

packages.Load
=============

packages.Load
   defaultDriver
      goListDriver (or findExternalDriver)


goListDriver:
   run `go list` to get various info (by gocommand.Runner)
      - `packagesdriver.GetSizesGolist` type size getter of given compiler/arch. 
      - `packages.createDriverResponse` do major load pkgs works
      -  deal with "file=XXX" and "pattern=XXXX" queries


createDriverResponse
   `golistargs` generates `go list` arguments
   TODO
