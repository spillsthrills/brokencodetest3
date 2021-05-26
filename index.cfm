<cfinclude template="header.cfm">

<cfhttp url="#cgi.http_host#/#jsonfile#" method="get">
<!--- create CF object && simplify naming --->
<cfset Animals = deserializeJSON(cfhttp.fileContent).Animals>
<!--- make sure variable exists --->
<cfset Match = 0 />


<cfoutput>
    <h2>What Does The Fox Say?</h2>
    <form  class="form-inline" id="foxForm" method ="post">
        <div class="form-group">
            <select class="form-control" name="input_say" id="input_say">
            <option value= "">CHOOSE A SOUND</option>
            <!--- fix attribute on cfloop --->
                <cfloop array="#Animals#" index="i">
                    <option value= "#i.noise#">#i.noise#</option>
                </cfloop>
            </select>
        </div>
        <!--- uncomment --->
        <input type="hidden" name="qCheck" value="Fox">

        <button type="Submit" class="btn btn-default CheckSound" name="CheckSound">Check Sounds</button>
    </form>
    <cfif isDefined("form.CheckSound")>
        <!--- by fixing naming at top it now refers to the array and not struct --->
        <cfloop array="#Animals#" index="i">
            <cfif i.Name IS form.qchecK>
                <cfif form.input_say IS i.Noise>
                    <cfset Match = 1>
                </cfif>
            </cfif>
        </cfloop>
        <cfif Match IS 1 >
            <h1>Congrats! You Found the Fox</h1>
            <img src="https://i.gifer.com/5sbR.gif">
        <cfelse>
            <img src="https://i.gifer.com/7FJ4.gif">
        </cfif>
   </cfif>
</cfoutput>
<script>
    $('.CheckSound').click(function() {
        if($('#input_say').val() == '') {
            return false
        } else {
            $('foxForm').submit();
        }
    });
</script>