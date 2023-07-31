<script setup>
import { ref, reactive, onMounted, computed } from "vue";
import Alerta from "./components/Alerta.vue";

const monedas = ref([
  { codigo: "USD", texto: "Dolar de Estados Unidos" },
  { codigo: "MXN", texto: "Peso Mexicano" },
  { codigo: "EUR", texto: "Euro" },
  { codigo: "GBP", texto: "Libra Esterlina" },
  { codigo: "COL", texto: "Peso colombiano" },
]);
const criptomonedas = ref([]);
const error = ref("");
const cotizar = reactive({
  moneda: "",
  criptomoneda: "",
});
const cotizacion = ref({});
onMounted(() => {
  const url =
    "https://min-api.cryptocompare.com/data/top/mktcapfull?limit=20&tsym=USD";
  fetch(url)
    .then((respuesta) => respuesta.json())
    .then(({ Data }) => (criptomonedas.value = Data));
});

const cotizarCripto = () => {
  //Cotizar este lleno
  if (Object.values(cotizar).includes("")) {
    error.value = "Todos los campos son obligatorios";
    return;
  }
  error.value = "";
  obtenerCotizacion();
};

const obtenerCotizacion = async () => {
  const { moneda, criptomoneda } = cotizar;
  const url = `https://min-api.cryptocompare.com/data/pricemultifull?fsyms=${criptomoneda}&tsyms=${moneda}`;
  const respuesta = await fetch(url);
  const data = await respuesta.json();
  cotizacion.value = data.DISPLAY[criptomoneda][moneda];
};

const mostrarResultado = computed(() => {
  return Object.values(cotizacion.value).length > 0;
});
</script>

<template>
  <div class="contenedor">
    <h1 class="titulo">Cotizador de <span>Criptomonedas</span></h1>

    <div class="contenido">
      <Alerta v-if="error">{{ error }}</Alerta>
      <form class="formulario" @submit.prevent="cotizarCripto">
        <div class="campo">
          <label for="monedad">Moneda:</label>
          <select id="monedad" v-model="cotizar.moneda">
            <option value="">--Seleccione--</option>
            <option
              v-for="moneda in monedas"
              :key="moneda.codigo"
              :value="moneda.codigo"
            >
              {{ moneda.texto }}
            </option>
          </select>
        </div>
        <div class="campo">
          <label for="cripto">Criptomoneda:</label>
          <select id="cripto" v-model="cotizar.criptomoneda">
            <option value="">-- Selecciona --</option>
            <option
              v-for="criptomoneda in criptomonedas"
              :key="criptomoneda.Id"
              :value="criptomoneda.CoinInfo.Name"
            >
              {{ criptomoneda.CoinInfo.FullName }}
            </option>
          </select>
        </div>

        <input type="submit" value="Cotizar" />
      </form>

      <div class="contenedor_resultado" v-if="mostrarResultado">
        <h2>Cotizaciòn</h2>
        <div class="resultado">
          <img
            :src="'https://cryptocompare.com/' + cotizacion.IMAGEURL"
            alt="imagen cripto"
          />
          <div>
            <P
              >El precio es de: <span>{{ cotizacion.PRICE }}</span></P
            >
            <p>
              Precio mas alto del dìa: <span>{{ cotizacion.HIGHDAY }}</span>
            </p>
            <p>
              Precio mas bajo del dìa: <span>{{ cotizacion.LOWDAY }}</span>
            </p>
            <p>
              Variaciòn ùltimas 24 horas:
              <span>{{ cotizacion.CHANGEPCT24HOUR }} %</span>
            </p>
            <p>
              Ùltima actualizaciòn: <span>{{ cotizacion.LASTUPDATE }}</span>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
