Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51B2F3C1C
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130124; cv=none; b=BGGBU3EyzJzVb6c3xrMdHEOaxPTLUU8dljKA2W+oyt/J6xCxM6JzDr/8OYb/MaPwSzPAOzkVTBium0Z245Lgidb98uRHWuxC+e8vKyhQIbaEhuHBHn1ojF7Tz5NYaNWf57z6MpEz67lPFBTDLPZZ/toBlJmV+S8k0OHUL2owTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130124; c=relaxed/simple;
	bh=rIjUOCkhvgji49T2bvQVIhQu3hc+yTZqVtW5vqjq0xE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=syq+mbtaWHS9kwdyy/+QVDCXzuNHoI/E6suoZCkqdPvVprUm8sHINuU2OxNSDnrjPApqqaBareR4TfRW9t8NX49SgSkO+eQ7QzqybcuajB5kslGwBSmPrktersmSD2Mw/DQFz6T78jQRKrY9SCTEUjn90InqGRW7f5hDjrw2fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5U8OMrr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5U8OMrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758130123; x=1789666123;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rIjUOCkhvgji49T2bvQVIhQu3hc+yTZqVtW5vqjq0xE=;
  b=M5U8OMrr3DBydBDysVnd9cU8pp52x6vYp1DhceerIb2KOANzU/4w9Btr
   CMMvtD7fwg9h8sJcYuzuMq42zL3cvcJxVB7y3W0xsgo/nAg1uXznCX4Lh
   6MKmdFc+9FzparUteexNljwSrbaivjjAF7qUs/eFwYGjKEDfUx/f4l7x8
   nkAPgx4unq67CpmDaRa2ijEBG6f0l+1hl59AdwvxmZb0eEbzqV5rvQFWh
   z2c1oqlmF/bLOzFJgHL2rOPkFXjXM8YFUtfyXjEbJnX0Ih3WKmN/3UAR/
   ORWv5T19nfqnOIHpjHmdvmpctYKx7b2t5uKLLig7Wp2OlEmSzvfpu04KH
   w==;
X-CSE-ConnectionGUID: W+A6ZCGsRJS36Xi98ZJgCw==
X-CSE-MsgGUID: DCIkAcrYRiy2LvQ9lRRawg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71549701"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="71549701"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 10:28:42 -0700
X-CSE-ConnectionGUID: iVe2/hx/QfKY+QKLkouOGg==
X-CSE-MsgGUID: VWFct4VsT/aEXA70V9V8VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="212460673"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.223]) ([10.125.111.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 10:28:42 -0700
Message-ID: <3e891eed-1e6c-407e-9e94-7ab6f76d0b84@intel.com>
Date: Wed, 17 Sep 2025 10:28:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/10] cxl: Delay HB port and switch dport probing
 until endpoint dev probe
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, rrichter@amd.com, Gregory Price
 <gourry@gourry.net>, Li Ming <ming.li@zohomail.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250829180928.842707-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 11:09 AM, Dave Jiang wrote:
> v9:
> - Reworked the port enumeration iteration loop. (Robert)
>   All please re-review "cxl: Defer dport allocation for switch ports"
> - Created helper functions for dealing with switch and endpoint decoder enumeration.
>   Main goal is to reduce cxl_test interface burden. (Robert)
>   - Dropped cxl_test changes for decoder functions
> - Dropped the cxl_test for region replay. It's not 100% ready and can be submitted later. (Alison)
> - See specific commits for more detailed changes.
> 
> v8:
> - A bit of changes from Dan and Robert's comments. Main change is moving the port MMIO
>   register probing to after the first dport shows up. This resulted with decoder allocation
>   happens after the register probe.
> - See specific commits for more detailed changes.
> 
> v7:
> - Remove -EEXIST to simplify error flow. (Ming)
> - Set dport to NULL during declare. (Jonathan)
> 
> v6:
> - Return -EEXIST when a dport already exists. (Jonathan)
> - Fix checking wrong port for NULL. (Ming)
> - Check host_bridge and call devm_cxl_add_dport_by_uport() directly vs add_port_attach_ep(). (Ming)
> - Set dport to NULL during declaration. (Jonathan)
> 
> v5:
> - Return dport instead of errno with dport pointer as output param. (Jonathan)
> - Consolidate common code in cxl_test. (Jonathan)
> - Rename cxl_port_get_total_dports() to cxl_port_update_total_dports(). (Jonathan)
> 
> v4:
> - Push dport allocation to when they are discovered. (Robert)
> - Drop linux id for dport with above changes.
> 
> v3:
> - Main changes revolve around improving naming of hostbridge uport and dport (Gregory)
> - See specific patches for detailed change log
> 
> This series attempts to delay the allocation of dports until when the endpoint device
> (memdev) are being probed. At this point, the CXL link is established and all the
> devices along the CXL link path up to the Root Port (RP) should be active.
> 
> And hopefully this help a bit with Robert's issue raised in the "Inactive
> downstream port handling" series [1]. Testing would be appreicated. Thank you!
> 
> [1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Dave Jiang (10):
>   cxl: Add helper to detect top of CXL device topology
>   cxl: Add helper to reap dport
>   cxl: Add a cached copy of target_map to cxl_decoder
>   cxl: Move port register setup to first dport appear
>   cxl/test: Refactor decoder setup to reduce cxl_test burden
>   cxl: Defer dport allocation for switch ports
>   cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
>   cxl/test: Adjust the mock version of
>     devm_cxl_switch_port_decoders_setup()
>   cxl/test: Setup target_map for cxl_test decoder initialization
>   cxl: Change sslbis handler to only handle single dport
> 
>  drivers/cxl/acpi.c                   |   7 +-
>  drivers/cxl/core/cdat.c              |  25 +--
>  drivers/cxl/core/core.h              |   5 +
>  drivers/cxl/core/hdm.c               | 105 ++++++---
>  drivers/cxl/core/pci.c               |  89 ++++++++
>  drivers/cxl/core/port.c              | 317 ++++++++++++++++++++-------
>  drivers/cxl/core/region.c            |   4 +-
>  drivers/cxl/cxl.h                    |  44 +++-
>  drivers/cxl/cxlpci.h                 |   2 -
>  drivers/cxl/port.c                   |  47 +---
>  tools/testing/cxl/Kbuild             |   7 +-
>  tools/testing/cxl/cxl_core_exports.c |  22 ++
>  tools/testing/cxl/exports.h          |  13 ++
>  tools/testing/cxl/test/cxl.c         | 115 ++++++++--
>  tools/testing/cxl/test/mock.c        |  96 +++-----
>  tools/testing/cxl/test/mock.h        |   9 +-
>  16 files changed, 642 insertions(+), 265 deletions(-)
>  create mode 100644 tools/testing/cxl/exports.h
> 
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585

Applied to cxl/next with minor fixes from comments:
14868cf9e4b8cefac0fb9eea4993ac3f863a8c0d
