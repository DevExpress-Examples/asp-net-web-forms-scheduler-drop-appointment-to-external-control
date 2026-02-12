Imports System
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Drawing

Partial Public Class VerticalAppointmentTemplate
	Inherits System.Web.UI.UserControl

	Private ReadOnly Property Container() As VerticalAppointmentTemplateContainer
		Get
			Return CType(Parent, VerticalAppointmentTemplateContainer)
		End Get
	End Property
	Private ReadOnly Property Items() As VerticalAppointmentTemplateItems
		Get
			Return Container.Items
		End Get
	End Property

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		appointmentDiv.Style.Value = Items.AppointmentStyle.GetStyleAttributes(Page).Value
		horizontalSeparator.Style.Value = Items.HorizontalSeparator.Style.GetStyleAttributes(Page).Value

		lblStartTime.ControlStyle.MergeWith(Items.StartTimeText.Style)
		lblEndTime.ControlStyle.MergeWith(Items.EndTimeText.Style)
		lblTitle.ControlStyle.MergeWith(Items.Title.Style)
		lblDescription.ControlStyle.MergeWith(Items.Description.Style)

		statusContainer.Controls.Add(Items.StatusControl)
		LayoutAppointmentImages()
	End Sub
	Private Sub LayoutAppointmentImages()
		Dim count As Integer = Items.Images.Count
		For i As Integer = 0 To count - 1
			Dim row As New HtmlTableRow()
			Dim cell As New HtmlTableCell()
			AddImage(cell, Items.Images(i))
			row.Cells.Add(cell)
			imageContainer.Rows.Add(row)
		Next i
	End Sub
	Private Sub AddImage(ByVal targetCell As HtmlTableCell, ByVal imageItem As AppointmentImageItem)
		Dim image As New Image()
		imageItem.ImageProperties.AssignToControl(image, False)
		targetCell.Controls.Add(image)
	End Sub
End Class