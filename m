Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD021ADB0;
	Mon, 17 Mar 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199880; cv=none; b=WiLbgeDF6uZ0ZuVyLzjf9akctqIjv/+f72YoY9RRhNUk84n/0aNtNWvoOvyzL4Or+tzoBXZGkPz9hRxEI+WDHS9rbYou9mF+nMwKHEDlA1xbZOgV7tFE3tmyqt/Ek5Q6ktawvuH3v1ilQ4WzO+QuJoBRU7Oqc2RviHI+AZZAFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199880; c=relaxed/simple;
	bh=b7Rn3k+XrysZNtSoTUfI/Vqywy0np6ejQIRHxes6qig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrqZOlwjcZEzORgvkyrloFQrEw6ZJVS29snntqod+ZSldMT0Nuv4+1tlJysUt3vkM58hikQt4qlD6+K/wUDX0QX2ZCVV8Urlx31YfKsvvrMkh0hXalTE0OnZwVoLqTUDEVBxpbEnsAqCeVf6qFoQjuUqCdntOYewSpR2WBMH5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4f-67d7dc4337dc
From: Rakie Kim <rakie.kim@sk.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rakie Kim <rakie.kim@sk.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v2 1/4] mm/mempolicy: Fix memory leaks in mempolicy_sysfs_init()
Date: Mon, 17 Mar 2025 17:24:23 +0900
Message-ID: <20250317082430.829-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250314105500.00000157@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC9ZZnoa7znevpBjPWcFnMWb+GzWL61AuM
	Fj/vHme3WLXwGpvF8a3z2C3OzzrFYnF51xw2i3tr/rNarF6T4cDpsXPWXXaP7rbL7B4tR96y
	eize85LJY9OnSeweJ2b8ZvHY+dDS4/MmuQCOKC6blNSczLLUIn27BK6Mni9P2QpOKlas33iC
	tYHxgGQXIweHhICJxISdwl2MnGDmsSXLWUHCbAJKEsf2xoCERQSMJN7dmMTYxcjFwSxwhUni
	9bEWNpCEsECIxLpbi9lBbBYBVYkfn26zgNi8AsYSpy43MUPM1JRouHSPCcTmFDCUePlgO1i9
	kACPxKsN+xkh6gUlTs58AtbLLCAv0bx1NjPIMgmB+2wS63b0MUEMkpQ4uOIGywRG/llIemYh
	6VnAyLSKUSgzryw3MTPHRC+jMi+zQi85P3cTIzC0l9X+id7B+OlC8CFGAQ5GJR5eg/XX0oVY
	E8uKK3MPMUpwMCuJ8LLsuJ4uxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6Yklqdmpq
	QWoRTJaJg1OqgdHkhelBRoWbyrL+//a+UpnTxF+l2bd9lshKdfO8HsMv8x++U5v50HBH5RfT
	0MCOgjO+StctTujeuL3dWfeec00EazFL5qJ1L28ZVCeuTHrDyR3FpyXq1HhcO+/yn0792HMs
	gekS87e4mTRLvlot+GH1SS0XUYXjlbzeW+Qsay4Hb9ddw2nwXImlOCPRUIu5qDgRABN4wzNp
	AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsXCNUNNS9fpzvV0g3XTbSzmrF/DZjF96gVG
	i593j7NbfH72mtli1cJrbBbHt85jtzg89ySrxflZp1gsLu+aw2Zxb81/VotD156zWqxek2Hx
	e9sKNgdej52z7rJ7dLddZvdoOfKW1WPxnpdMHps+TWL3ODHjN4vHzoeWHt9ue3gsfvGByePz
	JrkArigum5TUnMyy1CJ9uwSujJ4vT9kKTipWrN94grWB8YBkFyMnh4SAicSxJctZuxg5ONgE
	lCSO7Y0BCYsIGEm8uzGJsYuRi4NZ4AqTxOtjLWwgCWGBEIl1txazg9gsAqoSPz7dZgGxeQWM
	JU5dbmKGmKkp0XDpHhOIzSlgKPHywXaweiEBHolXG/YzQtQLSpyc+QSsl1lAXqJ562zmCYw8
	s5CkZiFJLWBkWsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREY0Mtq/0zcwfjlsvshRgEORiUe
	XoP119KFWBPLiitzDzFKcDArifCy7LieLsSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUgg
	PbEkNTs1tSC1CCbLxMEp1cC4cqbulFb/peJNa2rVXJruOi8/b+TN/kLlaX3hasbV3ad6f/06
	GVw9bYmMHsf6dpmG6mdLVhe+tnvwatuKrM9lbo9MbMrTIl2kON9f0VD6vqTNIstxnvU8/h63
	7k0KXkFyywq3T3imUfvOUai+7orh0yvJAbqLV3bMefxNdIfTLdPN80Jy7M8qsRRnJBpqMRcV
	JwIAZeOdBGQCAAA=
