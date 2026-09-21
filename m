Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE148517BAA
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028173; cv=none; b=eWbECprgeYU2y8Op5Xzpr7fJfYYEdyi4WJLm6XObBKaO2qRwjcQmpWrm6DbjefXTwj9AQolUXvZf5vD7JzQrrtGNhfXeOcsiROtYAJOXj/suNHRuUBLEDDux/6fQ2yVDOoZUOSymPV/CWpIuBoDo7nvMPKaTzj7dbvc34726QdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028173; c=relaxed/simple;
	bh=V+sj/HPRYliuAlIljV+SIr6kiRNuebM41veChVZ6Mxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox39DMo1USZDucm20L4wjH4b6eLRMXoMcUuV7yD0zAA1//zHZ+O7HlRBcCK+FhUNljT2ahcoUGybjlpb7OFCKdf824yM/leRtt4hO20WRTnU45kcCNHcm8KDkmDkOJNygZfsDgrC1Fd685lDdF4+6gBj7BdsJGKSQR3csLHaxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7vuJLHW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7vuJLHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790028172; x=1821564172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V+sj/HPRYliuAlIljV+SIr6kiRNuebM41veChVZ6Mxc=;
  b=f7vuJLHWZ/vQzT2+KMuUSXaGuHQ46cUa1BhR+SonrGYx8Re2NeMDEQme
   MYxQwYvkvfLOwUfhgeIVMlHFLoQARcYdiuf44o1o0jrMN3to+eQgatfYH
   HHZ57IZo0AbXSortGo1vclLEe38lxO9dz04PkfEUF2lpxZ3Odi6lANeGG
   gj+G0lC7qnBVMrWhkgRnWAOnXVzW6OJYojPhrKGZ2yqSU0TafjV0+OdCr
   g49U04/hxsLWXS3IsC8UJWbdSEVpIrhf4FJQv2E32srBlQ83nWO/mboyI
   uOsUuX+88O/wwijPMkUeqnNwjyFbWj5W6s2NXEoS7SYAMFiocTSUtpmOZ
   g==;
X-CSE-ConnectionGUID: HgsS6dKDSPyaRaqdAqKqDw==
X-CSE-MsgGUID: IKeWWwGeQa2Gsr2opsu0ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93081703"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="93081703"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 15:02:51 -0700
X-CSE-ConnectionGUID: 5llrupJTQ2CihikwESRh0w==
X-CSE-MsgGUID: FTMAb4oRRACGucicC5cx6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280910080"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.234]) ([10.125.109.234])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 15:02:50 -0700
Message-ID: <9ffddb3d-9b22-4fe4-b355-bbad82f4b8aa@intel.com>
Date: Mon, 21 Sep 2026 15:02:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 8/8] Documentation/cxl: Document DPA partition layout
 and ordering rules
To: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
 Gregory Price <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>, Anisa Su <anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-9-anisa.su@samsung.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260918203049.7273-9-anisa.su@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/26 1:30 PM, Anisa Su wrote:
> DC Partitions complicate DPA ordering. Add a DPA Partitions section to
> cxl-driver.rst describing spec-mandated and Linux requirements for the
> layout.
> 
> maturity-map.rst breaks the DCD entry into sub-items so the map shows
> what this series lands: partition enumeration is [1], event handling
> and DC-backed DAX regions remain [0] until the follow-on series enables
> them. The parent stays [0]; nothing is usable yet.
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> ---
> Changes:
> [jonathan]: drop paragraph describing "support for additional
> dc partitions may be added later..." to avoid predicting future work in
> documentation
> [davidlohr]: add DCD sub-items to maturity-map.rst so a multi-step
> upstreaming shows users what is there and sets expectations.
> ---
>  .../driver-api/cxl/linux/cxl-driver.rst       | 35 +++++++++++++++++++
>  Documentation/driver-api/cxl/maturity-map.rst |  4 +++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index dd6dd17dc536..eb4de2a9a9af 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -181,6 +181,41 @@ A Memory Device is a discrete base object that is not a port.  While the
>  physical device it belongs to may also host an `endpoint`, the relationship
>  between an `endpoint` and a `memdev` is not captured in sysfs.
>  
> +DPA Partitions
> +~~~~~~~~~~~~~~
> +A memory device presents its capacity as one flat `Device Physical Address`
> +(DPA) space divided into `partitions`, which Linux lays out in a fixed
> +order::
> +
> +  DPA 0                                                     end
> +  +---------------+---------------+---------------------------+
> +  |      ram      |     pmem      |       dynamic_ram_1       |
> +  +---------------+---------------+---------------------------+
> +  part[0]         part[1]         part[2]
> +
> +Part of that order is required by the CXL specification and part of it is a
> +Linux choice.
> +
> +The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
> +Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
> +at DPA 0 and pmem starts at the DPA immediately following it.
> +
> +Dynamic Capacity partitions only need to be 256MB aligned according to
> +CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
> +(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
> +(static) capacity and its first DC partition, or between one DC partition
> +and the next.
> +
> +Linux chooses not to support gaps between static and dynamic capacity: the
> +first DC partition must begin at the DPA immediately following static
> +capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
> +a device with no static capacity at all.
> +
> +Currently, only one dynamic partition is supported. A device may report up
> +to eight (CXL r4.0 Table 8-346); Linux configures the first and exposes it as
> +`dynamic_ram_1`. Gaps between DC partitions are not checked, since only the
> +first is used.
> +
>  Port Relationships
>  ~~~~~~~~~~~~~~~~~~
>  In our example described above, there are four host bridges attached to the
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index 282c1102dd81..fefd31899229 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst

Maybe hold off this commit for when everything goes in? Otherwise it's weird that there's documentation but no code.

> @@ -150,6 +150,10 @@ Memory-pooling
>  * [1] Hotplug of LDs (via PCI hotplug)
>  * [0] Dynamic Capacity Device (DCD) Support
>  
> +  * [1] DC partition enumeration / configuration (Get DC Config, CDAT DSMAS, event interrupts)
> +  * [0] Extent add / release event handling
> +  * [0] DC-backed DAX regions

I would just update maturity map once when the entire DCD code is in.

> +
>  Multi-host sharing
>  ------------------
>  

