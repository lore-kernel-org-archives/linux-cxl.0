Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023B20E023
	for <linux-cxl@vger.kernel.org>; Sat,  1 Aug 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785579167; cv=none; b=agOqB6cu6YXZsskZz4AoG1aQnLxelUC8q4BP7rQ1AVA18sKJ3QaBhkQ9Sh5jHOjpxdpsHyjQGtPDDZVWwsBnJJJbcsOC/JeGsL6ZpkqY3i6tL54OJzpy8grtQfyfwo8T713TWqrnSM5vn52Il+qcP/Ft9pRnSyroGdzUHkbbBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785579167; c=relaxed/simple;
	bh=g/j50hg1gf+M5nAj7G6slFMXY3YdVKAmXsiQ4ZtAavY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIZRPsA3GMeHJ8iDB36qQ0/2oSK9DdflzcYv9kTLUB2cC+af3f8Qf1HgX5hhiOo1FDVQJOata5fyCMZBiMV4PRO6O5CM1dw7lhpufk848zRIBWi0HYxFqqtcsFyYghv9iVM5hdSIDjDuKukkQrkFgoswcc1eUYgipTCdvObwkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqJby/ko; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqJby/ko"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1922357a91.0
        for <linux-cxl@vger.kernel.org>; Sat, 01 Aug 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785579166; x=1786183966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CRjCJN4PPtRE4NvJhtErGEPAXvNAwEgHaW35/sMVDho=;
        b=FqJby/koV5Qbp95Wf4YlxAVp4ubVU/IN7M8suh61XQTeaIM+6tGu6L8vd6f8SmjhJi
         08gva/PkSFl8Ih6ZyUYlJSDZ6Ilwy8wLOUON945VY8xgYhg+XkVpD4HgnH9hwe2ZsFmC
         NU+aY/0gUp1KO10PtoqBUgB0W31T0yA3iys//v619etEJmELLdLJq/rWAeUi2dpFZAas
         pSvCjfoX5e9Qp5mQy+lNP/H1WWtO2o9mEc8VIyFWqx1uZLgyohA9NncrqRONrjXonPHl
         4f++IUDnxEV5rMCTFZABj4lfK86whQAQIBq3KKjmpf6lJzeqzlf4FZSc1zWnB8FGJmXD
         mmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785579166; x=1786183966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CRjCJN4PPtRE4NvJhtErGEPAXvNAwEgHaW35/sMVDho=;
        b=YDHHOHFOXJIlr9qVPd5T3Aw6MFOt9ZQdl/9KSEXxw8p6Ug7j6gR/YWHEgWRqYOpp27
         eCu3O1CVFqjTqECMIXtoqXr5dfX4flFLtmYAsxf0xoNCVsFQKWy+NisuijYHIaTBYYUs
         nVopFdMUSXKY1MW5NFjDkbfO1XOJig+OPlADYkXgI6O39wFtXpQXARueJz9SjUMo9/tx
         huQVSXC/ZSNEu4HOjCeLDvApbypV7uqY+l4WinxpjtShcd1wm+kXZAGqcbwOhuRfLtbL
         9QHLuZIVrwjllAvEL8IF4wMdkWOcmuokFH7AXeHBtFXIfAw+Ho0RELHOuZJu5CjmT3Be
         rJdQ==
X-Gm-Message-State: AOJu0YwelrGG5/GoS08jg4YX8HwvDiwXXnh8X4+ZrBqNk471FM52r9qk
	c1VyvbRGz17RqVbHSlS0fHMPSx9yP4HvZqQFAp7FL8qaqYgeMhVKl4uk
X-Gm-Gg: AR+sD12iwW2bEEKPmisbx3uA4J8nOaG/Y8F+fMZtv+v5JZmmTctaP9nA4PWj3DiQruP
	J3AwOJMDMEaWnS7jjV3DHcnyCIsVDaRQmHAinbKKTI2YiL6vbgOVcql/YcTmCEpmhwYsj0XGyMN
	INlX/AjjXUmz4RKkzslEt8KcAyG8ocXzCSTEQSrIUvZAP+QbSyORG6faFw9vO71vJ2TY7tL5jII
	hTm62/rAZmxk3Rrm+OpFoNyqPc/rmde0EjGwIfNkpreoARDtUouigcV95Jz16OKDbWIL/qUm8q+
	JvqzvqDA2n66MR9oDUJyVYpP8+XyNgxKWQN8K0GpjR8N0im5ft0fe6l0+BpEyoaT+kFQmXtGb2z
	bx+GxhamDoDYSyDNIaJBZgd7CiMeHvKChtALwg1gx84Nm1JRDnYnsMA+GcAD2duh/MmzpZ3pnbX
	cAhBjWIl88EcAfq5TouSDHOW9mOmRh17ewrMwJ+HKD6yo8dB9XlbBLxCmSsJE51cxxsSqArQBqb
	Kh0pz/cl1H/DfhUdQ==
