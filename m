Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11008C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 15:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbjEKPKd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 11:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbjEKPKc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 11:10:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB71BEE
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 08:10:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHFgC2Sp1z6D8g1;
        Thu, 11 May 2023 23:09:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 16:10:28 +0100
Date:   Thu, 11 May 2023 16:10:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 6/7] cxl/mem: Support Secure Erase
Message-ID: <20230511161027.00005413@Huawei.com>
In-Reply-To: <20230421092321.12741-7-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-7-dave@stgolabs.net>
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

On Fri, 21 Apr 2023 02:23:20 -0700
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
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++
>  drivers/cxl/core/mbox.c                 |  6 ++++-
>  drivers/cxl/core/memdev.c               | 34 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  1 +
>  4 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 2e98ec9220ca..af7b603faf77 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -77,6 +77,16 @@ Description:
>  		completion.
>  
>  
> +What            /sys/bus/cxl/devices/memX/security/erase
> +Date:           May, 2023
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
> index 28daf7dcdec4..a2180f3e09eb 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1049,7 +1049,7 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
>  	};
>  	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
>  
> -	if (cmd != CXL_MBOX_OP_SANITIZE)
> +	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
>  		return -EINVAL;
>  
>  	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
> @@ -1067,6 +1067,10 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
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
> index 70e7158826c9..6406e8e47da2 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -138,6 +138,39 @@ static struct device_attribute dev_attr_security_sanitize =
>  	__ATTR(sanitize, 0644,
>  	       security_sanitize_show, security_sanitize_store);
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

As with earlier patch, I'd flip the logic.

> +		struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
> +
> +		if (!port || !is_cxl_endpoint(port))
> +			return -EINVAL;
> +		/* ensure no regions are mapped to this memdev */
> +		if (port->commit_end != -1)
> +			return -EBUSY;
> +
> +		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);

and use a simple error check here.

> +	}
> +
> +	if (rc == 0)
> +		rc = len;
> +	return rc;
> +}
> +
> +static struct device_attribute dev_attr_security_erase =
> +	__ATTR(erase, 0200, NULL, security_erase_store);
> +
>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -199,6 +232,7 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  
>  static struct attribute *cxl_memdev_security_attributes[] = {
>  	&dev_attr_security_sanitize.attr,
> +	&dev_attr_security_erase.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9bd33cfdc0ec..f8b513e70c21 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -345,6 +345,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>  	CXL_MBOX_OP_SANITIZE		= 0x4400,
> +	CXL_MBOX_OP_SECURE_ERASE		= 0x4401,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,

