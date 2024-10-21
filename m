Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF31E1C22;
	Mon, 21 Oct 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511796; cv=none; b=lQlEoPgwFEtF+pPyzob644Z0p7C2xwZR1aq00iGg1zL/1/icRRZ49hXHGdl19/pHhu3Brhxa6OQ0RHpbXDK2OWx480Q3fMnDUsGb7RUMD0Ddek8aAByFgZ7n7X9xw9g47LW/132MishZoVKlkGq+vP0sVQzT+EbjzM/MIx6HRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511796; c=relaxed/simple;
	bh=B4Hktr4dTY9FV1wNi3EDemMJgSpeWdvg+DXtZW7vj3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hluQxLuJJGt4vUH+RMSpsqsRrSYD8IucQrQevXY1cLzUMTU81st1rEsRlCMObx6HGNFx6UjhaGkYrxqqVowxrOrnrqaBteAYaJIgZBk34NQCvkUShUlgUlqZ2+JZx37NZ14zJ/sOO+kwGOzk7H+ePFMFgNV/sKdf/c3us4ORKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+U+Z84o; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+U+Z84o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729511794; x=1761047794;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=B4Hktr4dTY9FV1wNi3EDemMJgSpeWdvg+DXtZW7vj3E=;
  b=n+U+Z84or1ZUeKF4cWW9o6a5S/7r6otJH4JNbVFFbmd+A3caGiRP9pcK
   e4giSBf+HdKajglnM/9INfVpBE3lFFAbWrPQ4L6rP32hFtjpDHlPMYuOv
   MsAGfAK8nE1CJ10iz/I/LtSE8Q9cSWq2xh24WVGEMbggruW1I00l9h+K8
   Ei0/ILYMqz6c7QCFfA2+65PmFkfa/865NpFBEx+hScHJJK3l0dZXfWV4k
   yk7Y9m6pJS2PEj0a9oCJhOVF0k85hM+hrFZE+ofSAKlFLxvUYtlW2k1qx
   FNAG5L7RtXg7/w2lczWY6z1qaXhw0P3Qydz4jN+JDL1BL6s3lw5KY1qAJ
   w==;
X-CSE-ConnectionGUID: Gef+9v6ERIunmOPQbamx/Q==
X-CSE-MsgGUID: 2ALKV1uXTTyAG+ur0hTd0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="16621188"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="16621188"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 04:56:33 -0700
X-CSE-ConnectionGUID: bfTRB1DeRZ6KMXdk+aUTFQ==
X-CSE-MsgGUID: MZniU/MoTKWEqUkxVylqZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79658627"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 04:56:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Gregory Price <gourry@gourry.net>,
  Davidlohr Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Alejandro Lucero <alucerop@amd.com>,
  Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
In-Reply-To: <67119a9189428_3f14294b4@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 17 Oct 2024 16:15:29 -0700")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-6-ying.huang@intel.com>
	<67119a9189428_3f14294b4@dwillia2-xfh.jf.intel.com.notmuch>
Date: Mon, 21 Oct 2024 19:52:57 +0800
Message-ID: <87ed4965ba.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang Ying wrote:
>> The memory range of a type2 accelerator should be managed by the type2
>> accelerator specific driver instead of the common dax region drivers,
>> as discussed in [1].
>> 
>> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
>> 
>> So, the patch skips dax regions creation for type2 accelerator device
>> memory regions.
>> 
>> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alejandro Lucero <alucerop@amd.com>
>> Cc: Ben Cheatham <benjamin.cheatham@amd.com>
>> ---
>>  drivers/cxl/core/region.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d709738ada61..708be236c9a2 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3473,6 +3473,14 @@ static int cxl_region_probe(struct device *dev)
>>  					p->res->start, p->res->end, cxlr,
>>  					is_system_ram) > 0)
>>  			return 0;
>> +		/*
>> +		 * Accelerator regions have specific usage, skip
>> +		 * device-dax registration.
>> +		 */
>> +		if (cxlr->type == CXL_DECODER_ACCEL)
>> +			return 0;
>> +
>> +		/* Expander routes to device-dax */
>
> So Linux is this weird career choice where you get to argue with
> yourself months later. I understand why I took this shortcut of assuming
> that the coherence mode determines device-dax routing, but that is not
> sufficient.
>
> An HDM-DB region could want the device-dax uAPI, and an HDM-H range
> could want to do its own uAPI besides device-dax.
>
> So, in retrospect, I think it is a mistake to assume uAPI from coherence
> mode. It really is a property of the region decided by the region
> creator independent of the coherence mode or the device type.

Yes.  It isn't a good idea to determine the region usage based on coherence
mode.  In this series, clxr->type is used to designate
expander/accelerator instead of hostonly/dev, it makes more sense to
create device-dax for expander only by default.

> I am thinking that 'struct cxl_region' grows something like:
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..4cf1d030404d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -511,12 +511,25 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NEEDS_RESET 1
>  
> +/*
> + * enum cxl_mem_api - where to route this cxl region
> + * @CXL_MEM_API_DAX: application specific / soft-reserved memory
> + * @CXL_MEM_API_PMEM: direct region to the NVDIMM subsystem
> + * @CXL_MEM_API_NONE: accelerator specific / hard-reserved memory
> + */
> +enum cxl_mem_api {
> +	CXL_MEM_API_DAX,
> +	CXL_MEM_API_PMEM,
> +	CXL_MEM_API_NONE,
> +};
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
>   * @mode: Endpoint decoder allocation / access mode
>   * @type: Endpoint decoder target type
> + * @api: What if any subsystem will present this region to consumers
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
>   * @flags: Region state flags
> @@ -530,6 +543,7 @@ struct cxl_region {
>  	int id;
>  	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_type type;
> +	enum cxl_mem_api api;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
>  	unsigned long flags;

This looks good to me.  The usage is specified by the device driver explicitly.

> Now, I have not seen how Alejandro's series handles this, but this
> type-2 series was shorter so I started here first.

--
Best Regards,
Huang, Ying
