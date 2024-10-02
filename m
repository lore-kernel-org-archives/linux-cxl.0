Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7323CE;
	Wed,  2 Oct 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829915; cv=none; b=qlrTkt0bgcXC7LzH78HjzLIkemzuaveQUIlLnOECpVd5E7QL4PGAbYrX8Eef6pbbZl9dpBEMCZ8lYr1nzXABFCia84au43Yg9XmXcxCXhHseqBfRVPOBvraXGsfXpwVt7AE058qjU63LO9upUVkRRFkbjjjVY5Rjmawztly+b+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829915; c=relaxed/simple;
	bh=zrB5yYZC3j/TXu9gBefQkqeCZax138j6l+BEQ9jOTZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cvmCIo0UBBp8YScElofkaegduZVrEl3K6KQEjb96HyBb8GzXZo5qx+8E0teb+0qoa28IdghqxCjIc27LMpc+xTyviTKbDCKPUedX0ZabuXsKdk35OJnkORlxBfly0F2KTZQPNoi/R4u9TPszBg2U6/rX4UKHZ4YAP1lY5xUsZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gShuAQxl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gShuAQxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727829914; x=1759365914;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zrB5yYZC3j/TXu9gBefQkqeCZax138j6l+BEQ9jOTZw=;
  b=gShuAQxlppEThOvIWTm5cTDTpszaSHYvyO+ooHZhklU9KLsr8ByG9gDQ
   yK+ikfz0o4PUUxzzmA9JdwhGdDb4Q2zSqDQLiumdZIleodm6XtuZoxRil
   q5A7xooqvyzyk+WIAprMxjihg6q4bCorsD/E4dK6HHVRx2OR1+QqGCsQY
   ePMBPKKhmSJ3M7+uA8vygTxCIWKBWpf6wn23afk6BGZLsl4viXJJUnjfO
   eOaYsBFXUlHCRQgjhQ6f+4PK6IUyjGjWOL0RebIZ7bLxTn6n3fKASxjc+
   8Tcs8VflLQZCrjIKIb01L4n4sujKEVWOTU3rB9r7YKv4kj0maMBeaP7wQ
   g==;
X-CSE-ConnectionGUID: sjfPWj60RIuI8lRvtbIhUA==
X-CSE-MsgGUID: cKYMfVBYSCyubfOOagR/mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37583166"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="37583166"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:45:11 -0700
X-CSE-ConnectionGUID: PGNPqKpuQWuxPMTna5utQg==
X-CSE-MsgGUID: Sbtk5fVXRDCeQBP27xJxmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="78599535"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:45:08 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Alison Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alejandro
 Lucero <alucerop@amd.com>
Subject: Re: [RFC 3/5] cxl: Separate coherence from target type
In-Reply-To: <Zvv-xTGGTZee_fr8@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Tue, 1 Oct 2024 09:53:09 -0400")
References: <20240925024647.46735-1-ying.huang@intel.com>
	<20240925024647.46735-4-ying.huang@intel.com>
	<Zvv-xTGGTZee_fr8@PC2K9PVX.TheFacebook.com>
Date: Wed, 02 Oct 2024 08:41:35 +0800
Message-ID: <87plojnxog.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Wed, Sep 25, 2024 at 10:46:45AM +0800, Huang Ying wrote:
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
> Reviewed-by: Gregory Price <gourry@gourry.net>

Thanks!

>> @@ -1925,6 +1933,29 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>  		return -ENXIO;
>>  	}
>>  
>> +	/* Set the coherence of region to that of the first endpoint */
>> +	if (cxlr->coherence == CXL_DECODER_INVALIDCOH) {
>> +		unsigned long flags = cxlrd->cxlsd.cxld.flags;
>> +		enum cxl_decoder_coherence coherence = cxled->cxld.coherence;
>> +
>> +		cxlr->coherence = coherence;
>> +		if ((coherence == CXL_DECODER_HOSTONLYCOH &&
>> +		     !(flags & CXL_DECODER_F_HOSTONLYCOH)) ||
>> +		    (coherence == CXL_DECODER_DEVCOH &&
>> +		     !(flags & CXL_DECODER_F_DEVCOH))) {
>
> silly nit but my gut tells me we can make this less ugly.
> Not a blocker though.

Yes.  This looks urgly.  Will think about how to improve it.

>> +			dev_dbg(&cxlr->dev,
>> +"%s:%s endpoint coherence: %d isn't supported by root decoder: %#lx\n",
>> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> +				coherence, flags);
>> +			return -ENXIO;
>> +		}

--
Best Regards,
Huang, Ying
