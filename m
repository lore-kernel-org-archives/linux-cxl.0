Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B618D656;
	Fri,  4 Apr 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771560; cv=none; b=r5tToBldexRqxfIZBQqfqfYq23cFSUTVJaeUqq0oGWhfsXqRIf2b41xAnMGU8DWqhygx9eDlS38U7eUZbESV6GLD0O3i3mtaBBc/PjEVFq16NDCmEfHJc11onsjFlzXHdWAj+xKX6LgdZd5bA7VO8aM7i4SIgpeboGbvHZsGyEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771560; c=relaxed/simple;
	bh=A1YQV7DTUafA+9BT5+KgvszR0Cn++a78Zm/k3sbagI0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFuFeYufadKFX+1K1pGya/+y/4jfMb8xShRBYEiQOiigoo4ef+/ARv7D2RClMa2ljQpweg75D/MasRj3ijA2I/l4+vgPdgmGpD/HQTkBnqzF8QjYQdmBHUgm/qsJeNWeaUKw9MVZg9P5X3OmEJnrhi3N1ievOKV6FqFz5dCHB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTdr02jL4z6K9DN;
	Fri,  4 Apr 2025 20:55:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EC187140557;
	Fri,  4 Apr 2025 20:59:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 14:59:08 +0200
Date: Fri, 4 Apr 2025 13:59:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Rakie Kim <rakie.kim@sk.com>
CC: <akpm@linux-foundation.org>, <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<joshua.hahnjy@gmail.com>, <dan.j.williams@intel.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v6 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <20250404135906.0000308e@huawei.com>
In-Reply-To: <20250404074623.1179-2-rakie.kim@sk.com>
References: <20250404074623.1179-1-rakie.kim@sk.com>
	<20250404074623.1179-2-rakie.kim@sk.com>
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

On Fri, 4 Apr 2025 16:46:19 +0900
Rakie Kim <rakie.kim@sk.com> wrote:

> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with proper `kobject_del()` and `kobject_put()` sequences,
> ensuring correct teardown and preventing memory leaks.
> 
> By explicitly calling `kobject_del()` before `kobject_put()`,
> the release function is now invoked safely, and internal sysfs
> state is correctly cleaned up. This guarantees that the memory
> associated with the kobject is fully released and avoids
> resource leaks, thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
I've pretty much forgotten earlier discussions so apologies if I revisit
old ground! 

The fix is fine I think. But the resulting code structure
could be improved, without (I think) complicating what is here by much.

> ---
>  mm/mempolicy.c | 64 +++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..af3753925573 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3448,7 +3448,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
>  
>  	for (i = 0; i < nr_node_ids; i++)
>  		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> -	kobject_put(wi_kobj);
> +
> +	kfree(node_attrs);
> +	kfree(wi_kobj);
>  }
>  
>  static const struct kobj_type wi_ktype = {
> @@ -3494,15 +3496,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  	struct kobject *wi_kobj;
>  	int nid, err;
>  
> -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> -	if (!wi_kobj)
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs)
>  		return -ENOMEM;
>  
> +	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> +	if (!wi_kobj) {
> +		err = -ENOMEM;
> +		goto node_out;
As this is only place where we do kfree(node_attrs)
why not just do that here and return directly.

		
> +	}
> +
>  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
>  				   "weighted_interleave");
>  	if (err) {
> -		kfree(wi_kobj);
> -		return err;
> +		kobject_put(wi_kobj);
> +		goto err_out;
>  	}
>  
>  	for_each_node_state(nid, N_POSSIBLE) {
> @@ -3512,9 +3521,18 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  			break;
>  		}
>  	}
> -	if (err)
> +	if (err) {
> +		kobject_del(wi_kobj);
>  		kobject_put(wi_kobj);

For this and the one above, a unified exit kind of makes sense as
can do two labels and have the put only once.

If not, why not move this up into the loop and return directly?
If you move to an error handling block

err_del_obj:
	kobject_del(wi_kobj);
err_put_obj:
	kobject_put(wi_kobj);

then you could also do the goto from within that loop.


> +		goto err_out;
> +	}
> +
>  	return 0;
> +
> +node_out:
> +	kfree(node_attrs);
> +err_out:
> +	return err;
>  }
>  
>  static void mempolicy_kobj_release(struct kobject *kobj)
> @@ -3528,7 +3546,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
>  	mutex_unlock(&iw_table_lock);
>  	synchronize_rcu();
>  	kfree(old);
> -	kfree(node_attrs);
>  	kfree(kobj);
>  }
>  
> @@ -3542,37 +3559,24 @@ static int __init mempolicy_sysfs_init(void)
>  	static struct kobject *mempolicy_kobj;
>  
>  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> -	if (!mempolicy_kobj) {
> -		err = -ENOMEM;
> -		goto err_out;
> -	}
> -
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs) {
> -		err = -ENOMEM;
> -		goto mempol_out;
> -	}
> +	if (!mempolicy_kobj)
> +		return -ENOMEM;
>  
>  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
>  				   "mempolicy");
>  	if (err)
> -		goto node_out;
> +		goto err_out;
		goto err_put_kobj;
 or something like that.

>  
>  	err = add_weighted_interleave_group(mempolicy_kobj);
> -	if (err) {
> -		pr_err("mempolicy sysfs structure failed to initialize\n");
> -		kobject_put(mempolicy_kobj);
> -		return err;
> -	}
> +	if (err)
> +		goto err_del;
>  
> -	return err;
> -node_out:
> -	kfree(node_attrs);
> -mempol_out:
> -	kfree(mempolicy_kobj);
> +	return 0;
> +
> +err_del:
> +	kobject_del(mempolicy_kobj);
>  err_out:
> -	pr_err("failed to add mempolicy kobject to the system\n");
> +	kobject_put(mempolicy_kobj);
If we keep an err_out, usual expectation is all it does is return
+ maybe print a message. We'd not expect a put.

>  	return err;
>  }
>  

