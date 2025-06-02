Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78F21FF39;
	Mon,  2 Jun 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871529; cv=none; b=Dk2MM30hyeeoEYuriTiEMA26TpVff0XZEaZbvHRl6ZO6KL9HgDOTgLXBDP0a1OrE97WVHLUyGdAZ+g0d5UKx4IGQpqDvR5eDye3FNO6drjW5jpOIvry5esYXEXt/srupIhY84ShNA545H740KdYRBAJM8z89tJYNNCQSZFgFCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871529; c=relaxed/simple;
	bh=LhkeGeXHUt2ggJe/w/3bBrnJJDW8lZHf2s3EfUYKuSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eR8FN4JX/JHcnydkTE736tewplZrnTinOaJD0fouQwFgNunPTObtVlqRCA0gyjWr34qmd3THliw4ma/lL9oVByH/5Xqb/qgkmppCiPRTM5E7cVrxWFxUjscp1DB6OAbDfGksbhRnOfK3dnLWr4lrPvroprp2odJGmXoiRO4mcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pSlEcIPt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pSlEcIPt"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552C4WUo025222;
	Mon, 2 Jun 2025 13:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=B5fPK4uiFS4T0Mux0HVN5rTQIvFrP
	fJbnAszm7VP20Y=; b=pSlEcIPtchTFtM+wTHH/8f1+BHr9tiKTC39Gsti+Xuufw
	pFNFe43/XjGAI3Bpj8DOKjkFrFC7TDgIuIqf0CLjsvU2kM0Zk7T2RAQxjm9gsnxk
	IRp6W/6c14tmsHJenbGQQ0Za3nkqgtJtKu11IpgfTI8qOzYqPFQy7Ut9eq2kqN6/
	nROzY9bBA0tTA+lBua5oYXvRYjaFk//ZhzdcM82Qy4CGbgPcwDrRZ1Kgr8bpQKc/
	XQv6fTUEvC3snk7ab00014K73xFsFTZIYWrCojOjSUBUt34/RcanmbpCeikBHUAQ
	jf6bzaLdLf4M52Mdv/+tG9dek2c5Rji7CtWLneG/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ysnctkcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 13:38:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 552C2CVN016255;
	Mon, 2 Jun 2025 13:38:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7806by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 13:38:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552DblK3011778;
	Mon, 2 Jun 2025 13:38:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46yr7805xv-1;
	Mon, 02 Jun 2025 13:38:35 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: gourry@gourry.net, rdunlap@infradead.org, dave@stgolabs.net,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net,
        linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH v2] Documentation: cxl: fix typos and improve clarity in memory-devices.rst
Date: Mon,  2 Jun 2025 06:38:01 -0700
Message-ID: <20250602133806.3481259-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020111
X-Authority-Analysis: v=2.4 cv=Jdu8rVKV c=1 sm=1 tr=0 ts=683da95c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=tHa68p0SAAAA:8 a=RChXXvxoYHtGxfn2W1YA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMCBTYWx0ZWRfX+LmPhDUTlWJ/ wMMgqVDq12+1uCfE05st/YPPYxSRp5PzvkBUkNH9TG1h42Yfl5BeQp5WpRI//sQ5zGzedPtxXjH R5Sp/CYoUSxzlptfq748iVn0/RIIVNJ7GhbQH+TR/zLIFwtglTEa503SkAE9gApXncomzUxJsqd
 h8e3Xre9eITxdXYVhhIsMl0OZGGW97GT10bNz51PCVAxqxR2AZSWQrSS0qBWL/5yaOPc+TFYtTg RvQGia35nlC/ZbvcDmIGzUErPZG+alRQ6R59hdic9JWWBFLDfD2A65ZIQKpQQQMJ2elB+fdsXcr 7a59d9C4WoYEaUAE+zsqIpvbNpI4W7gYgCqAXoNHMyG+6fmvGVGbZrpGxRwWYHmHuvRFqoGVzkd
 Mi4L3k3mzcO3YBPK/L2jKf/BYOIRCaHYgdSCzC67yDdtWfCAfcg4Z2cZZgg/JOEyNsMAaRkE
X-Proofpoint-GUID: R362YqjlYjavhN5BQLbcqbyrahh_OKg9
X-Proofpoint-ORIG-GUID: R362YqjlYjavhN5BQLbcqbyrahh_OKg9

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
---
v1->v2
added Reviewed-by Randy Dunlap and Gregory Price
change "at a" -> "a"
---
 Documentation/driver-api/cxl/memory-devices.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index d732c42526df..2c67353de77a 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
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

