// Escondo los elementos que deben aparecer cuando uso el checkbox
document.getElementById('divCovid').style.visibility = "hidden";
document.getElementById('divGripe').style.visibility = "hidden";
document.getElementById('divAmarilla').style.visibility = "hidden";
// Inhabilito los input de fecha hasta que se usen los checkbox
document.getElementById('fechaCovid').disabled = true;
document.getElementById('fechaGripe').disabled = true;
document.getElementById('fechaAmarilla').disabled = true;

// Les agrego comportamiento a los checkbox para que muestren u oculten sus divs
var checkCovid = document.getElementById('checkCovid');
checkCovid.addEventListener('click', function() {
  if(checkCovid.checked){
    document.getElementById('divCovid').style.visibility = "visible";
    document.getElementById('fechaCovid').disabled = false;
  }
  else{
    document.getElementById('divCovid').style.visibility = "hidden";
    document.getElementById('fechaCovid').disabled = true;
  }
});

var checkGripe = document.getElementById('checkGripe');
checkGripe.addEventListener('click', function() {
  if(checkGripe.checked){
    document.getElementById('divGripe').style.visibility = "visible";
    document.getElementById('fechaGripe').disabled = false;
  }
  else{
    document.getElementById('divGripe').style.visibility = "hidden";
    document.getElementById('fechaGripe').disabled = true;
  }
});

var checkAmarilla = document.getElementById('checkAmarilla');
checkAmarilla.addEventListener('click', function() {
  if(checkAmarilla.checked){
    document.getElementById('divAmarilla').style.visibility = "visible";
    document.getElementById('fechaAmarilla').disabled = false;
  }
  else{
    document.getElementById('divAmarilla').style.visibility = "hidden";
    document.getElementById('fechaAmarilla').disabled = true;
  }
});


$("#formulario").submit(function(event){
  var validez = "true";

  var hoy = new Date().toISOString().slice(0, 10);

// Solo verifico la fecha si el checkbox está marcado
  if(document.getElementById("checkCovid").checked){
    var fc = reformatearFecha($("#fechaCovid").val());
    if(!isValidDate(fc)) validez = "Ingrese una fecha de vacunación para covid válida.";
    else if(hoy < fc) validez = "No puede ingresar fechas futuras.";
  }

  if(document.getElementById("checkGripe").checked){
    var fg = reformatearFecha($("#fechaGripe").val());
    if(!isValidDate(fg)) validez = "Ingrese una fecha de vacunación para gripe válida.";
    else if(hoy < fg) validez = "No puede ingresar fechas futuras.";
  }

  if(document.getElementById("checkAmarilla").checked){
    var fa = reformatearFecha($("#fechaAmarilla").val());
    if(!isValidDate(fa)) validez = "Ingrese una fecha de vacunación para fiebre amarilla válida.";
    else if(hoy < fa) validez = "No puede ingresar fechas futuras.";
  }


  if(validez != "true"){
    alert(validez);
    event.preventDefault();
  }
});


function isValidDate(dateString) {
  var regEx = /^\d{4}-\d{2}-\d{2}$/;
  if(!dateString.match(regEx)) return false;  // Invalid format
  var d = new Date(dateString);
  var dNum = d.getTime();
  if(!dNum && dNum !== 0) return false; // NaN value, Invalid date
  return d.toISOString().slice(0,10) === dateString;
}


function reformatearFecha(unaFecha){
  return unaFecha.substr(6) + "-" + unaFecha.substr(3,2) + "-" + unaFecha.substr(0,2);
}