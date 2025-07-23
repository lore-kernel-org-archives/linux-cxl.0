Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7501E7C08
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308729; cv=none; b=MTLIBs5zRWZeTaajkPunVdvKRbs3TgWO7VXJ4gL12UcJKZY88s9JzGU5S2qmBPE7X7ZxbQRNouVS42VFrguq4k5zs1CbHI+UautvtcANDZAnl5UvUrn1SyR3XJ4zdGqVHEGul8yU0a5IVMeTei3hGiqTTHDiXeNRpvRVwL2p1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308729; c=relaxed/simple;
	bh=4iktC47rTN/UEdFCbVKHySx/VqvAqfEQ/bnunuKt7EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmB0yfx0Mq9UpJa2E4n1NJccR9AWl0LIFqB7KJaiC+TsPdzYOYGCS6RjYQnaerCwPUld4MStFaL6BwtQEaLtiMoKFp0ixMYh6y1eLt3GhD/pKPP35ksmJOKtaLW1Kv228wHuk7Xv6jI4TDas2UuVWilrO4RIV4rCHJFdw2m23No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aN4kdqhT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aN4kdqhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753308727; x=1784844727;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4iktC47rTN/UEdFCbVKHySx/VqvAqfEQ/bnunuKt7EM=;
  b=aN4kdqhT+xczKLbcAUarNHj+t2V5+x7RfShQLdYjGAVxnNnp6doofwzE
   gmBWpaXdyxtMiNmc5W62lii2iCI47Jx5pGwuud3Y25S0AFOBtTD9uwB5l
   Y3v9EGZ1kWPonVu4SdlL3ZKjQF1ePJ+DSxed+1YGIHaW0d48vLb+2LRD/
   Z7WhiXYZQBf5D7cAesmkCnRp1inANhE2np5FW/acUUpARqYnbFBfoM8ZE
   drnFsbkzNZNRrebgGlGl6m9HxtpjMBHkesXY1c3ybEYc6KqDiMd6rTj3r
   aOjywnctM2Q37xz0NdEgKBI1QeL9rJyvgGP+wBTLlY0BmzvMqrAokz4ud
   w==;
X-CSE-ConnectionGUID: Bg5NHwnJQtiXKI1BMPNyRA==
X-CSE-MsgGUID: lODtJKH1QP+9QEMlkY+fFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55566366"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55566366"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:12:07 -0700
X-CSE-ConnectionGUID: GEhbTg9xQ2Ktye+5sTtCFA==
X-CSE-MsgGUID: x2iwiCc2RqySvgwahfj1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="165207242"
Received: from dustinle-mobl1.gar.corp.intel.com (HELO [10.247.118.179]) ([10.247.118.179])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:12:01 -0700
Message-ID: <d785a404-dcb1-49e5-9930-819ba6e2a8d8@intel.com>
Date: Wed, 23 Jul 2025 15:11:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: "Bowman, Terry" <terry.bowman@amd.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
 <2ec323cd-0c20-4ab8-93fe-58373f2c7a54@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2ec323cd-0c20-4ab8-93fe-58373f2c7a54@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/25 2:35 PM, Bowman, Terry wrote:
> On 7/21/2025 12:04 PM, Dave Jiang wrote:
>> Remove from core/pci_aer.c and move the CONFIG_PCIEAER_CXL ifdef to
>> cxlpci.h to deal with the exported symbols as needed. There is enough
>> AER handling code (and more to come) to move the AER code to its own
>> C file.
>>
>> Cc: Robert Richter <rrichter@amd.com>
>> Cc: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Address 0-day reprot of cxl_handle_rdport_errors symbol undefined
>> ---
>>  drivers/cxl/core/Makefile  |   1 +
>>  drivers/cxl/core/core.h    |   9 ++
>>  drivers/cxl/core/pci.c     | 171 +------------------------------------
>>  drivers/cxl/core/pci_aer.c | 168 ++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h          |   8 --
>>  drivers/cxl/cxlpci.h       |   8 ++
>>  tools/testing/cxl/Kbuild   |   1 +
>>  7 files changed, 189 insertions(+), 177 deletions(-)
>>  create mode 100644 drivers/cxl/core/pci_aer.c
>>
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 79e2ef81fde8..bcea856157af 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>> +cxl_core-$(CONFIG_PCIEAER_CXL) += pci_aer.o
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 29b61828a847..96c319c66a48 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -136,4 +136,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>  		    u16 *return_code);
>>  #endif
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>> +#else
>> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
>> +#endif
>> +
>> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
>> +
>>  #endif /* __CXL_CORE_H__ */
> 
> Hi Dave,
> 
> Any reason not to pull in cxl_handle_cor_ras()/cxl_handle_ras() into pci_ras.c?
> These 2 functions read the RAS from the register block and then call the trace routine.
> These are only called by the handlers in pci.c. I think it might round-out your changes 
> nicely if they are moved into pci_ras.c s.t. when CONFIG_PCIEAER_CXL is disabled then 
> they are do nothing. Or another way to look at it is they should only be enabled if 
> CONFIG_PCIEAER_CXL is enabled.
> 

Missed them. Yes I can do that.

> -Terry
> 
> [snip]
> 
> 

