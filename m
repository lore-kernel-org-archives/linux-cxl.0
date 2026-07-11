Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F9B125A0;
	Sat, 11 Jul 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783730048; cv=none; b=Xj8Ti6QGNCM7OrALRzJaC8oxqK+s7xtHMYcCgzpL0U9kHMboOQIcCvnFtmSFKYmsREmy0vSOtvIYbX7L7vzHVZtKHeRzgGX5LoozelJ2iBT8JTtqf9FFhaKdhY1HWemSl4bOTtDJOP8U8A1mp6PJwG+QLsCA6lUDQ4qgL3B4U8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783730048; c=relaxed/simple;
	bh=T4g57BVmcBiveivtaIr36Ax/6i4+NqV3IpEDZGPxnCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WBaNJ7S25ZGvhqn1EWaybfivKbBB9CnHiU52GJJ29RPL8YzVadsIPziDIAGZQ9nxbHvZqvAF4Nx5h2R23e8e/ufo+BHUrt99NmW498S1SNHP4PnXcSxgoDWgvV+WuC9j/rm6uYBsaAFZTS6k1FCuISP/t/n+siIuKsVSfs9YDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WMohM/d8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMohM/d8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ANIQ3l2202336;
	Sat, 11 Jul 2026 00:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rBRWSHgveIp/6cfNuX0stLvLPDamgFCzXwb
	8GP3FN5Q=; b=WMohM/d8/zB+JPNDP3HV86xHgmC7xAjNYJCpmhnV0uIDF7EPvfV
	A4bVcjeAYtBd8g9pkL0UPlvxvZLYTR0Itk+C4UZvAofK8kux3uNvrgc1XnIawbpJ
	TIW4WjecFeherEzoJfZPMeSZ2xjqiwSVn0GXYxcBmrEjNdg8gPkM3hnOnwPYGEpD
	hCMZHvwZsy5HG8uMjgamT5bwrN8LaB13zUGHO5kUoFerY8fV0OHq8AhK2S1G0Dt2
	e8R95Csce2Eh8+3RKnlKiDhjoV1CALCid7Q2ps7MWAWBuXEj6qHE0pp4LRql27bf
	kZ7E6OEEt6H2eA4hpOt24lZ/TRQpgiBdN3w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fawnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jul 2026 00:33:43 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66B0Xg13010599;
	Sat, 11 Jul 2026 00:33:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fan79k6cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jul 2026 00:33:42 +0000 (GMT)
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66B0Xf0O010594;
	Sat, 11 Jul 2026 00:33:41 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-mrana-lv.qualcomm.com [10.47.235.202])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 66B0Xf3W010593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jul 2026 00:33:41 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 78961)
	id 9DD026C0; Fri, 10 Jul 2026 17:33:41 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linux-kernel@vger.kernel.org,
        Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder commit time
Date: Fri, 10 Jul 2026 17:33:41 -0700
Message-Id: <20260711003341.2602368-1-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a518f67 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=Xub_O1pC82g251P8oewA:9
X-Proofpoint-ORIG-GUID: 3EFUVcZYW6LqDrpT-1_AHUzsy55dOU82
X-Proofpoint-GUID: 3EFUVcZYW6LqDrpT-1_AHUzsy55dOU82
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDAwMyBTYWx0ZWRfX0atcb6UcybBb
 ssNtKdXtH2OfOzCEN9T/OIDLYqZIawD8r2EBjpSuFFqZOrFSnMJT3oW067KsXzpY281z166oPpg
 1SFdYx/dNVZk+USUtHZ8pWsrftDNMmc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDAwMyBTYWx0ZWRfX7+198csBhJD+
 fsyyQ/MvsIKUz+lCYN/EcaiK1x11IaxxTmm1ua9y/0L8h96BMl577Hc1HOLkgGQBZNz8gXBCg+t
 Z2mRkHCADk/m2bVewtaX9u79K4TU1BNocG4ZInvJS3XqSM/SyEvL7oEtkEMiUqOczMcsYmw38IL
 2nx3NY6h7qwCT+HSGIDLeUcyExThQ+6npy4EbQLcayK/GwutAkWP39SfJ+qjEls/dZUEX7ydK2K
 JBlHWU06bY4lv5WUy+YfpAS/ZQ85v0aswuFHypDkKUWPVbzMJySTJpt53n/GoyDpmBqPeunxPjw
 E9xsfhX4oZw6uSOSPLlm6oQn4GRgiRTBb8SVANkqXTfxCQNSEWtz8bGJb6aePral4BMsZ22shQ4
 Soc1TW02bUs7hwVWYOYFEXdvf9dsxZeOk00vQR0F3MmcLGo32PZvXj9WU6YrjRISvgSEkMlGngg
 Ujil2S7AfSLF2wEpssA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607110003

A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
carries a restrictions field that describes the memory types a platform
window supports.  cfmws_to_decoder_flags() translates this into
CXL_DECODER_F_TYPE2 (HDM-DB permitted) and CXL_DECODER_F_TYPE3 (HDM-H
permitted) flags on the root decoder.

