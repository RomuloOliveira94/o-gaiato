import consumer from "channels/consumer";

function clearCookie(name) {
  document.cookie = name + "=; Path=/; Expires=Thu, 01 Jan 1970 00:00:00 GMT;";
}

consumer.subscriptions.create(
  { channel: "UserRedirectChannel" },
  {
    received(data) {
      if (data.redirect_to) {
        clearCookie("_o_gaiato_session");
        clearCookie("player_id");
        //window.location.href = data.redirect_to;
      }
    },
  }
);
