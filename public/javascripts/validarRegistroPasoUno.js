/* A la etiqueta html que tenga el id "formulario"
  le agregamos comportamiento cuando se hace submit. */
$("#formulario").submit(function(event){
  var validez = "true";

  // Expresiones regulares
  var regexNombre = /^[a-zA-Z ]{3,50}$/;
  var regexClave = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,32})/
  var regexDni = /^[0-9]{1,9}$/;
  var regexCentro = /^[1-3]{1}$/;
  var regexGenero = /^((F)|(M)|(N)){1}$/;

  // Fecha de HOY en formato aaaa-mm-dd
  var hoy = new Date().toISOString().slice(0, 10);

  var fn = reformatearFecha($("#fechaNac").val());

  // Se prueba la expresión regular con el string del input
  if(!regexNombre.test($("#nombre").val())) validez = "Ingrese un nombre válido.";
  else if(!regexNombre.test($("#apellido").val())) validez = "Ingrese un apellido válido.";
  else if(!regexDni.test($("#dni").val())) validez = "Ingrese un DNI válido.";
  else if(!isValidDate(fn)) validez = "Ingrese una fecha de nacimiento válida.";
  else if(hoy < fn) validez = "No puede ingresar fechas futuras.";
  else if(!regexGenero.test($("#genero").val())) validez = "Ingrese un género válido.";
  else if(!regexCentro.test($("#centro").val())) validez = "Ingrese un centro válido.";
  else if(!regexClave.test($("#clave").val())) validez = "Ingrese una contraseña válida.";
  else if($("#clave").val() != $("#clave2").val()) validez = "Las contraseñas deben coincidir.";

  /* Si validez se mantiene en "true" el formulario es correcto y se envía,
    caso contrario se muestra un mensaje y se cancela el envío. */
  if(validez != "true"){
    alert(validez);
    event.preventDefault();
  }
});


/* Esta función me la copié de internet, toma una
  fecha en formato aaaa-mm-dd y corrobora que sea válida */
function isValidDate(dateString) {
  var regEx = /^\d{4}-\d{2}-\d{2}$/;
  if(!dateString.match(regEx)) return false;  // Invalid format
  var d = new Date(dateString);
  var dNum = d.getTime();
  if(!dNum && dNum !== 0) return false; // NaN value, Invalid date
  return d.toISOString().slice(0,10) === dateString;
}


// Convierte unaFecha = dd/mm/aaaa -> aaaa-mm-dd
function reformatearFecha(unaFecha){
  return unaFecha.substr(6) + "-" + unaFecha.substr(3,2) + "-" + unaFecha.substr(0,2);
}