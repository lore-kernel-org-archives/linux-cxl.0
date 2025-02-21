Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB421F1506;
	Fri, 21 Feb 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155474; cv=none; b=MXxVjcFixdinYm8E+hUgcY0x9LAVv/5aTViHK4K2rJkGHIypE7QumnovWoOPfwK47r40LlYhB62OfQWXYSxiVdgEoFaakrUqfhU2dlzzC5sPAf2yFX3N+zZo+WUbrSqT1RrLeYlE6hmPY77K9qjIAjS5zH/WlCSEZYKIOwnnXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155474; c=relaxed/simple;
	bh=irguvaW4ZDyHOQ4VjIoMpbSmgH5YwZYJd0OZO144sjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzRxFashBuUFM82MBOec/2+4HSj9Q64TLgl7g6TA5LCesi2iDqji7kDnDIJvxHaLTbwjgiPGpI+xNcyIpjFLqd/hbvN1TZV8rtDlyjukz2+9UyksVrIf2jPfTdkSXDy9DPzbchLcjLrhxc64M4DWlm190YhKDQGZETcbjNXoP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9c6Vp8q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9c6Vp8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740155473; x=1771691473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=irguvaW4ZDyHOQ4VjIoMpbSmgH5YwZYJd0OZO144sjw=;
  b=E9c6Vp8qheyKGjRMRgRyFUW7FvLRN5YuCE/RYPbTkiXm03EOPjTkFjh9
   u+CaYRrrJII/Hl91ET7i68N5i9Zn4FKLpmLb0bhlt6v5RE32iYsqVj4pC
   HV5TpneVx09VJpHqw2aNsybNX133uJBIQylrHMvJUfsnDeFrQYrl1yKX4
   ryj0aj3ZsGSqK9Pd3JD0i4J1x8NjGIXqHk6/KOxoWjK8btGqrKrvgnnyi
   0hAIlxeBImwHIjulO2uBD/6w7h5SsDDqH3+9x9aaZEDOhHu6GRfPWxTRx
   iD7duMX4pXx9cZ/DHGYv8uhywvMsy7jMjj83rPBMyFwJ+OHj/+BsLp4pM
   g==;
X-CSE-ConnectionGUID: G3o3OMIERgyse0bM+evzjg==
X-CSE-MsgGUID: UANdtXwZSXKWjSvKeW0/xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44625958"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="44625958"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:31:13 -0800
X-CSE-ConnectionGUID: 2Z/vM83URUqksJET5tHwyQ==
X-CSE-MsgGUID: qNK1JJjtRf+ulNr65R6iqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120513464"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:31:11 -0800
Message-ID: <17a8be14-988c-4199-8304-827f679cceb2@intel.com>
Date: Fri, 21 Feb 2025 09:31:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Use guard() instead of rwsem locking
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250221012453.126366-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250221012453.126366-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/25 6:24 PM, Li Ming wrote:
> Use scoped resource management to replace open-coded locking operation
> is recommended. CXL subsystem still remains some down_read()/up_read()
> and down_write()/up_write() which can be replaced by guard() simply.
> 
> This patchset includes simply using guard() instead of some
> down_read()/up_read() and down_write()/up_write() cases. Besides, it
> also includes some function code cleanup after using guard().
> 
> base-commit: d5d2106e2118c4e09fef131d9889f79559b95bfc cxl/next

thanks for the rebase. applied to cxl/next

> 
> v3:
> - Drop the renaming of __construct_region() to construct_auto_region(). (Dan)
> - Rebase to the top of cxl/next. (Dave)
> v2:
> - Drop some local variables. (Jonathan)
> - Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
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
>  drivers/cxl/core/hdm.c    |  69 ++++++++++---------------
>  drivers/cxl/core/mbox.c   |  10 ++--
>  drivers/cxl/core/memdev.c |  17 +++---
>  drivers/cxl/core/port.c   |   8 +--
>  drivers/cxl/core/region.c | 105 +++++++++++++++++++-------------------
>  5 files changed, 91 insertions(+), 118 deletions(-)
> 

