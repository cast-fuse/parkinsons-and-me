module Helpers.Styles exposing (..)


button : String
button =
    "ph4 pv3 f5 outline-0"


buttonBlue : String
buttonBlue =
    "bg-dark-blue white bn " ++ button


buttonClear : String
buttonClear =
    "bg-white b--dark-blue dark-blue ba " ++ button


buttonDisabled : String
buttonDisabled =
    "bg-light-gray gray bn " ++ button


inputField : String
inputField =
    "w7 f6 blue b--blue ba h2 ttu outline-0 ph3 pv1"
