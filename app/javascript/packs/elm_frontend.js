import Elm from '../Main'

document.addEventListener('DOMContentLoaded', () => {
  const target = document.getElementById('root')

  document.body.appendChild(target)
  Elm.Main.embed(target, {baseUrl: window.location.origin})
})
