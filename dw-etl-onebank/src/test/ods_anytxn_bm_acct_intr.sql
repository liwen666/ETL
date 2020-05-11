create table public.ods_anytxn_bm_acct_intr
(
	txa_number varchar(32) not null,
	txa_type varchar(2) not null,
	txa_status varchar(1) default NULL::character varying,
	txa_business_module varchar(2) default NULL::character varying,
	txn_type varchar(5) default NULL::character varying,
	txn_code varchar(5) default NULL::character varying,
	txn_system_date timestamp,
	txn_organization_id varchar(4) default NULL::character varying,
	txn_effective_date timestamp,
	txn_effective_amnt numeric(18,2),
	txn_effective_currency varchar(3) default NULL::character varying,
	txn_posting_date date,
	txn_posting_time timestamp,
	txn_posting_amnt numeric(18,2),
	txn_posting_currency varchar(3) default NULL::character varying,
	txn_settle_amnt numeric(18,2),
	txn_settle_currency varchar(3) default NULL::character varying,
	txn_markup_percent numeric(18,6),
	txn_exchange_rate numeric(18,9),
	txn_plastic_number varchar(19) default NULL::character varying,
	txn_card_number_post varchar(19) default NULL::character varying,
	txn_lbs_info varchar(255) default NULL::character varying,
	txn_country varchar(3) default NULL::character varying,
	txn_region varchar(2) default NULL::character varying,
	txn_channel varchar(32) default NULL::character varying,
	txn_sub_channel_1 varchar(6) default NULL::character varying,
	txn_sub_channel_2 varchar(6) default NULL::character varying,
	txn_mechant_number varchar(16) default NULL::character varying,
	txn_material_flag varchar(1) default NULL::character varying,
	txn_pos_ind varchar(1) default NULL::character varying,
	txn_auth_code varchar(6) default NULL::character varying,
	txn_batch_number varchar(6) default NULL::character varying,
	txn_voucher_number varchar(6) default NULL::character varying,
	txn_reference_number varchar(12) default NULL::character varying,
	txn_cust_number varchar(32) default NULL::character varying,
	txn_cust_name varchar(60) default NULL::character varying,
	txn_cust_group_id varchar(6) default NULL::character varying,
	txn_intr_start_date date,
	txn_waive_intr_flag varchar(1) default NULL::character varying,
	txn_waive_latechg_flag varchar(1) default NULL::character varying,
	txn_chargeoff_flag varchar(1) default NULL::character varying,
	txn_chargeoff_amnt numeric(18,2),
	txn_chargeoff_date date,
	txn_chargeoff_rsn_cd varchar(4) default NULL::character varying,
	txn_total_amnt_due numeric(18,2),
	txn_orig_txa_number varchar(32) default NULL::character varying,
	txn_intr_table_id varchar(6) default NULL::character varying,
	txn_create_date timestamp not null,
	txn_last_update_date timestamp,
	txn_last_update_operator varchar(40) default NULL::character varying,
	txn_parent_txa_number varchar(32) default NULL::character varying,
	txn_late_charge_feetableid varchar(6) default NULL::character varying,
	txn_stmt_repayment_tableid varchar(6) default NULL::character varying,
	pro_cd varchar(6) default NULL::character varying,
	txn_orig_txa_type varchar(2) default NULL::character varying,
	txn_parent_txa_type varchar(2) default NULL::character varying,
	txn_connect_txa_number varchar(32) default NULL::character varying,
	txn_connect_txa_type varchar(2) default NULL::character varying,
	loan_banlance_type_flag varchar(2) default NULL::character varying,
	loan_order_number varchar(32) default NULL::character varying,
	loan_billing_tenor integer,
	product_code varchar(32) default NULL::character varying,
	cs_accu_total_accru_intr numeric(10),
	txn_cs_posting_amnt numeric(19,2),
	txn_capital_source_posting_amnt numeric(19,2),
	fus_id varchar(4) default NULL::character varying,
	joint_loan_flag varchar(1) default NULL::character varying,
	fus_percentage numeric(3,2),
	hp_posting_amnt numeric(18,2),
	flag varchar(5) default NULL::character varying,
	ot_posting_amnt numeric(18,2),
	create_time timestamp not null,
	last_update_time timestamp not null,
	real_channel varchar(23) not null
);


