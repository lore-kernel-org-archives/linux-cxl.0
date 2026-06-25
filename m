Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E33E0220
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389600; cv=none; b=G0kA/6IpT2UMrGedf7cdujrES+1KUsk9e+RTSorSko6sDtQCNSLiU0JOXHk/+5Ro25U0o2MzYVrPMgnmJnWhMnyksr49YURbwBdLaqrw92uqZujblsnZ9krTEropZWch9hOxnRgfzr5o2CIXIOCTf99inOlPl1bY17Ma8EZ4fuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389600; c=relaxed/simple;
	bh=E0KCu+shOnjqoTTudhIIT2SmGguJsEGXVPKrXtwW66M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpJF7pUSL8A/wrS+fZ8+CuugReaR/nvvJplFaCrlyDnwWlmuaiT055FwNMYQRcVY4WA3xaNOFfeBvza7aDROfawDojEDWhuXQA+eAOhBMeOijL7kuVydNmvFnd5g9NkK2rFm1czH5Q9nTHIgUzB5ygAKAsYH5wDsygFYgWDVcUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Szf4ecwK; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Szf4ecwK"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-139b5e604b9so2508435c88.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389598; x=1782994398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfG1GvsOHrjJK0b4qKYTwwusEHt1awKD6HYfwbXh22U=;
        b=Szf4ecwKfCUVIQPyV6rEyqvxXpn+0I0NuLJ+aclZn8RgY5EWf08NZJoSOsG+76YiVt
         qmNI7WHiyHcgHJLMA2s/g7n33cD+wUZQCExXJtrb2lDOE4Ym42wFFmiMawqTSZOiAWSl
         W62MRM2QNL+OOu7EoXzXboOwP1fsdEm8v+cNzyMmHRzkP2nfbstQAx1KG+Q9M/INZI3B
         vBl+O/tT7gjRf1Ap02qS4WzsUhc1bix8JyvZe5RBnjwDMrWB/3njGavv5soqM0grkIKR
         9Y/6NLVjg2Ehw6LsR65vYOlgTsdnys7ePhXwQQdByupemw/hIozBHnxcCtA3eRIpQt9E
         n2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389598; x=1782994398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfG1GvsOHrjJK0b4qKYTwwusEHt1awKD6HYfwbXh22U=;
        b=PZnhFa+BbFxSpjWHUK+cuXMgN2QQr3QURmI1GPz0E8NCdw96qveY2yxETJ2XY4hysV
         OuCwH8WVHPpelGk+MIA1m064wHJqwXmx7I+EN/lXVznFaXPspzB6npkiD7gjaP71mD2h
         sbhwm3V+qdkoIyVrJaA8UAX5w7Sm3P2dko9rRms/6BynjMMuUqDOGZZWAifiZwCUYy30
         Vih164PtE2chOwUCP9vUBl8jy/EhbIOfCZITYHk2DYLdKvr4mDVGwFOIVZ5V9tgtGk4O
         vKvnCjk4TDhvfkSCJ8+/PeGOjusrnOXAE4lWyndIYwvoRsPseTqMhSsbT8BlZ65D7cN5
         tfqA==
X-Gm-Message-State: AOJu0YwP04uprE5sMMz3k69cHU44enAou6iVmWd13Xsi8FHbkBpfq+ON
	7Mxf47DwZwrlgxBIlL6nFE1SrGh2Yw240a2FCkskmFSS6CSS8AG9VdItmPp28w==
X-Gm-Gg: AfdE7ckY1Agv8ng4I76MRusu7VoqGamlI8CMKwzntx8K7F/WwmbCtoffgjoTa8E5HcE
	Ohx4O0ldmPl2c8NNSusYeCDGeRBSogn/2vMUaVOUc/OVeMxg+ZjDrphYHXL6gpT8L5/wBf3NTft
	Ez+I3gTeYhwZ/+f6fqTQcnles760XWvefIiro2V9ktio++C02dcBGzIHDvTf2ddzktfi7bwbXo5
	Sea8/maqYNbVt9LgIo1P1mM+rmUjS8xw48drceVRG1pYNjMMQarUyWmz1eZaV8knNtZ9qVieubE
	dgyB/Woe2b5bO1By7TSTEJH3H0gnnpJ3LKQh4cOeI2FixyPDIehbXSgnhWb9gHHNLqCxobVkZNs
	Zsf5BSc37uaURejKJzw4uUgrV0dX3PCetHWRR2adj+Y1iWszva4ykCqbRfJX3est3wh64vNmsr/
	+Oc7RyOHzsOabeyr7qfKUD95w3UassU8R0LFK7d3ImZopi0LfF8ZDx+MkGg6g6be2zImRM
X-Received: by 2002:a05:7022:69a0:b0:137:fe07:8a2c with SMTP id a92af1059eb24-139dbac2ef7mr2452942c88.22.1782389598245;
        Thu, 25 Jun 2026 05:13:18 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f77602sm7422206c88.8.2026.06.25.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:13:17 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [NDCTL PATCH v7 4/5] daxctl: Add --uuid option to create-device for sparse regions
Date: Thu, 25 Jun 2026 05:09:38 -0700
Message-ID: <20260625121242.603807-5-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625121242.603807-1-anisa.su@samsung.com>
References: <20260625121242.603807-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a --uuid option to 'daxctl create-device' that writes the given
uuid to the new dax device's sysfs 'uuid' attribute.  On sparse (DCD)
regions this claims dax_resources whose tag matches and populates the
seed device with their capacity; size is determined by the claim, so
--uuid is mutually exclusive with --size.

Pass "0" to claim a single untagged dax_resource.  A claim that
matches no dax_resource leaves the device at size 0; the kernel
returns ENOENT.

Plumb the write through a new daxctl_dev_set_uuid() libdaxctl helper
(LIBDAXCTL_12) and document the option in the man page.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 Documentation/daxctl/daxctl-create-device.txt | 12 ++++
 daxctl/device.c                               | 72 +++++++++++++------
 daxctl/lib/libdaxctl.c                        | 53 ++++++++++++++
 daxctl/lib/libdaxctl.sym                      |  5 ++
 daxctl/libdaxctl.h                            |  1 +
 5 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/Documentation/daxctl/daxctl-create-device.txt b/Documentation/daxctl/daxctl-create-device.txt
index b774b86..27b87d0 100644
--- a/Documentation/daxctl/daxctl-create-device.txt
+++ b/Documentation/daxctl/daxctl-create-device.txt
@@ -82,6 +82,18 @@ include::region-option.txt[]
 
 	The size must be a multiple of the region alignment.
 
+	Mutually exclusive with --uuid.
+
+--uuid=::
+	For dax devices on sparse (DCD) regions, claim dax_resource(s) whose
+	tag matches the given UUID.  The device's size is determined by the
+	claimed capacity, so --uuid cannot be combined with --size.
+
+	A non-null UUID claims every matching dax_resource in the parent
+	region.  The value "0" is shorthand for the null UUID and claims a
+	single untagged dax_resource.  A write that matches no dax_resource
+	fails with ENOENT and the device is left at size 0.
+
 -a::
 --align::
 	Applications that want to establish dax memory mappings with
diff --git a/daxctl/device.c b/daxctl/device.c
index 47942f1..4213420 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -30,6 +30,7 @@ static struct {
 	const char *size;
 	const char *align;
 	const char *input;
+	const char *uuid;
 	bool check_config;
 	bool no_online;
 	bool no_movable;
@@ -86,7 +87,9 @@ OPT_BOOLEAN('C', "check-config", &param.check_config, \
 #define CREATE_OPTIONS() \
 OPT_STRING('s', "size", &param.size, "size", "size to switch the device to"), \
 OPT_STRING('a', "align", &param.align, "align", "alignment to switch the device to"), \
-OPT_STRING('\0', "input", &param.input, "input", "input device JSON file")
+OPT_STRING('\0', "input", &param.input, "input", "input device JSON file"), \
+OPT_STRING('\0', "uuid", &param.uuid, "uuid", \
+	"claim sparse dax_resource(s) matching this uuid (\"0\" for untagged)")
 
 #define DESTROY_OPTIONS() \
 OPT_BOOLEAN('f', "force", &param.force, \
@@ -864,6 +867,22 @@ static int do_create(struct daxctl_region *region, long long val,
 	struct daxctl_dev *dev;
 	int i, rc = 0;
 	long long alloc = 0;
+	uuid_t uuid;
+
+	if (param.uuid) {
+		if (param.size) {
+			fprintf(stderr,
+				"--uuid and --size are mutually exclusive\n");
+			return -EINVAL;
+		}
+		if (strcmp(param.uuid, "0") == 0) {
+			uuid_clear(uuid);
+		} else if (uuid_parse(param.uuid, uuid) < 0) {
+			fprintf(stderr, "failed to parse uuid '%s'\n",
+				param.uuid);
+			return -EINVAL;
+		}
+	}
 
 	if (daxctl_region_create_dev(region))
 		return -ENOSPC;
@@ -872,33 +891,46 @@ static int do_create(struct daxctl_region *region, long long val,
 	if (!dev)
 		return -ENOSPC;
 
-	if (val == -1)
-		val = daxctl_region_get_available_size(region);
-
-	if (val <= 0)
-		return -ENOSPC;
-
 	if (align > 0) {
 		rc = daxctl_dev_set_align(dev, align);
 		if (rc < 0)
 			return rc;
 	}
 
-	/* @maps is ordered by page_offset */
-	for (i = 0; i < nmaps; i++) {
-		rc = daxctl_dev_set_mapping(dev, maps[i].start, maps[i].end);
-		if (rc < 0)
+	if (param.uuid) {
+		rc = daxctl_dev_set_uuid(dev, uuid);
+		if (rc < 0) {
+			fprintf(stderr,
+				"%s: failed to claim uuid '%s': %s\n",
+				daxctl_dev_get_devname(dev), param.uuid,
+				strerror(-rc));
 			return rc;
-		alloc += (maps[i].end - maps[i].start + 1);
-	}
-
-	if (nmaps > 0 && val > 0 && alloc != val) {
-		fprintf(stderr, "%s: allocated %lld but specified size %lld\n",
-			daxctl_dev_get_devname(dev), alloc, val);
+		}
 	} else {
-		rc = daxctl_dev_set_size(dev, val);
-		if (rc < 0)
-			return rc;
+		if (val == -1)
+			val = daxctl_region_get_available_size(region);
+
+		if (val <= 0)
+			return -ENOSPC;
+
+		/* @maps is ordered by page_offset */
+		for (i = 0; i < nmaps; i++) {
+			rc = daxctl_dev_set_mapping(dev, maps[i].start,
+						    maps[i].end);
+			if (rc < 0)
+				return rc;
+			alloc += (maps[i].end - maps[i].start + 1);
+		}
+
+		if (nmaps > 0 && val > 0 && alloc != val) {
+			fprintf(stderr,
+				"%s: allocated %lld but specified size %lld\n",
+				daxctl_dev_get_devname(dev), alloc, val);
+		} else {
+			rc = daxctl_dev_set_size(dev, val);
+			if (rc < 0)
+				return rc;
+		}
 	}
 
 	rc = daxctl_dev_enable_devdax(dev);
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 01b1915..0302bd6 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1166,6 +1166,59 @@ DAXCTL_EXPORT int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long
 	return 0;
 }
 
+DAXCTL_EXPORT int daxctl_dev_set_uuid(struct daxctl_dev *dev, uuid_t uuid)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char buf[SYSFS_ATTR_SIZE];
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+	int rc;
+
+	rc = snprintf(path, len, "%s/uuid", dev->dev_path);
+	if (rc < 0)
+		return rc;
+	if (rc >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	if (uuid_is_null(uuid))
+		sprintf(buf, "0\n");
+	else
+		uuid_unparse(uuid, buf);
+
+	rc = sysfs_write_attr(ctx, path, buf);
+	if (rc < 0) {
+		err(ctx, "%s: failed to set uuid\n",
+				daxctl_dev_get_devname(dev));
+		return rc;
+	}
+
+	/*
+	 * On a sparse region the kernel populates the device size as a
+	 * side effect of claiming the matching dax_resource(s); refresh
+	 * the cached size so callers see the post-claim value.
+	 */
+	rc = snprintf(path, len, "%s/size", dev->dev_path);
+	if (rc < 0)
+		return rc;
+	if (rc >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc < 0) {
+		err(ctx, "%s: failed to read back size\n",
+				daxctl_dev_get_devname(dev));
+		return rc;
+	}
+	dev->size = strtoull(buf, NULL, 0);
+
+	return 0;
+}
+
 DAXCTL_EXPORT unsigned long daxctl_dev_get_align(struct daxctl_dev *dev)
 {
 	return dev->align;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 43dd60b..e020abf 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -113,3 +113,8 @@ global:
 	daxctl_dev_get_mode;
 	daxctl_dev_is_system_ram_mode;
 } LIBDAXCTL_10;
+
+LIBDAXCTL_12 {
+global:
+	daxctl_dev_set_uuid;
+} LIBDAXCTL_11;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 7ec159e..17e46ac 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -63,6 +63,7 @@ int daxctl_dev_get_minor(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_resource(struct daxctl_dev *dev);
 unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
 int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long size);
+int daxctl_dev_set_uuid(struct daxctl_dev *dev, uuid_t uuid);
 unsigned long daxctl_dev_get_align(struct daxctl_dev *dev);
 int daxctl_dev_set_align(struct daxctl_dev *dev, unsigned long align);
 int daxctl_dev_set_mapping(struct daxctl_dev *dev, unsigned long long start,
-- 
2.43.0

