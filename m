Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E59319877;
	Tue, 10 Feb 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724200; cv=pass; b=CbcFuW+FZaknDsF2DpdpckhXS2THbneVkLl5QlL/u4IEgbcPWWPc09AhMygypOttxdyD1QlbcsjbXa6kfXB8bWDT+5Ct2lzvnozuVAiQMO+bpveNZHslzFdrLHoWX6XTDlIHBkcvH+k97ltKuZSS+8khDfQzW2WEFYEyg2tWyqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724200; c=relaxed/simple;
	bh=2BSn1JChjMXd3ALXSdZJzoHgD3CSG/e1qyGV2a3Mj3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGEhOMcDVmQE6cnuc5NQepSip99TsG5QZCHogPeZuRAve2myK/Sh95kw4Z7VAMlyN9FUYXKJZy1TkCmOGg2yr7mbxHeQVZlKKWdsRPtfeVgwHApGbH7ESbiUkhOvLLdGKapWx6/tKvH+5y0/aYBYLTDOIxYv81G9TqWmC7ccsSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Xc/X5wZq; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Xc/X5wZq"
ARC-Seal: i=1; a=rsa-sha256; t=1770724063; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LgsaJgzmxAArEVN0BHAJVb4QLAvEWTpvKaYtn4znmCvcyuk4VX5rfYRFYzMAGEcUn3/BPTkfMn3O3xSK2jiPFPk8ygRf7OFr5OA2FTbWro+qdnHwIHzh+d1NxpuGascCFawbmgAXqyC7u032GTb0AgFwtFFcfGUnX6/6Oao0ymw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770724063; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rKLVpOH4qWtdhXrEWiIGQPOq6XakgqV4AKkcQISb48Y=; 
	b=VkDnLXIIDhhxiH7+LgS3v6PXCfkqngUKJoDks47r9v/DFulBO1vRvoPe8HsvbTuD0/zX5Pbim5fO+aOMAaISTdy7eSWiAUN6NHC4/wP0JIff/GTfFHJigWynWKTZV+UbS+ej5g0B7hFlswrL5WHxsKB0OebCJWDeSj+4ZuzhX9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770724063;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=rKLVpOH4qWtdhXrEWiIGQPOq6XakgqV4AKkcQISb48Y=;
	b=Xc/X5wZqgLxjRit42ntdV6KlSbcOc1tiNoBBFeJ+2C0RSyfKTrf34hiWJowt0O6v
	03qnBMdYe+3KnJKvfTmyzvbntmKsJoaD5jFXHWUGNaKprJ/oaCDp8g8ftnyfkWVmQkt
	b41rEeYZDoXiGfSrzhsB0NRjjHFjEEPUt2Ung6Lw=
Received: by mx.zohomail.com with SMTPS id 1770724061435744.5603740836011;
	Tue, 10 Feb 2026 03:47:41 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 10 Feb 2026 19:46:56 +0800
Subject: [PATCH v3 1/3] cxl/port: Introduce port_to_host() helper
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-fix-port-enumeration-failure-v3-1-06acce0b9ead@zohomail.com>
References: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
In-Reply-To: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770724039; l=1543;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=2BSn1JChjMXd3ALXSdZJzoHgD3CSG/e1qyGV2a3Mj3s=;
 b=q0aCmNdh6uGPBvH4AcR8wvth1sIOJvtPLA48phFQ8zgtv9yfLGa+DdONMCSJIsHHwXjklRjDi
 Wu5/64nW6tLCY1k56Fi0+MJezndBxV/ymh0DgWmXsxUw1f0R618lvOJ
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr080112280f3a426764f497992f6fec750000eb73f3c869bcf51434c96f4c1ff419e0559ad4edc3d2e1b21c0d:zu08011227046f282e5fcef7863ff5bad3000058d957063f49c19cb7ff41b0174d2d748f51777d06e770fbbf:rf0801122d771ee78e8f832aa2356220b000007c65841ec7fe5b92f42d47b94bde76dbccc117cebfafc8249a3aa87fc06e82:ZohoMail
X-ZohoMailClient: External

In CXL subsystem, a port has its own host device for the port creation
and removal. The host of CXL root and all the first level ports is the
platform firmware device, the host of other ports is their parent port's
device. Create this new helper to much easier to get the host of a cxl
port.

A dport_to_host() helper has been introduced, use port_to_host() as the
name to align with this naming convention.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/core.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 007b8aff0238..5b0570df0fd9 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -152,6 +152,24 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+static inline struct device *port_to_host(struct cxl_port *port)
+{
+	struct cxl_port *parent = is_cxl_root(port) ? NULL :
+				  to_cxl_port(port->dev.parent);
+
+	/*
+	 * The host of CXL root port and the first level of ports is
+	 * the platform firmware device, the host of all other ports
+	 * is their parent port.
+	 */
+	if (!parent)
+		return port->uport_dev;
+	else if (is_cxl_root(parent))
+		return parent->uport_dev;
+	else
+		return &parent->dev;
+}
+
 static inline struct device *dport_to_host(struct cxl_dport *dport)
 {
 	struct cxl_port *port = dport->port;

-- 
2.43.0

