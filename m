Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1DC77B61
	for <linux-cxl@archiver.kernel.org>; Mon,  1 May 2023 16:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjEAQg7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 May 2023 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQg6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 May 2023 12:36:58 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1810E58
        for <linux-cxl@vger.kernel.org>; Mon,  1 May 2023 09:36:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DB1F36413A8;
        Mon,  1 May 2023 16:28:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4CBA1641583;
        Mon,  1 May 2023 16:28:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682958538; a=rsa-sha256;
        cv=none;
        b=vUV6jxRW0NzTBPoWFtNCUjVVdt6zdmVxNbFdZ6FvB2s17ewHjaIoMeTi8zgRNIO7IdOYRJ
        ImytewHqA01neuOYyMa8pnXMLckpyKMM74kR2et/vzrPpZ9IhhAuksUX/0L3X2BPbtdude
        9c4GrBFJpPxERKiBDkYxW++3GutfzGs4JIIeHVQQ9A/50u1WrfUKyr5nEIntdY39rC41nE
        +Nrf/gRvvbh86LTWtrv9+Baw2IDZCGWXTlkBk/h07yYiFwmxFEV2tqt7YtKTzrVyMYUn1r
        dd0K0fmzq8G6UxHtWCCm0LLYtCYWjqnGxTkLumcQoe3Jsjzoxh4+OdgIPigEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682958538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=9W/fSZAl/qND435yGSuDvV0dd9JMqGRe1EN3C+0TO8c=;
        b=d5y28rMo8kXK1gUMrDuEPXg9YPhCToAdcQQ6Fr3fnqTW7lNMp0TTD1tiLwQ2lFfogzxtt8
        d9fwM1oDYKJAoi725FKP2lgL+qtexjzBhKrVzWB6vGlvDArMLkFYOHuZJ8dBmwJb6yMHLx
        9AibLoqBUAkfv4LN06PQSop5T+/MzVEYcakI38zm4sPun+Fdp02Evqhui45blGigarfhCf
        8K5A8HoDTbI2xxKpzZ4qqhJOwIovKZKyqYfIonXjMuyHw3FTwl0ly3vZfy/y3oxXFgPoN1
        q0Hf8cxpAe7VkJHzjngbCsQspDBxsS6iZ11Ji660IMNJr9PYvVz+ktbVFkB03A==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-7xf2w;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Spot: 328d2f30508a222f_1682958538614_3703042581
X-MC-Loop-Signature: 1682958538614:2270985919
X-MC-Ingress-Time: 1682958538614
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.52 (trex/6.7.2);
        Mon, 01 May 2023 16:28:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4Q97vF3gCjz3D;
        Mon,  1 May 2023 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682958538;
        bh=9W/fSZAl/qND435yGSuDvV0dd9JMqGRe1EN3C+0TO8c=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=NUF6lLM1UsfSNVzJ5XSmk65GtGQpJCq5sYGHOHcrUY5chVG/WDz3Xfl6PxqM1h7sj
         cOrXtVpG1l9fjT+vfgCU7ktrfDNqpCPA76jZlj5NnKyC92+ktHCSo+fxhDldKPPhZ0
         TsW8xDOqeMYREQI3QhTGKQnIhgrtvB6ceIXNUxnn+7ocqq80EyCFnnLMwHcUQQ83kU
         n74mOYolkMsowixUVqMgGx6ehCU0AgjxuIMRwyktmESbyDx90Uq1l6C7zEr4N59cbb
         TTLNpQUYms6+0gD+biVUO/zyEnnY6pkKarzF5ytrBLrbEKGjHNET0R1HX/w0sUEGnC
         7IKdAQx9wmGdw==
Date:   Mon, 1 May 2023 08:56:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Message-ID: <2vnt6otwqs5fy6z3ddalisugeptlndh5wmhrlwzjbnlea2gpwc@ce4t3m43pibj>
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-3-dave@stgolabs.net>
 <cb80b111-c639-aaff-f8dd-8ceacf124b1a@intel.com>
 <lq33scjudy22a7xpa7vrefhfk6uolzy6wvq4wimwvwg4emeo53@aa6n2n5up3gh>
 <c649c0f9-b6ef-d391-143c-eed3c6b5df11@intel.com>
 <mjpl5a3r4oviwl4b6oz7fjwcq3zcgvizxlru3jch62eqoprkdh@6xolbj3he5lz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <mjpl5a3r4oviwl4b6oz7fjwcq3zcgvizxlru3jch62eqoprkdh@6xolbj3he5lz>
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Apr 2023, Davidlohr Bueso wrote:

>On Fri, 28 Apr 2023, Dave Jiang wrote:
>
>>On 4/28/23 10:18 AM, Davidlohr Bueso wrote:
>>>On Fri, 28 Apr 2023, Dave Jiang wrote:
>>>
>>>>>+static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
>>>>
>>>>I apologize if I've asked this before and you've already answered.
>>>>What is the reason the mbox_wait a module global wq instead of a per
>>>>device wq? Just thinking when you tear down a device, you may want to
>>>>wake all pending for that device to clean up.
>>>
>>>Yes, I agree that doing the wait per-device is better, and not only
>>>for tear down reasons. By doing it globally, the queue reflects waits
>>>from different devices, but the driver really has no control about
>>>the order of the wait of each device is, so upon a blind wake_up(),
>>>it could perfectly well be that the first node in the waitq is not
>>>the node for that device.
>>>
>>>This all goes away with per-device, with the note that because of the
>>>mbox_mutex there never will only ever be a single waiter, so no concept
>>>of a queue really.
>>
>>If there's only a single waiter then I think a 'completion' can be
>>used instead right?
>
>Well completions still use (simple) wq underneath. What we really
>want is rcuwait semantics but there is currently no support for
>schedule timeouts. INTERRUPTIBLE sleep was added for new users in
>the past, so it could be doable.

Something like this, but I guess we could use completions for now and
convert to rcuwait later if we don't want to have to depend on sched
bits for this patch - and I'm sure there are a few other users out there
abusing queued wait for similar semantics that could make use of it.


diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 8052d34da782..9e4759de228b 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -49,9 +49,9 @@ static inline void prepare_to_rcuwait(struct rcuwait *w)

  extern void finish_rcuwait(struct rcuwait *w);

-#define rcuwait_wait_event(w, condition, state)				\
+#define ___rcuwait_wait_event(w, condition, state, ret, cmd)		\
  ({									\
-	int __ret = 0;							\
+	long __ret = ret;						\
	prepare_to_rcuwait(w);						\
	for (;;) {							\
		/*							\
@@ -67,10 +67,27 @@ extern void finish_rcuwait(struct rcuwait *w);
			break;						\
		}							\
									\
-		schedule();						\
+		cmd;							\
	}								\
	finish_rcuwait(w);						\
	__ret;								\
  })

+#define rcuwait_wait_event(w, condition, state)				\
+	___rcuwait_wait_event(w, condition, state, 0, schedule())
+
+#define __rcuwait_wait_event_timeout(w, condition, state, timeout)	\
+	___rcuwait_wait_event(w, ___wait_cond_timeout(condition),	\
+			      state, timeout,				\
+			      __ret = schedule_timeout(__ret))
+
+#define rcuwait_wait_event_timeout(w, condition, state, timeout)	\
+({									\
+	long __ret = timeout;						\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __rcuwait_wait_event_timeout(w, condition,	\
+						     timeout);		\
+	__ret;								\
+})
+
  #endif /* _LINUX_RCUWAIT_H_ */
