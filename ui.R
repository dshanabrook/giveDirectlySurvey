#giveDirectly UI
#Basic Income - What it's like, Raw Responses

fluidPage(
  titlePanel("Basic Income - What it's like, Raw Responses"),		

  sidebarLayout(
    sidebarPanel(
      checkboxInput("noQuestions", "Remove question words from cloud?", value=T),
      checkboxInput("noNumbers", "Remove Numbers?", value=T),
      selectInput("theQuestion", "Choose question: ", multiple=FALSE, theQuestions),
      textAreaInput("wordsToExclude", "Exclude these words:(no spaces) ", value="kes,give,spent,buying,remaining,pay,paid,bought,buy,also,kept,amount,join,transfer,airtime,take,will,use,made,can,get,since,given,now,able,"),
      submitButton(text="Update", icon=NULL),
      hr(),
    sliderInput("max","Maximum Number of Words:",
                  min = 1,  max = 30,  value = 22),
 	tags$div(class = "header", checked = NA,
               tags$a(href="https://docs.google.com/spreadsheets/d/1umh464Da62x6gY5zuEzlYa4Q2Fiq9igW78CQhVrGTtU/edit#gid=1770330013", "Raw Data Download"))),

    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )))