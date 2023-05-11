Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6173C77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 15:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjEKPH7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjEKPH6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 11:07:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E319B7
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 08:07:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHFc0134jz6D8qm;
        Thu, 11 May 2023 23:06:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 16:07:41 +0100
Date:   Thu, 11 May 2023 16:07:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Message-ID: <20230511160741.00004531@Huawei.com>
In-Reply-To: <20230421092321.12741-5-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-5-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 Apr 2023 02:23:18 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement support for CXL 3.0 8.2.9.8.5.1 Sanitize. This is done by
> adding a security/sanitize' memdev sysfs file, which is poll(2)-capable
> for completion. Unlike all other background commands, this is the
> only operation that is special and monopolizes the device for long
> periods of time.
> 
> In addition to the traditional pmem security requirements, all regions
> must also be offline in order to perform the operation.
> This permits
> avoiding explicit global CPU cache management, relying instead on
> attach_target() setting CXL_REGION_F_INCOHERENT upon reconnect.
> 
> The expectation is that userspace can use it such as:
> 
>     cxl disable-memdev memX
>     echo 1 > /sys/bus/cxl/devices/memX/security/sanitize
>     cxl wait-sanitize memX
>     cxl enable-memdev memX
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 19 ++++++
>  drivers/cxl/core/mbox.c                 | 56 ++++++++++++++++
>  drivers/cxl/core/memdev.c               | 86 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  4 ++
>  drivers/cxl/pci.c                       |  5 ++
>  5 files changed, 170 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3acf2f17a73f..2e98ec9220ca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -58,6 +58,25 @@ Description:
>  		affinity for this device.
>  
>  
> +What:           /sys/bus/cxl/devices/memX/security/sanitize
> +Date:           May, 2023
> +KernelVersion:  v6.5
> +Contact:        linux-cxl@vger.kernel.org
> +Description:
> +		(RW) Write a boolean 'true' string value to this attribute to
> +		sanitize the device to securely re-purpose or decommission it.
> +		This is done by ensuring that all user data and meta-data,
> +		whether it resides in persistent capacity, volatile capacity,
> +		or the LSA, is made permanently unavailable by whatever means
> +		is appropriate for the media type. This functionality requires
> +		the device to be not be actively decoding any HPA ranges.
> +
> +		Reading this file shows either "disabled" when not running, or
> +		"sanitize" during the duration of the sanitize operation. This
> +		sysfs entry is select/poll capable from userspace to notify upon
> +		completion.

A sysfs attribute that reads different from what is written is not very intuitive.
The one file one thing rule suggests to me that you should have a separate
santize_status or similar.  Or just have this read true when in progress making
it a self resetting toggle that returns -EBUSY if anyone tries to unset it.

> +
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index cde7270c6037..28daf7dcdec4 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1021,6 +1021,62 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
> +/**
> + * cxl_mem_sanitize() - Send a sanitation command to the device.
> + * @cxlds: The device data for the operation
> + * @cmd: The specific sanitation command opcode
> + *
> + * Return: 0 if the command was executed successfully, regardless of
> + * whether or not the actual security operation is done in the background,
> + * such as for the Sanitize case.
> + * Error return values can be the result of the mailbox command, -EINVAL
> + * when security requirements are not met or invalid contexts, or -EBUSY
> + * if the device is not offline.

What does offline mean for the device?  Perhaps a tighter definition needed.

> + *
> + * See CXL 3.0 @8.2.9.8.5.1 Sanitize and @8.2.9.8.5.2 Secure Erase.

This @ syntax would  be fine but it's inconsistent with other references in
this file.

> + */
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
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
> +	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
> +
> +	if (cmd != CXL_MBOX_OP_SANITIZE)
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
> +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 28a05f2fe32d..70e7158826c9 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -89,6 +89,55 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  static struct device_attribute dev_attr_pmem_size =
>  	__ATTR(size, 0444, pmem_size_show, NULL);
>  
> +static ssize_t security_sanitize_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
> +	u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> +
> +	if (cmd == CXL_MBOX_OP_SANITIZE && pct != 100)
> +		return sysfs_emit(buf, "sanitize\n");
> +	else
> +		return sysfs_emit(buf, "disabled\n");

As above. I don't like inconsistency of read and write values.

> +}
> +
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

I'd short cut the false case

	if (!sanitize)
		return len;

	...

> +		struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
> +
> +		if (!port || !is_cxl_endpoint(port))
> +			return -EINVAL;
> +		/* ensure no regions are mapped to this memdev */
> +		if (port->commit_end != -1)
> +			return -EBUSY;
> +
> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
		if (rc)
			return rc;
	}

	return len;

Simple flow is easier for reviewers to follow.

> +	}
> +
> +	if (rc == 0)
> +		rc = len;
> +	return rc;
> +}
> +
 
> @@ -324,11 +384,19 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> +static void put_sanitize(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +
> +	sysfs_put(cxlds->sec.sanitize_state);
> +}
> +
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
>  	struct cdev *cdev;
> +	struct kernfs_node *sec;
>  	int rc;
>  
>  	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
> @@ -355,6 +423,24 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
> +
> +	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> +	if (!sec) {
> +		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
> +		rc = -ENODEV;
> +		goto err;

At this stage the devm action is registered to unwind anything above here, so just
		return ERR_PTR(-ENODEV);

> +	}
> +	cxlds->sec.sanitize_state = sysfs_get_dirent(sec, "sanitize");
> +	sysfs_put(sec);
> +	if (!cxlds->sec.sanitize_state) {
> +		dev_err(dev, "sysfs_get_dirent 'sanitize' failed\n");
> +		rc = -ENODEV;
> +		goto err;

return ERR_PTR(-ENODDEV);

> +	}
> +	rc = devm_add_action_or_reset(cxlds->dev, put_sanitize, cxlds);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
>  	return cxlmd;
>  
>  err:
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 17e3ab3c641a..9bd33cfdc0ec 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -223,10 +223,12 @@ struct cxl_event_state {
>  /**
>   * struct cxl_security_state - Device security state
>   *
> + * @sanitize_state: sanitation sysfs file to notify
>   * @sanitize_dwork: self-polling work item for sanitation
>   * @sanitize_tmo: self-polling timeout
>   */
>  struct cxl_security_state {
> +	struct kernfs_node *sanitize_state;
>  	/* below only used if device mbox irqs are not supported */
>  	struct delayed_work sanitize_dwork;
>  	int sanitize_tmo;
> @@ -642,6 +644,8 @@ static inline void cxl_mem_active_dec(void)
>  }
>  #endif
>  
> +int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd);
> +
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bdee5273af5a..2bc3b595f270 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -113,6 +113,9 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>  
>  	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		if (cxlds->sec.sanitize_state)
> +			sysfs_notify_dirent(cxlds->sec.sanitize_state);
> +
>  		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> @@ -138,6 +141,8 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	if (cxl_mbox_background_complete(cxlds)) {
>  		cxlds->sec.sanitize_tmo = 0;
>  		put_device(cxlds->dev);
> +		if (cxlds->sec.sanitize_state)
> +			sysfs_notify_dirent(cxlds->sec.sanitize_state);
>  
>  		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
>  	} else {

