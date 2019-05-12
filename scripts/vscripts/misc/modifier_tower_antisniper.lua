function antisniper_attacked( keys )
	-- Variables
	local caster = keys.caster
	local attacker = keys.attacker
  local ability = keys.ability
  local modifier = keys.modifier

  local current_range = caster.GetBaseAttackRange(caster)
  local attack_range = math.floor(CalcDistanceBetweenEntityOBB(attacker, caster))
  --print("Caster's range buffer: "..attack_range)
  
  local current_stack = 1
	if caster:HasModifier(modifier) then
		current_stack = caster:GetModifierStackCount( modifier, ability )
	else
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	end

  if ( current_stack >= 2000) then
  	-- If tower's bonus range is already at max - skip completely
  	--print("Current stacks are maxed out: "..current_stack.." Skipping...")
    return
  elseif ( current_stack + current_range >= attack_range) then
  	-- If tower's bonus range is higher than attacker's attack range - skip
    return
  end

  local new_stacks = (attack_range - current_range) + 40

  if (new_stacks >= 2000) then
  	new_stacks = 2000
  end

  caster:SetModifierStackCount( modifier, ability, new_stacks )
end