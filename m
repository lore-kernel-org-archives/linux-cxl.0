Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02630377A87
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580989; cv=none; b=DQPni4ylxYDG77ZB4YkVVJPZu8erUrVrtdSyKdX1ixV683Q47doMYSgTbsIQs6dr/kGBrqDgUo2XAX46fw3ovfAeC2tEIzz6O0eV8L3G9KURq2MisKiRkRANrxs5gOg3l0UNjMe7qYY1Ast3Nk1nlTONUWxSWxbeWhobfDLo3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580989; c=relaxed/simple;
	bh=Vtju7hwKle57nIoZNWLt3cZYqFEuqlU0OvGOaJTjmb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKMXHyaaR8PUW62U5q4FxIQocAphgCMRnnQv0g7S4ujnWqu2Ny0wAz9nthw2JHx10luDeyGVni6aN5n1dR3r5DJF7IdmUHKAsEVLqe/uEFT6q5SQGNdYYT75Un3KPVyN8SxUTCjWxXYZddEKjsVISd8k+27IDZzM03DL/TcUsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuOd08Lz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuOd08Lz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789580973; x=1821116973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vtju7hwKle57nIoZNWLt3cZYqFEuqlU0OvGOaJTjmb8=;
  b=NuOd08Lz/ip3QZE/gIS0sw+oRoXQCTbpsX87DhN2MuI46SHBwiLQYmKe
   B+Sb5L2nLbs7yoJpJtGybRPflpu6jnL1MntHd2+DY6Suwzp44lWbsCETN
   BaNuLdvVRq66d1AXeDVav2Hk6OPZJ1zJz5CBdSM7wa1oC8lgyF92STAsQ
   iuNi3ongoanLPFCBr4pU0wNkMwLIBuddvo96055GGevEWl61pcVIAkqcC
   rzOdFxmQcrWRsf2Dh5qAud6mLWW0abnnB0vlpdO9lH8i93ZGUhAqio8gg
   Cy2HAtgpHc8s7z3RTCrTBPp0GMW4AKKbUwLZP0UgEbY0j65v5ThDJn+HK
   w==;
X-CSE-ConnectionGUID: hgtg2pcyQZ+yrS2TSF2RtQ==
X-CSE-MsgGUID: jRJiCdRDSLSWMNt4mrs7ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101480848"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101480848"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 10:49:30 -0700
X-CSE-ConnectionGUID: fukZwx59QfayM0D4nVK7mw==
X-CSE-MsgGUID: QvSNKwaKQKOLPArRBijKWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1629581"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.0]) ([10.125.109.0])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 10:49:29 -0700
Message-ID: <1b2d9995-ea0f-44c2-a11d-e41d1f321671@intel.com>
Date: Wed, 16 Sep 2026 10:49:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Create node access attributes for CFMWS-only
 NUMA nodes
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260916120338.369436-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260916120338.369436-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/26 5:03 AM, Guixin Liu wrote:
> A NUMA node that only backs a CXL fixed memory window and is not
> enumerated by SRAT has no memory_target in the HMAT code. When the
> first memory of such a node comes online, hmat_callback() exits early
> at find_mem_target() without creating anything, and
> node_update_perf_attrs() only updates attributes that already exist,
> so the node never gets its accessN sysfs attributes at all:
> /sys/devices/system/node/nodeX/accessN/initiators/* stays missing even
> though the region's own sysfs reports the coordinates.
> 
> Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
> by SRAT") handled this by having the CXL region notifier call
> node_set_perf_attrs() directly for such nodes, but
> 
>   commit 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates
>   directly instead of through HMAT")
> 
> replaced that call with node_update_perf_attrs() on the assumption
> that the HMAT callback has already created the attributes. That
> assumption does not hold for CFMWS-only nodes.
> 
> Restore the distinction: when the node is not backed by a real SRAT
> pxm, create the attributes with node_set_perf_attrs() instead of
> only trying to update them.
> 
> Tested on a QEMU CXL topology with a CFMWS window whose memory is not
> described by SRAT or HMAT: after the region's first memory block comes
> online, node1 has no accessN directory before this patch; with it,
> node1/access0/initiators/{read,write}_{bandwidth,latency} appear with
> the calculated coordinates.
> 
> Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> checkpatch reports one "Prefer a maximum 75 chars per line" warning:
> the 2e454fb8056d reference line above is 84 columns because checkpatch
> requires the quoted title to match the git subject exactly, and that
> subject is 62 characters long. Wrapping it instead produces a
> GIT_COMMIT_ID error, so the long line is the lesser evil.
>  drivers/cxl/core/cdat.c   | 5 +++++
>  drivers/cxl/core/core.h   | 1 +
>  drivers/cxl/core/region.c | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> ---
>  drivers/cxl/core/cdat.c   | 5 +++++
>  drivers/cxl/core/core.h   | 1 +
>  drivers/cxl/core/region.c | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..e28c40159d94 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -1072,3 +1072,8 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
>  	}
>  }
> +
> +bool cxl_need_node_perf_attrs_update(int nid)
> +{
> +	return !acpi_node_backed_by_real_pxm(nid);
> +}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35eaf636adc9..19a5b8edbfda 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -229,4 +229,5 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +bool cxl_need_node_perf_attrs_update(int nid);
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..636435733754 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2630,7 +2630,10 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> +			if (cxl_need_node_perf_attrs_update(nid))

Given that it's only used once and it's straight forward enough, just open code it instead of creating a helper.

DJ

> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> +			else
> +				node_update_perf_attrs(nid, &cxlr->coord[i], i);
>  			cset++;
>  		}
>  	}

