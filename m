Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC230239E80
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299563; cv=fail; b=ceKzCOWitehcEWSZWp/rPNiphTZ0Is5Oc/oMvQ9KE5Oc6NlV9/ncOrjqgskDe2JpnAWXk3aBNAufvXFBl60IKImeRRmW3zTBlkErF1hyB4GQPjC0UyyE6UkoL9PYNOJUtPZETwsZFim63TDXsHx9sUKk/qnGZ2LWGKfS01h6UmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299563; c=relaxed/simple;
	bh=UetuWIc4v2ZBd0rDfyRGmYrtI7cUe8xNQfPypxZyndo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1hnpKHx+SQ5+fybaheae2ChrJ1ZmTnPhjcogJJWbhs9DTNVuDYi8yUpvytzt2v510e+mRyWLTsGDWQmlV8hMUxAt3ucbtHd9Skp5wvGlJfj8HwrbVIHMVmWfmkJUaM4j9OL4UDcyBrVDyVuKtPcI44y1grtcoXqsisbEve0Spk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WPQtchKt; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WPQtchKt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9SmJ9EAJVvkzXpW4Yfc+I1B/2L1dqHeC8Ep4S3TsmheTEH1H3rbwN8z9NI0N+UL7r+N+dVbnGwtGnqrHhhy6MA4iBM6mYv6C1TQJ6bzKH7U98pSvZImZhJ0XIA6wnYLIDr4Gp6nN851ewXVYYdw2W2FakFwXNNpB9M700JMILy8sYDUe2fv02hWU6XzsKXl7Miw4LeINPmjm12Ihx/2v9m9I1bvjchVovpioyk3wJ2dLB9sMJEo95/bjiW0OkRjrg3F3OvNu1c0II1D01BMKNbiAjHceW05X35zJ9ae5mT7aDpc56ACmZHYbd1nvxm1j4dRrb1DhMWpwoIOTfdf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdfjdKw6X6jsluvytr/MxAduR6Gw6i3R9PvtDDbOdL4=;
 b=lISAW3b6zk04anPoZmVhX4EPhflv/MontlwHTpoUlqKbxs66jwqAvk2U7bJ199TNzoU/R62pUTQ1m0FixY/SYT9Ec1I0X2WP3ydVS3VJj/8KVzXFcTd2Ljec3tSF9YedD+r3Ygphwg4bNfe672uvTmujRq2bCtfdcf/L2z8dDXy49cxYN79CgvOKpEiaoXHT5ogosjmcCuWfiii24oKF4+a1Pcmr0cnJVr4wstc8gRonJ4L3Mca5Xfk1jGaLrJQGeVb8EIoM8eYJfVeDwvFYg+CD7V0jOZaM2DKwAJU18utZ2LeTgGl6OpAAU7Ev1b2IT+97iED514+SBNSOKSij0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdfjdKw6X6jsluvytr/MxAduR6Gw6i3R9PvtDDbOdL4=;
 b=WPQtchKtv0TSAhB4k99FxUuebOWbMny7fVL0gtYDsj0Ikpa8t9z7DmbCM3J00vAhkIiilCDDeNXzbHLZ6ID9642ANxzMkZRvMS0H8lWDV94s24/j/lXS/rwxUAVhDGeD16lUTCJlm7iz9XIwIdNHxZHFAT3qVxAehnDt+OUOaEQ=
Received: from PH8PR05CA0017.namprd05.prod.outlook.com (2603:10b6:510:2cc::29)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 17:25:58 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::9e) by PH8PR05CA0017.outlook.office365.com
 (2603:10b6:510:2cc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.15 via Frontend Transport; Sat,
 28 Feb 2026 17:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:25:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 11:25:56 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 09:25:56 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:25:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 0/4] type2 support preparation
