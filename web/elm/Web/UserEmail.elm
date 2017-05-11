module Web.UserEmail exposing (..)

import Model exposing (..)
import Json.Encode as Encode exposing (..)
import Http exposing (..)
import Web.Normalise exposing (normaliseEmail)
import Data.UserInfo exposing (emailToString)
import Data.Services exposing (top3Ids)


sendEmailConsent : Model -> Cmd Msg
sendEmailConsent model =
    case model.userId of
        Just uId ->
            putUser (makeEmailConsentUrl uId) (userEmailConsentJson model) PutUserEmailConsent

        Nothing ->
            Cmd.none


sendUserEmail : Model -> Cmd Msg
sendUserEmail model =
    case model.userId of
        Just uId ->
            putUser (makeEmailUrl uId model) (userEmailJson model) PutUserEmail

        Nothing ->
            Cmd.none


putUser : String -> Encode.Value -> (Result Error () -> Msg) -> Cmd Msg
putUser url body msg =
    put url (Http.jsonBody body)
        |> Http.send msg


userEmailConsentJson : Model -> Encode.Value
userEmailConsentJson model =
    userJson <| makeEmailConsentJson model


userEmailJson : Model -> Encode.Value
userEmailJson model =
    userJson <| makeEmailJson model


userJson : Encode.Value -> Encode.Value
userJson value =
    Encode.object
        [ ( "user", value ) ]


makeEmailConsentJson : Model -> Encode.Value
makeEmailConsentJson model =
    Encode.object
        [ ( "email_consent", Encode.bool model.emailConsent ) ]


makeEmailJson : Model -> Encode.Value
makeEmailJson model =
    Encode.object
        [ ( "email", Encode.string <| encodeEmail model )
        ]


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


makeEmailConsentUrl : Int -> String
makeEmailConsentUrl uId =
    "/api/users/" |> prepend (toString uId)


makeEmailUrl : Int -> Model -> String
makeEmailUrl uId model =
    "/api/users/"
        |> prepend (toString uId)
        |> prepend "?"
        |> prepend (sIdQueryString model)
        |> prepend "&uuid="
        |> prepend (Maybe.withDefault "" model.answerUuid)


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
