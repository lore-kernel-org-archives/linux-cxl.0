Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB1C77B73
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 19:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjEVTbJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjEVTbI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 15:31:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83E9C
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 12:31:01 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A45B9502330;
        Mon, 22 May 2023 19:31:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 259CF5027EC;
        Mon, 22 May 2023 19:31:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684783860; a=rsa-sha256;
        cv=none;
        b=80H5UO6V2vu4UgMKa68Cr6AK97Lu7CjX1e1+5+oFWXj7yAv65GrO+ZH3eg5F5ckvaXIIyG
        OI667oLVSjLWY0+XIPyn2M0b2zRq+7f+Ayxe7R/JmLF+vL6rFs2Op55L1zaJzn39r9a+pC
        WKEqwvTFs+1I07GlVRqFjmYKgC/mnV7r3RxDp3ljjh6B1aG6oMS/Tn9uRjGZ7qaW2xbNn/
        OT6vddydXRLQgaCioh1b5pcEVrME4YchhDaWwsOHZbhxlI6CbWl827Cvi1almq8800rsSQ
        4k/HNGJjZIU1i1noX5QYXyfrOuWJdjc/wptdl/vPvIGhHGTQHzaRR0+eK4WlWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684783860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=sFhwY1ilRJ86On7JHrHJI1e5YeTLoZLeQGOTPmhwWgs=;
        b=h8TKNmqCRTDmzdCYtQ/MR86Oe7jpyTpaLYe+o+Puqy0vs+mDFyuXM9frJhCEH8nUWAf+KY
        QvPfPp10AHhOXEM3V5wNk01lIpIaSV+7lVIXKJ1ku60puHzdl0cx148+7KvOCW05rVs3JO
        aoNsqPBiUKXa6krdtZs+kPmnIUMnxjnN5JXwNjpIk70VyLzoe/OR4klZwK6h71rHAC9huS
        HxvUyvNTRaoIqiU+sLx0YOzL+xwI38tTMBDd4jFGs+vP/mrxrFTSySqHc1YiZVCy1usET2
        UYIL3V1m3T328IBczQ+xPX3lnqg//UJpYSTaG3aRqzsbgBX2YEokNcWg1yetrg==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-m656l;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Soft: 718c178340f99fe4_1684783860463_3007638707
X-MC-Loop-Signature: 1684783860463:2868091386
X-MC-Ingress-Time: 1684783860462
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.252.222 (trex/6.8.1);
        Mon, 22 May 2023 19:31:00 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4QQ6xb31HYz8J;
        Mon, 22 May 2023 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684783859;
        bh=sFhwY1ilRJ86On7JHrHJI1e5YeTLoZLeQGOTPmhwWgs=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jPcuShCz6ko84jquQNwCQajhchy6TSueGdH6CyNXchBzdWGjrFk1VxdgR/XX+n6YU
         0fniDyBREiqKBFN/hymFDEwd9b5ahbqEqEBvB3Ot/kqgFhqn31MOHGS+604u64uTEX
         GW9qteLFKOfjeMSY1KSA3pd/9eX0zUjfyxheRjPl37nl3qsod7pt9hQpN7O7OsJjJ1
         DuyIUFUX4l3VF1Kwv6YmTGiGmJHwmRG6c6O9u7s2af9W49EMRRWziisHo+17K49j8Y
         n/IlWFIfX+TYbktDttdAK0isibxshc4pKUsZ7zK7tOPETjrl7beVi0k7Oxhfcru8YD
         xg4Gb30PsEHXQ==
