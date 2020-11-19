var donation = '';

function viewHistory(donation){
	donations = JSON.parse(donation);
	var total = 0;
	for ( let i = 0 ; i < donations.length ; i++ ) {
		document.getElementById("history_table").innerHTML = document.getElementById("history_table").innerHTML + 
			'<tr><td><a href="./view-charity?id=' + donations[i].payment_id + '">' + donations[i].name + '</a></td><td>$' + donations[i].amount + '</td><td>' + new Date(donations[i].payment_date).toDateString() + '</td></tr>';
		total = total + parseInt(donations[i].amount);
	}
	document.getElementById("total").innerHTML = '$' + total;
}
