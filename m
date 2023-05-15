Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BA7C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 10:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjEOKae (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEOKad (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 06:30:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC7CE6E
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 03:30:31 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKbF76KlSz6883d;
        Mon, 15 May 2023 18:28:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 11:30:29 +0100
Date:   Mon, 15 May 2023 11:30:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <20230515113027.00001825@Huawei.com>
In-Reply-To: <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
References: <20230502171841.21317-1-dave@stgolabs.net>
        <20230502171841.21317-4-dave@stgolabs.net>
        <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 3 May 2023 07:57:56 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> This adds support for handling background operations, as defined in
> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> can run in the background asynchronously (to the hardware).
> 
> The driver will deal with such commands synchronously, blocking all
> other incoming commands for a specified period of time, allowing
> time-slicing the command such that the caller can send incremental
> requests to avoid monopolizing the driver/device. This approach
> makes the code simpler, where any out of sync (timeout) between the
> driver and hardware is just disregarded as an invalid state until
> the next successful submission.
> 
> On devices where mbox interrupts are supported, this will still use
> a poller that will wakeup in the specified wait intervals. The irq
> handler will simply awake the blocked cmd, which is also safe vs a
> task that is either waking (timing out) or already awoken. Similarly
> any irq setup error during the probing falls back to polling, thus
> avoids unnecessarily erroring out.

This raises the question of why we don't support Doorbell Interrupts.
2 seconds is rather a long time to poll for.  I can't really remember the
reasoning but maybe it's that we don't expect anyone to every produce
hardware that takes that long. 

Ah well, job for another day perhaps.

I'm not following why the rcuwait is needed versus other options.
Perhaps some minimal text here for those of us not familiar with that
particular mechanism vs a completion of similar.

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Otherwise just a comment inline on dev_warn for unexpected interrupt
on an interrupt that you've marked as IRQF_SHARED which pretty much
guarantees you need to handle unexpected interrupts as 'normal'.

Jonathan

> ---
> 
> Changes from v2:
> - make the wait ret a long.
> - pass correct param orders to the wait (cond and state were inversed).
> 
>   drivers/cxl/core/mbox.c |   3 +-
>   drivers/cxl/cxl.h       |   7 +++
>   drivers/cxl/cxlmem.h    |   7 +++
>   drivers/cxl/pci.c       | 102 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 118 insertions(+), 1 deletion(-)


> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index db12b6313afb..d2f751d6583c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -5,6 +5,7 @@
>   #include <uapi/linux/cxl_mem.h>
>   #include <linux/cdev.h>
>   #include <linux/uuid.h>
> +#include <linux/rcuwait.h>
>   #include "cxl.h"
> 
>   /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -108,6 +109,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>    *            variable sized output commands, it tells the exact number of bytes
>    *            written.
>    * @min_out: (input) internal command output payload size validation
> + * @poll_count: (input)  Number of timeouts to attempt.
> + * @poll_interval: (input) Number of ms between mailbox background command
> + *                 polling intervals timeouts.
>    * @return_code: (output) Error code returned from hardware.
>    *
>    * This is the primary mechanism used to send commands to the hardware.
> @@ -123,6 +127,8 @@ struct cxl_mbox_cmd {
> 	size_t size_in;
> 	size_t size_out;
> 	size_t min_out;
> +	int poll_count;
> +	int poll_interval;
> 	u16 return_code;
>   };
> 
> @@ -329,6 +335,7 @@ struct cxl_dev_state {
> 	struct cxl_event_state event;
> 	struct cxl_poison_state poison;
> 
> +	struct rcuwait mbox_wait;
> 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>   };
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8bdf58c0c643..10dc4a4fbb4a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -51,6 +51,7 @@ static unsigned short mbox_ready_timeout = 60;
>   module_param(mbox_ready_timeout, ushort, 0644);
>   MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
> 
> +

:)  You know what I'm going to say - so I won't bother saying it.


>   static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>   {
> 	const unsigned long start = jiffies;
> @@ -84,6 +85,33 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
> 			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
> 			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
> 
> +static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> +{
> +	u64 reg;
> +
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
> +}
> +
> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	/* spurious or raced with hw? */
> +	if (unlikely(!cxl_mbox_background_complete(cxlds))) {
> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +		dev_warn(&pdev->dev,
> +			 "Mailbox background operation IRQ but incomplete\n");

It's a shared IRQ, there are many possible reasons we might get here that
aren't things we should warn about.  Would be nice if we could detect
the race might have happened and only return IRQ_HANDLED if that's the case
as opposed to it's someone else's interrupt.

> +		goto done;
> +	}
> +
> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +	rcuwait_wake_up(&cxlds->mbox_wait);
> +done:
> +	return IRQ_HANDLED;
> +}


