import "./app.postcss";
import Select_Tabelle from "./lib/Select_Tabelle.svelte";
import DarkLightBttn from "./lib/DarkLightBttn.svelte";

const app = new Select_Tabelle({
  target: document.getElementById("app"),
});

const button = new DarkLightBttn({
  target:document.getElementById("darkLightBttn"),
})

export default app;//||button;
