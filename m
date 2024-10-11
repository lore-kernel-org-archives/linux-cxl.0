Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818E17BA9;
	Fri, 11 Oct 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614674; cv=none; b=G36GiHt+ffnWcXX1wZvkSravtTTUfN4BBIrY1eAnhuhgHWBFkOXEU/l5HBZcnpMa9SGDRFMU6aJ7PX+4Ao6/KxOaHZKYUvAvqyyeKeSOu90ptyCTbGX43tqbbT8h9UpopA5U4QFaqR3bvup0aKJGIhYwH4482C65CrzArJF92Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614674; c=relaxed/simple;
	bh=ep5nUHCPM48um+Xp4OcKgtzbYd6FuZYwpN1qzFCD6EE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rgoudRRSYy2Y360taChPALJ3e2X96y6XxH2parn+YZJfx7yMBtENpgJfIy/TERXgMSFJqS0/u5qzS1B76+5FMNdEPqQb5liPSBjgTAEaB+0v6USWHGjo9OIBdSi+0gBG04oKhs2EQeZlZZ9kGOQM0ZYpXDWc9K1sUgXeBv/OsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHrq4Wxf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHrq4Wxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728614673; x=1760150673;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ep5nUHCPM48um+Xp4OcKgtzbYd6FuZYwpN1qzFCD6EE=;
  b=GHrq4WxfaT99UMUmMt8ssqrrC+PSV716b4SOhW9j8NdRiaPWC33SDEgi
   TYroE/2mccIXZ8cM6jmyN5G5x5YqnudjD1dryvPHOHjyN2zxxuD7lWsXt
   oDAUxFEPBVpzPEqfc7FuMkuZPgsREcCQKvXuHN7nwKQQOJJWxZfsUhPe2
   PerBExVJ4HfE9lDTVtygfOnIGTiUXRQjgxIxuFZpjVIQkgL1lcsiaFine
   uExeR/YgFss5ffgSQOQswA8ROwDwDU3ZFhTYJGJblbl+VlZrv4CHIRjSE
   GqZjfpAZcYrSZ2iOnpcmJZJPFiKIeFOtKusdsyMfxd54Br4ceqfZSOrfT
   A==;
X-CSE-ConnectionGUID: cIN83G/aQ8qxb9SVuosOtA==
X-CSE-MsgGUID: 3Evdmy1gR1u6GrLvkNuUUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28096191"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28096191"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 19:44:33 -0700
X-CSE-ConnectionGUID: XqJDrOIyTpW/J299GCTnMA==
X-CSE-MsgGUID: O31aAfRnSia93r0tHtnHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76426930"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 19:44:30 -0700
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
In-Reply-To: <87plojnxog.fsf@yhuang6-desk2.ccr.corp.intel.com> (Ying Huang's
	message of "Wed, 02 Oct 2024 08:41:35 +0800")
References: <20240925024647.46735-1-ying.huang@intel.com>
	<20240925024647.46735-4-ying.huang@intel.com>
	<Zvv-xTGGTZee_fr8@PC2K9PVX.TheFacebook.com>
	<87plojnxog.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date: Fri, 11 Oct 2024 10:40:57 +0800
Message-ID: <87iktz9xae.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Huang, Ying" <ying.huang@intel.com> writes:

> Gregory Price <gourry@gourry.net> writes:
>
>> On Wed, Sep 25, 2024 at 10:46:45AM +0800, Huang Ying wrote:

[snip]

>
>>> @@ -1925,6 +1933,29 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>>  		return -ENXIO;
>>>  	}
>>>  
>>> +	/* Set the coherence of region to that of the first endpoint */
>>> +	if (cxlr->coherence == CXL_DECODER_INVALIDCOH) {
>>> +		unsigned long flags = cxlrd->cxlsd.cxld.flags;
>>> +		enum cxl_decoder_coherence coherence = cxled->cxld.coherence;
>>> +
>>> +		cxlr->coherence = coherence;
>>> +		if ((coherence == CXL_DECODER_HOSTONLYCOH &&
>>> +		     !(flags & CXL_DECODER_F_HOSTONLYCOH)) ||
>>> +		    (coherence == CXL_DECODER_DEVCOH &&
>>> +		     !(flags & CXL_DECODER_F_DEVCOH))) {
>>
>> silly nit but my gut tells me we can make this less ugly.
>> Not a blocker though.
>
> Yes.  This looks urgly.  Will think about how to improve it.

Reviewed the code again.  However, I don't have any idea to improve
this.  Do you have some suggestion?

>>> +			dev_dbg(&cxlr->dev,
>>> +"%s:%s endpoint coherence: %d isn't supported by root decoder: %#lx\n",
>>> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>> +				coherence, flags);
>>> +			return -ENXIO;
>>> +		}
>

--
Best Regards,
Huang, Ying
