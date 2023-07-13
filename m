Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC6FC001DE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 20:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjGMUbm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjGMUbl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 16:31:41 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31C2127
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 13:31:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 71FA6760369;
        Thu, 13 Jul 2023 20:31:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CA6C77610EF;
        Thu, 13 Jul 2023 20:31:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689280297; a=rsa-sha256;
        cv=none;
        b=i3atl4pMOsei3OF4TiuudM3CRCQUn/X3MNk/hVxMSbT9UomyAOcPxoaAsItQutt9meOPpW
        dV4JULOTYKpRGmhHqGiF/6HmX1CEVhD7eH4eFI58bNcp0AQpO58vZ4UQG6LiuS0RV6Q7Fi
        N5JY7Y+pRHSLGRQsQtt9PuHr6FQNlyrOeF86BM34dg2O9vzYIK1Xx4tjCUcqyEP8GA/hYb
        oRSRSaRTSW7qHSCUicwOzSzG+xAef5t0p01M1jTTNRBloQkOUBbhgu41hYNwleYwyhjUtI
        bqEO3DR/gDS02LR0MmL7JP8sNCJcP6peMq7sUGi7b+dJMyEpWF6Xzlm8qU0SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689280297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=8iK7VQZo8wlFb2JaEFkfNE9z7domL1xoToRSBiUP9jE=;
        b=wtzlVT4jdzAbbuYrIvJaIly9NMNTVgAaQ2zxPICiaPEMBvmikCn2xdIj6Br8PE4jEYbrtn
        ex1SSJ7m4p5dtWDgFJja5lAhcAH7nc6X5QAcywWqEQMYNbv7uaNmp+8vo0UFaZ8m8YLBKZ
        ChAu+fDH6uTL3kZA8QrezXjcNF+slRDTDMLaGajIoK7W2L4eanN/Pmddd2Z177M1sJq2G8
        n4OtxyGp9wboPJeriS1p8bHASpadOGiRco0kFkBfXfT8kj6XTmdFiNrlyrS1zF0Mjt0Y5v
        eqBWaN1UzVt/ON9zaLoqBtwVNl99a42Xxt24wwp75kDCxvF8HvqzyjHUOhG1+A==
ARC-Authentication-Results: i=1;
        rspamd-5595f87fc9-2879x;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Well-Made: 3d4d93b44744c33f_1689280298126_769653654
X-MC-Loop-Signature: 1689280298126:2457961366
X-MC-Ingress-Time: 1689280298126
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.146.72 (trex/6.9.1);
        Thu, 13 Jul 2023 20:31:38 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4R25qY16krzb9;
        Thu, 13 Jul 2023 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689280297;
        bh=8iK7VQZo8wlFb2JaEFkfNE9z7domL1xoToRSBiUP9jE=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=YWnKxsDMTAOT7AL7Zql0HJBvE+l9c3XHeuyZt7MBltSJfEotxn9u4N6ZlMttUv716
         HBtHogs+bmP7IqgCF+QrviLTVl2TFLIz2h1/samlgFmihnLKvaRszB8z3XyN+qRjWN
         +J/Knnw/rw0pmk8Tm7/hqRgYCk5aE5ZutzMhVwqRtFYekBRf1Ua57Ip8NAGooZmivj
         yGtE2qw/61sFVcB+jNSyrXu546SZMNlH/xiGvCT/PkQzKTxKJOS3UJnOaLBh2nCW0v
         vuPj/aHezM2oh4CqMNyRhe5ewsbYCZIxQUvj1YzA+xxG/irsPZgtzNnFg1VDQ54HGB
         2XeHUAX914rhA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     vishal.l.verma@intel.com
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl/memdev: Introduce wait-sanitize functionality
Date:   Thu, 13 Jul 2023 12:54:50 -0700
Message-ID: <20230713195455.19769-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713195455.19769-1-dave@stgolabs.net>
References: <20230713195455.19769-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a new cxl_memdev_wait_sanitize() to libcxl to support
waiting for sanitize operation to be done in the background,
if any.

This is analogous to 'ndctl wait-overwrite'.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/cxl/cxl-wait-sanitize.txt | 35 +++++++++++
 Documentation/cxl/lib/libcxl.txt        |  1 +
 Documentation/cxl/meson.build           |  1 +
 cxl/builtin.h                           |  1 +
 cxl/cxl.c                               |  1 +
 cxl/lib/libcxl.c                        | 78 +++++++++++++++++++++++++
 cxl/lib/libcxl.sym                      |  5 ++
 cxl/libcxl.h                            |  1 +
 cxl/memdev.c                            | 26 +++++++++
 9 files changed, 149 insertions(+)
 create mode 100644 Documentation/cxl/cxl-wait-sanitize.txt

diff --git a/Documentation/cxl/cxl-wait-sanitize.txt b/Documentation/cxl/cxl-wait-sanitize.txt
new file mode 100644
index 000000000000..365b11597afd
--- /dev/null
+++ b/Documentation/cxl/cxl-wait-sanitize.txt
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-wait-sanitize(1)
+====================
+
+NAME
+----
+cxl-wait-sanitize - wait for a sanitization operation to complete
+
+SYNOPSIS
+--------
+[verse]
+'cxl wait-sanitize' <mem0> [<mem1>..<memN>] [<options>]
+
+DESCRIPTION
+-----------
+The kernel provides a POLL(2) capable sysfs file ('security/state') to
+indicate the state of device sanitization. When sanitization is in progress,
+this command waits for a change in the state of this file across all
+specified memdevs.
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
+-v::
+--verbose::
+	Emit debug messages.
+
+include::../copyright.txt[]
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 31bc85511270..3ea816bde471 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -135,6 +135,7 @@ int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 					  unsigned long long volatile_size);
+int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev);
 
 ----
 
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index a6d77ab8cbc2..ebf214ae30df 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -45,6 +45,7 @@ cxl_manpages = [
   'cxl-disable-region.txt',
   'cxl-enable-region.txt',
   'cxl-destroy-region.txt',
+  'cxl-wait-sanitize.txt',
   'cxl-monitor.txt',
 ]
 
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 9baa43b8a2ac..04f613703eac 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -22,6 +22,7 @@ int cmd_create_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx);
 #ifdef ENABLE_LIBTRACEFS
 int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
 #else
