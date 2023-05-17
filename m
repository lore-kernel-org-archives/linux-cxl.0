Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383BC77B7D
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 03:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjEQDYL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 23:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjEQDYJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 23:24:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432911FFB
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 20:24:07 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230517032404epoutp02d4b32807da93f62b1b3fda3569ca34a1~f0FPynacw1878518785epoutp02N
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 03:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230517032404epoutp02d4b32807da93f62b1b3fda3569ca34a1~f0FPynacw1878518785epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684293844;
        bh=Q4LyMhdnIFcxDHL0z0+MFUfEZnso5D9xr3asQfzYsso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zlbs9Or1SNp7CS0TSwvxkT7Jys8lpYMqMM6emEU7Hb+k2P9pgFTuoJmJqETIy/Hrv
         Sgd8Zmvpo/gAewFu2FSkxlR71vDu10GprzfPAqSUzAdvONqS9mAJiPttJPC32SoHKi
         n199OofaC03s9eeH5zoCcRCycuircZ3ZHDocqDfY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230517032404epcas2p1c3d394a24e127c5d2f60631b6fdc8301~f0FPbj0SN0857808578epcas2p1R;
        Wed, 17 May 2023 03:24:04 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QLdkC5CpRz4x9Py; Wed, 17 May
        2023 03:24:03 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.A2.17293.3D844646; Wed, 17 May 2023 12:24:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230517032403epcas2p48fbabf7aec3334b4892c87265b1a7705~f0FOogDhX3043130431epcas2p4f;
        Wed, 17 May 2023 03:24:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230517032403epsmtrp2965fb1a5131c536cab6a4cf64cf3dd76~f0FOn21uv0097500975epsmtrp2g;
        Wed, 17 May 2023 03:24:03 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-62-646448d372db
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.84.28392.3D844646; Wed, 17 May 2023 12:24:03 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230517032403epsmtip276c3b07ab06b101e1cdca0b9a894d7ff~f0FOXo6uu0909809098epsmtip2r;
        Wed, 17 May 2023 03:24:03 +0000 (GMT)
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        ira.weiny@intel.com, ks0204.kim@samsung.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl PATCH v2 2/2] cxl: add inject-poison & clear-poison commands
 to cxl tool
