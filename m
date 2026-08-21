Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F7490C04;
	Fri, 21 Aug 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323359; cv=fail; b=DkHrzl1h8IZVBMvJXcFmIrZKw+puwUAsXjs5esdX/39yMK/1xH5fLQB1uhsKwtbfmXh3fn3bAfbXi2TFtOPpCZe2INL/wPbzJAaZih7akzzPaN9rJjLnX+lO/+yzT6bvtaEy3QYm0lAK6dMBMCBrySIwCmemXqDgSzmBN9EvDaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323359; c=relaxed/simple;
	bh=t3u6+MAHpopvgwP6YGkSDSd66n3o8JQ8aR9RvD44uLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GTCCxuk6+Qg09FkVyxlDhB/PL7j0rRRhzPUUfvLLHZvogE9ZmdgGlJhHsyL/t2715/BK+cv/kf+9AXm2RbBEwLrGqbKebKiBpZwviL47iKHfyeKhDdsq0pQBtz31JQosgAAWKzluSJSnZfKkIScUt0eMQGeTMyiQJlTUpfthK4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vt+iV2Br; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vt+iV2Br"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjsnT53dXA/SARXDgIW4PTob8U1WfPmOlxWcSztwxB0DmabZLaECf122w0xVeQOu66vMHJqP5vrxM9ee7mvLqxnmQP2w3ES1ucN+lS5DqZX9Zw3HV6aVJfB8l4Nm8fv1wnKLL5xrrLTHK8DPlOWEG7EhcC86nxgjfFuwS2P+LS+cyYEiOsdiimoVN1vknYTK0fF7ELCNXrh7TP6mNS3BzpJcmeAUMyho46cwreYVVc1cnoB8fczIrT5y7iZAKtTAz3vY3Og9/8KdXoKUB0tOMpWNQ311Sv4TFHMp0Da6P9u5L9IvjY8NIaWWQzmLRNTpqD+0VXbVQNWzqXnyJx0NGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vok32WYhV+S/xdztILAkuV1t9PWqyeaW6xsAXQ6OAJQ=;
 b=qEwCSGYidt8DH3qlBiHQH2ma0NluY8EVYgb1nGbyaMl78oi042zBlKsOQfN6BQ1OBVR+KK0I9iEGA/1Z2D/Wnv7F02Yno48Li9qc7blEMVL0g+Gk0RSLAL5WpFu/ju8yQ/FjwCaKmo2mnl9QYGB/h4ejDS3tkXVhWLhm0378OXJVwKN7/wJKjyJcKY9mvSyJM/Z2hOgTf7mUBrLRBbCe7NiFTpjPgVnhEg9tob/CA9P1BIyewMOfnqYmR7RYrZht7yrKUMBXHXRH2ZlACvdE9nraq/vLZi5hxG1xca2oSFKp6GarY5CfWhQf80qZrRbEn6mJGDGRE2ht0shWutJ1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vok32WYhV+S/xdztILAkuV1t9PWqyeaW6xsAXQ6OAJQ=;
 b=vt+iV2Brd8whZBRHXQ/73QVb3CGa1Y8lKzsBumfGFlHkoCwq3QRp2Nk3NoQ732HkbDvcCiLio1zqgexnA5EUx6l0EKjdz3btIS/x2+fm74vCugsJ9NnjZSUc8m/cQZ+foA3S2aVoaSa+E6MZREvZZB+MdbgL2rDWEE78/LiLZMc=
Received: from SJ0PR05CA0136.namprd05.prod.outlook.com (2603:10b6:a03:33d::21)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 14:42:27 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::90) by SJ0PR05CA0136.outlook.office365.com
 (2603:10b6:a03:33d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Fri, 21
 Aug 2026 14:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 14:42:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 09:42:25 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 09:42:24 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 0/2] Type2 multipf support
