Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43892139D;
	Wed,  2 Apr 2025 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567542; cv=none; b=Za+ySqjY9vf4/TSs4zpxfri6len41LwqQdYst4CfmCc2aBTdty/K45VuX9v0D01lyo4228E6AP7ba9yRpl8BD10dVoTFKLb4zdU/jAA62HY79sPiDBSkqFxBsqYSjIWLnpDbnt5kIJfmUIbOa82GK8CucOlRqlq9Slefp+rtX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567542; c=relaxed/simple;
	bh=3gBK+yGijClrVI2Qauckmrdnk05u+wwJ1CPfzPWrlqE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VlFINC8MzW8FRjVKDSJj6kvH3BObYAndSmqNbUWqZxTwzlbgR36pBHDG0B1utDpM96oRLVDaOYUAXg+SvP8ORbfViQrud06oUcC/SwawFy5lIsBWoO2gHZgVUptoGIMnnk0TwykCnmC0bDErlCOKUG21JICk3PlIrny15Hgx7Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-8b-67ecbaacb317
Message-ID: <5462e706-5b29-495d-9af9-1945e8a5445e@sk.com>
Date: Wed, 2 Apr 2025 13:18:51 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, david@redhat.com, Jonathan.Cameron@huawei.com,
 yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Rakie Kim <rakie.kim@sk.com>, gourry@gourry.net
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250402014906.1086-4-rakie.kim@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXC9ZZnoe6aXW/SDaZ9VbCYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8b+
	7d/YC35ZV/zbe4ypgbHFoIuRk0NCwERi24EzTDD29albwWxeAUuJX22trCA2i4CKxLobV1gh
	4oISJ2c+YQGxRQXkJe7fmsHexcjFwSywgEni9IG3jCAJYYFIiQ2TroMNEhEwlrh1GWKokEC8
	xLzdR5hBbGYBEYnZnW1gNpuAmsSVl5PAajgFTCXOLj/HCFFjJtG1tQvKlpfY/nYOM8gyCYH/
	bBKvvrQzQlwtKXFwxQ2WCYyCs5AcOAvJjllIZs1CMmsBI8sqRqHMvLLcxMwcE72MyrzMCr3k
	/NxNjMCYWlb7J3oH46cLwYcYBTgYlXh4G3jfpAuxJpYVV+YeYpTgYFYS4Y34+jJdiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA2NnhcO1GXOPbHn+uUxw
	qut93XB57nWe3D8+PN1as+uYMfsxrSlH9h/erC0q9cL25NTF+3RmLb0cZRR3aEbux7bq+puB
	PyWSz808cHLzws+VC+SNJb44bE6edLUyTf/Fls+das17phzcvfChxN67Hd3LZvkfX9Sy7blZ
	2flHtq+mX87tdJyZLmgUpsRSnJFoqMVcVJwIAHfub9OlAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LhmqGlp7tm15t0g9alwhZz1q9hs5g+9QKj
	xdf1v5gtft49zm6xauE1NovjW+exWxyee5LV4vysUywWl3fNYbO4t+Y/q8Wha89ZLVavybD4
	vW0FmwOvx85Zd9k9utsus3u0HHnL6rF4z0smj02fJrF7nJjxm8Vj50NLj/f7rrJ5fLvt4bH4
	xQcmj8+b5AK4o7hsUlJzMstSi/TtErgy9m//xl7wy7ri395jTA2MLQZdjJwcEgImEtenbmUC
	sXkFLCV+tbWygtgsAioS625cYYWIC0qcnPmEBcQWFZCXuH9rBnsXIxcHs8ACJonTB94ygiSE
	BSIlNky6DjZIRMBY4tZliKFCAvES83YfYQaxmQVEJGZ3toHZbAJqEldeTgKr4RQwlTi7/Bwj
	RI2ZRNfWLihbXmL72znMExj5ZiG5YxaSUbOQtMxC0rKAkWUVo0hmXlluYmaOqV5xdkZlXmaF
	XnJ+7iZGYPQsq/0zcQfjl8vuhxgFOBiVeHgFet6kC7EmlhVX5h5ilOBgVhLhjfj6Ml2INyWx
	siq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qBUab+Icdes1XXOZtF
	mtYKHNI7PMk7e8WzvH0WbPFK6XK1JlmvtoW1rVkrw/pvL9+qitWfg7aX/SqU55i98YPm7PcJ
	X7cKam/R9bZwq/2649rMnLPHD76aqbujg+WcGKf11pUbuKcUvcufxXps8TJzm+g5ltwR3IyL
	Ut8765+TsPKoqW5e8OZLmRJLcUaioRZzUXEiAFMK6cmaAgAA
