Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF6C352A1
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Dec 2022 16:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGQew (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Dec 2022 11:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLGQek (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Dec 2022 11:34:40 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B874908F
        for <linux-cxl@vger.kernel.org>; Wed,  7 Dec 2022 08:34:36 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 093406C20FE;
        Wed,  7 Dec 2022 16:34:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 555716C2282;
        Wed,  7 Dec 2022 16:34:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670430872; a=rsa-sha256;
        cv=none;
        b=7MlgoOo5JrD5QVvur5hUI3oTDGmFGyh+dELGxcL4DS9E7OF/PaqkHUP3B1XLqfvAC8Z8QD
        siPt2bG5BJ68dGQdtkr12ZsNUV8JNtIdQpa+9qbptMe0yXoDAdMijCgv662RMwZWFJrckB
        2/dD+rSgXXMdjAFGfoaOpI7KDe8F8sjji6vIfRWfZozi6q/tzP1uAnXGre+zBsjd8eiMfb
        LyB47L4MUpK+41o9MaF6jVVkG0fh/WrUir/hxFSY+vdtkNKaZYIRmh4nxK/kkcyS46UwEI
        qHJUYI8LpIlImUfaMZ5w+crWm1Z6oxphttvqSv7hVt8zWmx43bhlCGFxTl4NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670430872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=WMmJaCNtuI+rBqPSgyMuLdLztAEQFMhmcV0yiOzORVo=;
        b=vIjUBE1hvrhqh269LSvG9EMe7Svv9zXNyORLpxm3pIB69eIhUNKy+AeaEShR3kP5oB9GMu
        +9BBeMdjOIxT4Yd1ZmdL9+dIMAv4DYm+1qk+FtWzZXbwznazoJAIMp/CVAl3JKtvAbmjib
        xNkmZ3MNds9TUFrnSox/chAvll+rrc39XmTTuA/P2bMdHCfQ7ZRUplInlRdc024HFPD8lB
        +4JRx/1zHg+TCuz+SL0yDCtqZQqK7Gx9WdsG/VsUzPlTd5LL7ytFHd7Y5f7LO1GQ+8hS4G
        2GM9zMu7aZX+z2PxsRI+QmB0LmV4/IMJSjPKe0qrNJu3VN7JnZTqcSwKepyWyA==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-s7kkk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Vacuous: 0a57866f204f5e6b_1670430872752_2004793114
X-MC-Loop-Signature: 1670430872752:2566852802
X-MC-Ingress-Time: 1670430872752
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.15 (trex/6.7.1);
        Wed, 07 Dec 2022 16:34:32 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4NS2tZ68RSz1M;
        Wed,  7 Dec 2022 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670430871;
        bh=XmlPoz4NBQ7D6mxWzBOejg0acimR+uCn7/PE38m8sgM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=d7h9GmEK8UE8gmnYj5AtQITOEIo5PaQ3wSbT/oQ2EJ3uusxbX0KNbscfcJVf5xPOO
         F0UWw5UJN1x4LQoWo1kKZfLIhbH+6erStE608HJBc/nrpZW/c3QaW1w94zSqK/qgG+
         x7Q7DzYoveprQ+9NJnbv3HGsYWlssNcuvEHMe+NOlVFs/VWrtngDW/DThvpGTV9n9M
         4xRayTkYx4mWLpUP7r4IZ3AcwxbGW7oWbI1JTwz0kXq41mnEjoU7y+voV5FUvkvdvo
         c+NbCeW+IdL9Rwd111mK43B0LNDTcOLnOGkD2RMKOoczS6o8tGstUgApRKM+1wqaLh
         8fsbNXFO8IVNQ==
Date:   Wed, 7 Dec 2022 08:10:26 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <20221207161026.c2qpn4p7uplm5qkt@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 06 Dec 2022, Dan Williams wrote:

>One of the recent revelations with this patch:
>
>https://lore.kernel.org/linux-cxl/167030056464.4044561.11486507095384253833.stgit@dwillia2-xfh.jf.intel.com/
>
>...is that commands that are not meant to be called from userspace
>should simply never appear in CXL_CMDS nor cxl_mem_commands. The
>motivation for defining SCAN_MEDIA and friends was to use their
>definitions to block the RAW command passthrough, but ironically that
>enables the ioctl path which is also unwanted.
>
>So I think this patchset first needs to mark those uapi command numbers
>deprecated. Then ensure that all other background commands can not be
>submitted via the ioctl path.

Ok I will have a look.

>
>>	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>>	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
>>	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
>> @@ -145,6 +151,136 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>>	return cxl_command_names[c->info.id].name;
>>  }
>>
>> +static unsigned long __maybe_unused
>> +cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
>> +{
>> +	struct cxl_mem_command *c;
>> +	unsigned long ret = 0;
>> +
>> +	c = cxl_mem_find_command(opcode);
>
>Per that change above, cxl_mem_find_command() is only for the uapi.
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
>In general I worry that this is a bit too flexible. Instead of callback
>ops I think this wants to be straight line code with something like a
>poll_interval argument in 'struct cxl_mbox_cmd' where 0 means the
>command is immediate and non-zero is a number of jiffies between
>background operation polling intervals.

Are you refering _only_ to the delay callback being too flexible or the
the whole set of callbacks? If only delay, I don't like the idea of
having a poll_interval argument *and* a bgops structure with post and
conflicts callbacks. We could also move conflicts functionality to
another argument in cxl_mbox_cmd structure, but not delay functionality,
which makes consolidating everything in a callback structure nicer imo.

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
>Is a workqueue needed? If the goal is to make it so that all the kernel
>background command use cases chop up their work so that one command can
>not monopolize the mailbox for a long amount of time then the
>implementation can also assume that foreground commands that collide
>with an in-flight background operation can just wait synchronously for
>their time slice.
>
>That makes the handling simple, acquire lock, poll for completion,
>and everyone else just queues up on the lock.

I don't see how associating a lock to the bg op will make it simpler. I
happen to think that my approach is simpler than anything involving locking.
I'll explore getting rid of the wq in favor of per-device as suggested by
Dave, but fundamentally would be along the same lines.

If we really want to make things simple, than maybe just not supporting
polling would be better - I assume most devices will have irq support
anyway.

...

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
>Can't happen with the straight-line approach as all an interrupt will do
>is wake up a wait_event_timeout() instance for the currently executing
>background command.

I don't follow here. Upon mbox irq support, getting an irq will have have
the isr simply do a:

     cxl_mbox_bgcmd_post();
     put_device(cxlds->dev);
     cxl_mbox_bgcmd_done(cxlds);

     return IRQ_HANDLED;

... to terminate the bg command and no wakeup is needed. But polling won't
be able to do this hence the check above. Maybe I'm just missing your point.

Thanks,
Davidlohr
