
# Reading data set
my_data=read.table("C:/Users/Owais/Dropbox/R/Shinyapps/sectarianviolencePK/sectarianviolencePK/data/sect_dataset.csv", header=T, sep=",")
my_data$Decade=as.factor(my_data$Decade)




server <- function(input, output) {
  ## stuffs for dashboard tab
  output$vbox1 <- renderValueBox({ 
    valueBox(
      "Attacks: 1,098",
      input$count,
      color = "orange",
      icon = icon("empire"))
  })
  output$vbox2 <- renderValueBox({ 
    valueBox(
      "Target Killing: 5,912",
      input$count,
      color = "red",
      icon = icon("bullseye")
    )
  })
  ## stuffs for data tab
  # data table output
  output$da.tab <- DT::renderDataTable(datatable(my_data, extensions = 'Buttons',
                                                 style = "bootstrap",
                                                 filter = list(position = 'top', clear = T, plain = F),
                                                 options = list(pageLength = 1500, dom = 'Bfrtip', 
                                                                buttons = 
                                                                  list('copy', 'print', list(
                                                                    extend = 'collection',
                                                                    buttons = c('csv', 'excel', 'pdf'), 
                                                                    text = 'Download')
                                                                  )
                                                 )
  )
  )
  ## stuffs for data explorer
  # for tab: Killed
  output$plotPresKill <- renderPlotly({
    # build graph with ggplot syntax
    p1 <- ggplot(my_data, color = President) + 
      geom_jitter(aes(Killed, Province, color = President),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p1)
  })
  output$plotGovKill <- renderPlotly({
    p2 <- ggplot(my_data, color = Government) + 
      geom_jitter(aes(Killed, Province, color = Government),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p2)
  })
  output$plotInciKill <- renderPlotly({
    p3 <- ggplot(my_data, color = Incident) + 
      geom_jitter(aes(Killed, Province, color = Incident),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p3)
  })
  output$plotDecKill <- renderPlotly({
    p4 <- ggplot(my_data, color = Decade) + 
      geom_jitter(aes(Killed, Province, color = Decade),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p4)
  })
  # for tab: Injured
  output$plotPresInj <- renderPlotly({
    # build graph with ggplot syntax
    p5 <- ggplot(my_data, color = President) + 
      geom_jitter(aes(Injured, Province, color = President),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p5)
  })
  output$plotGovInj <- renderPlotly({
    p6 <- ggplot(my_data, color = Government) + 
      geom_jitter(aes(Injured, Province, color = Government),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p6)
  })
  output$plotInciInj <- renderPlotly({
    p7 <- ggplot(my_data, color = Incident) + 
      geom_jitter(aes(Injured, Province, color = Incident),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p7)
  })
  output$plotDecInj <- renderPlotly({
    p8 <- ggplot(my_data, color = Decade) + 
      geom_jitter(aes(Injured, Province, color = Decade),
                  show.legend = T, 
                  inherit.aes = T, 
                  width = 0.2, 
                  height = 0.5,
                  size = 2,
                  alpha =0.5) + 
      ggthemes::theme_fivethirtyeight() + scale_colour_gdocs()
    
    ggplotly(p8)
  })
  ## stuffs for data comparison
  output$OutPlot3 <- renderPlot({
    p <- ggplot(my_data, aes(x=Killed, y=reorder(Province, Killed))) + 
      geom_segment(aes(yend = reorder(Province, Killed)), xend =0, colour = "grey50") +
      geom_point(size=3, aes(colour = Incident), alpha =0.5) +
      theme_bw() + 
      theme(panel.grid.major.y = element_line()) +
      facet_grid(Government ~ .)
    p
  })
}

