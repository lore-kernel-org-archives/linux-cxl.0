Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C43C17;
	Wed,  2 Apr 2025 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743557339; cv=none; b=CJ9qGXLqmmomFzgCGDxDww/HM5VtqimmXgWT2QFgmdM9ApT7PQqx/5oOYDaHCVRAYXJLaUflU9OTfSfstdVBlsHo3YtILD2A7pjmVUBpqBTCr0wnfUPWm2wfa/sUVcXoycAS7wvF6nIvJpka6iXgB4rQXBt0LyByed/74LwM2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743557339; c=relaxed/simple;
	bh=9fHDJ3Dz5NCO+7CJBRwb6ccS/OVogCHRXOkO6esEZBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfBasEnUAr8PckoOCd/b/KN6gao9fFkNhhi8ixtS2ISV3INpeWWOii/gXtLJ7aKtmOpt6nLt1X+Zg57cI3vk3x2sK7mZMBLJcOlkwDrXu8X7oW07fgFchUh4/78iHwjf7AP+qqqz0ctQyjH9VPQa+cvcTiyxp3K0lMQtuEsAgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-18-67ec92d1caba
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
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
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v4 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Wed,  2 Apr 2025 10:28:37 +0900
Message-ID: <20250402012845.1064-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z-xNajhtWgdhT2Jo@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoe6lSW/SDe4d5bSYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8ak
	K7+ZCv7IVJx5eo2lgbFHvIuRk0NCwESip72PtYuRA8zetKIYxGQTUJI4tjcGxBQRUJVou+Le
	xcjFwSzwiEnidPtSVpBOYYFwiX+fPoHZLEA10z42gNm8QFMmXt/ACjFdU6Lh0j0mEJtTwExi
	9/UPYHEhAR6JVxv2M0LUC0qcnPmEBcRmFpCXaN46mxmi9zmbxIluCwhbUuLgihssExj5ZyFp
	mYWkZQEj0ypGocy8stzEzBwTvYzKvMwKveT83E2MwFBfVvsnegfjpwvBhxgFOBiVeHgbeN+k
	C7EmlhVX5h5ilOBgVhLhjfj6Ml2INyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs
	1NSC1CKYLBMHp1QDo83EPxsWPs9RCta5mqBrs/SNUurdu6efLta49nzPcp672nEi1+patrX7
	reL6Ibnv5DwZr2I27gxb5ZU2fm1bOcT/xCeUT2HNOq5q8Wsuk7CrVbpI8YfAh/e28f5RUWuU
	ymoImaogYmAnvW+zwLWvq4yOHTx65IDqeVOpm8eEe+/5VbhYCuaZKbEUZyQaajEXFScCAGMO
	dz5xAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXCNUNNS/fipDfpBtN3mVjMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF52evmS1WLbzGZnF86zx2i8NzT7JanJ91isXi8q45bBb31vxntTh07Tmr
	xeo1GRa/t61gc+Dz2DnrLrtHd9tldo+WI29ZPRbvecnksenTJHaPEzN+s3jsfGjp8X7fVTaP
	b7c9PBa/+MDk8XmTXAB3FJdNSmpOZllqkb5dAlfGpCu/mQr+yFSceXqNpYGxR7yLkYNDQsBE
	YtOKYhCTTUBJ4tjeGBBTREBVou2KexcjFwezwCMmidPtS1m7GDk5hAXCJf59+gRmswDVTPvY
	AGbzAk2ZeH0DmC0hoCnRcOkeE4jNKWAmsfv6B7C4kACPxKsN+xkh6gUlTs58wgJiMwvISzRv
	nc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQIDfFntn4k7GL9cdj/E
	KMDBqMTDK9DzJl2INbGsuDL3EKMEB7OSCG/E15fpQrwpiZVVqUX58UWlOanFhxilOViUxHm9
	wlMThATSE0tSs1NTC1KLYLJMHJxSDYy6+xdef2gTH/x4hdOxz6c0/k9ZO/FT1iVzhQ1b8hjW
	aqXWzm73b+4+ePui++blrTffqt5MbfjAlbHLTM3wXQDXkw2rDcLKKtcYRaSGnrlx+95exjta
	ypsLJVb4avRZ2ojwxGpvTX28+kP/4qjJb81/tYW9qfl8z35rylolfstVk8uUdQ4pffRSYinO
	SDTUYi4qTgQArKrENWwCAAA=
