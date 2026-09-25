Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50125509F17
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376809; cv=none; b=tusSnTOBcX318CpbU9jD1ODA9H4rrVC47FjBKeaCp4Qq0vaZx8NV9cimHJtqUQ+NVVQ8pQPYC+wDgU7RAv4DXLziEbxBGzU9/jiwJQto4WPw/yP8s2HiVybc6kkc+mFOODg4+uhfahYDii6zY4eLb3bTxL4MFmQ+4I//h1Lmfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376809; c=relaxed/simple;
	bh=U0HJas1K3gioiJBsqieLjBp5aWapuO00Sncy5EtZ4pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIk0cFFFMqEk2rYIGkMgm7FvqkpODnVB0gUobUaqPAtxysbpRa1lBf+LCb2UHiuDd1seht45H8HNiR9x54JW+ETH92X04fbe6NMYFOXIgfjK+7rCyb/NqTirSsr5DZo3hmuOHqc2O/zOiYoK9v3F75PIeXyoKb7CeqpuZ7bZjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRKocq3N; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRKocq3N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790376806; x=1821912806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U0HJas1K3gioiJBsqieLjBp5aWapuO00Sncy5EtZ4pY=;
  b=QRKocq3NA7f37RzNyM5yHPxFD6sHJILAmGowqe+/tZSFZKiXUayCUh/J
   OeKEmwxju0Aci7K7NCFiK8aRnNE0N4B4tAUwi+4fo0QW+kkiuxJ0gwIz5
   5TtW52uWFnzBF3XqRFU/8/mwD1e9F/E3nyk8NpUOTN6lSuKNH2bYAlIwF
   kgbu6VsV9lMiLVNd0hPi+bNXS4FOUAC7P01M2zZnyMosAMW2LTPdfn0pP
   T8wKOfmU1pCQCC68zzLD3DPByWc93nyGYRFx30kfPgY6kT2ryoY3J6teN
   tDzHgxXbtYp6hEuXuPwSxwgqRO12WyNyOHAefheUu9OVD54WSMfS5DLD2
   A==;
X-CSE-ConnectionGUID: swoZxY5AQK2AWWmIDyfTAw==
X-CSE-MsgGUID: VWqQBeKmQbWIo7L+IPqlrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="89935663"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="89935663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 15:53:25 -0700
X-CSE-ConnectionGUID: iop7bXIZRbuYmH2wqJAl5Q==
X-CSE-MsgGUID: Cvjkh/bHSOuJ8W3eSe/4yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; 
   d="scan'208";a="273557074"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.110.251]) ([10.125.110.251])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 15:53:24 -0700
Message-ID: <a266e6db-eb28-4ca9-9214-de62df8b10b0@intel.com>
Date: Fri, 25 Sep 2026 15:53:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Store event records for EDAC repair regardless
 of tracing
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 ming.li@zohomail.com, icheng@nvidia.com
References: <20260924212320.56573-1-dave.jiang@intel.com>
 <20260925234425.67be0e2e@jic23-hlaptop>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260925234425.67be0e2e@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/26 3:44 PM, Jonathan Cameron wrote:
> On Thu, 24 Sep 2026 14:23:20 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> The driver throws away media error records unless a tracepoint is enabled.
>>
>> cxl_event_trace_record() stores general media and DRAM records for EDAC
>> repair, but both calls sit inside a block gated on the cxl_general_media
>> and cxl_dram tracepoints. That gate only exists to skip the DPA-to-HPA
>> lookup used to annotate those tracepoints. Storing a record does not need
>> the lookup.
>>
>> With both tracepoints off, two things break. The kernel clears the device
>> event log either way, so the records are destroyed in hardware and kept
>> nowhere else. And live repair stops working altogether: sPPR and memory
>> sparing require the target DPA to have reported an error, no DPA ever has
>> a record, so every request fails with -EINVAL.
> 
> Hi Dave,
> 
> Given userspace is always in that path (I think), without the
> tracepoints being enabled it will be one impressive guess to
> successfully make repair happen - you'll have to magically know
> what address will see a hit in the stored error records.
> 
> Maybe that happens in some test case, but it doesn't feel real
> to me.

If you don't think that's possible then I'll drop the patch.

DJ

