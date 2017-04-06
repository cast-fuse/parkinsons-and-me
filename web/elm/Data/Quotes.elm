module Data.Quotes exposing (..)

import Model exposing (..)
import Dict exposing (..)


handleGoToServices : Model -> Model
handleGoToServices model =
    case model.currentQuote of
        Nothing ->
            { model | view = Services }

        _ ->
            model


handleNextQuote : Model -> Model
handleNextQuote model =
    { model
        | currentQuote = nextQuote model.remainingQuotes
        , remainingQuotes = remainingQuotes model.remainingQuotes
    }


nextQuote : Maybe (List QuoteId) -> Maybe QuoteId
nextQuote quoteIds =
    quoteIds
        |> Maybe.andThen List.head


remainingQuotes : Maybe (List QuoteId) -> Maybe (List QuoteId)
remainingQuotes quoteIds =
    quoteIds
        |> Maybe.andThen List.tail


getQuoteIds : Quotes -> List QuoteId
getQuoteIds =
    Dict.keys
