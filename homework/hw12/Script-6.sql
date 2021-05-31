drop type _desc_stats_simple_agg_accum_type

create type _desc_stats_simple_agg_accum_type AS (
	n bigint,
	min double precision,
	max double precision,
	m1 double precision,
	m2 double precision,
	m3 double precision,
	m4 double precision
);

drop type _desc_stats_simple_agg_result_type

create type _desc_stats_simple_agg_result_type AS (
	count bigint,
	min double precision,
	max double precision,
	mean double precision,
	variance double precision, 
	skewness double precision,
	kurtosis double precision 
);


drop function _desc_stats_simple_agg_accumulator

create or replace function _desc_stats_simple_agg_accumulator(_desc_stats_simple_agg_accum_type, double precision)
returns _desc_stats_simple_agg_accum_type AS '
DECLARE
	a ALIAS FOR $1; -- This is for _desc_stats_simple_agg_accum_type type, we are just calling it a
	x ALIAS FOR $2; -- x represents the double precision value that we pass in
	n1 bigint;
	delta double precision;
	delta_n double precision;
	delta_2 double precision;
	num double precision;
	
BEGIN
	IF x IS NOT NULL then
		n1 = a.n;
		a.n = a.n + 1;
		delta = x - a.m1;
		delta_n = delta / a.n;
		a.m1 = a.m1 + delta_n;

		
		a.m4 = a.m4 + term1 * delta_2 * (a.n*a.n - 3*a.n + 3) + 6 * delta_2 * a.m2 - 4 * delta_n * a.m3;
		a.m3 = a.m3 + term1 * delta_n * (a.n - 2) - 3 * delta_n * a.m2;
		a.m2 = a.m2 + term1;
		a.min = least(a.min, x);
		a.max = greatest(a.max, x);

	end if;
	
	RETURN a;
END;
'
language plpgsql;

drop function _desc_stats_simple_finalizer

create or replace function _desc_stats_simple_finalizer(_desc_stats_simple_agg_accum_type)
returns _desc_stats_simple_agg_result_type AS '
BEGIN
	RETURN row(
		$1.n, 
		$1.min,
		$1.max,
	    $1.a,
	    $1.b / nullif(($1.n - 1.0), 0), 
	    case when $1.b = 0 then null else sqrt($1.n) * $1.c / nullif(($1.b ^ 1.5), 0) end, 
	    case when $1.b = 0 then null else $1.n * $1.c / nullif(($1.b * $1.b) - 3.0, 0) end
	);
END;
'
language plpgsql;


drop aggregate desc_stats_agg(double precision);

create or replace aggregate desc_stats_agg(double precision) (
	sfunc = _desc_stats_simple_agg_accumulator,
	stype = _desc_stats_simple_agg_accum_type,
	finalfunc = _desc_stats_simple_finalizer,
	initcond = '(0,,, 0, 0, 0, 0)'
);

