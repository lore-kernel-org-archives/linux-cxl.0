Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D21D514E;
	Thu, 21 Aug 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789744; cv=none; b=Wi5J9O0Q+Lgs8ZkOPZD3J+juxXD61JwQw+ysXHRwDAl2NY/1Ph80MOTU1EslZM3qiCLlhq5z1rKh0Tw8ShBIxbRzgo0X+X8wCz/suDjUbg2ARtMQX0PR6LtX+CCBbgRMZ0dUQ6WlZXq5dou65gNdizatrC6l7YZi+4ogPrgsByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789744; c=relaxed/simple;
	bh=VtTr2SVRL4i+FTsr/DVLv0FTkigsN48T7SWDWB9wZQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3AISqQo+rxT6RQdiFEV0DPc2KZlT7IPpsTplClZIA8KZbU/FBm1Y6gcoH96OKt4y3+APAvPb/r6VkIKiLrXM3b4Hk6CzFE3pdNJgbc4b/WSjYu403WNCqdE+Drv5uuVWScdPfWY0buJ8KevCWdk/vQIr3EBnFMAq4QzPmYq0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llrVGzr6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llrVGzr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755789743; x=1787325743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VtTr2SVRL4i+FTsr/DVLv0FTkigsN48T7SWDWB9wZQs=;
  b=llrVGzr6dTgIa5s0wQ58KDduRmjLHYg9NTrYac8BQt7ednBemK6Urv44
   6PoB58Se2oFBGB4I/EOGfmcqrri5BHWkdAPTeEQcIp55kr0x1mdWFyI3F
   +qMg9g8MNz0szmEehHg+q+nb7QP30bjts7fdtBBTfCGILokCJUpKrYc8R
   cJju2DaXgZkiwWyM7Tkj/dsQI53elmHpINcUScq+3dqLXKO3FbEObJI1X
   aRBxbn7BNzMABoBCeWYrMjIkBvuaxtDZg6nwKmktAcle5KIWIKsSOh2I+
   7fK7EaasdhKT8JRm4WeH+K7OLEO6YbG+GZbHfgdByNp74IJsVZWDANIEc
   A==;
X-CSE-ConnectionGUID: qXGZ8MTITAyguECTvwsllw==
X-CSE-MsgGUID: i+ZwZg4MQniFkp+Zt2SsxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58230547"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58230547"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:22:23 -0700
X-CSE-ConnectionGUID: Vm0etokJSPadRKHCemNoGA==
X-CSE-MsgGUID: WDOcFvIbQAeVtQe3qvFurA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167948034"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.210]) ([10.247.119.210])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:22:15 -0700
Message-ID: <37e0f2c0-a071-4e81-969c-af58a63fdfa9@intel.com>
Date: Thu, 21 Aug 2025 08:22:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, LMH, Decoders
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, Randy Dunlap
 <rdunlap@infradead.org>, Gregory Price <gourry@gourry.net>
References: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/20/25 8:06 AM, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
> Decoders.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
> 	  Switch and Endpoint Decoders match and attach Regions in
> 	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
> 	  Remove a wrong argument about large interleaves (Jonathan)
> 
> v2 -> v3: Rework a few phrases for better clarity.
> 	  Fix grammar and syntactic errors (Randy, Alok).
> 	  Fix semantic errors ("size does not comply", Alok).
> 	  Fix technical errors ("decoder's total memory?", Alok).
> 	  
> v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
> 
>  Documentation/driver-api/cxl/conventions.rst | 111 +++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index da347a81a237..714240ed2e04 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,114 @@ Detailed Description of the Change
>  ----------------------------------
>  
>  <Propose spec language that corrects the conflict.>
> +
> +
> +Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
> +============================================================================
> +
> +Document
> +--------
> +
> +CXL Revision 3.2, Version 1.0
> +
> +License
> +-------
> +
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Fabio M. De Francesco, Intel
> +Dan J. Williams, Intel
> +Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current CXL Specifications (Revision 3.2, Version 1.0),

spell out CXL on first use

> +the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> +Physical Address (HPA) windows associated with each CXL Host Bridge. Each
> +window represents a contiguous HPA range that may be interleaved across
> +one or more targets, including CXL Host Bridges. Each window has a set of
> +restrictions that govern its usage. It is the OSPM’s responsibility to

