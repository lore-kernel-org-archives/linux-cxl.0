Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA41ACEDC
	for <linux-cxl@vger.kernel.org>; Sat, 11 Oct 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207464; cv=none; b=P5pMz4z8XZWyJI6xWW6OhRsgfY4n70sicduUVtcuj9YRnZ6jxskF3InIBWFda5Q10JD2SCIQ9Dr8QwD48kdagUPg1rjq7cRx6xGWAar2/z3SBgMEeVeqQLHEQD/jpT9Txv9BYo/m46f9HLM/UrAcEiVzKONyH8zqTFZfYF7PfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207464; c=relaxed/simple;
	bh=D8Z8O00V3pdtfC9MbjmZgFLgk46ViTv+vvHWuWxjWFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoJ8wDM1PhFxdQTd06VkfsM5qx9qerUAB7VraoqNXjVeo/avKq6maTG8wGAx9MFfOWT7T+EqG8adEfXpNES5+qM4N6o2Mke7FCAIm3d/8y3Rc3VZTMw7Hm9zFrEv26y5kgH8ra1sCs0/fUinx3wVmTIpzLItSgAeF7CaC/g0f7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jw9GomQ4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jw9GomQ4"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59BHYBTf015431;
	Sat, 11 Oct 2025 18:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=rQVT62xmJH4oCITE5oYKn3JeZaRmk
	TlgK5CXOqjd5/A=; b=jw9GomQ4M6WyG016/GdulGyratdgQT+GIk/OpoS9KGuMf
	3dNXQ0Rro7nwOckbxTpEiv03uqtrEyw1rKrXChmYzkRVrwPAoT7b6l76Jtit8/7X
	WHjULn186A8e8wHAB8DUFFnadxoZISehaOmKf8YfcwGl8Tq869S+dS84lpXvC9rs
	BiEkFGyd+GI7o+tcHAj340l8o8knf62e7aCaaHLNTHIHzxBYysWcqHkkNl/rbatK
	U1QbbqQbX+d7fFma6G2P0UxPlx3L3sQqyg9nCyp5zC6U6PMblqQtffnMv1LIdQ0m
	Eh66wYY4ItIPXr/nBKIV7J/yz1jYb4EvLal7ylY1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfsrrfev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 18:30:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59BDXDUp018066;
	Sat, 11 Oct 2025 18:30:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp66bnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Oct 2025 18:30:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59BIUqSo018278;
	Sat, 11 Oct 2025 18:30:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49qdp66bnh-1;
	Sat, 11 Oct 2025 18:30:52 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-cxl@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH] cxl: fix typos in cdat.c comments
Date: Sat, 11 Oct 2025 11:30:44 -0700
Message-ID: <20251011183050.616325-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510110105
X-Proofpoint-GUID: UtGehJAFNVj9FAG6QN_33us23_40qJB9
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68eaa25f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=_IhK2FKGzJjqCjCiN_0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX+mY+lhTS0xPG
 MbV5Ud93YVle7EUv5jpHM+e6jyp0pol3kC+9KbAiUI5Op4+h36b8TdPKrj0PxgoymN1IY5aw3oJ
 SNPmK7kc5VGZxPEdj7gJMv5y479XfsXg0/oH8d7xgWF7kGEuF5sq2oP4lyydR5YdiEWDZxZuw4f
 QuJqJCbZKZSKzKNP+KcJHHP7atmgSVEe4kofGzonCuk6ILNhomwumKpz36bGh2ZSHlkUNaIesPa
 Ml11EOpXHyw5+IZZhW/3nG08Dsb/uxpEGstuk8qLcmAjKdkKbmL0km8S+MdDfX/9vy3NSS61ceo
 KleWNKTGmjIR8Q53PSo51qN0PHIgw1Sbr/EXBJxYHDiwqq//5zpSFhq04ytnYha7XbMcjV8Qu1C
 qZu6P5UUrPaWUiYCoEr7YmZvADZgug==
X-Proofpoint-ORIG-GUID: UtGehJAFNVj9FAG6QN_33us23_40qJB9

- Corrected spelling of "bandwdith" -> "bandwidth"
- Fixed "wht" -> "with"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/cxl/core/cdat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c4bd6e8a0cf0..7120b5f2e31f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -826,7 +826,7 @@ static struct xarray *cxl_switch_gather_bandwidth(struct cxl_region *cxlr,
 		cxl_coordinates_combine(coords, coords, ctx->coord);
 
 		/*
-		 * Take the min of the calculated bandwdith and the upstream
+		 * Take the min of the calculated bandwidth and the upstream
 		 * switch SSLBIS bandwidth if there's a parent switch
 		 */
 		if (!is_root)
@@ -949,7 +949,7 @@ static struct xarray *cxl_hb_gather_bandwidth(struct xarray *xa)
 /**
  * cxl_region_update_bandwidth - Update the bandwidth access coordinates of a region
  * @cxlr: The region being operated on
- * @input_xa: xarray holds cxl_perf_ctx wht calculated bandwidth per ACPI0017 instance
+ * @input_xa: xarray holds cxl_perf_ctx with calculated bandwidth per ACPI0017 instance
  */
 static void cxl_region_update_bandwidth(struct cxl_region *cxlr,
 					struct xarray *input_xa)
-- 
2.50.1

