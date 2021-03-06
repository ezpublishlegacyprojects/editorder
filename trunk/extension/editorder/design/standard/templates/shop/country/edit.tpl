{if is_set( $countries ) | not }
    {if $use_country_code}
        {def $countries = fetch( 'content', 'country_list' )}
    {else}
    	{def $countries = ezini('CountrySettings','Countries', 'content.ini' )}
    {/if}
{/if}
{default $max_len = 30
    $select_size = 1}

<select name="{$select_name}" size="{$select_size}">
{if and( is_set( $default_val ), is_set( $default_desc ) )}
    <option {if eq( $current_val, false )}selected="selected"{/if} value="{$default_val}">{$default_desc}</option>
{/if}
{foreach $countries as $country}
    <option 
    {if $use_country_code}
        {if eq( $country['Name'], $current_val )}
            selected="selected"
        {/if}
        value="{$country['CodiceStato']}" > {$country['Name']|shorten($max_len)}
    {else}
        {if eq( $country, $current_val )}
            selected="selected"
        {/if}
        value="{$country}" > {$country|shorten($max_len)}
    {/if}
    </option>
{/foreach}
</select>
{/default}
