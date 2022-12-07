Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7767BC352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 04:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLGEGu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGEGt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 23:06:49 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A962454B34
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 20:06:48 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E9F807E15FD;
        Wed,  7 Dec 2022 04:06:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a247.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6C41F7E14A5;
        Wed,  7 Dec 2022 04:06:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670386007; a=rsa-sha256;
        cv=none;
        b=KyEf8GNqOXBRmDspgwv4b8VnEolP+7jJP28cBhSv6zBBUdxHQ9txzn6vkiLBTDE/dveLYb
        KMfRQTAkUdE/mhQIuR2EcNa5/s5YqScZeCaWHdWn866B1ogpQkfZUXtCjg/Xtd1hMt2R7F
        zY1kSZxxoSHvaKwO7VSqI4jkuj+II7ANxZ47rotaNuIzNC4UgfNOdCXql+RQR6YqNlz2BZ
        eK8DhXZUf7C3tyWGJjPUO9SDmxoBldj40y4cEUIvCxb5jKxRFmZ6wYfyqT1RHwyZuv5Wqa
        W36TQaiH1/h02sdjfL8E0ZDYd6oPfKljsNATzNiIex/1jtrYZjMgWYFtWe3xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670386007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=A6MeFSLh9Rqr32NR6wS2qHS/Qpeu5RGsSbmLq+mpePA=;
        b=LRFNRhoj/SIUyD0B+BaddWg5vSQxiUpS4KtekObfYOSs8lahGhimcKHl9cSdPZ1fW2G7PL
        gLjxje0x3eE8wjijEcj3WcrtJhdjg1ljP/JOl7gYp0nz1RjYk8cxOa3gTEdOMaFDw4Y6w/
        TrX02N/JW+TBGhOfxoaema5fDOp4KizFeXrqtpAXcbWK2CnAbQye0S0pvRFnci0bFs4/Hn
        USl4xJWZJghZ2C9Af+6Id05uBk6RMMk0erDs0p8jtT0NIMZDwKEhIxa5Y9MWA4TV3qBrc5
        9WqSX0Zteglty6NRRBjeqMhYi3VoqEYWyQgN2UKnkFS9EbylvFvJWyZ6maR1zw==
ARC-Authentication-Results: i=1;
        rspamd-85f95c7974-q9fq5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Shelf: 4066d069358ae34d_1670386007748_808245500
X-MC-Loop-Signature: 1670386007748:3980464448
X-MC-Ingress-Time: 1670386007748
Received: from pdx1-sub0-mail-a247.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.197 (trex/6.7.1);
        Wed, 07 Dec 2022 04:06:47 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a247.dreamhost.com (Postfix) with ESMTPSA id 4NRkHp5XHGz1H;
        Tue,  6 Dec 2022 20:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670386007;
        bh=NHqtUohHYqkKuUoFSMoDjyy2QiSOUGGoQOj3ylWFEpc=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=mmSdHInMQvt8raSfyIWh9llzHiI6WQLb73UK3ceMQ4m1NSeHos9QFvrW/MN+IMe+t
         is9K/56Ss9iMhX5TDejlpL/7njK6WwENG+QIySGnD/9oNrONSzeUGa4cZowq9oRqJ1
         F+1A24OVr/X8dEz2YHj0tFN2w1bRZhT8s1wv3kmsmckwPiS62aOAnetZK6VPXWQKL5
         scbLS9zcQwDfvZk99fh8MKirc0R9YCqeU2jhcxOGzd3LZy2PfS935yloSttQF5naa7
         i6eS37FMfpaaEvOJACqe7cT1bmj0V3xxPvi/9jHsuSH/xfxAizlqeqTn+9ZM/JMQPo
         SDjsfneFMlptA==
Date:   Tue, 6 Dec 2022 19:42:45 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <20221207034245.xv6ifcvtsocetncg@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <8bb484e2-490b-bb03-cfdd-e868797b1911@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8bb484e2-490b-bb03-cfdd-e868797b1911@intel.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 06 Dec 2022, Dave Jiang wrote:

>On 12/5/2022 6:14 PM, Davidlohr Bueso wrote:
>>+static struct workqueue_struct *cxl_mbox_bgpoll_wq;
>
>Do we want per device wq rather than a global one? Just thinking if
>you have a device go away and you need to flush outstanding commands,
>you might impact the other devices.

