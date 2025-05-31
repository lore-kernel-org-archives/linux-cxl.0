Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1286323;
	Sat, 31 May 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748710669; cv=none; b=uqCXoxe+nNF/QDrQTkLPvA3i4ZcJpX2F8VbsyBQ0fD/hQQfEOetCfDN5Qg9PwFoDQw5z0JSD6V6x2CRTlQsN+U+GFiScc/eXXfg8jyDhVkrKPpxbl4ZWd6xApxHietEaNavUz8J4f7EGKgFkdIdpauvICdqZzMarPcxzib4YBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748710669; c=relaxed/simple;
	bh=MeOtkIrLMT6IjO2sNqCraauEVwJylK9XitUYKe63gT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unA6m2RlPdjgUUSv9MIJz4e9+eWINhvLyA9PltHqcFhtAbmk67y/eaQSZQlIhRFaWNtAWT/zji7UulsdesASdT6oRh6o2oAXn/7G3NUGQSfyeEu2MJCR610pqwr1ul8iDgnsk/3uQwFYyhJJ1VEwsQwDOitMwtABekPaibnN/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vS4O4fxK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vS4O4fxK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Otdj8ujGAF2QmUcG8kvdd7R/HPnA2c9NJiQzWXZJi3w=; b=vS4O4fxKFnEbTgQGKLGoqXmXFL
	pLw/6RbtSBMAcyaOmCL9SyDQyJT2ezrbf66EvB6gpih7lKsflY9guCr6t35Dd3RCytIftnY3yx9Mo
	PmiX9J/GpezlJwXgaILEElJs8AuCyhOPZdcpXCjaD5X9rExWbdGu5zpmcWuI9XhCdMamMgOY0r7w/
	UkAV0NBMfkL8HeCKdlSeVLpYKHNrwMyJTrC67HmQc+gEPv17L5mTCeMnVEXRpgMO72tlAUL/Gxmbm
	MZDIkw4seT4zOei06JtMBdQyWJvKI7TSDKWhL5kQm3/SSEY54/v57Yd1WqYER0U35gnS5Sxpw8UwX
	QLTICNAQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLPWa-0000000Gvr7-41Bt;
	Sat, 31 May 2025 16:57:37 +0000
Message-ID: <863ff758-d9a1-4800-8746-ee63ee2a4e63@infradead.org>
Date: Sat, 31 May 2025 09:57:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cxl: fix typos and improve clarity in
 memory-devices.rst
Content-Language: en-US
To: Alok Tiwari <alok.a.tiwari@oracle.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/31/25 12:51 AM, Alok Tiwari wrote:
> This patch corrects several typographical issues and improves phrasing
> in memory-devices.rst:
> 
> - Fixes duplicate word ("1 one") and adjusts phrasing for clarity.
> - Adds missing hyphen in "on-device".
> - Corrects "a give memory device" to "a given memory device".
> - fix singular/plural "decoder resource" -> "decoder resources".
> - Clarifies "spans to Host Bridges" -> "spans two Host Bridges".
> 
> These changes improve readability and accuracy of the documentation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

(This time not in html.)


> ---
>  Documentation/driver-api/cxl/memory-devices.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index d732c42526df..e9e2952a967d 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
>  (Linux term for the top of the CXL decode topology). From there, PCIe topology
>  dictates which endpoints can participate in which Host Bridge decode regimes.
>  Each PCIe Switch in the path between the root and an endpoint introduces a point
> -at which the interleave can be split. For example platform firmware may say at a
> -given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
> +at which the interleave can be split. For example, platform firmware may say at a
> +given range only decodes to one Host Bridge, but that Host Bridge may in turn
>  interleave cycles across multiple Root Ports. An intervening Switch between a
>  port and an endpoint may interleave cycles across multiple Downstream Switch
>  Ports, etc.
> @@ -187,7 +187,7 @@ decodes them to "ports", "ports" decode to "endpoints", and "endpoints"
>  represent the decode from SPA (System Physical Address) to DPA (Device Physical
>  Address).
>  
> -Continuing the RAID analogy, disks have both topology metadata and on device
> +Continuing the RAID analogy, disks have both topology metadata and on-device
>  metadata that determine RAID set assembly. CXL Port topology and CXL Port link
>  status is metadata for CXL.mem set assembly. The CXL Port topology is enumerated
>  by the arrival of a CXL.mem device. I.e. unless and until the PCIe core attaches
> @@ -197,7 +197,7 @@ the Linux PCI core to tear down switch-level CXL resources because the endpoint
>  ->remove() event cleans up the port data that was established to support that
>  Memory Expander.
>  
> -The port metadata and potential decode schemes that a give memory device may
> +The port metadata and potential decode schemes that a given memory device may
>  participate can be determined via a command like::
>  
>      # cxl list -BDMu -d root -m mem3
> @@ -249,8 +249,8 @@ participate can be determined via a command like::
>  ...which queries the CXL topology to ask "given CXL Memory Expander with a kernel
>  device name of 'mem3' which platform level decode ranges may this device
>  participate". A given expander can participate in multiple CXL.mem interleave
> -sets simultaneously depending on how many decoder resource it has. In this
> -example mem3 can participate in one or more of a PMEM interleave that spans to
> +sets simultaneously depending on how many decoder resources it has. In this
> +example mem3 can participate in one or more of a PMEM interleave that spans two
>  Host Bridges, a PMEM interleave that targets a single Host Bridge, a Volatile
>  memory interleave that spans 2 Host Bridges, and a Volatile memory interleave
>  that only targets a single Host Bridge.

-- 
~Randy
