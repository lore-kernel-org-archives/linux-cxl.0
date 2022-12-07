Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D85C4708E
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 15:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLGP0K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLGP0K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 10:26:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314160350
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 07:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670426769; x=1701962769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G2bUPvibNo9LMbyaOTE8+mx1knvpw4AOfssJmPRHncs=;
  b=WpXjvLKHuTdSgK9ga2IyeVQBo4Lii2yQMxBnSij1uS3+Oo99fbIgJO00
   2uBnJ1OHjW3Hb6Ga2pigoxbXahvxZQ5htqw9XevZAbP8jYiigJJFi6mO5
   yfbOEDG5WAgDqOuC9lDdK9/SGlj+US1qdk5vnPB3IrGTsPhvn2AbZ+/De
   50JBQGHJkBUSQlWJvtPLaUpqMdh1eZPSfBhLpbfNN0HZdocIpcr+zMCBR
   DF5uC1A2ERg8B41uDgngMjwF3yKBvKqCY+CU5XgU7ymikFt9QsEuhBKQN
   vn1MQt7zdRXyJsZzTkz2IJ5YFQhQtvP8Tdzbet3scdnIB1ZBP9yNWFaYQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="403186050"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="403186050"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:26:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="679167794"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="679167794"
Received: from ssislam-mobl1.amr.corp.intel.com (HELO [10.212.93.88]) ([10.212.93.88])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 07:26:07 -0800
Message-ID: <87058fa5-faf5-a336-0928-ef7d9c688371@intel.com>
Date:   Wed, 7 Dec 2022 08:26:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <8bb484e2-490b-bb03-cfdd-e868797b1911@intel.com>
 <20221207034245.xv6ifcvtsocetncg@offworld>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221207034245.xv6ifcvtsocetncg@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/6/2022 8:42 PM, Davidlohr Bueso wrote:
> On Tue, 06 Dec 2022, Dave Jiang wrote:
> 
>> On 12/5/2022 6:14 PM, Davidlohr Bueso wrote:
>>> +static struct workqueue_struct *cxl_mbox_bgpoll_wq;
>>
>> Do we want per device wq rather than a global one? Just thinking if
>> you have a device go away and you need to flush outstanding commands,
>> you might impact the other devices.
> 
> I'm not sure I completely follow here as the device is refcounted
> so it doesn't go away while the op is in progress. But this actually

i.e. somebody unbind the driver to a device for whatever reason.

DJ

> makes me think that the current usage is broken as nothing is actually
> serializing access to queue on the cxl_mbox_bgpoll_wq. So two different
> devices could be adding themselves concurrently.
> 
> And doing this per-device actually solves the above nicely, and no
> queue is actually needed as self would always be the only one.
> 
> ...
> 
>>> +/**
>>> + * struct cxl_mbox_bgcmd_ops - Optional ad-hoc handling of 
>>> background cmds
>>> + * @post: Execute after the command completes
>>> + * @conflicts: How to handle a @new command when one is currently 
>>> executing
>>> + *             (only for polling mode)
>>> + * @delay: Delay hint for polling on command completion
>>> + */
>>> +struct cxl_mem_bgcommand_ops {
>>> +    void (*post)(struct cxl_dev_state *cxlds, bool success);
>>
>> "post" here I think conveys different meaning than "after". Typically
>> it is used in the context of issuing the command. To remove confusion,
>> maybe call it "end_cmd" or "finish"?
> 
> Sure.
> 
>>
>>
>>> +    int (*conflicts)(u16 new);
>>
>> has_conflicts() may be better. Also, it can return a bool to indicate
>> whether there are conflicts.
> 
> I'd rather have the callback return the error directly, which is why
> it's an int.
> 
>>
>>> +    unsigned long (*delay)(struct cxl_dev_state *cxlds);
>>
>> "poll_delay"?
> 
> Sure.
> 
>>
>>> +};
>>> +
>>>  /**
>>>   * struct cxl_mem_command - Driver representation of a memory device 
>>> command
>>>   * @info: Command information as it exists for the UAPI
>>>   * @opcode: The actual bits used for the mailbox protocol
>>>   * @flags: Set of flags effecting driver behavior.
>>> + * @bg_ops: Set of optional callbacks to handle commands that can 
>>> run in
>>> + *          the background.
>>>   *
>>>   *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with 
>>> this flag
>>>   *    will be enabled by the driver regardless of what hardware may 
>>> have
>>>   *    advertised.
>>>   *
>>> + *  * %CXL_CMD_FLAG_BACKGROUND: The command may execute 
>>> asynchronously in the
>>> + *    background if the operation takes longer than ~2 seconds. The 
>>> semantics
>>> + *    are:
>>> + *      - Only a single of these commands can run at a time.
>>> + *      - Depending on the nature of the operation, devices may 
>>> continue to
>>> + *        accept new non-background commands.
>>> + *
>>>   * The cxl_mem_command is the driver's internal representation of 
>>> commands that
>>>   * are supported by the driver. Some of these commands may not be 
>>> supported by
>>>   * the hardware. The driver will use @info to validate the fields 
>>> passed in by
>>> @@ -374,8 +422,10 @@ struct cxl_mem_command {
>>>     struct cxl_command_info info;
>>>     enum cxl_opcode opcode;
>>>     u32 flags;
>>> +    struct cxl_mem_bgcommand_ops __maybe_unused *bgops;
>>>  #define CXL_CMD_FLAG_NONE 0
>>>  #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
>>> +#define CXL_CMD_FLAG_BACKGROUND BIT(1)
>>>  };
>>>  #define CXL_PMEM_SEC_STATE_USER_PASS_SET    0x01
>>> @@ -414,7 +464,8 @@ enum {
>>>  };
>>>  int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void 
>>> *in,
>>> -              size_t in_size, void *out, size_t out_size);
>>> +              size_t in_size, void *out, size_t out_size,
>>> +              u16 *return_code);
>>
>> Given the existing commands don't care about return_code and only the
>> new ones do, and to minimize code changes and having to chase down
>> every call of the existing command, you can maybe do something like:
>>
>> int cxl_mbox_send_cmd_with_return(struct cxl_dev_state *cxlds,
>>                   u16 opcode, void *in, size_t in_size,
>>                   void *out, size_t out_size,
>>                   u16 *return_code)
>> {
>>     .....
>> }
>>
>> int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds,
>>               u16 opcode, void *in, size_t in_size,
>>               void *out, size_t out_size)
>> {
>>     return cxl_mbox_send_cmd_with_return(cxlds, opcode, in, in_size,
>>                          out, out_size, NULL);
>> }
> 
> I thought about this as Jonathan wasn't too fond of this either. But
> considering Dan's recent rework of cxl_mbox_send_cmd() I have to redo
> these and should be cleaner anyway.
> 
> Thanks,
> Davidlohr
