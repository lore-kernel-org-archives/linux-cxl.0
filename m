Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9053CEB9B;
	Thu,  9 Jul 2026 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783633643; cv=none; b=AG1Ppgf0eQqaBo+9eNjhgMq28DhyN5IGks6vcnyVvAkY0VPspGXS4hI0+mh6a6J7Wq4LYd6Fy74oGiXNMVXNK6eTsoVAaiu0MlWEYWNIaL7LShVEzpkt9dUO/dujJFaSmfBba8bhqrbcwZ0pO9ns9FDUuu789j7HaFXxBSGDdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783633643; c=relaxed/simple;
	bh=AbXvIJl4z0cRha6mY+M/idycdHH2q07mY8EB2oRfS2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kaXszkP0RdSJDysHv++IMrx3P24m2hChArOxzszo9dnu/TKDI8OTtGQlm4CzKV60iK45ilCTpJoxg0X+93ZqqIbMunI904R+HuVbu+B/n3+kFGcNf6lrx6tqL/9RnM8sm94pd4LaQSvkpqn7GnN2V+iVKH7kXAfi1dRtiyOrkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SyUz175A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SyUz175A"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669JUpbf2557051;
	Thu, 9 Jul 2026 21:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qS3l0KDRspmatZnNLtJgkNBxSYSOeOhvKPp
	2rL+SIgQ=; b=SyUz175AJsVX52HiDcwSTgJj1qPo7BBAfZZcNPrCa9Z4ItnP3fb
	MMuCT6QWc3qpTKtL4PPfD+JaZJoi6us55/N/NgRvOfv9I7A6XIC+o+DeUuMxR5aP
	KNuVw9RmmZK4PsRe5DGvaDJB6g8/p/Gg+2ynLodpfsDsKuNPgyPxNkW+gJRiaC+p
	jTr71KBSmf41DMv3WFYDCBhs6YNJTw/SChi2Tgb+eTq21T19NXEdGj3f5IcQpF0R
	7swxMXH5TnZIcP3WofiW7HQhBtE8dhi5itFaDrvEDn97G9mZOZs9GMfyYQqDMyPj
	zygJB2My2ypa+671L77/OWk/FEAIJm6yItA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8gey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 21:47:14 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 669LlDjM012437;
	Thu, 9 Jul 2026 21:47:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4fa04mashx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 21:47:13 +0000 (GMT)
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 669LlD14012421;
	Thu, 9 Jul 2026 21:47:13 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-mrana-lv.qualcomm.com [10.47.235.202])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 669LlDrn012414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 21:47:13 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 78961)
	id 29E586CA; Thu,  9 Jul 2026 14:47:13 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v2] cxl/hdm: Enforce CFMWS memory type policy at decoder commit time
Date: Thu,  9 Jul 2026 14:47:12 -0700
Message-Id: <20260709214712.1402933-1-mayank.rana@oss.qualcomm.com>
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
X-Proofpoint-GUID: 4nKv1sRnW-ZT82Bd7Q4G3gjDOg1ej_gl
X-Proofpoint-ORIG-GUID: 4nKv1sRnW-ZT82Bd7Q4G3gjDOg1ej_gl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIxNyBTYWx0ZWRfX+Chbdt5mMSEO
 eTi10gf615CPhtopfUVHXwmwXlJeU2iNaEfinL0QMHDz+iKU4b/gJe6jmvwXdL5MwdRYPs3ZqCK
 tV0DFa96JJGbcUcDSestFiHtfQ+fPkk=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a5016e2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=Xub_O1pC82g251P8oewA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIxNyBTYWx0ZWRfXy3jeeHZntcBQ
 p4llSRPhX73hCo1wkRc3zcxDZ870PZKEiv+k8VCiZvpkA5O7RzKCT2U1lsCQfEyZ10lcz/NP+Eu
 UpYbigrAKzlo0BBxTT7cVteLjHmnJrdum1NpkCWJ8tFr+rucGJ/8uf8w4qhf9qe036b/6tAPK/l
 SbRnQ7wZarkFct9yKJ6JXhfK2N0KASjEb1noNfU46vMl1pAvQsy6uoUww6jnQVNQtniyEusy9qM
 onJXkb6Ul2kE5yBl0Dmzi7v6Sk0woLRXYjQNs7MyztHlaMq4Rw89lpfS4hcB3nehG8CXAgDLAJA
 fXIKHQtnRtTnr51ffFg2mI+8jQRDk+8mWQfaM25xME1SdsUuDVTHnSoMLiy41F0M+JJP1mGPsov
 ho66tetDvnonwA2HUnte4ify2qMK2ycpAfv7wSq4/pX20W54efSKk5m1gKzmxcpA0A8wu6s32m2
 FnLaqg9Pg0iUr2FB4Mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090217

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
Changes in v2:
  - Extend enforcement to cover both directions: HDM-H commits on
    HDM-DB-only windows are now rejected in addition to HDM-DB commits
    on HDM-H-only windows (reported by Sashiko AI review)
  - Generalize condition from single DEVMEM check to type-dispatch
    selecting required_flag based on target_type
  - Update commit message and subject to reflect bidirectional policy
  - Initialize required_flag = 0 and use explicit else-if for
    CXL_DECODER_HOSTONLYMEM; guard enforcement with required_flag &&
    so unknown target_type values skip the check cleanly

