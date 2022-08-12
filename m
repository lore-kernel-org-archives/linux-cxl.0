Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C685C00140
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 18:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbiHLSMn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiHLSMm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Aug 2022 14:12:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3FB2D8C
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 11:12:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pm17so1678525pjb.3
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WTdmd+SLRJ9Wy7VENDN9HR5C81AV5A0Vg/INCq5HVyY=;
        b=SleIKRD2TAw8gewy30iA95ZW/mu/KvZttoDydotbCo3yrfpEa/KxrZ904nlmz/CM+M
         Gia309K6gtFCkEWc/KxCmOkvdpbQEfs/cvTwCRdMvwvg3vRsHmpsMjvVNBkfXUuDz9y/
         azagACMY11ALAevWY6MOq/yu794n3/ipVvk+KUMAVjyzVumD3qZs31cmD2dF0fmedLSd
         Q56UtWXmHyVIKsx9kBqRHhnrEaIse8OFUDDn//1XjqB5OyOb70fpmWYqB5aHu8bsPcxb
         IhmBBU4X3AgIQl/4jGdUhXcvSq19YN4qe3JR1+b99m6Pn2A95vDNUi+d/9l1F0KrtWoy
         pEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WTdmd+SLRJ9Wy7VENDN9HR5C81AV5A0Vg/INCq5HVyY=;
        b=UYcHZDosG0yTYEu8iz7x+N+Ab0Frml98W304TuyPGfAesy7GzAQAMid0Afd7rioym0
         +ulHo8IuWTqbVWnQADWeapfrXG5m0WUo8eak7y8R414KSgH6fXBQ13LZgmXbdU39AR9S
         bG1oNBWYJFfp7KnJk7lG6ji4asv4iFIcFAV+HtcLkr2A4Ami+N2tWnqLSSBEatK6R7zD
         4ggaWuzpmpboLGyataudANk6siG7j3wksBvpuDwzQpQ1y8b1D2Bh+6RKgueFWMh01cYt
         uKbK/2Po+ycI1P3aQSfnz4L1Ze4g6I6NFFgOdqH6ZXND9h72QlYGXLgRvZgi5zXAnFQR
         fFkw==
X-Gm-Message-State: ACgBeo0+Vkoq/XU/x1sKYBLEgeO+zE5i/EH+Lww4LepQCwHuLvCVkHUu
        NcLpEQ3T9HLkeHTAO7FqTO9OJnwOyiA=
X-Google-Smtp-Source: AA6agR6aAh+JuhIR8ULeCiyIwaP89uTVvr5T1sGWPK21Ch0L4jrPPQVIF4BF+yq9squXTBKVCCVWJA==
X-Received: by 2002:a17:902:cec8:b0:16f:8081:54bc with SMTP id d8-20020a170902cec800b0016f808154bcmr4966494plg.139.1660327961197;
        Fri, 12 Aug 2022 11:12:41 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0052b84ca900csm1903071pfh.62.2022.08.12.11.12.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Aug 2022 11:12:40 -0700 (PDT)
From:   sunfishho12@gmail.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Matthew Ho <sunfishho12@gmail.com>
Subject: [ndctl PATCH v4] cxl: Add list verbose option to the cxl command
Date:   Fri, 12 Aug 2022 11:12:24 -0700
Message-Id: <20220812181224.89722-1-sunfishho12@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Matthew Ho <sunfishho12@gmail.com>

This adds the new subcommands cxl list -v, cxl list -vv, and cxl list -vvv.

cxl list -v is now equivalent to cxl list -RMBDPT, cxl list -vv is
equivalent to cxl list -RMBDPTi, and cxl list -vvv is equivalent to
cxl list -RMBDPTiHI. These additions make it easier to list all of the CXL
devices without having to remember which subcommand must be appended for each
type of device.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
---
Changes since v3[1]

 - Fixed formatting of patch
 - Amended patch to apply to latest region driver patches [2]
 - Added missed "Acked-by"

[1]: https://lore.kernel.org/linux-cxl/20220722183705.26936-1-sunfishho12@gmail.com/
[2]: https://lore.kernel.org/linux-cxl/20220810230914.549611-1-vishal.l.verma@intel.com/

Maybe this could be added to the region driver series?

 Documentation/cxl/cxl-list.txt | 20 ++++++++++++++++++++
 cxl/filter.h                   |  1 +
 cxl/list.c                     | 21 +++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 2906c2f6ef4b..0e7727ca167f 100644
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
+	  Everything *-v* provides, plus include disabled
+	  devices with --idle.
+	- *-vvv*
+	  Everything *-vvv* provides, plus enable
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
index 5f604ecddf3c..8c48fbbaaec3 100644
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

+	switch(param.verbose){
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
+		/*fallthrough*/
+	case 0:
+		break;
+	}
+
 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
 	if (debug) {
 		cxl_set_log_priority(ctx, LOG_DEBUG);
--
2.34.1

