Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0536828D
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235773; cv=none; b=frnKLN1I6wTsny/7/tuoolSbdArEzG+wj9JQIi5zEBh/zQm6b6yqaKkO6oJuzktwJK9gOW8kxc7lk0JbscrBgoOewVGEjPA3OxSlivSIxBSKAcfA17PD/A/fa+DoKhqlPiyjegi1jQlrEhit2RAa2wm/Vnpz7GvRtGgtQCLgg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235773; c=relaxed/simple;
	bh=J5fWXWgfUgNARS1URmEQO+2W2oErSS+uXHLDhl4DgLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs4ZeWCrEY+6wxUClUYgZT5tkWuDv6vmssiuCb0AD0JUN3NzSQLEZJuAsYyEL86kVNLTcxUm0zEx2EHqDlqJ8GP3lSBj9PEuaDgOOsh4QyHjZXLK0s+MHngCcXuP5WLQR/yp4SQ5ErwiduXP3jCCONA5PRdg++HCWeRXYp0KUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=btXf4B5N; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="btXf4B5N"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ba3ffd54dbso986676785a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768235767; x=1768840567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYljDHrhzse122IhNVBkcFsqZorvBX2rkO3ziE1OCKg=;
        b=btXf4B5N0xLmVJYyXRgkMD+46be0ZYK6RnGfyYOP58ZXDhTe30Yp8sVQvM/BU89RQ6
         YiZgoONf+xdfBOCPGJNsqI4MUW0pG8fkvRdR3kxuyT+lNkS7cX1yacKvYMggKrwc3WeF
         oXHqQxqlsoZYpl3Ic7wW9NtbkN+7VVyGxYmxcmg9wBWASPYZNCLd6A1S3/HrGN16Yfu4
         4chYsNLwXuks7Y68h0Tj+4Uvu0i2TTfx7FCJvPfNM67N2CMcF144B1LW92L9qev1BZ+O
         nvu5yjsyM9XDEMZhanoclekRIR8Jah19Xm58nYJIlP0xXZbmYmxZtCQOcQgk3V6XPk4M
         Q/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235767; x=1768840567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kYljDHrhzse122IhNVBkcFsqZorvBX2rkO3ziE1OCKg=;
        b=kd8GvwRmzSc68vFLrjLwKGAOheIfetkDN4ksGVwcP6WErdY8FMaWwaxesF+lMrQ3ki
         d+7zJscXOfbIXGg1hHBAXi/lfZXBfBdhlFfgEh1yndKlqTmquuVRf1AmuKo0x2fIHB6O
         Jtf2+yZzp+R9qXBCplaOBjWzPn+G0vY/nrXKS+dmF4FQ0uvTX8XPCR/Ope6sJ8ZvIXBz
         y+dAqXF4eQzlEMNgec8X64ALBjFeo7ekvgMHK7/x2IuX4Y/yfYsYW3fcgQ38W25gDS59
         Q+Q6Jd6MzfqVSCNIMtfOBWukxphte7vTCA3mOeBJutg6t9fIUaxOB+EzaRey4l9zozTf
         cwEA==
X-Gm-Message-State: AOJu0YxT0/dBduuWWFrM++M4EiCErCt/Z64MzyHpawPFpeTtjegBXo44
	WoM6cRIZ9iUB6LKS56JBvS1ujqRWjZCIrvtJp/KMpzOUAwuwLnzruIlbdSlaV8NLrf+xuDneP3R
	xD+Bl
X-Gm-Gg: AY/fxX7rjxBeAF961WCb4Rjj7r/w7Mr47Ok4PSl6XAMNqtMAtfUmVucnzxGDA1rV4SX
	//n4+TRydtFEWklgoUVYvo8mRwvUMccEOSDOq0tdySoRGTC1FlJFpDK224FnTtPgBFkcNs5jQUS
	cQP7yt680QvHMxuWpZf/xuwa/pmx9ZcIZSOXm2DbU5G2QiSMuS3OlNj35rCjQ/mPg2F2CU0gZwp
	QpjdUyAHKalxs2x/DgDUTAMbBGVw+y7TCNXhzoVlr+H2h+kZu3ADLgtvmd8H/CKUfmuYyHdd0P0
	6AZvGU76fTESp5f/NJBIGIHeGCCPUDbjR8Ou6J9qlvy5RWxk4pfVCEgOHkc6t/d2Py1kS6irKc8
	O3dz6EW6W+gQ2STiOwaqpOx0yw49CUVg6hSI1vRZAl3OOq/yMPzWkQb/nPmQn2HFbpIafKxDmNC
	rLT24zJs/r4wndi6mXhkPotrUp6ocWXtr07DAXbUQlSLXJf08ArhUY7WmGKSzHwISufQhbjuCJt
	y0GCr3DsLDAdw==
