Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AB1401C;
	Wed,  2 Apr 2025 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557364; cv=none; b=BtWHneuPyRvgrlAVRGOzLWDIKM1LbhAdANN4k10ARDUwOCRjlOMABWIAwVsP/MtKOR3fR42S4xWnaZ3r0pChSUpmSnFL50OgodmkgdW7I8Dfxz2B1no/HyeujQy7O0h3E8vxp21V5eEhntCIy9s0RKrwboMF9IZ4yxVv3FM0DiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557364; c=relaxed/simple;
	bh=8kLxX5lyLtaYcCZIqPT6UMbaiBiyemfBMMRAHy/qvXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqogKch5iyHDB+A11hlgJZb2vABHlssnuyhrUjRuQ6UHvsx73OynD6eBtJcBDIA0INQRdk+Oz/o/LDHEN7VON0s9uKtnnYaXo99DyQzGTexeewtk8U06Q5rFqB316Mj2ZXn9CijFcjBQnLD+dKS3V3Q8fem7v07Ysp8k3XS8tbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4c-67ec92ede4e8
From: Rakie Kim <rakie.kim@sk.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com,
	gourry@gourry.net
Subject: Re: [PATCH v4 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Wed,  2 Apr 2025 10:29:03 +0900
Message-ID: <20250402012912.1075-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <67ec58c8c637_1d472949b@dwillia2-xfh.jf.intel.com.notmuch>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXC9ZZnoe7bSW/SDS7stLCYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8aG
	tcsZC/bIVczoe8XSwHhWoouRk0NCwETi/os7LDD2rW0nmLsYOTjYBJQkju2NAQmLCGhLTJxz
	ECjMxcEscJ5J4kX3HHaQhLBAuMSD9rNgNouAqsSczQcZQWxeoDlHbt9lg5ipKdFw6R4TiM0p
	4C5xZMsbsF1CAjwSrzbsh6oXlDg58wlYnFlAXqJ562ywZRICr9kkZl09AzVIUuLgihssExj5
	ZyHpmYWkZwEj0ypGocy8stzEzBwTvYzKvMwKveT83E2MwIBfVvsnegfjpwvBhxgFOBiVeHgb
	eN+kC7EmlhVX5h5ilOBgVhLhjfj6Ml2INyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTE
	ktTs1NSC1CKYLBMHp1QDI2/B8mn28+qnmedNTv+gfVS3qppLarHImxvCrXuvONSHz7JPzTa8
	2S93l+Pvt5svJz48uafnc2GkjF7KceOvE66E7CphP8MhktTSdnHqo4MPzpmHMGcuFfk7T0l9
	hXhuk5O7yYatBs9S188w6p1UE735x8zTYkI/7/a/4yi22OE18/3Zb2y7fiuxFGckGmoxFxUn
	AgCx7ATxdAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNNS/ftpDfpBlv26VrMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF52evmS1WLbzGZnF86zx2i8NzT7JanJ91isXi8q45bBb31vxntTh07Tmr
	xeo1GRa/t61gc+Dz2DnrLrtHd9tldo+WI29ZPRbvecnksenTJHaPEzN+s3jsfGjp8X7fVTaP
	b7c9PBa/+MDk8XmTXAB3FJdNSmpOZllqkb5dAlfGhrXLGQv2yFXM6HvF0sB4VqKLkZNDQsBE
	4ta2E8xdjBwcbAJKEsf2xoCERQS0JSbOOQgU5uJgFjjPJPGiew47SEJYIFziQftZMJtFQFVi
	zuaDjCA2L9CcI7fvskHM1JRouHSPCcTmFHCXOLLlDQuILSTAI/Fqw36oekGJkzOfgMWZBeQl
	mrfOZp7AyDMLSWoWktQCRqZVjCKZeWW5iZk5pnrF2RmVeZkVesn5uZsYgUG+rPbPxB2MXy67
	H2IU4GBU4uEV6HmTLsSaWFZcmXuIUYKDWUmEN+Lry3Qh3pTEyqrUovz4otKc1OJDjNIcLEri
	vF7hqQlCAumJJanZqakFqUUwWSYOTqkGRsM2NYZWT5ZF1tzL4x/9lupz5zw2eeKrFOEX5/Of
	+pUcWfujR2CB/VdV/yfeYUVH3dyYKt7O2/V5ktTfPW8Xrro7RUti9/O7mr9Tt2/dMXOlkeCV
	Lyult6n8r9C47fDR/cGECL/TB05piklyb5necs/K9ojhF0+OmU9iLIv/XUiYt6LLxE16Bq8S
	S3FGoqEWc1FxIgBuu/7EbgIAAA==
X-CFilter-Loop: Reflected

On Tue, 1 Apr 2025 14:21:12 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Rakie Kim wrote:
> > Memory leaks occurred when removing sysfs attributes for weighted
> > interleave. Improper kobject deallocation led to unreleased memory
> > when initialization failed or when nodes were removed.
> > 
> > This patch resolves the issue by replacing unnecessary `kfree()`
> > calls with `kobject_put()`, ensuring proper cleanup and preventing
> > memory leaks.
> > 
> > By correctly using `kobject_put()`, the release function now
> > properly deallocates memory without causing resource leaks,
> > thereby improving system stability.
> > 
> > Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > ---
> >  mm/mempolicy.c | 61 +++++++++++++++++++++++++-------------------------
> >  1 file changed, 31 insertions(+), 30 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index bbaadbeeb291..5950d5d5b85e 100644
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
> > +	}
> > +
> >  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> >  				   "weighted_interleave");
> 
> It would be nice if this could take advantage of scope-based cleanup to
> avoid the new gotos. It would need a new:
> 
> DEFINE_FREE(kobject_put, struct kobject *, if (!IS_ERR_OR_NULL(_T)) kobject_put(_T))
> 
> ...and a wrapper around kobject_init_and_add() to support auto cleanup:
> 
> struct kobject *kobject_init_and_add_or_errptr(struct kobject *kobj)
> {
> 	int err = kobject_init_and_add(kobj...);
> 
> 	if (err)
> 		return ERR_PTR(err);
> 	return kobj;
> }
> 
> With those then you could do:
> 
> struct kobject *wi_kobj __free(kfree) = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> struct kobject *kobj __free(kobject_put) = kobject_init_and_add_or_errptr(no_free_ptr(wi_kobj), ...)
> 
> Otherwise, the patch does look good to me as is, but it seems like an
> opportunity for further cleanups that might also help other
> kobject_init_and_add() code paths.

Thank you for your response regarding this patch.

I believe that the method you suggested using `DEFINE_FREE` is an optimal
solution for addressing the memory release issue related to `kobject`.

I also think that similar problems may arise in many other kernel modules
that use `kobject`, and therefore, it would be beneficial to address this
issue more generally in those modules as well.

However, I believe that including such functionality as part of this patch
series may not be ideal. Instead, I think it's better to introduce this
approach as a separate patch for broader application and review.

I will work on creating a follow-up patch based on your suggestion.
Once again, thank you for proposing a clean and helpful solution.

Rakie

