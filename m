Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAA21ABB9;
	Mon,  9 Jun 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486989; cv=none; b=ica5vru1Jvbew2vtob2kIG06CKG9o8If/naJFrhw20VpyJ1P2SMqbq+w1n2RaNEZzRQ3WrKIX9LpLLWN4OOXPfo6OLrQlMJD/cgOwkyuxt7qhpUR/VlUPYwr6og8VifOkQq8Yy4MraGDng+K8WrEkgHffjuMa0YERPrTKF0cQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486989; c=relaxed/simple;
	bh=HBNTnta5vaItgp77f+/A524wlWPv31HjDmu3puJgV9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQgbiIm4lYxfyzzxCF9UV3MCV2GoSdxcLaH1b/OLBcNU66y1eA+4GhCIAjLT7ePQb8ge/+frDsFdkaIfxrljvKGINl5Mmjr6dtsmfWTUrsJZMrWHKgEMsOa5jADIn+6ZILrz1AGl//vLEQ+2JJZ90EAaaQaoEmbDkxUkmSlwLnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2Lyv1WV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2Lyv1WV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749486988; x=1781022988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HBNTnta5vaItgp77f+/A524wlWPv31HjDmu3puJgV9Y=;
  b=H2Lyv1WVQGQFCXnF7SGXRACxe6qyWOZPgsx4lt/vnxmOq2q/qD3AC9TL
   dbM/qlyvf3yEvI1TKJNgePRs8YNy11bOE/UKhFU1jzCHBc/9GBwLGxum9
   q51QAyJ8mMozFovZUu/6fm13nhdvq9nX+4VWi7bsYY2WmMXbE5V9RflIt
   66dyd+H8pB1NEgw+uZPU+X1c4SQgh+JZMTg1TN5Lgn4CQg/dtoDIOPeOX
   88HdS4WI2yGuDtuncikdVq8rdfwOWBKne3V9Dr6duKATuP6WjoAXxYqw2
   Z+dUR6fflPESeHlnZpzEjKNGE9nd9YQeff1SumtqJwFbd9gjBsFnRVxFj
   A==;
X-CSE-ConnectionGUID: wSTesjpxTLeWH/dRCa19NA==
X-CSE-MsgGUID: SdC2E0UAQzqLYJYZPj0a+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55235912"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="55235912"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:36:27 -0700
X-CSE-ConnectionGUID: T/z5oRiUR0KgkjSZU/HAZQ==
X-CSE-MsgGUID: iIrXgy8LTb2uNXxE1nf2cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="177468258"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:36:26 -0700
Message-ID: <019b8728-95d9-44c1-968e-630abd09741e@intel.com>
Date: Mon, 9 Jun 2025 09:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cxl: fix typos and improve clarity in
 memory-devices.rst
To: Alok Tiwari <alok.a.tiwari@oracle.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 corbet@lwn.net, linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
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

Can you please rebase the changes against v6.16-rc1? memory-devices.rst no longer exists.


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

