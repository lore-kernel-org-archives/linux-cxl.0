Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4993BEB64D0
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 16:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjFMQIG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbjFMQIC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 12:08:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71021985
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 09:08:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QgYLT6dTdz67GCV;
        Wed, 14 Jun 2023 00:05:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 17:07:56 +0100
Date:   Tue, 13 Jun 2023 17:07:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Message-ID: <20230613170755.000011b9@Huawei.com>
In-Reply-To: <20230612181038.14421-4-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
        <20230612181038.14421-4-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 12 Jun 2023 11:10:34 -0700
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
> check for 'sanitize_tmo' for uncommon poll scenarios.
> 
> The irq case is much simpler as hardware will serialize/error
> appropriately.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Not updated the check against -1 for whether to poll or not.

Which I'm guessing is the bug I'm seeing whilst testing this on qemu

> ---
>  drivers/cxl/core/memdev.c | 10 +++++
>  drivers/cxl/cxlmem.h      |  7 ++++
>  drivers/cxl/pci.c         | 77 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 1bbb7e39fc93..834f418b6bcb 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -460,11 +460,21 @@ void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cm
>  }
>  EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
>  
> +static void cxl_memdev_security_shutdown(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (cxlds->security.poll)
> +		cancel_delayed_work_sync(&cxlds->security.poll_dwork);
> +}
> +
>  static void cxl_memdev_shutdown(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  
>  	down_write(&cxl_memdev_rwsem);
> +	cxl_memdev_security_shutdown(dev);
>  	cxlmd->cxlds = NULL;
>  	up_write(&cxl_memdev_rwsem);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 091f1200736b..3a9df1044144 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -264,9 +264,15 @@ struct cxl_poison_state {
>   * struct cxl_security_state - Device security state
>   *
>   * @state: state of last security operation
> + * @poll: polling for sanitation is enabled, device has no mbox irq support
> + * @poll_tmo_secs: polling timeout
> + * @poll_dwork: polling work item
>   */
>  struct cxl_security_state {
>  	unsigned long state;
> +	bool poll;
> +	int poll_tmo_secs;
> +	struct delayed_work poll_dwork;
>  };
>  
>  /**
> @@ -379,6 +385,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4b2575502f49..c92eab55a5a7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -115,18 +115,52 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>  
>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  {
> +	u64 reg;
> +	u16 opcode;
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  
>  	if (!cxl_mbox_background_complete(cxlds))
>  		return IRQ_NONE;
>  
> -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	rcuwait_wake_up(&cxlds->mbox_wait);
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> +	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +		rcuwait_wake_up(&cxlds->mbox_wait);
> +	}
>  
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
> +	cxlds = container_of(work,
> +			     struct cxl_dev_state, security.poll_dwork.work);
> +
> +	mutex_lock(&cxlds->mbox_mutex);
> +	if (cxl_mbox_background_complete(cxlds)) {
> +		cxlds->security.poll_tmo_secs = 0;
> +		put_device(cxlds->dev);
> +
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		int timeout = cxlds->security.poll_tmo_secs + 10;
> +
> +		cxlds->security.poll_tmo_secs = min(15 * 60, timeout);
> +		queue_delayed_work(system_wq, &cxlds->security.poll_dwork,
> +				   timeout * HZ);
> +	}
> +	mutex_unlock(&cxlds->mbox_mutex);
> +}
> +
>  /**
>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>   * @cxlds: The device state to communicate with.
> @@ -187,6 +221,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * With sanitize polling, hardware might be done and the poller still
> +	 * not be in sync. Ensure no new command comes in until so. Keep the
> +	 * hardware semantics and only allow device health status.
> +	 */
> +	if (unlikely(cxlds->security.poll_tmo_secs > 0)) {
> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
> +			return -EBUSY;
> +	}
> +
>  	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>  			     mbox_cmd->opcode);
>  	if (mbox_cmd->size_in) {
> @@ -235,11 +279,34 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>  	 */
>  	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>  		u64 bg_status_reg;
> -		int i, timeout = mbox_cmd->poll_interval_ms;
> +		int i, timeout;
> +
> +		/*
> ++		 * Sanitation is a special case which monopolizes the device
> +		 * and cannot be timesliced. Handle asynchronously instead,
> +		 * and allow userspace to poll(2) for completion.
> +		 */
> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> +			if (cxlds->security.poll_tmo_secs != -1) {
Should be checking your new poll boolean.

Jonathan
> +				/* hold the device throughout */
