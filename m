Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D1BC0015E
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 20:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGMUjY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGMUjX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 16:39:23 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0011FD6
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 13:39:20 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2C1F276174C;
        Thu, 13 Jul 2023 20:31:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5F33C761C49;
        Thu, 13 Jul 2023 20:31:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689280298; a=rsa-sha256;
        cv=none;
        b=f32crOo3j7ervAoUStBVqcsP0EH3ZNi588zbZVMmsKHsXs4Lf/SGo9Ndq57vdTuF214Ik6
        g+ngdYU7lh0sIcfbgEp1dM6jXazIg2GBBVjr4ZIQuF/RZjJY60yIWocbr3v9HvUrVqrpR/
        35m6T+LoLn4+iaDE6Fk4JyCZf8Dcp5fqNIW9y9QdVt05gJZSu3vbxgfxLYW5cxkuQThOfv
        winv5ksDKPgoQzmIEEZmEXbPuCAMp+zKWbdtcLIuV26kdQIUeJ9R4jcqjs93dPO68cZm28
        vQKwWl64T19nlG/jc9M8O1mrOihK0w2i3CiQpni9dwhAcgwwm2BRl27mgC7Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689280298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=abWmoXIoyXnjyYpzH9e7OVwoCJ2o9Y9oHyilSP3W3Ss=;
        b=xnbCih6SNVdiZ4Gc+uRA4J15r+QJEOnzjHKcnsDY4PiIkoQ8fZb+dF9QL6xohFchZBj2oL
        RmQ2wcZqMeIFnMFB3cWCmQth1egwfddmPEbEncgJKE5fhyq49ixsrzDffnic2JyHMnc82M
        rnrpUXjcmXXkGmc7osyQX4IJS0qRTxdUmUOj3b31Z0r9scBGEoXoCqphDPA2oD/QJ9i4tE
        awvot4Rixxt4dbsNY+DfcpiQEsJijByRCGxEnnwSsIQM+SQKceF89bnMYRQ70x4PLrwZwi
        1HzXHoIbs3ad846yT7XXK/m5FoiVSDgYxI0BLQorNPaNgDmqHUD7e4LG/tUVnQ==
ARC-Authentication-Results: i=1;
        rspamd-7d9c4d5c9b-9tzkb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Battle-Interest: 12d9a35467c2d46e_1689280298771_769667390
X-MC-Loop-Signature: 1689280298770:2734522043
X-MC-Ingress-Time: 1689280298770
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.163.61 (trex/6.9.1);
        Thu, 13 Jul 2023 20:31:38 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4R25qY5LLQzvr;
        Thu, 13 Jul 2023 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689280298;
        bh=abWmoXIoyXnjyYpzH9e7OVwoCJ2o9Y9oHyilSP3W3Ss=;
        h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
        b=bCgfXvvN2gxgYZbcZtBFAf1TEp4JvJlTpZmKyCMf+wV3LttY6UKCKfa0/6sPOlfQK
         v6Ejo2dkh2Ef1Ty5FxRfrVU8eARVVN7HjyuhjNnXs7l16k3OGkj31hlfS6xn9/waJ0
         tc67ebSlxPdbzCNZZpZX8yAJQ+9aza4/0Cm8AnqZooPlLfQIkMDTWTQhEiZ3UFBgm1
         MHcOcWEnf+U4bsALA61uQ6A2hUxciLkfmyBRKoBdQo7AB/eYIGoA1HvzFo62451eCc
         oWXjPGTTUB2/Yr/8IF14scXWaaSCRvl0FjrKM9Nd7gsVyN2M+1tw9vQ9prDyGY6xuT
         1XHoR5WJADZ7g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     vishal.l.verma@intel.com
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/memdev: Introduce sanitize-memdev functionality
Date:   Thu, 13 Jul 2023 12:54:51 -0700
Message-ID: <20230713195455.19769-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713195455.19769-1-dave@stgolabs.net>
References: <20230713195455.19769-1-dave@stgolabs.net>
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
 Documentation/cxl/cxl-sanitize-memdev.txt | 68 +++++++++++++++++++++++
 Documentation/cxl/cxl-wait-sanitize.txt   |  4 ++
 Documentation/cxl/lib/libcxl.txt          |  1 +
 Documentation/cxl/meson.build             |  1 +
 cxl/builtin.h                             |  1 +
 cxl/cxl.c                                 |  1 +
 cxl/lib/libcxl.c                          | 16 ++++++
 cxl/lib/libcxl.sym                        |  1 +
 cxl/libcxl.h                              |  1 +
 cxl/memdev.c                              | 47 ++++++++++++++++
 10 files changed, 141 insertions(+)
 create mode 100644 Documentation/cxl/cxl-sanitize-memdev.txt

diff --git a/Documentation/cxl/cxl-sanitize-memdev.txt b/Documentation/cxl/cxl-sanitize-memdev.txt
new file mode 100644
index 000000000000..25aa3f55b789
--- /dev/null
+++ b/Documentation/cxl/cxl-sanitize-memdev.txt
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-sanitize-memdev(1)
+======================
+
+NAME
+----
+cxl-sanitize-memdev - Perform a cryptographic destruction or sanitization
+of the contents of the given memdevs.
+
+SYNOPSIS
+--------
+[verse]
+'cxl sanitize-memdev' <mem0> [<mem1>..<memN>] [<options>]
+
+DESCRIPTION
+-----------
+The 'sanitize-memdev' command performs two different methods of
+sanitization, per the CXL 3.0+ specification. It is required that
+the memdev be disabled before sanitizing, such that the device
+cannot be actively decoding any HPA ranges at the time. This
+permits avoiding explicit global CPU cache management, relying
+instead on the implict cache flushing when a region transitions
+between active to commited.
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
+	With this option, the sanitization request is merely submitted to the
+	kernel, and the completion is asynchronous. Depending on the medium and
+	capacity, sanitize may take tens of minutes to many hours. Subsequently,
+	'cxl wait-sanitize’ can be used to wait for the memdevs that are under
+	the sanitization.
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
index 365b11597afd..8bf38318eb3b 100644
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
index 3ea816bde471..a72c827a2821 100644
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
index 172dfb47a2dd..baf2a917ea6c 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -4046,6 +4046,22 @@ CXL_EXPORT int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev)
 	return rc;
 }
 
+int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len;
+
+	if (snprintf(path, len,
+		     "%s/security/%s", memdev->dev_path, op) >= len) {
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
index efc7c1090a5c..d2431e26f211 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -254,4 +254,5 @@ global:
 LIBCXL_6 {
 global:
 	cxl_memdev_wait_sanitize;
+	cxl_memdev_sanitize;
 } LIBCXL_5;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index c1656cb77103..e29b2d8b0412 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -417,6 +417,7 @@ unsigned long long cxl_cmd_partition_get_next_persistent_size(struct cxl_cmd *cm
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 		unsigned long long volatile_size);
 int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev);
+int cxl_memdev_sanitize(struct cxl_memdev *memdev, const char *op);
 
 enum cxl_setpartition_mode {
 	CXL_SETPART_NEXTBOOT,
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 3134a6f6ab27..7e621c4c6bc6 100644
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
+	log_info(&ml, "sanitization started on %d mem device%s\n",
+		 count >= 0 ? count : 0, count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
-- 
2.41.0