X-Google-Smtp-Source: AGHT+IEk7U/eiL6d2BgL0qXdS/KjLZjfHviCFNTvOTZ2x8tQOJI7E67CBhbzaabCC7zoXHNpM66EZw==
X-Received: by 2002:a05:620a:298c:b0:89e:c659:3f99 with SMTP id af79cd13be357-8c38937959amr2642286585a.6.1768235767303;
        Mon, 12 Jan 2026 08:36:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a7962sm1489152685a.11.2026.01.12.08.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:36:06 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 5/6] cxl: add CXL_REGION_SYSRAM_DEFAULT_* build options
Date: Mon, 12 Jan 2026 11:35:13 -0500
Message-ID: <20260112163514.2551809-6-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112163514.2551809-1-gourry@gourry.net>
References: <20260112163514.2551809-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DEFAULT_OFFLINE: Blocks will be offline after being created.
DEFAULT_ONLINE:  Blocks will be onlined in ZONE_MOVABLE
DEFAULT_ONLINE_NORMAL: Blocks will be onliend in ZONE_NORMAL.

This prevents users from having to use the MHP auto-online build config,
which may cause misbehaviors with other devices hotplugging memory.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/Kconfig                      | 40 ++++++++++
 drivers/cxl/core/memctrl/sysram_region.c | 94 ++++++++++++++++++------
 2 files changed, 110 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 5aed1524f8f1..3e087c9d5ea7 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -243,6 +243,46 @@ config CXL_REGION_CTRL_AUTO_SYSRAM
 
 endchoice
 
+choice
+	prompt "CXL SYSRAM Auto Online Mode"
+	depends on CXL_REGION
+	default CXL_REGION_SYSRAM_DEFAULT_OFFLINE
+	help
+	  Select whether CXL memory hotplugged as System RAM should be
+	  automatically onlined and in which zone. This applies when the
+	  region controller is set to SYSRAM (either explicitly or via
+	  the auto control mode).
+
+config CXL_REGION_SYSRAM_DEFAULT_OFFLINE
+	bool "Offline"
+	help
+	  Leave the memory offline after hotplug. The memory must be
+	  manually onlined via sysfs or other mechanisms before it can
+	  be used by the system.
+
+	  This is the default and most conservative option.
+
+config CXL_REGION_SYSRAM_DEFAULT_ONLINE
+	bool "Online (Movable)"
+	help
+	  Automatically online the memory as ZONE_MOVABLE after hotplug.
+	  ZONE_MOVABLE memory can be used for user pages and is eligible
+	  for memory hotremove, but cannot be used for kernel allocations.
+
+	  Select this for memory that may need to be hotremoved later.
+
+config CXL_REGION_SYSRAM_DEFAULT_ONLINE_NORMAL
+	bool "Online (Normal)"
+	help
+	  Automatically online the memory as ZONE_NORMAL after hotplug.
+	  ZONE_NORMAL memory can be used for all allocations including
+	  kernel allocations, but may not be hotremovable.
+
+	  Select this for maximum memory utilization when hotremove is
+	  not required.
+
+endchoice
+
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"
 	depends on CXL_REGION
diff --git a/drivers/cxl/core/memctrl/sysram_region.c b/drivers/cxl/core/memctrl/sysram_region.c
index a7570c8a54e1..2e2d9b59a725 100644
--- a/drivers/cxl/core/memctrl/sysram_region.c
+++ b/drivers/cxl/core/memctrl/sysram_region.c
@@ -129,12 +129,69 @@ static int offline_memory_block_cb(struct memory_block *mem, void *arg)
 	return *rc;
 }
 