Date:   Wed, 17 May 2023 12:23:11 +0900
Message-Id: <20230517032311.19923-3-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517032311.19923-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTTPeyR0qKwckp6hZ3H19gs2ievJjR
        YvrUC4wW+58+Z7FYfHQGs8XRPRwW52edYrG4NeEYkwOHx+I9L5k8Nq3qZPPo27KK0ePzJrkA
        lqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
        2Rl3X4YXHPepOHdxKVsD40GbLkYODgkBE4lpe0y6GLk4hAR2MEqsubuUCcL5xCjx5voOZgjn
        M6PEk5Ymxi5GTrCOc69WQlXtYpTo/bmPFcJpZJKYf+IiE0gVm4C2xN/+6WAdIgKyEs3rHoB1
        MAvsZ5RYsXMLG0hCWCBKYv3mCcwgh7AIqEo87VQCCfMK2Ejs3D6dDWKbvMT+g2eZQWxOAVuJ
        o7tb2SBqBCVOznzCAmIzA9U0b50NdqqEwEt2id8XWlghml0kpi3YCXW2sMSr41vYIWwpic/v
        9kItyJeYenAiVLxEou3MASjbWOLdzeesILcxC2hKrN+lDwkvZYkjt6DW8kl0HP7LDhHmleho
        E4JoVJXYsuEF1BBpiaMTN7FA2B4Sd380QgN0AqPEtd8L2CcwKsxC8s0sJN/MQli8gJF5FaNY
        akFxbnpqsVGBETx+k/NzNzGC06SW2w7GKW8/6B1iZOJgPMQowcGsJMIb2JecIsSbklhZlVqU
        H19UmpNafIjRFBjUE5mlRJPzgYk6ryTe0MTSwMTMzNDcyNTAXEmcV9r2ZLKQQHpiSWp2ampB
        ahFMHxMHp1QDk/vqfev7XJWn93Zr3GH5Fns16XUZ8ykLrcs8s98zV5Tu3W2aHX5qcXXDwkdr
        njs9q1nxrv7q36y3wdtsFvmn2nCzRKj1ZwknBJxY8OexqEoQS739Q4eHqjfNilaXL/5nys7B
        rJnUnVvyIkJaTrrw2NG7E+KrrqgeLz7w996tD3cY03u70o4yWbZN9O62/aS27Ks/z9IFcjrV
        J/MvbHloffz9M9m8mjXzcp5ndc55t3tuyOSgPQeub+1ZtMD4snvYv4+tNpr3b59es798lqFE
        3+TyWQLNASqOJ6wNTn2adilysVrbUWtDr0lp4aWTnlxx1H4ZFJjSfzZ42v9dFZN0jncKnhdd
        vr30WMPKwgTfiUosxRmJhlrMRcWJAMXHej0cBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSvO5lj5QUg6cv+CzuPr7AZtE8eTGj
        xfSpFxgt9j99zmKx+OgMZoujezgszs86xWJxa8IxJgcOj8V7XjJ5bFrVyebRt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGXdfhhcc96k4d3EpWwPjQZsuRk4OCQETiXOvVjJ1MXJxCAnsYJS4
        s34rM0RCWuLGoy42CFtY4n7LEVaIov+MErc3vgdLsAloS/ztn84IYosIyEo0r3sANolZ4Dij
        xI39u8ASwgIREl9/zWHvYuTgYBFQlXjaqQQS5hWwkdi5fTrUAnmJ/QfPgi3mFLCVOLq7FSwu
        BFTz4uFFRoh6QYmTM5+wgNjMQPXNW2czT2AUmIUkNQtJagEj0ypGydSC4tz03GLDAqO81HK9
        4sTc4tK8dL3k/NxNjOCQ1tLawbhn1Qe9Q4xMHIyHGCU4mJVEeAP7klOEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYBI7IJKwUfpFsI7diZOFSSs3L8/z
        utBR2Rjt+fGv3y0r0cf7PVc3nS77PmXxZdPf5+o0u24cD7434WVL6HT+l/on+Sver5I6wpxx
        U1jjy9yvVX05c3ecVq9teSE7Q+ZPRYDNvIwpPp8kX62+W/MyM6J+fti2FL+dd8UTznUzZK4Q
        Nmg5XHNq+prGT9aqq/VXPV5keTJo6f4QtZkJP49Xlc7csZUl0r3sy45wq2PFc/c/rZ4eZl/f
        leSSKqcRo7HawyB+9mPnAweDXie9jYyJNpXS4su91RIQE+Lr8y1p8SvuC2u0rO8oab3q0Jr4
        ZVPCVfeJfzq7TDwTqrbpqe7ecZxz/q3tM2tY+N+sF9yy45ESS3FGoqEWc1FxIgAdGd0v2AIA
        AA==
X-CMS-MailID: 20230517032403epcas2p48fbabf7aec3334b4892c87265b1a7705
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230517032403epcas2p48fbabf7aec3334b4892c87265b1a7705
References: <20230517032311.19923-1-junhyeok.im@samsung.com>
        <CGME20230517032403epcas2p48fbabf7aec3334b4892c87265b1a7705@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add new commands to cli tool, to inject and clear poison into dpa(-a) on the
memory device(memdev), and add man page documentation for the commands
(inject-poison, clear-poison).

Since the validity verification of the dpa would be done in
'cxl_validate_poison_dpa' of CXL driver, no additional logic is added
in this patch.

Also since it is expected no use case of injecting / clearing poison into the
same address for multiple devices, this command targets only one memdev,
like 'write-labels' command.

 usage: cxl {inject,clear}-poison <memdev> -a <dpa> [<options>]

    -v, --verbose         turn on debug
    -S, --serial          use serial numbers to id memdevs
    -a, --address <dpa>   DPA to inject or clear poison

