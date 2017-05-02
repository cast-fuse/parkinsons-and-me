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
