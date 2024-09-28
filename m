Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A516BE2A
	for <linux-cxl@vger.kernel.org>; Sat, 28 Sep 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727560582; cv=pass; b=dfcpbFUVyurfK53iny1z+oSfU/wfEjRaor1uTbUmdKXRP5EUBWo/hlxDR16QdFunVBhXEIeEhq0q3Y1V8hlulYV7uB1hY7Urq8q34FwmwXR9uQAXLgiP06txayQshzJebt9Nst8wD/BtAlZHUcUpGhvoEdMUpuQt33sGmEhp7CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727560582; c=relaxed/simple;
	bh=qcMJiE07qyCiq0Ekzm6z6LjT3i9gP7lbIeaVSITo5j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UIVGpirDEVlASX6jcr8bKcQ1wSmVDT/t+Ix7n5K7HQDvRBM+kZPdU2ysgqbSaXTiosx+6Lrx+GLiue3ZSlL3MjgpHPt498zPU8+ge8/cJYCDS4D4I70vLaEpeToza2MA0E2x9jBT/PVZ2fZp/cGAedQmU6JpvHnHwpcyX/ugx8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pbeBur7O; arc=pass smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pbeBur7O"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BA7428C0BAB;
	Sat, 28 Sep 2024 21:18:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.96.176.68])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5BC0C8C0E36;
	Sat, 28 Sep 2024 21:18:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727558322; a=rsa-sha256;
	cv=none;
	b=9dhdcz9YvUYNmFMoL/vc7lHnaDDcN4m6X6hZE3WmMybSsyPwkhLT/05KjltmCVkIxJ+ZEi
	cxv2Z9veaYb6wF/FqoBQdkG9QBPmODt9ua47mWUaQxXbIdmICqhwuIq9c/hxk7UG1n/XWh
	k8+0XjfJEo0EQDtfv29kR7zt/NbRBAKITa0hL+fds+XfcNr5THoS90YtwhcitREXc2lL5r
	ODuJh12RA0+ACoQTgqs6JkPhwt2ug8r80kKqOMqhh5OGxS0w+PWdM2oj//YvD2MHSdx2Z+
	e1jg/OB8B7eZCekq1RiKfWNhRa1kCalHSlsx0fMuJ/pQDA/ibM8bVyq0MyNKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727558322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=2gyP/3RVJrpN3WX1sDtJjq1Ux69pcr/D5rzsVpuGRYc=;
	b=4hKJ6Z6Wc0Ej7rIYnVDuw4SSTBm+8UnYrRAJoLgz+D8gPpIcNjD8hVKj5vMsB3cTS8jwvd
	k+jTh6XUw51Fsg9C7E2Gtf4h5ezzGwQexfjrTQoBZcfCZyvZ+26T1vNQ6qldwzOASu0Lps
	BW3wwwxHq7OsV9/BJiCN6c3q0FtgkQ3gLz0K7Rrcn04D6z3EYmeXGKzhuNfXFzd9+hfdzO
	VmHlJ70vr2/cIhjOT9j4vLkRRVMgCnPDGPnEkpL/pGfQL3PRt9qbrS3+VyISEE5gx7PG0p
	Uhqdsc9n4ZUwabZ/nNEjWD4+EPpJ6MVDs7IEMi7Vhvg26NO/RHaEbsXhZHD6Hg==
ARC-Authentication-Results: i=1;
	rspamd-9d66c6866-fccfr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Imminent: 4d2fc4412a2b7149_1727558322621_535094238
X-MC-Loop-Signature: 1727558322621:1593947940
X-MC-Ingress-Time: 1727558322621
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.176.68 (trex/7.0.2);
	Sat, 28 Sep 2024 21:18:42 +0000
