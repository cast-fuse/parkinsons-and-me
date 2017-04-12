module Data.Shuffle exposing (..)

import Random exposing (..)
import Model exposing (..)
import Tuple exposing (..)


handleShuffleQuotes : List QuoteId -> List Int -> Model -> Model
handleShuffleQuotes qIds randomInts model =
    let
        shuffledIds =
            shuffleList qIds randomInts
    in
        { model
            | currentQuote = List.head shuffledIds
            , remainingQuotes = List.tail shuffledIds
        }


shuffleQuoteIds : List QuoteId -> Cmd Msg
shuffleQuoteIds qIds =
    generate (ShuffleQuoteIds qIds) (randomList qIds)


shuffleList : List Int -> List Int -> List Int
shuffleList xs randomXs =
    xs
        |> List.map2 (,) randomXs
        |> List.sortBy first
        |> List.unzip
        |> second


randomList : List QuoteId -> Generator (List Int)
randomList qIds =
    list (List.length qIds) randomInt


randomInt : Generator Int
randomInt =
    int 0 100
