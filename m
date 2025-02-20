Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5A1D63D9;
	Thu, 20 Feb 2025 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072964; cv=none; b=drgDZaiuPyTJ6xojL59l/Z5mLvpNIZhLtuf2r086PlU5fQGDiiBuKJLY2XzZv60hF7KXFGjOMirtDJRHhVL7lJra+CGol1M72hiVozleXZgEVpuQGaH3mMTYYMmOKBzVR3YOHrgZ67wpWK/5F/gmUZ3sXlRZdFOicV6pfXOblS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072964; c=relaxed/simple;
	bh=mss40UVn6MKCpG4DM/UKrxGj+Gt8FmPcxueuRBW0i+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU8Oa49XIrqeCrUsVpVelDLHfrdlJ/BJmXomIdlrRxQcAhOK1Jg8JCeXrrrLbZYKFpSQUSDP0BnQMXxHr0UImdpgjCMSKVHurahl6ToA5iOQEgZT3jq4w7nBLfd0drasYYwv68ya1wwHk75iTvh7VsuFpCiTW6G66a6lsiBrmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0SRgeI9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0SRgeI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740072963; x=1771608963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mss40UVn6MKCpG4DM/UKrxGj+Gt8FmPcxueuRBW0i+w=;
  b=Z0SRgeI9hTKDBdhRZgmU3WTK3fqQb1fCA2V+Ts/hore4ikAgdNsOVo5Q
   8shW/waHzkHdA/6ZO52+iH3ncVwR93si+7KERytjB8szK9OtEvF9mowYP
   NWjbB8sGlVtmtek72SLcMWyU4MRFTc2L36ctEgy0khKicX/W436gmLX7m
   NwdCd6oYGsP3P4dxSrHZ42gWW11R7bYVCSUs7IlyzQYZDzIhOI73nGyLd
   ulwGzk6GivgzczjGaQPMR4HVE6OHZy2itN6EY4IMAQfsLfXXf2sgUgkDR
   7zYNed0IiuGtDbqoyyadB42QMGLc/qQgznl5gKjWfh8UR3HkuWUXAXj3U
   Q==;
X-CSE-ConnectionGUID: vlnheEJgSpKH/9FRqn53og==
X-CSE-MsgGUID: ZeZz4lnCT3+L6o79Mh+Hig==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40725440"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40725440"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:36:02 -0800
X-CSE-ConnectionGUID: HF0zkCVpQ2GkiO0SHisTDg==
X-CSE-MsgGUID: q8A91EifQk6kF0/AGZyKgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115779257"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:36:01 -0800
Message-ID: <3e232358-cb42-4b17-9b00-f04eb517a79f@intel.com>
Date: Thu, 20 Feb 2025 10:35:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/18] cxl/region: Add a dev_warn() on registration
 failure
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-16-rrichter@amd.com>
 <20250214163502.0000575f@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250214163502.0000575f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/25 9:35 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:53:45 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
>> Esp. in complex system configurations with multiple endpoints and
>> interleaving setups it is hard to detect region setup failures as its
>> registration may silently fail. Add messages to show registration
>> failures.
>>
>> Example log message:
>>
>>   cxl region5: region sort successful
>>   cxl region5: mem0:endpoint5 decoder5.0 add: mem0:decoder5.0 @ 0 next: none nr_eps: 1 nr_targets: 1
>>   cxl_port endpoint5: decoder5.0: range: 0x22350000000-0x2634fffffff iw: 1 ig: 256
>>   cxl region5: pci0000:e0:port1 decoder1.2 add: mem0:decoder5.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
>>   cxl region5: pci0000:e0:port1 iw: 1 ig: 256
>>   cxl region5: pci0000:e0:port1: decoder1.2 expected 0000:e0:01.2 at 0
>>   cxl endpoint5: failed to attach decoder5.0 to region5: -6
>>   cxl_port endpoint5: probe: 0
>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Tested-by: Gregory Price <gourry@gourry.net>
> I'm in general fine with this, but we have previously been reluctant in
> some cases to go above dev_dbg.  Hence would like input from more
> people on this one.

If this error message has been helpful in determining the cause of issues when debugging a platform, I'm all for it.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> From me though
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>  drivers/cxl/core/region.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index ebcfbfe9eafc..3031d4773274 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2147,6 +2147,12 @@ static int attach_target(struct cxl_region *cxlr,
>>  	rc = cxl_region_attach(cxlr, cxled, pos);
>>  	up_read(&cxl_dpa_rwsem);
>>  	up_write(&cxl_region_rwsem);
>> +
>> +	if (rc)
>> +		dev_warn(cxled->cxld.dev.parent,
>> +			"failed to attach %s to %s: %d\n",
>> +			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
>> +
>>  	return rc;
>>  }
>>  
> 

