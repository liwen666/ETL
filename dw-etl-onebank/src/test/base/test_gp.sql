drop table test_gp;

create table public.test_gp
(
	txa_number varchar(32) not null,
	txn_organization_id varchar(4) default NULL::character varying,
	txa_type varchar(2) default NULL::character varying,
	 CONSTRAINT test_gp_pk PRIMARY KEY (txa_number)
);



