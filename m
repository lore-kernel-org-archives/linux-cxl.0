Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637842517AC;
	Tue, 30 Jun 2026 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826723; cv=fail; b=hbSpNkDSqaQMEpgS7UxJB719RZb1uYyOgFmnO6PeEl8AVgDySIZDGD7NktEyo89fbAZFdgx5gvn+tFstQfG3oo0QtaBee2ByGmrkYtqMmoj6RbaQD9yuwyWouP7iJPI6c5lswtfHdut2Bc+GTDLEt5FvGSYgDCi8GuIoCWmt5Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826723; c=relaxed/simple;
	bh=VklNG4dEV0YGwE643gnOZcx6UKXJMkXwis7dfiucX5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a1SVZyYSB5/IDA2ULzJilpj5l1rqIfx8Ze1r9/r9TpojJUccX7R0xM6wYMHpc1GdysUIRcMh9xzbT8vB4HNAaofaFhWjRK2E2zVJihqsPwKO9vjIfhMP8x6jhQnmG7BdZYWIYUsekUAc4y8YfcfsC2p9xaJ3JXql3OKTfMYuMAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rrXHEhOE; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rrXHEhOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flryHqo9XOTiktOwFqjsVfejlOPR8YUS6PWOe7i2Bb/CReQ3cPbIW9tcRLLnccdgdXoDTFjhxS6L/ShBxEJHUm6LJPm7JoLMsIooUu8H2oHPPZIORiZYJWUp1CF7acCIU9MC3I+XCwQ7D3aEahVFa6njsEFUaq1KaJK94Yt/BYlxIOa5/IrjwDPAJlFKuVhJHmFC4b7rPEhvljTyk5IBuuLRvHLvezSQe4UVH1ac1M/kdJsZG52vMXyh90O8e159RSnzBiEpQMQA+PCwYYpgyFLgJbj4eEM5HtUlc3mFfQFdpN3b8turIB/RDKSP/lulQi1Df3W9CxLJmOvD/r0ONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLjsOa9owMjPp3XLd/iBxyUe+dgwLaJ/MEHRrOqEF3I=;
 b=gPEuN5N2l0b0BamiCQDlf2W641Zu7JaDyYV71bN9gPBLuBcy8X3po5LLZbVF1K8bsB1dPf0vCiKpqUq6eEVwAVC4z8PwdTbViBe2OSRepQ8GDzSH+IZlrw1sWdWtN3NvUWpXhfMNCWN4uU1dh9luYB78U4qquFk4pQiZlXuo+rXW0jlhvXNjFlORH4aZKDHOwcueih9HUR+h0w5ksfS0okUweRnL125muG2yyYhWRs++dMIYYKYQFyXXwsQtNzGO3MInl7+fS8Rrz747NvG+FIN29dgX8QE2FlNOTo/GVU1Hb/Eq2VTtdBE/ReuxV8SFzHV+Gqfp29Rrpx9pcsBdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLjsOa9owMjPp3XLd/iBxyUe+dgwLaJ/MEHRrOqEF3I=;
 b=rrXHEhOEmpTszfgCnAdKe53JRDsg/LFdK1equjq5SNAW/EzsYidFIzZSqYoxetmNNUQnqHWHJIGSCmk4TnlW37OIRJbyH/KsXC1MvqOPmOJiYUiM9jUQyl8RhFTzGVQTOFdw87USWOiuJvJNWsjPkpsIKymT16jjftWPgu0qI1c=
Received: from BN1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:408:e2::9)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 13:38:35 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::2) by BN1PR13CA0004.outlook.office365.com
 (2603:10b6:408:e2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 13:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 13:38:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 08:38:30 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Tue, 30 Jun 2026 08:38:29 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH v1 0/1] Fix hmat_adist_nb for coming CXL Type2
