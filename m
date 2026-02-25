Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE73ACA79
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021685; cv=fail; b=J2NG3aM/Th9LR4EDqir183EG/dgjZqIzAWXuDAnDUqHO8eYLA00oyMnEpq+DUVMVrBWv1gyklK83ctd16nTwAxboR96ebw8efC+PwfuR6G9LBveADoBydPIYRg/Q2QQj+1BZyneIi23CfMX9EafyMpw9Xw9Hh/MMryhtg4+pnSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021685; c=relaxed/simple;
	bh=UxalR2QeE5Z2q9D6qr9LUy+I8QegB3Q+JPvoIhZQ8Zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fPttsqseioikhpOVxShG86mxUy5JasWdgKLhR9p9Vf91RP5LGjfwhThISh9H1UIPw/2hnvLQC+uB+3LFrLZJ4mEVpsn88agDxbd8ee7Ov09yGWsyWdby13HEjUnJ+7id4EjzsEQDJLsKnvPYYZkjctnNc5c+DANalVxXMHwu7kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wYXBmO1p; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wYXBmO1p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeV8rbv8TkpTC4r+dA5qNdTL0aC3GlxJQCRAkZ+C+ZgsAu4/2cD94prlwzb33l++v8Ek2MlElt7pKn5sYjn+VT2k2fIahoqjaz312i00WzPP1wW7d0oSiS75DcBijtHiCm87IJgKz9c0NuzXWg9PTKc4miE8N6sXu7eIRaWyQp1AUA1xHZW8zhtbHVNAFQVhB/UndoRy4bRumdViNeqKhJZ54hHeALBSdAUV8CNyu6OdkJTNW6rwPnLOTFUGccAkl+vTlWPhKVrqdCT9LUtG/j8QSBBled/P+WHXlw3g/8bjnjYgorTBoZB6zc6xUI/dk/iytUKWboXhKeXMzX2U1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANiPBLh8LvcDIcPuOXMUTgsIIvOsqKuWW0JgGfQ/8Do=;
 b=HpNaGE0w5cvlVltAZbya+qGj2KMKpuKC2LGv1Ulw6mST/IFgIsp0fIVzQnu313zjvMPLQarWG5FNgRV64oY790j1HtlUdkTFduVv3mAkQ/rf7q3fZ/rpIsJZ4UFWFkkT91HJccO/VbZMYtx2qnmPKBfgy3FaNHM3giz+fI2FwE+Z9sllZE/qqoVrJ9huWuv95a2MaxVzZV7mIiUgprnZy4uv1spE+s0LepOEpCKEs6T31nXWMqMSI/zk0fo610tnYGIKeO+30dJPxcqqOH1kPzvvE72Ei7c5Evn2YuGeJ28Uk7Ot+zBWMuya1LkwbqE1XjH6IQCNlt9Go25KUpmpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANiPBLh8LvcDIcPuOXMUTgsIIvOsqKuWW0JgGfQ/8Do=;
 b=wYXBmO1pkvv4O72C7mzFcEhruo5unf3dwYeu8jelrB7NqK8LgcRA+P3D0QwtVpPWpoWgJRf61XsA4MbkFkosOq3mBiynNmzTd1niwLs5LdjotJTvzlaq6L3UVQqZOIpfxhqJKVbQDVOEk3q3NmMYk4tWG5khclXRY3DCjbRybXM=
Received: from DS7PR03CA0101.namprd03.prod.outlook.com (2603:10b6:5:3b7::16)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 25 Feb
 2026 12:14:39 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::4e) by DS7PR03CA0101.outlook.office365.com
 (2603:10b6:5:3b7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 12:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:14:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:14:38 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 25 Feb 2026 06:14:38 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 0/3] type2 support preparation
