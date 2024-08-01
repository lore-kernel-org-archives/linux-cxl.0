Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE32156F54;
	Thu,  1 Aug 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722493954; cv=none; b=h24huzx7DynH8yrTAHfuEwx3aqYUN7OCyPu638o6hu23TDlOPv8iX7+DZAnjFlCiO4dV/IqHMcczWZB8LixZWESn0u93Y+DWYjW7yOaoZhV5Skf+AIEl50KrwaMHIJ57T5a1+uBe7CsFILu6u5NNDQ83EKkh4ZGnAgS8xAbaiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722493954; c=relaxed/simple;
	bh=oxxFndBMVvEyHDztT3sIU4U429uaxVcLaKdlXlUsKYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XCic14TYR21W4U5tv8EGyhcVck0wVDf3wwoYmJPAuoWDLMZZjUi1Y1NZjpysa9Tg/1T91F/ShbHsVPV/A23Jih4hbYgt1icJ28TpDM/i18Kw0CECOM8FziLgXpcdAWnSdGr+QXyB37yzVp1/0+3Us3SWYbjCmg4gEbbK0KkhRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5p/Rlda; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5p/Rlda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722493952; x=1754029952;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oxxFndBMVvEyHDztT3sIU4U429uaxVcLaKdlXlUsKYY=;
  b=Q5p/RldaU4jQhbh9s6E+ibAbZHG+3S5Th560JanL0A7x23hj7n6Zx6Mn
   Ctc5qp2yZc7yEjxpGmsOySZ0A+Dj/ixg+IicCBwYw9A6VI0QHcq44pgX9
   mre59/aJvR8D4j1h5a8p5fs0lkSX2mTa+NObZOmCH4OKP8RYiYP6OXlni
   Q59/YwVh4zKLo49EsFEiGPJo9R661AXkv0MN4wjEfKCkmolDfzGhEbNNw
   yaZE/NqlNJVVB86MeUlThTqaOLqFYM7n/Dwj37SMYWkZ/y878wajo3nFe
   05xDF107C36aIGTCDJ2jUgC7555Y9v9KyyGJah/Gc1mkd+wGDwWuexhdq
   g==;
X-CSE-ConnectionGUID: PTGc0m2bSIqRNHwndfPZtQ==
X-CSE-MsgGUID: 00rOjEorRnq+eE6cjUH21Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="12822778"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="12822778"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 23:32:31 -0700
X-CSE-ConnectionGUID: Kaek4QVbRyumC9/bnjvXHg==
X-CSE-MsgGUID: CpheZxaUQZ+hd3QdiUN5hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="85844250"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 23:32:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Davidlohr Bueso <dave@stgolabs.net>,
  "Jonathan Cameron" <jonathan.cameron@huawei.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [PATCH 2/3] cxl: Set target type of region with that of root
 decoder
In-Reply-To: <ZqrmeC8nKVR3Tksz@aschofie-mobl2> (Alison Schofield's message of
	"Wed, 31 Jul 2024 18:35:52 -0700")
References: <20240729084611.502889-1-ying.huang@intel.com>
	<20240729084611.502889-3-ying.huang@intel.com>
	<ZqrmeC8nKVR3Tksz@aschofie-mobl2>
Date: Thu, 01 Aug 2024 14:28:55 +0800
Message-ID: <87o76ckb88.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alison Schofield <alison.schofield@intel.com> writes:

> On Mon, Jul 29, 2024 at 04:46:10PM +0800, Ying Huang wrote:
>> Now, the target type of region is hard-coded to HOSTONLYMEM, because
>> only type3 expanders are supported.  To support type2 accelerators,
>> set the target type of region root decoder with that of the root
>> decoder.
>
> Hi Ying,
>
> If the target type of a region is always the same as it's root decoder,
> (is it?)

IIUC, it is.  Do you know when they may be different?

> why do we store it as an attribute of the region. Can we look
> it up when needed?

Yes.  This is possible via to_cxl_root_decoder().  It's just
a little inconvenient.

> A bit more below -
>
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alejandro Lucero <alucerop@amd.com>
>> ---
>>  drivers/cxl/core/region.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..9a483c8a32fd 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2545,7 +2545,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>>  		return ERR_PTR(-EBUSY);
>>  	}
>>  
>> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
>> +	return devm_cxl_add_region(cxlrd, id, mode,
>> +				   cxlrd->cxlsd.cxld.target_type);
>>  }
>
> Passing the 'cxlrd' and then a piece of the cxlrd (.target_type) looks
> redundant.

Yes.  We can remove the parameter.  Will change this if we still need
cxlr->type.  Thanks!

--
Best Regards,
Huang, Ying

>
> -- Alison
>
>>  
>>  static ssize_t create_pmem_region_store(struct device *dev,
>> -- 
>> 2.39.2
>> 
