module Data.Web.QuoteServiceWeighting exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Http exposing (..)
import Model exposing (..)
import Dict exposing (..)
import Set


getQuoteServiceWeighting : Cmd Msg
getQuoteServiceWeighting =
    Http.get "/api/all" quoteServiceWeightingDecoder
        |> Http.send ReceiveQuoteServiceWeighting


quoteServiceWeightingDecoder : Decoder QuoteServiceWeighting
quoteServiceWeightingDecoder =
    decode QuoteServiceWeighting
        |> required "quotes" quoteDecoder
        |> required "services" servicesDecoder
        |> required "weightings" weightingDecoder


quoteDecoder : Decoder Quotes
quoteDecoder =
    Json.Decode.map Dict.fromList (list rawQuoteDecoder)


rawQuoteDecoder : Decoder ( QuoteId, String )
rawQuoteDecoder =
    decode (,)
        |> required "id" int
        |> required "body" string


servicesDecoder : Decoder Services
servicesDecoder =
    Json.Decode.map Dict.fromList (list rawServiceDecoder)


rawServiceDecoder : Decoder ( ServiceId, ServiceData )
rawServiceDecoder =
    decode (\serviceId body title cta url -> ( serviceId, ServiceData title body cta url ))
        |> required "id" int
        |> required "body" string
        |> required "title" string
        |> required "cta" string
        |> required "url" string


weightingDecoder : Decoder Weightings
weightingDecoder =
    Json.Decode.map rawWeightingToDict (list rawWeightingDecoder)


rawWeightingDecoder : Decoder RawWeighting
rawWeightingDecoder =
    decode RawWeighting
        |> required "quote_id" int
        |> required "service_id" int
        |> required "weight" float


getQuoteIdsFromWeightings : List RawWeighting -> List Int
getQuoteIdsFromWeightings rawWeightings =
    let
        removeDuplicates =
            Set.fromList >> Set.toList
    in
        rawWeightings
            |> List.map .quote_id
            |> removeDuplicates


rawWeightingToDict : List RawWeighting -> Dict QuoteId (Dict ServiceId Float)
rawWeightingToDict rawWeightings =
    let
        quoteIds =
            getQuoteIdsFromWeightings rawWeightings

        filterQuotesById qId =
            List.filter (\{ quote_id } -> qId == quote_id) rawWeightings

        makeWeightingsDict =
            List.foldr (\a b -> Dict.insert a.service_id a.weight b) Dict.empty

        weightingsByQuoteId =
            filterQuotesById >> makeWeightingsDict
    in
        quoteIds
            |> List.map (\qId -> ( qId, weightingsByQuoteId qId ))
            |> Dict.fromList
