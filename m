Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38E220F49;
	Sun, 29 Mar 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795563; cv=pass; b=nAM5FvIzAgbEKsns6Fi6vR6vv4PyMbkj4eZ4dLOfysuAoSHM4FD0z2R+6jVvtnGc+vd3BYVsYpoKvMCGGxycy4IMzyG7HUYWC4FtPqRmiXx+in5iZRx7VyPTUWWZ1F1QSCQMK4rPlkRohMnd30Bpyo9K+tqpIUeiZm2OE1SmbJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795563; c=relaxed/simple;
	bh=73lD8/guUfYYXtOt0kTn1HAAGN6lITHMHtOZQmxtdqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GVhADYyovA8yvGfH6LdY3uJAA7QJWBwQ7cJH8EVE7JSQtLXt/vsTXYwC9IpU8BIAgFmhuTcwAJf0Ao+WwLBxJHLzCsYd8B2gIoUUFO9C/xX8yRJhvCFAeHBTLEqj55hEce0t6qGm400WkAB79HGRIoOxkCKfd+8hQrG7t1xOlaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UqIAkAsS; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UqIAkAsS"
ARC-Seal: i=1; a=rsa-sha256; t=1774795544; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=evRlmWLe7RF/uj7dPcpphe1NRIFH+OlKiM0ozG5M9TkpjDagqCOY78au8NoofuQPE/6bNzsWhfwYz1sOOoXpVDCmkWTfjSEQnPc3wRp2pJAB+MG5HPUiwJSzHSzRIYCQGhreTTPFInA5AztWVBONasknSKiOnLQ3FN0o3vS58Qw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774795544; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gvvhwRt/JBOmTCxIA1J9ruEzTTXxUrgTq/BuJq/a0Es=; 
	b=PAaSeDrqunEFG+dTcqUTV+GdIzil3fzLtHoddzyoI3C+BnZKQ155kwmKPRL4cn/sa+CZ/FO+tulz2oJVwarYdV1PfmCy5z2ZAglNOf+F5G6tTd0c72eU3yiHaBAmRRB0j2btlWrrihoAU1WsNMS2K/BgXIrUtfHMSL1mvIU745w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774795544;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=gvvhwRt/JBOmTCxIA1J9ruEzTTXxUrgTq/BuJq/a0Es=;
	b=UqIAkAsSArJMhBCasBtpgPCkww7u/vRYrdG0/xuL9wvSs0fOyv8lO6iHVdyUTWfH
	HhAHy8sLzG98Q2ZR6G1URSPRxSa7NinkOIBLD5cgLcjNJovltjfV0QKjmglJ+8XExoR
	2VnRil9CNnBTuQdwHG/AkK7e+R0TKQa63Wf8RCSc=
Received: by mx.zohomail.com with SMTPS id 1774795541319976.628063130256;
	Sun, 29 Mar 2026 07:45:41 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sun, 29 Mar 2026 22:44:17 +0800
Subject: [PATCH] cxl/region: Add a region sysfs interface for region lock
 status
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-expose_region_locked_status-v1-1-cd860feaff6e@zohomail.com>
X-B4-Tracking: v=1; b=H4sIAMA6yWkC/x3MUQqDMBBF0a3IfBtIU7XVrUgJmjzt0GIkoyKIe
 zf4eeByDxJEhlCTHRSxsXCYEh55Ru7bTSMU+2Qy2lT6aWqFfQ4CGzGm0v6D+8FbWbplFdXr0hX
 9e6hfvqJ0mCMG3u97+znPC0yADfVtAAAA
X-Change-ID: 20260329-expose_region_locked_status-b05c4b8f97d6
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774795478; l=2660;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=73lD8/guUfYYXtOt0kTn1HAAGN6lITHMHtOZQmxtdqQ=;
 b=EBI8zOD818IorWzIKnx2qEr948FEziOtI+Ad2pjrnWB/hWenQzUQPzVzOs3bkupsK/DJFeKLD
 4MYP0LDOUOzDOd0SEYMxVNaTQ+d5b9EmDJm0+U7YdOtgAWcg1oQGWXW
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228b7516a99d94596250461e70a000095abe5c9ee6e2d6127384ee9e46efe4003d7494f2046380a82df:zu0801122781b06d2b68d04f7a1c73b859000011e60073952e335dcadc5382bb7618905ad5ebbf130446e52d:rf0801122d0cb664ed1a2041be1dadb4b00000a958b888107924d2df0e05ff66e2e113a81ec43cf2567a6c9aef01bd3e6bb8:ZohoMail
X-ZohoMailClient: External

If a region is created on a root decoder with Fixed Device Confiuration
attribute, the region will be locked , meaning region destroy
operations are not permitted. CXL region driver returns -EPERM for
region destroy operations.

Although the locked status of the corresponding root decoder implies the
region is also locked, exposing the region lock status directly to
userspace improves usability for users who may not be aware of this
relationship.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++++
 drivers/cxl/core/region.c               | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index c80a1b5a03db..50bf7334465b 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -508,6 +508,16 @@ Description:
 		(RO) The size of extended linear cache, if there is an extended
 		linear cache. Otherwise the attribute will not be visible.
 
+
+What:		/sys/bus/cxl/devices/regionZ/locked
+Date:		Mar, 2026
+KernelVersion:	v7.1
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The lock status of the region, region destroy operations
+		are not permitted if the region is locked.
+
+
 What:		/sys/bus/cxl/devices/regionZ/mode
 Date:		January, 2023
 KernelVersion:	v6.3
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 42874948b589..95d81816008e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -767,6 +767,22 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(extended_linear_cache_size);
 
+static ssize_t locked_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc;
+
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return rc;
+
+	rc = test_bit(CXL_REGION_F_LOCK, &cxlr->flags);
+	return sysfs_emit(buf, "%d\n", rc);
+}
+static DEVICE_ATTR_RO(locked);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -776,6 +792,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_extended_linear_cache_size.attr,
+	&dev_attr_locked.attr,
 	NULL,
 };
 

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260329-expose_region_locked_status-b05c4b8f97d6

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

