Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B4E25B2F4
	for <linux-cxl@vger.kernel.org>; Fri,  3 Apr 2026 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775192729; cv=pass; b=PvxfiH32C3lBID0PYHeF21+6FSm0jfpUiI8jR5CHrzaFsM/rHaUbLK8/gvu3uGf3eAj3DvCxBsTJg4L0BTrbywMwurS/drtYQHHsF1gUVz05HRfZa7pgXs6tcVDR+7HgD4QR/g2+Hp2cBSgJsU5a4fQm+huS/Rlv4qYdxr1EAN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775192729; c=relaxed/simple;
	bh=kW6XSE8RI6u44KR6Q8ZDA2dQPBAx9xp5NbfpGOkVOEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIxZcM1diyjk49tCfRD/MMl/5snMShmey9FNEfGPDBDoepm/lzu6O9bDfrf2wP6+5XKqlFe6ET0xen+BtrsXh0TEmLSPTxNmH5KwhEagV5kNgJ6tYHOnJzVlEVbCxfpKeKz9uKpjoQkjHSLyWMMMXBDGLPzchYeNwB6p2e25bng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Y1dKWytf; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Y1dKWytf"
ARC-Seal: i=1; a=rsa-sha256; t=1775192716; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AKAOH+k0+JwKrYVsAERZMhwcSNA2GN7ddL2yFZpoq711byLAR+SP998DLQCcaUsAIAqyshRRWOe+yKVBbp/SlWjORO0i/+WLLx8YVnb+EaSSlFaDn69IF/2Ap9dBjEKLwXDF9PZAGYfK226j330V+9wmX2Y3aPKvvwhM6d7YOcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775192716; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gqcBRkX5SKjK10sBPIIh++5ImdLB1uGEGxbapybqDJo=; 
	b=YeGMs2yh5lSpqjXJKfd+Ry9/qTFpFZ/xKcxt4QmCNGMC3xpNwVD79uc56rgoN6FRYo5VI2zqNQ/d22TSawGlTC8wKbEa5N8jowfiWnQD2SKQqppC1MbUPY0pcBubpBd7wsH1ocjk8KgFBZb/X++CVWTpihJHkL1c75wa2DZh638=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775192716;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=gqcBRkX5SKjK10sBPIIh++5ImdLB1uGEGxbapybqDJo=;
	b=Y1dKWytf5zrpnhfzRLtCf3wdcyf+p1337fT2MgxZELSg0sUEY43BYdbtlpe4FtDA
	UgrdW2YRXUkBfxvh+LI5g9qCtE8RsrIlfmGkOdsOSVqaTf3M6M9j3BqjDXciKdhIkXk
	YPqJvu6aOyLObBA7M6DpMivz1ZXYYdOtpiuwZKl4=
Received: by mx.zohomail.com with SMTPS id 1775192713464539.8635843670254;
	Thu, 2 Apr 2026 22:05:13 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	ming.li@zohomail.com
Subject: [ndctl PATCH v3 1/1] ndctl/cxl: Show region locked status to user
Date: Fri,  3 Apr 2026 13:04:59 +0800
Message-ID: <20260403050459.2236-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122823f92ea53a2ed608b7d5f5b50000e444d848c99b3c644a27d2ca65393ab35eb1b52603a05947ecd8:zu08011227bfb64a8fdcf3f03bc26f068a00001dcaabb337c6cd50e15c1a65d2a21468746b54c0e16fc16253:rf0801122d1c66af3199b63478e6d463dd00008bcf1d35691de896373c55068d6cc7361b84c84d79629f9bbf9f9a34281e7a:ZohoMail
X-ZohoMailClient: External

A region is not allowed to be destroyed if it is in locked status.
cxl destroy-region command will fail and ask user to try it again as
root, but it is not the real reason and it will confuse user if user is
already a root user. This patch will show the region locked status in
region information and output an explicit log to user that operation is
not permitted like below.

Before the patch:
cxl list -ir region0
[
  {
    "region":"region0",
    "resource":53955526656,
    "size":536870912,
    "type":"ram",
    "interleave_ways":2,
    "interleave_granularity":256,
    "decode_state":"commit",
    "state":"disabled",
    "qos_class_mismatch":true
  }
]

cxl destroy-region region0
libcxl: write_attr: failed to write 0
 to /sys/bus/cxl/devices/root0/decoder0.0/region0/commit: Operation not permitted hint: try running as root or using sudo
cxl region: destroy_region: region0: failed to reset decode: Operation not permitted
cxl region: decoder_region_action: region0: failed: Operation not permitted
cxl region: region_action: one or more failures, last failure: Operation not permitted
cxl region: cmd_destroy_region: destroyed 0 regions

