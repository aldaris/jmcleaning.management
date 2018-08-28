let changeTimer;

const handleAutoCompleteClick = event => {
    const clientId = event.currentTarget.getAttribute("data-id");
    fetch(`/clients/${encodeURIComponent(clientId)}/card`)
        .then(response => {
            if (response.ok) {
                return response.text();
            } else {
                return Promise.resolve("<span class='text-danger'>Failed to retrieve client details");
            }
        })
        .then(text => {
            hide(document.getElementById("search"));
            document.getElementById("selected_client").innerHTML = text;
            document.getElementById("invoice_client_id").value = clientId;
            show(document.getElementById("invoice-container"));
        });
};

const handleAutoComplete = event => {
    const term = event.currentTarget.value;
    clearTimeout(changeTimer);
    changeTimer = setTimeout(() => {
        fetch(`/clients/search/${encodeURIComponent(term)}`)
            .then(response => {
                if (response.ok) {
                    return response.text();
                } else {
                    return Promise.resolve("<span class='dropdown-item text-danger'>Unable to query clients</span>");
                }
            })
            .then(text => {
                const foundClients = document.getElementById("found_clients");
                foundClients.innerHTML = text;
                show(foundClients);
                let items = document.querySelectorAll("#found_clients > [data-id]");
                for (i = 0; i < items.length; i++) {
                    items[i].addEventListener("click", handleAutoCompleteClick);
                }
            });
    }, 500);
};

document.addEventListener("DOMContentLoaded", () => {
    let searchField = document.getElementById("search_client");
    searchField.addEventListener("input", handleAutoComplete);
    searchField.addEventListener("focus", handleAutoComplete);
});
