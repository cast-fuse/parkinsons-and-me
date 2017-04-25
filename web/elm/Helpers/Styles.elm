module Helpers.Styles exposing (..)


button : String
button =
    "ph4 pv3 f5 outline-0 pointer"


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
    "w-100 f6 blue b--blue ba h2 ttu outline-0 ph3 pv1"


spikesBackground : List ( String, String )
spikesBackground =
    [ ( "background-image", "url(/images/spikes.png)" )
    , ( "height", "115%" )
    , ( "top", "-2rem" )
    ]


bubblesBackground : List ( String, String )
bubblesBackground =
    [ ( "background-image", "url(/images/bubbles.png)" )
    , ( "height", "115%" )
    , ( "top", "-2rem" )
    ]


fuzzBackground : List ( String, String )
fuzzBackground =
    [ ( "background-image", "url(/images/fuzz.png)" )
    , ( "height", "135%" )
    , ( "top", "-3rem" )
    ]
