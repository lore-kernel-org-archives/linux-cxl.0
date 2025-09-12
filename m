Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0E1A9FA7;
	Fri, 12 Sep 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691941; cv=none; b=Oumq2pNIpgUNL0oNeXBBz/pKV5xLlu//aZBPQ8RbW1nr7VE57zkBgT/yyCikqMUlDQojSj5iX+9rzzNjcAVg41Wn2u4R/4DEnCSGBb3ZkD/dRaVwSx9TFxieK8Cixaj1CWvEttSrsYZa5xs6LIMuLG52BL4A8qk6uCwanpPKqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691941; c=relaxed/simple;
	bh=dbL50UAywLeOhXUJssuYWQB8CYJsgSGLuYFU5uusmC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2w/iXbv9DEc8rCo6AqKoSTpa6Jna+nTDUqw+W9cTSjb4WNgL3pVTVcCLDuz7jlOV8BCKjUMXksvmLFvI6ViTsbxlfaRmyS9Lp3J1EUJPyqr0h1yaWokRZxukmVv+XHrcElpitFAL+ZI5l62buXYFdAMFrNrV6TpSa4d5/2xlXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI0UVJRB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI0UVJRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757691940; x=1789227940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dbL50UAywLeOhXUJssuYWQB8CYJsgSGLuYFU5uusmC8=;
  b=KI0UVJRB+ADMAmLmBGTK+5YYsBwJTtitgxBY9wTP0Ugt1xzpoQ61W9/g
   x+BmdyU4wgYAjjd3bogKCPdfW1knzi41hAAgIL1ay/RyBHaYS1Jnt5GHv
   3GhUT34HY09nwcfOEkejq3vdQsL82bbR2teAG6GOEYciPdp1nhDL8yKtA
   P2UochA0jq1Zlm3INtg9xdBA0x6at0zcH9nZCagG3duAHerEWxSeh4jF5
   /AX01hdOAUrgBQhulAbIRgO8c4HYgmxOtIH5fpUCkbBZlmFeZL0YaP6r1
   yeumHx2mUAAiHnSBGjisa3VmYkzxZddZzoCd6mqJ1s//HBQGSx5dPqeKJ
   Q==;
X-CSE-ConnectionGUID: MyW274azS4yxdwpmPKKiAQ==
X-CSE-MsgGUID: 5kLoAQMaSCGhn0Q7moRBEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60114067"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="60114067"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:45:39 -0700
X-CSE-ConnectionGUID: LxwyJiQ8QvC5GkEhRGVXDQ==
X-CSE-MsgGUID: L8+nJ55FTkGLPEnFRJOCvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="197687882"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:45:38 -0700
Message-ID: <792caf42-ccc7-4ef5-963b-7c0f9ec765d6@intel.com>
Date: Fri, 12 Sep 2025 08:45:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 7:45 AM, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. This is another new appoach in
> response to earlier attempts to implement CXL address translation:
> 
>  * v1: [1] and the comments on it, esp. Dan's [2],
>  * v2: [3] and comments on [4], esp. Dave's [5]
> 
> This version 3 addresses the requests to reduce the number of patches
> to a minimum and also to remove platform specific implementations
> allowing the Documentation of CXL Address Translation Support in the
> Kernel's "Compute Express Link: Linux Conventions" document and an
> update of the CXL specification in the longterm. This patch submission
> will be the base for a documention patch that describes CXL Address
> Translation support accordingly. The documentation patch will be sent
> in the very next step.
> 
> The CXL driver currently does not implement address translation which
> assumes the host physical addresses (HPA) and system physical
> addresses (SPA) are equal.
> 
> Systems with different HPA and SPA addresses need address translation.
> If this is the case, the hardware addresses esp. used in the HDM
> decoder configurations are different to the system's or parent port
> address ranges. E.g. AMD Zen5 systems may be configured to use
> 'Normalized addresses'. Then, CXL endpoints have their own physical
> address base which is not the same as the SPA used by the CXL host
> bridge. Thus, addresses need to be translated from the endpoint's to
> its CXL host bridge's address range.
> 
> To enable address translation, the endpoint's HPA range must be
> translated to the CXL host bridge's address range. A callback is
> introduced to translate a decoder's HPA to the next parent port's
> address range. This allows the enablement of address translation for
> individual ports as needed. The callback is then used to determine the
> region parameters which includes the SPA translated address range of
> the endpoint decoder and the interleaving configuration. This is
> stored in struct cxl_region which allows an endpoint decoder to
> determine that parameters based on its assigned region.
> 
> Note that only auto-discovery of decoders is supported. Thus, decoders
> are locked and cannot be configured manually.

