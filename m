Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72430259C
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211634; cv=none; b=Mm+Ob7mO/vHxxuCGd0fxFuViqwIrJrsmmgb0pTEajoAgqA5Dcu1SWr7AJwRj+Gw2lamidtJ4HJIHZFsuVPVUecXC0Jgc8AreJf4+6Z5oPo9iI7N5tdY+KWEfT3b5UG86PgEengxhcQukEy46pJdRlJF7PbdzzdcSI0pS+8vAEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211634; c=relaxed/simple;
	bh=WQQReIVKm8quBulAWcYs8tuHMsWmEpdBmRao9Ol022M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFWNgK286EdzoQwLUVg1y6aGyRS4KFFGS0+J8y8BGL1FRLWlp7KZgcWzC2wbpZlrZLTWc/Kan9TwcJ/5s8mUSkrzHipDERvjpKaS4uRDOJ8y5B5Io0NMNe4vjUWXFcX7OzvGoeygdB8zZV12B1pevfRX3rsSXcwJ02sr2NTcPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kl5lMmVX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kl5lMmVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744211633; x=1775747633;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WQQReIVKm8quBulAWcYs8tuHMsWmEpdBmRao9Ol022M=;
  b=Kl5lMmVX3nSo7XC06J3dD6MYz4PfofTm4NuKr6drmyceKaIGdEibyPUG
   DsA6zVPvbuHj/OrVcVhMnl2/ObXDpHmpdeM6eQ+ZgMIXOFoj5OycK/Stk
   Xh2qaPAq2VWJkxVbAUNyFmQRdJATScFPZrHYBfOr4gGzBGFxowCoGGEvf
   QJeu3YafKxT4czg1IITqggsub84f32YS+NhvfbAcRkEohLETJrzJ63sVb
   JmfFrdzLN6/g9fot6gs4PY/kVX5KKY+1l+PGYCR9GmAX4e0oT2m9qp2vV
   tWN7ax7FpRh/3t3l6byjV9MQgV8QDOzAqxCXPqZD6ijL051mkWrbzTuKj
   Q==;
X-CSE-ConnectionGUID: +0F+UBCfRQ+eKS7h0dOrdg==
X-CSE-MsgGUID: mijTwBhgRiuDe1Syb+Dz9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45585407"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45585407"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:13:52 -0700
X-CSE-ConnectionGUID: gOIQJTlqSMKtuzbaSzbUkw==
X-CSE-MsgGUID: e1J9zS2jS+GueSRWknmv6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="128598837"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:13:50 -0700
Message-ID: <43967129-86ec-4dbc-a065-11269e311fed@intel.com>
Date: Wed, 9 Apr 2025 08:13:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
To: Gregory Price <gourry@gourry.net>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Huaisheng Ye <huaisheng.ye@intel.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "pei.p.jia@intel.com" <pei.p.jia@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
 <02fbb2a7-3973-4c7f-8b7d-cfabbb379467@fujitsu.com>
 <Z_aAnzqR-UP9rmIY@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z_aAnzqR-UP9rmIY@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/25 7:13 AM, Gregory Price wrote:
> On Mon, Apr 07, 2025 at 08:31:13AM +0000, Zhijian Li (Fujitsu) wrote:
>> [1] https://lore.kernel.org/linux-cxl/20240409075846.85370-1-lizhijian@fujitsu.com/
> 
> After looking at this, I see why this hasn't been fixed in QEMU.
> Basically QEMU doesn't implement the right reset mechanism.
> 
> ct3_reset calls
> 	cxl_component_register_init_common()
> 		ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
> 				 HDM_DECODER_ENABLE, 0)
> 
> But it never resets MEM_ENABLE in the dvsecs.
> 
> I'm not sure it's sane for Linux to be trying to handle hardware that
> doesn't itself reset correctly - and doing this fix just for QEMU seems
> a bit too far.

I agree. No need to twist Linux in a bunch for something broken on QEMU. Until there's actual hardware that does this deployed in the field, we should just leave the Linux driver as is.

> 
> The correct fix here is building an accessor for the existing CXL dvsecs
> and updating it during ct3_reset.
> 
> ~Gregory

