Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2888632B;
	Tue,  7 Jan 2025 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736222280; cv=pass; b=gGO4BC4i0oZwMn3reHeCf3dKUfAi7lmCBeipF+9TxEicZdjrZBvkGDTsTXz6zZWRqFEhLrsgCHo8u9TJ/c1cMRvaPI+iFdZtwerw+VNkAuRZ281BvdQP19ihIx+hnZkNKRyZC7S/fkvutAsgQTYlNiKWAjlWzEFcVxi5XEHYxTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736222280; c=relaxed/simple;
	bh=ZJ2npi9TOUOUlJvV1ovQxH+NzqKD2NmODV5k8lPVwLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdiRl2zoB94Yci7xMEYaR4JGJcdIbaBIxYB+kYKnuKYFtCspS3uepwbm0gZT0U0k4tX9bitJ4tLUHZaFJKUaJaMdNfZBA6ta5/alAU+MbN49fEvilruAaGPspIhJrdI6FM4eXthHLG+k9kfzAmqUkOZo3HMdH0hKeRPWq+cYEeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=C7KHlKTP; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="C7KHlKTP"
ARC-Seal: i=1; a=rsa-sha256; t=1736222257; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eBtDz4OOvfmx8bhkyUHe1XIEQZhEacWP+ZrrZ83ypDazUZdMkhpjVhb2AMAKbAULGFu8P/13f+pP72ohT5vtmqdJzvpopKhPA1/sgiSrN4PRBHZsH4FYgvyly1ItOOX5I26z4iYnlzMkB3MWhXuF7kbQ6z50quk3dHuVzkzP2dk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736222257; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=71Vfq/lr3HI1J1zvQTZQRh2XzJDy5bIV5/bnF/fmRUI=; 
	b=lQ+pQrPSiuFjkrJglJEvvFYaaXthXumZTmeWmW7x88KFyLqdthCuxgVu/Gvw+U1Dunc+Eof2+IQ3n7H4IOVUfRZPgeUKX//4M+m6FOeIV0WXmJcnCvc09GUQ0ff9h/1ZuxiX+vaOb9mdp6pNUNVPIDL7rPCAdogQSYF81VMN71M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736222257;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=71Vfq/lr3HI1J1zvQTZQRh2XzJDy5bIV5/bnF/fmRUI=;
	b=C7KHlKTPCfpfLekYLgpmJj7BcQP6YP+UdJxdzWTSubtTwU+XQEa1ZuJP9yhjj7sA
	cXrU/YIeNXo/zor2EmacIgRzR9cJeUSyeBroKAcSTQt4BlPdpn/oLbkeWSNKWjkMfxI
	/xZaANbkWZudQTHnj0y/iCQ2DqomlxVzms3NVick=
Received: by mx.zohomail.com with SMTPS id 1736222256697604.2342245130915;
	Mon, 6 Jan 2025 19:57:36 -0800 (PST)
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
Subject: [RFC PATCH 2/8] cxl/port: Delay port HDM setup until port component regs setup done
Date: Tue,  7 Jan 2025 11:57:02 +0800
Message-Id: <20250107035708.1134954-3-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107035708.1134954-1-ming.li@zohomail.com>
References: <20250107035708.1134954-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122721bf7b18384845fc227a7653000038dcea3b84bf001be3ee9689bc35dd43083f9e8465c96a9383:zu08011227af8fc1d34e5b4178c22d399e0000435e35c5b2af67e7dd3065942f9b4e2c38e93afbd25b8149a2:rf0801122d17b229b88663d808fed0c7470000d6ea91fa81cc05c594e745b3aae6a57a60b2c8a6e9fb226e0fd2d52f6156ee:ZohoMail
X-ZohoMailClient: External

Currently, devm_cxl_add_endpoint() is responsible for all CXL ports
component registers enumeration. so HDM setup for the port of host
bridge/switch also needs to be delayed until componeng registers setup
finished. So moving CXL host bridge/switch HDM setup implementation out
of cxl_switch_port_probe(), and let devm_cxl_add_endpoint() help to
setup HDM on such ports.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/port.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ae09bbbe0a17..c59f198f6cb0 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -59,7 +59,6 @@ static int discover_region(struct device *dev, void *root)
 
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
-	struct cxl_hdm *cxlhdm;
 	int rc;
 
 	/* Cache the data early to ensure is_visible() works */
@@ -71,6 +70,18 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 	cxl_switch_parse_cdat(port);
 
+	return 0;
+}
+
+static int cxl_switch_port_setup_hdm(struct cxl_port *port)
+{
+	struct cxl_hdm *cxlhdm;
+	int rc;
+
+	/* Skip hdm setup if there is a cxlhdm on the port */
+	if (dev_get_drvdata(&port->dev))
+		return 0;
+
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
@@ -89,6 +100,17 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return -ENXIO;
 }
 
+static int cxl_switch_port_setup(struct cxl_port *port)
+{
+	int rc;
+
+	rc = cxl_port_setup_regs(port);
+	if (rc)
+		return rc;
+
+	return cxl_switch_port_setup_hdm(port);
+}
+
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
 	struct cxl_port *iter, *parent_port = to_cxl_port(port->dev.parent);
@@ -109,9 +131,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		 */
 		if (iter != parent_port) {
 			guard(device)(&iter->dev);
-			rc = cxl_port_setup_regs(iter);
+			rc = cxl_switch_port_setup(iter);
 		} else {
-			rc = cxl_port_setup_regs(iter);
+			rc = cxl_switch_port_setup(iter);
 		}
 		if (rc)
 			return rc;
-- 
2.34.1

