Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F5CC43217
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Dec 2022 17:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLAR01 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLAR0T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Dec 2022 12:26:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17AD28E01
        for <linux-cxl@vger.kernel.org>; Thu,  1 Dec 2022 09:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669915577; x=1701451577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yHLEaDvIv5pbx0WabPPIZPXIp6ootz5fy0ymWV5aJ0U=;
  b=j1taiSESwJjNeJgyWfotjFmDRJDdxRmXi7ILZTpkFIdsKYF9h3GLXrZR
   n5aMo4Iv7/+I5bb5a/jFaUq9AyLiOgUVnOBw8c9sCyy1f4qEyor8Xg6np
   Qr3npsjNVryf13Bo3jB1I03uPO4UxWqSW62d8h0Vkj2dPVGQzmnO2dMzV
   O19gDCdcpGbWFMqvB7jyQ1tX76fKjuiaQ7RbhtGUb+eJEO27hMQRj13Bt
   cqHwmXr2jwri5v/k+vtl93NwzkMSF2cBDiFmN8B95C6IECVlxXB/NJOM8
   qnr/IxLnuDA7ps/bt8ucSxwfLcWEYVx+MOjpJmtlFm02+zvcU41Aa+ccZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="315772426"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="315772426"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 09:26:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="786970113"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="786970113"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 09:26:16 -0800
Message-ID: <d1d89d52-1153-1c13-f4be-2641e3cffd7b@intel.com>
Date:   Thu, 1 Dec 2022 10:26:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] cxl/memdev: Add support for the Inject Poison mailbox
 command
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <cover.1669781852.git.alison.schofield@intel.com>
 <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3c260749c833f51d5cad9ae3912debcdf8b82753.1669781852.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/29/2022 9:34 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the INJECT POISON mailbox command. Add
> a sysfs attribute and memdev driver support for injecting poison.
> 
> When a Device Physical Address (DPA) is written to the inject_poison
> sysfs attribute send an inject poison command to the device for the

A comma between attribute and send would make this read better.

> specified address.
> 
> Per the CXL Specification (8.2.9.8.4.2), after receiving a valid

spec v3?

> inject poison request, the device will return poison when the address
> is accessed through the CXL.mem bus. Injecting poison adds the address
> to the device's Poison List and the error source is set to injected

comma before 'and'.
'the' before 'injected'

> error. In addition, the device adds a poison creation event to its
> internal Informational Event log, updates the Event Status register,
> and if configured, interrupts the host.
> 
> Also, per the CXL Specification, it is not an error to inject poison
> into an address that already has poison present and no error is returned

comma before 'and'.

DJ

> from the device. The memdev driver performs basic sanity checking on the
> address, however, it does not go as far as reading the poison list to see
> if the address is on the list. That discovery is left to the device.
> 
> The inject_poison attribute is only visible for devices supporting
> the capability.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 19 +++++++++
>   drivers/cxl/core/memdev.c               | 53 +++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h                    |  3 ++
>   3 files changed, 75 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index b715a4609718..20db97f7a1aa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -416,3 +416,22 @@ Description:
>   		if accessed, and the source of the poison. The retrieved
>   		errors are logged as kernel trace events with the label
>   		'cxl_poison'.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/inject_poison
> +Date:		December, 2022
> +KernelVersion:	v6.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute the memdev driver sends an inject poison command to
> +		the device for the specified address. If successful, the device
> +		returns poison when the address is accessed through the CXL.mem
> +		bus. Injecting poison adds the address to the device's Poison
> +		List and the error source is set to injected error. In addition,
> +		the device adds a poison creation event to its internal
> +		Informational Event log, updates the Event Status register, and
> +		if configured, interrupts the host. It is not an error to inject
> +		poison into an address that already has poison present and no
> +		error is returned. The inject_poison attribute is only visible
> +                for devices supporting the capability.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d08b7295a01c..71130813030f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -142,6 +142,51 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>   }
>   static DEVICE_ATTR_WO(trigger_poison_list);
>   
> +static int cxl_validate_poison_dpa(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	if (!resource_size(&cxlds->dpa_res)) {
> +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> +		return -EINVAL;
> +	}
> +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> +			dpa, &cxlds->dpa_res);
> +		return -EINVAL;
> +	}
> +	if ((dpa & CXL_POISON_INJECT_RESERVED) != 0) {
> +		dev_dbg(cxlds->dev, "dpa reserve bit(s) [5:0] set 0x%llx\n",
> +			dpa);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t inject_poison_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 dpa;
> +	int rc;
> +
> +	rc = kstrtou64(buf, 0, &dpa);
> +	if (rc)
> +		return rc;
> +	rc = cxl_validate_poison_dpa(cxlds, dpa);
> +	if (rc)
> +		return rc;
> +
> +	dpa = cpu_to_le64(dpa);
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_INJECT_POISON, &dpa,
> +			       sizeof(dpa), NULL, cxlds->payload_size);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(inject_poison);
> +
>   static struct attribute *cxl_memdev_attributes[] = {
>   	&dev_attr_serial.attr,
>   	&dev_attr_firmware_version.attr,
> @@ -149,6 +194,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>   	&dev_attr_label_storage_size.attr,
>   	&dev_attr_numa_node.attr,
>   	&dev_attr_trigger_poison_list.attr,
> +	&dev_attr_inject_poison.attr,
>   	NULL,
>   };
>   
> @@ -175,6 +221,13 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>   			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>   			return 0;
>   	}
> +	if (a == &dev_attr_inject_poison.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_INJECT_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
> +			return 0;
> +	}
>   	return a->mode;
>   }
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19a9e545ac19..0d4c34be7335 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -396,6 +396,9 @@ struct cxl_mbox_poison_payload_out {
>   #define CXL_POISON_SOURCE_INJECTED	3
>   #define CXL_POISON_SOURCE_VENDOR	7
>   
> +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> +#define CXL_POISON_INJECT_RESERVED	GENMASK_ULL(5, 0)
> +
>   /**
>    * struct cxl_mem_command - Driver representation of a memory device command
>    * @info: Command information as it exists for the UAPI
