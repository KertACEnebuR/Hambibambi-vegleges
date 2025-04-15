function sendLogin (e) {
  console.log(e);

  let email    = document.querySelector(".email").value;
  let password = document.querySelector(".password").value;

  const jsonData = { c: 'login', email:email, password:password };

  const options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(jsonData)
  };

  fetch('../../controller/loginController.php', options)
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      if(data.message != "") {
        document.querySelector(".statusMessage").innerHTML = data.message;
        document.querySelector(".statusMessage").classList.remove("hide");
        document.querySelector(".statusMessage").classList.add("show");
      } else {
        document.querySelector(".statusMessage").classList.remove("show");
        document.querySelector(".statusMessage").classList.add("hide");
        document.querySelector(".statusMessage").innerHTML = "";

      }
  })
  .catch(error => {
    console.error('Fetch error:', error);
  });    
}

