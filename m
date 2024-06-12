Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3214696;
	Wed, 12 Jun 2024 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158270; cv=none; b=PQYAD25T/yfVG08xDL4WOCkPlOXcTHmRoriCbW8Z0b7k1uO+5fPotaUxBi9RmHWByL6kNyUC5+xmunRw/eyWpKjXfO3pXoPe4w5KztvXSoDICcYkEz1MlNOb3tTMs5bToTix3rkmWJjb5sT4n+QtSvXPb9COFX8kxYjrEWpsVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158270; c=relaxed/simple;
	bh=LWHVVPsFmew64zqAALVs4eh9lpfQHCEAvVdT/ITQtcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W9NYaWRY9DSJ4zPvK1pyW0uf/Mg/5uj9JzbvyxomLZ3S0zdt3wEtr8una0N634MtAF6CjJlCJvzgG0Apf5JVZBclYyQMQsRXyTo9t3xLT1oHjVhG9ykEJlvkFh226bhWmpKRwXFrNqMhuYtqIiZt3cT+CVQvL3w4KzANSp+Orjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSTDtDjT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSTDtDjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718158268; x=1749694268;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LWHVVPsFmew64zqAALVs4eh9lpfQHCEAvVdT/ITQtcc=;
  b=PSTDtDjTSAhpTR6upavYBeu6ob1VSFsPaDY9QOel3eHrpYPpXBYP9mXw
   +achaXyVyDHoq5MpSIiqrUXsYt7GQZqpC7qNtEvZZih49h/ACDB1g6lZ/
   Bx5m+68IzsQGEf0ppe+gaH8v++yZwnQ2JTvjbhEXY0b16YulVFMuuCWJf
   iI1usRqTv6fq+roEzFDB+NVMZAH/4l29dmGrrOP62DEL2vViu736xvC1m
   3nFp5l7jObui4o9K/hEAOQE3mh1rJ96Phg/jZdOTYAVVtpeYRotpp9/Zv
   akSkPxBPpHzmVxqem1rtCwFJI5sS8tbFSX8uAr3tNzyYnX7ZyVBRC+0Y1
   w==;
X-CSE-ConnectionGUID: kxL7B3awT7CnZOlWyattJg==
X-CSE-MsgGUID: zKWrA120QUegEDTdT9KROA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15072290"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="15072290"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 19:11:07 -0700
X-CSE-ConnectionGUID: yYK2WzgaRi28jJ38dXmMVw==
X-CSE-MsgGUID: LR+9Bc8VT6W+rqxM5B7A8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="44060310"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 19:11:06 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,
  Bharata B Rao <bharata@amd.com>,  Alistair Popple <apopple@nvidia.com>,
  "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH -V2] cxl/region: Support to calculate memory tier
 abstract distance
In-Reply-To: <ZmjBfcaosIlOODFR@aschofie-mobl2> (Alison Schofield's message of
	"Tue, 11 Jun 2024 14:28:29 -0700")
References: <20240611055423.470574-1-ying.huang@intel.com>
	<ZmjBfcaosIlOODFR@aschofie-mobl2>
Date: Wed, 12 Jun 2024 10:09:14 +0800
Message-ID: <87sexi7vzp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Alison,

Thanks for review!

Alison Schofield <alison.schofield@intel.com> writes:

> On Tue, Jun 11, 2024 at 01:54:23PM +0800, Ying Huang wrote:
>> To place memory nodes backed by CXL regions in the appropriate memory
>> tiers.  So that, pages can be promoted/demoted with the existing
>> memory tiering mechanism.
>
> How about more context for the unfamiliar because my first lookup was
> what's an 'abstract distance'? (not sure I even got it right below ;))

Sorry about this.

> An abstract distance value must be assigned by the driver that makes
> the memory available to the system. It reflects relative performance
> and is used to place memory nodes backed by CXL regions in the appropriate
> memory tiers allowing promotion/demotion within the existing memory tiering
> mechanism.

This looks good.  Will use it.  Thanks!

>> 
>> The abstract distance is calculated based on the memory access latency
>> and bandwidth of CXL regions.  Which in turn comes from the HMAT
>> and CDAT, etc.
>
> etc ?  
> I think the latency and bandwidth were already calculated, so you
> don't need to explain those. Perhaps drop the whole 'While in turn
> come from..." part.

Sure.

> a bit below...
>
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>> Changes:
>> 
>> v2:
>> 
>> - Added comments to struct cxl_region and minor fixes (Thanks Jonathan!)
>> - Link to v1: https://lore.kernel.org/linux-cxl/20240531024852.282767-1-ying.huang@intel.com/
>> 
>> ---
>>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>>  drivers/cxl/cxl.h         |  2 ++
>>  2 files changed, 38 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 3c2b6144be23..81d0910c0a02 100644
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
>
> I believe it's OK to send a resource_size_t to phys_to_target_node()
> like this:
>
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2308,10 +2308,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  static int cxl_region_nid(struct cxl_region *cxlr)
>  {
>         struct cxl_region_params *p = &cxlr->params;
> -       struct cxl_endpoint_decoder *cxled = p->targets[0];
> -       struct cxl_decoder *cxld = &cxled->cxld;
>
> -       return phys_to_target_node(cxld->hpa_range.start);
> +       return phys_to_target_node(p->res->start);
>  }
>

I believe this works.  But the original implementation is just a
mechanical code movement from cxl_region_perf_attrs_callback().  So, I
prefer to keep it stupid. Then, further optimization can be done on top
of it.  Is it good for you?

>
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
>> +	struct access_coordinate *perf;
>> +	int *adist = data;
>> +	int region_nid;
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
>> @@ -2371,6 +2399,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
>> index 603c0120cff8..f46252373159 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -522,6 +522,7 @@ struct cxl_region_params {
>>   * @params: active + config params for the region
>>   * @coord: QoS access coordinates for the region
>>   * @memory_notifier: notifier for setting the access coordinates to node
>> + * @adist_notifier: notifier for calculating the abstract distance of node
>>   */
>>  struct cxl_region {
>>  	struct device dev;
>> @@ -534,6 +535,7 @@ struct cxl_region {
>>  	struct cxl_region_params params;
>>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>>  	struct notifier_block memory_notifier;
>> +	struct notifier_block adist_notifier;
>>  };
>>  
>>  struct cxl_nvdimm_bridge {
>> -- 
>> 2.39.2
>> 
>> 

--
Best Regards,
Huang, Ying
