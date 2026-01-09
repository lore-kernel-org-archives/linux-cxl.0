Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000236402D;
	Fri,  9 Jan 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975711; cv=none; b=SzBM2A3d3gwc/HarmUD52Vx22aE8dNbnOCoxlvKAXLHMLStMp2gVUK/LG0BQ/y5xoil2L8frLZI/D867A/MRVpuLtx7D7+fBCXkIVMaACQe+KtlY8Ju5T/vi6ie5p++LRctFJGvoXEdR26BUr2A3SpXBcflGWCZYCwGAh7A4feA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975711; c=relaxed/simple;
	bh=o8t9J5XbvhInWoaQg8yWQZyxOVWBL+fxEY2ixp00ulA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FbOqwvoo6p4lOsiwhXR425c/ePpajvazc7wXA/wAa/NRMrRnM0DS2W03PlazyBDCBMar8IOmYKHhcrjbVAIHcVoYWjhd4OfmrDDU0OXojKiC+6sYQKiyWwh+dh7i9pJ1Z9Q/mFlCLJKEUMXpxZSVWdImJ0KIIqTPisIt/1ciqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2E9XZAO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2E9XZAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767975710; x=1799511710;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=o8t9J5XbvhInWoaQg8yWQZyxOVWBL+fxEY2ixp00ulA=;
  b=A2E9XZAOj7QuGREt91etZY7+Z0LLVVcjYgKMynLqNBcD4UaydetI5vpA
   dEGaHbjZFdz1GuajL5qaGSnSX67za9hm8NvlAzbmQqYgeReXXV3EoJ5hy
   FvVIKwiFjHBCZnxu5L2SnBjSD80nZBySGeZfktqBIoJ8K5KTiDaeAU6q2
   Htp00pztkBTmbi5MEPOo+gNYQxSwrQOp5pcXUFnde919jKacFZ/CSNaAn
   SH5y0z/71o+uVSISHYfmyxj2CExm+DtmvQ/QlnpIXy406br5+TPNH179c
   olSXUBcpkRom7uTbiB/0fS0x4DfFPpyDT3aaY+N2Fa9sCRCjubpmZv3Hu
   w==;
X-CSE-ConnectionGUID: C/dsiZkTQQOG+dC71lkGdg==
X-CSE-MsgGUID: +mtkl2nRQ26188RsMD2jPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="68558152"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="68558152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 08:21:49 -0800
X-CSE-ConnectionGUID: 5YTjsx0eS7O5AEtsCFngPg==
X-CSE-MsgGUID: 7YoM1O2DRUmbrRBJouMRxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203129137"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 08:21:48 -0800
Message-ID: <0fa5f0ab-ad71-4a3a-bf31-1b04225d3552@intel.com>
Date: Fri, 9 Jan 2026 09:21:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cxl/hdm: Fix newline character in dev_err() messages
From: Dave Jiang <dave.jiang@intel.com>
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260109122952.639231-1-rrichter@amd.com>
 <abb4fedd-df10-4993-9567-9be185094d6a@intel.com>
Content-Language: en-US
In-Reply-To: <abb4fedd-df10-4993-9567-9be185094d6a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 9:16 AM, Dave Jiang wrote:
> 
> 
> On 1/9/26 5:29 AM, Robert Richter wrote:
>> The newline character is not placed at the end of the string. This
>> causes unintended line wraps, broken log level and unterminated log
>> messages. Fix that for all messages.
>>
>> Note that the messages are changed to use colons now instead of
>> parentheses, which is more common use.
>>
>> Fixes: 24b18197184a ("cxl/hdm: Extend DVSEC range register emulation for region enumeration")
>> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> ---
> 
> Applied to cxl/next
> 4c9922387b35b325a645cc42f8daf9a9e4db690b

Actually 0db2344eb8a8a9451cf4f7b9b25e7a0247476813. For some reason b4 kept picking up two other patches from you Robert. I didn't notice until I pushed. Had to fix that.


> 
> 
>>  drivers/cxl/core/hdm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 031672e92b0b..28611b350cf6 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -966,7 +966,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
>>  	if (rc) {
>>  		dev_err(&port->dev,
>> -			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
>> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
>>  			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
>>  		return rc;
>>  	}
>> @@ -1117,7 +1117,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>>  	if (rc) {
>>  		dev_err(&port->dev,
>> -			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
>> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
>>  			port->id, cxld->id, *dpa_base,
>>  			*dpa_base + dpa_size + skip - 1, rc);
>>  		return rc;
>>
>> base-commit: 88c72bab77aaf389beccf762e112828253ca0564
>> prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021
>> prerequisite-patch-id: c142edda207a3a69ae242182e51e9a8b8d78cf72
> 
> 

