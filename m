Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F918C7EE2D
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 16:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjEaQKi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 12:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEaQKh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 12:10:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBBB3
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 09:10:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWYyQ6Lcwz6J7Jr;
        Thu,  1 Jun 2023 00:05:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 17:10:32 +0100
Date:   Wed, 31 May 2023 17:10:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/6] cxl/mem: Introduce security state sysfs file
Message-ID: <20230531171032.0000120f@Huawei.com>
In-Reply-To: <20230526033344.17167-2-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
        <20230526033344.17167-2-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 25 May 2023 20:33:39 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add a read-only sysfs file to display the security state
> of a device (currently only pmem):
> 
>     /sys/bus/cxl/devices/memX/security/state
> 
> This introduces a cxl_security_state structure that is
> to be the placeholder for common CXL security features.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Nothing to add to Dave's review. Given comment is minor, either
way...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++
>  drivers/cxl/core/memdev.c               | 46 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    | 11 ++++++
>  drivers/cxl/security.c                  |  3 ++
>  4 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 48ac0d911801..721a44d8a482 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,16 @@ Description:
>  		affinity for this device.
>  
>  
> +What:		/sys/bus/cxl/devices/memX/security/state
> +Date:		June, 2023
> +KernelVersion:	v6.5
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Reading this file will display the CXL security state for
> +		that device. Such states can be: 'disabled', or those available
> +		only for persistent memory: 'locked', 'unlocked' or 'frozen'.
> +
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..6e1d7d3610a2 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -107,6 +107,28 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t security_state_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	unsigned long state = cxlds->security.state;
> +
> +	if (!(state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
> +		return sysfs_emit(buf, "disabled\n");
> +	if (state & CXL_PMEM_SEC_STATE_FROZEN ||
> +	    state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT ||
> +	    state & CXL_PMEM_SEC_STATE_USER_PLIMIT)
> +		return sysfs_emit(buf, "frozen\n");
> +	if (state & CXL_PMEM_SEC_STATE_LOCKED)
> +		return sysfs_emit(buf, "locked\n");
> +	else
> +		return sysfs_emit(buf, "unlocked\n");
> +}
> +static struct device_attribute dev_attr_security_state =
> +	__ATTR(state, 0444, security_state_show, NULL);
> +
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -352,6 +374,11 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>  	NULL,
>  };
>  
> +static struct attribute *cxl_memdev_security_attributes[] = {
> +	&dev_attr_security_state.attr,
> +	NULL,
> +};
> +
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  				  int n)
>  {
> @@ -375,10 +402,16 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  	.attrs = cxl_memdev_pmem_attributes,
>  };
>  
> +static struct attribute_group cxl_memdev_security_attribute_group = {
> +	.name = "security",
> +	.attrs = cxl_memdev_security_attributes,
> +};
> +
>  static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>  	&cxl_memdev_attribute_group,
>  	&cxl_memdev_ram_attribute_group,
>  	&cxl_memdev_pmem_attribute_group,
> +	&cxl_memdev_security_attribute_group,
>  	NULL,
>  };
>  
> @@ -551,6 +584,15 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> +static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	cxlds->security.state = 0;
> +
> +	return 0;
> +}
> +
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
> @@ -579,6 +621,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> +	rc = cxl_memdev_security_init(cxlmd);
> +	if (rc)
> +		goto err;
> +
>  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1d8e81c87c6a..5329274b0076 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -260,6 +260,15 @@ struct cxl_poison_state {
>  	struct mutex lock;  /* Protect reads of poison list */
>  };
>  
> +/**
> + * struct cxl_security_state - Device security state
> + *
> + * @state: state of last security operation
> + */
> +struct cxl_security_state {
> +	unsigned long state;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -297,6 +306,7 @@ struct cxl_poison_state {
>   * @serial: PCIe Device Serial Number
>   * @event: event log driver state
>   * @poison: poison driver state info
> + * @security: device security state
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -336,6 +346,7 @@ struct cxl_dev_state {
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> +	struct cxl_security_state security;
>  
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 4ad4bda2d18e..9da6785dfd31 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -34,6 +34,9 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>  		return 0;
>  
>  	sec_out = le32_to_cpu(out.flags);
> +	/* cache security state */
> +	cxlds->security.state = sec_out;
> +
>  	if (ptype == NVDIMM_MASTER) {
>  		if (sec_out & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)
>  			set_bit(NVDIMM_SECURITY_UNLOCKED, &security_flags);

