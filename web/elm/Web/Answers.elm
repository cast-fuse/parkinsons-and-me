module Web.Answers exposing (..)

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


handlePostAnswersLoading : Model -> Model
handlePostAnswersLoading model =
    case model.currentQuote of
        Nothing ->
            { model | view = Loading }

        _ ->
            model


postAnswers : Model -> Cmd Msg
postAnswers model =
    model.userId
        |> Maybe.map (sendAnswers model)
        |> Maybe.withDefault Cmd.none


sendAnswers : Model -> Int -> Cmd Msg
sendAnswers model uId =
    Http.post (answersUrl uId) (makeAnswersJson model) answerResponseDecoder
        |> Http.send PostUserAnswers


answersUrl : Int -> String
answersUrl uId =
    "/api/users/" ++ (toString uId) ++ "/answers"


makeAnswersJson : Model -> Body
makeAnswersJson model =
    Encode.object [ ( "answer", makeAnswersObj model ) ]
        |> Http.jsonBody


answerResponseDecoder : Decoder String
answerResponseDecoder =
    at [ "data", "uuid" ] string


makeAnswersObj : Model -> Value
makeAnswersObj model =
    Encode.object [ ( "answers", encodeAnswers model ) ]


encodeAnswers : Model -> Value
encodeAnswers model =
    List.map encodeAnswer model.userAnswers
        |> Encode.list


encodeAnswer : ( QuoteId, Answer ) -> Value
encodeAnswer ( qId, answer ) =
    Encode.object
        [ ( "answer", Encode.bool <| answerToBool answer )
        , ( "quote_id", Encode.int qId )
        ]


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
