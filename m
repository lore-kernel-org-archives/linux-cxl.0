Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7318C221F35;
	Mon, 10 Mar 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595347; cv=none; b=afoJBJeEV8r6ihmesu3YSe4ZKLpblq9cx1yoFoxXuNEwHXqtvUCJ1r5smwCMRJQfKDpU3QIJK5cisFNdJh5HklnpgmdHVja4zFBF8uCNK+shiRQh3HcDTEktX1s9KTR5UaeHYpYn5b8c3H13zL6t4ny8punEqyc35Isiw3FCv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595347; c=relaxed/simple;
	bh=6M1UyAd8d/M18H5uFCfbe/Orf+WJZ8oMBL9WVomey2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8Ceo/MziswsZzSHe7uV/oALactZHqS2SM99LZ/etWC/n4qWPPsJj52qD97YLGU84W40Gl1tFzTDe7EhXRHftKiSODJMATFzEtIUUt7vA2PSS81yXd768RcwCiF2fmykiTzfmdALurEFI9ioERR1opuhPl0kVNviKUqwmKhydSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-62-67cea2ca9924
From: Rakie Kim <rakie.kim@sk.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH 2/4] mm/mempolicy: Enable sysfs support for memory hotplug in weighted interleave
Date: Mon, 10 Mar 2025 17:28:38 +0900
Message-ID: <20250310082854.606-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250307182015.489780-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoe6pRefSDT7/0bOYs34Nm8X0qRcY
	LX7ePc5ucXzrPHaL87NOsVhc3jWHzeLemv+sFqvXZDhweOycdZfdo7vtMrvH4j0vmTw2fZrE
	7nFixm8Wj50PLT0+b5ILYI/isklJzcksSy3St0vgymh5V1twWKmi/cdOtgbGNukuRg4OCQET
	id3nvboYOcHM9i0L2UHCbAJKEsf2xoCERQQ0JU60TmLuYuTiYBZYySTRtuA0M0hCWCBV4ti6
	6ewgNouAqsTkQ1PYQGxeAWOJ5acesEHM1JRouHSPCcTmFLCT2PVjCVivkACPxKsN+xkh6gUl
	Ts58wgJiMwvISzRvnQ22TELgDJvEz5N/WSAGSUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5ab
	mJljopdRmZdZoZecn7uJERjEy2r/RO9g/HQh+BCjAAejEg/vg3ln04VYE8uKK3MPMUpwMCuJ
	8KptP5UuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgVGt
	89h8YcepLb3/L+xIncVy6aPOsuOVX49d2enuu2aBd8upay8X7fUorGu7d2raRjVRpbLqeaG6
	GzwmLC/qbq64uu0D81n152JZs7Rf/Vqr2vI+bf3iX4H5hXoZB+TqHz8VPvFHb9rU4PORKd4z
	Ow7oNl53zjDfUbvMjSVs95arW27H30rlztNVYinOSDTUYi4qTgQA8vUg2l4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS/fUonPpBr/OKlrMWb+GzWL61AuM
	Fj/vHme3+PzsNbPF8a3z2C0Ozz3JanF+1ikWi8u75rBZ3Fvzn9Xi0LXnrBar12RY/N62gs2B
	x2PnrLvsHt1tl9k9Fu95yeSx6dMkdo8TM36zeOx8aOnx7baHx+IXH5g8Pm+SC+CM4rJJSc3J
	LEst0rdL4MpoeVdbcFipov3HTrYGxjbpLkZODgkBE4n2LQvZuxg5ONgElCSO7Y0BCYsIaEqc
	aJ3E3MXIxcEssJJJom3BaWaQhLBAqsSxddPZQWwWAVWJyYemsIHYvALGEstPPWCDmKkp0XDp
	HhOIzSlgJ7HrxxKwXiEBHolXG/YzQtQLSpyc+YQFxGYWkJdo3jqbeQIjzywkqVlIUgsYmVYx
	imTmleUmZuaY6hVnZ1TmZVboJefnbmIEhu6y2j8TdzB+uex+iFGAg1GJh/fBvLPpQqyJZcWV
	uYcYJTiYlUR41bafShfiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgST
	ZeLglGpgrHE4eSR5/YXCL+ohm9/aLLl/vHWWclD7ksW3eav/Vd53Mu44cWLiBdnlC79kMj89
	zHey6U3d/o09+Su3vDm4n9/0weLAnFdTos8oeXXFJ+3NivRNXpvgWLrgaZBL3XKzEzaHrE6d
	y6r+XP3m4Kq6xsX69YIJ39pma/HN7/48q5tn2kRvrkLvfCWW4oxEQy3mouJEAKmylgZZAgAA
