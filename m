Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0EF78F4A;
	Thu, 13 Mar 2025 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847602; cv=none; b=nGrZUckqGrdDRLu4qeGsVx5uOmQdyuikO7elRxRKkGwn7YvndDB7bpiiKAt6zAMivO5hQD1Vw3xoadimcBgJzu1TTo/RsT6GUsQRJj46tGJTbEiCsvq4FmLxVDpw3koTaHxfHRDTFD3udJkmUYu88zsAsCHM7dx96IRB7b0Hlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847602; c=relaxed/simple;
	bh=efFAatAqfWxQxOdra+Laiqaxb24NnK9PV+fwmqpE1y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4VqREZ4NwSFeiN9yH3cifZ2WsAR8RnWMbsth2kBV53IflCABuHLnaac4NZJGV4DE4CEHAgtDu4GCnqAOH5lRr/WPCsVysLqDSo0wdg0xUIZzYz4eeu8JmWLHjeSoH91x36c/j//6Er3HIwOt6nMsi9DgHBCGF+P86AWNlD9C9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fc-67d27c215fcf
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
Date: Thu, 13 Mar 2025 15:31:38 +0900
Message-ID: <20250313063247.681-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9Gs8i1FhJJ0eaiA@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoa5izaV0g0XrLS3mrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mn7/Pcde8ESlYuG/dawNjHtkuhg5OSQE
	TCS+fJ/JBmMv2raZvYuRg4NNQEni2N4YEFNEQFWi7Yp7FyMXB7PAeiaJ15tmgZULC4RIrLu1
	GKycBaim8SLYRF4BY4n+n2sZISZqSjRcuscEYnMKmElc+/WaBcQWEuCReLVhPyNEvaDEyZlP
	wOLMAvISzVtnM4PskhA4wSYxc+oTJohBkhIHV9xgmcDIPwtJzywkPQsYmVYxCmXmleUmZuaY
	6GVU5mVW6CXn525iBAbxsto/0TsYP10IPsQowMGoxMObMPliuhBrYllxZe4hRgkOZiUR3tW2
	F9KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08REkhPLEnNTk0tSC2CyTJxcEo1MBqfUzul
	Ly1ouuPoxFM7/mwQXrdw1p5slTmFN7MbXA8+ueUewPnZ9uHUh4m8tdMz7Ot2/bU8e9q2fPc8
	HafbOj+3OnxvbFvsNSnaVcIwpM+ZSTj7jdO5pm+uF1VDU64yPBGMkFiwQqg0wd+zY4575e/D
	Xz9sYTp/9e+bL7JfQ/LVU1PYQuakrVRiKc5INNRiLipOBADkTu32XgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXCNUNNS1ex5lK6wYHjhhZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDJ+/z3HXvBEpWLhv3WsDYx7ZLoYOTkkBEwkFm3bzN7FyMHBJqAkcWxvDIgpIqAq
	0XbFvYuRi4NZYD2TxOtNs9hAyoUFQiTW3VoMVs4CVNN4EWwKr4CxRP/PtYwQEzUlGi7dYwKx
	OQXMJK79es0CYgsJ8Ei82rCfEaJeUOLkzCdgcWYBeYnmrbOZJzDyzEKSmoUktYCRaRWjSGZe
	WW5iZo6pXnF2RmVeZoVecn7uJkZg4C6r/TNxB+OXy+6HGAU4GJV4eBMmX0wXYk0sK67MPcQo
	wcGsJMK72vZCuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwen
	VAPj+gq5wCk+R+z0RT6mVTzMkP5VtWpfXsnmG49+Kljeu7D5d5iKrpcd4yZ7u58SB3vfdsju
	esR1IETi68UVildUVY2e+pZmfWj+uegZI4/9ko6ubS/LFhXv/VGyVtOvvz7m372NL1xU3+rl
	3A6ZlauTb9xw3cJw2baHOz7tT/3+rHuJ7nXrFNNeJZbijERDLeai4kQA/UUOuFgCAAA=
