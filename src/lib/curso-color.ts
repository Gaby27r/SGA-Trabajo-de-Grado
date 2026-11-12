// Cada curso recibe un color de una paleta fija según su posición, para que
// las etiquetas sean consistentes en toda la app sin importar cuántos cursos
// se agreguen más adelante.
const PALETA = [
  { bg: "#EAF1EC", fg: "#2F5C4C", ring: "#B9D2C4" }, // verde tablero
  { bg: "#F5E9DA", fg: "#8A4B18", ring: "#E3C7A2" }, // ocre
  { bg: "#F1E5EC", fg: "#7A3B5E", ring: "#DCC0D2" }, // ciruela
  { bg: "#E7ECF3", fg: "#33507A", ring: "#C4D0E4" }, // añil
  { bg: "#F3EADD", fg: "#78552A", ring: "#E2CFB2" }, // arena
  { bg: "#EDE7F3", fg: "#5B4586", ring: "#D2C3E6" }, // lavanda
];

export function cursoColor(index: number) {
  return PALETA[index % PALETA.length];
}
