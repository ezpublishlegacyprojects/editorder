<?php
// library for template functions
include_once( "kernel/common/template.php" );

// take current object of type eZModule
$Module = $Params['Module'];

$tpl = eZTemplate::factory();

// read parameter Ordered View
// for example .../modul1/list/view/5
$orderID = $Params['orderID'];
$order = eZOrder::fetch( $orderID );

$tpl->setVariable( 'order_id', $orderID );
$tpl->setVariable('order', $order);

// use find/replace (parsing) in the template and save the result for $module_result.content
$Result ['content'] = $tpl->fetch ( 'design:editorder/edit.tpl' );
?>