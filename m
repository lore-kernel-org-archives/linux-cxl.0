Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE239FD9;
	Sun, 27 Oct 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015889; cv=none; b=ov1VHicrNJ6Fr1QQ81+WKLu9j215vsIJSdQdlx+D8m8T2jACMXF428LT7AfnpyoI0sQle2ovIIdMlkhZOfjrqAW9Cpe8MxjszMER2lcufy0lvMCetbNNhKVTqtbvsWkl4y8kp4JE8QqD9tDfoBSivuAUAEzUI9VbOWKvzNE0ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015889; c=relaxed/simple;
	bh=D8heilxrwBNBqtWGOdlYvysv+6a/+zwkQs22gXXTAaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DGEGvJFVi5zpa6mqORp6E7bMnEnzanQwUqITpwyD4/CZphkRRzkwAxA3/RckSMt7yHD63ow8Wt0wSJwfJCJYP1qrlGWXdM8c+xFvrj+QJIgw+Dy02zqgpY+BRlWxtBdKdekrmE2V9cBv2jhG6TzxUYgLb/1ZJGuQf1qEy40cnqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V15x4ptw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V15x4ptw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730015886; x=1761551886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D8heilxrwBNBqtWGOdlYvysv+6a/+zwkQs22gXXTAaI=;
  b=V15x4ptwowmscYFwKnQ0Uzyv5pa1oT7KjiOT9XqY9/WyQNfLswaNPqO4
   jmIY97IX85uNGSZRbTqpaMQUp7OvyuV9Vu/n7/M8RVWei5uLYmKZoWciy
   IbbjuMhmxmusqJCMVLOq/JIqJMC3Ho5WcwCasFte8U1anOjPdxjauOJci
   sEWiFWjUeh5VJkQCu3vTeyMPuLTGKmQplc8HYL3rHF71Wsuvw1MmU9CBH
   yXJgX3GDag57PqlTw7JUgIz40hC3TyFjRaEP/gS8u/fQr//embKYAQij8
   CW+WYBF9hUgG213qcEJstL0D0KwjRMGIXyWq9Sw5q8HZK7ipmVoh3I90m
   A==;
X-CSE-ConnectionGUID: 0v6iC9G2T8mTpjkvjL1s8A==
X-CSE-MsgGUID: Fou5him9STyD2l0xa4rwRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="41033994"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="41033994"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 00:58:06 -0700
X-CSE-ConnectionGUID: c7eGueviT3uRDiIjBFG3xA==
X-CSE-MsgGUID: JbuLpqg2TfOAfZSNiJRAaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="81477242"
Received: from unknown (HELO ixc04.bj.intel.com) ([10.238.153.130])
  by orviesa006.jf.intel.com with ESMTP; 27 Oct 2024 00:58:04 -0700
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org,
	pei.p.jia@intel.com,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH] [RFC] cxl/region: Fix region creation for greater than x2 switches
Date: Sun, 27 Oct 2024 15:57:17 +0800
Message-Id: <20241027075717.3714821-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fix the method to calculate @distance by iterativeley multiplying the number of targets per switch port. This also follows the algorithm recommended here [1].

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Link: http://lore.kernel.org/6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch [1]
Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>

---
 drivers/cxl/core/region.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e701e4b04032..9e226a293f45 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1288,6 +1288,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *iter = port;
 	u16 eig, peig;
 	u8 eiw, peiw;
 
@@ -1304,16 +1305,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
-		int i, distance;
+		int i, distance = 1;
+		struct cxl_region_ref *cxl_rr_iter;
 
 		/*
-		 * Passthrough decoders impose no distance requirements between
-		 * peers
+		 * Get distance from the number of distinct targets in region's
+		 * interest and the ancestral nr_targets.
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
-- 
2.39.3

