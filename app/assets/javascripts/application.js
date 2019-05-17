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

//= require_tree .
//= require jquery
//= require jquery-ui
//= require jquery-ui/ui/i18n/datepicker-ja
//= require bootstrap-sprockets
//= require bootstrap/dist/js/bootstrap.min 
//= require admin-lte/dist/js/adminlte.min
//= require admin-lte/plugins/iCheck/icheck.min
//= require chart.js/dist/Chart
//= require select2
//= require autonumeric
//= require cocoon
//= require flatpickr
//= require turbolinks
// jquery-ui/ui/i18n/datepicker-ja
//bootstrap-datepicker/js/bootstrap-datepicker
//bootstrap-datepicker/dist/locales/bootstrap-datepicker.ja.min

$(document).on('turbolinks:load', function() {
    $('.js-basic-single').select2();
    $(document).trigger('refresh_autonumeric');

    $(".ajax_exam").select2({
	    ajax: {
	      url:'/users/search.json',
	      dataType: 'json',
	      delay: 50,
	      data: function(params) {
	        return {　q: params.term　};
	   		},
	      	processResults: function (data, params) {
	        	return { results: $.map(data, function(obj) {
	            	return { id: obj.id, text: obj.name };
	          	})
	        	};
	      	
	      	}
    	},
	    theme: "bootstrap",
	    width: "100%",
	    placeholder: "ユーザー選択",
  	});
  	/*
  	$(".user_tooltip").tooltip({
    	placement : 'top'
  	});
  	*/
	$(".user_tooltip").tooltip().on("show.bs.tooltip", function() {

	    setTimeout(function () {
	      $(".tooltip").fadeOut('fast', function() {
	        $(this).remove();
	      });
	    }, 1000);
	  });

  	
    $('.mainte_check').iCheck({
    	checkboxClass: 'icheckbox_flat-green',
    	//radioClass: 'iradio_minimal-blue',
    	radioClass: 'iradio_flat-green'
    	//radioClass: 'iradio_square'
    });
/*
	$('input').on('ifChanged', function(event){
		var m_total;
		m_total=0;
		m_total=parseInt($('.mente').text());
		console.log(m_total);
		$(".user_tooltip").tooltip('dispose');

	//  alert(event.type + ' callback');
	});*/


	

  	 $('#sortable').sortable({
	    axis: 'y',
	    items: '.item',
	    cursor: 'move',
	    sort: function(e, ui) {
	      return ui.item.addClass('active-item-shadow');
	    },
	    stop: function(e, ui) {
	      ui.item.removeClass('active-item-shadow');
	      // highlight the row on drop to indicate an update
	      return ui.item.children('td').effect('highlight', {}, 1000);
    	},
	    update: function(e, ui) {
	      var item_id, position;
	      item_id = ui.item.data('item-id');
	      console.log(item_id);
	      position = ui.item.index(); // this will not work with paginated items, as the index is zero on every page
	      return $.ajax({
	        type: 'POST',
	        url: '/users/update_row_order',
	        dataType: 'json',
	        data: {
	          user: {
	            user_id: item_id,
	            row_order_position: position
	          }
        	}	
      		});
    	}
  	});
  	 $('#ordersortable').sortable({
	    axis: 'y',
	    items: '.item',
	    cursor: 'move',
	    sort: function(e, ui) {
	      return ui.item.addClass('active-item-shadow');
	    },
	    stop: function(e, ui) {
	      ui.item.removeClass('active-item-shadow');
	      // highlight the row on drop to indicate an update
	      return ui.item.children('td').effect('highlight', {}, 1000);
    	},
	    update: function(e, ui) {
	      var item_id, position;
	      item_id = ui.item.data('item-id');
	      console.log(item_id);
	      position = ui.item.index(); // this will not work with paginated items, as the index is zero on every page
	      return $.ajax({
	        type: 'POST',
	        url: '/ord_details/update_row_order',
	        dataType: 'json',
	        data: {
	          ord_detail: {
	            ord_detail_id: item_id,
	            row_order_position: position
	          }
        	}	
      		});
    	}
  	});


	
  	//select2で商品選択のあと、価格を上書き、小計を集計
  	$(this).on('change', '.product_select', function() {
		var quantity, total,unit_price,product_id,p_price,pri_val,p_id,totals,subtotals,t_id;

		unit_price = $(this).parents('.nested-fields').find('.unit-price').first().val();
		product_id = $(this).parents('.nested-fields').find('.product_select').first().val();
		p_id=$(this);
		$.ajax({
			type: 'GET',
	        url:'/products/content',
	        dataType: 'json',
	        data: {
	        	product:{ 
	        		id: product_id
	        	}	           
        	}	
      	})
      	.done(function(data){
      		
      		totals=0;
      		pri_val = parseInt(data);
      		quantity =$(p_id).parents('.nested-fields').find('.quantity').val();
      		if(quantity==""){
      			$(p_id).parents('.nested-fields').find('.quantity').val(1);
      			quantity =1;
      		};
      		total = parseInt(pri_val) * parseInt(quantity);

			//t_id=$(p_id).parents('.nested-fields').find('.subtotal').autoNumeric('set', total);
      		$(p_id).parents('.nested-fields').find('.subtotal').autoNumeric('set', total);
      		$(p_id).parents('.nested-fields').find('.unit-price').autoNumeric('set', pri_val).focus();

      		subtotals = $(p_id).parents().find('.subtotal').each(function() {
				totals += parseInt($(this).autoNumeric('get'));

	
			});			
			$('.total').autoNumeric('set', totals);
      	

   		});
		
	});

  	$(this).on('change', '.unit-price, .quantity ', money_cunmma) ;
	$(this).on('keyup', '.unit-price, .quantity ', money_cunmma);
	$(this).on('mousedown', '.unit-price, .quantity', money_cunmma);
	    
});

