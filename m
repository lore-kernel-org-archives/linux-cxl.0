Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04732C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 16:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbjEKQhG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbjEKQhF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 12:37:05 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8AC3AA7
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 09:37:03 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5F5427E2169;
        Thu, 11 May 2023 16:37:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a268.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D1A857E1D07;
        Thu, 11 May 2023 16:37:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683823021; a=rsa-sha256;
        cv=none;
        b=iMJzitp+eMPKG3i5TIJlCO+ZtJkfqmCjiwUCaO4fKKdUfc6EhLIapJjS7oM1I0jqeTerry
        qTNW0kbE7MsCnWqmvvLoBYBaq+S76cDWW2p9UFRV3zZGjczdxYgObKlHUHsayJnf3GBFFq
        N541yUDjOJYZ2pbp5HWTLSRPQpz4vhrZUP/Kfwd8UKbrn6M3/zSEvPKng5Oi7hkPqL/tx2
        lyiFgokBU/dsTG8gzt4hr9yxa4iUzcifdZkJhSVFnU9AC+kwyaZO4UpBOG2CMTe0lIuX8T
        sdgNcY0tyBtYSFtvP2qGxGnezmDdY2LIeIQsoDl45lu6EEoCY0GseLUvJjTIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683823021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QtgMBMUrEcyKjsp0MhsUJLi2A0FNGbP8DtYFx7TDzY0=;
        b=AvZcOvtCs97lh3HYXU+U3efzi6nStd7Ia6tOhN23KjFANI9ATlhg8lyOzCqVvd2SA/Yq2a
        zbYBKMw3IEXuy2JooYHYkK0/3i+RvFHqvOKxPc91+HESt/Ypc5/uEZwy6pQiF1S8PsvnG5
        X2HiOsye5xf8JONYnPQEctZ74Edc3dbdM93/JZxMdDD3n8aHi6WGD+m597zklWAL1TeQmA
        aAslAkWjWBzhc0YFNCb+21UWtDxpqR4PEvyopQ/5VK4XuzFrqR32kWX+0u4XP8rVLoci3H
        PlRW0KOCnNKHgKiCrstJ0HmK3a3cwrFVJzu3/MqpYaGmJUy24ok4KrYxQHyTCQ==
ARC-Authentication-Results: i=1;
        rspamd-79bb5575d7-hsvs4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Arithmetic: 246c772d6d417d34_1683823021227_2646306620
X-MC-Loop-Signature: 1683823021226:2242277949
X-MC-Ingress-Time: 1683823021226
Received: from pdx1-sub0-mail-a268.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.246 (trex/6.8.1);
        Thu, 11 May 2023 16:37:01 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a268.dreamhost.com (Postfix) with ESMTPSA id 4QHHbv4yK3z3J;
        Thu, 11 May 2023 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683823020;
        bh=miaFtS5eAIu9J/pA4IYstN7Wwi2idYXh06csDLUvp2M=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=cP2U89pPKGA+7cCwAdDdrc/WRx3CKNZza3SoAOlKPRpfjJOYIrkPS/ag1195PVH1W
         zu4vAa+iYR2pw7Y4UGVbyJpqivwhEdabj3awAebtn01hiMAURsBYs3h38ha8743teL
         hM0kOt0eQWHC74o+gupcWhDAvuD1HeEPu778+zAhsOwkrZuaUSJqc2lQt1apiG3ghf
         ipey99A05zXgKPRmD72z+CvbuRCFl4uSiH5kJe4LRyNkiNiDXpToZmvtqf1W6cShrU
         REsa4jzMJoMoQr2eSqZEdX3GBUVOOwRD2v73xK3s7nQZ6Ho5BZbszCQ9N0F2+7elCD
         3EKY+FDxwugUg==
Date:   Thu, 11 May 2023 09:04:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <yfcfwpnbag3jd3zhpafdxlzy4rabxf3e2l6l6ldearkwtx36gk@jbvjy5bnfl53>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
 <20230511152330.00001eac@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230511152330.00001eac@Huawei.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023, Jonathan Cameron wrote:

>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 044a92d9813e..72731a896f58 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -176,14 +176,21 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
>> +#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
>> +#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
>
>Numeric order of bits probably makes more sense. So move this up one line.

Sure.

>
>>  #define CXLDEV_MBOX_CTRL_OFFSET 0x04
>>  #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
>> +#define   CXLDEV_MBOX_CTRL_BG_CMD_IRQ BIT(2)
>>  #define CXLDEV_MBOX_CMD_OFFSET 0x08
>>  #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
>>  #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
>>  #define CXLDEV_MBOX_STATUS_OFFSET 0x10
>> +#define   CXLDEV_MBOX_STATUS_BG_CMD BIT(0)
>
>Hmm. Oddly field is called Background Operation.  Still that is then
>described as a command so I guess this is a reasonable bit of consolidation
>of naming.

Yes, I've found that the spec loosely mixes both terms.

