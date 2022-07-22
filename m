Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41F1C43334
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Jul 2022 18:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiGVSic (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiGVSib (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 14:38:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35FBA0261
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 11:38:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so8302865pjf.1
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfGLOPkXlxIT11PXLHi47cs4M5VqqVeDSVWUVWLZCKM=;
        b=DTDW8llsRX3YvnVvKa1EcR2n1aQH/YTwWIbTfi/8uyaEamwGebISsJ9Vwy6dlLuH2M
         l2/c1djUUfa7Jy9bif8cpEsxrxDI/h6GTGaKEyXbEepT4pOICw9CGLE1x8QzZTnYIqK1
         AtZGhqYE06cH5zVj5TJccJ5dIsHsQUCQatbKIImz/uL8N1MOMww4gxUjykolpgxiFzoP
         hGjFm/J2puK5/zKWXxgzl69uoR50DOORx1a07MvHiEMoLSx0+KjTtKWogCQPQkwLeK8g
         hhaS00sFruJNqCxmqwaEv3nIyLF+PArgKZ5n4r88YCPyZF3h6rOphF6KKTTzklAe4PMv
         k1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MfGLOPkXlxIT11PXLHi47cs4M5VqqVeDSVWUVWLZCKM=;
        b=0/kQJiv8auupZnGwPWbQNmYWRriD8/plJtYzQH4ngzhLT+1jCNfZOrZBrBQq00NCWC
         /0My81l0NWh9coSiY6PtvdDR2v5XX9n0vK8EPLD6fV13GXDvxtaHJRXjvp2rii46Fxqk
         JSuhGFFOzUQatykrQvSl9jhVu/p1w/oRo5PPcz2Gif6BPRZV9EDsQwcqRaNpVObHfMlQ
         48YWi9LrvR87Y0mD/xy+cnWHPd+bwyGVIAZfHzAS9mcQuTT/W2OzHPqTvDAYfD2awjbK
         xSkrs+EbsAIbWaui8+EhbnIWQSM2N1l8VoSE4IUPZUDOKuTFfaMItzUOcv3eMgZ7vmnz
         Q76Q==
X-Gm-Message-State: AJIora+fB5BKsTFhUTJyocrmMXd/g4J5eVDGEwBErVBaaMy0VIi3O88r
        zYCq9MHlhuk1zRguChaY4QDgzj7ImF0=
X-Google-Smtp-Source: AGRyM1veshuLFFJ+qPFdTSMXALlYQ7/C1Hpcoz2RLL3m9LcZxfy9KcBTxEMFX6Njs56lo16SAv3YpQ==
X-Received: by 2002:a17:90b:1b43:b0:1f2:3d94:efd2 with SMTP id nv3-20020a17090b1b4300b001f23d94efd2mr7629201pjb.65.1658515109868;
        Fri, 22 Jul 2022 11:38:29 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id bo23-20020a17090b091700b001efa35356besm5487552pjb.28.2022.07.22.11.38.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Jul 2022 11:38:28 -0700 (PDT)
From:   sunfishho12@gmail.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Matthew Ho <sunfishho12@gmail.com>
Subject: [ndctl PATCH v3] cxl: Add list verbose option to the cxl command
Date:   Fri, 22 Jul 2022 11:37:05 -0700
Message-Id: <20220722183705.26936-1-sunfishho12@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Matthew Ho <sunfishho12@gmail.com>

This adds the new subcommands cxl list -v, cxl list -vv, and cxl list -vvv, and
builds on this pending patch series that adds region listing support:

https://lore.kernel.org/linux-cxl/20220715062550.789736-1-vishal.l.verma@intel.com/

cxl list -v is now equivalent to cxl list -RMBDPT, cxl list -vv is
equivalent to cxl list -RMBDPTi, and cxl list -vvv is equivalent to
cxl list -RMBDPTiHI. These additions make it easier to list all of the CXL
devices without having to remember which subcommand must be appended for each
type of device.

Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
---

Maybe this could be added to the region driver series?

Changes since v2
 - Switch statement in cxl/list revised to make it so that appending more v's to
 cxl list -vvv does not change the resulting output.
 - Fallthrough comments added to the switch statement in cxl/list to suppress
 the gcc -Wimplicit-fallthrough warning.
 - Slightly tweak documentation of --verbose

 Documentation/cxl/cxl-list.txt | 20 ++++++++++++++++++++
 cxl/filter.h                   |  1 +
 cxl/list.c                     | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 2906c2f6ef4b..c29e69064c42 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -336,6 +336,26 @@ OPTIONS
 --region::
 	Specify the region name to filter the emitted regions.

+-v::
+--verbose::
+	Increase verbosity of the output. This can be specified
+	multiple times to be even more verbose on the
+	informational and miscellaneous output, and can be used
+	to override omitted flags for showing specific
+	information. Note that cxl list --verbose --verbose is
+	equivalent to cxl list -vv, and likewise
+	cxl list --verbose --verbose --verbose is equivalent to
+	cxl list -vvv.
+	- *-v*
+	  Enable --memdevs, --regions, --buses,
+	  --ports, --decoders, and --targets.
+	- *-vv*
+	  Everything *-v* provides, plus include
+	  disabled devices with --idle.
+	- *-vvv*
+	  Everything *-vv* provides, plus enable
+	  --health and --partition.
+
 --debug::
 	If the cxl tool was built with debug enabled, turn on debug
 	messages.
diff --git a/cxl/filter.h b/cxl/filter.h
index d22d8b1f798b..256df49c3d0c 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -26,6 +26,7 @@ struct cxl_filter_params {
 	bool human;
 	bool health;
 	bool partition;
+	int verbose;
 	struct log_ctx ctx;
 };

diff --git a/cxl/list.c b/cxl/list.c
index 5f604ecddf3c..4462d41fb976 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -52,6 +52,8 @@ static const struct option options[] = {
 		    "include memory device health information"),
 	OPT_BOOLEAN('I', "partition", &param.partition,
 		    "include memory device partition information"),
+	OPT_INCR('v', "verbose", &param.verbose,
+		 "increase output detail"),
 #ifdef ENABLE_DEBUG
 	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
 #endif
@@ -106,6 +108,25 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		param.memdevs = true;
 	}

+	switch (param.verbose){
+	default:
+	case 3:
+		param.health = true;
+		param.partition = true;
+		/* fallthrough */
+	case 2:
+		param.idle = true;
+		/* fallthrough */
+	case 1:
+		param.buses = true;
+		param.ports = true;
+		param.decoders = true;
+		param.targets = true;
+		/* fallthrough */
+	case 0:
+		break;
+	}
+
 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
 	if (debug) {
 		cxl_set_log_priority(ctx, LOG_DEBUG);
--
2.34.1

