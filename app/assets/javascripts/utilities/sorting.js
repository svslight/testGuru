document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.sort-by-title');
  //console.log(control)

  // checking for the existence of the sort-by-title class on the page
  if (control) { control.addEventListener('click', sortRowsByTitle) }
})

// Функция сортировки
function sortRowsByTitle() {
  var table = document.querySelector('table')

  // NodeList (rows: переменная воозвращает ссылку на NodeList)
	// https://developer.mozilla.org/ru/docs/Web/API/NodeList
  var rows = table.querySelectorAll('tr')       // Выберем все элементы таблицы
  var sortedRows = []                           // Переменная для массива с отсортированными строками

  // Select all table rows except the first one which is the header
  for (var i = 1; i < rows.length; i++) {     // В цикле получаем массив с не отсортированными строкам
    sortedRows.push(rows[i])
  }
  
  // var arrowUp = this.querySelector('.octicon-arrow-up')
  // console.log(arrowUp)
  // sortedRows.sort(compareRowsAsc)

  // Выбор сортировки
  if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc)
    this.querySelector('.octicon-arrow-up').classList.remove('hide')
    this.querySelector('.octicon-arrow-down').classList.add('hide')
  } else {
    sortedRows.sort(compareRowsDesc)
    this.querySelector('.octicon-arrow-down').classList.remove('hide')
    this.querySelector('.octicon-arrow-up').classList.add('hide')
  }  

  // Creating a new html document in memory
  var sortedTable = document.createElement('table')
  
  // Adding a css class using JS
  sortedTable.classList.add('table')
  
  // Adding the first row of the title from the rows collection
  sortedTable.appendChild(rows[0])                 // Добавим первую строчку с заголовком

  // Add the sorted array to the table in memory
  for (var i = 0; i < sortedRows.length; i++) {    // В цикле просматриваем отсортир массив
    sortedTable.appendChild(sortedRows[i])        // с помощ ф-ции appendChild добавим в табл sortedTable
  }

  // Put a table from memory into an existing
  table.parentNode.replaceChild(sortedTable, table)    // Замена таблицы                                                    

  // console.log(sortedRows)
}

// Функция сравнения по возрастанию
function compareRowsAsc(row1, row2) {
  var testTitle1 = row1.querySelector('td').textContent
  var testTitle2 = row2.querySelector('td').textContent

  if (testTitle1 < testTitle2) { return -1 }
  if (testTitle1 > testTitle2) { return 1 }
  return 0
}

// Функция сравнения по убыванию
function compareRowsDesc(row1, row2) {
  var testTitle1 = row1.querySelector('td').textContent
  var testTitle2 = row2.querySelector('td').textContent

  if (testTitle1 < testTitle2) { return 1 }
  if (testTitle1 > testTitle2) { return -1 }
  return 0
}
