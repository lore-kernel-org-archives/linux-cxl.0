Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA4C678D5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 08:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCGIUQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 03:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCGITx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 03:19:53 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DA23A9F
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 00:19:37 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230307081935epoutp011929393f4f266c3e791f2ea974d3b8ef~KFT-nOyL03139531395epoutp01b
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 08:19:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230307081935epoutp011929393f4f266c3e791f2ea974d3b8ef~KFT-nOyL03139531395epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678177175;
        bh=ndU6jYdYH68wPtVmnqEhobVmxodMd5U+qgj0Rft3SIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=As35Vp1cfMutpT1R5It4UrAl6s4eE9/ccjNQAXXyjWEFC3r8EB05wCTgff8mn+bL2
         qNVXQ/m2VzopK9nWmhJBT00q7gHANkRDK6tm740cKdY+qDHQwTf5jp+lDkNgoPZdz2
         PCU0CfrBz3JyuV2iY1hTjIgC7wdn230O7tsgvfFw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230307081934epcas2p18795fb82ac9ac4ae8a6067c327af9928~KFT-JUw5K1880318803epcas2p1E;
        Tue,  7 Mar 2023 08:19:34 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PW7dy0xcqz4x9QH; Tue,  7 Mar
        2023 08:19:34 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.35.31307.593F6046; Tue,  7 Mar 2023 17:19:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230307081933epcas2p338dbe10c507b6ebb59343bc2ca9bb8dc~KFT_Hgmis1160611606epcas2p3b;
        Tue,  7 Mar 2023 08:19:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230307081933epsmtrp147a1892c116c1f0a0e72c7cb07da500f~KFT_B8aSe3223532235epsmtrp1o;
        Tue,  7 Mar 2023 08:19:33 +0000 (GMT)
X-AuditID: b6c32a46-743fa70000007a4b-58-6406f39558b3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.22.18071.593F6046; Tue,  7 Mar 2023 17:19:33 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.133]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230307081933epsmtip210168f884a8a40e9770dd9bab5c926a1~KFT9yVp4A3147231472epsmtip2F;
        Tue,  7 Mar 2023 08:19:33 +0000 (GMT)
