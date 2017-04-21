module Data.Web.Answers exposing (..)

import Model exposing (..)
import Http exposing (..)
import Json.Encode as Encode
import Json.Decode as Decode exposing (..)


handlePostAnswers : Model -> Cmd Msg
handlePostAnswers model =
    case model.currentQuote of
        Nothing ->
            postAnswers model

        _ ->
            Cmd.none


postAnswers : Model -> Cmd Msg
postAnswers model =
    case model.userId of
        Just uId ->
            Http.post ("/api/users/" ++ (toString uId) ++ "/answers") (Http.jsonBody <| makeAnswersJson model) (answerResponseDecoder)
                |> Http.send PostUserAnswers

        Nothing ->
            Cmd.none


answerResponseDecoder : Decoder String
answerResponseDecoder =
    at [ "data", "uuid" ] string


makeAnswersJson : Model -> Value
makeAnswersJson model =
    Encode.object [ ( "answer", makeAnswersObj model ) ]


makeAnswersObj : Model -> Value
makeAnswersObj model =
    Encode.object [ ( "answers", Encode.object <| encodeAnswers model ) ]


encodeAnswers : Model -> List ( String, Value )
encodeAnswers model =
    List.map (\( qId, answer ) -> ( toString qId, Encode.bool <| answerToBool answer )) model.userAnswers


answerToBool : Answer -> Bool
answerToBool answer =
    case answer of
        Yes ->
            True

        No ->
            False


boolToAnswer : Bool -> Answer
boolToAnswer answer =
    case answer of
        True ->
            Yes

        False ->
            No
