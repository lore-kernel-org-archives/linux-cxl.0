Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAF5C43217
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Dec 2022 16:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLAQmI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiLAQmE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Dec 2022 11:42:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572368E5BB
        for <linux-cxl@vger.kernel.org>; Thu,  1 Dec 2022 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669912923; x=1701448923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sqJPgtgZ5bigfOiliOly1y6WY/PUC7U+3MvgnOMOCVQ=;
  b=SacbluGHJ+m1GcYc1gXQrQWt0Zq3FyfydlwUiCWtKE93AU2D5Dw8wr5b
   y46NHbMVUPgJLrrsE38A5GDihW3zwpr1p6Tc3UuNZnyUQ3JfY8+HK5Rc8
   QduCf7hcY3s3sIBhyBwNUn+1rWEeOw6CwyERFm0BFju931KKM2+r79jiV
   ONJAToUWvXKlo/xVpBY6D3mahDGTZf513KlceR+zqK2PaBZ5VDGmiv4Vo
   Bh2+mSJu0kzDbZlhiLCDQyKrlGtFcMvGdP1An4eA1BCy35bq/Cm+OGWkH
   1w2QkuN9OlcJ1ezMfEuyYvF/+HNEp2Zcp0FwDoAr6jcbo3VFzRVIgCgej
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="402006430"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="402006430"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 08:42:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="750876667"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="750876667"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 08:42:02 -0800
Message-ID: <a595f3dd-3655-eda8-34ed-b11445068e62@intel.com>
Date:   Thu, 1 Dec 2022 09:42:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison mailbox
 command
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        alison.schofield@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org
References: <cover.1669781852.git.alison.schofield@intel.com>
 <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
 <20221130143136.00003808@Huawei.com> <20221130144057.000024de@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221130144057.000024de@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/30/2022 7:40 AM, Jonathan Cameron wrote:
