Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9319478
	for <linux-cxl@vger.kernel.org>; Thu,  1 Aug 2024 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498803; cv=none; b=HqQnK+Zulgj7xupo1vmc6J5poBKswo9h/9TSvFu0KEWNsQmw+DSDrUB3sTFcyaenKZYfhHcrCttHaIRp6OAtTD7AWIWaEJBm1NdG90S1b5GuhyvHHHz5Z5eV80AYI6gPygWyrLK/bgExyWObxLGUZiLPya8/Z/8+saBZqvLUUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498803; c=relaxed/simple;
	bh=eGP8Fe7pUsb5B1rHjsHwO5k12jyO8yyWO1vCGmbiAR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7LQyRoXsNUV95AkQNXv42cS+rYH0HDCIxNjqMRhfAVvf968ITU4IwJ+vh62KUQ4HKV1HQBGlVEF26AbXJ/hEQ8CrlmV84h010pbgUYqMTa/9jG3hGKt4cc9cKtz4HyBd77IoO2t12iQGZTBdpkCV+PAztkW6waN8+4c4xmewa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXbCDpPqtmYngRBA--.10310S2;
	Thu, 01 Aug 2024 15:53:13 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwB3pbXnPqtmNC8KAA--.18047S2;
	Thu, 01 Aug 2024 15:53:12 +0800 (CST)
Date: Thu, 1 Aug 2024 15:53:11 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH 3/8] mm: memblock: Add a means to add to
 memblock.reserved
Message-ID: <Zqs+51lRoq+quMmk@phytium.com.cn>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-4-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529171236.32002-4-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:AQAAfwB3pbXnPqtmNC8KAA--.18047S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAEAWaqm98E1AAFsZ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF47WrWfur4xZF1fWF17ZFb_yoW8ZFy8pr
	93Ga1fCF4UGF18Xa93J3WYgry7Zwn5GF1ruFWjkFy7Aa4kXr1xJw4kG3yYgFyqqr47Kr4v
	qF1xAFWDCw4DW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, May 29, 2024 at 06:12:31PM +0100, Jonathan Cameron wrote:
> For CXL CFMWS regions, need to add memblocks that may not be
> in the system memory map so that their nid can be queried later.
> Add a function to make this easy to do.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/memblock.h |  2 ++
>  mm/memblock.c            | 11 +++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index c7d518a54359..9ac1ed8c3293 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -113,6 +113,8 @@ static inline void memblock_discard(void) {}
>  void memblock_allow_resize(void);
>  int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
>  		      enum memblock_flags flags);
> +int memblock_add_reserved_node(phys_addr_t base, phys_addr_t size, int nid,
> +		      enum memblock_flags flags);
>  int memblock_add(phys_addr_t base, phys_addr_t size);
>  int memblock_remove(phys_addr_t base, phys_addr_t size);
>  int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 5498d5ea70b4..8d02f75ec186 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -714,6 +714,17 @@ int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
>  	return memblock_add_range(&memblock.memory, base, size, nid, flags);
>  }
>  
> +int __init_memblock memblock_add_reserved_node(phys_addr_t base, phys_addr_t size,
> +				      int nid, enum memblock_flags flags)
> +{
> +	phys_addr_t end = base + size - 1;
> +
> +	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
> +		     &base, &end, nid, flags, (void *)_RET_IP_);
> +
> +	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
> +}
> +
>  /**
>   * memblock_add - add new memblock region
>   * @base: base address of the new region
> -- 
> 2.39.2
>

Tested-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

