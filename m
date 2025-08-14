Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5F2FB996;
	Thu, 14 Aug 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186998; cv=none; b=q7QHUWSkuyhsmhzE1TImF5Jjyvc/2x+z+SBavjz6i44z7Y+kpVQj9I/R+SYOxwHCPIS8z/O3xHnZa4Kn/F1dwn4oFzY8fpdQwgxFG6jv7tQMXTw55GM0feJ5Zx4ob0WcBLhG49o4/vlrd+6IO/mPoNjGI+MubHX2Xh5YGrqHyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186998; c=relaxed/simple;
	bh=3h2uES2VslNzNOlhdk3e0ZzlqdhIcg1czAl4A5mleuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfzGNKvuFffL1dgvruaJUuv8fT0yV87DSqOC/lMMefwQT05iBL2BFRqjtRKOlaTRq7QrDmz4rpNcEQNeGufFDdQOpU6o/8LBXoIxHs84jBPzAa6vCySkuekgd+4R6gbu9P2X6UmRsLIPQeG8BkBP2XqKqEvF4Oix64mWqPSv85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DWjsmerM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DWjsmerM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RxZJR6SmruU9qKmz3YFoByNqdMbdKVlOdMVKI5gChGw=; b=DWjsmerMtgZVEQf1yV8diFOgum
	bJMBcGQzoxKtqF8UXL3rU1XZ3GhSyR6MbV6HWS1Oe9y5W0A7+HQeoL4nrvSKtaSjQcU8nt9j4pTQA
	1Ab4TIdmydfaf3pa/OAatpok66Vlkw3897N+owgWXbUR1yKxhwr/a6LGFxlqdSuLUni6e0Y1iA3E+
	a0EL6dfVj9wJ0eW7w0wcuLW0bfuuvnHq1c2XcW3mR0xfrJ7AourX9vUm/gAJmuPFtKdtHc3qXLis8
	LmfZyPjGjMd4y+mM1TU1SsxpMk12GeuLRkVaeshWALgk7drZmoe1IognxpRK/Xo4btZQRbhQZmgcM
	2DvYHeTw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umaJe-0000000HYBq-36lq;
	Thu, 14 Aug 2025 15:56:34 +0000
Message-ID: <95b81414-52d4-4e13-a894-9d59cd0e175c@infradead.org>
Date: Thu, 14 Aug 2025 08:56:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Fix driver-api typos
To: Ranganath V N <vnranganath.20@gmail.com>, corbet@lwn.net,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
 dave@stgolabs.net, rafael@kernel.org, linux-kernel-mentees@vger.kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com
References: <20250814114245.16399-1-vnranganath.20@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814114245.16399-1-vnranganath.20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/25 4:42 AM, Ranganath V N wrote:
> Corrected a few spelling mistakes
> 
> - functionalty ==> functionality
> in Documentation/driver-api/cxl/devices/device-types.rst
> 
> - adjascent ==> adjacent
> in Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> 
> - succeessful ==> successful
> in Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/driver-api/cxl/devices/device-types.rst           | 2 +-
>  .../cxl/platform/example-configurations/one-dev-per-hb.rst      | 2 +-
>  Documentation/driver-api/thermal/exynos_thermal_emulation.rst   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
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
> index c21d10838bc5..f77d27c25ce2 100644
> --- a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> +++ b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> @@ -32,7 +32,7 @@ Exynos emulation mode requires synchronous of value changing and
>  enabling. It means when you want to update the any value of delay or
>  next temperature, then you have to enable emulation mode at the same
>  time. (Or you have to keep the mode enabling.) If you don't, it fails to
> -change the value to updated one and just use last succeessful value
> +change the value to updated one and just use last successful value
>  repeatedly. That's why this node gives users the right to change
>  termerpature only. Just one interface makes it more simply to use.
>  

-- 
~Randy
