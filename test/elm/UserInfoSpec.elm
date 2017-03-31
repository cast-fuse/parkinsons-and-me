module UserInfoSpec exposing (all)

import Test exposing (..)
import Expect
import Model exposing (..)
import Update exposing (initialModel)
import Data.UserInfo
    exposing
        ( validatePostcode
        , validateForm
        )


all : Test
all =
    describe "User Info Test Suite"
        [ valdidatePostcodeSpec
        , validateFormSpec
        ]


valdidatePostcodeSpec : Test
valdidatePostcodeSpec =
    describe "validatePostcode"
        [ test "an empty postcode should return a NotEntered Value" <|
            \() ->
                Expect.equal (validatePostcode "") NotEntered
        , test "an invalid postcode should return the postcode wrapped in an Invalid value" <|
            \() ->
                Expect.equal (validatePostcode "e83") (Invalid "e83")
        , test "a valid postcode should return the postcoed wrapped in a Valid value" <|
            \() ->
                Expect.equal (validatePostcode "e82na") (Valid "e82na")
        , test "should handle capital letters" <|
            \() ->
                Expect.equal (validatePostcode "E82NA") (Valid "E82NA")
        ]


validateFormSpec : Test
validateFormSpec =
    describe "validateForm"
        [ test "returns True if all fields are valid" <|
            \() ->
                Expect.true "" (validateForm validFormModel)
        , test "returns False if the name field is invalid" <|
            \() ->
                Expect.false "" (validateForm invalidNameModel)
        , test "returns False if the age field is invalid" <|
            \() ->
                Expect.false "" (validateForm invalidAgeModel)
        , test "returns False if the postcode field is invalid" <|
            \() ->
                Expect.false "" (validateForm invalidPostcodeModel)
        , test "returns False if the postcode field is not entered" <|
            \() ->
                Expect.false "" (validateForm notEnteredPostcodeModel)
        ]


validFormModel : Model
validFormModel =
    { initialModel
        | name = Just "andrew"
        , postcode = Valid "e82na"
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
        | postcode = Invalid "e82"
    }


notEnteredPostcodeModel : Model
notEnteredPostcodeModel =
    { validFormModel
        | postcode = NotEntered
    }
