
### BEFORE
```python
class Solution:
    def findJudge(self, N: int, trust: List[List[int]]) -> int:
        trusts=[False]*N
        # find who trusts someone, and who does not
        for t in trust:
            trusts[t[0]-1]=True # remember to add one later
        
        # find only one who does not trust anyone
        judge=None
        for i,el in enumerate(trusts):
            if not el:
                if not judge: judge=i+1
                else: return -1
        
        if not judge: return -1
        
        trusts=[0]*N
        for t in trust:
            if t[1]==judge: trusts[t[0]-1]=1
    
        return judge if sum(trusts)==N-1 else -1
```

### AFTER
```python
class Solution:
    def findJudge(self, n: int, trust: List[List[int]]) -> int:
        if n==1: return 1
        trust_no_one_set = set(range(1,n+1))
        trusted_by_dict = {}
        for i in trust:
            if i[0] in trust_no_one_set:
                trust_no_one_set.remove(i[0])
            trusted_by_dict[i[1]] = trusted_by_dict.get(i[1],0)+1
        if len(trust_no_one_set) != 1:
            return -1
        judge = list(trust_no_one_set)[0]
        return judge if trusted_by_dict.get(judge, -1) == n-1 else -1
```