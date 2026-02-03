Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887117B425;
	Tue,  3 Feb 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144726; cv=none; b=lvoKNYQaWTFH63Xlg+uQGIh+p7Y4o2Lw5UTMgCSJoooGhRErsZx28RGURMqykZtNo74RXdtqlySF37URt+4DKsa4CwhCnp8K62FASQR7UUfHGVFqjlM6NotpgnPuoz/+HdyD0sceE32b0iYhQdHL5JLsrBshSWLUJdFj9iO3kR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144726; c=relaxed/simple;
	bh=5Mub8vAZ41NctLsgFyNFEaYOee+N2rNLS61xndkCRDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNAM+Gm08lzVpTkye80vOqlF9ouG0ovU6tOeT38WywK2mLOg6XX2aHKwOfCu2fCoBVpB32jAs/lf33Reo1Kd+qilFDi8C5QddLcb0aHvSWqKeKgdTZxqASLiqriBuiwoQ/yAyW3SFLnj8ol2C9rmiMXvw36XAP1IFU/VfP/+hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4Aay7n8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4Aay7n8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770144724; x=1801680724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Mub8vAZ41NctLsgFyNFEaYOee+N2rNLS61xndkCRDE=;
  b=I4Aay7n8eF1t+zUuMb0acf3itutpJjTBycgRc3kp+sJwnCtl67jzQC0I
   TDMLx1rv/s7ggHs+/rF8q5O8Y6kiv1gUplbpXAoz5Hp+lnE+Flp2S2d2l
   6kUJSFyrvv0ZPmblrlXx+5x/1Uuvo7uBRSCpPcaHcKpdJau3bdGNkvBM0
   FvrWEEy2jY3yi4VlNgpqU46fMKVL5HB53uIo1BNVEe+AJubZ9uEL5/1jK
   QC//HmXUnVm68/zMidvlYr4sBXupLGMpJOk9P9jIQFb7FxTJ6t0z8ddk1
   7g1VAAoGNFtp/2qfbYUaaYLI4XwVexN2bym5qdBjf9swn6Sp1GVZvPVzL
   g==;
