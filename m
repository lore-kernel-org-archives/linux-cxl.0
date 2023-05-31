Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF0FC77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 16:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEaQle (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEaQlc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 12:41:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062098
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 09:41:30 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWZjN3MKmz67xpB;
        Thu,  1 Jun 2023 00:39:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 17:41:28 +0100
Date:   Wed, 31 May 2023 17:41:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/6] cxl/mem: Support Secure Erase
Message-ID: <20230531174127.000004a3@Huawei.com>
In-Reply-To: <20230526033344.17167-6-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
        <20230526033344.17167-6-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 25 May 2023 20:33:43 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement support for the non-pmem exclusive secure erase, per
> CXL specs. Create a write-only 'security/erase' sysfs file to
> perform the requested operation.
> 
> As with the sanitation this requires the device being offline
> and thus no active HPA-DPA decoding.
> 
> The expectation is that userspace can use it such as:
> 
> 	cxl disable-memdev memX
> 	echo 1 > /sys/bus/cxl/devices/memX/security/erase
> 	cxl enable-memdev memX
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 10 +++++++++
>  drivers/cxl/core/mbox.c                 |  6 +++++-
>  drivers/cxl/core/memdev.c               | 28 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  1 +
>  4 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 5753cba98692..f224c1215f22 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -85,6 +85,16 @@ Description:
>  		the device to be not be actively decoding any HPA ranges.
>  
>  
> +What            /sys/bus/cxl/devices/memX/security/erase
> +Date:           June, 2023
> +KernelVersion:  v6.5
> +Contact:        linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Write a boolean 'true' string value to this attribute to
> +		secure erase user data by changing the media encryption keys for
> +		all user data areas of the device.
> +
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 51c64829f20a..6622eac66bf1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1102,7 +1102,7 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
>  	};
>  	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
>  
> -	if (cmd != CXL_MBOX_OP_SANITIZE)
> +	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)

Maybe just use a switch + default for the inevitable growth of this list and
attempting to avoid churn?

>  		return -EINVAL;
>  
>  	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
> @@ -1120,6 +1120,10 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
>  	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
>  		return -EINVAL;
>  
> +	if (cmd == CXL_MBOX_OP_SECURE_ERASE &&
> +	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return -EINVAL;
> +
>  	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0) {
>  		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 90f23e53d483..d06c8539e82c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -163,6 +163,33 @@ static ssize_t security_sanitize_store(struct device *dev,
>  static struct device_attribute dev_attr_security_sanitize =
>  	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
>  
> +static ssize_t security_erase_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
> +	ssize_t rc;
> +	bool erase;
> +
> +	if (kstrtobool(buf, &erase) || !erase)
> +		return -EINVAL;
> +
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
> +	/* ensure no regions are mapped to this memdev */
> +	if (port->commit_end != -1)
> +		return -EBUSY;
> +
> +	rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
> +
> +	return rc ? rc : len;
> +}
> +static struct device_attribute dev_attr_security_erase =
> +	__ATTR(erase, 0200, NULL, security_erase_store);
> +
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -411,6 +438,7 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>  static struct attribute *cxl_memdev_security_attributes[] = {
>  	&dev_attr_security_state.attr,
>  	&dev_attr_security_sanitize.attr,
> +	&dev_attr_security_erase.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 408ec33c8480..758fea7b9dbf 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -392,6 +392,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>  	CXL_MBOX_OP_SANITIZE		= 0x4400,
> +	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,

