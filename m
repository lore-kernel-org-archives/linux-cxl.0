Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D261DA21;
	Thu,  6 Jun 2024 01:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636601; cv=none; b=rXaDESWbi/GZGldNdBOMBOH94oP0J4p5wsK9ToV7/bIGQN2bh2lT03Byt9d9he5HuPeHTtPVA7dIYddLLEZcHNTpB5zah+dTwkwZGW4vvesl4VOj60PjBZECR/S5elxRDE7seQ9aJFbAXkq3QZTg0NSgPEaYTiVOY0ieX5Fs9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636601; c=relaxed/simple;
	bh=XatycHO7VMZ0EQIY9hx3Nb47G42PwMSEtepwIgWK9Jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oY3kjybidHJHuTTL4zCIbhRYDIK615vaT5GIeL9VSb1VU3dYnErEy9+tCAq9+S5/EWyCufDJT4wAXfJ755nuZ78TUflsKg6JsbwfDEL3zwzWf5IFAydoDdFu5brZQGkSGKEGvU7g/RFREUz5NeQqDZSlfKhEjGdc9VkpRonmER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQ5Kg11C; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ5Kg11C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717636599; x=1749172599;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XatycHO7VMZ0EQIY9hx3Nb47G42PwMSEtepwIgWK9Jc=;
  b=SQ5Kg11Cbq0iyrslOy8GS25ip3d5QDOLRiFzOY0nYaOVzaZxORTskma2
   /VqBBlY6dS7Pccji7FmDJXKUA8UGUNo8yON4H27dAvgIXzdS/7ifbjL97
   kt1MjfHpSRA2bMiLWabSkUjTpktqhUTLY3NZwtD1KIEQcNsZguv8pnTF6
   IpBNBMDb0POCZx04Fdo2SZit4PbpnNKP75nXKbhuTvPrEvWIqoGTppdzS
   62rqWoFB0hQS4fprrQ7p7iPcQ+bAT+Ra5KqzCvTYcRIYJ03PxvXZdZLOH
   ZN/aE7CbcaaMuuAVGTbMIXOZ7ugGwYpH1lCvEZEOqZAcHvQbN4GUKzbPA
   Q==;
X-CSE-ConnectionGUID: 58JHEeOIQ8uEyYTrwuhnDA==
X-CSE-MsgGUID: hCwDcudWQfG3ly8DInU5iQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14084237"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14084237"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:16:38 -0700
X-CSE-ConnectionGUID: a8eyrfpRT0qJ8CG6gZ8upw==
X-CSE-MsgGUID: XBW1xq7LQ3a/4IBtNPoV9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37889884"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:16:36 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Bharata
 B Rao <bharata@amd.com>,  "Alistair Popple" <apopple@nvidia.com>,  "Aneesh
 Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] cxl/region: Support to calculate memory tier abstract
 distance
In-Reply-To: <20240605131017.000069b6@Huawei.com> (Jonathan Cameron's message
	of "Wed, 5 Jun 2024 13:10:17 +0100")
References: <20240531024852.282767-1-ying.huang@intel.com>
	<20240605131017.000069b6@Huawei.com>
Date: Thu, 06 Jun 2024 09:14:45 +0800
Message-ID: <87a5jy98je.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Jonathan,

Thank you very much for review!

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Fri, 31 May 2024 10:48:52 +0800
> Huang Ying <ying.huang@intel.com> wrote:
>
>> To place memory nodes backed by CXL regions in the appropriate memory
>> tiers.  So that, pages can be promoted/demoted with the existing
>> memory tiering mechanism.
>> 
>> The abstract distance is calculated based on the memory access latency
>> and bandwidth of CXL regions.  Which in turn comes from the HMAT
>> and CDAT, etc.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> Minor comments inline.  Otherwise, looks good to me.
>
> Jonathan
>
>
>> ---
>>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>>  drivers/cxl/cxl.h         |  1 +
>>  2 files changed, 37 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 00a9f0eef8dd..1f8f71a034ae 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/uuid.h>
>>  #include <linux/sort.h>
>>  #include <linux/idr.h>
>> +#include <linux/memory-tiers.h>
>>  #include <cxlmem.h>
>>  #include <cxl.h>
>>  #include "core.h"
>> @@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>  	return true;
>>  }
>>  
>> +static int cxl_region_nid(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_region_params *p = &cxlr->params;
>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>> +	struct cxl_decoder *cxld = &cxled->cxld;
>> +
>> +	return phys_to_target_node(cxld->hpa_range.start);
>> +}
>> +
>>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>>  					  unsigned long action, void *arg)
>>  {
>>  	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>>  					       memory_notifier);
>> -	struct cxl_region_params *p = &cxlr->params;
>> -	struct cxl_endpoint_decoder *cxled = p->targets[0];
>> -	struct cxl_decoder *cxld = &cxled->cxld;
>>  	struct memory_notify *mnb = arg;
>>  	int nid = mnb->status_change_nid;
>>  	int region_nid;
>> @@ -2319,7 +2326,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>>  	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>  		return NOTIFY_DONE;
>>  
>> -	region_nid = phys_to_target_node(cxld->hpa_range.start);
>> +	region_nid = cxl_region_nid(cxlr);
>>  	if (nid != region_nid)
>>  		return NOTIFY_DONE;
>>  
>> @@ -2329,6 +2336,27 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>>  	return NOTIFY_OK;
>>  }
>>  
>> +static int cxl_region_calculate_adistance(struct notifier_block *nb,
>> +					  unsigned long nid, void *data)
>> +{
>> +	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>> +					       adist_notifier);
>> +	int region_nid;
>> +	struct access_coordinate *perf;
>> +	int *adist = data;
> Local style looks to be reverse xmas tree subject to any dependencies etc.

Sure.  Will change this to follow reverse xmas tree.

>> +
>> +	region_nid = cxl_region_nid(cxlr);
>> +	if (nid != region_nid)
>> +		return NOTIFY_OK;
>> +
>> +	perf = &cxlr->coord[ACCESS_COORDINATE_CPU];
>> +
>> +	if (mt_perf_to_adistance(perf, adist))
>> +		return NOTIFY_OK;
>> +
>> +	return NOTIFY_STOP;
>> +}
>> +
>>  /**
>>   * devm_cxl_add_region - Adds a region to a decoder
>>   * @cxlrd: root decoder
>> @@ -2380,6 +2408,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>  	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
>>  	register_memory_notifier(&cxlr->memory_notifier);
>>  
>> +	cxlr->adist_notifier.notifier_call = cxl_region_calculate_adistance;
>> +	cxlr->adist_notifier.priority = 100;
>> +	register_mt_adistance_algorithm(&cxlr->adist_notifier);
>> +
>>  	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>>  	if (rc)
>>  		return ERR_PTR(rc);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 603c0120cff8..6891f87f8ef7 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -534,6 +534,7 @@ struct cxl_region {
> This has docs that need an updte.

Yes.  Thanks for reminding!

>>  	struct cxl_region_params params;
>>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>>  	struct notifier_block memory_notifier;
>> +	struct notifier_block adist_notifier;
>>  };
>>  
>>  struct cxl_nvdimm_bridge {

--
Best Regards,
Huang, Ying
