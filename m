Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7739C626
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946823; cv=fail; b=hYsI0uZwl1MwcYyLQsnEx/d4H6DkNI7RBwOkYA5MmwHLfD5zFoCOpx1VU+MhHUrCWK+g46ZCqvrEM5X6yWc7KPqt7o8C3vD4n9QLMQCSanytFEL8KaIUparvYQHxb4hHGdKeM0XXHI8ZdCTdK7AoRGZUafG3lIzLi/IACsUi7tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946823; c=relaxed/simple;
	bh=KRdJkqJajmJSxwFNAFr2bQT3ZXmWxDvGJ4oxkzGVLYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRzODeOpIyDW7mWxwY1CyTXEhrp4IYxo7wnDn/wm35zV/IDty+GWlGkfRSgWGyKJ0gkvjPgWQxvbYPeoPwqTstM8P/ytwEO67Tx2zxac8pYHcRN1jFbwXyb7x+g2X6wO1zo9PZq8vZWrOhPgACDFuxbxaFTfO6fcSDic7ioK1pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wgf+rae1; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wgf+rae1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYrbhizM0QdafsC2nKazMKlQLCXmkVzUouc0PbSxpFmvYQASINJlpdk/aq7Kn9gWHsYbFlSjrzKvrkG2VaralBmVQX+xk7FTzG0LVpA2Db8dooTQSC0LdjWRwTIEg7e36A6U/cD8z8BznOeHNxU8LkPfaMm2UxDaYO/z/amRQ1VicY1aEDTLjbR822z4Rrp4OyRlhzafMueb84HAWvOyLZVn/cmvyb4SO7gF8DcHHAheLck15A+oxt0n3dCCERJBrckCNHPyGGQCJm6FrAGq+S4tUHYqphPgmm0PwY2ycmtPMMD7cv9xXPGkeHpGEYn7Egmq0AGOitktd8pCfKzpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjLJJvbLF+URBQE1l7o+QP7oGkiL2W6wnYjK8+pIFv0=;
 b=qn0DVC8hDWBpUg5taRFGkkAafZMZif9ehW2WhK0k1bLI2Yba7w0eGxJDXuFw3Rrb7I/1sDNH/UjXFIj+252To+Yt1N9cV/LnKznGJzxu5dBLVqf2NsFDvVUDI2sEVHetyb9EDXKDSkHJWKH+Il51aqk90JjoWtizH726soOFgWOsl/VlftPlZ87IAcXAyhOTZy7nQJGLg2ipPgr/dEHyvLBRonewfp9ucS4J17HVAToX61rj7XefP2b1yLDyTjxLPSBKc2kYTPmEke+JdmUSkhF2atze7mlBQp3X8OSzfYMi0AD0lCJ0S/ZzkaI/pIWrI8Wamzmz3I7G9161wLylfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjLJJvbLF+URBQE1l7o+QP7oGkiL2W6wnYjK8+pIFv0=;
 b=Wgf+rae1IihEebeIwmmdfyxusoOL95YitxquxnxtndkkCleajzHY+84pDTDo63s3iCBrrOIy0Jk71vS1yP0oTre2qhWQ6hdRrcMt87yyYsmFMYjiVN4Drjpaj1mMMNr/49MOumOTQ08qnsepPeG5ilZDhI6IQ6lBzruc7jNEuXk=
Received: from BYAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:a02:a8::37)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:26:57 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::48) by BYAPR03CA0024.outlook.office365.com
 (2603:10b6:a02:a8::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 15:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 15:26:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 24 Feb
 2026 09:26:56 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 24 Feb 2026 09:26:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 3/3] cxl/region: Factor out interleave granularity setup