+static int cxl_sysram_online_memory(struct range *range, int online_type)
+{
+	struct online_memory_cb_arg cb_arg = {
+		.online_type = online_type,
+		.rc = 0,
+	};
+	int rc;
+
+	rc = walk_memory_blocks(range->start, range_len(range),
+				&cb_arg, online_memory_block_cb);
+	if (!rc)
+		rc = cb_arg.rc;
+
+	return rc;
+}
+
+static int cxl_sysram_offline_memory(struct range *range)
+{
+	int offline_rc = 0;
+	int rc;
+
+	rc = walk_memory_blocks(range->start, range_len(range),
+				&offline_rc, offline_memory_block_cb);
+	if (!rc)
+		rc = offline_rc;
+
+	return rc;
+}
+
+static int cxl_sysram_auto_online(struct device *dev, struct range *range)
+{
+	int online_type;
+	int rc;
+
+	if (IS_ENABLED(CONFIG_CXL_REGION_SYSRAM_DEFAULT_OFFLINE))
+		return 0;
+
+	if (IS_ENABLED(CONFIG_CXL_REGION_SYSRAM_DEFAULT_ONLINE))
+		online_type = MMOP_ONLINE_MOVABLE;
+	else if (IS_ENABLED(CONFIG_CXL_REGION_SYSRAM_DEFAULT_ONLINE_NORMAL))
+		online_type = MMOP_ONLINE_KERNEL;
+	else
+		online_type = MMOP_ONLINE_MOVABLE;
+
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
+
+	rc = cxl_sysram_online_memory(range, online_type);
+
+	unlock_device_hotplug();
+
+	if (rc)
+		dev_warn(dev, "auto-online failed: %d\n", rc);
+
+	return rc;
+}
+
 static ssize_t state_store(struct device *dev,
 			   struct device_attribute *attr,
 			   const char *buf, size_t len)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
-	struct online_memory_cb_arg cb_arg;
 	struct range range;
 	int rc;
 
@@ -149,30 +206,14 @@ static ssize_t state_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	if (sysfs_streq(buf, "online")) {
-		cb_arg.online_type = MMOP_ONLINE_MOVABLE;
-		cb_arg.rc = 0;
-		rc = walk_memory_blocks(range.start, range_len(&range),
-					&cb_arg, online_memory_block_cb);
-		if (!rc)
-			rc = cb_arg.rc;
-	} else if (sysfs_streq(buf, "online_normal")) {
-		cb_arg.online_type = MMOP_ONLINE;
-		cb_arg.rc = 0;
-		rc = walk_memory_blocks(range.start, range_len(&range),
-					&cb_arg, online_memory_block_cb);
-		if (!rc)
-			rc = cb_arg.rc;
-	} else if (sysfs_streq(buf, "offline")) {
-		int offline_rc = 0;
-
-		rc = walk_memory_blocks(range.start, range_len(&range),
-					&offline_rc, offline_memory_block_cb);
-		if (!rc)
-			rc = offline_rc;
-	} else {
+	if (sysfs_streq(buf, "online"))
+		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE_MOVABLE);
+	else if (sysfs_streq(buf, "online_normal"))
+		rc = cxl_sysram_online_memory(&range, MMOP_ONLINE);
+	else if (sysfs_streq(buf, "offline"))
+		rc = cxl_sysram_offline_memory(&range);
+	else
 		rc = -EINVAL;
-	}
 
 	unlock_device_hotplug();
 
@@ -332,6 +373,10 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
 	dev_dbg(dev, "%s: added %llu bytes as System RAM\n", dev_name(dev),
 		(unsigned long long)total_len);
 
+	rc = cxl_sysram_auto_online(dev, &range);
+	if (rc)
+		goto err_auto_online;
+
 	dev_set_drvdata(dev, data);
 	rc = devm_device_add_group(dev, &cxl_sysram_region_group);
 	if (rc)
@@ -341,6 +386,7 @@ int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
 
 err_add_group:
 	dev_set_drvdata(dev, NULL);
+err_auto_online:
 	/* if this fails, memory cannot be removed from the system until reboot */
 	remove_memory(range.start, range_len(&range));
 err_add_memory:
-- 
2.52.0

