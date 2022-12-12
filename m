Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E9C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Dec 2022 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiLLRjH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiLLRjE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Dec 2022 12:39:04 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F16402
        for <linux-cxl@vger.kernel.org>; Mon, 12 Dec 2022 09:39:02 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3343664073A;
        Mon, 12 Dec 2022 17:29:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 968246416D1;
        Mon, 12 Dec 2022 17:29:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670866169; a=rsa-sha256;
        cv=none;
        b=4isj0+763tqkdWxD9dTm2o3ZeKmLQB6LVSnA8GtgofTJBhWldvEWnkSxCVzRkL19B0+Ofn
        O8Xm0A46P6tzljzS3NXHbHLImLRMAxOWuX5mRFXm2GNJRzvEi7AhuPYDL/SUAkguTkKWSW
        u8a0n4+OiyDw5ZzLBJDDG07W44MZzjInOQxFSPI7jvvacY225N21jqSGV6e2c9YaIrkPxC
        o5GejJtpX/NKEGcX+LubiAP+8iEgAi1sQrOmu4oGVX4Dn42T6NRMczrmBmeerlbJXCB+23
        JDp6jwapdoV0Eh0BmL8EeswvWVdMGkRRjhmqTtB/ks2qsg2rmdIgah+Ze5sHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670866169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=DLer8p7z6XkcZBBersr+cUHup0WgeIzlmEWgBw+poP0=;
        b=GUkmPYNXGucL4t8XoBv9K4JDTeZuQedfLPSjmbWp176zR/Ldg/s5xnZ3wYR+Z0OIkA1jHF
        NSUfNtuLIYu338PdE9HY8uGqTRpOzkvhw8UTbaMIVFJXSXKyVXW4h9LQmXf0pjz65UFncU
        bOMhfPmAIXLrf+M1+cnhNL2xhhgdeq8nWNkDn5Gfr5tE+8QopMSyDh+iTPUQ3w17UINYco
        0CXI5+mo1gvwtfIDyJ4v8kCE0pMR+Fa4H/+xkelY1vKEtL9ZGF+/BJ2vGNNTSHSUYcb251
        kpqTe5wOzBdoYuk622RfXRuXI3kOCGxQZ/9tpROvL0X7EkZYZ5mEOXuXSA+h9Q==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-w5hfh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Industry: 4c86941f30c4d44b_1670866169889_3203382878
X-MC-Loop-Signature: 1670866169889:4282383029
X-MC-Ingress-Time: 1670866169889
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.16 (trex/6.7.1);
        Mon, 12 Dec 2022 17:29:29 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4NW7sh5McHz3d;
        Mon, 12 Dec 2022 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670866169;
        bh=DLer8p7z6XkcZBBersr+cUHup0WgeIzlmEWgBw+poP0=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=hM0ImLeAt3BR4J0IKMTX7JN3YwXFO26Myo7QR1Hp7218IyjuQv4+FR5O6Mtz1U4LE
         8nJYtxJyR/xECzQ9lTRZlYy1/f+zBlOUVYOhj+qFlxHQnyVdqAx8ruY0WageTR2KR/
         8jw855NHHPvIyZkIunOgPmY/UjCx5Zk11ftI+4f4/XREWE5Hn0/cyF6lBajfTq6MZu
         cXF/EUNofBBO76flw6xQzjCS2pSGAa7XrPwIU7+kZhWqTnnth1Q2rIjhd8kI1qnyJQ
         3KsV3/2/Upi/rgAzyt7L6Ld+N+DkE65c/LA9/IdPNHLVzO+EuWOZE7oCR+KnSOEUCw
         xQnIL0bsWbJkA==
Date:   Mon, 12 Dec 2022 09:05:07 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Message-ID: <20221212170507.qn5pegj6s6q3nto6@offworld>
References: <20221206011501.464916-1-dave@stgolabs.net>
 <20221206011501.464916-2-dave@stgolabs.net>
 <638ff285d426e_3cbe0294af@dwillia2-xfh.jf.intel.com.notmuch>
 <20221207161026.c2qpn4p7uplm5qkt@offworld>
 <639103c3b0853_3cbe02944d@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <639103c3b0853_3cbe02944d@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 07 Dec 2022, Dan Williams wrote:

