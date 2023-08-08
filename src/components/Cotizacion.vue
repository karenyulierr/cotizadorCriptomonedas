<script setup>
defineProps({
  cotizacion: {
    type: Object,
    required: true,
  }
});
</script>

<template>
  <div class="contenedor_resultado">
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
</template>
