Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB97C23C8AA;
	Wed,  1 Oct 2025 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759298660; cv=pass; b=bKebeOuCM2KgL4zoVo7HIy0yzLwEXTNfahQC1xwh39Y3mIWHYPgVdS3m3sytZF3KQmm4YCMDSfizGyjkx8qK93JPpVWHajjHKS/PWUv8zK7sTnJE24zvr2YGCS42aK/tWpxbfw4PA9uEgNohDh0inF+kY//LAUuxcThNCRotmcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759298660; c=relaxed/simple;
	bh=SGJ7F7f+BSgPcdMjTeUtiZj9dNe/Bu7K1pwrqKqmi5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t8XZSK8I5n4UIubyVqBuVBKbiMAkZMNnmLMxZgZu2ybPqpbt4fr2THXV/ASfvzKcna0PmrlEFSGk+kcW3LWBESd5v0IvcmDSfXT2DJifAnLmu5Bb3PK4RQnq5kRlvyDqGEHZSV2BsBUNFqsgw/nJzV1+lp5LphSkTBomz5g7vDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=cN/94/8G; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="cN/94/8G"
ARC-Seal: i=1; a=rsa-sha256; t=1759298641; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EDFEQhRp5WHix1Smy2ciXXj8vM9O7D4/SdXkhSzlxmZaQ8b6zoQf4SILsCtxvJeRacdAqUSdzhImMQ5Q+S/OsZlUg+Q8/SwBYiu/CGu2DHf2sFjE18e8j3hbSXr4lB4NAmB8MjYtxjWu8kdgxsD8WV+ps3622W61u6BQJQi53/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759298641; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QB/yhut3QVT8pqvoLVYMTyBpZhMcos5NCHWzyAFrkQE=; 
	b=n3xDCMuPG4HI5hsaCy8Y7N9PFWTbsk8NqNCvzjFo2A4u5tfEkRMl+tjH+To/8+UTMed32uMjrp6eX2eXwBAUiJToYdfpIWFP3agY2DveOqXa6yKsXqAgQswzXiJRgxJMdS/qB2FZMvsGNm8KwW95CQrgp7YZtA8UAaCFStmpOk4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759298641;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=QB/yhut3QVT8pqvoLVYMTyBpZhMcos5NCHWzyAFrkQE=;
	b=cN/94/8G6TKQegYodm8YymZKzFaeVHU71Np1kxylsyn2BqGG4zXB4qtq/ad1xvn6
	z1ESr7kNsxRR56uAvd2oDQfbudGU/PcEhw5/JyinVCrKiOu35DPfCqhv9/f1glAAf1a
	I87AkFBqiEIoGbDOQLYVJWdFSfPRcrP6kIhwByX4=
Received: by mx.zohomail.com with SMTPS id 1759298640059998.7891591675034;
	Tue, 30 Sep 2025 23:04:00 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v3 1/1] cxl/port: Avoid missing port component registers setup
Date: Wed,  1 Oct 2025 14:03:37 +0800
Message-Id: <20251001060337.431639-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270f03e9fa526107d7f29c96340000121ea283752c0e86ac80962e2a5e455b3b9209b024ed4c16a1:zu0801122716c4fdacd7ca08e715a4fa1800006ac98176b65f2107132009134120a9ccec6988953a28e9ba50:rf0801122dba65126e536d26798d6b6a7e00009a1a09397bb8d296d201aa06820ed2985fc34c254c83d75f09a337454096d1:ZohoMail
X-ZohoMailClient: External

port->nr_dports is used to represent how many dports added to the cxl
port, it will increase in add_dport() when a new dport is being added to
the cxl port, but it will not be reduced when a dport is removed from
the cxl port.

Currently, when the first dport is added to a cxl port, it will trigger
component registers setup on the cxl port, the implementation is using
port->nr_dports to confirm if the dport is the first dport.

A corner case here is that adding dport could fail after port->nr_dports
updating and before checking port->nr_dports for component registers
setup. If the failure happens during the first dport attaching, it will
cause that CXL subsystem has not chance to execute component registers
setup for the cxl port. the failure flow like below:

port->nr_dports = 0
dport 1 adding to the port:
	add_dport()	# port->nr_dports: 1
	failed on devm_add_action_or_reset() or sysfs_create_link()
	return error	# port->nr_dports: 1
dport 2 adding to the port:
	add_dport()	# port->nr_dports: 2
	no failure
	skip component registers setup because of port->nr_dports is 2

The solution here is that moving component registers setup closer to
add_dport(), so if add_dport() is executed correctly for the first
dport, component registers setup on the port will be executed
immediately after that.

Fixes: f6ee24913de2 ("cxl: Move port register setup to when first dport appear")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
v3:
- add fix tag
- add review tags

v2:
- remove dport from port->dports in case of component registers setup
  failed.

base-commit: 46037455cbb748c5e85071c95f2244e81986eb58 cxl/next
---
 drivers/cxl/core/port.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d5f71eb1ade8..8128fd2b5b31 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1182,6 +1182,20 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	/*
+	 * Setup port register if this is the first dport showed up. Having
+	 * a dport also means that there is at least 1 active link.
+	 */
+	if (port->nr_dports == 1 &&
+	    port->component_reg_phys != CXL_RESOURCE_NONE) {
+		rc = cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc) {
+			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
+			return ERR_PTR(rc);
+		}
+		port->component_reg_phys = CXL_RESOURCE_NONE;
+	}
+
 	get_device(dport_dev);
 	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
 	if (rc)
@@ -1200,18 +1214,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
 	cxl_debugfs_create_dport_dir(dport);
 
-	/*
-	 * Setup port register if this is the first dport showed up. Having
-	 * a dport also means that there is at least 1 active link.
-	 */
-	if (port->nr_dports == 1 &&
-	    port->component_reg_phys != CXL_RESOURCE_NONE) {
-		rc = cxl_port_setup_regs(port, port->component_reg_phys);
-		if (rc)
-			return ERR_PTR(rc);
-		port->component_reg_phys = CXL_RESOURCE_NONE;
-	}
-
 	return dport;
 }
 
-- 
2.34.1

