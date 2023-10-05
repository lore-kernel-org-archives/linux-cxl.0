Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F2FE92705
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Oct 2023 14:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjJEOih (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjJEOgQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Oct 2023 10:36:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E240F81
        for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 06:58:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3248ac76acbso925801f8f.1
        for <linux-cxl@vger.kernel.org>; Thu, 05 Oct 2023 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696514331; x=1697119131; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wn6Em+o0gkIpmb/ObfPSgCvA3m73Mu1ZDj4fK+nToG4=;
        b=myUhvOYUMD9mCSNtAfme9GJ7ioBDJQvjDoYy06CCw0iCYUpFdNc5Y3zLpDk96JPCI1
         1sgSkhKqiEtXM9PzVHzscew6aDo6G/qmohduHzYiqpKJISoQTeS65Ss3rriJ+T0FTWtf
         nLmDJb3k3GQ40h/XFru4IkFMa7ytdvp3mKiS/V5Zn9MeXJmzdDAiAlUzefUsjBnVfkaa
         Xz+aWmbQjK4G7M1mTKjt6IFQqh6qE1ZhSwE2DMkRJB8MR0yQvP7zziUo2i/Jy5MiNcey
         jp0dqgNXXv9TSS4R7f6mCFc9HxCphTz8CIaqFSXCckBD1GLdmRPHJ5QKFvvhUeg0Pzg2
         iZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514331; x=1697119131;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn6Em+o0gkIpmb/ObfPSgCvA3m73Mu1ZDj4fK+nToG4=;
        b=BBXi8iGDb6Kb68q5++BDRTTLxl4FL2ZEHv6Tm6hgKD5KQyR9eSzbfOqmK01M1O0cXZ
         ERp2K4Fn8yehWkbvTHyN5L4gtiXxdmyR831h11mCoybgjAGOIdftaBXExnE9k3t9+aU7
         NhGpzG2fTusWqo4GApX6VCiKvT4op4TMR5s1wwMuWDKLSdVjQUjv06pnG3iUbosbipc4
         HqBEhQf91ewCHTG69RRReZTf3YiYNxjA6VeVKwZNSZwVspvvuBrDk3Vn1ujq74Xbqhnc
         8ljEaTyfb2dn70EvRvNErO+DQJ81AjyCqTQJ6wZYRSfRJ6dyFGYcA6WqA8US7j4l8SQW
         VB4w==
X-Gm-Message-State: AOJu0YwTsuBOam97QA+vjm27Thdp2ryr6k1SXGa7rarplFpYHl5AjvlR
        DFJUEw+eGHzSMPB9sgN1z0wHYw==
X-Google-Smtp-Source: AGHT+IEm8BURx2Ll1byyK8uUf5yHWTqN0Cz1KB7q4EUDkoypWK0U6H3oDODp3tRIwZmxWiHDt38ZpA==
X-Received: by 2002:adf:e406:0:b0:31a:e6c2:7705 with SMTP id g6-20020adfe406000000b0031ae6c27705mr4615866wrm.50.1696514331718;
        Thu, 05 Oct 2023 06:58:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v11-20020adfedcb000000b0031fd849e797sm1845899wro.105.2023.10.05.06.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:58:51 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:58:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] dax: remove unnecessary check
Message-ID: <554b10f3-dbd5-46a2-8d98-9b3ecaf9465a@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

We know that "rc" is zero so there is no need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1d818401103b..ea7298d8da99 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1300,7 +1300,7 @@ static ssize_t memmap_on_memory_store(struct device *dev,
 	dev_dax->memmap_on_memory = val;
 
 	device_unlock(dax_region->dev);
-	return rc == 0 ? len : rc;
+	return len;
 }
 static DEVICE_ATTR_RW(memmap_on_memory);
 
-- 
2.39.2

