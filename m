Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D776321B905
	for <linux-cxl@vger.kernel.org>; Sat, 21 Feb 2026 04:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771648220; cv=none; b=gmiVbeadW1MJV/cgRFdBvKZAGz8DUL4Cg6alX5yEcqXtuz45qRbvOjdDeatgVS+NPtNJGx7pwryNessdIjolXNJQNWmYhe6F/PpgCtPdxPVO6mo1AOs4Z1afDi9ouUBCv6a69rDRlw2cOmMGLiJ5v3/DEkqdgKgNe5bDTJudb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771648220; c=relaxed/simple;
	bh=SOBRjeasEkoGzAMnYXxXZWlhxYUAK095a9xfC1Y0/so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLNTzZOjM8s+fIwu9fWP3KuiMzqESCa9VsaibNf95DEuhHvjYqcuau9hPqLnkM5VsbGIGY1SK9fPPwQmzOvyCRd1gFZ05WTRiHFQlPJbCSvcxp2GgHdMg6LijlazOAITXbwphHhlquV/pYHsHfCESbO9fKLrSVRbMM/VFqm/zWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OgDcyq+D; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OgDcyq+D"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5069df1d711so23895731cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 20:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771648217; x=1772253017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ix5JV8eP/LnMAYYaOupAc+ixUwINu+P3fRblxKT0WY=;
        b=OgDcyq+D+O0lkKLa/aPRh73GcJCSuUONsX7jM95bsqxL0iw0SQHG9pr89M2S++JJ6G
         DR/gjK981FEvzdllCL0nHENQbKjex6tLPoRsptLiYifY4VpGdxd5j/da2hcUfpJq/6XD
         bVjkrHbL9QwWohI2m9CCf2ETRzrrQhPB1CGzbNe0bWFz83co1S18r+UQyHJ3ZCo7bUJY
         nhkD9m9MmERsf4wPzB0v9u9k6KZumPDgihpr7VOSjPe99704+LGVutfRYi7l8qJ3TIJP
         5Vk3o3E7Hmf+xadR2QhDYfCZAQHGol0XYiKi0jeowmYoDqvXFvfu0LnIU//h08ShSbdu
         8d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771648217; x=1772253017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ix5JV8eP/LnMAYYaOupAc+ixUwINu+P3fRblxKT0WY=;
        b=W+fx6SvYPD0J94OIA0Fl+4OkB4K/1ByYMbscFxhQNw5QiPBU9lesxZmn2Xm8rTfGbX
         kaEylSBbFzv4R/fPnZDfqyjSD8spMmlklevrPCIexSEHmIWPxH0kzhmSr/qOomuUt0mB
         uTt3wrvdNG5JtQY0BVYs0LhwdnaFpTk2BD0njuk18ClRRR/fqrEssuQ7HmyKSRpNY0qy
         h91BUKZWkjRtoQACr0+ExWkwSh9oiTWlwU+4AZaGw+8QwokM59ONFI1OQFGU++NBjAnx
         3RGD5RYlNDcPWkY/Lbwm90Z+vsdwS2YdID0B+EAfAVv3ERKBxCJv/jG//KnfUwnYtzuO
         +u7g==
X-Gm-Message-State: AOJu0YwFg18ZhIhNBMIICelMWamwe1vC3On0Gmmud/55ervdxqQ4y5Yx
	X6KxQNys82OCri8yqr5xmBnGzzQv0LBnU3/LIOAtGGjBZYK+MGZFDWF5xdaAi4kG0UH/+vy0Gnc
	fVcbd
X-Gm-Gg: AZuq6aL37ZL+6WyRsAUi8yGHNcLGCcNoEZOgI7UYidu7nZITRe5q2i//L/gwne82DEV
	MeAkLgGpp7IqLkx21mCEXb41iZRS7hmIR2x8UO8Uvr0cRY8OTVxRQMz6T0J9rU/zv8+YOUc/d+7
	J6qpgYYrg4wNpzeE4ZqCSa/AbqdXWf7RFeUJAPc9oT8fAzrGKCnqqntIesDBtsQCVcyS0z9PhkK
	lmnEnsBJxzXi9oP9f+JTWgzfXJuN4EhPOFbcxKNcTk5Mrjb9vp5+KLcOeA+HLvNP9GyzTGQ5wnY
	3Z3pDVbyvCpsuhasNOCG20eYyqEUsTZ8XAobakK/1dvnC9UGuaXXDY8gxvfrt++fYd6/GMD177C
	6HnkwFUyeb2g90X0aUSvKN6kxwyJxio0SJKzHByxWHLHxmX1eX7vMgu9klp3uK04WjJ6o1PptCO
	P4Z2JxBLbo7raYoH/P+vkR7VLDo9K4vk5G9ssEm+oEjpAPLkNVzk8u+LgSnzqq6oqdOGWLC+WN5
	9hnXspn+0bp9lo=
X-Received: by 2002:ac8:7d82:0:b0:506:be2c:a96d with SMTP id d75a77b69052e-5070bb816ffmr32009951cf.3.1771648217535;
        Fri, 20 Feb 2026 20:30:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a1e6fsm9984991cf.16.2026.02.20.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 20:30:17 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 1/2] cxl/region: fix region leak when attach_target fails in cxl_add_to_region
Date: Fri, 20 Feb 2026 23:30:12 -0500
Message-ID: <20260221043013.1420169-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_add_to_region() ignores the return value of attach_target().  When
attach_target() fails (e.g. cxl_port_setup_targets() returns -ENXIO),
the auto-discovered region remains registered with its HPA resource
consumed but never reaches COMMIT state.  Subsequent region creation
attempts fail with -ENOSPC because the HPA range is already reserved.

Track whether this call to cxl_add_to_region() created the region, and
call drop_region() on attach_target() failure to unregister it and
release the HPA resource.  Pre-existing regions are left alone since
other endpoints may already be attached.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 385be9cb44cd..276046d49f88 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3923,6 +3923,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	struct cxl_region_context ctx;
 	struct cxl_region_params *p;
 	bool attach = false;
+	bool newly_created = false;
 	int rc;
 
 	ctx = (struct cxl_region_context) {
@@ -3946,15 +3947,23 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	mutex_lock(&cxlrd->range_lock);
 	struct cxl_region *cxlr __free(put_cxl_region) =
 		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
-	if (!cxlr)
+	if (!cxlr) {
 		cxlr = construct_region(cxlrd, &ctx);
+		newly_created = !IS_ERR(cxlr);
+	}
 	mutex_unlock(&cxlrd->range_lock);
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
 	if (rc)
 		return rc;
 
-	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
+	rc = attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
+	if (rc) {
+		/* If endpoint was just created, tear it down to release HPA */
+		if (newly_created)
+			drop_region(cxlrd, cxlr);
+		return rc;
+	}
 
 	scoped_guard(rwsem_read, &cxl_rwsem.region) {
 		p = &cxlr->params;
@@ -3972,7 +3981,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 				p->res);
 	}
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
-- 
2.47.3

