```python
class Solution:
    def maxSubarraySumCircular(self, nums: List[int]) -> int:
        if len(nums) == 1: return nums[0]
        
        n = len(nums)
        st1 = 0
        sm1 = mxSum1 = nums[0]
        
        i = 1
        while i != st1:
            sm1 = sm1+nums[i]
            if nums[i] >= sm1:
                sm1 = nums[i]
                st = i

            if sm1 > mxSum1: mxSum1 = sm1
            i = (i+1)%n
            
        nums = [nums[-1]] + nums[:-1]
        sm2 = mxSum2 = nums[0]
        st2 = 0
        i = 1
        while i != st2:
            sm2 = sm2+nums[i]
            if nums[i] >= sm2:
                sm2 = nums[i]
                st2 = i

            if sm2 > mxSum2: mxSum2 = sm2
            i = (i+1)%n
        
            
        return max(mxSum1, mxSum2)
```