Received: from localhost.localdomain (unknown [172.58.113.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4XGKvP4jjDz80;
	Sat, 28 Sep 2024 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727558322;
	bh=2gyP/3RVJrpN3WX1sDtJjq1Ux69pcr/D5rzsVpuGRYc=;
	h=From:To:Cc:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=pbeBur7O9qPoo8RwrsP4h2WSWRBDj2l059ETh+hOy/F0OP6oAjbOqt2/GjT4Afhhe
	 yAIesvdt4vRIMpVmfzSZQu1R2kmnYFJUp5IoSJOigh6n6L8YhW8KYgBI2ywu4fKr8G
	 +bM1xiuVEnUuhEtUC8WH51OXFXZQXcQvTJ1RANpj5aKCRwtx9XmVpPoFGZTuvnf+Ra
	 4llqVuXUpqVD+5PbZjrFhNCQqemUlSDYRDswYQ/91Bt6vc6KvDAKRUDdlYNtRIUuv0
	 MctAho6Y8Mpmomsb0OFNAxKaQcV/2qftj5P4EVikpM1qOliD7XOPHZdh2jVEBW8kfP
	 1Jy2SJD/K9USg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: vishal.l.verma@intel.com
Cc: y-goto@fujitsu.com,
	dave.jiang@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH -ndctl] cxl/memdev: Introduce sanitize-memdev functionality
Date: Sat, 28 Sep 2024 14:16:42 -0700
Message-ID: <20240928211643.140264-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new cxl_memdev_sanitize() to libcxl to support triggering memory
device sanitation, in either Sanitize and/or Secure Erase, per the
CXL 3.0 spec.

This is analogous to 'ndctl sanitize-dimm'.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/cxl/cxl-sanitize-memdev.txt | 59 +++++++++++++++++++++++
 Documentation/cxl/meson.build             |  1 +
 cxl/builtin.h                             |  1 +
 cxl/cxl.c                                 |  1 +
 cxl/lib/libcxl.c                          | 15 ++++++
 cxl/lib/libcxl.sym                        |  1 +
 cxl/libcxl.h                              |  1 +
 cxl/memdev.c                              | 48 ++++++++++++++++++
 8 files changed, 127 insertions(+)
 create mode 100644 Documentation/cxl/cxl-sanitize-memdev.txt

diff --git a/Documentation/cxl/cxl-sanitize-memdev.txt b/Documentation/cxl/cxl-sanitize-memdev.txt
new file mode 100644
index 000000000000..22212898542a
--- /dev/null
+++ b/Documentation/cxl/cxl-sanitize-memdev.txt
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-sanitize-memdev(1)
+======================
+
+NAME
+----
+cxl-sanitize-memdev - Perform a cryptographic destruction or sanitization
+of the contents of the given memdev(s).
+
+SYNOPSIS
+--------
+[verse]
+'cxl sanitize-memdev <mem0> [<mem1>..<memN>] [<options>]'
+
+DESCRIPTION
+-----------
+The 'sanitize-memdev' command performs two different methods of
+sanitization, per the CXL 3.0+ specification. It is required that
+the memdev be disabled before sanitizing, such that the device
+cannot be actively decoding any HPA ranges at the time.
+
+The default is 'sanitize', but additionally, a 'secure-erase'
+option is available. If both types of operations are supplied,
+then the 'secure-erase' is performed before 'sanitize'.
+
+OPTIONS
+-------
+
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
+include::verbose-option.txt[]
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-wait-sanitize[1],
+linkcxl:cxl-disable-memdev[1],
+linkcxl:cxl-list[1],
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index 8085c1c2c87e..99e6ee782a1c 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -49,6 +49,7 @@ cxl_manpages = [
   'cxl-monitor.txt',
   'cxl-update-firmware.txt',
   'cxl-set-alert-config.txt',
+  'cxl-sanitize-memdev.txt',
   'cxl-wait-sanitize.txt',
 ]
 
diff --git a/cxl/builtin.h b/cxl/builtin.h
index c483f301e5e0..29c8ad2a0ad9 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -16,6 +16,7 @@ int cmd_reserve_dpa(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_update_fw(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_set_alert_config(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_sanitize_memdev(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_port(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_port(int argc, const char **argv, struct cxl_ctx *ctx);
diff --git a/cxl/cxl.c b/cxl/cxl.c
index 16436671dc53..9c9f217c5a93 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -80,6 +80,7 @@ static struct cmd_struct commands[] = {
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
 	{ "monitor", .c_fn = cmd_monitor },
+	{ "sanitize-memdev", .c_fn = cmd_sanitize_memdev },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 91eedd1c4688..4f44bf1b6185 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1414,6 +1414,21 @@ CXL_EXPORT int cxl_memdev_get_id(struct cxl_memdev *memdev)
 	return memdev->id;
 }
 
+CXL_EXPORT int cxl_memdev_sanitize(struct cxl_memdev *memdev, char *op)
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
+	return sysfs_write_attr(ctx, path, "1\n");
+}
+
 CXL_EXPORT int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev,
 					int timeout_ms)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 304d7fa735d4..89a4c63cb874 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -281,4 +281,5 @@ global:
 	cxl_memdev_get_ram_qos_class;
 	cxl_region_qos_class_mismatch;
 	cxl_port_decoders_committed;
+	cxl_memdev_sanitize;
 } LIBCXL_6;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index fc6dd0085440..a722bab8a65b 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -79,6 +79,7 @@ bool cxl_memdev_fw_update_in_progress(struct cxl_memdev *memdev);
 size_t cxl_memdev_fw_update_get_remaining(struct cxl_memdev *memdev);
 int cxl_memdev_update_fw(struct cxl_memdev *memdev, const char *fw_path);
 int cxl_memdev_cancel_fw_update(struct cxl_memdev *memdev);
+int cxl_memdev_sanitize(struct cxl_memdev *memdev, char *op);
 int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev, int timeout_ms);
 
 /* ABI spelling mistakes are forever */
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 6e44d1578d03..60d1515b19f3 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -35,6 +35,8 @@ static struct parameters {
 	bool align;
 	bool cancel;
 	bool wait;
+	bool sanitize;
+	bool secure_erase;
 	const char *type;
 	const char *size;
 	const char *decoder_filter;
@@ -160,6 +162,12 @@ OPT_STRING('\0', "pmem-err-alert",                                            \
 	   &param.corrected_pmem_err_alert, "'on' or 'off'",                  \
 	   "enable or disable corrected pmem error warning alert")
 
+#define SANITIZE_OPTIONS()			      \
+OPT_BOOLEAN('e', "secure-erase", &param.secure_erase, \
+	    "secure erase a memdev"),		      \
+OPT_BOOLEAN('s', "sanitize", &param.sanitize,	      \
+	    "sanitize a memdev")
+
 #define WAIT_SANITIZE_OPTIONS()                \
 OPT_INTEGER('t', "timeout", &param.timeout,    \
 	    "time in milliseconds to wait for overwrite completion (default: infinite)")
@@ -226,6 +234,12 @@ static const struct option set_alert_options[] = {
 	OPT_END(),
 };
 
+static const struct option sanitize_options[] = {
+	BASE_OPTIONS(),
+	SANITIZE_OPTIONS(),
+	OPT_END(),
+};
+
 static const struct option wait_sanitize_options[] = {
 	BASE_OPTIONS(),
 	WAIT_SANITIZE_OPTIONS(),
@@ -772,6 +786,27 @@ out_err:
 	return rc;
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
 static int action_wait_sanitize(struct cxl_memdev *memdev,
 				struct action_context *actx)
 {
@@ -1228,6 +1263,19 @@ int cmd_set_alert_config(int argc, const char **argv, struct cxl_ctx *ctx)
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
 
+int cmd_sanitize_memdev(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(
+		argc, argv, ctx, action_sanitize_memdev, sanitize_options,
+		"cxl sanitize-memdev <mem0> [<mem1>..<memn>] [<options>]");
+
+	log_info(&ml, "sanitize %s on %d mem device%s\n",
+		 count >= 0 ? "completed/started" : "failed",
+		 count >= 0 ? count : 0,  count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}
+
 int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx)
 {
 	int count = memdev_action(
-- 
2.46.1

