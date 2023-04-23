Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA22C7618E
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 02:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDWCbO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 22:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDWCbK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 22:31:10 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC1E1BEB
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 19:31:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A1888340B48;
        Sun, 23 Apr 2023 02:31:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3B9AE340AAF;
        Sun, 23 Apr 2023 02:31:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682217067; a=rsa-sha256;
        cv=none;
        b=Q/7/A/spy5Xop8ylpXC+xhV55KfLtmGNYB8VWOWl3Mn31ePsyVlQlg85Tmkr5dUqOOz49A
        XA1HcANb9jcaX6rdgknMa3zIXKlYpDW6HVisjS1ElSZKP4ju/8j7t8azEwNQ3yaZEjgluW
        HCJpYjZvIOd4VTpGvyi3xjO9oSO88amsK2oSqGV4ye5cximOFqdH5202NW1rDbu3fxGzl6
        sMIv1aNNgJyCHQkqPJa1QRgH+NTAcZzBlu4dMxHQHIa/4NsLDt+jZtrLEuIn8k89ASWdYm
        EOwWCCIBo3brcD4zVGH7sN0yBrfIf6M2gLlxcDCt9gR7Xp+D3TrgZRDm1NU14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682217067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=SFfMuY+2Oj0njG94SPiTnO9QRryCM2lVxJPdKpV8+3Y=;
        b=pCPNAD7WRLCFy8I4vQHiWcic+mUImk/dTIVtNF/XQHrAshdP+eRmA7mEKDIUU6NBymOAXP
        hTN0vSB4DOkdPN1YXnAvvtgiPNaF2iTZLNvatPMse2gjL1axNpgkVVNrjIkWJ8wX4TKiVh
        8AZnmHNQGI+rLABj6qcGdsYDGJCBfuutI/UxonBIV7GP5KvEdWAVSVmhO+9aEklGYGHXiU
        +1Zop6pojD4mfganUAHQJeAHHaSATc2+u//6TcrDqw/ESLKCH/XJffUnGXzKqJViASRVEY
        WjzzBUhdCi3SSft8wpWNIcVy7MdtyMw+5BVn7irKwEigtyIF4YjbRaccYSvkAw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-wkztd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Average: 398a4c800db2cc86_1682217067499_1868177975
X-MC-Loop-Signature: 1682217067499:519153389
X-MC-Ingress-Time: 1682217067499
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.45 (trex/6.7.2);
        Sun, 23 Apr 2023 02:31:07 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4Q3shB5Ll9zPY;
        Sat, 22 Apr 2023 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682217067;
        bh=SFfMuY+2Oj0njG94SPiTnO9QRryCM2lVxJPdKpV8+3Y=;
        h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
        b=KL4K8ptavUDZFH3RCBQ1SLn+r7PCdamJ5BEdDpg10iDij+lQ52A2swtooV2Run5P2
         2mjiDM+Z3cZxFnE6n72kzyiZCUa1xy25kxr5sTVoCgV/O88yrAR6/6HwmlZzO/+sng
         7vF7FHgfmvjWbeGFyZ7yGyMZCuUoS0vkZ4/o/DQdkYOQWmfkGQ/fOo6dvRCOtKD4ri
         yvMSJxtwpTnXfPWBK7dIohNCyPxPdX6qEchFwVEbkZTqc9l3UQlWiS7BDpMFvJBvMZ
         3TGFsEWHNlLbCn2i51hIDlgOFq0k900EX8lPWQoPrelQp0zupWMWb+Ani/LWRtMyH0
         YokI1mh3JBwZw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Date:   Sat, 22 Apr 2023 18:59:20 -0700
Message-Id: <20230423015920.11384-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230423015920.11384-1-dave@stgolabs.net>
References: <20230423015920.11384-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a new cxl_memdev_sanitize() to libcxl to support triggering memory
device sanitation, in either Sanitize and/or Secure Erase, per the
CXL 3.0 specs.

