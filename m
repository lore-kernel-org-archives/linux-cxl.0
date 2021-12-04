Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507E9C433EF
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Dec 2021 01:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383982AbhLDBk0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 20:40:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:51768 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383963AbhLDBk0 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Dec 2021 20:40:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="235819331"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="235819331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:37:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="501393973"
Received: from pnaidu-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.128.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 17:37:00 -0800
Date:   Fri, 3 Dec 2021 17:36:59 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH 1/2] cxl/pci: Implement Interface Ready Timeout
Message-ID: <20211204013659.helfmgrwu2e44e7n@intel.com>
References: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163855974164.1338601.11643774914793606293.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163855974164.1338601.11643774914793606293.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-12-03 11:29:01, Dan Williams wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> The original driver implementation used the doorbell timeout for the
> Mailbox Interface Ready bit to piggy back off of, since the latter does
> not have a defined timeout. This functionality, introduced in commit
> 8adaf747c9f0 ("cxl/mem: Find device capabilities"), needs improvement as
> the recent "Add Mailbox Ready Time" ECN timeout indicates that the
> mailbox ready time can be significantly longer that 2 seconds.
> 
> While the specification limits the maximum timeout to 256s, the cxl_pci
> driver gives up on the mailbox after 60s. This value corresponds with
> important timeout values already present in the kernel. A module
> parameter is provided as an emergency override.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: add modparam, drop check_device_status()]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c |   34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8dc91fd3396a..519795432708 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/moduleparam.h>
>  #include <linux/module.h>
> +#include <linux/delay.h>
>  #include <linux/sizes.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -35,6 +37,19 @@
>  /* CXL 2.0 - 8.2.8.4 */
>  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>  
> +/*
> + * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> + * dictate how long to wait for the mailbox to become ready. The new
> + * field allows the device to tell software the amount of time to wait
> + * before mailbox ready. This field allows for up to 255 seconds. 255
> + * seconds is unreasonable long, and longer than other default timeouts

s/unreasonable/unreasonably

> + * in the OS. Use the more sane, 60 seconds instead.
> + */
> +static unsigned short mbox_ready_timeout = 60;
> +module_param(mbox_ready_timeout, ushort, 0600);
> +MODULE_PARM_DESC(mbox_ready_timeout,
> +		 "seconds to wait for mailbox ready status");
> +

It's a bit of a weird thing to set as a modparam since it's not module specific,
but device specific. However, I suppose it's better than hardcoded 60s and I
can't come up with a better alternative. Perhaps mention this in the commit
message?

>  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  {
>  	const unsigned long start = jiffies;
> @@ -281,6 +296,25 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
>  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  {
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	unsigned long timeout;
> +	u64 md_status;
> +
> +	timeout = jiffies + mbox_ready_timeout * HZ;
> +	do {
> +		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +		if (md_status & CXLMDEV_MBOX_IF_READY)
> +			break;
> +		if (msleep_interruptible(100))
> +			break;
> +	} while (!time_after(jiffies, timeout));

One thing I noticed after I wrote these using time_after... time_before_eq()
might be a better fit. I'm slightly annoyed both APIs exist, but...

> +
> +	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
> +		dev_err(cxlds->dev,
> +			"timeout awaiting mailbox ready, device state:%s%s\n",
> +			md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
> +			md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
> +		return -EIO;
> +        }
>  
>  	cxlds->mbox_send = cxl_pci_mbox_send;
>  	cxlds->payload_size =
> 

All in all, LGTM
