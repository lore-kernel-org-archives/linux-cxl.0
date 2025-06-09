Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222C15B102;
	Mon,  9 Jun 2025 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489110; cv=none; b=MqpKCY78TdczQ5H0z5X2uB6xto9IGqhJuPriUySlaG6d/0NhV+mjZkhEc29P6Gz1hzQ+FV2DkChnykMxpb164lp8Yfxh2siFHqNGOQWpL8G4/CTmeNHIVaPyWpTzP/QPq+kpkWrzzeUPVgA4fTpwWRKWx2O/Sh/aVzReN4FAZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489110; c=relaxed/simple;
	bh=Zc9k0GvsLHQBb6pSqv2De889TV9l2b1pkVelPJAzcYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFpQfhBSmiFUJHXNtwT35+hrqwZjefYutKdna+xc5wSNY+SpyNsgNZG7Lr5tCGpGYUtW2BpFpHpGhD0nBFl9FTzOO1kezzVLqvYWmI9r3fMIV3n0fxWgVDYqbsBAS9SiIDqUaqtyn+NKvH0nAg1ckzA2Y/o2aAIzyPFo4btHCyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ly5d4Rfd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ly5d4Rfd"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fdb21006154;
	Mon, 9 Jun 2025 17:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=4kkB0pdhy4LtB2d8Dt+x/uRpKX3b9
	Z4Xiq1VjlCZHRg=; b=ly5d4RfdfDmLVJNNcHifjQ4uwd6MNy/mzpZ+9RagY/pC2
	OuDYVOY8UEDsveGObfirUCvH6iC520c1T5tOtawJcdNPab49aXf7AoxS5MtIyRHf
	QjcLUJF6UStGh2VyvU8Oj0W5g+ctIebxCV1LtaEOdj75m/aVuzMIfNO0glv30MNR
	J2aXpkHXlxu+bHzdTHI0ujGb77Cz/dJ2owX3vr9Fcc0Gvi3XgbJkjqkcAIvHywPB
	bpIZbWHiqaWYtw3hMIyniiJ1HjMJmpYuztDIb3J/LBkjUZEgqLuH2LrMo7hShPx0
	J/MwKjfRYpXXz19Hyu2HdilBanwI87LDgsm3A4WZw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjsxj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 17:11:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559FTrha031326;
	Mon, 9 Jun 2025 17:11:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7pkfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 17:11:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 559HBXpA035634;
	Mon, 9 Jun 2025 17:11:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 474bv7pkf4-1;
	Mon, 09 Jun 2025 17:11:33 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: gourry@gourry.net, rdunlap@infradead.org, dave@stgolabs.net,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net,
        linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH v3] Documentation: cxl: fix typos and improve clarity in memory-devices.rst
Date: Mon,  9 Jun 2025 10:10:48 -0700
Message-ID: <20250609171130.2375901-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-06-09_06,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090129
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684715c7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=tHa68p0SAAAA:8 a=i0EeH86SAAAA:8 a=_IABl59LKn_a5T-pKP4A:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyOSBTYWx0ZWRfX1E/LEju1K3wP P3UO6o4gAaplyTJJABd7/cA0FhzBqyrMD0I5aaI+sDfukqZN8HYfRpHOJJE2lmVdFBaYLSIo1s8 x4YH8HlFdVdjw0J56joStYutUKTMUiJR6SON4EPeFRXUMvPqY/9ReqPuM1mtrtonGjzoy/8bGzu
 7xSm0bmLdIxXP6I5bxGRxPxiIVCkLit8xIZSYdgcVxwinKTsH1n69tdyMlFIvjn/Vr08+YpwE2E DGN7zX9AlBAkYRLPOq/FSFn+pIUkMepeiLG8ATuiiNC2D1zeWhaHDuS8GutrFHt/gXAr1OEzXaW qFg3t/sXf7ZDTKIFnI0aKaPyEgxRAqvY0whOr+UgRu00FHH87aT+q79ZdQ4vIMolTWm5bJ/SSj/
 qkgdLBnG6GBRWvmnSdrW9DrYiLxG0+VVgvS9gKTgZrar8DFbVVc33LXtjBx3UsJ5DDgsekAs
