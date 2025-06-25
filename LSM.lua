local Compiler = {}

function Compiler:Run(Bytecode)
    
    local memory = {
        pool = {};
        flags = {};
        stacks = {};
        protolist = {};
    }

    local cur_ = 1;

    memory.protolist[1] = {"main", memory.pool}

	while cur_ <= #Bytecode do
		task.wait()
		local ins = Bytecode[cur_]
		
		if ins == nil then
			break;
		end

		if (ins[1] == "def") then
			memory.pool[ins[2]] = ins[3]
		elseif (ins[1] == "add") then
			local eof = nil
			local cins = table.clone(ins)
			table.remove(cins, 1)
			table.remove(cins, 1)

			for i=1, #cins do
				if eof == nil then
					eof = cins[i]
				else
					eof += cins[i]
				end
			end

			memory.pool[ins[2]] = eof
		elseif (ins[1] == "sub") then
			local eof = nil
			local cins = table.clone(ins)
			table.remove(cins, 1)
			table.remove(cins, 1)

			for i=1, #cins do
				if eof == nil then
					eof = cins[i]
				else
					eof -= cins[i]
				end
			end

			memory.pool[ins[2]] = eof
		elseif (ins[1] == "div") then
			local eof = nil
			local cins = table.clone(ins)
			table.remove(cins, 1)
			table.remove(cins, 1)

			for i=1, #cins do
				if eof == nil then
					eof = cins[i]
				else
					eof /= cins[i]
				end
			end

			memory.pool[ins[2]] = eof
		elseif (ins[1] == "mul") then
			local eof = nil
			local cins = table.clone(ins)
			table.remove(cins, 1)
			table.remove(cins, 1)

			for i=1, #cins do
				if eof == nil then
					eof = cins[i]
				else
					eof *= cins[i]
				end
			end

			memory.pool[ins[2]] = eof
		elseif (ins[1] == "call") then
			local f = memory.pool[ins[2]]
			if (typeof(f) == "function") then
				local fparams = {}
				local fparamsaddrs = ins[3]
				for i=1, #fparamsaddrs do
					table.insert(fparams, memory.pool[fparamsaddrs[i]])
				end
				local fret = {f(table.unpack(fparams))}
				for i=1, #ins[4] do
					memory.pool[ins[4][i]] = fret[i]
				end
			else
				-- get function flag address
				local flag = memory.flags[f]
				-- make a new stack for the function
				memory.stacks[f] = {}
				-- transfer all params to the stack
				for i=1, #ins[3] do
					memory.stacks[f][i] = memory.pool[ins[3][i]]
				end
				-- store return address in predefined stack entry
				memory.stacks[f]["ret"] = cur_ + 1
				-- store addresses in a predefined metatable to be returned
				memory.stacks[f]["ret_mt"] = {}
				-- store all the params pointers, so the function knows hwere to return to
				for i=1, #ins[4] do
					memory.stacks[f]["ret_mt"][i] = ins[4][i]
				end
				-- set in prority_list
				table.insert(memory.protolist, {
					flag, memory.stacks[f.__func]
				})
				-- set the position.
				cur_ = flag
			end
		elseif (ins[1] == "flag") then
			memory.flags[ins[2]] = cur_
			cur_ += ins[3]
		elseif (ins[1] == "ret") then
			-- find function in stack pro list
			local func = memory.protolist[#memory.protolist]

			-- if main then break, as there is no higher function for the values.
			if (func[1] == "main") then
				break;
			end

			-- get the abv stack from above
			local abv = memory.protolist[#memory.protolist - 1]
			for i=1, #func[2]["ret_mt"] do -- get the list of expected returns, and the addresses to store
				abv[2][func[2]["ret_mt"][i]] = func[2][func[2]["ret_mt"][i]]
				-- store in the addresses, the value of the pointer in the current function itno the stack above
			end

			-- go to the predefined instruction in the process.
			cur_ = func[2]["ret"]
		elseif (ins[1] == "jmp") then
			cur_ = ins[1][2]
		elseif (ins[1] == "jmpcon") then
			if (memory.pool[ins[2]] == true) then
				cur_ = ins[1][3]
			end
		elseif (ins[1] == "sys") then
			if (ins[2] == "eq") then
				memory.pool[ins[5]] = memory.pool[ins[3]] == memory.pool[ins[4]] 
			elseif (ins[2] == "gt") then
				memory.pool[ins[5]] = memory.pool[ins[3]] > memory.pool[ins[4]] 
			elseif (ins[2] == "gteq") then
				memory.pool[ins[5]] = memory.pool[ins[3]] >= memory.pool[ins[4]] 
			elseif (ins[2] == "lt") then
				memory.pool[ins[5]] = memory.pool[ins[3]] < memory.pool[ins[4]] 
			elseif (ins[2] == "lteq") then
				memory.pool[ins[5]] = memory.pool[ins[3]] <= memory.pool[ins[4]] 
			elseif (ins[2] == "noteq") then
				memory.pool[ins[5]] = memory.pool[ins[3]] ~= memory.pool[ins[4]] 
			elseif (ins[2] == "ind") then
				memory.pool[ins[3]] = memory.pool[ins[4]][memory.pool[ins[5]]]
			elseif (ins[2] == "nind") then
				memory.pool[ins[4]][memory.pool[ins[5]]] = memory.pool[ins[3]]
			end
		end
		
		cur_ += 1
	end

    return;
end

return Compiler