X-CFilter-Loop: Reflected

On Tue, 1 Apr 2025 16:32:42 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Tue, Apr 01, 2025 at 06:08:59PM +0900, Rakie Kim wrote:
> >  static void sysfs_wi_release(struct kobject *wi_kobj)
> > @@ -3464,35 +3477,84 @@ static const struct kobj_type wi_ktype = {
> >  
> >  static int sysfs_wi_node_add(int nid)
> >  {
> ... snip ..
> > +	mutex_lock(&wi_group->kobj_lock);
> > +	if (wi_group->nattrs[nid]) {
> > +		mutex_unlock(&wi_group->kobj_lock);
> > +		pr_info("Node [%d] already exists\n", nid);
> > +		kfree(new_attr);
> > +		kfree(name);
> > +		return 0;
> > +	}
> >  
> > -	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
> > -		kfree(node_attr->kobj_attr.attr.name);
> > -		kfree(node_attr);
> > -		pr_err("failed to add attribute to weighted_interleave\n");
> > -		return -ENOMEM;
> > +	wi_group->nattrs[nid] = new_attr;
> > +	mutex_unlock(&wi_group->kobj_lock);
> > +
> 
> Shouldn't all of this
> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> > +	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
> > +	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
> > +	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
> > +	wi_group->nattrs[nid]->kobj_attr.show = node_show;
> > +	wi_group->nattrs[nid]->kobj_attr.store = node_store;
> > +	wi_group->nattrs[nid]->nid = nid;
> > +
> > +	ret = sysfs_create_file(&wi_group->wi_kobj,
> > +				&wi_group->nattrs[nid]->kobj_attr.attr);
> > +	if (ret) {
> > +		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> > +		kfree(wi_group->nattrs[nid]);
> > +		wi_group->nattrs[nid] = NULL;
> > +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
> >  	}
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Be happening inside the lock as well?

I agree that applying your suggestion would make the code more robust.
I will update the patch to follow your recommendation.

> 
> > +
> > +	switch(action) {
> > +	case MEM_ONLINE:
> > +		if (node_state(nid, N_MEMORY)) {
> 
> Hm, I see the issue here, ok, this node_state check isn't needed, as it
> will always be true.  So this function needs to handle duplicates still.

Yes, you're right. The `node_state(nid, N_MEMORY)` check I added here is
redundant because it will always be true in this context. I will remove it
to avoid unnecessary duplication.

>                           vvv 
> > +			err = sysfs_wi_node_add(nid);
> > +			if (err) {
> > +				pr_err("failed to add sysfs [node%d]\n", nid);
> > +				return NOTIFY_BAD;
> > +			}
> > +		}
> > +		break;
> > +	case MEM_OFFLINE:
> > +		if (!node_state(nid, N_MEMORY))
> 
> This check is good for the time being.

This check looks appropriate for now and I'll keep it as-is.

> 
> > +			sysfs_wi_node_release(nid);
> > +		break;
> > +	}
> > +
> > +notifier_end:
> > +	return NOTIFY_OK;
> >  }
> >  
> > 
> 
> But really I think we probably just want to change to build on top of this:
> https://lore.kernel.org/all/20250401092716.537512-2-osalvador@suse.de/
> 
> And use register_node_notifier with NODE_BECAME_MEMORYLESS and NODE_BECAME_MEM_AWARE
> 
> ~Gregory

Thank you for sharing the link regarding `node_notify`. I agree that the
mechanism you pointed out would be a better fit for this patch.

By using `register_node_notifier` with `NODE_BECAME_MEMORYLESS` and
`NODE_BECAME_MEM_AWARE`, we can avoid unnecessary callbacks and implement
this functionality more efficiently.

However, I think it would be better to apply the current patch first and
then update it to use `node_notify` once that support is finalized and
available upstream.

Rakie

