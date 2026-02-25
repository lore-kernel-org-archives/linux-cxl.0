Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09834F49A
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022164; cv=fail; b=F9zEq1t4G/qZQde+T1MjljctyDg7biCGIki1XXr9Rzzzt0WknpcfTXRcK7ew/EQUrTR+8BXApB/a9YVLCQHmSe18wKOu3UqOXu1bOO1NaUZ/qcpsd+cFrIC7R/Wm+hmBdRFiwcG2M54ytiLyLvvpKaXFGEtGBYjyXNVb0GlZfjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022164; c=relaxed/simple;
	bh=nLJLpSOrTZhaAoEFZGjFOO3NeU7ZiihMit/p8UBCFoU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S2qDLhr+VePpC7BGOF+0hPioNfBaGpGrmOXLLKU0iOw/bzQqml+S9OxDo3dNaYmnHZ6ijOrKZ8qB9UOw9HNF9e8cMgsL9d42VNkTWayRLCi3u9/exX6f5dGZVxnr3YecnxmInxsgDyj8CMXOP+1JNMt3LDu1l+HQd17fge17NWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aIquWFOB; arc=fail smtp.client-ip=52.101.193.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aIquWFOB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rv+t/Sur9VQk45a0d6vUx4XEpDeWCOblNquLqTj7l3gKBhH+QmWPZhpW0lLoDaKtnyaMHAuDss1khuijnbDM+3mMaR/PlxlZEa623XWNtFHlTcwzcuizC/xiRVgSnsH3RlRsTmIa5gqG3UEMBY1iJYTe2yBnBqUSCzsax/DIrZCgwG1fd43pfOpRoevARVatH9v4eEby1mKiEDIExMj2aUZ/QGODmN0nZbJ7uVHFI5/MJHEn6piZNNS+zONBrew/SEyi3k3O61z68hAVi+3OHYyRIVbFLyx2aMN7g0g4Uh2TV1Ivab94DoDURW/VD6OKiRwo7wV4Zsf3powXSYyFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GclvOkw/3+3uT8KIt1s1RTiSvZnn/S7SJSxjHhmsupg=;
 b=tx2Vraivk6o1o+JJGbJ0m1IAlLxvbPs2NXv6k38/oxPhDftEQBBBLj2lCjoigaHRAiIPbwBCIklvnDf4P/8RTxOIDQ7GV40+nHDn7xtg+z8tSLeNcNGqq/OotnBvhDrbU5qERLKEa/4zU4PP+zA1FGupiSXa06tBiw6tRMUmlJ8/LeKgC2hyNZZQBx6CZn1V+nruCkfeGHYHgrUi8yQuyebkU6ZltZYKZdPCaRSqIgS4CZg0W2pMykhGBlGjHr7XK5yG4pHQAjINcec7vcZZM2aONr9kN4Sfr5zRIkuW8Y2rUSP0tdCYxo+j20PdSkS3dcrGsxHlTapDkEF1kAOVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GclvOkw/3+3uT8KIt1s1RTiSvZnn/S7SJSxjHhmsupg=;
 b=aIquWFOBQ15Gpw7j9M/H2PxD3XEc0AHI7Cu9ArlT2TZVid2Ng7HZh1UqRW6kPN2sdDI+aIvnRjyaFjMU3QZwY+CRrdPd4yhjPALNlBhb5pA58zSXgCsuqP0haHtkF5i/HtwOgObR/pnAfIC48K9C2NpP/PmD6pJfn3d3cNc0K4Q=
Received: from SJ0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:a03:33e::21)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 12:22:37 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ac) by SJ0PR03CA0046.outlook.office365.com
 (2603:10b6:a03:33e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Wed,
 25 Feb 2026 12:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:22:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 25 Feb
 2026 06:22:36 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Feb
 2026 06:22:36 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 25 Feb 2026 06:22:35 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 0/3] cxl region changes for Type2 support
