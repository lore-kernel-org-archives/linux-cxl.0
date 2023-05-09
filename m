Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A0EC7EE22
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 15:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjEIPZJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjEIPZG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 11:25:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C32A49D6
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 08:25:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaea43def7so41472915ad.2
        for <linux-cxl@vger.kernel.org>; Tue, 09 May 2023 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645900; x=1686237900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX3aP/5DthuPCekKZDcqCd6crocwyObcAs1lRnioK90=;
        b=F5MUoBUE5u7DgsnADrU5ePszG0mAePgoJ0z1HVnRECMkTIO8vxBhxasZ7uC203/mk0
         eJophLn+d41ivCp0VZ0mekoyPYXrbfTTw98yEMc/534O0JJlQW4gNfsE2q4oYoZHeU82
         +2gmUQeRDsxRBLXFtwlhKorwSPaPybs0rsGVaurZlbo9H+KL3sNzcScM65Zr2IuOgu7q
         L5w5GctN9NyaN9IIvUfAOZ1Gf6kxwm8QP9Ddpp+yUlANGtmtA/CWkpEKGfbaZbym5WJD
         t1nP/ZL8eIMtxsK5qCXOl9MkFjSQcRp/lHvOC4Bmfna6HzMjLdiQP0vtMJlrgzALUYZM
         r7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645900; x=1686237900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX3aP/5DthuPCekKZDcqCd6crocwyObcAs1lRnioK90=;
        b=eEg8FjWtLJGxW8KU5548Dl5pC/abKnSU18iCIS/V1d729ujXFXL5Br75tQnUeHmOKB
         Zic8fOOLFa9Y6eDK7hUxdFwhQGemLnVnXMlIh5BuQSo4L6ZK+orgAeNkSjbdFGL3iUzz
         StTc9Q1FohJtx8c+ap4ZdhBBZo17+5EnscFHIEkWYzjJ0zW5jaaEoIy3ziFQ/5HT215v
         wsAGr2RMhgpiPJMGGnLo5q58qKHQlegggR3TnDhO1Da11KTbKMlZRj3877a0VmzK+3iZ
         zlfVFzxDa8Q558maa7yFeQgPV/2CSGucxKQwORFzleSj+Xo9s8Dr4UDNHRo7TTf4i4Wc
         MR8g==
X-Gm-Message-State: AC+VfDzpBwCLMq+W7au3GPzC/uVNfJ3HEEFui0GbKIRvCoNu/O7QNfq8
        F0CA5O1zrn8T6leVTrXSplHdlrSk7KQ=
X-Google-Smtp-Source: ACHHUZ7qgn7AWYXmlGL/WnKq4Wk7cwfgJorb5hF6+xT0HWc/i8XXrOIez/uRh4nQJe7Z+IERMa3vbA==
X-Received: by 2002:a17:903:2308:b0:19d:778:ff5 with SMTP id d8-20020a170903230800b0019d07780ff5mr18797505plh.15.1683645900506;
        Tue, 09 May 2023 08:25:00 -0700 (PDT)
Received: from localhost ([1.230.133.98])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001aaeaa27dd5sm1697344plt.252.2023.05.09.08.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:25:00 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [ndctl PATCH 3/3] cxl: fix changed function name in a comment
Date:   Wed, 10 May 2023 00:24:27 +0900
Message-Id: <20230509152427.6920-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509152427.6920-1-minwoo.im.dev@gmail.com>
References: <20230509152427.6920-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_memdev_target_find_decoder() has been renamed to
cxl_memdev_find_decoder in Commit 21b089025178 ("cxl: add a
'create-region' command").  Fix function name in a comment.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 cxl/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/region.c b/cxl/region.c
index 71f152d9e5a5..45f0c6a3771c 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -676,7 +676,7 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 		}
 		if (cxl_decoder_get_mode(ep_decoder) != p->mode) {
 			/*
-			 * The memdev_target_find_decoder() helper returns a free
+			 * The cxl_memdev_find_decoder() helper returns a free
 			 * decoder whose size has been checked for 0.
 			 * Thus it is safe to change the mode here if needed.
 			 */
-- 
2.34.1

