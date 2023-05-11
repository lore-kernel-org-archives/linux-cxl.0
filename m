Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F841C77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 15:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbjEKPCt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbjEKPCr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 11:02:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED99E9
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 08:02:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHF5M163Mz6DB2Z;
        Thu, 11 May 2023 22:43:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 15:45:31 +0100
Date:   Thu, 11 May 2023 15:45:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <20230511154530.00000801@Huawei.com>
In-Reply-To: <20230421092321.12741-4-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-4-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 Apr 2023 02:23:17 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Sanitation is by definition a device-monopolizing operation, and thus
> the timeslicing rules for other background commands do not apply.
> As such handle this special case asynchronously and return immediately.
> Subsequent changes will allow completion to be pollable from userspace
> via a sysfs file interface.
> 
> For devices that don't support interrupts for notifying background
> command completion, self-poll with the caveat that the poller can
> be out of sync with the ready hardware, and therefore care must be
> taken to not allow any new commands to go through until the poller
> sees the hw completion. The poller takes the mbox_mutex to stabilize
> the flagging, minimizing any runtime overhead in the send path to
> check for 'sanitize_tmo' for uncommon poll scenarios. This flag
> also serves for sanitation (the only user of async polling) to know
> when to queue work or simply rely on irqs.
> 
> The irq case is much simpler as hardware will serialize/error
> appropriately.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/cxlmem.h | 16 +++++++++
>  drivers/cxl/pci.c    | 79 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8c3302fc7738..17e3ab3c641a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -220,6 +220,18 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/**
> + * struct cxl_security_state - Device security state
> + *
> + * @sanitize_dwork: self-polling work item for sanitation
> + * @sanitize_tmo: self-polling timeout
> + */
> +struct cxl_security_state {
> +	/* below only used if device mbox irqs are not supported */
Call it out by name.  We are almost sure to make a 'below' bit rot
at somepoint :)

> +	struct delayed_work sanitize_dwork;
> +	int sanitize_tmo;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -256,6 +268,7 @@ struct cxl_event_state {
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
>   * @event: event log driver state
> + * @sec: device security state
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -296,6 +309,8 @@ struct cxl_dev_state {
>  
>  	struct cxl_event_state event;
>  
> +	struct cxl_security_state sec;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };

...

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index aa1bb74a52a1..bdee5273af5a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -97,6 +97,8 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  {
>  	struct cxl_dev_state *cxlds = id;
> +	u64 reg;
> +	u16 opcode;
>  
>  	/* spurious or raced with hw? */
>  	if (!cxl_mbox_background_complete(cxlds)) {
> @@ -107,12 +109,47 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  		goto done;
>  	}
>  
> -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	wake_up(&mbox_wait);
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> +
> +	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +		wake_up(&mbox_wait);
> +	}
>  done:
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * Sanitation operation polling mode.
> + */
> +static void cxl_mbox_sanitize_work(struct work_struct *work)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = container_of(work, struct cxl_dev_state,
> +			     sec.sanitize_dwork.work);
> +
> +	WARN_ON(cxlds->sec.sanitize_tmo == -1);

Overly paranoid?

> +
> +	mutex_lock(&cxlds->mbox_mutex);
> +	if (cxl_mbox_background_complete(cxlds)) {
> +		cxlds->sec.sanitize_tmo = 0;
> +		put_device(cxlds->dev);
> +
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		int tmo = cxlds->sec.sanitize_tmo + 10;

Add some units to the naming of variables.

> +
> +		cxlds->sec.sanitize_tmo = min(15 * 60, tmo);

Why? That feels like it needs a comment to me.  Not that expensive
to check this so I'm not sure the ramp up is that logical.

> +		queue_delayed_work(system_wq,
> +				   &cxlds->sec.sanitize_dwork, tmo * HZ);
> +	}
> +	mutex_unlock(&cxlds->mbox_mutex);
> +}
> +
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @cxlds: The device state to communicate with.
> @@ -173,6 +210,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * With sanitize polling, hardware might be done and the poller still
> +	 * not be in sync. Ensure no new command comes in until so. Keep the
> +	 * hardware semantics and only allow device health status.
> +	 */
> +	if (unlikely(cxlds->sec.sanitize_tmo > 0)) {
> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)

Doesn't this let the value of mbox_cmd->opcode change to HEALTH_INFO so that
when we get here again we could carry on without other commands though still not in
sync (if things are very weird).

> +			return -EBUSY;
> +	}
> +
>  	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>  			     mbox_cmd->opcode);
>  	if (mbox_cmd->size_in) {
> @@ -223,6 +270,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  		u64 bg_status_reg;
>  		int i;
>  
> +		/*
> +		 * Sanitation is a special case which monopolizes the device
> +		 * in an uninterruptible state and thus cannot be timesliced.
> +		 * Return immediately instead and allow userspace to poll(2)
> +		 * for completion.
> +		 */
> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> +			if (cxlds->sec.sanitize_tmo != -1) {

As below. Have a self explanatory variable called sec.polling or sec.interrupt

> +				/* give first timeout a second */
> +				cxlds->sec.sanitize_tmo = 1;

If this was named santize_tmo_secs then comment not needed.

> +				/* hold the device throughout */
> +				get_device(cxlds->dev);
> +				queue_delayed_work(system_wq,
> +						   &cxlds->sec.sanitize_dwork,
> +						   cxlds->sec.sanitize_tmo * HZ);
> +			}
> +
> +			dev_dbg(dev, "Sanitation operation started\n");
> +			return 0;
> +		}
> +
>  		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>  			mbox_cmd->opcode);
>  
> @@ -366,6 +434,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  		if (rc)
>  			goto mbox_poll;
>  
> +		/* flag that irqs are enabled */
> +		cxlds->sec.sanitize_tmo = -1;

That's confusing.  I'd add a separate structure element for it instead with
appropriate naming.

> +
>  		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
>  		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>  
> @@ -373,7 +444,11 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	}
>  
>  mbox_poll:
> +	INIT_DELAYED_WORK(&cxlds->sec.sanitize_dwork,
> +			  cxl_mbox_sanitize_work);
> +	cxlds->sec.sanitize_tmo = 0;
>  	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
> +
My favorite moan. Unrelated whitespace change! Push it to patch 2 that introduced
that dev_dbg() I think.

>  	return 0;
>  }
>  

