Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6453ED5DA
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829035; cv=fail; b=d9qwNhGH8P9H/vM6TYcZ40xa2+4XDfLUYYiizsCdhEQHRDFJcy5ALV+yJZJhu2YIcs3NqsavXMoNrS2XH6wljWzjLdiXZjZknyJraqQ9FYxyNVvaC/c/8eRs0PTiyhCA4VYCsPh+nG6MSIfeGz1cCqQZ6Um5Zw6k6zrRLnrS3Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829035; c=relaxed/simple;
	bh=ov8EHoCoy9QcscP/D/97S3qyCtLKCSp8R5oAZFJsgn4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1jhbrfJuM/7M+vY2l49m7KOdMiOIB5G2IEiz+jYSrHyD5OMXe1BvM5yV03aNsdszjAnE0FMa18+Gpdodb1OWT/L72KpajC23VMfgXI0ftIIlzAoIRqHwyElUc+TZag1H5IsI2kf4s5HvoIqfi7Qf8EIoBUya5S1MFQ9ACLBLug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E/5ViKne; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E/5ViKne"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcZfKauAYJdxvDoUv7H/fN8eCjEgWwi44doblIUOu6xO+tqg/G1PLqKbBYCb+39c1ZXCx4H5ux4SY6tab6zfrRkVFzVG0W7y4WCQ+9ABbrK5X5FW0wpP7VeA6w67HbFDLFP9HHI0mgb5O1QOu/TQ7GWUkmEMnDGpg7ZDHfjMihR/uheBqlU4W0nqWHJ8fBu842EdPS15mp7//pTg22MlnO4sc7z6ThwJBAJS9/PDK/U3DM/4RiTSlr3NatnhVdY6IhpXklneX+RtfE924/YdCzCeiG2BW3S1kdioAWnfcWRYU0Ey5A4izwI89Wc2zsD8RU4Bk4pQURyRe9w02cyyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouSbfFNDvMQOsogoIdkHVRhfYsKX3faKGYvvMEoQ6Ck=;
 b=RjHTG4pZF1EmEDFSUcQw5KZYY7y87tqjsRloLU8FEL0xm7t4CncZ59hsMl+v7jNMVI609s8Xj2jvIoDjXxL4hB3AyHKKeNOiPe+BwsaVSeaMaZFIXFSrB/UQuLYg9voQ0orBcSJGNhKOfdyq+zy757DeR9+6HKnv1wdlvcf8Cwgiiqt5m9Y7rROv4wCkfBokcT7Vh/DKBXGlD07PU6I/CmN1XXjjln9PcNZHpCSibWYXcTsiD/h1Mskb0/nh/6Hdu+ReW+FxMQZmhBvVBaqNMUMv+0FPcp9I5pV2slAvKqBbVqmAa9nHzMzS7/gBwWHWShy1Wmw/TzOKztFR/NAWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouSbfFNDvMQOsogoIdkHVRhfYsKX3faKGYvvMEoQ6Ck=;
 b=E/5ViKneVWYJlOdzB5Lzumrk9cDEjd6Mvk41bX19DOkvz8JF6eD5RtFn5pBX1F2Bms1y51xXyIzHIkvpUuQlQNrO7G9WuUIcBIEpNBr4XRHw0yFOovhJwg47itEIfZwtnH0Hd7RnkIO9uCxMevA+b5pm3ry1yr19HHR0bMkcY3M=
Received: from SA9PR11CA0004.namprd11.prod.outlook.com (2603:10b6:806:6e::9)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 30 Jun
 2026 14:17:10 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::16) by SA9PR11CA0004.outlook.office365.com
 (2603:10b6:806:6e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 14:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 14:17:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 09:17:09 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 30 Jun 2026 09:17:08 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <djbw@kernel.org>, <dave.jiang@intel.com>,
	<kuba@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v31 0/5] Type2 device basic support
