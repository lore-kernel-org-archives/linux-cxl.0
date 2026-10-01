Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CF2580F2;
	Thu,  1 Oct 2026 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856090; cv=fail; b=qGpqE5SOZQO4HZ4d5TVF7+bMUFP4xdZ8UvedvuRJIeetuWDLn7gAZf7IpeY28i46lUbIAo+pkVf1nIeeC1h88YUrrltG3ds1Z7gFX3G89MZGJ9eyIyb/mqEHFTI8pbrSzK05IV7zBdGh0hQQxlflp0b65ycsAjnf+IL6kt0txjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856090; c=relaxed/simple;
	bh=ixlpRm6bkOfmGon63Zy69B3fj7KZ8vh4kzeFvxUNmuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEFpE6HeLlXqc9H2pzAyrCv1sKjYlUPq5+VHmRX0UqEbHDbDf8uPgIjbSaJzJRvbYk3Quw/iWK4v/ZFseRTfuYv86Xns7KOsKuAW+06BBa67Ck4xwGpBAuLMyntuGLAFxn437MqVBsB2tNafICD9o1qZrIbZ86BcxJsIKQD/YL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=naEznPds; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="naEznPds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxha7C9sxTgwhEpaQ6E+zQCjkAsiHT+iUkFg10TC44MMa1Ef/CzWLIim6XzNVjEWHUY/cY18B1lwX7YNu3AsqQgGqyNqxyw9jtSNCWbb20RSMvrHNr+/KA68wFkKTI/4fKQo8vSuyggWtk2DbT7FK4duYyQLpNg/Vn/5nBE7xkcsOzPt/rFE/HLX3lL8+exh6aRb3bydG0rzb+mc79x8cYgFO5DyW3ZIb4iXHrKNqqyJfnCRsUf+hxIhwBF2qsutG533kPUWSHhgiwolsQcE/1h0T64xiBrT9f/WBos1+G0bhvvwJeOKPZ/jeeU83/E6IwtdO1Ju2xRiYS00TvIqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aorIkc0HWa2KurYiqIBGnyIW+qZeSYoo5Icanm1lHAg=;
 b=S4Z3Uj8KbmUbktjXIivcPvOd8/KNTThZG8FQ+uAZAU3H3T5gJdisE5eK3nEZvNVKpKBrxhfm5Bgdsw4mP5pH/SDOtbt7OVj7NLcOysZ89ifmHhp2MW60ys2A7kobiofVzEVSFZYQezduceoyLgzPADt+nmJLYX2+K1JGe8dOpv06I4IEbk0AKcSQWkAxabMNMH/9zB2gUPu+9uXa8WbZYudDFTGGgcmbvsGtrMQT0fh7ZBOJTuiyB5e5JqChosxb0+SYB99joyssI4uMfgsZ//ASB44eTEp4tB8DlK5+O5Ff6HyfScuMSCrDmXScNgbTlnisD9SvhPuoGWU3BA/5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aorIkc0HWa2KurYiqIBGnyIW+qZeSYoo5Icanm1lHAg=;
 b=naEznPdsGemp7RecUlr0nPJ5PiSvjZvM78S5eBIi39O3MNSSWLOe8WCCNNmOFHtOq0V4PUygZt3bd/FMhQFfoS+4Vf/870cUCBIShjLuMkrY/swptaGlr1XH8C9b62IthXammoFi/iCApd4PenxAKm4jN99f6M3Su2h3gG0AEbM=
