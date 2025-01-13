Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0E1C5D48;
	Mon, 13 Jan 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793698; cv=none; b=ijBmuf9MmvJUkghUSIucIBI7K8Cz6WLDEygJoMnaj1Uy0D/Kt0a2uiIDfkdbZ+iF/OOLAy2EItiEvwfm9awIzHxtkTLzdScqjQA53QPrnCjbAdhAmM0RqPwTlZkZwp77ZC3WLKDpYCAhTXuXC2/ooHBMOgDja8CuZzCMZ0ftnMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793698; c=relaxed/simple;
	bh=QMV0RVFno/8zuLADMNIhn6oU+OgHhcg1ELbDCalcBik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLiByig3i009U71FhoVg/+HHnZxqntoGXPq9QCyktNWbtu6rI9OvSWFJTR9coTo4QNQ/NPWEPdfjosc8qH7b/cQKCbS/oFd0OTDyRAfHWm+DHU/RSOZJfbInWYP7lwgtgmSUbXfLQqkmRPk5R9PpadM04uSZYOzRSlFrysd1ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bidJqDzo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bidJqDzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736793696; x=1768329696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMV0RVFno/8zuLADMNIhn6oU+OgHhcg1ELbDCalcBik=;
  b=bidJqDzoR7YZQO64csOGevyY5HkX+hoLC+B038+7N7hRGOaxyYtsPrQl
   cNn545pw2Vw1oNU2OTQ4agvtMJJEv69prHmzJ5TpsN0e8bcWQlcgG9awL
   NwARganLtdnK+JT5HfiYUlGzB/cKitO/zfCZiPwxus8S43qbGKNgiVr2t
   zuaeKZ2/tbYMxk/u33GSyLuJUziow/Vg1cR3IY/n3b5IhOwWEDQgWPMoY
   jjvpAMa7iqBXYo8KFcNqbccJ83amHcCX4O+yipOy02BEOF5iXhbFPIo8l
   aQh3OCtraSI+QZvmDZZSuITmwU8ytxD4XJnMCREnx2IUDUh0Z0HsmZTK6
   Q==;
X-CSE-ConnectionGUID: 0BRZFibrSMO0l+x1mB0P8w==
X-CSE-MsgGUID: XRZB7L6eQXqk7c8G6pBr4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47646871"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47646871"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:41:36 -0800
X-CSE-ConnectionGUID: nezb9ctmSFqI8aLTGfjj2g==
X-CSE-MsgGUID: Ma0GeEATSCmpfzEByCHx7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="105084185"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:41:34 -0800
Date: Mon, 13 Jan 2025 10:41:32 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 00/29] cxl: Add address translation support and enable
 AMD Zen5 platforms
Message-ID: <Z4VeXOcPUUmdTCFy@aschofie-mobl2.lan>
References: <20250107141015.3367194-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:46PM +0100, Robert Richter wrote:
> This patch set adds support of address translation and enables this
> for AMD Zen5 platforms. This is a new appoach in response to an
> earlier attempt to implement CXL address translation [1] and the
> comments on it, esp. Dan's [2]. Dan suggested to solve this by walking
> the port hierarchy from the host port to the host bridge. When
> crossing memory domains from one port to the other, HPA translations
> are applied using a callback function to handle platform specifics.
> 
> The CXL driver currently does not implement address translation which
> assumes the host physical addresses (HPA) and system physical
> addresses (SPA) are equal.

Hi Robert,

