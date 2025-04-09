Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C649215798
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240822; cv=none; b=Xq6J/880+GifxgNJZbhgm97KgaSn6/3hsz0sQ/bq3hTmKD/Bue2qAhhlP0Zi78WtQg4+Tnngz4sYv1IvxeM6yvRSi6b/N9FQxKT94KJweKIMee11GwM5qgQoExK6nXK+Zd8y2dYGNs6IwUttqAp6ZzdoPzJx1MlgH6jX2DKirAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240822; c=relaxed/simple;
	bh=GVWitFk4KsMJvGglvirpiiflNudOsRU+lR11DCZxC84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4LgVEZQx3RtOV8yOPAEBToXL1oPmEYu/OtTJQao0jfuqCTaMUdpYMocd6qFRFiuiWCJSQyrgu5Qo+hZVCpUV/4iP1MmlXDqpeSx2+vzub43TfDavjHz669hvwSOABZrdaOxsANFnkbZR8qBN6LKYN9FI9Ky+OCJVE1pLWF4Aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGuNqoBk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGuNqoBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744240821; x=1775776821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GVWitFk4KsMJvGglvirpiiflNudOsRU+lR11DCZxC84=;
  b=aGuNqoBkaK0Oib9+l6Gu+ErQzB4ucKEU5K5SZgUMn+J/P6eNceQOMVG7
   TvBmIM+LYjiYXUvtmUAEB6YSlMf/TXRFrHRbufdfjHyWc5rDCz5M8/VsH
   v68+V61h1+N6H/B3GKtdeuvIn4jErPOJDy3SWioOJrxIryPO3gaxvHQVU
   BxRXsTfDNKZvRM4Mf5qBCr2ubIeE9aIV2KtsVqCjEPVDdIclsXv+NX2kn
   NZfJT2mPO70NmKyrOfrk+Z7p7nzFml6aTiSgWMS09mpPBslH+vn7u1Or5
   tgdNAwTN1+0ZPr3uWsraMjsByNDSuZLANIa17mcrJfiWGeIt/E5HsX11z
   w==;
X-CSE-ConnectionGUID: s7DcokTiSM65fHPjc4NNYg==
X-CSE-MsgGUID: 2+qqzzPDSAWizk+7Mdkr7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45632305"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45632305"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 16:20:19 -0700
X-CSE-ConnectionGUID: 8nNNDO+vSSy8R55OZ8IVbQ==
X-CSE-MsgGUID: LHWB0P7yR+G6fqJiDtX47A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="132863666"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 16:20:17 -0700
Message-ID: <6e371233-b3a5-405a-9eb7-02b1b9c1ba24@intel.com>
Date: Wed, 9 Apr 2025 16:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Update the CXL Maturity Map
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250409230933.348045-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250409230933.348045-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/25 4:09 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> How about an update to reflect all your recent goodness and updated
> intentions?
> 
> I see DavidL updated along with his patches :)
> 
> I made a couple of changes and am including the entire file in
> the patch for your review convenience.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/driver-api/cxl/maturity-map.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index a2288f9df658..94be52d623b8 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -1,202 +1,202 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  .. include:: <isonum.txt>
>  
>  ===========================================
>  Compute Express Link Subsystem Maturity Map
>  ===========================================
>  
>  The Linux CXL subsystem tracks the dynamic `CXL specification
>  <https://computeexpresslink.org/cxl-specification-landing-page>`_ that
>  continues to respond to new use cases with new features, capability
>  updates and fixes. At any given point some aspects of the subsystem are
>  more mature than others. While the periodic pull requests summarize the
>  `work being incorporated each merge window
>  <https://lore.kernel.org/linux-cxl/?q=s%3APULL+s%3ACXL+tc%3Atorvalds+NOT+s%3ARe>`_,
>  those do not always convey progress relative to a starting point and a
>  future end goal.
>  
>  What follows is a coarse breakdown of the subsystem's major
>  responsibilities along with a maturity score. The expectation is that
>  the change-history of this document provides an overview summary of the
>  subsystem maturation over time.
>  
>  The maturity scores are:
>  
>  - [3] Mature: Work in this area is complete and no changes on the horizon.
>    Note that this score can regress from one kernel release to the next
>    based on new test results or end user reports.
>  
>  - [2] Stabilizing: Major functionality operational, common cases are
>    mature, but known corner cases are still a work in progress.
>  
>  - [1] Initial: Capability that has exited the Proof of Concept phase, but
>    may still have significant gaps to close and fixes to apply as real
>    world testing occurs.
>  
>  - [0] Known gap: Feature is on a medium to long term horizon to
>    implement.  If the specification has a feature that does not even have
>    a '0' score in this document, there is a good chance that no one in
>    the linux-cxl@vger.kernel.org community has started to look at it.
>  
>  - X: Out of scope for kernel enabling, or kernel enabling not required
>  
>  Feature and Capabilities
>  ========================
>  
>  Enumeration / Provisioning
>  --------------------------
>  All of the fundamental enumeration an object model of the subsystem is
>  in place, but there are several corner cases that are pending closure.
>  
>  
>  * [2] CXL Window Enumeration
>  
> -  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
> +  * [3] :ref:`Extended-linear memory-side cache <extended-linear>`

