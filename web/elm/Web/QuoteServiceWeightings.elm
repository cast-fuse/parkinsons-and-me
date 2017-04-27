module Web.QuoteServiceWeightings exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Http exposing (..)
import Model exposing (..)
import Dict exposing (..)
import Data.QuoteServiceWeightings exposing (..)


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
    decode (\serviceId body title cta url earlyOnset shortcode -> ( serviceId, ServiceData title body cta url earlyOnset shortcode ))
        |> required "id" int
        |> required "body" string
        |> required "title" string
        |> required "cta" string
        |> required "url" string
        |> required "early_onset" bool
        |> required "shortcode" string


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
