Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B542F0C45;
	Sat, 30 May 2026 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780115118; cv=pass; b=GkWkbqRLmvcG/50d+o6Rq5dkxaf/gMQYPqlE21S1v5NWXMUnUMEWnZkF7fT8SPBdTWAiU1aGS81vKXUX3CKklAKc1mhsc8qCl8LnH9+/Ssfdz8R/mRdv63enfZWm3jE4PMOJuCBCJGySWf8KToG+oEYo/+Kf30cFK05pPQ36QxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780115118; c=relaxed/simple;
	bh=UjwcannNSEYVNXGty0gSxUl3thcJiAJ/CmY6vhpklso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XgmBfyxOKG0gzCaTLU2Mcz9ozB8QiVYxY05omOH0BqCX0LIfe1BgW2kzMKixUS14w8MoJF0RAYLSMEi4fENwPnfgwU7jqyNazrZUe9G5255hBvxrV5EfQn1V+EicqcE8+SIAU0GFypFkovPlZbLlOIgm/LE1egZa/A/nrHpEZkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Zg+ydXfs; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Zg+ydXfs"
ARC-Seal: i=1; a=rsa-sha256; t=1780115112; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S26u6RLz0Vu56m8xmD0jO1jui3BiY5sJapMDZRwaDlAMT6BcUvl3enJIbJ/0VUX6ExpGpNLXZi6RSpx/IGf5bGff1tIvGYtXUodaxNcPEzRNs+uwnkGu1++YteCwDNLSda7Ys9mPqJzRcLrZHAaIa/DK0Zkc1Fl2M0jFQgERfnE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780115112; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b8+nupdxKvvqds2fj4gfOE755touuhcMWKZpjgM0S3k=; 
	b=GeoxjCrVF08xma6OyYe9XP7QDGo/82j7awIbeYy/FTXW7PO0hGO4kqYEyoSAEppNyJpMl37EBhNaPFCT1Umnk6d9SdVE9KjafJZbvAi0fs8ffdbOq7gPYNYu0cmZE/bt+bWBhK1H+0dWlenr/K9oHzn/mTdwEfZSpZCSlfzW8dU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780115112;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=b8+nupdxKvvqds2fj4gfOE755touuhcMWKZpjgM0S3k=;
	b=Zg+ydXfssCsVhyD92BJO0d1IFNjNfUTEJoJWOgV9eShRgHl0XAT58oa7oyLArXyr
	8zm9R4Sr1LjnJKxCgUZrc7kO2T7Q9KH+ywTaGn987oMfLVpqT3zrSeXc8k6GR5+M0s4
	dOvvXkWau9OZcR6Ntael6/FAjtJlL2CqlHut/xXE=
Received: by mx.zohomail.com with SMTPS id 1780115110079392.9237621240293;
	Fri, 29 May 2026 21:25:10 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 30 May 2026 12:24:40 +0800
Subject: [PATCH] cxl/region: Fix NULL pointer within p->targets[]
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
X-B4-Tracking: v=1; b=H4sIAIdmGmoC/x2M0QqDMAwAf6Xk2ULaTpH9ypCSbVEDpRupyob03
 1f2eHB3JxRW4QJXc4LyIUVeuYHrDDxWygtbeTYGj37APqCd5RPznlKUHDfShbcSSZW+1vlLwED
 jnXCG1r+Vm/x/36Zaf/wyPjNrAAAA
X-Change-ID: 20260530-fix_null_in_targets_array-124303a8ba0f
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780115105; l=1901;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=UjwcannNSEYVNXGty0gSxUl3thcJiAJ/CmY6vhpklso=;
 b=vcBV/FRlCHttoVZBNhNCOArClKLASoTumfU2KBvJ4KsURa9qvHMiBlsMqJ/Iky3Zr+EJMzBxe
 j6x5YFS09fWDV8j5FK7EBayb2iu8tCLm2JKsh1RGenRL0qMrntTV8Ub
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: zu08011227ca6dec2f92bf7be4e933af6c0000e89cf5fb483ae4325a9f8609425d090ca0198f81b12ed86e84:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

cxl_region_remove_target() leaves a NULL pointer in the slot of the
removable endpoint decoder in p->targets array. However, p->targets
array replies on p->nr_targets to determine validity, which means when
p->nr_targets == p->interleave_ways, driver assumes all elements from
index 0 to (p->nr_targets - 1) are valid. The stale NULL pointer
violates this assumption and causes the driver to treat a NULL pointer
as a valid endpoint decoder.

To fix this issue, when a endpoint decoder is removed by
cxl_region_remove_target(), always swap the last valid endpoint decoder
pointer into the slot of removal endpoint decoder to ensure all pointers
before p->targets[p->nr_targets] are valid.

Fixes: 809ccef5385f ("cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()")
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e90c024c8036..54018db87a4c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2220,7 +2220,15 @@ static int cxl_region_remove_target(struct device *dev, void *data)
 			p->nr_targets--;
 			cxled->state = CXL_DECODER_STATE_AUTO;
 			cxled->pos = -1;
-			p->targets[i] = NULL;
+
+			/*
+			 * Swap the last valid target into the slot to
+			 * ensure no invalid target in p->nr_targets range.
+			 * The targets array will be re-sorted during the
+			 * last endpoint decoder attaching again.
+			 */
+			p->targets[i] = p->targets[p->nr_targets];
+			p->targets[p->nr_targets] = NULL;
 
 			return 1;
 		}

---
base-commit: 809ccef5385fa1779c7db3de43272f3fc6a87a45
change-id: 20260530-fix_null_in_targets_array-124303a8ba0f

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

