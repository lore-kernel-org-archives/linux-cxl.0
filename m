Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A71F0988
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334675; cv=pass; b=i41D7U3yblF0gVGS7Wl6H1mP+svhrHQt2JgPrT/f+ZTUQUCGtHXGJDLFg4BafA/LO0lKd6yjABJvHzf95CCcybHxUkEbhxKzGUPWltTBBtAlXD12Zn+vjETo4vhl+1q3z2LOn0By7njzQ/+JEO8185p99+P9Nzy8E/7KG0xvkh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334675; c=relaxed/simple;
	bh=rE6qz6SELhIYDmhSaxbCxkN1KPwJeoljBXe4VhH4jN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OpsdXpIEBsqP+SQ8i5QvcY7Wa2zCHVclisqmUECuF9QsjaSOYHHD4KrpR3P43uOOaQeKs33zUkx+9k0h1DJ7FZsMtOZe5uT+BOdWANAxwnakRFFTaU0XfESayYVJwqKVdbyKZANefjJyFGLBRXw5tVctAbP8NG8N7vNGqc8skZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D2F2F784014;
	Tue, 18 Mar 2025 21:51:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a205.dreamhost.com (100-114-55-81.trex-nlb.outbound.svc.cluster.local [100.114.55.81])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6D63F78375E;
	Tue, 18 Mar 2025 21:51:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742334672; a=rsa-sha256;
	cv=none;
	b=MIEB27+D4+IT4AbJGpir61SQojgz/W6sR7JW1/Nlh/f66d1Mj7NUkunS2CUXeWn1IB6+YV
	pwMmuA6RlNsyOiiXMriISPnvSgF1naIaKkF2v6mH4Y2IaYEuz6dCCfMDjJ9oMfQ96k1nso
	zExjDr5/U8/F+IISy+1bcLULrCbAtSMvAfGnNWHwdK/+vrmDuFKrQNcYXduzO5K0Rcap1C
	R0Lfsc+ZwMAv3D1pFFJQdg7B82QfI91XmWe4fHucjza4YpvCnAdUwMJSaNv8HJ3yqJDFZE
	3Q9JglHkA6m7+aR2djteOfEVxoM6VM1XiNVZJcpajG+vUgN6oG17HTT6OoED1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742334672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=simGjs+q/srhYwboM0nFgZa6Q8y2zmNm3U3lIRHIbwA=;
	b=2i/ZZ3eUQflmldAL9j8mFXAl8iXcHinbgazl+fGKMmoCLaiGX8XxM/qTl7WwzQs0WbrBmj
	cICoeYAiPAEyVtYH0c2wffvihDeSn7HvMRuOHXY+vNZgJFYBuGyBUhD3KfhMs9tld1wHnc
	tMBM16X+0IEhkfsk7Z/q/Mrg44z+V+xDkbQQv2pa452jipFPme6fjdlbgIinXaVRAWs8Tt
	dkuIrMC9Bb12loFSQR4usMp1iujwRVZKrTrY73DymE+LjkuJBeMHjPBwQRWGozdbM4tcS5
	gKT8sWapFN5qrPWHGq46vUYVrTa63e2gmT+htFeeNywE5pYs9UM0YFyXU5cQCw==
ARC-Authentication-Results: i=1;
	rspamd-588454d544-nrzgz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Snatch: 0ecb7af676d97a30_1742334672673_1095808589
X-MC-Loop-Signature: 1742334672673:2570646050
X-MC-Ingress-Time: 1742334672673
Received: from pdx1-sub0-mail-a205.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.55.81 (trex/7.0.2);
	Tue, 18 Mar 2025 21:51:12 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a205.dreamhost.com (Postfix) with ESMTPSA id 4ZHQX00llJz3j;
	Tue, 18 Mar 2025 14:51:12 -0700 (PDT)
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v3 -ndctl] cxl/memdev: Introduce sanitize-memdev functionality
Date: Tue, 18 Mar 2025 14:50:13 -0700
Message-Id: <20250318215013.560215-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new cxl_memdev_sanitize() to libcxl to support triggering memory
device sanitation, in either Sanitize and/or Secure Erase, per the
CXL 3.0 spec.

