Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C90C43217
	for <linux-cxl@archiver.kernel.org>; Mon, 28 Nov 2022 15:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiK1PCU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiK1PCU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Nov 2022 10:02:20 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F2122521
        for <linux-cxl@vger.kernel.org>; Mon, 28 Nov 2022 07:02:19 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id jn7so10387912plb.13
        for <linux-cxl@vger.kernel.org>; Mon, 28 Nov 2022 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hD3JWskx463z8JLKarnN8tJtF+i70g6BGCNjkOyahI=;
        b=aXYnzYSZrLZKItaqQyR5woQt+TE7/y0NZh4x/MgPSW90slZ2gnJHnS5PbBUeuCuHR6
         cEahuQcB+M7aHUWsx1M3m50JSTWiM9jyLEoJUasYexM/SocLWfL18BdjjPyfD/Shy1bJ
         PYG7f5XSh4OAldtXFcZMOmUKma/RRRyU5QlKypoqnohBlFCTBbsEYwoJ7cl8Bdaxrpm7
         U1Be+gDNPXUp0Ii086rhLwghEFWv6qruQJFarQAP6tl8TvPc2QKQSvU8tQw00QRnhTIM
         Xw408bD6f9cewGXf3/GN3mVFfUAwCqrUXhqruIQjDGIcu2Mw2Z/cZPSTWscp6HVZDG3t
         Ki9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hD3JWskx463z8JLKarnN8tJtF+i70g6BGCNjkOyahI=;
        b=oUtQ5vANYAP3mVu4rL6aGbrAkkgN69OxIwI8Mr76Ttz3WitV2ivNCTnEunDV/K+EZq
         cJc6dFnXPi5RwqpTLCqOetnEI/3k28tt/uT2+DLQ10Bj/uZnp74FJ0/hcIt+RE8cffSo
         1d10clgYe0bfSLqSWSu892ANFYawXVyhBUh7YMveJOqd8k8JCLlLutjBoBdTMM2FrgRE
         YVlbf1ZXLKsplKemqSU1fNT5rBigNrV5AHjqKte5YcMODjy92IGB5QLSJGmO9Ct4cGub
         ZfG9N6x/HF8XslEjBzPH5yNXbxb9DTC6XgMKaov9/nBbDbVdfbfKR9bA9iRIK/3LNySD
         koBw==
X-Gm-Message-State: ANoB5pkyEzYYPPKQfABJdhVkPxzWh1iQgKYXK3R3DfyrHXCRNxfmqzuW
        S5Xo5kt0YMa2w+JrI/19I5wVFNo1EZi5
X-Google-Smtp-Source: AA0mqf6B3/pu1D4l032e2H/NZQ1mxQcgQM/ErlQ5eHxB64Xt+pSrylggyBAyHN9G/tKGaC6u0Zp7FA==
X-Received: by 2002:a17:902:ec04:b0:189:8c37:6f17 with SMTP id l4-20020a170902ec0400b001898c376f17mr5111507pld.67.1669647737577;
        Mon, 28 Nov 2022 07:02:17 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001886ff82680sm8997928plh.127.2022.11.28.07.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:02:17 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: [RFC v4 2/3] tests/qtest/cxl-test: whitespace, line ending cleanup
Date:   Mon, 28 Nov 2022 10:01:56 -0500
Message-Id: <20221128150157.97724-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221128150157.97724-1-gregory.price@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Defines are starting to exceed line length limits, align them for
cleanliness before making modifications.

Signed-off-by: Gregory Price <gregory.price@memverge.com>

---
 tests/qtest/cxl-test.c | 99 +++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index c54f18e76b..e59ba22387 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -8,55 +8,64 @@
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
 
-#define QEMU_PXB_CMD "-machine q35,cxl=on " \
-                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
-
-#define QEMU_2PXB_CMD "-machine q35,cxl=on "                            \
-                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
-                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
-
-#define QEMU_VIRT_2PXB_CMD "-machine virt,cxl=on "                      \
-                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "  \
-                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
-
-#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
+#define QEMU_PXB_CMD \
+  "-machine q35,cxl=on " \
+  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+  "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
+
+#define QEMU_2PXB_CMD \
+  "-machine q35,cxl=on " \
+  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+  "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
+ "- M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
+
+#define QEMU_VIRT_2PXB_CMD \
+  "-machine virt,cxl=on " \
+  "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+  "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
+  "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
+
+#define QEMU_RP \
+  "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
 
 /* Dual ports on first pxb */
-#define QEMU_2RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
-                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
+#define QEMU_2RP \
+  "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+  "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
 
 /* Dual ports on each of the pxb instances */
-#define QEMU_4RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
-                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
-                 "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
-                 "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
-
-#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
-
-#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
-
-#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
-                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
-                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
+#define QEMU_4RP \
+  "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+  "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
+  "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
+  "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
+
+#define QEMU_T3D \
+  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
+
+#define QEMU_2T3D \
+  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
+
+#define QEMU_4T3D \
+  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
+  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
+  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
 
 static void cxl_basic_hb(void)
 {
-- 
2.37.3

