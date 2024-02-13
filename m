Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E39225D2
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816719; cv=none; b=fwatX0Rvttt4Wihy8EgTv1itwyCNZzKUT6pXsLrxWvLO4iQkvRt7VkpX1R6DYFXGTjsNQl+aWBmW1C6Sfoy1FrrAOWLuP6z9Gj+Go/vFz+SfKeSMZ+wJNdnvnBU0KDFnUBfZg1DZh4JNf9F3m8FB3lfqsY+YMu43Y21DIAzQz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816719; c=relaxed/simple;
	bh=VkFFewy5/FvdeMZkM5YfhsBOBTOZwYA4mq3NdZARql4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGDHnj8LHKVUPVHv91+C4BNMODo5SR12Gi2S5LL+kWlOALSRB6+k24LdjTXfqu6bdBglrzXKSrH8X77dsw8+k8GHPRjI2iybzza+FeYe0n7j0xTsRb8V0EZxsKkRUaNCmpN+Eh7M2uyZB/sD7pggReODcvxicJdxH4sseip22Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYwww2TkPz6F97k;
	Tue, 13 Feb 2024 17:28:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BEA021413D4;
	Tue, 13 Feb 2024 17:31:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 09:31:53 +0000
Date: Tue, 13 Feb 2024 09:31:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Message-ID: <20240213093152.000017d5@Huawei.com>
In-Reply-To: <ZcZ3LU9bM20Lomce@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-10-nifan.cxl@gmail.com>
	<20240124165815.00007e46@Huawei.com>
	<ZcZ3LU9bM20Lomce@debian>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index 43cea3d818..4ec65a751a 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c  
> >   
> > > +/*
> > > + * Check whether a DPA range [dpa, dpa + len) has been backed with DC extents.
> > > + * Used when validating read/write to dc regions
> > > + */
> > > +bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > > +                                  uint64_t len)
> > > +{
> > > +    CXLDCDRegion *region;
> > > +    uint64_t nbits;
> > > +    long nr;
> > > +
> > > +    region = cxl_find_dc_region(ct3d, dpa, len);
> > > +    if (!region) {
> > > +        return false;
> > > +    }
> > > +
> > > +    nr = (dpa - region->base) / region->block_size;
> > > +    nbits = DIV_ROUND_UP(len, region->block_size);
> > > +    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;  
> > I'm not sure how this works... Is it taking a size or an end point?
> > 
> > Linux equivalent takes size, so I'd expect
> > 
> >     return find_next_zero_bit(region->blk_bitmap, nbits, nr);
> > Perhaps a comment would avoid any future confusion on this.
> >   
> 
> My understanding is that the size is the size of the bitmap, which is
> also end of the range to check, not the length of the range to check.
> 
> The function find_next_zero_bit(bitmap, size, offset) checks the bitmap range
> [offset, size) to find the next unset bit, for the above test, we want to
> check range [nr, nr + nbits), so the arguments passed to the function
> should be right.
> 
> In the definition of the function, whenever offset >= size, it returns size
> because size is the end of the range, So if we pass nbits and nr
> to the function and nr >= nbits, which can be common, meaning (dpa-region_base)
> \> len, the function will always return true; that is not what we want.  
> 
> To sum up, the second parameter of the function should always be the end
> of the range to check, for our case, it is nr + nbits.
Ok. Thanks for the explanation. That sounds good to me

Jonathan

> 
> Fan
