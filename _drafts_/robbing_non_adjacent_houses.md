198. House Robber
Medium

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.


PREVIOUS
```python
class Solution:
    def rob(self, a: List[int]) -> int:
        if not a: return 0
        if len(a)<3: return max(a)
        if len(a)==3: return max(a[1],a[0]+a[2])
        track=[0 for _ in range(len(a))]
        track[0]=a[0]
        track[1]=a[1]
        track[2]=a[0]+a[2]
        for i in range(2,len(a)):
            track[i]=max(a[i]+track[i-3],a[i]+track[i-2], track[i-1])
        return track[-1]
```

LATER
```python
class Solution:
    def rob(self, nums: List[int]) -> int:
        if not nums: return 0
        if len(nums) <= 2: return max(nums)
        if len(nums) == 3: return max(nums[0]+nums[2], nums[1])
        
        robValues = [0]*len(nums)
        robValues[0]=nums[0]
        robValues[1]=max(nums[0], nums[1])
        robValues[2]=max(nums[0]+nums[2], nums[1])
        
        for i in range(3, len(nums)):
            robValues[i] = max(robValues[i-1], robValues[i-2]+nums[i])
        
        return robValues[-1]
```
