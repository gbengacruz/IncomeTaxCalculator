create or replace package tax_calc_api  as 
-- author       : gbenga cruz
-- description  : cloud payroll tax calcution
-- date         : january 25, 2023


   
     /*tax setup*/ 
    type pr_tax_setup_tapi_rec is record (
	 tax_rank          pr_tax_setup.tax_rank%type
	,amount_to         pr_tax_setup.amount_to%type
	,tax_setup_key     pr_tax_setup.tax_setup_key%type
	,amt_higher         pr_tax_setup.amt_higher%type
	,amount_from       pr_tax_setup.amount_from%type
	,tax_perc          pr_tax_setup.tax_perc%type
	,tax_desc          pr_tax_setup.tax_desc%type
	,tax_code          pr_tax_setup.tax_code%type
	);
    
	type pr_tax_setup_tapi_tab is table of pr_tax_setup_tapi_rec index by pls_integer;
    
     /*tax percentage*/ 
    type pr_tax_perc_tapi_rec is record (
	 tax_rank          pr_tax_setup.tax_rank%type
	,amount_to         pr_tax_setup.amount_to%type
	,amt_higher        pr_tax_setup.amt_higher%type
	,amount_from       pr_tax_setup.amount_from%type
	,tax_perc          pr_tax_setup.tax_perc%type
	,tax_code          pr_tax_setup.tax_code%type
	);
    

     /*get tax amount*/ 
    function fn_get_tax_amt(p_tax_code varchar2,
	                        p_gross_pay number) return number;

end tax_calc_api;
/