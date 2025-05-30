Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579EA21CC55;
	Fri, 30 May 2025 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608179; cv=pass; b=luMcd1LJwQw7qTyrlokd8HuS/NVnSYxzS7MZNN2tU58lQRlxrBZa33hITfRdxVif9YAu0jzCVsEuuZsx9o9nOKw3OCAPK+FCsRSgvheSBaJqsSaRnKnCE9aPMkgwUaUGGLstg0T5Wswkck3kUCBa573H5+3fExFRLHxUdXEEIPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608179; c=relaxed/simple;
	bh=vvV+wMXjkH/YHcIFZOZpmowXuylo2ezRofTrPhaaREw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=obeuU5Lq8NFcHXN6HZ3ftc2uz/dRtQA7FRsxN5hXyWAG4epmEtc88aBRibjAabz4zJh9sCD3hTE0CQVlNT/JrtmlLWxT9xgm/5mLVvWEUS2Wq/EFLLegySe4pKRp3VgKQqAK6I0tSaqELAmFHBOqzQbqOZlW0PPaEhqPK2NfUiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=fFXr4mAL; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="fFXr4mAL"
ARC-Seal: i=1; a=rsa-sha256; t=1748608162; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k49OgJzzZLufNhC8Tz3BXHb8FMuaEICnSKbNtbXQ6iytbZLwdmoOWamtXjmGvhv/xrL3eHWFb2xqIEiPmIR3WzznjojUHbQ9SWAx7RskGUu6X2RRIyHFU8ZCHnEVaogWvV9mB0HMod20MDYMm/m47xhE5J+EfS5JidYbbFtVGKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748608162; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eQQxAyPBFvkur3FmRKO3w9aZ2DfIiint0lRxeDh5doo=; 
	b=MBRDa0QC9dwwZTfe1WspSlIBIlPPAvNvjsbOw/hVTkd855HlKU7XrcZ1hKmQ1zoKtOnBJWVuC2eP17LD+FUS+VeOgIZb5jy5+pos99PaDyaB1ImnIzy+D7jR529ZwVcVcZRnhqmHK2Jnh4YgvsKNBWh2rFEwwZNfxY6N3HUYFXo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748608162;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=eQQxAyPBFvkur3FmRKO3w9aZ2DfIiint0lRxeDh5doo=;
	b=fFXr4mALNExgUxrLat5VrKgrX4iTVCFbXCD0Jz7U2Kv5RaeYrvTTLrquelsbCkNl
	B5yoP4Aj5g5vYb9blXwE8V1OT99mAneSoL/2mqesdrCcjiSftq5iQWr2F0C55e2/O4u
	tcIxWlg+BGD+uYZiLGoXbOOne0brs0Y1au0f4kKg=
Received: by mx.zohomail.com with SMTPS id 1748608159927498.66596290421217;
	Fri, 30 May 2025 05:29:19 -0700 (PDT)
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
Subject: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region miscalculation
Date: Fri, 30 May 2025 20:28:52 +0800
Message-Id: <20250530122852.10139-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122765ddd9d0631f8d58cd66bcff0000a49192212baac76999e2fb3877b96e84f471dedbb239ffe6bb:zu08011227d66e7ac81153cd1949d4747900001810b266e707db1081724184c570c274114dfa772ed16c0998:rf0801122db408275213036446fedb25090000bfb0124f58ba15059e30daa9c966ed4d4cf9692f08219c80704791888a7d4f:ZohoMail
X-ZohoMailClient: External

When trying to update the scrub_cycle value of a cxl region, which means
updating the scrub_cycle value of each memdev under a cxl region. cxl
driver needs to guarantee the new scrub_cycle value is greater than the
min_scrub_cycle value of a memdev, otherwise the updating operation will
fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).

Current implementation logic of getting the min_scrub_cycle value of a
cxl region is that getting the min_scrub_cycle value of each memdevs
under the cxl region, then using the minimum min_scrub_cycle value as
the region's min_scrub_cycle. Checking if the new scrub_cycle value is
greater than this value. If yes, updating the new scrub_cycle value to
each memdevs. The issue is that the new scrub_cycle value is possibly
greater than the minimum min_scrub_cycle value of all memdevs but less
than the maximum min_scrub_cycle value of all memdevs if memdevs have
a different min_scrub_cycle value. The updating operation will always
fail on these memdevs which have a greater min_scrub_cycle than the new
scrub_cycle.

The correct implementation logic is to get the maximum value of these
memdevs' min_scrub_cycle, check if the new scrub_cycle value is greater
than the value. If yes, the new scrub_cycle value is fit for the region.

The change also impacts the result of
cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
minimum min_scrub_cycle value among all memdevs under the region before
the change. The interface will return the maximum min_scrub_cycle value
among all memdevs under the region with the change.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
I made this change based on my understanding on the SPEC and current CXL
EDAC code, but I am not sure if it is a bug or it is designed this way.

base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
---
 drivers/cxl/core/edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 2cbc664e5d62..ad243cfe00e7 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
 				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
 {
 	struct cxl_mailbox *cxl_mbox;
-	u8 min_scrub_cycle = U8_MAX;
 	struct cxl_region_params *p;
 	struct cxl_memdev *cxlmd;
 	struct cxl_region *cxlr;
+	u8 min_scrub_cycle = 0;
 	int i, ret;
 
 	if (!cxl_ps_ctx->cxlr) {
@@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
 		if (ret)
 			return ret;
 
+		/*
+		 * The min_scrub_cycle of a region is the maximum value among
+		 * the min_scrub_cycle of all the memdevs under the region.
+		 */
 		if (min_cycle)
-			min_scrub_cycle = min(*min_cycle, min_scrub_cycle);
+			min_scrub_cycle = max(*min_cycle, min_scrub_cycle);
 	}
 
 	if (min_cycle)
-- 
2.34.1

