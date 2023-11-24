<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128546684/15.2.5%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/E4708)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->

# Scheduler for ASP.NET Web Forms - How to drop an appointment from Scheduler to an external control
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/128546684/)**
<!-- run online end -->

This example demonstrates how to drag and drop appointment info from [ASPxScheduler](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxScheduler.ASPxScheduler) to an outside area. 

![](scheduler-with-external-drop-area.png)

## Implementation Details

The built-in drag-and-drop functionality in the **ASPxScheduler** can conflict with a custom implementation. To resolve the conflict, add a `div` element (drag panel) to an appointment template and disable the built-in drag-and-drop functionality in its `onmousedown` event handler.

```aspx
<div class="draggable" style="background: blue;" onmousedown="DragPanelHold();">
```

```js
function DragPanelHold() {
    // disable built-in dragging logic
    setTimeout('scheduler.mouseHandler.SwitchToDefaultState();', 0);
}
```

Attach the [Draggable](https://jqueryui.com/draggable/) jQuery interaction to the drag panel so that it can be dragged. Attach the [Droppable](https://jqueryui.com/droppable/) jQuery interaction to a drop target - a`div` element with the [ASPxListBox](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxListBox) inside.

```aspx
<div class="droppable">
	<dx:ASPxListBox ID="ASPxListBox1" runat="server"  ClientInstanceName="listBox">
	    <Items>
	        <dx:ListEditItem Text="Drop appointments here" Value="Drop appointments here" />
	    </Items>
	</dx:ASPxListBox>
</div>
```

```js
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
```

Call the `InitalizejQuery` method in the [ASPxGlobalEvents.ControlsInitialized](https://docs.devexpress.com/AspNet/js-ASPxClientGlobalEvents.ControlsInitialized) and [ASPxGlobalEvents.EndCallback](https://docs.devexpress.com/AspNet/js-ASPxClientGlobalEvents.EndCallback) event handlers.

```aspx
<dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
    <ClientSideEvents ControlsInitialized="InitalizejQuery" EndCallback="InitalizejQuery" />
</dx:ASPxGlobalEvents>
```

## Files to Review

* [CustomVerticalAppointmentTemplate.ascx](./CS/CustomForms/CustomVerticalAppointmentTemplate.ascx) (VB: [CustomVerticalAppointmentTemplate.ascx](./VB/CustomForms/CustomVerticalAppointmentTemplate.ascx))
* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))

## Documentation

* [How to: Customize Appointment Appearance via Templates](https://docs.devexpress.com/AspNet/4220/components/scheduler/examples/customization/custom-form-and-custom-fields/how-to-customize-appointment-appearance-via-templates)

## More Examples

* [Text Box for ASP.NET Web Forms - How to apply the jQuery AutoComplete plugin to an editor](https://github.com/DevExpress-Examples/asp-net-web-forms-textbox-apply-jquery-autocomplete-plugin)
* [Scheduler for ASP.NET Web Forms - How to drag a row from ASPxGridView to ASPxScheduler](https://github.com/DevExpress-Examples/how-to-drag-a-row-from-aspxgridview-to-aspxscheduler-e4292)
* [Scheduler for ASP.NET Web Forms - How to drag-and-drop an appointment from an external control](https://github.com/DevExpress-Examples/how-to-drop-an-appointment-from-an-external-control-onto-an-aspxscheduler-e4746)
