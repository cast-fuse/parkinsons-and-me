module Data.Quotes
    exposing
        ( handleUpdateAnswers
        , firstQuote
        , quoteDict
        )

import Model exposing (..)
import Dict exposing (..)


handleUpdateAnswers : Model -> YesNo -> ( Int, Quote ) -> Model
handleUpdateAnswers model answer (( i, q ) as currentQuote) =
    let
        updatedQuotes =
            updateAnswer answer currentQuote model.quotes
    in
        if q == lastQuote then
            { model
                | view = Results
                , quotes = updatedQuotes
            }
        else
            { model
                | quotes = updatedQuotes
                , currentQuote = getQuote (i + 1) model.quotes
            }


getQuote : Int -> Dict Int Quote -> ( Int, Quote )
getQuote quoteIndex quotes =
    quotes
        |> Dict.get quoteIndex
        |> Maybe.map (\q -> ( quoteIndex, q ))
        |> Maybe.withDefault ( 0, dummyQuote )


updateAnswer : YesNo -> ( Int, Quote ) -> Dict Int Quote -> Dict Int Quote
updateAnswer newAnswer ( quoteIndex, _ ) quotes =
    let
        mapNewAnswer =
            Maybe.map (\q -> { q | answer = newAnswer })
    in
        Dict.update quoteIndex mapNewAnswer quotes


firstQuote : Quote
firstQuote =
    quoteDict
        |> Dict.get 0
        |> Maybe.withDefault dummyQuote


lastQuote : Quote
lastQuote =
    let
        lastIndex =
            (Dict.size quoteDict) - 1
    in
        quoteDict
            |> Dict.get lastIndex
            |> Maybe.withDefault dummyQuote


quoteDict : Dict Int Quote
quoteDict =
    let
        addIndexToQuote i x =
            ( i, Quote x No )
    in
        quotes
            |> List.indexedMap addIndexToQuote
            |> Dict.fromList


quotes : List String
quotes =
    List.map (\x -> "\"" ++ x ++ "\"")
        [ "Id' feel most comfortable if support staff came to see me at home."
        , "I'll just wait and see what information and support I'm offered."
        , "I want to say what I feel without anyone knowing who I cam, but know that someone will still be there listening and supporting me."
        ]


dummyQuote : Quote
dummyQuote =
    Quote "" No
