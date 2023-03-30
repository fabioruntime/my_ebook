$('#shoppingCartModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget)
  var ebook_id = button.data('ebook-id')
  var title = button.data('title')
  var modal = $(this)
  modal.find('.modal-description').text("The '" + title + "' will be added to your library.")
  modal.find('.modal-body input').val(ebook_id)
})
