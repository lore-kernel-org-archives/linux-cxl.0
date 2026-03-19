Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD230B502;
	Thu, 19 Mar 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929579; cv=pass; b=OQpqvtqid2rYcNqkVym1guOWbT3I7VhZRffTzz/NaS7QknuJPuTPFxxpVlqf/uWE67oc+kcEDPVZ+1lyqFXyrHOrjGVoNUgiV7UigbnyuPVSA+BtayE/wQmZfbeWEE60G8Z/gJ3k4frGTbz62IgYN+bYCbHL3OQccWPLOTSPnWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929579; c=relaxed/simple;
	bh=56w20MZUIlAyE115A6+FVQV8oAXDOglnPckBdBxKr+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NirSiJRqmp3IlX98DCQkkQUlgBmvN6kMbwkvgcd4uLHhfqlidtWGOC52QGizit3YRRG8BvLfvduTK0vYickGe4sVpMhUPE8ZULkNpk/GFIY49tOEw1ZRi8vZwBfhzPa7M2SU2e/VC8q6hYX0H49aux8tymy1kyr9X+602wACnKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aOnsuH3a; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aOnsuH3a"
ARC-Seal: i=1; a=rsa-sha256; t=1773929560; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dmYFhWyc5qcOfgldHxBWAzz8Tn3wFwjGFdudDiS2rJaCODQcD5N7igI2lyqvmPq3lSmgEaVB+qz0baPNSr4CWev+8GKqXB2fLMluYdYkjN2Y3rhdCgD7D8NoOz6fdIYXL6t70rVM82A9cAJ3rlHwQlHhF0fVswF7vLnxGs+RHss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773929560; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zfAMRlo2orfAVJO9MeMQPgE0r+KKNuOMF+3rhLUrZsY=; 
	b=PHPKdyoL0xNoGBC4pJW7fPj8e4tmNq3h1JsnKeeXgImLtxDkZ62dIZ8Jc8GQLbEPrfAvxkqz0UZRDWlsuvVDFysmk8fhT9od5NY/A83POF1/eI2PBJa42lZ1ATvXWdhgw9o+LErXOX7FxtjctzF0BAUKZiTteUC1GXNtq+0CpzQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773929560;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=zfAMRlo2orfAVJO9MeMQPgE0r+KKNuOMF+3rhLUrZsY=;
	b=aOnsuH3adMbGiLNnLaG0QspWraSBusdfpFEj57lj7RYOH5WrgEM0KBwNuaAAJTsI
	0Epqya1CgIb3QBgU2p0iGqGaC7IiMlYexvRx3+6uArck88bgYPZKVvtwiod8Sg8mKlp
	ME/opcF+yyMQ2ZMzIRdK7sWyplpCC+g4dL2GZJjM=
Received: by mx.zohomail.com with SMTPS id 1773929557163149.00069194712887;
	Thu, 19 Mar 2026 07:12:37 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Thu, 19 Mar 2026 22:12:09 +0800
Subject: [PATCH] cxl/region: Hold memdev lock during region poison
 injection/clear
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-hold_memdev_lock_for_region_poison_inject-clear-v1-1-05243c5a9572@zohomail.com>
X-B4-Tracking: v=1; b=H4sIADgEvGkC/x2NQQqDMBBFryKzbiCmEmyvUspgk1GnjRmZiBTEu
 zd09XiL9/8BhZSpwL05QGnnwpKrtJcGwjzkiQzH6uCs8/ba3swsKeJCS6Qdk4QPjqKoNNUOV+F
 SwflNYTMh0aCme/XW2dh33juoq6vSyN//4+N5nj+1lLkwgQAAAA==
X-Change-ID: 20260319-hold_memdev_lock_for_region_poison_inject-clear-4b8020d84662
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773929554; l=6216;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=56w20MZUIlAyE115A6+FVQV8oAXDOglnPckBdBxKr+I=;
 b=x/mJr2DSFR0HV1IYnOiJEf1uc899pgNyS77V8selcSsDP62dCdhcYwdE6sAEbAORce9ibZpCH
 2azwCkbOPdBDsREXEvTHGkqBd3BEpTj25AL27c6Xxf2Gg5nLd4HirYt
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228b269b2e051c438c6cbd7d0070000c481ce6234e6e5331527837bf18abdf91514c98ab01321ae8951:zu08011227efc9cd2edb00a2634e267d9c0000d259fc34736778a49d5d9fe8822dab3d0d4b85ff104873704f:rf0801122d0c2089fbe8d700521a092832000023daafa5d8580e33d6bae026040f8d0ee705397b280325e0d7f12c099184af:ZohoMail
X-ZohoMailClient: External

cxl_dpa_to_region() has expectations that cxlmd->endpoint remains valid
for the duration of the call. When userspace performs poison injection
or clearing on a region via debugfs, holding cxl_rwsem.region and
cxl_rwsem.dpa alone is insufficient, these locks do not prevent the
retrieved CXL memdev from being destroyed, nor do they protect against
concurrent driver detachment. Therefore, hold CXL memdev lock in the
debugfs callbacks to ensure the cxlmd->dev.driver remains stable for the
entire execution of the callback functions.

To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
for avoiding deadlock. the interfaces have to find out the correct CXL
memdev at first, holding lock in the sequence then checking if the DPA
data has been changed before holding locks.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 112 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f24b7e754727..1a509acc52a3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4101,12 +4101,70 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
 	return 0;
 }
 
+static int __cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
+				      struct dpa_result *res)
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
+	rc = __cxl_region_poison_lookup(cxlr, offset, res);
+	if (rc)
+		return rc;
+
+	/*
+	 * Hold the device reference in case
+	 * the device is destroyed after that.
+	 */
+	get_device(&res->cxlmd->dev);
+	return 0;
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
+	struct device *dev __free(put_device) = &res1.cxlmd->dev;
+	ACQUIRE(device_intr, devlock)(dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
@@ -4115,20 +4173,18 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
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
+	rc = __cxl_region_poison_lookup(cxlr, offset, &res2);
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
@@ -4136,10 +4192,20 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
 
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
+	struct device *dev __free(put_device) = &res1.cxlmd->dev;
+	ACQUIRE(device_intr, devlock)(dev);
+	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
+		return rc;
+
 	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
 	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
@@ -4148,20 +4214,18 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
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
+	rc = __cxl_region_poison_lookup(cxlr, offset, &res2);
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

---
base-commit: d5f9bfc37906bbb737790af11f1537593f8778a5
change-id: 20260319-hold_memdev_lock_for_region_poison_inject-clear-4b8020d84662

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

