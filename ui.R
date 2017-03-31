#questionAnalysis
#change these defaults for your application

fluidPage(
  titlePanel(theWebPageTitle),		

  sidebarLayout(
    sidebarPanel(
      checkboxInput("noQuestions", "Remove question words from cloud?", value=T),
      checkboxInput("noNumbers", "Remove Numbers?", value=T),
      selectInput("theQuestion", "Choose question: ", multiple=FALSE, theQuestions),
      textAreaInput("wordsToExclude", "Exclude these words:(no spaces) ", theDefaultExclusionWords),
      submitButton(text="Update", icon=NULL),
      hr(),
    sliderInput("max","Maximum Number of Words:",
                  min = 1,  max = 30,  value = 22),
 	tags$div(class = "header", checked = NA,
               tags$a(href= theDataSource))),

    # Show Word Cloud
    mainPanel(	
      h3(textOutput("mainTitle")),
      plotOutput("plot")
    )))