Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE19265621
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847335; cv=none; b=HtI38xcVf+b4FsYv9+Ou//hUkVZY7utAbPmbEtwF0lMwKl+k+59KJ+LqVVawgHCtWfuW/Njge4mtp0DVDkz8gJGUGVj57mEFiWol3GrR9GCZLl5Hs6tRXYwaJUDAKvsx9MdkqJloX9Wrs4pg2Zd63KhJeDYWRgVOjdxuoFSms4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847335; c=relaxed/simple;
	bh=Ii1J/qAF3bjFdval6JURO3PtfyLzz1m/y7deDz4/szM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeksVI+NmImugdM9uCRQw8uni2FUhkQSBFq1aJTEF62qA8/fGGgv0VgyA1LgIrThUn//pRrllF6y32qX9Xtm3GadVtp66AF3uCFPlGoPncBcvuKQ5TzsgYiE0tYxxrmAhhIsTjJutuGQgfK0SoVbmiVjwaxkRvYZEjR7l06ZspM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWKgQ5nr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWKgQ5nr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773847331; x=1805383331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ii1J/qAF3bjFdval6JURO3PtfyLzz1m/y7deDz4/szM=;
  b=QWKgQ5nr5owmaHWBMIglzHQAE9Zt4spXaFhMWIqiUIwT4N7rBgdZwJM3
   44pjVecqxB0LM7Ks8l8jXsk+Nm4Hunr+nPzJYV4j9UyLkV1LWOoeqjF/T
   Z20OXD6sGGiG1mt1m2ptG0f8QPNgCnQBjDovT/ekllN2jc8sf7kjpH3w1
   K6dviZ0N3xhxoFRgma4cBtOClKq+FNDR07ydnwyuMdr1+9nUAxh9WKu8W
   Tt71T+SczYAlEy6UMEgW+MYFCjbZgJZTf0JIX++9qh1sou27ppPVKLcML
   OPGxQ5iX/+g1uSue8f1hsCTgLB9QbkbLES5fa/94eLK3wzxFz/yCjibZQ
   Q==;
X-CSE-ConnectionGUID: ARRMk64lQbGBTMcEUepNDQ==
X-CSE-MsgGUID: vbx5Jv59TSSWdEfbDo96Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74086260"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74086260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:22:10 -0700
X-CSE-ConnectionGUID: bbi4haJ4SDucLpNepAgabg==
X-CSE-MsgGUID: cd2n7SpgQSOtnKWJBNw6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222627994"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:22:10 -0700
Message-ID: <2b32038a-0685-4d8a-a17e-3fddf975f0db@intel.com>
Date: Wed, 18 Mar 2026 08:22:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Add endpoint decoder flags clear when PCI reset
 happens
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com
References: <20260317234926.3545119-1-dave.jiang@intel.com>
 <93651c0f-230f-4dfe-a6a7-5c4b23a178b8@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <93651c0f-230f-4dfe-a6a7-5c4b23a178b8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/26 7:12 AM, Cheatham, Benjamin wrote:
> On 3/17/2026 6:49 PM, Dave Jiang wrote:
>> When a PCI reset happens, the lock and enable flags of the CXL device
>> should be cleared to avoid stale state flags after reset. Add flag
>> clearing during cxl_reset_done() to clear the relevant endpoint
>> decoder flags for all decoders of the endpoint device.
>>
>> Reported-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Rename CLEAR_MASK to RESET_MASK (Alison)
>> - Make the helper function take a mask argument to specify which flags
>>   to clear (Alison)
>> ---
>>  drivers/cxl/cxl.h |  1 +
>>  drivers/cxl/pci.c | 19 +++++++++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 9b947286eb9b..d09c84bcc015 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -333,6 +333,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>>  #define CXL_DECODER_F_LOCK  BIT(4)
>>  #define CXL_DECODER_F_ENABLE    BIT(5)
>>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>> +#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>>  
>>  enum cxl_decoder_type {
>>  	CXL_DECODER_DEVMEM = 2,
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index fbb300a01830..a0bba4b4db92 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1030,6 +1030,20 @@ static void cxl_error_resume(struct pci_dev *pdev)
>>  		 dev->driver ? "successful" : "failed");
>>  }
>>  
>> +static int cxl_decoder_clear_flags(struct device *dev, void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	unsigned long *flags = data;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
> 
> I would either a) rename this function to cxl_endpoint_decoder_clear_flags() or b) change
> it to use struct cxl_decoder devices directly. The generality of option b is nicer imo,
> but you'd have to throw in an extra check for switch decoders (or add a is_cxl_decoder() helper).

Thanks for the review Ben. We can probably do both to make it extra clear.

DJ

> 
> With either of those:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> Thanks,
> Ben
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	cxled->cxld.flags &= ~(*flags);
>> +
>> +	return 0;
>> +}
>> +
>>  static void cxl_reset_done(struct pci_dev *pdev)
>>  {
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> @@ -1045,6 +1059,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
>>  	guard(device)(&cxlmd->dev);
>>  	if (cxlmd->endpoint &&
>>  	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
>> +		unsigned long flags = CXL_DECODER_F_RESET_MASK;
>> +
>> +		device_for_each_child(&cxlmd->endpoint->dev, &flags,
>> +				      cxl_decoder_clear_flags);
>> +
>>  		dev_crit(dev, "SBR happened without memory regions removal.\n");
>>  		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
>>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>>
>> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> 