X-CFilter-Loop: Reflected

On Wed, 12 Mar 2025 11:49:06 -0400 Gregory Price <gourry@gourry.net> wrote:

Hi Gregory
Thank you for your response regarding this patch.

> On Wed, Mar 12, 2025 at 04:56:24PM +0900, Rakie Kim wrote:
> > Improper cleanup of sysfs attributes caused kobject and memory leaks when
> > initialization failed or nodes were removed.
> > 
> > This patch ensures proper deallocation of kobjects and memory, preventing
> > resource leaks and improving stability.
> >
> 
> This patch does multiple things, please split these changes into
> multiple patches.

This patch should remain as a single patch since all changes address
kobject-related memory issues in mempolicy_sysfs_init(). If you still
believe it should be split, I would appreciate your suggestion on
which parts should be separated.

> 
> > Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > ---
> >  mm/mempolicy.c | 29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index bbaadbeeb291..1691748badb2 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3541,39 +3541,40 @@ static int __init mempolicy_sysfs_init(void)
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
> > +		goto node_out;
> >  	}
> 
> It's not clear to me why you re-ordered these allocations, it seems
> superfluous.
> 
> >  
> >  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> >  				   "mempolicy");
> > -	if (err)
> > -		goto node_out;
> > +	if (err) {
> > +		kobject_put(mempolicy_kobj);
> 
> Is this correct? If kobject_init_and_add fails, from other examples we
> need only free the mempolicy_kobj - because it failed to initialize and
> therefore should not have any references.  I think this causes an
> underflow.

Regarding the reordering of mempolicy_kobj allocation:
1) In kobject_init_and_add(), kobject_init() is always called, which
   increments the kobject's refcount. Therefore, even if
   kobject_init_and_add() fails, kobject_put() must be called to ensure
   proper memory cleanup.

   int kobject_init_and_add(struct kobject *kobj, const struct kobj_type *ktype,
                           struct kobject *parent, const char *fmt, ...)
   {
   ...
       kobject_init(kobj, ktype);
       retval = kobject_add_varg(kobj, parent, fmt, args);
   ...
       return retval;
   }

2) The release function for mempolicy_kobj is responsible for freeing
   associated memory:

   static void mempolicy_kobj_release(struct kobject *kobj)
   {
       ...
       kfree(ngrp->nattrs);
       kfree(ngrp);
       kfree(kobj);
   }

   Once mempolicy_kobj is passed to kobject_init_and_add(), the memory
   for ngrp->attrs and ngrp should be released via mempolicy_kobj_release().
   The allocation order was changed to ensure that kobject_put() properly
   invokes mempolicy_kobj_release() when required.

> 
> > +		goto err_out;
> > +	}
> >  
> >  	err = add_weighted_interleave_group(mempolicy_kobj);
> >  	if (err) {
> > -		pr_err("mempolicy sysfs structure failed to initialize\n");
> >  		kobject_put(mempolicy_kobj);
> > -		return err;
> > +		goto err_out;
> >  	}
> >  
> > -	return err;
> > +	return 0;
> > +
> 
> Please keep functional changes and refactors separate.  There's more
> churn in this patch than is needed to accomplish what the changelog
> states is the intent.

As mentioned earlier, I believe this patch does not need to be split.
However, if you have further concerns or suggestions, I would
appreciate your input.

> 
> >  node_out:
> >  	kfree(node_attrs);
> > -mempol_out:
> > -	kfree(mempolicy_kobj);
> >  err_out:
> > -	pr_err("failed to add mempolicy kobject to the system\n");
> > +	pr_err("mempolicy sysfs structure failed to initialize\n");
> >  	return err;
> > +
> >  }
> >  
> >  late_initcall(mempolicy_sysfs_init);
> > 
> > base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
> > -- 
> > 2.34.1
> > 