> On Wed, 30 Nov 2022 14:31:36 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Tue, 29 Nov 2022 20:34:33 -0800
>> alison.schofield@intel.com wrote:
>>
>>> From: Alison Schofield <alison.schofield@intel.com>
>>>
>>> CXL devices optionally support the INJECT POISON mailbox command. Add
>>> a sysfs attribute and memdev driver support for injecting poison.
>>>
>>> When a Device Physical Address (DPA) is written to the inject_poison
>>> sysfs attribute send an inject poison command to the device for the
>>> specified address.
>>>
>>> Per the CXL Specification (8.2.9.8.4.2), after receiving a valid
>>> inject poison request, the device will return poison when the address
>>> is accessed through the CXL.mem bus. Injecting poison adds the address
>>> to the device's Poison List and the error source is set to injected
>>> error. In addition, the device adds a poison creation event to its
>>> internal Informational Event log, updates the Event Status register,
>>> and if configured, interrupts the host.
>>>
>>> Also, per the CXL Specification, it is not an error to inject poison
>>> into an address that already has poison present and no error is returned
>>> from the device. The memdev driver performs basic sanity checking on the
>>> address, however, it does not go as far as reading the poison list to see
>>> if the address is on the list. That discovery is left to the device.
>>>
>>> The inject_poison attribute is only visible for devices supporting
>>> the capability.
>>>
>>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> A few trivial things inline.  With those fixes LGTM
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>>> ---
>>>   Documentation/ABI/testing/sysfs-bus-cxl | 19 +++++++++
>>>   drivers/cxl/core/memdev.c               | 53 +++++++++++++++++++++++++
>>>   drivers/cxl/cxlmem.h                    |  3 ++
>>>   3 files changed, 75 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>>> index b715a4609718..20db97f7a1aa 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>>> @@ -416,3 +416,22 @@ Description:
>>>   		if accessed, and the source of the poison. The retrieved
>>>   		errors are logged as kernel trace events with the label
>>>   		'cxl_poison'.
>>> +
>>> +
>>> +What:		/sys/bus/cxl/devices/memX/inject_poison
>>> +Date:		December, 2022
>>> +KernelVersion:	v6.2
>>> +Contact:	linux-cxl@vger.kernel.org
>>> +Description:
>>> +		(WO) When a Device Physical Address (DPA) is written to this
>>> +		attribute the memdev driver sends an inject poison command to
>>> +		the device for the specified address. If successful, the device
>>> +		returns poison when the address is accessed through the CXL.mem
>>> +		bus. Injecting poison adds the address to the device's Poison
>>> +		List and the error source is set to injected error. In addition,
>> "set to Injected."
>>
>> perhaps to match spec naming in Media Error Record.
>>
>>> +		the device adds a poison creation event to its internal
>>> +		Informational Event log, updates the Event Status register, and
>>> +		if configured, interrupts the host. It is not an error to inject
>>> +		poison into an address that already has poison present and no
>>> +		error is returned. The inject_poison attribute is only visible
>>> +                for devices supporting the capability.
>>
>> White space issues (spaces instead of tabs?)
>>
>> Add something about the masked bits / granularity of addresses that are accepted.
>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index d08b7295a01c..71130813030f 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -142,6 +142,51 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>>>   }
>>>   static DEVICE_ATTR_WO(trigger_poison_list);
>>>   
>>> +static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
>>> +{
>>> +	if (!resource_size(&cxlds->dpa_res)) {
>>> +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
>>> +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
>>> +			dpa, &cxlds->dpa_res);
>>> +		return -EINVAL;
>>> +	}
>>> +	if ((dpa & CXL_POISON_INJECT_RESERVED) != 0) {
>>> +		dev_dbg(cxlds->dev, "dpa reserve bit(s) [5:0] set 0x%llx\n",
>>> +			dpa);
>>> +		return -EINVAL;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static ssize_t inject_poison_store(struct device *dev,
>>> +				   struct device_attribute *attr,
>>> +				   const char *buf, size_t len)
>>> +{
>>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>> +	u64 dpa;
>>> +	int rc;
>>> +
>>> +	rc = kstrtou64(buf, 0, &dpa);
>>> +	if (rc)
>>> +		return rc;
>>> +	rc = cxl_validate_poison_dpa(cxlds, dpa);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	dpa = cpu_to_le64(dpa);
>>> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_INJECT_POISON, &dpa,
>>
>> Endianness?
> 
> Got thrown by the type and missed the cpu_to_le64().  Use a local __le64 so it's all explicit.
> One of the static analysis tools will correctly moan about storing it to a u64
> (can't remember which).

Sparse. I just got yelled at by 0-day for something similar. :)

> 
>>
>>> +			       sizeof(dpa), NULL, cxlds->payload_size);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	return len;
>>> +}
>>> +static DEVICE_ATTR_WO(inject_poison);
>>> +
>>>   static struct attribute *cxl_memdev_attributes[] = {
>>>   	&dev_attr_serial.attr,
>>>   	&dev_attr_firmware_version.attr,
>>> @@ -149,6 +194,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>>>   	&dev_attr_label_storage_size.attr,
>>>   	&dev_attr_numa_node.attr,
>>>   	&dev_attr_trigger_poison_list.attr,
>>> +	&dev_attr_inject_poison.attr,
>>>   	NULL,
>>>   };
>>>   
>>> @@ -175,6 +221,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>>>   			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>>>   			return 0;
>>>   	}
>>> +	if (a == &dev_attr_inject_poison.attr) {
>>> +		struct device *dev = kobj_to_dev(kobj);
>>> +
>>> +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
>>> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>>> +			return 0;
>>> +	}
>>>   	return a->mode;
>>>   }
>>>   
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index 19a9e545ac19..0d4c34be7335 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -396,6 +396,9 @@ struct cxl_mbox_poison_payload_out {
>>>   #define CXL_POISON_SOURCE_INJECTED	3
>>>   #define CXL_POISON_SOURCE_VENDOR	7
>>>   
>>> +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
>>> +#define CXL_POISON_INJECT_RESERVED	GENMASK_ULL(5, 0)
>>> +
>>>   /**
>>>    * struct cxl_mem_command - Driver representation of a memory device command
>>>    * @info: Command information as it exists for the UAPI
>>
>>
> 
