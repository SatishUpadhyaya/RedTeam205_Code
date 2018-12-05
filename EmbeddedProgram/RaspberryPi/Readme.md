<h2>Description of the programs</h2>
<ul>
<li><b>changeAPI_state.py:</b> changes the state of the bike to stolen</li>
  <ul>
    <li><b>Request(s) performed:</b> get and put</li>
  </ul>
  <br>
<li><b>changeLoc.py:</b> changes location based on the data from the GPS sensor</li>
  <ul>
    <li><b>Request(s) performed:</b> get and put</li>
  </ul>
  <br>
<li><b>getStat.py:</b> changes the state of the bike (armed/unarmed) then calls turnoff.py or turnon.py and testscript.py based on the current state in the API</li>
  <ul>
    <li><b>Request(s) performed:</b> get</li>
  </ul>
  <br>
<li><b>login.py:</b> login to the users account, save the jwt token in the text file</li>
  <ul>
    <li><b>Request(s) performed:</b> post</li>
  </ul>
  <br>
<li><b>main.py:</b> task scheduler</li>
  <br>
<li><b>testscript.py:</b> When the bike is stolen (moved), calls changeAPI_state.py</li>
  <br>
<li><b>turnoff.py:</b> disarms the bike</li>
  <br>
<li><b>turnon.py:</b> arms the bike</li>
</ul>
