
String? validateEmail(String? Correoform){
  if (Correoform == null || Correoform.isEmpty) 
    return 'Porfavor ingrese un correo';

  String pattern = r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(Correoform)) return 'Porfavor ingresa un formato de correo valido';

  return null;
  
}

String? validatecontra(String? contraform){
  if(contraform == null || contraform.isEmpty)
  return 'Porfavor ingresa una contraseña';
    
  return null;
}