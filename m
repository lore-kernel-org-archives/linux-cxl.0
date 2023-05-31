Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2CC7EE23
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjEaQ3s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEaQ3r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 12:29:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511712E
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 09:29:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWZRm15DCz67g2H;
        Thu,  1 Jun 2023 00:27:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 17:29:40 +0100
Date:   Wed, 31 May 2023 17:29:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/6] cxl/mbox: Add sanitation handling machinery
Message-ID: <20230531172939.00006d8b@Huawei.com>
In-Reply-To: <25925dfa-d2ee-c9dc-90b8-875d2c74eed5@intel.com>
References: <20230526033344.17167-1-dave@stgolabs.net>
        <20230526033344.17167-3-dave@stgolabs.net>
        <25925dfa-d2ee-c9dc-90b8-875d2c74eed5@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 30 May 2023 16:36:21 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 5/25/23 20:33, Davidlohr Bueso wrote:
> > Sanitation is by definition a device-monopolizing operation, and thus
> > the timeslicing rules for other background commands do not apply.
> > As such handle this special case asynchronously and return immediately.
> > Subsequent changes will allow completion to be pollable from userspace
> > via a sysfs file interface.
> >
> > For devices that don't support interrupts for notifying background
> > command completion, self-poll with the caveat that the poller can
> > be out of sync with the ready hardware, and therefore care must be
> > taken to not allow any new commands to go through until the poller
> > sees the hw completion. The poller takes the mbox_mutex to stabilize
> > the flagging, minimizing any runtime overhead in the send path to
> > check for 'sanitize_tmo' for uncommon poll scenarios. This flag
> > also serves for sanitation (the only user of async polling) to know
> > when to queue work or simply rely on irqs.
> >
> > The irq case is much simpler as hardware will serialize/error
> > appropriately.
> >
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> 
> Just a minor nit below, otherwise
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> 
> > ---
> >   drivers/cxl/core/memdev.c | 10 +++++
> >   drivers/cxl/cxlmem.h      | 10 +++++
> >   drivers/cxl/pci.c         | 83 +++++++++++++++++++++++++++++++++++++--
> >   3 files changed, 99 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 6e1d7d3610a2..02763e83545c 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -460,11 +460,21 @@ void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cm
> >   }
> >   EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
> >   
> > +static void cxl_memdev_security_shutdown(struct device *dev)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +
> > +	if (cxlds->security.poll_tmo_secs != -1)
> > +		cancel_delayed_work_sync(&cxlds->security.poll_dwork);
> > +}
> > +
> >   static void cxl_memdev_shutdown(struct device *dev)
> >   {
> >   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >   
> >   	down_write(&cxl_memdev_rwsem);
> > +	cxl_memdev_security_shutdown(dev);
> >   	cxlmd->cxlds = NULL;
> >   	up_write(&cxl_memdev_rwsem);
> >   }
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 5329274b0076..02ec68f97de2 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -264,9 +264,18 @@ struct cxl_poison_state {
> >    * struct cxl_security_state - Device security state
> >    *
> >    * @state: state of last security operation
> > + * @poll_tmo_secs: polling timeout
> > + * @poll_dwork: polling work item
> > + *
> > + * Polling (sanitation) is only used when device mbox irqs are not
> > + * supported. As such, @poll_tmo_secs == -1 indicates that polling
> > + * is disabled. Otherwise, when enabled, @poll_tmo_secs is maxed
> > + * at 15 minutes and serialized by the mbox_mutex.
> >    */
> >   struct cxl_security_state {
> >   	unsigned long state;
> > +	int poll_tmo_secs;
> > +	struct delayed_work poll_dwork;
> >   };
> >   
> >   /**
> > @@ -380,6 +389,7 @@ enum cxl_opcode {
> >   	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
> >   	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
> >   	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> > +	CXL_MBOX_OP_SANITIZE		= 0x4400,
> >   	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
> >   	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
> >   	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index a78e40e6d0e0..a0d93719ab18 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -115,16 +115,52 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
> >   
> >   static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> >   {
> > +	u64 reg;
> > +	u16 opcode;
> >   	struct cxl_dev_id *dev_id = id;
> >   	struct cxl_dev_state *cxlds = dev_id->cxlds;
> >   
> > -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> > -	if (cxl_mbox_background_complete(cxlds))
> > -		rcuwait_wake_up(&cxlds->mbox_wait);
> > +	if (!cxl_mbox_background_complete(cxlds))
> > +		goto done;
> >   
> > +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> > +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> > +	if (opcode == CXL_MBOX_OP_SANITIZE) {
> > +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> > +	} else {
> > +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> > +		rcuwait_wake_up(&cxlds->mbox_wait);
> > +	}
> > +done:
> >   	return IRQ_HANDLED;
> >   }
> >   
> > +/*
> > + * Sanitation operation polling mode.
> > + */
> > +static void cxl_mbox_sanitize_work(struct work_struct *work)
> > +{
> > +	struct cxl_dev_state *cxlds;
> > +
> > +	cxlds = container_of(work,
> > +			     struct cxl_dev_state, security.poll_dwork.work);
> > +
> > +	mutex_lock(&cxlds->mbox_mutex);
> > +	if (cxl_mbox_background_complete(cxlds)) {
> > +		cxlds->security.poll_tmo_secs = 0;
> > +		put_device(cxlds->dev);
> > +
> > +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> > +	} else {
> > +		int timeout = cxlds->security.poll_tmo_secs + 10;
> > +
> > +		cxlds->security.poll_tmo_secs = min(15 * 60, timeout);
> > +		queue_delayed_work(system_wq, &cxlds->security.poll_dwork,
> > +				   timeout * HZ);
> > +	}
> > +	mutex_unlock(&cxlds->mbox_mutex);
> > +}
> > +
> >   /**
> >    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
> >    * @cxlds: The device state to communicate with.
> > @@ -185,6 +221,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >   		return -EBUSY;
> >   	}
> >   
> > +	/*
> > +	 * With sanitize polling, hardware might be done and the poller still
> > +	 * not be in sync. Ensure no new command comes in until so. Keep the
> > +	 * hardware semantics and only allow device health status.
> > +	 */
> > +	if (unlikely(cxlds->security.poll_tmo_secs > 0)) {
> > +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
> > +			return -EBUSY;
> > +	}
> > +
> >   	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
> >   			     mbox_cmd->opcode);
> >   	if (mbox_cmd->size_in) {
> > @@ -233,11 +279,34 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >   	 */
> >   	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
> >   		u64 bg_status_reg;
> > -		int i, timeout = mbox_cmd->poll_interval_ms;
> > +		int i, timeout;
> > +
> > +		/*
> > +		 * Sanitation is a special case which monopolizes the device
> > +		 * and cannot be timesliced. Handle asynchronously instead,
> > +		 * and allow userspace to poll(2) for completion.
> > +		 */
> > +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> > +			if (cxlds->security.poll_tmo_secs != -1) {
> > +				/* hold the device throughout */
> > +				get_device(cxlds->dev);
> > +
> > +				/* give first timeout a second */
> > +				timeout = 1;
> > +				cxlds->security.poll_tmo_secs = timeout;
> > +				queue_delayed_work(system_wq,
> > +						   &cxlds->security.poll_dwork,
> > +						   timeout * HZ);
> > +			}
> > +
> > +			dev_dbg(dev, "Sanitation operation started\n");
> > +			goto success;
> > +		}
> >   
> >   		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
> >   			mbox_cmd->opcode);
> >   
> > +		timeout = mbox_cmd->poll_interval_ms;
> >   		for (i = 0; i < mbox_cmd->poll_count; i++) {
> >   			if (rcuwait_wait_event_timeout(&cxlds->mbox_wait,
> >   				       cxl_mbox_background_complete(cxlds),
> > @@ -268,6 +337,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >   		return 0; /* completed but caller must check return_code */
> >   	}
> >   
> > +success:
> >   	/* #7 */
> >   	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
> >   	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> > @@ -376,10 +446,15 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >   		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
> >   		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> >   
> > +		/* flag that irqs are enabled */
> > +		cxlds->security.poll_tmo_secs = -1;  
> 
> Use a #define instead of -1 magic number? CXL_CMD_TIMEOUT_INVALID 
> perhaps? Would also apply to all the checking of poll_tmo_secs in this 
> patch.

If we can avoid this use of magic numbers entirely it would be more readable.
Either a nicely named boolean, or querying it directly from the hardware
/ other cached state (which looks fiddly).

> 
> 
> >   		return 0;
> >   	}
> >   
> >   mbox_poll:
> > +	cxlds->security.poll_tmo_secs = 0;
> > +	INIT_DELAYED_WORK(&cxlds->security.poll_dwork,
> > +			  cxl_mbox_sanitize_work);
> >   	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
> >   	return 0;
> >   }  
> 

