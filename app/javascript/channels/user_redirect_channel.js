import consumer from "channels/consumer";

function handleLeave(leave) {
  fetch(leave, {
    method: "DELETE",
    headers: {
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      Accept: "application/json",
    },
  })
    .then((response) => {
      window.location.href = "/";
    })
    .catch((error) => {
      console.error("Error during redirect:", error);
    });
}

consumer.subscriptions.create(
  { channel: "UserRedirectChannel" },
  {
    received(data) {
      if (data.leave) {
        handleLeave(data.leave);
      }
    },
  }
);