Hi Robert, thanks for reworking this.

What happens with the manual configured path if only auto-discovery is supported? Things don't work? It works with no translation needed? Platform will lock all decoders and not allow manual configuration for CXL devices?

DJ

> 
> Finally, Zen5 address translation is enabled using ACPI PRMT.
> 
> This series bases on cxl/next.
> 
> V3:
>  * rebased onto cxl/next,
>  * complete rework to reduce number of required changes/patches and to
>    remove platform specific code (Dan and Dave),
>  * changed implementation allowing to add address translation to the
>    CXL specification (documention patch in preparation),
>  * simplified and generalized determination of interleaving
>    parameters using the address translation callback,
>  * depend only on the existence of the ACPI PRM GUID for CXL Address
>    Translation enablement, removed platform checks,
>  * small changes to region code only which does not require a full
>    rework and refactoring of the code, just separating region
>    parameter setup and region construction,
>  * moved code to new core/atl.c file,
>  * fixed subsys_initcall order dependency of EFI runtime services
>    (Gregory and Joshua),
> 
> V2:
>  * rebased onto cxl/next,
>  * split of v1 in two parts:
>    * removed cleanups and updates from this series to post them as a
>      separate series (Dave),
>    * this part 2 applies on top of part 1, v3,
>  * added tags to SOB chain,
>  * reworked architecture, vendor and platform setup (Jonathan):
>    * added patch "cxl/x86: Prepare for architectural platform setup",
>    * added function arch_cxl_port_platform_setup() plus a __weak
>      versions for archs other than x86,
>    * moved code to core/x86,
>  * added comment to cxl_to_hpa_fn (Ben),
>  * updated year in copyright statement (Ben),
>  * cxl_port_calc_hpa(): Removed HPA check for zero (Jonathan), return
>    1 if modified,
>  * cxl_port_calc_pos(): Updated description and wording (Ben),
>  * added sereral patches around interleaving and SPA calculation in
>    cxl_endpoint_decoder_initialize(),
>  * reworked iterator in cxl_endpoint_decoder_initialize() (Gregory),
>  * fixed region interleaving parameters() (Alison),
>  * fixed check in cxl_region_attach() (Alison),
>  * Clarified in coverletter that not all ports in a system must
>    implement the to_hpa() callback (Terry).
> 
> [1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
> [2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/
> [3] https://patchwork.kernel.org/project/cxl/cover/20250218132356.1809075-1-rrichter@amd.com/
> [4] https://patchwork.kernel.org/project/cxl/cover/20250715191143.1023512-1-rrichter@amd.com/
> [5] https://lore.kernel.org/all/78284b12-3e0b-4758-af18-397f32136c3f@intel.com/
> 
> Robert Richter (11):
>   cxl/region: Store root decoder in struct cxl_region
>   cxl/region: Store HPA range in struct cxl_region
>   cxl/region: Rename misleading variable name @hpa to @range
>   cxl/region: Add @range argument to function cxl_find_root_decoder()
>   cxl/region: Add @range argument to function cxl_calc_interleave_pos()
>   cxl/region: Separate region parameter setup and region construction
>   cxl: Introduce callback to translate a decoder's HPA to the next
>     parent port
>   cxl/region: Implement endpoint decoder address translation
>   cxl/region: Lock decoders that need address translation
>   cxl/acpi: Prepare use of EFI runtime services
>   cxl: Enable AMD Zen5 address translation using ACPI PRMT
> 
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/acpi.c        |   8 +-
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/atl.c    | 138 ++++++++++++++++++++++
>  drivers/cxl/core/core.h   |   1 +
>  drivers/cxl/core/port.c   |   8 ++
>  drivers/cxl/core/region.c | 239 ++++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |  17 +++
>  8 files changed, 368 insertions(+), 48 deletions(-)
>  create mode 100644 drivers/cxl/core/atl.c
> 
> 
> base-commit: 561c4e30bff93b3c33e694a459f8580f8a6b3c8c

