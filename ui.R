library(shiny)
library(shinydashboard)
library(ggplot2)
library(plyr)
library(plotly)
library(DT)
library(ggthemes)

# my data
my_data=read.table("data/sect_dataset.csv", header=T, sep=",")
# changing date to categorical data 
#my_data$Year=factor(my_data$Year)

## Preparing sidebar items
sidebar <- dashboardSidebar(
  width = 250,
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashbd", icon = icon("dashboard")),
    menuItem("Data", tabName = "datafile", icon = icon("th")),
    menuItem("Visualization", icon = icon("navicon"), tabName = "graphs", 
             menuSubItem("Data Explorer for Killed", tabName = "kill", icon = icon("pie-chart")), 
             menuSubItem("Data Explorer for Injured", tabName = "inj", icon = icon("pie-chart"))
    ),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    br(),
    hr(),
    # email sharing link
    menuItem("Feedback & suggestion", icon = icon("envelope-o"),
             href = "mailto:?ow.raza@hotmail.com?subject=Feedback on VAS app"),
    # source code link
    menuItem("Source code", icon = icon("file-code-o"), 
             href = "https://github.com/oraza/sectarianviolencePK"),
    # github fork link
    menuItem("Fork me @ github", icon = icon("code-fork"), 
             href = "https://github.com/oraza/sectarianviolencePK") 
  )
)
## Preparing body items
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashbd",
            fluidRow(
              valueBoxOutput("vbox1", width = 6),
              valueBoxOutput("vbox2", width = 6)),
            h2("Introduction",  align = "center", style = "font-family: 'times'; color:red"),
            p("Shia population is estimated between 5% to 20% of total population of Pakistan. Since last five decades,
              Shia in Pakistan have been targeted by various militant groups. Doctors, lawyers, businessmen, teachers and
              other professionals have been under attacks by various Sunni Muslim militant groups, most prominently", 
              a("Sipah-e-Sahaba", href = "https://en.wikipedia.org/wiki/Sipah-e-Sahaba_Pakistan")," and",
              a("Lashkar-e-Jhangvi.", href="https://en.wikipedia.org/wiki/Lashkar-e-Jhangvi"),"These attacks have
              significantly surged after the end of Afghan War, when local anti-shia milinants came under coaliation with",
              a("Talibans.", href = "https://en.wikipedia.org/wiki/Taliban"), style = "font-family: 'times'"),
            fluidPage(
              fluidRow(
                column(
                  h2("About this app ...", align = "center", style = "font-family: 'times'; color:red"),
                  p("This app helps you to explore and visualize the sectarian violence against Shia community in Pakistan. 
                    I have used the database available", a("here.", href="http://lubpak.com/archives/132675"), 
                    style = "font-family: 'times'"),
                  width = 4,
                  align = "left"
                  
                ),
                column(
                  h2("How to use!", style = "font-family: 'times'; color:red"),
                  p("This app contains two major sections; database and graphs. After cleaning and re-defining type of incident, 
                    two variables were added, i.e, type of government and president at the day of incident. This new 
                    addition was done to explore and understand further relationship of sectarian violence in Pakistan.", 
                    style = "font-family: 'times'"), 
                  p("Section for", strong("data"), "presents the database, which is provided with copying, printing and 
                    downloading options. Section for", strong("visualization"), "has two sub-sections, a. explorer for 
                    people killed & b. explorer for people injured in sectarian violence. In these sub-sections, data is
                    plotted against geo-political regions of Pakistan. Within each sub-section, navigation panel contains four 
                    tabs that plot data points according to the selected tab. Graphs are plotted on an interactive platform,
                    such that when the mouse-pointer hovers over data-point it shows further information. Users can choose to
                    turn off the data-points by clicking on labels given in the legend.", 
                    style = "font-family: 'times'"),
                  width = 8,
                  align = "left"
                ),
                br(),
                br()
                  )
                ),
            br(),
            br(),
            p(strong("Suggested citation:"), "Violnce Against Shia: App for exploring and visualizing sectarian violence
              in Pakistan, 1968 - 2014, Version 1.0,", style = "font-family: 'times'", 
              tags$img(src = "C_thin.png", width = "10px", height = "10px"), "Owais Raza")
    ),  
    tabItem(tabName = "datafile",
            box(title = "Sectarian violence against Shia in Pakistan, 1960-2014",
                width = 12, 
                DT::dataTableOutput('da.tab'))  
    ),
    tabItem(tabName = "kill",
            mainPanel(
              tabsetPanel(
                tabPanel("By President",
                         plotlyOutput("plotPresKill"), width = "auto"),
                tabPanel("By Government", 
                         plotlyOutput("plotGovKill"), width = "auto"),
                tabPanel("By Incident",
                         plotlyOutput("plotInciKill"), width = "auto"),
                tabPanel("By Decade",
                         plotlyOutput("plotDecKill"), width = "auto")))
    ),
    tabItem(tabName = "inj",
            mainPanel(
              tabsetPanel(
                tabPanel("By President",
                         plotlyOutput("plotPresInj"), width = "auto"),
                tabPanel("By Government",
                         plotlyOutput("plotGovInj"), width = "auto"),
                tabPanel("By Incident",
                         plotlyOutput("plotInciInj"), width = "auto"),
                tabPanel("By Decade",
                         plotlyOutput("plotDecInj"), width = "auto")
              )
            )
    )
              )
            )
## Putting them together into a dashboardPage

ui <- dashboardPage( 
  skin="yellow",
  # add this -> navbarMenu()
  dashboardHeader(
    title="Violence Against Shia",
    titleWidth = 250,
    #Facebook Sharing
    tags$li(class = "dropdown",
            tags$a(href = "http://www.facebook.com/sharer.php?u=https://ow-raza.shinyapps.io/sectarianviolencePK/", 
                   target = "_blank", 
                   tags$img(height = "20px", 
                            src = "fb2.png")
            )
    ),
    # Linkedin link
    tags$li(class = "dropdown",
            tags$a(href = "http://www.linkedin.com/shareArticle?mini=true&url=https://ow-raza.shinyapps.io/sectarianviolencePK/", 
                   target = "_blank", 
                   tags$img(height = "20px", 
                            src = "linkedin.png")
            )
    ),
    # Twitter link
    tags$li(class = "dropdown",
            tags$a(href = "http://twitter.com/share?url=https://ow-raza.shinyapps.io/sectarianviolencePK/  &text= my first shiny app @reye27",
                   target = "_blank",
                   tags$img(height = "20px", 
                            src = "twitter.png")
            )
    ),
    # Github link
    tags$li(class = "dropdown",
            tags$a(href = "https://github.com/oraza",
                   target = "_blank",
                   tags$img(height = "20px", 
                            src = "github.png")
            )
    )
  ),
  sidebar,
  body
)