I tried this out and have some sporadic review. (It's a big set so please
pardon that I'm not giving a comprehensive review on v1.)

I commented directly on a couple of patches, which were things that I touched
to get user created regions working. So that leads to my main feedback - let's
keep user created regions alive.

This set made me wonder if there may be an advantage in further delineating the
auto vs user region creation path. This set is a special auto method and we
have hetero-interleave coming which will introduce more auto only special-ness. Just a thought that was triggered by seeing the refactoring of the interleave
calculation path.

Suggest ditching the term 'address translation' and specifically stating what
is being translated. And that may lead to some clean up in code/comments that
I added during the DPA->HPA->SPA translation when I thought it was the only
translation in town.

DPA to HPA: exists to report HPAs in trace events when a device reports a DPA
        media error.
HPA to SPA: exists to report the above HPAs correctly when XOR interleave
        arithmetic is used.
HPA to SPA: introduced here

The latter 2 HPA to SPA are not equivalent. The root decoder callback added
for XOR doesn't apply on the front-end like is introduced here. The HB
decoder (hardware) does XOR the translation. The callback (as it exists today)
only comes into play when DPA addresses are directly reported in events. So
there may be some renaming needs there.

That's all for now. I'll review, try out more, in the v2.
--Alison

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
> translated to each of the parent port's address ranges up to the root
> decoder. This is implemented by traversing the decoder and port
> hierarchy from the endpoint up to the root port and applying platform
> specific translation functions to determine the next HPA range of the
> parent port where needed:
> 
>   if (cxl_port->to_hpa)
>     hpa = cxl_port->to_hpa(cxl_decoder, hpa)
> 
> A callback is introduced to translate an HPA range from a port to its
> parent.
> 
> The root port's HPA range is equivalent to the system's SPA range and
> can then be used to find an endpoint's root port and region.  
> 
> Also, translated HPA ranges must be used to calculate the endpoint
> position in the region.
> 
> Once the region was found, the decoders of all ports between the
> endpoint and the root port need to be found based on the translated
> HPA. Configuration checks and interleaving setup must be modified as
> necessary to support address translation.
> 
> Note that only auto-discovery of decoders is supported. Thus, decoders
> are locked and cannot be configured manually.
> 
> Finally, Zen5 address translation is enabled using ACPI PRMT.
> 
> Purpose of patches:
> 
>  * Patches #1-#4: Minor cleanups and updates separated from the actual
>    implementation
> 
>  * Patches #5-#12, #14, #17, #18: Code rework and refactoring.
> 
>  * Patches #13, #15, #16, #19-#24: Functional changes for address
>    translation (common code).
> 
>  * Patch #25, #26: AMD Zen5 address translation.
> 
>  * Patch #27-#29: Changes to improve debug messages for better debugging.
> 
> [1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
> [2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/
> 
> 
> Robert Richter (29):
>   cxl: Remove else after return
>   cxl/pci: Moving code in cxl_hdm_decode_init()
>   cxl/pci: cxl_hdm_decode_init: Move comment
>   cxl/pci: Add comments to cxl_hdm_decode_init()
>   cxl/region: Move find_cxl_root() to cxl_add_to_region()
>   cxl/region: Factor out code to find the root decoder
>   cxl/region: Factor out code to find a root decoder's region
>   cxl/region: Split region registration into an initialization and
>     adding part
>   cxl/region: Use iterator to find the root port in
>     cxl_find_root_decoder()
>   cxl/region: Add function to find a port's switch decoder by range
>   cxl/region: Unfold cxl_find_root_decoder() into
>     cxl_endpoint_initialize()
>   cxl: Modify address translation callback for generic use
>   cxl: Introduce callback to translate an HPA range from a port to its
>     parent
>   cxl: Introduce parent_port_of() helper
>   cxl/region: Use an endpoint's SPA range to find a region
>   cxl/region: Use translated HPA ranges to calculate the endpoint
>     position
>   cxl/region: Rename function to cxl_find_decoder_early()
>   cxl/region: Avoid duplicate call of cxl_find_decoder_early()
>   cxl/region: Use endpoint's HPA range to find the port's decoder
>   cxl/region: Use translated HPA ranges to find the port's decoder
>   cxl/region: Lock decoders that need address translation
>   cxl/region: Use translated HPA ranges to create a region
>   cxl/region: Use root decoders interleaving parameters to create a
>     region
>   cxl/region: Use endpoint's SPA range to check a region
>   cxl/amd: Enable Zen5 address translation using ACPI PRMT
>   MAINTAINERS: CXL: Add entry for AMD platform support (CXL_AMD)
>   cxl/region: Show message on registration failure
>   cxl/region: Show message on broken target list
>   cxl: Show message when a decoder was added to a port
> 
>  MAINTAINERS               |   7 +
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/acpi.c        |  14 +-
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/amd.c    | 227 +++++++++++++++++++++
>  drivers/cxl/core/cdat.c   |   2 +-
>  drivers/cxl/core/core.h   |   6 +
>  drivers/cxl/core/hdm.c    |   3 +-
>  drivers/cxl/core/pci.c    |  44 +++--
>  drivers/cxl/core/port.c   |  22 ++-
>  drivers/cxl/core/region.c | 407 ++++++++++++++++++++++++++++----------
>  drivers/cxl/cxl.h         |  16 +-
>  drivers/cxl/port.c        |  22 +--
>  13 files changed, 623 insertions(+), 152 deletions(-)
>  create mode 100644 drivers/cxl/core/amd.c
> 
> 
> base-commit: 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2
> -- 
> 2.39.5
> 
