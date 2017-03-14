#read survey
#strip off questions, create corpus from them
#correct logical, numeric
#add short header
#return  corpusQ, data

library(SnowballC)
library(shiny)
library(tm)
library(wordcloud)

doDebug <- F

getQuestions <- function(data, questionNumber=NULL) {
	questions <- theQuestions[1,questionNumber]
	questions <- tolower(questions)
	questions <- paste(questions, sep=" ", collapse=" ") 
	questions <- strsplit(questions,split=" ")
	questions <- unlist(questions)
	return(questions)
	}

getCorpusQ <- function(questions){	
	corpusQ <- Corpus(VectorSource(questions))
	corpusQ <- tm_map(corpusQ,  content_transformer(tolower))
	corpusQ <- tm_map(corpusQ, removePunctuation)
	return(corpusQ)
	}	
changeYesNoToTFNA <- function(dataField){
	dataField[dataField =="Yes"] <- T
	dataField[dataField =="No"] <- F
	dataField[dataField =="Doesn't know or prefers not to say"] <- "NA"
	dataField <- as.logical(dataField)
	return(dataField)
}

frequencies <- function(words){
	corpus <- Corpus(VectorSource(words))    
	dtm <- TermDocumentMatrix(corpus)
	m <- as.matrix(dtm)
	v <- sort(rowSums(m),decreasing=TRUE)
	d <- data.frame(word = names(v),freq=v)
	return(d)
}

trimCorpus <- function(corpusQ, noNumbers, noQuestions, wordsToExclude = "") {

	corpusD <- tm_map(corpus, content_transformer(tolower))
	if (noNumbers) 
		corpusD <- tm_map(corpusD, removeNumbers)
	if (noQuestions) 
		corpusD <- tm_map(corpusD, removeWords, corpusQ[]$content)	
	corpusD <- tm_map(corpusD, removeWords, wordsToExclude)
	corpusD <- tm_map(corpusD, removeWords,stopwords("en"))	
	corpusD <- tm_map(corpusD, removePunctuation)
	return(corpusD)
	}

createCorpusDF <- function(corpusD) {
	corpusDF <- data.frame(text = get("content", corpusD))
	row.names(corpusDF) <- columnHeaders
	return(corpusDF)
}

data <- read.csv("data/basicIncome.csv", as.is=T, header=F)
data <- data[,-4]
theQuestions <- data[1,]
names(theQuestions) <- data[1,]

#remove header
data <- data[-1,]
#create header
names(data) <- c("name","age","biggestDifference","familyInteractL","howInteract","howSpent","forProjects","changeFeelWork","whyToIndividual","problemToIndividual","howLongPayments","trustPayments","trustAffectedLifePlans")


#change yes/no questions to T F NA
data$trustPayments <- changeYesNoToTFNA(data$trustPayments)
data$familyInteractL <- changeYesNoToTFNA(data$familyInteractL)
data$age <- as.numeric(data$age)
data$howLongPayments <- as.numeric(data$howLongPayments)

columnHeaders <- names(data)
numResponses <- nrow(data)
corpus <- Corpus(VectorSource(data))

#debugging
if (F){
	wordsToRemove <- c("mary,george,joyce")
	excludeWords <- unlist(strsplit(wordsToRemove,","))
	
	theQuestion <- theQuestions[2]
	noNumbers <- F
	noQuestions <- F
	wordsToExclude <- c("difference", "biggest")
	questionNumber <- match(theQuestion, theQuestions)
	corpusQ <- getCorpusQ(getQuestions(data,questionNumber))
	corpusD <- trimCorpus(corpusQ,noNumbers, noQuestions,excludeWords)
	corpusDF <- createCorpusDF(corpusD)
	frequencies(as.character(corpusDF[2,1]))
	if (is.numeric(data[,questionNumber]))
		hist(data[,questionNumber],main=theQuestion,xlab="",col=brewer.pal(8, "Dark2"))
	else
		wordcloud(corpusDF[questionNumber, ])
	}
