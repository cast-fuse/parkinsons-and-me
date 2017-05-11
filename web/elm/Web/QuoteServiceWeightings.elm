module Web.QuoteServiceWeightings exposing (..)

import Data.QuoteServiceWeightings exposing (..)
import Dict exposing (..)
import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Model exposing (..)


getQuoteServiceWeightings : Cmd Msg
getQuoteServiceWeightings =
    Http.get "/api/quotes-services-weightings" (field "data" quoteServiceWeightingsDecoder)
        |> Http.send ReceiveQuoteServiceWeightings


quoteServiceWeightingsDecoder : Decoder QuoteServiceWeightings
quoteServiceWeightingsDecoder =
    decode QuoteServiceWeightings
        |> required "quotes" quoteDecoder
        |> required "services" servicesDecoder
        |> required "weightings" weightingDecoder


quoteDecoder : Decoder Quotes
quoteDecoder =
    list rawQuoteDecoder
        |> Decode.map Dict.fromList


rawQuoteDecoder : Decoder ( QuoteId, String )
rawQuoteDecoder =
    decode (,)
        |> required "id" int
        |> required "body" string


servicesDecoder : Decoder Services
servicesDecoder =
    list rawServiceDecoder
        |> Decode.map Dict.fromList


rawServiceDecoder : Decoder ( ServiceId, ServiceData )
rawServiceDecoder =
    let
        service a b c d e f i =
            ( i, ServiceData a b c d e f )
    in
        decode service
            |> required "title" string
            |> required "body" string
            |> required "cta" string
            |> required "url" string
            |> required "early_onset" bool
            |> required "location_based_url" bool
            |> required "id" int


weightingDecoder : Decoder Weightings
weightingDecoder =
    list rawWeightingDecoder
        |> Decode.map rawWeightingToDict


rawWeightingDecoder : Decoder RawWeighting
rawWeightingDecoder =
    decode RawWeighting
        |> required "quote_id" int
        |> required "service_id" int
        |> required "weight" float
