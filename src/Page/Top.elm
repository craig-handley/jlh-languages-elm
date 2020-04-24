module Page.Top exposing (Model, Msg(..), init, update, view)

import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events
import Json.Decode
import Ports
import Session
import Utils exposing (..)
import Viewer



{-
   This is the top page - the page that is displayed when the url path is "/"
-}
-- MODEL


type alias Model =
    { session : Session.Session
    , localStorageInputField : String
    }



-- INIT


init : Session.Session -> ( Model, Cmd Msg )
init session =
    ( Model session "", Cmd.none )



-- UPDATE


type Msg
    = NoOp
    | LocalStorageInputFieldChange String
    | SetLocalStorage
    | ClearLocalStorage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        -- Updates the value of the localStorage input field in the model
        LocalStorageInputFieldChange input ->
            ( { model | localStorageInputField = input }, Cmd.none )

        -- Sets the value in local storage (from Set localStorage button, onEnter listener of the localStorage input field)
        SetLocalStorage ->
            let
                localStorage =
                    { token = model.localStorageInputField }

                session =
                    model.session

                newSession =
                    { session | localStorage = Just localStorage }
            in
            ( { model | localStorageInputField = "", session = newSession }, Ports.toLocalStorage localStorage )

        -- Clears localStorage (from Clear localStorage button)
        ClearLocalStorage ->
            let
                session =
                    model.session

                newSession =
                    { session | localStorage = Nothing }
            in
            ( { model | session = newSession }, Ports.clearLocalStorage () )



-- VIEW


view : Model -> Viewer.Details Msg
view model =
    { title = toTitle
    , body =
        [ div [ class "row" ]
            [ div [ class "column" ]
                [ h1 [] [ text "Adult Courses" ]
                , div [ class "content" ]
                    [ div [] [ text "JLH Languages teaches French to adults as a type of \"brain gym.\"" ]
                    , div [] [ text "Everyone wants to live a healthy life for longer: there is increasing scientific evidence that suggests that we need to exercise our brain as well as our body. Factors that help to keep our brain in good shape are:" ]
                    , list1
                    , div [] [ text "Learning a foreign language includes all 3 of these elements. In addition, doing something different and fun is also an excellent way of reducing stress." ]
                    , div [] [ text "According to a Public Health England report in 2016, \"Keeping your brain active and challenged throughout life may help reduce your dementia risk.\"" ]
                    , div [] [ text "We teach languages in an innovative way. Each unit of teaching is based around a conversation (e.g. on food, sport, camping, music) and by the end of each module learners will have mastered the conversation so that they are able to communicate in the target language on that topic." ]
                    , div [] [ text "If you would like to learn a language from scratch or refresh your knowledge in a fun and friendly environment then get in touch to find the nearest class to you!" ]
                    , div [] [ text "Other services:" ]
                    , list2
                    ]
                ]
            , div [ class "column" ]
                [ h1 [] [ text "Immersive Restaurant Experience For Schools" ]
                , div [ class "content" ]
                    [ div [] [ text "Having worked for several years as a Head of Department of Modern Languages, I was always looking for a way to bring the languages I taught to life. This is very challenging in a classroom but the alternative, a trip abroad, can be a very time-consuming endeavour and is, sadly, out of the question for many students." ]
                    , div [] [ text "This is the reason why I have teamed up with restaurants in my local area to offer a fun, effective and hassle-free alternative to a foreign trip." ]
                    , div [] [ text "Our aim is to give students a taste of being in a French restaurant whilst remaining in the UK. The restaurants I am currently working with are based in Cannock (South Staffordshire) although I do have plans to expand to other regions." ]
                    , div [] [ text "We can cater for groups up to a maximum of 30 students. We cater for all dietary requirements (e.g. vegetarians, vegans, food allergies, Halal meals) so that all students can participate fully and benefit from this experience." ]
                    ]
                ]
            ]
        ]
    }



-- HELPERS


toTitle : String
toTitle =
    "Home Page"


list1 : Html msg
list1 =
    ul []
        [ li [] [ text "Education – learning a new skill" ]
        , li [] [ text "Social engagement – joining a club, meeting with other people" ]
        , li [] [ text "Cognitive stimulation – reading, puzzles, crosswords" ]
        ]


list2 : Html msg
list2 =
    ul []
        [ li [] [ text "Private tuition for GCSE and A-level examinations" ]
        , li [] [ text "Intensive one-to-one tuition" ]
        , li [] [ text "Business French lessons" ]
        ]



-- Custom event listener for the 'Enter' key being pressed


onEnter : Msg -> Attribute Msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.Decode.succeed msg

            else
                Json.Decode.fail "not ENTER"
    in
    Html.Events.on "keydown" (Json.Decode.andThen isEnter Html.Events.keyCode)
