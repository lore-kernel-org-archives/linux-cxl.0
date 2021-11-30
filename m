Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11944C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Nov 2021 13:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhK3NXA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:23:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4182 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhK3NW7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 Nov 2021 08:22:59 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J3N7r5BHkz67Mdm;
        Tue, 30 Nov 2021 21:18:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 14:19:38 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 13:19:38 +0000
Date:   Tue, 30 Nov 2021 13:19:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 4/9] cxl/pci: Implement Interface Ready Timeout
Message-ID: <20211130131936.000039ab@Huawei.com>
In-Reply-To: <20211129214721.1668325-5-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
        <20211129214721.1668325-5-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 29 Nov 2021 13:47:16 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The original driver implementation used the doorbell timeout for the
> Mailbox Interface Ready bit to piggy back off of, since the latter
> doesn't have a defined timeout. This functionality, introduced in commit
> 8adaf747c9f0 ("cxl/mem: Find device capabilities"), can now be improved
> since a timeout has been defined with an ECN to the 2.0 spec.
> 
> While devices implemented prior to the ECN could have an arbitrarily
> long wait and still be within spec, the max ECN value (256s) is chosen
> as the default for all devices. All vendors in the consortium agreed to
> this amount and so it is reasonable to assume no devices made will
> exceed this amount.

Update the description to talk about the 60 seconds choice.

I'm fine with 60 seconds, but I can see it being controversial...

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> ---
> Changes since v1:
> - Use 60 seconds for timeout instead of 256 (Dan)
> ---
>  drivers/cxl/pci.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6c8d09fb3a17..b28c220d48ea 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  #include <linux/sizes.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -298,6 +299,38 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
>  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  {
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	unsigned long timeout;
> +	u64 md_status;
> +	int rc;
> +
> +	/*
> +	 * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> +	 * dictate how long to wait for the mailbox to become ready. The new
> +	 * field allows the device to tell software the amount of time to wait
> +	 * before mailbox ready. This field allows for up to 255 seconds. 255
> +	 * seconds is unreasonable long, and longer than other default timeouts
> +	 * in the OS. Use the more sane, 60 seconds instead.
> +	 *
> +	 * 100ms is chosen as the specified pause as it is the value used in the
> +	 * CXL Type 3 Memory Device Software Guide.
> +	 */
> +	timeout = jiffies + 60 * HZ;
> +
> +	rc = check_device_status(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	do {
> +		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +		if (md_status & CXLMDEV_MBOX_IF_READY)
> +			break;
> +		if (msleep_interruptible(100))
> +			break;
> +	} while (!time_after(jiffies, timeout));
> +
> +	/* It's assumed that once the interface is ready, it will remain ready. */
> +	if (!(md_status & CXLMDEV_MBOX_IF_READY))
> +		return -EIO;
>  
>  	cxlds->mbox_send = cxl_pci_mbox_send;
>  	cxlds->payload_size =

