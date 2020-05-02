# VISTAS
# Carta
#*************************************************************************
CREATE OR REPLACE VIEW carta AS
SELECT 
  productos.id AS idProd,
  producto,
  precio,
  existe,
  imagen,
  pertenece,
  iva,
  categoria
FROM 
  productos
LEFT JOIN pro_pertenece ON pro_pertenece.id = productos.idPertenece 
LEFT JOIN iva           ON iva.id = productos.idIVA 
LEFT JOIN categorias    ON categorias.id = productos.idCategoria 

#************************************************************************