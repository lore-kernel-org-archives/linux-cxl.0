Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2631DC64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 18:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjB1ScD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjB1ScC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 13:32:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE710253
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677609121; x=1709145121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x1p8iyolm9RyR+F89mBpArMWNYmUSsEj5pwaTq6iv7Q=;
  b=JiioLwo1eqjH2Dg7RGeMzK4tW6ZYZKEm061bWARidbcD560DTVcXB5Vy
   7AKb6HXZ02R1MHlYbB8D3Oc91+1MZnWloxpJrEi6qDcfhq8sDNeZwMV2x
   F5TVulPrWGWrW5AFymP5GywrY3MKmcf/syL2gLznIkSURkhZ6KKnGoLI/
   H9mgOGzQb+7pzI/bKfvPF7LkI+bBuqYKdF9hNL/wqOeoqU+61i3laouXY
   VV3cvWYVzunCS0XfRSkgcH1pFpkjWtaRLuxCtkCSm/SsfBGwr6LQQSmlq
   aI/uGijWdr8atKusddhp4Hc0ewC5ggmL/XeyU6aA37+Pv9vefO3Ef2DoW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="322470199"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="322470199"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 10:32:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="674259364"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="674259364"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 10:32:00 -0800
Message-ID: <17be3112-2a56-1def-794a-d37187ec190d@intel.com>
Date:   Tue, 28 Feb 2023 11:31:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 6/7] cxl/mem: Support Secure Erase
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-7-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230224194652.1990604-7-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/24/23 12:46 PM, Davidlohr Bueso wrote:
> Implement support for the non-pmem exclusive secure erase, per
> CXL specs.
> 
> To properly support this feature, create a 'security/erase' sysfs
> file that when read will list the current pmem security state and
> when written to, perform the requested operation.

Need update. WO attrib.

DJ

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 12 ++++++
>   drivers/cxl/core/mbox.c                 | 56 +++++++++++++++++++++++++
>   drivers/cxl/core/memdev.c               | 32 +++++++++++++-
>   drivers/cxl/cxlmem.h                    |  2 +
>   4 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index b315d78b7e91..91a74e27f248 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -80,6 +80,18 @@ Description:
>   	       to be flushed. If this sysfs entry is not present then the
>   	       architecture does not support security features.
>   
> +What:          /sys/bus/cxl/devices/memX/security/erase
> +Date:          February, 2023
> +KernelVersion: v6.4
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +	       (WO) Write a boolean 'true' string value to this attribute to
> +	       secure erase the device to securely re-purpose or decommission
> +	       it. This is done by hanging the media encryption keys for all
> +	       user data areas of the device. This causes all CPU caches to
> +	       be flushed. If this sysfs entry is not present then the
> +	       architecture does not support security features.
> +
>   What:		/sys/bus/cxl/devices/*/devtype
>   Date:		June, 2021
>   KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 885de3506735..bf206fe26839 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1082,6 +1082,62 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
>   
> +/**
> + * cxl_mem_secure_erase() - Send secure erase command to the device.
> + * @cxlds: The device data for the operation
> + *
> + * Return: 0 if the command was executed successfully.
> + * Upon error, return the result of the mailbox command or -EINVAL if
> + * security requirements are not met. CPU caches are flushed before and
> + * after succesful completion of each command.
> + *
> + * See CXL 3.0 @8.2.9.8.5.2 Secure Erase.
> + */
> +int cxl_mem_secure_erase(struct cxl_dev_state *cxlds)
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
> +		.opcode = CXL_MBOX_OP_SECURE_ERASE,
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
> +	sec_out = le32_to_cpu(out.flags);
> +	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
> +		return -EINVAL;
> +
> +	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return -EINVAL;
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to secure erase device : %d", rc);
> +		return rc;
> +	}
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_secure_erase, CXL);
> +
>   static int add_dpa_res(struct device *dev, struct resource *parent,
>   		       struct resource *res, resource_size_t start,
>   		       resource_size_t size, const char *type)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a1bb095d081c..6334a0d1a925 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -155,6 +155,34 @@ static ssize_t security_sanitize_store(struct device *dev,
>   static struct device_attribute dev_attr_security_sanitize =
>   	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
>   
> +static ssize_t security_erase_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	ssize_t rc;
> +	bool erase;
> +
> +	rc = kstrtobool(buf, &erase);
> +	if (rc)
> +		return rc;
> +
> +	if (erase) {
> +		if (cxl_memdev_active_region(cxlmd))
> +			return -EBUSY;
> +
> +		rc = cxl_mem_secure_erase(cxlds);
> +	}
> +
> +	if (rc == 0)
> +		rc = len;
> +	return rc;
> +}
> +
> +static struct device_attribute dev_attr_security_erase =
> +	__ATTR(sanitize, 0200, NULL, security_erase_store);
> +
>   static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> @@ -217,6 +245,7 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>   static struct attribute *cxl_memdev_security_attributes[] = {
>   	&dev_attr_security_state.attr,
>   	&dev_attr_security_sanitize.attr,
> +	&dev_attr_security_erase.attr,
>   	NULL,
>   };
>   
> @@ -224,7 +253,8 @@ static umode_t cxl_security_visible(struct kobject *kobj,
>   				    struct attribute *a, int n)
>   {
>   	if (!cpu_cache_has_invalidate_memregion() &&
> -	    a == &dev_attr_security_sanitize.attr)
> +	    (a == &dev_attr_security_sanitize.attr ||
> +	     a == &dev_attr_security_erase.attr))
>   		return 0;
>   	return a->mode;
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0d2009b36933..2cf9ec3242a6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -332,6 +332,7 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>   	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>   	CXL_MBOX_OP_SANITIZE		= 0x4400,
> +	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>   	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>   	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>   	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> @@ -632,6 +633,7 @@ static inline void cxl_mem_active_dec(void)
>   #endif
>   
>   int cxl_mem_sanitize(struct cxl_dev_state *cxlds);
> +int cxl_mem_secure_erase(struct cxl_dev_state *cxlds);
>   
>   struct cxl_hdm {
>   	struct cxl_component_regs regs;
