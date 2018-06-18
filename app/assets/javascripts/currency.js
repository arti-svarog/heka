$(document).ready(function(){
	$("#amount").keyup(function()
	{
		ajaxFunction();
	});
	// Start First Dropdown
	$(".view-data-first a").click(function(){
		$("#first_currency").html($('span:first', this).text());
		ajaxFunction();
	});
	// Start Second Dropdown
	$(".view-data-second a").click(function(){
		$("#second_currency").html($('span:first', this).text());
		ajaxFunction();
	});
	$('#exchange-page').click(function() {
		var quantity = $("#amount").val();
		var total = $("#second_cur").val();
		var	currency1 = $("#first_currency").html();
		var	currency2 = $("#second_currency").html();
		window.location.href = "/home/exchange?first="+currency1+"&&second="+currency2+"&quantity="+quantity+"&total="+total;
		return false;
	});
	//Exchange vice versa javascript
	$('#exchange_image').click(function(){
		var currency1 = $('#first_currency').text();
		var currency2 = $('#second_currency').text();
		$('#first_currency').text(currency2);
		$('#second_currency').text(currency1);
		ajaxFunction();
	});
	function ajaxFunction() {
		var	currency1 = $("#first_currency").html();
		var	currency2 = $("#second_currency").html();
    var amount = $("#amount").val();
		$(".form-group-change1").hide();
    $.ajax({
		  url: "/home/currency_exchange",
		  type: "GET",
		  data: {"params" : {"first" :currency1,"second" :currency2 ,"quantity" :amount}},
		  dataType: "script",
		  success:function(data){
				$('.light').val(JSON.parse(data).data);
  		}
		});
	}

});