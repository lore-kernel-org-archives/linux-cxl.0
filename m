Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596901EA7F1
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849540; cv=none; b=YwIuFHPW+xsRsyFmUg+bNPRQ7uaDzknKVSw5WDvlI3MBughvqDN3GRLpMVXBuUiZZ8Ep59Gu+lDlGy99R5jytwbKR2oaYa2on1d/6fpEAmtdIWygbxGi8iax6FUwkuv4gY3rGkR/XKT2bGyzN1Pfeif5cUTbemJlX3pc/CvWhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849540; c=relaxed/simple;
	bh=MW3qKpSsINvYibjVDY7Sa65dh/zOjKke2BG9uLwI0lg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gb0Ab2VCqvdZ4NyUS7z+T0SqbF46Ixn86ynfpORUjCW734SBYWqAnKUBcpJtZ3yO4KN47Kiq53EMZAR7Mc+BUcJ+HMqtg9lo+ZuFXIvRYNKMaeThKbQaya5Ro+OnG2CaA34TlQ1GDxSjtSvJ/4Ew7oy2U2Qfo624hqd6eYyFMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpdbT54rZz6H8G3;
	Thu,  6 Feb 2025 21:43:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E691C140520;
	Thu,  6 Feb 2025 21:45:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Feb
 2025 14:45:34 +0100
Date: Thu, 6 Feb 2025 13:45:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <krish.reddy@samsung.com>,
	<vishak.g@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <s5.kumari@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250206134533.00003e62@huawei.com>
In-Reply-To: <20250206092714.zdwd6lddw64d5j3b@test-PowerEdge-R740xd>
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
	<20250123050903.92336-3-vinayak.kh@samsung.com>
	<20250124151946.0000134f@huawei.com>
	<20250206092714.zdwd6lddw64d5j3b@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >> +static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
> >> +                          uint8_t fill_value)
> >> +{
> >> +
> >> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> >> +    uint64_t vmr_size = 0, pmr_size = 0;
> >> +    AddressSpace *as = NULL;
> >> +    MemTxAttrs mem_attrs = {0};
> >> +
> >> +    if (ct3d->hostvmem) {
> >> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> >> +        vmr_size = memory_region_size(vmr);
> >> +    }
> >> +    if (ct3d->hostpmem) {
> >> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> >> +        pmr_size = memory_region_size(pmr);
> >> +    }
> >> +
> >> +    if (dpa_addr < vmr_size) {
> >> +        as = &ct3d->hostvmem_as;
> >> +    } else if (dpa_addr < vmr_size + pmr_size) {
> >> +        as = &ct3d->hostpmem_as;
> >> +    } else {
> >> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> >> +            return -ENODEV;
> >> +        }
> >> +        as = &ct3d->dc.host_dc_as;
> >> +    }  
> >
> >You could factor out everything down to here and then use that
> >for the validate_dpa_addr() as finding an address space means
> >we also checked the address is valid. Otherwise it does not match.  
> 
> Didnt get what you meant, validate_dpa_addr is meant for 
> checking valid dpa address and sanitize_range is 
> get the address space handle to do actual sanitize
> of dpa address, so two are different purposes, 

Different purposes but the actual checks mostly
overlap.  If we can find the address space then there
are only a few extra checks on alignment with granual
size etc needed.  I'd just like to avoid that duplication
so factor out the shared code to a helper called in both
functions.


> 
> >  
> >> +
> >> +    return  address_space_set(as, dpa_addr,  