Testing
-------

The bug and fix were validated using QEMU with a modified CXL configuration
on linux-next (v7.2-rc2).

Two test-only kernel changes were applied (not part of this patch):

  1. drivers/cxl/acpi.c: cfmws_to_decoder_flags() result overridden to
     clear CXL_DECODER_F_TYPE2 and retain only CXL_DECODER_F_TYPE3,
     simulating a CFMWS that restricts to HDM-H only (no HDM-DB).

  2. drivers/cxl/core/hdm.c: cxl_decoder_commit() forced to set
     target_type = CXL_DECODER_DEVMEM for endpoint decoders before the
     CFMWS check, simulating a dual-capable device committing HDM-DB.

Bug reproduction (without this patch):

  # cxl create-region -m mem0 -d decoder0.0 -t pmem
  cxl region: cmd_create_region: created 1 region

  HDM-DB committed silently despite CFMWS advertising HDM-H only.
  No error or warning in dmesg.

Fix validation (with this patch):

  # cxl create-region -m mem0 -d decoder0.0 -t pmem
  cxl region: create_region: region0: failed to commit decode: Operation not supported
  cxl region: cmd_create_region: created 0 regions

  dmesg:
    cxl_port endpoint2: HDM-DB commit rejected on decoder2.0, \
        CFMWS does not permit this memory type

  HDM-DB commit blocked with -EOPNOTSUPP as expected.

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

drivers/cxl/core/hdm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c26dab185dc8..127a187cdadb 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -836,14 +836,29 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 
 	/*
-	 * Enforce HDM-H: reject HDM-DB if CFMWS lacks CXL_DECODER_F_TYPE2.
+	 * Enforce CFMWS memory type policy: reject commits where the decoder
+	 * target_type conflicts with the root decoder's CFMWS restrictions.
+	 * - HDM-DB (DEVMEM) requires CXL_DECODER_F_TYPE2 on the root decoder.
+	 * - HDM-H (HOSTONLYMEM) requires CXL_DECODER_F_TYPE3 on the root decoder.
+	 * - Unknown target_type values leave required_flag zero; skip enforcement.
 	 */
-	if (cxld->target_type == CXL_DECODER_DEVMEM && cxld->region) {
+	if (cxld->region) {
+		unsigned long required_flag = 0;
+		const char *type_name;
+
 		cxlrd = to_cxl_root_decoder(cxld->region->dev.parent);
-		if (!(cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_TYPE2)) {
+		if (cxld->target_type == CXL_DECODER_DEVMEM) {
+			required_flag = CXL_DECODER_F_TYPE2;
+			type_name = "HDM-DB";
+		} else if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+			required_flag = CXL_DECODER_F_TYPE3;
+			type_name = "HDM-H";
+		}
+
+		if (required_flag && !(cxlrd->cxlsd.cxld.flags & required_flag)) {
 			dev_err(&port->dev,
-				"HDM-DB commit rejected on %s, CFMWS restricts to HDM-H only\n",
-				dev_name(&cxld->dev));
+				"%s commit rejected on %s, CFMWS does not permit this memory type\n",
+				type_name, dev_name(&cxld->dev));
 			return -EOPNOTSUPP;
 		}
 	}
-- 
2.34.1
