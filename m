Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19242C001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 14:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjHDOQT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjHDOQR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 10:16:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C1C1990
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 07:16:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHSMz5GVSz67Q0T;
        Fri,  4 Aug 2023 22:12:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 15:16:13 +0100
Date:   Fri, 4 Aug 2023 15:16:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <fan.ni@samsung.com>, <dave.jiang@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/memdev: Only show sanitize sysfs files when
 supported
Message-ID: <20230804151612.000066cf@Huawei.com>
In-Reply-To: <20230726051940.3570-4-dave@stgolabs.net>
References: <20230726051940.3570-1-dave@stgolabs.net>
        <20230726051940.3570-4-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jul 2023 22:19:40 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> If the device does not support Sanitize or Secure Erase commands,
> hide the respective sysfs interfaces such that the operation can
> never be attempted.
> 
> In order to be generic, keep track of the enabled security commands
> found in the CEL - the driver does not support Security Passthrough.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Ah just realized I was too late on this one as it's upstream. Ah well I'll
comment anyway (I'd already reviewed most of it :)

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  6 ++--
>  drivers/cxl/core/mbox.c                 | 45 ++++++++++++++++++++++++-
>  drivers/cxl/core/memdev.c               | 19 +++++++++++
>  drivers/cxl/cxlmem.h                    | 15 +++++++++
>  4 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c4c4acb1f3b3..087f762ebfd5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -86,7 +86,8 @@ Description:
>  		HPA ranges. This permits avoiding explicit global CPU cache
>  		management, relying instead for it to be done when a region
>  		transitions between software programmed and hardware committed
> -		states.
> +		states. If this file is not present, then there is no hardware
> +		support for the operation.

Or older kernel.... 

I don't think we need to talk about when they aren't present as it just complicates
the ABI docs.  The similar case for the DOE is there to explain the weird corner
of it's there, but broken.
An example were it's not documented (I think) is the poison commands so I think
we should keep that absence as meaning the obvious (you can't use the interface).

>  
>  
>  What            /sys/bus/cxl/devices/memX/security/erase
> @@ -101,7 +102,8 @@ Description:
>  		HPA ranges. This permits avoiding explicit global CPU cache
>  		management, relying instead for it to be done when a region
>  		transitions between software programmed and hardware committed
> -		states.
> +		states. If this file is not present, then there is no hardware
> +		support for the operation.
>  
>  
>  What:		/sys/bus/cxl/devices/memX/firmware/
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..ca60bb8114f2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -121,6 +121,45 @@ static bool cxl_is_security_command(u16 opcode)
>  	return false;
>  }
>  
> +static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
> +					 u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_SANITIZE:
> +		set_bit(CXL_SEC_ENABLED_SANITIZE, security->enabled_cmds);
> +		break;

I'm a fan of returning when nothing else to do.
(this is when I realized this was definitely upstream as I called this function
 in the switch cci code!)

> +	case CXL_MBOX_OP_SECURE_ERASE:
> +		set_bit(CXL_SEC_ENABLED_SECURE_ERASE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_SECURITY_STATE:
> +		set_bit(CXL_SEC_ENABLED_GET_SECURITY_STATE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_SET_PASSPHRASE:
> +		set_bit(CXL_SEC_ENABLED_SET_PASSPHRASE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
> +		set_bit(CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_UNLOCK:
> +		set_bit(CXL_SEC_ENABLED_UNLOCK, security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_FREEZE_SECURITY:
> +		set_bit(CXL_SEC_ENABLED_FREEZE_SECURITY,
> +			security->enabled_cmds);
> +		break;
> +	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
> +		set_bit(CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
> +			security->enabled_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static bool cxl_is_poison_command(u16 opcode)
>  {
>  #define CXL_MBOX_OP_POISON_CMDS 0x43
> @@ -677,7 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd && !cxl_is_poison_command(opcode)) {
> +		if (!cmd && (!cxl_is_poison_command(opcode) ||
> +			     !cxl_is_security_command(opcode))) {
>  			dev_dbg(dev,
>  				"Opcode 0x%04x unsupported by driver\n", opcode);
>  			continue;
> @@ -689,6 +729,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		if (cxl_is_poison_command(opcode))
>  			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
>  
> +		if (cxl_is_security_command(opcode))
> +			cxl_set_security_cmd_enabled(&mds->security, opcode);
> +
>  		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f99e7ec3cc40..14b547c07f54 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -477,9 +477,28 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>  	.attrs = cxl_memdev_pmem_attributes,
>  };
>  
> +static umode_t cxl_memdev_security_visible(struct kobject *kobj,
> +					   struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_security_sanitize.attr &&
> +	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> +		return 0;
> +
> +	if (a == &dev_attr_security_erase.attr &&
> +	    !test_bit(CXL_SEC_ENABLED_SECURE_ERASE, mds->security.enabled_cmds))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
>  static struct attribute_group cxl_memdev_security_attribute_group = {
>  	.name = "security",
>  	.attrs = cxl_memdev_security_attributes,
> +	.is_visible = cxl_memdev_security_visible,
>  };
>  
>  static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 083c6e58bc49..f86afef90c91 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -244,6 +244,19 @@ enum poison_cmd_enabled_bits {
>  	CXL_POISON_ENABLED_MAX
>  };
>  
> +/* Device enabled security commands */
> +enum security_cmd_enabled_bits {
> +	CXL_SEC_ENABLED_SANITIZE,
> +	CXL_SEC_ENABLED_SECURE_ERASE,
> +	CXL_SEC_ENABLED_GET_SECURITY_STATE,
> +	CXL_SEC_ENABLED_SET_PASSPHRASE,
> +	CXL_SEC_ENABLED_DISABLE_PASSPHRASE,
> +	CXL_SEC_ENABLED_UNLOCK,
> +	CXL_SEC_ENABLED_FREEZE_SECURITY,
> +	CXL_SEC_ENABLED_PASSPHRASE_SECURE_ERASE,
> +	CXL_SEC_ENABLED_MAX
> +};
> +
>  /**
>   * struct cxl_poison_state - Driver poison state info
>   *
> @@ -346,6 +359,7 @@ struct cxl_fw_state {
>   * struct cxl_security_state - Device security state
>   *
>   * @state: state of last security operation
> + * @enabled_cmds: All security commands enabled in the CEL
>   * @poll: polling for sanitization is enabled, device has no mbox irq support
>   * @poll_tmo_secs: polling timeout
>   * @poll_dwork: polling work item
> @@ -353,6 +367,7 @@ struct cxl_fw_state {
>   */
>  struct cxl_security_state {
>  	unsigned long state;
> +	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
>  	bool poll;
>  	int poll_tmo_secs;
>  	struct delayed_work poll_dwork;

