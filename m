Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498301FAC5A;
	Tue, 14 Jan 2025 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889927; cv=none; b=LeDAZApQAF4ZBLIut4MwPK+kROUF0NwysAbMvTIsoA9lwm4JldkTsABUCOkpDzNASoGvB6DRQesgnzjHvDe60AdEQ2YfhibFh3raiDiRBtXtzQ1x4YlqYJPo1CrKIBFC9sMnY8dFTsF9otMcTGQI03eYB1xC+8JNnR5l65cslnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889927; c=relaxed/simple;
	bh=sL76TjBGKuyOoQde4k5U/aSoxWecY1BgMAvDh/l9e18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I8nDU70/JmoG8PZWPGV8hFvFbExjYRxiRBYqojvBlOUgUPdHVCK/LRNTy9G40l+BvC9gjyDqAfoSXLzMxV6OiNhhXq4s2ZsdccneG1i9oBkAEp9nlauME/LZ7/27k14xGiMgdvN1QOTQqVrTJmC3tEA0g3AkjcmSLE/g+I59ZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IWqepRmb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IWqepRmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1736889918;
	bh=sL76TjBGKuyOoQde4k5U/aSoxWecY1BgMAvDh/l9e18=;
	h=From:Date:Subject:To:Cc:From;
	b=IWqepRmbgt9r4iEDZJH80Wk1r/dNTfJi0SG4nsMf5aBy7Twh0KdFJrqomsb0hhLbG
	 e01ArFMwDUzYCEembvBCV9s6hzacWFRa9PYhWccWLjQHcGhH1x7kEUbnrcxO7wZcJs
	 txexTBy9/U83W5KqHVW6i1ZmlTI4z4eVdvoJDE9c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jan 2025 22:25:14 +0100
Subject: [PATCH] cxl/port: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADnWhmcC/x3MSwqAMAwA0atI1gba4g+vIiK1Rg1IlaaIIt7d4
 vItZh4QCkwCbfZAoJOFd5+g8wzcav1CyFMyGGVKpXWBcsss6HYvEUf2g40xoLs2nLQyZMeiLps
 KUn4Emvn6113/vh8Js5RnagAAAA==
X-Change-ID: 20250114-sysfs-const-bin_attr-cxl-d102eab47586
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736889917; l=1931;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sL76TjBGKuyOoQde4k5U/aSoxWecY1BgMAvDh/l9e18=;
 b=tG5OpJo2V6kxQzXNvwJRqU4b8gz/iZmKlRFWKxIzQPu8ZyWNXuNnl4ZCwVoiySPnH9FLHGr18
 B4aKjAOMh+xDlCLZScLlNL/LAfQMRDmJc9CcObpUhhPbyy6g134++ZW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/cxl/port.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4c83f6a22e584f1f248807c7fa4fe932d6f11d67..664fde6ff53862c6aef2a83be56c1518b6bfbadd 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -153,7 +153,7 @@ static int cxl_port_probe(struct device *dev)
 }
 
 static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *bin_attr, char *buf,
+			 const struct bin_attribute *bin_attr, char *buf,
 			 loff_t offset, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -170,7 +170,7 @@ static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
 				       port->cdat.length);
 }
 
-static BIN_ATTR_ADMIN_RO(CDAT, 0);
+static const BIN_ATTR_ADMIN_RO(CDAT, 0);
 
 static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
 					    const struct bin_attribute *attr, int i)
@@ -184,13 +184,13 @@ static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-static struct bin_attribute *cxl_cdat_bin_attributes[] = {
+static const struct bin_attribute *const cxl_cdat_bin_attributes[] = {
 	&bin_attr_CDAT,
 	NULL,
 };
 
-static struct attribute_group cxl_cdat_attribute_group = {
-	.bin_attrs = cxl_cdat_bin_attributes,
+static const struct attribute_group cxl_cdat_attribute_group = {
+	.bin_attrs_new = cxl_cdat_bin_attributes,
 	.is_bin_visible = cxl_port_bin_attr_is_visible,
 };
 

---
base-commit: 7f5b6a8ec18e3add4c74682f60b90c31bdf849f2
change-id: 20250114-sysfs-const-bin_attr-cxl-d102eab47586

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

