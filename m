Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A135F509F14
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746001; cv=none; b=N9NvbTgxAgwu02IDtqimRC/upDAtw4NM6+6wVxCK3mhG9zrIqOykeVZp92K0XDqa+TOTRGvbLLvmxNpjN0oSJIUmgm+VveHnmNr0n3nuHZAJD2hAifyQhdgGCxL82PQvFueueuQ4IOlurYpG7rEz7Xm+QwGYJ4LXRn+yWFQysKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746001; c=relaxed/simple;
	bh=GXwYWAqDWne40w00hYCRgU+uJcziJc7f75fX4cBI/Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Id64uIhngGVbtahSfVWNm/FmaHfdnQWeefUNEyqSbdalEq7uMpahkOIq5aeCKCI3NGAYAUQIELixCrTDmCJZHUhpn+/uwBqeA4Yo/BbQNozWJAJxBIkqu2GH6ki3pLeOz8F/VpiueCkp4jGZu881666xLScMffkUnIwiO6Xgubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3w41UBM; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3w41UBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789745994; x=1821281994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GXwYWAqDWne40w00hYCRgU+uJcziJc7f75fX4cBI/Hw=;
  b=F3w41UBMFtgsWoDW7LYINmsAZUsfEWJbsHiPqW3trdzM4dTIP5JGzWvh
   olt20sVK0k1Oh3imARfN3D+/4rEkqoZCYphhD4RMrO227mSeZU9hsUfJS
   MMCD6hg+5fl3L5a9xagw62av9oc3uNJMOov/gWToAZSPEE6mWseKRvTZ6
   IVl23zk/6O4CGfP69ZOnd42PC5ajcHdYJl1KMQrx7ShypFvrZExNMDIQR
   poBMn2N07iF0tnruCfShBVW8lPFW3OeJ2BN3Rt5rm6H+udhwgesDCX57g
   Uy0yyF81u194BnufKt5cL/i45Y85zcPtYF56x0gM4PiNkIr4JKqPFMPqS
   Q==;
X-CSE-ConnectionGUID: VTI3BvvXRNeV89t8g9m/rA==
X-CSE-MsgGUID: vfowvA3sRkipN7aNPCPVAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="759639"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="759639"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:39:49 -0700
X-CSE-ConnectionGUID: 7czY633ZQvGonTKK7pQ+5Q==
X-CSE-MsgGUID: vBUjJnpZR6uth67wC46DwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="297908248"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:39:48 -0700
Message-ID: <85642d5d-b6c5-47ea-a51c-989d5bbb72b8@intel.com>
Date: Fri, 18 Sep 2026 08:39:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260917024632.1397380-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260917024632.1397380-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/26 7:46 PM, Guixin Liu wrote:
> A NUMA node that only backs a CXL fixed memory window and is not
> enumerated by SRAT has no memory_target in the HMAT code, so
> hmat_callback() exits early at find_mem_target() and never creates
> the node's accessN attributes:
> /sys/devices/system/node/nodeX/accessN/initiators/* stays missing.
> 
> Commit debdce20c4f2 ("cxl/region: Deal with numa nodes not enumerated
> by SRAT") had the CXL region notifier call node_set_perf_attrs()
> directly for such nodes, but commit 2e454fb8056d ("cxl, acpi/hmat:
> Update CXL access coordinates directly instead of through HMAT")
> replaced it with node_update_perf_attrs(), which only updates
> attributes that already exist and thus does nothing for these nodes.
> 
> Create the attributes with node_set_perf_attrs() when the node is not
> backed by a real SRAT pxm.
> 
> Tested on a QEMU CXL topology with a CFMWS window not described by
> SRAT or HMAT: node1/access0/initiators/{read,write}_{bandwidth,latency}
> appear with the calculated coordinates once the region's first memory
> block comes online.
> 
> Fixes: 2e454fb8056d ("cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT")
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Applied to cxl/next:
ef71014055f7

> ---
> Changes since v1 (https://lore.kernel.org/r/20260916120338.369436-1-kanie@linux.alibaba.com):
> 
> - Open code the one-use helper (Dave Jiang)
> - Comment why creating the attributes here is safe: this path runs
>   at most once per node (Jonathan Cameron)
> - Lead with the user visible regression (Alison Schofield)
> ---
>  drivers/cxl/core/region.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..9a5fd3da539d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/acpi.h>
>  #include <linux/memregion.h>
>  #include <linux/genalloc.h>
>  #include <linux/debugfs.h>
> @@ -2630,7 +2631,19 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> +			/*
> +			 * A CFMWS-only node (not backed by a real SRAT pxm)
> +			 * has no HMAT memory_target, so hmat_callback()
> +			 * never created the access attributes for it:
> +			 * create them here instead of only updating them.
> +			 * This is called at most once per node (see
> +			 * nodemask_region_seen), so the attributes are not
> +			 * created twice.
> +			 */
> +			if (!acpi_node_backed_by_real_pxm(nid))
> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> +			else
> +				node_update_perf_attrs(nid, &cxlr->coord[i], i);
>  			cset++;
>  		}
>  	}

