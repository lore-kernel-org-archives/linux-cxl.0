Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4457C77B60
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 22:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjD1WgO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346568AbjD1WgN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 18:36:13 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF65265
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 15:35:47 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 57EA91021EE;
        Fri, 28 Apr 2023 22:35:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a277.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C451B10072A;
        Fri, 28 Apr 2023 22:35:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682721335; a=rsa-sha256;
        cv=none;
        b=TaYLC43BKQr0kZw22hf7Qc9rvEknw5NTjma3P1J3f+5+WXbIa+P03WWMP3KAzI/s0UU/Q3
        sfj7KHTd6ntlmH6OD4mAA5t1Qjbm8Kygg7J7M6mEX17xca4RkqIsENnrVgKegjjJtVqe/a
        2dL8ek+N58PbPFHOwB/pGreWSL0/tlVqBUoQTlT63+2oGZ2wwG7SCAdcOKMnmaHTHrt1Bo
        yK5gAA3G8m66SqzX1eUxNvW8bKIGJVCgdoCJ0ZoWO5iRKPpRGnlhSMPEmufZrMl5hplvhT
        C8g7tiz5PG6STJ9Gm+XeEgR1WzC+Gkca7Pmi5mxJmiSb18mhue9V+zhQuacwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682721335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=UM9W2AtEUdLuej4FZnKc8vWJdKxaf0Om+tU1GUr57tk=;
        b=GJzLwbw/nX06+M30/edBn0DhfQ51re1f3HPHYQ0B0wj7dCDrh5mTRfekK4UQa/HawPhE8r
        wnvYZ7SLjMqITyIlZ6efI+6Z3a5dU6aOTuTDvRvmpt+jH4iM7T3vdRRas5ENxYnXFPVe8u
        5E8/qNN0tDt4dPRpjGy2urIhVV3NZl0wh2dL5/LngOb5TcZcqPDCMXXO/Gi+8GJHh6ktFy
        WRjftiZ1nfCbIeeDXevm6voP7StN5TYtA+tQmJag6QyyQV/InJSglii/TmI/rLIfhhtiKQ
        sUe2tBhEBA3j+/RnxYCeHoTS0laME0lZeAjn3cE0WrwZtyW6Zyreo77c+ASY1Q==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zn4rt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Lettuce: 2a7c204118cea5e2_1682721336110_3303174519
X-MC-Loop-Signature: 1682721336110:2383286208
X-MC-Ingress-Time: 1682721336109
Received: from pdx1-sub0-mail-a277.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.8.80 (trex/6.7.2);
        Fri, 28 Apr 2023 22:35:36 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a277.dreamhost.com (Postfix) with ESMTPSA id 4Q7S9g0NdszB1;
        Fri, 28 Apr 2023 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682721335;
        bh=UM9W2AtEUdLuej4FZnKc8vWJdKxaf0Om+tU1GUr57tk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=bkFGXUyKU7WBzGhQfg/sEAPNaKKHy8+fCndNrCAmlLfr2bmQBRbkBMeyXJ+/oqd//
         Ae3Pq8eGjaFjDUxTt1+crFQgH90lLXuv1HU77dlhW6/mN1s0cAi54Nd25cr2LCIrFp
         +O9YmTJwx0G2CvQ9rGJFLDpwnFRU5OtacEWG9UyPNLOOxjVT5w8gi+4j4qrZfe7zvX
         4HRbX8RYDo08+hSVAlkDFAnSbOlbHdpK8bCarwE6rXgWqjzmXIwBdw5T5v4FExudOV
         y/GHJpJf9YqZwJbiHKbdti616UF6ZDgMh1SixslTdfeRs9GlB8KsR/pqBIxScrMc3I
         BwXmv1bPytZqw==
Date:   Fri, 28 Apr 2023 15:03:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <mjpl5a3r4oviwl4b6oz7fjwcq3zcgvizxlru3jch62eqoprkdh@6xolbj3he5lz>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
 <cb80b111-c639-aaff-f8dd-8ceacf124b1a@intel.com>
 <lq33scjudy22a7xpa7vrefhfk6uolzy6wvq4wimwvwg4emeo53@aa6n2n5up3gh>
 <c649c0f9-b6ef-d391-143c-eed3c6b5df11@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c649c0f9-b6ef-d391-143c-eed3c6b5df11@intel.com>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Apr 2023, Dave Jiang wrote:

>On 4/28/23 10:18 AM, Davidlohr Bueso wrote:
>>On Fri, 28 Apr 2023, Dave Jiang wrote:
>>
>>>>+static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
>>>
>>>I apologize if I've asked this before and you've already answered.
>>>What is the reason the mbox_wait a module global wq instead of a per
>>>device wq? Just thinking when you tear down a device, you may want to
>>>wake all pending for that device to clean up.
>>
>>Yes, I agree that doing the wait per-device is better, and not only
>>for tear down reasons. By doing it globally, the queue reflects waits
>>from different devices, but the driver really has no control about
>>the order of the wait of each device is, so upon a blind wake_up(),
>>it could perfectly well be that the first node in the waitq is not
>>the node for that device.
>>
>>This all goes away with per-device, with the note that because of the
>>mbox_mutex there never will only ever be a single waiter, so no concept
>>of a queue really.
>
>If there's only a single waiter then I think a 'completion' can be
>used instead right?

Well completions still use (simple) wq underneath. What we really
want is rcuwait semantics but there is currently no support for
schedule timeouts. INTERRUPTIBLE sleep was added for new users in
the past, so it could be doable.

Thanks,
Davidlohr
