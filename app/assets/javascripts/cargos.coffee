$ ->
  if $('#cargos-new').length
    $('#cargo_total_quantity').on 'input', ->
      val = $(this).val()
      $('#cargo_in_stock_quantity').val(val)