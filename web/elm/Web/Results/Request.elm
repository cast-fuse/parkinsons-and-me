module Web.Results.Request exposing (..)

import Http exposing (..)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Web.Answers exposing (..)
import Web.QuoteServiceWeightings exposing (..)
import Web.User exposing (rawUserDecoder)
import Model exposing (..)
import Dict exposing (..)


getResults : String -> Cmd Msg
getResults answerUUID =
    Http.get ("/api/my-results/" ++ answerUUID) (field "data" previousResultsDecoder)
        |> Http.send ReceiveResults


previousResultsDecoder : Decoder Results
previousResultsDecoder =
    decode Results
        |> required "user" rawUserDecoder
        |> required "answers" answersDecoder
        |> required "quotes" quoteDecoder
        |> required "services" servicesDecoder
        |> required "weightings" weightingDecoder


answersDecoder : Decoder (List ( QuoteId, Answer ))
answersDecoder =
    field "answers" (dict bool)
        |> Json.map transformRawAnswers


transformRawAnswers : Dict String Bool -> List ( QuoteId, Answer )
transformRawAnswers answers =
    answers
        |> Dict.toList
        |> List.map (\( qId, answerBool ) -> ( String.toInt qId, boolToAnswer answerBool ))
        |> List.map (\( x, y ) -> ( Result.withDefault 0 x, y ))
