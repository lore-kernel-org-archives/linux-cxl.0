Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25340DFDA
	for <linux-cxl@vger.kernel.org>; Sun, 29 Mar 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795667; cv=pass; b=ZbFdTjhG6Xoz2m3cKybrD+BkUx60tLGSrvI0OoU5yuAxVjMh2EP1HSegxqOzgo1bKckhzWVZlKvrENY8UWD0EEhO7hRiXhvityhj0enxLp+qhba8GF7oPC8E8VqR3Ig7iiuMaEdHn0aBHjdSBHmHgc7smgfdYm8HhoQX+3qwywc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795667; c=relaxed/simple;
	bh=GYRe3twZ1oRCugq2swQzDGpxhJuHXULYxYfQ4JyMprQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0cr9U2FDrDzV9Lw7gbXPgOigK/AKap4pgCGFV2KGY+0FSPK394OQCnP2zJ+qcVURATxcueNu6qtTPyHuj/sT0D68SqUmArqx6LURihg31m78f77QuUQM7Qs4vizuOVSSDXm/kCVeA4kgSyJVlcoPSdd/tz77LIvVHyTsyVo1RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=GS+lqbC6; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="GS+lqbC6"
ARC-Seal: i=1; a=rsa-sha256; t=1774795654; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TFZbdYuoqmLH3L0lO0Jo6ZRmWrU8+Xuk6qhcBdqrNEHeyjFz0IwpjFuVS+ES7FWrkIhLK90Xh6OYtM62KxtZwt/z2WwyiCGKnwbRfFWu/SEIZf79DRNDE2V284gu4TPKCrvDhK7GkN6uQOYABbggZCsgom51TWy4r8eJhRgHSm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774795654; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=coOK7NtPRHVqev0TZEdagCRrs25LxcpIylGu9UrAyso=; 
	b=FKTuUuQ69IIPeF5JioaXjqNB2PRMdg2LUblB53kxHVf6+B4HKd3ypCkzRM4MHjPTkGme/fMpA+TC1yDKHaPpeftdnnd+v4IUxlZuOwbr5vSgXO88bb1fs6Jffge1HAUb1BXpRBqvhNFLtPBBNMRyS7ll3Fk26MjYmiaUhbNc1ok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774795654;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=coOK7NtPRHVqev0TZEdagCRrs25LxcpIylGu9UrAyso=;
	b=GS+lqbC6ctZEDTa3iU8knHT6fCeC2zaciiP1Q5k1mYMGE/24JQ2PYD74Kn0mwK5M
	B/47q9QNyq5ZtEq7vjgiYI/d4uR8Riq/+IStEgPujYKK3w9qVuEH9n8xhBpyY/EXaRg
	UFsI8uroY+OyASg+IwQFLklq5o7qhpZsqZvu42P0=
Received: by mx.zohomail.com with SMTPS id 1774795651448530.5698139063169;
	Sun, 29 Mar 2026 07:47:31 -0700 (PDT)
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
Subject: [PATCH 1/1] ndctl: Show region locked status to user
Date: Sun, 29 Mar 2026 22:47:14 +0800
Message-ID: <20260329144714.888155-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228d4a89545e50a5543037ca59800006133a36ddc57441d863fd1f33526c6fd01dcc6867993833428f6:zu080112270aa0c3088d54b8687f8af4f40000c5ebefb57ef6994640decabde96397e9eacebfa78ea5c626c3:rf0801122d3689751ac2114499ff7a6bbd00001255adbeecdc5d88dd5c3d41e3c63212f9c86e215f05ce67fbf259ef848131:ZohoMail
X-ZohoMailClient: External

A region is not allowed to be destroyed if it is in locked status.
cxl destroy-region command will fail and ask user to try it again as
root, but it is not the real reason and it will confuse user if user is
already a root user. This patch will shows the region locked status in
region information and outputs an explicit log to user that operation is
not allowed like below.

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
root@jammy-cloud:~/ndctl# cxl list -ir region0
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
index 207cf2d..a3b511e 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -853,6 +853,12 @@ static int destroy_region(struct cxl_region *region)
 		}
 	}
 
+	if (cxl_region_is_locked(region)) {
+		log_err(&rl, "%s: Cannot destroy a locked region.\n",
+			devname);
+		return -EPERM;
+	}
+
 	/* Reset the region decode in preparation for removal */
 	rc = cxl_region_decode_reset(region);
 	if (rc) {
-- 
2.43.0

