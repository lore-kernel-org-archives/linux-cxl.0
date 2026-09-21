Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F894DA540;
	Mon, 21 Sep 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013359; cv=fail; b=lXwTJL/6nnlCPopm4Y5jZah6eA4AvEAOPYSO2j0lxie4WCitxUJRzg6b5MoKQyTgOGaZzrhg+Po/Ohpsmjj5/fD5wYwupV2uKol2EO3jqZVZWEfCmn5/8bBNTcekGJFsyMSR9Ja5TyMW25pw+OVOgc2guoO3d6vbTf8Okh18HaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013359; c=relaxed/simple;
	bh=fGErNgzHd5oPsoPw0XmyIj+xqIKgqHMlCTPVJz68j1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn1gd35GvXopU+fgOgEzzjspyWBR4tHCuK/KPjIKXFdnom6ZV0eFHYHMLAuEwO5fQmDhZDI+BtopS18Hpilr1fWipWar4CWxUX15wcCsLR7YcnkDCD6WwVAJyWT56Me6MUvnNa0dyGUXqs4CUT8BCbKNBtPrdP3c6SATumNV0Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N/vltTpo; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N/vltTpo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUIOWjEVB5/wQHmAfzBAcFtmO3OMtfr59iRoXNYdcNyMA6CNRzGjSO2AeVgJCVk4s4rSBoBiYKkaX5QsCH/QSP6xkcvLycaiK6/aaxp3c37VdLc70olFv/z7wUJtMoilpPdWGGMjvp2JwF8MSSuFyINuuzBe+BKJGZZ25ReUfyyndefjh7V3/aCF8FFoH9EQGcUtBPsnnm9rmyPtgfGpkEQqNTW/9Gx4xgIChcTNztsIQvnH0gbhC8+QVNNto/dRvN5D+arR8fjqHXXj/3R5+LTOpBRchxtOfTyHtP+IljTg/GOlINxfTv8B4WslmVOCIvgUj+CyrNEIL5XOAkCQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlnfl2uCkEoL+4boiuau7MAt8w47zdRmmK2LxZTvLLY=;
 b=CuxD/Dp5Oh3GsipfF7w9psS6JTTpSxQW7d4RGSoboDiMoAkTjvXTE1CL/+ia1IsrJcUbtLXJ5a0AOsMTynczIuBXNyZGyZ1B2cDS3icx18bjk/a/cZyjzbGciXXuzox6UGkD3NDc3KSDrNkJWBrp0r7o1XqMwAvQIsULD4TIw4Jnfb000O+EERIMwEYc5yZ6tCuGZG69Wq4QUveU8A3S0rcBsPJ5mQ9KzQr0DcYrthEBly24LF1VWLPleCFN+/UKq5CDODVbsPu6PoCACwpEF5he3EL5nwlqmrwkOmlIIQRBdSqB+Mon6xQXz+r8cmLtBarzbg/MWOybkcC47RQbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlnfl2uCkEoL+4boiuau7MAt8w47zdRmmK2LxZTvLLY=;
 b=N/vltTpon1bGUwxTLYMQpfOuvaJdHoCnoMl7xT/yezyBkx2IhB2MVH+pCmFa1+6VIN6PpwRp6qqY2QP9Ttvg2Rz7WV3jeL/k6Oe4CuO5YUB+oWmIXVV4pHFx58gkCn5peRW1YQz1xeGboyOuxjiwbPA6l+/qeELImeCf2n0O3QU=
Received: from PH7P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::31)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:55:53 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::98) by PH7P223CA0026.outlook.office365.com
 (2603:10b6:510:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 21 Sep 2026 17:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:55:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:51 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 21 Sep 2026 12:55:51 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 1/4] driver core: Rely on supplier driver binding at link creation
