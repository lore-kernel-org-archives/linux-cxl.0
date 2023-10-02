Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0EEE7849A
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Oct 2023 10:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjJBKCf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Oct 2023 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjJBKCe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Oct 2023 06:02:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E28AC
        for <linux-cxl@vger.kernel.org>; Mon,  2 Oct 2023 03:02:29 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rzc235kNrz6K8gC;
        Mon,  2 Oct 2023 18:02:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 11:02:26 +0100
Date:   Mon, 2 Oct 2023 11:02:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <20231002110225.00000e61@Huawei.com>
In-Reply-To: <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
        <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 29 Sep 2023 16:09:39 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for fixing the init/teardown of the 'sanitize' workqueue
> and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
> to be the single location where the sysfs attribute is notified. With
> that change there is no distinction between polled mode and interrupt
> mode. All the interrupt does is accelerate the polling interval.
> 
> The change to check for "mds->security.sanitize_node" under the lock is
> there to ensure that the interrupt, the work routine and the
> setup/teardown code can all have a consistent view of the registered
> notifier and the workqueue state. I.e. the expectation is that the
> interrupt is live past the point that the sanitize sysfs attribute is
> published, and it may race teardown, so it must be consulted under a
> lock.
> 
> Lastly, some opportunistic replacements of
> "queue_delayed_work(system_wq, ...)", which is just open coded
> schedule_delayed_work(), are included.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One trivial comment inline, otherwise looks fine to me

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/memdev.c |    3 +-
>  drivers/cxl/cxlmem.h      |    2 --
>  drivers/cxl/pci.c         |   60 +++++++++++++++++++--------------------------
>  3 files changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b547c07f54..2a7a07f6d165 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -561,8 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> -	if (mds->security.poll)
> -		cancel_delayed_work_sync(&mds->security.poll_dwork);
> +	cancel_delayed_work_sync(&mds->security.poll_dwork);
>  }
>  
>  static void cxl_memdev_shutdown(struct device *dev)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..55f00ad17a77 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -360,7 +360,6 @@ struct cxl_fw_state {
>   *
>   * @state: state of last security operation
>   * @enabled_cmds: All security commands enabled in the CEL
> - * @poll: polling for sanitization is enabled, device has no mbox irq support
>   * @poll_tmo_secs: polling timeout
>   * @poll_dwork: polling work item
>   * @sanitize_node: sanitation sysfs file to notify
> @@ -368,7 +367,6 @@ struct cxl_fw_state {
>  struct cxl_security_state {
>  	unsigned long state;
>  	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
> -	bool poll;
>  	int poll_tmo_secs;
>  	struct delayed_work poll_dwork;
>  	struct kernfs_node *sanitize_node;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index aa1b3dd9e64c..ac4e434b0806 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -128,10 +128,10 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>  	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>  	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		mutex_lock(&mds->mbox_mutex);
>  		if (mds->security.sanitize_node)
> -			sysfs_notify_dirent(mds->security.sanitize_node);
> -
> -		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
> +			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
> +		mutex_unlock(&mds->mbox_mutex);
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>  		rcuwait_wake_up(&mds->mbox_wait);
> @@ -160,8 +160,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  		int timeout = mds->security.poll_tmo_secs + 10;
>  
>  		mds->security.poll_tmo_secs = min(15 * 60, timeout);
> -		queue_delayed_work(system_wq, &mds->security.poll_dwork,
> -				   timeout * HZ);
> +		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
>  	}
>  	mutex_unlock(&mds->mbox_mutex);
>  }
> @@ -293,15 +292,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		 * and allow userspace to poll(2) for completion.
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> -			if (mds->security.poll) {
> -				/* give first timeout a second */
> -				timeout = 1;
> -				mds->security.poll_tmo_secs = timeout;
> -				queue_delayed_work(system_wq,
> -						   &mds->security.poll_dwork,
> -						   timeout * HZ);
> -			}
> -
> +			/* give first timeout a second */
> +			timeout = 1;
> +			mds->security.poll_tmo_secs = timeout;
> +			schedule_delayed_work(&mds->security.poll_dwork,
> +					      timeout * HZ);
>  			dev_dbg(dev, "Sanitization operation started\n");
>  			goto success;
>  		}
> @@ -384,7 +379,9 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  	struct device *dev = cxlds->dev;
>  	unsigned long timeout;
> +	int irq, msgnum;
>  	u64 md_status;
> +	u32 ctrl;
>  
>  	timeout = jiffies + mbox_ready_timeout * HZ;
>  	do {
> @@ -432,33 +429,26 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
>  
>  	rcuwait_init(&mds->mbox_wait);
> +	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
>  
> -	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
> -		u32 ctrl;
> -		int irq, msgnum;
> -		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -
> -		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> -		irq = pci_irq_vector(pdev, msgnum);
> -		if (irq < 0)
> -			goto mbox_poll;
> -
> -		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
> -			goto mbox_poll;
> +	/* background command interrupts are optional */
> +	if ((cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) == 0)

Nit, but it's a boolean flag, so to me
	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))

feels slightly better.

There are instances of this done with !() elsewhere in the file,
so not obviously a case of wanting to match local style.


> +		return 0;
>  
> -		/* enable background command mbox irq support */
> -		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> -		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> -		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
> +	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
> +	if (irq < 0)
> +		return 0;
>  
> +	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
>  		return 0;
> -	}
>  
> -mbox_poll:
> -	mds->security.poll = true;
> -	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
> +	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
> +	/* enable background command mbox irq support */
> +	ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> +	ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> +	writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>  
> -	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>  	return 0;
>  }
>  
> 

