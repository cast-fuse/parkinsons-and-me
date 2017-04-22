module Data.Web.Results.Request exposing (..)

import Http exposing (..)
import Json.Decode as Json exposing (..)
import Json.Decode.Pipeline exposing (..)
import Data.Web.Answers exposing (..)
import Data.Web.QuoteServiceWeightings exposing (..)
import Data.Web.User exposing (rawUserDecoder)
import Model exposing (..)


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
    Json.map (\{ quoteId, answer } -> ( quoteId, answer )) rawAnswerDecoder
        |> Json.list


rawAnswerDecoder : Decoder RawAnswer
rawAnswerDecoder =
    decode RawAnswer
        |> required "quote_id" int
        |> required "answer" booltoAnswerDecoder


booltoAnswerDecoder : Decoder Answer
booltoAnswerDecoder =
    bool |> andThen (\x -> succeed (boolToAnswer x))
