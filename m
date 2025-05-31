Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B93156F28;
	Sat, 31 May 2025 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748691843; cv=none; b=qitgJJH/cK7i2ZADnOA0LrOgKLZMrnlNKvjyv+78tcUN62dPRO/iAy1owaLd0r7MF1BPkfWj38vLoXXE9529NyDQmWIvBKK7u2cYhbRX1/O30Kc40lXeV5xOyXtOohqQFVCU/J/EqLTx0b1EctpioxhGqVAiiSm70Ek28pl01cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748691843; c=relaxed/simple;
	bh=DkqS88KswCE6eElc0WJt9rrEpqfehV3SZ4pLuufurPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpAddcVGHOG+yzXJ/RF56hTTAAlvO4z7dUjZwEyws2nW6ji0ELVaU0JYyvUeRkoagwX6iDZcKZoSQN15BMDd0FFwUAa/5G9vMMxmfOFrQItOHe0hh+hfxNwjKJejPNyjDm5WXGaAGYR4o1MzyKi3cHO/8mid2/yf0j1ZvgHXLcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mioBR5A9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mioBR5A9"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54VBNo6n012581;
	Sat, 31 May 2025 11:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=t9bZw8QZfqhGsbVSOQB67yk33BS8b
	HKTYP3OGG3cT+w=; b=mioBR5A94gnt/OVhg5v0U2kCpmrwX2dX3bMacS6AEEsDW
	Z78tIHxgz+2eUBl0bppOW3gCsamjCWhgcwVJ7/nonhVTUSlMwAdp3L8H/kcCrGju
	NH/fDtxLyuDQXYJATKac1XqQlFOj0xfFOSXaSb/YuJqmWgCShQSVeqfsIS3mg8E2
	QxYe0oDEbgwv29gg2m11ls2Sww+IeENYIpVzR+7K3fJVlmTFmpGt6KnJaEniclo0
	7eDpigepSCtSlBv3brCGBMWX5ZjFce2DtxakiUUu/JfW53YnaS05RO8XOJ/l46Qk
	Sdy7VGfroq4r9vIkmM0I09zY6v7Cq+NzjW0okGxQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ytawg7p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 May 2025 11:43:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54V6eVKe030620;
	Sat, 31 May 2025 11:43:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr76gace-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 May 2025 11:43:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54VBhlI3024372;
	Sat, 31 May 2025 11:43:48 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46yr76ga9m-1;
	Sat, 31 May 2025 11:43:47 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, shiju.jose@huawei.com,
        viro@zeniv.linux.org.uk, Smita.KoralahalliChannabasappa@amd.com,
        fabio.m.de.francesco@linux.intel.com, linux-cxl@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] cxl/trace: Fix typo in macro and spec reference
Date: Sat, 31 May 2025 04:41:58 -0700
Message-ID: <20250531114317.3341757-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505310105
X-Proofpoint-GUID: vKQCz9NXjdTzJ8VHZUALbYJ0OE25nivm
X-Proofpoint-ORIG-GUID: vKQCz9NXjdTzJ8VHZUALbYJ0OE25nivm
X-Authority-Analysis: v=2.4 cv=ctObk04i c=1 sm=1 tr=0 ts=683aeb76 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=2xcyL-vh7mIpikw6uGIA:9 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDEwNSBTYWx0ZWRfX+e6tEKsjte02 YLSBrXA5sAah8HWMCpAVwOfi9UlppxmrE2pHdd8Z1jSfzEYcVt1XjgNbNsFgp/i1/POSsf2jPKG KKV6IKJ6ok0Kozxmo8l8gTQAu6C6UnBv3O8bjm2KJw0waacrTZXiigiWmfUTGotYvylL9CJh84q
 LMKL6iNtYgJUfptPoYmbVXbBqfC7XC+JTKk+PlxmyDEXoHpR8QtdeGpjSRt4nBMM2RzrvwSSQMQ 9yocQEnMXaT4W5DEL162LmhBImnKQD16Sv8nWohEhxNWk8VkDVFl/ifboX1BDTpXmK2YJLMxILc IQAtjCYRDN9xg/oUlw8XDFdH2khkqxbUZsh/Tu+QBdCtZ0yDR07TdabZnw/tmCed8l2zeCvZpBA
 scxrbetKC1adgVjYCQfrAeoqMAhuGOvmXH5teLBfnWQmMPwn/+pWSv/xJG+CITq8uqOF7AlR

- Corrects a typo in the macro name: CXL_RAS_CE_RETRY_THRESH
was previously misspelled as CLX_RAS_CE_RETRY_THRESH.

- fixes a typo in a spec reference from "res" to "rev"
in the CXL spec reference: "CXL rev 3.1 section 8.2.9.2.1.3"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/cxl/core/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 25ebfbc1616c..de0712a31d96 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -109,7 +109,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 #define CXL_RAS_CE_CACHE_DATA_ECC	BIT(0)
 #define CXL_RAS_CE_MEM_DATA_ECC		BIT(1)
 #define CXL_RAS_CE_CRC_THRESH		BIT(2)
-#define CLX_RAS_CE_RETRY_THRESH		BIT(3)
+#define CXL_RAS_CE_RETRY_THRESH		BIT(3)
 #define CXL_RAS_CE_CACHE_POISON		BIT(4)
 #define CXL_RAS_CE_MEM_POISON		BIT(5)
 #define CXL_RAS_CE_PHYS_LAYER_ERR	BIT(6)
@@ -118,7 +118,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_CACHE_DATA_ECC, "Cache Data ECC Error" },			\
 	{ CXL_RAS_CE_MEM_DATA_ECC, "Memory Data ECC Error" },			\
 	{ CXL_RAS_CE_CRC_THRESH, "CRC Threshold Hit" },				\
-	{ CLX_RAS_CE_RETRY_THRESH, "Retry Threshold" },				\
+	{ CXL_RAS_CE_RETRY_THRESH, "Retry Threshold" },				\
 	{ CXL_RAS_CE_CACHE_POISON, "Received Cache Poison From Peer" },		\
 	{ CXL_RAS_CE_MEM_POISON, "Received Memory Poison From Peer" },		\
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
@@ -684,7 +684,7 @@ TRACE_EVENT(cxl_dram,
 /*
  * Memory Module Event Record - MMER
  *
- * CXL res 3.1 section 8.2.9.2.1.3; Table 8-47
+ * CXL rev 3.1 section 8.2.9.2.1.3; Table 8-47
  */
 #define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
 #define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
-- 
2.47.1

