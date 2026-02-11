Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846C2BCF43
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819711; cv=none; b=o5dt6cbR6K6dkBv8FE/xTPsYdpZxFUGuSjUpK5Dbj5NKyA0qlRfiIO4tAqYeXfy6uS4zZyuIyQE99MKTkDPAplyuFvCmGmwUMosyymGekmD7DlSZ+NkmMAuNT7oAt1phhFjs8LEG9TlAvGII/tPDmxy/Gnp441pVpouMEiArbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819711; c=relaxed/simple;
	bh=cpDFlTKOf6SRUpXUrBaJswHvvyZKhTQQ6ZD4dW4iSMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha1LtHHxw9KnowkBNpuav24DbRbNC2Cv+3vIhL3Ny/FUlS6xDD8NqcrCh6EJGCt+N+i9zKD3swyBOPGoK9Q+OvwBom2JWOKsr4Sfk4LcW9P5e2wpGd2tkfZufxRfyspX5ogBzFLoOAuOFZHGHySsfK2DssrGKS05BA5MBe4rIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NYsehbo0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NYsehbo0"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-505a1789a27so11578091cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770819708; x=1771424508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEL3esNNatCbr/bkbGQf1MBlSa4lnjGnRCnp5HwHRC4=;
        b=NYsehbo0V6TU+gbZf568YGqM+PZfcqrqfkyFlAhdlGQWWxDQOCg9uQgKxS4qkK1tmP
         h5Q5dGg/7AHTjNnJ6+CqERzmL3CWcsQTJMIMlwGhU2I6SrCZq8/j5NVZXOioVoB7+ggm
         2X/Kd0iBV6pBUncqCV2YqyAxzr3QQsyypEk+Q9DBpHcUF4TuVcovNgmAiSW+ddkNX8Pr
         rPwu1UjxJFyV/ZsChrxnSinHbIp/4vTkdE0rrVYGq21VEoqFAnrF0BHNe7I4kCqJQWNo
         6/yhiC5i0knoWgrb+UBbFRx8hBMooNSXc0Nq48H6WU+hFLb4vbEXf0aCy+8NCYoS2LAw
         7+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770819708; x=1771424508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEL3esNNatCbr/bkbGQf1MBlSa4lnjGnRCnp5HwHRC4=;
        b=YPLD4XbxAXa2bwi19NdQgo0moTUUC8huZ3tv09d41yNcboimbefmCG/5GFTV9oilyN
         mtrM5LYzZAmv55rBITLSQbpkwM9QdCdnRO9oK5hscs2TOPNq/8wGKCjerr26s7uLThQe
         5xB84DBQPK9kg0H5x6sGt1LZUADTA1Pndct2+594/gT/oFJObnI9/ErOfx6gNj+IA3X2
         nhYDOzBZc5YZp/PuI+E9mTc6PfRR0/iuYEej5xo1pOr3K7dJuT7mrhfEwy+WUXQmpUwG
         8+N0H8oYaThpukLTqOH3Ri/n2p0IY8umeDrW0KIbW4buPRGFgqva849rJ9I8O5cgtdiv
         YX3A==
X-Forwarded-Encrypted: i=1; AJvYcCVBDl9ArgZzG2/5QfrTaBmuuZ7U8FSGjLrtaZ9ctkak/ArJPd1Rh/Fkpy6a1XfQJCokOrOx/hb+bzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpsCX70+mT8P4mxlUgTWGz6kv+HpMe4QNhFqIJkPB79bU3eFP
	TfiIBkrQBiPER3tGy23LB8UNVf135mOzMxxYz2pttmsLj6+W/GmjdA5vg/RyqzdySJQ=
X-Gm-Gg: AZuq6aIT8Sc5tiSWUpSs+IAXTREOUE730Sma8AiBLnYt9DeTkqSZgOe7VPD1TuwVYI9
	mLpxZi5QjsOBhAtpgydv/lVSx2jrgl3G525767MxOuDJC4mRT+yg5ZAuAnYjOs2W6ZmltdOVjvl
	Wzpb6SwdUPjAqVctqDER1gEk1wMwlzPJdEMgXY6BLapdsuDkePi/CB6XRFMV3f34s2XXhLcckEh
	GgSLoz2GpwddFTCIKQzvBhI+bS1ADmy1OBmwVUdaoaerp/sjLYcBgXaeiBl+3UKLqWAAQ0ycScB
	62JqgJoLSsYXAWitkQNBnju6cktwNKZAKTB+DsHA4bDO/KeouBkAywVk1CLULuL8kGVEfOwmfgU
	nM/eSy2QcBHJWkzR/oEsky8OaVzCTfspgUwelxXOExQdg2u4asv3HW1a/BvzMz75YmrNFX/ug7w
	ZGq+wg7+PwC1Mn8ylJvJkuZsLKf6xtLHDfYEXo1jK5vOCnEAYTNisF5OM/+3HG7KEYKoU7oD2d0
	NvJxhL0Fw==
X-Received: by 2002:a05:622a:646:b0:502:6ed5:7b04 with SMTP id d75a77b69052e-50639a199b4mr244208631cf.74.1770819707999;
        Wed, 11 Feb 2026 06:21:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d7bdesm14877131cf.6.2026.02.11.06.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:21:47 -0800 (PST)
Date: Wed, 11 Feb 2026 09:21:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>, dan.j.williams@intel.com,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
	David Hildenbrand <david@kernel.org>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYyQeSzSjBaUjMCJ@gourry-fedora-PF4VCD3F>
References: <20260211103320.2064211-1-cuichao1753@phytium.com.cn>
 <20260211103320.2064211-2-cuichao1753@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211103320.2064211-2-cuichao1753@phytium.com.cn>

On Wed, Feb 11, 2026 at 06:33:20PM +0800, Cui Chao wrote:
> In some physical memory layout designs, the address space of CFMW (CXL
> Fixed Memory Window) resides between multiple segments of system memory
> belonging to the same NUMA node. In numa_cleanup_meminfo, these multiple
> segments of system memory are merged into a larger numa_memblk. When
> identifying which NUMA node the CFMW belongs to, it may be incorrectly
> assigned to the NUMA node of the merged system memory.
> 
> When a CXL RAM region is created in userspace, the memory capacity of
> the newly created region is not added to the CFMW-dedicated NUMA node.
> Instead, it is accumulated into an existing NUMA node (e.g., NUMA0
> containing RAM). This makes it impossible to clearly distinguish
> between the two types of memory, which may affect memory-tiering
> applications.
> 
> Example memory layout:
> 
> Physical address space:
>     0x00000000 - 0x1FFFFFFF  System RAM (node0)
>     0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
>     0x40000000 - 0x5FFFFFFF  System RAM (node0)
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> After numa_cleanup_meminfo, the two node0 segments are merged into one:
>     0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.
> 
> To address this scenario, accurately identifying the correct NUMA node
> can be achieved by checking whether the region belongs to both
> numa_meminfo and numa_reserved_meminfo.
> 

Changelog comments after this are a bit much but other than that

> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

