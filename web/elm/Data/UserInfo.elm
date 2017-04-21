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
        NotEnteredPostcode ->
            ""

        InvalidPostcode string ->
            string

        ValidPostcode postcode ->
            postcode


validatePostcode : String -> Postcode
validatePostcode postcode =
    if Regex.contains postcodeRegex postcode then
        ValidPostcode postcode
    else if postcode == "" then
        NotEnteredPostcode
    else
        InvalidPostcode postcode



-- regex from Stack overflow answer: http://stackoverflow.com/questions/164979/uk-postcode-regex-comprehensive


postcodeRegex : Regex
postcodeRegex =
    regex "^(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))$"


isValidPostcode : Postcode -> Bool
isValidPostcode postcode =
    case postcode of
        ValidPostcode _ ->
            True

        _ ->
            False


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


emailRegex : Regex
emailRegex =
    regex
        "^(([^<>()\\[\\]\\\\.,;:\\s@\"]+(\\.[^<>()\\[\\]\\\\.,;:\\s@\"]+)*)|(\".+\"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"


validateEmail : String -> Email
validateEmail email =
    if Regex.contains emailRegex email then
        ValidEmail email
    else if email == "" then
        NotEnteredEmail
    else
        InvalidEmail email


isValidEmail : Email -> Bool
isValidEmail email =
    case email of
        ValidEmail _ ->
            True

        _ ->
            False


emailToString : Email -> String
emailToString email =
    case email of
        ValidEmail email ->
            email

        InvalidEmail email ->
            email

        RetrievedEmail email ->
            email

        SubmittedEmail email ->
            email

        _ ->
            ""
