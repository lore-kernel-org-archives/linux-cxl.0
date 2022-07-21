Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A96C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Jul 2022 19:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGUTZT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiGUTZP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Jul 2022 15:25:15 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2110BA
        for <linux-cxl@vger.kernel.org>; Thu, 21 Jul 2022 12:25:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so2539191pgb.4
        for <linux-cxl@vger.kernel.org>; Thu, 21 Jul 2022 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1STwQsTB1PZHATgXQqop8khz7uuK12LWLLiFe3xSTpE=;
        b=b4tV+28IlyDkvv5AnhzOQt2ZrU3HOaWwS0D7O65Zq4xQhedbHSHWCtMzQ7YoRft+Ld
         xa+HTW1zTPG3K+f8dVeSN1fecSb6OoICcWu8WqKt5bcMvx2cFCGnlXaVv+gTH32vr9AU
         27tBnZ2qQvt/rE875ATehnoCwI8ISKRVldYq67qYg1GmoB7KeGahVsb+lG5DuymLThAk
         wl1W9TJBm65cRUktm1ze1hod2hTduHv90lT6tWtwR9UrKp/9CGCSTn4sCKjVuHvsqj5l
         /vSiOUlQr6QUySwmWYFcorm17HPQhOP9+0FvTFwZn57cUhLJXHeQkyoU8WTJnkLSKZ/q
         4EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1STwQsTB1PZHATgXQqop8khz7uuK12LWLLiFe3xSTpE=;
        b=gQbnDJU2GiGg0qSkTLsfGYON5vnCNzLebh7xeTOs9uHMQ9BBZ8DBasSEsCyWoKrWRF
         cLoDrNFGA+o7/965Yv8f3k0UUZ3cTicpz71anQW0DvMOVu6hPpIhZ8PhkDusAEFYH7Ia
         3D3LFZTS2p8E/FaKYuz3mXMqj408ihyclKYlok+MEleq4cqsIFpWS7+teYdHCIBfEv8e
         N6CVdzCMTB07UlYI/GohDKAyGKi+uN2UClcc6uen0nu872SbevJD0ZU3lOCmMvjxfEXF
         29Qk6gNzy/NNLM7749j/8Sx4olHNqwHOD0h7iCYBMvQoh7oCr+H65RqVXHGdx1uLwz3o
         L8ag==
X-Gm-Message-State: AJIora+/dfnbPAP1yBlTKch+SSfGD9+UqE6OBrHrdvnrUC7l10DNmk0b
        vKz9bgMOYHli5ru+S/sXzslYhYXcv4c=
X-Google-Smtp-Source: AGRyM1tb871w4cwx/WPgul8QgKiV55mwlhI/gwiHxHDzBQa/ur2IcmC1nEklzMRyXovFNCYva/cyOA==
X-Received: by 2002:a05:6a00:b8b:b0:51b:eefc:7fd2 with SMTP id g11-20020a056a000b8b00b0051beefc7fd2mr44788530pfj.74.1658431510598;
        Thu, 21 Jul 2022 12:25:10 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b0016b8746132esm2128794plg.105.2022.07.21.12.25.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 Jul 2022 12:25:10 -0700 (PDT)
From:   sunfishho12@gmail.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Matthew Ho <sunfishho12@gmail.com>
Subject: [ndctl PATCH v2] cxl: Add list verbose option to the cxl command
Date:   Thu, 21 Jul 2022 12:24:47 -0700
Message-Id: <20220721192447.16958-1-sunfishho12@gmail.com>
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
Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
---

Changes since v1 (previously titled "Add list all option to the cxl command"):
 - cxl list -v, cxl list -vv, cxl list -vvv replace cxl list --all,
 providing greater control over detail of the output. --human has been excluded
 as it can be appended by the user.

 Documentation/cxl/cxl-list.txt | 20 ++++++++++++++++++++
 cxl/filter.h                   |  1 +
 cxl/list.c                     | 17 +++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 2906c2f6ef4b..f069aee8c674 100644
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
+	  Automatically enable --memdevs, --regions, --buses,
+	  --ports, --decoders, --targets.
+	- *-vv*
+	  Everything *-v* provides, plus automatically include
+	  disabled devices with --idle.
+	- *-vvv*
+	  Everything *-vv* provides, plus automatically enable
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
index 5f604ecddf3c..4763c7c36024 100644
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
@@ -106,6 +108,21 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 		param.memdevs = true;
 	}

+	switch (param.verbose){
+	default:
+		break;
+	case 3:
+		param.health = true;
+		param.partition = true;
+	case 2:
+		param.idle = true;
+	case 1:
+		param.buses = true;
+		param.ports = true;
+		param.decoders = true;
+		param.targets = true;
+	}
+
 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
 	if (debug) {
 		cxl_set_log_priority(ctx, LOG_DEBUG);
--
2.34.1

