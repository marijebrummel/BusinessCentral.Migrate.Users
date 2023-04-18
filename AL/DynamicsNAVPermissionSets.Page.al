page 88890 "PTE Dynamics NAV Perm. Sets"
{
    PageType = ListPart;
    SourceTable = "PTE Dynamics NAV Perm. Set";
    Caption = 'Lines';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field("Permission Set"; Rec."Permission Set")
                {
                    ApplicationArea = All;

                }
                field("Exists in Business Central"; Rec."Exists in Business Central")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}