Date: Wed, 25 Feb 2026 12:14:27 +0000
Message-ID: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 382986a9-e147-4639-f38c-08de746772ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	CFbzl5AXp/mQ4ovo2i6Gvh3SCFLHCxrm9U7arzLRQMJNjaAJpejvv6gW0Dy1WMg8XcjFwmhYACJfEFiqSUyWwgH9eGmbcXOZ0ZK9zuSStUqvw0TxTE7uVaepNLlZeighFkz7e46ZZz3LQCyHuonVh7tA7KUod90ycas/BkhXPE6craQR93bRuaSwVjYAoyIs8Qp5qgx1oznUmjbE1oy1aoIkfxzLEGR9ueX8ef4aP+BwvBQm5UtHgsQm5Yc8q8bsVTPgsONlguEHw+QdiDhEqW2tvG/X8lBlN+rVqU5R6/bWm+HbhkHihQC5Zf+Ycn3ewI72KK9RExnolzcH4bvbYOC2lp3BG95lgL0hZzLjMKVh+0xuDeS/37gwrsRxtX3xbtANSYU/w5uKbKWpwH1NNQ6pY3a0tNvqMTVsao3ifeWSjSU2FArbfwBoZtgSDG2Xb+3VuprfoC61B1hbiH2/cgyUHrWlAwMj/PTn4NEv4GPQA6bBstz0VPdXPTNx52PLP0raNs2FYkXWZiqSpF6vgJ0zmiClLylCJhllBobN1PvgNqpUxWzQNDh27VU9/A7siweUnz4/9epk50NT48eRGNztw1I/DgfLnzyJ/fOTnjU6v3wCevgsFIFi1eXh/+D6LX4QdFyqG3G4h8mYTHMkwIYDvz3eQauSKEQLO56hQXA4En/2vyapJQMXLsH9QtcUGRCDqSrEeGf4THEP9hOy5Cr4QYu6UsBHrzs/hgAs4LAijuGJor1F+e1BfS5dV2InVoV7iNAQOxtNEDe6tbCNDFDyTzXEciWbq/iRC9zBOJDQtyFd46fYIL6wEbacVnTv7EYfHyE5Tq6MlkMzgDICJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RIWVe12OBV8hHQoEwyEjOxi2kOghRuFh0/H/MTCPFQEP0OVbsg3uRe8+mmaJjBFq3NQVxPRo0o9q7gV7xWYQZZP6wyRYG6O6aagI6mBiPdwv0aYS3qt4dGjB//fQX7NEPA+PL7o79rPKmGgZRK4LopJqYuAO0vxvjF5Au8YQOVVtCGXMf1FhDJHoleNhU6mipgt8GXoItBqSgF03UqWEsUZ7vNQZhjoG846MfdTOe4OOR7NkBlmk9pb9RdyAIgCPkFQgvc7Uo8HTlgSQlQTp2dYWA1lpXZ2QUGwfRRx94S32K2nuwqvatl73NdtAhFtXxqgxq47oMNQkvgg4Bd8wE/EADlyj9wLknHOsPNynbP/cixjDD+MiGKBhCthLSESazO8KvRDfX7PjrMJbWO8KYdetu35UjVPu2KNqd+eARcKr/OUvwO63u4oAl2slVaNW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:14:39.0902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382986a9-e147-4639-f38c-08de746772ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

From: Alejandro Lucero <alucerop@amd.com>

For facilitating the integration of type2 support, here it comes the
first patches to be applied in preparation for impending type2 drivers.

FWIW, the first two patches are a split of first patch in v23, while the
third patch is the third patch in v23.

Not sure if I should have added the review tags as the code has not
changed, but maybe better a clean start.

v2 changes:
	- fix nit (Allison)
	- rephrase commit (Allison)

Alejandro Lucero (3):
  cxl: support Type2 when initializing cxl_dev_state
  cxl: export internal structs for external Type2 drivers
  cxl: Move pci generic code

 drivers/cxl/core/core.h      |   2 +
 drivers/cxl/core/mbox.c      |  12 +-
 drivers/cxl/core/memdev.c    |  24 ++++
 drivers/cxl/core/pci.c       |  62 ++++++++++
 drivers/cxl/core/regs.c      |   1 -
 drivers/cxl/cxl.h            |  99 +--------------
 drivers/cxl/cxlmem.h         |  86 +------------
 drivers/cxl/cxlpci.h         |  13 ++
 drivers/cxl/pci.c            |  84 ++-----------
 include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem.c |   3 +-
 11 files changed, 343 insertions(+), 269 deletions(-)
 create mode 100644 include/cxl/cxl.h


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.34.1

