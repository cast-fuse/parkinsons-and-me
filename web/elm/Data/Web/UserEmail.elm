module Data.Web.UserEmail exposing (..)

import Model exposing (..)
import Json.Encode as Encode exposing (..)
import Http exposing (..)
import Data.Web.Normalise exposing (normaliseEmail)
import Data.UserInfo exposing (emailToString)
import Data.Services exposing (top3Ids)


sendUserEmail : Model -> Cmd Msg
sendUserEmail model =
    case model.userId of
        Just uId ->
            put (makeEmailUrl uId model) (Http.jsonBody <| makeUserJson model)
                |> Http.send PutUserEmail

        Nothing ->
            Cmd.none


makeUserJson : Model -> Encode.Value
makeUserJson model =
    Encode.object [ ( "user", makeEmailJson model ) ]


makeEmailJson : Model -> Encode.Value
makeEmailJson model =
    Encode.object
        [ ( "email", Encode.string <| encodeEmail model ) ]


encodeEmail : Model -> String
encodeEmail model =
    emailToString model.email
        |> normaliseEmail


put : String -> Http.Body -> Request ()
put url body =
    Http.request
        { method = "PUT"
        , headers = []
        , url = url
        , body = body
        , expect = expectStringResponse (\_ -> Ok ())
        , timeout = Nothing
        , withCredentials = False
        }


makeEmailUrl : Int -> Model -> String
makeEmailUrl uId model =
    "/api/users/"
        |> prepend (toString uId)
        |> prepend "?"
        |> prepend (sIdQueryString model)


prepend : String -> String -> String
prepend =
    flip (++)


sIdQueryString : Model -> String
sIdQueryString model =
    model.userWeightings
        |> top3Ids
        |> List.map toString
        |> String.join ","
        |> String.append "service_ids="
