Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ABBC77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 21:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjDWV3H (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDWV3F (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 17:29:05 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CB2132
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 14:29:03 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8032B54153C;
        Sun, 23 Apr 2023 21:23:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a314.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E4DA254152A;
        Sun, 23 Apr 2023 21:23:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682285002; a=rsa-sha256;
        cv=none;
        b=2tkZVFIOg0m4BsJPouV2W1nEcMPsLTKXVqDvj459gBCRkPfbJzsy6eqikFU6EZjvX9oPgS
        q8Khcol6gy9TF4xHp6pNeBkyglrZQAbB6TTBiKMGeDXg1oKBrvi5u3j0ZhjpVYCVr/oUY8
        BMmy741HmryAUtkmAGohpiMTKsqxfaoRVWkpPbyWrxjUQ+zNjjgFG8V7BtvipkWxh5VjPh
        xUSDHsJlZYvUIVPFl1InnFYhauf36D33g+H/0FZN+0dPlIWjbft3xUJmro0HnQyLSXHyuF
        hDUR6wZigfwyD8Xi+bf7AKQsu7Dr95QQD0jvDHkiKozwi+6sBc/q3kowkXFLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682285002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ZjnZ4/I9l3dMI5oOIvrcWtzW3pvkmQdmVABixlE2yV8=;
        b=fa3r6BSfCqmuPZ+UHIaicaB1bAepCegHF2X8/tW5kPfz0TIHEZVRMl+w5FkF1gtt7BMJca
        aQPLQIYnM19rMX1RNOtFgs/hnq9r5RifqTEdPY6atdTv4U0o1+bkhiYNhXcmRnRGAOwFpi
        wVcCauZvv0Z9CXuSSy909yfvRfaq57WN801weIXUX8pFs5U9EZyNCRxj7I1o4K2I1jkJUG
        5WFJ40MkMo3ZK0/TlXEhLFk28M0ooPK/0ndgxhX1izuMOCHB3ftnWXELJ9tQZsNpHIlPe7
        SFtCktE+jPNUtt8+zXDNbFO3z80t0L16OS62AVlRP72egk6CMSgsLgs6YK8Tlg==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-7w52k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Versed-Illustrious: 3b526a9360582864_1682285002259_2958960843
X-MC-Loop-Signature: 1682285002259:821162052
X-MC-Ingress-Time: 1682285002259
Received: from pdx1-sub0-mail-a314.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.36 (trex/6.7.2);
        Sun, 23 Apr 2023 21:23:22 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a314.dreamhost.com (Postfix) with ESMTPSA id 4Q4Lpd0RMzzQm;
        Sun, 23 Apr 2023 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682285001;
        bh=ZjnZ4/I9l3dMI5oOIvrcWtzW3pvkmQdmVABixlE2yV8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JH8eB2wnjHVtwPcXhudZhVy/yhZT106JYKCPsdL/MxT+32rl4efeUi7aof+NK5nM8
         eovnXDyB6zMnfrY13Jub0F8OwLUudqlkOlxG9CVihikK/TNBFGNIkBpxUTzjwcczSy
         TXpJG0MFuPhLQW07V2KLxr9jXjmk22iWHhAtOmBj9bqTszLF9n2BoS5mmWTxw8LHSi
         +6aLF3uXlcqkEf0Q/RSw2Qn7ziRBGTRpRuFYQ7Ic6vgjlFtLa+PwWqzvBt9mpy+tzP
         X7rTKmLxGC4YgbRHtVshWeYB1+xC6L56tiM25EjL5Qps/iqmz1Bnb9XdBKpGUMNJDg
         A1LwKhVo+2ssA==
Date:   Sun, 23 Apr 2023 13:51:42 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Li, Ming" <ming4.li@intel.com>
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <mw5bsc5u72fdrgo7qovj6u2npg2asftzp3jeprwtmnvbvg7vet@fayzcxpurjl6>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
 <d9ba88f8-9cc1-44f8-6e92-cb46683de938@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d9ba88f8-9cc1-44f8-6e92-cb46683de938@intel.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 23 Apr 2023, Li, Ming wrote:

>On 4/21/2023 5:23 PM, Davidlohr Bueso wrote:
>> +static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>> +{
>> +	u64 reg;
>> +
>> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>> +	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
>> +}
>
>should using a MACRO to define '100' be better?

Given that an abstraction is already being provided, this feels like an
overkill. Plus pct == 100 is pretty self descriptive.

>> +
>> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>> +{
>> +	struct cxl_dev_state *cxlds = id;
>> +
>> +	/* spurious or raced with hw? */
>> +	if (!cxl_mbox_background_complete(cxlds)) {

While at it, this probably wants to be unlikely().

>> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +
>> +		dev_warn(&pdev->dev,
>> +			 "Mailbox background operation IRQ but incomplete\n");
>> +		goto done;
>> +	}
>> +
>> +	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
>> +	wake_up(&mbox_wait);
>> +done:
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  /**
>>   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>>   * @cxlds: The device state to communicate with.
>> @@ -178,7 +206,59 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>>	mbox_cmd->return_code =
>>		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>>
>> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
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
>> +		u64 bg_status_reg;
>> +		int i;
>> +
>> +		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>> +			mbox_cmd->opcode);
>> +
>> +		for (i = 0; i < mbox_cmd->poll_count; i++) {
>> +			int ret = wait_event_interruptible_timeout(
>> +				mbox_wait, cxl_mbox_background_complete(cxlds),
>> +				msecs_to_jiffies(mbox_cmd->poll_interval));
>> +			if (ret > 0)
>> +				break;
>> +
>> +			/* interrupted by a signal */
>> +			if (ret < 0)
>> +				return ret;
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
>> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
>> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {
>>		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>>			cxl_mbox_cmd_rc2str(mbox_cmd));
>>		return 0; /* completed but caller must check return_code */
>
>why does here only handle failure cases for non-background command? Maybe I missed something, I think that we need to do same thing here for background command.

Good point. Checking for background rc here is bogus and confusing because
this is a synchronous path and will never be true. I'll get rid of it, while
harmless it is semantically wrong. The same check is however necessary for
sanitation later in the cxl_internal_send_cmd() layer.

Thanks,
Davidlohr
