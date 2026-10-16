Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90341A57D
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186980; cv=none; b=fBoY3OJc5HaQyZTgLuD8VuJoLpiJCA7wFL9cYxDEFQe5XuwQOgns+YsNsMaq4/0zIRRb250Xqa5EVa07gu0ZAdw1TTxn6xjemgiKIwyywC/Q8sxGI9J1fgjelMZ6sUu+JiVLOmS3py85azOWCfXgWtJ3Grq7ozyj8PqWEWH7r5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186980; c=relaxed/simple;
	bh=MaJyLKfEFkwt0tCY+isqmy8S4HZq1gBm/vsuIioFA0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3uaZeRnabp+OYkjba4yhPluU8aJGbjIVW2+BItQbPdhKiQFVmIUjQ8xjWYkyEmc2RdIF8LYkI5m5/3YGmouYp+Dru2fMoGsS3SndDFbGD/AYVgUCdEC9HOcddrbMgCOe8vxVA1KELDkAfXNT/Xw4b4JkycnagD+BLUgsU0hvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gPXLBhD8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gPXLBhD8"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f269e335eso43637385a.3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792186978; x=1792791778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7MJLgBfxx+DZnWh1hc6BeLSdrKP2xfVHQ/GKNMuuDIE=;
        b=gPXLBhD8nG7Q8OUgP9GgI0tmuNcALziVvYAgeq0LhsBjyXl/0L1XqHPfR+VYAlcpZ6
         tx3ZugCjeaNRnZh6d6UnpcySagr42jX//KfzrJ7Per51edh0AIa1qYb9i1Qmccwb5LyC
         +q1JJRJqBT8lpuOjcXD+Q2LxO2MnE6MJrXzsIE/5zvyZaxbnT57G1eLwD8TEKlDY38S3
         s1aQiILwBiFa/XxH0cdZyw/EoYeg1chi/0oLDpoRrP8ml37wyJ++b4E85pZAwVYrbFsK
         UPJh0KvcEAdEY9upexqiedIL54UAu9TGMDrt2FYKPtSGC4wFsgf7xBJJSEXRELfOOPmZ
         Q7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186978; x=1792791778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7MJLgBfxx+DZnWh1hc6BeLSdrKP2xfVHQ/GKNMuuDIE=;
        b=QrCFMGbRlV3rkL46p0Rwna+OackGxx5/1zGfNbhrdJyvfM9Nmj80wI8hqty8t2n+YL
         qW/V8G1zgErtCUNFhwlOl6CmjmP2/0tH8OIXhmfE00qLhb2vP1xpoUipNa0QGdUm9QDl
         ZY/NxKnedmHQPYqRiSqfRd0pJFKHAFV2PcLf43HMBu+F957nIX2Vecwvij724VAhidZ7
         gLew7Nc2+JNTqxIs+hdW5pjYgb9aQA4JgW1LjMqoMpmIm92zT4NfVZ6Nu6kEHcP+GNWL
         OWSu6TmUs6s5hHrUx/d9fWlN6Vi+TuWJrvY7+0lWEcaC8bJh44j8IE9HDeu3NrxZtegK
         BdDA==
X-Forwarded-Encrypted: i=1; AKwUvBxc7YCbv17WZ2RBvbGx+p3gZVuzRxxgIFazYpGWciA9RmS+ztBtaMZare0LhjLbEeILP6BqybDZNjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfWvxvuWe8Mv/Y8NhlXzzCsH7uDSBXl4lWWDwHmrO76QCm0SOf
	3DHae4LGmgKskiJNEEaVKArxmnfLfedbpcSBMwvMNFHd1SbU7fT5dEdwVtx4aGLNMFkVht6iSdz
	o6HeP5kY=
X-Gm-Gg: AYBFou3B77n0Nx86x6wl13BqDPYxHcjlnmVWFfNaOoBCIw+KuD98n4+HY5mSFuYKE69
	gU6Piq4wy0bqaZr5iNKima81SzzIEcJ0HHQZG47rtXmNYY9jA7GgpIiVxii+qB65RDSZeI+9BdU
	Tbvsf9Q3wGZN28WdJHfJsq+0HZDGjtE2nTMK0uxHE+v5qQNrQSsolVNNHaYD7bKjYYyneglMD+/
	/4o8uV06ul2infWPl/sFmjqOJx6Or3kt2g/ckQKFz/Yg1g5vS/BvKZjUX7WJknoepbU86FrW1Yc
	4nsjtSODE6qsTNSJDz9hpaLJRHochI2DuC6JpICSm9A4xWBHDKkyh5LIp09TgiY4KtBIQxKhcFH
	1WH5rkANA8nVvkZX6nMVksM/6LFjsMbeAhIdEhBrwvHs05/vU8uMzQa7G6A0JApcqeMXdY1P5w/
	6gxnfBLgrbOiItlXVqzwhoucWVlyM4CqKZ7DHYKHBkBNzMSzB+la5ooF9MUtCYGPgTRO2o+k8l7
	vIRr6Vc+tmxM7x5+6U0NxEbzu2wHPooQunsgg4vMT9Go+1cAn9lJ9CFzElf
X-Received: by 2002:a05:620a:7018:b0:93e:4d60:d389 with SMTP id af79cd13be357-93f29cccec2mr230239585a.25.1792186978398;
        Fri, 16 Oct 2026 14:42:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1a8ee1sm312622985a.34.2026.10.16.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:42:58 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH 3/6] daxctl: offline whole-device memory via atomic unplug when available
Date: Fri, 16 Oct 2026 17:42:45 -0400
Message-ID: <20261016214248.443247-4-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016214248.443247-1-gourry@gourry.net>
References: <20261016214248.443247-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gourry@gourry.net>

When the kernel provides daxX.Y/state, offline by writing 'unplugged'.
The kernel offlines and removes the whole device atomically, so no
agent can online blocks before a later unbind. On failure the device
is left unchanged.

The memory blocks are removed rather than left offline, including
when they are all offline already; 'daxctl online-memory' restores
them. If they are all offline and the unplug fails (e.g. no memory
hotremove support), this remains a no-op.

Unplugging a node's last memory removes its sysfs directory, so treat
a missing node directory as zero blocks when the device is unplugged.
'daxctl list' likewise omits 'movable' for a device with no blocks.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 daxctl/device.c        | 51 +++++++++++++++++++++++++++++++++++++++---
 daxctl/json.c          |  6 ++++-
 daxctl/lib/libdaxctl.c | 12 ++++++++--
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index fd84799..99c0d96 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -694,7 +694,8 @@ static int dev_offline_memory(struct daxctl_dev *dev)
 {
 	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
-	int num_sections, num_on, num_off, rc;
+	int num_sections, num_on, num_off, rc, unplug;
+	enum daxctl_kmem_state state;
 
 	if (!mem) {
 		fprintf(stderr, "%s: failed to get the memory object\n",
@@ -717,17 +718,61 @@ static int dev_offline_memory(struct daxctl_dev *dev)
 		return num_on;
 	}
 
+	/*
+	 * Unplug atomically where supported, even if already offline, so
+	 * no agent can online blocks before a later unbind.
+	 */
+	state = daxctl_dev_get_kmem_state(dev);
+	unplug = state != DAXCTL_KMEM_UNKNOWN && state != DAXCTL_KMEM_UNPLUGGED;
+
 	num_off = num_sections - num_on;
-	if (num_off == num_sections) {
+	if (num_off == num_sections && !unplug) {
 		fprintf(stderr, "%s: all memory sections (%d) already offline\n",
 			devname, num_off);
 		return 1;
 	}
-	if (num_off)
+	if (num_off && num_on)
 		fprintf(stderr, "%s: %d memory section%s already offline\n",
 			devname, num_off,
 			num_off == 1 ? "" : "s");
 
+	if (unplug) {
+		rc = daxctl_dev_set_kmem_state(dev, DAXCTL_KMEM_UNPLUGGED);
+		if (rc < 0 && num_on == 0) {
+			/* already offline, unplug is best effort */
+			if (param.verbose)
+				fprintf(stderr, "%s: unplug failed: %s\n",
+					devname, strerror(-rc));
+			fprintf(stderr, "%s: all memory sections (%d) already offline\n",
+				devname, num_off);
+			return 1;
+		}
+		if (rc < 0) {
+			fprintf(stderr, "%s: failed to offline memory: %s\n",
+				devname, strerror(-rc));
+			return rc;
+		}
+		if (param.verbose)
+			fprintf(stderr, "%s: %d memory section%s unplugged\n",
+				devname, num_sections,
+				num_sections == 1 ? "" : "s");
+
+		/* blocks are removed, none should remain online */
+		num_on = daxctl_memory_is_online(mem);
+		if (num_on < 0) {
+			fprintf(stderr, "%s: failed to determine online state: %s\n",
+				devname, strerror(-num_on));
+			return num_on;
+		}
+		if (num_on) {
+			fprintf(stderr, "%s: failed to offline %d memory sections\n",
+				devname, num_on);
+			return -ENXIO;
+		}
+
+		return 0;
+	}
+
 	/* offline the remaining sections */
 	rc = daxctl_memory_offline(mem);
 	if (rc < 0) {
diff --git a/daxctl/json.c b/daxctl/json.c
index 8da91b1..cf81fe6 100644
--- a/daxctl/json.c
+++ b/daxctl/json.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2015-2020 Intel Corporation. All rights reserved.
+#include <errno.h>
 #include <limits.h>
 #include <string.h>
 #include <util/json.h>
@@ -79,7 +80,10 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 		if (jobj)
 			json_object_object_add(jdev, "total_memblocks", jobj);
 
-		movable = daxctl_memory_is_movable(mem);
+		/* an unplugged device has no zone */
+		movable = -ENXIO;
+		if (num_sections > 0)
+			movable = daxctl_memory_is_movable(mem);
 		if (movable == 1)
 			jobj = json_object_new_boolean(true);
 		else if (movable == 0)
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index cbb42e3..eedf4dd 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1644,8 +1644,16 @@ static int daxctl_memory_op(struct daxctl_memory *mem, enum memory_op op)
 	}
 
 	node_dir = opendir(node_path);
-	if (!node_dir)
-		return -errno;
+	if (!node_dir) {
+		rc = -errno;
+		/* unplugging a node's last memory removes its directory */
+		if (rc == -ENOENT &&
+		    daxctl_dev_get_kmem_state(dev) == DAXCTL_KMEM_UNPLUGGED) {
+			dbg(ctx, "%s: unplugged, no blocks to count\n", devname);
+			return 0;
+		}
+		return rc;
+	}
 
 	errno = 0;
 	while ((de = readdir(node_dir)) != NULL) {
-- 
2.53.0-Meta