X-CFilter-Loop: Reflected

On Fri,  7 Mar 2025 10:19:59 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

Hi Joshua
Thank you for your response regarding this patch.

> On Fri,  7 Mar 2025 15:35:31 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> 
> Hi Rakie, thank you for your work on this patch! I think it makes a lot of
> sense, given the discussion between Gregory & Honggyu in the weighted
> interleave auto-tuning patch.
> 
> I have a few small nits and questions that I wanted to raise, but none that
> should change the behavior at all : -)
> 
> > Previously, sysfs entries for weighted interleave were only created during
> > initialization, preventing dynamically added memory nodes from being recognized.
> > 
> > This patch enables sysfs registration for nodes added via memory hotplug,
> > allowing weighted interleave settings to be updated as the system memory
> > configuration changes.
> > 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > ---
> >  mm/mempolicy.c | 51 +++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 32 insertions(+), 19 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 385607179ebd..fc10a9a4be86 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3389,6 +3389,13 @@ struct iw_node_attr {
> >  	int nid;
> >  };
> >  
> > +struct iw_node_group {
> > +	struct kobject *wi_kobj;
> > +	struct iw_node_attr **nattrs;
> > +};
> > +
> > +static struct iw_node_group *ngrp;
> > +
> >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  			 char *buf)
> >  {
> > @@ -3431,8 +3438,6 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  	return count;
> >  }
> >  
> > -static struct iw_node_attr **node_attrs;
> > -
> >  static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> >  				  struct kobject *parent)
> >  {
> > @@ -3448,7 +3453,7 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
> >  	int i;
> >  
> >  	for (i = 0; i < nr_node_ids; i++)
> > -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> > +		sysfs_wi_node_release(ngrp->nattrs[i], wi_kobj);
> 
> Nit: I think it is slightly awkward to have a global struct ngrp, and then have
> its members passed individually like this. Of course there's nothing that
> we can do for sysfs_wi_release's argument, but I think we can make the
> arguments for sysfs_wi_node_release a bit cleaner. An idea would just be to
> pass an integer (nid) instead of the nattrs[i] pointer. We also don't need
> to pass wi_kobj, since it is accessible from within sysfs_wi_node_release.
> 
> Once we make both these changes, patch 3 becomes a little bit cleaner (IMHO),
> where we acquire the lock for the ngrp struct, then access its contents,
> and we don't have to pass two pointers as arguments when they are already
> accessible via the global struct anyways.
> 

I completely agree with your observations about the use of
ngrp and wi_kobj.
When I was working on this patch, I aimed to minimize changes to the
existing code. This approach led to the creation of similar code being
used differently, as you pointed out. I'll make the necessary adjustments
and update the patch to version 2.


> >  	kobject_put(wi_kobj);
> >  }
> >  
> > @@ -3486,12 +3491,10 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
> >  		return -ENOMEM;
> >  	}
> >  
> > -	node_attrs[nid] = node_attr;
> > +	ngrp->nattrs[nid] = node_attr;
> >  	return 0;
> >  }
> >  
> > -struct kobject *wi_kobj;
> > -
> >  static int wi_node_notifier(struct notifier_block *nb,
> >  			       unsigned long action, void *data)
> >  {
> > @@ -3504,10 +3507,10 @@ static int wi_node_notifier(struct notifier_block *nb,
> >  
> >  	switch(action) {
> >  	case MEM_ONLINE:
> > -		err = add_weight_node(nid, wi_kobj);
> > +		err = add_weight_node(nid, ngrp->wi_kobj);
> 
> Same idea here, we probably don't need to pass wi_kobj into add_weight_node.
> With that said, I can also see the argument for passing the struct itself,
> since it saves a line of variable declaration & definition.
> 
> [...snip...]
> 
> Please let me know what you think! I hope you have a great day, thank you
> again for this patch!
> Joshua

I will also update this issue in version 2.

> 
> Sent using hkml (https://github.com/sjp38/hackermail)
> 

Rakie
