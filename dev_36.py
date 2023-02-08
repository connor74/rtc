def dev_sum(m):
    i = 1
    while True:
        num = i * m
        l_str = list(str(num))
        l_int = [int(i) for i in l_str]
        if sum(l_int) == m:
            return num
        else:
            i += 1
print(dev_sum(36))
