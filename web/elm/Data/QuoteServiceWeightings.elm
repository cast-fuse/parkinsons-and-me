module Data.QuoteServiceWeightings exposing (..)

import Model exposing (..)
import Dict exposing (..)
import Set
import Data.Weightings exposing (..)


setQuoteServiceWeightings : QuoteServiceWeightings -> Model -> Model
setQuoteServiceWeightings data model =
    { model
        | quotes = data.quotes
        , services = data.services
        , weightings = data.weightings
        , userWeightings = makeEmptyWeightingsDict data.services
    }


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
