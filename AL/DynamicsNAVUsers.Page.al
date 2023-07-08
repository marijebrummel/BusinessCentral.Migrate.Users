page 88888 "PTE Dynamics NAV Users"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PTE Dynamics NAV User";
    Caption = 'Dynamics NAV Users';
    CardPageId = "PTE Dynamics NAV User";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Activated in Business Central"; Rec."Activated in Business Central")
                {
                    ApplicationArea = All;
                }
                field("Is Super User"; Rec.IsSuperUser())
                {
                    ApplicationArea = All;
                }
                field("Is Enabled"; Rec.IsEnabled())
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ReadFromCSVFile)
            {
                Caption = 'Read from CSV File';
                Image = ExportFile;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.ReadFromCSV();
                end;
            }
        }
    }
}