X-Received: by 2002:a17:90b:5888:b0:38f:1e1a:5141 with SMTP id 98e67ed59e1d1-38fbc50af6cmr2938409a91.28.1785579165811;
        Sat, 01 Aug 2026 03:12:45 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b120f2fsm16130565ad.64.2026.08.01.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 03:12:45 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: use %pe to print error pointers
Date: Sat,  1 Aug 2026 15:42:17 +0530
Message-ID: <20260801101217.12778-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the code printing pointer error values simpler and address the
coccinelle warnings:

  drivers/cxl/core/port.c:939:3-10: WARNING: Consider using %pe to print PTR_ERR()
  drivers/cxl/core/port.c:1275:25-32: WARNING: Consider using %pe to print PTR_ERR()
  drivers/cxl/core/port.c:1309:25-32: WARNING: Consider using %pe to print PTR_ERR()
  drivers/cxl/core/region.c:686:3-10: WARNING: Consider using %pe to print PTR_ERR()
  drivers/cxl/core/region.c:3778:13-20: WARNING: Consider using %pe to print PTR_ERR()

The %pe specifier prints the error symbolically, so a failed dport
addition reports -EBUSY rather than -16, which is easier to follow
when tracing port and region setup with dynamic debug enabled.

The PTR_ERR() uses in return statements are left unchanged.

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
Tested with cxl config build in x86 Architecture

 drivers/cxl/core/port.c   | 13 ++++++-------
 drivers/cxl/core/region.c |  8 ++++----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..c9875e6af9f6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -932,11 +932,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 
 	parent_port = parent_dport ? parent_dport->port : NULL;
 	if (IS_ERR(port)) {
-		dev_dbg(uport_dev, "Failed to add%s%s%s: %ld\n",
+		dev_dbg(uport_dev, "Failed to add%s%s%s: %pe\n",
 			parent_port ? " port to " : "",
 			parent_port ? dev_name(&parent_port->dev) : "",
-			parent_port ? "" : " root port",
-			PTR_ERR(port));
+			parent_port ? "" : " root port", port);
 	} else {
 		dev_dbg(uport_dev, "%s added%s%s%s\n",
 			dev_name(&port->dev),
@@ -1271,8 +1270,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
 				     component_reg_phys, CXL_RESOURCE_NONE);
 	if (IS_ERR(dport)) {
-		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
-			dev_name(&port->dev), PTR_ERR(dport));
+		dev_dbg(dport_dev, "failed to add dport to %s: %pe\n",
+			dev_name(&port->dev), dport);
 	} else {
 		dev_dbg(dport_dev, "dport added to %s\n",
 			dev_name(&port->dev));
@@ -1305,8 +1304,8 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
 				     CXL_RESOURCE_NONE, rcrb);
 	if (IS_ERR(dport)) {
-		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
-			dev_name(&port->dev), PTR_ERR(dport));
+		dev_dbg(dport_dev, "failed to add RCH dport to %s: %pe\n",
+			dev_name(&port->dev), dport);
 	} else {
 		dev_dbg(dport_dev, "RCH dport added to %s\n",
 			dev_name(&port->dev));
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..894df68a6074 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -682,8 +682,8 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 				    dev_name(&cxlr->dev));
 	if (IS_ERR(res)) {
 		dev_dbg(&cxlr->dev,
-			"HPA allocation error (%ld) for size:%pap in %s %pr\n",
-			PTR_ERR(res), &size, cxlrd->res->name, cxlrd->res);
+			"HPA allocation error (%pe) for size:%pap in %s %pr\n",
+			res, &size, cxlrd->res->name, cxlrd->res);
 		return PTR_ERR(res);
 	}
 
@@ -3773,9 +3773,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	if (IS_ERR(cxlr)) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+			"%s:%s: %s failed assign region: %pe\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			__func__, PTR_ERR(cxlr));
+			__func__, cxlr);
 		return cxlr;
 	}
 

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.43.0

