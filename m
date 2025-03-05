Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3290513AC1;
	Wed,  5 Mar 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169060; cv=fail; b=XeKOd3PGXz6D7y5PYSjnXeB0w2U5nimMRP3OtMMHqOot9qEwOqWBGZ3eKonUv0HGqCOZSAkvlzl9v9++lh88Fh5IZKYjGKkKbs9sSGPl75FaSROf42RwX8ApqXlpVUYGdtPtzVp6vFcKaobFkoOgcUZ9IVAzpKb5cVxsX+x7w7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169060; c=relaxed/simple;
	bh=ytKTmbbthJYLorl5CoASnmB3SLBEM3HmcNW4kG6l0i4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbysLpKKNbifedf6vybmmQroLrGfuHSdbn3qXrZoyKGBBWSYYtB0H57ZMcRWqtBdWVShNxudHgHAqaOAtqBY9nnCt0g3tq5dyrhlOLtkDGok0gKw6mNyU6MfGdojmv7ArbtpfF5MPmpfuQCqrcUfrff1crxveFr1rfmZhYjTHTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wA3Ruo08; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wA3Ruo08"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffus4s1qvF7UqiK1doKlTO+0Iloyo6ycp9a5ZHJSVR5P342o7D1qlgRWpCk65zdf0BRk1zUaIxbUcRyzRPWyM2mMa9WKdNu8W4Yh/UD+0QAfGGo4vOAOErxj/DjV0k73xZMhanSpkAxXighDaKQBPAmjkfr1GGX4/FXsW4Juhiiw8OpKVpf0gGmZEIvutiYj/jRf7SzwVVHZRFOl29o06gSweUU92wFIEsDNWqmcjuRenAU+1fMCHvFkB+6GqHrbTYtSEvyv1036LDgjCODlj9FDGMN1hD7SRaW39+bqQNuokVseJ1pfymz1eCSGmd8rGjLZSuZIkkzgEyb8qDk7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjF+htxNyPCGYsSmRvENj+XublfHTJwjZVZVRcR0Mi4=;
 b=YYqfjW/clZxNcUVT5sw5oGWYzgnHbRC0B0PNqUiThcw3lFMIvjYe3wm9kcS4kHXOFilcIcGbzWDI79bVkYFLAJfcE0nXPAxaEzk8z2fN1F5DC5urxJSZ0lb20yM5iX5r2zPMfOjjLkfOzXo1WaLVgRcf21vBz6LW/GGevEJJL/yR1Rnn+xc6Y9m4iTi95BNqW9ybjFIxS2NlTPoYoxC4EhwwlkJn/8ULBdPn2/e0gcMSrIeKqiNut/Fr5OxI7nu8qflyJ4Lp+LhUIGNRGI/LiSemqW+C8qJXVYeS9ndo53L0g21mmxduE6JIRjhGPj3Q5oExkxyYia7eY5drSBGuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjF+htxNyPCGYsSmRvENj+XublfHTJwjZVZVRcR0Mi4=;
 b=wA3Ruo08okuCuGYRJ+PErAptaCUJxHoAaBu5UJz46c4EFrkpDQQJlgtJxVPLOhrwW910khCngnlWdllQgvfxPUB/5rp4DFrfgMEoUVvI+QgBsjOmrmxL7mFnm22e8rqcB1Z9iGqynCWTCnWJdRd6zTbCMT1ckdqsWH+89ZDQVtk=
Received: from BYAPR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:74::36)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 10:04:14 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::3c) by BYAPR05CA0059.outlook.office365.com
 (2603:10b6:a03:74::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Wed,
 5 Mar 2025 10:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 10:04:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 03:59:27 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH 0/2] cxl/pci: Inactive downstream port handling
