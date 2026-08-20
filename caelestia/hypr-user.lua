-- Cargar la disposición de monitores generada por nwg-displays.
-- Caelestia no hace require de monitors.lua por defecto, por eso los
-- cambios de nwg-displays no se aplicaban. Esto lo carga en cada arranque
-- y sobrevive a las actualizaciones de los dotfiles de Caelestia.
require("monitors")

-- Reglas de workspaces (generadas por nwg-displays)
require("workspaces")
