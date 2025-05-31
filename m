Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8FF9CB;
	Sat, 31 May 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748677951; cv=none; b=GnhtavdedCsJQ8h+zLjI/nKrisVmYukiCBMA8z4z9Q8nF4JJ7SiCDNntU/3XamOrw8D/8lssjEDRPUjc0lbKM3DqzIiLLrPfL6nct2RqCGtGK2C+vBxu4H3vrRs1w1lJorfF81BsBrlqCyshe7CEvmvvduF22I0I8qcbA3FNRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748677951; c=relaxed/simple;
	bh=tHojx3WnGS7eQ0SzezEGkt1EjWAPJ30dI6MnJxTgjM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iftYM6jbtrFs4Disz+2086oHuKguKmhlN6JyEoBM4lvnlp9mt9uBP2zzpT5hQH6O5CYTrMhzGPh52ZrI1xVF5elXkqkRudoXZDcoRvF9SpJswiX3SZJYsOI5wNrf39Jknw/R2WDPE2DPBFndiqitN9AE31PJaCZZXeP+1C0qgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQn2Dy7d; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQn2Dy7d"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54V5F2C4012423;
	Sat, 31 May 2025 07:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=U/de0sLPbqSCHnDWBPAZlkOrRjPwz
	POr/jCBm6y14z4=; b=fQn2Dy7dU/Mwi6+5/HaZVdFRdHhvS8obRHMsitkIQ89KR
	5XKRAcm6cVDhNh29WVRlyTF54A3f6RshKJTGLdDOIY6JVmFZh9eXM1rmGcnyc20s
	IDv1EBT5fFV/H9VZZsKxw+mg7CYRayC92YNa3k920zHubF8p/2a2DNZmNU1lR3FK
	EuCbw3nQhVsC1PABb15d0aEFENbIOuskoBc4pYoWzpPyrP/P1wvUEZP6XBbp+4GG
	cIMaALAaKkJhgbGYzf8bB//TAZnax7OaWT5ebg7F1aLwUzey3KYeAL1hw9AfA7RL
	TS0t87y8JAKXUHW0SMxSz5/m/SDQeMvNHmWZ82nXA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrpe05rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 May 2025 07:52:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54V6VD7F040698;
	Sat, 31 May 2025 07:52:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr76n6nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 May 2025 07:52:14 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54V7qDZX009425;
	Sat, 31 May 2025 07:52:13 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46yr76n6nq-1;
	Sat, 31 May 2025 07:52:13 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net,
        linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] Documentation: cxl: fix typos and improve clarity in memory-devices.rst
Date: Sat, 31 May 2025 00:51:58 -0700
Message-ID: <20250531075209.3334261-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-05-31_03,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505310067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDA2OCBTYWx0ZWRfX9mSvu23lUmTe ZEzKciV+C8x+RSIB47ibN8EU/YW05929zCa3L5CST2XJh7slNIjWTOVCMa98skM8ZOj6Hc+Z1Dz nlt+AtrV/I1XHlrAOdBKV7RkBQ4jJGIPftK+9KgUKS/9TlsXzZ6B9LKZd3M/E1EqzbmVtAeVLGs
 lCJow/hf1y3CtrIHm6LlfgCEsQMk8QGSs89VPvtGYg7YHWdZVwGiOF7qApaAb1+icsSKsndv+P+ e6NLxcdsxivXKBVN09o6pSRI1VLTeAoBE5tlrli8RDNy1sBUjo+QeY+pV1zauWtPak4huSFbDSi LM7Rh7hlNN9p+4ug0752ZLN1EKI+2Y/yXKFBh6/lDT8EchHDAUAmMyMOXQpTLTHLX3CkNNHbzyg
 BJr9eSQvvNirIGUhytaeQQzIDIsvIit8DT4t1SG1ROB4wRRh6FPPMnepO97LYeIWxa85mb+F
X-Authority-Analysis: v=2.4 cv=NN7V+16g c=1 sm=1 tr=0 ts=683ab52f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=434jntuLdbThvQkW9cEA:9 cc=ntf awl=host:13206
X-Proofpoint-GUID: tY2p2HxlxCnsdj_N1alDJ5HSJN6OP0_w
X-Proofpoint-ORIG-GUID: tY2p2HxlxCnsdj_N1alDJ5HSJN6OP0_w

This patch corrects several typographical issues and improves phrasing
in memory-devices.rst:

- Fixes duplicate word ("1 one") and adjusts phrasing for clarity.
- Adds missing hyphen in "on-device".
- Corrects "a give memory device" to "a given memory device".
- fix singular/plural "decoder resource" -> "decoder resources".
- Clarifies "spans to Host Bridges" -> "spans two Host Bridges".

These changes improve readability and accuracy of the documentation.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 Documentation/driver-api/cxl/memory-devices.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index d732c42526df..e9e2952a967d 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -29,8 +29,8 @@ Platform firmware enumerates a menu of interleave options at the "CXL root port"
 (Linux term for the top of the CXL decode topology). From there, PCIe topology
 dictates which endpoints can participate in which Host Bridge decode regimes.
 Each PCIe Switch in the path between the root and an endpoint introduces a point
-at which the interleave can be split. For example platform firmware may say at a
-given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
+at which the interleave can be split. For example, platform firmware may say at a
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