Link to corresponding kernel patch:
- inject poison: https://lore.kernel.org/linux-cxl/241c64115e6bd2effed9c7a20b08b3908dd7be8f.1681874357.git.alison.schofield@intel.com/
- clear poison: https://lore.kernel.org/linux-cxl/8682c30ec24bd9c45af5feccb04b02be51e58c0a.1681874357.git.alison.schofield@intel.com/

Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>
---
 Documentation/cxl/cxl-clear-poison.txt  | 41 ++++++++++++
 Documentation/cxl/cxl-inject-poison.txt | 42 ++++++++++++
 Documentation/cxl/meson.build           |  2 +
 cxl/builtin.h                           |  2 +
 cxl/cxl.c                               |  2 +
 cxl/memdev.c                            | 85 ++++++++++++++++++++++++-
 6 files changed, 171 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/cxl/cxl-clear-poison.txt
 create mode 100644 Documentation/cxl/cxl-inject-poison.txt

diff --git a/Documentation/cxl/cxl-clear-poison.txt b/Documentation/cxl/cxl-clear-poison.txt
new file mode 100644
index 0000000..eabad00
--- /dev/null
+++ b/Documentation/cxl/cxl-clear-poison.txt
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-clear-poison(1)
+====================
+
+NAME
+----
+cxl-clear-poison - send clear poison command to specified CXL memdev
+                   targeting given DPA.
+
+SYNOPSIS
+--------
+[verse]
+'cxl clear-poison <memdev> -a <dpa> [<options>]'
+
+DESCRIPTION
+-----------
+Clear poison from the <dpa> of the <memdev>, and remove the address from the
+device's Poison List. Note that it is not an error to clear poison from an
+address that does not have poison set.
+
+OPTIONS
+-------
+<memory device>::
+        A 'memX' device name, or a memdev id number. Restrict the operation to
+        the specified memdev.
+
+-a::
+--address=::
+        Physical address of a CXL memdev to inject poison into.
+
+-S::
+--serial=::
+        Specify CXL memory device serial number(s) to filter the listing
+
+include::verbose-option.txt[]
+
+
+SEE ALSO
+--------
+CXL-3.0 8.2.9.8.4.3
diff --git a/Documentation/cxl/cxl-inject-poison.txt b/Documentation/cxl/cxl-inject-poison.txt
new file mode 100644
index 0000000..5a0fac2
--- /dev/null
+++ b/Documentation/cxl/cxl-inject-poison.txt
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-inject-poison(1)
+====================
+
+NAME
+----
+cxl-inject-poison - send inject poison command to specified CXL memdev
+                    targeting given DPA.
+
+SYNOPSIS
+--------
+[verse]
+'cxl inject-poison <memdev> -a <dpa> [<options>]'
+
+DESCRIPTION
+-----------
+Add the <dpa> to the <memdev> poison list and the error source shall be set
+to an injected error. In addition, the device shall add an appropriate poison
+creation event to its internal Informational Event Log, update the Event Status
+register, and if configured, interrupt the host.
+
+OPTIONS
+-------
+<memory device>::
+        A 'memX' device name, or a memdev id number. Restrict the operation to
+        the specified memdev.
+
+-a::
+--address=::
+        Physical address of a CXL memdev to inject poison into.
+
+-S::
+--serial=::
+        Specify CXL memory device serial number(s) to filter the listing
+
+include::verbose-option.txt[]
+
+
+SEE ALSO
+--------
+CXL-3.0 8.2.9.8.4.2
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index a6d77ab..c0067ab 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -46,6 +46,8 @@ cxl_manpages = [
   'cxl-enable-region.txt',
   'cxl-destroy-region.txt',
   'cxl-monitor.txt',
+  'cxl-inject-poison.txt',
+  'cxl-clear-poison.txt',
 ]
 
 foreach man : cxl_manpages
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 9baa43b..60b081c 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -22,6 +22,8 @@ int cmd_create_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_clear_poison(int argc, const char **argv, struct cxl_ctx *ctx);
 #ifdef ENABLE_LIBTRACEFS
 int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
 #else