X-CFilter-Loop: Reflected

Hi Rakie,

This is to fix the following broken status.
https://lore.kernel.org/linux-mm/b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com

So we must add the following tag for this patch.
Fixes: fa3bea4e1f82 ("mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for 
weighted interleaving")


Hi Gregory,

This patch is already in Andrew's tree. Is the current version okay for you?


Hi Andrew,

I'm not sure if this is going to the final version but could you please add this
patch to stable with Cc: <stable@vger.kernel.org>?
We might need to bring the whole series to avoid conflicts to stable tree.

Thanks,
Honggyu

On 4/2/2025 10:49 AM, Rakie Kim wrote:
> The weighted interleave policy distributes page allocations across multiple
> NUMA nodes based on their performance weight, thereby improving memory
> bandwidth utilization. The weight values for each node are configured
> through sysfs.
> 
> Previously, sysfs entries for configuring weighted interleave were created
> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> might not have memory. However, not all nodes in N_POSSIBLE are usable at
> runtime, as some may remain memoryless or offline.
> This led to sysfs entries being created for unusable nodes, causing
> potential misconfiguration issues.
> 
> To address this issue, this patch modifies the sysfs creation logic to:
> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>     the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>     based on whether a node transitions into or out of the N_MEMORY state.
> 
> Additionally, the patch ensures that sysfs attributes are properly managed
> when nodes go offline, preventing stale or redundant entries from persisting
> in the system.
> 
> By making these changes, the weighted interleave policy now manages its
> sysfs entries more efficiently, ensuring that only relevant nodes are
> considered for interleaving, and dynamically adapting to memory hotplug
> events.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> ---
>   mm/mempolicy.c | 110 ++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 87 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3092a792bd28..ea4f3f3f2cdd 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -113,6 +113,7 @@
>   #include <asm/tlbflush.h>
>   #include <asm/tlb.h>
>   #include <linux/uaccess.h>
> +#include <linux/memory.h>
>   
>   #include "internal.h"
>   
> @@ -3390,6 +3391,7 @@ struct iw_node_attr {
>   
>   struct sysfs_wi_group {
>   	struct kobject wi_kobj;
> +	struct mutex kobj_lock;
>   	struct iw_node_attr *nattrs[];
>   };
>   
> @@ -3439,13 +3441,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>   
>   static void sysfs_wi_node_release(int nid)
>   {
> -	if (!wi_group->nattrs[nid])
> +	struct iw_node_attr *attr;
> +
> +	if (nid < 0 || nid >= nr_node_ids)
> +		return;
> +
> +	mutex_lock(&wi_group->kobj_lock);
> +	attr = wi_group->nattrs[nid];
> +	if (!attr) {
> +		mutex_unlock(&wi_group->kobj_lock);
>   		return;
> +	}
> +
> +	wi_group->nattrs[nid] = NULL;
> +	mutex_unlock(&wi_group->kobj_lock);
>   
> -	sysfs_remove_file(&wi_group->wi_kobj,
> -			  &wi_group->nattrs[nid]->kobj_attr.attr);
> -	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> -	kfree(wi_group->nattrs[nid]);
> +	sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
> +	kfree(attr->kobj_attr.attr.name);
> +	kfree(attr);
>   }
>   
>   static void sysfs_wi_release(struct kobject *wi_kobj)
> @@ -3464,35 +3477,81 @@ static const struct kobj_type wi_ktype = {
>   
>   static int sysfs_wi_node_add(int nid)
>   {
> -	struct iw_node_attr *node_attr;
> +	int ret = 0;
>   	char *name;
> +	struct iw_node_attr *new_attr = NULL;
>   
> -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> -	if (!node_attr)
> +	if (nid < 0 || nid >= nr_node_ids) {
> +		pr_err("Invalid node id: %d\n", nid);
> +		return -EINVAL;
> +	}
> +
> +	new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
> +	if (!new_attr)
>   		return -ENOMEM;
>   
>   	name = kasprintf(GFP_KERNEL, "node%d", nid);
>   	if (!name) {
> -		kfree(node_attr);
> +		kfree(new_attr);
>   		return -ENOMEM;
>   	}
>   
> -	sysfs_attr_init(&node_attr->kobj_attr.attr);
> -	node_attr->kobj_attr.attr.name = name;
> -	node_attr->kobj_attr.attr.mode = 0644;
> -	node_attr->kobj_attr.show = node_show;
> -	node_attr->kobj_attr.store = node_store;
> -	node_attr->nid = nid;
> +	mutex_lock(&wi_group->kobj_lock);
> +	if (wi_group->nattrs[nid]) {
> +		mutex_unlock(&wi_group->kobj_lock);
> +		pr_info("Node [%d] already exists\n", nid);
> +		kfree(new_attr);
> +		kfree(name);
> +		return 0;
> +	}
> +	wi_group->nattrs[nid] = new_attr;
>   
> -	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
> -		kfree(node_attr->kobj_attr.attr.name);
> -		kfree(node_attr);
> -		pr_err("failed to add attribute to weighted_interleave\n");
> -		return -ENOMEM;
> +	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
> +	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
> +	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
> +	wi_group->nattrs[nid]->kobj_attr.show = node_show;
> +	wi_group->nattrs[nid]->kobj_attr.store = node_store;
> +	wi_group->nattrs[nid]->nid = nid;
> +
> +	ret = sysfs_create_file(&wi_group->wi_kobj,
> +				&wi_group->nattrs[nid]->kobj_attr.attr);
> +	if (ret) {
> +		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> +		kfree(wi_group->nattrs[nid]);
> +		wi_group->nattrs[nid] = NULL;
> +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
>   	}
> +	mutex_unlock(&wi_group->kobj_lock);
>   
> -	wi_group->nattrs[nid] = node_attr;
> -	return 0;
> +	return ret;
> +}
> +
> +static int wi_node_notifier(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	int err;
> +	struct memory_notify *arg = data;
> +	int nid = arg->status_change_nid;
> +
> +	if (nid < 0)
> +		goto notifier_end;
> +
> +	switch(action) {
> +	case MEM_ONLINE:
> +		err = sysfs_wi_node_add(nid);
> +		if (err) {
> +			pr_err("failed to add sysfs [node%d]\n", nid);
> +			return NOTIFY_BAD;
> +		}
> +		break;
> +	case MEM_OFFLINE:
> +		if (!node_state(nid, N_MEMORY))
> +			sysfs_wi_node_release(nid);
> +		break;
> +	}
> +
> +notifier_end:
> +	return NOTIFY_OK;
>   }
>   
>   static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
> @@ -3504,13 +3563,17 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>   		       GFP_KERNEL);
>   	if (!wi_group)
>   		return -ENOMEM;
> +	mutex_init(&wi_group->kobj_lock);
>   
>   	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
>   				   "weighted_interleave");
>   	if (err)
>   		goto err_out;
>   
> -	for_each_node_state(nid, N_POSSIBLE) {
> +	for_each_online_node(nid) {
> +		if (!node_state(nid, N_MEMORY))
> +			continue;
> +
>   		err = sysfs_wi_node_add(nid);
>   		if (err) {
>   			pr_err("failed to add sysfs [node%d]\n", nid);
> @@ -3518,6 +3581,7 @@ static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>   		}
>   	}
>   
> +	hotplug_memory_notifier(wi_node_notifier, DEFAULT_CALLBACK_PRI);
>   	return 0;
>   
>   err_out:

