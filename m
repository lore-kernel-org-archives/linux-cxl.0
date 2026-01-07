Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F9399A51
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800110; cv=none; b=p1n+FEyq4qLsVuxfMUDvQ61L6fsShOe/+suvAfKYBiAMrZ50oHrYn9+aOvl0TrUTcobnRP0JrnTWUenx1uO7Wr4gdSqG8hE1J0xjcKoSROOlJ7kvORo3sDARFmLND8QNLIXinJYjcoB42aC5k9j0rc9NIg2Zcv6No82GF7wHLOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800110; c=relaxed/simple;
	bh=r9IqegKKXF0hOodqnrc7EmAalu0NN7c//lGhFFS/Wr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLX+wgO1NWCXKHK1ZyQLv7l50OQhc0e10lql9SyRAI4UkvxnhhINgF3W0Ljd+SvlxdfDcvJLzqD6tS+rHZOeq6/OM1NWK0s8E1z0IFs2skqgyIFbm2YrBkoCOH5hKOOlcZKmB8Kq/L3/wbNo37pc4pO0yQa20l18EPZaIAwWYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3TdIF7d; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3TdIF7d"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4537407477aso1409151b6e.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800107; x=1768404907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJ1yqTOSIYfzgCIPomxp4mh5lXIFW6Vqr0XKillgvQc=;
        b=H3TdIF7d/5+LEF1QIFQ7iujVmgDwfVacrRcyO5bHe/pXkovi8WtVwSuSwKqbzjJCgJ
         8CvHJZm/A/D+7DeBfhvfY8es5GdZcg/M4VWkQs+3JllRmJRF7fIhLFN1EHh1lFNP5/x/
         GhNM4ROwGb7Mef0zmfw+NHlcEHkJoyt80EmbavTOTm7QGhNn9Vq4739kX4PcpSrcKCgK
         xDZwsPmISvAn6G1oa7aSWiJvd2IqMuaXv821IGmsMV9AZ+8Py/3MIVJSdC9uEO0WsBVZ
         7SuhaM/4wwf4AgwFxO/IeNPSuYuG6n8HHxzxC9WI6v3yZQpF23gYqvHuC5ftLMu6ZVIC
         BDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800107; x=1768404907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ1yqTOSIYfzgCIPomxp4mh5lXIFW6Vqr0XKillgvQc=;
        b=aOdPvOpJRfyLk1lEArbmUIQIl9q2f8DWoZBLRcNlwaM9Z8pdMrLbfDXTf95XKmbeeX
         CEG26SrJ7zjiervdR1xFp2Ql5+fxNQrvjXqVMyES7ghck40VMP3HnmBTP6GS4w6OjdOs
         UEDSZili/ufAzTm6lSjaVsMn8YvX3JCUoYSyBOf1EyR6LSEXmqoBWdJQb+crgJ7M/IJ2
         am4sjLYRO6kQdnfER1iSYQqcj3cqsO9Z6WFYAhArP7c6Q8G/pNyneRr+SjPR5O3iMMf4
         7s4vUDtOXdde2H/kUT5cAalzU3LWnwgiiALyk5TK6YeTe//z8nqEcExg6pYxcjb6i9ya
         F27Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa25QlxTK7uS4PGvO8Djihcno07Rsbca7+gP8l1o2zVUpvIHLTkzb19V/J76uWZzc+AjmKbIhb6VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSF/eSlIBn568/y/3FPMHOSi5xMQe69pre5Y7aqVkq4VII6RX
	cJOiCVWAXAUndwhq6HM6Ai0v5rQcJ8Gv+pZo0IfY9gFFyK+Jr1dpYGG1
