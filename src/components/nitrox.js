const NITROX_PROXY = import.meta.env.VITE_NITROX_PROXY;

class Nitrox {
  static async service(service) {
    const response = await fetch('/config/environment.json');
    const environment = await response.json();

    let hostname = typeof window === 'undefined' ? undefined : window.location.hostname;

    const TUNNEL = `http://${environment.NITROX_PROXY}`;
    const PROXY = `http://${environment.NITROX_PROXY}`;

    if (hostname === 'localhost') {
      return `${PROXY}/nitrox-${service}`;
    } else {
      return `${TUNNEL}/nitrox-${service}`;
    }
  }
}

export default Nitrox;
