library(dplyr)
library(ggplot2)
library(stringr)
library(shiny)
library(plotly)
library(maps)

source("analysis.r")
df <- read.csv("final_df.csv")

intro_pg <- tabPanel("Background",
                     fluidPage(
                       img(src = "https://workplaceservices.fidelity.com/bin-public/070_NB_PreLogin_Pages/images/uw_hero_cherryblossoms.png"),
                       h1("Are College Campus's really THAT safe?"),
                       
                       p("For students, parents, and teachers in recent years, campus safety has become an increasingly urgent worry, and 
                         for good reason. The rise in campus shootings and other violent crimes has brought the safety of universities into 
                         question, forcing us to examine whether these are truly safe places to live and study. That's why our project aims to 
                         provide a comprehensive analysis of the safety of universities by comparing their crime rates with those of their 
                         surrounding areas."),
                       
                       p("We won't stop at just looking at the numbers. Our project delves deeper, examining different types of crimes
                         , including theft, assault, sexual offenses, and focusing in on rapes. We will analyze crime statistics and reports 
                         from various universities across the United States, comparing the crime rates in universities with the overall crime rates
                         of their respective states. By doing so, we will provide a data-driven analysis of the safety of universities that goes 
                         beyond just the numbers."),
                       
                       p("Our mission is to empower individuals to make informed decisions about their safety and well-being while attending university.
                         We want to spark a conversation about campus safety and encourage universities to prioritize the safety of their students and 
                         faculty. By examining the measures universities are taking to address campus safety, we can identify best practices that other
                         universities can adopt. Our project aims to highlight the effectiveness of safety measures and identify areas where
                         improvements are needed."),
                       
                       p("In conclusion, our project about the safety of universities is a timely and crucial topic that demands attention. By providing 
                         a comprehensive analysis of the safety of universities and their surrounding communities, we hope to empower individuals to make
                         informed decisions about their safety and well-being while attending university. Ultimately, we believe that by highlighting the
                         importance of campus safety, we can help universities create safer environments for their students and faculty, paving the way 
                         for a brighter future.")
                     )
                     
)


compare_pg <- tabPanel("Compare",
                          fluidPage(
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons(
                                  inputId = "compare_data",
                                  label = "Select One:",
                                  choices = list("US" = 0, "College Campus" = 1),
                                  selected = 0
                                ),
                                
                                selectInput(
                                  inputId = "compare_crime",
                                  label = "Select a crime:",
                                  choices =  names(df)[12:17],
                                  selected = names(df)[12]
                                )
                              ),
                              mainPanel(
                                h3("Question: What are the crime rates for different crimes, either in overall crime rates in the state or specifically on college campuses?"),
                                plotOutput("barchart"),
                                h3("What does this question help us understand?"),
                                p("The question answered by the graph enables a comprehensive understanding of crime rates for a specific crime type across different states, 
                                  differentiating between overall state crime rates and crime rates on college campuses. It facilitates public safety, informs resource allocation
                                  and policy development, identifies trends and patterns, enables comparative analysis, and drives the implementation of effective prevention and 
                                  intervention strategies. Ultimately, it contributes to creating safer communities and promoting the well-being of individuals within those communities."),
                                h3("Key Takeaways:"),
                                p("- Rape and Aggravated Assault crime rates are higher across all states when looking at College Campus's"),
                                p("- This indicates that college campuses may experience a higher incidence of these specific crimes compared to the surrounding communities or the state as a whole."),
                                p("- The findings suggest the need for increased attention and preventive measures to address the safety and security concerns on college campuses, particularly in relation to sexual assault and aggravated assault.")
                              )
                            )
                          )
                          
)

factors_pg <- tabPanel("Factors",
                       fluidPage(sidebarLayout(
                         sidebarPanel(
                           selectInput(
                             inputId = "factors_crime",
                             label = "Select a crime:",
                             choices =  names(df)[12:17],
                             selected = names(df)[12]
                           )

                         ),
                         mainPanel(
                           h3("Question: What is the distribution of selected crime rates on campuses in each state?"),
                           plotlyOutput("factors"),
                           h3("What does this question help us understand?"),
                           p("This pie chart provides valuable insights into the distribution and prevalence of different types of crimes. By visually comparing the proportions of crime categories, 
                             we can identify which crimes have higher or lower rates on campuses in the selected state. The chart helps us understand the most prevalent crimes as well as those with
                             lower occurrence rates, shedding light on patterns and potential disparities in their distribution among different campuses. This information enables stakeholders to focus
                             prevention efforts on areas of concern and prioritize campus security measures. The interactive nature of the chart allows for comparative analysis, facilitating the
                             identification of regional or campus-specific variations in crime prevalence and highlighting areas for improvement or successful prevention strategies. Ultimately, 
                             this question and the resulting interactive pie chart contribute to a better understanding of the distribution and prevalence of selected crime rates, aiding in informed
                             decision-making and the promotion of safer campus environments."),
                           h3("Key Takeaways:"),
                           p("- The chart provides a visual representation of the distribution of selected crime rates, showing the relative proportions of different crime categories. This helps
                             identify which crimes are more prevalent or less prevalent on campuses within the selected state."),
                           p("- The chart highlights the crime categories with larger proportions, indicating the most prevalent crimes on campuses. This information can guide resource allocation
                             and prevention efforts to address the most significant concerns.")
                         )
                       )
                       )
)

drilldown_pg <- tabPanel("Drill Down",
                         fluidPage(
                           sidebarLayout(
                             sidebarPanel(
                               radioButtons(
                                 inputId = "data_map",
                                 label = "Select One:",
                                 choices = list("All" = 0, "West" = 1, "Washington" = 2),
                                 selected = 0 
                               ),
                               selectInput(
                                 inputId = "map_crime",
                                 label = "Select a crime:",
                                 choices =  names(df)[12:17],
                                 selected = names(df)[12]
                               )
                             ),
                             mainPanel(
                               h3("Question: What are the geographic variations in the crime rates of a specific crime across different regions or states in the United States?"),
                               plotOutput("map"),
                               h3("What does this question help us understand?"),
                               p("This map helps us understand the spatial distribution and regional disparities in the selected crime's prevalence. By visualizing crime rates on a map, we can gain insights into which areas have higher or lower rates of the specific offense, highlighting hotspots and regions with potential crime challenges. This information is crucial for understanding the spatial dynamics of crime and can guide resource allocation, law enforcement strategies, and policy decisions. Additionally, the map enables users to identify patterns and trends, such as higher crime rates in urban centers or variations between states or regions. These insights can inform targeted interventions, allocation of law enforcement resources, and the development of preventive measures tailored to specific geographic areas. Overall, the question helps us grasp the spatial nature of crime and supports evidence-based decision-making to enhance public safety and address crime-related issues effectively."),
                               h3("Key Takeaways:"),
                               p("- The map highlights the regional variations in crime rates for the selected offense, allowing users to identify areas with higher or lower rates. This information helps understand the geographical distribution of the specific crime across the US."),
                               p("- The map identifies regions with higher crime rates for the selected offense. These areas may require targeted interventions, increased law enforcement presence, or specialized crime prevention strategies.")
                             )
                           )
                         )
)


summary_pg <- tabPanel("Summary",
                       fluidPage(
                         h1("Summary"),
                         h2("The Crime Analysis Project: Understanding Safety on College Campuses"),
                         p("Our project aims to provide a comprehensive analysis of the safety of universities by comparing their crime rates with those of their surrounding areas. We delve deeper into different types of crimes, including theft, assault, sexual offenses, and specifically focus on rape. By analyzing crime statistics and reports from various universities across the United States, we offer a data-driven analysis that goes beyond just the numbers."),
                         p("Our mission is to empower individuals to make informed decisions about their safety and well-being while attending university. We want to spark a conversation about campus safety and encourage universities to prioritize the safety of their students and faculty. By examining the measures universities are taking to address campus safety, we can identify best practices that other universities can adopt. Our project aims to highlight the effectiveness of safety measures and identify areas where improvements are needed."),
                         p("This project is a timely and crucial topic that demands attention. By providing a comprehensive analysis of the safety of universities and their surrounding communities, we hope to empower individuals to make informed decisions about their safety and well-being while attending university. Ultimately, we believe that by highlighting the importance of campus safety, we can help universities create safer environments for their students and faculty, paving the way for a brighter future."),
                         h2("Datasets used:"),
                         tags$ul(
                           tags$li("FBI's Uniform Crime Reporting (UCR) Program - Crime in the United States, Offense and Population Percent Distribution by Region, 2018"),
                           tags$a(href = "https://ucr.fbi.gov/crime-in-the-u.s/2018/crime-in-the-u.s.-2018/downloads/download-printable-files", "View dataset for Crimes in the US in 2018"),
                           tags$li(" U.S. Department of Education's Campus Safety and Security (CSS) Program - Campus Safety and Security Data"),
                           tags$a(href = "https://ope.ed.gov/campussafety/#/datafile/list", "View dataset for Crimes on College Campuses")
                         ),
                         
                         h2("Background Research/Inspiration:"),
                         tags$ul(
                           tags$li(tags$a(href = "https://www.safewise.com/blog/safest-college-towns-america/", "The Top 10 Safest Colleges in America in 2021")),
                           tags$li(tags$a(href = "https://www.usnews.com/education/best-colleges/applying/articles/college-campus-safety-questions-to-ask", "College Campus Safety: Questions to Ask")),
                           tags$li(tags$a(href = "https://www.insidehighered.com/news/2022/06/22/survey-campuses-perceived-safe-some-students-not-all", "Students Mostly Feel Safe on College Campuses, but Not Equally So"))
                         ),
                         h3("By: Nicole Zhou and Neda Bokhari"),
                       ))


ui <- navbarPage("Saftey on Campus",
                 tags$head(
                   tags$style(HTML("
                     /* Change the navbar color */
                     .navbar {
                       background-color: #ACBAA9;
                       color: #5C4033;
                     }
                     /* Change the font family */
                     body {
                       font-family: quicksand;
                     }
                     
                     /* Change the font color */
                     h1, h2, h3, p {
                       color: #013220;
                     }
                   "))
                 ),
                 intro_pg,
                 compare_pg,
                 factors_pg,
                 drilldown_pg,
                 summary_pg
)

# Define server logic
server <- function(input, output) {
  
  output$barchart <- renderPlot({
    barchart <- barplot_crime(df, input$compare_data, input$compare_crime)
    return(barchart)
  })
  
  output$factors <- renderPlotly({
      selected_crime <- input$factors_crime
      piechart <- piechart_crime(df, selected_crime)
      return(piechart)
  })
  
  output$map <- renderPlot({
    us_map <- plot_map(df, input$data_map, input$map_crime)
    return(us_map)
  })

}

# Run the application
shinyApp(ui = ui, server = server)