From:   Jehoon Park <jehoon.park@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, jehoon park <jehoon.park@samsung.com>
Subject: [ndctl patch RFC 2/2] cxl: add identify command to cxl tool
Date:   Tue,  7 Mar 2023 17:21:02 +0900
Message-Id: <20230307082102.27195-3-jehoon.park@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307082102.27195-1-jehoon.park@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7bCmqe7Uz2wpBtNO2ljcfXyBzaJ58mJG
        i+lTLzBa7H/6nMXiwOsGdovzs06xWNyacIzJgd1j8Z6XTB6bVnWyefRtWcXo8XmTXABLVLZN
        RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
        QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjLYZ
        21kLlnhUfNqxiKmB8aB5FyMnh4SAicTn6yeYQWwhgR2MEtuPhnQxcgHZnxgl3m5cyALhfGOU
        mHz1DwtMx9ePfawQib2MEps3TmCGcLqZJI69fw1WxSagLXF/+wY2EFtEQFaied0DJpAiZoHl
        jBKL9/8EWygs4CKxeMkjdhCbRUBV4taj92BxXgEbifX9s5gg1slLrN5wACzOKWArsfJZJxvI
        IAmBfewSR5f/BnI4gBwXiVsvnCDqhSVeHd/CDmFLSbzsb4Oy8yV+nrzFCmEXSHz68gHqHWOJ
        dzefs4KMYRbQlFi/Sx9iorLEkVtgFcwCfBIdh/+yQ4R5JTrahCAaVSW6jn9ghLClJQ5fOcoM
        YXtIXF7RzwQJkgmMEmePvGWdwCg3C2HBAkbGVYxiqQXFuempxUYFRvAIS87P3cQITmBabjsY
        p7z9oHeIkYmD8RCjBAezkgjv23dsKUK8KYmVValF+fFFpTmpxYcYTYFBN5FZSjQ5H5hC80ri
        DU0sDUzMzAzNjUwNzJXEeaVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MOVlSjWnXPp/sUedhyvz
        0ksNYcWVsU94uIPV3+fff3hO9sSOBMuHwhd3Lzi+p3h299dbr9aZP43zW962v7goo03nfuzs
        pjkpT2YIZuQr8KbcDfm8PnjTxqUf951xXnhrsd2LP8c1HzhyJGfOumIcOpez/F6f0Hy+GUtO
        MKSs1D2uFJopNL/pzebs75nK06a2BNhp/RbhnBBZbjUhfe1xp65ny7qibJ2n6zx7WlI3u6R9
        fXQYx0tpF67GozttNlf9iklL/lb25+bxHOvkzecSUy+yLur7V+vbtUbBTV7cd1f5rre71D9s
        qlJdcmH7AYPLkwReWTps47ePePdtkt7lD1XHtp86mLTo6rv0hJ9ZPtxKLMUZiYZazEXFiQBD
        a7Bn6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSvO7Uz2wpBv/myVncfXyBzaJ58mJG
        i+lTLzBa7H/6nMXiwOsGdovzs06xWNyacIzJgd1j8Z6XTB6bVnWyefRtWcXo8XmTXABLFJdN
        SmpOZllqkb5dAldG24ztrAVLPCo+7VjE1MB40LyLkZNDQsBE4uvHPtYuRi4OIYHdjBKbLjSx
        QySkJe41X4GyhSXutxyBKupkkmi9sYgJJMEmoC1xf/sGNhBbREBWonndA7A4s8BaRolzbcIg
        trCAi8TiJY/ABrEIqErcevSeGcTmFbCRWN8/iwligbzE6g0HwOKcArYSK591gs0UAqpp3LiU
        bQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHBpqW5g3H7qg96hxiZOBgP
        MUpwMCuJ8L59x5YixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUA9OlygzxqmCpeT9MXT5s59lu2PHCM4tRaMacud0TDZYcXxrbFe7X8F57Yo5t45b/5wXT
        Uh+vUL1R932DmPwOO4+bNVkz/Sz/24urWt6OcCnaz5rokraN4+XB25X260Q1jV5KzLx5Y97O
        WJfqd1c0PX/GrWzg4/CSMXvua/Vuit2sW2ee5Sq1xj0pPuyxeGvdo6Cz/ydvDzpvcuO5yz72
        1A2vf96dLHiUO26RpKuJlUeO0Gd/NsfZJ8890Qu4JlCa8cDyzOqSjpw/mYuCL2z7eH7S3gV3
        mLoXBbHOKdH2XDuN5VO6XXBd7tb9pUX/30e46M04sWCuw0uXZRzzc1IVDI98VT0vc/fD9njO
        +Vm/5nUqsRRnJBpqMRcVJwIAmglLAaUCAAA=
X-CMS-MailID: 20230307081933epcas2p338dbe10c507b6ebb59343bc2ca9bb8dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230307081933epcas2p338dbe10c507b6ebb59343bc2ca9bb8dc
References: <20230307082102.27195-1-jehoon.park@samsung.com>
        <CGME20230307081933epcas2p338dbe10c507b6ebb59343bc2ca9bb8dc@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: jehoon park <jehoon.park@samsung.com>

Add identify command to cxl-cli. This new command displays
basic information about CXL memory device(s).
Add man page documentation for identify cli command.

Signed-off-by: jehoon park <jehoon.park@samsung.com>
---
 Documentation/cxl/cxl-identify.txt |  57 ++++++++++++
 Documentation/cxl/meson.build      |   1 +
 cxl/builtin.h                      |   1 +
 cxl/cxl.c                          |   1 +
 cxl/memdev.c                       | 141 +++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 Documentation/cxl/cxl-identify.txt

