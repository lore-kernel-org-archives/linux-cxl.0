Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7E3876B5
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529457; cv=none; b=LvxUPvmRi6X6k3Tq/TrPxaf/umuecv5U2yrFZv0CV4O8avDfc5HVYqO1JcFsPcsPBMyfyCqOk7pumy5Ip/9A9bsaT+sY+o/OPjStG0AM6y2lFnEVxJK+Uw7uXn6WszdiIvNkJk/5S9eMN9jwvnuJ4cAeol7lM+aK2aRqDUbosYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529457; c=relaxed/simple;
	bh=slI4nvrX63CgPuf0Zdsw9jQIJ2+RZL8IaZz0qSbJ7Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPj5vZFYESJIsH7pf63wJe6BYkmlYhfV1kkOjuJjEj8v+EN93sQ87H4d8aXAgJeA8o4LAuCQ3uX1vJURd5bFtlppyiXfFUMCW+hwhGTj+GTs5KFZ3P1xqhv+3e2R4XKDmupRYrjqeEriGDQub55nQc8wLq0Aw9SiuyDGMDUdYxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3vcKAsQ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3vcKAsQ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13621cca8f5so5370958c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529454; x=1780134254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdCEB4+GSe0WqjUBIw1Z2Tl7ajOiH3CDmRtVej+qJq8=;
        b=i3vcKAsQaR9s6keLi0+j758II1uuS6gttPuLiuAk6EL55BHZrA6hS1DX7Nd5xui/+w
         bwOJwLEk33nwp5Eqr1D9O4pOp+3LBV+di+3iS0o9lcK7I9TnWSx7P6KPMdnkCtKpRYqy
         RWteZepPVg/0BdIU4B6lgQc6kwEzHrw8S/CTRTQXhigF6yBJTlEAsp2FeBcNLgp6zIRf
         e920GWtnIaEeAmEmkDcA7Odht9D/2ISr6/lMhKPSCIHcqZz7mECeubUxal3MDfYiuxBx
         B3cHSGwJeYzSruV7ZtGDjZMWcZuRaW9FdQoy0bcv9aBTmspbrG6av/8aXruR5ZLpYxxV
         RDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529454; x=1780134254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdCEB4+GSe0WqjUBIw1Z2Tl7ajOiH3CDmRtVej+qJq8=;
        b=EisADriHR+eHQlgmmMps2MEOm3LwDgiLSOzvFV2+zgC4nXSzOiL5aQPHoOe2WYvIrj
         IUOhya1/WjWpeUwoJFw2t9bIl/EY4JJQwLP6S+x4kOZBXvQjgHkZRXgeHTYnxgyaZMTh
         IiB2CbRJS76b48p4bJK46OEnWfHKNfi2HtLYy8BeFy1y3rdvC1QTo+qX2zDOx6MJOw+x
         7ZmbG/lB8j8W2E9PQETOgihKeZJh+RINLWlKPIQGtG3W4bPTUtGmAWcfTjT9JCzmbBA8
         4HBeJUVzMxYjY4MVRG0D8SojTAZD+G6+0lQyYWwGWjffEVfmWBasTwnfMp0brrMjhZYD
         L1lg==
X-Gm-Message-State: AOJu0YwjOiJ/9g7zYBEfv8nG69j0vqTbo6Pqqb3IQc/Jjnv+yITC+iDe
	pDbVbOAk1P1sXUTPQO7vEUi2x24h+sRuyakq5B9tXOFAhw9nhZhxH/6xnP0pyQ==
