{*?template charset=utf-8*}
<div class="maincontentheader">
  <h1>{"Order %order_id [%order_status]"|i18n("design/standard/shop",,
       hash( '%order_id', $order.order_nr,
             '%order_status', $order.status_name ) )}</h1>
</div>

<b>{"Customer"|i18n("design/standard/shop")}</b>
<br />
<form name="editorder" method="post" action={concat( '/editorder/save/', $order_id)|ezurl}>
	<div id="userdata">
		<label>{"Name"|i18n("design/standard/shop")}</label>
		<input type="text" id="name" class="user" name="name" value="{$order.account_information.first_name|wash} {$order.account_information.last_name}" />
		
		<label>E-mail</label>
		<input type="text" id="email" class="user" name="email" value="{$order.account_information.email|wash}" />
		
		<label>{"Company"|i18n("design/standard/shop")}</label>
		<input type="text" id="street1" class="user" name="street1" value="{$order.account_information.street1|wash}" />
		
		<label>{"Street"|i18n("design/standard/shop")}</label>
		<input type="text" id="street2" class="user" name="street2" value="{$order.account_information.street2|wash}" />
		
		<label>{"Zip"|i18n("design/standard/shop")}</label>
		<input type="text" id="zip" class="user" name="zip" value="{$order.account_information.zip|wash}" />
		
		<label>{"Place"|i18n("design/standard/shop")}</label>
		<input type="text" id="place" class="user" name="place" value="{$order.account_information.place|wash}" />
		
		<label>{"State"|i18n("design/standard/shop")}</label>
		<input type="text" id="state" class="user" name="state" value="{$order.account_information.state|wash}" />
		
		<label>{"Country/region"|i18n("design/standard/shop")}</label>
		{include uri='design:shop/country/edit.tpl' select_name='country' select_size=5 current_val=$order.account_information.country use_country_code=1}
		
		<label>{"Comment"|i18n("design/standard/shop")}</label>
		<textarea id="comment" class="user" name="comment" rows=5 cols=50>{$order.account_information.comment|wash}</textarea>
	</div>
	<input type="submit" id="editCustomer" name="ConfirmButton" value="Modifica" />
	<input type="submit" id="cancelEdit" name="CancelButton" value="Indietro" />
</form>
{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
         $locale = false()
         $symbol = false()}

{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{/if}

<br />

<b>{"Product items"|i18n("design/standard/shop")}</b>
<table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
        <th>
        {"Product"|i18n("design/standard/shop")}
        </th>
        <th>
        {"Count"|i18n("design/standard/shop")}
        </th>
        <th>
        {"VAT"|i18n("design/standard/shop")}
        </th>
        <th>
        {"Price ex. VAT"|i18n("design/standard/shop")}
        </th>
        <th>
        {"Price inc. VAT"|i18n("design/standard/shop")}
        </th>
        <th>
        {"Discount"|i18n("design/standard/shop")}
        </th>
        <th>
        {"Total price ex. VAT"|i18n("design/standard/shop")}
        </th>
        <th>
        {"Total price inc. VAT"|i18n("design/standard/shop")}
        </th>
        <th>
        &nbsp;
        </th>
</tr>
{section name=ProductItem loop=$order.product_items show=$order.product_items sequence=array(bglight,bgdark)}
<tr>
        <td class="{$ProductItem:sequence}">
        <a href={concat("/content/view/full/",$ProductItem:item.node_id,"/")|ezurl}>{$ProductItem:item.object_name}</a>
        </td>
        <td class="{$ProductItem:sequence}">
        {$ProductItem:item.item_count}
        </td>
        <td class="{$ProductItem:sequence}">
        {$ProductItem:item.vat_value} %
        </td>
        <td class="{$ProductItem:sequence}">
        {$ProductItem:item.price_ex_vat|l10n( 'currency', $locale, $symbol )}
        </td>
        <td class="{$ProductItem:sequence}">
        {$ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
        </td>
        <td class="{$ProductItem:sequence}">
        {$ProductItem:item.discount_percent}%
        </td>
        <td class="{$ProductItem:sequence}">
        {$ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
        </td>
        <td class="{$ProductItem:sequence}">
        {$ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}
        </td>
</tr>
{/section}
</table>

<b>{"Order summary"|i18n("design/standard/shop")}:</b><br />
<table class="list" cellspacing="0" cellpadding="0" border="0">
<tr>
    <td class="bgdark">
    {"Subtotal of items"|i18n("design/standard/shop")}:
    </td>
    <td class="bgdark">
    {$order.product_total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td class="bgdark">
    {$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>

{section name=OrderItem loop=$order.order_items show=$order.order_items sequence=array(bglight,bgdark)}
<tr>
        <td class="{$OrderItem:sequence}">
        {$OrderItem:item.description}:
        </td>
        <td class="{$OrderItem:sequence}">
        {$OrderItem:item.price_ex_vat|l10n( 'currency', $locale, $symbol )}
        </td>
        <td class="{$OrderItem:sequence}">
        {$OrderItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
        </td>
</tr>
{/section}
<tr>
    <td class="bgdark">
    <b>{"Order total"|i18n("design/standard/shop")}</b>
    </td>
    <td class="bgdark">
    <b>{$order.total_ex_vat|l10n( 'currency', $locale, $symbol )}</b>
    </td>
    <td class="bgdark">
    <b>{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}</b>
    </td>
</tr>
</table>


<b>{"Order history"|i18n("design/standard/shop")}:</b><br />
<table class="list" cellspacing="0" cellpadding="0" border="0">
{let order_status_history=fetch( shop, order_status_history,
                                 hash( 'order_id', $order.order_nr ) )}
{section var=history loop=$order_status_history sequence=array(bglight,bgdark)}
<tr>
    <td class="{$history.sequence} date">{$sel_pre}{$history.modified|l10n( shortdatetime )}</td>
        <td class="{$history.sequence}">{$history.status_name|wash}</td>
</tr>
{/section}
{/let}
</table>
