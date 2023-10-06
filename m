Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BF63AC
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1XyhiSq"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00616CA
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577508; x=1728113508;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/dpCvNzlJlvaPei/tDvzilDMHmjDl41Wdn+AH99cks=;
  b=j1XyhiSqT1pA5+9mEe1GRwXfIrlM4cvNWeCq8VA1lmVRGBkrIXkgUYmx
   QHmPrv9JSo5E8lO+3Ml+daHxJ+OKCjM+KPDeCrAyyCO44HdZJthF5lFV8
   jtr7M6kfVHWC7d/30UEODoXO7v3Y0An3NepKh3kfRtDUx0BO+lUYOkdBj
   ceYnKfk3jb0zcEIXmlQS2AFsmxyJBtvuP40E2TG4PLuXc2YMgxw3fXRrO
   BsU03ZDsTmu4ENcp4g89bGmqvaMKCSHLzPZAZaV4jK4Yaz5wXVMq4O0Tl
   WZlTJmPvxDcQ7WQ8zVG4JTiQ9J59I5YilCYVkX92/QYmTdO1AHWhKvN/n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775572"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775572"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842736334"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842736334"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:31:40 -0700
Subject: [ndctl PATCH 1/2] cxl/memdev: Add a wait-sanitize command
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 00:31:40 -0700
Message-ID: <169657750018.1491881.8156431995584336323.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657749402.1491881.12666757616880845510.stgit@dwillia2-xfh.jf.intel.com>
References: <169657749402.1491881.12666757616880845510.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In support of a regression test for the kernel's sanitize completion
notifier, add a "wait-sanitize" command and supporting infrastructure.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/cxl-wait-sanitize.txt |   44 ++++++++++++++++++++++
 Documentation/cxl/lib/libcxl.txt        |    5 ++
 Documentation/cxl/meson.build           |    1 
 cxl/builtin.h                           |    1 
 cxl/cxl.c                               |    1 
 cxl/lib/libcxl.c                        |   63 +++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym                      |    5 ++
 cxl/libcxl.h                            |    1 
 cxl/memdev.c                            |   34 ++++++++++++++++-
 9 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/cxl/cxl-wait-sanitize.txt

diff --git a/Documentation/cxl/cxl-wait-sanitize.txt b/Documentation/cxl/cxl-wait-sanitize.txt
new file mode 100644
index 000000000000..2745e37e3526
--- /dev/null
+++ b/Documentation/cxl/cxl-wait-sanitize.txt
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-wait-sanitize(1)
+======================
+
+NAME
+----
+cxl-wait-sanitize - wait for a sanitize operation to complete
+
+SYNOPSIS
+--------
+[verse]
+'cxl wait-sanitize <mem0> [<mem1>..<memN>] [<options>]'
+
+DESCRIPTION
+-----------
+
+A sanitize take several seconds to complete. Block and wait for the
+sanitize operation to complete.
+
+EXAMPLE
+-------
+----
+# cxl wait-sanitize mem0
+sanitize completed on 1 mem device
+----
+
+OPTIONS
+-------
+
+include::bus-option.txt[]
+
+-t::
+--timeout::
+	Milliseconds to wait before timing out and returning. Defaults
+	to 5000.
+
+include::verbose-option.txt[]
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-list[1],
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index 31bc85511270..95026dbf2a81 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -72,6 +72,7 @@ const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
 int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
+int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev);
 ----
 
 A memdev is given a kernel device name of the form "mem%d" where an id
@@ -93,6 +94,10 @@ device.
 cxl_memdev_get_numa_node() returns the affinitized CPU node number if
 available or -1 otherwise.
 
