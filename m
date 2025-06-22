Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FAD1CF5C0
	for <linux-cxl@vger.kernel.org>; Sun, 22 Jun 2025 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750617604; cv=none; b=ndnDoL6zVMOc3Aj0+7ilQpj09c/MVTkqo5DOfHDWCQKYlqbOJ7aUwO30ixDrT4UzALQqeWmveUQ7UW0Z7l8eTPi3fj3/+J+KR9Uo14CWwZ6umOjGO1zon+XGNea6o1J8RJ58W2ZPZ6BUiZNibAr4sAFQxXOMyXcLlqK74MmSqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750617604; c=relaxed/simple;
	bh=4zUqJarprWUVg1v6H/WICt1b3c333Mfr5RUckN7EDcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQ+h5Lb/x0H8IKHC8JWnx8V7YFbfUFoPeCGKOcmWrCw8exdZfxShwej/NXr1e8qSimazD8ZIUkDx9w9Ub3ZOCQlP2SMUbHcjnW3YRzgXJDUH6ugsm7Zw3Sjxb+OXwuKt1HeJqXaMOUidZa0KUNdKJ8ibN5LwHXCP3XhEqwR/ywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iVDv5Dbb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVDv5Dbb"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MFNAEk014190;
	Sun, 22 Jun 2025 18:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=9nHZI0gPEtXoWqp7IpuQXNvPmNw6Y
	D5znE2qxmUning=; b=iVDv5DbbyZBrAogWSy6T7vQTUeh02bT7ubLA6n1oDWCLT
	lgnIbGUUQgR45maKUYieoQYAgmptN5S5Nv+QZXAMJ1ko/xj3VxsFRl61/eFWXJVC
	1FhLptJ662IO+N8nbfYm6dEmNY3CY5obaycxg6ddhKd2U7JtzQzYgS6gt/3PxRZF
	3hQcfak4bj3dV8l2xJRJjNew7MySrLTbAduZxUx08OXn8Ro9WiWrBFEklNxk+B2w
	NaqUBC9cTptT3eaO1a88FG5Y/ez3zNX9rJrT7Q44SSRhOdT2MEC6Oos5OK/pRs6K
	UOpCNqncMZUqYufxr6IX80JuHdl/EXJ/EoFOB7TUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5g7gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Jun 2025 18:39:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55MIVGuU002571;
	Sun, 22 Jun 2025 18:39:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpb4bwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Jun 2025 18:39:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55MIdnSR019077;
	Sun, 22 Jun 2025 18:39:49 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpb4bw1-1;
	Sun, 22 Jun 2025 18:39:49 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-cxl@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH] cxl/edac: Use correct format specifier for u32 val
Date: Sun, 22 Jun 2025 11:39:16 -0700
Message-ID: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-22_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506220119
X-Proofpoint-GUID: j3etamI16WVDUWt6HzLSaB7SBbHrovuo
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=68584df7 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=uaK7bTDsDLueLMOGudsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIyMDExOSBTYWx0ZWRfX10LR9P9VqVYl BzovnuZSJZcnu/m+9Nwjdgjn6y9lvYCY5rr2zX+OAPqU6zrKYjdZxwQeF6FbteAk5HVBbr08veI uTaI/n2DIonQzZGa7HwNl86Jhv+iivHHMhmzZoXGb5JgwFuTwaeYudw8OmhC4poYP0+c2skSY5m
 H5lC88CnwNhSTDBsg1H1J6Ac3IEBfVvnf7m+7A0+yJ238vDZ7P75FdZgNCQZbE4h7BthnOkvPZ/ 7KBIkJ4sSbtN0JjpbWrMqV3PMqMOmTd1ZtcOUbGuzliYv9VhfSzdrE1i1h7jxbN7D+aTScZL58n RhCqdWbKFxzP1l6ljOJR2sgB9aD6T0vFCI+sQLODBIkJPSq0eWvCzyJL59NOd4ZJ+niAf+S8wkq
 Id7NJAcLMZMOa2Rv3xgimM0UDXr3NXY5LGbjjstLPJ7QcD09q7s5CVzrfRHl4jLWVwVh6Q1q
X-Proofpoint-ORIG-GUID: j3etamI16WVDUWt6HzLSaB7SBbHrovuo

The dev_dbg() message in cxl_set_ecs_threshold() used %d for
an unsigned value, which could lead to incorrect logging.
Update the format specifier to %u to match variable type.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/cxl/core/edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 2cbc664e5d626..76cb016e0bd9a 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -693,7 +693,7 @@ static int cxl_set_ecs_threshold(struct device *dev, u8 *log_cap, u16 *config,
 				      ECS_THRESHOLD_IDX_4096);
 		break;
 	default:
-		dev_dbg(dev, "Invalid CXL ECS threshold count(%d) to set\n",
+		dev_dbg(dev, "Invalid CXL ECS threshold count(%u) to set\n",
 			val);
 		dev_dbg(dev, "Supported ECS threshold counts: %u, %u, %u\n",
 			ECS_THRESHOLD_256, ECS_THRESHOLD_1024,
-- 
2.46.0

