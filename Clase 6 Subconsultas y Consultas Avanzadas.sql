USE world;
#EJERCICIO 1 -> Subconsulta con IN para identificar paises que contienen ciudades con mas de 5 millones de habitantes 
SELECT 
Name, Continent 
FROM country 
WHERE 
	Code IN ( # Subconsulta que devuelve los codigos de paises con ciudades grandes > 5 millones 
    SELECT DISTINCT CountryCode 
    FROM CITY 
    WHERE Population > 5000000
    ); 
    
#ejercicio 2 subconsulta correlacionada con EXISTS -> Encontrar los idiomas que son habladon en un unico pais 
SELECT 
Language
FROM countryLanguage 
AS cl1
WHERE 
NOT EXISTS ( # busca el mismo idioma en otros paises / se detiene en el primer registro que cumple la condicion (modelo de muchos a muchos ) 
	SELECT 1 
    FROM countryLanguage AS cl2 
    WHERE 
    cl2.Language = cl1.Language  # mismo idioma
    AND cl2.CountryCode !=cl1.CountryCode #diferente pais
);


#EJERCICIO 3 Subconsulta ESCALAR en SELECT -> Calcular que porcentaje de poblacion que cada ciudad representa respecto a su pais 
# JOIN  para obtener datos basicos del pais 
# Usamos subconsulta escalar para el calculo especifico
SELECT 
ci. Name AS CityName,
ci.Population AS CityPopulation,
co.Name AS CountryName,
co.Population AS CountryPopulation,
# Expresion que calcula el porcentaje con subconsulta
ROUND( 
(ci.Population * 100.0 ) / (
SELECT Population FROM country WHERE Code = ci.CountryCode # Devuelve el total de poblacion del pais 
), 2 )
AS PercentageOfCountry
FROM city ci 
JOIN 
country co ON ci.CountryCode = co.Code;