Date: Fri, 21 Aug 2026 16:51:32 +0100
Message-ID: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdfa618-7b85-4a19-f57b-08deff926bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|5023799004|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Uibgzo1+kPrxYW+xsM9HvWIozMXpeAJY40/CK6GF2t0v69fmLStcfKd4eTAACDhcEQocLKWc4YnEulBDwue+vubquZBTXYIu9PPsBZCbxy48f2Q0QyHy9PSwQGR8uvf8RvMVAZh3t3FvrHYtFkOWJl4znQ/eR48Ulot3hvH3mUiKg/OaFN+S3B9fhJuvUrtESia0j9plWxd+HeyCrylIdbxzj/LAvxKQIqmat0NH5cJdJtgw8pSyg35/bbwqaqq7Nt+LNf+Bz0uTSfuRfvl1EzyYtrdaLXUk5CNctcsBLGAZtdR2hG1Il+nQy9y5PT7KEmEJbvHOmasU+h2IlyHQHooQcLi2zzc3GZsHKXxh64n1KIP8qye8FKvq4Udbv2z+bwWDI4L3neg+jB9gvJRWpb2TAXshODTu0/FOBD1gvg9ZtlSKYQbis+AVAHFSTqap+/Azmh6AvllKwD2j6YP6tK+awQWMLzFqKvoGERzFzRJI4NxCtQYm0Pg7WCHMTrie//Dbhm41EVSWpLMefKUbd/+J3xVgJqVCW39K/ZKqbOLT0p905O8T7V+sOTeFBoIw428lJWlTNBvvZ8Bzr2ls+Lmpq8f7gNs7rsK+vocwS2yA/0epJPMFUljJxcUDQN8OFxunW5UuYY4/mq+A8ngg1pEdXUpxiaGQOolARwBVi1zWIgFjo84oVGL1bEm+anMu8Ul5nv5tR29Q0+WDKgOu0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bZyZBCaaXsxfVgnoICgJoj2Isybke51dJdr+i1a99sNvLtDoUm9ce+zfxmDA+tl0UB/dDqracIMgZ1xutg/UQnVybCz5pdCp1pS9C9xWebXtaRNXScaz1V6efXJN092x00q2NMQlp1X2M3e6/XMQqC4AwYq7OYcurG8CGKqNQBJR+DUgbCiGwe+TVcj0mTMGYbWQZ4zcvzE2/Kk6vmv3vV/mxwinSZbqjGwgaMGu88cUDTGVgLA7mcFZkZUiL2SSWIHLBB0QmiQJaFjfUc8uqt0JrAJ6IbQDoraROJQjvxBuwQlBfbQVI6UZWZ64FfiqWUzVLvvaX3BnV6Cwkgxn5Y83l7GFu/Jdtkn9TotB52oRpy87jc/9Xm0kFLuqY/8RQseySYHciOSryp8Gpovaz8B3T5cmCSO37WetDR26QTJmVWJguUl0eGIleCKPMRf3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:42:26.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdfa618-7b85-4a19-f57b-08deff926bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E

From: Alejandro Lucero <alucerop@amd.com>

Commit message of first patch explains why this is needed but I want to
add some comments here.

First, the final Type2 basic support was possible once Dan Williams and
I reached an agreement on how to solve the potential unwinding spenarios
linked to a cxl memdev object. The actions triggering this unwinding are:

 - User space unbinding the cxl mem device from the cxl mem driver.
 - User space removing cxl_acpi module.
 - User space unbinding Type2/accelerator pci device from its driver.
 - User space removing Type2/accelerator driver.

The last two trigger the unwinding from the Type2/accelerator driver
exit path, while the first two start the unwinding which in turn invoke
the Type2 driver release from its pci device.

In any case, the decission was to release the Type2 driver always
instead of a degraded functionality if CXL.mem is only part of the full
functionality. This needs to be extended to other non-PF0 PFs, so all
the scenarios listed above ending up releasing those other PFs as well
from their drivers.

This needs to link a memdev to those non-PF0 PFs, and invoke those PFs
release from their drivers when unwinding. This is not complicated per
se but the devil is in the potential race conditions between the
linking/unlinking and the memdev release. I think it does only require
to keep a reference to the memdev device for the time the
linking/unlinking happens, but maybe there are corner cases I did not
think about. I have tested it with real hardware advertising two PFs and
under all the scenarios listed, but stressing this requires another
framework, likely under qemu or adding a new cxl test set.

FWIW, using vanilla 7.2 as cxl next has not the sfc changes yet.

Alejandro Lucero (2):
  cxl/memdev: add support for mutipf device
  sfc: add multipf support

 drivers/cxl/core/memdev.c          | 122 +++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h               |   1 +
 drivers/net/ethernet/sfc/efx_cxl.c | 106 +++++++++++++++++++++++--
 include/cxl/cxl.h                  |   4 +
 4 files changed, 227 insertions(+), 6 deletions(-)


base-commit: 818bebeb63dd6bf5f4e07e145f6cdbace520a34c
-- 
2.34.1

