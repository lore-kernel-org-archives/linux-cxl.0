Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BC301703;
	Tue, 16 Sep 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041406; cv=none; b=OPmehgbaeLrAVtyGOH1EsRWe6OpZ3Y90Arg9AOXKclpdS9Ty/djzyJlZnf0jwghAVsgvAzKB4I46NBD/BRcAoTF6kuj6PI+CrJoSHVgIM94SkYtD2Nag2rmzQNDOw/rsl4y6Y75KE0+zbvg+CbnIXXpHYIvu3FE2NxBpFZMtd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041406; c=relaxed/simple;
	bh=WQW74fvVuaki22ep9T+b8x6c1/eKNstI6ZzLI1AUhnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRH5OlW3LRbacpv4wIX7zkMLO3r9VgQI0B9RbcLzaqmM5YQ2qPXIuMVjqIY3pKWvnhKRk9LldDYmjzTzpV1yVt0yxlb4vmZ6eb5X6Pk7fTwvVhfT7u192++p4E40GFx6bVddq1M2bAEfFYt013tqqibz0Y+ATvhkzJK7luInzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlYO3dzM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlYO3dzM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758041404; x=1789577404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WQW74fvVuaki22ep9T+b8x6c1/eKNstI6ZzLI1AUhnI=;
  b=UlYO3dzMKpuognpx/H7j21AhMI8URHGCkkgbeynXqHQumHm/fLC4URSo
   q6DbCO9hPe0EO0EYCwjs7fw9f+w+m20r+UGi1fMiakAEN9vbLVYHtN359
   y6vrqGgxg574CNj+u4XWSH81isulHx5XuL5KChEuhXAqzyoJ6zdI4jcwB
   yuVWmS7Hs9OOqMu8OFHOdpWMX+oP6GpIg/7xHqwhDDXZ+a+4CjzRVO2jt
   OmF6GaaVmNJwFuET/Dca9fE5ESL6dwwLiPK7PH0JkNdGQCUqEdHpW/qEd
   w24psN7AhlSxDh3Ehc/MHo+TIYO6IHko5QTRxrYEZ+IovIZngYNdpOlfX
   w==;
X-CSE-ConnectionGUID: f6U4qjCRQVK+E5JOFwyfEQ==
X-CSE-MsgGUID: Xs2AewOSRrSK1flVwSAU4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60246253"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60246253"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:50:03 -0700
X-CSE-ConnectionGUID: pKJ/5TWZRY2hZPBvoHIlgw==
X-CSE-MsgGUID: N8L0NTtgTfusU4KLyFLNtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174555344"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.174]) ([10.125.111.174])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:50:02 -0700
Message-ID: <7c7b8c26-e9b8-43aa-965b-47532d52524c@intel.com>
Date: Tue, 16 Sep 2025 09:50:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, Low memory Holes, Decoders
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, Randy Dunlap
 <rdunlap@infradead.org>, Gregory Price <gourry@gourry.net>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Robert Richter <rrichter@amd.com>
References: <20250915145810.16872-1-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250915145810.16872-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/15/25 7:57 AM, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
> Decoders.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Applied to cxl/next with updates from various commenters.
c5dca38633daa1e240144bac453cf9065604a413

