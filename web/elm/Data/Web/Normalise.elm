module Data.Web.Normalise exposing (..)

import Model exposing (..)


normaliseName : String -> String
normaliseName =
    String.toLower


normaliseEmail : String -> String
normaliseEmail =
    String.toLower


normalisePostcode : String -> String
normalisePostcode postcode =
    postcode
        |> String.filter ((/=) ' ')
        |> String.toLower


normaliseAgeRange : AgeRange -> String
normaliseAgeRange ageRange =
    case ageRange of
        UnderForty ->
            "under_forty"

        Forties ->
            "forties"

        Fifties ->
            "fifties"

        Sixties ->
            "sixties"

        Seventies ->
            "seventies"

        OverEighty ->
            "over_eighty"


stringToAgeRange : String -> AgeRange
stringToAgeRange ageRange =
    case ageRange of
        "under_forty" ->
            UnderForty

        "forties" ->
            Forties

        "fifties" ->
            Fifties

        "sixties" ->
            Sixties

        "seventies" ->
            Seventies

        "over_eighty" ->
            OverEighty

        _ ->
            UnderForty
