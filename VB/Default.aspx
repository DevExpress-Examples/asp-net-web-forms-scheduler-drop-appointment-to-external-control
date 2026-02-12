<%@ Page Language="VB" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="Default" %>

<%@ Register Src="~/CustomForms/CustomVerticalAppointmentTemplate.ascx"
    TagName="CustomVerticalAppointmentTemplate" TagPrefix="cat" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Untitled Page</title>
        <script type="text/javascript" src="scripts/jquery-1.8.0.min.js"></script>
        <script type="text/javascript" src="scripts/jquery-ui-1.8.23.custom.min.js"></script>
    
        <script type="text/javascript" language="javascript">
            function InitalizejQuery(s, e) {
                $('.draggable').draggable({ helper: 'clone', appendTo: 'body', zIndex: 100 });
                $('.droppable').droppable({
                        activeClass: "dropTargetActive",
                        hoverClass: "dropTargetHover",
                        
                        drop: function (ev, ui) {
                            var appointmentId = $(ui.draggable).find("input[type='hidden']").val();
                            listBox.AddItem(appointmentId);
                            // Additional logic goes here...
                        }
                    }
                );
            }
            function DragPanelHold() {
                // disable built-in dragging logic
                setTimeout('scheduler.mouseHandler.SwitchToDefaultState();', 0);
            }
        </script>
    
        <style type="text/css">
            .dropTargetActive {
                border: solid 5px red;
            }
            .dropTargetHover {
                border: solid 5px yellow;
            }
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td style="width: 200px;">
                    <div class="droppable">
                        <dx:ASPxListBox ID="ASPxListBox1" runat="server"  ClientInstanceName="listBox">
                            <Items>
                                <dx:ListEditItem Text="Drop appointments here" Value="Drop appointments here" />
                            </Items>
                        </dx:ASPxListBox>
                    </div>
                </td>
                <td>
                    <dx:ASPxScheduler ID="ASPxScheduler1" runat="server" ClientInstanceName="scheduler" OnAppointmentInserting="ASPxScheduler1_AppointmentInserting">
                        <Views>
                            <DayView>
                                <Templates>
                                    <VerticalAppointmentTemplate>
                                        <cat:CustomVerticalAppointmentTemplate ID="CustomVerticalAppointmentTemplate1" runat="server" />
                                    </VerticalAppointmentTemplate>
                                </Templates>
                                <DayViewStyles ScrollAreaHeight="300px" />
                            </DayView>
                        </Views>
                    </dx:ASPxScheduler>
                </td>
            </tr>
        </table>

        <asp:ObjectDataSource ID="appointmentDataSource" runat="server" DataObjectTypeName="CustomEvent"
            TypeName="CustomEventDataSource" DeleteMethod="DeleteMethodHandler" SelectMethod="SelectMethodHandler"
            InsertMethod="InsertMethodHandler" UpdateMethod="UpdateMethodHandler" OnObjectCreated="appointmentsDataSource_ObjectCreated">
        </asp:ObjectDataSource>
        
        <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
            <ClientSideEvents ControlsInitialized="InitalizejQuery" EndCallback="InitalizejQuery" />
        </dx:ASPxGlobalEvents>
    </form>
</body>
</html>
