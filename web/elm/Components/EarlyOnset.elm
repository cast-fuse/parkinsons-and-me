module Components.EarlyOnset exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


url : String
url =
    "https://www.parkinsons.org.uk/"


earlyOnset : Html Msg
earlyOnset =
    div [ class "bg-light-gray" ]
        [ p [] [ text "your rights and legal options" ]
        , p [] [ text "money grants and benefits" ]
        , a [ attribute "href" url, attribute "onclick" ("trackOutboundLink('" ++ url ++ "'); return true;"), attribute "target" "_blank" ] [ text "Find out more" ]
        ]