This is analogous to 'ndctl sanitize-dimm'.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/cxl/cxl-sanitize-memdev.txt | 65 +++++++++++++++++++++++
 Documentation/cxl/cxl-wait-sanitize.txt   |  4 ++
 Documentation/cxl/lib/libcxl.txt          |  1 +
 Documentation/cxl/meson.build             |  1 +
 cxl/builtin.h                             |  1 +
 cxl/cxl.c                                 |  1 +
 cxl/lib/libcxl.c                          | 16 ++++++
 cxl/lib/libcxl.sym                        |  1 +
 cxl/libcxl.h                              |  1 +
 cxl/memdev.c                              | 47 ++++++++++++++++
 10 files changed, 138 insertions(+)
 create mode 100644 Documentation/cxl/cxl-sanitize-memdev.txt

diff --git a/Documentation/cxl/cxl-sanitize-memdev.txt b/Documentation/cxl/cxl-sanitize-memdev.txt
new file mode 100644
index 000000000000..194a9ad36778
--- /dev/null
+++ b/Documentation/cxl/cxl-sanitize-memdev.txt
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-sanitize-memdev(1)
+======================
+
+NAME
+----
+cxl-sanitize-memdev - Perform a cryptographic destruction or sanitation of
+the contents of the given memdevs.
+
+SYNOPSIS
+--------
+[verse]
+'cxl sanitize-memdev' <mem0> [<mem1>..<memN>] [<options>]
+
+DESCRIPTION
+-----------
+The 'sanitize-memdev' command performs two different methods of
+sanitation, per the CXL 3.0 specification. It is required that
+the memdev be disabled before sanitizing, such that the device
+cannot be actively decoding any HPA ranges at the time.
+
+The default is 'sanitize', but additionally, a 'secure-erase'
+option is available. If both types of operations are supplied,
+then the 'secure-erase' is performed before 'sanitize'.
+
+
+OPTIONS
+-------
+<memdev>::
+include::memdev-option.txt[]
+
+-b::
+--bus=::
+include::bus-option.txt[]
+
+-e::
+--secure-erase::
+	Erase user data by changing the media encryption keys for all user
+	data areas of the device.
+
+-s::
+--sanitize::
+	Sanitize the device to securely re-purpose or decommission it. This is
+	done by ensuring that all user data and meta data, whether it resides
+	in persistent capacity, volatile capacity, or the label storage area,
+	is made permanently unavailable by whatever means is appropriate for
+	the media type.
+
+	With this option, the sanitation request is merely submitted to the
+	kernel, and the completion is asynchronous. Depending on the medium and
+	capacity, sanitize may take tens of minutes to many hours. Subsequently,
+	'cxl wait-sanitize’ can be used to wait for the memdevs that are under
+	the sanitation.
+
+-v::
+--verbose::
+	Emit debug messages.
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-wait-sanitize[1]
+linkcxl:cxl-disable-memdev[1]
diff --git a/Documentation/cxl/cxl-wait-sanitize.txt b/Documentation/cxl/cxl-wait-sanitize.txt
index c2ceae7ade0e..7e56c5a3a0ca 100644
--- a/Documentation/cxl/cxl-wait-sanitize.txt
+++ b/Documentation/cxl/cxl-wait-sanitize.txt
@@ -33,3 +33,7 @@ include::bus-option.txt[]
 	Emit debug messages.
 
 include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-sanitize-memdev[1]
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 9d98865e172c..0aae0537aec8 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -136,6 +136,7 @@ struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 					  unsigned long long volatile_size);
 int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev);
+int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op);
 
 ----
 
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index ebf214ae30df..ba4e4077c09c 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -46,6 +46,7 @@ cxl_manpages = [
   'cxl-enable-region.txt',
   'cxl-destroy-region.txt',
   'cxl-wait-sanitize.txt',
+  'cxl-sanitize-memdev.txt',
   'cxl-monitor.txt',
 ]
 
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 04f613703eac..956a773ffd0e 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -23,6 +23,7 @@ int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_sanitize_memdev(int argc, const char **argv, struct cxl_ctx *ctx);
 #ifdef ENABLE_LIBTRACEFS
 int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
 #else