$(document).on('turbolinks:load', function() {
	$(".product_select").select2({
	    ajax: {
	      url:'/products/search.json',
	      dataType: 'json',
	      delay: 50,
	      data: function(params) {
	        return {　q: params.term　};
	   		},
	      	processResults: function (data, params) {
	        	return { results: $.map(data, function(obj) {
	            	return { id: obj.id, text: obj.name };
	          	})
	        	};
	      	
	      	}
    	},
	    theme: "bootstrap",
	    width: "100%",
	    placeholder: "商品選択",
  	});
  	

	$(this).on('cocoon:after-insert', function(){
		$(".user_tooltip").tooltip().on("show.bs.tooltip", function() {

	    setTimeout(function () {
	      $(".tooltip").fadeOut('fast', function() {
	        $(this).remove();
	      });
	    }, 1000);
	  });
  	 	$(".product_select").select2({
	    ajax: {
	      url:'/products/search.json',
	      dataType: 'json',
	      delay: 50,
	      data: function(params) {
	        return {　q: params.term　};
	   		},
	      	processResults: function (data, params) {
	        	return { results: $.map(data, function(obj) {
	            	return { id: obj.id, text: obj.name };
	          	})
	        	};
	      	
	      	}
    	},
	    theme: "bootstrap",
	    width: "100%",
	    placeholder: "商品選択",
  		});
  	});
  	$(this).on('cocoon:after-remove', function(){

  	});
});

$(document).on('turbolinks:load', function() {

	    $('.flatpickr').flatpickr({
    	dateFormat: "Y-m-d",
    	allowInput:"true",
    	locale: "ja"
    });
});
$(document).on('turbolinks:load', function() {

	$(".del_button").click(function () {
        var quantity, total, unit_price,totals,subtotals,tax,grand_total;
		totals=0;
		total=$(this).parents('.nested-fields').find('.quantity').val(0);
		total=$(this).parents('.nested-fields').find('.subtotal').removeClass('subtotal');
		subtotals = $(this).parents().find('.subtotal').each(function() {
			console.log(totals);
			return totals += parseInt($(this).autoNumeric('get'));
		});
		$('.total').autoNumeric('set', totals);
		tax=totals*8/100;
		tax=Math.floor(tax);
		$('.tax').autoNumeric('set', tax);
		grand_total=totals+tax;
		$('.grand_total').autoNumeric('set', grand_total);
    });
});


function money_cunmma(){
	var quantity, total, unit_price,totals,subtotals,tax,grand_total;
		totals=0;
		unit_price= $(this).parents('.nested-fields').find('.unit-price').first().autoNumeric('get');
		quantity =$(this).parents('.nested-fields').find('.quantity').val();
		total = parseInt(unit_price) * parseInt(quantity);
		$(this).parents('.nested-fields').find('.subtotal').autoNumeric('set', total);

		subtotals = $(this).parents().find('.subtotal').each(function() {
			return totals += parseInt($(this).autoNumeric('get'));
		});
		$('.total').autoNumeric('set', totals);
		tax=totals*8/100;
		tax=Math.floor(tax);
		$('.tax').autoNumeric('set', tax);
		grand_total=totals+tax;
		$('.grand_total').autoNumeric('set', grand_total);

}



/*
$(this).on('change', '.unit-price, .quantity', function() {
		var quantity, total, unit_price;
		unit_price = $(this).find('.unit-price').first().val();
		quantity = $(this).parents('.nested-fields').find('.quantity').first().val();
		total = parseInt(unit_price) * parseInt(quantity);
		if (total) {
			return $(this).parents('.nested-fields').find('.subtotal').val("" + total).change();
		}
	});

*/