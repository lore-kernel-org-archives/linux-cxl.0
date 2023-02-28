Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAD3C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 16:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjB1Q2E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 11:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1Q2D (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 11:28:03 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910325584
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 08:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677601636; x=1709137636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MXtLUF543DcqBkx8tKuuMD7myNhisfWawP0Bs17rC5I=;
  b=b29GPUnJdFJZ4AQcB0h3PshDM8xaiYOdvRjbfj9oRDU5yWNujoVER2N7
   N6xvFEZRTWHG1nRYqD2FNQPu1EbtYn6XqxCOI7De1x9vW12Tr5MWqX2zP
   8OO7mekqfagslgmg7oJ5v7V/7qEzACRXbGwlzlLcHV+n8EPOvyN3X3jl1
   KuLn+mqJVcnervimF+bhIffzOp0AWGEoW/Sg4yQu2p8UBpaPWmXVn4p9H
   zhr9cr+tBQxfEZSJi1j8RjDuJOx7VYYNDyfd0VwuaaKkCKLDmyY91dO04
   bBYIH8nyiQH3Zgcdd2RZhCexb9pj2q6w9+89sNN1uyP7UrDf6rGs+pTZn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="396750588"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="396750588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:27:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="798106578"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="798106578"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 08:27:02 -0800
Message-ID: <029b177d-7b91-77f7-a830-5f5ebe3ab0b8@intel.com>
Date:   Tue, 28 Feb 2023 09:27:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] cxl/mbox: Add background cmd handling machinery
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-2-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230224194652.1990604-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/24/23 12:46 PM, Davidlohr Bueso wrote:
> This adds support for handling background operations, as defined in
> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
> can run in the background asynchronously (to the hardware). Currently
> these are limited to Maintenance, transfer/activate Firmware, Scan
> Media, Sanitize (aka overwrite), and VPPB bind/unbind.
> 
> The driver will deal with such commands synchronously, blocking
> all other incoming commands for a specified period of time, allowing
> time-slicing the command such that the caller can send incremental
> requests to avoid monopolizing the driver/device. This approach
> makes the code simpler, where any out of sync (timeout) between the
> driver and hardware is just disregarded as an invalid state until
> the next successful submission.
> 
> On devices where mbox interrupts are supported, this will still use
> a poller that will wakeup in the specified wait intervals. The irq
> handler will simply awake a blocked cmd, which is also safe vs a
> task that is either waking (timing out) or already awoken.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Just a minor comment inline. Otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/cxl.h    |   7 +++
>   drivers/cxl/cxlmem.h |   6 +++
>   drivers/cxl/pci.c    | 100 +++++++++++++++++++++++++++++++++++++++++--
>   3 files changed, 109 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d853a0238ad7..b834e55375e3 100644
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
> index ccbafc05a636..934076254d52 100644
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
> +	u64 poll_interval;
>   	u16 return_code;
>   };
>   
> @@ -322,6 +327,7 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>   	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>   	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,
>   	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>   	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>   	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 60b23624d167..26b6105e2797 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -52,6 +52,8 @@ static unsigned short mbox_ready_timeout = 60;
>   module_param(mbox_ready_timeout, ushort, 0644);
>   MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
>   
> +static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
> +
>   static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>   {
>   	const unsigned long start = jiffies;
> @@ -85,6 +87,25 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>   			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>   			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>   
> +static irqreturn_t cxl_mbox_irq(int irq, void *id)
> +{
> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +	wake_up(&mbox_wait);
> +	return IRQ_HANDLED;
> +}
> +
> +static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> +{
> +	u64 bgcmd_status_reg;
> +	u32 pct;
> +
> +	bgcmd_status_reg = readq(cxlds->regs.mbox +
> +				 CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, bgcmd_status_reg);
> +
> +	return pct == 100;
> +}
> +
>   /**
>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>    * @cxlds: The device state to communicate with.
> @@ -178,6 +199,56 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   	mbox_cmd->return_code =
>   		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>   
> +	/*
> +	 * Handle the background command in a synchronous manner.
> +	 *
> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
> +	 * which we currently hold. Furthermore this also guarantees that
> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
> +	 * in that no new bg operation can occur in between.
> +	 *
> +	 * With the exception of special cases that merit monopolizing the
> +	 * driver/device, bg operations are timesliced in accordance with
> +	 * the nature of the command being sent.
> +	 *
> +	 * In the event of timeout, the mailbox state is indeterminate
> +	 * until the next successful command submission and the driver
> +	 * can get back in sync with the hardware state.
> +	 */
> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> +		u64 bg_status_reg;
> +		const bool timeslice = mbox_cmd->opcode != CXL_MBOX_OP_SANITIZE;
> +
> +		dev_dbg(dev, "Mailbox background operation started\n");
> +
> +		while (1) {
> +			if (wait_event_interruptible_timeout(
> +				mbox_wait, cxl_mbox_background_complete(cxlds),
> +				msecs_to_jiffies(mbox_cmd->poll_interval)) > 0)
> +				break;
> +
> +			if (timeslice && !--mbox_cmd->poll_count)
> +				break;
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
> +
> +		dev_dbg(dev, "Mailbox background operation completed\n");

May be helpful to also emit the return_code in case of errors.

DJ

> +	}
> +
>   	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>   		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>   			cxl_mbox_cmd_rc2str(mbox_cmd));
> @@ -222,8 +293,11 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
>   static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   {
>   	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>   	unsigned long timeout;
>   	u64 md_status;
> +	int rc, irq;
>   
>   	timeout = jiffies + mbox_ready_timeout * HZ;
>   	do {
> @@ -272,6 +346,24 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>   		cxlds->payload_size);
>   
> +	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ)) {
> +		dev_dbg(dev, "Only Mailbox polling is supported");
> +		return 0;
> +	}
> +
> +	irq = pci_irq_vector(pdev,
> +			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
> +	if (irq < 0)
> +		return irq;
> +
> +	rc = devm_request_irq(dev, irq, cxl_mbox_irq,
> +			      IRQF_SHARED, "mailbox", cxlds);
> +	if (rc)
> +		return rc;
> +
> +	writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
> +	       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +
>   	return 0;
>   }
>   
> @@ -757,6 +849,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>   
> +	rc = cxl_alloc_irq_vectors(pdev);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_pci_setup_mailbox(cxlds);
>   	if (rc)
>   		return rc;
> @@ -777,10 +873,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_alloc_irq_vectors(pdev);
> -	if (rc)
> -		return rc;
> -
>   	cxlmd = devm_cxl_add_memdev(cxlds);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