diff --git a/Documentation/cxl/cxl-identify.txt b/Documentation/cxl/cxl-identify.txt
new file mode 100644
index 0000000..ee25895
--- /dev/null
+++ b/Documentation/cxl/cxl-identify.txt
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-identify(1)
+===============
+
+NAME
+----
+cxl-identify - display basic information about a CXL memdev
+
+SYNOPSIS
+--------
+[verse]
+'cxl identify <mem0> [<mem1>..<memN>] [<options>]'
+
+DESCRIPTION
+-----------
+This command sends an identify command to a CXL memory device, and displays
+the result. Provided information: CXL memory device's capacity
+(total, volatile and persistent), partition alignment, event log size,
+LSA size, poison list size, inject poison limit, poison handling capabilities
+and QoS telemetry capabilities.
+
+EXAMPLE
+-------
+----
+# cxl identify mem0
+FW Revision                              : BWFW VERSION 00
+Total Capacity                           : 1.00 GB
+Volatile Only Capacity                   : 1.00 GB
+Persistent Only Capacity                 : 0 B
+Partition Alignment                      : 0 B
+Informational Event Log Size             : 0
+Warning Event Log Size                   : 0
+Failure Event Log Size                   : 0
+Fatal Event Log Size                     : 0
+LSA Size                                 : 0 B
+Poison List Maximum Media Error Records  : 256
+Inject Poison Limit                      : 0
+Poison Handling Capabilities
+Injects Persistent Poison                : Not Supported
+Scans for Poison                         : Not Supported
+QoS Telemetry Capabilities
+Egress Port Congestion                   : Not Supported
+Temporary Throughput Reduction           : Not Supported
+cxl memdev: cmd_identify: identified 1 mem
+----
+
+OPTIONS
+-------
+<memory device(s)>::
+include::memdev-option.txt[]
+
+include::verbose-option.txt[]
+
+SEE ALSO
+--------
+CXL-3.0 8.2.9.8.1
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index a6d77ab..d60d42d 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -46,6 +46,7 @@ cxl_manpages = [
   'cxl-enable-region.txt',
   'cxl-destroy-region.txt',
   'cxl-monitor.txt',
+  'cxl-identify.txt',
 ]
 
 foreach man : cxl_manpages
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 9baa43b..2276415 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -32,4 +32,5 @@ static inline int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx)
 	return EXIT_FAILURE;
 }
 #endif
+int cmd_identify(int argc, const char **argv, struct cxl_ctx *ctx);
 #endif /* _CXL_BUILTIN_H_ */