>
>>  #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
>>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
>> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
>
>Obviously there are line length disadvantages to includes the status part
>in the field names and there isn't a BG_CMD_COMMAND register thankfully
>but I still find the absence of status a bit inconsistent / confusing.
>initial instinct is this a field called OP_CODE in a register called
>BG_CMD_COMMAND
>
>> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
>> +#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
>
>It might be nice to to do 'something' with the Vendor Specific extended
>status even if it is just put it in a dev_dbg() for anyone who cares?

I had previously considered something like that, I'll add it in the
next iteration.

>
>>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>>
>>  /*
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 090acebba4fa..8c3302fc7738 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -108,6 +108,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>>   *            variable sized output commands, it tells the exact number of bytes
>>   *            written.
>>   * @min_out: (input) internal command output payload size validation
>> + * @poll_count: (input)  Number of timeouts to attempt.
>> + * @poll_interval: (input) Number of ms between mailbox background command
>> + *                 polling intervals timeouts.
>
>name it poll_interval_ms: and the units become obvious everywhere without needing
>comments.  Good for the lazy / forgetful reviewer if nothing else...

Makes sense.

>
>>   * @return_code: (output) Error code returned from hardware.
>>   *
>>   * This is the primary mechanism used to send commands to the hardware.
>> @@ -123,6 +126,8 @@ struct cxl_mbox_cmd {
>>	size_t size_in;
>>	size_t size_out;
>>	size_t min_out;
>> +	int poll_count;
>> +	int poll_interval;
>>	u16 return_code;
>>  };
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 39b829a29f6c..aa1bb74a52a1 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -51,6 +51,7 @@
>>  static unsigned short mbox_ready_timeout = 60;
>>  module_param(mbox_ready_timeout, ushort, 0644);
>>  MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
>> +static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
>
>I see in discussion you are moving to a per device approach so I won't review
>that bit on this version.

Right, fyi the latest vesion is here:

https://lore.kernel.org/linux-cxl/gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn/

...
>> +static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>> +{
>> +	struct cxl_dev_state *cxlds = id;
>> +
>> +	/* spurious or raced with hw? */
>
>If talking about a race, I'd like a comment that gives more info.
>What is the potential hardware race?
>
>I can sort of see polling might have noticed completed command and
>launched another one, all before the interrupt actually got handled.
>If that's what you were thinking then eat the interrupt without the
>scary message.

Yes that's the raced with hw motivation, and the warning below can provide
insightful debug info. That said, for spurious irqs (which the kernel/core
considers this a reality, so yeah we should not be printing any message.

I'll get rid of it.

>
>> +	if (!cxl_mbox_background_complete(cxlds)) {
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
>
>We already have an rc floating around in here.  Having ret as well with more limited
>scope isn't great for readability.  I think you can just use rc here.

I was thinking the same, I can rename it 'wait_ret' (it also ends up being a long in
the latest version).

>
>> +				mbox_wait, cxl_mbox_background_complete(cxlds),
>> +				msecs_to_jiffies(mbox_cmd->poll_interval));
>> +			if (ret > 0)
>> +				break;
>> +
>I'd drop this blank line to keep all the handling of ret in one block of code.
>It looks a bit too separate to me otherwise.
>
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
>
>Why are we interested in the memory device status at this point? A timeout on background
>command isn't really a cxl_cmd_err() in my head at least.

Will revisit.

>
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
>
>Here is where I'd like to also log the vendor specific extended status.

ok

>
>> +	}
>> +
>> +	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
>> +	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {
>
>You overrode the original return code with the background command return code. So if you get
>here and it's still RC_BACKGROUND I think something went wrong.

Yes, Ming had previously brought this up and is addressed in the last version.

>
>>		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>>			cxl_mbox_cmd_rc2str(mbox_cmd));
>>		return 0; /* completed but caller must check return_code */
>> @@ -224,6 +304,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>>	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>>	unsigned long timeout;
>>	u64 md_status;
>> +	int rc, irq;
>>
>>	timeout = jiffies + mbox_ready_timeout * HZ;
>>	do {
>> @@ -272,6 +353,27 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>>	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
>>		cxlds->payload_size);
>>
>> +	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
>> +		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +
>> +		irq = pci_irq_vector(pdev,
>> +			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
>> +		if (irq < 0)
>> +			goto mbox_poll;
>> +
>> +		rc = devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
>> +				      IRQF_SHARED, "mailbox", cxlds);
>> +		if (rc)
>> +			goto mbox_poll;
>
>Hmm. The old argument of whether to carry on when something unexpected happens.

Well yes and no. The reason I am very tolerant upon errors here is that the
background cmd polling will be done regardless of the device's interrupt
capability. So I find it way too harsh to just fail the probe altogether
when effectively no harm is done.

>I'd argue in this case at least and possibly the one above we should fail
>hard as we really want to know if interrupt allocations are failing, not just
>fall back quietly to polling.  I'd rather fail to probe the driver in a fashion
>that lets us figure out what broke.
>
>> +
>> +		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
>> +		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>> +
>> +		return 0;
>> +	}
>> +
>> +mbox_poll:
>> +	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>>	return 0;
>>  }
>>

Thanks for reviewing!
