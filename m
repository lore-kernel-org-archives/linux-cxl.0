Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2A12E1D3
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279668; cv=none; b=DM4VmJ6oEVOqwn2tvf9Ohv2Xm1nE/JvMxGTV6LOClbBH+8NiZVrAwMaZx09MCUhBTpOyoUmxkKAKVcEDk5Erx8c7PH/WXnfj9zHB5qLfAgDL3lA1rTbtUkYqQlpLyX8wkpFQj4Ik/Pm1Er6x9wm3nLli4jeRat8CLNhZqXG+Aks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279668; c=relaxed/simple;
	bh=m6Lvgv1hxXV0+3hd352lHTY/KJCt4gs+dsvna1eac9Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENK7byRNN03ml28Ewt36RyFJHJZWV9kBc9ENqfalq8IvcC/95vRYsKTu0MvEWKoWE6iiJbkPpohnFLlO5+nRPPwQJS6GVjukUTN5fGKeUkdLFeEt0s7G2mZsF5owzD78tN3Z9OECltHkN/gnX4JifGGM5VwWn5L69/EzGLx+mxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VJnD161Cvz6K8wk;
	Tue, 16 Apr 2024 22:56:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 21F3D140B55;
	Tue, 16 Apr 2024 23:00:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 16 Apr
 2024 16:00:57 +0100
Date: Tue, 16 Apr 2024 16:00:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: Gregory Price <gregory.price@memverge.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <20240416160056.0000325c@Huawei.com>
In-Reply-To: <Zh1lk8FWmf0oI7RM@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-11-nifan.cxl@gmail.com>
	<Zhm7ssKVGdGlR9Iq@memverge.com>
	<Zh1lk8FWmf0oI7RM@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Apr 2024 10:37:00 -0700
fan <nifan.cxl@gmail.com> wrote:

> On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote:
> > On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:  
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > All dpa ranges in the DC regions are invalid to access until an extent
> > > covering the range has been added. Add a bitmap for each region to
> > > record whether a DC block in the region has been backed by DC extent.
> > > For the bitmap, a bit in the bitmap represents a DC block. When a DC
> > > extent is added, all the bits of the blocks in the extent will be set,
> > > which will be cleared when the extent is released.
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> > >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
> > >  include/hw/cxl/cxl_device.h |  7 ++++
> > >  3 files changed, 89 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 7094e007b9..a0d2239176 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > >  
> > >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > >          ct3d->dc.total_extent_count += 1;
> > > +        ct3_set_region_block_backed(ct3d, dpa, len);
> > >  
> > >          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);  
> > 
> > while looking at the MHD code, we had decided to "reserve" the blocks in
> > the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
> > prevent a potential double-allocation (basically we need to sanity check
> > that two hosts aren't reserving the region PRIOR to the host being
> > notified).
> > 
> > I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
> > to prevent pending extents from being double-allocated.  Is this an
> > explicit choice?
> > 
> > I can see, for example, why you may want to allow the following in the
> > pending list: [Add X, Remove X, Add X].  I just want to know if this is
> > intentional or not. If not, you may consider adding a pending check
> > during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> > 
> > ~Gregory  
> 
> First, for remove request, pending list is not involved. See cxl r3.1,
> 9.13.3.3. Pending basically means "pending to add". 
> So for the above example, in the pending list, you can see [Add x, add x] if the
> event is not processed in time.
> Second, from the spec, I cannot find any text saying we cannot issue
> another add extent X if it is still pending.

I think there is text saying that the capacity is not released for reuse
by the device until it receives a response from the host.   Whilst
it's not explicit on offers to the same host, I'm not sure that matters.
So I don't think it is suppose to queue multiple extents...


> From the kernel side, if the first one is accepted, the second one will
> get rejected, and there is no issue there.
> If the first is reject for some reason, the second one can get
> accepted or rejected and do not need to worry about the first one.
> 
> 
> Fan
> 

