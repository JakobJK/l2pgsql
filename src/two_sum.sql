-- https://leetcode.com/problems/two-sum/

create or replace function two_sum(nums int[], target int) returns int[] as $$ 
    declare result int[]; 
    begin
    drop table if exists two_sum_table;
    create temporary table two_sum_table(
        idx int, 
        val int
        );
        for idx in 1..array_length(nums, 1)
        loop 
            insert into two_sum_table (idx, val) values (idx - 1, nums[idx]);
        end loop;
        select ARRAY[a.idx, b.idx] 
            from two_sum_table a 
            join two_sum_table b on a.val + b.val = target 
            and a.idx != b.idx limit 1 
            into result;
        return result;
    end;
$$ language plpgsql volatile security definer;