However, nothing currently prevents a caller from committing an endpoint
or switch decoder whose target_type conflicts with the CFMWS policy:

  - A decoder with target_type == CXL_DECODER_DEVMEM (HDM-DB) can be
    committed on a window that lacks CXL_DECODER_F_TYPE2 (HDM-H only).
    A dual-capable device will accept HOSTONLY=0 + COMMIT=1 without
    asserting COMMIT_ERROR, silently violating platform policy.

  - Symmetrically, a decoder with target_type == CXL_DECODER_HOSTONLYMEM
    (HDM-H) can be committed on a window that lacks CXL_DECODER_F_TYPE3
    (HDM-DB only), again violating ACPI CFMWS restrictions.

Add a check in cxl_decoder_commit() that walks from the decoder's
assigned region to the root decoder and rejects the commit with
-EOPNOTSUPP if the decoder's target_type requires a capability flag that
the CFMWS window does not advertise:

  - CXL_DECODER_DEVMEM      requires CXL_DECODER_F_TYPE2 on root decoder
  - CXL_DECODER_HOSTONLYMEM requires CXL_DECODER_F_TYPE3 on the root
    decoder

required_flag is initialized to zero so that any future target_type
values not covered by the if/else-if chain leave the enforcement check
a no-op via the leading required_flag && guard.

This makes the CFMWS restrictions field authoritative for memory type
enforcement in both directions, regardless of individual device capability.
The existing COMMIT_ERROR path in cxld_await_commit() remains as a
secondary safeguard for devices that cannot support the requested mode.

Fixes: 3e23d17ce198 ("cxl/acpi: Use the ACPI CFMWS to create static decoder objects")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
---
  - Initialize required_flag = 0 and use explicit else-if for
    CXL_DECODER_HOSTONLYMEM; guard enforcement with required_flag &&
    so unknown target_type values skip the check cleanly

Changes in v2:
  - Extend enforcement to cover both directions: HDM-H commits on
    HDM-DB-only windows are now rejected in addition to HDM-DB commits
    on HDM-H-only windows (reported by Sashiko AI review)
  - Generalize condition from single DEVMEM check to type-dispatch
    selecting required_flag based on target_type
  - Update commit message and subject to reflect bidirectional policy

Testing
-------

The bug and fix were validated using QEMU with a modified CXL configuration.

Two test-only changes were applied (not part of this patch):

  1. QEMU ACPI (hw/acpi/cxl.c): CFMWS restrictions field changed from
     0x0f to 0x02 (ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM only, without
     RESTRICT_DEVMEM).  This causes cfmws_to_decoder_flags() to set
     CXL_DECODER_F_TYPE3 only on the root decoder, simulating a platform
     that does not permit HDM-DB.

  2. Kernel (drivers/cxl/core/hdm.c): init_hdm_decoder() uncommitted
     endpoint path changed to force CXL_DECODER_DEVMEM unconditionally,
     simulating a dual-capable device (supports both HDM-H and HDM-DB).
     QEMU's cxl-type3 device reports CXL_DEVTYPE_CLASSMEM and defaults
     to HOSTONLYMEM; this override exercises the DEVMEM commit path that
     a real Type-2 or dual-capable Type-3 device would trigger.

Bug reproduction (without this patch):

  # cxl create-region -m mem0 -d decoder0.0 -t pmem
  created 1 region

  HDM-DB committed silently despite CFMWS advertising HDM-H only.
  No error or warning in dmesg.

Fix validation (with this patch):

  # cxl create-region -m mem0 -d decoder0.0 -t pmem
  cxl region: cmd_create_region: created 0 regions

  dmesg:
    cxl_core: cxl region0: mem0:decoder2.0 type mismatch: 2 vs 3
    cxl_port endpoint2: failed to attach decoder2.0 to region0: -6

  The decoder's target_type (2=DEVMEM) mismatches the region's required
  type (3=HOSTONLYMEM) enforced by the CFMWS restriction -- commit blocked.

QEMU invocation:

  qemu-system-x86_64 \
    -kernel bzImage \
    -append "root=/dev/sda rw console=ttyS0" \
    -drive file=rootfs.img,index=0,media=disk,format=raw \
    -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
    -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
    -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0,sn=0x1 \
    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
    -nographic


drivers/cxl/core/hdm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..127a187cdadb 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -802,6 +802,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_root_decoder *cxlrd;
 	int id = cxld->id, rc;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
@@ -834,6 +835,34 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
+	/*
+	 * Enforce CFMWS memory type policy: reject commits where the decoder
+	 * target_type conflicts with the root decoder's CFMWS restrictions.
+	 * - HDM-DB (DEVMEM) requires CXL_DECODER_F_TYPE2 on the root decoder.
+	 * - HDM-H (HOSTONLYMEM) requires CXL_DECODER_F_TYPE3 on the root decoder.
+	 * - Unknown target_type values leave required_flag zero; skip enforcement.
+	 */
+	if (cxld->region) {
+		unsigned long required_flag = 0;
+		const char *type_name;
+
+		cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
+		if (cxld->target_type == CXL_DECODER_DEVMEM) {
+			required_flag = CXL_DECODER_F_TYPE2;
+			type_name = "HDM-DB";
+		} else if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+			required_flag = CXL_DECODER_F_TYPE3;
+			type_name = "HDM-H";
+		}
+
+		if (required_flag && !(cxlrd->cxlsd.cxld.flags & required_flag)) {
+			dev_err(&port->dev,
+				"%s commit rejected on %s, CFMWS does not permit this memory type\n",
+				type_name, dev_name(&cxld->dev));
+			return -EOPNOTSUPP;
+		}
+	}
+
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
 		setup_hw_decoder(cxld, hdm);
 
-- 
2.34.1
