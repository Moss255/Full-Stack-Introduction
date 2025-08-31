const API_URL = "http://127.0.0.1:8000";

// Function to fetch and display all users
async function fetchUsers() {
    try {
        const response = await fetch(`${API_URL}/users/`);
        const users = await response.json();
        
        const tableBody = document.querySelector("#userTable tbody");
        tableBody.innerHTML = ''; // Clear existing data
        
        users.forEach(user => {
            const row = document.createElement("tr");
            row.innerHTML = `
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>
                    <button class="delete-btn" data-id="${user.id}">Delete</button>
                </td>
            `;
            tableBody.appendChild(row);
        });
        
        // Add event listeners to all delete buttons
        document.querySelectorAll(".delete-btn").forEach(button => {
            button.addEventListener("click", handleDelete);
        });
        
    } catch (error) {
        console.error("Error fetching users:", error);
    }
}

// Function to handle form submission
async function handleAddUser(event) {
    event.preventDefault();
    
    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    
    try {
        const response = await fetch(`${API_URL}/users/`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ name, email }),
        });
        
        if (response.ok) {
            document.getElementById("addUserForm").reset(); // Clear the form
            fetchUsers(); // Refresh the user list
        } else {
            console.error("Failed to add user:", await response.json());
        }
    } catch (error) {
        console.error("Error adding user:", error);
    }
}

// Function to handle user deletion
async function handleDelete(event) {
    const userId = event.target.getAttribute("data-id");
    
    try {
        const response = await fetch(`${API_URL}/users/${userId}`, {
            method: "DELETE",
        });
        
        if (response.ok) {
            fetchUsers(); // Refresh the user list
        } else {
            console.error("Failed to delete user:", await response.json());
        }
    } catch (error) {
        console.error("Error deleting user:", error);
    }
}

// Attach event listener to the form
document.getElementById("addUserForm").addEventListener("submit", handleAddUser);

// Initial fetch to load users when the page loads
document.addEventListener("DOMContentLoaded", fetchUsers);