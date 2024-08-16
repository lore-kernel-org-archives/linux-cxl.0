Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553941C7B7F;
	Fri, 16 Aug 2024 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817333; cv=none; b=t4zWjK8SLpZNYMwDZNGSbw3yjwzSG52GvFEs4udk85qb6vTF/OxN8rJOicqM/0ftyr4jlTRC5E7EVUbBmGlTgARl4wM/5RotH6bR4+hTMQY+l3DPIEtChkLh3FPz9fRCM3GuAZbzv4EIOaULLgud2sT+VLLOPc4QuRvCf56EDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817333; c=relaxed/simple;
	bh=18K1X6hkpyxWWugHftsiPLTtiWyO1FKFLEPU84k6jk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bz1hcmLSn6UWVorVuPpwsLtMeptBHj0hRLL8clyKmfiKswMK8NB9PCBPda6IBaUrOjlNoj8E7RPq/VZmDP08YrqJoe0gtvlFHQben5Q0lr16rlU2Lm/m1qMs9blcIRNTx2kqESsIc4T3iqdCWPgnbgbbC+bAGNXt1Ik+jOaYndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F71zT2Qz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F71zT2Qz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817332; x=1755353332;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=18K1X6hkpyxWWugHftsiPLTtiWyO1FKFLEPU84k6jk8=;
  b=F71zT2QzRlrccXTPEfG2lScPyJ2Q0pZqfhC7zujLGabZOKzDr9UchFzM
   /2fJzbvo72GyerfILkJIMNaUQvafuTbjThHqySmtlGbww2jxjW7ssJCTL
   vU5xLurVHkkL+z0xmsYdAyH+qNNJejaKIKruEKRESFJubVmG+Zz302mOM
   ujKRrOHK5y/7Q5gO5zWYryw09mm4N4GKlzX+fysgRRiC0zrWDe8i3TIlO
   UkZma8m/OT2mxJIxps8EGW249i+BgQhyWe7EaaXOl7rxfVXK56LheLDhY
   Yl4JTM/X3rnaNJUh6562yUuCQyKDw6lHnPxJRPswId+czZI3UasmQbvq3
   A==;
X-CSE-ConnectionGUID: L5/gFeDAQ62HAvg5ReH03A==
X-CSE-MsgGUID: zADiQVYfQKSwoixV9uKXNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22085331"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22085331"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:52 -0700
X-CSE-ConnectionGUID: hvMeK9GsR9atL7/MfElkRA==
X-CSE-MsgGUID: HSXWDMB/SoWj0yvzCqPePQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64571678"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:49 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:23 -0500
Subject: [PATCH RESEND v2 18/18] tools/testing/cxl: Add Dynamic Capacity
 events
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-18-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=3592;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=18K1X6hkpyxWWugHftsiPLTtiWyO1FKFLEPU84k6jk8=;
 b=I7T8LRUkZz9eSXvjIReM42nnl34Lpi7JddyThzZA/fKRnXnENig+usrRa790RoOlMk3FkMyQI
 AwVFXc5vGbIBXKOnPuakmfeBkKtXunYH3BgW6l3PlwfQqaxU4GXTQWB
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

OS software needs to be alerted when new extents arrive on a Dynamic
Capacity Device (DCD).  On test DCDs extents are added through sysfs.

Add events on DCD extent injection.  Directly call the event irq
callback to simulate irqs to process the test extents.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d6041a2145c5..20364fee9df9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -2008,6 +2008,41 @@ static bool new_extent_valid(struct device *dev, size_t new_start,
 	return false;
 }
 
+struct dcd_event_dyn_cap dcd_event_rec_template = {
+	.hdr = {
+		.id = UUID_INIT(0xca95afa7, 0xf183, 0x4018,
+				0x8c, 0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+		.length = sizeof(struct dcd_event_dyn_cap),
+	},
+};
+
+static int send_dc_event(struct mock_event_store *mes, enum dc_event type,
+			 u64 start, u64 length, const char *tag_str)
+{
+	struct device *dev = mes->mds->cxlds.dev;
+	struct dcd_event_dyn_cap *dcd_event_rec;
+
+	dcd_event_rec = devm_kzalloc(dev, sizeof(*dcd_event_rec), GFP_KERNEL);
+	if (!dcd_event_rec)
+		return -ENOMEM;
+
+	memcpy(dcd_event_rec, &dcd_event_rec_template, sizeof(*dcd_event_rec));
+	dcd_event_rec->data.event_type = type;
+	dcd_event_rec->data.extent.start_dpa = cpu_to_le64(start);
+	dcd_event_rec->data.extent.length = cpu_to_le64(length);
+	memcpy(dcd_event_rec->data.extent.tag, tag_str,
+	       min(sizeof(dcd_event_rec->data.extent.tag),
+		   strlen(tag_str)));
+
+	mes_add_event(mes, CXL_EVENT_TYPE_DCD,
+		      (struct cxl_event_record_raw *)dcd_event_rec);
+
+	/* Fake the irq */
+	cxl_mem_get_event_records(mes->mds, CXLDEV_EVENT_STATUS_DCD);
+
+	return 0;
+}
+
 /*
  * Format <start>:<length>:<tag>
  *
@@ -2021,6 +2056,7 @@ static ssize_t dc_inject_extent_store(struct device *dev,
 				      const char *buf, size_t count)
 {
 	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
 	unsigned long long start, length;
 	char *len_str, *tag_str;
 	size_t buf_len = count;
@@ -2063,6 +2099,13 @@ static ssize_t dc_inject_extent_store(struct device *dev,
 	if (rc)
 		return rc;
 
+	rc = send_dc_event(&mdata->mes, DCD_ADD_CAPACITY, start, length,
+			   tag_str);
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 static DEVICE_ATTR_WO(dc_inject_extent);
@@ -2071,6 +2114,7 @@ static ssize_t dc_del_extent_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
 	unsigned long long start;
 	int rc;
 
@@ -2083,6 +2127,12 @@ static ssize_t dc_del_extent_store(struct device *dev,
 	if (rc)
 		return rc;
 
+	rc = send_dc_event(&mdata->mes, DCD_RELEASE_CAPACITY, start, 0, "");
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 static DEVICE_ATTR_WO(dc_del_extent);
@@ -2111,6 +2161,13 @@ static ssize_t dc_force_del_extent_store(struct device *dev,
 	if (rc)
 		return rc;
 
+	rc = send_dc_event(&mdata->mes, DCD_FORCED_CAPACITY_RELEASE,
+			      start, 0, "");
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 static DEVICE_ATTR_WO(dc_force_del_extent);

-- 
2.45.2

