Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5590C77B61
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjD1Qnw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjD1Qnv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 12:43:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E08CE
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682700229; x=1714236229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eXF0h8f4XFDHmzJ5wUZ9iXUUgLTkVJkL8YU6NhXNO5A=;
  b=dmxVOEJvin15gmHQfQAiO7qB7pE4NrDZJ/0GNQFxtswyqt3vwD0hGFtv
   l/a7CEROy1BVbykaPSuyIwlIEq8U7MBZ0z0jwPumuTDeAogyctycm8sL0
   fbIZKg+tY0hQhiYizliiM3ITxcDMflXGQQSA6He13tKT7iLPECbP69GRF
   N3MeUyjO9ir6676k2B/4wh4KPENQXITgfCGv/eY6emwqvUv/CV4KTiX07
   0uXR1HIfVMiCAeqeWEB42UsMppiqK+YjgRrtCjXwKV8hy2grR854HfkR6
   TC5rZ9aFTjNEKC4A3mGObaBoUel/Qqn8qOm/CXPPm5Ij7Q57X2Lu6FiNw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="332115425"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="332115425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="725402625"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="725402625"
Received: from egliskay-mobl.amr.corp.intel.com (HELO [10.212.108.170]) ([10.212.108.170])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:43:48 -0700
Message-ID: <46b76304-e75f-9a1a-296d-f67237d246d5@intel.com>
Date:   Fri, 28 Apr 2023 09:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-4-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230421092321.12741-4-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/21/23 2:23 AM, Davidlohr Bueso wrote:
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
>   drivers/cxl/cxlmem.h | 16 +++++++++
>   drivers/cxl/pci.c    | 79 ++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8c3302fc7738..17e3ab3c641a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -220,6 +220,18 @@ struct cxl_event_state {
>   	struct mutex log_lock;
>   };
>   
> +/**
> + * struct cxl_security_state - Device security state
> + *
> + * @sanitize_dwork: self-polling work item for sanitation
> + * @sanitize_tmo: self-polling timeout
> + */
> +struct cxl_security_state {
> +	/* below only used if device mbox irqs are not supported */
> +	struct delayed_work sanitize_dwork;
> +	int sanitize_tmo;
> +};
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> @@ -256,6 +268,7 @@ struct cxl_event_state {
>    * @serial: PCIe Device Serial Number
>    * @doe_mbs: PCI DOE mailbox array
>    * @event: event log driver state
> + * @sec: device security state
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
>    * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -296,6 +309,8 @@ struct cxl_dev_state {
>   
>   	struct cxl_event_state event;
>   
> +	struct cxl_security_state sec;
> +
>   	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>   };
>   
> @@ -327,6 +342,7 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>   	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>   	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,
>   	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>   	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>   	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index aa1bb74a52a1..bdee5273af5a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -97,6 +97,8 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>   static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>   {
>   	struct cxl_dev_state *cxlds = id;
> +	u64 reg;
> +	u16 opcode;
>   
>   	/* spurious or raced with hw? */
>   	if (!cxl_mbox_background_complete(cxlds)) {
> @@ -107,12 +109,47 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>   		goto done;
>   	}
>   
> -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	wake_up(&mbox_wait);
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> +
> +	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");

I might be missing something. Do we not want to stop waiting as well if 
the sanitation operation has ended?

> +	} else {
> +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +		wake_up(&mbox_wait);
> +	}
>   done:
>   	return IRQ_HANDLED;
>   }
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
> +
> +	mutex_lock(&cxlds->mbox_mutex);
> +	if (cxl_mbox_background_complete(cxlds)) {
> +		cxlds->sec.sanitize_tmo = 0;
> +		put_device(cxlds->dev);
> +
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		int tmo = cxlds->sec.sanitize_tmo + 10;
> +
> +		cxlds->sec.sanitize_tmo = min(15 * 60, tmo);
> +		queue_delayed_work(system_wq,
> +				   &cxlds->sec.sanitize_dwork, tmo * HZ);
> +	}
> +	mutex_unlock(&cxlds->mbox_mutex);
> +}
> +
>   /**
>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>    * @cxlds: The device state to communicate with.
> @@ -173,6 +210,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   		return -EBUSY;
>   	}
>   
> +	/*
> +	 * With sanitize polling, hardware might be done and the poller still
> +	 * not be in sync. Ensure no new command comes in until so. Keep the
> +	 * hardware semantics and only allow device health status.
> +	 */
> +	if (unlikely(cxlds->sec.sanitize_tmo > 0)) {
> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
> +			return -EBUSY;
> +	}
> +
>   	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>   			     mbox_cmd->opcode);
>   	if (mbox_cmd->size_in) {
> @@ -223,6 +270,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   		u64 bg_status_reg;
>   		int i;
>   
> +		/*
> +		 * Sanitation is a special case which monopolizes the device
> +		 * in an uninterruptible state and thus cannot be timesliced.
> +		 * Return immediately instead and allow userspace to poll(2)
> +		 * for completion.
> +		 */
> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> +			if (cxlds->sec.sanitize_tmo != -1) {
> +				/* give first timeout a second */
> +				cxlds->sec.sanitize_tmo = 1;
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
>   		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>   			mbox_cmd->opcode);
>   
> @@ -366,6 +434,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   		if (rc)
>   			goto mbox_poll;
>   
> +		/* flag that irqs are enabled */
> +		cxlds->sec.sanitize_tmo = -1;
> +
>   		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
>   		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>   
> @@ -373,7 +444,11 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	}
>   
>   mbox_poll:
> +	INIT_DELAYED_WORK(&cxlds->sec.sanitize_dwork,
> +			  cxl_mbox_sanitize_work);
> +	cxlds->sec.sanitize_tmo = 0;
>   	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
> +
>   	return 0;
>   }
>   
