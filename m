Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A413E716D;
	Mon, 16 Mar 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692409; cv=fail; b=gAbrLVXHn+qhj2EQu9CJSOsLT4hx0ixr3GHCG+rOVjfSz0kk8TbobcHCei3FdjaW7Tpba0XQ0Bo6H7mosLwfkLqvnx14T+vV6NxlDuYHqiYjTDD5Q8s4oBaFk0sdTx/T5XjBtZAzsxC1jsEgTl/EvjQInqOVMp/8TlOVpIrWkJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692409; c=relaxed/simple;
	bh=4pYzcReI1gXKFgr+fXEn7VNn8vfJ23LoVRo5ls9DUQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hGtt2IKAjqbfdl7w2tQA97UAlLt5O+YBhhtcBwypndwx+fpzlOfZANU+uuDNIN+U0MxzUaGc+BgbTZRGgR+Sf4ovBwBcuhMRkKTNfGDPgPN1ErgYu1h7CHrPd5kZV0RV1RiEwyqNzYxNpEU07UC2r8wJSfBMVvzqQz5v/pz3BM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lUmvAbvY; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lUmvAbvY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPHEIKhvMZH4ET2Eemoksw14fxecCLkNc8/4tDhIyDMKEYO94GIrZO6Bz/T8GntypfTYv8DZ13lHKrMHq3tmwX4PSeC6tNV+5Dv8UOIjCwrhBR9/qc4K1DxMn4gs9l1Ny2xsCfxCmIo/ZpW2/4NVRkwN2mUnZr7oWTGNSPAUZmYSSa0cY98SzL8LZXlUDJBxvPb3p2j71B5nbsKCCT3BaBqvwvW6h0kd8rkUuAnqI09eQEkYy9hQW8C7Dw+T9Grjm2kRAt2W5QO2QIFym4EtVxp43LgCe3IelZRliF8PA0M4Y1sKqWSmM4mkffqXBkFy/7VI8k2oJqrwTMef4SZvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvpgCqUoMVm23kDDY69GafcAg0/uNkg5I1oKKuns2sY=;
 b=Op/xkIXj1Z3jOtrCrMZGZDJeEKAit37ToKuSdBNMfxQXCnRqF6m3P2i+XUdVymEJRi6JdElqC2Ne/s3ZL2HCMlenc1xQONbdQue8C2mCgvia6nMeHU/BvvsEdDSNe42OXHbYBfsWH/6fuG5Amp1P6GNDcsUbGyYx+F5S4KJ5jO88QcN/woG2VIweFJ9N/DxjeX+f0wqPWI+tNJ9c7eChuWScseRhrmLfI9PgYFFr6jPhP/+RC98qE7KxqljVJ1JKoXoBHf3OxaKKU95mezI8t8Ip7lZE8zpH1nQuMPc+BRT0viYZB72Icyiq8OprKqrzb6v5q/W9BW1aeZ2BSNLyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvpgCqUoMVm23kDDY69GafcAg0/uNkg5I1oKKuns2sY=;
 b=lUmvAbvYQFjKiYcL0+vatsmMs3Ps6k2isxAnnXirh+VtaESPAaxKUKDCwddt+xp1O3me0EZYpOPJUuAX4bIDwWgoRM6Bn1JPN52pd4xzi/frisK5I8R9FU3QrBv0Nillv2HJ37pPlhtyRNX7x1kMxHuZt5Xgrj5y7mfNoK3RLnw=
