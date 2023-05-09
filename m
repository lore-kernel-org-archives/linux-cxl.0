Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDFCC77B7C
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 15:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjEIPZC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjEIPZB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 11:25:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1D844BF
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 08:24:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64384274895so4285821b3a.2
        for <linux-cxl@vger.kernel.org>; Tue, 09 May 2023 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645897; x=1686237897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhv/anInD/+eHNMylLX7tViymCuVD4zqzVYkaDHoG8E=;
        b=OX4n0XS+zPrgpeUkeUYDhcD7uGudBKnxepmYKdzyk3GZy+rRo6uTzLvTFqAwVaFjaT
         CEIKg7lqkkwO8m+tg82q0u49Ah2Fm41KcbCwfAMDVdXFcr4xNNvcfU6I2DHxjBIJNgE3
         CPQI7HIG8TsUB6nVSu1N23vk+yp4AJANq5lyxGVrm9m//aoyrhMxhdaCn11KQs3A9/v3
         dk73rZ9zz4/YNNp+c3ApH8SjlCZJgdb/yf9NGYf0kYbb7IA/T+W31laYieNRTu+IJie/
         6To+rH4bSE+MErJ+bq+sm8rh6HmR+LpcrymbgxgfUcRoTztLeeNXd1VJpINKO84Peowr
         4qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645897; x=1686237897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhv/anInD/+eHNMylLX7tViymCuVD4zqzVYkaDHoG8E=;
        b=Vc+5UhQ3eOK16rSYdMPdAZk8K0PaeEDM6lw3gnmEzO0LhO44XwLg3vShe2PDvp5sU0
         CppLwlOKx3uKllPictgbU5eEWKuuwTinmcbZB2JXNGAsl0edmc0o0P3xDKfI7rmK8HWx
         bBpqbGhfOkeDysCxX5k5/uxdR/Wp6+aRBv+LrCdXibpoW52kbTUO7zBuRTHJbkGKPtYU
         Rxt8vSwNfG/fzSfQP2IIpMZ1oMBM6x/9Iia+jPpOQxWIAbk+Y0aS+qe3RkbasarCYmA/
         WnR/lF94PxVHx4ZPEsZ804vwGHg7ekAGgXmvGvK/TcH2X2CBMiHfn0k+BxEFi1q8AqCW
         BBdg==
X-Gm-Message-State: AC+VfDyqGKweZ85PHVsBCoZ83kHtKAKUtmnsAGwcCwgW5Vh6Ep97RA2X
        6cssbdybVOAjbFqePddv5PGzkasUVLQ=
X-Google-Smtp-Source: ACHHUZ43P8qZFo2/PVS5RGVoJgFKAVDU4EJBqELFbTlBc/dA/UsNDplL8j6RDfP5jyr5lYGZbd8M9Q==
X-Received: by 2002:a05:6a20:54a2:b0:100:8592:9a7f with SMTP id i34-20020a056a2054a200b0010085929a7fmr9309140pzk.45.1683645896856;
        Tue, 09 May 2023 08:24:56 -0700 (PDT)
Received: from localhost ([1.230.133.98])
        by smtp.gmail.com with ESMTPSA id 63-20020a630142000000b0051303d3e3c5sm1508556pgb.42.2023.05.09.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:24:56 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [ndctl PATCH 2/3] cxl: region: remove redundant func name from error
Date:   Wed, 10 May 2023 00:24:26 +0900
Message-Id: <20230509152427.6920-3-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509152427.6920-1-minwoo.im.dev@gmail.com>
References: <20230509152427.6920-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

If user does not provide `-s, --size` option and there's no ep_min_size
configured, it prints error log like the following.  This patch removes
redundant repeated function name from the log.

Before:

  root@vm:~/work# cxl create-region -m -d decoder0.0 -w 1 -g 1024 mem0
  cxl region: create_region: create_region: unable to determine region size
  cxl region: cmd_create_region: created 0 regions

After:
  root@vm:~/work# cxl create-region -m -d decoder0.0 -w 1 -g 1024 mem0
  cxl region: create_region: unable to determine region size
  cxl region: cmd_create_region: created 0 regions

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 cxl/region.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cxl/region.c b/cxl/region.c
index 07ce4a319fd0..71f152d9e5a5 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -607,7 +607,8 @@ static int create_region(struct cxl_ctx *ctx, int *count,
 	} else if (p->ep_min_size) {
 		size = p->ep_min_size * p->ways;
 	} else {
-		log_err(&rl, "%s: unable to determine region size\n", __func__);
+		log_err(&rl, "unable to determine region size\n");
+
 		return -ENXIO;
 	}
 	max_extent = cxl_decoder_get_max_available_extent(p->root_decoder);
-- 
2.34.1

