module Data.Quotes exposing (..)

import Model exposing (..)
import Dict exposing (..)


getQuoteIds : Quotes -> List QuoteId
getQuoteIds =
    Dict.keys


nextQuote : Maybe (List QuoteId) -> Maybe QuoteId
nextQuote quoteIds =
    quoteIds
        |> Maybe.andThen List.head


remainingQuotes : Maybe (List QuoteId) -> Maybe (List QuoteId)
remainingQuotes quoteIds =
    quoteIds
        |> Maybe.andThen List.tail
