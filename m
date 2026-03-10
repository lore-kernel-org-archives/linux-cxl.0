Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351131715E;
	Tue, 10 Mar 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165198; cv=none; b=TBYZBXiIYJq3QjfSsH7gTQy08jCpMOQYCIhgMQ0PmRPo5lvzOQl7RBE+v9B2Y2r2Prq9d83EIYrHVlofCwGD3ny3hWcGbyXzHNeT1JUc//Dx9hN3OgwBPW0flxhr0kugEwlIzAEVz0x4JplXv2luCjZWzhEtT944omLU8bNm9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165198; c=relaxed/simple;
	bh=bwjFivXvDMR7ae/O+uHjEp3C9ypISb9Y3UZxG9mQKPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MX8XiI+jINHpLS7SOultdPm8/XuJS3Q4x9wyM3CX/Br74+hU1l+Ri5LxrnTGXG7cbEmpglZN414kiCHSPhoJ4wNrIl/vhNeBe16vWFtI3mcaVSk5xbplJZ/Z4XAjMLtPTWvQNUt3LAiG6eqSMUizUPfBtPMm6fOv9Lf/IZx2Jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHN/N/u0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHN/N/u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773165197; x=1804701197;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bwjFivXvDMR7ae/O+uHjEp3C9ypISb9Y3UZxG9mQKPI=;
  b=fHN/N/u0hpQfdMBrTHqMKW75dMZvEd9pkyqSPGrd+qkPL+3kYvlW8yPk
   iRKRKpNE1SWhtQDHTpkLZPVjzIHt6zfZxgoLRDlXT8hRAbLdCvljIvUX8
   ZM4ZSWqes3sOO0vfiPq3qIHzjVphuxi+8HVkRHbAqkCo9LTTJ9IhhWDxv
   s9qFKmxFD3Puuq5PU811Ju72oEtRUbKlXFQHOGR6NE8DbunFHz+3/8rvJ
   peehpU2ZtJX6aJFRovJo8GRtdg/iBZUqnleDGXgPkSwWkq95cIFRYjyN8
   9UoMhMh6AG0fTv6DeaHMIW6HXWqcGF0vbZDWujvS1B6nqB5mbVOdny/fW
   A==;
X-CSE-ConnectionGUID: AAeLKpf1RAa15DpFiLR1aA==
X-CSE-MsgGUID: 0aHY/MW6RWSrFFNQ5Ac7KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78079707"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="78079707"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 10:53:14 -0700
X-CSE-ConnectionGUID: J8VruwUETZKm27QO2xN5rw==
X-CSE-MsgGUID: CY9+hRJZTaSOxZmjDikjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="215548388"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 10:53:12 -0700
Message-ID: <3b7f16d5-be31-42f9-9671-24532530273a@intel.com>
Date: Tue, 10 Mar 2026 10:53:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/26 8:57 AM, Li Ming wrote:
> CXL memdev poison injection/clearing debugfs interfaces are visible
> before the CXL memdev endpoint initialization, If user accesses the
> interfaces before cxlmd->endpoint updated, it is possible to access an
> invalid endpoint in cxl_dpa_to_region().
> 
> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
> interfaces until CXL memdev probing completed.
> 
> The following patch will check the given endpoint validity in
> cxl_dpa_to_region().
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 273c22118d3d..8ebaf9e96035 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -295,6 +295,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> +	device_lock_assert(&cxlmd->dev);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	lockdep_assert_held(&cxl_rwsem.region);
>  
> @@ -331,6 +332,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	int rc;
>  
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -355,6 +360,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> +	device_lock_assert(&cxlmd->dev);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	lockdep_assert_held(&cxl_rwsem.region);
>  
> @@ -400,6 +406,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	int rc;
>  
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> 

