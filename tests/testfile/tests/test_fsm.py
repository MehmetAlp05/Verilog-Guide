import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

def to_hex(obj): # Convert to hex only if signal is longer than 16 bits
    try:
        binary_str = str(obj)
        binary_str = binary_str.strip()
        if(len(binary_str)>=16  and  binary_str.replace("1","").replace("0","") == ""):
            value = int(binary_str,2)
            hex_len = (len(binary_str)+3)//4
            hex_str = format(value, '0{}x'.format(hex_len))
            return "0x"+hex_str
    except Exception as e:
        pass
    return obj
#This function helps us see the values of the signals in our design.
def Log_Design(dut):
    #Log whatever signal you want from the datapath, called before positive clock edge
    s1 = "dut"
    obj1 = dut
    wires = []
    submodules = []
    for attribute_name in dir(obj1):
        attribute = getattr(obj1, attribute_name)
        if attribute.__class__.__module__.startswith('cocotb.handle'):
            if(attribute.__class__.__name__ == 'ModifiableObject'):
                wires.append((attribute_name, to_hex(attribute.value)) )
            elif(attribute.__class__.__name__ == 'HierarchyObject'):
                submodules.append((attribute_name, attribute.get_definition_name()) )
            elif(attribute.__class__.__name__ == 'HierarchyArrayObject'):
                submodules.append((attribute_name, f"[{len(attribute)}]") )
            elif(attribute.__class__.__name__ == 'NonHierarchyIndexableObject'):
                wires.append((attribute_name, [to_hex(v) for v in attribute.value] ) )
            #else:
                #print(f"{attribute_name}: {type(attribute)}")
                
        #else:
            #print(f"{attribute_name}: {type(attribute)}")
    #for sub in submodules:
    #    print(f"{s1}.{sub[0]:<16}is {sub[1]}")
    for wire in wires:
        print(f"{s1}.{wire[0]:<16}= {wire[1]}")

@cocotb.test()
async def test_fsm(dut):
    test_failed = False  # Flag to track overall test failure
    # Start the clock
    clock = Clock(dut.clk, 2, units="us")  # 500 MHz clock
    cocotb.start_soon(clock.start())

    async def write_state(left, right, attack,current_state):
        dut.left.value = left
        dut.right.value = right
        dut.attack.value = attack
        #await Timer(2, units="us")  # Wait for one clock cycle
        print("left",left,"right",right,"attack",attack)
    # Test all transitions from state 0
    # State encoding: 0 = idle, 1 = left, 2 = right, 3 = attack, 4 = done

    # Helper to check state after clock edge
    async def check_state(expected_state):
        await Timer(2, units="us")  # Wait for one clock cycle
        #Log_Design(dut)
        if (dut.state.value == expected_state):
            print(True,f"Expected state {expected_state}, got {dut.state.value}\n")
        else:
            test_failed = True  # Mark overall test as failed
            print(">>>>>>>>>",False,f"Expected state {expected_state}, got {dut.state.value}\n")
        moveflag=expected_state==1 or expected_state==2
        if (moveflag==dut.move_flag.value):
            print(True,f"Expected move flag {moveflag}, got {dut.move_flag.value}\n")
        else:
            print(">>>>>>>>>",False,f"Expected move flag {moveflag}, got {dut.move_flag.value}\n")
            test_failed = True  # Mark overall test as failed
        attackflag=expected_state==3 or expected_state==4
        if (attackflag==dut.attack_flag.value):
            print(True,f"Expected attack flag {attackflag}, got {dut.attack_flag.value}\n")
        else:
            print(">>>>>>>>>",False,f"Expected attack flag {attackflag}, got {dut.attack_flag.value}\n")
            test_failed = True  # Mark overall test as failed
        directionflag=moveflag and (dut.attack.value==1)
        if (directionflag==dut.direction.value):
            print(True,f"Expected attack flag {directionflag}, got {dut.direction.value}\n")
        else:
            print(">>>>>>>>>",False,f"Expected attack flag {directionflag}, got {dut.direction.value}\n")
            test_failed = True  # Mark overall test as failed
        
    # Start from state 0 (idle)
    dut.state.value = 0
    dut.left.value = 0
    dut.right.value = 0
    dut.attack.value = 0
    await Timer(1, units="us")

    # (0 -> 1 (left pressed))
    await write_state(left=1, right=0, attack=0, current_state=0)
    await check_state(1)
    # 0 -> 2 (right pressed)
    dut.state.value = 0
    await write_state(left=0, right=1, attack=0, current_state=0)
    await check_state(2)
    # 0 -> 3 (attack pressed)
    dut.state.value = 0
    await write_state(left=0, right=0, attack=1, current_state=0)
    await check_state(3)
    # 0 -> 0 (no input)
    dut.state.value = 0
    await write_state(left=0, right=0, attack=0, current_state=0)
    await check_state(0)

    # Now test all transitions from state 1
    dut.state.value = 1
    # 1 -> 1 (left pressed)
    await write_state(left=1, right=0, attack=0, current_state=1)
    await check_state(1)
    # 1 -> 2 (right pressed)
    dut.state.value = 1
    await write_state(left=0, right=1, attack=0, current_state=1)
    await check_state(2)
    # 1 -> 3 (attack pressed)
    dut.state.value = 1
    await write_state(left=0, right=0, attack=1, current_state=1)
    await check_state(3)
    # 1 -> 0 (no input)
    dut.state.value = 1
    await write_state(left=0, right=0, attack=0, current_state=1)
    await check_state(0)
    # All transitions from state 2
    dut.state.value = 2
    # 2 -> 1 (left pressed)
    await write_state(left=1, right=0, attack=0, current_state=2)
    await check_state(1)
    # 2 -> 2 (right pressed)
    dut.state.value = 2
    await write_state(left=0, right=1, attack=0, current_state=2)
    await check_state(2)
    # 2 -> 3 (attack pressed)
    dut.state.value = 2
    await write_state(left=0, right=0, attack=1, current_state=2)
    await check_state(3)
    # 2 -> 0 (no input)
    dut.state.value = 2
    await write_state(left=0, right=0, attack=0, current_state=2)
    await check_state(0)
    # All transitions from state 3
    dut.state.value = 3
    # 3 -> 4 (any input)
    await write_state(left=0, right=0, attack=0, current_state=3)
    await check_state(4)
    dut.state.value = 3
    await write_state(left=1, right=0, attack=0, current_state=3)
    await check_state(4)
    dut.state.value = 3
    await write_state(left=0, right=1, attack=0, current_state=3)
    await check_state(4)
    dut.state.value = 3
    await write_state(left=0, right=0, attack=1, current_state=3)
    await check_state(4)
    dut.state.value = 3
    await write_state(left=1, right=1, attack=1, current_state=3)
    await check_state(4)
    # All transitions from state 4
    dut.state.value = 4
    # 4 -> 0 (any input)
    await write_state(left=0, right=0, attack=0, current_state=4)
    await check_state(0)
    dut.state.value = 4
    await write_state(left=1, right=0, attack=0, current_state=4)
    await check_state(0)
    dut.state.value = 4
    await write_state(left=0, right=1, attack=0, current_state=4)
    await check_state(0)
    dut.state.value = 4
    await write_state(left=0, right=0, attack=1, current_state=4)
    await check_state(0)
    dut.state.value = 4
    await write_state(left=1, right=1, attack=1, current_state=4)
    await check_state(0)

    # Final assertion for the overall result
    if test_failed:
        raise AssertionError("Some test cases failed. Check logs for details.")
    else:
        cocotb.log.info("All test cases passed successfully!")