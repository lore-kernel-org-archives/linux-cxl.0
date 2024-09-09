Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFB18A925
	for <linux-cxl@vger.kernel.org>; Mon,  9 Sep 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925242; cv=none; b=T2xlughVXJPy9sMdyd1bLy7TxZxy8W/ZOa/IvMbsAwmWOArU8P94fKsThya1V+fMQGL8OIxTQfK3et3GvB8626z77rJKy9RfzZq/uZ345IngRmsWL19Gcs11/D+kdXNUOkrrPudYavxqZeqhyd+h1PkDaD6tovrIA78Zj1LqxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925242; c=relaxed/simple;
	bh=Hk/ggfyKwbJ0ZoOS8CtyrV9cwkBdsKAJwBhvy1AO3sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lf6x9nEMxSFqTQ1/5q5yTjNr3j0gfFRDBj3682e9QHmQz7RYYSE8L6oSMEbd4TFPfFXv9yuQv/S35F9i0UxAdLgCi5QymPPlesu0VweTKfLeUR6UKla39R45jUSLY6p3Xoa0kSF8Y/XK3A7EJp4Jamwhck+Kp/UtAG5daYr3ztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiRjyMOb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiRjyMOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725925240; x=1757461240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hk/ggfyKwbJ0ZoOS8CtyrV9cwkBdsKAJwBhvy1AO3sA=;
  b=RiRjyMObofZQFnS4hqQ4Xc2Ns+EHEpmZClvlLSmWgNnPonPaEsEVMiJS
   Qm+Hut6EFFX/eZ0Pd2W1j2U7JTw6olYm6VieXB4LFIK5q1Q7n1fv7DhFC
   osWyK5yyChNkuMBZdFCRwj/PJTqv7fLiXJsw4RosFNyJcSahbpTtjO+58
   5ucZQamwrPDTgggLuYIvRxSAn1q03NVr86+oY+sf88DJ2v94fi3UiaWfu
   7lICKoVCHG17dKTIdlce5CX1PGxZrUa3vKHnoXHvUa7jmluUOUh7/s83X
   LQ3gAbQF2N5QFGaZFri4ymiGAYpJvaGmonk4gWCyDMjxZRfsnw8JkM/Bd
   A==;
X-CSE-ConnectionGUID: hzvzi5vwSgS5RC9sBUuuoA==
X-CSE-MsgGUID: W/fs8kFpQV2MSBaikaFNTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35791564"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="35791564"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 16:40:40 -0700
X-CSE-ConnectionGUID: 0Njm88fCSNSR038W0HfQJA==
X-CSE-MsgGUID: QroM+BY8Sie67ZBtQqswYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="66453577"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.50]) ([10.125.111.50])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 16:40:38 -0700
Message-ID: <c476dc9a-8607-417e-ae07-effba90cf02e@intel.com>
Date: Mon, 9 Sep 2024 16:40:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] cxl: Move mailbox related bits to the same context
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
 <20240905223711.1990186-3-dave.jiang@intel.com>
 <66df8232cec82_3c80f229462@iweiny-mobl.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <66df8232cec82_3c80f229462@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/24 4:18 PM, Ira Weiny wrote:
> Dave Jiang wrote:
>> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
>> it. This allows isolation of all CXL mailbox data in order to export
>> some of the calls to external kernel callers and avoid exporting of CXL
>> driver specific bits such has device states. The allocation of
>> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> 
> 						cxl_mailbox_init()?

Yes. Thanks. Leftover from previously.


> 
>> mailbox can be created independently.
>>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>> v4:
>> - cxl_mbox could be NULL in cxl_mailbox_init. (Alison)
>> - rework after headers moves
>> ---
>>  drivers/cxl/core/mbox.c      | 57 +++++++++++++++++++--------
>>  drivers/cxl/core/memdev.c    | 18 +++++----
>>  drivers/cxl/cxlmem.h         | 21 +++++-----
>>  drivers/cxl/pci.c            | 76 ++++++++++++++++++++++++------------
>>  drivers/cxl/pmem.c           |  4 +-
>>  include/cxl/mailbox.h        | 28 +++++++++++++
>>  tools/testing/cxl/test/mem.c | 44 +++++++++++++++------
>>  7 files changed, 176 insertions(+), 72 deletions(-)
>>  create mode 100644 include/cxl/mailbox.h
>>
> 
> [snip]
> 
>>  
>> +int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>> +{
>> +	if (!cxl_mbox || !host)
>> +		return -EINVAL;
>> +
>> +	cxl_mbox->host = host;
>> +	mutex_init(&cxl_mbox->mbox_mutex);
>> +	rcuwait_init(&cxl_mbox->mbox_wait);
> 
> I would have expected a few more things in here from
> cxl_pci_setup_mailbox().  For example is irq setup needed?  Perhaps
> deferred for now?

I split out the initialization of data structures and the setup of the hardware. We can further deal with that as things become more clearer what a type2 device that wants a mailbox would look like.

> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, CXL);
>> +
>>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>  {
>>  	struct cxl_memdev_state *mds;
>> @@ -1418,7 +1444,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>  		return ERR_PTR(-ENOMEM);
>>  	}
>>  
>> -	mutex_init(&mds->mbox_mutex);
>>  	mutex_init(&mds->event.log_lock);
>>  	mds->cxlds.dev = dev;
>>  	mds->cxlds.reg_map.host = dev;
> 
> [snip]
> 
>>  
>> +static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
>> +{
>> +	int rc;
>> +
>> +	/*
>> +	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
>> +	 */
>> +	if (!cxlds->reg_map.device_map.mbox.valid)
>> +		return -ENODEV;
> 
> This seems like new functionality.  I don't think it is wrong but it was
> not checked before right?  If I missed the check are we not checking 2x?

Yes this is a new check. Previous code assumed that we never fail when it comes to mailboxes. I'm adding this to fail if mailbox isn't discovered as this is not in compliance with the spec.

> 
>> +
>> +	rc = cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
>> +}
>> +
>>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  {
>>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>> @@ -846,6 +868,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (rc)
>>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>>  
>> +	rc = cxl_pci_type3_init_mailbox(cxlds);
>> +	if (rc)
>> +		return rc;
>> +
> 
> I feel like this should be just before cxl_pci_setup_mailbox() after alloc
> irq.  Because we are removing some of the setup from
> cxl_pci_setup_mailbox() and putting it into cxl_pci_type3_init_mailbox()
> it just flows better in my mind.  I don't think there is a requirement to
> put it there though.

I think I had it running earlier to hit that check in case a mailbox did not exist so we can just bail without doing all the additional work. At least that was my thought process.

> 
> Ira
> 
> [snip]
