Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF471DA32
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533319; cv=none; b=OcgiqN1eQngRyiA1kTq3aH+EzCtgGM/5o2IdUrcQ1KN1LU73FfgRBbXx5T+mq5eQwHM1SiJA8AWbe2sr8GHufRf7OnVpkQi2mim4IkfeNfe7wsVUgPcYLfBrM2vzMJJA1jN6picBi11vDqU7fZI3MRWK0JD15KbMTwFhGdFxM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533319; c=relaxed/simple;
	bh=IVSyM/HJ+z3mp81uV6FhHCMOVLarMYESnC3dsb4V7eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJyEFZWxlN+sOegRAdVfRQCeiwxXsOXMNunSzbA1LA0z7JoYqtNTr1NlZnVBMm+Jmk/NX4SIdf5pjlnUgYUpz2xIE99Y7IXI2RuFRVm1ShafjrnDxeIX2lG58xbFpSzaeNqnecN6sKsmKCaOybKp/9p1pMhIckZfIBF6UNnN+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPFiIsEt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPFiIsEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708533318; x=1740069318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IVSyM/HJ+z3mp81uV6FhHCMOVLarMYESnC3dsb4V7eI=;
  b=SPFiIsEtuazL5ZfTz7mWcdeRBWsluxHFoQdSz1AOzuiMgYx05GDhE2TM
   Ijaz2bQdrxwHC0649pZU2GmLLMrgoGNnDNl5gUUagXj8R59c1mtFpprFu
   v48JhuZ/X0kSy7o1heBFJccPOtQmJF1h5CNKv4o6RFRN0seX0IkU5l2q1
   oCOEalBX3ce9ZUy9NxWhdCeGCEFbE5OroebRe9kwUb6PgGLABL+hEuCZU
   sv5/rLln7bXS4jj4UmwHGDjQ930M3vFlIavMDu/kPxd8wyKBHeMt+ZgJV
   Zbrk2lNZNK2wod122P4RndOQkchIYQ4EKMzgfz9XqdOHC2Pb1qa47vio/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13401072"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13401072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:35:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913333870"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="913333870"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.113.24]) ([10.246.113.24])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:35:15 -0800
Message-ID: <a251128e-ba9e-49fb-a237-f3b8c2b605e2@intel.com>
Date: Wed, 21 Feb 2024 09:35:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add post reset warning if the reset is detected as
 Secondary Bus Reset (SBR)
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240215232307.2793530-1-dave.jiang@intel.com>
 <20240219142006.000056a4@Huawei.com>
 <65d4ed7338566_6c7452941e@dwillia2-xfh.jf.intel.com.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65d4ed7338566_6c7452941e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/24 11:20 AM, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Thu, 15 Feb 2024 16:23:07 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> SBR is equivalent to a device been hot removed and inserted again. Doing a
