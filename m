Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0A4C77B76
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 02:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDWCbO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 22 Apr 2023 22:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWCbJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 22 Apr 2023 22:31:09 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033651717
        for <linux-cxl@vger.kernel.org>; Sat, 22 Apr 2023 19:31:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 54DEA761844;
        Sun, 23 Apr 2023 02:31:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BA986761881;
        Sun, 23 Apr 2023 02:31:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682217066; a=rsa-sha256;
        cv=none;
        b=0RCnVgPjX0B+EdIaNRfAHrPIoCheRYPiAJEKLu1jB4wlBzJ24z6TxvEHYCDRfkVSrtk/b5
        +H4mnbOhJxkDr8xAcR9dLIORqBZvlveJ3Bb+C+yiyCMrotXqruPQ/3cAwd7iOyaf2dQWOr
        xosSKPdh6qjy9cerZATKTppgffGc2F2q70+l6qsqseap4K+r68BfW65hYVXXWxJ1BHLQVA
        WXzAD5XOjXHtby0mCqmsh0DG0vvJWPig694XkW3FmRXHkCpqSJ0MiddGhici7x3H+YeoBy
        xIftrHti2Iy3H9yZTCaemBSMoXOcQOLBc/9O1VX7q5JLXQFxcT20CjwjS0MuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682217066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=qI3dzLC56et52B//iwEyUz9zZ9LbHYij3FBuSyHWU60=;
        b=LoqsDqmC14/UaNXGNS40aUULS4F1AB0/NssmGVHdhjcM+jM8qQx8/xZ5aIFszrcRNfw8b4
        QSi7YCfhZ/5BQjx5DDM3wxj0GdbslH2NC1u4ZX9h6v/OtwZMQekh9Gvt35QWF4LpmDLyBm
        m+bXwYv95AOeOEgNygT8tlwfMIIvxj65bMoyhCKGsIcIw8ImXmTnh2CodlISuDJSickDGI
        7w8JnAiWA7GGftKfvLThskgy0QB1OKcapHNtXdwiT1R/G84AsXg3ZNq+/xAYNdE+gWubDU
        JIwNwhtRTkE2vMujVvfO/CP+0FspuS5PqEteC+nUR+D7ZDaIAYg/0qzxxjNkcw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zn4rt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Tangy: 4282c47463b3814e_1682217067092_2891787587
X-MC-Loop-Signature: 1682217067092:1989321500
X-MC-Ingress-Time: 1682217067092
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.65 (trex/6.7.2);
        Sun, 23 Apr 2023 02:31:07 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4Q3shB2KfnzK5;
        Sat, 22 Apr 2023 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682217066;
        bh=qI3dzLC56et52B//iwEyUz9zZ9LbHYij3FBuSyHWU60=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=dRdqI7oAtdj3K/JSjWW8LAgIBznswFRoWgWz9D6jb4qb2HxCyBaiRSoz/0vIuZMPt
         7oSR31T+6+SKWIDm9BoJFokL0YKgJ7Xc1wAH5ZD8j66dgjGQLW5kHwNfKgZJYprM64
         Wc9NARgcyQmZONcB6JDAIGffhLfYF5I0CYN7+CK69YGcYiidnjBOLJN4lfdKFgy/dX
         DDeKcRMDKomHyBpPrdxTpN2FAQLJceaDQxzdQ/QQBcX0RGWmucg/zeqBPMZ/Klu4EW
         jE4C34/RkkHG2mdPozH0jynoVWzHDHXOAzbBeLVZIw6cIf/9McLkSmZFDzZeiYCbCb
         g7xILg0Zv2OnQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 1/2] cxl/memdev: Introduce wait-sanitize functionality
Date:   Sat, 22 Apr 2023 18:59:19 -0700
Message-Id: <20230423015920.11384-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230423015920.11384-1-dave@stgolabs.net>
References: <20230423015920.11384-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a new cxl_memdev_wait_sanitize() to libcxl to support
waiting for sanitation operation to be done in the background,
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
 cxl/lib/libcxl.sym                      |  1 +
 cxl/libcxl.h                            |  1 +
 cxl/memdev.c                            | 26 +++++++++
 9 files changed, 145 insertions(+)
 create mode 100644 Documentation/cxl/cxl-wait-sanitize.txt

diff --git a/Documentation/cxl/cxl-wait-sanitize.txt b/Documentation/cxl/cxl-wait-sanitize.txt
new file mode 100644
index 000000000000..c2ceae7ade0e
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
+cxl-wait-sanitize - wait for a sanitation operation to complete
+
+SYNOPSIS
+--------
+[verse]
+'cxl wait-sanitize' <mem0> [<mem1>..<memN>] [<options>]
+
+DESCRIPTION
+-----------
+The kernel provides a POLL(2) capable sysfs file ('security/sanitize') to
+indicate the state of device sanitation. When sanitation is in progress,
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
index f9af376137fa..9d98865e172c 100644
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
index 4859bd5e2fbb..f369f45271d5 100644
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
@@ -3851,6 +3852,83 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
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
+		     "%s/security/sanitize", memdev->dev_path) >= len) {
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
index 6bc0810152e0..bf7d38f7e6fe 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -70,6 +70,7 @@ global:
 	cxl_memdev_zero_label;
 	cxl_memdev_write_label;
 	cxl_memdev_read_label;
+	cxl_memdev_wait_sanitize;
 local:
         *;
 };
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index d699af859a86..c9c935126d4a 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -412,6 +412,7 @@ unsigned long long cxl_cmd_partition_get_next_volatile_size(struct cxl_cmd *cmd)
 unsigned long long cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 		unsigned long long volatile_size);
+int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev);
 
 enum cxl_setpartition_mode {
 	CXL_SETPART_NEXTBOOT,
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 0b3ad0223bec..4fc787ffe1e6 100644
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
+	log_info(&ml, "sanitation completed on %d mem device%s\n",
+		 count >= 0 ? count : 0, count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.40.0