Date: Sat, 28 Feb 2026 17:25:45 +0000
Message-ID: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ac368e-a5dc-4b58-d7f5-08de76ee6f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	sxdasikvascLlSJO+DtN9H+AliXVKqFVCtGVZ/QlsFcxpnDTy1kE6qd/CvrLCOLdGpv7+VeMW8pcri9wSSehp8M2t/W+Uz+rHgmcpTkApb4q4XJMxWDSb4GDiCqS5+weZZqHqRpF1B7tk4l2MqA8YILwFfB/XYV6cXPK6TdhCiUhqFUhZOu4DLDKnGEPzfo1HZuLK/hPjnnrafwari/T1MzJZOAlfxfl0UC17ad37nf1jGH8jQgxnHEIBMHyTelinnNNpnUphIeSPBngZztN0Xja24kBrHW3gg16gMu5iWOLrE8SUBTAKPQsI+vErSKNi/sthJTJDFLRlW0y/hTjY7couT7O0KjVEeiHiiVVS9ZQW4tNqrprzda1sdpiXI6MAKNftuRHqJiJCNlrcFiN7i3qmNnnVulk5dEs6JEv0d11LHLq0KFfaEnLJwHpS6XY6yARsLIoh4H0gGhePDAQ026LZL1DbAyvZm9+bBb0OhmLgpiYKPZ3M2Klp/nkHw13B2VvQSerLggPxvrRW7IcF4dqNelgrNTJGKUoj9Q29ViGfGdt3oHgfZaxqRQg+GcN7FUPfnWrHMCvG6liGkolD5ehzxE0dmFwxapRMqxrCNiTyenw0NHX71l3UgRBpXE+gGODEdKx4corGYLrQxhxNNdNxs1h6zvNyW24Bg6odYdeLpxOXjsQg7xnFRNnOGgtOql+YJTIKlNXAPuubZ1VUVla73L8EZGICuBIs0nijv0gznsKHyP0W8RV8tDLganDNf92SB22Uy9eKqqn+Afvbn9kQ2aolbOD6pWwHJy0BmpBJ8OvuMxDGajrpB1yiFAzaNSC5RCDMiWY/vYH76T/rQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DosxeXvTZVmHAMne3x1jS7kAc0VVlZnx79OytdsKrwsLPwxcNr41N/zElu4e71HtSI2sLHwlPkglXhe9yvBe6g+QdH7BASZv86bDaGRnSihEv6xs/uUJsN0Nq1Ew+2ei6KkllUUeE5Rs06bwDgpSRvA6cQ71ldTdxmElwFEQtDbQgoYrDeGhdCTcpYuVG1Dn25fyUvPJMXC4Ke1J5d+vgIr9g8Dj1GtD+/uLq1zOyj/S3u0eAt86Q2qan0EEK+B67TLqC108C0GmzuLiZHB8LezFgpeKU0gIZpZlK/P6mBEwQAvrAcwBEbpyIuPCPLRHpn3elRgQC64IPjXUXNyv0bznAMpeeCtoifEotdDZljU4L6QVK7ubq/0K8sz9NSfLxgULDxqoUn6/SLhTypmqq+vi/hXtCnOxF/ZYwdScvfkf+9tgTAfIPNI9Ypd2tmos
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:25:57.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ac368e-a5dc-4b58-d7f5-08de76ee6f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

From: Alejandro Lucero <alucerop@amd.com>

For facilitating the integration of type2 support, here it comes the
first patches to be applied in preparation for impending type2 drivers.

FWIW, the first two patches are a split of first patch in v23, while the
third patch is the third patch in v23.

Not sure if I should have added the review tags as the code has not
changed, but maybe better a clean start.

v3 changes:
	- fix commit (Greg, Jonathan)
	- fix member field comment (Jonathan)
	- add patch for removing redundant call in moved code (Greg)

v2 changes:
	- fix nit (Allison)
	- rephrase commit (Allison)

Alejandro Lucero (4):
  cxl: support Type2 when initializing cxl_dev_state
  cxl: export internal structs for external Type2 drivers
  cxl: Move pci generic code
  cxl/pci: Remove redundant cxl_pci_find_port() call

 drivers/cxl/core/core.h      |   2 +
 drivers/cxl/core/mbox.c      |  12 +-
 drivers/cxl/core/memdev.c    |  24 ++++
 drivers/cxl/core/pci.c       |  57 +++++++++
 drivers/cxl/core/regs.c      |   1 -
 drivers/cxl/cxl.h            |  99 +--------------
 drivers/cxl/cxlmem.h         |  86 +------------
 drivers/cxl/cxlpci.h         |  13 ++
 drivers/cxl/pci.c            |  84 ++-----------
 include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |   3 +-
 11 files changed, 338 insertions(+), 269 deletions(-)
 create mode 100644 include/cxl/cxl.h


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.34.1

