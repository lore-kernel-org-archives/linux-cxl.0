Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E37263F5F;
	Mon,  5 Jan 2026 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767645530; cv=none; b=E0h+ykxx1+4HvhkJGpB+RwEZCM7rVCPkWgTNF/S4X7sNHL+vLuiy9SuTmGfCSoZKi4NJzLMlDpcA+fU0SFyfVsIvtNxdsYKMi9KRznEJprskkpCIGnBD0ssBSeU6y8Kyqj4OOZEsayerHdtlmSp6P0jiFQcrcNTlEBmYSdgz5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767645530; c=relaxed/simple;
	bh=1lIUMD23Z9ohe0QWCsI48WLsS+piG8EAOC6P4/HGXT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsV9DUpE22fSDffNrR1YLSz2xLqglRYjGvUybiEgr2TZ2+uqITJTByT0xEv4o80fB6cWxU1keVvcpfqpet6YY0cNwRWlbYYSjypDRRDbI6HGsD1YWPQXIgrlQ9yE73GEXc4Kzfdkeptao5cnO5o9FdL8jj7kpkJPht0TdF/v/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BZ860cQR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BZ860cQR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605Hp55H1934953;
	Mon, 5 Jan 2026 20:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=WhTlznQgSIVyQMzddyYJpKe2xP228
	0SnyNSHuCmuIZc=; b=BZ860cQRe3igW0r6cCZuKWDZp76/uc6qMnVTUgzto/WmR
	uqSzbX7RvhJigRCDPfTiLBUixfysl1mvZGaxWbmvd+1de8xplknuZsJLQSJ5FWEB
	o3WekLXSaumZzO84uktJuuwF6bQcEcNbRwffi+s4n4R0JslGhn9U6CcgDQXBkB5s
	nQJ2tg6vU99B8jpe7Wl2AUKjOtjAAXiNeRM8ks2B/2sxe34JS2nkis9hXR/wOtek
	gfjkzS/GMcpcdJT9MfV3iye7qBxfi0/ZeJCPB7XyDFMJP9Q4IDX+pVFHxf/Ozw9p
	pB6wX9oDsYlcvuiY4kcqgQhafAKLR7pEV0qdK+RAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bgj2c08a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 20:38:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 605IooJe015471;
	Mon, 5 Jan 2026 20:38:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4besj7j808-1;
	Mon, 05 Jan 2026 20:38:34 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
        lison.schofield@intel.com, vishal.l.verma@intel.com
Cc: ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/pci: Remove outdated FIXME comment and BUILD_BUG_ON
Date: Mon,  5 Jan 2026 12:38:33 -0800
Message-ID: <20260105203833.1604585-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050180
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE3OSBTYWx0ZWRfX7rsX2+BxF6Tf
 qmEcGdP2piZ6fx4t7nYCT0kXUo2UKl9Ni+MGJiYRjd3FXWIvhhBS7bxV6jPmKztctDEMu/wCtj9
 BxV8c89HzjltrOmmFOiONBP+CUQnvWJ2ygfmsTTaiDs0kmjrLhxKkd3sUPFZs/rsjQDZ6GEhBYV
 +Jup4Hd+k0Ff0p5n1AwZGj98aZpwd4zCoIaPFXLwzeDq7EbARC3t1bt/bD5cjIDI3VyRxF282LF
 SAwtXE2NQeFxyaPuan5AalyyjiiqcNnBFk8WWCJlnRDUi1f3A4Dlk9NUiOd3/8AV2IRsTx+YrXf
 kauKq91VJoyyHJr+2S1EbX9MEozBzM98Vs1F3RaLZ/d5oZXjzWlSkrkfhqS7lJUZp1SfHaKuRIf
 /n0/7+b6lKQBEPZ67mVfLpS4bGCISSb60okyvS4+IlYOZpLr0cBKVFVR85cQ5b8raxjkEJp/nZi
 n4EKw0fs31CWAYu6fEg==
X-Authority-Analysis: v=2.4 cv=KeDfcAYD c=1 sm=1 tr=0 ts=695c214b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=tjgsuXTvzfAlEncZS1gA:9
X-Proofpoint-ORIG-GUID: F8omdBBmaukeBFnkLcCG2cvm3PQ23FW3
X-Proofpoint-GUID: F8omdBBmaukeBFnkLcCG2cvm3PQ23FW3

Remove the outdated FIXME comment about switching to struct_group() and
the associated BUILD_BUG_ON check. This work was already completed in
commit 301e68dd9b9b ("cxl/core: Replace unions with struct_group()")
which converted struct cxl_regs to use struct_group_tagged().

The BUILD_BUG_ON was checking that anonymous union layout was preserved,
but since struct_group() now handles this correctly, the compile-time
check is no longer necessary.

Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 drivers/cxl/pci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0be4e508affe..3b2293dffb3f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -912,13 +912,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	unsigned int i;
 	bool irq_avail;
 
-	/*
-	 * Double check the anonymous union trickery in struct cxl_regs
-	 * FIXME switch to struct_group()
-	 */
-	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
-		     offsetof(struct cxl_regs, device_regs.memdev));
-
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
-- 
2.50.1

