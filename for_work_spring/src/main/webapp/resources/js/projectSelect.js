console.log("Project Select js 실행...!!!");

var projectSelect = (function(){
	
	function getProjects(callback, error){
		
		$.getJSON("/pmPage/PrSelect.json",
				function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				error();
			}
		});
	}
	return{
		getProjects : getProjects
	};
})();