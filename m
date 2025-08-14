Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0653FE7;
	Thu, 14 Aug 2025 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197585; cv=none; b=TpE8DoymgkY64cKSCMLzYwvN/tMBWJncnnFNn2kXxT++dwXq4nPS65wq2ZTaFHEjeMBsVuL5f1ENmCHXD7rcbXwFzwTnoBCt1hdcxsRpCS8cSDZWhDxxLwgPoRTtyhj3r2t/Ktpy4+rKvLVtMSGF+AuQXMTkSjKsHCcHbY/DxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197585; c=relaxed/simple;
	bh=s8mh3vNgWnfGDCjVY/PnUQL8O1hytFgaktLZBUfTQYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiftRAj+AAk3QkE6ORxLZrkzM18zU8OR/fnA1YrGwmKWmBzOQ12iZvzizwc3KNFt3GvMEqDdOf67J8kTbX2kyS2Cscq1jZS9I48jOzBsJ+N7twTO8i5q9tn0710nmwnxohRF+/xatvgr0+yMCjdG5UG1FKRypYVxnLxobncG1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4KCWCaJj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4KCWCaJj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sOCcAEc3jUijNMas3bMHj5Td9WLxZFFODnC7RkYq4o0=; b=4KCWCaJjmLZFaJsybygl/t+8EB
	klvcJZvQpcvRCC42lqFLQSZMx2OFJ5aUar9EGgYheGA2FRyYvTHLo58V1U9x03Auri2qNpTpZz1W9
	lXg0K7SeohNa8BoNU/fUPFCO623zzTgbVsntufx6t6s89newdM+wiN3KbDXEK+j+j7LfyBZ8plNrN
	mP5CRWZ5M714m6/4qGT7wv8quE8NZbbUyGNzam7KaFblJ5iwVnjnLi8TeEWTfQB8c23YnYxtT6Jgv
	N0qD8veDlG+VncXUHKrN3BpcqD+mUZYapW2bnUg5OMsud8QZoM+ypZx7MvYgIujViiyfrdvKkgw6i
	0WrhxIaQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umd4O-00000000MZy-2WlP;
	Thu, 14 Aug 2025 18:53:00 +0000
Message-ID: <eb9ce8dd-ac8e-41b7-b56e-121d3c744c60@infradead.org>
Date: Thu, 14 Aug 2025 11:52:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: Fix driver-api typos
To: Ranganath V N <vnranganath.20@gmail.com>, alison.schofield@intel.com
Cc: alim.akhtar@samsung.com, corbet@lwn.net, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel-mentees@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, rafael@kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <aJ4KEKHn351vQXe_@aschofie-mobl2.lan>
 <20250814184304.20448-1-vnranganath.20@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814184304.20448-1-vnranganath.20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/25 11:43 AM, Ranganath V N wrote:
> Corrected a few spelling mistakes
> 
> v2:
> * corrected as per suggestions.
> * improved the phrasing.
> 
> functionalty ==> functionality
> in Documentation/driver-api/cxl/devices/device-types.rst
> 
> adjascent ==> adjacent
> in Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> 
> succeessful ==> successful
> in Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Looks good. Thanks.
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  .../driver-api/cxl/devices/device-types.rst        |  2 +-
>  .../example-configurations/one-dev-per-hb.rst      |  2 +-
>  .../thermal/exynos_thermal_emulation.rst           | 14 +++++++-------
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> index 923f5d89bc04..7f69dfa4509b 100644
> --- a/Documentation/driver-api/cxl/devices/device-types.rst
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
>  Typically used for initialization, configuration, and I/O access for anything
>  other than memory (CXL.mem) or cache (CXL.cache) operations.
>  
> -The Linux CXL driver exposes access to .io functionalty via the various sysfs
> +The Linux CXL driver exposes access to .io functionality via the various sysfs
>  interfaces and /dev/cxl/ devices (which exposes direct access to device
>  mailboxes).
>  
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> index aebda0eb3e17..a4c3fb51ea7d 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> @@ -10,7 +10,7 @@ has a single CXL memory expander with a 4GB of memory.
>  Things to note:
>  
>  * Cross-Bridge interleave is not being used.
> -* The expanders are in two separate but adjascent memory regions.
> +* The expanders are in two separate but adjacent memory regions.
>  * This CEDT/SRAT describes one node per device
>  * The expanders have the same performance and will be in the same memory tier.
>  
> diff --git a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> index c21d10838bc5..c679502f01c7 100644
> --- a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> +++ b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> @@ -28,13 +28,13 @@ changed into it.
>  delay of changing temperature. However, this node only uses same delay
>  of real sensing time, 938us.)
>  
> -Exynos emulation mode requires synchronous of value changing and
> -enabling. It means when you want to update the any value of delay or
> -next temperature, then you have to enable emulation mode at the same
> -time. (Or you have to keep the mode enabling.) If you don't, it fails to
> -change the value to updated one and just use last succeessful value
> -repeatedly. That's why this node gives users the right to change
> -termerpature only. Just one interface makes it more simply to use.
> +Exynos emulation mode requires that value changes and enabling are performed
> +synchronously. This means that when you want to update any value, such as the
> +delay or the next temperature, you must enable emulation mode at the same
> +time (or keep the mode enabled). If you do not, the value will fail to update
> +and the last successful value will continue to be used. For this reason,
> +this node only allows users to change the temperature. Providing a single
> +interface makes it simpler to use.
>  
>  Disabling emulation mode only requires writing value 0 to sysfs node.
>  

-- 
~Randy
