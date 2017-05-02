module Helpers.Styles exposing (..)


button : String
button =
    "ph3 pv2 f4 outline-0 pointer sans-serif"


buttonClear : String
buttonClear =
    "bg-white b--green-blue green-blue ba " ++ button


buttonDisabled : String
buttonDisabled =
    "bg-light-gray gray bn " ++ button


inputField : String
inputField =
    "w-100 f6 blue b--green-blue ba h2 outline-0 ph3 pv1"
