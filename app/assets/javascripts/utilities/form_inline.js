document.addEventListener('turbolinks:load', function() {

  // Если использовать JS
  // var controls = document.querySelectorAll('.form-inline-link')

  // if (controls.length) {
  //  for (var i = 0; i < controls.length; i++) {
  //    controls[i].addEventListener('click', formInlineLinkHandler)
  //  }
  // }

  // Если использовать jQUERY
  $('.form-inline-link').on('click', formInlineLinkHandler)

  var errors = document.querySelector('.resource-errors')
                     
  if (errors) {
    var resourceId = errors.dataset.resourceId
    formInlineHandler(resourceId)
  }
})

/* Обрабатывать встроенные ссылки формы */
function formInlineLinkHandler(event) {
  event.preventDefault()

  var testId = this.dataset.testId
  formInlineHandler(testId)
  //console.log('testId')
}

/* Встроенный обработчик формы */
function formInlineHandler(testId) {
  /* JS: Найти элементы для дальнейшей работы:
         ссылку по котой кликнули; заголовак который нужно скрыть; форму которую нужно показать 
  */

  // var link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]')
  // var testTitle = document.querySelector('.test-title[data-test-id="' + testId + '"]')
  // var formInline = document.querySelector('.form-inline[data-test-id="' + testId + '"]')

  // if (formInline.classList.contains('hide')) {
  //   testTitle.classList.add('hide')
  //   formInline.classList.remove('hide')
  //   link.textContent = 'Cancel'
  // } else {
  //   testTitle.classList.remove('hide')
  //   formInline.classList.add('hide')
  //   link.textContent = 'Edit'
  // } 

  /* jQUERY: toggle - ф. автоматически определяет виден элемент или нет, 
             если виде - то ф.toggle элемент скрывает и наоборот
             $formInline.is(':visible')- если элемент(formInline.is) показан(visible) - то Cancel
  */
  var link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]')
  var $testTitle = $('.test-title[data-test-id="' + testId + '"]')
  var $formInline = $('.form-inline[data-test-id="' + testId + '"]')

  $testTitle.toggle()
  $formInline.toggle()  

  if ($formInline.is(':visible')) {
    link.textContent = 'Cancel'    
  } else {
    link.textContent = 'Edit'
  }
}
