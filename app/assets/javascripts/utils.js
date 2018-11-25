document.addEventListener("DOMContentLoaded", () => {
    addClickHandlers();
    addModalHandlers();
});

function addClickHandlers() {
    let clickables = document.querySelectorAll("[data-href]");
    for (i = 0; i < clickables.length; i++) {
        clickables[i].addEventListener("click", event => {
            window.location = event.currentTarget.getAttribute("data-href");
        });
    }
}

function addModalHandlers() {
    let triggers = document.querySelectorAll("[data-modal]");
    for (i = 0; i < triggers.length; i++) {
        let trigger = triggers[i];
        trigger.addEventListener("click", event => {
            let modalElement = document.querySelector(trigger.getAttribute("data-target"));
            document.getElementById("modal-action").setAttribute("href", trigger.getAttribute("data-modal"));
            let modal = new Modal(modalElement, {});
            modal.show();
        });
    }
}
