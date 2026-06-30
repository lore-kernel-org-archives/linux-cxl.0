Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387012517AC;
	Tue, 30 Jun 2026 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826717; cv=fail; b=LTkkJOLonMUsHeEKJQjj57GH5cGt94Yn4sDwObQo2qaf0vodPv7Mg56lkD+v8k8eev6yduiPQHC/fx+PDWMjNG4Q77/OW/MzmJWhZ5HJ9rKtv7KCULirBpJw8ec0UBVKxod2tE1vwdzekP5Fn5XCAkZQoQ39PXRYcBn/Ji93XqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826717; c=relaxed/simple;
	bh=2SyTEx1KEq5Q8epfi//2S/mLv1wiyTxuAclHxd4o9WI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQMx+dv4bjX21f6yGjuz3+raFc51uv1QXIa0SDYZq5RFsxJrd1WM42oDNlh9i8HuPp5r6X0wAkAF8bjfPH3MafEbIQPzekR91rWtVVz3LuvQMiYFVX8vEyNYyFm9yWcPtw9y45tXQFTfW4l/rtS8npsWPFf9k2Q0mtpsUVTRb3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aIiEhrBm; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aIiEhrBm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3a3oF2OGEIAR/1sG/LlXvfqwLWP5xQzwSzk3aX2rOQc9H/VB3rzUy1mz2lgOL149XJEkEVcNsCxvz7cwOq/0sYaRgbFwKxx1pPcldi2wE1YwdN2QawTkyaFBodhDqLd9HZliTzaBXf9HSAmWH+rI0zqXMpBDvrNRAb7bi3HTK3f/kwmmqDKqtqCDRTHj7SO0PZmPUfQCR9IRnQiCn+HKroypY1LJgEx6JAszV03eDwg8j8Xz5voVYMq7ctXqOFBJfQxpxmBwVyDNGywpNcimo1D6RGvJxneBj3OezZef0BppKgxiUOE9DIOA2YoY9jIX/PeLQA8do6DrbG6hz0hIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPF4cBx2Ln/M+g0w2MxIA+Mf3x5j1lMvOTcm0cmOV3g=;
 b=OTgYyENPxC60HX5fvAj2ZaiTTCG5GbNhOmxSTj0yocYAquexGF80ynHXImBATNhy2v0ZxVvwLoktsA+2Qw/9wwdWNJToGvyXGmAp/8Q2kn96/3EcBVaogidI3QpMkUxhF0RMoIVQR55zpLE4SqENEi0+cIcMNhPTyOz1YBHfSaFaqCfH1mHEx42tF2JUNqkRYyVdTSJMs5xUTQXcX5iP1OxKxVkk4EknJP2gK6HP2CpkksnvqPHpslTyh/Lbru72UPaDYPgmMU/e+Xb5tAonZdwpvD2DTA/s6L3wTSYg5Sl5fDwSuvNH/i9MjRo6BGpp2i4BiC0j6Dhte+jph6gkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPF4cBx2Ln/M+g0w2MxIA+Mf3x5j1lMvOTcm0cmOV3g=;
 b=aIiEhrBmprlwHa4QhInDv2IfjYUd6kD+f1QZFenhNnskeMrj/UpbjbIKQQhEt/p/zb6TV7dvSmxFG1/rwQPtvCc7y8wcsAhr7xrXuXqWKhUwGd0PGUj6/GVASg+ml19wkABYCKcUAvCtRg+GVZFYDkkv2cGb2baCb57/UIKZC9A=
Received: from DS1PR03CA0026.namprd03.prod.outlook.com (2603:10b6:8:233::13)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 13:38:32 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:233:cafe::1f) by DS1PR03CA0026.outlook.office365.com
 (2603:10b6:8:233::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 13:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 13:38:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 08:38:31 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 30 Jun 2026 08:38:30 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH v1 1/1] acpi/hmat: preserve hmat_adist_nb notifier block
Date: Tue, 30 Jun 2026 15:35:07 +0100
Message-ID: <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
References: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 576ac7f1-9a18-453f-1236-08ded6ace076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GLbZyDH6k/mi8QmZt+3McsMAayMoaI6HL3ZQYgiiXJ7Wvhh23tFGciQ4lZd6URpnqMTBNooNifAUHxgXEy/Anhjvyos6k6CxWfMCsvD49UyskQlP2gN4/G0T+aZ+9odOh+VNfYhXZRPpLdR9f+oBrKnmh5GUb9/VFM9brFChASubhLQT+RwdhlQvqieo7fvrAk+txcokBADgWAEeQNJAvXkJ/JbVpgi5UmbWtKt4ateBhu6Ci4RhKv+tYxVXTq4Q9Rnhv29rh1pTIKjOJ0MLTmZzZnmhQglgR2NdHSUFPK7aYbOqg38fAPBjjrOF0GUvEmj7hKbmfGy5a6brKb0glaq9nFOhpV7lXMT8HM7zyzPZ7LcK1iZlJp8sfpMStKQ+Pf+pNKUgwCCD9FRumqnbGpkiMFuBl8QlXtNtb0SmiibiqRePIfUnnibML/QpD/qNkIyKKT0pcjZuzn3R6MrO66Fp2KCNUpPe3P3ccOjjOOFVecANexY+aM9rudAZY0TufTaAlOrtIIe39nhytBE+H5SsHvC2jxCXegpQ20JmT3US/N3/rFhmTVeKHfb880Em0UFE0LLLo84ZjZ8eIKeT14PWV3XUR+msFfqg5MY8XuWKx3+hOhKrgYgWuDYmwpQF6tdJBq5rMrJRznDDmSnKEeiRvpuXsv2uWPgulmfLYs4ldaVDLL2Dx80N5mT5/TxB8q0oEJeMrjz6uxOyZUJGHQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5BS43MUGn9whCJwRYRbsa5kE+aCQVy0u4kJFdKrwo+AykfpihKgJSXFr7yDPn66l0fxs11HtlHeOBrT5GROpaqKDHz00V4x5GkVOTrzc/0u05CjqWi+GZjH6MqpQW9N2mtjDOwNZKjN63tyuWDSnCUqItWftILXQy6tOsvZ0cNDa/puQt772AqviukdTFIsEJh0bt9fuYfkMsfmy+aLDZQinirabrrqC7W8Lq7v/6VOaRYwslGWsqbWHCM102+vcYE1UmAS/MxXEfWMCdXzq6wREyCjYRiXBJ+mJW6NyibnrfPHNY6PxswrYiAX+zVs5pp9RsBqy7MGmo5uofuAnuNHWzE3CmQ1ykxeBx6Y1/b/5rH6EELfqvXsW2csPajVn5BbdADDC1ifMzX70d2X5l6o3zMX+Tt0ytFjI0yNAK82OOBUCGVuRytZOuoaQEj/3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:38:32.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576ac7f1-9a18-453f-1236-08ded6ace076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

From: Alejandro Lucero <alucerop@amd.com>

Remove __meminitdata from hmat_adist_nb declaration preserving it even
when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
registrations using register_mt_adistance_algorithm() will find a
notifier chain likely corrupted. This is the case when a CXL Type2
driver will load after kernel initialization and a CXL region created from
its committed HDM decoders registers an mt_adistance_algorithm notifier.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 9792dc394756..3006789ae31f 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
 	return NOTIFY_STOP;
 }
 
-static struct notifier_block hmat_adist_nb __meminitdata = {
+static struct notifier_block hmat_adist_nb = {
 	.notifier_call = hmat_calculate_adistance,
 	.priority = 100,
 };
-- 
2.34.1

