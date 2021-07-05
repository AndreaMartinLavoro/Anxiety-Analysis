url <- "dataset/dataset.csv"
myData <- read.csv(url)

summary(myData)
str(myData$text)
dim(myData)
nrow(myData)
ncol(myData)
names(myData)
class(myData)
head(myData,7)

myData[, c('subreddit', 'post_id', 'text', "id", "confidence", "sentiment")]

write.csv(myData[, c('subreddit', 'post_id', 'text', "id", "sentiment")],'dataset/dataset_cleaned.csv')

myData[, c('text')]

write.csv(myData[, c('text')],'dataset/dataset_for_textmining.txt')

# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
install.packages("syuzhet") # for sentiment analysis
install.packages("ggplot2") # for plotting graphs
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("syuzhet")
library("ggplot2")

# Read the text file from local machine , choose file interactively
text <- readLines("dataset/dataset_for_textmining.txt")#file.choose() - per scegliere interattivamente il file
# Load the data as a corpus
TextDoc <- Corpus(VectorSource(text))

#Replacing "/", "@" and "|" with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
TextDoc <- tm_map(TextDoc, toSpace, "/")
TextDoc <- tm_map(TextDoc, toSpace, "@")
TextDoc <- tm_map(TextDoc, toSpace, "\\|")
# Convert the text to lower case
TextDoc <- tm_map(TextDoc, content_transformer(tolower))
# Remove numbers
TextDoc <- tm_map(TextDoc, removeNumbers)
# Remove english common stopwords
TextDoc <- tm_map(TextDoc, removeWords, stopwords("english"))
# Remove your own stop word
# specify your custom stopwords as a character vector
TextDoc <- tm_map(TextDoc, removeWords, c("s", "company", "team")) 
# Remove punctuations
TextDoc <- tm_map(TextDoc, removePunctuation)
# Eliminate extra white spaces
TextDoc <- tm_map(TextDoc, stripWhitespace)
# Text stemming - which reduces words to their root form
TextDoc <- tm_map(TextDoc, stemDocument)

# Build a term-document matrix
TextDoc_dtm <- TermDocumentMatrix(TextDoc)
dtm_m <- as.matrix(TextDoc_dtm)
# Sort by descearing value of frequency
dtm_v <- sort(rowSums(dtm_m),decreasing=TRUE)
dtm_d <- data.frame(word = names(dtm_v),freq=dtm_v)
# Plot the most frequent words
barplot(dtm_d[30:40,]$freq, las = 2, names.arg = dtm_d[30:40,]$word,
        col ="lightgreen", main ="Top 5 most frequent words",
        ylab = "Word frequencies")

#generate word cloud
set.seed(1234)
wordcloud(words = dtm_d$word, freq = dtm_d$freq, min.freq = 5,
          max.words=100, random.order=FALSE, rot.per=0.40, 
          colors=brewer.pal(8, "Dark2"))

tail(myData,7)

# che tipologie di ansia, quante ?
dataForGen = data.frame(myData[, c('subreddit')])
save(dataForGen, file="dataForGen.RData")
load("dataForGen.RData")
head(dataForGen,100)
colnames(dataForGen)

i = 0
lung = nrow(dataForGen)
for (i in lung : (i + 1)){
  if(dataForGen[i,1]=="survivorsofabuse")
    c = c+1
}
print(c)

anxiety = 0
stress = 0
domesticviolence = 0
assistance = 0
relationships = 0
survivorsofabuse = 0
ptsd = 0
homeless = 0
i = 0
lung = nrow(dataForGen)
for (i in lung : (i + 1)){
  if(dataForGen[i,1]=="anxiety"){anxiety = anxiety+1}
  if(dataForGen[i,1]=="stress"){stress = stress+1}
  if(dataForGen[i,1]=="domesticviolence"){domesticviolence = domesticviolence+1}
  if(dataForGen[i,1]=="assistance"){assistance = assistance+1}
  if(dataForGen[i,1]=="relationships"){relationships = relationships+1}
  if(dataForGen[i,1]=="survivorsofabuse"){survivorsofabuse = survivorsofabuse+1}
  if(dataForGen[i,1]=="ptsd"){ptsd = ptsd+1}
  if(dataForGen[i,1]=="homeless"){homeless = homeless+1}
}
matrice = matrix(c(anxiety, stress, domesticviolence, assistance, relationships, survivorsofabuse, ptsd, homeless),ncol = 1
)

matrice <- sort(rowSums(matrice),decreasing=TRUE)

rownames(matrice) = c("anxiety", "stress", "domesticviolence", "assistance", "relationships", "survivorsofabuse", "ptsd", "homeless")
par(las=2)
barplot(matrice[,1], main="Frequnza degli argomenti", horiz=TRUE,
        names.arg=c("anxiety", "stress", "domesticviolence", "assistance", "relationships", "survivorsofabuse", "ptsd", "homeless"))

#crea il dataset.csv da utilizzare con lo sketch in processing per generare un opera
write.csv(myData[, c('subreddit')],'gen_art/dataset_for_genart.csv')


#sentiment anlysis - grazie a queste analisi metodologiche si riesce a capire il Sentiment degli utenti rispetto al brand in un dato periodo temporale e in un contesto definito.

library(ggplot2)
url <- "dataset/dataset_cleaned.csv"
dati <- read.csv(url)
frame <- as.data.frame.matrix(dati)

ggplot(data = frame) + geom_point(mapping = aes(x = sentiment, y = subreddit))