X-Gm-Gg: AY/fxX7KkszTmYePgvEapAAyMBSwgW4Y0l/EnXk0H9qr1f5cyRQ4rckJInLS1TMPCzA
	Xozv/J6NWfE5CcSPnTWpgFbdSEbtrISZ7NlwfcFvT6pEy0hbUor6AI6PsDfejUklvlP/JC2FTJG
	n6UgDj/GW5UT4LYBDWw5NWbWr7+CtN9jFIxcsDWw0FCPxwRBpS6eW9WqbpYrPBBtTdNriRpAbyZ
	sXcSOCkJkC29Jd/irkqTAR8AuIprgazmljV50dz+PzpLK4By58Jbo4YSjmyHsr01kO3hw62CCP+
	U50qj+DsWcQV76BLkYneKStWBgl7CpSR3aCt+J7oGL8iYv0jHkgfreSR7P7eu1U73r6WVEZ10LP
	V1G78fHeyqawl9R6Xa6kiHc8RRuAHVrYPC+wwQfDt+KBaQwCCepdduqHo4oLAQuq0jBMd3uvOM4
	0YLLF3nlKnLdpgAA4IHnyvkFSAFTDE2lMocTsOC9xSgi/U
X-Google-Smtp-Source: AGHT+IFhZzTBYXOyULopr/miqFWcFwpZ56BKeqT24Ye9+avl9LSKcVCkPXTacK24wfwEckn/JSxlfA==
X-Received: by 2002:a05:6808:f94:b0:453:797b:79d1 with SMTP id 5614622812f47-45a6bee7f78mr1417557b6e.33.1767800107198;
        Wed, 07 Jan 2026 07:35:07 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183cd4sm2415499b6e.1.2026.01.07.07.35.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:35:06 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH 1/2] daxctl: Add support for famfs mode
Date: Wed,  7 Jan 2026 09:34:58 -0600
Message-ID: <20260107153459.64821-2-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153459.64821-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153459.64821-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

Putting a daxdev in famfs mode means binding it to fsdev_dax.ko
(drivers/dax/fsdev.c). Finding a daxdev bound to fsdev_dax means
it is in famfs mode.

The test is added to the destructive test suite since it
modifies device modes.

With devdax, famfs, and system-ram modes, the previous logic that assumed
'not in mode X means in mode Y' needed to get slightly more complicated

Add explicit mode detection functions:
- daxctl_dev_is_famfs_mode(): check if bound to fsdev_dax driver
- daxctl_dev_is_devdax_mode(): check if bound to device_dax driver

Fix mode transition logic in device.c:
- disable_devdax_device(): verify device is actually in devdax mode
- disable_famfs_device(): verify device is actually in famfs mode
- All reconfig_mode_*() functions now explicitly check each mode
- Handle unknown mode with error instead of wrong assumption

Modify json.c to show 'unknown' if device is not in a recognized mode.

Signed-off-by: John Groves <john@groves.net>
---
 daxctl/device.c                | 126 ++++++++++++++++++++++++++++++---
 daxctl/json.c                  |   6 +-
 daxctl/lib/libdaxctl-private.h |   2 +
 daxctl/lib/libdaxctl.c         |  77 ++++++++++++++++++++
 daxctl/lib/libdaxctl.sym       |   7 ++
 daxctl/libdaxctl.h             |   3 +
 6 files changed, 210 insertions(+), 11 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index e3993b1..14e1796 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -42,6 +42,7 @@ enum dev_mode {
 	DAXCTL_DEV_MODE_UNKNOWN,
 	DAXCTL_DEV_MODE_DEVDAX,
 	DAXCTL_DEV_MODE_RAM,
+	DAXCTL_DEV_MODE_FAMFS,
 };
 
 struct mapping {
@@ -471,6 +472,13 @@ static const char *parse_device_options(int argc, const char **argv,
 					"--no-online is incompatible with --mode=devdax\n");
 				rc =  -EINVAL;
 			}
+		} else if (strcmp(param.mode, "famfs") == 0) {
+			reconfig_mode = DAXCTL_DEV_MODE_FAMFS;
+			if (param.no_online) {
+				fprintf(stderr,
+					"--no-online is incompatible with --mode=famfs\n");
+				rc =  -EINVAL;
+			}
 		}
 		break;
 	case ACTION_CREATE:
