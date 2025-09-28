Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C98192B90;
	Sun, 28 Sep 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759048051; cv=pass; b=O3D9jXoA4yaO3/PRHBqLElmSU+3E0s9GgpUzR7CNwO3WE2qY7Vfk66IExkLMQTIaWzLacB6Tm3ldQXxcJLDZt6u48ceaJew785W7cDWlJKa/QYEA4QeTX8g+JVSNXn43JS4va7Ven8HwBw7gLg6D/aYOLp6XLewqquF9fmEAUMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759048051; c=relaxed/simple;
	bh=BY3MaZq6jjs6ZCm53ibX+TPc0KsKC0+Jtsqvmq6eCs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ks2/rg88lOrkwoqIwhe9tOFcuU/JaYliTyhoD890wINtMjryUXNz3Y4y1Z3gI6F9AhOjWMvbqMq3wXRMJm4oC59c0M38vVs3ZlvbyeOQJ1mK8UrI4jXEy0yaXHsCo4yDFci9rddbvCBfNBfHqun0F4nOBOkIIkpHYZ6qVyhGhi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=aJ6bT9kY; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="aJ6bT9kY"
ARC-Seal: i=1; a=rsa-sha256; t=1759048038; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fmbG56g0bP2pjP4ZItOMq+kfQOMEuJxGDTuhiVhRVxQA/H5hFDJku3Op+NQ6mUA4M6NtOaaSYABquJ6ZJf+eSw27m39oJLDXASJKKUVXcZ8Yfz8l0fB6Qhd40vvXitTRfDca9m2nmmQ/5uTMMJXu9MjPLX36kUss1pIhhlqO19Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759048038; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0se3mk6dns8vnGKOUjB0E8DCWoF8sHHi4vPc2T0MRzA=; 
	b=ET8LjjBNE+3a5XJx3mS3N63LmBJC4Im6guVa3hzuoUBiAX6wO3wQQVale9WFloYQ7KNgIcty4+hxodnZo0Gri1frDy4Pp8Y1ebduBbmhM7rMfwm1cLwzVfeCqeFupCcd0m1RK22x2Q7jLBqJrox35VDHGIC+WfBuII0snxpqCdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759048038;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=0se3mk6dns8vnGKOUjB0E8DCWoF8sHHi4vPc2T0MRzA=;
	b=aJ6bT9kYK9Ga6EY5b9CL1Lu3uXGfvCKp15OOlqF8KH7uJMuexC4Wwx3jjXDI5UjI
	PsY0PFP3mesiG0eZNarO/VV+nTHg4bu4+jmLaE5BM8iSps2Un0UGXCjXbFPatkI5jNR
	TfyWS9Fo73Z1aZj7zRtzelcKoRtZW1VremxT/m/c=
Received: by mx.zohomail.com with SMTPS id 1759048036865829.4631101955218;
	Sun, 28 Sep 2025 01:27:16 -0700 (PDT)
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
Subject: [PATCH 1/1] cxl/port: Avoid missing port component registers setup
Date: Sun, 28 Sep 2025 16:27:03 +0800
Message-Id: <20250928082703.377604-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122769a6103cc02dc5adc320306e0000a511a6b2ac14bde620e895d6efa8d6055e44586069d6cbbe38:zu080112274680d10ce4f7e964c6c7e30a00000112c4dde273fa05bcdbea61f072fa462a4b1da0ac87242bda:rf0801122dd41a5b0702e54ff9217fb4d20000958148868da14df2fa53f22583fa3de1197883664eb9d998c7450d39da8277:ZohoMail
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
	no chance for component registers setup execution
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
base-commit: 46037455cbb748c5e85071c95f2244e81986eb58 cxl/next
---
 drivers/cxl/core/port.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d5f71eb1ade8..e25f326acd7a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1182,6 +1182,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	/*
+	 * Setup port register if this is the first dport showed up. Having
+	 * a dport also means that there is at least 1 active link.
+	 */
+	if (port->nr_dports == 1 &&
+	    port->component_reg_phys != CXL_RESOURCE_NONE) {
+		rc = cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc)
+			return ERR_PTR(rc);
+		port->component_reg_phys = CXL_RESOURCE_NONE;
+	}
+
 	get_device(dport_dev);
 	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
 	if (rc)
@@ -1200,18 +1212,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 
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

