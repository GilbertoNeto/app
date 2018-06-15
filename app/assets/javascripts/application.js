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