I'm not sure I completely follow here as the device is refcounted
so it doesn't go away while the op is in progress. But this actually
makes me think that the current usage is broken as nothing is actually
serializing access to queue on the cxl_mbox_bgpoll_wq. So two different
devices could be adding themselves concurrently.

And doing this per-device actually solves the above nicely, and no
queue is actually needed as self would always be the only one.

...

>>+/**
>>+ * struct cxl_mbox_bgcmd_ops - Optional ad-hoc handling of background cmds
>>+ * @post: Execute after the command completes
>>+ * @conflicts: How to handle a @new command when one is currently executing
>>+ *             (only for polling mode)
>>+ * @delay: Delay hint for polling on command completion
>>+ */
>>+struct cxl_mem_bgcommand_ops {
>>+	void (*post)(struct cxl_dev_state *cxlds, bool success);
>
>"post" here I think conveys different meaning than "after". Typically
>it is used in the context of issuing the command. To remove confusion,
>maybe call it "end_cmd" or "finish"?

Sure.

>
>
>>+	int (*conflicts)(u16 new);
>
>has_conflicts() may be better. Also, it can return a bool to indicate
>whether there are conflicts.

I'd rather have the callback return the error directly, which is why
it's an int.

>
>>+	unsigned long (*delay)(struct cxl_dev_state *cxlds);
>
>"poll_delay"?

Sure.

>
>>+};
>>+
>>  /**
>>   * struct cxl_mem_command - Driver representation of a memory device command
>>   * @info: Command information as it exists for the UAPI
>>   * @opcode: The actual bits used for the mailbox protocol
>>   * @flags: Set of flags effecting driver behavior.
>>+ * @bg_ops: Set of optional callbacks to handle commands that can run in
>>+ *          the background.
>>   *
>>   *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with this flag
>>   *    will be enabled by the driver regardless of what hardware may have
>>   *    advertised.
>>   *
>>+ *  * %CXL_CMD_FLAG_BACKGROUND: The command may execute asynchronously in the
>>+ *    background if the operation takes longer than ~2 seconds. The semantics
>>+ *    are:
>>+ *      - Only a single of these commands can run at a time.
>>+ *      - Depending on the nature of the operation, devices may continue to
>>+ *        accept new non-background commands.
>>+ *
>>   * The cxl_mem_command is the driver's internal representation of commands that
>>   * are supported by the driver. Some of these commands may not be supported by
>>   * the hardware. The driver will use @info to validate the fields passed in by
>>@@ -374,8 +422,10 @@ struct cxl_mem_command {
>>	struct cxl_command_info info;
>>	enum cxl_opcode opcode;
>>	u32 flags;
>>+	struct cxl_mem_bgcommand_ops __maybe_unused *bgops;
>>  #define CXL_CMD_FLAG_NONE 0
>>  #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
>>+#define CXL_CMD_FLAG_BACKGROUND BIT(1)
>>  };
>>  #define CXL_PMEM_SEC_STATE_USER_PASS_SET	0x01
>>@@ -414,7 +464,8 @@ enum {
>>  };
>>  int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>>-		      size_t in_size, void *out, size_t out_size);
>>+		      size_t in_size, void *out, size_t out_size,
>>+		      u16 *return_code);
>
>Given the existing commands don't care about return_code and only the
>new ones do, and to minimize code changes and having to chase down
>every call of the existing command, you can maybe do something like:
>
>int cxl_mbox_send_cmd_with_return(struct cxl_dev_state *cxlds,
>				  u16 opcode, void *in, size_t in_size,
>				  void *out, size_t out_size,
>				  u16 *return_code)
>{
>	.....
>}
>
>int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds,
>		      u16 opcode, void *in, size_t in_size,
>		      void *out, size_t out_size)
>{
>	return cxl_mbox_send_cmd_with_return(cxlds, opcode, in, in_size,
>					     out, out_size, NULL);
>}

I thought about this as Jonathan wasn't too fond of this either. But
considering Dan's recent rework of cxl_mbox_send_cmd() I have to redo
these and should be cleaner anyway.

Thanks,
Davidlohr
