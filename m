Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC58286D6B;
	Sun, 28 Sep 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054511; cv=pass; b=Ddpi4yvHjThr//+iSTVE2zBWOD3R4foNDNpvk6pM8LUYXyQJrglQ3IkhtQCc7SNghCBerA+r478UpEAPLjmv/gBwIO6RjgK2rw/aF6HjrRLZ3fUolvxsL4qnvu7pSuYqQtj4Gvme0d0DIQVjVcY5g8m1+iFScTX706NRD/GXx9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054511; c=relaxed/simple;
	bh=GkECR7fUG6hmU1Ej06Z9oM7ZqRjezSc2DJE1BWnhOlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+5mMoYd5DqondYHUmpAfHWQKd+26zOXyisJl6IjFL9B8Lfvr6+WSEKS0cWBJaIWGFz20k3KvYGulKKqTTGkxLlffhCJkdjwJn7ibGpK7I4MZ5jy4s4VZAzbGDwIzTmMxTPbkRC/NFkiVH4Rl9FkNwjtEh1gXCpASXEQ9Cu8vsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TF5ksk7z; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TF5ksk7z"
ARC-Seal: i=1; a=rsa-sha256; t=1759054495; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G9Mhl/X01Rzum3sUsRFXZXN0I6vJZknn1vktWJ1gVPI5NS90+V2uemSEEU7Su0Wp6XZcianie0Yb2xKWm4jEX1O58EG98sIL+Nd8mY6B2qU7PnBlmHuCPzHSCZ7t7u4xy+iRs91cU/RUcwgtSAA8Ts9TuECVBJ/Ap1xXyN1QYzo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759054495; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jkva9SjXpOT3+FQguGv97Znb5NVX/F/3HNDCRkfOEQE=; 
	b=L7BaZ/MNKuX0NXp6gaqr7k6aTa1ic3x/+2II1EdAnDQnnXfZL3abm1Jv4PFw3g1xeYPcmyFsbrrRGSbUGaPHFX4bU1U7ZxWLXDbbpl6ILgW51rpiJAUo3uOKUSqcMxvKma5YO8Tf8YdyhoWxFq/8v7CAGXsgRVXZkJ9Jc5aXJlk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759054495;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=jkva9SjXpOT3+FQguGv97Znb5NVX/F/3HNDCRkfOEQE=;
	b=TF5ksk7zDPnnXXfiGB1WBmmfkocrafKfn8piVZ3OQXliIArR6oCaQOlce7lNC6n0
	HZMSRFPd0l4BHbVTDTU+G4u2Yj+vE7OjcUr6XAONBNRu/CBE3A9Ty5YaOl7HdCoiXNX
	ONLc+kWj4PdxJdxmz4OEFcCNeE8OJ2U2RPtWRPdU=
Received: by mx.zohomail.com with SMTPS id 1759054494207283.78612729170607;
	Sun, 28 Sep 2025 03:14:54 -0700 (PDT)
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
Subject: [PATCH v2 1/1] cxl/port: Avoid missing port component registers setup
Date: Sun, 28 Sep 2025 18:14:33 +0800
Message-Id: <20250928101433.424778-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cf04a5705abc7b016dbfbb1b0000b93afb6da2cbb1a974038ff3e59f4df99b4bb604dfed74ef18:zu08011227e4476c90d80e97504c6f16240000015cf08b9d42de84800e3d6b98a61308a8bf08325f7796b72a:rf0801122dd0e457bde1a0da80244d626b0000da008d6bb7eceee86f015ed6b2687001c6661bfa44a3336eaa85683a43d77a:ZohoMail
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

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
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

