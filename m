Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588B78F26
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982078; cv=none; b=n3Q4OftX3vLw9N4o5J6CYSxLY8FUPepCehiic6aAe6x14dKPtTM+h0TAmKU2uiu5FxMJMhxFaB8HjcBPjep1WOS+Fehazh+Kjh0zWCsQ2j9iaM3cOp3FFsHz4BHs8yPaAe9f3EEh1JwGkqwcirD0AfW7SWiqoUuPBZ436sMK7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982078; c=relaxed/simple;
	bh=QGpcg/EhCTeK5FmLAZcXD6lY35PV/QOXSecMjf1KHK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2wWPvkwqV7Xzyfiz5PT7Am4lETx1wWAgrRsDRdmyIDuFOSoizPCgl45reAqv5dIrfRm+dxbFRXYFiU1y1td4hLZT56G4D6lZrYM/rjg1IWGpZoE86vTdUZF/qHuaVMGr/YWHJHKBpThhm5yGAhmNssQndPe+F7tA74jkMl8xFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCxUy00b; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCxUy00b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776982076; x=1808518076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QGpcg/EhCTeK5FmLAZcXD6lY35PV/QOXSecMjf1KHK4=;
  b=jCxUy00bAn6zUc1m+L7Y/KbxnG8sFCY+4RC/3sCWLYjOV1AqGjoa/B9C
   PwrEBO8+ztNxZoHPuLdZHI5xeogzfP0TgI4gs263MisHns5OY18FjjUlI
   4DZmmnErYH1xt3CylS8jyXLQ4O/7U099OV0cFgLrM5/catIEr99o+LGYN
   vwvVWRu+wrihMnW+3zMrkFis2yRAN5R5li6MLPc4dn0miH98PcgbD8vY9
   d2YIC0zcdFf+6ftWQZz1wDEW0WSumkooF/dbn8S0IjoMco6EiwiGVDAYp
   usdtMtAUokD3wXSx9Dey0NQIJCcIdgKsK5ars+esPxl66zMWuQigT+TFM
   g==;
X-CSE-ConnectionGUID: e1f6rVfBQZS0V/GMjr7+ZA==
X-CSE-MsgGUID: r1s5zPbZRBemZJw8hme7/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="103425232"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="103425232"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 15:07:56 -0700
X-CSE-ConnectionGUID: EQBLItUWTeurYKIf1aCy0w==
X-CSE-MsgGUID: 2DqEKS5kTW2hI8GBE0Jsvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="236764761"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.37]) ([10.125.108.37])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 15:07:55 -0700
Message-ID: <52e82a4d-39f9-40ff-a78a-5b09e0813018@intel.com>
Date: Thu, 23 Apr 2026 15:07:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 0/8] Type2 device basic support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 djbw@kernel.org, edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/26 11:05 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> I feel this version suits better a RFC based on v25 plus the changes
> introduced. It tries to address the problem of user space actions
> triggering accelerator region removal, and extending Dan's approach
> in here:
> 
> https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#m2d9e5c59ce4873641037f9bcd2f70d5679cda03c
> 
> As discussed there, the protection needs to cover the accelerator driver
> handling of the region physical range for things like ioremap, and to
> offer a way for such driver to undo things or at least stop using that
> very same physical range if the region disappears. It ends up merging
> several of v25 patches into just one.
> 
> Another change is linking the region release to the endpoint device and
> keep with Dan's autoremove. This makes unnecessary the previous cxl_exit
> and similar actions are now performed inside region detach callback.

So this would only work if the region is single device right? Which is fine for initial implementation. Maybe make a comment in the code that this is the assumption being made for the person one day needing to deal with the possibility of interleaving.

DJ

> 
> I think the outcome is quite promising, lowering the accelerator driver
> complexity regarding region handling. The cost is those new callbacks
> which I think are totally necessary for doing things safely with the
> region by the driver.
> 
> I have successfully tested the cases of cxl_acpi removal while sfc
> driver remaining, and cxl_mem unbinding sfc cxl memdev.
> 
> v26 changes:
>  - patch 6: it implements all the new functionlity described above.
>  - patch 8: region detach callback invokes a new sfc function for safely
> 	    stopping cxl-backed piobufs use.
> 
> Alejandro Lucero (8):
>   sfc: add cxl support
>   cxl/sfc: Map cxl regs
>   cxl/sfc: Initialize dpa without a mailbox
>   cxl: Prepare memdev creation for type2
>   sfc: create type2 cxl memdev
>   cxl: attach region to an accelerator/type2 memdev
>   cxl: Avoid dax creation for accelerators
>   sfc: support pio mapping based on cxl
> 
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/mbox.c               |  51 +---------
>  drivers/cxl/core/memdev.c             |  81 +++++++++++++++-
>  drivers/cxl/core/pci.c                |   1 +
>  drivers/cxl/core/port.c               |   1 +
>  drivers/cxl/core/region.c             | 125 ++++++++++++++++++++++++-
>  drivers/cxl/core/regs.c               |   1 +
>  drivers/cxl/cxlmem.h                  |   6 --
>  drivers/cxl/cxlpci.h                  |  12 ---
>  drivers/cxl/mem.c                     |  45 ++++++---
>  drivers/cxl/pci.c                     |   1 +
>  drivers/net/ethernet/sfc/Kconfig      |   9 ++
>  drivers/net/ethernet/sfc/Makefile     |   1 +
>  drivers/net/ethernet/sfc/ef10.c       |  72 +++++++++++++--
>  drivers/net/ethernet/sfc/efx.c        |  14 ++-
>  drivers/net/ethernet/sfc/efx.h        |   1 +
>  drivers/net/ethernet/sfc/efx_cxl.c    | 128 ++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    |  31 +++++++
>  drivers/net/ethernet/sfc/net_driver.h |  12 +++
>  drivers/net/ethernet/sfc/nic.h        |   3 +
>  include/cxl/cxl.h                     |  25 +++++
>  include/cxl/pci.h                     |  22 +++++
>  22 files changed, 552 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081