diff --git a/cxl/cxl.c b/cxl/cxl.c
index 3be7026f43d3..bf55e8bcb2f7 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -76,6 +76,7 @@ static struct cmd_struct commands[] = {
 	{ "enable-region", .c_fn = cmd_enable_region },
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
+	{ "wait-sanitize", .c_fn = cmd_wait_sanitize },
 	{ "monitor", .c_fn = cmd_monitor },
 };
 
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 769cd8a75de9..172dfb47a2dd 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <dirent.h>
 #include <unistd.h>
+#include <poll.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
@@ -3968,6 +3969,83 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 	return cmd;
 }
 
+CXL_EXPORT int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	struct pollfd fds;
+	char buf[SYSFS_ATTR_SIZE];
+	int fd = 0, rc;
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len;
+
+	if (snprintf(path, len,
+		     "%s/security/state", memdev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+		    cxl_memdev_get_devname(memdev));
+		return -ERANGE;
+	}
+
+	fd = open(path, O_RDONLY|O_CLOEXEC);
+	if (fd < 0) {
+		rc = -errno;
+		err(ctx, "open: %s\n", strerror(errno));
+		return rc;
+	}
+	memset(&fds, 0, sizeof(fds));
+	fds.fd = fd;
+
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc < 0) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+	/* skipping if we aren't in sanitize state */
+	if (strncmp(buf, "sanitize", 8) != 0) {
+		rc = 0;
+		goto out;
+	}
+
+	for (;;) {
+		rc = sysfs_read_attr(ctx, path, buf);
+		if (rc < 0) {
+			rc = -EOPNOTSUPP;
+			break;
+		}
+
+		if (strncmp(buf, "sanitize", 8) == 0) {
+			rc = poll(&fds, 1, -1);
+			if (rc < 0) {
+				rc = -errno;
+				err(ctx, "poll error: %s\n", strerror(errno));
+				break;
+			}
+			dbg(ctx, "poll wake: revents: %d\n", fds.revents);
+			if (pread(fd, buf, 1, 0) == -1) {
+				rc = -errno;
+				break;
+			}
+			fds.revents = 0;
+		} else {
+			if (strncmp(buf, "disabled", 8) == 0)
+				rc = 1;
+			break;
+		}
+	}
+
+	if (rc == 1)
+		dbg(ctx, "%s: sanitize complete\n",
+		    cxl_memdev_get_devname(memdev));
+	else if (rc == 0)
+		dbg(ctx, "%s: sanitize skipped\n",
+		    cxl_memdev_get_devname(memdev));
+	else
+		dbg(ctx, "%s: sanitize error waiting for complete\n",
+		    cxl_memdev_get_devname(memdev));
+ out:
+	close(fd);
+	return rc;
+}
+
 CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
 {
 	struct cxl_memdev *memdev = cmd->memdev;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index c6545c717d50..efc7c1090a5c 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -250,3 +250,8 @@ global:
 	cxl_region_get_daxctl_region;
 	cxl_port_get_parent_dport;
 } LIBCXL_4;
+
+LIBCXL_6 {
+global:
+	cxl_memdev_wait_sanitize;
+} LIBCXL_5;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0218d730298f..c1656cb77103 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -416,6 +416,7 @@ unsigned long long cxl_cmd_partition_get_next_volatile_size(struct cxl_cmd *cmd)
 unsigned long long cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 		unsigned long long volatile_size);
+int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev);
 
 enum cxl_setpartition_mode {
 	CXL_SETPART_NEXTBOOT,
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 0b3ad0223bec..3134a6f6ab27 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -135,6 +135,11 @@ static const struct option free_dpa_options[] = {
 	OPT_END(),
 };
 
+static const struct option wait_sanitize_options[] = {
+	BASE_OPTIONS(),
+	OPT_END(),
+};
+
 enum reserve_dpa_mode {
 	DPA_ALLOC,
 	DPA_FREE,
@@ -653,6 +658,16 @@ out_err:
 	return rc;
 }
 
+static int action_wait_sanitize(struct cxl_memdev *memdev,
+				struct action_context *actx)
+{
+	/*
+	 * It's perfectly ok for the device to be active
+	 * or enabled, so no need to check anything here.
+	 */
+	return cxl_memdev_wait_sanitize(memdev);
+}
+
 static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 			 int (*action)(struct cxl_memdev *memdev,
 				       struct action_context *actx),
@@ -893,3 +908,14 @@ int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(argc, argv, ctx, action_wait_sanitize,
+		wait_sanitize_options,
+		"cxl wait-sanitize <mem0> [<mem1>..<memn>] [<options>]");
+	log_info(&ml, "sanitization completed on %d mem device%s\n",
+		 count >= 0 ? count : 0, count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.41.0