+cxl_memdev_wait_sanitize() if a sanitize operation is in-flight when
+this is called the program will block until the sanitize operation
+completes or the wait times out.
+
 === MEMDEV: Control
 ----
 int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index c5533572ef75..3d2c9d991c1b 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -47,6 +47,7 @@ cxl_manpages = [
   'cxl-destroy-region.txt',
   'cxl-monitor.txt',
   'cxl-update-firmware.txt',
+  'cxl-wait-sanitize.txt',
 ]
 
 foreach man : cxl_manpages
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 3ec6c6cb01be..526534ae7cd0 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -15,6 +15,7 @@ int cmd_enable_memdev(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_reserve_dpa(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_free_dpa(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_update_fw(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_port(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_port(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_set_partition(int argc, const char **argv, struct cxl_ctx *ctx);
diff --git a/cxl/cxl.c b/cxl/cxl.c
index e1524b808908..33ede59df684 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -69,6 +69,7 @@ static struct cmd_struct commands[] = {
 	{ "reserve-dpa", .c_fn = cmd_reserve_dpa },
 	{ "free-dpa", .c_fn = cmd_free_dpa },
 	{ "update-firmware", .c_fn = cmd_update_fw },
+	{ "wait-sanitize", .c_fn = cmd_wait_sanitize },
 	{ "disable-port", .c_fn = cmd_disable_port },
 	{ "enable-port", .c_fn = cmd_enable_port },
 	{ "set-partition", .c_fn = cmd_set_partition },
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index af4ca44eae19..51fbfa812363 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 // Copyright (C) 2020-2021, Intel Corporation. All rights reserved.
+#include <poll.h>
 #include <stdio.h>
 #include <errno.h>
 #include <limits.h>
@@ -1371,6 +1372,68 @@ CXL_EXPORT int cxl_memdev_get_id(struct cxl_memdev *memdev)
 	return memdev->id;
 }
 
+CXL_EXPORT int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev,
+					int timeout_ms)
+{
+	struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
+	const char *devname = cxl_memdev_get_devname(memdev);
+	char *path = memdev->dev_buf;
+	int len = memdev->buf_len;
+	struct pollfd fds = { 0 };
+	int fd = 0, rc;
+	char buf[9];
+
+	if (snprintf(path, len, "%s/security/state", memdev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return -ERANGE;
+	}
+
+	fd = open(path, O_RDONLY|O_CLOEXEC);
+	if (fd < 0) {
+		/* device does not support security operations */
+		if (errno == ENOENT)
+			return 0;
+		rc = -errno;
+		err(ctx, "%s: %s\n", path, strerror(errno));
+		return rc;
+	}
+	memset(&fds, 0, sizeof(fds));
+	fds.fd = fd;
+
+	rc = pread(fd, buf, sizeof(buf), 0);
+	if (rc < 0) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	/* skipping if not currently sanitizing */
+	if (strncmp(buf, "sanitize", 8) != 0) {
+		rc = 0;
+		goto out;
+	}
+
+	rc = poll(&fds, 1, timeout_ms);
+	if (rc == 0) {
+		dbg(ctx, "%s: sanitize timeout\n", devname);
+		rc = -ETIMEDOUT;
+	} else if (rc < 0) {
+		err(ctx, "%s: sanitize poll error: %s\n", devname, strerror(errno));
+		rc = -errno;
+	} else {
+		dbg(ctx, "%s: sanitize wake\n", devname);
+
+		rc = pread(fd, buf, sizeof(buf), 0);
+		if (rc < 0 || strncmp(buf, "sanitize", 8) == 0) {
+			err(ctx, "%s: sanitize wake error\n", devname);
+			rc = -ENXIO;
+		} else
+			rc = 0;
+	}
+out:
+	close(fd);
+	return rc;
+}
+
 CXL_EXPORT unsigned long long cxl_memdev_get_serial(struct cxl_memdev *memdev)
 {
 	return memdev->serial;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8fa1cca3d0d7..b69f9328e668 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -264,3 +264,8 @@ global:
 	cxl_memdev_update_fw;
 	cxl_memdev_cancel_fw_update;
 } LIBCXL_5;
+
+LIBCXL_7 {
+global:
+	cxl_memdev_wait_sanitize;
+} LIBCXL_6;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0f4f4b2648fb..13532d5be931 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -77,6 +77,7 @@ bool cxl_memdev_fw_update_in_progress(struct cxl_memdev *memdev);
 size_t cxl_memdev_fw_update_get_remaining(struct cxl_memdev *memdev);
 int cxl_memdev_update_fw(struct cxl_memdev *memdev, const char *fw_path);
 int cxl_memdev_cancel_fw_update(struct cxl_memdev *memdev);
+int cxl_memdev_wait_sanitize(struct cxl_memdev *memdev, int timeout_ms);
 
 /* ABI spelling mistakes are forever */
 static inline const char *cxl_memdev_get_firmware_version(
diff --git a/cxl/memdev.c b/cxl/memdev.c
index f6a2d3f1fdca..d76a4d86a40a 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -38,7 +38,10 @@ static struct parameters {
 	const char *type;
 	const char *size;
 	const char *decoder_filter;
-} param;
+	int timeout;
+} param = {
+	.timeout = -1,
+};
 
 static struct log_ctx ml;
 
@@ -99,6 +102,10 @@ OPT_BOOLEAN('c', "cancel", &param.cancel,                            \
 OPT_BOOLEAN('w', "wait", &param.wait,                                \
 	    "wait for firmware update to complete before returning")
 
+#define WAIT_SANITIZE_OPTIONS()                 \
+OPT_INTEGER('t', "timeout", &param.timeout,    \
+	    "time in milliseconds to wait for overwrite completion (default: infinite)")
+
 static const struct option read_options[] = {
 	BASE_OPTIONS(),
 	LABEL_OPTIONS(),
@@ -155,6 +162,12 @@ static const struct option update_fw_options[] = {
 	OPT_END(),
 };
 
+static const struct option wait_sanitize_options[] = {
+	BASE_OPTIONS(),
+	WAIT_SANITIZE_OPTIONS(),
+	OPT_END(),
+};
+
 enum reserve_dpa_mode {
 	DPA_ALLOC,
 	DPA_FREE,
@@ -673,6 +686,12 @@ out_err:
 	return rc;
 }
 
+static int action_wait_sanitize(struct cxl_memdev *memdev,
+				struct action_context *actx)
+{
+	return cxl_memdev_wait_sanitize(memdev, param.timeout);
+}
+
 static int action_update_fw(struct cxl_memdev *memdev,
 			    struct action_context *actx)
 {
@@ -968,3 +987,16 @@ int cmd_update_fw(int argc, const char **argv, struct cxl_ctx *ctx)
 
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
+
+int cmd_wait_sanitize(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	int count = memdev_action(
+		argc, argv, ctx, action_wait_sanitize, wait_sanitize_options,
+		"cxl wait-sanitize <mem0> [<mem1>..<memn>] [<options>]");
+
+	log_info(&ml, "wait sanitize %s on %d mem device%s\n",
+		 count >= 0 ? "completed" : "failed", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
+
+	return count >= 0 ? 0 : EXIT_FAILURE;
+}

