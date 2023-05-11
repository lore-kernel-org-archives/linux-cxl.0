Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBFBC77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 14:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjEKOXq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 10:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbjEKOXm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 10:23:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C8546AB
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 07:23:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHDd22Xh5z6D8f3;
        Thu, 11 May 2023 22:22:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 15:23:31 +0100
Date:   Thu, 11 May 2023 15:23:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <20230511152330.00001eac@Huawei.com>
In-Reply-To: <20230421092321.12741-3-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-3-dave@stgolabs.net>
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

On Fri, 21 Apr 2023 02:23:16 -0700
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
> handler will simply awake a blocked cmd, which is also safe vs a
> task that is either waking (timing out) or already awoken. Similarly
> any irq setup error during the probing falls back to polling, thus
> avoids unnecessarily erroring out.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c |   3 +-
>  drivers/cxl/cxl.h       |   7 +++
>  drivers/cxl/cxlmem.h    |   5 ++
>  drivers/cxl/pci.c       | 104 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 6198637cb0bb..cde7270c6037 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -180,7 +180,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>  	if (rc)
>  		return rc;
>  
> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
>  		return cxl_mbox_cmd_rc2errno(mbox_cmd);
>  
>  	if (!out_size)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..72731a896f58 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -176,14 +176,21 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> +#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
> +#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)

Numeric order of bits probably makes more sense. So move this up one line.

>  #define CXLDEV_MBOX_CTRL_OFFSET 0x04
>  #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
> +#define   CXLDEV_MBOX_CTRL_BG_CMD_IRQ BIT(2)
>  #define CXLDEV_MBOX_CMD_OFFSET 0x08
>  #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
>  #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
>  #define CXLDEV_MBOX_STATUS_OFFSET 0x10
> +#define   CXLDEV_MBOX_STATUS_BG_CMD BIT(0)

Hmm. Oddly field is called Background Operation.  Still that is then
described as a command so I guess this is a reasonable bit of consolidation
of naming.

>  #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)

Obviously there are line length disadvantages to includes the status part
in the field names and there isn't a BG_CMD_COMMAND register thankfully
but I still find the absence of status a bit inconsistent / confusing.
initial instinct is this a field called OP_CODE in a register called
BG_CMD_COMMAND

> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)

It might be nice to to do 'something' with the Vendor Specific extended
status even if it is just put it in a dev_dbg() for anyone who cares?

>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
>  /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 090acebba4fa..8c3302fc7738 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -108,6 +108,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   *            variable sized output commands, it tells the exact number of bytes
>   *            written.
>   * @min_out: (input) internal command output payload size validation
> + * @poll_count: (input)  Number of timeouts to attempt.
> + * @poll_interval: (input) Number of ms between mailbox background command
> + *                 polling intervals timeouts.

name it poll_interval_ms: and the units become obvious everywhere without needing
comments.  Good for the lazy / forgetful reviewer if nothing else...

>   * @return_code: (output) Error code returned from hardware.
>   *
>   * This is the primary mechanism used to send commands to the hardware.
> @@ -123,6 +126,8 @@ struct cxl_mbox_cmd {
>  	size_t size_in;
>  	size_t size_out;
>  	size_t min_out;
> +	int poll_count;
> +	int poll_interval;
>  	u16 return_code;
>  };
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 39b829a29f6c..aa1bb74a52a1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -51,6 +51,7 @@
>  static unsigned short mbox_ready_timeout = 60;
>  module_param(mbox_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
> +static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);

I see in discussion you are moving to a per device approach so I won't review
that bit on this version.

>  
>  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  {
> @@ -85,6 +86,33 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>  			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>  			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>  
> +static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> +{
> +	u64 reg;
> +
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;

This is what motivated comment on including _STATUS_ in field names.
I briefly thought you had a field from the wrong register.

> +}
> +
> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	/* spurious or raced with hw? */

If talking about a race, I'd like a comment that gives more info.
What is the potential hardware race?

I can sort of see polling might have noticed completed command and
launched another one, all before the interrupt actually got handled.
If that's what you were thinking then eat the interrupt without the
scary message.

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
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @cxlds: The device state to communicate with.
> @@ -178,7 +206,59 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	mbox_cmd->return_code =
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
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

We already have an rc floating around in here.  Having ret as well with more limited
scope isn't great for readability.  I think you can just use rc here.

> +				mbox_wait, cxl_mbox_background_complete(cxlds),
> +				msecs_to_jiffies(mbox_cmd->poll_interval));
> +			if (ret > 0)
> +				break;
> +
I'd drop this blank line to keep all the handling of ret in one block of code.
It looks a bit too separate to me otherwise.

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

Why are we interested in the memory device status at this point? A timeout on background
command isn't really a cxl_cmd_err() in my head at least.

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

Here is where I'd like to also log the vendor specific extended status.

> +	}
> +
> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {

You overrode the original return code with the background command return code. So if you get
here and it's still RC_BACKGROUND I think something went wrong.

>  		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>  			cxl_mbox_cmd_rc2str(mbox_cmd));
>  		return 0; /* completed but caller must check return_code */
> @@ -224,6 +304,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  	unsigned long timeout;
>  	u64 md_status;
> +	int rc, irq;
>  
>  	timeout = jiffies + mbox_ready_timeout * HZ;
>  	do {
> @@ -272,6 +353,27 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>  		cxlds->payload_size);
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

Hmm. The old argument of whether to carry on when something unexpected happens.
I'd argue in this case at least and possibly the one above we should fail
hard as we really want to know if interrupt allocations are failing, not just
fall back quietly to polling.  I'd rather fail to probe the driver in a fashion
that lets us figure out what broke.

> +
> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +
> +		return 0;
> +	}
> +
> +mbox_poll:
> +	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>  	return 0;
>  }
>  