diff --git a/cxl/cxl.c b/cxl/cxl.c
index 3be7026..be536ea 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -77,6 +77,7 @@ static struct cmd_struct commands[] = {
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
 	{ "monitor", .c_fn = cmd_monitor },
+	{ "identify", .c_fn = cmd_identify },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 0b3ad02..638107c 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -135,6 +135,136 @@ static const struct option free_dpa_options[] = {
 	OPT_END(),
 };
 
+static const struct option identify_options[] = {
+	BASE_OPTIONS(),
+	OPT_END(),
+};
+
+static void bytes_to_str(unsigned long long bytes, char *str, int len)
+{
+	/* convert bytes to human friendly formats (B, KB, MB, GB, TB) */
+
+	if (bytes == ULLONG_MAX)
+		snprintf(str, len, "Invalid");
+	else if (bytes < SZ_1K)
+		snprintf(str, len, "%lld B", bytes);
+	else if (bytes < SZ_1M)
+		snprintf(str, len, "%.2lf KB", (double)bytes / SZ_1K);
+	else if (bytes < SZ_1G)
+		snprintf(str, len, "%.2lf MB", (double)bytes / SZ_1M);
+	else if (bytes < SZ_1T)
+		snprintf(str, len, "%.2lf GB", (double)bytes / SZ_1G);
+	else
+		snprintf(str, len, "%.2lf TB", (double)bytes / SZ_1T);
+}
+
+static int action_identify(struct cxl_memdev *memdev,
+			   struct action_context *actx)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_cmd *cmd;
+	int rc;
+	char fw_rev[0x10], total_cap[10], volatile_only[10],
+		persistent_only[10], alignment[10], lsa_size[10];
+	int info_log_size, warn_log_size, fail_log_size, fatal_log_size,
+		poison_list_max, inject_poison_limit, inject_persistent_poison,
+		scan_poison, egress_port_congestion, temp_throughput_reduction;
+
+	cmd = cxl_cmd_new_identify(memdev);
+	if (!cmd)
+		return -ENOMEM;
+
+	rc = cxl_cmd_submit(cmd);
+	if (rc < 0) {
+		log_err(&ml, "cmd submission failed: %s\n", strerror(-rc));
+		return rc;
+	}
+
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (rc != 0) {
+		log_err(&ml, "%s: mbox status: %d\n", __func__, rc);
+		return -ENXIO;
+	}
+
+	rc = cxl_cmd_identify_get_fw_rev(cmd, fw_rev, 0x10);
+	if (rc != 0) {
+		log_err(&ml, "%s: can't get firmware revision\n", devname);
+	}
+
+	bytes_to_str(cxl_cmd_identify_get_total_size(cmd), total_cap,
+		     sizeof(total_cap));
+	bytes_to_str(cxl_cmd_identify_get_volatile_only_size(cmd),
+		     volatile_only, sizeof(volatile_only));
+	bytes_to_str(cxl_cmd_identify_get_persistent_only_size(cmd),
+		     persistent_only, sizeof(persistent_only));
+	bytes_to_str(cxl_cmd_identify_get_partition_align(cmd), alignment,
+		     sizeof(alignment));
+	info_log_size =
+		cxl_cmd_identify_get_event_log_size(cmd, CXL_IDENTIFY_INFO);
+	warn_log_size =
+		cxl_cmd_identify_get_event_log_size(cmd, CXL_IDENTIFY_WARN);
+	fail_log_size =
+		cxl_cmd_identify_get_event_log_size(cmd, CXL_IDENTIFY_FAIL);
+	fatal_log_size =
+		cxl_cmd_identify_get_event_log_size(cmd, CXL_IDENTIFY_FATAL);
+	bytes_to_str(cxl_cmd_identify_get_label_size(cmd), lsa_size,
+		     sizeof(lsa_size));
+	poison_list_max = cxl_cmd_identify_get_poison_list_max(cmd);
+	inject_poison_limit = cxl_cmd_identify_get_inject_poison_limit(cmd);
+	inject_persistent_poison =
+		cxl_cmd_identify_injects_persistent_poison(cmd);
+	scan_poison = cxl_cmd_identify_scans_for_poison(cmd);
+	egress_port_congestion = cxl_cmd_identify_egress_port_congestion(cmd);
+	temp_throughput_reduction =
+		cxl_cmd_identify_temporary_throughput_reduction(cmd);
+
+	printf("CXL Identify Memory Device \"%s\"\n", devname);
+	printf("FW Revision                              : %s\n", fw_rev);
+	printf("Total Capacity                           : %s\n", total_cap);
+	printf("Volatile Only Capacity                   : %s\n",
+	       volatile_only);
+	printf("Persistent Only Capacity                 : %s\n",
+	       persistent_only);
+	printf("Partition Alignment                      : %s\n", alignment);
+	printf("Informational Event Log Size             : %d\n",
+	       info_log_size);
+	printf("Warning Event Log Size                   : %d\n",
+	       warn_log_size);
+	printf("Failure Event Log Size                   : %d\n",
+	       fail_log_size);
+	printf("Fatal Event Log Size                     : %d\n",
+	       fatal_log_size);
+	printf("LSA Size                                 : %s\n", lsa_size);
+	printf("Poison List Maximum Media Error Records  : %d\n",
+	       poison_list_max);
+	printf("Inject Poison Limit                      : %d\n",
+	       inject_poison_limit);
+	printf("Poison Handling Capabilities\n");
+	printf("Injects Persistent Poison                : ");
+	if (inject_persistent_poison)
+		printf("Supported\n");
+	else
+		printf("Not Supported\n");
+	printf("Scans for Poison                         : ");
+	if (scan_poison)
+		printf("Supported\n");
+	else
+		printf("Not Supported\n");
+	printf("QoS Telemetry Capabilities\n");
+	printf("Egress Port Congestion                   : ");
+	if (egress_port_congestion)
+		printf("Supported\n");
+	else
+		printf("Not Supported\n");
+	printf("Temporary Throughput Reduction           : ");
+	if (temp_throughput_reduction)
+		printf("Supported\n");
+	else
+		printf("Not Supported\n");
+
+	return 0;
+}
+
 enum reserve_dpa_mode {
 	DPA_ALLOC,
 	DPA_FREE,
@@ -893,3 +1023,14 @@ int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_identify(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(
+		argc, argv, ctx, action_identify, identify_options,
+		"cxl identify <mem0> [<mem1>..<memn>] [<options>]");
+	log_info(&ml, "identified %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.17.1