X-Gm-Gg: Acq92OGMMf1h1OlBAd1L+4rnTAjLI+WDl7LG1RWZDbZEYkJe3hqxcLifdDhRG++7n9k
	UOsc6C/uFS6gxA7JxYaKkV9EpgHZ0PiFvit2ulhn6d7V79hqiCnZqoBtv+qjD0Cxk4c98msbz1f
	Oo0utYHqsEpbTB4dghx2z+k4N1AeAnhfCpqbG1DH8JMwrvvuVxdICYvfzK9r9gw985GzeFR8U9Y
	DNTo0dsdHpRAROSI++Tcg5tWTTuW6PKvPP6T4bDAi3Zgx8NtmcFU9tRrfGpA2TMSK9ckQsw4j26
	aatPuwSi0Ube3k39bDdPrn9xQ+uZbJKaNPf2eEdj/n3H0DbxK2NvWq7Jpxorf1GoUEGFs3Czi9J
	aCH1v4R4LS/SkpAqb1LBxv1bkp3ztbiy98xneNl31SLY0UPI9K5CktgVtXE2VFGHjpta16k/nex
	OMpKtOylvSsWq8zGXOYkQbhAOUAURbTN6RVzso/ayFMfTegGwcRMCYEnxbD7ggWV3/eFD9s4grw
	UVdH2DDVwDlnXJXiYZyQCZ2q/NX
X-Received: by 2002:a05:7022:60d:b0:130:ab68:2b6f with SMTP id a92af1059eb24-1365f812d70mr2615308c88.9.1779529454246;
        Sat, 23 May 2026 02:44:14 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:13 -0700 (PDT)
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
Subject: [PATCH v10 19/31] cxl/extent: Enforce cross-region tag uniqueness
Date: Sat, 23 May 2026 02:43:13 -0700
Message-ID: <8f4aa2f5da26221efdd85650578c953657466e0f.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The per-region scan in cxl_tag_already_committed() only catches a tag
re-appearing on the same cxlr_dax.  The orchestrator owns tag
allocation and is responsible for global uniqueness, but a buggy FM
(or firmware redelivering a tag for a previously-closed allocation)
can still hand the same uuid to extents on two different regions or
memdevs, and the per-region check accepts the second one — leaving
two independent cxl_dc_tag_group objects with the same uuid.

Add a host-wide registry of live tag groups with non-null uuids.
alloc_tag_group() inserts on success, free_tag_group() removes; both
skip the null-uuid case since the spec defines no cross-chain identity
for untagged allocations.

An attempt to add a second group with the same uuid fails with
-EBUSY.

No exit hook is needed: cxl_core only unloads after every dependent
module has, by which point every live tag group has been freed and
the registry is empty.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 drivers/cxl/core/core.h   |  5 ++++
 drivers/cxl/core/extent.c | 60 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c   | 19 +++++++++++++
 drivers/cxl/cxl.h         |  3 ++
 4 files changed, 87 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 65daaaadf68e..02b36728c22d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -69,6 +69,7 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
 
 int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent,
 		   u16 seq_num);
+bool cxl_tag_already_committed(const uuid_t *tag);
 int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent);
 int online_tag_group(struct cxl_dc_tag_group *group);
 #else
@@ -91,6 +92,10 @@ static inline int online_tag_group(struct cxl_dc_tag_group *group)
 {
 	return 0;
 }
+static inline bool cxl_tag_already_committed(const uuid_t *tag)
+{
+	return false;
+}
 static inline
 struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa,
 				     struct cxl_endpoint_decoder **cxled)
diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
index 51116c8139ed..f66fa8c600c5 100644
--- a/drivers/cxl/core/extent.c
+++ b/drivers/cxl/core/extent.c
@@ -18,8 +18,60 @@ static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
 	memdev_release_extent(mds, &dc_extent->dpa_range);
 }
 