X-Proofpoint-ORIG-GUID: 4gj9Jimbai6MOpAkM8QuaubgsazdzVZm
X-Proofpoint-GUID: 4gj9Jimbai6MOpAkM8QuaubgsazdzVZm

This patch corrects several typographical issues and improves phrasing
in memory-devices.rst:

- Fixes duplicate word ("1 one") and adjusts phrasing for clarity.
- Adds missing hyphen in "on-device".
- Corrects "a give memory device" to "a given memory device".
- fix singular/plural "decoder resource" -> "decoder resources".
- Clarifies "spans to Host Bridges" -> "spans two Host Bridges".
- change "at a" -> "a"

These changes improve readability and accuracy of the documentation.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron<jonathan.cameron@huawei.com>
---
v2->v3
rebase to v6.16-rc1
added Reviewed-by: Jonathan Cameron
v1->v2
added Reviewed-by Randy Dunlap and Gregory Price
change "at a" -> "a
---
 Documentation/driver-api/cxl/theory-of-operation.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/cxl/theory-of-operation.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
index 40793dad3630..257f513e320c 100644
--- a/Documentation/driver-api/cxl/theory-of-operation.rst
+++ b/Documentation/driver-api/cxl/theory-of-operation.rst
@@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
 (Linux term for the top of the CXL decode topology). From there, PCIe topology
 dictates which endpoints can participate in which Host Bridge decode regimes.
 Each PCIe Switch in the path between the root and an endpoint introduces a point
-at which the interleave can be split. For example platform firmware may say at a
-given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
+at which the interleave can be split. For example, platform firmware may say a
+given range only decodes to one Host Bridge, but that Host Bridge may in turn
 interleave cycles across multiple Root Ports. An intervening Switch between a
 port and an endpoint may interleave cycles across multiple Downstream Switch
 Ports, etc.
@@ -187,7 +187,7 @@ decodes them to "ports", "ports" decode to "endpoints", and "endpoints"
 represent the decode from SPA (System Physical Address) to DPA (Device Physical
 Address).
 
-Continuing the RAID analogy, disks have both topology metadata and on device
+Continuing the RAID analogy, disks have both topology metadata and on-device
 metadata that determine RAID set assembly. CXL Port topology and CXL Port link
 status is metadata for CXL.mem set assembly. The CXL Port topology is enumerated
 by the arrival of a CXL.mem device. I.e. unless and until the PCIe core attaches
@@ -197,7 +197,7 @@ the Linux PCI core to tear down switch-level CXL resources because the endpoint
 ->remove() event cleans up the port data that was established to support that
 Memory Expander.
 
-The port metadata and potential decode schemes that a give memory device may
+The port metadata and potential decode schemes that a given memory device may
 participate can be determined via a command like::
 
     # cxl list -BDMu -d root -m mem3
@@ -249,8 +249,8 @@ participate can be determined via a command like::
 ...which queries the CXL topology to ask "given CXL Memory Expander with a kernel
 device name of 'mem3' which platform level decode ranges may this device
 participate". A given expander can participate in multiple CXL.mem interleave
-sets simultaneously depending on how many decoder resource it has. In this
-example mem3 can participate in one or more of a PMEM interleave that spans to
+sets simultaneously depending on how many decoder resources it has. In this
+example mem3 can participate in one or more of a PMEM interleave that spans two
 Host Bridges, a PMEM interleave that targets a single Host Bridge, a Volatile
 memory interleave that spans 2 Host Bridges, and a Volatile memory interleave
 that only targets a single Host Bridge.
-- 
2.47.1