Date:   Mon, 22 May 2023 11:57:32 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <ps5l5kclllyhjfaelf6p7cl4vsq6v3lp5uxoqt6u5m4ha7adw5@6q4gjq7hlxpp>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
 <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
 <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 22 May 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> >> +	/*
>> >> +	 * Handle the background command in a synchronous manner.
>> >> +	 *
>> >> +	 * All other mailbox commands will serialize/queue on the mbox_mutex,
>> >> +	 * which we currently hold. Furthermore this also guarantees that
>> >> +	 * cxl_mbox_background_complete() checks are safe amongst each other,
>> >> +	 * in that no new bg operation can occur in between.
>> >> +	 *
>> >> +	 * Background operations are timesliced in accordance with the nature
>> >> +	 * of the command. In the event of timeout, the mailbox state is
>> >> +	 * indeterminate until the next successful command submission and the
>> >> +	 * driver can get back in sync with the hardware state.
>> >> +	 */
>> >> +	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>> >> +		long ret;
>> >> +		u64 bg_status_reg;
>> >> +		int i, timeout = mbox_cmd->poll_interval;
>> >> +
>> >> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>> >> +			mbox_cmd->opcode);
>> >> +
>> >> +		for (i = 0; i < mbox_cmd->poll_count; i++) {
>> >> +			ret = rcuwait_wait_event_timeout(&cxlds->mbox_wait,
>> >> +					cxl_mbox_background_complete(cxlds),
>> >> +					TASK_INTERRUPTIBLE,
>> >> +					msecs_to_jiffies(timeout));
>> >> +			if (ret > 0)
>> >> +				break;
>> >> +			if (ret < 0) /* interrupted by a signal */
>> >
>> >Have you tested this path? I am curious what happens on the next command
>> >submission? As far as I can see foreground commands would not be
>> >impacted but the next background submission would fail instead of wait,
>> >right?
>>
>> No, I haven't tested this path. My expectation here is that this would be
>> similar to the timeout case in that the driver returns but the hw keeps
>> processing the command. The next command, fg or bg, would be at the mercy
>> of the hw doing the right thing until it's done with the canceled one.
>
>Right, it's that "mercy" part where there needs to be documentation of
>what to expect.
>
>If someone sends SIGTERM after triggering a scan media and then
>immediately resubmits it maybe the right answer is to go into another
>interruptible sleep awaiting the last background state to clear out. It
>just seems like returning an error leaves userspace to fend for itself
>with little visibility of what it needs to do next. SIGTERM during a
>background command means, "I do not care about the previous result".
>Given the driver is mitigating long running background cycles that
>implies that waiting before submitting the next colliding command would
>not be onerous. They can always SIGTERM again if the wait gets too long.
>
>
>> >Perhaps a dev_err_ratelimited() message and an EBUSY status for when
>> >that happens to at least indicate, "hardware is still chewing on a
>> >cancelled request".  Later we can think about whether that's recoverable
>> >via a reset.
>>
>> Well but reaching this path already assumes hw didn't error out the current
>> command because the canceled one was still being run.
>>
>> Alternatively we could also just make the sleep uninterruptible, but because
>> this comes from the user triggering the bg op, I thought against it.
>
>I don't think that would solve the problem of how to detect when the
>driver is out of sync with the device and what to do to resolve that
>situation. An inopportune SIGTERM is indistinguishable from getting the
>polling interval wrong.

It at least removes one point of potential disambiguity. This out of sync
issue with timeouts was one of the reasons I originally proposed dealing
with all bg commands asynchronously (which doesn't prevent users from still
time-slicing). This approach is supposed to make the code simpler, but leaves
this mess. Currently we state:

	 * In the event of timeout, the mailbox state is
	 * indeterminate until the next successful command submission and the
	 * driver can get back in sync with the hardware state.

>
>>
>> >> +				return ret;
>>
>> rcuwait, unlike regular wait, returns -EINTR instead of -ERESTARTSYS. I've
>> updated the return value here to the latter.
>>
>> >> +		}
>> >> +
>> >> +		if (!cxl_mbox_background_complete(cxlds)) {
>> >> +			u64 md_status =
>> >> +				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>> >> +
>> >> +			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
>> >> +				    "background timeout");
>> >> +			return -ETIMEDOUT;
>> >> +		}
>> >> +
>> >> +		bg_status_reg = readq(cxlds->regs.mbox +
>> >> +				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>> >> +		mbox_cmd->return_code =
>> >> +			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
>> >> +				  bg_status_reg);
>> >> +		dev_dbg(dev,
>> >> +			"Mailbox background operation (0x%04x) completed\n",
>> >> +			mbox_cmd->opcode);
>> >> +	}
>> >> +
>> >>	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>> >>		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>> >>			cxl_mbox_cmd_rc2str(mbox_cmd));
>> >> @@ -271,6 +350,29 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>> >>	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>> >>		cxlds->payload_size);
>> >>
>> >> +	rcuwait_init(&cxlds->mbox_wait);
>> >> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
>> >> +		int irq, msgnum;
>> >> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> >> +
>> >> +		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>> >> +		irq = pci_irq_vector(pdev, msgnum);
>> >> +		if (irq < 0)
>> >> +			goto mbox_poll;
>> >> +
>> >> +		if (devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
>> >> +				     IRQF_SHARED, NULL, cxlds))
>> >
>> >This needs IRQF_ONESHOT and that @dev_id needs to be globally unique in
>> >case @irq is shared. So I think you want to factor out a common helper
>> >from cxl_event_req_irq() that this can reuse. I.e. cxl_event_req_irq()
>> >already gets the flags and @dev_id right, so just create a cxl_req_irq()
>> >that takes the irq as an argument and share it.
>>
>> For the oneshot this was a hardirq, so I don't think this is needed, but
>> regardless, I've added the following helper in a new patch which both
>> events and mbox can call:
>
>Ah, right, this was hard-irq only, I missed that.
>
>I wouldn't be opposed to cxl_request_irq() following pci_request_irq()'s
>lead and taking multiple handler arguments to skip the thread invocation
>when it is not needed.

Sure. I was fine with just doing everything in the BH, but allowing that
flexibility seems best.

>>
>> static int cxl_request_irq(struct cxl_dev_state *cxlds,
>>			  int irq, irq_handler_t handler)
>> {
>>         struct device *dev = cxlds->dev;
>>         struct cxl_dev_id *dev_id;
>>
>>         /* dev_id must be globally unique and must contain the cxlds */
>>         dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
>>         if (!dev_id)
>>	       return -ENOMEM;
>>         dev_id->cxlds = cxlds;
>>
>>         return devm_request_threaded_irq(dev, irq, NULL, handler,
>>					IRQF_SHARED | IRQF_ONESHOT, NULL,
>>					dev_id);
>> }
>>
>> >
>> >> +			goto mbox_poll;
>> >> +
>> >> +		/* only enable background cmd mbox irq support */
>> >> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
>> >> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>> >
>> >Just in case some other code ever enables doorbell interrupts it would
>> >be nice if this performed a read-modify-write rather than assuming it
>> >can clobber that setting.
>>
>> Hmm do you mean enabling/disabling dynamically?
>
>No, grep for:
>
>"write.*CTRL"
>
>...and observe that all writes to control registers are doing a
>read-modify-write sequence.

Oh, ok I get it.

>> Otherwise I would have
>> expected this to be a one time thing which we could just OR both bits.
>> Maybe this could be revisited when needed? Jonathan suggested enabling
>> doorbell irqs in the future, which I plan on looking into at some point.
>
>Sure, that code might be in another function also performing its own
>read-modify-write, so my comment just asking for this to be consistent
>with other control register updates in the driver.

Thanks for clarifying, I had not seen it like that - will definitely update
in the next version.

Thanks,
Davidlohr
