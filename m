Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCEB22FE07;
	Mon,  7 Apr 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018693; cv=none; b=dHnzsmmMBWl1hoAQPIAkdVioUsPEMdBhSe1Et6LF1uOW2OyY6qtHUfv3yMie15tKtIpA/2OcFDpgTjrB07Om3zBDq6A9g84JpaAiDZijeygJYMmwaU/e3kt3IJAQ2HdD2faRGyc3pAqMRCQcw/hEgZT+r6N0piyoFj9ZeCIeNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018693; c=relaxed/simple;
	bh=so1M13uYeqlqlSBoxVsye2zlapdSowU+KnXTgHES3d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1efkWuZtLY/+CTEB76/jEJYiV7eXs8qUv+2kiNGJIDccTu9GFmx9MFUsYKznYARwG2t3GOzK7SPXhzz/j+f7Lh/6G+c/U5k0OMl14IjO0OCfzzLZBoSyXRZnSnLdkfVLY5SEsKuJfDAs6DqzT0rLZTyn3CGHu6zSEZiMMt3jV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-f8-67f39cfdb816
From: Rakie Kim <rakie.kim@sk.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v6 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Mon,  7 Apr 2025 18:37:53 +0900
Message-ID: <20250407093800.417-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250404135906.0000308e@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe7fOZ/TDc4c5rCYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vFmWlFFqvXZDhwe+ycdZfd
	o7vtMrtHy5G3rB6L97xk8tj0aRK7x4kZv1k8dj609Hi/7yqbx+bT1R6fN8kFcEVx2aSk5mSW
	pRbp2yVwZaz8+JGt4IVpxabTj5gaGFdqdjFyckgImEg8vtbE1MXIAWbv2xoOYrIJKEkc2xsD
	UiEiYCTx7sYkxi5GLg5mgbdMEg9+7AErFxYIl5i7wB/EZBFQlZh4iAmknFfAWGLD5MOsEMM1
	JRou3QOLcwoYSrS8XQgWFxLgkXi1YT8jRL2gxMmZT1hAbGYBeYnmrbOZQVZJCHxmk3jbD5GQ
	EJCUOLjiBssERv5ZSHpmIelZwMi0ilEoM68sNzEzx0QvozIvs0IvOT93EyMw9JfV/onewfjp
	QvAhRgEORiUe3h1un9OFWBPLiitzDzFKcDArifBanvqULsSbklhZlVqUH19UmpNafIhRmoNF
	SZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoHRJsTnCFPN6StJtarvboSl6V4S//6gQ+VYYv+h
	n18e9WW+u+bY053Mw2ty7GqMMhv3jIs5xToPeTYH3152hXPTdZ4G3g/fRDY0SGa8jWa8PkXN
	8lHgEqU7csdXfLikFi1o4HVe7OXe3I2fdguYv3SNOCjn2Gblobmd5bt0QKD6zLjrZjFs5m5K
	LMUZiYZazEXFiQBnpm4beQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXCNUNNS/fPnM/pBo2NVhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBkrP35kK3hhWrHp9COmBsaV
	ml2MHBwSAiYS+7aGg5hsAkoSx/bGdDFycogIGEm8uzGJsYuRi4NZ4C2TxIMfe5hAaoQFwiXm
	LvAHMVkEVCUmHmICKecVMJbYMPkwK4gtIaAp0XDpHlicU8BQouXtQrC4kACPxKsN+xkh6gUl
	Ts58wgJiMwvISzRvnc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQLD
	fVntn4k7GL9cdj/EKMDBqMTDe6PxU7oQa2JZcWXuIUYJDmYlEV7LU0Ah3pTEyqrUovz4otKc
	1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxr1d/LqBmr/mX34hYpvDtW7xR1mv
	p50lM54t2/DMeHlejGjcCpFsnuT/Jm11gdGsrJm/ZnP/D5jFkmIhmXvmErd1uORTr557XAf4
	rsX/ig5jmN14r9n+o/6CCQUduzPaJkQ+mP16nXH5i8Rf4llKXnwBHEd99P6Efp9isup59o3M
	3bP2aia8U2Ipzkg01GIuKk4EAJgVBiZzAgAA
X-CFilter-Loop: Reflected

On Fri, 4 Apr 2025 13:59:06 +0100 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> On Fri, 4 Apr 2025 16:46:19 +0900
> Rakie Kim <rakie.kim@sk.com> wrote:
> 
> > Memory leaks occurred when removing sysfs attributes for weighted
> > interleave. Improper kobject deallocation led to unreleased memory
> > when initialization failed or when nodes were removed.
> > 
> > This patch resolves the issue by replacing unnecessary `kfree()`
> > calls with proper `kobject_del()` and `kobject_put()` sequences,
> > ensuring correct teardown and preventing memory leaks.
> > 
> > By explicitly calling `kobject_del()` before `kobject_put()`,
> > the release function is now invoked safely, and internal sysfs
> > state is correctly cleaned up. This guarantees that the memory
> > associated with the kobject is fully released and avoids
> > resource leaks, thereby improving system stability.
> > 
> > Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> I've pretty much forgotten earlier discussions so apologies if I revisit
> old ground! 
> 
> The fix is fine I think. But the resulting code structure
> could be improved, without (I think) complicating what is here by much.
> 

