const initDatepicker = (elt) => {
  return flatpickr(elt, {
    dateFormat: "Y/m/d",
    altInput: true,
    altFormat: "m/d/Y"
  });
}

const initTimepicker = (elt) => {
  return flatpickr(elt, {
    enableTime: true,
    noCalendar: true,
    dateFormat: "h:i K"
  });
};

export { initDatepicker, initTimepicker };
