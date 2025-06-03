Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8014B5AE;
	Tue,  3 Jun 2025 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990481; cv=none; b=Ix1kFDULa0WbkxC0cJzQePSn4cbmeXIn3ApcPIkN9EzZr/snPd7K32+LDmQ+l2gMZupvwAwWUvFDgDb/1Co4hHXB7z1/pQRGbW62MhMFXkCR2nJKXPdfHeo0gm7Rx9rtvjuyH3HBhlGuzPZmCyPo4ywkvFtIf+wNUQqVzyz5rO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990481; c=relaxed/simple;
	bh=NCl7elu1kKnTcHqGapi3E5d5TqHpSu6hrSczxDdVnlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVbBqbnODC6jy2xOrGc4YagxSmcYbsZxVN9RYZxSkguE2VtEBy04gUl0zpvdN534oOIrhTAW5sDoAM0h7NXWcHvBWYdJKqE5gA3pEjy58FZYtwiV/o9LG0KXD2saKXmETh8GwC9VZrbuuNn24T2qJFTXNRgAuKB6W0h9+gggOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLgCGVyW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLgCGVyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748990479; x=1780526479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NCl7elu1kKnTcHqGapi3E5d5TqHpSu6hrSczxDdVnlg=;
  b=SLgCGVyWqCZNgRhJaz+nDBxddAX6Rt9FLsiZWsvBcCap3pT1zR3X++uq
   Lc9y1Oq1qXazZMONsgwMOpaVAA0q3TBsg/OUVkDYtw8zhg8TKvnnKvMda
   lup29lyqzn1+tJ/kkTqNi9giC0EEXz1Khmy3LbgaEiUxGuU3sgUKFJ2SG
   lOUu6EAnyteRoxS2g9UseMWAgbk5aiR4Pg+YaFHygv8QQjg5yi8ImoU5o
   3bgl7t4GqQaTU9ZpmMG7xmtn+aRKCDqxINhL7TvnTYoiwhbiKet+7Io0N
   xCJg1zpqwWMpkZz8j5CjN9A39hG5MwuOQDgwgYh1C8Y6m/jypx3X1XEvi
   w==;
X-CSE-ConnectionGUID: w5V4FyK3RUazMjUdXdZXOg==
X-CSE-MsgGUID: rFEFTDsjTxmUGf/R3UBnzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51195315"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="51195315"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:41:18 -0700
X-CSE-ConnectionGUID: C3HJVG6XSa+lWVwXKAdjjw==
X-CSE-MsgGUID: Djq2N7UvR86eIMtmT/Y28A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="144964959"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:41:18 -0700
Message-ID: <aba5fbcc-981d-4591-ba47-d879656c999f@intel.com>
Date: Tue, 3 Jun 2025 15:41:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cxl/Documentation: Add more description about
 min/max scrub cycle
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603104314.25569-1-ming.li@zohomail.com>
 <20250603104314.25569-2-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603104314.25569-2-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 3:43 AM, Li Ming wrote:
> user can configurare scrub cycle for a region or a memory device via

s/configurare/configure/

> sysfs interface. Currently, these interfaces have not enough description
> for the return value. So adding return value description to these
> interfaces.
> 
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-edac-scrub | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-edac-scrub b/Documentation/ABI/testing/sysfs-edac-scrub
> index c43be90deab4..ab6014743da5 100644
> --- a/Documentation/ABI/testing/sysfs-edac-scrub
> +++ b/Documentation/ABI/testing/sysfs-edac-scrub
> @@ -49,6 +49,12 @@ Description:
>  		(RO) Supported minimum scrub cycle duration in seconds
>  		by the memory scrubber.
>  
> +		Device-based scrub: returns the minimum scrub cycle
> +		supported by the memory device.
> +
> +		Region-based scrub: returns the max of minimum scrub cycles
> +		supported by individual memory devices that back the region.
> +
>  What:		/sys/bus/edac/devices/<dev-name>/scrubX/max_cycle_duration
>  Date:		March 2025
>  KernelVersion:	6.15
> @@ -57,6 +63,16 @@ Description:
>  		(RO) Supported maximum scrub cycle duration in seconds
>  		by the memory scrubber.
>  
> +		Device-based scrub: returns the maximum scrub cycle supported
> +		by the memory device.
> +
> +		Region-based scrub: returns the min of maximum scrub cycles
> +		supported by individual memory devices that back the region.
> +
> +		If the memory device does not provide maximum scrub cycle
> +		information, return the maximum supported value of the scrub
> +		cycle field.
> +
>  What:		/sys/bus/edac/devices/<dev-name>/scrubX/current_cycle_duration
>  Date:		March 2025
>  KernelVersion:	6.15

