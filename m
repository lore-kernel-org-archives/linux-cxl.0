Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE43BD239
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047346; cv=pass; b=Ab4eVIw/6opxjrF5loeC7RbcoG54w8HwXnfz4fdqDfR8lvxxwbgsJOCh22jhUoWS+K2OaAvBaIF4xS+78bu2xNZU3zNNEymVTKdNUmOe9rA+xTHXBC//yO7DITEzAISM+jDFkfyB3jaSJszqN8/g5ZNfFiFs7lZcsEquB7y40Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047346; c=relaxed/simple;
	bh=A6c464M0lZK7+cHFfDP0C6rZFb75kA0PZ/H1oDLwpaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKVjRivrf5XM1ptgSEhj3WvOmQ2OY8txAijHGsq/Y+8WpYnksNeySh1Md6jR7N2+PTBw7ygjdZBifel3nnCq8T+Nh+xzB6b5dx833M9IdoMjSBJW8A6FGi/hD/UnmGGv6omjGWxH44Nvu6FOxsCDDuSQNWswnyIAriA1Wxhtd9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=GWox22A5; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="GWox22A5"
ARC-Seal: i=1; a=rsa-sha256; t=1775047334; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gsZ+mWu/WS8CAa1kw7RkXSIsLcdrw4lT1glF4/PxLAZOjAzSfqtYWBWYxf8Vcsq4GR4FerZrPbA13YC+9amuyeSld/ufu01yhLLUmRZPu2woD2TyU3FiM1pkSaDLbBzkIcLWeXEMAfC8qY1KOML6rDXs/nfAKnGvjj4kAwauPHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775047334; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qT6MMGwpUQay6ycbrqO/drc/KIfqDvCxiKOq4M977d8=; 
	b=AYyox48x6WoG3GmWUfEjwzx9gx0uO8IWhTpWwtN6CXAGkKwtlSvU5dKXH6SqPl5nvmduXGsaH8SagQuIcxYOfW9TcWWTUGHmdGi2hBV2YwAwqmYeNyWpR0Vd/6RoP2Mq8UM989EgwaNX41A5LE+hpyaKviM1ieq4WpyjeUKz+HU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775047334;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=qT6MMGwpUQay6ycbrqO/drc/KIfqDvCxiKOq4M977d8=;
	b=GWox22A5p9MC9d+vTknhS2hqPGKBUsvMUSPG1qR8388YcSVcr/R91IspPO6OvrLb
	s6Em3lmWqCnbXHYz4vl9HNyRuhhPQdueyIoRPVmqARz1UkgSOUoMH6mSHEHVoUCnvx/
	WcanwX3QSmVxOgu8yk577tTVuuPhC7bBGto4vNK0=
Received: by mx.zohomail.com with SMTPS id 1775047332877771.7299283335816;
	Wed, 1 Apr 2026 05:42:12 -0700 (PDT)
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
Subject: [ndctl PATCH v2 1/1] ndctl/cxl: Show region locked status to user
Date: Wed,  1 Apr 2026 20:42:05 +0800
Message-ID: <20260401124205.1288996-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122838169af71b46a7743a74da130000a5b0df47450b8e32cc8fdfa942518d9362cfda6f689a7d9f71ba:zu080112277b9574a1d16c60d5d398aa590000df9539d523df6f8d573cfa9ba6f1299a153c41e2a600d3b3cb:rf0801122d6b5775b60b6fa7d4b6b5506e000062eebb32970bdad28f21f5ed9aa0b51abcd9708b2d71147d6cc6b0fedc743e:ZohoMail
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
v2:
* Move lock status checking to the beginning of destroy_region().
  (Alison)
---
 cxl/json.c         |  4 ++++
 cxl/lib/libcxl.c   | 11 +++++++++++
 cxl/lib/libcxl.sym |  5 +++++
 cxl/lib/private.h  |  1 +
 cxl/libcxl.h       |  1 +
 cxl/region.c       |  6 ++++++
 6 files changed, 28 insertions(+)

diff --git a/cxl/json.c b/cxl/json.c
index a0dc343..3bbe07a 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -1077,6 +1077,10 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
 			json_object_object_add(jregion, "state", jobj);
 	}
 
+	jobj = json_object_new_boolean(cxl_region_is_locked(region));
+	if (jobj)
+		json_object_object_add(jregion, "locked", jobj);
+
 	if (flags & UTIL_JSON_MEDIA_ERRORS) {
 		jobj = util_cxl_poison_list_to_json(region, NULL, flags);
 		if (jobj)
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 5e8deb6..ce2b364 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -472,6 +472,11 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
 	return is_enabled(path);
 }
 
+CXL_EXPORT bool cxl_region_is_locked(struct cxl_region *region)
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
+		region->locked = false;
+	else
+		region->locked = strtoul(buf, NULL, 0);
+
 	cxl_region_foreach_safe(decoder, region_dup, _r)
 		if (region_dup->id == region->id) {
 			list_del_from(&decoder->regions, &region_dup->list);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 797e398..7c586f4 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -315,3 +315,8 @@ global:
 	cxl_memdev_clear_poison;
 	cxl_debugfs_exists;
 } LIBCXL_10;
+
+LIBCXL_12 {
+global:
+	cxl_region_is_locked;
+} LIBCXL_11;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 582eebf..d074122 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -189,6 +189,7 @@ struct cxl_region {
 	u64 start;
 	u64 size;
 	u64 cache_size;
+	bool locked;
 	unsigned int interleave_ways;
 	unsigned int interleave_granularity;
 	enum cxl_decode_state decode_state;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index a853ab6..6ff58de 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -353,6 +353,7 @@ int cxl_region_clear_all_targets(struct cxl_region *region);
 int cxl_region_decode_commit(struct cxl_region *region);
 int cxl_region_decode_reset(struct cxl_region *region);
 bool cxl_region_qos_class_mismatch(struct cxl_region *region);
+bool cxl_region_is_locked(struct cxl_region *region);
 
 #define cxl_region_foreach(decoder, region)                                    \
 	for (region = cxl_region_get_first(decoder); region != NULL;           \
diff --git a/cxl/region.c b/cxl/region.c
index 207cf2d..8a85522 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -837,6 +837,12 @@ static int destroy_region(struct cxl_region *region)
 	unsigned int ways, i;
 	int rc;
 
+	if (cxl_region_is_locked(region)) {
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