diff --git a/cxl/cxl.c b/cxl/cxl.c
index bf55e8bcb2f7..4520162ae4fc 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -77,6 +77,7 @@ static struct cmd_struct commands[] = {
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
 	{ "wait-sanitize", .c_fn = cmd_wait_sanitize },
+	{ "sanitize-memdev", .c_fn = cmd_sanitize_memdev },
 	{ "monitor", .c_fn = cmd_monitor },
 };
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index f369f45271d5..129d452ad989 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3929,6 +3929,22 @@ CXL_EXPORT int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev)
 	return rc;
 }
 
+int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len;
+
+	if (snprintf(path, len,
+		     "%s/security/%s", memdev->host_path, op)  >= len) {
+		err(ctx, "%s: buffer too small!\n",
+		    cxl_memdev_get_devname(memdev));
+		return -ERANGE;
+	}
+
+	return sysfs_write_attr(ctx, path, "1");
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index bf7d38f7e6fe..2b8b47fb89e5 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -71,6 +71,7 @@ global:
 	cxl_memdev_write_label;
 	cxl_memdev_read_label;
 	cxl_memdev_wait_sanitize;
+	cxl_memdev_sanitize;
 local:
         *;
 };
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index c9c935126d4a..4f105a0bb3d9 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -413,6 +413,7 @@ unsigned long long cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cm
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 		unsigned long long volatile_size);
 int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev);
+int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op);
 
 enum cxl_setpartition_mode {
 	CXL_SETPART_NEXTBOOT,
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 4fc787ffe1e6..e45dd7fc540f 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -31,6 +31,8 @@ static struct parameters {
 	bool serial;
 	bool force;
 	bool align;
+	bool sanitize;
+	bool secure_erase;
 	const char *type;
 	const char *size;
 	const char *decoder_filter;
@@ -85,6 +87,12 @@ OPT_STRING('t', "type", &param.type, "type",                   \
 OPT_BOOLEAN('f', "force", &param.force,                        \
 	    "Attempt 'expected to fail' operations")
 
+#define SANITIZE_OPTIONS()			      \
+OPT_BOOLEAN('e', "secure-erase", &param.secure_erase, \
+	    "secure erase a memdev"),		      \
+OPT_BOOLEAN('s', "sanitize", &param.sanitize,	      \
+	    "sanitize a memdev")
+
 static const struct option read_options[] = {
 	BASE_OPTIONS(),
 	LABEL_OPTIONS(),
@@ -140,6 +148,12 @@ static const struct option wait_sanitize_options[] = {
 	OPT_END(),
 };
 
+static const struct option sanitize_options[] = {
+	BASE_OPTIONS(),
+	SANITIZE_OPTIONS(),
+	OPT_END(),
+};
+
 enum reserve_dpa_mode {
 	DPA_ALLOC,
 	DPA_FREE,
@@ -668,6 +682,28 @@ static int action_wait_sanitize(struct cxl_memdev *memdev,
 	return cxl_memdev_wait_sanitize(memdev);
 }
 
+static int action_sanitize_memdev(struct cxl_memdev *memdev,
+				  struct action_context *actx)
+{
+	int rc = 0;
+
+	if (cxl_memdev_is_enabled(memdev))
+		return -EBUSY;
+
+	/* let Sanitize be the default */
+	if (!param.secure_erase && !param.sanitize)
+		param.sanitize = true;
+
+	if (param.secure_erase)
+		rc = cxl_memdev_sanitize(memdev, "erase");
+	if (param.sanitize)
+		rc = cxl_memdev_sanitize(memdev, "sanitize");
+	else
+		rc = -EINVAL;
+
+	return rc;
+}
+
 static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 			 int (*action)(struct cxl_memdev *memdev,
 				       struct action_context *actx),
@@ -919,3 +955,14 @@ int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_sanitize_memdev(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(argc, argv, ctx, action_sanitize_memdev,
+		sanitize_options,
+		"cxl sanitize-memdev <mem0> [<mem1>..<memn>] [<options>]");
+	log_info(&ml, "sanitation started on %d mem device%s\n",
+		 count >= 0 ? count : 0, count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.40.0

