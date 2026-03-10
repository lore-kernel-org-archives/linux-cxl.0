Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A92D8DDD;
	Tue, 10 Mar 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158390; cv=pass; b=Nm36H6OfsX9mbCc1u80qXj9OtwkVWU3F4ETg8KRtYkEeRUvKXmTX6x4xcRONLo+e8OjnkAz46jxQ7oO6HNz0vBtuiH1WGDb+5FxkCagQqWyFROuhiqAua8jgQrdFf6PN9xRa6OxTC9pN36ryEjm/wI+G7ZKimpYaWHPdG4k3cMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158390; c=relaxed/simple;
	bh=7uXjgUS17rN8Ll/gnRcu85M6/i9qBoCICZaBKbWjeJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieHl+clBZN9w7nW9Ks6z718Djpjbf0vrQMQx0rQOuNn5tTbZcbcoyIU4FapS6r7FiYUYAgGy8BcUVmm5XizbeAEYVpC+H8iAYyuqQcSMZhAveXUgalhyhzogeNkGJbDshcEtBwosnrE8oJ780sO8B1dsfwn6EPLsZPMN05q9tWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QneG5rvr; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QneG5rvr"
ARC-Seal: i=1; a=rsa-sha256; t=1773158315; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KHaFQKHXj3QeFgzhm5w0ysBLkqCSAuBPLVwDcpee734vpylG8DZ/bGa4iPkFQYueypsGOMZaRmpuaEo/iFjVf3Y7AZipbk+8yubXqzppmvCwuLP4UAYYnLaKoWZSXQO9dYM1ixADdfet9xK3rIFdqisDbAQGNlQV2zInTvU93ZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773158315; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+RPEIbMEe8q6eYLYeU4hi/v6ximwu60dK8z8ozgBoqA=; 
	b=C69X0h6I6nH4kSkSyl5FXirA6En7neM5cd1fq4G7Xl3xo6fTV7rbIrhdZ55afkHrYCsospV593py3MM/6Qn0kLbtk2W7tBrVr18ZZdxqYwwxSxhKdYTfZdEg5TCtsDHz5VpyslWQDPbgfwKwjljf1ICSYmFwAPo+j5++a4zFwsQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773158315;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=+RPEIbMEe8q6eYLYeU4hi/v6ximwu60dK8z8ozgBoqA=;
	b=QneG5rvrvaeYUXaEVhzv2SPU6DPtCfCftvAday96MTMx8tX+BCfBhDAV0G3DQ2mB
	5yftQuLPnYkTMvfj/eXfS+auV8gFIzP7iwhvkLNm9mio8xEdP4o4g6rMX+eyAJSKCmi
	x1IEES2myKwjYR+rEPLN0QNU3pqp7a2l0cnfuAkk=
Received: by mx.zohomail.com with SMTPS id 177315831278026.18028059296273;
	Tue, 10 Mar 2026 08:58:32 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Mar 2026 23:57:55 +0800
Subject: [PATCH 3/7] cxl/region: Hold memdev lock during region poison
 injection/clear
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-fix_access_endpoint_without_drv_check-v1-3-94fe919a0b87@zohomail.com>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773158297; l=5515;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=7uXjgUS17rN8Ll/gnRcu85M6/i9qBoCICZaBKbWjeJ4=;
 b=xFC3LCto5UbkXryqeZTlYX8CaT7FkR9iqQv8qgAxGBLtL992Bo3Hlgu4sKh7KhTGqa4hMdKO1
 Mkd7C+G32xBA3cIGv47ksO0s+GwbLY4NYpbiF5MN2RwCW4oJbttJ5JP
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228cb73c16a3c571c9f26fcee140000409ad2aa4cf679071ad0393842c5e9db4f0624cd9315fcd58035:zu08011227beb5cb94cb9e0a7fb0d728d20000ddb8908f84b6e05a681563cd6af3fa6a51f5b5146db2e8a2da:rf0801122df722e868c718e3f2a9f790e3000013f66bbdc2c1918c15ef9a335a7d2e111dca2a554d6489fbe3f8db10ba8332:ZohoMail
X-ZohoMailClient: External

