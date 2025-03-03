import consumer from "channels/consumer";

consumer.subscriptions.create("Accounts::AccountVisibilityChannel", {
  initialized() {
    // Called once when the subscription is created.
    this.update = this.update.bind(this);
  },

  connected() {
    // Called when the subscription is ready for use on the server
    this.install();
    this.update();
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    this.uninstall();
  },

  rejected() {
    // Called when the subscription is rejected by the server.
    this.uninstall();
  },

  update() {
    this.documentIsActive() ? this.visibility() : this.away();
  },

  install() {
    window.addEventListener("focus", this.update);
    window.addEventListener("blur", this.update);
    document.addEventListener("turbo:load", this.update);
    document.addEventListener("visibilitychange", this.update);
  },

  uninstall() {
    window.removeEventListener("focus", this.update);
    window.removeEventListener("blur", this.update);
    document.removeEventListener("turbo:load", this.update);
    document.removeEventListener("visibilitychange", this.update);
  },

  visibility() {
    // Calls `AppearanceChannel#appear(data)` on the server.
    this.perform("visibility", { visibility: "available" });
  },

  away() {
    // Calls `AppearanceChannel#away` on the server.
    this.perform("away");
  },

  documentIsActive() {
    console.log(document.visibilityState, document.hasFocus());
    return document.visibilityState === "visible" && document.hasFocus();
  },
});