Thank you for your response regarding this patch.
I appreciate your willingness to revisit this code and share your
thoughts. Please feel free to provide suggestions anytime.

> > ---
> >  mm/mempolicy.c | 64 +++++++++++++++++++++++++++-----------------------
> >  1 file changed, 34 insertions(+), 30 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index bbaadbeeb291..af3753925573 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3448,7 +3448,9 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
> >  
> >  	for (i = 0; i < nr_node_ids; i++)
> >  		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> > -	kobject_put(wi_kobj);
> > +
> > +	kfree(node_attrs);
> > +	kfree(wi_kobj);
> >  }
> >  
> >  static const struct kobj_type wi_ktype = {
> > @@ -3494,15 +3496,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  	struct kobject *wi_kobj;
> >  	int nid, err;
> >  
> > -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > -	if (!wi_kobj)
> > +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > +			     GFP_KERNEL);
> > +	if (!node_attrs)
> >  		return -ENOMEM;
> >  
> > +	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > +	if (!wi_kobj) {
> > +		err = -ENOMEM;
> > +		goto node_out;
> As this is only place where we do kfree(node_attrs)
> why not just do that here and return directly.

Regarding your suggestion:
Is the following change what you had in mind?
               
    wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
    if (!wi_kobj) {
        kfree(node_attrs);
        return -ENOMEM;
    }
I will apply this change accordingly.

> 
> 		
> > +	}
> > +
> >  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> >  				   "weighted_interleave");
> >  	if (err) {
> > -		kfree(wi_kobj);
> > -		return err;
> > +		kobject_put(wi_kobj);
> > +		goto err_out;
> >  	}
> >  
> >  	for_each_node_state(nid, N_POSSIBLE) {
> > @@ -3512,9 +3521,18 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  			break;
> >  		}
> >  	}
> > -	if (err)
> > +	if (err) {
> > +		kobject_del(wi_kobj);
> >  		kobject_put(wi_kobj);
> 
> For this and the one above, a unified exit kind of makes sense as
> can do two labels and have the put only once.
> 
> If not, why not move this up into the loop and return directly?
> If you move to an error handling block
> 
> err_del_obj:
> 	kobject_del(wi_kobj);
> err_put_obj:
> 	kobject_put(wi_kobj);
> 
> then you could also do the goto from within that loop.
> 

As for your second suggestion about restructuring the error handling,
you are right that having unified labels helps make the flow cleaner.
I will update the code to use:

err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
                           "weighted_interleave");
if (err)
    goto err_put_kobj;

for_each_node_state(nid, N_POSSIBLE) {
    err = add_weight_node(nid, wi_kobj);
    if (err) {
        pr_err("failed to add sysfs [node%d]\n", nid);
        goto err_del_kobj;
    }
}

err_del_kobj:
    kobject_del(wi_kobj);
err_put_kobj:
    kobject_put(wi_kobj);
    return err;

This structure keeps error handling more consistent and avoids redundancy.

> 
> > +		goto err_out;
> > +	}
> > +
> >  	return 0;
> > +
> > +node_out:
> > +	kfree(node_attrs);
> > +err_out:
> > +	return err;
> >  }
> >  
> >  static void mempolicy_kobj_release(struct kobject *kobj)
> > @@ -3528,7 +3546,6 @@ static void mempolicy_kobj_release(struct kobject *kobj)
> >  	mutex_unlock(&iw_table_lock);
> >  	synchronize_rcu();
> >  	kfree(old);
> > -	kfree(node_attrs);
> >  	kfree(kobj);
> >  }
> >  
> > @@ -3542,37 +3559,24 @@ static int __init mempolicy_sysfs_init(void)
> >  	static struct kobject *mempolicy_kobj;
> >  
> >  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> > -	if (!mempolicy_kobj) {
> > -		err = -ENOMEM;
> > -		goto err_out;
> > -	}
> > -
> > -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > -			     GFP_KERNEL);
> > -	if (!node_attrs) {
> > -		err = -ENOMEM;
> > -		goto mempol_out;
> > -	}
> > +	if (!mempolicy_kobj)
> > +		return -ENOMEM;
> >  
> >  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> >  				   "mempolicy");
> >  	if (err)
> > -		goto node_out;
> > +		goto err_out;
> 		goto err_put_kobj;
>  or something like that.
> 
> >  
> >  	err = add_weighted_interleave_group(mempolicy_kobj);
> > -	if (err) {
> > -		pr_err("mempolicy sysfs structure failed to initialize\n");
> > -		kobject_put(mempolicy_kobj);
> > -		return err;
> > -	}
> > +	if (err)
> > +		goto err_del;
> >  
> > -	return err;
> > -node_out:
> > -	kfree(node_attrs);
> > -mempol_out:
> > -	kfree(mempolicy_kobj);
> > +	return 0;
> > +
> > +err_del:
> > +	kobject_del(mempolicy_kobj);
> >  err_out:
> > -	pr_err("failed to add mempolicy kobject to the system\n");
> > +	kobject_put(mempolicy_kobj);
> If we keep an err_out, usual expectation is all it does is return
> + maybe print a message. We'd not expect a put.

Lastly, I agree with your point about `err_out`.
I will revise it to use `err_del_kobj` and `err_put_kobj` as needed.

Thanks again for the detailed review.

Rakie

> 
> >  	return err;
> >  }
> >  
> 
