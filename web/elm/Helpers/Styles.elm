module Helpers.Styles exposing (..)


button : String
button =
    "ph3 pv2 f3 outline-0 pointer sans-serif"


buttonClear : String
buttonClear =
    "bg-white b--green-blue ba bw1 " ++ button


buttonDisabled : String
buttonDisabled =
    "bg-light-gray gray bn " ++ button


inputField : String
inputField =
    "w-100 f6 blue b--green-blue bw1 ba h2 outline-0 ph3 pv1"
