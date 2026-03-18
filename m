Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD73DB646
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847613; cv=none; b=KzUEbDuutBRtiWwJrSU21pPDXTDiFTmgmR3SH9SshudeuXUTKmRP2dWl1ioBLWORKES6nZjYbvs/K0KNbVpDGKedLboAsjIguP6pG18It5BmXoRwZSjI+4kOqoUPWOOACIC7eVEa+xbswDb+BDgWXlgyZS/SPnbhwo62WRfx50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847613; c=relaxed/simple;
	bh=P6V3kwwE+VHhBzugrM5RSQInsQX2HfYi+LBmH3hN4qA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IF00bhotYPPnCLfZT613BCmDZ+C41SL6z+h2X8Wk5ajA3V73CkvqDao1FrBEy7L+GZoWkStlAwXXHZm/oAKZrXqy3DLQd5pA49FqK/GE/lUlnFQWgCL7UxxBsIzQOyWr949ja6bmgDEKTu4yXNSHlNwQP8DXN/L8CmF42v8ixOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9gn383O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9gn383O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773847610; x=1805383610;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=P6V3kwwE+VHhBzugrM5RSQInsQX2HfYi+LBmH3hN4qA=;
  b=R9gn383O4UWDtobBjZcWbTd/LsH813BitlKknZOCWRHarRz5fdthv2l/
   PVyOnYezar6JXKRnwK783YHyCFGyqKI1IG3pEnZ7IQ04KYgMpd5/YVfTh
   6eRr1pzSZydgVo+IGcGf8zARFyb/Jop1uM7p8zIPCiGeRZEjMjooQPUvY
   fRS0XFzak/XaHdf0LENQtP0guEWIlQVDYUFORRMSieuWIMW3LyjZ8SMOr
   yim+iZWaFpZ/uiKkRYvXjp9j5udyqFMzgqk3NXePLKOiGMvrN/ZneCv7Y
   Cb7oUNX3F9mcwdD7tol9Aj/siM6Lwu9SrOqexGMvI4gzklTw4vlWf3KJ7
   w==;
X-CSE-ConnectionGUID: vhZvO0JoTTW0oNLLVVEr/Q==
X-CSE-MsgGUID: rar1GXqhSRC87FzI6nV+wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74087144"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74087144"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:26:49 -0700
X-CSE-ConnectionGUID: ZhITbV4ESbu4BwONkXcQ+w==
X-CSE-MsgGUID: FHLumr0ZRxacnBpKF4qXzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222877056"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:26:49 -0700
Message-ID: <c388c432-87e6-43c6-bba6-3f73a82e6d04@intel.com>
Date: Wed, 18 Mar 2026 08:26:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Add endpoint decoder flags clear when PCI reset
 happens
From: Dave Jiang <dave.jiang@intel.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com
References: <20260317234926.3545119-1-dave.jiang@intel.com>
 <93651c0f-230f-4dfe-a6a7-5c4b23a178b8@amd.com>
 <2b32038a-0685-4d8a-a17e-3fddf975f0db@intel.com>
Content-Language: en-US
In-Reply-To: <2b32038a-0685-4d8a-a17e-3fddf975f0db@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/26 8:22 AM, Dave Jiang wrote:
> 
> 
> On 3/18/26 7:12 AM, Cheatham, Benjamin wrote:
>> On 3/17/2026 6:49 PM, Dave Jiang wrote:
>>> When a PCI reset happens, the lock and enable flags of the CXL device
>>> should be cleared to avoid stale state flags after reset. Add flag
>>> clearing during cxl_reset_done() to clear the relevant endpoint
>>> decoder flags for all decoders of the endpoint device.
>>>
>>> Reported-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>> v2:
>>> - Rename CLEAR_MASK to RESET_MASK (Alison)
>>> - Make the helper function take a mask argument to specify which flags
>>>   to clear (Alison)
>>> ---
>>>  drivers/cxl/cxl.h |  1 +
>>>  drivers/cxl/pci.c | 19 +++++++++++++++++++
>>>  2 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 9b947286eb9b..d09c84bcc015 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -333,6 +333,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>>>  #define CXL_DECODER_F_LOCK  BIT(4)
>>>  #define CXL_DECODER_F_ENABLE    BIT(5)
>>>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>>> +#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>>>  
>>>  enum cxl_decoder_type {
>>>  	CXL_DECODER_DEVMEM = 2,
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index fbb300a01830..a0bba4b4db92 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -1030,6 +1030,20 @@ static void cxl_error_resume(struct pci_dev *pdev)
>>>  		 dev->driver ? "successful" : "failed");
>>>  }
>>>  
>>> +static int cxl_decoder_clear_flags(struct device *dev, void *data)
>>> +{
>>> +	struct cxl_endpoint_decoder *cxled;
>>> +	unsigned long *flags = data;
>>> +
>>> +	if (!is_endpoint_decoder(dev))
>>> +		return 0;
>>
>> I would either a) rename this function to cxl_endpoint_decoder_clear_flags() or b) change
>> it to use struct cxl_decoder devices directly. The generality of option b is nicer imo,
>> but you'd have to throw in an extra check for switch decoders (or add a is_cxl_decoder() helper).
> 
> Thanks for the review Ben. We can probably do both to make it extra clear.

Actually we can't go with option B because the decoders come in as the child device and not passed in as we iterate through device_for_each_child(). So I'll just go with option a. 

> 
> DJ
> 
>>
>> With either of those:
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>
>> Thanks,
>> Ben
>>> +
>>> +	cxled = to_cxl_endpoint_decoder(dev);
>>> +	cxled->cxld.flags &= ~(*flags);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static void cxl_reset_done(struct pci_dev *pdev)
>>>  {
>>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> @@ -1045,6 +1059,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
>>>  	guard(device)(&cxlmd->dev);
>>>  	if (cxlmd->endpoint &&
>>>  	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
>>> +		unsigned long flags = CXL_DECODER_F_RESET_MASK;
>>> +
>>> +		device_for_each_child(&cxlmd->endpoint->dev, &flags,
>>> +				      cxl_decoder_clear_flags);
>>> +
>>>  		dev_crit(dev, "SBR happened without memory regions removal.\n");
>>>  		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
>>>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>>>
>>> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
>>
> 

