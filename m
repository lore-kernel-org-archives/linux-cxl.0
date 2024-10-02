Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501F1FA4;
	Wed,  2 Oct 2024 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829867; cv=none; b=ula+G7d9Hy0/rKFxvF77GkbLZxwKU8FvStEenemwnTFIPM/cwpX5Us4iAxPjuR3GEWFOChTbICJroLo9A0Yfyi6Xcov/1w1YmZLqoRSGVCSuHrA1xXSgNhAzIKtRw9PcG77LFfzsq91ffM/LYOGemJU8MWfuGwpPdEaI2xXySfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829867; c=relaxed/simple;
	bh=Cpd2/fCJWhNJswd/Wu9NmTkpsUbepUaKwCDHjrcSnlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SskwAUKw++9GaaNjUl2mtK3nDX+6BEgogrSFVfLkOG8vffavvVF6rtYb5KnGoS2F+6Rjuc8j4HnuQPMs15OBuiwb22txB7RM07WGebajuKxzlQ8WHZ16tIMRDXnGOhZ/W13dNRzbTghZ0Q9fU25dTj0JIvwwwuKWzRea3MprQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtSbrQsP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtSbrQsP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727829867; x=1759365867;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Cpd2/fCJWhNJswd/Wu9NmTkpsUbepUaKwCDHjrcSnlc=;
  b=mtSbrQsPLBg2pYcXay/CtJlFCw23kvcX5Xnp31OFeTxV0RLqzXwXZT3R
   XfvR50QVT+G2oUqLpbBZ5WL4Zr4LBqHITFdKCdYAThT/Rk2f1Z/dWvTo/
   Utc0M+vws3qq7PfzMmoxc6a6X4ItU6hMTRC589Km+xdGCFEdpzaZkRHps
   E+4hHPb+HpgwbrAZeSN2p2ItlGQhDFRHK0+0YlFgR+Utt3HyYdm/0FPbk
   g7iicN/JLijfHDu/nxwNoFLQZune3ouwnK/4iMBnEhz4eEfWv1tx3uL6t
   +5Qtlkdup4MGz32V0rJdq2J/3d5jMptpXOF0dSXGNoqf0o8Dgjlx6xDts
   g==;
X-CSE-ConnectionGUID: oI+Ox0odQu+4y0dQzWarPA==
X-CSE-MsgGUID: rNazjVtlTj2RO/9ufptTOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38373889"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="38373889"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:44:26 -0700
X-CSE-ConnectionGUID: wjnn1cIXQ++8IdFRc4ufnQ==
X-CSE-MsgGUID: gfTfrprlR9mY0+ekT+PP1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="74277090"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:44:22 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Alison Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [RFC 4/5] cxl: Set type of region to that of the first endpoint
In-Reply-To: <Zvv_oov557lzvYUM@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Tue, 1 Oct 2024 09:56:50 -0400")
References: <20240925024647.46735-1-ying.huang@intel.com>
	<20240925024647.46735-5-ying.huang@intel.com>
	<Zvv_oov557lzvYUM@PC2K9PVX.TheFacebook.com>
Date: Wed, 02 Oct 2024 08:40:49 +0800
Message-ID: <87ttdvnxpq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Wed, Sep 25, 2024 at 10:46:46AM +0800, Huang Ying wrote:
>> The type of region is hard-coded as type 3 expander now, because this
>> is the only supported device type.  As a preparation to support type 2
>> accelerators, we set the type of region to that of the first endpoint.
>> Then, we will check whether the type of region is same as the type of
>> other endpoints of the region.  Because what we really need is to make
>> sure the type of all endpoints of a region is same.
>> 
>> The target type of endpoint devices comes from expander/accelerator
>> device drivers via struct cxl_dev_state.
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
>>  drivers/cxl/acpi.c        |  1 -
>>  drivers/cxl/core/hdm.c    | 28 +++++++++++++---------------
>>  drivers/cxl/core/port.c   |  2 ++
>>  drivers/cxl/core/region.c | 13 +++++++------
>>  drivers/cxl/cxl.h         |  1 +
>>  5 files changed, 23 insertions(+), 22 deletions(-)
>> 
>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Thanks!

>>  static ssize_t create_pmem_region_store(struct device *dev,
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 99398c868d82..2a2d2c483654 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -324,6 +324,7 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>  #define CXL_DECODER_F_MASK        GENMASK(5, 0)
>>  
>>  enum cxl_decoder_type {
>> +	CXL_DECODER_INVALID,
>
> nit - should this be an explicit value?

Sure.  Will fix this in the future version!

>>  	CXL_DECODER_ACCEL = 2,
>>  	CXL_DECODER_EXPANDER = 3,
>>  };
>> -- 
>> 2.39.2
>> 

--
Best Regards,
Huang, Ying
