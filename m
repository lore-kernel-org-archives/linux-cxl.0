Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34912773D8;
	Sat,  6 Jun 2026 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780732309; cv=pass; b=ItCsV+rgnSCOkryHTqiKN1/5ebjceK6JlpIbA7ZB7UcT+JQP2mlKZD0bPFgj3cWEUeC47me5QHz0LUMM+hwM/SihSWId0noCRecNnDVMo1yNNhC/N0T03OoRPMKZ5r1ncw4JJ3vxaY7/Kzvn//4vchsjFbYyTZIdAwSrs+E0HJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780732309; c=relaxed/simple;
	bh=DlzP5BqjjlU5vKX4n21H/XoZ6pfjCyyvEGq8JuLlumM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5hzulz/i7ojGx3kDeClnqgM11wj18Iv+1yxsMiET94iBFIN0M/j8+20/tv+/4zRgJmE5edmqXqzNnq6tDTLKJ3tmKe62DnjG+IojKUIxycIzGRkYl3BnFxb7vvVHtUhlz9lK2CejtWqrx2/SWdFEqHqIcXsg8hqBZbGVcsYBlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Gs5Hjq2t; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Gs5Hjq2t"
ARC-Seal: i=1; a=rsa-sha256; t=1780732299; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OOwEmYvKek3uBOhVzltpsNvn1onlU8whrQPCs8jD6jZ4uYL8CCNggmtwPEeKSQQ/EgGgYJmXOSZ3BJdSUFMxzsnqdr21n1/8ucdbk1qu/YzyOTvvCR6f2XrI11/xjPs/cQr1rHcBIKkZSgDALlaaOzu4h8JDgR9FarMfx6dpUig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780732299; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FRyCdlku698Jfqxqbz1V8T61whr1uWT03r0TytHkJ2c=; 
	b=Rihnky5SBBG/8jc/aTI08EhBZfitT2b4KAdI8DpDLDPd6eFZ6k/XOda8owV0KnezpSkpNoNv9HVh4MA9fSG0EbsX0LdRGi5dPoRqn/0kBfgK28Lr5Ztv1YO5aFhEDs/3a4B8WFInoBgQSU+Q2ODsaOuXwll/is0GiZa121B7T84=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780732299;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=FRyCdlku698Jfqxqbz1V8T61whr1uWT03r0TytHkJ2c=;
	b=Gs5Hjq2tK2kJlAkyfdbcrE8jkU4/HcYozdo7FAWFbKnV0vwhVOcTy/MNpNEPESiZ
	aY7+oXvQPGOUIy2UdHW/O4FqlRa3OfWiDFH3NOT0W3AWEtWyfbRLHkBswZ0Y3QPM25Y
	ZJPMBqNiHOm91mFFjZ1byH45nnKp7Qw7AruJ6DFk=
Received: by mx.zohomail.com with SMTPS id 1780732296907272.6205441834147;
	Sat, 6 Jun 2026 00:51:36 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 06 Jun 2026 15:51:01 +0800
Subject: [PATCH 2/2] cxl/region: Fill first free targets[] slot during
 auto-discovery
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-2-5d94ca06c4e4@zohomail.com>
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
In-Reply-To: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780732288; l=3776;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=DlzP5BqjjlU5vKX4n21H/XoZ6pfjCyyvEGq8JuLlumM=;
 b=Sir2tbujsIf+TTfJ+VrlANuJ2h7euKgdJnfB4c8H5l0Ixx5JZSwJGQPEeXAhCmKLUUdWStH9o
 fehSgyvQxKKDm3YpIId2OYNj3xuM9GbnKouFv9+v44NECSeykCp+ULt
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: zu080112274271da52080df1b600dee8540000fa3b085b389673256862a2175d82bb7a34e2ad014b9be937ab:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

Any invalid endpoint decoder pointer in the target array of an active
region is not allowed by cxl driver. This means cxl driver always
assumes the first p->nr_targets entries of the target array in an
auto-assembly region are valid. However, there are scenarios that could
leave NULL endpoint decoder pointer holes in the target array.

1. When cxl_cancel_auto_attach() removes an endpoint decoder from a
   target array, the target slot is set to NULL. If the removed endpoint
   decoder is not the last element in the target array, the target array
   will contain a NULL hole.

2. When a auto-assembly region removes an assigned endpoint decoder, if
   the removed endpoint decoder is not the last element in the target
   array, always remains a NULL hole in the target array.

When a NULL pointer hole exists in a region's target array, it
introduces two potential problems:
1. Access an endpoint decoder via a NULL pointer. it always trigger
   calltrace like that.
    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN PTI
    RIP: 0010:cxl_calc_interleave_pos+0x26/0x810 [cxl_core]
    Call Trace:
      <TASK>
      cxl_region_attach+0xc50/0x2140 [cxl_core]
      cxl_add_to_region+0x321/0x2330 [cxl_core]
      discover_region+0x92/0x150 [cxl_port]
      device_for_each_child+0xf3/0x170
      cxl_port_probe+0x150/0x200 [cxl_port]
      cxl_bus_probe+0x4f/0xa0 [cxl_core]
      really_probe+0x1c8/0x960
      __driver_probe_device+0x323/0x450
      driver_probe_device+0x45/0x120
      __device_attach_driver+0x15d/0x280
      bus_for_each_drv+0x10f/0x190

2. Not having enough valid endpoint decoders attached to an
   auto-assembly region. if an auto-assembly region is created with lock
   flag or assigned endpoint decoder with lock flag, which means
   assigned endpoint decoder will not be reset during detaching, they
   could re-attach to the auto-assembly region again. But cxl region
   driver relies on p->nr_targets to verify whether the required number
   of endpoint decoders has been attached, and NULL endpoint decoder
   pointers are still counted in that case.

To fix above issues, adjust cxl_region_attach_auto() logic to find the
first free target slot for endpoint decoder attachment, this ensures
NULL holes in the target array are filled, rather than adding new
endpoint decoders at the tail of the target array.

Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c4335ebf19f7..532dac77bd00 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1848,8 +1848,21 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
 	 * this means that userspace can view devices in the wrong position
 	 * before the region activates, and must be careful to understand when
 	 * it might be racing region autodiscovery.
+	 *
+	 * The endpoint decoder will be recorded into the first free slot of
+	 * the target array.
 	 */
-	pos = p->nr_targets;
+	for (pos = 0; pos < p->interleave_ways; pos++) {
+		if (!p->targets[pos])
+			break;
+	}
+
+	if (pos == p->interleave_ways) {
+		dev_err(&cxlr->dev, "%s: unable to find a free target slot\n",
+			dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
 	p->targets[pos] = cxled;
 	cxled->pos = pos;
 	cxled->state = CXL_DECODER_STATE_AUTO_STAGED;

-- 
2.43.0

