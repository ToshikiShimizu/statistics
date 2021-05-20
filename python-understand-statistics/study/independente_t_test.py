#!/usr/bin/env python
# coding: utf-8

# In[3]:


import numpy as np
from scipy import stats


# In[4]:


group_a = np.random.normal(0, 1, 50)
group_b = np.random.normal(0.5, 1, 50)


# In[5]:


t, p = stats.ttest_ind(group_a, group_b, equal_var=False)


# In[6]:


t, p


# In[ ]:





# In[ ]:




