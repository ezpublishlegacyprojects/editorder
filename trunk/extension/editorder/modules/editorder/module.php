<?php

$Module = array( 'name' => 'Edit Order' );
$ViewList = array();

$ViewList['edit'] = array('script' => 'edit.php',
						  'functions' => array('edit'),
						  'params' => array('orderID'),
                          'default_navigation_part' => 'ezshopnavigationpart'
					  	 );
					  	 
$ViewList['save'] = array('script' => 'save.php',
						  'functions' => array('edit'),
						  'params' => array('orderID'),
						  'single_post_actions' => array('ConfirmButton' => 'Modifica',
	                          							 'CancelButton' => 'Indietro'
	                                    			    ),
                          'default_navigation_part' => 'ezshopnavigationpart'
						 );
						 
// The entries in the user rights
// are used in the View definition, to assign rights to own View functions
// in the user roles

$FunctionList['edit'] = array();
?>