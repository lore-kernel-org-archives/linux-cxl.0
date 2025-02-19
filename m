Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14223C8CC;
	Wed, 19 Feb 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005418; cv=none; b=QBlg1EETuCRON/TqmnzhvLLvu9GzumseN6u9B1xQoEJqmNbYrcoMyyWFq8m6+w/jwAiV52vt+IxbvebJzYGGNlDqX2MENdZn0XoVmtdZjLqezu2Cr7INgmJzsASwUS/Wp1Gi26KWrmI2JdLnTzY643hD7ixDc/C2bXrXm6WZlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005418; c=relaxed/simple;
	bh=ocGeZZmrowWlQKBKYQZNE0gYQHxe7/vrWX72SKLXTUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RygGbI2l0o/ME8yA6fjLfQBfivN4rbV8YfQef5iBIarpvyi4T5f9luUJMxFByLikP7BCZmX5duRM0htz6JMByFfDMT4lN6mjLm3i3zj4CrFgffqXWOZYZMsFrgmyI6Nhi+v7uOk2Bm5SoJy0t52vVD/gzqwjlUzkjGTrV4K4u/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbrjxXJH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbrjxXJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740005416; x=1771541416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ocGeZZmrowWlQKBKYQZNE0gYQHxe7/vrWX72SKLXTUs=;
  b=QbrjxXJH7BWtylMlUNlRq4VCh5H0GGtMwpBgn68t6LEu7ALsE53EQuUz
   TkUdBzx+uDxMjwrENxCOPazT9bHd8/S//QEdKqnp2VqAPOB97LSAI6w8c
   IncFHwd+hcCnxHH50mmxGg1l7M44cDYdZKl/7n4fRQIz225tahYoCN1f3
   Gjxo/SLfqjKGLqntEOWFgSEweBAA5nOJK5QRUsO6NcbZYqABwnx6e2w+u
   TdCCyhZR/ij8tIwkkGrCLvaOPiAbA9gEfUK7wuFZl7kZWeU+7+nH5tXUq
   cAqsc1/8nMHUwh0VP5ZoIeUfE/4ZS/9hPEC+gVyQUwJ29NmTrbMqHyhKV
   w==;
X-CSE-ConnectionGUID: BSmZLOsfSkyNreLD+7pzVw==
X-CSE-MsgGUID: FPSsjl4vSVKWkM1y4cUdpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40905343"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40905343"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:50:16 -0800
X-CSE-ConnectionGUID: gaQxovgARX68sWzjY1PugA==
X-CSE-MsgGUID: uV0LOIK0QxGRGqFOwRzeVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118964492"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:09:29 -0800
Message-ID: <07d8bd01-ed09-4106-81fb-0e7b6793e3aa@intel.com>
Date: Wed, 19 Feb 2025 14:09:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Use guard() instead of rwsem locking
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217144828.30651-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250217144828.30651-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/25 7:48 AM, Li Ming wrote:
> Use scoped resource management to replace open-coded locking operation
> is recommended. CXL subsystem still remains some down_read()/up_read()
> and down_write()/up_write() which can be replaced by guard() simply.
> 
> This patchset includes simply using guard() instead of some
> down_read()/up_read() and down_write()/up_write() cases. Besides, it
> also includes some function code cleanup after using guard().
> 
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3 (tag: v6.14-rc2)
> 
> v2:
> - Drop some local variables. (Jonathan)
> - Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)

Hi Ming,
Can you please do me a favor and rebase this against cxl/next for a v3? I think there are some conflicts against the DPA cleanup that's not easily resolved. Thanks!

DJ

> 
> Li Ming (7):
>   cxl/core: Use guard() to replace open-coded down_read/write()
>   cxl/core: cxl_mem_sanitize() cleanup
>   cxl/memdev: cxl_memdev_ioctl() cleanup
>   cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
>   cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
>   cxl/region: Drop goto pattern in cxl_dax_region_alloc()
>   cxl/region: Drop goto pattern of construct_region()
> 
>  drivers/cxl/core/hdm.c    | 68 +++++++++++-----------------
>  drivers/cxl/core/mbox.c   | 10 ++---
>  drivers/cxl/core/memdev.c | 17 +++----
>  drivers/cxl/core/port.c   |  8 +---
>  drivers/cxl/core/region.c | 95 +++++++++++++++++++--------------------
>  5 files changed, 85 insertions(+), 113 deletions(-)
> 