> ---
> 
> v5 -> v6: Extend "Summary of The Change" with detailed explanation about
> 	  the mismatch between the Root and the other HDM Decoders HPA
> 	  range sizes (Gregory)
> 	  Clarify that this change is exclusively intended to enable x86
> 	  platforms which map CXL memory under 4GB (Gregory)
> 
> v4 -> v5: Fix grammar and syntactic errors (Dave)
> 	  Spell out CXL, OSPM, on first use (Dave)
> 	  Rewrite a few sentences for better clarity (Dave)
> 	  Talk about SPA vs HPA and SPA's relationship to CFMWS (Dave)
> 	  Adjust a table for htmldocs output (Bagas)
> 	  Use bullet list (Bagas)
> 	  Correct the CFMWS[1] HPA range to not overlap CFMWS[0] (Robert)
> 	  Correct the CFMWS[1] HPA range to the NIW*256MB rule (Robert)
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
>  Documentation/driver-api/cxl/conventions.rst | 135 +++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index da347a81a237..6bce7c614fff 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,138 @@ Detailed Description of the Change
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
> +- Fabio M. De Francesco, Intel
> +- Dan J. Williams, Intel
> +- Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current Compute Express Link (CXL) Specifications (Revision
> +3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
> +or more Host Physical Address (HPA) windows associated with each CXL Host
> +Bridge. Each window represents a contiguous HPA range that may be interleaved
> +across one or more targets, including CXL Host Bridges.  Each window has a set
> +of restrictions that govern its usage. It is the Operating System-directed
> +configuration and Power Management (OSPM) responsibility to utilize each window
> +for the specified use.
> +
> +Table 9-22 of the current CXL Specifications states that the Window Size field
> +contains the total number of consecutive bytes of HPA this window describes.
> +This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
> +
> +Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
> +memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
> +the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
> +
> +The HPA represents the actual physical memory address space that the CXL devices
> +can decode and respond to, while the System Physical Address (SPA), a related
> +but distinct concept, represents the system-visible address space that users can
> +direct transaction to and so it excludes reserved regions.
> +
> +BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
> +with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
> +resulting in lost capacity in the Endpoints with no SPA to map to that part of
> +the HPA range that intersects the hole.
> +
> +E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB::
> +
> + +--------+------------+-------------------+------------------+-------------------+------+
> + | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
> + +========+============+===================+==================+===================+======+
> + |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
> + +--------+------------+-------------------+------------------+-------------------+------+
> + |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
> + +--------+------------+-------------------+------------------+-------------------+------+
> +
> +HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
> +a 12 ways region and all the intermediate Switch Decoders.  They are configured
> +by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
> +3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Root
> +Decoder HPA range that results smaller (2GB) than that of the Switch and
> +Endpoint Decoders in the hierarchy (3GB).
> +
> +This creates 2 issues which lead to a failure to construct a region:
> +
> +1) A mismatch in region size between root and any HDM decoder. The root decoders
> +   will always be smaller due to the trim.
> +
> +2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
> +
> +This change allows a region with a base address of 0GB to bypass these checks to
> +allow for region creation with the trimmed root decoder address range.
> +
> +This change does not allow for any other arbitrary region to violate these
> +checks - it is intended exclusively to enable x86 platforms which map CXL memory
> +under 4GB.
> +
> +Despite the HDM decoders covering the PCIE hole HPA region, it is expected that
> +the platform will never route address accesses to the CXL complex because the
> +root decoder only covers the trimmed region (which excludes this).  This is
> +outside the ability of Linux to enforce.
> +
> +On the example platform, only the first 2GB will be potentially usable, but
> +Linux, aiming to adhere to the current specifications, fails to construct
> +Regions and attach Endpoint and intermediate Switch Decoders to them.
> +
> +There are several points of failure that due to the expectation that the Root
> +Decoder HPA size, that is equal to the CFMWS from which it is configured, has
> +to be greater or equal to the matching Switch and Endpoint HDM Decoders.
> +
> +In order to succeed with construction and attachment, Linux must construct a
> +Region with Root Decoder HPA range size, and then attach to that all the
> +intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
> +regardless of their range sizes.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
> +Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
> +with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
> +
> +This change allows the OSPM to construct Regions and attach intermediate Switch
> +and Endpoint Decoders to them, so that the addressable part of the memory
> +devices total capacity is made available to the users.
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
> +The description of the Window Size field in table 9-22 needs to account for
> +platforms with Low Memory Holes, where SPA ranges might be subsets of the
> +endpoints HPA. Therefore, it has to be changed to the following:
> +
> +"The total number of consecutive bytes of HPA this window represents. This value
> +shall be a multiple of NIW * 256 MB.
> +
> +On platforms that reserve physical addresses below 4 GB, such as the Low Memory
> +Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
> +have a size that doesn't align with the NIW * 256 MB constraint.
> +
> +Note that the matching intermediate Switch Decoders and the Endpoint Decoders
> +HPA range sizes must still align to the above-mentioned rule, but the memory
> +capacity that exceeds the CFMWS window size won't be accessible.".

