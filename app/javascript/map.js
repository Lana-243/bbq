document.addEventListener('turbo:load', () => {
  ymaps.ready(init);

  function init() {

    const mapElement = document.getElementById('map');
    if (!mapElement) return;ss

    const address = mapElement.getAttribute('data-address');

    const myMap = new ymaps.Map('map', {
      center: [55.76, 37.64],
      zoom: 10,
    });

    const myGeocoder = ymaps.geocode(address);

    myGeocoder.then(
      function (res) {
        coordinates = res.geoObjects.get(0).geometry.getCoordinates();

        myMap.geoObjects.add(
          new ymaps.Placemark(
            coordinates,
            { iconContent: address },
            { preset: 'islands#blueStretchyIcon' }
          )
        );

        myMap.setCenter(coordinates);
        myMap.setZoom(15);
      },
      function (err) {
        alert('Ошибка при определении местоположения');
      }
    );
  }
});