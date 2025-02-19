Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF51FECAE
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984758; cv=none; b=DDAQTlQdhQIaVqBPRvC9K1oKUZ2/iKHChddHwVqpgJy+aZ6MgUY6yQKUQbjn03X+QtGOtyryhklkXAguLlYG3Xv+aMxt1Uo5zSfSrB+QjO4UOOuAjY9z9Nl8yHsLS/0Yh35Ef5p4XYdqeTqLKuByCbeIn9rLbj19YhlDPqDr1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984758; c=relaxed/simple;
	bh=d1f77bYgroldxR5h5yYq3k7rEKDl36tby1NxwnvSOwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGwcl+qFmHHudm3jqmFbakIGUfGWySgqdNnltJBz934OkDTblfGLKv61X+JbP7ihnvixTgFPhtmZOF5dKT0rHr8NEZYp5QrODhewkqOuzgQ4IXz6aSJwgSKv0E9oXvyDUrFx8MU1Aq/ST8KMXG7DETDtb7g4mDxLkGr3TDFMfbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjWpLH6G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjWpLH6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739984755; x=1771520755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d1f77bYgroldxR5h5yYq3k7rEKDl36tby1NxwnvSOwU=;
  b=AjWpLH6GFzG09xIdV8TsVc0qTYNV4AoSAUP4geV+HedxDQlYfGMpTHl1
   Ja28GVRWlz5ePBXufPIBHnO9Uvu5kmD08kVf2/mb0nnWtUtIqhf5ZrdQG
   qqGLiuQBeYXbjIx2DVso9jKY4N5MpZ4tjwylpmI4x9dDlvs5vIdz7wPUO
   x/dMRNRzrBvYr9vlr/mt78ZZSiNMsQJrI64zDKT6Kp6uUgtVM+7+nr+3U
   Ix/Pfl01Nf8MkaEomlb3SEOmUVAnzDcpZt+ATNCq+bB6zAXbs5J4gBO4M
   FzJaXMYEzb3p4CIUi8LikeV3umRrBpRpHludqA6WMzVDwkzFo2IEH0SNU
   w==;
X-CSE-ConnectionGUID: iBak2jIGRJmfbUoIFP9pUQ==
X-CSE-MsgGUID: GkDQOvFrQr+x83LOHG7oOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44380712"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44380712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:05:50 -0800
X-CSE-ConnectionGUID: GhNtkM2TSQ+1WlJ7d1rJGg==
X-CSE-MsgGUID: La9tmLw4QmS0EVBZSvxcsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115252563"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:05:26 -0800
Message-ID: <9df43c5c-bca9-4e34-b6df-758272b211a6@intel.com>
Date: Wed, 19 Feb 2025 10:05:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl: Document missing sysfs files
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 ira.weiny@intel.com, alison.schofield@intel.com, linux-cxl@vger.kernel.org
References: <20250218224853.67457-1-dave@stgolabs.net>
 <20250218224853.67457-3-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250218224853.67457-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 3:48 PM, Davidlohr Bueso wrote:
> Add to the ABI documentation the payload_max and label_storage_size
> read-only files, which have been there since the early days.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7bdf0eb79d7c..04a880bd1dde 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -18,6 +18,24 @@ Description:
>  		specification.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/payload_max
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Maximum size (in bytes) of the mailbox command payload
> +		registers. Linux caps this at 1MB if the device reports a
> +		larger size.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/label_storage_size
> +Date:		May, 2021
> +KernelVersion:	v5.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Size (in bytes) of the Label Storage Area (LSA).
> +
> +
>  What:		/sys/bus/cxl/devices/memX/ram/size
>  Date:		December, 2020
>  KernelVersion:	v5.12

