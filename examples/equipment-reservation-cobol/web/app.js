const fields = document.querySelector('#fields');
const result = document.querySelector('#result');
const actor = document.querySelector('#actor');
let currentAction = 'SEARCH';

const shapes = {
  SEARCH: [['START','2030-01-01 10:00:00'], ['END','2030-01-01 11:00:00']],
  RESERVE: [['EQUIP_ID','1'], ['START','2030-01-01 10:00:00'], ['END','2030-01-01 11:00:00']],
  MINE: [],
  ADD: [['NAME','Camera'], ['DESCRIPTION','Shared kit']],
  MAINT: [['EQUIP_ID','1'], ['START','2030-01-01 10:00:00'], ['END','2030-01-01 11:00:00'], ['REASON','Service']],
  CANCEL: [['RSRV_ID','1']],
  PICKUP: [['RSRV_ID','1'], ['PICKUP','2030-01-01 10:00:00']],
  RETURN: [['USE_ID','1'], ['RETURN','2030-01-01 11:00:00']],
  HISTORY: [['EQUIP_ID','1']]
};

function showFields(action) {
  currentAction = action;
  fields.replaceChildren();
  for (const [name, value] of shapes[action]) {
    const label = document.createElement('label');
    label.textContent = name;
    const input = document.createElement('input');
    input.name = name;
    input.value = value;
    label.append(input);
    fields.append(label);
  }
}

async function submit() {
  result.textContent = 'Sending…';
  const body = [`ACTION=${currentAction}`, `ACTOR=${actor.value}`];
  for (const input of fields.querySelectorAll('input')) {
    body.push(`${input.name}=${input.value}`);
  }
  const response = await fetch('/eqrs', {
    method: 'POST',
    headers: {'Content-Type': 'text/plain'},
    body: body.join('\n')
  });
  result.textContent = await response.text();
}

for (const button of document.querySelectorAll('[data-action]')) {
  button.addEventListener('click', () => showFields(button.dataset.action));
}
document.querySelector('#submit').addEventListener('click', submit);
showFields(currentAction);