cxl_dpa_to_region() will require callers holding the given CXL memdev
lock for endpoint validity checking in the following patch. To prepare
it, region poison injection/clearing debugfs interfaces need to ensure
the correct CXL memdev lock is held at the beginning.

To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
for avoiding deadlock. the interfaces have to find out the correct CXL
memdev at first, holding lock in the sequence then checking if the DPA
data has been changed before holding locks.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 101 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 42874948b589..806512dfab07 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4074,12 +4074,60 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
 	return 0;
 }
 
+static int cxl_region_poison_lookup_locked(struct cxl_region *cxlr, u64 offset,
+					   struct dpa_result *res)
+{
+	int rc;
+
+	*res = (struct dpa_result){ .dpa = ULLONG_MAX, .cxlmd = NULL };
+
+	if (validate_region_offset(cxlr, offset))
+		return -EINVAL;
+
+	offset -= cxlr->params.cache_size;
+	rc = region_offset_to_dpa_result(cxlr, offset, res);
+	if (rc || !res->cxlmd || res->dpa == ULLONG_MAX) {
+		dev_dbg(&cxlr->dev,
+			"Failed to resolve DPA for region offset %#llx rc %d\n",
+			offset, rc);
+
+		return rc ? rc : -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
+				    struct dpa_result *res)
+{
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return rc;
+
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return rc;
+
+	return cxl_region_poison_lookup_locked(cxlr, offset, res);
+}
+
 static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 {
-	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
 	struct cxl_region *cxlr = data;
+	struct dpa_result res1, res2;
 	int rc;
 
+	/* To retrieve the correct memdev */
+	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
+	if (rc)
+		return rc;
+
+	ACQUIRE(device_intr, devlock)(&res1.cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
@@ -4088,20 +4136,18 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
 
-	if (validate_region_offset(cxlr, offset))
-		return -EINVAL;
-
-	offset -= cxlr->params.cache_size;
-	rc = region_offset_to_dpa_result(cxlr, offset, &result);
-	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
+	/*
+	 * Retrieve memdev and DPA data again in case that the data
+	 * has been changed before holding locks.
+	 */
+	rc = cxl_region_poison_lookup_locked(cxlr, offset, &res2);
+	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {
 		dev_dbg(&cxlr->dev,
-			"Failed to resolve DPA for region offset %#llx rc %d\n",
-			offset, rc);
-
-		return rc ? rc : -EINVAL;
+			"Error injection raced region reconfiguration: %d", rc);
+		return -ENXIO;
 	}
 
-	return cxl_inject_poison_locked(result.cxlmd, result.dpa);
+	return cxl_inject_poison_locked(res2.cxlmd, res2.dpa);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
@@ -4109,10 +4155,19 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
 
 static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 {
-	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
 	struct cxl_region *cxlr = data;
+	struct dpa_result res1, res2;
 	int rc;
 
+	/* To retrieve the correct memdev */
+	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
+	if (rc)
+		return rc;
+
+	ACQUIRE(device_intr, devlock)(&res1.cxlmd->dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
@@ -4121,20 +4176,18 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
 
-	if (validate_region_offset(cxlr, offset))
-		return -EINVAL;
-
-	offset -= cxlr->params.cache_size;
-	rc = region_offset_to_dpa_result(cxlr, offset, &result);
-	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
+	/*
+	 * Retrieve memdev and DPA data again in case that the data
+	 * has been changed before holding locks.
+	 */
+	rc = cxl_region_poison_lookup_locked(cxlr, offset, &res2);
+	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {
 		dev_dbg(&cxlr->dev,
-			"Failed to resolve DPA for region offset %#llx rc %d\n",
-			offset, rc);
-
-		return rc ? rc : -EINVAL;
+			"Error clearing raced region reconfiguration: %d", rc);
+		return -ENXIO;
 	}
 
-	return cxl_clear_poison_locked(result.cxlmd, result.dpa);
+	return cxl_clear_poison_locked(res2.cxlmd, res2.dpa);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,

-- 
2.43.0

