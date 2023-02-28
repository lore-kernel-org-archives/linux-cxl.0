Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2EC64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 17:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjB1R2c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 12:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB1R2a (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 12:28:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B61E1DC
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 09:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677605308; x=1709141308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7u2e5ZdUrxxj3A0Fs5cHBpKSd//x5dSo3IoLacMmaUI=;
  b=R2xQlrwtWNZXAP2h7oYr2VQ97Eg9LGdmSEVaV4UGqf9Qs+mH02Og9Nop
   IMut51nqJ7cwFPObh9pKqFs9rieZKxgi9Dgo79sEQB5KBEj1V60xpVSbu
   lAiy+U5Q+oe82YZ+sSdEkNlcM3uhxIe+3INDTZZlmLAiB0YfnuGUFe2Q1
   ziCMN203nf2TTY2HeH9nE8wODgxESxDaZc6M8jSbntx0h5wAfkn67rqpB
   vK351eJ0B92+U6+QYY0qq728jS+a7L3G1cHzMIXoLUQxFdgScwetfu/vv
   nb+p+DDws+q5hVxAvDB8Tq9ZUMgbli6MLoPsyw+ZPUdZkNqx8+3JfA7c/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="332927983"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="332927983"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 09:28:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="783948486"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="783948486"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 09:28:28 -0800
Message-ID: <7333903c-4ef9-6f1f-9767-e32f228149b3@intel.com>
Date:   Tue, 28 Feb 2023 10:28:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 4/7] cxl/mem: Support Sanitation
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-5-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230224194652.1990604-5-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/24/23 12:46 PM, Davidlohr Bueso wrote:
> Implement support for the non-pmem exclusive sanitize (aka overwrite),
> per CXL specs. This is the baseline for the sanitize-on-release
> functionality.
> 
> To properly support this feature, create a 'security/sanitize' sysfs
> file that when read will list the current pmem security state and
> when written to, perform the requested operation.

I think this segment needs to be updated? The attrib is write only from 
the code below.

DJ

> 
> This operation can run in the background and the driver must wait
> for completion (no timeout), where the poller will awake every
> ~10 seconds (this could be further based on the size of the device).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++
>   drivers/cxl/core/mbox.c                 | 61 +++++++++++++++++++++++++
>   drivers/cxl/core/memdev.c               | 39 ++++++++++++++++
>   drivers/cxl/cxlmem.h                    |  2 +
>   4 files changed, 116 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index e9c432a5a841..b315d78b7e91 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -66,6 +66,20 @@ Description:
>   		are available: frozen, locked, unlocked and disabled (which
>   		is also the case for any unsupported security features).
>   
> +What:          /sys/bus/cxl/devices/memX/security/sanitize
> +Date:          February, 2023
> +KernelVersion: v6.4
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +	       (WO) Write a boolean 'true' string value to this attribute to
> +	       sanitize the device to securely re-purpose or decommission it.
> +	       This is done by ensuring that all user data and meta-data,
> +	       whether it resides in persistent capacity, volatile capacity,
> +	       or the LSA, is made permanently unavailable by whatever means
> +	       is appropriate for the media type. This causes all CPU caches
> +	       to be flushed. If this sysfs entry is not present then the
> +	       architecture does not support security features.
> +
>   What:		/sys/bus/cxl/devices/*/devtype
>   Date:		June, 2021
>   KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..885de3506735 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>   #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/memregion.h>
>   #include <linux/security.h>
>   #include <linux/debugfs.h>
>   #include <linux/ktime.h>
> @@ -1021,6 +1022,66 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>   
> +/**
> + * cxl_mem_sanitize() - Send sanitation (aka overwrite) command to the device.
> + * @cxlds: The device data for the operation
> + *
> + * Return: 0 if the command was executed successfully, regardless of
> + * whether or not the actual security operation is done in the background.
> + * Upon error, return the result of the mailbox command or -EINVAL if
> + * security requirements are not met. CPU caches are flushed before and
> + * after succesful completion of each command.
> + *
> + * See CXL 3.0 @8.2.9.8.5.1 Sanitize.
> + */
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds)
> +{
> +	int rc;
> +	u32 sec_out = 0;
> +	struct cxl_get_security_output {
> +		__le32 flags;
> +	} out;
> +	struct cxl_mbox_cmd sec_cmd = {
> +		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
> +		.payload_out = &out,
> +		.size_out = sizeof(out),
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = {
> +		.opcode = CXL_MBOX_OP_SANITIZE,
> +		.poll_interval = 10000UL,
> +	};
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		return -EINVAL;
> +
> +	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
> +		return rc;
> +	}
> +
> +	/*
> +	 * Prior to using these commands, any security applied to
> +	 * the user data areas of the device shall be DISABLED (or
> +	 * UNLOCKED for secure erase case).
> +	 */
> +	sec_out = le32_to_cpu(out.flags);
> +	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
> +		return -EINVAL;
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> +		return rc;
> +	}
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
> +
>   static int add_dpa_res(struct device *dev, struct resource *parent,
>   		       struct resource *res, resource_size_t start,
>   		       resource_size_t size, const char *type)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 68c0ab06b999..a1bb095d081c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -127,6 +127,34 @@ static ssize_t security_state_show(struct device *dev,
>   static struct device_attribute dev_attr_security_state =
>   	__ATTR(state, 0444, security_state_show, NULL);
>   
> +static ssize_t security_sanitize_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	ssize_t rc;
> +	bool sanitize;
> +
> +	rc = kstrtobool(buf, &sanitize);
> +	if (rc)
> +		return rc;
> +
> +	if (sanitize) {
> +		if (cxl_memdev_active_region(cxlmd))
> +			return -EBUSY;
> +
> +		rc = cxl_mem_sanitize(cxlds);
> +	}
> +
> +	if (rc == 0)
> +		rc = len;
> +	return rc;
> +}
> +
> +static struct device_attribute dev_attr_security_sanitize =
> +	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
> +
>   static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> @@ -188,11 +216,22 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>   
>   static struct attribute *cxl_memdev_security_attributes[] = {
>   	&dev_attr_security_state.attr,
> +	&dev_attr_security_sanitize.attr,
>   	NULL,
>   };
>   
> +static umode_t cxl_security_visible(struct kobject *kobj,
> +				    struct attribute *a, int n)
> +{
> +	if (!cpu_cache_has_invalidate_memregion() &&
> +	    a == &dev_attr_security_sanitize.attr)
> +		return 0;
> +	return a->mode;
> +}
> +
>   static struct attribute_group cxl_memdev_security_attribute_group = {
>   	.name = "security",
> +	.is_visible = cxl_security_visible,
>   	.attrs = cxl_memdev_security_attributes,
>   };
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4e31f3234519..0d2009b36933 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -631,6 +631,8 @@ static inline void cxl_mem_active_dec(void)
>   }
>   #endif
>   
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds);
> +
>   struct cxl_hdm {
>   	struct cxl_component_regs regs;
>   	unsigned int decoder_count;
