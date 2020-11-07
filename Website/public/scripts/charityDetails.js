var charity = '';

function viewCharity(num,orgs){
	charity = JSON.parse(orgs);
	loadCharity(num);
	cardRow(0,"similar");
	cardCharity(0,1);
	cardCharity(1,2);
	cardCharity(2,3);
}

function loadCharity(num){
	// Title & Logo
	document.getElementById("charity_title").innerHTML = charity[num].name + " - CharityHub Profile";
	document.getElementById("charity_brand").innerHTML = charity[num].name;
	document.getElementById("charity_logo").src = './img/charity/' + charity[num].org_id + 'L.png';
	document.getElementById("charity_logo").alt = charity[num].name;

	// Charity Type List
	document.getElementById("types").innerHTML = "<a type='button' id='type1' class='btn btn-primary btn-sm' href='#'>" + charity[num].type1 + "</a>"
	if( charity[num].type2 !== "" )
		document.getElementById("types").innerHTML = document.getElementById("types").innerHTML + " <a type='button' id='type2' class='btn btn-primary btn-sm' href='#'>" + charity[num].type2 + "</a>"
	if( charity[num].type3 !== "" )
		document.getElementById("types").innerHTML = document.getElementById("types").innerHTML + " <a type='button' id='type2' class='btn btn-primary btn-sm' href='#'>" + charity[num].type3 + "</a>"
	document.getElementById("types").innerHTML = document.getElementById("types").innerHTML + "<br><br>";

	// Website & Social Media Links
	document.getElementById("links").innerHTML = "<a type='button' id='charity_url' class='btn btn-dark btn-sm' href='" + charity[num].url + "'>" + charity[num].name + "</a>";
	if( charity[num].url_fb !== "" )
		document.getElementById("links").innerHTML = document.getElementById("links").innerHTML + " <i class='fa fa-facebook-official fa-2x' href='" + charity[num].url_fb + "' style='vertical-align:bottom;'></i>"
	if( charity[num].url_tw !== "" )
		document.getElementById("links").innerHTML = document.getElementById("links").innerHTML + " <i class='fa fa-twitter fa-2x' href='" + charity[num].url_fb + "' style='vertical-align:bottom;'></i>"
	if( charity[num].url_in !== "" )
		document.getElementById("links").innerHTML = document.getElementById("links").innerHTML + " <i class='fa fa-instagram fa-2x' href='" + charity[num].url_fb + "' style='vertical-align:bottom;'></i>"
	document.getElementById("links").innerHTML = document.getElementById("links").innerHTML + "<br><br>";

	// Contact & Description
	document.getElementById("charity_contact").innerHTML = '1111 Engineering Drive<br>Boulder, CO 80309-0428';
	if( charity[num].mission !== "" )
		document.getElementById("charity_desc").innerHTML = charity[num].mission;
	else
		document.getElementById("charity_desc").innerHTML = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eu lobortis elementum nibh tellus molestie nunc. Fringilla urna porttitor rhoncus dolor purus non enim. Ac odio tempor orci dapibus ultrices in. Duis ultricies lacus sed turpis tincidunt id aliquet risus. Feugiat nibh sed pulvinar proin gravida hendrerit lectus a. Donec ac odio tempor orci. Nascetur ridiculus mus mauris vitae. Ut lectus arcu bibendum at varius. Non arcu risus quis varius quam quisque id diam."; // Dummy description if blank

	// Events
	/*
	if( charity[num].event1 !== "" )
		document.getElementById("events").innerHTML = "<button type='button' class='btn btn-info' href='#'>" + charity[num].event1 + "</button><p>" + charity[num].event_date1 + "</p>"
	else
		document.getElementById("events").innerHTML = ""
	if( charity[num].event2 !== "" )
		document.getElementById("events").innerHTML = document.getElementById("events").innerHTML + "<button type='button' class='btn btn-info' href='#'>" + charity[num].event2 + "</button><p>" + charity[num].event_date2 + "</p>"
	if( charity[num].event3 !== "" )
		document.getElementById("events").innerHTML = document.getElementById("events").innerHTML + "<button type='button' class='btn btn-info' href='#'>" + charity[num].event3 + "</button><p>" + charity[num].event_date3 + "</p>"
	if( charity[num].event1 === "" && charity[num].event2 === "" && charity[num].event3 === "" )
		document.getElementById("events").innerHTML = "There are no upcoming events for this organization."
	*/
	// Placeholder Events
	document.getElementById("events").innerHTML = "<button type='button' class='btn btn-info' href='#'>Project Presentations</button><p>November 30, 2020</p><button type='button' class='btn btn-info' href='#'>Milestone 6</button><p>December 4, 2020</p><button type='button' class='btn btn-info' href='#'>Final Exam</button><p>December 9, 2020</p>"

	// Photo
	document.getElementById("photo").src = './img/charity/' + charity[num].org_id + '.jpg';

	/* Photo Gallery
	if( charity[num].photo1 !== "" && charity[num].photo_title1 !== "" && charity[num].photo_text1 !== "" && charity[num].photo2 !== "" && charity[num].photo_title2 !== "" && charity[num].photo_text2 !== "" && charity[num].photo3 !== "" && charity[num].photo_title3 !== "" && charity[num].photo_text3 !== "" ) {
		document.getElementById("photo1").src = './img/charity/' + charity[num].org_id + '.jpg';
		document.getElementById("photo1").alt = charity[num].photo_title1;
		document.getElementById("photo_title1").innerHTML = charity[num].photo_title1;
		document.getElementById("photo_text1").innerHTML = charity[num].photo_text1;
		document.getElementById("photo2").src = charity[num].photo2;
		document.getElementById("photo2").alt = charity[num].photo_title2;
		document.getElementById("photo_title2").innerHTML = charity[num].photo_title2;
		document.getElementById("photo_text2").innerHTML = charity[num].photo_text2;
		document.getElementById("photo3").src = charity[num].photo3;
		document.getElementById("photo3").alt = charity[num].photo_title3;
		document.getElementById("photo_title3").innerHTML = charity[num].photo_title3;
		document.getElementById("photo_text3").innerHTML = charity[num].photo_text3;
	}
	else
		document.getElementById("projectCarousel").style.display = "none";
	*/
}

