page 88889 "PTE Dynamics NAV User"
{
    PageType = Card;
    SourceTable = "PTE Dynamics NAV User";
    Caption = 'Dynamics NAV User';
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Main)
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
            part(Lines; "PTE Dynamics NAV Perm. Sets")
            {
                ApplicationArea = All;
                SubPageLink = "Full Name" = field("Full Name");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(UserCard)
            {
                ApplicationArea = All;
                Caption = 'User Card';
                Image = User;
                RunObject = page "User Card";
                RunPageLink = "Full Name" = field("Full Name");
            }
        }
        area(Processing)
        {
            action(EnableDisable)
            {
                Caption = 'Change Enabled or Disabled';
                Image = RemoveContacts;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.EnableDisable();
                end;
            }
            action(AssignPermissions)
            {
                Caption = 'Assign Permissions';
                Image = Permission;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.AssignPermission();
                end;
            }
        }
    }
}