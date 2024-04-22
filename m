Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D1146A67
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786947; cv=none; b=tcngVfvWEZqYivd1dVFQUa7Dk+gTqWCBvqc4fDhn45JehDM1nXsrCWZBXSe2lntzrKu1OaUEGBpW51qrc2OjNBxIfS+s4gabbRumUv+ojkrXToc2+u4LbvguDEoVLPY0LURuId2ghWzBgFSgleDFV/TGdiyKTy27jcMUcHLfHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786947; c=relaxed/simple;
	bh=LsnRN8tYW0D23e4AXe1SjtYWH9dT2l6ybQ/SzOm/W+M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBtSmoJzGQkgYQMR8cBtL2dGc2RxRKKK8x+4CIKSw3y1kc0KeqnXuX4/dp8Il25GmyhxRzLYS/LrPyo9c842wVagfOh0Yj0N4YAs42dAJKGQBfDtl4miIso6z07bA48bbPwPMFjY0+shI1WVskSKErqGut57URIywLmWJzGnsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNNx35QlFz6K9Mp;
	Mon, 22 Apr 2024 19:55:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 75D3E140119;
	Mon, 22 Apr 2024 19:55:41 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 12:55:40 +0100
Date: Mon, 22 Apr 2024 12:55:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240422125539.00005b2b@huawei.com>
In-Reply-To: <ZiKpn7oSQWKkywwx@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-7-fan.ni@samsung.com>
	<ZiKpn7oSQWKkywwx@memverge.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 19 Apr 2024 13:27:59 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Apr 18, 2024 at 04:10:57PM -0700, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Add (file/memory backed) host backend for DCD. All the dynamic capacity
> > regions will share a single, large enough host backend. Set up address
> > space for DC regions to support read/write operations to dynamic capacity
> > for DCD.
> > 
> > With the change, the following support is added:
> > 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity. Currently, all DC regions share one
> >    host backend;
> > 2. Add namespace for dynamic capacity for read/write support;
> > 3. Create cdat entries for each dynamic capacity region.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  16 ++--
> >  hw/mem/cxl_type3.c          | 172 +++++++++++++++++++++++++++++-------
> >  include/hw/cxl/cxl_device.h |   8 ++
> >  3 files changed, 160 insertions(+), 36 deletions(-)
> >   
> 
> A couple general comments in line for discussion, but patch looks good
> otherwise. Notes are mostly on improvements we could make that should
> not block this patch.
> 
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> 
> >  
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index a1fe268560..ac87398089 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -45,7 +45,8 @@ enum {
> >  
> >  static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >                                            int dsmad_handle, uint64_t size,
> > -                                          bool is_pmem, uint64_t dpa_base)
> > +                                          bool is_pmem, bool is_dynamic,
> > +                                          uint64_t dpa_base)  
> 
> We should probably change the is_* fields into a flags field and do some
> error checking on the combination of flags.
> 
> >  {
> >      CDATDsmas *dsmas;
> >      CDATDslbis *dslbis0;
> > @@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >              .length = sizeof(*dsmas),
> >          },
> >          .DSMADhandle = dsmad_handle,
> > -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> > +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
> > +                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),  
> 
> For example, as noted elsewhere in the code, is_pmem+is_dynamic is not
> presently supported, so this shouldn't even be allowed in this function.
> 
> > +    if (dc_mr) {
> > +        int i;
> > +        uint64_t region_base = vmr_size + pmr_size;
> > +
> > +        /*
> > +         * TODO: we assume the dynamic capacity to be volatile for now.
> > +         * Non-volatile dynamic capacity will be added if needed in the
> > +         * future.
> > +         */  
> 
> Probably don't need to mark this TODO, can just leave it as a note.
> 
> Non-volatile dynamic capacity will coincide with shared memory, so it'll
> end up handled.  So this isn't really a TODO for this current work, and
> should read more like:
> 
> "Dynamic Capacity is always volatile, until shared memory is
> implemented"

I can sort of see your logic, but there is a difference between
volatile memory that is shared and persistent memory (typically whether
we need to care about deep flushes in some architectures) so I'd expected
volatile shared capacity to still be a thing, even if the host OS treats
it in most ways as persistent.

Also, persistent + DCD could be a thing without sharing sometime in the
future.

> 
> > +    } else if (ct3d->hostpmem) {
> >          range1_size_hi = ct3d->hostpmem->size >> 32;
> >          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> >                           (ct3d->hostpmem->size & 0xF0000000);
> > +    } else {
> > +        /*
> > +         * For DCD with no static memory, set memory active, memory class bits.
> > +         * No range is set.
> > +         */
> > +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3;  
> 
> We should probably add defs for these fields at some point. Can be
> tabled for later work though.
Agreed - worth tidying up but not on critical path.

> 
> > +        /*
> > +         * TODO: set dc as volatile for now, non-volatile support can be added
> > +         * in the future if needed.
> > +         */
> > +        memory_region_set_nonvolatile(dc_mr, false);  
> 
> Again can probably drop the TODO and just leave a statement.
> 
> ~Gregory

