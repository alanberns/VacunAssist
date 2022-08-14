/* A la etiqueta html que tenga el id "formulario"
  le agregamos comportamiento cuando se hace submit. */
$("#formulario").submit(function(event){
  var validez = "true";

  var regexClave = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,32})/

  // Se prueba la expresión regular con el string del input
  if(!regexClave.test($("#claveNueva").val())) validez = "Ingrese una contraseña válida.";

  else if($("#claveNueva").val() != $("#claveRepetir").val()) validez = "Las contraseñas deben coincidir.";

    /* Si validez se mantiene en "true" el formulario es correcto y se envía,
    caso contrario se muestra un mensaje y se cancela el envío. */
  if(validez != "true"){
    alert(validez);
    event.preventDefault();
  }
});