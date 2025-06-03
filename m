Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377357262D;
	Tue,  3 Jun 2025 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947422; cv=pass; b=t2VR0ogg3WIiZgphixEOoh6V87qGtk1L44qOsPp+9V1I/nm8czRDU26R1Uk3c0M8yV8PvfbsVr+RQeNTmzQc0GHYen34HX5jEJKdYhEDcpEvvdHp8LVjawk7Jm231TUIpkRdygt3kthj4STu8N6xV4kPH7vzgz7H4thRd4FNySM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947422; c=relaxed/simple;
	bh=VYokcoB9tTNrTZMOKW7sp19l0rIKS6i8KRNk35GJhH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HR89b3RrzomBjnAWltSOQn516MrpGKAAJdNfPRQ4hCuiJWDupkgNgA1CpdIBWHULCkbFXAyTlk8+i7JVADQZD5SamDqVMCy9d27R+yam3SAdUPK58lPdZyqVyFQqIs1G+boeMsD2xnRoziexSX4rGxLYnQ7TlGymOgqkJhDTzwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=F0E4IDlE; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="F0E4IDlE"
ARC-Seal: i=1; a=rsa-sha256; t=1748947406; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UKMh7YZnH2X5dneYMMm8B77J9e2uoSro4NZI+1pFj/+MHOpSaztel6KpbfRIOyV3OAO5CY23/QdlgUUpQkpRuNN09TroGmpXoEMJPft7emnbxjnMii2puLlkgJWquS20wInbUmx2Yu+8DeL6Xna+C37JOEyKRDB+VAnbFDzm9rs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748947406; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ArSzRf3I0l33OFS28JZ6daiy0F4X33j8ikhVLlOoWwc=; 
	b=SMFLTI9eyO8BQiObmhHxwC6d0IJ8fOjLOV9hljzCA882p6puSwPucnIgWbhCsN1a7AygUxEQOd4/1SRXcdPoRdvqCyd1+t6Yp2BUpEU7SQ5zVsom+JP/GlLTLxn/yw8vaPayJgJPNFbpflxhKrjOrqiXuoXCZhbvkFLIIebXKCY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748947406;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=ArSzRf3I0l33OFS28JZ6daiy0F4X33j8ikhVLlOoWwc=;
	b=F0E4IDlEf/bkG2VUfbK+32PbJueZeCXFEGZRPQgmh6CbVDEsuRcDi1Qsz4WnicdI
	+uQ5DhBHOd4fCmTA7B4IUYXS74OLIqPV6XR1faa8uOx5VCFmPIVxSaMYUD7BRhx7frw
	iELAtmt3sKLBBdsgCaS1K/P8LViNBLau9RmYOxSI=
Received: by mx.zohomail.com with SMTPS id 1748947405527168.18325164558655;
	Tue, 3 Jun 2025 03:43:25 -0700 (PDT)
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
Subject: [PATCH v1 1/2] cxl/edac: Fix the min_scrub_cycle of a region miscalculation
Date: Tue,  3 Jun 2025 18:43:13 +0800
Message-Id: <20250603104314.25569-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227aecb809a82e7b789034ee1c9000042afafde908c1560de520b632ee8c6303b15f993738c2ee444:zu080112272c3936a8d64a616a51f2302800009c01008e7c5bbdfe565febfcf4fe5d52640ff6e78faf98e4e8:rf0801122d82dd26ba6d59a3922acbe2bf0000a9e95494c56be44a6b95c51337c1bd5bdf57c30588dff9bd8a0a20b51a77a2:ZohoMail
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
Changes from RFC:
1. Add more description about the max scrub cycle. (Alison)
2. Add more description about the min scrub cycle of a region. (Alison)
3. Drop RFC tag.

base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
---
 drivers/cxl/core/edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 2cbc664e5d62..0ef245d0bd9f 100644
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
+		 * The min_scrub_cycle of a region is the max of minimum scrub
+		 * cycles supported by memdevs that back the region.
+		 */
 		if (min_cycle)
-			min_scrub_cycle = min(*min_cycle, min_scrub_cycle);
+			min_scrub_cycle = max(*min_cycle, min_scrub_cycle);
 	}
 
 	if (min_cycle)
-- 
2.34.1

