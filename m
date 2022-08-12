Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CDC00140
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 22:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiHLWQK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Aug 2022 18:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHLWQI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Aug 2022 18:16:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E795AE7
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 15:16:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 13so1832984plo.12
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Sz+s9qA67W2QYWtOdQuvIxXR9MRPGddlKfTqjWgaT0c=;
        b=CCu4yGfaQu4Gec/O587D78t7fjD2if9HDWv1CR+S8GwJkyRUMA7mckv+KsikRfwIEV
         jTatqgS11qbK5t05K9b48+JAO2+3UMPrbvI6mhOdEfHvFmPHEg2IWYiy1BjQVUBP0k0w
         1se1J+UwokpaWQunCXIVr/tZRmYKhDWHnPNff85jcF/36SP4cScPtwSvjfNTVjX3GW5O
         NCOP77m+CKzTXmBdl+ynONn4OcVRon4RqbMAUaVyra9eRq1Nj0TvoaRZDpK7qXQmzmmW
         8ksl5o90sOQKV9boxuh57faPFJfw9VWs7vu8ZcZsM07THdrpe8Qi04glQgQSU4shnvRm
         bDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Sz+s9qA67W2QYWtOdQuvIxXR9MRPGddlKfTqjWgaT0c=;
        b=BDthgAeEv85z7lg7DtthFfAa/HrpnMh3HwyqPdumG12/A09rB0vXaAXyEhA4TEFvzh
         7UDR2z1c8YbXYtaMEyzAN1RJOWIZDFnbOzNWMbxPkQNAoti4EDuf7NV1fDQl8Tcyt83M
         uhGH7vADwuW4i6VygPPZoahLLqgTGBtZKI5EuLci0GL2BL/F2bmNm+qiZHGfINk5Dpfk
         xLypukOOy9GVo40bNTQQ0dXE7rEzC109Q8MmBHIlHl85S55qMxWSofe30V/Xg3efMrDI
         6SEZNTJ4RAKSVOy/Ni354xcT833tw26vMZy+qMsdAmqAE3FRjIcgkbtg1d2d+UQagOX0
         ZIfQ==
X-Gm-Message-State: ACgBeo2uSKcFHucNSKe1yDkrsVqgdf8E7HD2a7EReQUrMzg17Y7y7m+I
        LPuIN/HREchXnzFC4PMFFbRJ1b8i1Eo=
X-Google-Smtp-Source: AA6agR4fkk7NXKDRv6KJxTdfqjI8E2bXyJrIiS8vF+2roTwjsFuczPRAXy0AKc6C4rVCHX/pEjgmow==
X-Received: by 2002:a17:903:32ce:b0:16f:2bbb:7169 with SMTP id i14-20020a17090332ce00b0016f2bbb7169mr5801763plr.143.1660342566731;
        Fri, 12 Aug 2022 15:16:06 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b0016d785ef6d2sm2233814plh.223.2022.08.12.15.16.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Aug 2022 15:16:06 -0700 (PDT)
From:   sunfishho12@gmail.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com,
        Matthew Ho <sunfishho12@gmail.com>
Subject: [ndctl PATCH v5] cxl: Add list verbose option to the cxl command
Date:   Fri, 12 Aug 2022 15:15:53 -0700
Message-Id: <20220812221553.92278-1-sunfishho12@gmail.com>
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
Changes since v4 [1]

 - Fixed typo in documentation
 - Removed unnecessary example in documentation

This patch applies to the following region driver patch series [2].

[1]: https://lore.kernel.org/linux-cxl/20220722183705.26936-1-sunfishho12@gmail.com/
[2]: https://lore.kernel.org/linux-cxl/20220810230914.549611-1-vishal.l.verma@intel.com/

 Documentation/cxl/cxl-list.txt | 18 ++++++++++++++++++
 cxl/filter.h                   |  1 +
 cxl/list.c                     | 21 +++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 2906c2f6ef4b..177b9713d812 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -336,6 +336,24 @@ OPTIONS
 --region::
 	Specify the region name to filter the emitted regions.

+-v::
+--verbose::
+	Increase verbosity of the output. This can be specified
+	multiple times to be even more verbose on the
+	informational and miscellaneous output, and can be used
+	to override omitted flags for showing specific
+	information. Note that cxl list --verbose --verbose is
+	equivalent to cxl list -vv.
+	- *-v*
+	  Enable --memdevs, --regions, --buses,
+	  --ports, --decoders, and --targets.
+	- *-vv*
+	  Everything *-v* provides, plus include disabled
+	  devices with --idle.
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

