create or replace package body tax_calc_api as
-- Author       : Gbenga Cruz
-- Description  : Cloud Payroll Tax calcution
-- Date         : January 25, 2023


    -- Get Tax Amount
    function fn_get_tax_amt(p_tax_code varchar2, p_gross_pay number) return number as
    v_tax_amt    pr_tax_setup.amount_from%TYPE;
    v_gross_amt  pr_tax_setup.amount_from%TYPE;
    v_decimal NUMBER:=2; 	
    BEGIN
		 v_tax_amt   := 0;
		 v_gross_amt := p_gross_pay;
         --UK Tax
		 IF p_tax_code = 'UK' THEN 

                    for uk in (select tax_rank,
                                     amount_from, 
                                     amount_to, 
                                     tax_perc
                              from pr_tax_setup
                              where tax_code = p_tax_code order by tax_rank
                            ) 
                     loop                             
                                if v_gross_amt >= uk.amount_from then
                                   v_tax_amt  := round(v_tax_amt + (((least(v_gross_amt,uk.amount_to)-uk.amount_from))*uk.tax_perc),v_decimal);
                                end if;

                    end loop;   
            end if;

           --Nigeria Tax
           IF p_tax_code = 'NG' THEN 

                    for ng in (select tax_rank,
                                     amount_from, 
                                     amount_to, 
                                     tax_perc,
                                     amt_higher,
                                     relief_perc1,
                                     relief_perc2
                              from pr_tax_setup
                              where  tax_code = p_tax_code order by tax_rank
                            ) 
                     loop 
                                if  ng.tax_rank = 0 then
                                v_gross_amt := v_gross_amt - (greatest((v_gross_amt*ng.relief_perc1),ng.amt_higher)+(v_gross_amt*ng.relief_perc2));
                                end if;

                                if v_gross_amt >= ng.amount_from then
                                   v_tax_amt  := round(v_tax_amt + (((least(v_gross_amt,ng.amount_to)-ng.amount_from))*ng.tax_perc),v_decimal);
                                end if;

                    end loop;   
            end if;

         --Canada Tax
         IF p_tax_code = 'CA' THEN 

                    for ca in (select tax_rank,
                                     amount_from, 
                                     amount_to, 
                                     tax_perc
                              from pr_tax_setup
                              where tax_code = p_tax_code order by tax_rank
                            ) 
                     loop                             
                                if v_gross_amt >= ca.amount_from then
                                   v_tax_amt  := round(v_tax_amt + (((least(v_gross_amt,ca.amount_to)-ca.amount_from))*ca.tax_perc),v_decimal);
                                end if;

                    end loop;   
            end if;
		return v_tax_amt;
	exception when no_data_found then
	return null;
    when others then
    raise;	
    end fn_get_tax_amt;

end tax_calc_api;
/