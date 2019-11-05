$dashboard = New-UDDashboard -title "Calendar" -Content {
    New-UDCard -Id "ButtonCard" -Title "Buttons" -titlealignment "center" -Content {
        $date = get-date #initial date
        
        #Add a calendar, which starts on selected yesterday. and shows a modal on the selected day.
        New-UDCalendar -id "Calendarbois" -onChange {
            #run the eventData variable through the Out-UDCalDate to turn it into a DateTime type. 
            $date = $eventData | Out-UDCalDate
            if ($date -is [datetime]) {
                Show-UDToast $date
            }
        } -StartView $date.AddDays(-1)
    }

    New-UDButton -Text "GetDate" -OnClick {
        #Get-UDCalElement returns a preformatted DateTime object, instead of manually formatting it yourself.
        $stuff = "Calendarbois" | Get-UDCalElement

        if ($stuff -is [datetime]) {
            Show-UDToast $stuff
        }
    }

    New-UDButton -Text "OtherGetDate" -OnClick {
        #Get-UDCalElement returns a preformatted DateTime object, instead of manually formatting it yourself.
        Show-UDToast [datetime](get-udelement -id "Calendarbois").Attributes.date
        
    }
}

Start-UDDashboard -Dashboard $dashboard -Port 8083