function cardRow(icard,location){
	var box = document.getElementById(location);
	for ( let i = 0 ; i<3 ; i++ ) {
		box.innerHTML = box.innerHTML
			+ "<div class='card border-dark bg-light' style='width: 18rem;'><a class='text-dark' id='item_url"
			+ (icard+i) + "'><h5 class='card-header' id='item_title"
			+ (icard+i) + "'></h5><img class='card-img-top' id='item_photo"
			+ (icard+i) + "' src='data:,'></a><div class='container'><p class='card-text' id='item_desc"
			+ (icard+i) + "'></p><div class='container border border-light' id='item_types"
			+ (icard+i) + "'></div></div></div>";
	}
}

function cardCharity(card,num){
	document.getElementById("item_photo" + card).src = './img/charity/' + charity[num].org_id + '.jpg';
	document.getElementById("item_title" + card).innerHTML = charity[num].name;
	document.getElementById("item_url" + card).href = "./view-charity?id=" + charity[num].org_id;
	document.getElementById("item_desc" + card).innerHTML = charity[num].tag;
	document.getElementById("item_types" + card).innerHTML = "<a type='button' class='btn btn-dark btn-sm' href='#'>" + charity[num].type1 + "</a>"
	if( charity[num].type2 !== "" )
		document.getElementById("item_types" + card).innerHTML = document.getElementById("item_types" + card).innerHTML + " <a type='button' class='btn btn-dark btn-sm' href='#'>" + charity[num].type2 + "</a>"
	if( charity[num].type3 !== "" )
		document.getElementById("item_types" + card).innerHTML = document.getElementById("item_types" + card).innerHTML + " <a type='button' class='btn btn-dark btn-sm' href='#'>" + charity[num].type3 + "</a>"
}

function getHome(orgs){
	charity = JSON.parse(orgs);
	document.getElementById("title1").innerHTML = "Featured";
	cardRow(0,"row1");
	cardCharity(0,0);
	cardCharity(1,1);
	cardCharity(2,2);
	document.getElementById("title2").innerHTML = "Trending";
	cardRow(3,"row2");
	cardCharity(3,3);
	cardCharity(4,4);
	cardCharity(5,5);
	document.getElementById("title3").innerHTML = "Recommended For You";
	cardRow(6,"row3");
	cardCharity(6,2);
	cardCharity(7,0);
	cardCharity(8,1);
}