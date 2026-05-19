Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6544C81AA8;
	Tue, 19 May 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197058; cv=pass; b=a76Ep1pBc/WALjhIFRKp5EgcyZrrnyW3251dl6znZRP5ef/MMdq6yk0mpj5fMHIohxK+d/4+k8uY1735hqG1E50vVL77EmH8VR1vrwd183mH7xoHw4wl8zV/8QSjaE+Lr7yWPrhLgLsW/UO08W6odnhREIz7EEBE9A134TZ39uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197058; c=relaxed/simple;
	bh=bUxtNfIKLFBglENK0+HoaqdMcP9px3ry2UClXkt1zGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KTM5B/3ZpjHGGIqBjgurLFxuGDckVbxD299T8Bt4kAV0cmtGn3RfWnuKlzubeUjO3AcKDgV/Tv4OGsSSctMcmtlsKcW7CRWLnrfP91VLfzFZc6trgf/bthecAmnWF7YoV1FMFzl3F44EahlpzNcUD7PDGKivpWFDvkjadkSHDv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=E85u9gWU; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="E85u9gWU"
ARC-Seal: i=1; a=rsa-sha256; t=1779197051; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ITHbEpAZiXs+WWudN3/rnNBvUYcxzcRBWWZJAS4uNUwrmKQuhFXHdXq8O7kJxRVfNZ/Du4fl329OFlinFP7/ghumnZ4YGavVlTfFa55Cb5PmLiInXkSCjpWo3itbERYe2Y12a+p2P9LNvdSUKTAZ3ugc1zXrbPS0YdffABdLFco=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779197051; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bE403zlNyZJxlgHSq5Esu2xViFaaGw9Bt9p1NP3iRNU=; 
	b=Q7Hb7wUuCuhLVYf0KvrwhPBJrnAuF617ehGthT70CDvnxHTi6fo1FDKdN117DOKX3F6FzfrD/hKMJdSogn9AkiaDr3ub8jPGLloFvkngDYJTLjTvkFF+fhZd4kXlyd1sFbNz9xFLAqdsiIT0v7nNkgaSkDpZq3lMyiI420CafnI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779197051;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=bE403zlNyZJxlgHSq5Esu2xViFaaGw9Bt9p1NP3iRNU=;
	b=E85u9gWUq/1COJXhGvElmiN/DhKorYQ7PUNsqRIR4PBTKacrhfQuhug5h/b9iikT
	sy40AFVa03pV7C3htBL3VWlQmRn8ADQz/B/w/fWwEWr82nK3wljUh97iF9G0Zg3Bvxl
	ptfNdDumkD98PBLEPxwSpPaaxltlGeRaLQVXIOWI=
Received: by mx.zohomail.com with SMTPS id 1779197048227639.7223267775388;
	Tue, 19 May 2026 06:24:08 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Tue, 19 May 2026 21:23:53 +0800
Subject: [PATCH] cxl/region: Fix out of bounds access in
 cxl_cancel_auto_attach()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
X-B4-Tracking: v=1; b=H4sIAGhkDGoC/x2MWwqAIBAArxL7ndADzbpKhJhttT8abkUQ3j3pc
 2BmXmCMhAxD8ULEm5iCz1CXBbjd+g0FLZmhqRpVyboXKz0mXKcJq5nD5Rc21jlkFlq3upM9orQ
 Kcn5EzO6/HqeUPqBlEVBqAAAA
X-Change-ID: 20260519-fix_out_of_bounds_access-8838759ee5a6
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779197045; l=2550;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=bUxtNfIKLFBglENK0+HoaqdMcP9px3ry2UClXkt1zGA=;
 b=Q18NH79tm0wQAmrXaixKm2Eg/YCzGjaMayOzlwwv7Cu42azENXQYsojEAgytiJiu4A4Iu5ieF
 0KkNep25NELAQM+lPDf8D7ybCWHrIVQQ44gGpqwatjsw7l6qmZZe/Ml
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: zu0801122773a101aca37c9c80e719f0a0000057c462660c333dcc0e31ec8ce5ef3ba46b6890cd636fb1e978:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
accessing p->targets[]. However, cxled->pos can be set to -ENXIO in
cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
causes the driver to use a negative index to access p->targets[],
resulting in out-of-bounds access.

Fix it by walking p->targets[] instead of using cxled->pos directly.

Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..551228bc91f5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2202,18 +2202,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_by_target(struct device *dev, const void *data)
+static int cxl_region_remove_target(struct device *dev, void *data)
 {
-	const struct cxl_endpoint_decoder *cxled = data;
+	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
+	int i;
 
 	if (!is_cxl_region(dev))
 		return 0;
 
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
-	return p->targets[cxled->pos] == cxled;
+	for (i = 0; i < p->nr_targets; i++) {
+		if (p->targets[i] == cxled) {
+			p->nr_targets--;
+			cxled->state = CXL_DECODER_STATE_AUTO;
+			cxled->pos = -1;
+			p->targets[i] = NULL;
+
+			return 1;
+		}
+	}
+
+	return 0;
 }
 
 /*
@@ -2222,25 +2234,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
  */
 static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
-	int pos = cxled->pos;
-
 	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
 		return;
 
-	struct device *dev __free(put_device) =
-		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
-	if (!dev)
-		return;
-
-	cxlr = to_cxl_region(dev);
-	p = &cxlr->params;
-
-	p->nr_targets--;
-	cxled->state = CXL_DECODER_STATE_AUTO;
-	cxled->pos = -1;
-	p->targets[pos] = NULL;
+	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
 }
 
 static struct cxl_region *

---
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260519-fix_out_of_bounds_access-8838759ee5a6

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

