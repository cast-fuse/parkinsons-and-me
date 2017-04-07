module Data.UserInfo exposing (..)

import Model exposing (..)
import Regex exposing (..)


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


postCodeToString : Postcode -> String
postCodeToString postcode =
    case postcode of
        NotEntered ->
            ""

        Invalid string ->
            string

        Valid postcode ->
            postcode


validatePostcode : String -> Postcode
validatePostcode postcode =
    if Regex.contains postcodeRegex postcode then
        Valid postcode
    else if postcode == "" then
        NotEntered
    else
        Invalid postcode



-- regex from Stack overflow answer: http://stackoverflow.com/questions/164979/uk-postcode-regex-comprehensive


postcodeRegex : Regex
postcodeRegex =
    regex "^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$"


isValidPostcode : Model -> Bool
isValidPostcode model =
    case model.postcode of
        NotEntered ->
            False

        Invalid _ ->
            False

        Valid _ ->
            True


isValidName : Model -> Bool
isValidName model =
    case model.name of
        Nothing ->
            False

        Just _ ->
            True


isValidAgeRange : Model -> Bool
isValidAgeRange model =
    case model.ageRange of
        Nothing ->
            False

        Just _ ->
            True
