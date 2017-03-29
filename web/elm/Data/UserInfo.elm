module Data.UserInfo exposing (..)

import Model exposing (..)
import Regex exposing (..)


infoQueries : List ( String, String -> Msg )
infoQueries =
    [ ( "What's your name?", SetName )
    , ( "What's your postcode?", SetPostcode )
    ]


ageRanges : List AgeRange
ageRanges =
    [ UnderForty
    , Forties
    , Fifties
    , Sixties
    , Seventies
    , OverEighty
    ]


ageRangeToString : AgeRange -> String
ageRangeToString ageRange =
    case ageRange of
        UnderForty ->
            "Under 40"

        Forties ->
            "40s"

        Fifties ->
            "50s"

        Sixties ->
            "60s"

        Seventies ->
            "70s"

        OverEighty ->
            "80+"


validatePostcode : String -> Postcode
validatePostcode postcode =
    if Regex.contains postcodeRegex postcode then
        Valid postcode
    else
        Invalid postcode


postcodeRegex : Regex
postcodeRegex =
    regex "^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$"
