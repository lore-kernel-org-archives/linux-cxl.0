Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523F2BCF46
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 06:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156693; cv=none; b=FO9J1FkCeK0P5TK147Aboiw+AsZW8TaUaixWiLEyJpCxEF9kNlJuGDYaszKMlcnFB8AsAS8JvC5usa77KwG1873vtIPOJUnJsvuiR0rAMtcHIkPX0NpGRnu6u00zz8bBs0e1GzDrV5FyogzndHkFFGFsMVyfGUqoW3GVXqbE5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156693; c=relaxed/simple;
	bh=aRoFCzTe2ulb3Kbp24rEmRosHi6WJaEuiV5EJtCpIks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUsQvktDRbBFj+U95WqagnOt4Dg4XwmDri5pGQ5Iyco/PFVT7knpS972R2byzi/IypOG2gcjmdRXeXOntMETRXeKntzUgSiXQJd277nebugc3oDJ0XKnehSJe1/1c3OyTeLtYnpZqm3k05T/CViD9RsWquhipEj4GDTY/VzU6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MIGqfjB6; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MIGqfjB6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788156687; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mE+NzOt+NjDFqX9gVani3KxMAKBxBXKGmxVnK5uhzW4=;
	b=MIGqfjB67Kxgwo2tef0QC4SVzGljluPp8DKVG73+izTHZNOgvI6W1vpyuAQdXDmk6eELRuytX3XfPR3BYyE+oKFshtSdT+aH+WwetUxpMZLR5O02SSqagdreio9B4aI0lh12bROtEVlDTYk8okR/NKPQ0JghvMDCor6TjP+BlZM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9tH81Y_1788156686;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9tH81Y_1788156686 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 14:11:26 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3] cxl/region: Unregister the pmem region when the bridge is unbound
Date: Mon, 31 Aug 2026 14:11:20 +0800
Message-ID: <20260831061120.200790-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing cxl_acpi unbinds the nvdimm bridge before the regions it
serves. A region probe can therefore register its cxl_pmem_region and
only then find the bridge unbound, which leaves the new device with
nothing to remove it.

The orphan outlives the teardown and pins its region and its memdevs, so
a later cxl_acpi bind renumbers the root port, ports, endpoints,
decoders and the memdev.

Unregister the cxl_pmem_region when the bridge is unbound.

Found by code inspection. Racing a cxl_region bind against a cxl_acpi
unbind leaked a pmem_region device on 12 of 12 attempts, and none with
this patch.

Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
Found by inspecting the CXL error paths, then confirmed on a QEMU CXL
topology (4 memdevs behind a CXL switch, one of them with 2G of
persistent capacity).

Test procedure, with a dev_err() temporarily added on the unbound-bridge
branch so that taking it could be observed:

  cxl create-region -d decoderX.Y -m memN -t pmem -s 2G -w 1 -g 256
  echo regionN > /sys/bus/cxl/drivers/cxl_region/unbind
  echo regionN > /sys/bus/cxl/drivers/cxl_region/bind &
  echo ACPI0017:00 > /sys/bus/platform/drivers/cxl_acpi/unbind &
  wait

Without the patch all 12 attempts took the unbound-bridge branch. The
region bind failed with -ENXIO and pmem_regionN stayed registered on the
cxl bus after the teardown had removed everything else, including the
bridge and the region it hangs off, leaving its /sys/bus/cxl/devices/
link dangling into the deleted path. Because the orphan keeps references
on its region and on the mapped memdev, the ancestor chain up to the CXL
root port stayed pinned, so rebinding cxl_acpi renumbered the topology:
root0 became root1, port1 became port2 and mem3 became mem4.

With the patch the same 12 attempts still reach that branch and the bind
still fails with -ENXIO, but nothing is left registered and the numbering
is stable across repeated bind and unbind cycles.

No artificial delay was needed to land in the window. The teardown
releases the bridge first, so it gets there while the probe is still
inside device_add().

v2 -> v3:
- Reframe the changelog around cxl_acpi teardown, which is the reachable
  path, rather than cxl_pmem being unloaded or unbound. The bridge driver
  sets suppress_bind_attrs and cxl_acpi now depends on cxl_pmem, so that
  framing could not happen (Alison Schofield)
- Drop the -EEXIST claim. The leaked device pins the region id, so the id
  is never reused and no duplicate name occurs; the observable
  consequence is the leak and the renumbering after a rebind
- Cut the implementation narration and state what was tested
  (Alison Schofield)
- The code is unchanged from v2, so Richard Cheng's and Li Ming's
  Reviewed-by tags are carried over. Note that the changelog has been
  rewritten since they gave them, in particular the -EEXIST claim above

v1 -> v2:
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

v1 was patch 8/8 of the "cxl: Assorted fixes" series [1]. Per review
feedback that series is not being reworked as a whole; the fixes are
resent individually instead. Patches 1, 2 and 7 of the series are
dropped, as those issues are already fixed in cxl/next.

[1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
v2: https://lore.kernel.org/linux-cxl/20260812061043.57319-1-kanie@linux.alibaba.com/

 drivers/cxl/core/region_pmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
index 23d97e3d78b6..7ab1373a95e0 100644
--- a/drivers/cxl/core/region_pmem.c
+++ b/drivers/cxl/core/region_pmem.c
@@ -168,12 +168,14 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
 		dev_name(dev));
 
 	scoped_guard(device, &cxl_nvb->dev) {
-		if (cxl_nvb->dev.driver)
+		if (cxl_nvb->dev.driver) {
 			rc = devm_add_action_or_reset(&cxl_nvb->dev,
 						      cxlr_pmem_unregister,
 						      cxlr_pmem);
-		else
+		} else {
 			rc = -ENXIO;
+			cxlr_pmem_unregister(cxlr_pmem);
+		}
 	}
 
 	if (rc)

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