After the patch:
cxl list -ir region0
[
  {
    "region":"region0",
    "resource":53955526656,
    "size":536870912,
    "type":"ram",
    "interleave_ways":2,
    "interleave_granularity":256,
    "decode_state":"commit",
    "state":"disabled",
    "locked":true,
    "qos_class_mismatch":true
  }
]

cxl destroy-region region0
cxl region: destroy_region: region0: Cannot destroy a locked region.
cxl region: decoder_region_action: region0: failed: Operation not permitted
cxl region: region_action: one or more failures, last failure: Operation not permitted
cxl region: cmd_destroy_region: destroyed 0 regions

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v3:
* Set locked state to unknown if no sysfs locked attribute exposed.
  (Alison)

v2:
* Move lock status checking to the beginning of destroy_region().
  (Alison)
---
 cxl/json.c         |  6 ++++++
 cxl/lib/libcxl.c   | 11 +++++++++++
 cxl/lib/libcxl.sym |  5 +++++
 cxl/lib/private.h  |  1 +
 cxl/libcxl.h       |  8 ++++++++
 cxl/region.c       |  6 ++++++
 6 files changed, 37 insertions(+)

diff --git a/cxl/json.c b/cxl/json.c
index a0dc343..eee7781 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -1077,6 +1077,12 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
 			json_object_object_add(jregion, "state", jobj);
 	}
 
+	if (cxl_region_locked_state(region) != CXL_REGION_LOCKED_UNKNOWN) {
+		jobj = json_object_new_boolean(cxl_region_locked_state(region));
+		if (jobj)
+			json_object_object_add(jregion, "locked", jobj);
+	}
+
 	if (flags & UTIL_JSON_MEDIA_ERRORS) {
 		jobj = util_cxl_poison_list_to_json(region, NULL, flags);
 		if (jobj)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 5e8deb6..2945d21 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -472,6 +472,11 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
 	return is_enabled(path);
 }
 
+CXL_EXPORT int cxl_region_locked_state(struct cxl_region *region)
+{
+	return region->locked;
+}
+
 CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
 {
 	struct cxl_decoder *root_decoder = cxl_region_get_decoder(region);
@@ -689,6 +694,12 @@ static void *add_cxl_region(void *parent, int id, const char *cxlregion_base)
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		region->module = util_modalias_to_module(ctx, buf);
 
+	sprintf(path, "%s/locked", cxlregion_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		region->locked = CXL_REGION_LOCKED_UNKNOWN;
+	else
+		region->locked = strtoul(buf, NULL, 0);
+
 	cxl_region_foreach_safe(decoder, region_dup, _r)
 		if (region_dup->id == region->id) {
 			list_del_from(&decoder->regions, &region_dup->list);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 797e398..ed4429f 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -315,3 +315,8 @@ global:
 	cxl_memdev_clear_poison;
 	cxl_debugfs_exists;
 } LIBCXL_10;
+
+LIBCXL_12 {
+global:
+	cxl_region_locked_state;
+} LIBCXL_11;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 582eebf..d2d71fc 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -189,6 +189,7 @@ struct cxl_region {
 	u64 start;
 	u64 size;
 	u64 cache_size;
+	enum cxl_region_locked_state locked;
 	unsigned int interleave_ways;
 	unsigned int interleave_granularity;
 	enum cxl_decode_state decode_state;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index a853ab6..e6eec8e 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -354,6 +354,14 @@ int cxl_region_decode_commit(struct cxl_region *region);
 int cxl_region_decode_reset(struct cxl_region *region);
 bool cxl_region_qos_class_mismatch(struct cxl_region *region);
 
+enum cxl_region_locked_state {
+	CXL_REGION_LOCKED_UNKNOWN = -1,
+	CXL_REGION_UNLOCKED,
+	CXL_REGION_LOCKED,
+};
+
+int cxl_region_locked_state(struct cxl_region *region);
+
 #define cxl_region_foreach(decoder, region)                                    \
 	for (region = cxl_region_get_first(decoder); region != NULL;           \
 	     region = cxl_region_get_next(region))
diff --git a/cxl/region.c b/cxl/region.c
index 207cf2d..853cd08 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -837,6 +837,12 @@ static int destroy_region(struct cxl_region *region)
 	unsigned int ways, i;
 	int rc;
 
+	if (cxl_region_locked_state(region) == CXL_REGION_LOCKED) {
+		log_err(&rl, "%s: Cannot destroy a locked region.\n",
+			devname);
+		return -EPERM;
+	}
+
 	/* First, unbind/disable the region if needed */
 	if (cxl_region_is_enabled(region)) {
 		if (param.force) {
-- 
2.43.0

