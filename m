Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7AC6FA8E
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 16:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjB1QsS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 11:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB1QsR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 11:48:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD4A34F58
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 08:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677602862; x=1709138862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n9uaDmIcKlKwHCL793MAr/1gB+f9o+2Knaox8BR3CzM=;
  b=f1lBe9WTHBiBnwlJuz+3YqmmHR4wlBkceU9n/MP2WwemfYU6/aSuT1qq
   3DEbV6M+YtTzmonQd5IMF8emwLdQl56ecVdDmrVBegZGX3Kw6YnGzVMZh
   /GQhsytl1a83W1cruw9lJ3lZqXHGlT73+KQigRlDXfxTmRZfcpEYXjdeK
   U8UcA7jcEkgSMZ08HlhqfMUEXX7cFKAqi8PMPbEvNPlYbp+FZk2okR//Z
   vgcB7ehwNVcBAsWUV+WH8io4hAwiWyoBKVH4Jq/CZvWDUhEH1wu96o4n1
   B0txBnvr3SlLaeOMMXUsj5B6E16bYtFAg+lZhapGX0YimXFLKoc9Bnf0s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="334227440"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="334227440"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:47:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="738251637"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="738251637"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:47:41 -0800
Message-ID: <44d17cd5-a580-1f1d-980c-137834ed6125@intel.com>
Date:   Tue, 28 Feb 2023 09:47:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 2/7] cxl/security: Add security state sysfs ABI
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-3-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230224194652.1990604-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/24/23 12:46 PM, Davidlohr Bueso wrote:
> This adds the sysfs memdev's security/ directory with
> a single 'state' file, which is always visible. In the
> case of unsupported security features, this will show
> disabled.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

I don't have strong opinion on whether the state attrib should be 
visible if there's no security support, but this deviates from the 
nvdimm security state behavior.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++
>   drivers/cxl/core/memdev.c               | 49 +++++++++++++++++++++++++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..e9c432a5a841 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -57,6 +57,14 @@ Description:
>   		host PCI device for this memory device, emit the CPU node
>   		affinity for this device.
>   
> +What:		/sys/bus/cxl/devices/memX/security/state
> +Date:		February, 2023
> +KernelVersion:	v6.4
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The security state for that device. The following states
> +		are available: frozen, locked, unlocked and disabled (which
> +		is also the case for any unsupported security features).
>   
>   What:		/sys/bus/cxl/devices/*/devtype
>   Date:		June, 2021
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0af8856936dc..47cc625bb1b0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. */
>   
> +#include <linux/memregion.h>
>   #include <linux/device.h>
>   #include <linux/slab.h>
>   #include <linux/idr.h>
> @@ -89,6 +90,43 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>   static struct device_attribute dev_attr_pmem_size =
>   	__ATTR(size, 0444, pmem_size_show, NULL);
>   
> +static ssize_t security_state_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	u32 sec_out;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_get_security_output {
> +		__le32 flags;
> +	} out;
> +	struct cxl_mbox_cmd mbox_cmd = {
> +		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
> +		.payload_out = &out,
> +		.size_out = sizeof(out),
> +	};
> +
> +	if (!cpu_cache_has_invalidate_memregion())
> +		goto disabled;
> +
> +	if (cxl_internal_send_cmd(cxlds, &mbox_cmd) < 0)
> +		goto disabled;
> +
> +	sec_out = le32_to_cpu(out.flags);
> +	if (!(sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		goto disabled;
> +	if (sec_out & CXL_PMEM_SEC_STATE_FROZEN)
> +		return sysfs_emit(buf, "frozen\n");
> +	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return sysfs_emit(buf, "locked\n");
> +	else
> +		return sysfs_emit(buf, "unlocked\n");
> +disabled:
> +	return sysfs_emit(buf, "disabled\n");
> +}
> +
> +static struct device_attribute dev_attr_security_state =
> +	__ATTR(state, 0444, security_state_show, NULL);
> +
>   static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> @@ -148,10 +186,21 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>   	.attrs = cxl_memdev_pmem_attributes,
>   };
>   
> +static struct attribute *cxl_memdev_security_attributes[] = {
> +	&dev_attr_security_state.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_memdev_security_attribute_group = {
> +	.name = "security",
> +	.attrs = cxl_memdev_security_attributes,
> +};
> +
>   static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>   	&cxl_memdev_attribute_group,
>   	&cxl_memdev_ram_attribute_group,
>   	&cxl_memdev_pmem_attribute_group,
> +	&cxl_memdev_security_attribute_group,
>   	NULL,
>   };
>   
