Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950941A3152;
	Thu, 20 Mar 2025 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742449227; cv=none; b=Gh20z42ZXktWVd4cg9E5YC2/FWKXpuHzcabrWy92DC9uzkCmlD+ast7BEGI7xgAFwmb8GW3W1jONOTlCbvhPwvi5KVA0bJI0PYKvNRsAHTiqaX/MjsBZiGkRYSVDHFUdyj9Mi6FiFt2oaRdqb4TE7jW+Fx+RKlR28LcnyFWdLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742449227; c=relaxed/simple;
	bh=Upjw/yWb4OlnCEBwTmspWkyp0uJZb1mknb6860OYb5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLw+zzKv2oAFIw/GpUMrriKN9kZVslWHQ/W0rgu3XDyHufrinVJddz/zAzORsO7dY6HC7PnuIHyMYMPNYBzpkRhb4P9LTlFyF5E7KGLDk38v8RvHZkU2NrM6E4UmXJwJUryGjGq1M9ok1tP2Uj5JPWZJJc8l6ZqSSFjg9avwxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6e-67dbaa401ae0
From: Rakie Kim <rakie.kim@sk.com>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	gourry@gourry.net
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Thu, 20 Mar 2025 14:40:01 +0900
Message-ID: <20250320054010.914-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250320041749.881-2-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXC9ZZnoa7DqtvpBrOvqFnMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK2P7
	iR2sBWeUKy5t7WVsYJwi08XIySEhYCKx+eleti5GDjC7+5gBiMkmoCRxbG8MiCkioCBx6F90
	FyMXB7PAdSaJsw8Ws4PEhQXCJVpniIIMYRFQlbiwfiM7iM0rYCwx7dthVojhmhINl+4xgdic
	QMNv9fxmA7GFBHgkXm3YzwhRLyhxcuYTFhCbWUBeonnrbGaI3tdsEvfPB0DYkhIHV9xgmcDI
	PwtJyywkLQsYmVYxCmXmleUmZuaY6GVU5mVW6CXn525iBAb6sto/0TsYP10IPsQowMGoxMP7
	4sqtdCHWxLLiytxDjBIczEoivCIdt9OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhP
	LEnNTk0tSC2CyTJxcEo1MMau/qS39tH3Beb9+3Pm992MUq8NWsS4YvvhkNAddwXfCC4XuJuY
	3yLZOqWuhdv+cPWS0IafdtMCjK8u6m868JqFXfruyzJlrwqnOZaCTsfufnYxTeo4UF1b5cy+
	jmFWpcHV0HwxY0bOXS7FCb8CtHNcg/boTmrk+ftAU9dzzhmVoIvdr2qclFiKMxINtZiLihMB
	pzuOM3ACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXCNUNNS9dh1e10g0OfZC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugStj+4kdrAVnlCsube1lbGCcItPFyMEhIWAi
	0X3MAMRkE1CSOLY3BsQUEVCQOPQvuouRi4NZ4DqTxNkHi9lB4sIC4RKtM0S7GDk5WARUJS6s
	38gOYvMKGEtM+3aYFcSWENCUaLh0jwnE5gQafqvnNxuILSTAI/Fqw35GiHpBiZMzn7CA2MwC
	8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzA8F5W+2fiDsYv
	l90PMQpwMCrx8L64citdiDWxrLgy9xCjBAezkgivSMftdCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGmrpN29YWG5x5N+WatN2C2zefqjZNF7gb+7yr
	TCfr7kq+BI89LE6v3nAzmapVTZ4gFyJauYzfx5Xr4QH+f1NlXe0MffLdNnz7ILswUVvPICii
	6wnv7ove5nvk3EyvKVxjWpGwnN1ruf6Xd0YMT7eLN5WmJnjnL5dfnjB5Ql/zBtcfahc7dwsr
	sRRnJBpqMRcVJwIAooshrGsCAAA=
X-CFilter-Loop: Reflected

On Thu, 20 Mar 2025 13:17:46 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

Hi Gregory

I initially planned to separate this patch from the hotplug-related patch
series as an independent update. However, after reviewing the code following
Jonathan's suggestion to consolidate `kobject` and `node_attrs` into a single
struct, I realized that most of the intended functionality for Patch 2 was
already incorporated.

As a result, Patch 1 now only contains the `kobject_put` fix, while the
struct consolidation work has been included in Patch 2. Given the current
design, it seems more natural to keep Patch 1 and Patch 2 together as part
of the same patch series rather than separating them.

Rakie

> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with `kobject_put()`, ensuring proper cleanup and preventing
> memory leaks.
> 
> By correctly using `kobject_put()`, the release function now
> properly deallocates memory without causing resource leaks,
> thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> ---
>  mm/mempolicy.c | 61 +++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..5950d5d5b85e 100644
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
> @@ -3512,9 +3521,17 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  			break;
>  		}
>  	}
> -	if (err)
> +	if (err) {
>  		kobject_put(wi_kobj);
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
> @@ -3528,7 +3545,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
>  	mutex_unlock(&iw_table_lock);
>  	synchronize_rcu();
>  	kfree(old);
> -	kfree(node_attrs);
>  	kfree(kobj);
>  }
>  
> @@ -3542,37 +3558,22 @@ static int __init mempolicy_sysfs_init(void)
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
>  
>  	err = add_weighted_interleave_group(mempolicy_kobj);
> -	if (err) {
> -		pr_err("mempolicy sysfs structure failed to initialize\n");
> -		kobject_put(mempolicy_kobj);
> -		return err;
> -	}
> +	if (err)
> +		goto err_out;
> +
> +	return 0;
>  
> -	return err;
> -node_out:
> -	kfree(node_attrs);
> -mempol_out:
> -	kfree(mempolicy_kobj);
>  err_out:
> -	pr_err("failed to add mempolicy kobject to the system\n");
> +	kobject_put(mempolicy_kobj);
>  	return err;
>  }
>  
> 
> base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
> -- 
> 2.34.1
> 
