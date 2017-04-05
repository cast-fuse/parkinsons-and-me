module Data.Web exposing (..)

import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Http exposing (..)
import Model exposing (..)
import Dict


quoteDecoder : Decoder Quotes
quoteDecoder =
    Json.Decode.map Dict.fromList (list rawQuoteDecoder)


rawQuoteDecoder : Decoder ( QuoteId, String )
rawQuoteDecoder =
    decode (,)
        |> required "id" int
        |> required "body" string


serviceDecoder : Decoder ( ServiceId, ServiceData )
serviceDecoder =
    decode (\serviceId body title cta url -> ( serviceId, ServiceData title body cta url ))
        |> required "id" int
        |> required "body" string
        |> required "title" string
        |> required "cta" string
        |> required "url" string


rawWeigthingDecoder : Decoder RawWeighting
rawWeigthingDecoder =
    decode RawWeighting
        |> required "quote_id" int
        |> required "service_id" int
        |> required "weight" float
