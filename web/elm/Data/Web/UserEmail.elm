module Data.Web.UserEmail exposing (..)

import Model exposing (..)
import Json.Encode as Encode exposing (..)
import Http exposing (..)
import Data.Web.Normalise exposing (normaliseEmail)


sendUserEmail : Model -> Cmd Msg
sendUserEmail model =
    case model.userId of
        Just uId ->
            put ("/api/users/" ++ (toString uId)) (Http.jsonBody <| makeUserJson model)
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
    emailToString model
        |> normaliseEmail


emailToString : Model -> String
emailToString model =
    case model.email of
        ValidEmail email ->
            email

        InvalidEmail email ->
            email

        RetrievedEmail email ->
            email

        _ ->
            ""


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