Date: Tue, 24 Feb 2026 15:26:45 +0000
Message-ID: <20260224152645.3441489-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: c28d92ad-e63b-4633-65aa-08de73b925cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Vz9ZFjv5tY9fQNhZq8vDndgURwfJu4awbSoqQMWENRx+Ve2CawEZKroXdpB?=
 =?us-ascii?Q?Ix+pH3va3fgQmvibPRRGkZnkX2YPljXpbCC7/r0xNZspe5AJZ0zBs+MiDf2D?=
 =?us-ascii?Q?I5gd2d3hKDnJt8HyzncS8ghIBWus2WrpXROYCCXTFz+DcMIuUu5gXxwlSVsH?=
 =?us-ascii?Q?ScNlKNcnVrnBN2e44/e7SFRD+U/unIsIWvqqXoW4DdJjoNizY1ySv102y8/3?=
 =?us-ascii?Q?AjbjhxphYnQuThFcv6YsTsBoUHK9RyDTpyMmz7GynfOIfRpCroRyFYvD/2gV?=
 =?us-ascii?Q?xBX8psemfXQwtQyGp9DwA78hgUsIJxDPKJshlbv8QLfK30Y+a/oDhsIRLtO9?=
 =?us-ascii?Q?J6pQxapoTACjbPZmgd7QA79g/YxuvdUyrkyuEITHWXUALfF41+NMkrRWikRY?=
 =?us-ascii?Q?41ap6XacE8wkkbjCx+RpxI2DBerVMus3SiHEbxyFXQcAsJJ85t693uSNoX6z?=
 =?us-ascii?Q?hCyJ1ESJmIowjr7UVUqJXeWr/c6gfd+gguKKWNQoVSo2bFPhuAbQo5K1aop+?=
 =?us-ascii?Q?GiFW7BBzaYqbSCWzGi4Fm6e/ZpLXpe24tR+MowIQFNEh3sn5Tfz0k+el/HTb?=
 =?us-ascii?Q?Hn4bKGpD4Gbn3Fp68P4p5xf+eSI988Yj+RH75DiP92ZPn/+vtXcIQdE01nGW?=
 =?us-ascii?Q?4Q/MYz0KGkSxPiP8bt+P22A7T9f38P47ELX8ZH2rSp3YGRUlCtnkyRvbsPYO?=
 =?us-ascii?Q?SQYCGJNjLPFv48FXOCQWk5L/LsonFAV+7Nen0VdoIK7OVN+UOvH5pEAexWGM?=
 =?us-ascii?Q?RKZlGsHerH+vAPdYM/6cf3RqdCZ0iauF7iG7cqOcmjYoqcNBWvcfBEhGPzdM?=
 =?us-ascii?Q?z5ML+T5muIKNTmFqmi0CfXiTmkkCJD2zatAwZq/V5evGu5nadWkqPCwCVpN9?=
 =?us-ascii?Q?ntkX+IGc4U+T/Fxc539m52M1dvzorsg3GYWE1StUbobmhWCP9ItC+1FDVy8a?=
 =?us-ascii?Q?OHuk5gHMpINNhZZl/yBS3bM6veA1+CLaiaed8BM9PMiB1SqBgiew5JQeP98O?=
 =?us-ascii?Q?b4uhqz0m80uaV1dgRkgGKfJ76vnWSC6z3wtyAwp3qA8a59xYIOLVAXQITx0o?=
 =?us-ascii?Q?lO0RfZWzvkQNC9nCel6i1hKmlStNO4lXNSYJvQyp40OsaJ4K5T1IJd4eyRha?=
 =?us-ascii?Q?XXvJi74YmJ3VrZMpqcByKCcOcB8ZFGjTfCTjZM0QppdJwh/tcf8z5x+ac32U?=
 =?us-ascii?Q?FPY+oOct9RN+29zJF5/zB24pHY4Ggt0P+T0oweph66J3IpypZlqxfZm+8WY6?=
 =?us-ascii?Q?jkqrKGUPLGjuidqhgyxAWZPzatrx/X8JImDwCsaktY9fxYjmTGVN0OaJazoA?=
 =?us-ascii?Q?WehikkgbdwZzc4YHcV+OVhUKfpjI3AuBOYnqwjbS1Iz6wpTBKtLMNp1968hP?=
 =?us-ascii?Q?CMSjQV0z/v5jttmr95hwoCun/zhgXhoxLBZzM/4Tk3DWs7mE8CNSVDDOrbYs?=
 =?us-ascii?Q?dHD1O5He/2A/Y8SSeYaTS3fSmalbKOsrjladta9nB2eXPsbCtGzi1AKa4NJ7?=
 =?us-ascii?Q?hK8WHI4yGbrNqAly+x7oAVsh5bkmxikeblbHAbECCSvMF27mPASX4INSI38a?=
 =?us-ascii?Q?KThx6BVlt4sCLc1uIdHv4EP+K7YBt01gVapueWx4OmWIEgS2RCV3/uObc63d?=
 =?us-ascii?Q?BumqljXpO+fyGrwFSW5LJdculhOkub1gzbRkSIDEDUeQfGoCl1DkLoYHEZG6?=
 =?us-ascii?Q?1Vpf/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zez+R7sqjCXCn6zPI4wwBQFJI12zHS9PprkJL/Bgkz7GZ+M8Ic9sU3KuEDhAVZqM9V7VLZADh+7jjuFyVT4nJ1Sdpez+6mthZMUOmzPjgaejWjMUobhb9uF4sH0qM+hkXnlGXY758wcg+TJjuKFbvwCK3UX61kufRIIIkenWUtDjZV943xpXzx90XpiH8S8J6NadKmnSrWnS5woBspSZtQ7mqXNfCq8UOSPjwRTOuOBwB7Sv0c+Z+Vasy5CtzoxNZa6DbBaYKD/82D4Ei0w7rhZmBAx6OCwWKZ/QmpdWZVoKfCDeZu8ty7N2chvrs5gYDajoDS4qqrHkzQ5BvwgjjQICuZurBCzFDRwNjlqE3yeLVpmr1DLW34TSPVO4MiIfYGUQ/oqxwKSodSMBRkCb00IVLsNKU9C4F6bZqc9Hui3/csWsZ/Jh72AKTwclxlt5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:26:57.2152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28d92ad-e63b-4633-65aa-08de73b925cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup forinterleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3ef4ccf1c92b..aed3733490a1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -559,21 +559,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -589,14 +582,33 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
 
 	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_granularity(cxlr, val);
+	if (rc)
+		return rc;
 
 	return len;
 }
-- 
2.34.1

