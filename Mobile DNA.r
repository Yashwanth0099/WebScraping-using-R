install.packages("rvest")
install.packages("dplyr")
install.packages("xml2")
install.packages("httr")
install.packages("stringr")
install.packages("ggplot2")

library(rvest)
library(dplyr)
library(xml2)
library(httr)
library(stringr)
library(ggplot2)

get_abstract<- function(journal_link) {
  journal_page <- read_html(journal_link)
  abst <- journal_page %>% html_nodes("#Abs1-content p") %>%
    html_text() %>% paste(collapse = ",")
  return(abst)
}
get_date<- function(journal_link) {
  journal_page <- read_html(journal_link)
  journal_date <- journal_page %>% html_nodes(".c-article-identifiers__item time") %>%
    html_text() %>% paste(collapse = ",")
  return(journal_date)
}

get_corauthor<- function(journal_link) {
  journal_page <- read_html(journal_link)
  corauth <- journal_page %>% html_nodes("#corresponding-author-list") %>%
    html_text() %>% paste(collapse = ",")
  a<-sub("^\\s*Correspondence to\\s*","",corauth)  #removes coresspond to from the column
  return(a)
}

get_keywords <- function(journal_link) {
  journal_page <- read_html(journal_link)
  keywrd <- journal_page %>% html_nodes(".c-article-subject-list__subject a") %>%
    html_text() %>% paste(collapse = ",")
  return(keywrd)
}


get_email <- function(journal_link) {
  journal_page <- read_html(journal_link)
  email_full <- journal_page %>% html_nodes("#corresponding-author-list a") %>%
    html_attr("href")  %>% paste(collapse = ",")
  el <- sub("^mailto:", "", email_full)#cleaning the email id removes mailto:
  em = gsub("mailto:", "",el)#cleaning the email id removes mailto:
  return(em)
}

df<-data.frame()

for(page in seq(from =1,to =9)){
  url<-paste0("https://mobilednajournal.biomedcentral.com/articles?searchType=journalSearch&sort=PubDate&page=",page,"&ref_=adv_nxt")
  journal<-read_html(url)
  title<-journal %>% html_nodes(".c-listing__title a") %>% html_text() 
  authors<-journal %>% html_nodes(".c-listing__authors-list") %>% html_text()
  journal_links<- journal %>% html_nodes(".c-listing__title a") %>% 
    html_attr("href") %>% paste("https://mobilednajournal.biomedcentral.com", ., sep = "")
  Abstract <- sapply(journal_links,FUN = get_abstract,USE.NAMES = FALSE)
  publish_date <- sapply(journal_links,FUN = get_date,USE.NAMES = FALSE)
  Keywords <- sapply(journal_links,FUN = get_keywords,USE.NAMES = FALSE)
  
  email <- sapply(journal_links,FUN = get_email,USE.NAMES = FALSE)
  
  corr_author <- sapply(journal_links,FUN = get_corauthor,USE.NAMES = FALSE)
  df<-rbind(df,data.frame(title,authors,Abstract,publish_date,Keywords,email,corr_author))
}
View(df)

#write above dataframe in a file
write.csv(df,file="C:\\Users\\tejal\\OneDrive\\Desktop\\ds636class\\data3.csv")

#read the above dataframe from the file
data<-read.csv("C:\\Users\\tejal\\OneDrive\\Desktop\\ds636class\\data3.csv")

#get the date from a column called publish date
date <- data$publish_date

#get only the year part
year <- gsub(".*([0-9]{4})", "\\1", date)

# Create a frequency table of years
year_counts <- as.data.frame(table(year))

# Rename columns for clarity
colnames(year_counts) <- c("Year", "Count")

# Convert Year column to numeric (if necessary)
year_counts$Year <- as.numeric(as.character(year_counts$Year))



#year vs count
ggplot(year_counts, aes(x = Year, y = Count,fill = Count)) +
  geom_bar(stat = "identity")+ 
  labs(title = "Year Counts", x = "Year", y = "Count")+
  scale_fill_gradient(low = "#ABABD9", high = "#800080", limits = c(min(year_counts$Count), max(year_counts$Count)))
#=========================================================================


# Extract month names from the date variable
month <- str_extract(date, "\\b[A-Za-z]+\\b")

# Create a frequency table of months and convert it to a data frame
month_counts <- as.data.frame(table(month))


# Rename columns for clarity
names(month_counts) <- c("Month", "Count")  

month_counts$Month <- factor(month_counts$Month,
                             levels = c("January", "February", "March", "April", "May", "June",
                                        "July", "August", "September", "October", "November", "December"),
                             ordered = TRUE)



library(viridis)  # Load the viridis package

# Create the donut chart
donut_chart <- ggplot(month_counts, aes(x = "", y = Count, fill = Month)) +
  geom_bar(width = 1, stat = "identity") +
  geom_text(aes(label = Count), position = position_stack(vjust = 0.5), color = "red", size = 5) +  # Add data labels
  coord_polar("y", start = 0) +
  #scale_fill_viridis(discrete = TRUE) +  # Use viridis color palette
  theme_void() +
  labs(fill = "Month") +
  theme(legend.position = "right")  # Adjust legend position as needed

# Render the plot
print(donut_chart)

