I think 2? May be issues if there is memory hole.

DJ

>    * [0] Low Memory-hole
> -  * [0] Hetero-interleave
> +  * [X] Hetero-interleave
>  
>  * [2] Switch Enumeration
>  
>    * [0] CXL register enumeration link-up dependency
>  
>  * [2] HDM Decoder Configuration
>  
>    * [0] Decoder target and granularity constraints
>  
>  * [2] Performance enumeration
>  
>    * [3] Endpoint CDAT
>    * [3] Switch CDAT
>    * [1] CDAT to Core-mm integration
>  
>      * [1] x86
>      * [0] Arm64
>      * [0] All other arch.
>  
>    * [0] Shared link
>  
>  * [2] Hotplug
>    (see CXL Window Enumeration)
>  
>    * [0] Handle Soft Reserved conflicts
>  
>  * [0] :ref:`RCH link status <rch-link-status>`
>  * [0] Fabrics / G-FAM (chapter 7)
>  * [0] Global Access Endpoint
>  
>  
>  RAS
>  ---
>  In many ways CXL can be seen as a standardization of what would normally
>  be handled by custom EDAC drivers. The open development here is
>  mainly caused by the enumeration corner cases above.
>  
>  * [3] Component events (OS)
>  * [2] Component events (FFM)
>  * [1] Endpoint protocol errors (OS)
>  * [1] Endpoint protocol errors (FFM)
>  * [0] Switch protocol errors (OS)
>  * [1] Switch protocol errors (FFM)
>  * [2] DPA->HPA Address translation
>  
>      * [1] XOR Interleave translation
>        (see CXL Window Enumeration)
>  
>  * [1] Memory Failure coordination
>  * [0] Scrub control
>  * [2] ACPI error injection EINJ
>  
>    * [0] EINJ v2
>    * [X] Compliance DOE
>  
>  * [2] Native error injection
>  * [3] RCH error handling
>  * [1] VH error handling
>  * [0] PPR
>  * [0] Sparing
>  * [0] Device built in test
>  
>  
>  Mailbox commands
>  ----------------
>  
>  * [3] Firmware update
>  * [3] Health / Alerts
>  * [1] :ref:`Background commands <background-commands>`
>  * [3] Sanitization
>  * [3] Security commands
>  * [3] RAW Command Debug Passthrough
>  * [0] CEL-only-validation Passthrough
>  * [0] Switch CCI
>  * [3] Timestamp
>  * [1] PMEM labels
>  * [3] PMEM GPF / Dirty Shutdown
>  * [0] Scan Media
>  
>  PMU
>  ---
>  * [1] Type 3 PMU
>  * [0] Switch USP/ DSP, Root Port
>  
>  Security
>  --------
>  
>  * [X] CXL Trusted Execution Environment Security Protocol (TSP)
>  * [X] CXL IDE (subsumed by TSP)
>  
>  Memory-pooling
>  --------------
>  
>  * [1] Hotplug of LDs (via PCI hotplug)
>  * [0] Dynamic Capacity Device (DCD) Support
>  
>  Multi-host sharing
>  ------------------
>  
>  * [0] Hardware coherent shared memory
>  * [0] Software managed coherency shared memory
>  
>  Multi-host memory
>  -----------------
>  
>  * [0] Dynamic Capacity Device Support
>  * [0] Sharing
>  
>  Accelerator
>  -----------
>  
>  * [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
>  * [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
>  * [0] CXL.cache 68b (CXL 2.0)
>  * [0] CXL.cache 256b Cache IDs (CXL 3.0)
>  
>  User Flow Support
>  -----------------
>  
> -* [0] HPA->DPA Address translation (need xormaps export solution)
> +* [0] Inject & clear poison by HPA
>  
>  Details
>  =======
>  
>  .. _extended-linear:
>  
>  * **Extended-linear memory-side cache**: An HMAT proposal to enumerate the presence of a
>    memory-side cache where the cache capacity extends the SRAT address
>    range capacity. `See the ECN
>    <https://lore.kernel.org/linux-cxl/6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch/>`_
>    for more details:
>  
>  .. _rch-link-status:
>  
>  * **RCH Link Status**: RCH (Restricted CXL Host) topologies, end up
>    hiding some standard registers like PCIe Link Status / Capabilities in
>    the CXL RCRB (Root Complex Register Block).
>  
>  .. _background-commands:
>  
>  * **Background commands**: The CXL background command mechanism is
>    awkward as the single slot is monopolized potentially indefinitely by
>    various commands. A `cancel on conflict
>    <http://lore.kernel.org/r/66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch>`_
>    facility is needed to make sure the kernel can ensure forward progress
>    of priority commands.

