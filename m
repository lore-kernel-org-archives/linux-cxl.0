Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DB83CD4;
	Fri, 21 Jun 2024 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936844; cv=none; b=IEfWvYEC2JleJ9BnV5ejMhGhaKjQ/NX4FWbcqGMOfmO1zI77HD4xRcybGjmPQvGYWIfFwqfS15ZUbsDlsiQCpHb53X1bMqtA3zN2OmCBJeKR8zca+mP+h81BXZ0eIRDvXY0IB3Kouu31p5DeE/LY+WP0fSEin/vTuFXwdV0pSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936844; c=relaxed/simple;
	bh=Wptugyt91HQIamfAU4jbgvpcqaICqBPYTL6Zjz5rPqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivfoA47PPjZVwe15NjSJWOTF9bNc86wgtZJD+x7DtLy2ttFgBgjPhwYP8YMOSzHzX6dVciwyk55SKuKl96F0GjVFOrhQtIMn/i4wh3G8b1doIzIpP/mZgsWrof8VtkP9CM4pyyg04oAuJDJacfqFvhgfJZMWYq0mab+uw11oyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnfQMtAV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnfQMtAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718936843; x=1750472843;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Wptugyt91HQIamfAU4jbgvpcqaICqBPYTL6Zjz5rPqw=;
  b=BnfQMtAV8Su+6KOnbIGJmV5AcG+n1MzGX/2hAT3x4ZgQhP7dpM/r/Zkn
   Eg0OXXaqkHees5nQywAtVoac0iIrwUlGNOdSZTz6pjXVotDdPCRz6LnuI
   peTy0SYn0dEvtnbGkCJR8I+dpNmwNjsiuhcFq2i+jBBK0HJxcra6CDEBZ
   wynoor8CjmN+WcX754x8SOoJf9spi2r4oiAIAguRVwo2k95Qk9v3G1sCD
   xdDHpBKZyhWro8wuPPVKF0mlSV0aqFlp4Jza+XqEaypDsVJn2tn/KhDed
   H1m7GKbBJMwFqUvQLDjAcLzLFtUqYxHyVD42quvxFYhDUjpXjhDguf/J5
   Q==;
X-CSE-ConnectionGUID: fCLb9dEnQ6O4sdK4ael6+Q==
X-CSE-MsgGUID: e2owq4iFTDGUm+FwUozdXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="26548763"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="26548763"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:27:22 -0700
X-CSE-ConnectionGUID: 3lfHA8SQRRG1Ez3N4P3YeQ==
X-CSE-MsgGUID: IkC/uqcYTyChInZcq2PBjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42896215"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:27:17 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Alison Schofield
 <alison.schofield@intel.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Bharata B Rao <bharata@amd.com>,  Alistair Popple <apopple@nvidia.com>,
  "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] cxl/region: Simplify cxl_region_nid()
In-Reply-To: <20240620121517.00006e3e@Huawei.com> (Jonathan Cameron's message
	of "Thu, 20 Jun 2024 12:15:17 +0100")
References: <20240618084639.1419629-1-ying.huang@intel.com>
	<20240618084639.1419629-4-ying.huang@intel.com>
	<20240620121517.00006e3e@Huawei.com>
Date: Fri, 21 Jun 2024 10:25:24 +0800
Message-ID: <87wmmj117v.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Tue, 18 Jun 2024 16:46:39 +0800
> Huang Ying <ying.huang@intel.com> wrote:
>
>> The node ID of the region can be gotten via resource start address
>> directly.  This simplifies the implementation of cxl_region_nid().
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> ---
>>  drivers/cxl/core/region.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index dc15ceba7ab7..605efe3562c6 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2309,15 +2309,13 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>  static int cxl_region_nid(struct cxl_region *cxlr)
>>  {
>>  	struct cxl_region_params *p = &cxlr->params;
>> -	struct cxl_endpoint_decoder *cxled;
>> -	struct cxl_decoder *cxld;
>> +	struct resource *res;
>>  
>>  	guard(rwsem_read)(&cxl_region_rwsem);
>> -	cxled = p->targets[0];
>> -	if (!cxled)
>> +        res = p->res;
>
> Odd indent - I think spaces rather than tab.  Otherwise seems
> reasonable.

Good catch!  I used spaces accidently.

Hi, Dave,

Do you need me to send a new version?  Or you can change it?

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thank you very much for your review!

--
Best Regards,
Huang, Ying

>
>> +	if (!res)
>>  		return NUMA_NO_NODE;
>> -	cxld = &cxled->cxld;
>> -	return phys_to_target_node(cxld->hpa_range.start);
>> +	return phys_to_target_node(res->start);
>>  }
>>  
>>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
