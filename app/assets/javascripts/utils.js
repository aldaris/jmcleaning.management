document.addEventListener("DOMContentLoaded", () => {
    let clickables = document.querySelectorAll("[data-href]");
    for (i = 0; i < clickables.length; i++) {
        clickables[i].addEventListener("click", event => {
            window.location = event.currentTarget.getAttribute("data-href");
        })

    }
});