Date: Tue, 30 Jun 2026 16:13:41 +0100
Message-ID: <20260630151346.31201-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 58708df7-5802-4154-e315-08ded6b24648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	K0vtAStv7IxtnsIRd/rO5q5K+HYI17PUVUrJ8GN4o/1iMggIGO7acQSgc/VRDePI1AAY+W/MEYdLpEmEBqbjG8vL61chLGdUsm0QfGK5kbvweGYTeFYyBExgCq2uzZPoSLP+Ozne93kS9Lv9RucIjT4DouSOYNY9A99KWVBeL7jEprT7qVVBRLJ9eYd9QpCzvj4+YfU10JPycO6+R52If3havf7OMRdep+WuB6Eof3csmvdhF4D24pefUN3F4FUP2ZGvZtzhFbcbmKxCgSEBxujTbHGCmJCoY5poHwOzC95aQY4Y5TmHleyeGcyj+8VBeoHJ73SawGucUNz8TQkOfzwxkBlZgqm67FRQANgdrWqezGGFSDTA6z2ulRiuA6FjaI5Los4EQwvPltiyEeLw7aGmVX/Hnw9HUa1qM8uYK2ALi//5GbBb12NmWaiug8UJPzPcZq6WXcQe7nQJZUB5O5BkhAuzIM46yTpod2npqQXT6WBhVfDbfa/5oEiyJZoa5/3QJ+69CyUI3qZhicptQssQPdq/zx/qyobOgKVLC6L5jjuO/Wx9SWif6ChtpVXEoQA6qPbtB2t/TdUDqt3HI2dVmORWMQ6lLQv7edjo5rEIH7IkYIO/XUp3xZ1ERO1nNl9Gi1jlQkNoGT7mNPzC9YEBxkwwFzF/OZVQU3lDQ88Les8Wc+JJBjkWn28bM/rTyr/xO69v3/rS2SBoKCPX+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ag8PtlJTmhYdoQLIKiX5jmWxrTI0edeAmePEse9+127uvN/w5Hod+iyIN/fVO74QFK2h1HVRBE7OZ1hbweuXj+8h9/OEX+PSOtVIBB5HQIzoAPRHSKrDcjvjD97lsTiM7o8AV51of9CD328guyP8tn2Tzf0B7wjMCCPNVBZbnXKHSHgwJfQ3k9zbsepBHWpUNKcgpq5nTeNPD5BnueNOohev15JP+v6tJSoqkjQC/VQtS5oSSB2vjV6EKZK7IQbFNE6slodymRwxLEBbOaO10/IIUn8MPHz19imvzwa1VOEtzwuiWPW6ErAEPI9KUqa4HuROsB6aPSpYjuI+XNtpHKz0zgPG9a+mr17V69zeyo/bqT+kZwAsSN1scK5wOzYfQO3K+RwHtOTTBtZMcch90GZwFZvcIb6xnuz/f/4Y/ufyEOybubq5WzGSkSGCwfdr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:17:10.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58708df7-5802-4154-e315-08ded6b24648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177

From: Alejandro Lucero <alucerop@amd.com>

This series adds the sfc netdev driver as the client for previous
CXL Type2 support changes.

Changes from v30:

 - Only sfc changes as CXL Type2 client.

Changes from v29:

 - Only cxl core changes.

Changes from v28:

 - patch 1:
        fix doc (Ed Cree)
        fix error path (Sashiko)

 - patch 3:
        removing extra + char (sashiko)

 - path5:
        remove stray change (Ed Cree)

Changes from v27:

 - patch 1: make driver probe failing if error in efx_cxl_init (Dan)
 - patch 4: add unmapping if error after efx_cxl_init (Dave)
 - patch 4/5: move cxl_pio_initialised from patch 4 to patch 5 (Dave)

Tested in the cxl_for_7.3 branch.


Alejandro Lucero (5):
  sfc: add cxl support
  sfc: Map cxl regs
  sfc: Initialize cxl dpa
  sfc: obtain and map cxl range using devm_cxl_probe_mem
  sfc: support pio mapping based on cxl

 drivers/net/ethernet/sfc/Kconfig      |   9 +++
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  41 ++++++++--
 drivers/net/ethernet/sfc/efx.c        |  18 ++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 105 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  32 ++++++++
 drivers/net/ethernet/sfc/net_driver.h |  10 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 8 files changed, 211 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h


base-commit: 96ddf1af34f5f9e29891a5bfb7a18dd0a5bab9d6
-- 
2.34.1

