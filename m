Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A337754B
	for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705482; cv=none; b=hYWNKnFw9EcdvkdNBPmg9ZMvD8U0t8o+v0EkkiZkDhpw7MJ7pV5yFstpvWBKrbDG+TZhQ5b+QhlrOVxejc089uluJdQN36VsGy80lwA8E3QeQf27uClJriCndxAESdh/LfPj7QfF0l3TNx0KJm3EG95//JDp+pVfb518CPdcp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705482; c=relaxed/simple;
	bh=p4XUO2M01QPGPMnIXZIEkgOXDr7X702oEp/xyj0eCDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBvim8gNUkSstgKXqIPbgMiEDB1MmvKH67BHd7Ll6s824A4ekWrFdv1o30GrXAUA0oXX5uGmkak9i2Jam5FKiHG/MoQgRqucy1wgCP0JMMdcCpT+QGzzaZrfU9F7fHi6tLJ05NhvmnM6CRtnl1yJOhnlJgCOJ3CGpHH4IwH+jaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ef2YV1xJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ef2YV1xJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773705481; x=1805241481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p4XUO2M01QPGPMnIXZIEkgOXDr7X702oEp/xyj0eCDE=;
  b=Ef2YV1xJ29k61z5hh8boi/vVaboUQ7ebACUauO3aTHKQizVjIpO8A+7g
   vXsYUo7sT/ILk3LSJsJHkDENLChSbTT5QjER5+EdHy00jNPhYnf1SgARM
   xHNTK+aDAO6BI3lcIry29qYwMV753OCiawD92msTzBHXEKPK+ii0NIBCP
   1WTaARU/Tp8T76T5K26i5a6R6ewMThk74pD7mwYBqMkwJnnORee/mHpsR
   gDfhnMDUJSar0XxwOZp+2fV4vr3P7jhoSg8rjvhNjDvxQAb5r9WnF8PFR
   HCuBrxpgZkLnLXcOoAaas0ZYIMVaXoYKYfgpOhzEeYQvxQsyte0vcYC+1
   Q==;
X-CSE-ConnectionGUID: 8pVDN3gKRXqMaZqVTsCLjQ==
X-CSE-MsgGUID: y1yIlze5Ro295dVqr1NXBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74765390"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74765390"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:58:01 -0700
X-CSE-ConnectionGUID: Co/qpMm0QJqDTJTzDe6nUg==
X-CSE-MsgGUID: Emk9TpWmT12fB6tU6+fCcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="252586301"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.111]) ([10.125.108.111])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 16:57:59 -0700
Message-ID: <fe2d131f-777d-4add-bf21-86e19fce2e03@intel.com>
Date: Mon, 16 Mar 2026 16:57:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] cxl region changes for Type2 support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/26 10:36 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for Type2 devices/drivers support, these next patches
> adapt the cxl region code for required Type2 functionality preserving
> current functionality.
> 
> v3 changes:
> 	- fix type conversion in patch 2 (Allison)
> 	-fix commit (Jonathan)
> 
> v2 changes:
> 	- fix commit in patches 2 and 3 (Dave)
> 
> Alejandro Lucero (3):
>   cxl: Make region type based on endpoint type
>   cxl/region: Factor out interleave ways setup
>   cxl/region: Factor out interleave granularity setup
> 
>  drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 31 deletions(-)
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

Applied to cxl/next.
64584273dfb8 cxl/region: Factor out interleave granularity setup
29f0724c4592 cxl/region: Factor out interleave ways setup
09d065d256b1 cxl: Make region type based on endpoint type
d537d953c478 cxl/pci: Remove redundant cxl_pci_find_port() call
