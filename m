Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA74FC7EE23
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 17:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEVRbm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 13:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjEVRbl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 13:31:41 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F783F4
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 10:31:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7376F14287A;
        Mon, 22 May 2023 17:31:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E15D11427E9;
        Mon, 22 May 2023 17:31:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684776698; a=rsa-sha256;
        cv=none;
        b=i5mITvIM1jl+ZHUjbj3Vk1JNRC1w8U1gqstlGcJ5sR29fNA8OstT/uhFvLQdSdMipMkklM
        Wzt2+YH0kKU2z8AOTcpi4Eno3tRWyymGYLd+nceSwE7q6Ii6iI0NBgWzn58XMfSM8cP5lx
        AF8/8ysE/t6SmsIN0cuOC7xpulR1KV8Ladc+yLS50Z6bml7/Bbq4Q9pIHUeEihAduVu/2b
        u19okx9BsTyQgyjJH5etzm4dL4YLyhtwEX5Fwx1WrHdpn2mUif33TLHapqXlxsHKOBUS5Z
        3Qko9sM2KI9GO1Ikh03xseOj6Pa77BAfXX3C5JYewW7WlKVj1mMpR38850a00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684776698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=yZZAJvh3s7HNjYY3ekCIvxJuZ0f5YC/qdWwyu3fCXPY=;
        b=QugZGMJ6CmzxH4sAdWGg09zxkkmRUv0Hhvn1iY6gUnDTt8GYxQe6zEmD4U9Kx01pe+yFcX
        6i02kNmpsLT4n25Wlz9BnmfWr+svpQyU1yLBKe9a98vLlc+SJDuro8zc1sQaFVkhDKUSP9
        CzmElhBuTnazPk68ffUv55YF1miLWn/QvL/q4fzMbkf7Jx4eDF/Pnsk/bE1zizO857p0ni
        7rlUxfmNhnDAhFnmGcQfY4mTpiU4prUzsaQI7MiiH31ihz9ZBTEqI/fmrpxmdyV+tNnsob
        ICM8PZS0lv1nc7u9hek6WgTLFs+bxFi4X8w7jHgGaGDJGaKMVma8W8iPcHYz1g==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-smwkl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-Befitting: 3e953c022bf1f463_1684776698240_1693811515
X-MC-Loop-Signature: 1684776698240:109152331
X-MC-Ingress-Time: 1684776698240
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.217.246 (trex/6.8.1);
        Mon, 22 May 2023 17:31:38 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4QQ4Hs18LLz2v;
        Mon, 22 May 2023 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684776697;
        bh=yZZAJvh3s7HNjYY3ekCIvxJuZ0f5YC/qdWwyu3fCXPY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ZC7zQzV3QKk/YFXlAH9ncX0DhomHo8E92/fCSgRmrDkQeK+fs8JIrFLwquAIi6lBC
         Mp3CZa7M20g/Jkg1MjEoiF7vSjK3Imdcv8UKSZd4aJxmlRzk4/kbVILdzBUW9LRieu
         wO7oAzssRz1KWPCjjMO3LQJW7RoJqLSiyvB5cPB/aIbR0u+HJf9DjB1TJeI85d8CF7
         9OOkAG/FlaRAIX3X7J44WQbJwB715bZcY+WgYgy1lZbOuNqRvikQQL0IIZoLbJTj7F
         iCCcpBy+rz0uYWnlKMyYEGqBEfD2A84z1yw1qQLtE/h2D9DKwMQZ0q8utI7S+7AQtc
         t07xL1Y8jRXKQ==
Date:   Mon, 22 May 2023 09:58:10 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023, Dan Williams wrote:

>> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>> +{
>> +	struct cxl_dev_state *cxlds = id;
>> +
>> +	/* spurious or raced with hw? */
>> +	if (unlikely(!cxl_mbox_background_complete(cxlds))) {
>
>I expect this will fire all the time. While the specification allows for
>a vector per-reason there's nothing stopping an implementation from
>using one vector for all reasons. There's little incentive for spending
>silicon gates on exclusive vectors since none of the CXL interrupts
>service software fast paths.

fyi I have removed the warn below entirely. Handler is now simply:

	if (cxl_mbox_background_complete())
		wake_up();
	return IRQ_HANDLED;

>
>> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +
>> +		dev_warn(&pdev->dev,
>> +			 "Mailbox background operation IRQ but incomplete\n");
>> +		goto done;
>> +	}
>> +
>> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>> +	rcuwait_wake_up(&cxlds->mbox_wait);
>> +done:
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   /**
>>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>>    * @cxlds: The device state to communicate with.
>> @@ -177,6 +205,57 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>>	mbox_cmd->return_code =
>>		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>>
>> +	/*
>> +	 * Handle the background command in a synchronous manner.
>> +	 *
>> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
>> +	 * which we currently hold. Furthermore this also guarantees that
>> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
>> +	 * in that no new bg operation can occur in between.
>> +	 *
>> +	 * Background operations are timesliced in accordance with the nature
>> +	 * of the command. In the event of timeout, the mailbox state is
>> +	 * indeterminate until the next successful command submission and the
>> +	 * driver can get back in sync with the hardware state.
>> +	 */
>> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>> +		long ret;
>> +		u64 bg_status_reg;
>> +		int i, timeout = mbox_cmd->poll_interval;
>> +
>> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>> +			mbox_cmd->opcode);
>> +
>> +		for (i = 0; i < mbox_cmd->poll_count; i++) {
>> +			ret = rcuwait_wait_event_timeout(&cxlds->mbox_wait,
>> +					cxl_mbox_background_complete(cxlds),
>> +					TASK_INTERRUPTIBLE,
>> +					msecs_to_jiffies(timeout));
>> +			if (ret > 0)
>> +				break;
>> +			if (ret < 0) /* interrupted by a signal */
>
>Have you tested this path? I am curious what happens on the next command
>submission? As far as I can see foreground commands would not be
>impacted but the next background submission would fail instead of wait,
>right?

No, I haven't tested this path. My expectation here is that this would be
similar to the timeout case in that the driver returns but the hw keeps
processing the command. The next command, fg or bg, would be at the mercy
of the hw doing the right thing until it's done with the canceled one.

>Perhaps a dev_err_ratelimited() message and an EBUSY status for when
>that happens to at least indicate, "hardware is still chewing on a
>cancelled request".  Later we can think about whether that's recoverable
>via a reset.

Well but reaching this path already assumes hw didn't error out the current
command because the canceled one was still being run.

Alternatively we could also just make the sleep uninterruptible, but because
this comes from the user triggering the bg op, I thought against it.

>> +				return ret;

rcuwait, unlike regular wait, returns -EINTR instead of -ERESTARTSYS. I've
updated the return value here to the latter.

>> +		}
>> +
>> +		if (!cxl_mbox_background_complete(cxlds)) {
>> +			u64 md_status =
>> +				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>> +
>> +			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
>> +				    "background timeout");
>> +			return -ETIMEDOUT;
>> +		}
>> +
>> +		bg_status_reg = readq(cxlds->regs.mbox +
>> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>> +		mbox_cmd->return_code =
>> +			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
>> +				  bg_status_reg);
>> +		dev_dbg(dev,
>> +			"Mailbox background operation (0x%04x) completed\n",
>> +			mbox_cmd->opcode);
>> +	}
>> +
>>	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>>		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>>			cxl_mbox_cmd_rc2str(mbox_cmd));
>> @@ -271,6 +350,29 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>>	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>>		cxlds->payload_size);
>>
>> +	rcuwait_init(&cxlds->mbox_wait);
>> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
>> +		int irq, msgnum;
>> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +
>> +		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>> +		irq = pci_irq_vector(pdev, msgnum);
>> +		if (irq < 0)
>> +			goto mbox_poll;
>> +
>> +		if (devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
>> +				     IRQF_SHARED, NULL, cxlds))
>
>This needs IRQF_ONESHOT and that @dev_id needs to be globally unique in
>case @irq is shared. So I think you want to factor out a common helper
>from cxl_event_req_irq() that this can reuse. I.e. cxl_event_req_irq()
>already gets the flags and @dev_id right, so just create a cxl_req_irq()
>that takes the irq as an argument and share it.

For the oneshot this was a hardirq, so I don't think this is needed, but
regardless, I've added the following helper in a new patch which both
events and mbox can call:

static int cxl_request_irq(struct cxl_dev_state *cxlds,
			  int irq, irq_handler_t handler)
{
        struct device *dev = cxlds->dev;
        struct cxl_dev_id *dev_id;

        /* dev_id must be globally unique and must contain the cxlds */
        dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
        if (!dev_id)
	       return -ENOMEM;
        dev_id->cxlds = cxlds;

        return devm_request_threaded_irq(dev, irq, NULL, handler,
					IRQF_SHARED | IRQF_ONESHOT, NULL,
					dev_id);
}

>
>> +			goto mbox_poll;
>> +
>> +		/* only enable background cmd mbox irq support */
>> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
>> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>
>Just in case some other code ever enables doorbell interrupts it would
>be nice if this performed a read-modify-write rather than assuming it
>can clobber that setting.

Hmm do you mean enabling/disabling dynamically? Otherwise I would have
expected this to be a one time thing which we could just OR both bits.
Maybe this could be revisited when needed? Jonathan suggested enabling
doorbell irqs in the future, which I plan on looking into at some point.

Thanks,
Davidlohr
