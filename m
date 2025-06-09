Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E0D1CF7AF;
	Mon,  9 Jun 2025 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501758; cv=none; b=qz7zyWIoMx/pvd9t7FdF+IwXJaaH0c7HrF3PONG1svgdwlgTNfk/zWzUjddhA6/YOd37Y60X5/PKnzqvWN3bJm8Gb+GtWWgNv1nj0LEH0CmfgGiklsODe0zxZoHstg5XT2XnsxMaLrVgiPw7/oENmZjoPke3bY18we3g3sOKzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501758; c=relaxed/simple;
	bh=kz8Qmi1W6iqKFfqAlzvTIDu8B6BAVAfGpkByPREk0u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATuL6Qc2M8vi/3fHMOOC9NSojfJE7SAsgf9HSm+JMQI7+y3yfTSaPByBxIQEXxtBZw/kHvHlYj2n0Zv20kZZUTDNYEI0ujv8UiAEcbxQBzrOCD+7zYZJUVfCoBt1/F1ACGwYRaYlhAtEsoNS445JPxeg/Sd1hzMoCgHPqk76KTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EN2TfaSG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EN2TfaSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749501756; x=1781037756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kz8Qmi1W6iqKFfqAlzvTIDu8B6BAVAfGpkByPREk0u0=;
  b=EN2TfaSGAeKkaFO8D0/HwDEFmeyLpNrc3+ZRYhA2iv0l80/QSRxBlJSk
   aFnnrGT3m0b3ZMyUOSYeSuyIWrtmHTDQ3oPyDbJgTi7LYp6DheF8+l2wd
   dAxj9iW5pNNkFT5T05KXiOYsKwe6uk+XKQg2CkXJO0MX2HkV8eDtYLwBY
   h/95DDf3BVyB5mbNISWHeivO7zR8JLZA3axF35+F0PZhQYe77hGr2U5hS
   h21IEC0+10FpejaUl/bM3WjSHlDDY+0Rgr/aiphvhuLFnCxNezGpNDI4H
   O5LkPbx7wE7ksAYJHfiIeTmtC5g6RDqolG9lWGsrgAJCDD0O0lJfZbCbP
   g==;
X-CSE-ConnectionGUID: HKQLNwloQWSRF2ZxelDfoQ==
X-CSE-MsgGUID: 36XHIFanTIyiIP5G5435ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69039733"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="69039733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:42:35 -0700
X-CSE-ConnectionGUID: P7K+iHnQS8OWVmyC4a23UA==
X-CSE-MsgGUID: 8T4zM3IYQFSJ492ZFomJ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151498838"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:42:33 -0700
Message-ID: <b5ac9dcf-60e9-465a-a864-58ff48dcae61@intel.com>
Date: Mon, 9 Jun 2025 13:42:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: cxl: fix typos and improve clarity in
 memory-devices.rst
To: Alok Tiwari <alok.a.tiwari@oracle.com>, gourry@gourry.net,
 rdunlap@infradead.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250609171130.2375901-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250609171130.2375901-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/25 10:10 AM, Alok Tiwari wrote:
> This patch corrects several typographical issues and improves phrasing
> in memory-devices.rst:
> 
> - Fixes duplicate word ("1 one") and adjusts phrasing for clarity.
> - Adds missing hyphen in "on-device".
> - Corrects "a give memory device" to "a given memory device".
> - fix singular/plural "decoder resource" -> "decoder resources".
> - Clarifies "spans to Host Bridges" -> "spans two Host Bridges".
> - change "at a" -> "a"
> 
> These changes improve readability and accuracy of the documentation.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron<jonathan.cameron@huawei.com>

Applied to cxl/next

> ---
> v2->v3
> rebase to v6.16-rc1
> added Reviewed-by: Jonathan Cameron
> v1->v2
> added Reviewed-by Randy Dunlap and Gregory Price
> change "at a" -> "a
> ---
>  Documentation/driver-api/cxl/theory-of-operation.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
> index 40793dad3630..257f513e320c 100644
> --- a/Documentation/driver-api/cxl/theory-of-operation.rst
> +++ b/Documentation/driver-api/cxl/theory-of-operation.rst
> @@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
>  (Linux term for the top of the CXL decode topology). From there, PCIe topology
>  dictates which endpoints can participate in which Host Bridge decode regimes.
>  Each PCIe Switch in the path between the root and an endpoint introduces a point
> -at which the interleave can be split. For example platform firmware may say at a
> -given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
> +at which the interleave can be split. For example, platform firmware may say a
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

