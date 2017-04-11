module Data.Web.User exposing (..)

import Model exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)
import Data.UserInfo exposing (..)


postUserDetails : Model -> Cmd Msg
postUserDetails model =
    Http.post "/api/users" (Http.jsonBody <| makeUserJson model) userIdDecoder
        |> Http.send ReceiveUserId


makeUserJson : Model -> Value
makeUserJson model =
    let
        userDetails =
            makeUserDetailsJson model
    in
        Encode.object [ ( "user", userDetails ) ]


makeUserDetailsJson : Model -> Value
makeUserDetailsJson model =
    Encode.object
        [ ( "name", Encode.string <| encodeName model )
        , ( "age_range", Encode.string <| encodeAgeRange model )
        , ( "postcode", Encode.string <| encodePostcode model )
        ]


encodeName : Model -> String
encodeName model =
    Maybe.withDefault "" model.name


encodeAgeRange : Model -> String
encodeAgeRange model =
    Maybe.withDefault UnderForty model.ageRange
        |> ageRangeToString


encodePostcode : Model -> String
encodePostcode model =
    postCodeToString model.postcode


userIdDecoder : Decoder Int
userIdDecoder =
    Decode.at [ "data", "id" ] Decode.int
