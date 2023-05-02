Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C04C77B7E
	for <linux-cxl@archiver.kernel.org>; Tue,  2 May 2023 17:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjEBRvB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 May 2023 13:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBRvA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 May 2023 13:51:00 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7CA10C7
        for <linux-cxl@vger.kernel.org>; Tue,  2 May 2023 10:50:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 728EE6422AE;
        Tue,  2 May 2023 17:50:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 884D6641906;
        Tue,  2 May 2023 17:50:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683049856; a=rsa-sha256;
        cv=none;
        b=ElYf6NLjwIofLpJsddBAkuAarC5RY3QlOPGKjEn/GF95rk10kAw/Mm6M7OPbYptypXqT9T
        2ek1Xa5ifAZrnr/9uueBJO7vs5uYMGlxb0qXx1WIyQSLrmS3TWRzbjp6wwOvjvU25i3TI5
        m8ouTb7gQYcJ885LsyfIFT9NdtL/IWriK/k6GRwsVlopBT4frkVwM+kgiQ3RQVng9nQJGN
        9Wq+PBWWekuJgAbSiHlGVM5UiEKg66sIL0m4eEMtgLNQ6nBSBHXU1d1tQo3firmzr2hFIN
        MJH4HIo1mtiqkE20WeseZFdZYMqz084X7/qhZEvc3Ys8h+FvSHY+01nYpZ4vXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683049856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=rkM6ONnw6r/7864JoUeIxYJLqOn3E8BmKoHAsmM4ywg=;
        b=lsiWaN2JPe47HkgagBHfALNLsj+OsdhjHkZ83O3qcD5XwedICXOHZcM4Skiemowm9djIEg
        WWEnIgQHfzDSWNi6/IXMJ4bA3siMJUmSasuCSHgt7iIlZ7GmAbLlwRKheJaUFIj5MNXCYL
        CTX2gkDcm7NXL/5d21iA7EdUDHbSmUpLOHMZvP82HWB329S1m+pv4Zca+7fSCG+aJVGTvj
        v11OTPdKqJn+RS9mM242ezgzteWGrC/6dQa0Ezjuq52iG7BJr5O/6Lgs3j+hFz6XeHWtv9
        vxO4kPqEUW6Sxol6u0hwJIwKSM/0m9vOvTe3xzChnUCm4+nid7jWO6l0rfhkhw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-v5ksg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Absorbed: 168f589937216298_1683049857174_3289117841
X-MC-Loop-Signature: 1683049857174:1305190389
X-MC-Ingress-Time: 1683049857174
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.243.54 (trex/6.7.2);
        Tue, 02 May 2023 17:50:57 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Q9ngM4styz31;
        Tue,  2 May 2023 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683049856;
        bh=rkM6ONnw6r/7864JoUeIxYJLqOn3E8BmKoHAsmM4ywg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=RO0tkkSPGZqzgwWXKRSs1MiyLcEw3tFXjyAhwp/d0CszbP2C8JyCPx7Y98WZ2wrNT
         tb+nuaAO8kNbQD7n2KlqMU5xGQySr7iattK9wRY4x7/3YIvfPnPxyQxzq5eWejfb8C
         5yqGAMQ5a5p5Jd7LjX0r09RknBkwtV2cJnn5bJzqGSjQOvMcVLn/jpVXMCkTHpHuGx
         pm3fmtpMDziYncGcajJH9M/3HPTm0jO0zLolYGnFLwo0bH2geCe+gPqMrsCXaec6WY
         l9slHETZzvG0b5uJUVrVJFk7JFXQM+uYrX5qz+h70cgSdUuqT/OKvf0dQ9DyvQZT76
         VN4XO7LyNoeOA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, peterz@infradead.org, mingo@redhat.com
Subject: [PATCH 1/3] rcuwait: Support timeouts
Date:   Tue,  2 May 2023 10:18:39 -0700
Message-Id: <20230502171841.21317-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502171841.21317-1-dave@stgolabs.net>
References: <20230502171841.21317-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Introduce rcuwait_wait_event_timeout(), with semantics equivalent
to calls for the simple and regular waitqueue counterparts.

Cc: peterz@infradead.org
Cc: mingo@redhat.com
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Only cc'ing sched folks this patch to avoid spamming. fyi the actual user
comes up in patch 3 (cxl/mbox: Add background cmd handling machinery),
but found a few other potential users in various drivers, so more could
be added.

 include/linux/rcuwait.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 8052d34da782..27343424225c 100644
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
+						     state, timeout);	\
+	__ret;								\
+})
+
 #endif /* _LINUX_RCUWAIT_H_ */
-- 
2.40.1

