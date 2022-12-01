Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10244C47088
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Dec 2022 17:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLARzV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLARzB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Dec 2022 12:55:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E231D671
        for <linux-cxl@vger.kernel.org>; Thu,  1 Dec 2022 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669917289; x=1701453289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KJ0QhsxSQMBud6c1D/P30da9Dj71+KK5C0N/F5A1Zy4=;
  b=UedIgouoV1PdtXeuRTtVuPWmtG1DWs1PxAzdyDV9IvJ7eyWOhk1agGHb
   e4RuBX3awlI1B5llaRuDC2kZbwdi1OvewqSi1xc5nqJqEBnDqAKhAdyWS
   gpmU2LqBKyMYcBffFQnX/BeMXCp3j79ARbfH3G3v2+Kgdlphsttvl+iq6
   ZRye6cbV77zDshks6XHGRl2d8gARWOwO+66xBzp9NMSqNSQ5UFkVUYAp/
   kwpPc4Y2aPdqlrkQEwEEdEH853Wzq/aXsr4pHafFUkSAeGRSpihulWj20
   TmlGGvt9Z8aVOHVaDOyoWpKHHo1+5NUJg7i08FjyPPGAryiZunyPZbUoj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296109426"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="296109426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 09:54:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="769318739"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="769318739"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 09:54:47 -0800
Message-ID: <c803589c-7808-a8d2-7f48-e97e5bbfa844@intel.com>
Date:   Thu, 1 Dec 2022 10:54:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 2/5] cxl/memdev: Add support for the Clear Poison mailbox
 command
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <cover.1669781852.git.alison.schofield@intel.com>
 <091f50b2644f220f0607633a4a953184e9c88b53.1669781852.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <091f50b2644f220f0607633a4a953184e9c88b53.1669781852.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/29/2022 9:34 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the CLEAR POISON mailbox command. Add
> a sysfs attribute and memdev driver support for clearing poison.
> 
> When a Device Physical Address (DPA) is written to the clear_poison
> sysfs attribute send a clear poison command to the device for the

comma between 'attribute' and 'send'

> specified address.
> 
> Per the CXL Specification (8.2.9.8.4.3), after receiving a valid clear

Please add spec version.

> poison request, the device removes the address from the device's Poison
> List and writes 0 (zero) for 64 bytes starting at address. If the device
> cannot clear poison from the address, it returns a permanent media error
> and ENXIO is returned to the user.
> 
> Additionally, and per the spec also, it is not an error to clear poison
> of an address that is not poisoned. No error is returned and the address
> is not overwritten. The memdev driver performs basic sanity checking on
> the address, however, it does not go as far as reading the poison list to
> see if the address is poisoned before clearing. That discovery is left to
> the device. The device safely handles that case.
> 
> Implementation note: Although the CXL specification defines the clear
> command to accept 64 bytes of 'write-data' to be used when clearing
> the poisoned address, this implementation always uses 0 (zeros) for
> the write-data.
> 
> The clear_poison attribute is only visible for devices supporting the
> capability.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 17 +++++++++
>   drivers/cxl/core/memdev.c               | 47 +++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h                    |  6 ++++
>   3 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 20db97f7a1aa..9d2b0fa07e17 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -435,3 +435,20 @@ Description:
>   		poison into an address that already has poison present and no
>   		error is returned. The inject_poison attribute is only visible
>                   for devices supporting the capability.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/clear_poison
> +Date:		December, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute the memdev driver sends a clear poison command to the

comma between 'attribute' and 'the'.

DJ

> +		device for the specified address. Clearing poison removes the
> +		address from the device's Poison List and writes 0 (zero)
> +		for 64 bytes starting at address. It is not an error to clear
> +		poison from an address that does not have poison set, and if
> +		poison was not set, the address is not overwritten. If the
> +		device cannot clear poison from the address, ENXIO is returned.
> +		The clear_poison attribute is only visible for devices
> +		supporting the capability.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 71130813030f..85caffd5a85c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -187,6 +187,44 @@ static ssize_t inject_poison_store(struct device *dev,
>   }
>   static DEVICE_ATTR_WO(inject_poison);
>   
> +static ssize_t clear_poison_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_clear_poison *pi;
> +	u64 dpa;
> +	int rc;
> +
> +	rc = kstrtou64(buf, 0, &dpa);
> +	if (rc)
> +		return rc;
> +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> +	if (rc)
> +		return rc;
> +	pi = kzalloc(sizeof(*pi), GFP_KERNEL);
> +	if (!pi)
> +		return -ENOMEM;
> +	/*
> +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> +	 * is defined to accept 64 bytes of 'write-data', along with the
> +	 * address to clear. The device writes 'write-data' into the DPA,
> +	 * atomically, while clearing poison if the location is marked as
> +	 * being poisoned.
> +	 *
> +	 * Always use '0' for the write-data.
> +	 */
> +	pi->address = cpu_to_le64(dpa);
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_POISON, pi,
> +			       sizeof(*pi), NULL, cxlds->payload_size);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(clear_poison);
> +
>   static struct attribute *cxl_memdev_attributes[] = {
>   	&dev_attr_serial.attr,
>   	&dev_attr_firmware_version.attr,
> @@ -195,6 +233,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>   	&dev_attr_numa_node.attr,
>   	&dev_attr_trigger_poison_list.attr,
>   	&dev_attr_inject_poison.attr,
> +	&dev_attr_clear_poison.attr,
>   	NULL,
>   };
>   
> @@ -228,6 +267,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>   			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>   			return 0;
>   	}
> +	if (a == &dev_attr_clear_poison.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds)) {
> +			return 0;
> +		}
> +	}
>   	return a->mode;
>   }
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0d4c34be7335..532adf9c3afd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -399,6 +399,12 @@ struct cxl_mbox_poison_payload_out {
>   /* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
>   #define CXL_POISON_INJECT_RESERVED	GENMASK_ULL(5, 0)
>   
> +/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
> +struct cxl_mbox_clear_poison {
> +	__le64 address;
> +	u8 write_data[64];
> +} __packed;
> +
>   /**
>    * struct cxl_mem_command - Driver representation of a memory device command
>    * @info: Command information as it exists for the UAPI
