Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FC44C7C;
	Sun, 23 Mar 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742722428; cv=pass; b=qg3vLk+ddBP+TPmjDN4/BADnYK41tO27Ns2VrMFB+6uqWRAl0QHC3TWrYQoBr3i9Z8g3ugKBHetZAFGAWk1wzFOeIMv/8PxMUNRzli8jdSLODNbP327O8ueMWgfYmEyGag/rndG+G2kX0tatCh91wGtyMVv+D+gc+EIa5xw7NFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742722428; c=relaxed/simple;
	bh=8jeaP+MWD2tgRl9NLRwGHRLuRzce6k/ACt8lN+rLuvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYpLOC4do11nJujAUMBoI5UO22xwYOBCe2aGCJD8+oQOWM2C6do+FVl3d0QkNztU0rGqagZrzrDeU3hDWoVoM9pJbWpzVA2XY8IMFzr4mZFlnyF8AnZ08skxQOpXsqmTl7K2t5sUyUQUotu/znQdDpeCj4AYl9jImvJwJDrJEBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=MtW90Xl1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="MtW90Xl1"
ARC-Seal: i=1; a=rsa-sha256; t=1742722291; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U4BqNczMHMF8stiLx9OjD1tAK/PAbEmf8GMsN/4e8fhyQKKpd4mV+bQQTONEs70WVglwi2h5vmVl/sAl2oRCgNW3LovMSIfOWdk479VpnoNIX6rAirjHYr9DEw3CbGcK504w2n3QEa7f0z2I6dHlkK0VFY/f6midUbVFS0+U9M4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742722291; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sHzVg5jAvTvlsVsN9qhuPuY+nmgFsZiFexjCim3EX2s=; 
	b=KzAIQfxkuzO9csLzEljHI4Bo0tWLAJPiYvgUOCEcNZGvsxZfR4/G+iv6muU/NRAKAZTVNXBNmscM219J3kHwdwVCMzgteYO1iDhZDHQ1ViCTctgqfnTT8gcL/CTIJlnnFDHIjcJYCc0flacTQT/v5Up+fBkUICxRQIBjJk9s5iM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742722291;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=sHzVg5jAvTvlsVsN9qhuPuY+nmgFsZiFexjCim3EX2s=;
	b=MtW90Xl1iJGpoTZJZWuwlLgHQmR/K9Qzp/dtXxjm5YBOLj0AxlkVDLctYD+pYHUF
	n1oxyBwvTJrpfeW8wbnDr/WZyOofHbfwi9izaIiEoUMnSfzAJqqkDJ/zLdfxaEuvQeX
	roTEDhxl3w6VsVKH+KzSy+sZpUrf88Zj7cW18QCw=
Received: by mx.zohomail.com with SMTPS id 1742722290465787.3206155303363;
	Sun, 23 Mar 2025 02:31:30 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 0/3] Fix using wrong GPF DVSEC location issue
Date: Sun, 23 Mar 2025 17:31:07 +0800
Message-Id: <20250323093110.233040-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112279cd3ea6009e317a589a172d400001df68938294a4cb517f7e72e810861307d513f365bf43b19bb:zu08011227a4438750858dcd53daab071e00004827cbb948a4535bffbc4e6da2705707098c4048aa9f498c9a:rf0801122d70d473059eefbebc9629feaa00000b7722115daa8f4d196100cbf51c196b17e4fa5c10dd323800fe318cf1a9be:ZohoMail
X-ZohoMailClient: External

During review all new patches in branch cxl/next. I noticed there may be
a problem in below commit.

commit a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")

There is a new field gpf_dvsec in struct cxl_port to cache GPF DVSEC for
Port(DVSEC ID 04h) location. When the first EP attaching to a cxl port,
it will trigger locating GPF DVSEC on the cxl dport which the first EP
is under, then the location is cached in port->gpf_dvsec. So if another
EP under another dport is attaching, it will reuse the value of
port->gpf_dvsec as GPF DVSEC location for this another dport. The
problem is the cached location may be a wrong location for other dports
of the port.

Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, Each
CXL Downstream switch ports and CXL root ports have their own GPF DVSEC
for Port(DVSEC ID 04h). So my understanding is that CXL subsystem should
locate GPF DVSEC for Port for each dport rather than using the cached
location in CXL port.

base-commit: 3b5d43245f0a56390baaa670e1b6d898772266b3 cxl/next

v2:
- Drop RFC tag.
- Add Fixes tag to patch #1.
- Pickup reviews.
- Add tested by Davidlohr.
- Adjust the changelog of patch #2.(Davidlohr)
- Fix typo issue in patch #2.(Davidlohr)

Li Ming (3):
  cxl/core: Fix caching dport GPF DVSEC issue
  cxl/pci: Update Port GPF timeout only when the first EP attaching
  cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()

 drivers/cxl/core/core.h |  2 +-
 drivers/cxl/core/pci.c  | 30 +++++++++++++++++-------------
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  6 +++---
 drivers/cxl/pmem.c      |  2 +-
 5 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.34.1

