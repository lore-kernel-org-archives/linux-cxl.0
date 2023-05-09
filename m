Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE084C77B7C
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjEIPie (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjEIPid (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 11:38:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FD7468E
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 08:38:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643a6f993a7so3287772b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 09 May 2023 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646711; x=1686238711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qLtWNSBnTDLgJRHJFMJMddl94+PpA/rKujXlbX5tD4=;
        b=a5Pz2heqvKom283Cgu9VNHJm9jE+vA4WybG22n6wlib9RKnR67zQg1+3shqCGYPDtp
         JjZyYpVS3J/nPR2BK4S1nsgd6jfQnmn1+Jv1bySGfmZOGu06H4YBcwJ3bgTXraJjz7B7
         S5Tzra+zije0c1rDwXgTzPLa48IxPglCIJuRaTQNDxk0yzuqctNIOiQIP3p19J6tW32Q
         w0AneqxOzdSDispYf1SwJ6nraFqH+uKdPkVI9Cv564cY6Y5DWZpWzcTHvjvIuyrgdktB
         4dZhmdtTeOHt3qpFSPCAkCz6JIga+x5OPsZuuHDOEPooBVR7/bVKuBZq5n3kpl0ZmpY1
         9BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646711; x=1686238711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qLtWNSBnTDLgJRHJFMJMddl94+PpA/rKujXlbX5tD4=;
        b=HyAaYayut+CZz/VoXbkgzM3V1J5gTm9Q+dycVVYxuk0IuYMH9Fdn1+mXCf0sevnzQ/
         ZCYoKgaYlBDK5nDFePbKZ5uDXpUQVAm8F3bOpDR550V66T7JEPdMqDEnxUqyRwR96c9G
         Cb7vjklXxSkPxvlxTE9vjS/Zj8cEUPNb5sTgRkrwb9fEEmI1dP2gStJxVMu2I9mic4Le
         MmXv1N+asj3RbuRzgK+8oDVzu9Epf90jY8AU0F2woenK0mYfrP0rNSfXuJZtLcEKFE80
         z0Shwu4ylZZomPQGYBU9KpHXejWx1cgogmu/nnZyNLBYlvIz/7snRXEEyvPzPAIddlRs
         8u1g==
X-Gm-Message-State: AC+VfDz3xyrtk9mn4AY/VjksexJvVqU8Ts18thf7qTJ2pwOLWl44C1My
        zTokcftKm611+LY5HMxxIcTAcy8gmCE=
X-Google-Smtp-Source: ACHHUZ57VywwqQeV0KB1umI5vY39hcwUBcsNqNIF67huSHqG7J/t48JKVeBBzi+irB6Idg0hWDGjNw==
X-Received: by 2002:a05:6a20:914a:b0:f2:c2a3:39a with SMTP id x10-20020a056a20914a00b000f2c2a3039amr19170734pzc.61.1683646711449;
        Tue, 09 May 2023 08:38:31 -0700 (PDT)
Received: from localhost ([1.230.133.98])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b0064399be15f0sm1895785pff.183.2023.05.09.08.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:38:30 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] cxl/region: Fix typo in region comment in RAM mode
Date:   Wed, 10 May 2023 00:38:21 +0900
Message-Id: <20230509153821.7740-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

s/manged/managed

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f822de44bee0..d5832a1d1da3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2871,7 +2871,7 @@ static int cxl_region_probe(struct device *dev)
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_DECODER_RAM:
 		/*
-		 * The region can not be manged by CXL if any portion of
+		 * The region can not be managed by CXL if any portion of
 		 * it is already online as 'System RAM'
 		 */
 		if (walk_iomem_res_desc(IORES_DESC_NONE,
-- 
2.34.1

