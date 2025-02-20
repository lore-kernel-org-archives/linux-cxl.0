Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9119CC20
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029332; cv=none; b=NxTITFuNAkZfZo2SyEo5Y6hdwpSYq5pduHBvJR43XuI2w83CycO57/p4r3p5Vkv/jY55sRroyYzs3P0jTPbze81f4gAXLUZ2qoB328ngv2hBkmkqO1nbg7HdIfDs5t9dDCFlIuEObp+rb51/TTV4InObXqfL/GR2o0B37D5gNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029332; c=relaxed/simple;
	bh=7Tr5Zp9vYROQ+M+902RGyMoAH3+8nZokHIfTcNeZzzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=oYS8WmEuQlL1Y1VNnaL//bOdWR9eIVs2iVqsriFslVS8p7ukKdnGCjR4LD1GuRQTLjoFrCNhKBh50L9z/WCZI8ksC5lxr/rMbmaHjIOFABW2NQhPh04n/SrRQIr3ujurpuu9wTosnA1i3stYIAdqZYaNXhiAOC2bohnNQ27yecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A3XS+I5C; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A3XS+I5C"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250220052847epoutp02c7c40d7eac7b5f7429417debb4fe5757~l03RMShqT1725317253epoutp02N
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 05:28:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250220052847epoutp02c7c40d7eac7b5f7429417debb4fe5757~l03RMShqT1725317253epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740029327;
	bh=9NhaPdm3BDTOK0IhaPe0WxEZpnRK6Icu6IAR630h+CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3XS+I5CyfVO99SgTjMXLeGz4tD65f8VpRYDzYJREFpgFRWo+RJ4/WhBburGufP37
	 8QES/4etBgg19IaHWlNqew+pqI9bA2HpqETk7PaGbQIFxkL0y+xm2zraGmViSaSQwR
	 Y2IytSAKsmwggFJIcEtDFk3utyViUkg41ae0mVnE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250220052847epcas5p405d0e17209f8ad8c11d7262e2b0cceb2~l03Q5UqTJ1412414124epcas5p4h;
	Thu, 20 Feb 2025 05:28:47 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yz1yP15tlz4x9Pr; Thu, 20 Feb
	2025 05:28:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.BE.20052.C8DB6B76; Thu, 20 Feb 2025 14:28:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250220052736epcas5p254a601a6710b3fd58a827ca99680d746~l02PHLk2M1855518555epcas5p2b;
	Thu, 20 Feb 2025 05:27:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250220052736epsmtrp288a7c12049f09d7eaa8658b90aa37fd4~l02PGdO-a3134831348epsmtrp2E;
	Thu, 20 Feb 2025 05:27:36 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-39-67b6bd8c218b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.CA.23488.84DB6B76; Thu, 20 Feb 2025 14:27:36 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220052734epsmtip2aea6b1e5abe1ad6084c72ccaf496d5d5~l02NoNXuA1496914969epsmtip2T;
	Thu, 20 Feb 2025 05:27:34 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
	<vinayak.kh@samsung.com>
Subject: [PATCH v3 2/3] hw/cxl: factor out calculation of sanitize duration
 from cmd_santize_overwrite
