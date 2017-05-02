module Helpers.Styles exposing (..)


button : String
button =
    "ph4 pv3 f5 outline-0 pointer"


buttonBlue : String
buttonBlue =
    "bg-green-blue white bn " ++ button


buttonClear : String
buttonClear =
    "bg-white b--green-blue black ba " ++ button


buttonDisabled : String
buttonDisabled =
    "bg-light-gray gray bn " ++ button


inputField : String
inputField =
    "w-100 f6 black b--green-blue ba2 h2 ttu outline-0 ph3 pv1"
