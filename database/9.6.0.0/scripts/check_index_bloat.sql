/*
 * check_index_bloat.sql
 *
 * Check indexes for bloat. Use from psql as a postgresql superuser.
 *
 * The output is an sql script to reindex indexes that are bloated.
 * The output also contains the number of rows and pages in the index,
 * the estimated number of pages the index would need if densely
 * packed, and the "bloat factor". The bloat factor is the number of
 * times larger the index is currently compared to the packed state.
 * The output can be saved to a file for review or piped directly to
 * psql to * perform the reindexing.
 *
 * There are two parameters that may be adjusted by editting this
 * script: bloat_limit and statement_timeout. They are documented
 * inline.
 *
 */

set QUIET
\pset footer

-- Bloat factor to trigger reindexing, default is 4.
\set bloat_limit 4
\echo '\\set ECHO all'

-- Limit how long a reindex can run or wait for locks to avoid locking
-- the table for too long. In milliseconds, default is 30 minutes.
\echo set statement_timeout=1800000;   -- 30 minutes

/*
 * Find indexes with bloat_factor > bloat_limit.
 */
select 'reindex index '||nspname||'.'||relname||'; --' as "-- command --",
       reltuples as tuples, relpages as pages,
       (reltuples/estimated_pp)::int as packed,
       ((estimated_pp / (reltuples/relpages)) + 0.5)::int as bloat
  from (select nspname, x.relname, x.relpages, x.reltuples,
               count(*) as nkeys, sum(stawidth) as keysize,
               8000 / (16+sum(stawidth+2))::int as estimated_pp
          from pg_index i
          join pg_class x on indexrelid = x.oid
          join pg_class c on indrelid = c.oid
          join pg_namespace n on x.relnamespace = n.oid
          join pg_attribute a on c.oid = attrelid
          join pg_statistic s on c.oid = s.starelid and staattnum = attnum
          where attnum = ANY(indkey)
            and x.relpages > 3 and x.reltuples > 1
          group by 1, 2, 3, 4
       ) idxstats
  where estimated_pp / (reltuples/relpages) > :bloat_limit
  order by nspname, estimated_pp / (reltuples/relpages) desc;
\echo reset statement_timeout;