diff --git a/cxl/cxl.c b/cxl/cxl.c
index 3be7026..359e619 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -77,6 +77,8 @@ static struct cmd_struct commands[] = {
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
 	{ "monitor", .c_fn = cmd_monitor },
+	{ "inject-poison", .c_fn = cmd_inject_poison },
+	{ "clear-poison", .c_fn = cmd_clear_poison },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 0b3ad02..d1fed3c 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -34,6 +34,7 @@ static struct parameters {
 	const char *type;
 	const char *size;
 	const char *decoder_filter;
+	const char *poison_address;
 } param;
 
 static struct log_ctx ml;
@@ -85,6 +86,10 @@ OPT_STRING('t', "type", &param.type, "type",                   \
 OPT_BOOLEAN('f', "force", &param.force,                        \
 	    "Attempt 'expected to fail' operations")
 
+#define POISON_OPTIONS()                                       \
+OPT_STRING('a', "address", &param.poison_address, "dpa",       \
+	   "DPA to inject or clear poison")
+
 static const struct option read_options[] = {
 	BASE_OPTIONS(),
 	LABEL_OPTIONS(),
@@ -135,6 +140,12 @@ static const struct option free_dpa_options[] = {
 	OPT_END(),
 };
 
+static const struct option poison_options[] = {
+	BASE_OPTIONS(),
+	POISON_OPTIONS(),
+	OPT_END(),
+};
+
 enum reserve_dpa_mode {
 	DPA_ALLOC,
 	DPA_FREE,
@@ -351,6 +362,42 @@ static int action_free_dpa(struct cxl_memdev *memdev,
 	return __reserve_dpa(memdev, DPA_FREE, actx);
 }
 
+static int action_inject_poison(struct cxl_memdev *memdev,
+				struct action_context *actx)
+{
+	int rc;
+
+	if (!param.poison_address) {
+		log_err(&ml, "%s: set dpa to inject poison.\n",
+			cxl_memdev_get_devname(memdev));
+		return -EINVAL;
+	}
+	rc = cxl_memdev_inject_poison(memdev, param.poison_address);
+	if (rc < 0) {
+		log_err(&ml, "%s: inject poison failed: %s\n",
+			cxl_memdev_get_devname(memdev), strerror(-rc));
+	}
+	return rc;
+}
+
+static int action_clear_poison(struct cxl_memdev *memdev,
+			       struct action_context *actx)
+{
+	int rc;
+
+	if (!param.poison_address) {
+		log_err(&ml, "%s: set dpa to clear poison.\n",
+			cxl_memdev_get_devname(memdev));
+		return -EINVAL;
+	}
+	rc = cxl_memdev_clear_poison(memdev, param.poison_address);
+	if (rc < 0) {
+		log_err(&ml, "%s: clear poison failed: %s\n",
+			cxl_memdev_get_devname(memdev), strerror(-rc));
+	}
+	return rc;
+}
+
 static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
 {
 	if (!cxl_memdev_is_enabled(memdev))
@@ -755,7 +802,9 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 				continue;
 			found = true;
 
-			if (action == action_write) {
+			if ((action == action_write) ||
+			    (action == action_inject_poison) ||
+			    (action == action_clear_poison)) {
 				single = memdev;
 				rc = 0;
 			} else
@@ -771,9 +820,17 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	}
 	rc = err;
 
-	if (action == action_write) {
+	if ((action == action_write) || (action == action_inject_poison) ||
+	    (action == action_clear_poison)) {
 		if (count > 1) {
-			error("write-labels only supports writing a single memdev\n");
+			if (action == action_write) {
+				error("write-labels only supports writing "
+				      "a single memdev\n");
+			} else {
+				error("poison command only supports injecting "
+				      "or clearing poison into a single "
+				      "memdev\n");
+			}
 			usage_with_options(u, options);
 			return -EINVAL;
 		} else if (single) {
@@ -893,3 +950,25 @@ int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_inject_poison(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(
+		argc, argv, ctx, action_inject_poison, poison_options,
+		"cxl inject-poison <memdev> -a <dpa> [<options>]");
+	log_info(&ml, "inject-poison %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
+
+int cmd_clear_poison(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(
+		argc, argv, ctx, action_clear_poison, poison_options,
+		"cxl clear-poison <memdev> -a <dpa> [<options>]");
+	log_info(&ml, "clear-poison %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.34.1

