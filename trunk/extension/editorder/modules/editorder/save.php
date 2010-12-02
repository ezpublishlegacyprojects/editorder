<?php
// library for template functions
include_once( "kernel/common/template.php" );
include_once('lib/ezfile/classes/ezlog.php');

// take current object of type eZModule
$module = $Params['Module'];
$orderID = $Params['orderID'];

$tpl = eZTemplate::factory();
$http = eZHTTPTool::instance();

//var_dump($module);

if ($module->isCurrentAction('Modifica'))
{
	eZLog::write ( 'modifica in corso dell\'ordine '.$orderID, 'editorder.log', 'var/log');

	//$orderID = $http->postVariable('order_id');
	$order = eZOrder::fetch( $orderID );
	
	/* The only necessary values are those that are indicated in the conditional expression below
	 * Those that are not needed are retrieved with the postVariable method using as a fallback value
	 * the empty string
	 */
	if ($http->hasPostVariable('name') && $http->hasPostVariable('email') 
		&& $http->hasPostVariable('street2') && $http->hasPostVariable('zip')
		&& $http->hasPostVariable('place') && $http->hasPostVariable('country'))
	{
		$name = explode(' ', $http->postVariable('name'));
		
		$view_parameters = array('first-name' => $name[0],
								 'last-name' => $name[1],
								 'email' => $http->postVariable('email'),
								 'street1' => $http->postVariable('street1', ''),
								 'street2' => $http->postVariable('street2'),
								 'zip' => $http->postVariable('zip'),
								 'place' => $http->postVariable('place'),
								 'state' => $http->postVariable('state', ''),
								 'country' => $http->postVariable('country'),
								 'comment' => $http->postVariable('comment', ''));
		
		$tpl->setVariable('view_parameters', $view_parameters);
		
		$db = eZDB::instance();
        $db->begin();

        $doc = new DOMDocument( '1.0', 'utf-8' );

        $root = $doc->createElement( "shop_account" );
        $doc->appendChild( $root );

        foreach($view_parameters as $key => $param)
        {
        	$root->appendChild( $doc->createElement( $key, $param ) );
        }

        $xmlString = $doc->saveXML();

        $order->setAttribute( 'data_text_1', $xmlString );
        
        // logging the actual user who did the update
        $user = eZUser::currentUser();
        $order->setAttribute( 'account_identifier',  $user->attribute('login'));

        //$order->setAttribute( 'ignore_vat', 0 );

        $order->store();
        $message = $db->commit();
        
        if ($message)
        {
        	$tpl->setVariable('message', 'Modifica effettuata con successo');
        } else {
        	$tpl->setVariable('message', 'La modifica non è andata a buon fine, ma nessun dato è andato perso. L\'errore è stato segnalato. Se questo errore si verifica nuovamente, contattare l\'assistenza.');
        	eZLog::write ( 'errore nella registrazione della modifica nel db: '.$db->errorMessage(), 'editorder.log', 'var/log');
        }
        
	}
	
	$tpl->setVariable( 'order_id', $orderID );
	$tpl->setVariable('order', $order);	

	$Result ['content'] = $tpl->fetch ( 'design:editorder/save.tpl' );
} else {
	$module->redirectTo( '/shop/orderlist/' );
}

?>