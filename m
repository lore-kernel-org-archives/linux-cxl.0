Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503E22F778;
	Fri,  9 May 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806591; cv=none; b=Ec/HVTrVt22Z6ERJ4elQk6Fsipvo6UuLC07BS9qKV4RkwCiV44nXDKE+y/1Zst9lI01m4x8tw5SiBiKNehlXjo1rb3AV/U2TZDeMNxCq7hFzA85pycHpsHZm4nJSrSuSdvIqmtLh5xnewVLcMwHyrnwxSn9cZUPSJQFPGySEkmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806591; c=relaxed/simple;
	bh=GPRzG8VKelEecZ0Yee3qUa2iBon8T40y70Gj2OBr1HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqnM0cLEd+dq/UXUGd2KzAqJxigXZSl45CygnVDLnROFfD3qkBP8I7k5hb0IJ4h7TH6DvcIBpWigghGXcksIez8urgj7HeqCI7XgCqQK/icjTavAPP0YC7R9sKVboIJteifzXI7L4DVTtp6sGPNDAtlpDYTJie5bJK/rz1eO53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0krhn6W; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0krhn6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746806590; x=1778342590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GPRzG8VKelEecZ0Yee3qUa2iBon8T40y70Gj2OBr1HM=;
  b=M0krhn6WJp60ST81plttPwPqlJ3NNaNs+2+u/56eDKN7YjnYENRWFb9z
   HslGLWR6XY7PzmwOE76WXUwJR+O4/7E+RSdM6OEytcjTksqlmAdDGkmca
   qPrQ9xiCmfcRw6XjKfJ7Iz7izL9NubRYwwcNPIsQH8AA7PLAsQguqp22i
   syWJhcKs8YIZMH2uSuLW9WjihY2PeUsWexQmW3nLgvr0iX7QI5Fwb84/s
   ZRD5rFChtE+96UhlmetgxvvRQTDy9w6eqNqqRvxz8ig/ZsGJX0aaP8ZNi
   NZAeIY4zibtflToRBLttaBdzc6nI6iEDUk27Cw8JSvR9ni+Lv7lwoH4H6
   g==;
