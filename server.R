#input data

shinyServer(function(input, output, session) {
	output$value <- renderText({ input$wordsToExclude })
	excludeWords <- reactive(unlist(strsplit(input$wordsToExclude,",")))

	questionNumber <- reactive(match(input$theQuestion, theQuestions))
	corpusQ <- reactive(getCorpusQ(getQuestions(data,questionNumber())))
	corpusD <- reactive(trimCorpus(corpusQ(),FALSE, input$noQuestions,excludeWords()))
	corpusDF <- reactive(createCorpusDF(corpusD()))
	
	output$plot <- renderPlot({
		if (is.numeric(data[,questionNumber()]))
			#boxplot(data[,questionNumber()])
			hist(data[,questionNumber()],main=input$theQuestion,xlab="",
						col=brewer.pal(8, "Dark2"))

		else
			wordcloud(corpusDF()[questionNumber(), ],scale=c(4,0.5),
                   max.words=input$max,colors=brewer.pal(8, "Dark2"))
	})
})