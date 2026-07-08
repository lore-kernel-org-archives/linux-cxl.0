Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF3305057;
	Wed,  8 Jul 2026 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546272; cv=none; b=ddrrsyXIPodYN14x0XfdiTFJz973NCpGplrr2EvqGhKmZ/YcQwwizVjOGg4LzRkx7ccfjhoofkp9uC93U7XMRnof3Kv/9wy3ZKSKjrW2978vnFRJb2AGbSSC6cRjBABFJ/kWwuRKZw6yQPWKPFmWSAFCquYcv9JZuIrn69aaXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546272; c=relaxed/simple;
	bh=WSI9zlhGWsFuCq5MTbKQ20EYxtOc3j2rw9jp3ksljI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XQQoQ3upnBHAqUT8vzsPZl1LKDK6A9IpwIdcJB8XfBM6Rlp4lRoKi35P+3/hMtKaROLkIf/8WJXEexyh+foiRmhceh0o4Mx9kWmLpKGEiSwinJH+fktwimeDv2/SE4WaSDdsEh/QgFd2z2Qczs4KJkJqEi6iZSabSLMyQPTRbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7jNugww; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7jNugww"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668KtOIx3946671;
	Wed, 8 Jul 2026 21:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=p2FIftPz7MVeDPkRKnCTSQ
	JYK4/jTAXeo5j0ggQnB8Q=; b=L7jNugwwpUZdf2V6k3YLRPtv1pn1sOWROVUMI3
	IV7eHUdZRoQvX2mf0717Rk24LvnhtVA7iAT66J4h6xonfDFSIHhthIyo87XyXswH
	cQVjtMGukLVHrnNFwVryXVt4otf5t759dd2cNsJu+OEaq6LLLUH3Enl3iLbl642n
	v21+hXA6ggubf8+YgFccOJey03bKT181HCyqZWWlpdd9HUnGK6cemX+HyCO1oSqt
	/7WuLvyyyusSrpjaK/QAUwdNW9bsX3Vnxx+x7EUm2o4GxziTisKD6OxN45udGCo8
	fnsV7dUvrkdichUBRsF0ctusbZn3+PXQzgjJQcoB/K3rckaA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqs95an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 21:30:50 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 668LUnn7014271;
	Wed, 8 Jul 2026 21:30:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4f9rfnbacs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 21:30:49 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 668LUmMI014265;
	Wed, 8 Jul 2026 21:30:48 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-mrana-lv.qualcomm.com [10.47.235.202])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 668LUmGL014262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 21:30:48 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 78961)
	id 9AC7B6CA; Wed,  8 Jul 2026 14:30:48 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH] cxl/hdm: Enforce CFMWS HDM-H policy at decoder commit time
Date: Wed,  8 Jul 2026 14:30:47 -0700
Message-Id: <20260708213047.267024-1-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIxMCBTYWx0ZWRfX5bq4v1EyVuYr
 ZjzkY5VM9O+HhB3xKQ2dQW09RLgc3syI5arN66bU4QxOtOpSCoREMyvDXYuAQxp9AjUEDGOcrie
 9t+I/xjzSZ+uIJApwWroD0lLdyRfQzs=
X-Proofpoint-GUID: 2GiLppSVOWUwcOm7NpqTxehiaqS7Wl_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIxMCBTYWx0ZWRfX75g67yix+1Ve
 uQ5l7BbkjHOmJlNAHwnUELhpACocO9nc4Wv4hvvQl+b3CGUXHYy2avMOra4PaoyN22ryTI4jpxA
 7Au+nGqDVWaV05a9c1WCq+SeO7RzVdkNiRqtsLIht5wLsw7k4DNg1tmgwoalT/38/pGSXiX25Ty
 PsW0zuPgoKEzfHR9xDPjrYkwRiDQKu0uhT20slAEhXVgWjmOQfpE0YJLG6VjXZw4P+fDqNPVHXO
 22P4vbPB/k/v0l21sDWbbLJA/cv3JHJGYSNiK+TnG4iI4TKUQTyMHzL2yCrfZOo9IHzFrM5a3Sm
 O9276ABdKFiQ+NFKGR0/QvSL2LjrUx8yGrDgmV+Hl3vgVvuB6kNfLc4IGfqiyJQjzy601QtYDKE
 w0tOD2rqMagyiFHh+NYNKXck3xukC7VPPCOckt5OCOzakRr0OZ+vWIz1Z3s+MMCp92bbsMmsqii
 yCpKPGwKwGQagj0zRLQ==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4ec18a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=FSsoVMqp1frxoYIPBNwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2GiLppSVOWUwcOm7NpqTxehiaqS7Wl_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080210

A CXL Fixed Memory Window Structure (CFMWS) in the ACPI CEDT table
carries a restrictions field that describes the memory types a
platform window supports.  When the platform sets only
ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM (bit 1) without setting
ACPI_CEDT_CFMWS_RESTRICT_DEVMEM (bit 0), the window is advertised as
Host-Only Memory (HDM-H) only.  This platform intent is translated into
CXL_DECODER_F_TYPE3 without CXL_DECODER_F_TYPE2 on the root decoder by
cfmws_to_decoder_flags().

However, nothing currently prevents a caller from committing an endpoint
or switch decoder with target_type == CXL_DECODER_DEVMEM (HDM-DB) on
such a window.  A dual-capable device -- one that supports both HDM-H
and HDM-DB -- will accept HOSTONLY=0 + COMMIT=1 without asserting
COMMIT_ERROR, silently operating in HDM-DB mode despite the platform
policy prohibiting it.

Add a check in cxl_decoder_commit() that walks from the decoder's
assigned region to the root decoder and rejects the commit with
-EOPNOTSUPP if:

  1. target_type is CXL_DECODER_DEVMEM (HDM-DB requested), and
  2. The root decoder's CFMWS window lacks CXL_DECODER_F_TYPE2
     (HDM-DB not permitted by platform)

This makes the CFMWS restrictions field authoritative for HDM-H
enforcement regardless of individual device capability.  The existing
COMMIT_ERROR path in cxld_await_commit() remains as a secondary
safeguard for devices that cannot support HDM-H at all.

Fixes: 3e23d17ce198 ("cxl/acpi: Use the ACPI CFMWS to create static decoder objects")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
---
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
  type (3=HOSTONLYMEM) enforced by the CFMWS restriction — commit blocked.

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

 drivers/cxl/core/hdm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..c26dab185dc8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -802,6 +802,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_root_decoder *cxlrd;
 	int id = cxld->id, rc;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
@@ -834,6 +835,19 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
+	/*
+	 * Enforce HDM-H: reject HDM-DB if CFMWS lacks CXL_DECODER_F_TYPE2.
+	 */
+	if (cxld->target_type == CXL_DECODER_DEVMEM && cxld->region) {
+		cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
+		if (!(cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_TYPE2)) {
+			dev_err(&port->dev,
+				"HDM-DB commit rejected on %s, CFMWS restricts to HDM-H only\n",
+				dev_name(&cxld->dev));
+			return -EOPNOTSUPP;
+		}
+	}
+
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
 		setup_hw_decoder(cxld, hdm);
 
-- 
2.34.1