>Hmm, I'm just not (yet) grokking how the callbacks or irq support
>simplify the implementation. Perhaps I can explain better in code...

So when I say that no polling at all makes the implementation simpler I'm
referring to the fact that only some form of ->post() would be needed (in
an async context of course). As such, most of the infrastructure in this
series is to support polling, and without it we could do away with the
other callbacks as well as the atomics. The hardware would take care
"synchronizing" everything - which is similar to what Jonathan had
highlighted in the rfc version and was wondering about the explicit
checks.

>I see irq support as a small incremental extension of polling support,
>not something that precludes polling support. For example (untested /
>unfinished):
>
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index 3a66aadb4df0..30b21ae4cbe5 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -178,6 +178,19 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_sta=
te *cxlds,
>        mbox_cmd->return_code =3D
>                FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>
>+       if (mbox_cmd->return_code =3D=3D CXL_MBOX_CMD_RC_BACKGROUND) {
>+               int i;
>+
>+               for (i =3D 0; i < mbox_cmd->poll_count; i++)
>+                       rc =3D wait_event_interruptible_timeout(
>+                               &mbox_wait, cxl_background_complete(cxlds),
>+                               mbox_cmd->poll_interval);
>+
>+               if (!cxl_background_complete(cxlds))
>+                       cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
>+                                   "background timeout");
>+       }
>+
>        if (mbox_cmd->return_code !=3D CXL_MBOX_CMD_RC_SUCCESS) {
>                dev_dbg(dev, "Mailbox operation had an error: %s\n",
>                        cxl_mbox_cmd_rc2str(mbox_cmd));
>
>...where all irq support adds is a small handler that does:
>
>    wake_up(&mbox_wait);
>    return IRQ_HANDLED;
>
>...to short-circuit the wait in __cxl_pci_mbox_send_cmd().

I agree that under this synchronous scheme polling and irq are quite
straightforward. I had always considered an async approach and not
playing with timeouts, but just let the whole thing run to completion.
I was also guided by the fact that the spec says:

"It is strongly recommended that devices continue to accept new non-
background commands while the background operation is running."

What I don't like about a synchronous approach is that you get the
situation where the driver timesout, but the hw is still doing the
background command, no? And there is no way to "cancel" it. Sure,
any new incoming mbox commands during that time would self-serialize
naturally by hw. But when the bg command is done and we have irqs enabled,
the isr will be triggered and we no longer have the context. You would
also have a discrepancy in a returned timeout error vs a different
return code from the actual hw, specially if for example the operation
was successful. afaict the only thing that would allow users to know
the real status of the sent bg command would be the Background Operation
Status command, but that is far from ideal.

>The cxl_internal_send_cmd() caller gets a synchronous response and can
>handle it from there. No need for conflict detection nor async execution
>contexts. Caller is responsible for making sure ->poll_count and
>->poll_interval are reasonable.

=2E..

>The complexity I see here is the synchronization needed to make sure
>that the isr is aligned with the current background command queued for
>execution and in turn synchronized with incoming commands. My
>observation is that current mailbox state synchronization is
>sufficient for:
>
>- Transfer FW: broken up into multiple transfers
>- Scan Media: broken up by Scan Media Physical Address Length values
>  that try to get the Estimated Scan Media Time below
>  CXL_MAILBOX_TIMEOUT_MS per iteration.
>- Sanitize: the device is effectively dead during this operation, so
>  there is little need to time-share

But tbh I find it much more intuitive to get an error then having to
block for who knows how long. Either way this would still require special
cases such as sanitize where the poller should not timeout. Of course
there is nothing in the approach from this series that prevents users
=66rom being mindful of the background command and breaking things up,
where possible.

Thanks,
Davidlohr