Date: Mon, 21 Sep 2026 20:12:36 +0100
Message-ID: <20260921191239.4249-2-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921191239.4249-1-alucerop@amd.com>
References: <20260921191239.4249-1-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: b9eb7ade-d6d7-4545-6a47-08df180993f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	HfN2RIeYh73M/jEv+Ei8pdVUzI8mFyaRe/eNEuzV1woXlDndPEzNnjuWFTziBQxKIpjGjHtWR4fXH2q84c5hLbxv8wJ39HIhDdcMNa9mBPUv+oEtFKHyG1NuHZd7kuA63CGuJyVMANimFBH9MK2Zlg0K65hAjiYeu8Nst3UafRfEZzGGfc4p+pLRsph9Wc1Lh9gJDminnDlMj+TfSqrAxhvnBRrqS30v5kj1S1QR1CYrgT/20fL8dzdZ2GoOUAhPWj2AMzo6/Uo9MFP3MyIlAFbfnwm3MNHP9O0Zn+O3G3GU1Jy1O6r03xnBlCKN6dwBJXDSViwzBhKMnaAt5NhjnqMbI5Bl86lpTQEamRnbwpEY3a76rIk2cVwJd59RUSGe6Iopb+Ona/njKu7HUio1u9AIbUXd1fb5+euVTUwSKj0PP5+2XjZeclRGruDOD6UqFJ7tkXI1Rz0WBAh6y8fJ8Uvv/goIfiPhwjMiN6Z+gBMTj39Ax7FMEcy6P6cpuOY9/pAOw9fjEVYZV26KOc5+vEKxCXY3Gvdjvo8XMinXwg5r1Ve8ZbmPHOhwNSKr7KTxdkpcs6VvWv+Wezvd69vCb9OXky0aiGizwrRcxW6XUwORbDs7rU6HEbioyCjNqlJQ0kn9SFQZQ7LYTCoLTCRH7s2qwetoUy+P01bgn875cKWQIk+/PGwxi11HrjEIN5f9fNWHlDuunids/RfMSygQmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fu7M+t5ewsoSGIwed3B0JiAEL6fPjRqVEfqPaZPtlpmLKsdmCd9fJ85jg9++Bf6oY7b+25zRRhjxI1KSXFcqnGcvIuB7lMGf4tQNE4eYF/aMXilPEIxQ3Jdz8I3bxHqRNnJz3IQo0GAPTpDR0T4Fflsw90yOz+LgvXUjwLrmi1hyyJlNFCZnDH6FMmeqK70GCsSYmodu9QMM/ijzOiOjxFauPkDB+v1I0Ni8fM6gucJGcL7lf597SxyWxLklIVKQEbWvJQdRPBaion807fQ735xojCI0SFSMhW0uHrckfFMvmE+WNO7dxS+EEqrCBHQXyQkc+zHyefBblSbd8DSqFUlyrxj9lqDfyioXYKFKDFLNhd0kY4YlU+xu1d8AEbaeN3rSsMxW1rXKEzO5WM+RmG9KSSFJAOP/swHHJuvUgar7y4XTq2rgQMi/eWSUcNBq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:55:52.5354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eb7ade-d6d7-4545-6a47-08df180993f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602

From: Alejandro Lucero <alucerop@amd.com>

Differentiate between driver binding from PM dependency when a device
link is created. Rely on the device being bound to a driver for validating
the supplier as some device drivers could not support PM.

Check for supplier's PM state only if consumer specifies PM_RUNTIME flag.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/base/core.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4c0c373998a1..eb6d87e35d76 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -834,15 +834,26 @@ struct device_link *device_link_add(struct device *consumer,
 	device_pm_lock();
 
 	/*
-	 * If the supplier has not been fully registered yet or there is a
-	 * reverse (non-SYNC_STATE_ONLY) dependency between the consumer and
-	 * the supplier already in the graph, return NULL. If the link is a
-	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
-	 * because it only affects sync_state() callbacks.
+	 * If the supplier has not been fully registered yet with a driver
+	 * return NULL.
 	 */
-	if (!device_pm_initialized(supplier)
-	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
-		  device_is_dependent(consumer, supplier))) {
+	scoped_guard(device, supplier) {
+		if (!device_is_bound(supplier)) {
+			link = NULL;
+			goto out;
+		}
+	}
+	/*
+	 * If consumer asks for PM to use the link and the supplier has not
+	 * PM initialized, or if there is a reverse (non-SYNC_STATE_ONLY)
+	 * dependency between the consumer and the supplier already in the
+	 * graph, return NULL. If the link is a SYNC_STATE_ONLY link, we
+	 * don't check for reverse dependencies because it only affects
+	 * sync_state() callbacks.
+	 */
+	if (((flags & DL_FLAG_PM_RUNTIME) && !device_pm_initialized(supplier)) ||
+	    (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
+	     device_is_dependent(consumer, supplier))) {
 		link = NULL;
 		goto out;
 	}
-- 
2.34.1

