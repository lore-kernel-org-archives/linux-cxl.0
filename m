Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE47A1DF988;
	Fri,  4 Apr 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771966; cv=none; b=Zdt35TmJsCZUHI43pO/cxxNqbc4uXiB6Xlsz/mH7+CcFliAtaJYKggCfVWP8U2OYLApRIILjI+js/5ofnXhigEGGCsRLPL9EQHwgeXu2BWvb/2zYztRGE7aBEM9hj6tydEye9SHLdddlkoBFGOiOPc+oofgrQVkCVx1FCZWcx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771966; c=relaxed/simple;
	bh=ad8maAL2fBcxLsP8JIBZ6Wfk7ULRuauQ/2j0MN5bL0E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aL2GqmzhdWmEJff8XBR/IY1yS5TihwCqDzXvfLipowtA5qgxWuguFy5jdGky7+iLqzne1oRSIiTX721ZTZArApejuhw0XNZLfjf0GpKss3VNtO7l6GCV1grPIBVdcLZ6xN6hl8js09fcO6p/+JeVvziPE2qnXjrruWEOW5mj0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTf3M0KKCz6L4wH;
	Fri,  4 Apr 2025 21:05:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 71AF8140732;
	Fri,  4 Apr 2025 21:06:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 15:06:00 +0200
Date: Fri, 4 Apr 2025 14:05:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Rakie Kim <rakie.kim@sk.com>
CC: <akpm@linux-foundation.org>, <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<joshua.hahnjy@gmail.com>, <dan.j.williams@intel.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v6 2/3] mm/mempolicy: Prepare weighted interleave sysfs
 for memory hotplug
Message-ID: <20250404140559.00001112@huawei.com>
In-Reply-To: <20250404074623.1179-3-rakie.kim@sk.com>
References: <20250404074623.1179-1-rakie.kim@sk.com>
	<20250404074623.1179-3-rakie.kim@sk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 4 Apr 2025 16:46:20 +0900
Rakie Kim <rakie.kim@sk.com> wrote:

> Previously, the weighted interleave sysfs structure was statically
> managed during initialization. This prevented new nodes from being
> recognized when memory hotplug events occurred, limiting the ability
> to update or extend sysfs entries dynamically at runtime.
> 
> To address this, this patch refactors the sysfs infrastructure and
> encapsulates it within a new structure, `sysfs_wi_group`, which holds
> both the kobject and an array of node attribute pointers.
> 
> By allocating this group structure globally, the per-node sysfs
> attributes can be managed beyond initialization time, enabling
> external modules to insert or remove node entries in response to
> events such as memory hotplug or node online/offline transitions.
> 
> Instead of allocating all per-node sysfs attributes at once, the
> initialization path now uses the existing sysfs_wi_node_add() and
> sysfs_wi_node_delete() helpers. This refactoring makes it possible
> to modularly manage per-node sysfs entries and ensures the
> infrastructure is ready for runtime extension.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
Hi Rakie,

Some things I was requesting in patch 1 are done here.
Mostly I think what is wanted is moving some of that
refactoring back to that patch rather than here.

Some of the label and function naming needs another look.

Jonathan

> ---
>  mm/mempolicy.c | 73 ++++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index af3753925573..73a9405ff352 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3388,6 +3388,13 @@ struct iw_node_attr {
>  	int nid;
>  };
>  
> +struct sysfs_wi_group {
> +	struct kobject wi_kobj;
> +	struct iw_node_attr *nattrs[];
> +};
> +
> +static struct sysfs_wi_group *wi_group;
> +
>  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
> @@ -3430,27 +3437,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	return count;
>  }
>  
> -static struct iw_node_attr **node_attrs;
> -
> -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> -				  struct kobject *parent)
> +static void sysfs_wi_node_delete(int nid)

Maybe stick to release naming to match the sysfs_wi_release()
below? I don't really care about this.

>  {
> -	if (!node_attr)
> +	if (!wi_group->nattrs[nid])
>  		return;
> -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> -	kfree(node_attr->kobj_attr.attr.name);
> -	kfree(node_attr);
> +
> +	sysfs_remove_file(&wi_group->wi_kobj,
> +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> +	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> +	kfree(wi_group->nattrs[nid]);
>  }
>  
>  static void sysfs_wi_release(struct kobject *wi_kobj)
>  {
> -	int i;
> -
> -	for (i = 0; i < nr_node_ids; i++)
> -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +	int nid;
>  
> -	kfree(node_attrs);
> -	kfree(wi_kobj);
> +	for (nid = 0; nid < nr_node_ids; nid++)
> +		sysfs_wi_node_delete(nid);
> +	kfree(wi_group);
>  }

> -static int add_weighted_interleave_group(struct kobject *root_kobj)
> +static int add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>  {
> -	struct kobject *wi_kobj;
>  	int nid, err;
>  
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs)
> +	wi_group = kzalloc(struct_size(wi_group, nattrs, nr_node_ids),
> +			GFP_KERNEL);

Align to after the ( 
I think it's a couple of spaces short of that.


> +	if (!wi_group)
>  		return -ENOMEM;
>  
> -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj) {
> -		err = -ENOMEM;
> -		goto node_out;
> -	}
> -
> -	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> +	err = kobject_init_and_add(&wi_group->wi_kobj, &wi_ktype, mempolicy_kobj,
>  				   "weighted_interleave");
> -	if (err) {
> -		kobject_put(wi_kobj);
> +	if (err)
>  		goto err_out;
> -	}
>  
>  	for_each_node_state(nid, N_POSSIBLE) {
> -		err = add_weight_node(nid, wi_kobj);
> +		err = sysfs_wi_node_add(nid);
>  		if (err) {
>  			pr_err("failed to add sysfs [node%d]\n", nid);
> -			break;
> +			goto err_del;
Ah!  This is what I was looking for in patch 1, but it's down here.
Move it back to there.
>  		}
>  	}
> -	if (err) {
> -		kobject_del(wi_kobj);
> -		kobject_put(wi_kobj);
> -		goto err_out;
> -	}
>  
>  	return 0;
>  
> -node_out:
> -	kfree(node_attrs);
> +err_del:
> +	kobject_del(&wi_group->wi_kobj);
>  err_out:
> +	kobject_put(&wi_group->wi_kobj);
Same issue as previous patch on naming of the label.
Moving to this single error block is fine but belongs in patch 1.

>  	return err;
>  }
>  

