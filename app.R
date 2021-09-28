library(shiny)
library(lab5package)

val = val2014()

ui = fluidPage(
    titlePanel("2014 Swedish election: county results"),
    sidebarLayout(
        sidebarPanel(
            selectInput(
                "county",
                "County:",
                choices = c(
                    "Blekinge",
                    "Dalarna",
                    "Gotland",
                    "Gavleborg",
                    "Halland",
                    "Jamtland",
                    "Jonkoping",
                    "Kalmar",
                    "Kronoberg",
                    "Norrbotten",
                    "Skane",
                    "Stockholm",
                    "Sodermanland",
                    "Uppsala",
                    "Varmland",
                    "Vasterbotten",
                    "Vasternorrland",
                    "Vastmanland",
                    "vastergotland",
                    "Orebro",
                    "Ostergotland"
                )
            ),
            hr(),
            helpText("Source: Valmyndigheten (2014)")
        ),
        mainPanel(
           plotOutput("countyPlot")
        )
    )
)

server = function(input, output) {
    output$countyPlot = renderPlot({
        selectCounty = val$county(input$county)
        bp = barplot(
            selectCounty,
            main = input$county,
            xlab = "Political party",
            ylab = "Percent",
            ylim = c(0, 50),
            col = c("#66BEE6", "#63A91D", "#3399FF", "#1B5CB1", "#FF0000",
                    "#C40000", "#008000", "#4E83A3", "#cd0067", "grey")
        )
        axis(2, seq(0, 50, 5))
        text(bp, 0, format(round(selectCounty, 2), nsmall = 2), pos = 3)
    })
}

shinyApp(ui = ui, server = server)
