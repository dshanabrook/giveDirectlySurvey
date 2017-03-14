#giveDirectly UI

fluidPage(
  titlePanel("GiveDirectly Survey"),

  sidebarLayout(
    sidebarPanel(
      checkboxInput("noQuestions", "Remove question words?", value=T),
      selectInput("theQuestion", "Choose question: ", multiple=FALSE, theQuestions),
      textAreaInput("wordsToExclude", "Exclude these words: ", value="kes,give,"),
      submitButton(text="Update", icon=NULL),
      hr(),
    sliderInput("max","Maximum Number of Words:",
                  min = 1,  max = 30,  value = 22)
    ),

    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )
  )
)