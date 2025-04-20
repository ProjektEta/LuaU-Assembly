local LSM = {}

--[[

	RAX : Registry Add Absolute : {ADDR, VALUE}
	RAT : Registry Add Temporary : {ADDR, VALUE}
	RDX : Registry Delete Absolute : {ADDR}
	RDT : Registry Delete Temporary : {ADDR}
	JMP : Jump : {REG_ID}
	CALL : Call : {ADDR, {IADDR'S}, {OADDR'S}}
	RET : Return : {REG_ID}
	CON : Concact : {ADDR, {STRING'S}}
	IND : Index : {TABLEADDR, ADDRESS, INDEX}
	NIND : NewIndex : {TABLEADDR, INDEX, VALUE}
]]--

function LSM:Run(bCode)
	
	local i = 0
	
	local memory = {
		fmem = {},
		gmem = {}
	}
	
	while i < #bCode do
		i += 1
		
		local Line = bCode[i] -- {INS, ARGS}
		
		if Line[1] == "rax" then
			memory.gmem[Line[2][1]] = Line[2][2]
		elseif Line[1] == "rat" then
			memory.fmem[Line[2][1]] = Line[2][2]
		elseif Line[1] == "rdx" then
			memory.gmem[Line[2][1]] = nil
		elseif Line[1] == "rdt" then
			memory.fmem[Line[2][1]] = nil
		elseif Line[1] == "jmp" then
			i = Line[2][1]
			continue
		elseif Line[1] == "call" then
			local args = {}
			
			for x=1, #Line[2][2] do
				table.insert(args, memory.gmem[Line[2][2][x]])
			end
			
			local rvalues = {memory.gmem[Line[2][1]](table.unpack(args))}
			for x=1, #Line[2][3] do
				memory.gmem[Line[2][3][x]] = rvalues[x]
			end
		elseif Line[1] == "con" then
			local s = ""
			
			for x=1, #Line[2][2] do
				s ..= memory.gmem[Line[2][2][x]]
			end
			
			memory.gmem[Line[2][1]] = s
		elseif Line[1] == "ind" then
			memory.gmem[Line[2][2]] = memory.gmem[Line[2][1]][memory.gmem[Line[2][3]]]
		elseif Line[1] == "nind" then
			memory.gmem[Line[2][1]][memory.gmem[Line[2][2]]] = memory.gmem[Line[2][3]]
		end
		
	end
end

return LSM
