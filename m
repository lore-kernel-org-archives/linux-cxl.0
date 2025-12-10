Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146523A994;
	Wed, 10 Dec 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381316; cv=none; b=NaJcVBFcFrtnF+AvFHe1KsbpC7ZwYqTH3S/dZpfuNlp2gtllZK87BHHpqQTparqAiWzBbAgiGwEO8y0KASepGCt8EZHdycihj28l5JGFbYTyWBKfHayp4m6mNw68Df9B0z8IQznMkHYVL/iY6aJ5P44ez7E2Jwq6TVktDDmu3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381316; c=relaxed/simple;
	bh=fKnAfbuzs8+R8HHDjN0yx56Qfgqz0erk6/4J/q/XK1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHg509TPnollOSef0HJL6CbLwWIT1wElwgxmvyziCn0n2YWJ9pJsNhq2wfoTEeZq2f3H3UdvYkLCVmk2unqmhtl6hHDjH+MluemZhqeM0kYUTn0gpErO/NzU/AG0pF4xS+Fha6QFGvOj3LXmVQdKzQHDHL7PIC1v/b9gjljrvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+b0WNDe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+b0WNDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765381314; x=1796917314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fKnAfbuzs8+R8HHDjN0yx56Qfgqz0erk6/4J/q/XK1w=;
  b=U+b0WNDemGaRq9o4mjaGpnJHxFFpjHBuXqpn/hqEL5wSuRBfCN/HEZHX
   N74v77h3FDeJhW9VqgwEm0BM5feZddD65ZTMFytyAwZmBgyxGyEHdFcip
   mnsNmXq5Nbal2IhBqVHA5qtWf3Uiq7408Sb6ZKSuYOvIpezDbNrOePq/4
   vQL7KKNkYaPOfMcI4veDH4pfSk7QVnjI0n1BAYAlpWZm9VSm4Z0jTCpAT
   sRJQ+RqXhlFFQ5Ggna2MBBsbz2PYA7nlrRiMxKNbI1/fqr8rC1QQNWhi5
   sWqk+B1wYxrXfd9ff2XuP2I7XExR9yUKMdX3SkwPT4EkuwV4RIwkbn3RT
   g==;
