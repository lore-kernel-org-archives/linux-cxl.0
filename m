Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADEAC7EE2D
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEaQgw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 May 2023 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEaQgf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 May 2023 12:36:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C959138
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 09:36:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWZbS5lBRz67Xx5;
        Thu,  1 Jun 2023 00:34:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 17:36:21 +0100
Date:   Wed, 31 May 2023 17:36:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/6] cxl/mbox: Add sanitation handling machinery
Message-ID: <20230531173620.00001946@Huawei.com>
In-Reply-To: <20230526033344.17167-3-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
        <20230526033344.17167-3-dave@stgolabs.net>
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

On Thu, 25 May 2023 20:33:40 -0700
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
...

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5329274b0076..02ec68f97de2 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -264,9 +264,18 @@ struct cxl_poison_state {
>   * struct cxl_security_state - Device security state
>   *
>   * @state: state of last security operation
> + * @poll_tmo_secs: polling timeout
> + * @poll_dwork: polling work item
> + *
> + * Polling (sanitation) is only used when device mbox irqs are not
> + * supported. As such, @poll_tmo_secs == -1 indicates that polling
> + * is disabled. Otherwise, when enabled, @poll_tmo_secs is maxed
> + * at 15 minutes and serialized by the mbox_mutex.

Long comment to avoid a bool :)

>   */
>  struct cxl_security_state {
>  	unsigned long state;
> +	int poll_tmo_secs;
> +	struct delayed_work poll_dwork;
>  };

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a78e40e6d0e0..a0d93719ab18 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -115,16 +115,52 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>  
>  static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  {
> +	u64 reg;
> +	u16 opcode;
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  
> -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	if (cxl_mbox_background_complete(cxlds))
> -		rcuwait_wake_up(&cxlds->mbox_wait);
> +	if (!cxl_mbox_background_complete(cxlds))

If we hit this path, does it mean it wasn't our interrupt?
Or an we get here via a race as well - but if so there should
be a comment on why this isn't returning IRQ_NONE. So either
a comment on the race or IRQ_NONE return.


> +		goto done;
>  
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> +	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +		rcuwait_wake_up(&cxlds->mbox_wait);
> +	}
> +done:
>  	return IRQ_HANDLED;
>  }
>