spell out OSPM on first use.

> +utilize each window for the specified use.
> +
> +Table 9-22 states the Window Size field contains the total number of
> +consecutive bytes of HPA this window represents. This value must be a
> +multiple of the Number of Interleave Ways * 256 MB.
> +
> +Platform Firmware (BIOS) might reserve physical addresses below 4 GB,
> +such as the Low Memory Hole for PCIe MMIO. In such cases, the CFMWS Range

Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
memory gap such as the Low Memory Hole for PCIe MMIO may exist. 

> +Size may not adhere to the NIW * 256 MB rule.
> +
> +On these systems, BIOS publishes CFMWS to communicate the active System
> +Physical Address (SPA) ranges that map to a subset of the Host Physical
> +Address (HPA) ranges. The SPA range trims out the hole, resulting in lost

So in the first paragraph, HPA is said to be described by CFMWS. But here a
brand new term SPA is introduced. I think you may need a paragraph above this
to talk about SPA vs HPA and SPA's relationship to CFMWS. Otherwise I think unless
the reader is knowledgeable all this, it is very confusing.

> +capacity in the endpoint with no SPA to map to the CXL HPA range that
> +exceeds the matching CFMWS range.
> +
> +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> +starting at 2 GB:
> +
> +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
> +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256
> +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256
> +
> +HDM decoder base and HDM decoder size represent all the 12 Endpoint
> +Decoders of a 12 way region and all the intermediate Switch Decoders.
> +They are configured by the BIOS according to the NIW * 256MB rule,
> +resulting in a HPA range size of 3GB.
> +
> +The CFMWS Base and CFMWS Size are used to configure the Root Decoder HPA
> +range base and size. CFMWS cannot intersect Memory Holes, then the CFMWS[0]
> +size is smaller (2GB) than that of the Switch and Endpoint Decoders that
> +make the hierarchy (3GB).
> +
> +On that platform, only the first 2GB will be potentially usable but,
> +because of the current specs, Linux fails to make them available to the
> +users. The driver expects that Root Decoder HPA size, which is equal to
> +the CFMWS from which it is configured, to be greater or equal to the
> +matching Switch and Endpoint HDM Decoders.
> +
> +The CXL driver fails to construct Regions and to attach Endpoint and
> +intermediate Switch Decoders to those Regions after their construction.
> +
> +In order to succeed with Region construction and Decoders attachment,
> +Linux must construct Regions with Root Decoders size, and then attach to

'a Region' and 'Root Decoder'?

> +them all the intermediate Switch and Endpoint Decoders that are part of the
> +hierarchy, even though the Decoders HPA range sizes may be larger than
> +those Regions whose sizes are trimmed by Low Memory Holes.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without this change, the OSPM wouldn't match Intermediate and Endpoint

s/Without this change,/Without the change/

> +Decoders with Root Decoders configured with CFMWS HPA sizes that don't
> +align with the NIW * 256MB constraint, leading to lost memdev capacity.

s/, leading/and leads to/

DJ

> +This change allows the OSPM to construct Regions and attach Intermediate
> +Switch and Endpoint Decoders to them, so that the addressable part of the
> +memory devices total capacity is not lost.
> +
> +References
> +----------
> +
> +Compute Express Link Specification Revision 3.2, Version 1.0
> +<https://www.computeexpresslink.org/>
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +The description of the Window Size field in table 9-22 needs to account
> +for platforms with Low Memory Holes, where SPA ranges might be subsets of
> +the endpoints' HPA. Therefore, it has to be changed to the following:
> +
> +"The total number of consecutive bytes of HPA this window represents.
> +This value shall be a multiple of NIW * 256 MB. On platforms that reserve
> +physical addresses below 4 GB, such as the Low Memory Hole for PCIe MMIO
> +on x86 or a requirement for greater than 8-way interleave CXL Regions
> +starting at address 0, an instance of CFMWS whose Base HPA is 0 might have
> +a window size that doesn't align with the NIW * 256 MB constraint. Note
> +that the matching intermediate Switch and Endpoint Decoders' HPA range
> +sizes must still align to the above-mentioned rule, but the memory capacity
> +that exceeds the CFMWS window size will not be accessible."

