module Helpers.Styles exposing (..)


classes : List String -> String
classes =
    String.join " "


button : String
button =
    "ph3 pv2 f3 outline-0 pointer no-select sans-serif"


buttonClearHover : String
buttonClearHover =
    classes [ buttonClear, "bg-animate hover-bg-light-blue" ]


buttonClear : String
buttonClear =
    "bg-white b--green-blue ba bw1 " ++ button


buttonDisabled : String
buttonDisabled =
    "bg-light-gray gray bn " ++ button


inputField : String
inputField =
    "w-100 f6 b--green-blue ba h2 outline-0 ph3 pv1"
