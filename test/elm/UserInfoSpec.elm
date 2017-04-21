module UserInfoSpec exposing (all)

import Test exposing (..)
import Expect
import Model exposing (..)
import Update exposing (initialModel)
import Data.UserInfo
    exposing
        ( validatePostcode
        , isValidPostcode
        , isValidName
        , isValidAgeRange
        )


all : Test
all =
    describe "User Info Test Suite"
        [ valdidatePostcodeSpec
        , isValidNameSpec
        , isValidAgeRangeSpec
        ]


valdidatePostcodeSpec : Test
valdidatePostcodeSpec =
    describe "postcodeValidation"
        [ describe "validatePostcode"
            [ test "an empty postcode should return a NotEntered Value" <|
                \() ->
                    Expect.equal (validatePostcode "") NotEnteredPostcode
            , test "an invalid postcode should return the postcode wrapped in an Invalid value" <|
                \() ->
                    Expect.equal (validatePostcode "e83") (InvalidPostcode "e83")
            , test "a valid postcode should return the postcoed wrapped in a Valid value" <|
                \() ->
                    Expect.equal (validatePostcode "e82na") (ValidPostcode "e82na")
            , test "should handle capital letters" <|
                \() ->
                    Expect.equal (validatePostcode "E82NA") (ValidPostcode "E82NA")
            ]
        , describe "isValidPostcode"
            [ test "returns True for a Valid Postcode" <|
                \() ->
                    Expect.true "" (isValidPostcode validFormModel.postcode)
            , test "returns False for an Invalid Postcode" <|
                \() ->
                    Expect.false "" (isValidPostcode invalidPostcodeModel.postcode)
            , test "returns False for a NotEntered Postcode" <|
                \() ->
                    Expect.false "" (isValidPostcode notEnteredPostcodeModel.postcode)
            ]
        ]


isValidNameSpec : Test
isValidNameSpec =
    describe "isValidNameSpec"
        [ test "returns True if a valid name" <|
            \() ->
                Expect.true "" (isValidName validFormModel)
        , test "returns False if the name field is invalid" <|
            \() ->
                Expect.false "" (isValidName invalidNameModel)
        ]


isValidAgeRangeSpec : Test
isValidAgeRangeSpec =
    describe "isValidAgerange"
        [ test "returns True if a valid AgeRange" <|
            \() ->
                Expect.true "" (isValidAgeRange validFormModel)
        , test "returns False if the name field is invalid" <|
            \() ->
                Expect.false "" (isValidAgeRange invalidAgeModel)
        ]


validFormModel : Model
validFormModel =
    { initialModel
        | name = Just "andrew"
        , postcode = ValidPostcode "e82na"
        , ageRange = Just UnderForty
    }


invalidNameModel : Model
invalidNameModel =
    { validFormModel
        | name = Nothing
    }


invalidAgeModel : Model
invalidAgeModel =
    { validFormModel
        | ageRange = Nothing
    }


invalidPostcodeModel : Model
invalidPostcodeModel =
    { validFormModel
        | postcode = InvalidPostcode "e82"
    }


notEnteredPostcodeModel : Model
notEnteredPostcodeModel =
    { validFormModel
        | postcode = NotEnteredPostcode
    }