Received: from BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::21)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 20:20:00 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::2f) by BN9P221CA0027.outlook.office365.com
 (2603:10b6:408:10a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 20:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 20:20:00 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 15:19:59 -0500
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2] cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled
Date: Mon, 16 Mar 2026 20:19:49 +0000
Message-ID: <20260316201950.224567-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4955efed-bfe2-4bc6-1f52-08de83996688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	u+ybdTwX3vR0/O7JkSODSb8tOk5LQAVlnKYud0sdnYsk/+xFRkym6dJh5rSpa+5qJloqAOd0wnEQcptdGuYC6AXXp1UN6XUGjptyrE27C09+SX3vSiOGQou48poLxor/kpqmVJocIq3F0n3djP0g73Qye0JIegYRGP95LxXpSNz9BBM+ZAspDCfSy5TFtsm+XgCEWAOAV7CEJRSds0FI4jrFgZg+R9yZP/oRmSLR4lYxzf67JHY5HYcTbXWg8wLKdrCaW4szccQyBr3SEgleMdDvvAbUc5vJd3ovsJQjO5Rpoio/Z9XzNVU6U0iZDlDSnEA3XqmErLqKfvWA2OCguTgGeJsttBmqw/H65rSvH4uNkBvcw+RLNbbkuIYp6BlJcIWoTsuHXfxP3aGL23lX68nXo4LX5iFxjgsF/xFMLQ1lhPj7CJQh63U4OUuCmqP6G+1pL7Vhk56HkQ3HAEEWP/q7x6Ll3N/35TYHT6BHGtlgfS0PLsKHSINVpoEQWOHoNV9R+EKEU3tVASV8M/58FuWw+UkMN8NX3Lacu9T6rv0nM6vwYfU9JyGGdKu9vCf5L8fgaW9DLnXaE2OiOTb97y7T+MVo8QqAWCIYgFBUZrGnaujYc0IRdoJm/hAGkcmKyycDwveSDCtsmJ9zxyOr0JE6T2Z67igN8YBjgXqbovChyOZgZwARYw9lIGJKYc10lbSjYg+TTaWIfdCj51Pv/1ERONWVJVmKVrkz1eUS2dYUN4vBpRIDs9uSm8LUn/SHV5pqGw5DXpJWbwWXGtO5nA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	byB5+4iiYj/XcUf1Y/zZ+0tp7vhpIqT76ThRF9cbH9PLvsBIvcLPTLIhICwhetG1g5tjS51nZ57UKThFH5YcQkcrHnSdWUtLpUuBraKLApkV4RgaCyEZ4rT/hZR3JuFUMlqbN58SFl3lHf581v1bMWSFHwOgsvBoQL2wA1aT0t8GFBSWkrcIZo/qTL0MELWdc5OFNUzO6rjSBBObIOwybGgHHD/BPvGT4o9PjSxp9IKR8XMzpin9PwlCBsO0MWDMIrHZ1u95DrWHIu3K2oO/3sJOi8dtUiTk5fZCraqupSX+XLX0enJjfmlGBv5SaOks3gPUjb6Lu8K0F5Nnf/HmMk3LjwrTj5Vh4EWlpAo+MwMW8v2aaWR3Y1m1u28rKU1V4Ul3Tkw8RqAWZw/Si6AvZtVfmGzVPmj2GMVqqt1SyHKxE1tMm8mm9bmgLA9ICJ8d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:20:00.6171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4955efed-bfe2-4bc6-1f52-08de83996688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

Check the global CXL_HDM_DECODER_ENABLE bit instead of looping over
per-decoder COMMITTED bits to determine whether to fall back to DVSEC
range emulation. When the HDM decoder capability is globally enabled,
ignore DVSEC range registers regardless of individual decoder commit
state.

should_emulate_decoders() currently loops over per-decoder COMMITTED
bits, which leads to an incorrect DVSEC fallback when those bits are
zero. One way to trigger this is to destroy a region and bounce the
memdev:

  cxl disable-region region0
  cxl destroy-region region0
  cxl disable-memdev mem0
  cxl enable-memdev mem0

Region teardown zeroes the HDM decoder registers including the committed
bits. The subsequent memdev re-probe finds uncommitted decoders and falls
back to DVSEC emulation, even though HDM remains globally enabled.

Observed failures:

  should_emulate_decoders: cxl_port endpoint6: decoder6.0: committed: 0 base: 0x0_00000000 size: 0x0_00000000
  devm_cxl_setup_hdm: cxl_port endpoint6: Fallback map 1 range register
  ..
  devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region0
  __construct_region: cxl_pci 0000:e1:00.0: mem1:decoder6.0:
  __construct_region region0 res: [mem 0x850000000-0x284fffffff flags 0x200] iw: 1 ig: 4096
  cxl region0: pci0000:e0:port1 cxl_port_setup_targets expected iw: 1 ig: 4096 ..
  cxl region0: pci0000:e0:port1 cxl_port_setup_targets got iw: 1 ig: 256 state: disabled ..
  cxl_port endpoint6: failed to attach decoder6.0 to region0: -6
  ..
  devm_cxl_add_region: cxl_acpi ACPI0017:00: decoder0.0: created region4
  alloc_hpa: cxl region4: HPA allocation error (-34) ..

Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v2:
  Reworded commit message to focus on root cause per Dan's feedback.
  Dropped downstream details (IG/construct_region/hpa_alloc)
  Added error signatures.
  Link to v1: https://lore.kernel.org/r/20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com
---
 drivers/cxl/core/hdm.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c222e98ae736..cb5d5a047a9d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -94,7 +94,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	struct cxl_hdm *cxlhdm;
 	void __iomem *hdm;
 	u32 ctrl;
-	int i;
 
 	if (!info)
 		return false;
@@ -113,22 +112,16 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 		return false;
 
 	/*
-	 * If any decoders are committed already, there should not be any
-	 * emulated DVSEC decoders.
+	 * If HDM decoders are globally enabled, do not fall back to DVSEC
+	 * range emulation. Zeroed decoder registers after region teardown
+	 * do not imply absence of HDM capability.
+	 *
+	 * Falling back to DVSEC here would treat the decoder as AUTO and
+	 * may incorrectly latch default interleave settings.
 	 */
-	for (i = 0; i < cxlhdm->decoder_count; i++) {
-		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
-		dev_dbg(&info->port->dev,
-			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
-			info->port->id, i,
-			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
-			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
-			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
-			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
-			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
-		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
-			return false;
-	}
+	ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	if (ctrl & CXL_HDM_DECODER_ENABLE)
+		return false;
 
 	return true;
 }

base-commit: 93d0fcdddc9e7be9d4f42acbe57bc90dbb0fe75d
-- 
2.17.1