>>> SBR on a CXL type 3 device is problematic if the exported device memory is
>>> part of system memory that cannot be offlined. The event is equivalent to
>>> violently ripping out that range of memory from the kernel. While the
>>> hardware requires the "Unmask SBR" bit set in the Port Control Extensions
>>> register and the kernel currently does not unmask it, user can unmask
>>> this bit via setpci or similar tool.
>>>
>>> The driver does not have a way to detect whether a reset coming from the
>>> PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
>>> detect is to note if there are active decoders before the reset and check
>>> if the range register memory active bit remains set after reset.
>>>
>>> A helper function to check is added to detect if the range register memory
>>> active bit is set. A locked helper for cxl_num_decoders_committed() is also
>>> added to allow pci code to call the cxl_num_decoders_committed() while
>>> holding the cxl_region_rwsem.
>>>
>>> Add a err_handler->reset_prepare() to detect whether there are active
>>> decoders.  Add a err_handler->reset_done() to check if there was active
>>> memory before the reset and it is no longer active after the reset. A
>>> warning is emitted in the case of active memory has been offlined.
>>>
>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> This feels like we are papering over a hole in the PCI core.
>> Is there no way of detecting Secondary Bus Reset (SBR) and
>> communicate that down to the device?
>> +CC Bjorn. 
>> Most of the logic would be needed in driver anyway though as
>> we don't want to bother warning on SBR if there was no memory mapped.
>>
>> Bjorn, would you prefer this FLR vs SBR being detected by state
>> change in driver, or a modification to the PCI core so that it
>> provides this info to the drivers?  I assume this pretty unique
>> to CXL as normally there isn't a magic control to ignore triggering
>> a reset.
> 
> So there *is* a magic control to ignore triggering a reset per the CXL
> specification, see "Unmask SBR" in "Port Control Extensions".
> 
> Moreover, I do not see this as papering over a hole. The only software
> that flips that "Unmask SBR" bit from its default today is a userpace
> "setpci" script.  Unless kernel_lockdown is in force there is nothing to
> stop or warn root about the danger, in fact there is a wide swath of
> damage that root with config-cycle-write-access can wreak.
> 
> If someone goes through that trouble, and in keeping with the general
> Linux ethos of giving root access to footguns (outside of
> kernel_lockdown), there is not much justification to block it, but the
> driver can definitely clarify the damage after the fact.
> 
> I will also point out that the lack of a reset reason notification is
> not the loan concern. If there is appetite for increasing core-to-driver
> transparency, the hotplug reason is also missing. Whether ->remove() is
> logical or physical and the ability to set the magnetic-retention-latch
> from an endpoint driver could be interesting, but the staus quo is
> sufficient for now.
> 
> ...a comment for Dave below
> 
>>
>> One trivial comment inline.
>>
>> Jonathan
>>
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index e59d9d37aa65..81d9f57d2e84 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -45,6 +45,17 @@ int cxl_num_decoders_committed(struct cxl_port *port)
>>>  	return port->commit_end + 1;
>>>  }
>>>  
>>> +int cxl_num_decoders_committed_locked(struct cxl_port *port)
>>> +{
>>> +	int decoders;
>>> +
>>> +	guard(rwsem_read)(&cxl_region_rwsem);
>>> +	decoders = cxl_num_decoders_committed(port);
>>
>> return cxl_num_decoder_commited(port);
>>
>>> +
>>> +	return decoders;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed_locked, CXL);
>>> +
>>>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>>>  			    char *buf)
>>>  {
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index b6017c0c57b4..530c7e693096 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -720,6 +720,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>>>  }
>>>  
>>>  int cxl_num_decoders_committed(struct cxl_port *port);
>>> +int cxl_num_decoders_committed_locked(struct cxl_port *port);
>>>  bool is_cxl_port(const struct device *dev);
>>>  struct cxl_port *to_cxl_port(const struct device *dev);
>>>  struct pci_bus;
>>> @@ -800,6 +801,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>>>  int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>>>  			struct cxl_endpoint_dvsec_info *info);
>>> +bool cxl_dvsec_rr_active(struct device *dev, int d);
>>>  
>>>  bool is_cxl_region(struct device *dev);
>>>  
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index 5303d6942b88..9f1814005322 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -440,6 +440,7 @@ struct cxl_dev_state {
>>>  	struct resource ram_res;
>>>  	u64 serial;
>>>  	enum cxl_devtype type;
>>> +	bool active_rr_prereset;
>>>  };
>>>  
>>>  /**
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 233e7c42c161..5a5fda7134f6 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -957,11 +957,42 @@ static void cxl_error_resume(struct pci_dev *pdev)
>>>  		 dev->driver ? "successful" : "failed");
>>>  }
>>>  
>>> +static void cxl_reset_prepare(struct pci_dev *pdev)
>>> +{
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>> +
>>> +	if (cxl_num_decoders_committed_locked(cxlmd->endpoint))
>>> +		cxlds->active_rr_prereset = true;
>>> +}
>>> +
>>> +static void cxl_reset_done(struct pci_dev *pdev)
>>> +{
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>> +	struct device *dev = &cxlmd->dev;
>>> +
>>> +	/*
>>> +	 * FLR does not expect to touch the HDM decoders and related registers.
>>> +	 * SBR however will wipe all device configurations.
>>> +	 * Issue warning if there was active configuration before reset that no
>>> +	 * longer exists.
>>> +	 */
>>> +	if (cxlds->active_rr_prereset &&
>>> +	    !cxl_dvsec_rr_active(&pdev->dev, cxlds->cxl_dvsec)) {
>>> +		dev_warn(dev, "SBR happened without memory regions removal.\n");
>>> +		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");
> 
> Dave, did you test this? I reacted to the addition of
> ->active_rr_prereset as a case of putting code logic in a data
> structure, but I doubt it is even effectice since nothing informs
> software that the register values changed. I.e. the check should be to
> walk through all the software committed decoders and see if they are
> still hardware committed. No need for ->active_rr_prereset.

I've not got hold of hw to test yet. I just figured to see if this is the direction we want to go while I work on getting hold of hw. I added ->active_rr_prereset with the thinking that if we find there's nothing setup before the reset and after the reset we can skip emitting false warnings. But it sounds like we want only ->reset_done() to walk through the decoders and emit warning if nothing is setup regardless of previous state? Although would it be sufficient to just detect the range register Memory_Active bit? SBR would reset this bit to 0 right?
