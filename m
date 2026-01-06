Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631B36B048;
	Tue,  6 Jan 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722120; cv=none; b=GBqCUZedURlExM3gMcZ8+PpZ9v8LO+qJfS28hMkSEbdqdQ/osUymCMYqRGKTLN3p4XqN8jWVT7ryNkcQV5G2Aoufq1gU5+EDQeUhVUoGiPP1GPn9FJpF1bPYM/YrOagAV9eg/KELxVI4XqKVNV5GsgH5EpFwIL9JINAc8MJhI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722120; c=relaxed/simple;
	bh=y4Jd2BJKKXFVHARl6UUkt+RWFWcl2/xFoiSKaW5q5wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ/+aBdPeCGYzvWrSW/JPKOLyDeHodTlLwJI8Ads/v/w6VNu8KxWV/fhAGkcYnW3kRIDtckxdpXqxrFDsavmhw0Y+pcbz23KzOjRyHiJmz2ahSVrp32jBd/N1MTg6s+dIW09FqD0nODrwhsPQaF+86OHsjz3FpnfNLyFSjwTIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkNi2iWi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkNi2iWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767722119; x=1799258119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y4Jd2BJKKXFVHARl6UUkt+RWFWcl2/xFoiSKaW5q5wc=;
  b=lkNi2iWiNBcnJPqmKLZ7+eQVKRoN6MvzvanpaIOfHzANxJdF4iEQZ/bJ
   d1X7mkrROP4Dq4MRD/ANK3F5UcLiPFtOgj9VPuhofZQyaseiPr6iOoY9L
   bTH6qmVfxBNIVtGTQ6D6sbYm9eCOyj3aRAiM/CjsXskrddKi5huEjTrBf
   PA/YjQmanYKOfwPGRZ1aQJQb70RXFSYO2icJ6bl5T/KLrb4uXhAuFSLw9
   XPPAP0HEzH0PwKQDRMKGRiCzaYlE32lyQGPWEzhyH/uVp/7IhmIyi50Jw
   UyUAuWjLYfZ5VCKxpJxnsar8J6cvfCRvIUaLMekgMTkUfac0XAA4uSxrp
   Q==;
X-CSE-ConnectionGUID: M2bHSLp9QqCSkujOkjUHVA==
X-CSE-MsgGUID: wBE/rw9tQ5mAXhxeBnZ9bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="68104048"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="68104048"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 09:55:18 -0800
X-CSE-ConnectionGUID: Ru5HFSM0QvSS5b4qFNIm2w==
X-CSE-MsgGUID: 4Muz8/RaSjmgOeng1bzDJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="203166092"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 09:55:15 -0800
Message-ID: <56cc995d-9b5a-41f5-a719-92835f376d13@intel.com>
Date: Tue, 6 Jan 2026 10:55:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Remove outdated FIXME comment and BUILD_BUG_ON
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, lison.schofield@intel.com,
 vishal.l.verma@intel.com
Cc: ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260105203833.1604585-1-samasth.norway.ananda@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260105203833.1604585-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/26 1:38 PM, Samasth Norway Ananda wrote:
> Remove the outdated FIXME comment about switching to struct_group() and
> the associated BUILD_BUG_ON check. This work was already completed in
> commit 301e68dd9b9b ("cxl/core: Replace unions with struct_group()")
> which converted struct cxl_regs to use struct_group_tagged().
> 
> The BUILD_BUG_ON was checking that anonymous union layout was preserved,
> but since struct_group() now handles this correctly, the compile-time
> check is no longer necessary.
> 
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/pci.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0be4e508affe..3b2293dffb3f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -912,13 +912,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	unsigned int i;
>  	bool irq_avail;
>  
> -	/*
> -	 * Double check the anonymous union trickery in struct cxl_regs
> -	 * FIXME switch to struct_group()
> -	 */
> -	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
> -		     offsetof(struct cxl_regs, device_regs.memdev));
> -
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
>  		return rc;

