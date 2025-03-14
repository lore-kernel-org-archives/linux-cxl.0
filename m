Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3B1FCFE7;
	Fri, 14 Mar 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949709; cv=none; b=TLXY44zdZN6VbC9+BUCUFR4CH6NKcqzDu1sflpNEyn0Z5SKx7zbYWuiQTKXYXVZNfs5GFGmehyEo0NqBI1y8FAtaM/HuS2a0+MiMeYzejPDhRH+IOBE5gtotshhk8DVwgm8YyAeRoP2VTudRdHh7z1Puxlxpx+BbdYoK4xAvCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949709; c=relaxed/simple;
	bh=nNm+VhtAcLEdsHKBLMc5J8ULnVh4KdS4HhppmBKfEYI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8uz7cfk/qTs8B0KmKe4z9gFCIK/O7qQvrA/k/RvjpLmJRgTjYIUtRxxK3ikvG2n4iEfGFkb9YE/YXnQseKoJ8evP3xlpLLPRldfGa0cX1w756uUvdBUzs+ukG42lU+atzoRGg8WKcVsB3gqHaUT94cRsiw1jrfyXWiZincR6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDh3S0VHKz67D9Y;
	Fri, 14 Mar 2025 18:50:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BC6391400CA;
	Fri, 14 Mar 2025 18:55:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 11:55:02 +0100
Date: Fri, 14 Mar 2025 10:55:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Rakie Kim <rakie.kim@sk.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <joshua.hahnjy@gmail.com>,
	<dan.j.williams@intel.com>, <ying.huang@linux.alibaba.com>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in
 mempolicy_sysfs_init()
Message-ID: <20250314105500.00000157@huawei.com>
In-Reply-To: <Z9L_MgjuhrploEUm@gourry-fedora-PF4VCD3F>
References: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
	<20250313063247.681-1-rakie.kim@sk.com>
	<Z9L_MgjuhrploEUm@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Mar 2025 11:52:18 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Mar 13, 2025 at 03:31:38PM +0900, Rakie Kim wrote:
> > > Is this correct? If kobject_init_and_add fails, from other examples we
> > > need only free the mempolicy_kobj - because it failed to initialize and
> > > therefore should not have any references.  I think this causes an
> > > underflow.  
> > 
> > Regarding the reordering of mempolicy_kobj allocation:
> > 1) In kobject_init_and_add(), kobject_init() is always called, which  
> 
> Quite right, mea culpa.
> 
> > 
> > 2) The release function for mempolicy_kobj is responsible for freeing
> >    associated memory:
> > 
> >    static void mempolicy_kobj_release(struct kobject *kobj)
> >    {
> >        ...
> >        kfree(ngrp->nattrs);
> >        kfree(ngrp);
> >        kfree(kobj);
> >    }
> >   
> 
> I see what you're trying to do now after looking at the free-ordering
> at little closer.
> 
> Lets do the following:
> 
> 1) allocate node_attrs and mempolicy_kobj up front and keep your
>    reordering, this lets us clean up allocations on failure before
>    kobject_init is called
> 
> 2) after this remove all the other code and just let
>    mempolicy_kobj_release clean up node_attrs
> 
> 3) Add a (%d) to the error message to differentiate failures

Given how unlikely (and noisy) a memory allocation failure is,
maybe just drop the printing at all in those paths - allowing
early returns.

The lifetime rules around node_attrs in here are making readability
poor. It is implicitly owned by the mempolicy_kobj, but no direct association.
Maybe just encapsulating the kobject in a structure that contains
this as a [] array at the end.  Then we end up with single allocation of
stuff that is effectively one thing.


> 
> This is a little bit cleaner and is a bit less code. (Not built or
> tested, just a recommendation).
> 
> I'd recommend submitting this patch by itself to mm-stable, since the
> remainder of the patch line changes functionality and this fixes a bug
> in LTS kernels.
> 
> ~Gregory
> 
> ---
> 
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 530e71fe9147..05a410db08b4 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3541,38 +3541,34 @@ static int __init mempolicy_sysfs_init(void)
>  	int err;
>  	static struct kobject *mempolicy_kobj;
> 
> -	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> -	if (!mempolicy_kobj) {
> +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> +			     GFP_KERNEL);
> +	if (!node_attrs) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}
> 
> -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> -			     GFP_KERNEL);
> -	if (!node_attrs) {
> +	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> +	if (!mempolicy_kobj) {
>  		err = -ENOMEM;
> -		goto mempol_out;
> +		kfree(node_attrs);
> +		goto err_out;
>  	}
> 
>  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
>  				   "mempolicy");
>  	if (err)
> -		goto node_out;
> +		goto mempol_out;
> 
>  	err = add_weighted_interleave_group(mempolicy_kobj);
> -	if (err) {
> -		pr_err("mempolicy sysfs structure failed to initialize\n");
> -		kobject_put(mempolicy_kobj);
> -		return err;
> -	}
> +	if (err)
> +		goto mempol_out;
> 
> -	return err;
> -node_out:
> -	kfree(node_attrs);
> +	return 0;
>  mempol_out:
> -	kfree(mempolicy_kobj);
> +	kobject_put(mempolicy_kobj);
>  err_out:
> -	pr_err("failed to add mempolicy kobject to the system\n");
> +	pr_err("mempolicy sysfs structure failed to initialize (%d)\n", err);
>  	return err;
>  }
> 
> 