Received: from SJ0PR13CA0168.namprd13.prod.outlook.com (2603:10b6:a03:2c7::23)
 by CH3PR12MB647349.namprd12.prod.outlook.com (2603:10b6:610:365::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 12:01:22 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a6) by SJ0PR13CA0168.outlook.office365.com
 (2603:10b6:a03:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 12:01:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 12:01:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:21 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 07:01:20 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
Date: Thu, 1 Oct 2026 14:20:21 +0100
Message-ID: <20261001132023.17032-3-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001132023.17032-1-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CH3PR12MB647349:EE_
X-MS-Office365-Filtering-Correlation-Id: 98dbdab6-39c8-4d04-1b47-08df1fb3b607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wgv5+7pMQEvfJoSaUrcmoZrZ4usBdiMx/SDlHEWkKz5KxcQMRjSo23+gh2KR45+MOZ3Szyra2nEweRgSPGvqLPamTedb1OPkOyHzmiSgwOzvkAHbIcL2unXQeMW1vzwB1Bq7V/SekhneCHhJM+KuHWQ/0ONiM7gH+j5jt87rxjYo1OV25/i9hCPRKMf7TX7qYONUPgQ9jTNMlxpiDCdd0ZfT1S5wqE68CcILwL3C06cE+yvCOJk8TAfxpvnaZo5iOqYu60yUApbLpgQqa3px2sZQWUeEiuSZA4+5t1VRbJUEx67ARCuYKOZGICz5ZHSKOadKZkTk9MOAvI/rGUnbySPVqto8VlwhUAix+u3GZoP7MLBkwSnvlH62dPAppbI4gmhvEvoHN6VgYGyh9JEUqG5901I3v6x8qZ52OpjGKOFAySsKSqCPFmPyOuNyoKcvgglMuoOk/NW2FwSwGlBOVDXmYx0nn8dLZGnTu4kwK+fk9OBkxAoOZ7KVy3IYOXl83i4AZzny1K4531rWyqXXwkdFtgL8NbGXRcnK1Q2pJtIJcG1WnaDd+e87zSUQfRVBZuDbxV12ngcdXPhuG40lpbOjEJrqqWk5PGdTlYcy1FNSyqov1RP8CUxYqRG/nUbNSPh47h6vwqPpV59O2Lm1QbokqUuJR9F3D6T8JqJlyyXtSh72K6oeNIDqryIOGgTTq3661lAmortUzHbZrX4kkA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tnUUcdFF2a9STF+RKFl3EQghWkRhcbtXqisHmtswg9cDZEmKzBb6089HDflpDKjFNEaFx32QgTKaOVmY6YlIy/f/e7XOo0hYsZom5tTMBaNuFZHukg5z7HKKOVUayFDq4whN2Lx4gyo6dVeTWN7UXG5u24w9OvrvD9D1kChPEyeaXTyHrMJ3d5JUu0g8NtUtCjTpwZ/O+9obTox5EToo1EyrLJ3ATNWZ5ynEdRY4pLknOM/9hDXDm7fYQ+bYNqmS2LSbTkCvLpYre6nzUXeZxmrWY4kCej3jdJU7elcSIKMOU/NVkH39tS3z0o3/t6dY7tWpfsAs0XcEHPC+u3pgv5xPssUy1Jo+Dkii2+GTOQ8jyNcJmIhQ2+QECvMYjuYDQlXtYBPLXfQSSsAFiejhOucbdaErY/sk5H0yRHIiDk59SIZPAhJ5HZgb0pUMro0r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:01:22.2414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98dbdab6-39c8-4d04-1b47-08df1fb3b607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB647349

From: Alejandro Lucero <alucerop@amd.com>

Use a new field in cxl_attach_region struct for easily link it with the
region the memdev is attached to.

This facilitates device links creation where such a region is the supplier
with non-PF0 physical functions wanting to use the CXL region being the
consumers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 1 +
 drivers/cxl/cxlmem.h      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..78ca7ebc3e55 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	if (rc)
 		return rc;
 
+	attach->cxlr = cxlr;
 	attach->hpa_range = (struct range) {
 		.start = cxlr->params.res->start,
 		.end = cxlr->params.res->end,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..c598561b8e5f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -104,6 +104,7 @@ struct cxl_memdev_attach {
 /**
  * struct cxl_attach_region - coordinate mapping a region at memdev registration
  * @attach: common core attachment descriptor
+ * @cxlr: cxl region the memdev is attached to.
  * @hpa_range: physical address range of the region
  *
  * For the common simple case of a CXL device with private (non-general purpose
@@ -112,6 +113,7 @@ struct cxl_memdev_attach {
  */
 struct cxl_attach_region {
 	struct cxl_memdev_attach attach;
+	struct cxl_region *cxlr;
 	struct range hpa_range;
 };
 
-- 
2.34.1

