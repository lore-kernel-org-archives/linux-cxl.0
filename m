Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC617BBF;
	Thu,  3 Oct 2024 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727918236; cv=none; b=fmfkcLogmpIh5D0WepJ3Y/lT1UhAdXk9O+CQmk2Wi3lJxYlae3stgEbLrplj0UccJ8yobzSQCUhEf7Do70uvrfB+t8UakEfeYPqVDQ2UDisQ3KS6WA7mQ/uX9oSSPD2W8ga6TqotNpTJReVbxzwB49OLrcq7wsHFXrpoZ8TEo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727918236; c=relaxed/simple;
	bh=pgd/IO0H3XV88SaSbX7Hbygk/pZyc8NEDATw7tf4nfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iKRtqRZGkm1tGNFrP2rrdr4iVNFM6bGodFg5FeKOHNveMWxY3IV6Jvas+EyBtuh0X00aRL2xvheeRz8J0NCYlQsMHaAPj198PwwzkDfwq/YOSva0DoAmP2sRgnIaCjOhYqsK1bVyS9Winop9dUzpMZBGegsn2oDR4rmcvhK/3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpdEZVRV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpdEZVRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727918234; x=1759454234;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pgd/IO0H3XV88SaSbX7Hbygk/pZyc8NEDATw7tf4nfs=;
  b=YpdEZVRVNe2qd8ASNLt8s+JubegRWAb2qEOgo2ExkZ5D4FjlyTotYYJ9
   j56+Dcit03+qJw1fOq64lp58UhsCKwbGomwTM6RcJj4yScaeJ3arxnP8M
   Fgu1wcMGQHRZ8BXS3xdRQHxcv0aadYCHVRgHVG+u0sr0B2soebJKIGjq7
   f/N7euOFl+AuZraOkPyb6o8tNk4x2XXm+o1Oriqqth0MPGkYuLLU5NyqQ
   ice4PoPjJJY3hWe7c2BQR0B4H7XCpKXV7tF3EOjDFZ6mRkxSinNBjCsm8
   Xt2cXuW2IQKSQvSswCvCyroQnSZhcvOWrubmPgP49UFWOLddv7Vas4ipg
   Q==;
X-CSE-ConnectionGUID: r77JzBjSQcmxa23T3YxSkQ==
X-CSE-MsgGUID: D7uFj4MRRGWsSsqtjPhEkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38239747"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="38239747"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 18:17:13 -0700
X-CSE-ConnectionGUID: VuEPQef+TdONg3jvR1FF+g==
X-CSE-MsgGUID: 3/TxaM6BQ+mr4XN92EFXvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74216248"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 18:17:11 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: <linux-cxl@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Alejandro Lucero <alucerop@amd.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC 3/5] cxl: Separate coherence from target type
In-Reply-To: <e0f08438-69cf-4e79-abf2-f5f3240d9517@amd.com> (Ben Cheatham's
	message of "Wed, 2 Oct 2024 16:15:35 -0500")
References: <20240925024647.46735-1-ying.huang@intel.com>
	<20240925024647.46735-4-ying.huang@intel.com>
	<e0f08438-69cf-4e79-abf2-f5f3240d9517@amd.com>
Date: Thu, 03 Oct 2024 09:13:37 +0800
Message-ID: <875xqang3i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ben Cheatham <benjamin.cheatham@amd.com> writes:

> Hi Huang, quick comments in this patch and the next.
>
> On 9/24/24 9:46 PM, Huang Ying wrote:
>> Previously, target type (expander or accelerator) and
>> coherence (HOSTONLY (HDM-H) or DEV (HDM-D/DB)) are synonym.  So target
>> type is used to designate coherence too.  However, it's possible for
>> expanders to use HDM-DB now.  So, we need to separate coherence from
>> target type.
>> 
>> Accordingly, the HOSTONLY field of decoder ctrl
>> register (CXL_HDM_DECODER0_CTRL_HOSTONLY) need to be set according to
>> coherence.
>> 
>> The coherence of decoders can not be determined via target type too.
>> So, accelerator/expander device drivers need to specify coherence
>> explicitly via newly added coherence field in struct cxl_dev_state.
>> 
>> The coherence of each end points in a region need to be same.  So, the
>> coherence of the first end point is recorded in struct region.  Which
>> will be checked against the coherence of all other end points.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alejandro Lucero <alucerop@amd.com>
>> ---
>>  drivers/cxl/core/hdm.c    | 22 +++++++++++++++-------
>>  drivers/cxl/core/mbox.c   |  1 +
>>  drivers/cxl/core/port.c   |  1 +
>>  drivers/cxl/core/region.c | 37 ++++++++++++++++++++++++++++++++++---
>>  drivers/cxl/cxl.h         |  9 +++++++++
>>  drivers/cxl/cxlmem.h      | 11 +++++++++++
>>  6 files changed, 71 insertions(+), 10 deletions(-)
>> 
>
> [snip]
>
>>  
>> +/*
>> + * enum cxl_devcoherence - the coherence of the cxl device
>> + * @CXL_DEVCOH_DEV      - HDM-D or HDM-DB
>> + * @CXL_DEVCOH_HOSTONLY - HDM-H
>> + */
>
> Could I suggest mapping the coherence type to the expected device type(s) in this
> comment? My thinking here is that the coherence types aren't exactly straightforward
> and having the device types they correspond to would help ease any confusion, especially
> since it looks like we are expecting type 2 driver writers to fill this in manually. I'm
> thinking something along the lines of:
> /*
>  * enum cxl_devcoherence - the coherence of the cxl device
>  * @CXL_DEVCOH_DEV      - HDM-D (type 2) or HDM-DB (type 2/3)
>  * @CXL_DEVCOH_HOSTONLY - HDM-H (type 3)
>  */

This looks good to me!  Thanks!  Will do this in the next version.

>> +enum cxl_devcoherence {
>> +	CXL_DEVCOH_DEV,
>> +	CXL_DEVCOH_HOSTONLY,
>> +};
>> +
>>  /**
>>   * struct cxl_dpa_perf - DPA performance property entry
>>   * @dpa_range: range for DPA address
>> @@ -438,6 +448,7 @@ struct cxl_dev_state {
>>  	struct resource ram_res;
>>  	u64 serial;
>>  	enum cxl_devtype type;
>> +	enum cxl_devcoherence coherence;
>>  };
>>  
>>  /**

--
Best Regards,
Huang, Ying
