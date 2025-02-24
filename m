Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D4F1D8E1A;
	Mon, 24 Feb 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421927; cv=none; b=fRMt7NV+iSiZITUI4ykhJmxrGWSnizikAgD9NUPfSsHsXkIfIvTdVCKAATxymofOKw+/+HhjvIvQ6//J4FHF80+v9Ave+ZS2Pu0MgXmnztpCAydHzs9f/X964MFFViY6ZK0fYkFQJqucsOH9XK8B0Cc/2yUzVa/WUYx38WwxlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421927; c=relaxed/simple;
	bh=PvY0vNGIV2nrW6cWOBfrLF3KmywdDgPWMWumXt7kQCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0VAjAe13VCq+E7+eDo0YxMe8dUn8tdi91LiQxXhwsmHx9G5ZBQ/Jq8rPXWmk3xij0DHZXu3xVkAkLrkJPLiAn9o37I64+axfv9/D/sRhzjGA+5lgVKat2YW8WfLjSMWn5mrz5mOogrQ/59i9TPm+33D6wx7ltEr/+pnRuCC7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVOfNOqi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVOfNOqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740421926; x=1771957926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PvY0vNGIV2nrW6cWOBfrLF3KmywdDgPWMWumXt7kQCQ=;
  b=ZVOfNOqi3TC+7tX0gybAfuMXefaKNiukXogQLaSJFZY0PgC6qDDDlGXY
   4zuE6sxvwREjtCO9OThM89U4feFCA9SQ8y6+6mvO0juD05998YKUp5I3P
   0KsAXjHovc+GyCwErdWn1Gv2MlJyys9rcKijhmOFlfnI/I5RwVdk5cACK
   JlJp8aY3gw4QjMqyOz5nw77aiWLwSgdxpBPisyuVXWubXJwlqbtGvaKTf
   4/aDoE/rDCvCjvYZ+nihHp9T2xtEkzF8oQSgePSVvXgAbG3BLZ/OXHUN3
   t0NvN03UyWaNsNMbCUUJ/L2VB58VRG2+igqOiGSjcm7QV+cKm9pvUlJQT
   Q==;
X-CSE-ConnectionGUID: cEMVdVoySvO2EN9X2s4BQA==
X-CSE-MsgGUID: MxB+H7GQRVCrDtQlWHVicg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51409366"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="51409366"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:32:05 -0800
X-CSE-ConnectionGUID: o+AFoa3CRp6RA4OjFkFi/g==
X-CSE-MsgGUID: CY4OW9ShQoizvgSgFWyM9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121105550"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.111.71]) ([10.125.111.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 10:32:04 -0800
Message-ID: <5b866a4a-2cd0-4b17-bf0e-7eeb2a778f7a@intel.com>
Date: Mon, 24 Feb 2025 11:32:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/Documentation: Remove 'mixed' from sysfs mode doc
To: Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/25 11:29 AM, Ira Weiny wrote:
> Commit 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> removed the mixed mode.
> 
> Remove it from the sysfs documentation.
> 
> Fixes: 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3f5627a1210a16aca7c18d17131a56491048a0c2..3ba551ed10e29f33b9eb873bab9b542c8afb66f0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -321,14 +321,13 @@ KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> -		translates from a host physical address range, to a device local
> -		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		translates from a host physical address range, to a device
> +		local address range. Device-local address ranges are further
> +		split into a 'ram' (volatile memory) range and 'pmem'
> +		(persistent memory) range. The 'mode' attribute emits one of
> +		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
> +		not actively decoding, or no DPA allocation policy has been
> +		set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
>  		state, with either 'ram' or 'pmem' to set the boundaries for the
> 
> ---
> base-commit: 8760c1c0bf7eee63a56b5f9edb42d93737a6a378
> change-id: 20250224-remove-mixed-sysfs-e3baa7616bcc
> 
> Best regards,

