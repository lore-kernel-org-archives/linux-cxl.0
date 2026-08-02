Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E2322A
	for <linux-cxl@vger.kernel.org>; Sun,  2 Aug 2026 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785669646; cv=none; b=UzIvrOQSrJKe48a01ZMtz1qFmiUBJoHjDLBECNsauLTmy65sCNTt9KfAPOVuzIMd5zg71k/JXbw7S0kNm/czefcIIRtqQ2Fi0lcB83t1CijPacRJzsXmZNrlurzVs9ER9ynhURNkFdkopPaLXx33E37iHFTYQnrVZNJa2tWpQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785669646; c=relaxed/simple;
	bh=LFPcp6CXA/x3F71q2TIdQYdeiBvgEWE8aizjnFiqyiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKCOe5EdSKhiLgBfLyjr/P6Qo/DY8/wBcvOy4XK3qx0T6uBHHL91TPhv0kVg7MB6ASQVvF5qaFwXie1rY8nBpxT4Z3KbgDP8kmwrjrO5HKqVd5UEQviIHw3OR8XV07NAGhw3wIw/qbsc+OtVU/ZB/BC/ZFoUwWLNuUEshildyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THK+NQ2A; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THK+NQ2A"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so33753515ad.0
        for <linux-cxl@vger.kernel.org>; Sun, 02 Aug 2026 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785669644; x=1786274444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XXturRtkPIePk9i4DZbCbMO/flEYuSWL+nIK+cXwWV4=;
        b=THK+NQ2AqMQaUyVQ+zto2DrZ/4dCt2MQCBFg7f6U0JYORe96xTgZsIjmB2zVUXyGxd
         iQL+8YY4Gb/nXU0H7oqSfCxEEXdcyvNF6GiKZXCTaRBux5BT5xAM8d4tPD3TsBoRQPGd
         9LziQi+TGS1kqtEglsjVsdvJ/3oGHXmPmpOLLNO9Piwcss1mLBjxq4nbCTjRoJUlzfSt
         YLpcjL6jOKQwKiMAH4aWVpXG4irJlMjdUqaVTVJSKzwqaSvaxJ/0bm+TT88F68Hg6sXZ
         KBwmoQxIRizu6b/S7st0AuZIm+INUUzU9guI/Ga968pJX5V029/a/luCGgWDHMzTN+3B
         nTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785669644; x=1786274444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXturRtkPIePk9i4DZbCbMO/flEYuSWL+nIK+cXwWV4=;
        b=NzhhPotaNmDRsRsirMJ4Eo/Ewougzoel94korQ2RzZnUPjPfLSs3833FGkH+oW0AkL
         uSFCYJzDA9+WkqIiaSSWbnaQXxsc0F8kbTEClBOm2NhhAEOODXjrzXQaMS9VtQhHkNlg
         fQmi3kliPITjgmnZj2AiG6jVA4xYYj0PynsMjEe2GWbCRE+RteoL7j8MxSTJoLReXq+0
         Sz/VNi5ykEuKX7hIYrh+9KY9qdhy7XEdr3+T7VSlmoXW3evJGy2FSI0XH7iZHSrLvS0j
         9FIg6qaqnPKaQf3l+T06YN/Ay6KAgP2eNThy/XDeEKkceo5MSeF7MUBT5708+HBiNQR2
         VEAA==
X-Gm-Message-State: AOJu0Ywd/6XWMXZOrOPHKUTx7Lx7e4LzABrmhT5Gj7RYwqTyEZoIdfwr
	BaEXiDnv2+eWMlM8cTj1+bjbJP0gwXCayCUry/yaip687Kn5SP1A3kzo
X-Gm-Gg: AR+sD11uEItslmqa1AMrl4EIGljfe1cGrA8eYDtDh5CZGoexJTfYvnvKKz1tGSOMPby
	mbV5iEQjAf1A3lMavfxnO/pxvwhX0MaEL7hKBCtjwd5wRQ+tmllYjKS6ufSXVpXmIk8PfjglrMo
	NL6wJFpFt+4kECSMxdDWUCc3jV+ppNZKy3EBgO9jtcw7Jj8k+m8UOyXo+so6i914FT7YGRKXTLF
	42pdkEB2D+v9QOb2CZq48UmNqUNhWbCxgCD2I4/6ac4l6IHxTvhwR6+CBdwuzWbkraJ/zVv/JJj
	BdpLzAlUmgj4zjlLiAo3y9fyjgj06rixEUjMjBgQA1iKR6BCWxd2nRpCkhpjMVw3Ib2BheI9LVi
	eOyexJizccfGxIdv2NBhOUXolE7Ef8BP2aue+XTMuLXNuNvdSD7kYVNvWznwoLU3sNHO+W8PcA6
	j/JSNKVa20eHgDe6u5pJX114wkhCSScjSoBeK132H00Gb6Vnt2sF8KP7Tm5e+CKwUxsxDahLQVn
	XfLKohispLPRwe/ktgmBTA3hCSg
X-Received: by 2002:a17:902:da81:b0:2c9:97a9:2097 with SMTP id d9443c01a7336-2d05241c768mr70935345ad.43.1785669643654;
        Sun, 02 Aug 2026 04:20:43 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb486sm25568915ad.53.2026.08.02.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 04:20:42 -0700 (PDT)
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
Subject: [PATCH v2] cxl: Use %pe to print error pointers
Date: Sun,  2 Aug 2026 16:50:29 +0530
Message-ID: <20260802112029.28767-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the %pe printk format specifier to report error pointers directly
instead of printing PTR_ERR() as a long value.  A failed dport addition
then reports -EBUSY rather than -16, which is easier to follow when
tracing port and region setup with dynamic debug enabled.

Convert the five affected sites in drivers/cxl/core/port.c and
drivers/cxl/core/region.c.  PTR_ERR() uses in return statements are
unaffected and left unchanged.

drivers/cxl was scanned in full; these are the only conversion
candidates.

Found by: make coccicheck MODE=report M=drivers/cxl/
No functional change intended.

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
Compile tested only with cxl config on x86.

v2:
 - Reword commit message: lead with the code improvement, note coccinelle
   only as the tool used to locate the sites (Alison)
 - Capitalise subject per CXL convention (Alison)
 - Note that drivers/cxl was scanned in full and these are the only
   candidates (Alison)
 - Clarify that the patch is compile tested only
 - No code changes
Link to v1: https://lore.kernel.org/linux-cxl/20260801101217.12778-1-shaikhkamal2012@gmail.com/

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

