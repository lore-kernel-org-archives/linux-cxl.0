Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6D2E847
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479673; cv=none; b=SSdh0zm/XaiHgGnoNi2jAleNGa4aBGmI9ov2wAgQvUQ0Q6kMgOqox40RgOSbU4YrPJOHV7DMCZ4H0oV0kCUd3ZdYh+Xnj25EC+NzCDBWeHQjsQtg/0092EyYO1lzndhYGj8xG1Sr7PywgIJgwjUSk0MdglFFBDBRIWY88jbzYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479673; c=relaxed/simple;
	bh=XoWz/xDITxz/TTRZGqnkPOs6y2KW9/A4GSpdl/TiHjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g7GTyPDOvJaBh5jCJ3SS4E1lnSudh3/f0a4N+XRH6e4Kt+3yAAaOAw+tUtEePQdH1h4Wtz+1U6bnbc79YbSckWQJAM32DjJoAH4r1R9v1Y/m5S1uTWkULIdpdywuGK516Xo7rNyqPVcdakxz2kOhpzbFcCu2cgRlWQ+KnW7Gl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=V0W75jtA; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="V0W75jtA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479671; x=1739015671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XoWz/xDITxz/TTRZGqnkPOs6y2KW9/A4GSpdl/TiHjQ=;
  b=V0W75jtAl+d3s/8M+4N2Y92P5jETeDkfs9AOve9CGjmVXYvR/wDwKWSF
   JYt/p0SfSS3S8pPTfDx9I4ZQ+fldNg+7SobW982C8yDAwfq5iQLewy686
   uvZ7K34iq7GpyDC4GD+1epXgGXh2viaYvUmXmj6iXTekzGT9MfoBP9jbn
   4aVQxAJZ1WzZXVDsq1AU9CJTWIAMhrSAAeOdo1GI9QZrC3FtZ7i1iRQKt
   UYzuW7UyJslm03bnV5f1UWhq4L5TUmKJ3efpdlFxU4eyS0U3RTpB98D1x
   cEFSE4+cmQHk1SET8kqV+hZExm14py/EqS28q9ssy88/emNWfP7UAZ/E3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="137381733"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="137381733"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:21 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E79BC14A228
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DCC6D1F73B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 70F2520097CE7
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:18 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B72A01A006A;
	Fri,  9 Feb 2024 19:54:17 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH SET] cxl: add poison event handler
Date: Fri,  9 Feb 2024 19:54:10 +0800
Message-Id: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--8.310200-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cPvjhWxSrUkKRFbgtHjUWLy/OuUJVcMZhsIdsUH0fXfURCc
	5GBROM2VCuUOawo+L53x0YmcL/AjYyWfqL2WP1wRWFHKJ2wSViQXivwflisSrDABh2rVVNejLXk
	gVQ0v4RO75T5NVSKqdYAy6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuDGrCD/Q6EU/+EB
	l7sckhDbfxLhB3CJZGLzsNEGymi1XrpcchznD6Bw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Currently driver only trace cxl events, poison injection on cxl memdev
is silent.  OS needs to be notified then it could handle poison range
in time.  Per CXL spec, the device error event could be signaled through
FW-First and OS-First methods.

This draft patchset adds poison event handler in OS-First method:
  - qemu:
    - CXL device report POISON event to OS by MSI by sending GMER after
      injecting a poison record
  - CXL driver
    a. read the POISON event through GMER;
    b. get POISON list;
    c. translate DPA to HPA;
    d. construct a mce instance, then call mce_log() to queue this mce
       instance;

This patchset includes 2 patches for qemu, 5 patches for cxl driver.

Shiyang Ruan (5):
  cxl/core: correct length of DPA field masks
  cxl/core: introduce cxl_memdev_dpa_to_hpa()
  cxl/core: introduce cxl_mem_report_poison()
  cxl/core: add report option for cxl_mem_get_poison()
  cxl/core: add poison injection event handler

 arch/x86/kernel/cpu/mce/core.c |  1 +
 drivers/cxl/core/mbox.c        | 82 +++++++++++++++++++++++++++-------
 drivers/cxl/core/memdev.c      | 16 ++++++-
 drivers/cxl/core/region.c      |  8 ++--
 drivers/cxl/core/trace.h       |  6 +--
 drivers/cxl/cxlmem.h           | 11 ++---
 drivers/cxl/pci.c              |  4 +-
 7 files changed, 97 insertions(+), 31 deletions(-)

-- 
2.34.1

