Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4862EC352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLGPdb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLGPdW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 10:33:22 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E22C61B82
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670427200; x=1701963200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u1YRI4O1MMLpvUKIVb1Kp4GK/ZX9m/+IyiI+2MSKpbs=;
  b=EgKKY0KclUePg02m4IwPCe+3ckLt9bXFTmVZWOK8/fgOSKNBT28sBqJI
   46aCGZySgbONRRGOdAXfJ7g/voUmE7ouluCIwYDmRjaONUIcp8WLjaA/y
   0MYQgbyUNKaH1Ru/8dL/iS7nZnxXn2XhvUd76wCRDaB3U8uWSBQMPWl5a
   kZ2UpY7sXZ8b8P5HgBXA/VR4tl/cBnsBSC5WlkKj0+exj6G91Ji1Gbm3Z
   S3b5p6Qdsl4fGvyJ225r4E6S51WtBV2H8qYiifDVaoHl8lmSF+WiZtM6Q
   RAKzCVeP7TjCxXy2jX3M6ZKvcb2oWTC1KvFrLBhRgQy04SrcGZFos1drU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="296613343"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="296613343"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:33:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="648774210"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="648774210"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.93.88]) ([10.212.93.88])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:33:04 -0800
Message-ID: <984a25cf-f8b4-5d63-9a88-7ed7d4f49ba2@intel.com>
Date:   Wed, 7 Dec 2022 08:33:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     ira.weiny@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/6/2022 6:55 PM, Dan Williams wrote:
> Davidlohr Bueso wrote:
>> This adds support for handling background operations, as defined in
>> the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
>> can run asynchronously in the background, these are limited to:
>> transfer/activate firmware, scan media, sanitize (aka overwrite)
>> and VPPB bind/unbind.
>>
>> Completion of background operations, successful or not, can be handled
>> via irq or poll based. This patch deals only with polling, which
>> introduces some complexities as we need to handle the window in which
>> the original background command completed, then a new one is
>> successfully started before the poller wakes up and checks. This,
>> in theory, can occur any amount of times. One of the problems is
>> that previous states cannot be tracked as hw background status
>> registers always deal with the last command.
>>
>> So in order to keep hardware and the driver in sync, there can be
>> windows where the hardware is ready but the driver won't be, and
>> thus must serialize/handle it accordingly. While this polling cost
>> may not be ideal: 1) background commands are rare/limited and
>> 2) the extra busy time should be small compared to the overall
>> command duration and 3) devices that support mailbox interrupts
>> do not use this.
>>
>> The implementation extends struct cxl_mem_command to become aware
>> of background-capable commands in a generic fashion and presents
>> some interfaces:
>>
>> - Calls for bg operations, where each bg command can choose to implement
>>    whatever needed based on the nature of the operation. For example,
>>    while running, overwrite may only allow certain related commands to
>>    occur, while scan media does not have any such limitations.
>>    Delay times can also be different, for which ad-hoc hinting can
>>    be defined - for example, scan media could use some value based on
>>    GET_SCAN_MEDIA_CAPS and overwrite has predefined values based on
>>    pmem DSM specs[0]. Similarly some commands need to execute tasks
>>    once the command finishes, such as overwriting requires CPU flushing
>>    when successfully done. These are:
>>
>>    cxl_mbox_bgcmd_conflicts()
>>    cxl_mbox_bgcmd_delay()
>>    cxl_mbox_bgcmd_post()
>>
>> - cxl_mbox_send_cmd() is extended such that callers can distinguish,
>>    upon rc == 0, between completed and successfully started in the
>>    background.
>>
>> - cxl_mbox_bgcmd_running() will atomically tell which command is
>>    running in the background, if any. This allows easy querying
>>    functionality. Similarly, there are cxl_mbox_bgcmd_start() and
>>    cxl_mbox_bgcmd_done() to safely mark the in-flight operation.
>>    While x86 serializes atomics, care must be taken with arm64, for
>>    example, ensuring, minimally, release/acquire semantics.
>>
>> There are currently no supported commands.
>>
>> [0] https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>   drivers/cxl/core/core.h |   3 +-
>>   drivers/cxl/core/mbox.c | 213 ++++++++++++++++++++++++++++++++++++++--
>>   drivers/cxl/core/port.c |   1 +
>>   drivers/cxl/cxl.h       |   8 ++
>>   drivers/cxl/cxlmem.h    |  55 ++++++++++-
>>   drivers/cxl/pci.c       |   4 +
>>   drivers/cxl/pmem.c      |   5 +-
>>   drivers/cxl/security.c  |  13 +--
>>   8 files changed, 282 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 1d8f87be283f..2a71664a0668 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -69,6 +69,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>>   
>>   int cxl_memdev_init(void);
>>   void cxl_memdev_exit(void);
>> -void cxl_mbox_init(void);
>> +int cxl_mbox_init(void);
>> +void cxl_mbox_exit(void);
>>   
>>   #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 35dd889f1d3a..bfee9251c81c 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -10,6 +10,7 @@
>>   #include "core.h"
>>   
>>   static bool cxl_raw_allow_all;
>> +static struct workqueue_struct *cxl_mbox_bgpoll_wq;
>>   
>>   /**
>>    * DOC: cxl mbox
>> @@ -24,7 +25,7 @@ static bool cxl_raw_allow_all;
>>   	for ((cmd) = &cxl_mem_commands[0];                                     \
>>   	     ((cmd) - cxl_mem_commands) < ARRAY_SIZE(cxl_mem_commands); (cmd)++)
>>   
>> -#define CXL_CMD(_id, sin, sout, _flags)                                        \
>> +#define __CXL_CMD(_id, sin, sout, _flags, _bgops)                              \
>>   	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
>>   	.info =	{                                                              \
>>   			.id = CXL_MEM_COMMAND_ID_##_id,                        \
>> @@ -33,8 +34,13 @@ static bool cxl_raw_allow_all;
>>   		},                                                             \
>>   	.opcode = CXL_MBOX_OP_##_id,                                           \
>>   	.flags = _flags,                                                       \
>> +	.bgops = _bgops,						       \
>>   	}
>>   
>> +#define CXL_CMD(_id, sin, sout, _flags) __CXL_CMD(_id, sin, sout, _flags, NULL)
>> +#define CXL_BGCMD(_id, sin, sout, _flags, _bgops)                              \
>> +	__CXL_CMD(_id, sin, sout, _flags | CXL_CMD_FLAG_BACKGROUND, _bgops)
>> +
>>   #define CXL_VARIABLE_PAYLOAD	~0U
>>   /*
>>    * This table defines the supported mailbox commands for the driver. This table
>> @@ -63,7 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>>   	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
>>   	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
>>   	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>> -	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
>> +	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),
> 
> One of the recent revelations with this patch:
> 
> https://lore.kernel.org/linux-cxl/167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com/
> 
> ...is that commands that are not meant to be called from userspace
> should simply never appear in CXL_CMDS nor cxl_mem_commands. The
> motivation for defining SCAN_MEDIA and friends was to use their
> definitions to block the RAW command passthrough, but ironically that
> enables the ioctl path which is also unwanted.
> 
> So I think this patchset first needs to mark those uapi command numbers
> deprecated. Then ensure that all other background commands can not be
> submitted via the ioctl path.
> 
>>   	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>>   	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
>>   	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
>> @@ -145,6 +151,136 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>>   	return cxl_command_names[c->info.id].name;
>>   }
>>   
>> +static unsigned long __maybe_unused
>> +cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
>> +{
>> +	struct cxl_mem_command *c;
>> +	unsigned long ret = 0;
>> +
>> +	c = cxl_mem_find_command(opcode);
> 
> Per that change above, cxl_mem_find_command() is only for the uapi.
> 
>> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
>> +		dev_WARN_ONCE(cxlds->dev, true,
>> +			      "Not a background command\n");
>> +		return 0;
>> +	}
>> +
>> +	if (c->bgops && c->bgops->delay)
>> +		ret = c->bgops->delay(cxlds);
>> +
>> +	return ret * HZ;
>> +}
> 
> In general I worry that this is a bit too flexible. Instead of callback
> ops I think this wants to be straight line code with something like a
> poll_interval argument in 'struct cxl_mbox_cmd' where 0 means the
> command is immediate and non-zero is a number of jiffies between
> background operation polling intervals.
> 
>> +
>> +static void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds,
>> +				u16 opcode, bool success)
>> +{
>> +	struct cxl_mem_command *c;
>> +
>> +	c = cxl_mem_find_command(opcode);
>> +	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
>> +		dev_WARN_ONCE(cxlds->dev, true,
>> +			      "Not a background command\n");
>> +		return;
>> +	}
>> +
>> +	if (c->bgops && c->bgops->post)
>> +		c->bgops->post(cxlds, success);
>> +}
>> +
>> +/*
>> + * Ensure that ->mbox_send(@new) can run safely when a background
>> + * command is running. If so, returns zero, otherwise error.
>> + *
>> + * check 1. bg cmd running. If not running it is fine to
>> + *	    send any command. If one is running then there
>> + *	    may be restrictions.
>> + * check 2. @new incoming command is capable of running
>> + *          in the background. If there is an in-flight bg
>> + *          operation, all these are forbidden as we need
>> + *          to serialize when polling.
>> + * check 3. @new incoming command is not blacklisted by the
>> + *          current running command.
>> + */
>> +static int __maybe_unused
>> +cxl_mbox_check_cmd_bgcmd(struct cxl_dev_state *cxlds, u16 new)
>> +{
>> +	struct cxl_mem_command *c;
>> +
>> +	/* 1 */
>> +	if (likely(!cxl_mbox_bgcmd_running(cxlds)))
>> +		return 0;
>> +
>> +	c = cxl_mem_find_command(new);
>> +	if (!c)
>> +		return -EINVAL;
>> +
>> +	/* 2 */
>> +	if (c->flags & CXL_CMD_FLAG_BACKGROUND)
>> +		return -EBUSY;
>> +
>> +	/* 3 */
>> +	if (c->bgops && c->bgops->conflicts)
>> +		return c->bgops->conflicts(new);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Background operation polling mode.
>> + */
>> +void cxl_mbox_bgcmd_work(struct work_struct *work)
> 
> Is a workqueue needed? If the goal is to make it so that all the kernel
> background command use cases chop up their work so that one command can
> not monopolize the mailbox for a long amount of time then the
> implementation can also assume that foreground commands that collide
> with an in-flight background operation can just wait synchronously for
> their time slice.
> 
> That makes the handling simple, acquire lock, poll for completion,
> and everyone else just queues up on the lock.

Aren't certain commands valid while a background command is on going? 
Just thinking if you are doing a sanitize (overwrite), for a pmem it may 
take a LONG time. And maybe you don't want to block everything for the 
duration of that command completion? Maybe I'm not understanding what 
you are saying here.

DJ

> 
>> +{
>> +	struct cxl_dev_state *cxlds;
>> +	u64 bgcmd_status_reg;
>> +	u16 opcode;
>> +	u32 pct;
>> +
>> +	cxlds = container_of(work, struct cxl_dev_state, mbox_bgpoll.work);
>> +
>> +	dev_WARN_ONCE(cxlds->dev, !!cxlds->mbox_irq,
>> +		      "Polling mailbox when IRQs are supported\n");
>> +
>> +	bgcmd_status_reg = readq(cxlds->regs.mbox +
>> +				 CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK,
>> +			   bgcmd_status_reg);
>> +
>> +	pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, bgcmd_status_reg);
>> +	if (pct != 100) {
>> +		unsigned long hint;
>> +		u64 status_reg;
>> +
>> +		status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
>> +		if (!FIELD_GET(CXLDEV_MBOX_STATUS_BACKGROUND_OPERATION,
>> +			       status_reg))
>> +			dev_WARN(cxlds->dev,
>> +				 "No background operation running (%u%%).\n",
>> +				 pct);
>> +
>> +		hint = cxl_mbox_bgcmd_delay(cxlds, opcode);
>> +		if (hint == 0) {
>> +			/*
>> +			 * TODO: try to do better(?). pct is updated every
>> +			 * ~1 sec, maybe use a heurstic based on that.
>> +			 */
>> +			hint = 5 * HZ;
>> +		}
>> +
>> +		queue_delayed_work(cxl_mbox_bgpoll_wq,
>> +				   &cxlds->mbox_bgpoll, hint);
>> +	} else { /* bg operation completed */
>> +		u16 return_code;
>> +
>> +		return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
>> +					bgcmd_status_reg);
>> +		cxl_mbox_bgcmd_post(cxlds, opcode,
>> +				    return_code == CXL_MBOX_CMD_RC_SUCCESS);
>> +
>> +		put_device(cxlds->dev);
>> +		cxl_mbox_bgcmd_done(cxlds);
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_mbox_bgcmd_work, CXL);
>> +
>>   /**
>>    * cxl_mbox_send_cmd() - Send a mailbox command to a device.
>>    * @cxlds: The device data for the operation
>> @@ -153,6 +289,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>>    * @in_size: The length of the input payload
>>    * @out: Caller allocated buffer for the output.
>>    * @out_size: Expected size of output.
>> + * @return_code: (optional output) HW returned code.
>>    *
>>    * Context: Any context.
>>    * Return:
>> @@ -167,8 +304,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>>    * error. While this distinction can be useful for commands from userspace, the
>>    * kernel will only be able to use results when both are successful.
>>    */
>> -int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>> -		      size_t in_size, void *out, size_t out_size)
>> +int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode,
>> +		      void *in, size_t in_size,
>> +		      void *out, size_t out_size, u16 *return_code)
>>   {
>>   	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>>   	struct cxl_mbox_cmd mbox_cmd = {
>> @@ -183,12 +321,53 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>>   	if (in_size > cxlds->payload_size || out_size > cxlds->payload_size)
>>   		return -E2BIG;
>>   
>> +	/*
>> +	 * With bg polling this can overlap a scenario where the
>> +	 * hardware can receive new requests but the driver is
>> +	 * not ready. Handle accordingly.
>> +	 */
>> +	if (!cxlds->mbox_irq) {
>> +		rc = cxl_mbox_check_cmd_bgcmd(cxlds, opcode);
>> +		if (rc)
>> +			return rc;
>> +	}
> 
> Can't happen with the straight-line approach as all an interrupt will do
> is wake up a wait_event_timeout() instance for the currently executing
> background command.
> 
>> +
>>   	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
>> +	if (return_code)
>> +		*return_code = mbox_cmd.return_code;
>>   	if (rc)
>>   		return rc;
>>   
>> -	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
>> +	switch (mbox_cmd.return_code) {
>> +	case CXL_MBOX_CMD_RC_BACKGROUND:
>> +	{
>> +		int err;
>> +
>> +		dev_dbg(cxlds->dev, "Opcode 0x%04x: %s\n", opcode,
>> +			cxl_mbox_cmd_rc2str(&mbox_cmd));
>> +
>> +		err = cxl_mbox_bgcmd_begin(cxlds, opcode);
>> +		if (err) {
>> +			dev_WARN(cxlds->dev,
>> +				 "Corrupted background cmd (opcode 0x%04x)\n",
>> +				 err);
>> +			return -ENXIO;
>> +		}
>> +
>> +		get_device(cxlds->dev);
>> +
>> +		if (!cxlds->mbox_irq) {
>> +			/* do first poll check asap before using any hinting */
>> +			queue_delayed_work(cxl_mbox_bgpoll_wq,
>> +					   &cxlds->mbox_bgpoll, 0);
>> +		}
>> +		break;
>> +	}
>> +	case CXL_MBOX_CMD_RC_SUCCESS:
>> +		break;
>> +	default:
>>   		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
>> +	}
>>   
>>   	/*
>>   	 * Variable sized commands can't be validated and so it's up to the
>> @@ -575,7 +754,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
>>   		int rc;
>>   
>>   		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
>> -				       out, xfer_size);
>> +				       out, xfer_size, NULL);
> 
> In the above referenced patch I fixed up cxl_internal_send_cmd() to
> derive all its parameters from a passed in 'struct cxl_mbox_cmd', that
> should make it easier to add new parameters.
> 
> I'll stop here until we can come to consensus on how general this
> solution needs to be. I think this really wants to have a single
> background command use case in mind to answer some of the use case case
> questions.
