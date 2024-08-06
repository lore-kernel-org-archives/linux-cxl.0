Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8E15D1;
	Tue,  6 Aug 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722923764; cv=none; b=nQNvf6XMCqE5+TUnYZjiXQDQMCi4eM1HdJZrzW4Hz1LPG0txfn/8AfF7d1YW2olwCHDv6mTmOUyX30OBEoiB8P4nx0mKxADx6h+nUaGeu4pI5YiPk7QhiqX5UXae2amdtZphKDQUq7TJ/44DVhjEaiTyHrrDuDrRWP5eeYJ6Uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722923764; c=relaxed/simple;
	bh=lIGGixSjmNw+yXtMk0pVgzj8pzhnE5r53TrEawaitCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oxxY0BATauyYeEYK/vAvebCGJV+WgGyDmPcMHEsvircU9TGeO42oGppWBJjoOyO51gDwJB0jRRabHXRX4ZR+C4BN3ERBbbZllv00rqWIuruSUZTShuXB5mcMqX09s8sG3ytyEGcHeQcU1RyXvXIVPtpy4gqUqjMHJtnoUu3LV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE2N+W+5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE2N+W+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722923760; x=1754459760;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lIGGixSjmNw+yXtMk0pVgzj8pzhnE5r53TrEawaitCY=;
  b=gE2N+W+5u/7x1bU5nCyHtHZLfqtdQkdg6FmmEOfDwRFmMWCUTEjpXUID
   vh0brGHA/PrV1IwWDkRM5TriRnhT6q0UgwVm8y681W5zKiJPzfoydRbOP
   x7nFqnK0jA72nQRoXJUaXf0urfTaiCizjN/e8mqyERsfGIdZqQtecyvZC
   ZiGDoLxRUrez77pK5DCihvvICjdSpuYVjX2pXiQPTmWgISAT/5TvdgmDl
   Gi3+PMlrlIHX75PdrFM+YAmZ+3/j0onHTkyAHq7MWyX9ksboQ2E1UVC0i
   Rllj5LvJB4SvSzclR32vwFaX21m/J1PkgiB5C2K58BcUbvMoMZorAWPDn
   g==;
X-CSE-ConnectionGUID: MMCKHjZjTl+3/YyFl6uevQ==
X-CSE-MsgGUID: zBxcZZCoTr+Q9RnHkpclpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="23832921"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="23832921"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 22:56:00 -0700
X-CSE-ConnectionGUID: f1e7N9nERyCnEP5fu5NIxQ==
X-CSE-MsgGUID: KSKV4sUyRYWndxRR66R8EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="61021643"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 22:55:57 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Davidlohr Bueso <dave@stgolabs.net>,
  "Alison Schofield" <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  "Alejandro
 Lucero" <alucerop@amd.com>
Subject: Re: [PATCH 3/3] cxl: Avoid to create dax regions for type2
 accelerators
In-Reply-To: <20240804173813.00001018@Huawei.com> (Jonathan Cameron's message
	of "Sun, 4 Aug 2024 17:38:13 +0100")
References: <20240729084611.502889-1-ying.huang@intel.com>
	<20240729084611.502889-4-ying.huang@intel.com>
	<20240804173813.00001018@Huawei.com>
Date: Tue, 06 Aug 2024 13:52:25 +0800
Message-ID: <87v80e9p0m.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Mon, 29 Jul 2024 16:46:11 +0800
> Huang Ying <ying.huang@intel.com> wrote:
>
>> The memory range of a type2 accelerator should be managed by the type2
>> accelerator specific driver instead of the common dax region drivers,
>> as discussed in [1].
>> 
>> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
>> 
>> So, in this patch, we skip dax regions creation for type2 accelerator
>> device memory regions.
>> 
>> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alejandro Lucero <alucerop@amd.com>
>> ---
>>  drivers/cxl/core/region.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 9a483c8a32fd..b37e12bb4a35 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3435,6 +3435,14 @@ static int cxl_region_probe(struct device *dev)
>>  					p->res->start, p->res->end, cxlr,
>>  					is_system_ram) > 0)
>>  			return 0;
>> +		/*
>> +		 * HDM-D[B] (device-memory) regions have accelerator
>> +		 * specific usage, skip device-dax registration.
>> +		 */
>> +		if (cxlr->type == CXL_DECODER_DEVMEM)
>> +			return 0;
>
> As in previous need to be careful as that may not mean it's
> an accelerator.

Yes.  We need some other way to identify type2 devices.

> However, we do need to deal with BI setup for HDM-DB type 3 devices
> etc and to check the HDM Decoder capability registers to make sure
> Supported Coherence model is appropriate. (e.g. 11 for host only or
> device coherency - HDM-H/HDM-DB)

Yes.  We need to check BI configuration too.

>> +
>> +		/* HDM-H routes to device-dax */
>>  		return devm_cxl_add_dax_region(cxlr);
>>  	default:
>>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",

--
Best Regards,
Huang, Ying
