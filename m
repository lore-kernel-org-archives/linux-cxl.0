Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B9283FC9
	for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705410; cv=none; b=P9/BEwy63a/Wxw873VP8PqEJsbdXBFdblvSDJPbWvAPfGZW4RdiG0puhaOeTaP1Y/kNnY0i47iWpC9NYXxo1e19dx915yaJZa+q1QRu9VvpJpDdz5armodHvVjRQnTfHn4zO17atw0M8Lxlyx8me9CblnSEz8J47+QIzuWm1cQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705410; c=relaxed/simple;
	bh=VG/yhmxYERQ/SFRSPvW7nTqwPUcWBhqUndfOmXwFYdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFt/rI43VlzYZWnWOHnitjY82809E0P5f2Bo+AQVWfK4Yj1S/AcntwBzzkVr1QAZiiBKHbazk+6GutN6O9l2W07thKPHJ+BmFOVN9hDe+SrznDAncTPqeXyilmrOMVNUqdVuo8xnbnqly5Wr3ZpkPUMIn/OzL2E99wUK6crOKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PduIZ8EW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PduIZ8EW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773705409; x=1805241409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VG/yhmxYERQ/SFRSPvW7nTqwPUcWBhqUndfOmXwFYdw=;
  b=PduIZ8EWqLDWENKrk5e4vUqVPVa6Tp1qRFkrQlVCLECuGFA81e4eGIQ9
   FIvjoRwY+6blej1HW1TR77fayuR9s1v3sAT32nyqHQeJOQfo19CdPRLON
   dfhCH/KQLTNTMN5DrDv7Vd65YmcdwF2dWLnja/uXnSoheCOms1n+hmOQM
   zEmyscQi0BDYnAFcne2mk2bsBsBFhLlFkrGGbL3SQ2ACsdU0mh/+ECGf+
   iWBftijTQzUpqymEJFvebjBQP75tQ3bqelGmLvLROcz8SLJBaPzRZU9Kz
   jEApNlQHkYAKyGZqhzdUVEUNlDyUvOMnnn4sSmvRDBfMvBjIzoF/NHfVe
   g==;
X-CSE-ConnectionGUID: xRYFaS8qRJ6nk/tW1sDjQA==
X-CSE-MsgGUID: PTGqqJB5TYihGZZNj+tTCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74622879"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74622879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:56:48 -0700
X-CSE-ConnectionGUID: ETALpoD8R9O4BqEBuMilfQ==
X-CSE-MsgGUID: HIZwM8cPTze+1wFnA+AhjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="216523849"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.111]) ([10.125.108.111])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:56:47 -0700
Message-ID: <fce194f4-3fb9-4e7e-907f-e6ea14a3782b@intel.com>
Date: Mon, 16 Mar 2026 16:56:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] type2 support preparation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, gourry@gourry.net
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/26 9:47 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> For facilitating the integration of type2 support, here it comes the
> first patches to be applied in preparation for impending type2 drivers.
> 
> FWIW, the first two patches are a split of first patch in v23, while the
> third patch is the third patch in v23.
> 
> Not sure if I should have added the review tags as the code has not
> changed, but maybe better a clean start.
> 
> v4 changes:
> 	- clarify code removal in patch 4
> 	- fix commit author in patch 4
> 
> v3 changes:
> 	- fix commit (Greg, Jonathan)
> 	- fix member field comment (Jonathan)
> 	- add patch for removing redundant call in moved code (Greg)
> 
> v2 changes:
> 	- fix nit (Allison)
> 	- rephrase commit (Allison)
> 
> Alejandro Lucero (3):
>   cxl: support Type2 when initializing cxl_dev_state
>   cxl: export internal structs for external Type2 drivers
>   cxl: Move pci generic code
> 
> Gregory Price (1):
>   cxl/pci: Remove redundant cxl_pci_find_port() call
> 
>  drivers/cxl/core/core.h      |   2 +
>  drivers/cxl/core/mbox.c      |  12 +-
>  drivers/cxl/core/memdev.c    |  24 ++++
>  drivers/cxl/core/pci.c       |  57 +++++++++
>  drivers/cxl/core/regs.c      |   1 -
>  drivers/cxl/cxl.h            |  99 +--------------
>  drivers/cxl/cxlmem.h         |  86 +------------
>  drivers/cxl/cxlpci.h         |  13 ++
>  drivers/cxl/pci.c            |  84 ++-----------
>  include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/mem.c |   3 +-
>  11 files changed, 338 insertions(+), 269 deletions(-)
>  create mode 100644 include/cxl/cxl.h
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

Applied to cxl/next

58f28930c7fb cxl: Move pci generic code from cxl_pci to core/cxl_pci
005869886d1d cxl: export internal structs for external Type2 drivers
9a775c07bb04 cxl: support Type2 when initializing cxl_dev_state

