Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0E206F04;
	Wed, 19 Mar 2025 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356701; cv=pass; b=X2VblToi2jMSw5zfRjdvH3Kgxb+IHMuW5Fb73bCFJB6GWghFIOs4SRIpqsqe465KT6NsJHuxXis5ok1Xc7sLAM/PFsg6NOiaivFMA2hwxY4L7k+CWm45uVf6GQqxqmFOPLannURo0oAGug+IRD8ij5jocwmJv3BzCuhcmMqjXHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356701; c=relaxed/simple;
	bh=2Ap7XP7ktez6DuU1/+ksqU+a3TYiiG6jnWT6zov5YH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dm4Zk1dsPLIR5K/G4AKqnZYQWUYpw8vV1b3YtJ3lfY/d3ISkPc1M5wvIsYDQGMUlsYut9yJ+FSIHI2flQptX/J5so3HnHS5zmN0+/zQZf+dAUNB6og/wrLplVLMmVsXj/KTMIkUGJynIDgS3xmMwazkIrZPbwIhun8zQcSIL3Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ad/ObXTE; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ad/ObXTE"
ARC-Seal: i=1; a=rsa-sha256; t=1742356680; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dMmr93QgnbDaDtbfqRgXk2PsEdjg+/En7sn4iky6tog8qrFeeT9xO9wUkr+/XW0Tftm2ijazJ43Pc1F5Etgc0fx6iIZE++JCg8vTsgd+feu6e63Vy9BDP/CzJNuDxg8SgoJKQkdnZawJz8ZLbDhv3P78LAGvnR33Ct6tihXxL4U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742356680; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H6WG9xcRw4zYhnVWREY+q7gEjRbmCtOj40WMa1Ay7G8=; 
	b=IyH/nTJC8bfmyfqSKnor740CAc/kjegx+WFAnX2r+OqaEf0QEN1/+UhdIjWk2fMXoOl3KxqUiI+Oe4+vsdsRdg2wNUMS8dlA+8dCU7Crj14Q7EKKXdx76dzFxE7X7hb4QkcCHZIGzz7lo+/A+Fsp1r4uvnVhFO9HzzY4O5rkdRY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742356680;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=H6WG9xcRw4zYhnVWREY+q7gEjRbmCtOj40WMa1Ay7G8=;
	b=ad/ObXTEuwA4qmagMlMhtic6lsd1u5qkQY+B8UxrH/7uVTRDB9TClQ///6j2930S
	F9GFmWJ1TrR9CcGLALqbQzyVwOszz3jNCdNyEyNqdHMUxJuF4RAd+Mj+lQK5208fPch
	x4FIEIhqYe7ipTKKyl0j47ncE3HszwIoXcKjqWp4=
Received: by mx.zohomail.com with SMTPS id 1742356677205569.6024035883355;
	Tue, 18 Mar 2025 20:57:57 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [RFC Patch v1 1/3] cxl/core: Fix caching dport GPF DVSEC issue
Date: Wed, 19 Mar 2025 11:55:14 +0800
Message-Id: <20250319035516.222054-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319035516.222054-1-ming.li@zohomail.com>
References: <20250319035516.222054-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227c398821006ad9d3998d1972100004d2ea4dfb7814767343b890b777e269e49625548c470d5b7e7:zu080112273defea981b23a767a6b5212200006bd52cc347ccf3fa0b6a8909fc12bb9d678b74b77d9600d8d9:rf0801122deaef31fbcdbf028250bc003d000008518a6c59404989e32852639ed4cee2e86e48efb815968e58e059d567c73b:ZohoMail
X-ZohoMailClient: External

Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, only
CXL Downstream switch ports and CXL root ports have GPF DVSEC for CXL
Port(DVSEC ID 04h).

CXL subsystem has a gpf_dvsec in struct cxl_port which is used to cache
the offset of a GPF DVSEC in PCIe configuration space. It will be
updated during the first EP attaching to the cxl_port, so the gpf_dvsec
can only cache the GPF DVSEC offset of the dport which the first EP is
under. Will not have chance to update it during other EPs attaching.
That means CXL subsystem will use the same GPF DVSEC offset for all
dports under the port, it will be a problem if the GPF DVSEC offset
cached in cxl_port is not the right offset for a dport.

Moving gpf_dvsec from struct cxl_port to struct cxl_dport, make every
cxl dport has their own GPF DVSEC offset caching, and each cxl dport
uses its own GPF DVSEC offset for GPF DVSEC accessing.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/core.h |  2 +-
 drivers/cxl/core/pci.c  | 16 ++++++++--------
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e35f6e08ddb5..a808a3529e8c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -117,7 +117,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
-int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
+int cxl_gpf_port_setup(struct cxl_dport *dport);
 int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
 					    int nid, resource_size_t *size);
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 96fecb799cbc..aab0a505d527 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1128,26 +1128,26 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 	return rc;
 }
 
-int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port)
+int cxl_gpf_port_setup(struct cxl_dport *dport)
 {
 	struct pci_dev *pdev;
 
-	if (!port)
+	if (!dport)
 		return -EINVAL;
 
-	if (!port->gpf_dvsec) {
+	if (!dport->gpf_dvsec) {
 		int dvsec;
 
-		dvsec = cxl_gpf_get_dvsec(dport_dev, true);
+		dvsec = cxl_gpf_get_dvsec(dport->dport_dev, true);
 		if (!dvsec)
 			return -EINVAL;
 
-		port->gpf_dvsec = dvsec;
+		dport->gpf_dvsec = dvsec;
 	}
 
-	pdev = to_pci_dev(dport_dev);
-	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 1);
-	update_gpf_port_dvsec(pdev, port->gpf_dvsec, 2);
+	pdev = to_pci_dev(dport->dport_dev);
+	update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 1);
+	update_gpf_port_dvsec(pdev, dport->gpf_dvsec, 2);
 
 	return 0;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fd6646c1a2e..726bd4a7de27 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1678,7 +1678,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			if (rc && rc != -EBUSY)
 				return rc;
 
-			cxl_gpf_port_setup(dport_dev, port);
+			cxl_gpf_port_setup(dport);
 
 			/* Any more ports to add between this one and the root? */
 			if (!dev_is_cxl_root_child(&port->dev))
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..2d81ccd83916 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -592,7 +592,6 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
- * @gpf_dvsec: Cached GPF port DVSEC
  */
 struct cxl_port {
 	struct device dev;
@@ -616,7 +615,6 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
-	int gpf_dvsec;
 };
 
 /**
@@ -664,6 +662,7 @@ struct cxl_rcrb_info {
  * @regs: Dport parsed register blocks
  * @coord: access coordinates (bandwidth and latency performance attributes)
  * @link_latency: calculated PCIe downstream latency
+ * @gpf_dvsec: Cached GPF port DVSEC
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -675,6 +674,7 @@ struct cxl_dport {
 	struct cxl_regs regs;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
+	int gpf_dvsec;
 };
 
 /**
-- 
2.34.1

