Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6E2F549F
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297524; cv=none; b=dc2AAxs/TiuckIMrHdhQ0FQslqG2lx7aBm9gOXcvqeOAh+aVAEhHco3pBs/iSD3kCdYpq2UfW/P9EKcZ7guBunglTBJ7Tv5LJTPDFdL5Zjr/i8su7FFdlem3pKQTaytm2Gai+YOwJ/RKCb60IwCrjrPyvzImdkPD7A/4+pnF1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297524; c=relaxed/simple;
	bh=NEqet6AF9jlRVfrcAPElX4TZ9RTmy2e5gEJDvwlGL1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6Qxof4T6O8VrP6v0nshdkX4mxo5Lr9GzlPtuS+dlCWOi32H2FH2k+110Dp313jZAs+alNnnXjIqzIcSKtGxTAOLyrdjWiPk31FReDbx0rhug+h7fRw6E4lB+64EfNFo9cqSSC4uuI0xJTWcgie2TzYxqkIrLjd1g2VA1qXwyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXvYxMaR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXvYxMaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781297524; x=1812833524;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NEqet6AF9jlRVfrcAPElX4TZ9RTmy2e5gEJDvwlGL1k=;
  b=HXvYxMaRZZFl2URfK0s1WSD0GwiySBZYXebVJ62w58Zle/xMO1RbQcDn
   E/s0GKY8fjhiCbjTlhC/3axODYrhH+zNd4qcy7MyZzl6yxnSKQq46k6E1
   WE6/ETOrGtKSSWwxy2Qk0T0nRiNtLRm9g1jpaJp5g/e/P6arF5O97PNbC
   EPfw8UekJlO9iIyMZ8fhi5pphcuhM+1baqHCB1e1pnfrKxr9r6jQOjDL4
   LXGiSTy9hdfybnCngb8fDUi0lUZABIXg0rWpv8BgM1bDLQWptixarXEPG
   qe+G7M/8nEMfEzuXlqYccsKfca6X+D+kP3zFRH8/NFC/jR03nGGSSNUxN
   A==;
X-CSE-ConnectionGUID: MnhdnLpARlm/hyyG1sKhCQ==
X-CSE-MsgGUID: bSH8jAtQRemHsOw6YOEx0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="104807247"
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="104807247"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 13:52:03 -0700
X-CSE-ConnectionGUID: 6PCLyedfSYe98lV9Q9qnGw==
X-CSE-MsgGUID: T89YQUQ9QbSgACe6qpVNnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,201,1774335600"; 
   d="scan'208";a="252016290"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 13:52:02 -0700
Message-ID: <1ed6abd1-fab9-44c4-87cb-9cb6061dbfed@intel.com>
Date: Fri, 12 Jun 2026 13:52:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cxl: Introduce devm_cxl_probe_mem() and fix region
 deletion
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Alejandro Lucero <alucerop@amd.com>, Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519210158.1499795-1-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 2:01 PM, Dan Williams wrote:
> The devm_cxl_probe_mem() helper creates a memdev and retrieves a mapped
> HPA range for the device. At present the retrieved region information is
> expected to be established by platform firmware. A future update will
> auto-establish a region if one is not already present. This arranges for a
> simple CXL topology detach == Accelerator driver detach scheme.
> 
> Now, automatic region establishment on behalf of an accelerator driver
> also requires automatic region teardown. The existing scheme of
> triggering devm_release_action() of a cxl root device to destroy a
> region is racy [1].  There is no path to coordinate multiple devres
> actions, or conflicting devres actions, without using the
> devm_remove_action_nowarn() workaround.
> 
> Instead, move final region cleanup responsibility to the root decoder
> teardown path (devres action cxld_unregister()). Expand the root decoder
> @range_lock, renamed @regions_lock, to coordinate region creation, sysfs
> manageability, and deletion. The @regions_lock also prevents regions
> from disappearing mid-auto-assembly.
> 
> Changes from the initial RFC [2]:
> * tested with Dave's type2 cxl_test
> * fix region remove by endpoints (Dave, Alejandro)
> * fix user triggered region remove (Sungwoo)
> * fix lifetime of the @attach ops (Alison, sashiko)
> * hide @attach details inside the CXL core
> 
> [1]: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
> [2]: http://lore.kernel.org/20260403210050.1058650-1-dan.j.williams@intel.com
> 
> Dan Williams (5):
>   cxl/region: Block region delete during region creation
>   cxl/region: Resolve region deletion races
>   cxl/memdev: Pin parents for entire memdev lifetime
>   cxl/memdev: Introduce cxl_class_memdev_type
>   cxl/region: Introduce devm_cxl_probe_mem()
> 
>  drivers/cxl/core/core.h      |   2 +
>  drivers/cxl/cxl.h            |   8 +-
>  drivers/cxl/cxlmem.h         |  27 +++--
>  include/cxl/cxl.h            |   3 +
>  drivers/cxl/core/memdev.c    |  20 +++-
>  drivers/cxl/core/port.c      |   7 +-
>  drivers/cxl/core/region.c    | 194 ++++++++++++++++++++++++++++++-----
>  drivers/cxl/mem.c            |  95 +++++++++++++----
>  drivers/cxl/pci.c            |   2 +-
>  tools/testing/cxl/test/mem.c |   2 +-
>  10 files changed, 297 insertions(+), 63 deletions(-)
> 
> 
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581


Applied to cxl/next
d8dcb0b74b04 cxl/region: Introduce devm_cxl_probe_mem()
2ed519c21bb4 cxl/memdev: Introduce cxl_class_memdev_type
bd3a6ff4b84e cxl/memdev: Pin parents for entire memdev lifetime
4dd86ca99ffc cxl/region: Resolve region deletion races
d91feb88692e cxl/region: Block region delete during region creation

