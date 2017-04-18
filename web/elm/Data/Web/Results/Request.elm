module Data.Web.Results.Request exposing (..)

import Http exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Data.Web.Normalise exposing (..)
import Data.Web.Answers exposing (..)
import Data.Web.QuoteServiceWeightings exposing (..)
import Model exposing (..)
import Dict exposing (..)


getResults : String -> Cmd Msg
getResults aId =
    Http.get ("/api/my-results/" ++ aId) (field "data" previousResultsDecoder)
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
        |> andThen (\x -> (succeed (transformRawAnswers x)))


transformRawAnswers : Dict String Bool -> List ( QuoteId, Answer )
transformRawAnswers answers =
    answers
        |> Dict.toList
        |> List.map (\( qId, answerBool ) -> ( String.toInt qId, boolToAnswer answerBool ))
        |> List.map (\( x, y ) -> ( Result.withDefault 0 x, y ))


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
    string |> andThen (\x -> (succeed (stringToAgeRange x)))
