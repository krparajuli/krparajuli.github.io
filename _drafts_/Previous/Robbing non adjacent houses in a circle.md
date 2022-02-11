
https://leetcode.com/problems/house-robber-ii


213. House Robber II
Medium

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

 

Example 1:

Input: nums = [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.

Example 2:

Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.

Example 3:

Input: nums = [1,2,3]
Output: 3

 

Constraints:

    1 <= nums.length <= 100
    0 <= nums[i] <= 1000




```python
class Solution:
    
    # Original problem solving
    def robHelper(self, nums: List[int]) -> int:
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
        
        
    def rob(self, nums: List[int]) -> int:
        if len(nums) < 3: return max(nums)
        return max(self.robHelper(nums[1:]), self.robHelper(nums[:-1]))
```

### Single Run Solution
```python

class Solution:    
    def rob(self, nums: List[int]) -> int:
        l = len(nums)
        if l < 4: return max(nums)
        
        withoutFirst = [0]*len(nums)
        withFirst = [0]*len(nums)
        withoutFirst[0] = 0
        withoutFirst[1:3] = nums[1:3]
        withFirst[:2] = nums[:2]
        withFirst[2] = max(withFirst[0]+nums[2],withFirst[1])
        
        for i in range(3, l):
            withoutFirst[i] = max(withoutFirst[i-1], withoutFirst[i-2]+nums[i], withoutFirst[i-3]+nums[i])
            withFirst[i] = max(withFirst[i-1], withFirst[i-2]+nums[i],withFirst[i-3]+nums[i])
        return max(withoutFirst[-1], withFirst[-2])
            

```

Expression should be this 

(I) **dp[i] = max(dp[i-1], dp[i-2]+nums[i], dp[i-3]+nums[i])**
and not 

(II) **dp[i] = max(dp[i-1], dp[i-2]+nums[i])**

Consider the counter example:

    [4,1,2,7,4]

    (I) 4 and 7 = 11
    (II) 1 and 7 = 8

 - Comment if anything else