@@ -696,8 +704,42 @@ static int disable_devdax_device(struct daxctl_dev *dev)
 	int rc;
 
 	if (mem) {
-		fprintf(stderr, "%s was already in system-ram mode\n",
-			devname);
+		fprintf(stderr, "%s is in system-ram mode\n", devname);
+		return 1;
+	}
+	if (daxctl_dev_is_famfs_mode(dev)) {
+		fprintf(stderr, "%s is in famfs mode\n", devname);
+		return 1;
+	}
+	if (!daxctl_dev_is_devdax_mode(dev)) {
+		fprintf(stderr, "%s is not in devdax mode\n", devname);
+		return 1;
+	}
+	rc = daxctl_dev_disable(dev);
+	if (rc) {
+		fprintf(stderr, "%s: disable failed: %s\n",
+			daxctl_dev_get_devname(dev), strerror(-rc));
+		return rc;
+	}
+	return 0;
+}
+
+static int disable_famfs_device(struct daxctl_dev *dev)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc;
+
+	if (mem) {
+		fprintf(stderr, "%s is in system-ram mode\n", devname);
+		return 1;
+	}
+	if (daxctl_dev_is_devdax_mode(dev)) {
+		fprintf(stderr, "%s is in devdax mode\n", devname);
+		return 1;
+	}
+	if (!daxctl_dev_is_famfs_mode(dev)) {
+		fprintf(stderr, "%s is not in famfs mode\n", devname);
 		return 1;
 	}
 	rc = daxctl_dev_disable(dev);
