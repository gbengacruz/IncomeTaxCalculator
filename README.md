# IncomeTaxCalculator
 Income Tax Calculator
 
<P>declare</P>
<P>l_result number;</P>
<P>begin</P>

<P>l_result := tax_calc_api.fn_get_tax_amt(p_tax_code => 'UK', -- ('UK','CA','NG')</P>
	                                       <P>p_gross_pay => 42000</P> --Taxable gross pay
                                         <P>);</P>

<P>dbms_output.put_line(l_result);</P>
<P>end;</P>
