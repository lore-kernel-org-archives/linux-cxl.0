Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C3633E9
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813777; cv=none; b=QmckWpi60Pmay9FlfkmF8GfXqrpyIbPVEv7BFIqljy7hO8W8NRQr5Afct4UJbxQ30Jr5ptmSKGAVErmc1uwc8yA2LxPYPEe/JtE+hbBR4PB8SfqHHOisApe+RUypvWuFBz4p41Xe1McrvHfR0Q+53rF0CSdFZ3Na4mbzj/9j9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813777; c=relaxed/simple;
	bh=6hMOAH+8JcUYtjOsmKu0v+ztMzYjBX4gOPVPsQsuOfg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfid0hhm7LrdeKHjnIbQYoNnM3hf2JzTu1ewIFcYFy4ycKjqiJ2WYLzr7awW61EPiNjUauHMaWiZbUedb/RmkacCVfya4WHJ0uJUmdNHXK6dtAvXAU9r7WfucQda+zcNJwc54QORVtEURaIfqzLbaFKIcAH95kky3D45no9DSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr7Z145Hcz6JB95;
	Thu,  7 Mar 2024 20:16:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D65014155A;
	Thu,  7 Mar 2024 20:16:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:16:06 +0000
Date: Thu, 7 Mar 2024 12:16:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240307121605.00002d7f@Huawei.com>
In-Reply-To: <ZejAh2O7fDBCcG-N@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-7-nifan.cxl@gmail.com>
	<20240306162816.00002e0e@Huawei.com>
	<ZejAh2O7fDBCcG-N@debian>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > > @@ -868,16 +974,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> > >                                         AddressSpace **as,
> > >                                         uint64_t *dpa_offset)
> > >  {
> > > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> > > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> > >  
> > >      if (ct3d->hostvmem) {
> > >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > > +        vmr_size = memory_region_size(vmr);
> > >      }
> > >      if (ct3d->hostpmem) {
> > >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > > +        pmr_size = memory_region_size(pmr);
> > > +    }
> > > +    if (ct3d->dc.host_dc) {
> > > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > > +        /* Do we want dc_size to be dc_mr->size or not?? */  
> > 
> > Maybe - definitely don't want to leave this comment here
> > unanswered and I think you enforce it above anyway.
> > 
> > So if we get here ct3d->dc.total_capacity == memory_region_size(ct3d->dc.host_dc);
> > As such we could just not stash total_capacity at all?  
> 
> I cannot identify a case where these two will be different. But
> total_capacity is referenced at quite some places, it may be nice to have
> it so we do not need to call the function to get the value every time?

I kind of like having it via one path so that there is no confusion
for the reader, but up to you on this one.  The function called is trivial
(other than some magic to handle very large memory regions) so
this is just a readability question, not a perf one.

Whatever, don't leave the question behind.  Find to have something
that says they are always the same size if you don't get rid
of the total_capacity representation.


Jonathan
