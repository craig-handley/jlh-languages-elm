module Page.AdultCoursesPage exposing (Model, Msg(..), init, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Session
import Type.Course exposing (Course)
import Viewer



-- MODEL


type alias Model =
    { session : Session.Session
    }



-- INIT


init : Session.Session -> ( Model, Cmd Msg )
init session =
    ( Model session, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


viewCourses : Model -> Html Msg
viewCourses model =
    case model.session.courses of
        Just courses ->
            table []
                ([ viewTableHeader ] ++ List.map viewCourse courses)

        Nothing ->
            table [] []


viewTableHeader : Html Msg
viewTableHeader =
    thead []
        [ tr []
            [ th [] [ text "Date" ]
            , th [] [ text "Time" ]
            , th [] [ text "Venue" ]
            , th [] [ text "Details" ]
            ]
        ]


viewCourse : Course -> Html Msg
viewCourse course =
    tbody []
        [ tr []
            [ td [] [ text course.day ]
            , td [] [ text course.time ]
            , td [] [ text course.location ]
            , td [] [ text course.abilityLevel ]
            ]
        ]


view : Model -> Viewer.Details Msg
view model =
    { title = toTitle
    , body =
        [ div [ class "content" ]
            [ div [ class "heading" ] [ text "Current Courses" ]
            , viewCourses model
            , div [] [ text "* Advanced Conversation: For fluent or near-fluent speakers of French. Come along and chat or discuss the issues of the day." ]
            , div [] [ text "** Improvers: Learners have a sound grasp of French grammar and want to improve their spoken French in order to communicate effectively in the language." ]
            , div [] [ text "First session free." ]
            , div [] [ text "If you are interested in attending a course at any of these locations please get in touch (jane@jlhlanguages.org / 07793 556020) stating the venue(s) of interest and the relevant French course (beginner / mixed ability / intermediate / advanced.)" ]
            , div [] [ text "If none of these locations are suitable please send details of a town / village near you and we will do our best to accommodate your request." ]
            , div [] [ text "JLH Languages will provide:" ]
            , list1
            , div [] [ text "Terms and Conditions:" ]
            , list2
            ]
        ]
    }


list1 : Html msg
list1 =
    ul []
        [ li [] [ text "A weekly lesson of 90 minutes" ]
        , li [] [ text "All materials used during the lesson (material from the lesson is e-mailed out after the lesson each week so you can go over anything you want to at your leisure.)" ]
        , li [] [ text "A drink during the short break" ]
        , li [] [ text "Regular tips of how to learn and links to useful websites/TV or radio programmes that may be of interest to learners of French" ]
        ]


list2 : Html msg
list2 =
    ul []
        [ li [] [ text "Lesson are purchased in blocks: 3 lessons for £45 or 5 lessons for £65" ]
        , li [] [ text "The client needs to give at least 1 week’s notice if the client cannot attend a lesson due to a foreseeable event (e.g. hospital appointment.) Full payment will not be taken for that lesson as long as the client gives at least 1 week’s notice" ]
        , li [] [ text "However, the client will be charged £4 for the resources related to the missed lesson that are e-mailed out" ]
        , li [] [ text "Payment can be made by card, bank transfer or in cash" ]
        ]



-- HELPERS


toTitle : String
toTitle =
    "Adult Courses Page"
