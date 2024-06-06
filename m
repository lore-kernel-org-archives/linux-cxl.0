Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C36D502
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644198; cv=none; b=NgIcoYTXfbAVtX4gXq9R+Ae71mJKfxn5VYfpT89HUKVWcT86H9DA60g0Q7dAk2LrYpalddXH1ThgOPMyWfGZiHDvAwKdcXo66iMtnXb+MzZ7xVABrJvfSmwcYSSZHMHj2FxgxeunehAwomRsvLMsNGLQBHZcgxTqCujWi6VLVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644198; c=relaxed/simple;
	bh=J0wNgeAdzssJEghoYc2kygycIHNYBGlnszbK/mQqnmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOon6NbLwIMcdhMLPbSqtYmGwRBGBz8Kp+pYw7Tli8pudd2T3DGkMrMLQFN7COtZgg5ZfbB7SXNmF6UjlscKL0N8hmYNIMn8ZWyq250MDu+Fr7XSITac5+buF2Xpco4deJIUJvUcjTGppArPaJCp8uff8ST11NISnRAkNI1nc/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duHQHb0M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duHQHb0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717644196; x=1749180196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J0wNgeAdzssJEghoYc2kygycIHNYBGlnszbK/mQqnmo=;
  b=duHQHb0MlC6+23Nw6cY/wbsbBL0CWGO/HOjm5yLMWTgd5GpTQJhkPvEg
   m7LxjuO+R0fwElmlfcFfZpoDKfBBoItctyh2JvCgR/kN0ZhbtHzRIT3tD
   boPSjQ2qIiE7BbJChGly/UQ7mu3ZHFPSQOoIGZpVM2KXIAt5MPwo9Uq6l
   Kq+gh8M3QPPBgl33Rtkf3J+uTduQ6bWmhCD4CmJQx4nispME9F8cmEPSL
   zBMDPavRNjs3djcOQEtofoC7XzO5z2C8zAHWEsCMHGLThr03VqK/MtqSA
   oqWRFzoKg3feFfpvGOiffYX4Bxhw1EotsFj6tRYI6JEfiw9g+3Zvfx+kf
   w==;
X-CSE-ConnectionGUID: eVuxZDJJQWW7fi8pLy/H2g==
X-CSE-MsgGUID: AR85AQHHT9e5J31AQspm8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14034034"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14034034"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 20:23:15 -0700
X-CSE-ConnectionGUID: WC3kcWr2QmSonViUD+feDw==
X-CSE-MsgGUID: 77zjzUCYSQaVKbcsMRynTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42229172"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 20:23:15 -0700
Date: Wed, 5 Jun 2024 20:23:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, .manzanares@samsung.com
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <ZmEroVRLDDLdHIqL@aschofie-mobl2>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>

On Fri, May 24, 2024 at 05:53:49PM -0700, Dan Williams wrote:
> Provide a survey of the work-in-progress maturity (implementation
> status) of various aspects of the CXL subsystem.
> 
> Clarify that in addition to ongoing upkeep relative to specification
> updates, there are some long running themes in the driver that respond
> to the discovery of new corner cases (bugs) and new use cases (feature
> extensions).
> 
> The primary audience is distribution maintainers, but it also serves as
> a guide for kernel developers to understand what aspects of the CXL
> subsystem need more help. It is a landing page to document ongoing
> progress, and a guide to discern exposure to work-in-progress features.

Hi Dan,

I'm wondering if Scan Media can be added to the list. I was within 
striking distance of posting that set when higher priority work called.
Since it got pushed aside no one has cared :(  I'd welcome the chance
to contribute it upstream if there is a justification. Can we add it
here as a [0] here to keep it on the radar.

-- Alison

> 
> Help wanted / welcome to expand on the "Details" section.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst        |    2 
>  Documentation/driver-api/cxl/maturity-map.rst |  173 +++++++++++++++++++++++++
>  MAINTAINERS                                   |    1 
>  3 files changed, 176 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/maturity-map.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 036e49553542..12b82725d322 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -9,4 +9,6 @@ Compute Express Link
>  
>     memory-devices
>  
> +   maturity-map
> +
>  .. only::  subproject and html
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> new file mode 100644
> index 000000000000..9c5bff6484dd
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -0,0 +1,173 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +===========================================
> +Compute Express Link Subsystem Maturity Map
> +===========================================
> +
> +The Linux CXL subsystem tracks the dynamic `CXL specification
> +<https://computeexpresslink.org/cxl-specification-landing-page>`_ that
> +continues to respond to new use cases with new features, capability
> +updates and fixes. At any given point some aspects of the subsystem are
> +more mature than others. While the periodic pull requests summarize the
> +`work being incorporated each merge window
> +<https://lore.kernel.org/linux-cxl/?q=s%3APULL+s%3ACXL+tc%3Atorvalds+NOT+s%3ARe>`_,

Thanks for the lore link!



