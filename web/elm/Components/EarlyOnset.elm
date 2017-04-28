module Components.EarlyOnset exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


url : String
url =
    "https://www.parkinsons.org.uk/"


earlyOnset : Html Msg
earlyOnset =
    div [ class "bg-light-gray" ]
        [ p [] [ text "your rights and legal options" ]
        , p [] [ text "money grants and benefits" ]
        , a [ href url, onClick <| TrackLink url ] [ text "Find out more" ]
        ]