@@ -711,6 +753,7 @@ static int disable_devdax_device(struct daxctl_dev *dev)
 
 static int reconfig_mode_system_ram(struct daxctl_dev *dev)
 {
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
 	const char *devname = daxctl_dev_get_devname(dev);
 	int rc, skip_enable = 0;
 
@@ -724,11 +767,21 @@ static int reconfig_mode_system_ram(struct daxctl_dev *dev)
 	}
 
 	if (daxctl_dev_is_enabled(dev)) {
-		rc = disable_devdax_device(dev);
-		if (rc < 0)
-			return rc;
-		if (rc > 0)
+		if (mem) {
+			/* already in system-ram mode */
 			skip_enable = 1;
+		} else if (daxctl_dev_is_famfs_mode(dev)) {
+			rc = disable_famfs_device(dev);
+			if (rc)
+				return rc;
+		} else if (daxctl_dev_is_devdax_mode(dev)) {
+			rc = disable_devdax_device(dev);
+			if (rc)
+				return rc;
+		} else {
+			fprintf(stderr, "%s: unknown mode\n", devname);
+			return -EINVAL;
+		}
 	}
 
 	if (!skip_enable) {
@@ -750,7 +803,7 @@ static int disable_system_ram_device(struct daxctl_dev *dev)
 	int rc;
 
 	if (!mem) {
-		fprintf(stderr, "%s was already in devdax mode\n", devname);
+		fprintf(stderr, "%s is not in system-ram mode\n", devname);
 		return 1;
 	}
 
@@ -786,12 +839,28 @@ static int disable_system_ram_device(struct daxctl_dev *dev)
 
 static int reconfig_mode_devdax(struct daxctl_dev *dev)
 {
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
 	int rc;
 
 	if (daxctl_dev_is_enabled(dev)) {
-		rc = disable_system_ram_device(dev);
-		if (rc)
-			return rc;
+		if (mem) {
+			rc = disable_system_ram_device(dev);
+			if (rc)
+				return rc;
+		} else if (daxctl_dev_is_famfs_mode(dev)) {
+			rc = disable_famfs_device(dev);
+			if (rc)
+				return rc;
+		} else if (daxctl_dev_is_devdax_mode(dev)) {
+			/* already in devdax mode, just re-enable */
+			rc = daxctl_dev_disable(dev);
+			if (rc)
+				return rc;
+		} else {
+			fprintf(stderr, "%s: unknown mode\n", devname);
+			return -EINVAL;
+		}
 	}
 
 	rc = daxctl_dev_enable_devdax(dev);
@@ -801,6 +870,40 @@ static int reconfig_mode_devdax(struct daxctl_dev *dev)
 	return 0;
 }
 
+static int reconfig_mode_famfs(struct daxctl_dev *dev)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+	const char *devname = daxctl_dev_get_devname(dev);
+	int rc;
+
+	if (daxctl_dev_is_enabled(dev)) {
+		if (mem) {
+			fprintf(stderr,
+				"%s is in system-ram mode, must be in devdax mode to convert to famfs\n",
+				devname);
+			return -EINVAL;
+		} else if (daxctl_dev_is_famfs_mode(dev)) {
+			/* already in famfs mode, just re-enable */
+			rc = daxctl_dev_disable(dev);
+			if (rc)
+				return rc;
+		} else if (daxctl_dev_is_devdax_mode(dev)) {
+			rc = disable_devdax_device(dev);
+			if (rc)
+				return rc;
+		} else {
+			fprintf(stderr, "%s: unknown mode\n", devname);
+			return -EINVAL;
+		}
+	}
+
+	rc = daxctl_dev_enable_famfs(dev);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 static int do_create(struct daxctl_region *region, long long val,
 		     struct json_object **jdevs)
 {
@@ -887,6 +990,9 @@ static int do_reconfig(struct daxctl_dev *dev, enum dev_mode mode,
 	case DAXCTL_DEV_MODE_DEVDAX:
 		rc = reconfig_mode_devdax(dev);
 		break;
+	case DAXCTL_DEV_MODE_FAMFS:
+		rc = reconfig_mode_famfs(dev);
+		break;
 	default:
 		fprintf(stderr, "%s: unknown mode requested: %d\n",
 			devname, mode);
diff --git a/daxctl/json.c b/daxctl/json.c
index 3cbce9d..01f139b 100644
--- a/daxctl/json.c
+++ b/daxctl/json.c
@@ -48,8 +48,12 @@ struct json_object *util_daxctl_dev_to_json(struct daxctl_dev *dev,
 
 	if (mem)
 		jobj = json_object_new_string("system-ram");
-	else
+	else if (daxctl_dev_is_famfs_mode(dev))
+		jobj = json_object_new_string("famfs");
+	else if (daxctl_dev_is_devdax_mode(dev))
 		jobj = json_object_new_string("devdax");
+	else
+		jobj = json_object_new_string("unknown");
 	if (jobj)
 		json_object_object_add(jdev, "mode", jobj);
 
diff --git a/daxctl/lib/libdaxctl-private.h b/daxctl/lib/libdaxctl-private.h
index ae45311..0bb73e8 100644
--- a/daxctl/lib/libdaxctl-private.h
+++ b/daxctl/lib/libdaxctl-private.h
@@ -21,12 +21,14 @@ static const char *dax_subsystems[] = {
 enum daxctl_dev_mode {
 	DAXCTL_DEV_MODE_DEVDAX = 0,
 	DAXCTL_DEV_MODE_RAM,
+	DAXCTL_DEV_MODE_FAMFS,
 	DAXCTL_DEV_MODE_END,
 };
 
 static const char *dax_modules[] = {
 	[DAXCTL_DEV_MODE_DEVDAX] = "device_dax",
 	[DAXCTL_DEV_MODE_RAM] = "kmem",
+	[DAXCTL_DEV_MODE_FAMFS] = "fsdev_dax",
 };
 
 enum memory_op {
diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index b7fa0de..0a6cbfe 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -418,6 +418,78 @@ DAXCTL_EXPORT int daxctl_dev_is_system_ram_capable(struct daxctl_dev *dev)
 	return false;
 }
 
+/*
+ * Check if device is currently in famfs mode (bound to fsdev_dax driver)
+ */
+DAXCTL_EXPORT int daxctl_dev_is_famfs_mode(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *mod_path, *mod_base;
+	char path[200];
+	const int len = sizeof(path);
+
+	if (!device_model_is_dax_bus(dev))
+		return false;
+
+	if (!daxctl_dev_is_enabled(dev))
+		return false;
+
+	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return false;
+	}
+
+	mod_path = realpath(path, NULL);
+	if (!mod_path)
+		return false;
+
+	mod_base = basename(mod_path);
+	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_FAMFS]) == 0) {
+		free(mod_path);
+		return true;
+	}
+
+	free(mod_path);
+	return false;
+}
+
+/*
+ * Check if device is currently in devdax mode (bound to device_dax driver)
+ */
+DAXCTL_EXPORT int daxctl_dev_is_devdax_mode(struct daxctl_dev *dev)
+{
+	const char *devname = daxctl_dev_get_devname(dev);
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	char *mod_path, *mod_base;
+	char path[200];
+	const int len = sizeof(path);
+
+	if (!device_model_is_dax_bus(dev))
+		return false;
+
+	if (!daxctl_dev_is_enabled(dev))
+		return false;
+
+	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n", devname);
+		return false;
+	}
+
+	mod_path = realpath(path, NULL);
+	if (!mod_path)
+		return false;
+
+	mod_base = basename(mod_path);
+	if (strcmp(mod_base, dax_modules[DAXCTL_DEV_MODE_DEVDAX]) == 0) {
+		free(mod_path);
+		return true;
+	}
+
+	free(mod_path);
+	return false;
+}
+
 /*
  * This checks for the device to be in system-ram mode, so calling
  * daxctl_dev_get_memory() on a devdax mode device will always return NULL.
@@ -982,6 +1054,11 @@ DAXCTL_EXPORT int daxctl_dev_enable_ram(struct daxctl_dev *dev)
 	return daxctl_dev_enable(dev, DAXCTL_DEV_MODE_RAM);
 }
 
+DAXCTL_EXPORT int daxctl_dev_enable_famfs(struct daxctl_dev *dev)
+{
+	return daxctl_dev_enable(dev, DAXCTL_DEV_MODE_FAMFS);
+}
+
 DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
 {
 	const char *devname = daxctl_dev_get_devname(dev);
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 3098811..2a812c6 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -104,3 +104,10 @@ LIBDAXCTL_10 {
 global:
 	daxctl_dev_is_system_ram_capable;
 } LIBDAXCTL_9;
+
+LIBDAXCTL_11 {
+global:
+	daxctl_dev_enable_famfs;
+	daxctl_dev_is_famfs_mode;
+	daxctl_dev_is_devdax_mode;
+} LIBDAXCTL_10;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 53c6bbd..84fcdb4 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -72,12 +72,15 @@ int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 int daxctl_dev_disable(struct daxctl_dev *dev);
 int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
 int daxctl_dev_enable_ram(struct daxctl_dev *dev);
+int daxctl_dev_enable_famfs(struct daxctl_dev *dev);
 int daxctl_dev_get_target_node(struct daxctl_dev *dev);
 int daxctl_dev_will_auto_online_memory(struct daxctl_dev *dev);
 int daxctl_dev_has_online_memory(struct daxctl_dev *dev);
 
 struct daxctl_memory;
 int daxctl_dev_is_system_ram_capable(struct daxctl_dev *dev);
+int daxctl_dev_is_famfs_mode(struct daxctl_dev *dev);
+int daxctl_dev_is_devdax_mode(struct daxctl_dev *dev);
 struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev);
 struct daxctl_dev *daxctl_memory_get_dev(struct daxctl_memory *mem);
 const char *daxctl_memory_get_node_path(struct daxctl_memory *mem);
-- 
2.49.0

