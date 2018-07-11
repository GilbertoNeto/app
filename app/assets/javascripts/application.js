// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require jquery.mask
//= require jquery.raty
//= require underscore


$(document).on('turbolinks:load', function(){
	$('#cep').blur(function(e) {
		var cep = $('#cep').val();

		if (!cep.match(/^[0-9]{5}-[0-9]{3}$/)) {
			alert('CEP inválido');
			return false;
		}

		$.ajax({
			dataType: "json",
			url: '/cep/index',
			data: {'cep': cep},
			success: function(data) {
				if ($.isEmptyObject(data)) {
					alert('CEP não encontrado');
					$('#cep').val('');
					$('#bairro').val('');
					$('#cidade').val('');
					$('#estado').val('');
					$('#rua').val('');
					return false;
				}
				$('#bairro').val(data.neighborhood);
				$('#cidade').val(data.city);
				$('#estado').val(data.state);
				$('#rua').val(data.address);
			}
		});
	});
});

(function() {
  var bind, showOrHideDependentFieldsCheckbox, showOrHideDependentFieldsSelect, toggle;

  toggle = function($parent, showOrHide, method, duration) {
    if (showOrHide) {
      if (method === 'disable') {
        $parent.find('input,textarea,select,button,.btn').removeAttr('disabled');
        return $parent.find('.select2').select2('enable');
      } else {
        return $parent.show(duration);
      }
    } else {
      if (method === 'disable') {
        $parent.find('input,textarea,select,button,.btn').attr('disabled', 'disabled');
        return $parent.find('.select2').select2('disable');
      } else {
        return $parent.hide(duration);
      }
    }
  };

  showOrHideDependentFieldsSelect = function(duration) {
    var $select, showOrHideFields;

    if (duration == null) {
      duration = 'fast';
    }
    $select = $(this);
    showOrHideFields = function() {
      var $this, showOrHide;

      $this = $(this);
      showOrHide = _.contains($this.attr('data-option-value').split('|'), $select.val());
      return toggle($this, showOrHide, $this.data('method'), duration);
    };
    return $(".js-dependent-fields[data-select-id=" + ($select.attr('id')) + "]").each(showOrHideFields);
  };

  showOrHideDependentFieldsCheckbox = function(duration) {
    var $checkbox, showOrHideFields;

    if (duration == null) {
      duration = 'fast';
    }
    $checkbox = $(this);
    showOrHideFields = function() {
      var $this, showOrHide;

      $this = $(this);
      showOrHide = $this.data('checkbox-value') === $checkbox.is(':checked');
      return toggle($this, showOrHide, $this.data('method'), duration);
    };
    return $(".js-dependent-fields[data-checkbox-id=" + ($checkbox.attr('id')) + "]").each(showOrHideFields);
  };

  bind = function() {
    var $inputs, $selects;

    $selects = $('select');
    $selects.not('[data-important]').each(_.partial(showOrHideDependentFieldsSelect, 0));
    $selects.filter('[data-important]').each(_.partial(showOrHideDependentFieldsSelect, 0));
    $selects.change(showOrHideDependentFieldsSelect);
    $inputs = $('input[type=checkbox]');
    $inputs.not('[data-important]').each(_.partial(showOrHideDependentFieldsCheckbox, 0));
    $inputs.filter('[data-important]').each(_.partial(showOrHideDependentFieldsCheckbox, 0));
    return $inputs.change(showOrHideDependentFieldsCheckbox);
  };

  this.DependentFields = {
    bind: bind
  };

}).call(this);


$(document).ready(function() {
     DependentFields.bind()
 });
