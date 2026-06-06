Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CAB26A08A;
	Sat,  6 Jun 2026 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780732299; cv=pass; b=rZ50xRcZonrW2sl9/M4bWPkVxotqSKGnIwQFaqN0DUUY9tbBh0Kwd8DCyMjDDLQuT2zbctIyiOekLmv/q8EMtoqXOIb3y28G4XvUz7tsRU1CnTwz99hqDeH9MThRgXmI9hrG//bpqUQbpu0R8rkVB3OwrMuWrghRhdinBxU3tQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780732299; c=relaxed/simple;
	bh=fCrWzVfgo7b+dQu0uIZyRPfOEuYxmdy3dhwU10MtZE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sjq4M9OaVrl78MPd7byQO8L07FbiDLhqatj6I3h7tqdnCHispMsCm+xT2bZfdFM8vWcRE6E/VHBiHdf04q9odl3IoEUGH8E0iO992fBry8SK6mP8agxi9zgtvojsu5eWkOIRMLR0/gihziFwbJEjITFddVnqBqfmUjKFiODi/4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Fo45Ezt0; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Fo45Ezt0"
ARC-Seal: i=1; a=rsa-sha256; t=1780732293; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Anc7G3IaxQKPiVNT3+4lEAOkk/ndjXFGYuHxl4QTeZMjNmNW5ebPiPV5OZvh0KADlCJELETxvBjlREkyzzwqTkYZEkjFmcU/wjyOc5k0ilhDS+kKYQ9knMwPhcNWjpjxaqzkParU0mRQCTvTB4F1yNlCpf/Vbuq3NvPpuqPtSfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780732293; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=huNdBBJgwSSKU/TONAlpEvDTVsm/VMEu6t/cT25utbw=; 
	b=TkhN387ING+g1KEmwdPykU2PagHXF7rvMBrft0IE9vWHQmSBSBM2PiGXqaANK7dMvrckJQ6FXDygCWVGBljlvAIiAvCxPnt0PSX0/TcCU1ewapGdeIIpDG9PnvjqgTxvThwynWNWvXFf16DEAAmMbLvIJ8BKDAirN5f2nUaWvmc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780732293;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=huNdBBJgwSSKU/TONAlpEvDTVsm/VMEu6t/cT25utbw=;
	b=Fo45Ezt0wX/av0X97oN272Dj/ZLdbWuOT0m7dnzIZdF/1lCA0FuQxAu+Qdsu5W2Z
	AmXwBvELFUEKruAY/r4qbYTCCK0lcBQWbljgKjYDtGVmk4kGGGElYGhVUDOVsHkM4wo
	ukAJzmRPmbFGHMxYRS+giHhXioyJHGpRUT7UfySE=
Received: by mx.zohomail.com with SMTPS id 1780732291030737.946463374025;
	Sat, 6 Jun 2026 00:51:31 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Subject: [PATCH 0/2] cxl/region: Fix two decoder attach/detach issues for
 auto-assembly region
Date: Sat, 06 Jun 2026 15:50:59 +0800
Message-Id: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTRI2oC/x2NQQrDIBAAvxL2XCGVYKBfKWWx69osBC2utikhf
 4+UOc1lZgflIqxwG3Yo/BGVnLpcLwPQ4tOLjYTuYEfrxo6JsmH9ZhTVxoqSasmhEQd8/pC2Fck
 n4hV9qxl9rZ4W46yb4xQDsZ2hl9+Fe+Z/vT+O4wS2sV+OhQAAAA==
X-Change-ID: 20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-6267f4fdce27
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780732288; l=1977;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=fCrWzVfgo7b+dQu0uIZyRPfOEuYxmdy3dhwU10MtZE4=;
 b=6lR/yqd7sDMxxrI+eVSndVTVnK3nBrThtsegyyHny3v/KsQfWPR2nS54XHYbLlI6FBQSp9R1d
 fKEv8nzKeOBACZEZK2uFiL2jG3eTVvFluyInjI3YwidGaoOyDJqKB2t
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: zu08011227c031c2f29f2799c2048ea5fd0000b719a94c0174692ff86da999cbd2ab4822f3d6ad59b466424c:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

This patchset includes two fixes for endpoint decoder attach/detach for
auto-assembly region.

Patch #1 fixes OOB access in cxl_cancel_auto_attach().

Patch #2 fixes NULL endpoint pointers hole in p->targets[]. CXL driver
does not allow any NULL pointer hole in p->targets[], it will cause
NULL pointer dereference issue. However, if an assigned endpoint decoder
is removed from an auto-assembly region, it could make it happen.

The following operations can always trigger NULL pointer hole issue.
Precondition:
an auto-assembly region with LOCK flags or its assigned endpoint
decoders with LOCK flags. This means these assigned endpoint decoders
could be re-attached to the region after being detached.

echo {one of cxl pci BDF} > /sys/bus/pci/drivers/cxl_pci/unbind
echo {one of cxl pci BDF} > /sys/bus/pci/drivers/cxl_pci/bind

it will trigger the NUll pointer dereference issuse fixed by patch #2.

Note: Patch #2 only fixes NULL pointer dereference issue, re-attaching
a removal endpoint decoder to the auto-assembly region still fails
with the patch, because there are other issues blocking re-attachment
flow. One of them is that re-attachment will trigger calling
cxl_region_attach_position() for each targets in p->targets[] again, but
the function fails on the targets which have been attached. I am not
sure whether re-attachment is a valid user usage, if yes, I will work on
that later.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
Li Ming (2):
      cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()
      cxl/region: Fill first free targets[] slot during auto-discovery

 drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 22 deletions(-)
---
base-commit: a1516711b95490ad6c9f05b61500e73d4f603d28
change-id: 20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-6267f4fdce27

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