X-CSE-ConnectionGUID: 3/9UCTJgS86E5VXJUurdpg==
X-CSE-MsgGUID: jnNoTPj/SWW5wUdp2gcreg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59298917"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59298917"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:03:09 -0700
X-CSE-ConnectionGUID: dy+/pV5jSsi3tjZGAqV3RA==
X-CSE-MsgGUID: S0q6RtYJShW0dQiK2NFvgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="137641752"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 09:03:08 -0700
Message-ID: <14b64c8d-a5fc-42eb-8160-590c17bbbd99@intel.com>
Date: Fri, 9 May 2025 09:03:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] cxl: Address translation support, part 1:
 Cleanups and refactoring
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/9/25 8:06 AM, Robert Richter wrote:
> This series is the first part of adding support for CXL address
> translation. It contains cleanup and code refactoring in preparation
> of the actual implementation that will be sent in part 2. Cleanup and
> code refactoring have been split in a separate series to reduce the
> number of patches of the series. Even without address translation on
> top this rework improves esp. the region code, cleans it up,
> simplifies it and adds debugging messages to better analyze region
> creation failures:
> 
> Content of patches:
> 
>  * Patches 1: Remove else after return.
> 
>  * Patches 2-3: Cleanups and comments around cxl_hdm_decode_init().
> 
>  * Patches 4-6: Adding and modifying helper functions.
> 
>  * Patches 7-11: Refactoring of endpoint decoder setup and cxl_find*()
>    including cleanup helpers.
> 
>  * Patches 12-14: Adding and modifying debug messages.
> 
> v6:
>  * added tags to SOB chain,
>  * added more occurences to remove-else-after-return (Alison),
>  * updated description of cxl_port_pick_region_decoder() (Fabio),
> 
> v5:
>  * added tags to SOB chain,
>  * made comment a oneliner in cxl_hdm_decode_init() (Jonathan),
>  * updated patch description introducing parent_port_of() (Fabio),
>  * removed EXPORT_SYMBOL_NS_GPL() of function parent_port_of() (Dan),
>  * renamed functions to cxl_port_pick_region_decoder() and
>    cxl_rr_assign_decoder(), updated descriptions (Dan),
>  * added patch to replace put_cxl_root() by a cleanup helper,
>  * using __free() for reference counting of cxl_find_*() functions,
>    added cleanup helpers (Dan),
>  * dropped patch adding CFMWS memory log messages (Dan),
> 
> v4:
>  * rebased onto cxl/next, commit 0a14566be090 ("cxl/Documentation:
>    Remove 'mixed' from sysfs mode doc"),
>  * added tags to SOB chain,
>  * reworked comments in cxl_hdm_decode_init() (dropped moving comment
>    and updated patch that modifies comments) (Jonathan),
>  * reworded patch description that removes duplicate call of
>    cxl_find_decoder_early() (Jonathan),
>  * moved some patches out of this rework and cleanup series (Dave,
>    Jonathan),
> 
> v3:
>  * added tags to SOB chain,
>  * fixed NULL pointer dereference in cxl_find_root_decoder() (Alison),
>  * updated subject line of patches that add kernel messages and
>    included example log messages (Alison),
> 
> v2:
>  * rebased onto cxl/next,
>  * added tags to SOB chain,
>  * move patches with cleanups and refactoring into this separate
>    series (Dave),
>  * added patch "cxl/acpi: Unify CFMWS memory log messages with SRAT
>    messages" to improve CFMWS log messages,
>  * renamed endpoint decoder functions to cxl_endpoint_decoder_*() (Li),
>  * reworded patch description that moves find_cxl_root() and reworks
>    cxl_find_root_decoder() (Terry),
>  * small changes to cxl_find_root_decoder()/
>    cxl_endpoint_decoder_initialize() (Jonanthan),
>  * updated comment in cxl_port_find_switch_decoder() (Ben),
>  * cxl_endpoint_decoder_initialize(): Simplify variable declaration
>    (Jonathan, Ben),
>  * cxl_find_decoder_early(): Added comment on function usage (Gregory),
>  * reordered patches and reworded some of the subject for a better
>    structure.
> 
> Robert Richter (14):
>   cxl: Remove else after return
>   cxl/pci: Moving code in cxl_hdm_decode_init()
>   cxl/pci: Add comments to cxl_hdm_decode_init()
>   cxl: Introduce parent_port_of() helper
>   cxl/region: Rename function to cxl_port_pick_region_decoder()
>   cxl/region: Avoid duplicate call of cxl_port_pick_region_decoder()
>   cxl/region: Move find_cxl_root() to cxl_add_to_region()
>   cxl/port: Replace put_cxl_root() by a cleanup helper
>   cxl/region: Factor out code to find the root decoder
>   cxl/region: Factor out code to find a root decoder's region
>   cxl/region: Add function to find a port's switch decoder by range
>   cxl/region: Add a dev_warn() on registration failure
>   cxl/region: Add a dev_err() on missing target list entries
>   cxl: Add a dev_dbg() when a decoder was added to a port
> 
>  drivers/cxl/acpi.c        |  10 ++-
>  drivers/cxl/core/cdat.c   |   2 +-
>  drivers/cxl/core/hdm.c    |   3 +-
>  drivers/cxl/core/memdev.c |   4 +-
>  drivers/cxl/core/pci.c    |  48 +++++++----
>  drivers/cxl/core/port.c   |  23 ++---
>  drivers/cxl/core/region.c | 177 +++++++++++++++++++++++---------------
>  drivers/cxl/cxl.h         |  13 +--
>  drivers/cxl/port.c        |  15 +---
>  9 files changed, 173 insertions(+), 122 deletions(-)
> 
> 
> base-commit: 8e62ba590160f91abba6490d9c17aa13bada4752

Applied to cxl/next. Thanks Robert!

