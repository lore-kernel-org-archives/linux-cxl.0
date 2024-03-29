Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3B8BFC
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694189; cv=none; b=hR0CZhokVOTUbEeLTEJK9MpT6FO25NiKzpoqiqdlfq5g9nz1cPx9etFf5eNwmwOclbhg4X2LDjjeAwooJWEHqYBnxRK1RG502Yln2hBW0yRKoT0qpdZQNkxvtBCwMVKd1/WsTOrIBu5+TZDk7SOoZXR/nFXLuVgOwUcGJMhcnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694189; c=relaxed/simple;
	bh=OV3u9PFPBxcZetPCHjdd1JxSRP+skqDSB/QGdHY7BKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YDhqyaZR8uC83EFl1aPpeUJV+AC3dwB0p2r8l5FMSgpIGtqFrUe2FMMXFUit6launBoLzi67eW4Cr3nPu49+yzrjje7l5qCRc3hTelQN0zig5pM3Jt3FNrMWM6aCHYyXwUwsUq92YzJUVxscO82KKRV0CG70wNxU+Ovo7CHhoio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PxLuHkyx; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PxLuHkyx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711694186; x=1743230186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OV3u9PFPBxcZetPCHjdd1JxSRP+skqDSB/QGdHY7BKc=;
  b=PxLuHkyxcOvnUoG5VE8S/Sdj4fifbXWsYJurPWpvPo4YK+wVUm0asoq6
   GDSDdZL74/sWLh743QpFTRj9aQPfxfUJ3q4C7DxqJFQN9K0ZUjKQOvJ9w
   ah9CB0yXgZmoqfH7NMmpThbGbaaMutDavu2rqonyncosOyciuptOwKEu/
   rDnvr4c5o1G/COtJtrcTtjmkdtStUK+a5aRnAC8KYzR6ZZjX3JC1o5+Hm
   L0gXE7IHDcXLRYciHIZnn5TZcahfuFGTIvdYrfmHd5YVABStDFsaV2rOa
   HBAt3UizuA+Fr5D3DY9nT2BaK9Q6qtFpEjZzxKTuHQmN2RgBsVNpr/Uzf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="141726392"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; 
   d="scan'208";a="141726392"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 15:36:18 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id B0630DCC01
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DD30D106085
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 70451200A7F0B
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 15:36:15 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 966DE1A006A;
	Fri, 29 Mar 2024 14:36:14 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com
Subject: [RFC PATCH v2 0/6] cxl: add poison event handler
Date: Fri, 29 Mar 2024 14:36:08 +0800
Message-Id: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10--8.993200-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cMkinkyECdW8xlxrtI3TxRk1QQ6Jx/fflb+Aw16GgqpO0+j
	bx0gEqGpOQhWysfkZ0EbNNo/4MUKcPGCAvUPDMAJqhcdnP91eXGlLADMASK8x0+z00/C4DjDQiM
	ingSlKoK4W6HEaP3gfW9yZj3aufb5HxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwTpZBKtCN9kSuD0
	NYznv/PLajWsk6DUHUm+9cshTl/b5FHiGvOIOu1w==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Changes:
RFCv1 -> RFCv2:
1. update commit message of PATCH 1
2. use memory_failure_queue() instead of MCE
3. also report poison in debugfs when injecting poison
4. correct DPA->HPA logic:
     find memdev's endpoint decoder to find the region it belongs to
5. distinguish transaction_type of GMER, only handle POISON related
     event for now


Currently driver only traces cxl events, poison injection (for both vmem
and pmem type) on cxl memdev is silent.  OS needs to be notified then it
could handle poison range in time.  Per CXL spec, the device error event
could be signaled through FW-First and OS-First methods.

So, add poison event handler in OS-First method:
  - qemu:
    - CXL device report POISON event to OS by MSI by sending GMER after
      injecting a poison record
  - CXL driver                                  <-- this patchset
    a. parse the POISON event from GMER;
    b. retrieve POISON list from memdev;
    c. translate poisoned DPA to HPA;
    d. enqueue poisoned PFN to memory_failure's work queue;


Shiyang Ruan (6):
  cxl/core: correct length of DPA field masks
  cxl/core: introduce cxl_mem_report_poison()
  cxl/core: add report option for cxl_mem_get_poison()
  cxl/core: report poison when injecting from debugfs
  cxl: add definition for transaction_type
  cxl/core: add poison injection event handler

 drivers/cxl/core/mbox.c   | 126 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/core/memdev.c |   5 +-
 drivers/cxl/core/region.c |   8 +--
 drivers/cxl/core/trace.h  |   6 +-
 drivers/cxl/cxlmem.h      |  13 ++--
 include/linux/cxl-event.h |  17 ++++-
 6 files changed, 144 insertions(+), 31 deletions(-)

-- 
2.34.1