Date: Thu, 20 Feb 2025 10:57:23 +0530
Message-Id: <20250220052724.1256642-3-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220052724.1256642-1-vinayak.kh@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpm7v3m3pBms3MFtMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
	VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
	6Xp5qSVWhgYGRqZAhQnZGR9/nmQt6JSvuPK2lbGBcYFYFyMnh4SAicSzpV+Yuhi5OIQEdjNK
	TDvZwA7hfGKUmDS9hQ3C+cYocfH6dXaYlgmf+6Fa9jJKfFswC8ppYJKYeGEZG0gVm4CBxIPm
	42AdIgKSEr+7TjOD2MwCHxglFj3V7WLk4BAWyJC4/zkbxGQRUJW4ctQepIJXwFbizdqvzBC7
	5CX2HzwLZnMK2EnsezqdHaJGUOLkzCcsEBPlJZq3zmYGOUFCoJdDYsbFnVDNLhJTf7xgg7CF
	JV4d3wL1gJTE53d7oeLFEucufmKEsGskXnetgOq1l2g91c8MchuzgKbE+l36EGFZiamn1jFB
	7OWT6P39hAkiziuxYx6IzQFkq0gsfZsJs+nLs2ao6R4Sq240QwN3IqPEzZeH2ScwKsxC8s4s
	JO/MQti8gJF5FaNkakFxbnpqsWmBYV5qOTyOk/NzNzGCU6mW5w7Guw8+6B1iZOJgPMQowcGs
	JMLbVr8lXYg3JbGyKrUoP76oNCe1+BCjKTC4JzJLiSbnA5N5Xkm8oYmlgYmZmZmJpbGZoZI4
	b/POlnQhgfTEktTs1NSC1CKYPiYOTqkGJqEa6eMWnfzn/E2Ef2ec0Vt9rmNWWnLj0i71jQ0n
	5nBftDedqZN+weyZ7yXFnQnPJ243sdniGbD5RdO9kDWz/54UfFUYtK/v6uHO33XhHg4qT87p
	qKi/SN9uEmKk8CczT+fC1gi/u4vO3HzP3uf8J+yk5ryVCif5Nr7y8z7VuU1ysssBhWO/p07d
	F+hrv/u9zvuOVWaGIaWx5Utszp1nWuNrdeGNBvcnr20Rs3krZHRO5Krl8V5v8Wf8FZvSv9po
	k7XyoX2fpi5N5HELdn23UNJ9Yt6tr5rf2OVXTmLcf2C6A7vk/31L5jW1TXq9KXJ9+oRWYWHd
	+ZNjQqaHbtyxeML5h1OXb6pzdA7cVnT3q5ISS3FGoqEWc1FxIgBQh+y/LgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK7H3m3pBu9+i1tMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6Mjz9PshZ0yldcedvK2MC4QKyLkZNDQsBE
	YsLnfqYuRi4OIYHdjBIvemawQySkJI7t/MkGYQtLrPz3HCwuJPCPUeLoeS8Qm03AQOJB83Gw
	uIiApMTvrtPMIIOYBX4xSjzdfR8sISyQJtFy9AFjFyMHB4uAqsSVo/YgYV4BW4k3a78yQ8yX
	l9h/8CyYzSlgJ7Hv6XSoXbYSS/pPs0HUC0qcnPmEBWQMs4C6xPp5QiBhZqDW5q2zmScwCs5C
	UjULoWoWkqoFjMyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1kvNzNzGCY0NLYwfju29N+ocY
	mTgYDzFKcDArifC21W9JF+JNSaysSi3Kjy8qzUktPsQozcGiJM670jAiXUggPbEkNTs1tSC1
	CCbLxMEp1cBk0NpWmOh0TPfzEkHzlcJLRJbExAi6B98xWC8cuWlyeuIzxrAN746KpHxbLP65
	Me+LSxujDXNtz5uyzfk2ZR91xKtPyyjyz78uHy8/9ytv4xmZTZLPRSsNxWffuFQmfXCH/fEJ
	p0QZLxhcPxn7cXmtwBnVSdkejM+Pa26ujGHL2+vqFhOwdDVfMGfu8s8K1Q2Pz19ldErsq55r
	IhOpZihQY716csMH+cP/lp2dk3BsGYvw85uFXHq1Ycbqcl+WWOcetDw/e26iW5JyxpX0xO8T
	pikeeWQx7+qTxuOu0YYsodevzHnLzOh+qifh77ZbYT9CPr6Zqppt1Hpk2QnPe1f8oxYI+3oq
	Rr6etlqqcLESS3FGoqEWc1FxIgBHsEYr/AIAAA==
X-CMS-MailID: 20250220052736epcas5p254a601a6710b3fd58a827ca99680d746
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220052736epcas5p254a601a6710b3fd58a827ca99680d746
References: <20250220052724.1256642-1-vinayak.kh@samsung.com>
	<CGME20250220052736epcas5p254a601a6710b3fd58a827ca99680d746@epcas5p2.samsung.com>

Move the code of calculation of sanitize duration into function
for usability by other sanitize routines

Estimate times based on:
             https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 61 ++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f55a2fe614..2428d85fef 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1656,34 +1656,10 @@ static void __do_sanitization(CXLType3Dev *ct3d)
     cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
-/*
- * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
- *
- * Once the Sanitize command has started successfully, the device shall be
- * placed in the media disabled state. If the command fails or is interrupted
- * by a reset or power failure, it shall remain in the media disabled state
- * until a successful Sanitize command has been completed. During this state:
- *
- * 1. Memory writes to the device will have no effect, and all memory reads
- * will return random values (no user data returned, even for locations that
- * the failed Sanitize operation didn’t sanitize yet).
- *
- * 2. Mailbox commands shall still be processed in the disabled state, except
- * that commands that access Sanitized areas shall fail with the Media Disabled
- * error code.
- */
-static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
-                                         uint8_t *payload_in,
-                                         size_t len_in,
-                                         uint8_t *payload_out,
-                                         size_t *len_out,
-                                         CXLCCI *cci)
+static int get_sanitize_duration(uint64_t total_mem)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-    uint64_t total_mem; /* in Mb */
-    int secs;
+    int secs = 0;
 
-    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
     if (total_mem <= 512) {
         secs = 4;
     } else if (total_mem <= 1024) {
@@ -1712,6 +1688,39 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
         secs = 240 * 60; /* max 4 hrs */
     }
 
+    return secs;
+}
+
+/*
+ * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
+    secs = get_sanitize_duration(total_mem);
+
     /* EBUSY other bg cmds as of now */
     cci->bg.runtime = secs * 1000UL;
     *len_out = 0;
-- 
2.34.1

