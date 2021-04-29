let changeTimer;

const handleSuggestionSelection = event => {
    const clientId = event.currentTarget.getAttribute("data-id");
    fetchWithGet(`/clients/${encodeURIComponent(clientId)}/card`,
        Promise.resolve("<span class='text-danger'>Failed to retrieve client details"))
        .then(text => {
            hide(document.getElementById("search"));
            document.getElementById("selected_client").innerHTML = text;
            document.getElementById("invoice_client_id").value = clientId;
        });
};

const retrieveAutoCompleteSuggestions = event => {
    const term = event.currentTarget.value;
    clearTimeout(changeTimer);
    changeTimer = setTimeout(() => {
        fetchWithGet(`/clients/search/${encodeURIComponent(term)}`,
            Promise.resolve("<span class='dropdown-item text-danger'>Unable to query clients</span>"))
            .then(text => {
                const foundClients = document.getElementById("found_clients");
                foundClients.innerHTML = text;
                show(foundClients);
                let items = document.querySelectorAll("#found_clients > [data-id]");
                for (i = 0; i < items.length; i++) {
                    items[i].addEventListener("click", handleSuggestionSelection);
                }
            });
    }, 500);
};

const addCloseListener = node => {
    node.addEventListener("click", event => {
        const card = node.parentNode.parentNode;
        card.classList.add("fade-out");
        setTimeout(() => {
            card.parentNode.removeChild(card);
        }, 1000);
    });
};

document.addEventListener("DOMContentLoaded", () => {
    let searchField = document.getElementById("search_client");
    if (searchField) {
        searchField.addEventListener("input", retrieveAutoCompleteSuggestions);
        searchField.addEventListener("focus", retrieveAutoCompleteSuggestions);
    }

    let closeButtons = document.querySelectorAll(".close");
    for (i = 0; i < closeButtons.length; i++) {
        addCloseListener(closeButtons[i]);
    }
    let uploadField = document.getElementById("invoice_pdf");
    uploadField.addEventListener("change", event => {
        document.querySelector(".custom-file-label").textContent = event.currentTarget.value.split("\\").pop();
    });
});
