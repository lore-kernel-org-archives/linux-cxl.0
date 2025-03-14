Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0A190468;
	Fri, 14 Mar 2025 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938286; cv=none; b=gtHgMt6kz6bfE16Z/93Gyf9LywKMvypoJ7bUTL6GsJIM9kkXC4t+dLx04O4L/kINGffZk+XQ0lFK8e/3DKC7N1Lh+eFuIj8+x8izvYk6tm1Bm/lmnkZ5w5YSDj+1UBugT53wyVL7EMXmPrzDlWM4MY2sc6faWB7qeKR4jRHd8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938286; c=relaxed/simple;
	bh=91ptrKYVgvUExZhnsTJFVT9CkAFHXxfrnrnkNYBuX54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJEFj4YmZDwUzEj2jGiDyAXnJdR/FE3n95aW694YOG03Z1umgNG7f9Dx37BuSMSKhlg9eD6MLjfhRNOvSsOdYevdKlAMUW6ObKYtCxrF2Kmrl9LUCJs6jIzj3NnyQT9Pwti21l/wINjIf3Pvei0MRUqkLuBPxiUnV6WdE83AjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a6-67d3de65ef9c
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in mempolicy_sysfs_init()
Date: Fri, 14 Mar 2025 16:44:11 +0900
Message-ID: <20250314074433.780-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9L_MgjuhrploEUm@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnkW7qvcvpBqeOqVnMWb+GzWL61AuM
	Fj/vHme3OL51HrvF+VmnWCwu75rDZnFvzX9Wi9VrMhw4PHbOusvu0d12md1j8Z6XTB6bPk1i
	9zgx4zeLx86Hlh6fN8kFsEdx2aSk5mSWpRbp2yVwZWxf94a94JZUxcz3txgbGM+JdDFyckgI
	mEisaNzBDGO/WL8OyObgYBNQkji2NwbEFBFQlWi74t7FyMXBLLCeSeL1pllsIOXCAiES624t
	ZgexWYBquo/NZQep5xUwlpgwswhioqZEw6V7TCA2p4CZxIS928HKhQR4JF5t2M8IYvMKCEqc
	nPmEBcRmFpCXaN46mxlkl4TAGTaJie8esUMMkpQ4uOIGywRG/llIemYh6VnAyLSKUSgzryw3
	MTPHRC+jMi+zQi85P3cTIzCIl9X+id7B+OlC8CFGAQ5GJR7eDbsupQuxJpYVV+YeYpTgYFYS
	4bW4fDldiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6Pw
	/Ig+v1DByaKfo9VjXbsPm4YZTp5ZoJv/ZtaK+EUFfW8FO05nL7h55cqj1Krwe40nFXRDQrXv
	8rCVaXy9M3U9i8PaykRdw4x7fxjz6y6L7OyprcgIO/x+z76ECY8SC4wC90fPVz22bbaZk8OE
	1G+3qtlkpr1v2Lk1d/3th+sEsoorkmKXPVRiKc5INNRiLipOBAAtAxLgXgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXCNUNNSzf13uV0g8dHxSzmrF/DZjF96gVG
	i593j7NbfH72mtni+NZ57BaH555ktTg/6xSLxeVdc9gs7q35z2px6NpzVovVazIsfm9bwebA
	47Fz1l12j+62y+wei/e8ZPLY9GkSu8eJGb9ZPHY+tPT4dtvDY/GLD0wenzfJBXBGcdmkpOZk
	lqUW6dslcGVsX/eGveCWVMXM97cYGxjPiXQxcnJICJhIvFi/jrmLkYODTUBJ4tjeGBBTREBV
	ou2KexcjFwezwHomidebZrGBlAsLhEisu7WYHcRmAarpPjaXHaSeV8BYYsLMIoiJmhINl+4x
	gdicAmYSE/ZuBysXEuCReLVhPyOIzSsgKHFy5hMWEJtZQF6ieets5gmMPLOQpGYhSS1gZFrF
	KJKZV5abmJljqlecnVGZl1mhl5yfu4kRGLjLav9M3MH45bL7IUYBDkYlHt4Nuy6lC7EmlhVX
	5h5ilOBgVhLhtbh8OV2INyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFM
	lomDU6qB8aKTlJnOix/t0/WKP0Tt3jahb0+Aqt1vsRcXHGoai7xvirr+Zjwwz/TJnvrtfAXr
	ORQ2HHg5p5CHucrpQ/jas5q3q1bebNof5fL92f+s61ESib1aEgo68yb0fRYxUpN5WHDtudmR
	L3w1v0U8ru2bcTzmpAlTSNn+sCmOU1iOyStbzr/6tulqohJLcUaioRZzUXEiAOU/NchYAgAA
X-CFilter-Loop: Reflected

On Thu, 13 Mar 2025 11:52:18 -0400 Gregory Price <gourry@gourry.net> wrote:
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

I will make every effort to incorporate your suggestions.
Additionally, I will separate this patch from the current patch series
and create it as an independent patch.

Rakie

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
