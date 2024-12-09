Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D519B3EE
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787192; cv=none; b=NFfWR7+kkp6gdKlDfuTr3waQNDC9eXoY6vP9mhO149XROGIYRiEPpN2Ob5G8ZjCAgAlpn0h/94JE+pOF1gyc92tX1vmTgzsGt6AtsN81Ne3imhu2OvtGtxZCD8G38BR8Ph29/a4o6VUZ3I0mMULROH4c0F5J8ndi2ibFud9rIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787192; c=relaxed/simple;
	bh=8F86IZ34mf3V4v566o3e/6t4tcXDheRg0PxHZgJj0bQ=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=UNg1Wz+zGF3soXK1Bg4uDt7CsuImmoQC7F8kPKLswmZE0bTnJMXW2bSql7m+O3VIkwpygfFChWxtbP4LLGQOHpY2yBY+2Fq+yQI1G2h4XiPsZgNOCG53mLejxO9IPXgIgwURI04RPZszO2rpWWPopzQX3hnGTa29OSRZJsVUa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEn/erCL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEn/erCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733787190; x=1765323190;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8F86IZ34mf3V4v566o3e/6t4tcXDheRg0PxHZgJj0bQ=;
  b=EEn/erCLELx/2NyiC0FdpQgE/GULNIe7r/SRK8su/ts8bD757k8/9bM3
   yP71rbveoKlP+Jn+InPHH0PKBh282nEIZCRwZ1kxWSnmmKmRadRBr9O9J
   sl/6Y1LTiiuTk1pBVJ2lT5FIGvl7ip9w3/bTUhGqC5ygI3fuAUKcEovJK
   Ckccre7RtwO42tF1avLNa3QAZwPu5qgGJeSfDFVSFutMQqgcQOx5mxYP2
   +UNipD+D5iaeE3DlQ0zB+7brqUhYcLwfNaCWmRLMypp9iqk0VEFbc/XDK
   /7YY/rP9+UwTwTMIZc0oeGmdYPDGp/Z2jMZHlFtu8iGBJ8FcgV2iIkSBn
   A==;
X-CSE-ConnectionGUID: 0dFHJlY0QLCuLX6JKxv6Sw==
X-CSE-MsgGUID: w+RXb4SoTF+EjKUxxvd8jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="51523221"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="51523221"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 15:33:10 -0800
X-CSE-ConnectionGUID: Y8p3jMPSRwq3MH2QDDsf2w==
X-CSE-MsgGUID: OHKNdm34QlKh9n2Lpy0UAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="95565956"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.118])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 15:33:03 -0800
Subject: [PATCH v2] cxl/region: Fix region creation for greater than x2
 switches
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: Huaisheng Ye <huaisheng.ye@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 linux-cxl@vger.kernel.org
Date: Mon, 09 Dec 2024 15:33:02 -0800
Message-ID: <173378716722.1270362.9546805175813426729.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Huaisheng Ye <huaisheng.ye@intel.com>

The cxl_port_setup_targets() algorithm fails to identify valid target list
ordering in the presence of 4-way and above switches resulting in
'cxl create-region' failures of the form:

  # cxl create-region -d decoder0.0 -g 1024 -s 2G -t ram -w 8 -m mem4 mem1 mem6 mem3 mem2 mem5 mem7 mem0
  cxl region: create_region: region0: failed to set target7 to mem0
  cxl region: cmd_create_region: created 0 regions

  [kernel debug message]
  check_last_peer:1213: cxl region0: pci0000:0c:port1: cannot host mem6:decoder7.0 at 2
  bus_remove_device:574: bus: 'cxl': remove device region0

QEMU can create this failing topology:

                       ACPI0017:00 [root0]
                           |
                         HB_0 [port1]
                        /             \
                     RP_0             RP_1
                      |                 |
                USP [port2]           USP [port3]
            /    /    \    \        /   /    \    \
          DSP   DSP   DSP   DSP   DSP  DSP   DSP  DSP
           |     |     |     |     |    |     |    |
          mem4  mem6  mem2  mem7  mem1 mem3  mem5  mem0
 Pos:      0     2     4     6     1    3     5    7

 HB: Host Bridge
 RP: Root Port
 USP: Upstream Port
 DSP: Downstream Port

