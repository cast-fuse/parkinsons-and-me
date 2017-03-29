module Helpers.Styles
    exposing
        ( button
        , buttonBlue
        , buttonClear
        )


button : String
button =
    "ph4 pv3 f5 outline-0"


buttonBlue : String
buttonBlue =
    "bg-dark-blue white bn " ++ button


buttonClear : String
buttonClear =
    "bg-white b--dark-blue dark-blue ba " ++ button
