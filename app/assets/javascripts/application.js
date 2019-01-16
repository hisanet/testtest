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
//= require bootstrap-sprockets
//= require jquery/dist/jquery.min
//= require bootstrap/dist/js/bootstrap.min  
//= require admin-lte/dist/js/adminlte.min 
//= require chart.js/dist/Chart


//= require select2

// js-selectable クラスをつけたらSELCT2タグになるようにする
$(document).ready(function() {
    $('.js-basic-single').select2();

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

  	$("#ajax_exam").select2({
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
});
/*
$(document).ready(function() {
    $('.js-data-ajax').select2({
	  ajax: {
	    url: '/users.json',
	    dataType: 'json'
	    // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
  		}
	});

	$('.ajaxexample').select2({
	  ajax: {
	    url: '/users/index.json',
	    dataType: 'json'
	    results: function(data, page) {
        return { 
          results: $.map( data, function(user, i) { 
            return { id: user.id, text: user.name } 
          } )
        }
      	}
	    // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
  		}
	});

	$(".ajax_exam").select2({
	    ajax: {
	      url:'/users.json',
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
	    placeholder: "本選択",
  	});
});
*/