...with the following command steps:

$ qemu-system-x86_64 -machine q35,cxl=on,accel=tcg  \
        -smp cpus=8 \
        -m 8G \
        -hda /home/work/vm-images/centos-stream8-02.qcow2 \
        -object memory-backend-ram,size=4G,id=m0 \
        -object memory-backend-ram,size=4G,id=m1 \
        -object memory-backend-ram,size=2G,id=cxl-mem0 \
        -object memory-backend-ram,size=2G,id=cxl-mem1 \
        -object memory-backend-ram,size=2G,id=cxl-mem2 \
        -object memory-backend-ram,size=2G,id=cxl-mem3 \
        -object memory-backend-ram,size=2G,id=cxl-mem4 \
        -object memory-backend-ram,size=2G,id=cxl-mem5 \
        -object memory-backend-ram,size=2G,id=cxl-mem6 \
        -object memory-backend-ram,size=2G,id=cxl-mem7 \
        -numa node,memdev=m0,cpus=0-3,nodeid=0 \
        -numa node,memdev=m1,cpus=4-7,nodeid=1 \
        -netdev user,id=net0,hostfwd=tcp::2222-:22 \
        -device virtio-net-pci,netdev=net0 \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
        -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
        -device cxl-upstream,bus=root_port0,id=us0 \
        -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
        -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-vmem0 \
        -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
        -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-vmem1 \
        -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
        -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-vmem2 \
        -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
        -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-vmem3 \
        -device cxl-upstream,bus=root_port1,id=us1 \
        -device cxl-downstream,port=4,bus=us1,id=swport4,chassis=0,slot=8 \
        -device cxl-type3,bus=swport4,volatile-memdev=cxl-mem4,id=cxl-vmem4 \
        -device cxl-downstream,port=5,bus=us1,id=swport5,chassis=0,slot=9 \
        -device cxl-type3,bus=swport5,volatile-memdev=cxl-mem5,id=cxl-vmem5 \
        -device cxl-downstream,port=6,bus=us1,id=swport6,chassis=0,slot=10 \
        -device cxl-type3,bus=swport6,volatile-memdev=cxl-mem6,id=cxl-vmem6 \
        -device cxl-downstream,port=7,bus=us1,id=swport7,chassis=0,slot=11 \
        -device cxl-type3,bus=swport7,volatile-memdev=cxl-mem7,id=cxl-vmem7 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=32G &

In Guest OS:
# cxl create-region -d decoder0.0 -g 1024 -s 2G -t ram -w 8 -m mem4 mem1 mem6 mem3 mem2 mem5 mem7 mem0

Fix the method to calculate @distance by iterativeley multiplying the
number of targets per switch port. This also follows the algorithm
recommended here [1].

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Link: http://lore.kernel.org/6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch [1]
Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
[djbw: add a comment explaining 'distance']
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since the RFC [1]:
* add a comment to clarify what 'distance' represents (Li Zhijian)

[1]: http://lore.kernel.org/20241027075717.3714821-1-huaisheng.ye@intel.com

 drivers/cxl/core/region.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 70d0a017e99c..30ac76df9cba 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1295,6 +1295,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *iter = port;
 	u16 eig, peig;
 	u8 eiw, peiw;
 
@@ -1311,16 +1312,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
-		int i, distance;
+		int i, distance = 1;
+		struct cxl_region_ref *cxl_rr_iter;
 
 		/*
-		 * Passthrough decoders impose no distance requirements between
-		 * peers
+		 * The "distance" between peer downstream ports represents which
+		 * endpoint positions in the region interleave a given port can
+		 * host.
+		 *
+		 * For example, at the root of a hierarchy the distance is
+		 * always 1 as every index targets a different host-bridge. At
+		 * each subsequent switch level those ports map every Nth region
+		 * position where N is the width of the switch == distance.
 		 */
-		if (cxl_rr->nr_targets == 1)
-			distance = 0;
-		else
-			distance = p->nr_targets / cxl_rr->nr_targets;
+		do {
+			cxl_rr_iter = cxl_rr_load(iter, cxlr);
+			distance *= cxl_rr_iter->nr_targets;
+			iter = to_cxl_port(iter->dev.parent);
+		} while (!is_cxl_root(iter));
+		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+
 		for (i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,