Date: Wed, 25 Feb 2026 12:22:20 +0000
Message-ID: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 088978eb-2b3e-4120-53f8-08de74688fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	SIPCQFU90hYVH6NLXfbaV4rokrvN3CLqzTonV4t66uIlip4Ph4kj4XtirrtDoCOWlrtgkeRkQn+NR6T1w+K5XtKceG4ZTvPWY7AoyhXNnVrAIToNF37QqlCalzxrfXxU+eLRS173azJmT/JsEtG3Q2ENKeqvJq63Jx1Ng0yCTwraqww2/yMu9KjNBWYRM+uR2oO8pNdOdfPm1qYX0jHdpC97EkImj9jwzYyNN9IgBnTj6wfzQUqfp5Zh/erJzLtWIUPNictP7UV7/rd2eJaXzRUXNbPoh1IjMwO1owTlDP7Euc+0gaS5c7cjDPPCf1HVnQcOS/6XsOgdCoGnSpBONYwXD6WapEjmgz4/mLXhXK7/iiydwk8LSCCG9PYRPha8FcRKC/Iba7Gs2r1nla8I/nyF9qIUcgBLNGUf0+VCCzPQOO7Bp1yTaEqO3dwxR6jApj1ymLE4I0ONqbiNazQOp2ahFpABEMrtLmBzNJpLRy5EYF6PO0zHNF1yQXJce+e9dkfSqTj2kZ8s2GbBipwqOowYxmYGa6JHAsgae0CE6XyrB3s73Pc2ctaO1N1m5/ULuG4Ufuj0O+rJN9y+7Fm4VFKEcb/GZ3DkMkrnStznLSkUFkqz0kiAZKECQqjSEDMd8kK11kaFEgkU8xgPZVxWWt7OilVj74wPDz24vgPyM1LgSOJNvlzHHC7mU+pYLZ/mCPJ6lMLDDaEFShZbrrL+6BvY1CnIzrn/FBwJUpbepmlRDY0p4OFVdYYfPIPAkncx4nfXiVOEtTUpRnSOIFeg3uZHZL4akDTzOvGad2LV3jdbv6/SQw030CwUl+jBkFlOYBKuOZfDkt0Wa9l2s7Ebdw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+ZFOAnK9ZMQQipf3QgV+LnX41pWm3CYCUYhYYEOfZpySrDg2moxrU6ul1U0AtzYuzgJZxTIo0hmc2rRuG9/au/k8ibsL6hkGMugDybYKLIX1RI+oqGmlVzEy8i6wIAoI/yP7RMnAKS0VwvvrzilNYlf0kYqW0+p1eKItQ3AU4+SnBWJbaV5lytN48i5Ip+Vwh92I5wFfYb/kXzzv4DqlhQyRoAm+biuDdyYjW2o25J6jf9sI2gWbAcs5tnhqkJyNjfP1F83+YGFnWTMO2T2elObiw9Tt8Irt6aCcAxx8RzU4iyXTToGU5A6k2HoPK5O9yBFHNcxtT41S6lZBVleAtUyvallcvRObvmj9ezbUMdb6JwGucoxMIPbDUy/EMv+IIDfeDOjZXTY76BypX5JFeZMAiOvwOIAvzUkFHImVXDdWoDEq5OWCZyTIEyZgO5F7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:22:37.1571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 088978eb-2b3e-4120-53f8-08de74688fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

From: Alejandro Lucero <alucerop@amd.com>

In preparation for Type2 devices/drivers support, these next patches
adapt the cxl region code for required Type2 functionality preserving
current functionality.

v2 changes:
	- fix commit in patches 2 and 3 (Dave)

Alejandro Lucero (3):
  cxl: Make region type based on endpoint type
  cxl/region: Factor out interleave ways setup
  cxl/region: Factor out interleave granularity setup

 drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 31 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
prerequisite-patch-id: 8d7cc83a3a58f41fe5e06fae90007692187095dc
prerequisite-patch-id: c29b0a563fe612597230f169c616753222b39f14
prerequisite-patch-id: 5303d151b258b111d338359c565831476035f16f
-- 
2.34.1