+/*
+ * Host-wide registry of live tag groups with non-null uuids.  Enforces
+ * that within this host, a tag uuid identifies exactly one allocation
+ * across all regions and memdevs — closing the gap left by the
+ * per-region scans in cxlr_add_extent() and uuid_claim_tagged().  The
+ * orchestrator (FM) owns tag-uuid allocation per spec; this is a
+ * defense against firmware bugs and orchestrator misbehavior.  Untagged
+ * (null uuid) allocations are not tracked: the spec defines no
+ * cross-chain identity for them.
+ */
+static DEFINE_MUTEX(cxl_tag_lock);
+static LIST_HEAD(cxl_tag_groups);
+
+static int cxl_tag_register(struct cxl_dc_tag_group *grp)
+{
+	struct cxl_dc_tag_group *g;
+
+	if (uuid_is_null(&grp->uuid))
+		return 0;
+
+	guard(mutex)(&cxl_tag_lock);
+	list_for_each_entry(g, &cxl_tag_groups, registry_node)
+		if (uuid_equal(&g->uuid, &grp->uuid))
+			return -EBUSY;
+	list_add_tail(&grp->registry_node, &cxl_tag_groups);
+	return 0;
+}
+
+static void cxl_tag_unregister(struct cxl_dc_tag_group *grp)
+{
+	if (uuid_is_null(&grp->uuid))
+		return;
+
+	guard(mutex)(&cxl_tag_lock);
+	list_del(&grp->registry_node);
+}
+
+bool cxl_tag_already_committed(const uuid_t *tag)
+{
+	struct cxl_dc_tag_group *g;
+
+	if (uuid_is_null(tag))
+		return false;
+
+	guard(mutex)(&cxl_tag_lock);
+	list_for_each_entry(g, &cxl_tag_groups, registry_node)
+		if (uuid_equal(&g->uuid, tag))
+			return true;
+	return false;
+}
+
 static void free_tag_group(struct cxl_dc_tag_group *group)
 {
+	cxl_tag_unregister(group);
 	xa_destroy(&group->dc_extents);
 	kfree(group);
 }
@@ -54,12 +106,20 @@ alloc_tag_group(struct cxl_dax_region *cxlr_dax, uuid_t *uuid)
 {
 	struct cxl_dc_tag_group *group __free(kfree) =
 				kzalloc(sizeof(*group), GFP_KERNEL);
+	int rc;
+
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
 	group->cxlr_dax = cxlr_dax;
 	uuid_copy(&group->uuid, uuid);
 	xa_init(&group->dc_extents);
+	INIT_LIST_HEAD(&group->registry_node);
+
+	rc = cxl_tag_register(group);
+	if (rc)
+		return ERR_PTR(rc);
+
 	return no_free_ptr(group);
 }
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 70e6c4c9743c..85959dee35ea 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1474,6 +1474,25 @@ static int cxl_add_pending(struct cxl_memdev_state *mds)
 		extract_tag_group(pending, &tag, &group);
 		list_sort(NULL, &group, extent_seq_compare);
 
+		/*
+		 * Cross-More-chain uniqueness.  A non-null tag seen in this
+		 * group must not already correspond to a committed tag group
+		 * anywhere on this host.  More=0 was supposed to close that
+		 * allocation, and tag uuids must be unique across all regions
+		 * and memdevs (the orchestrator owns assignment per spec).
+		 * Either constraint failing — same chain redelivered, or two
+		 * distinct allocations colliding on the same uuid — is a
+		 * firmware/orchestrator bug; reject the whole group.
+		 */
+		if (cxl_tag_already_committed(&tag)) {
+			dev_warn(dev,
+				 "Tag %pUb: dropping group, tag already committed (firmware/orchestrator bug)\n",
+				 &tag);
+			list_for_each_entry_safe(pos, tmp, &group, list)
+				delete_extent_node(pos);
+			continue;
+		}
+
 		/* Sequence-number integrity */
 		if (cxl_check_group_seq(dev, &tag, &group)) {
 			list_for_each_entry_safe(pos, tmp, &group, list)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cbbfba92fea9..a28e7b12a4a8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -598,12 +598,15 @@ struct cxl_dax_region {
  *		allocations.
  * @nr_extents: live count of dc_extents in the group; the group is freed
  *		when the last dc_extent device is released.
+ * @registry_node: anchor in the host-wide non-null-tag registry that
+ *		enforces tag uuid uniqueness across all regions and memdevs.
  */
 struct cxl_dc_tag_group {
 	struct cxl_dax_region *cxlr_dax;
 	uuid_t uuid;
 	struct xarray dc_extents;
 	unsigned int nr_extents;
+	struct list_head registry_node;
 };
 
 bool is_dc_extent(struct device *dev);
-- 
2.43.0

