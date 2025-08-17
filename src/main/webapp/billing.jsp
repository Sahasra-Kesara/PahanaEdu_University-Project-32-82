<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Billing Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 15px;
        }
        .result-card {
            display: none;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Billing System</h2>

    <!-- Customer Account Form -->
    <div class="card shadow p-4 mb-4">
        <form id="billingForm">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="accountNo" class="form-label">Customer Account Number</label>
                    <input type="text" id="accountNo" name="accountNo" class="form-control" required>
                </div>
                <div class="col-md-6 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Fetch Account Info</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Customer Info Result -->
    <div id="billingResult" class="card shadow p-4 result-card">
        <h5 class="mb-3">Customer Details</h5>
        <ul class="list-group">
            <li class="list-group-item"><strong>Name:</strong> <span id="customerName"></span></li>
            <li class="list-group-item"><strong>Units Used:</strong> <span id="units"></span></li>
            <li class="list-group-item"><strong>Rate Per Unit:</strong> <span id="rate"></span></li>
            <li class="list-group-item"><strong>Total Bill:</strong> <span id="total"></span></li>
        </ul>
    </div>

    <!-- Error -->
    <div id="errorBox" class="alert alert-danger mt-3 d-none"></div>

    <!-- Item Selection Section -->
    <div class="card shadow p-4 mt-5">
        <h5 class="mb-3">Add Items to Bill</h5>
        <div class="row">
            <div class="col-md-6">
                <label for="itemSelect" class="form-label">Select Item</label>
                <select id="itemSelect" class="form-select" required></select>
            </div>
            <div class="col-md-3">
                <label for="itemQty" class="form-label">Quantity</label>
                <input type="number" id="itemQty" class="form-control" value="1" min="1">
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <button type="button" class="btn btn-success w-100" onclick="addItemToBill()">Add to Bill</button>
            </div>
        </div>
    </div>

    <!-- Bill Table -->
    <div class="card shadow p-4 mt-4">
        <h5 class="mb-3">Itemized Bill</h5>
        <table class="table">
            <thead>
            <tr>
                <th>Item</th>
                <th>Price (Rs.)</th>
                <th>Qty</th>
                <th>Total (Rs.)</th>
            </tr>
            </thead>
            <tbody id="billTableBody"></tbody>
            <tfoot>
            <tr>
                <td colspan="3"><strong>Final Total</strong></td>
                <td id="finalBillTotal">Rs. 0.00</td>
            </tr>
            </tfoot>
        </table>
    </div>

    <a href="dashboard.jsp" class="btn btn-secondary mt-4">Back to Dashboard</a>
</div>

<!-- Scripts -->
<script>
    const itemMap = {};

    function fetchItems() {
        fetch("items/list")
            .then(res => res.json())
            .then(items => {
                const itemSelect = document.getElementById("itemSelect");
                itemSelect.innerHTML = "";

                items.forEach(item => {
                    itemMap[item.id] = item;

                    const option = document.createElement("option");
                    option.value = item.id.toString();
                    option.textContent = item.name;
                    itemSelect.appendChild(option);
                });
            })
            .catch(err => {
                console.error("Failed to load items:", err);
            });
    }

    function addItemToBill() {
        const select = document.getElementById("itemSelect");
        const qtyInput = document.getElementById("itemQty");

        const itemId = select.value.toString();
        const quantity = parseInt(qtyInput.value);

        if (!itemId || isNaN(quantity) || quantity <= 0) {
            alert("Please select a valid item and quantity.");
            return;
        }

        const item = itemMap[itemId];
        if (!item) {
            console.error("Item not found for ID:", itemId);
            alert("Invalid item selected.");
            return;
        }

        const total = item.price * quantity;

        // Debugging output
        console.log("Adding to bill:");
        console.log("Item Name:", item.name);
        console.log("Item Price:", item.price);
        console.log("Quantity:", quantity);
        console.log("Total:", total);

        const row = document.createElement("tr");

        // Explicitly build each <td> to debug visibility
        const tdName = document.createElement("td");
        tdName.textContent = item.name;

        const tdPrice = document.createElement("td");
        tdPrice.textContent = "Rs. " + Number(item.price).toFixed(2);

        const tdQty = document.createElement("td");
        tdQty.textContent = quantity;

        const tdTotal = document.createElement("td");
        tdTotal.textContent = "Rs. " + (Number(item.price) * quantity).toFixed(2);

        row.appendChild(tdName);
        row.appendChild(tdPrice);
        row.appendChild(tdQty);
        row.appendChild(tdTotal);

        document.getElementById("billTableBody").appendChild(row);
        updateBillTotal();
    }

    function updateBillTotal() {
        let total = 0;
        const rows = document.querySelectorAll("#billTableBody tr");
        rows.forEach(row => {
            const amount = parseFloat(row.children[3].textContent.replace("Rs. ", ""));
            total += amount;
        });
        document.getElementById("finalBillTotal").textContent = "Rs. " + total.toFixed(2);
    }

    window.onload = function () {
        fetchItems();

        document.getElementById("billingForm").addEventListener("submit", function (e) {
            e.preventDefault();

            const accountNo = document.getElementById("accountNo").value;
            const resultCard = document.getElementById("billingResult");
            const errorBox = document.getElementById("errorBox");

            resultCard.style.display = "none";
            errorBox.classList.add("d-none");

            fetch("billing/calculate?accountNo=" + accountNo)
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(err => { throw err; });
                    }
                    return response.json();
                })
                .then(data => {
                    document.getElementById("customerName").textContent = data.customerName;
                    document.getElementById("units").textContent = data.units;
                    document.getElementById("rate").textContent = "Rs. " + data.ratePerUnit.toFixed(2);
                    document.getElementById("total").textContent = "Rs. " + data.total.toFixed(2);
                    resultCard.style.display = "block";
                })
                .catch(err => {
                    errorBox.textContent = err.message || "An error occurred while fetching billing data.";
                    errorBox.classList.remove("d-none");
                });
        });
    };
</script>
</body>
</html>
