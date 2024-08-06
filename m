Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260ECEC4;
	Tue,  6 Aug 2024 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907933; cv=none; b=n58lES7/mgJBVqIH16kKX7P6Q8UM4vXKF75rp15do/9q0tjrxDwvSxR0Ycvoj2BSwAF6NBafrtYKhCDQ0/uCnO/2UVloSpb8FlD6inXdgja9kQ8cqGJu33uAp/+xaOjOEe9VrejDQdcYLnVzC8cat675m83st2jgLXWHJ5TXsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907933; c=relaxed/simple;
	bh=8JM33EL9EX6svjFhSUMuNAxDgwAEGfs9STZx806OiSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJgf/iqb8gjdN8xGDU7e2vk+Ob0g2FZ8BkGwQI+PyWxB9VGi+BkhohNvLuZWlrzx6N/HNyAIVPQCHxssY+aodkAlnJEIqyN61W7EJ17FrCf0Bbeanq6OcjxC+9RHbnnpJWcDf/D0eIJ7fFhhAZTjqj77cDWBlpmboD89tiUAIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FP5ppg/4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FP5ppg/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722907931; x=1754443931;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8JM33EL9EX6svjFhSUMuNAxDgwAEGfs9STZx806OiSg=;
  b=FP5ppg/4GH6uqG6lcwK4Z8mD0dUeJ9qOm/QxSm1j9/8HyO/31JzSrDMz
   VLHfKRfmRL438g4CMoBu2Ynn0NUADD1Se0Fr199jRAEsGWDUrd4XZNHeF
   XtJ82Bp1tTBmgBnJbkKDGkraczxIEMCzYTS9Fo7GIMsqDfSMGWxNJrof0
   +YkA4xz/McdnfEgACR2rbOZi6uxZbaPPACl+PsXlvAKtmrUmhi0JfevR2
   fJAjTp8lT4ELAmgB9hsAA7DogydMnfpm6ApDR3GLUsCLhLrO8MZ9ZQLC7
   JZMi0cnioGGqgnknpJ7kGaDDEUBhuMbIBU0REbAffQoNCC+ROT985snYF
   A==;
X-CSE-ConnectionGUID: sUktuYYCQxOWbdVOIKyHnA==
X-CSE-MsgGUID: GaBuMmesRh6NBlGhaCsiHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20479693"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20479693"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:32:10 -0700
X-CSE-ConnectionGUID: QJ3kC4yiSViLLkCI8DXv1w==
X-CSE-MsgGUID: INQVMo1BQiy/TWN7abVCDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="86939041"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 18:32:07 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Davidlohr Bueso <dave@stgolabs.net>,
  "Alison Schofield" <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  "Alejandro
 Lucero" <alucerop@amd.com>
Subject: Re: [PATCH 1/3] cxl: Set target type of root decoder based on CFMWS
 restrictions
In-Reply-To: <20240804172436.00003275@Huawei.com> (Jonathan Cameron's message
	of "Sun, 4 Aug 2024 17:24:36 +0100")
References: <20240729084611.502889-1-ying.huang@intel.com>
	<20240729084611.502889-2-ying.huang@intel.com>
	<20240804172436.00003275@Huawei.com>
Date: Tue, 06 Aug 2024 09:28:34 +0800
Message-ID: <87zfpqa18d.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Jonathan,

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Mon, 29 Jul 2024 16:46:09 +0800
> Huang Ying <ying.huang@intel.com> wrote:
>
>> Now, the target type of root decoder is hard-coded to HOSTONLYMEM,
>> because only type3 expanders are supported.  To support type2
>> accelerators, set the target type of root decoder based on the
>> window restrictions field of CFMWS entry.
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
>>  drivers/cxl/acpi.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 82b78e331d8e..40c92ad29122 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -382,7 +382,10 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>>  
>>  	cxld = &cxlrd->cxlsd.cxld;
>>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>> -	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>> +	if (cxld->flags & CXL_DECODER_F_TYPE2)
>
> These flags need updating or we are going to run into problems
> long term.
>
> As of more recent specs, the distinction is messier than it was and
> it's device coherent HDM-D / HDM-DB (second one being type2 or type3 with
> BI support) and/or Host only coherent HDM-H.

I got your idea.  Previously, Device Coherent (HDM-D/DB) means type2
devices, while Host-only Coherent (HDM-H) means type3 devices.  But in
recent specs, type3 devices could be HDM-DB too.  So, we should rename
ACPI_CEDT_CFMWS_RESTRICT_TYPEX and CXL_DECODER_F_TYPEX.  What's your
suggestion for the new name? _DEVMEM and _HOSTONLYMEM?

> I'm curious on whether anyone is support both on same CFWMS?
> I believe it is possible and the spec doesn't rule it out.

This sounds possible.

> Jonathan
>
>
>> +		cxld->target_type = CXL_DECODER_DEVMEM;
>> +	else
>> +		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>>  	cxld->hpa_range = (struct range) {
>>  		.start = cfmws->base_hpa,
>>  		.end = cfmws->base_hpa + cfmws->window_size - 1,

--
Best Regards,
Huang, Ying