Date: Tue, 30 Jun 2026 15:35:06 +0100
Message-ID: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8d4087-59fc-4ce6-038c-08ded6ace201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mWjTiaVJsTNCutIAgJovcL7jAU/GEklDfersJvA2oXaBxr/5iaV48EZfKfa7DukMq/UI9HEnITa523ySSPChnmW/x6E4KkkvjHAOq3BQummdG5EIJi9EOcWc4y0aD32eR/MNbXRXzLGp1I1AM1P15aNr17eGTerbEf4yv2O58mu7C7UYKdYvo0a/Ve3ATPTXgE6BgnwzZ2lGkF5ituSTXj6gzeMOZDVFz4ZENAi/MklmIryZZHHwBjAoE0Q/SDi72dIyjtHCeB2NH50PI0qgFgtcATOVtrkHiLa8rAsbfiQ0yPArufBF7gLrgzIT750ZgnYxy+QVNwnvDtPR4llmEkNMl3SMDfrcG0IqX2z4nC0QnHADpNqNH5z2kgRxqvdQAveKvRPPYHGVr9lhg+fcPMLehN0ZXsReCtfstYm/ycth8/djvj8PzfErFWz6qNBo/qoe43KWeAEkfqQVU5zuT4mEGBtjPcWDZci/uKM8A8DBn75cODrLqQN0WN8K0bSJMBlNC5Xw4wEkQcUgYDIDAQxW5hpVDg64EOJDq/ouJEWAJ/zWVCCSj4XhylvPfKjZQccm9DvcJIPWbbcm17cX1zYUI5GOILEwn4cJ4zLw9pGpIimGkpKJUA72i1jBfiJxGzk0XoqoyY7scAYFrkqycX8vC7j39OP5+6kvfSmlZAo0aIsFMlex3tgS0uX4bb69bNkVXe9dJPV3CrHPgx30Qg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	slItfbLAwkRBVw85c7WXAyYh6XNKrP+P/VoCtvAIYiGENp8zGeJbVeztDJGR635sBvrmmeT04TrXn0OgtYmTO2unQCNsIxE0C5xM7d3ur1yVUv0TtCSZP0NcG3DwWHqSIhDldR4MrX72p+Ro96inqhgKL8q9ZM1L9xG4MVijckCVWCkNmhfQweZylENlXNiEvTYYBippuJYhIjLCiliyXp6Zm8L3aQ4Zv26AbkiNRAzgNLKuBZ3ooBYWXHCsc7QcJL6CiZrDvHeVuVmMNFrRZtH5qARqlk1FpcMK2+h2DPSmOQ/1t9P9FSCu14kh6qd1Kvvr5mkUCUrnzSR2Ce+Qb0mtC1nRWkaj6M5iJ9NFC4rROdhrpzH3m/6Z4qCsNYseEjmnie0pcbtfl1Kiv6HQ9dRuT4wgKOMJBTjLJGpApkHufvA6TcZwajQ5lFyirkJL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:38:34.7194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8d4087-59fc-4ce6-038c-08ded6ace201
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

From: Alejandro Lucero <alucerop@amd.com>

While working on adding CXL Type2 support I found a problem with
register_mt_adistance_algorithm() which is used inside
cxl_region_probe(). It turns out my kernel config had not
CONFIG_MEMORY_HOTPLUG enabled leading to the hmat_adist_nb notifier
block deleted after kernel initialization without doing any notifer
block unregister, leaving the notifier chain unaware of this. A CXL
Type2 driver can be load after kernel initialization and with a kernel
not enabling memory hotplug, the notifier registration crashes if the
released memory from hmat_adist_nb is reused.

I'm not sure but I do not think this can happen for Type3 devices
because the related CXL driver is used only during kernel initialization
if memory hotplug not enabled. Type2, aka CXL accelerator drivers, is
coming and the problem will arise with certainty.

I have contemplated to modify how the identified __meminit and
__meminitdat are defined in linux/init.h, extending the case for being
empty definitions if CONFIG_CXL_MEM=y, but I think it makes sense to
only avoid the use of __meminit for hmat_adist_nb.

FWIW, a Type2 device should not require CONFIG_MEMORY_HOTPLUG and its
memory is currently initialized by the BIOS. Maybe not having memory
hotplug enabled is unusual and even more with CXL, so another option
could be to enable memory hotplug if CXL mem is enabled.

Alejandro Lucero (1):
  acpi/hmat: preserve hmat_adist_nb notifier block

 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.34.1

