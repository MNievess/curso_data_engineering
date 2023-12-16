
{% macro extraer_sexo(nombre) %}
  {# Esta función usa la librería gender_guesser para adivinar el sexo de un nombre #}
  {# Importamos la librería gender_guesser #}
  import gender_guesser.detector as gender

  {# Creamos un objeto detector #}
  d = gender.Detector()

  {# Obtenemos el sexo usando el detector #}
  sexo = d.get_gender(nombre)

  {# Devolvemos el sexo #}
  return sexo
{% endmacro %}