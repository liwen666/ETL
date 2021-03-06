create table public.ods_anytxn_bm_cc_loan_plan
(
	plan_detl_id integer not null,
	status varchar(3) default NULL::character varying,
	loan_order_number varchar(32) default NULL::character varying,
	billing_tenor integer not null,
	delq_days integer,
	curr_total_amnt numeric(18,2),
	cs_curr_total_amnt numeric(18,2),
	principal_amnt numeric(18,2),
	interest_amnt numeric(18,2),
	service_fee numeric(18,2),
	cs_service_fee numeric(18,2),
	over_due_amnt numeric(18,2),
	exempt_amnt numeric(18,2),
	hp_curr_total_amnt numeric(18,2),
	hp_principal_amnt numeric(18,2),
	hp_interest_amnt numeric(18,2),
	hp_service_fee numeric(18,2),
	ot_curr_total_amnt numeric(18,2),
	ot_principal_amnt numeric(18,2),
	ot_interest_amnt numeric(18,2),
	ot_service_fee numeric(18,2),
	payment_due_date date,
	effective_date date,
	effective_time timestamp,
	card_number varchar(20) default NULL::character varying,
	bank_name varchar(256) default NULL::character varying,
	acq_ref_nbr varchar(32) default NULL::character varying,
	auto_pymt_ind varchar(1) default NULL::character varying,
	payment_flag varchar(1) default NULL::character varying,
	is_cmps_over integer,
	compensatory_flag varchar(1) default NULL::character varying,
	bal_trans_flag varchar(1) default NULL::character varying,
	last_update_business_date date,
	last_update_time timestamp not null,
	create_time timestamp not null,
	rep_grace integer,
	ovd_status varchar(1) default NULL::character varying,
	start_date_option varchar(1)
);

alter table public.ods_anytxn_bm_cc_loan_plan owner to gpadmin;

create unique index if not exists ods_anytxn_bm_cc_loan_plan_pkey
	on public.ods_anytxn_bm_cc_loan_plan (plan_detl_id);

