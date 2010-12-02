{*?template charset=UTF-8*}

<div id="message">
	<p>{$message}</p>
</div>

<div id="data">
	<ul>
		<li>Ordine: {$order_id}</li>
		<li>Nome: {$view_parameters.first-name}</li>
		<li>Cognome: {$view_parameters.last-name}</li>
		<li>Email: {$view_parameters.email}</li>
		<li>Azienda: {$view_parameters.street1}</li>
		<li>Indirizzo: {$view_parameters.street2}</li>
		<li>Luogo: {$view_parameters.place}</li>
		<li>Cap: {$view_parameters.zip}</li>
		<li>Provincia: {$view_parameters.state}</li>
		<li>Paese: {$view_parameters.country}</li>
		<li>Commenti: {$view_parameters.comment}</li>
	</ul>
</div>