X-CSE-ConnectionGUID: NZZLmSzhS0SlACQHMuybCA==
X-CSE-MsgGUID: UBd9B4XlQk2W4uhn0mKYkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96780151"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="96780151"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:52:03 -0800
X-CSE-ConnectionGUID: YVMFVfyvRK6+TEC6EMT5Ng==
X-CSE-MsgGUID: 2QpH+cbHRO6g47XQVz+zSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="247529808"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.221]) ([10.125.110.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:52:02 -0800
Message-ID: <125a0a77-b966-410c-b9e4-a7d81e462576@intel.com>
Date: Tue, 3 Feb 2026 11:52:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20260110114705.681676-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/26 4:46 AM, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. The current approach bases on v4
> and is in response to earlier attempts to implement CXL address
> translation:
> 
>  * v1: [1] and the comments on it, esp. Dan's [2],
>  * v2: [3] and comments on [4], esp. Dave's [5],
>  * v3: [6] and comments on it, esp. Dave's [7],
>  * v4: [8].
> 
> This version addresses Alison's review comments to change the
> implementation to disable HPA/SPA translation handler. There are a
> view minor but no major changes otherwise. See the changelog for
> details. Thank you all for your reviews and testing.
> 
> Documentation of CXL Address Translation Support will be added to the
> Kernel's "Compute Express Link: Linux Conventions". This patch
> submission will be the base for a documentation patch that describes CXL
> Address Translation support accordingly.
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
> introduced to translate a decoder's HPA to the CXL host bridge's
> address range. The callback is then used to determine the region
> parameters which includes the SPA translated address range of the
> endpoint decoder and the interleaving configuration. This is stored in
> struct cxl_region which allows an endpoint decoder to determine that
> parameters based on its assigned region.
> 
> Note that only auto-discovery of decoders is supported. Thus, decoders
> are locked and cannot be configured manually.
> 
> Finally, Zen5 address translation is enabled using ACPI PRMT.
> 
> This series bases on v6.19-rc1.

Applied to cxl/next. Including the conventions doc.
00bc604c96bb762f0f050460e25de2729edb1699

> 
> V9:
>  * rebased onto v6.19-rc1,
>  * updated sob-chains,
>  * removed alignment check in cxl_prm_setup_root() for DPA ranges,
>  * moved assignment to variable len in cxl_prm_setup_root() closer to user,
>  * removed patch from series (Alison):
>    [PATCH v8 12/13] cxl: Check if ULLONG_MAX was returned from translation functions
>  * added patch to factor out poison setup code,
>  * changed implementation to disable HPA/SPA translation handlers (Alison),
> 
> V8:
>  * rebased onto cxl-for-6.19,
>  * updated sob-chains,
>  * renamed cxl_root callback to translation_setup_root,
>  * renamed functions to cxl_root_setup_translation and cxl_prm_setup_root,
>  * added comment around cxl_root_setup_translation(),
>  * added check for ULLONG_MAX of return value of translation functions,
>  * added callback to setup translation for regions
>    (cxl_region_setup_translation, cxl_prm_setup_region),
>  * add HPA/SPA callback handlers that return ULLONG_MAX (Alison),
> 
> V7:
>  * rebased onto cxl/for-6.19/cxl-prm,
>  * reworded comment and description of 11/11 (decoder lock),
> 
> V6:
>  * rebased onto v6.18-rc5 and CXL updates for v6.19,
>  * note: applies on top of: [PATCH v3 0/3] CXL updates for v6.19,
> 
> V5:
>  * fixed build error with !CXL_REGION (kbot),
>  * updated sob-chains,
>  * added note to get_cxl_root_decoder() to drop reference after use
>    (Dave),
>  * moved initialization of base* variables in
>    cxl_prm_translate_hpa_range() (Dave, Jonathan),
>  * fixed initialization of cxlr->hpa_range for the non-auto case
>    (Alison),
>  * added description of the @hpa_range arg to
>    cxl_calc_interleave_pos() (kbot),
>  * removed optional patches 12-14 to send them separately (Alison,
>    Dave),
>  * reordered patches 1-6 to reduce dependencies between them and give
>    way for early pick up candidates,
>  * rebased onto cxl/next (c692f5a947ad),
>  * added commas in comment in cxl_add_to_region() (Jonathan),
>  * removed cxlmd from struct cxl_region_context (Dave, Jonathan),
>  * removed use of PTR_ERR_OR_ZERO() (Jonathan),
>  * increased wrap width to 80 chars for comments in cxl_atl.c (Jonathan),
>  * moved (ways > 1) check out of while loop in cxl_prm_translate_hpa_range()
>    (Jonathan),
>  * removed trailing comma in struct prm_cxl_dpa_spa_data initializer (Jonathan),
>  * updated patch description on locking the decoders (Dave, Jonathan),
>  * spell fix in patch description (Jonathan),
> 
> V4:
>  * rebased onto v6.18-rc2 (cxl/next),
>  * updated sob-chain,
>  * reworked and simplified code to use an address translation callback
>    bound to the root port,
>  * moved all address translation code to core/atl.c,
>  * cxlr->cxlrd change, updated patch description (Alison),
>  * use DEFINE_RANGE() (Jonathan),
>  * change name to @hpa_range (Dave, Jonathan),
>  * updated patch description if there is a no-op (Gregory),
>  * use Designated initializers for struct cxl_region_context (Dave),
>  * move callback handler to struct cxl_root_ops (Dave),
>  * move handler initialization to acpi_probe() (Dave),
>  * updated comment where Normalized Addressing is checked (Dave),
>  * limit PRM enablement only to AMD supported kernel configs (AMD_NB)
>    (Jonathan),
>  * added 3 related optional cleanup patches at the end of the series,
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
>  * added several patches around interleaving and SPA calculation in
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
> [6] https://patchwork.kernel.org/project/cxl/cover/20250912144514.526441-1-rrichter@amd.com/
> [7] https://lore.kernel.org/all/20250912144514.526441-8-rrichter@amd.com/T/#m23c2adb9d1e20770ccd5d11475288bda382b0af5
> [8] https://patchwork.kernel.org/project/cxl/cover/20251103184804.509762-1-rrichter@amd.com/
> 
> Robert Richter (13):
>   cxl/region: Rename misleading variable name @hpa to @hpa_range
>   cxl/region: Store root decoder in struct cxl_region
>   cxl/region: Store HPA range in struct cxl_region
>   cxl: Simplify cxl_root_ops allocation and handling
>   cxl/region: Separate region parameter setup and region construction
>   cxl/region: Add @hpa_range argument to function
>     cxl_calc_interleave_pos()
>   cxl/region: Use region data to get the root decoder
>   cxl: Introduce callback for HPA address ranges translation
>   cxl/acpi: Prepare use of EFI runtime services
>   cxl: Enable AMD Zen5 address translation using ACPI PRMT
>   cxl/atl: Lock decoders that need address translation
>   cxl/region: Factor out code into cxl_region_setup_poison()
>   cxl: Disable HPA/SPA translation handlers for Normalized Addressing
> 
>  drivers/cxl/Kconfig       |   5 +
>  drivers/cxl/acpi.c        |  17 +--
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/atl.c    | 211 ++++++++++++++++++++++++++++++++
>  drivers/cxl/core/cdat.c   |   8 +-
>  drivers/cxl/core/core.h   |   8 ++
>  drivers/cxl/core/port.c   |   8 +-
>  drivers/cxl/core/region.c | 247 ++++++++++++++++++++++++--------------
>  drivers/cxl/cxl.h         |  40 ++++--
>  9 files changed, 426 insertions(+), 119 deletions(-)
>  create mode 100644 drivers/cxl/core/atl.c
> 
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8

