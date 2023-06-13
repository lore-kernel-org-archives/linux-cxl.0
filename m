Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6BDEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjFMRAM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjFMRAM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 13:00:12 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BF183
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 10:00:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 44B0B821EBA;
        Tue, 13 Jun 2023 17:00:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9430F821F10;
        Tue, 13 Jun 2023 17:00:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686675607; a=rsa-sha256;
        cv=none;
        b=2AuXMHUnYwf62IdicqW8LDseTCzn4J0nTqLQguoShKOaznlx5LDPdF2/rXlVunamw+yj0D
        3UqmaCDulcOG/8OgeCCnA/7nKnrd5H0DL8yye7iyoGTB3meLq448rqyDahVFYxOIpErKZX
        hVN/RsQO/HAPKHC8yADBl95Yevcdvegvz7x9AhqvQB4rAHw7C5LJRbc/Lf7nn5psPr+vAs
        uZSEtSR3TMPGVi3hd6WlBZlOk0D8igq1exgxUJovL/KSicjc4CP4V+Bfs3a4Cc6Q+clIpI
        qxkiqILmo8t2ESrAeGvEO57RG1Ly2GJetigK70SX2ucd7A1rD8rzEVNkHg+J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686675607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=8Bm107Ie6pJimA73G95z602Z25qq9VjrRGir+xYBolk=;
        b=jDa+Ynr6isP5ZOlqhAkPi0gWm5CnLbPaVue48rTykPBrpAEO6qsIbYnT1YkY0bzGXmQKwA
        OvzHUJUASFcwEXIRV0ROm8SRz2N17lUwNH6zughJNIB4jtfzWx9sLSkW48FpyymUwGHB0V
        fOPXs+6MGQe2NO3RWZPpHL/sNoTrslB+EbKv6lzGaYkePxdZOX2YVM5wX8YyCua1Z3ziC7
        UNyazsQpj4uxkbwY8ZJHK6n1nZQPdDZDYgU8zXsikNa54mcOXWNlccdcGpgC4FA4Cl1m/m
        uMSgPnsn+TIGY/n5aV/hOi0WNjAWwnGYjKGCvXKihR3YteMpJz299mb7qeiZrQ==
ARC-Authentication-Results: i=1;
        rspamd-7c78575475-w6j5z;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Chief: 01b10eaa4687c73c_1686675609048_2792494970
X-MC-Loop-Signature: 1686675609048:1187536267
X-MC-Ingress-Time: 1686675609048
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.252.234 (trex/6.9.1);
        Tue, 13 Jun 2023 17:00:09 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4QgZYL6lkFz4g;
        Tue, 13 Jun 2023 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686675607;
        bh=8Bm107Ie6pJimA73G95z602Z25qq9VjrRGir+xYBolk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ptMcN4oZgz1xpfIKYCJlYqlZjCvRuFf+JfZVXKbBM9a5c+ViNuAK+PpIk8WGJbX0S
         3PmUSFwNGn3FSZC43dZrFq5DBxss7X0vwYiVp00tN8QLjFhxGjtakfwg35461H4RV1
         yuZhN6cLxm448SHrQ0/R962yoTi0tgDfiwkx8rH2ZYNnScF5n0wOb0yGIo28RGbs1r
         YIz9ho53ccxakpRnlFfrOFDe7wbnY63Sv9BWjE8Vhj6HKiU2eiJCVoC/Rtk6L8DB4d
         q115NShv2BQLeWvRaOV8NnylzN1zhiPBgkZu2xXoxmzeB5LjIGEUriQZyDrJS7VW3V
         yAsX33j8T5HQA==
Date:   Tue, 13 Jun 2023 09:25:21 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 0/7] cxl: Support device sanitation
Message-ID: <ispowzuk5fg2u7zbpenocvyihh4t3kywtszcbg245unypzduex@jenknfy62rjl>
References: <20230612181038.14421-1-dave@stgolabs.net>
 <20230613162611.00007b0b@Huawei.com>
 <20230613165130.00006259@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230613165130.00006259@huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 13 Jun 2023, Jonathan Cameron wrote:

>On Tue, 13 Jun 2023 16:26:11 +0100
>Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
>> Hi Davidlohr,
>>
>> > Testing.
>> > ========
>> >
>> > o There are the mock device tests for Sanitize and Secure Erase.
>> >
>> > o The latest (v2) qemu bg/sanitize support series is posted here:
>> >	https://lore.kernel.org/linux-cxl/20230418172337.19207-1-dave@stgolabs.net/
>>
>> That doesn't seem to have support for reading back the security state so
>> the stuff this set adds fails before it gets going.
>> Am I missing another series?

Correct, when testing I simply comment out the security state call in cxl_mem_sanitize().

>>
>I hacked in enough to get things to carry on...
>
>Following might be something I've broken locally but on basis
>it might not...  Note my QEMU is odd right now as I'm in middle
>of a big refactor of the CCI handling, but this should still not happen
>even if I happen to have broken QEMU side of things in some weird way.
>
>My base is more or less mainline + background set as queued on CXL
>tree plus this set.
>
>However similar traces to below happen when I poke a 1 into
>sanitize
>
> This appears to be:
>
>        WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
>then
>        WARN_ON_ONCE(!list_empty(&work->entry));
>
>triggering.
>

Oh apologies, my bad. I actually should have tested this last iteration :/

But with the below I replicated the testing without anything falling out
(also with polling).

I'll wait a bit to see if Dan has any other comments regarding the series
before sending in another iteration - otherwise maybe this could be folded
in to avoid more email overhead?

Thanks,
Davidlohr

----8<-------
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d1df23c19245..008e1c267ce2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -288,12 +288,12 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
		int i, timeout;

		/*
-+		 * Sanitation is a special case which monopolizes the device
+		 * Sanitation is a special case which monopolizes the device
		 * and cannot be timesliced. Handle asynchronously instead,
		 * and allow userspace to poll(2) for completion.
		 */
		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-			if (cxlds->security.poll_tmo_secs != -1) {
+			if (cxlds->security.poll) {
				/* hold the device throughout */
				get_device(cxlds->dev);
