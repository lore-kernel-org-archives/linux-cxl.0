Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C65C43334
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiGNS2u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbiGNS2s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 14:28:48 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7105E08D
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 11:28:45 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f65so2302245pgc.12
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 11:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YM8Wm93rGqjW1HFzG2rDekOn/6Rrk+Aq84Zm3nihRXk=;
        b=aC7YZZergXbl2kY7bESZ97qDOZn4dDgw6sT1sbIgOQPYp5U6vJ7OEZ4+JfajGeNwwj
         yssUmjIJaV1Hp9zfUqPRiqSM7XEJJdovv2xDltgzNIvs27IA0sXV6PAV6SGeSaaAH8Rb
         ucRFTHudooPkip42RtZZObBsVuXBmDuz2/A6SxY3g2RC3VKzmQkFWbaSNbicwqyLdCZh
         U0BefoSZkKaVXuRxVIflFrqinV6pLwYIVsSf7IMcX615Lpp1WtcO3aD2F249J6ZRhyyZ
         bYVH0pIlv+jAcG149cRupSyXfW/smVHN1IaqFPfwt55RGIWE4Qer/ZwUEsFvV8kUDmWc
         ZCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YM8Wm93rGqjW1HFzG2rDekOn/6Rrk+Aq84Zm3nihRXk=;
        b=K9kCaYpr3znw8u0GwOegRv0Pm7zohcraSxTafoEibIsYddMTqTgzrAhxkoTkWnN3dr
         DbOIv9eHjwZVzi1l/sajgndiNaGfDiTqbbU+aOGd3+QRHN2cnqY5ACF/ArThadTDizBT
         /5SACI06d7/CFhOW5t9Lte8P8JXyesYPaf5iFcYUgInZnt2y5FxKz+rSLvgyM65XRVXh
         WBs39PcUtQfJKQairYNYPt5Eqe3uFjDFsdWktNqri545+ImSWUSEjx8M9JcFI451es6u
         1L1pdEwe4ydhnT5uLNYboTUV9/9OmiCZNpDhlVGAGsGqLx1ER158K8vWUwdDkGqbbcL/
         HAFQ==
X-Gm-Message-State: AJIora/ahshRKg6FSL9E2thsQTAoeZyiwgXm/BjWppTV0ozF26po8mJB
        pMVxlYAht0gtGUwJyIkIXsa6thTqACE=
X-Google-Smtp-Source: AGRyM1uOgBWeyaocfGCJuZw90sPWvPWDSXdlLG3TdNpq/EnZTazIRrgJrqfdSUklO55zd5r5lQBYOA==
X-Received: by 2002:a63:8342:0:b0:415:dde4:f5ec with SMTP id h63-20020a638342000000b00415dde4f5ecmr8417645pge.263.1657823324954;
        Thu, 14 Jul 2022 11:28:44 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b0016a7d9e6548sm1776063plh.262.2022.07.14.11.28.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Jul 2022 11:28:44 -0700 (PDT)
From:   sunfishho12@gmail.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Matthew Ho <sunfishho12@gmail.com>
Subject: [PATCH ndctl] cxl: Add list all option to the cxl command
Date:   Thu, 14 Jul 2022 11:27:37 -0700
Message-Id: <20220714182737.60714-1-sunfishho12@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Matthew Ho <sunfishho12@gmail.com>

This adds a new subcommand cxl list --all, which is equivalent to cxl list -MBPEDTHIiu. This addition makes it easier to list all the CXL devices at once, as one does not need to append a subcommand for each device. --all is also easier to remember than -MBPEDTHIiu. When region support is added, this will be updated to include it.

Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
---
 cxl/filter.h |  1 +
 cxl/list.c   | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/cxl/filter.h b/cxl/filter.h
index 697b7779c08e..7009c00a1c23 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -13,6 +13,7 @@ struct cxl_filter_params {
 	const char *port_filter;
 	const char *endpoint_filter;
 	const char *decoder_filter;
+	bool all;
 	bool single;
 	bool endpoints;
 	bool decoders;
diff --git a/cxl/list.c b/cxl/list.c
index 1e9d441190a0..738282e95434 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -50,6 +50,8 @@ static const struct option options[] = {
 		    "include memory device health information "),
 	OPT_BOOLEAN('I', "partition", &param.partition,
 		    "include memory device partition information "),
+	OPT_BOOLEAN(0, "all", &param.all,
+		    "include info on all components of the CXL hierarchy"),
 #ifdef ENABLE_DEBUG
 	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
 #endif
@@ -82,6 +84,19 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		usage_with_options(u, options);
 	}

+	if (param.all){
+		param.memdevs = true;
+		param.buses = true;
+		param.ports = true;
+		param.endpoints = true;
+		param.decoders = true;
+		param.partition = true;
+		param.health = true;
+		param.targets = true;
+		param.human = true;
+		param.idle = true;
+	}
+
 	if (num_list_flags() == 0) {
 		if (param.memdev_filter || param.serial_filter)
 			param.memdevs = true;
--
2.34.1

