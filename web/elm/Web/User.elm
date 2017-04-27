module Web.User exposing (..)

import Model exposing (..)
import Model.Email exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Data.UserInfo exposing (..)
import Web.Normalise exposing (..)


handleRetrievedUserData : RawUser -> Model -> Model
handleRetrievedUserData rawUser model =
    case rawUser.email of
        "" ->
            { model | email = NotEntered, userId = Just rawUser.id }

        _ ->
            { model | email = Valid rawUser.email, userId = Just rawUser.id }


postUserDetails : Model -> Cmd Msg
postUserDetails model =
    Http.post "/api/users" (Http.jsonBody <| makeUserJson model) (field "data" rawUserDecoder)
        |> Http.send ReceiveUser


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
        |> normaliseName


encodeAgeRange : Model -> String
encodeAgeRange model =
    Maybe.withDefault UnderForty model.ageRange
        |> normaliseAgeRange


encodePostcode : Model -> String
encodePostcode model =
    postCodeToString model.postcode
        |> normalisePostcode


rawUserDecoder : Decoder RawUser
rawUserDecoder =
    decode RawUser
        |> required "id" int
        |> required "name" string
        |> required "age_range" ageRangeDecoder
        |> optional "email" string ""
        |> required "postcode" string


ageRangeDecoder : Decoder AgeRange
ageRangeDecoder =
    string |> Decode.map stringToAgeRange
