Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAD1DA23;
	Fri, 13 Mar 2026 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440633; cv=none; b=nLYlUwrh/JxFGyT6qeMBRK9UEIMs/g+KA572iKRbOWvlEoxCDD/igT9CePxpywjORWf81UUmW0HUEKKEqMd81zM/TJuUnLPFHOjdGvIZabLPsTGuKw8M+LBIaZIAtzGrRPBII4LtO+BYk47bgUkSylqmz0WQ3gXQeMx4D5FeSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440633; c=relaxed/simple;
	bh=YO191PXoLEWaOaVYsZLm79pR6Kcrl0ST6J08y2vgl9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiITWGKaaLkZYr3aXYYqFFHpRDFy2yfa5YWeUz0hJYi6FNyLp/yxJk6XxSXG/CKfYKAF+Hklj72pJeIkcLvgq4P3OxY55gmXcdLqIuTImMVw7zeEq4wQxJOR6hMTCq0dJ3iVkFyNnkDp8cKFA67qa/In5Wn57iTdGplG3FzXc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4ORlF3W; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4ORlF3W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773440632; x=1804976632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YO191PXoLEWaOaVYsZLm79pR6Kcrl0ST6J08y2vgl9Y=;
  b=e4ORlF3WTfaECFr0Yf6bbapgW5ccNcYfVcvYCKg/WRBqkizCDIS0tUn2
   6Kj+kUKPfbqByy9vsdw7X5Q37fgo/aJOIs7gdO+Yn6/FWYJrVYjUAbKii
   7RnrOr/N6gTpahNedNlIpjEfa7dWvRtbSfNIdzSJzWdOWKL9L5e5Rdch/
   p+gdW6SuAQDA06hXK0MWjhMNbPAlJLXJrZW8NO/fvpXLy8LUHHmgM1FWq
   FyTw5UmLak8yRoUZangg0jqPqyFACdH5qc6L6VsiXctyC/gBRARSDQEuZ
   Q5yGau8KYP5LwonuDss9Ec+NQEUxB0sxK5R1J1WtrW2U/ymRRe+yJ8mem
   A==;
X-CSE-ConnectionGUID: HI8fkxXKRcKWBx0PLsMVIQ==
X-CSE-MsgGUID: 8lvmCHu1T16NzeHAGUohxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="73570549"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="73570549"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:23:51 -0700
X-CSE-ConnectionGUID: 6yTda9FhQCOAIqZo9qRY4g==
X-CSE-MsgGUID: FnsrSL8ZQNeINhurkYuZ/A==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:23:49 -0700
Message-ID: <ca0b9c17-8b3b-4460-be5c-26139341ec6e@intel.com>
Date: Fri, 13 Mar 2026 15:23:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] selftests/vfio: Fix VLA initialisation in
 vfio_pci_irq_set()
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-21-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-21-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> C does not permit initialiser expressions on variable-length arrays.
> vfio_pci_irq_set() declared
> 
> u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> 
> where count is a function parameter, making buf a VLA.  GCC rejects
> this with "variable-sized object may not be initialized".
> 
> Replace the initialiser with an explicit memset() immediately after
> the declaration.
> 
> Fixes: 19faf6fd969c2 ("vfio: selftests: Add a helper library for VFIO selftests")

Should this fix be split out from the series and sent ahead? Does not seem to be tied to the current implementation. 

DJ

> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index fac4c0ecadef..3258e814f450 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -26,8 +26,10 @@
>  static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  			     u32 index, u32 vector, u32 count, int *fds)
>  {
> -	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> +	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
>  	struct vfio_irq_set *irq = (void *)&buf;
> +
> +	memset(buf, 0, sizeof(buf));
>  	int *irq_fds = (void *)&irq->data;
>  
>  	irq->argsz = sizeof(buf);

