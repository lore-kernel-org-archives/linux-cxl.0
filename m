Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C10349CC2;
	Thu, 21 May 2026 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382476; cv=none; b=SkT5AXyfv/df7ChG6XKBjXXfyNEJoDO7jNjlGtBAGPCX6Td+OhF1ZOvb1VFWBSTpIBSw6Irea1hQfQsUQttfg4Ad5Kexgwp1amBLFLpA2nHdbw/64DiDThJBz0CU4+2R2lk1doy2iAiv3C5xBsYGkoj7fRRgJWHp344dMq/89wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382476; c=relaxed/simple;
	bh=rU5HRTEtU+epBe9uBR8bSO+Vc15Z6EEtc5I9HDsFppU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SX6GDb4Nx5vPX1uhS/sgUuPSAaf4yaWdbQ4Pdduc4qOo46qFLrdICucVcFtrOvEit7h96ASM6V0KIB5SiVsIzN8L7UdB/wyBIPun0WeVeOyGIDd2uz0+UFWxcfQB8+UG5qa4XXbstZfHZ8XBOpErFR2HavvO81E0a+UC9kMkCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iblgfFoP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iblgfFoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779382476; x=1810918476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rU5HRTEtU+epBe9uBR8bSO+Vc15Z6EEtc5I9HDsFppU=;
  b=iblgfFoPif0HtHHJM4j3cgZI8azQonZQTpmg7/LVQUJovEuC6H6eGi4Q
   WLDX+JWN/oEG9/7Wp1KzI6rG07Y9e/wGA0OOpabZqAj9tJymvMAQZoXX7
   NfKUlGxIhAKPfNZwsJ96NbBDHfc7fE4GDvaZRbDnPE+CyzRxeXArv5Qx9
   l9Byhohhi1ipcxPf+v9FetzUkbCvK5CoFjQ9JBttQEwAQmjVgVnn6ca+o
   x35kJshQ1S6ewMLB7ydoYkqgNNBVTXiC8pftT6+3Y8WMFkmgu7ew8Zv+1
   7Fz8G7EQokz8WrB+rkVhrXt1NJnw0nBD/hSPZHlbva2C/ksoXqaGAos9x
   A==;
X-CSE-ConnectionGUID: zuv287a/RoWuHHq8vV00ag==
X-CSE-MsgGUID: jw51D1iQR9aNBDcOYzEUfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91777330"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="91777330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:54:35 -0700
X-CSE-ConnectionGUID: Dq3YkcyhQdCSF/IDeYXp7g==
X-CSE-MsgGUID: 5aRwHrxKQjC/KahxVCctJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="240811622"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.110.16]) ([10.125.110.16])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:54:34 -0700
Message-ID: <99e5dfb4-9f3d-46aa-b028-a90a500a7d6f@intel.com>
Date: Thu, 21 May 2026 09:54:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Validate partition index before array
 access
To: KobaK <kobak@nvidia.com>, Dan Williams <djbw@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <20260414024527.3399590-1-kobak@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260414024527.3399590-1-kobak@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/13/26 7:45 PM, KobaK wrote:
> From: Koba Ko <kobak@nvidia.com>
> 
> construct_region() reads cxled->part and uses it to index
> cxlds->part[] without checking for a negative value. If the
> partition was never resolved, part remains at its initial value
> of -1, causing an out-of-bounds array access.
> 
> Add a guard to return -EBUSY when part is negative.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Signed-off-by: Koba Ko <kobak@nvidia.com>

Applied to cxl/next
abb3c0de1190

> ---
>  drivers/cxl/core/region.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index edc267c6cf77..de749b54fd62 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3712,6 +3712,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
> +	if (part < 0)
> +		return ERR_PTR(-EBUSY);
> +
>  	do {
>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id),

