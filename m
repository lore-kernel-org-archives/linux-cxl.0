Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F349233723
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022168; cv=fail; b=RVC7zY1+edjQGIi9nVnXvrPgsAPGct0s+IW1phWfQCIe7I6eYPpH8ZYdT1qyPpBQOgo14KApM4A89qA+9bmuTFNGCHw36i4JsFa6nolNwcQAlyrOMIJn+Cq4EGKK2yeWmLcSdbg/rVm2AQ9ZPvlLswQIn3iuiyycp5w5msB8vfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022168; c=relaxed/simple;
	bh=3dIvSxHq733cY4BqZezEvLKzfP9oq+hAKA2Vj+ZAyoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q64697A6zp1zrazyVjbj8AVvWcwI/VqvK9t+irrTMoj6q15gqnwNIV7cRrnsRCemq7cEsLOsxrBnBS/qkN0LEICqDyWVrAUU+8bpDDCGlwAWmOPHbPAqlkAtgqsphU9GQc5L3YcywR+Y9t8neJWh93ii4q1BW1teuHxBahrff5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMvUY8T3; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMvUY8T3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0YPbLlTyKvirx9JwmLo8Fhdxb5Vlt+/XuhGYuPf2U/ZY6J2PdODiqvEQBMwcPW5ceXSw6vUMWobclTmH5ROQ/uWM4IpsshjFB3pwR8FJbfLfDpMtditROxfG/kTEzvc2z+vindbnXk+Dp/yAQJtYz0l5vmQeLABCBvDUD07NlvCKhV7qzxH0tfQ+Q2DqpOozzVjH/5FSyCY7h42ZOZMRz9sSVTQuAqMLvWEVRtHYCa395+2D+wBHrW0TIWUxSt9DyEM/WNNvcQv3lf6iObgkfWZq6KOdgCKj8ZCnotZ9OF27sxPn8glhHun7DGltMuhcg8MtBE8kVs6YwUv7w93fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6zFoozRbREWaL7gLBQAdnQM3FFL5v3WkV1+0uWIa8U=;
 b=wV2OTfep57nSXG3r5fCTfe4x/FXdDBlgPui/3avXgp5PuPIRnrZUGhLDrkat9HXbHWU1nNmcRmxZZtEWCTWujGGo0TQzmCR+6kjkTWQx9pHAMiAJ4T6v9C7JzoQGjvN2hUr1FxbMu0WEpwuyLv5z2p2IZuebdiv/+Kd4Y77PWW4b0EfzDErFJJtFUuuVvaCDOPMYB+ja1b5DT0qCpCdabDS+9Z5QZdf0rrzsWI3UyV4IowOgyXXDzN6JKSJ/wJMAhM8VVlruSnZFLEq+owF3gTBe5Nf61enjOMilY6+zWfduOVJO6SexKvXgYyNT2RiQz3lopMSGGevhnscx2WeIyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6zFoozRbREWaL7gLBQAdnQM3FFL5v3WkV1+0uWIa8U=;
 b=QMvUY8T3yLrFmoMqkghgXnUv1m7asiM0/TstjzJ4vKm7PsxkKqp0trMzAwiNR75iAx1vnHW7ZsHS6y1Pvl+TBVZkyCRlzfLzNHkJIayRX6QVOzL0wyT/6TaVy9Ai/thh8QbTPD0J14Blu+pQQUcaaYJe172I8KiBMM6qkfsjPTo=
Received: from DS7PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:3bb::32)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 12:22:40 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::12) by DS7PR03CA0087.outlook.office365.com
 (2603:10b6:5:3bb::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Wed,
 25 Feb 2026 12:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:22:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:22:39 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 25 Feb 2026 06:22:39 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Gregory Price <gourry@gourry.net>
Subject: [PATCH v2 3/3] cxl/region: Factor out interleave granularity setup
Date: Wed, 25 Feb 2026 12:22:23 +0000
Message-ID: <20260225122223.3841889-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 42be026f-5f75-4bb1-f047-08de746891b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	N0gVla1X/rulAu8nnUhv012TpCPWgIJUgR0AZ976T8T2yuNfZYipXuMhAVX5ZBQ3bGEvYe3MeIGK1n5ya474hERTukF7SkVXnUbqRuajhWc1KusjVJPQmaMGjfsMVrGvEg8JQDsSX2RzeJHH2jUlAkJIcrEjtYhnJUbZ9CPXKQhJjub/YipfRMaiu6E/+oe/6qiTrb2Cnnv/u8V+ASXoIUu5DsN60rem8moP4h//YXR8mKGAPhoAXiN9PRnUpFpwgYgu3CEirc5xprh+M1l8Q+iiUJMr8Js6RsANcq72nQC6JnaUMT22icnsGGukkQN2+pt17WImdzIlZ/AP/ZEFp541ZTW2+S1yImdqb9uV9z6godbUeKlKfgFti67aevF+oTsnu2OXXBrGgW6GsMycT/dzIrSgFpuggqfgA0KWSC3efc9zowycKmTWM7+0nsyENsZUQtpRPLzh0LdTtyZtyVvq/PyqDEjEm7393WOsjai3P63w+lfHrVJ5QmxwLY6b8gbPlVnJ2JdaYsbM/ofGhK7SSLWcFy9u3cC7Vy+VpVq8ruXCKmUT7VfnWUVBCDmjJxdTQuAmX0wduGwK7bMI0Ub089x/h9XmiCJ2b8szVLPSuL5tfEH0/3qLdOdSc+usPaxeLnJM+xD9eD1OxUUBS2qK04H5j+9Xnr3t5IIhJPoF0UgSYsByBGxBWcsFJUbpHEggTo01G3XHfrYL/46OD3iOG7LFy6CVpI5kBEiuAi3sS+JExMOh3Gg2IxJGJGpPW94HR5acsL2THxETJZyqZwsXhhvjt09Dd13PvTehhA4IJAXLG5f7dLf6GjnWwVesIO6AhVf417RSacBMYX1LNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HDEfXGHs7RiMYp+DxGtqzy7Mbouqim7tSzu73eNj2ltplH+WYq6DGreWFlNri9gIxY9xiaMQ2F9HphpfWAqDI5GRIlKKLB8KLjiJw+Xwks206DMf0TRPu3XzYrTCMZtM7DNgKbqmP7ygIJlYRy/nwqHwQdc7mVtDHrxS+k7ZHTOAkuRN+XR0/alwYDtkk/jlNcDY4jB5JZLM04kiy/M+DCD+7ziTALLhGFQcbJXzYjxZrFjK1pBD3wxywBj7rnzf+jK0SkAohhugms+ikTCpkhgzVyXBEu4PSZqz//N/bEAlRHX7kwEKQqlvGuYLOTwBBMPQyOVUDiyVZZjxJHOQN5ufB2G2B1/nTirbf05Xh4YmH+AaqbMdyNQIFQSvUcX3JQ9+jAqh+IktZ6oFZ4/SWbCI1gOxiCxJy+wYDOfR2XzA82ByuOyZ+i3MWkGbowyE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:22:40.2629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42be026f-5f75-4bb1-f047-08de746891b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices can be triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup forinterleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
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

