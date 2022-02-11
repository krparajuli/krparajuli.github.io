```python
# WORKS BUt EXPENSIVE ON STORAGE
class Solution:
    def jump(self, nums: List[int]) -> int:
        if len(nums) <= 1: return 0
        
        dp = [[0]*(len(nums)+1)]*(len(nums)+1)
        for i in range(0,len(nums)):
            step = nums[i]
            dp[i+1][i+1] = min(dp[i][i]+1,dp[i][i+1])
            for j in range(1, step+1):
                if i+1+j <= len(nums):
                    if dp[i][i+1+j] == 0:
                        dp[i][i+1+j] = dp[i+1][i+1]+1
                    else:
                        dp[i+1][i+1+j] = min(dp[i][i+1+j], dp[i+1][i+1]+1)
            # print(dp)
        return dp[-1][-1]
        
```
This is O(n^2) so does not run as fast

### Greedy approach is O(n)
```python
class Solution:
    def jump(self, nums: List[int]) -> int:
        steps = reaches = 0
        windowEnd = 0  # window for BFS 
        
        for i in range(0, len(nums)):
            if i > windowEnd:
                windowEnd = reaches
                steps += 1
            
            if i+nums[i] > reaches:
                reaches = i+nums[i]
        
        return steps
```

Runtime: 116 ms, faster than 95.33% of Python3 online submissions for Jump Game II.

Memory Usage: 15 MB, less than 97.88% of Python3 online submissions for Jump Game II.

