Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4646AC6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjC3SRK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjC3SRI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:17:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF64E068
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:16:58 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnWns5mHrz6J7dm;
        Fri, 31 Mar 2023 02:16:17 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 19:16:56 +0100
Date:   Thu, 30 Mar 2023 19:16:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] cxl/memdev: Add support for the Clear Poison
 mailbox command
Message-ID: <20230330191655.0000147b@Huawei.com>
In-Reply-To: <ca3a435e06eab299e111bcc3477e4325b2802797.1677704994.git.alison.schofield@intel.com>
References: <cover.1677704994.git.alison.schofield@intel.com>
        <ca3a435e06eab299e111bcc3477e4325b2802797.1677704994.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed,  1 Mar 2023 13:36:27 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the CLEAR POISON mailbox command. Add
> a sysfs attribute and memdev driver support for clearing poison. The
> attribute is only visible for devices supporting the capability when
> the kernel is built with CONFIG_CXL_POISON_INJECT.
> 
> When a Device Physical Address (DPA) is written to the clear_poison
> sysfs attribute, send a clear poison command to the device for the
> specified address.
> 
> Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid
> clear poison request, the device removes the address from the device's
> Poison List and writes 0 (zero) for 64 bytes starting at address. If
> the device cannot clear poison from the address, it returns a permanent
> media error and -ENXIO is returned to the user.
> 
> Additionally, and per the spec also, it is not an error to clear poison
> of an address that is not poisoned. In this case, the device does not
> overwrite the address and the device does not return an error.

That's not inline with the spec.

"Clear Poison Write Data: The data the device shall always write into the
requested physical address, atomically, while clearing poison if the location
is marked as being poisoned."

The overwrite always happens whether or not it's poisoned.

> 
> *Implementation note: Although the CXL specification defines the clear
> command to accept 64 bytes of 'write-data' to be used when clearing
> the poisoned address, this implementation always uses 0 (zeros) for
> the write-data.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++
>  drivers/cxl/core/memdev.c               | 59 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  6 +++
>  3 files changed, 83 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index e19d1020f30a..e2c77eda443e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -451,3 +451,21 @@ Description:
>  		inject_poison attribute is only visible for devices supporting
>  		the capability. Kconfig option CXL_POISON_INJECT must be on
>  		to enable this option. The default is off.
> +
> +
> +What:		/sys/bus/cxl/devices/memX/clear_poison
> +Date:		January, 2023
> +KernelVersion:	v6.3
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(WO) When a Device Physical Address (DPA) is written to this
> +		attribute, the memdev driver sends a clear poison command to
> +		the device for the specified address. Clearing poison removes
> +		the address from the device's Poison List and writes 0 (zero)
> +		for 64 bytes starting at address. It is not an error to clear
> +		poison from an address that does not have poison set, and if
> +		poison was not set, the address is not overwritten. If the

As above.

> +		device cannot clear poison from the address, -ENXIO is returned.
> +		The clear_poison attribute is only visible for devices
> +		supporting the capability. Kconfig option CXL_POISON_INJECT
> +		must be on to enable this option. The default is off.
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 82e09b81e9c6..ed3e4517dc3a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -251,6 +251,53 @@ static ssize_t inject_poison_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(inject_poison);
>  
> +static ssize_t clear_poison_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mbox_clear_poison clear;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u64 dpa;
> +	int rc;
> +
> +	rc = kstrtou64(buf, 0, &dpa);
> +	if (rc)
> +		return rc;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	rc = cxl_validate_poison_dpa(cxlmd, dpa);
> +	if (rc) {
> +		up_read(&cxl_dpa_rwsem);
> +		return rc;
> +	}
> +
> +	/*
> +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> +	 * is defined to accept 64 bytes of 'write-data', along with the
> +	 * address to clear. The device writes the data into the address
> +	 * atomically, while clearing poison if the location is marked as
> +	 * being poisoned.

This statement is correct in that it says the data is always written
whether or not there is poison at the address.

> +	 *
> +	 * Always use '0' for the write-data.
> +	 */
> +	clear = (struct cxl_mbox_clear_poison) {
> +		.address = cpu_to_le64(dpa)
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_CLEAR_POISON,
> +		.size_in = sizeof(clear),
> +		.payload_in = &clear,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> +
> +	up_read(&cxl_dpa_rwsem);
> +	return rc ? rc : len;
> +}
> +static DEVICE_ATTR_WO(clear_poison);
> +
>  static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_serial.attr,
>  	&dev_attr_firmware_version.attr,
> @@ -259,6 +306,7 @@ static struct attribute *cxl_memdev_attributes[] = {
>  	&dev_attr_numa_node.attr,
>  	&dev_attr_trigger_poison_list.attr,
>  	&dev_attr_inject_poison.attr,
> +	&dev_attr_clear_poison.attr,
>  	NULL,
>  };
>  
> @@ -295,6 +343,17 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
>  			return 0;
>  	}
> +	if (a == &dev_attr_clear_poison.attr) {
> +		struct device *dev = kobj_to_dev(kobj);
> +
> +		if (!IS_ENABLED(CONFIG_CXL_POISON_INJECT))
> +			return 0;
> +
> +		if (!test_bit(CXL_MEM_COMMAND_ID_CLEAR_POISON,
> +			      to_cxl_memdev(dev)->cxlds->enabled_cmds)) {
> +			return 0;
> +		}
> +	}
>  	return a->mode;
>  }
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 01d27f362cd6..8a15274789a6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -607,6 +607,12 @@ struct cxl_mbox_inject_poison {
>  	__le64 address;
>  };
>  
> +/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
> +struct cxl_mbox_clear_poison {
> +	__le64 address;
> +	u8 write_data[CXL_POISON_LEN_MULT];
> +} __packed;
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI

