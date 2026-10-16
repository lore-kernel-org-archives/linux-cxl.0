Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A143C058
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186978; cv=none; b=BkrcKvUT6JcrucQNTbUYLwq+5QmiXbWQJeW87kcTZdjijCqDmD+xX40Q1eOReZ4U09u6zoJZd6dnjtqQahi6MwodBk1npI+8w+wNl37IUpflC1qQAvVYR9BzErzC9pRJY1y3ZTOUSkZYPjcGf7wJnSP1ouErp0FGe737+nv6q2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186978; c=relaxed/simple;
	bh=OrZefnPbM0hqSNG5LgeRH/CmfOYM38WyetYV8dzfLcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iq/Snxf3ocIztCR3+Uf0XKsKURCsezzJMrgS/YG4K9RFvvw/x8F/j1tzKE5jwsZQCZVKaPGgQpRZmglGQ7jyDnoPkETUr0ebRg7GPbMRu2y96qwjEb3KMxw3GqLFMBtR1lxYkR9v8YGexpdjL6d8IxfV+NnM6lXo/BAkDV+Dy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cmYIf/cV; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cmYIf/cV"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f269e335eso43633685a.3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 14:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792186976; x=1792791776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yqel/rUpZMGCjsyhhgtEf+VLt6cd2+9NH+Tz/z60eU8=;
        b=cmYIf/cVyod67EuU82Zlo7V5GhfxbDRE8pp0kq6J8mPqO3nghGUwoNqLoh+tNXTqBh
         FbFVFV71N2XjO8Q6MZoQDM7tC0+ce4752/y7EBtumABBKT7UlmUvMomBUBUA4gEcHFez
         bRO5G398pG02uWDBY2mokLeNXGROMB5rrfJmBV3y8DujbdNHpNXGBEAuwiYo6yH6kedS
         t7ZLOd3EwH8prjgChq+5QrLJWVCaQ4kL16415gibx0poebZmRPDD2yYSnXetNe4oNvr8
         jF9Ob0WgN3uaM5xic5aCPM/NNWAZtwTrtpyb/ntJd/j6QXL7Tt0bM16gLYEsUaT8xqGO
         Z4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186976; x=1792791776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yqel/rUpZMGCjsyhhgtEf+VLt6cd2+9NH+Tz/z60eU8=;
        b=rEZw9bB5EKoiJmYy6vCBTQFpQxteM2EsXWfXaMc62thj527BKDhrmb9lqR50MTw0ye
         hWDrGO76QK7hmryyqucTheRne89k8hJycEG2TKNrgQoMEZBTlFgIBBDr0PvxPB8GHfHO
         KBbdpubQyfgbUW0F47agM4uD7QqZH/JF4oSjGO9bBDS/66shpL0uLRavUroKFZkMHOPz
         dRPd6nvdI6RgmqxJZt3ZrR8MsQHhwzskyDXDVJ/wqEE+YlnRPBEHqOlx3gW6xvPV2shU
         Z0yooUD9fPGtqZcJ6uNixIWt8fyimnCKDsMeltRdAOwyEoWkUiUHG5yAlh1ru1Ga+43Z
         afZA==
X-Forwarded-Encrypted: i=1; AKwUvBzaszy7YE9nxcULZQS9e5sG3TpsKw76HMfz3Hr6lnwtw5FVA5LNLGcY8Ty0swOmNrWUoB0O14o133E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpnyOASr2ISGPfxLiDWDpGau0HaaZa56KqoudDSuW1hdHp0O0o
	UiDWsYGxwI/coRNGERSZRr0+j9eon8l2hYkC2XZl5sMmfnC+i29U1V5j7SvgMpQBQ+dYn7D3ktY
	zqErU3xY=
X-Gm-Gg: AYBFou3hf9X3sz4r0rAaDXGKxKWXZbUuD6hjPQ+RPT0TnCPSd4DDFkU1B8OfEFg8n24
	6ZCii8QcrUxV0XyBw5XB2h8RKUpcaSRzqpa+m9+FXZ1AtiIXIZLLLbrhCU7HTtKnyPowMBUvsNb
	U4VYqNg9ZE+sDtqmjuL24AxTtafjXNF2vCsuPXGJXFg6GmKNIPHIWPxlWesUoXHuQ4OpK8+fCEd
	XnGefI9kAvOFm0yVozfk0vGX8qSqYorIs8kt1YVDrcz4iEqPMZKi4QncGzOOQ7SfyAiJVDids5x
	8uHw+LkdBu96yksKSfZSRim0Qzg/m26XH4D4/Q6/uy46934BE79vw5n0/bZPi6y9ynP+HC/KLQS
	yPVv1UBJMsrS0w1rY2NDnnJYjCmmhLqCuVoqllpt37MwaYm9RA1nmdqvReYAZ6CMjSCky/HfO+s
	Uq8kXABJCqL54KBe8yTSWAbKnLcVUWBGIkX5CT4G9hRToV7uSvEtTPvg1xMMYVzKZvBEJ0QE+5r
	3Nus5rKT0cZs6tF9K8tw29LPFMJQqnwhsGPq9I0ueBMnNWYELQ2hx/9wkbv
X-Received: by 2002:a05:620a:3728:b0:93e:94a4:a97d with SMTP id af79cd13be357-93f29a03e49mr222662085a.0.1792186975618;
        Fri, 16 Oct 2026 14:42:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1a8ee1sm312622985a.34.2026.10.16.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 14:42:53 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH 1/6] libdaxctl: add dax kmem atomic hotplug state accessors
Date: Fri, 16 Oct 2026 17:42:43 -0400
Message-ID: <20261016214248.443247-2-gourry@gourry.net>
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

Recent kernels add /sys/bus/dax/devices/daxX.Y/state to dax_kmem
devices for atomic whole-device hotplug. It reads 'unplugged',
'offline', 'online', 'online_kernel' or 'online_movable', and accepts
all but 'offline'.

Add an enum and get/set accessors for it. The getter returns
DAXCTL_KMEM_UNKNOWN when the attribute is absent, so callers can fall
back to per-block operations.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 daxctl/lib/libdaxctl-private.h |  9 ++++++
 daxctl/lib/libdaxctl.c         | 59 ++++++++++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |  6 ++++
 daxctl/libdaxctl.h             | 18 +++++++++++
 4 files changed, 92 insertions(+)

diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index b902e3d..00e906c 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -58,6 +58,15 @@ static const char *state_strings[] = {
 	[MEM_ZONE_MOVABLE] = "online_movable",
 };
 
+/* dax_kmem daxX.Y/state strings */
+static const char *kmem_state_strings[] = {
+	[DAXCTL_KMEM_UNPLUGGED] = "unplugged",
+	[DAXCTL_KMEM_OFFLINE] = "offline",
+	[DAXCTL_KMEM_ONLINE] = "online",
+	[DAXCTL_KMEM_ONLINE_KERNEL] = "online_kernel",
+	[DAXCTL_KMEM_ONLINE_MOVABLE] = "online_movable",
+};
+
 /**
  * struct daxctl_region - container for dax_devices
  */
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 01b1915..cbb42e3 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1794,3 +1794,62 @@ DAXCTL_EXPORT int daxctl_dev_has_online_memory(struct daxctl_dev *dev)
 	else
 		return 0;
 }
+
+DAXCTL_EXPORT enum daxctl_kmem_state daxctl_dev_get_kmem_state(
+		struct daxctl_dev *dev)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+	char buf[SYSFS_ATTR_SIZE];
+	int i;
+
+	if (snprintf(path, len, "%s/state", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return DAXCTL_KMEM_UNKNOWN;
+	}
+
+	/* absent on older kernels */
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		return DAXCTL_KMEM_UNKNOWN;
+
+	for (i = DAXCTL_KMEM_UNPLUGGED; i <= DAXCTL_KMEM_ONLINE_MOVABLE; i++)
+		if (strcmp(buf, kmem_state_strings[i]) == 0)
+			return i;
+
+	dbg(ctx, "%s: unrecognized kmem state '%s'\n",
+			daxctl_dev_get_devname(dev), buf);
+	return DAXCTL_KMEM_UNKNOWN;
+}
+
+DAXCTL_EXPORT int daxctl_dev_set_kmem_state(struct daxctl_dev *dev,
+		enum daxctl_kmem_state state)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+
+	switch (state) {
+	case DAXCTL_KMEM_UNPLUGGED:
+	case DAXCTL_KMEM_ONLINE:
+	case DAXCTL_KMEM_ONLINE_KERNEL:
+	case DAXCTL_KMEM_ONLINE_MOVABLE:
+		break;
+	/* 'offline' is read-only */
+	case DAXCTL_KMEM_OFFLINE:
+	case DAXCTL_KMEM_UNKNOWN:
+	default:
+		dbg(ctx, "%s: invalid kmem state %d\n",
+				daxctl_dev_get_devname(dev), state);
+		return -EINVAL;
+	}
+
+	if (snprintf(path, len, "%s/state", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	return sysfs_write_attr(ctx, path, kmem_state_strings[state]);
+}
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 43dd60b..d247542 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -113,3 +113,9 @@ global:
 	daxctl_dev_get_mode;
 	daxctl_dev_is_system_ram_mode;
 } LIBDAXCTL_10;
+
+LIBDAXCTL_12 {
+global:
+	daxctl_dev_get_kmem_state;
+	daxctl_dev_set_kmem_state;
+} LIBDAXCTL_11;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 7ec159e..e2812cc 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -77,6 +77,24 @@ int daxctl_dev_get_target_node(struct daxctl_dev *dev);
 int daxctl_dev_will_auto_online_memory(struct daxctl_dev *dev);
 int daxctl_dev_has_online_memory(struct daxctl_dev *dev);
 
+/*
+ * dax_kmem whole-device hotplug state (daxX.Y/state). UNKNOWN means the
+ * attribute is absent (older kernel, or device not bound to kmem) or
+ * reports a state this library does not recognize.
+ */
+enum daxctl_kmem_state {
+	DAXCTL_KMEM_UNKNOWN = -1,
+	DAXCTL_KMEM_UNPLUGGED = 0,
+	DAXCTL_KMEM_OFFLINE,
+	DAXCTL_KMEM_ONLINE,
+	DAXCTL_KMEM_ONLINE_KERNEL,
+	DAXCTL_KMEM_ONLINE_MOVABLE,
+};
+
+enum daxctl_kmem_state daxctl_dev_get_kmem_state(struct daxctl_dev *dev);
+int daxctl_dev_set_kmem_state(struct daxctl_dev *dev,
+		enum daxctl_kmem_state state);
+
 struct daxctl_memory;
 
 enum daxctl_dev_mode {
-- 
2.53.0-Meta

