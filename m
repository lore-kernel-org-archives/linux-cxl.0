Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6562DFA21;
	Tue, 15 Apr 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744732839; cv=none; b=jT4SanOzqlfnth4tVrb6Ar7WGTAKYzi76I+FtsfQUoHM17pC/Zx8MqYkuC0GZO6A/3Lf7JBC1LAVtAjnnjFO5aQhKumff6YJhjzkhrtOMSQUG2ZcUjhltRT2dNyqoCgsqld0MUMkSXoFya8bTdPoIshCvwNyyrjSOfEavioOf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744732839; c=relaxed/simple;
	bh=Ih2Gg4WFdXpWVNRpq/XOFe5Rqh3AJmlwRf+b6zGFCj0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZHxwyRc6FtReZkGIFHZ2ae0l8HCi9Gtma8R1FFKZnSszg4tY3VJpwT9YG8c1dCqGsGgge2cR6gapUz/3gB5ZPk1+tvksHawFxfZWgmeKaztlEYJm4ZYSqvmJqjeU33Zo8xwxjHEq/C5wv+Q75P/3GqN1Me39f+v2J9/mi25K4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcTNy5h6Mz6FGYx;
	Tue, 15 Apr 2025 23:59:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 27BAF140133;
	Wed, 16 Apr 2025 00:00:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 18:00:32 +0200
Date: Tue, 15 Apr 2025 17:00:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Rakie Kim <rakie.kim@sk.com>
CC: <akpm@linux-foundation.org>, <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<joshua.hahnjy@gmail.com>, <dan.j.williams@intel.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <20250415170031.0000372b@huawei.com>
In-Reply-To: <20250408073243.488-4-rakie.kim@sk.com>
References: <20250408073243.488-1-rakie.kim@sk.com>
	<20250408073243.488-4-rakie.kim@sk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Apr 2025 16:32:42 +0900
Rakie Kim <rakie.kim@sk.com> wrote:

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
>    the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>    based on whether a node transitions into or out of the N_MEMORY state.
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
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/mempolicy.c | 106 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 83 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 988575f29c53..9aa884107f4c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -113,6 +113,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
>  #include <linux/uaccess.h>
> +#include <linux/memory.h>
>  
>  #include "internal.h"
>  
> @@ -3421,6 +3422,7 @@ struct iw_node_attr {
>  
>  struct sysfs_wi_group {
>  	struct kobject wi_kobj;
> +	struct mutex kobj_lock;
>  	struct iw_node_attr *nattrs[];
>  };
>  
> @@ -3470,13 +3472,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  static void sysfs_wi_node_delete(int nid)
>  {
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
>  		return;
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
Here you go through a careful dance to not touch wi_group->nattrs[nid]
except under the lock, but later you are happy to do so in the
error handling paths.  Maybe better to do similar to here and
set it to NULL under the lock but do the freeing on a copy taken
under that lock.
. 
>  }
>  
>  static void sysfs_wi_release(struct kobject *wi_kobj)
> @@ -3495,35 +3508,77 @@ static const struct kobj_type wi_ktype = {
>  
>  static int sysfs_wi_node_add(int nid)
>  {
> -	struct iw_node_attr *node_attr;
> +	int ret = 0;

Trivial but isn't ret always set when it is used? So no need to initialize
here.

>  	char *name;
> +	struct iw_node_attr *new_attr = NULL;

This is also always set before use so I'm not seeing a
reason to initialize it to NULL.


>  
> -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> -	if (!node_attr)
> +	if (nid < 0 || nid >= nr_node_ids) {
> +		pr_err("Invalid node id: %d\n", nid);
> +		return -EINVAL;
> +	}
> +
> +	new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);

I'd prefer sizeof(*new_attr) because I'm lazy and don't like checking
types for allocation sizes :)  Local style seems to be a bit
of a mix though.

> +	if (!new_attr)
>  		return -ENOMEM;
>  
>  	name = kasprintf(GFP_KERNEL, "node%d", nid);
>  	if (!name) {
> -		kfree(node_attr);
> +		kfree(new_attr);
>  		return -ENOMEM;
>  	}
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

I'd have been tempted to use the new_attr pointer but perhaps
this brings some documentation like advantages.

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

See comment above on the rather different handling here to in
sysfs_wi_node_delete() where you set it to NULL first, release the lock and tidy up.
new_attrand name are still set so you could even combine the handling with the
if (wi_group->nattrs[nid]) above via appropriate gotos.

> +		kfree(wi_group->nattrs[nid]);
> +		wi_group->nattrs[nid] = NULL;
> +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
>  	}
> +	mutex_unlock(&wi_group->kobj_lock);
>  
> -	wi_group->nattrs[nid] = node_attr;
> -	return 0;
> +	return ret;
> +}