X-CSE-ConnectionGUID: HO/dSRU1QTSvu3e2NB58bA==
X-CSE-MsgGUID: PHfC32kpSWWEr3OwSf8xZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67390882"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="67390882"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 07:41:53 -0800
X-CSE-ConnectionGUID: fXhyqdNfR7CDxF74pR7PTg==
X-CSE-MsgGUID: eG3ogs/HTqqUxPIYLw5L2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="201463203"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.138]) ([10.125.109.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 07:41:52 -0800
Message-ID: <6099f3ab-5b11-4a16-9c00-d717ff11e988@intel.com>
Date: Wed, 10 Dec 2025 08:41:50 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl, doc: Moving conventions in separate files
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
References: <20251209181959.210533-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251209181959.210533-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/9/25 11:19 AM, Robert Richter wrote:
> Moving conventions in separate files.
> 
> Note this patch removes the line to include:: <isonum.txt>. From Jon:
> 
> "This include has been cargo-culted around the docs...the only real
> use of it is to write |copy| rather than ©, but these docs don't even
> do that. It can be taken out."
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
>  * Removed include:: <isonum.txt> line (Jon).
> ---
> ---
>  Documentation/driver-api/cxl/conventions.rst  | 183 +-----------------
>  .../driver-api/cxl/conventions/cxl-lmh.rst    | 135 +++++++++++++
>  .../driver-api/cxl/conventions/template.rst   |  38 ++++
>  3 files changed, 179 insertions(+), 177 deletions(-)
>  create mode 100644 Documentation/driver-api/cxl/conventions/cxl-lmh.rst
>  create mode 100644 Documentation/driver-api/cxl/conventions/template.rst
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index e37336d7b116..53f31a229c8d 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -1,182 +1,11 @@
>  .. SPDX-License-Identifier: GPL-2.0
> -.. include:: <isonum.txt>
>  
> -=======================================
>  Compute Express Link: Linux Conventions
> -=======================================
> +#######################################
>  
> -There exists shipping platforms that bend or break CXL specification
> -expectations. Record the details and the rationale for those deviations.
> -Borrow the ACPI Code First template format to capture the assumptions
> -and tradeoffs such that multiple platform implementations can follow the
> -same convention.
> +.. toctree::
> +   :maxdepth: 1
> +   :caption: Contents
>  
> -<(template) Title>
> -==================
> -
> -Document
> ---------
> -CXL Revision <rev>, Version <ver>
> -
> -License
> --------
> -SPDX-License Identifier: CC-BY-4.0
> -
> -Creator/Contributors
> ---------------------
> -
> -Summary of the Change
> ----------------------
> -
> -<Detail the conflict with the specification and where available the
> -assumptions and tradeoffs taken by the hardware platform.>
> -
> -
> -Benefits of the Change
> -----------------------
> -
> -<Detail what happens if platforms and Linux do not adopt this
> -convention.>
> -
> -References
> -----------
> -
> -Detailed Description of the Change
> -----------------------------------
> -
> -<Propose spec language that corrects the conflict.>
> -
> -
> -Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
> -============================================================================
> -
> -Document
> ---------
> -
> -CXL Revision 3.2, Version 1.0
> -
> -License
> --------
> -
> -SPDX-License Identifier: CC-BY-4.0
> -
> -Creator/Contributors
> ---------------------
> -
> -- Fabio M. De Francesco, Intel
> -- Dan J. Williams, Intel
> -- Mahesh Natu, Intel
> -
> -Summary of the Change
> ----------------------
> -
> -According to the current Compute Express Link (CXL) Specifications (Revision
> -3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
> -or more Host Physical Address (HPA) windows associated with each CXL Host
> -Bridge. Each window represents a contiguous HPA range that may be interleaved
> -across one or more targets, including CXL Host Bridges. Each window has a set
> -of restrictions that govern its usage. It is the Operating System-directed
> -configuration and Power Management (OSPM) responsibility to utilize each window
> -for the specified use.
> -
> -Table 9-22 of the current CXL Specifications states that the Window Size field
> -contains the total number of consecutive bytes of HPA this window describes.
> -This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
> -
> -Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
> -memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
> -the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
> -
> -The HPA represents the actual physical memory address space that the CXL devices
> -can decode and respond to, while the System Physical Address (SPA), a related
> -but distinct concept, represents the system-visible address space that users can
> -direct transaction to and so it excludes reserved regions.
> -
> -BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
> -with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
> -resulting in lost capacity in the Endpoints with no SPA to map to that part of
> -the HPA range that intersects the hole.
> -
> -E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB:
> -
> - +--------+------------+-------------------+------------------+-------------------+------+
> - | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
> - +========+============+===================+==================+===================+======+
> - |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
> - +--------+------------+-------------------+------------------+-------------------+------+
> - |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
> - +--------+------------+-------------------+------------------+-------------------+------+
> -
> -HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
> -a 12 ways region and all the intermediate Switch Decoders. They are configured
> -by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
> -3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Root
> -Decoder HPA range that results smaller (2GB) than that of the Switch and
> -Endpoint Decoders in the hierarchy (3GB).
> -
> -This creates 2 issues which lead to a failure to construct a region:
> -
> -1) A mismatch in region size between root and any HDM decoder. The root decoders
> -   will always be smaller due to the trim.
> -
> -2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
> -
> -This change allows a region with a base address of 0GB to bypass these checks to
> -allow for region creation with the trimmed root decoder address range.
> -
> -This change does not allow for any other arbitrary region to violate these
> -checks - it is intended exclusively to enable x86 platforms which map CXL memory
> -under 4GB.
> -
> -Despite the HDM decoders covering the PCIE hole HPA region, it is expected that
> -the platform will never route address accesses to the CXL complex because the
> -root decoder only covers the trimmed region (which excludes this). This is
> -outside the ability of Linux to enforce.
> -
> -On the example platform, only the first 2GB will be potentially usable, but
> -Linux, aiming to adhere to the current specifications, fails to construct
> -Regions and attach Endpoint and intermediate Switch Decoders to them.
> -
> -There are several points of failure that due to the expectation that the Root
> -Decoder HPA size, that is equal to the CFMWS from which it is configured, has
> -to be greater or equal to the matching Switch and Endpoint HDM Decoders.
> -
> -In order to succeed with construction and attachment, Linux must construct a
> -Region with Root Decoder HPA range size, and then attach to that all the
> -intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
> -regardless of their range sizes.
> -
> -Benefits of the Change
> -----------------------
> -
> -Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
> -Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
> -with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
> -
> -This change allows the OSPM to construct Regions and attach intermediate Switch
> -and Endpoint Decoders to them, so that the addressable part of the memory
> -devices total capacity is made available to the users.
> -
> -References
> -----------
> -
> -Compute Express Link Specification Revision 3.2, Version 1.0
> -<https://www.computeexpresslink.org/>
> -
> -Detailed Description of the Change
> -----------------------------------
> -
> -The description of the Window Size field in table 9-22 needs to account for
> -platforms with Low Memory Holes, where SPA ranges might be subsets of the
> -endpoints HPA. Therefore, it has to be changed to the following:
> -
> -"The total number of consecutive bytes of HPA this window represents. This value
> -shall be a multiple of NIW * 256 MB.
> -
> -On platforms that reserve physical addresses below 4 GB, such as the Low Memory
> -Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
> -have a size that doesn't align with the NIW * 256 MB constraint.
> -
> -Note that the matching intermediate Switch Decoders and the Endpoint Decoders
> -HPA range sizes must still align to the above-mentioned rule, but the memory
> -capacity that exceeds the CFMWS window size won't be accessible.".
> +   conventions/cxl-lmh.rst
> +   conventions/template.rst
> diff --git a/Documentation/driver-api/cxl/conventions/cxl-lmh.rst b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
> new file mode 100644
> index 000000000000..baece5c35345
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
> @@ -0,0 +1,135 @@
> +.. SPDX-License-Identifier: GPL-2.0
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
> +across one or more targets, including CXL Host Bridges. Each window has a set
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
> +E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB:
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
> +a 12 ways region and all the intermediate Switch Decoders. They are configured
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
> +root decoder only covers the trimmed region (which excludes this). This is
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
> diff --git a/Documentation/driver-api/cxl/conventions/template.rst b/Documentation/driver-api/cxl/conventions/template.rst
> new file mode 100644
> index 000000000000..39a9ca87cf92
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/conventions/template.rst
> @@ -0,0 +1,38 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. :: Template Title here:
> +
> +Template File
> +=============
> +
> +Document
> +--------
> +CXL Revision <rev>, Version <ver>
> +
> +License
> +-------
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Summary of the Change
> +---------------------
> +
> +<Detail the conflict with the specification and where available the
> +assumptions and tradeoffs taken by the hardware platform.>
> +
> +
> +Benefits of the Change
> +----------------------
> +
> +<Detail what happens if platforms and Linux do not adopt this
> +convention.>
> +
> +References
> +----------
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +<Propose spec language that corrects the conflict.>
> 
> base-commit: 9d887fa9036f64331038b48199ae07da89777160