X-CFilter-Loop: Reflected

On Fri, 14 Mar 2025 10:55:00 +0000 Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> On Thu, 13 Mar 2025 11:52:18 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Mar 13, 2025 at 03:31:38PM +0900, Rakie Kim wrote:
> > > > Is this correct? If kobject_init_and_add fails, from other examples we
> > > > need only free the mempolicy_kobj - because it failed to initialize and
> > > > therefore should not have any references.  I think this causes an
> > > > underflow.  
> > > 
> > > Regarding the reordering of mempolicy_kobj allocation:
> > > 1) In kobject_init_and_add(), kobject_init() is always called, which  
> > 
> > Quite right, mea culpa.
> > 
> > > 
> > > 2) The release function for mempolicy_kobj is responsible for freeing
> > >    associated memory:
> > > 
> > >    static void mempolicy_kobj_release(struct kobject *kobj)
> > >    {
> > >        ...
> > >        kfree(ngrp->nattrs);
> > >        kfree(ngrp);
> > >        kfree(kobj);
> > >    }
> > >   
> > 
> > I see what you're trying to do now after looking at the free-ordering
> > at little closer.
> > 
> > Lets do the following:
> > 
> > 1) allocate node_attrs and mempolicy_kobj up front and keep your
> >    reordering, this lets us clean up allocations on failure before
> >    kobject_init is called
> > 
> > 2) after this remove all the other code and just let
> >    mempolicy_kobj_release clean up node_attrs
> > 
> > 3) Add a (%d) to the error message to differentiate failures
> 
> Given how unlikely (and noisy) a memory allocation failure is,
> maybe just drop the printing at all in those paths - allowing
> early returns.
> 
> The lifetime rules around node_attrs in here are making readability
> poor. It is implicitly owned by the mempolicy_kobj, but no direct association.
> Maybe just encapsulating the kobject in a structure that contains
> this as a [] array at the end.  Then we end up with single allocation of
> stuff that is effectively one thing.
> 

Hi Jonathan

Thank you for your response regarding this patch.
Your suggestions seem very appropriate. As you recommended, I will proceed to
encapsulate node_attrs and mempolicy_kobj into a single structure.

Rakie

> 
> > 
> > This is a little bit cleaner and is a bit less code. (Not built or
> > tested, just a recommendation).
> > 
> > I'd recommend submitting this patch by itself to mm-stable, since the
> > remainder of the patch line changes functionality and this fixes a bug
> > in LTS kernels.
> > 
> > ~Gregory
> > 
> > ---
> > 
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 530e71fe9147..05a410db08b4 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3541,38 +3541,34 @@ static int __init mempolicy_sysfs_init(void)
> >  	int err;
> >  	static struct kobject *mempolicy_kobj;
> > 
> > -	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> > -	if (!mempolicy_kobj) {
> > +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > +			     GFP_KERNEL);
> > +	if (!node_attrs) {
> >  		err = -ENOMEM;
> >  		goto err_out;
> >  	}
> > 
> > -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > -			     GFP_KERNEL);
> > -	if (!node_attrs) {
> > +	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> > +	if (!mempolicy_kobj) {
> >  		err = -ENOMEM;
> > -		goto mempol_out;
> > +		kfree(node_attrs);
> > +		goto err_out;
> >  	}
> > 
> >  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> >  				   "mempolicy");
> >  	if (err)
> > -		goto node_out;
> > +		goto mempol_out;
> > 
> >  	err = add_weighted_interleave_group(mempolicy_kobj);
> > -	if (err) {
> > -		pr_err("mempolicy sysfs structure failed to initialize\n");
> > -		kobject_put(mempolicy_kobj);
> > -		return err;
> > -	}
> > +	if (err)
> > +		goto mempol_out;
> > 
> > -	return err;
> > -node_out:
> > -	kfree(node_attrs);
> > +	return 0;
> >  mempol_out:
> > -	kfree(mempolicy_kobj);
> > +	kobject_put(mempolicy_kobj);
> >  err_out:
> > -	pr_err("failed to add mempolicy kobject to the system\n");
> > +	pr_err("mempolicy sysfs structure failed to initialize (%d)\n", err);
> >  	return err;
> >  }
> > 
> > 
> 
