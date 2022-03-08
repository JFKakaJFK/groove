module layout

imports src/theme
imports src/utils

template layout(){
  title { "Groove" }
  styled()[class="flex flex-col"]{
    navbar()

    <div class="flex-1 grid px-4 py-8" style="place-items: start center;" all attributes>
      placeholder "~G.rootId" {
        elements
      }
    </div>

    footer()
  }
}