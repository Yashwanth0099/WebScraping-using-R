# Web Scraping Using R - Mobile DNA
## Overview
This project focuses on web scraping using R to extract, structure, and analyze data from web pages. The goal was to extract publication data, analyze trends, and visualize insights effectively.

## Features
- Web Scraping: Extracted publication data, including titles, authors, abstracts, publish dates, keywords, and corresponding author emails.
- Data Structuring: Combined extracted fields into a structured data frame for analysis.
- Data Analysis: Performed year-wise and month-wise analysis of publication counts using R libraries such as ggplot2.
- Visualizations: Created bar graphs and donut charts for better insights.

## Code Highlights
- HTML Parsing: Used rvest and httr libraries to retrieve and parse HTML content.
- CSS Selectors: Identified target data fields using browser tools like SelectorGadget.
- Custom Functions: Developed reusable functions for extracting abstracts and structuring data.
- Data Frame Creation: Consolidated extracted data into a structured format for further processing.

## Visualizations
- Year-Wise Analysis: Bar graph displaying the number of articles published per year.
- Month-Wise Analysis: Donut chart illustrating monthly publication counts.

## Challenges
- Difficulty in looping through multiple pages for data extraction.
- Challenges in retrieving author-related data (e.g., corresponding emails).
- Addressed parsing issues with the help of additional research and trial-and-error.

## Tools & Libraries
- Libraries Used: rvest, httr, ggplot2, stringr.
- Visualization Tools: Created bar graphs and donut charts to display trends.
