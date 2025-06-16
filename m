Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539815A79B;
	Mon, 16 Jun 2025 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054074; cv=none; b=hUvpWBUtWhE69H9e57rwS2MEs456/xxj242+/Y6wzojszOBecuTIIhVPXKJc32Zt5/noYpyEB+qcWM6lAGonS4es77acOEPQtVDrCkvVQcPtsduSUaNYwQFXiaJWYvjkeOlBMvxfC7BZxchj8pICmVa0Y6BFuIkW0Ch6WqTQfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054074; c=relaxed/simple;
	bh=3aY1BoapMOrG+X9hJ11RVDqZMjK7J273gsTC9KOzXYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M6VIov4DjhWA0eSTJ8845pShiXMGiWWxNXbKnPVsLrA1JKWrQkhiLeGW9dnDJLJueuODl3XDOMOZM/BEzbqkP5cl74kyR/DDwlZxn07auVaeMfqXEvNL3vhibU3yariGnI5jN4aoZYsF6phsKIHhAkiwpUvmx5A7rNYEBXGbQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qAH/5Ut/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qAH/5Ut/"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNrep0004958;
	Mon, 16 Jun 2025 06:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=OeQccFsxYaMk+2oAr5Rfei0TTt24+
	k+w+3UL8HZWKiw=; b=qAH/5Ut/H1NSM0b4+rVKdR/qBxvKO+gWdugz7L9lhdHMz
	wb+x8jhnZ2MPqBV09JrAb/K1jUikPtoxpeyHCB7ir83USspzOculELRgq4F7p4j+
	xVc6gIWUHji76kE5eq3OJWsae8cP2CZGf2QlN34l6Yw2ec7/cPMraoW/IqQF9G84
	y9IfZMZ7mhM3lQWME3ENQLZODLvpNLXRpd13swWEeSV2YZBfoa9q1pvS+bINeRVU
	4pS2i0Zhr79MvF5C3O7KnMatHYtO7x+XmMlH5rfo9FJ0XTOt8AxTkae+0+bgwLVi
	okSZmEASL4eE4/OxWNsNNMWQ2Bd/C6BH27lZyss9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914ehqxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 06:07:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55G4dPoj032093;
	Mon, 16 Jun 2025 06:07:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh7g6ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 06:07:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55G67d7f007555;
	Mon, 16 Jun 2025 06:07:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 478yh7g6ej-1;
	Mon, 16 Jun 2025 06:07:39 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org, corbet@lwn.net,
        dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, gourry@gourry.net
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] cxl: docs/devices Fix typos and clarify wording in device-types.rst
Date: Sun, 15 Jun 2025 23:07:32 -0700
Message-ID: <20250616060737.1645393-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506160039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAzOSBTYWx0ZWRfXx4QQKlmuKXZI VLp2EqYIjck4mohGrDvUjfp31yijgBn+I32lT4NY9loLjOLz5Ert7n8gCJtHw+MU8nN9uFKDW47 shebjA8umXRTQXMCBbuYb241uxIBJGDOr8X73cQvOVveEmJHRu8/5clISCh1MKU6ntwH2Tjy/SG
 Sf7edSC45mJnnUS4dj+A7/j3ldfee/axO1gr/j9w3cNeWOPoX4oYp/E3Tp/5vOu1As1em9qrYHl jTz86ruXzGR6xxtkvJeZGlumxQS7fWxVYtcEmgqIIGh4wYRPl2g7VyIP7c3CPY0PoQyalJmiP3x HMXvMQdmwEVdfo38kw6BohfJwxJyieu6H1wwhkS3EAj7fSleIXemgH4GIPqSdBtEiVCUtZWkvoR
 u5PFXqdLpPf54GSKNqtXoYumdYP7Yy2Vd8EWZEssE2aFIL+R9CM426HprUpBVtGwQdlVk1f0
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=684fb4ad b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=5rsIUXSFhDujYq55XicA:9
X-Proofpoint-GUID: DkbpINJH-lcQiqr3Wuefolq7p5FmBC-P
X-Proofpoint-ORIG-GUID: DkbpINJH-lcQiqr3Wuefolq7p5FmBC-P

Fix several typos and improve comment clarity in the CXL device types
docs:
 "w/" replaced with "with"
 "sill" -> "still"
 "The allows" -> "This allows"
 "capacity" corrected to "capable"
 "more devices" corrected to "more hosts" in MLD description

These changes improve readability and enhance the documentation quality.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 Documentation/driver-api/cxl/devices/device-types.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
index f5e4330c1cfe..401c463af3ba 100644
--- a/Documentation/driver-api/cxl/devices/device-types.rst
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -63,13 +63,13 @@ A Type-2 CXL Device:
 
 * Supports cxl.io, cxl.cache, and cxl.mem protocols
 * Optionally implements coherent cache and Host-Managed Device Memory
-* Is typically an accelerator device w/ high bandwidth memory.
+* Is typically an accelerator device with high bandwidth memory.
 
 The primary difference between a type-1 and type-2 device is the presence
 of host-managed device memory, which allows the device to operate on a
-local memory bank - while the CPU sill has coherent DMA to the same memory.
+local memory bank - while the CPU still has coherent DMA to the same memory.
 
-The allows things like GPUs to expose their memory via DAX devices or file
+This allows things like GPUs to expose their memory via DAX devices or file
 descriptors, allows drivers and programs direct access to device memory
 rather than use block-transfer semantics.
 
@@ -89,7 +89,7 @@ basic coherent DMA.
 Switch
 ------
 
-A CXL switch is a device capacity of routing any CXL (and by extension, PCIe)
+A CXL switch is a device capable of routing any CXL (and by extension, PCIe)
 protocol between an upstream, downstream, or peer devices.  Many devices, such
 as Multi-Logical Devices, imply the presence of switching in some manner.
 
@@ -103,7 +103,7 @@ A Single-Logical Device (SLD) is a device which presents a single device to
 one or more heads.
 
 A Multi-Logical Device (MLD) is a device which may present multiple devices
-to one or more devices.
+to one or more hosts.
 
 A Single-Headed Device exposes only a single physical connection.
 
-- 
2.47.1

