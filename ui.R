#giveDirectly UI


fluidPage(
  # Application title
  titlePanel("GiveDirectly Survey"),

  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      checkboxInput("noQuestions", "Remove question words?", value=T),
 #     checkboxInput("noNumbers", "Remove numbers?", value=F),
      selectInput("theQuestion", "Choose question: ", multiple=FALSE, theQuestions),
      textAreaInput("wordsToExclude", "Exclude these words: ", value="kes,give,"),
      submitButton(text="Update", icon=NULL),
      hr(),
 #     sliderInput("freq",
  #                "Minimum Frequency:",
  #                min = 1,  max = numResponses, value = 15),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 30,  value = 22)
    ),

    # Show Word Cloud
    mainPanel(
         # verbatimTextOutput("value"),

      plotOutput("plot")
    )
  )
)