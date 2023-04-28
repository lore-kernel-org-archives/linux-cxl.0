Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09523C77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 16:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjD1QV3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjD1QV2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 12:21:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9CBF4
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682698886; x=1714234886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dfucD9nhFFC3ceGd/jlWnOo/ROEGpdVkI+VuT03vPOw=;
  b=fFfukoNmB5FkwqeEZ5H3x9l93h5NE3nSAVrYas5XlHf2UYFUwjBmKa9Y
   t6e8vRM2qOD+V1wxxXKprt2oJVKv+/yOMKSWzP/7hPN2q4M+undGXmVeH
   fzbnftlxyITfUjsAcVgVl3CTth5p/Allna3D5g0+SdJ+//tC6wOwgjYTd
   3Gm3ATzeGFbMgFnxW9YV431Waljk+l9XnW/Y+qpGZxqtCyqfHhxPLS8Xz
   LQsGpQar4AfZYPTCqUzLoZfhFU+goHUEisvBhgC2BxsO1R0FAp9miR9Iq
   iMOvo0RDXLNvli1lVrOCnEV1qtOwFWTo5CP7rAZvGFWIha2lUoJ3xf7Ds
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="375784486"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="375784486"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="697590539"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="697590539"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.108.170]) ([10.212.108.170])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:21:26 -0700
Message-ID: <cb80b111-c639-aaff-f8dd-8ceacf124b1a@intel.com>
Date:   Fri, 28 Apr 2023 09:21:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230421092321.12741-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/21/23 2:23 AM, Davidlohr Bueso wrote:
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
> handler will simply awake a blocked cmd, which is also safe vs a
> task that is either waking (timing out) or already awoken. Similarly
> any irq setup error during the probing falls back to polling, thus
> avoids unnecessarily erroring out.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   drivers/cxl/core/mbox.c |   3 +-
>   drivers/cxl/cxl.h       |   7 +++
>   drivers/cxl/cxlmem.h    |   5 ++
>   drivers/cxl/pci.c       | 104 +++++++++++++++++++++++++++++++++++++++-
>   4 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 6198637cb0bb..cde7270c6037 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -180,7 +180,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>   	if (rc)
>   		return rc;
>   
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
>   		return cxl_mbox_cmd_rc2errno(mbox_cmd);
>   
>   	if (!out_size)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..72731a896f58 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -176,14 +176,21 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   /* CXL 2.0 8.2.8.4 Mailbox Registers */
>   #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>   #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> +#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
> +#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
>   #define CXLDEV_MBOX_CTRL_OFFSET 0x04
>   #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
> +#define   CXLDEV_MBOX_CTRL_BG_CMD_IRQ BIT(2)
>   #define CXLDEV_MBOX_CMD_OFFSET 0x08
>   #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
>   #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
>   #define CXLDEV_MBOX_STATUS_OFFSET 0x10
> +#define   CXLDEV_MBOX_STATUS_BG_CMD BIT(0)
>   #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
>   #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
>   #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>   
>   /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 090acebba4fa..8c3302fc7738 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -108,6 +108,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>    *            variable sized output commands, it tells the exact number of bytes
>    *            written.
>    * @min_out: (input) internal command output payload size validation
> + * @poll_count: (input)  Number of timeouts to attempt.
> + * @poll_interval: (input) Number of ms between mailbox background command
> + *                 polling intervals timeouts.
>    * @return_code: (output) Error code returned from hardware.
>    *
>    * This is the primary mechanism used to send commands to the hardware.
> @@ -123,6 +126,8 @@ struct cxl_mbox_cmd {
>   	size_t size_in;
>   	size_t size_out;
>   	size_t min_out;
> +	int poll_count;
> +	int poll_interval;
>   	u16 return_code;
>   };
>   
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 39b829a29f6c..aa1bb74a52a1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -51,6 +51,7 @@
>   static unsigned short mbox_ready_timeout = 60;
>   module_param(mbox_ready_timeout, ushort, 0644);
>   MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
> +static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);

I apologize if I've asked this before and you've already answered. What 
is the reason the mbox_wait a module global wq instead of a per device 
wq? Just thinking when you tear down a device, you may want to wake all 
pending for that device to clean up.

>   
>   static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>   {
> @@ -85,6 +86,33 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>   			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>   			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
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
> +	if (!cxl_mbox_background_complete(cxlds)) {
> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +		dev_warn(&pdev->dev,
> +			 "Mailbox background operation IRQ but incomplete\n");
> +		goto done;
> +	}
> +
> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +	wake_up(&mbox_wait);
> +done:
> +	return IRQ_HANDLED;
> +}
> +
>   /**
>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>    * @cxlds: The device state to communicate with.
> @@ -178,7 +206,59 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   	mbox_cmd->return_code =
>   		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>   
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> +	/*
> +	 * Handle the background command in a synchronous manner.
> +	 *
> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> +	 * which we currently hold. Furthermore this also guarantees that
> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
> +	 * in that no new bg operation can occur in between.
> +	 *
> +	 * Background operations are timesliced in accordance with the nature
> +	 * of the command. In the event of timeout, the mailbox state is
> +	 * indeterminate until the next successful command submission and the
> +	 * driver can get back in sync with the hardware state.
> +	 */
> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> +		u64 bg_status_reg;
> +		int i;
> +
> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> +			mbox_cmd->opcode);
> +
> +		for (i = 0; i < mbox_cmd->poll_count; i++) {
> +			int ret = wait_event_interruptible_timeout(
> +				mbox_wait, cxl_mbox_background_complete(cxlds),
> +				msecs_to_jiffies(mbox_cmd->poll_interval));
> +			if (ret > 0)
> +				break;
> +
> +			/* interrupted by a signal */
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		if (!cxl_mbox_background_complete(cxlds)) {
> +			u64 md_status =
> +				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
> +				    "background timeout");
> +			return -ETIMEDOUT;
> +		}
> +
> +		bg_status_reg = readq(cxlds->regs.mbox +
> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +		mbox_cmd->return_code =
> +			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
> +				  bg_status_reg);
> +		dev_dbg(dev,
> +			"Mailbox background operation (0x%04x) completed\n",
> +			mbox_cmd->opcode);
> +	}
> +
> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {
>   		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>   			cxl_mbox_cmd_rc2str(mbox_cmd));
>   		return 0; /* completed but caller must check return_code */
> @@ -224,6 +304,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>   	unsigned long timeout;
>   	u64 md_status;
> +	int rc, irq;
>   
>   	timeout = jiffies + mbox_ready_timeout * HZ;
>   	do {
> @@ -272,6 +353,27 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>   		cxlds->payload_size);
>   
> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +
> +		irq = pci_irq_vector(pdev,
> +			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
> +		if (irq < 0)
> +			goto mbox_poll;
> +
> +		rc = devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
> +				      IRQF_SHARED, "mailbox", cxlds);
> +		if (rc)
> +			goto mbox_poll;
> +
> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +
> +		return 0;
> +	}
> +
> +mbox_poll:
> +	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>   	return 0;
>   }
>   