> 
>>
>> Move the two stores ahead of the tracepoint check. Keep them under the
>> memdev lock, which is what stops err_rec_free() from freeing
>> cxlmd->err_rec_array while the CPER callback runs. Leave the region and
>> DPA rwsems with the lookup.
>>
>> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> 
> Why the fixes tag?   Maybe this is enabling something new that is
> useful but I'm not immediately understanding what was 'broken' before.
> 
> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Assisted-by: LLM
>> ---
>> Found by reviewing the gate, not from a failure report.
>>
>> The documented flow is unaffected, which is why this has gone unnoticed:
>> rasdaemon watches the tracepoints, so they are on and the records exist
>> (Documentation/edac/memory_repair.rst:94-97). Offline repair is unaffected
>> too, since both checks sit under cxl_is_memdev_memory_online():
>>
>>   edac.c:1807  sPPR     -EINVAL when neither cxl_find_rec_dram() nor
>>                         cxl_find_rec_gen_media() finds a record
>>   edac.c:1357  sparing  -EINVAL when cxl_mem_get_rec_dram() finds none
>>
>> The unconditional log clear is at mbox.c:1115, after the record loop.
>>
>> The memdev lock has to cover the store. err_rec_free() is a devm action on
>> &cxlmd->dev (edac.c:2021) that NULLs err_rec_array and frees it, and the
>> CPER path (cxl/pci.c:1053) can run while cxl_mem unbinds. Hoisting the
>> stores out from under guard(device) would trade the gating bug for a
>> use-after-free.
>>
>> The casts on cxlmd go away because the parameter has not been const since
>> dc372e5f429c ("cxl/pci: Hold memdev lock in cxl_event_trace_record()").
>>
>> Tested in QEMU with cxl_test. kprobe entry counts over the same 220 mock
>> event records, using cxl_event_trace_record() as the control:
>>
>>   tracepoints off      control   store_gen_media   store_dram
>>     before                 220                 0            0
>>     after                  220                22           33
>>
>>   tracepoints on       control   store_gen_media   store_dram
>>     before                 220                22           33
>>     after                  220                22           33
>>
>> Records are kept with tracing off, and the tracing-on path is unchanged -
>> the hoist neither drops nor duplicates a store. The guest log shows
>> cxl_clear_event_record() draining the device log in both cases, so the
>> records really are gone from hardware whether or not the kernel kept them.
>> Builds warning-free with CONFIG_CXL_EDAC_MEM_FEATURES=y and disabled.
>>
>> Not covered: the -EINVAL itself. cxl_test mocks no sPPR or sparing feature,
>> so the repair path cannot be driven end to end.
>>
>> Left alone to keep this minimal: the WARN_ON_ONCE checks on the AP/CME
>> counter-expire descriptor (mbox.c:952-964) stay inside the gate, and are
>> arguably mis-gated for the same reason.
>> ---
>>  drivers/cxl/core/mbox.c | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 55828a836c01..89fb2f569e4b 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -913,6 +913,22 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>>  		return;
>>  	}
>>  
>> +	/*
>> +	 * EDAC memory repair looks these records up from the current boot, so
>> +	 * store them whether or not tracing is enabled. Hold the memdev lock
>> +	 * across the store to keep cxlmd->err_rec_array alive against a
>> +	 * concurrent cxl_mem unbind.
>> +	 */
>> +	guard(device)(&cxlmd->dev);
>> +
>> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>> +		if (cxl_store_rec_gen_media(cxlmd, evt))
>> +			dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
>> +	} else if (event_type == CXL_CPER_EVENT_DRAM) {
>> +		if (cxl_store_rec_dram(cxlmd, evt))
>> +			dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
>> +	}
>> +
>>  	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
>>  		u64 dpa, hpa = ULLONG_MAX, hpa_alias = ULLONG_MAX;
>>  		struct cxl_region *cxlr;
>> @@ -922,7 +938,6 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>>  		 * translations. Take topology mutation locks and lookup
>>  		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
>>  		 */
>> -		guard(device)(&cxlmd->dev);
>>  		guard(rwsem_read)(&cxl_rwsem.region);
>>  		guard(rwsem_read)(&cxl_rwsem.dpa);
>>  
>> @@ -937,9 +952,6 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>>  		}
>>  
>>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>> -			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
>> -				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
>> -
>>  			if (evt->gen_media.media_hdr.descriptor &
>>  			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
>>  				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
>> @@ -952,9 +964,6 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>>  						hpa_alias, &evt->gen_media);
>>  		} else if (event_type == CXL_CPER_EVENT_DRAM) {
>> -			if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
>> -				dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
>> -
>>  			if (evt->dram.media_hdr.descriptor &
>>  			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
>>  				WARN_ON_ONCE((evt->dram.media_hdr.type &
>>
>> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> 