This is analogous to 'ndctl sanitize-dimm'.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes from v2: resend, corrupted patch file
Changes from v1:
 - remove '-s' option and allow sanitize and secure erase to
   be exclusive. (Vishal)
 - update cxl-sanitize test cases (Alison)
 - update wait-sanitize manpage to include sanitize-memdev cmd

 Documentation/cxl/cxl-wait-sanitize.txt |  1 +
 Documentation/cxl/meson.build           |  1 +
 cxl/builtin.h                           |  1 +
 cxl/cxl.c                               |  1 +
 cxl/lib/libcxl.c                        | 15 ++++++++++
 cxl/lib/libcxl.sym                      |  1 +
 cxl/libcxl.h                            |  1 +
 cxl/memdev.c                            | 38 +++++++++++++++++++++++++
 test/cxl-sanitize.sh                    |  4 +--
 9 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/Documentation/cxl/cxl-wait-sanitize.txt b/Documentation/cxl/cxl-wait-sanitize.txt
index e8f2044e4882..9391c66eec52 100644
--- a/Documentation/cxl/cxl-wait-sanitize.txt
+++ b/Documentation/cxl/cxl-wait-sanitize.txt
@@ -42,3 +42,4 @@ include::../copyright.txt[]
 SEE ALSO
 --------
 linkcxl:cxl-list[1],
+linkcxl:cxl-sanitize-memdev[1],
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
index 63aa4ef3acdc..d9dd37519aa4 100644
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
index 0c155a40ad47..bff45d47c29b 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -287,4 +287,5 @@ LIBECXL_8 {
 global:
 	cxl_memdev_trigger_poison_list;
 	cxl_region_trigger_poison_list;
+	cxl_memdev_sanitize;
 } LIBCXL_7;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0a5fd0e13cc2..e10ea741bf6d 100644
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
index 6e44d1578d03..4a2daab2bbe5 100644
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
@@ -160,6 +162,10 @@ OPT_STRING('\0', "pmem-err-alert",                                            \
 	   &param.corrected_pmem_err_alert, "'on' or 'off'",                  \
 	   "enable or disable corrected pmem error warning alert")
 
+#define SANITIZE_OPTIONS()			      \
+OPT_BOOLEAN('e', "secure-erase", &param.secure_erase, \
+	    "Secure Erase a memdev")
+
 #define WAIT_SANITIZE_OPTIONS()                \
 OPT_INTEGER('t', "timeout", &param.timeout,    \
 	    "time in milliseconds to wait for overwrite completion (default: infinite)")
@@ -226,6 +232,12 @@ static const struct option set_alert_options[] = {
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
@@ -772,6 +784,19 @@ out_err:
 	return rc;
 }
 
+static int action_sanitize_memdev(struct cxl_memdev *memdev,
+				  struct action_context *actx)
+{
+	int rc;
+
+	if (param.secure_erase)
+		rc = cxl_memdev_sanitize(memdev, "erase");
+        else
+		rc = cxl_memdev_sanitize(memdev, "sanitize");
+
+	return rc;
+}
+
 static int action_wait_sanitize(struct cxl_memdev *memdev,
 				struct action_context *actx)
 {
@@ -1228,6 +1253,19 @@ int cmd_set_alert_config(int argc, const char **argv, struct cxl_ctx *ctx)
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
diff --git a/test/cxl-sanitize.sh b/test/cxl-sanitize.sh
index 9c161014ccb7..8c5027ab9f48 100644
--- a/test/cxl-sanitize.sh
+++ b/test/cxl-sanitize.sh
@@ -45,7 +45,7 @@ count=${#active_mem[@]}
 set_timeout ${active_mem[0]} 2000
 
 # sanitize with an active memdev should fail
-echo 1 > /sys/bus/cxl/devices/${active_mem[0]}/security/sanitize && err $LINENO
+"$CXL" sanitize-memdev ${active_mem[0]} && err $LINENO
 
 # find an inactive mem
 inactive=""
@@ -67,7 +67,7 @@ done
 # secounds
 set_timeout $inactive 3000
 start=$SECONDS
-echo 1 > /sys/bus/cxl/devices/${inactive}/security/sanitize &
+"$CXL" sanitize-memdev $inactive || err $LINENO
 "$CXL" wait-sanitize $inactive || err $LINENO
 ((SECONDS > start + 2)) || err $LINENO
 
-- 
2.39.5