Date: Wed, 5 Mar 2025 10:58:36 +0100
Message-ID: <20250305095839.3076198-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a04dab8-0631-44e6-e82a-08dd5bcd155a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SmjJy7kFp+tiJ/qgeAb4Bh8yQKXpYrg4JW3awL+m5cKXjZbWPYbSJEBfDleR?=
 =?us-ascii?Q?Q04KYLSPq8yqpHLl6AEXtT7q8f+UVQEDhof3rCQG5C5yKZZzqP0KbrjoTRYC?=
 =?us-ascii?Q?fj0L36JJhKp8Xz4QjrEZTANrfSBEeYl0CW34PdtqvpFvLXv6R1q6eiwVIvaq?=
 =?us-ascii?Q?lEJgIF3ohW+WmoZKDLi7BMCg2bSFEAp9BcwlhFegs4X0M0ESxhyMXMluLZP/?=
 =?us-ascii?Q?wttcpLVQ3pUGlk8FLiwTdTGvQRbqvYl6gAsjqXMdtGOZ0e2IVmltbtzqiAZH?=
 =?us-ascii?Q?B7xbY6hefGBYv6UEg49YXcjyxxICJ0n7tep+RZQIUMHKBQUJY5PP6UjPH3UY?=
 =?us-ascii?Q?PoXQoyN7aoTo2yZSY4DHnUfU3/Ff61q+sQr4YBI+LC/SyaYi3kG6WoS0NbmI?=
 =?us-ascii?Q?qlcYtrLCk2+11M3XipJygwvMIyD1Eq2RgvVbJa+N11eLiS3/qOQ9UwpIf9dM?=
 =?us-ascii?Q?c2uHGUQHaI8mNpk4RGyQ0v/WNGqMORpDnW909uB9HkO/5YbjZq4xvpX6Y2fv?=
 =?us-ascii?Q?EbhgSdui4Z31SsXBeSNr99UQDDc0nJO8sZ7GxBq3LcNZ8E7Ep5Ng4VtAsHqN?=
 =?us-ascii?Q?c7qsJqrCqpsID+k4rY/zQSPtP4yukm66pg8nTU/9IP159Lhfkfdv75yFyE2/?=
 =?us-ascii?Q?47FBNXijPcRnlQWbWR3wwelL8qZ9UV2Pqmserkz+NVmWd19VyrDZ7VbuWSSc?=
 =?us-ascii?Q?1teZgY0YTLOiOMeSzkPi5wiTTMkYHF+cvFReYlSNkku3crfuH+K8YBRTS9yR?=
 =?us-ascii?Q?nB4hR8Fl0rELeVOB//1iSr5bil2qnhIvMq79IbJX+AlDFOLdo4ZPSLO15GB4?=
 =?us-ascii?Q?hdogw3/fat1VEJODTIvzqEprpOWjn7Ug/YcibX5x50DULn3d1CULOfePrgUR?=
 =?us-ascii?Q?fOxVBKedwHVov8Cr+6MqdHcSFmkxUi0xhnorjkl6s6IpvOzcu1KQdWgV1h3G?=
 =?us-ascii?Q?bnkX3svkci9h1lWvPgx4yDCHoVUgWVbj8UZSiqAvg7WTpAYQvi/IW+yczqt4?=
 =?us-ascii?Q?/Gup+9Y+hC+rcdxx3TYEqA5c96sJRp9/LqhQXoUV0ZD3fAXSE6f2HMXZvH3c?=
 =?us-ascii?Q?R7DcK+yZVgNybFvQ7R0aI3g3OAlga1r1F+MDsgRLnTiA85tdBQwbpoSoMWem?=
 =?us-ascii?Q?zY6A62WES8pkafDaSNLKeslMp0/gJaaJ2Gw1uv8d+Ysp27kh5N50QFNO4CnU?=
 =?us-ascii?Q?Ql3T9pm4OpVc7/dZQqqF1cicV/F9ZBWJTPDP6cuiZFQkHqSVh3P+UGs6qXSZ?=
 =?us-ascii?Q?xTDxXfS4lc/7gm8es+xQqc3lztwRC11pQ6MkV7E3okX56e+VOcq5SFZlOjcg?=
 =?us-ascii?Q?cy2otXzDZMI/udioYsVHLmD+eekQG5j+ED7SwmqNlQFhuyGs/NIP0BoepLrY?=
 =?us-ascii?Q?HP7/pX+JBnjsLrjWj/eWk/XSEzGFoepDBzr3cABRZDaTFeI3BnIbtTKQkdbn?=
 =?us-ascii?Q?cYaocicOyWAGFWGXXWJcA4XVedJZQWgP9LbBWgv2IsZMBjG/J6OJRDdoP1DU?=
 =?us-ascii?Q?GjMfcDWehQ3NdDc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 10:04:13.9462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a04dab8-0631-44e6-e82a-08dd5bcd155a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465

A small series with individual patches to handle inactive downstream
ports during enumeration. First patch changes downstream port
enumeration to ignore those with duplicate port IDs. Second patch only
enables active downstream ports with the link status up.

Patches are independent each and can be applied individually.

Robert Richter (2):
  cxl/pci: Ignore downstream ports with duplicate port IDs
  cxl/pci: Check link status and only enable active dports

 drivers/cxl/core/pci.c  | 40 ++++++++++++++++++++++++++++++++++------
 drivers/cxl/core/port.c |  2 +-
 2 files changed, 35 insertions(+), 7 deletions(-)


-- 
2.39.5

