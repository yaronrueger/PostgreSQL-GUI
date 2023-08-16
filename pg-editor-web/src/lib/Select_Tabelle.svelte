<script lang="ts">
  //Select Import:
  import { Button, P, Select, Label, Input } from 'flowbite-svelte';
  import { onMount } from 'svelte';
  import axios from 'axios';
  import { writable } from 'svelte/store';

  //Tabelle Import:
  import {Table, TableBody, TableBodyCell, TableBodyRow, TableHead, TableHeadCell, TableSearch } from 'flowbite-svelte';

  //Select:
  let selected: string = null;
  let tables: string[] = [];
  let test = writable<Array<{value: string, name: string}>>([]);

  onMount(async () => {
      axios.get('http://yourAPI.de/tables')
      .then(res => {
          tables = res.data;

          test.update(t => {
            for (let i = 0; i < tables.length; i++){
              t.push({value:tables[i], name: tables[i]});
            }
              return t;
          });
      })
      .catch(err => console.error(err))
  });
  
  //Tabelle:
  let dataStructure = writable<Array<string>>([]);
  let data = writable<Array<Array<string>>>([]);
  let filteredData = writable<Array<Array<string>>>([]);
  let filterValues = Array($dataStructure.length).fill("");
  let count = [];
  let showModal = false;

  function getTablestructureData(){
      axios
      .get('http://yourAPI.de/tablestructure/' + {selected})
      .then(res => {
        dataStructure.set(res.data); // Verwenden Sie die 'set()' Methode, um den Wert von 'data' zu aktualisieren
      })
      .catch(err => console.error(err));
  }

  function getTableData(){
      axios
      .get('http://yourAPI.de/tabledata/' + {selected})
      .then(res => {
        data.set(res.data); 
        filteredData.set(res.data);
      })
      .catch(err => console.error(err));
  }

  function filterData() {
    filteredData.set(
      $data.filter(row =>
        row.every((cell, index) =>
          !filterValues[index] || cell.includes(filterValues[index])
        )
      )
    );
  }

  function toggleModal() {
    showModal = !showModal;
  }

  function commitData(){
    
  }

  $: {
    if (selected) {
      getTablestructureData();
      getTableData();
      count = ["Add"]
    }
  }
</script>
<!-->
  Select:
<-->
<div class="block">
<main class = "selectMain">
  {#key $test}
      <Label>
          <Select class="mt-2" items={$test} bind:value={selected} />
      </Label>
  {/key}
</main>

<!-->
  Tabelle:
<-->
<main class="tabelleMain">
  <div class="tableContainer">
  <Table id="tableSize" hoverable={true}>
    <TableHead defaultRow={false}>
        {#each count as number}
        <tr>
        <TableHeadCell>
          <button id="addButton" on:click={toggleModal} class="font-medium text-primary-600 hover:underline dark:text-primary-500">
            <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512">
              <style>svg{fill:#000000}</style><path d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"/></svg>
            </button>
            </TableHeadCell>
        {#each $dataStructure as inputData, index}
          <TableHeadCell>
            <Input
              id="small-input"
              size="sm"
              placeholder={inputData}
              bind:value={filterValues[index]}
              on:input={filterData}
            />
          </TableHeadCell>
        {/each}
      </tr>
      {/each}
      <tr>
        {#each count as number}
        <TableHeadCell>
          <span class="sr-only"></span>
        </TableHeadCell>
        {/each}
        {#each $dataStructure as item}
          <TableHeadCell>{item}</TableHeadCell>
        {/each}
      </tr>
    </TableHead>
    <TableBody>
      {#each $filteredData as row}
      <TableBodyRow>
        <TableBodyCell>
          <a href="/tables" class="font-medium text-primary-600 hover:underline dark:text-primary-500">
            <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512">
              <path d="M362.7 19.3L314.3 67.7 444.3 197.7l48.4-48.4c25-25 25-65.5 0-90.5L453.3 19.3c-25-25-65.5-25-90.5 0zm-71 71L58.6 323.5c-10.4 10.4-18 23.3-22.2 37.4L1 481.2C-1.5 489.7 .8 498.8 7 505s15.3 8.5 23.7 6.1l120.3-35.4c14.1-4.2 27-11.8 37.4-22.2L421.7 220.3 291.7 90.3z"/></svg>
          </a>
        </TableBodyCell>
        {#each row as cell}
          <TableBodyCell>{cell}</TableBodyCell>
        {/each}
      </TableBodyRow>
    {/each}
  </TableBody>
  </Table>
  </div>
</main>
</div>

<!-->
  Add-Fenster:
<-->
{#if showModal}
  <div class="modal">
    <h3>Hinzufügen</h3>
    <div class="inputs">
      {#each $dataStructure as inputData}
        <Input
          id="small-input"
          size="sm"
          placeholder={inputData}
          on:input={filterData}
        />
      {/each}
    </div>
    <div class="buttns">
      <Button color="green" on:click={commitData}>Commit</Button>
      <Button on:click={toggleModal}>Schließen</Button>
    </div>
  </div>
{/if}


<style>
  #addButton{
    background-color: transparent !important;
  }
  .block{
    background-color: #363636;
    padding-top: 15px;
    padding-left: 15px;
    padding-right: 15px;
    padding-bottom: 15px;
    border-radius: 14px;
  }
  .selectMain{
    padding-bottom: 25px;
    display: flex;
    justify-content:center;
    align-items: flex-start;
    flex-direction: column;
  }
  .tableContainer {
    width: 100%;
    max-height: 75vh;
    overflow-x: auto;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
  }
  .modal {
    /* Styles für das Modal */
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color:#363636;
    padding: 20px;
    border-radius: 5px;
    z-index: 2;
    text-align: center;
  }
  .inputs{
    padding-top: 10px;
  }
  .buttns{
    padding-top: 10px;
  }
</style>
