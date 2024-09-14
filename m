Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12794154BE0
	for <linux-cxl@vger.kernel.org>; Sat, 14 Sep 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312886; cv=fail; b=cZavkhFaDim/3KZSrf2nmid+8ok1a2wPCjnx6YeOO6E8rYv5yMos9HyWQs8RznUqvoqByPS1dhYMb3TxcGUSbcBztJcVpHGIEdrVDntgqV/Kff1TlSwbe/CQ7tVA9dXeA73BGHAGugInBX6nlBgVdg82ovoFLQ0DLMfXkbANmqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312886; c=relaxed/simple;
	bh=aWXoHbgpbcDr3/Co/m2lXKJc5eUPEq2Xf49L0ugqyUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R+6ZCxTC6o96q1X3EzlbiK/ELp3JubOWU6y8tArPZhRMiX0sUHEaUKppa5SXWV+q44cHr2QLiNVBGoAYBM2uor02COOiM77o6zdAN0oxgdbB0aZyT07aO0HIdmtfgMLqEh3pOcqbr89U25iQ8A7X8amd3Dj46ysdlw79PDEZAcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=cPfLt7HU; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="cPfLt7HU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKgOOgcwDGfA6dS/FM53sFdILat+oHE65793Uvfy55lIwB+EEIWF1kdD8XkXmd0oVNEPXkw/NuD8ABXJcQz5FRs9nY1Or1bBK05hLx9f6W+b262PGSAnuAqqRz/H8iFz/U2n+hDnyE4Fh8/ZDc0xwdfOTH0qoNP5sQNgm+EdV6J9FXnSF8dteyTQgws9aD6/mDVrzaDVLy15+Jh9WSCQAjUkUTofFkZ2rMG/l9WSme1JRGHTjFHRwPJFKf9JHPJWM1aIfThzKFYYw8nvnb3InmArzY1yG8SmXYeD+ABH0Fk2Y2xJ9P0IsF668hWUBhjqqMOzQeQe6wA1TjY0oSC0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWurBCnkVDOKxwoN4VxNG9mRtJhZ9tkueleRIm1x0uM=;
 b=zTYNLsvsiEExHJCBx67GUfkNh1JlvKK5M5dg9iIa5FcqYPU2FQ/WfF/dPHlYEcd0XbW19b1nrg9JgfujYMN6kaaNAUrYMfl8j8Zlc0uy6PXzKmWukRe4zcRyPkAGA4qA/ZxJOMX2MS0U1O6Q6vG/kMoLfSrAmxTAYW/+cQfzAh1hA3rObMDYj7YTWOuih3/EE+xuTRn57irY3utG+WRcd442a7FQYz5+F/XLwjSlQyhqXYpbe0Szq31gn6SamHEeKW9Tfu9QqyUStRdLKVSQRB7NFyJIMH8Em5sFaZK8RSVgqKdS10oqC+zGTIwmvyJZXy+WXUJ3dbgm49S287sfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=redhat.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWurBCnkVDOKxwoN4VxNG9mRtJhZ9tkueleRIm1x0uM=;
 b=cPfLt7HU7/TZNi9kBINhlkLXLFG0+pyii6wMBTVC20Lz2G09gFRvjVPgVNbPbluVKsKNE719xqrtnwI2pgtFbkU8opkktkR8dUN9GSo7afr/cAYGav64v90L+5z0SkuRT+Tr+fMTHMyaIR4kpOIL+9QUOiUi3/e5fU5KGNH3rq7wXNbUVP0QmiUIHIxC0dNxwFlxItAeejxqJ5d7ONbvd25rVSUVi+AchxUCZeMlJg8LsjJkNSNEsFMLq/cQ9XT9sazlchdeIY89Vlhm4S//h1nKbGaYsN/XL45kWIjEOZzXOmatT+Ng11WEqnq587XVuc77EPjljAS1xc5CikN9dQ==
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by DS1PR08MB9812.namprd08.prod.outlook.com (2603:10b6:8:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 11:21:19 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::6b) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Sat, 14 Sep 2024 11:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sat, 14 Sep 2024 11:21:19 +0000
Received: from BOW36EX19B.micron.com (137.201.85.154) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 05:21:16 -0600
Received: from EMR-025.micron.com (10.101.228.116) by
 RestrictedRelayBOW36EX19B.micron.com (137.201.85.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Sat, 14 Sep 2024 05:21:15 -0600
From: <ajay.opensrc@micron.com>
To: <mst@redhat.com>
CC: <Jonathan.Cameron@huawei.com>, <john@jagalactic.com>,
	<emirakhur@micron.com>, <ajayjoshi@micron.com>, <sthanneeru@micron.com>,
	<Ravis.OpenSrc@micron.com>, <arramesh@micron.com>, <dave@stgolabs.net>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH v1] hw/cxl: Fix background completion percentage calculation
Date: Sat, 14 Sep 2024 16:50:21 +0530
Message-ID: <20240914112021.2730383-1-ajay.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS1PR08MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 51af6d05-bf57-4298-8e17-08dcd4af5b21
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6xks/WYvVZCT4Pn1nEhY7E6naINe3UDPjMA/YBtMZf7PnC/AqSoNAppSsd1p?=
 =?us-ascii?Q?Xwwacj1UoRc8tFgJ0iBMUy5NtXEL3PBsEzTD0lTkI63vdwKLaL4257eEOo1H?=
 =?us-ascii?Q?UbbeROlQk/XRKedvldrmpMk4gkoPWx8nfoE87gdjnkhG+j6MWz5eNiDVoLyH?=
 =?us-ascii?Q?kds1cNrCbCSbWGzpRN5D47IwYwjbsgDPtXZSqz40jxuxmm4QCHUghX/hLB/E?=
 =?us-ascii?Q?7zFWMBRzbgreHOpde2DnvEsoOGdJpUST1HEtnuvQ1vZhCnsi+ZgXehExTirL?=
 =?us-ascii?Q?Ij5fMY2XMoXPt1Au+SZ2ueFq4UPg9WlSxdVfPw4Ap8TsVUwuSn+pWRrQKCwT?=
 =?us-ascii?Q?U3hoQtwZzf/5imdvlLsy/6zy0w2IW7uAOJO3gr1l0w/tHTf2zwebJuuMMzQP?=
 =?us-ascii?Q?HTH6ruEPfW2yvg51q16FaGT5C2KaJ5oaA/75dlLv5Y4GbUYhjAs3nLHdgGty?=
 =?us-ascii?Q?advRPT1naNM8+h1wVSEUi7NSZj2Y2Fe//dlf2R8zQcnMktTeoWfN8oW7wj9X?=
 =?us-ascii?Q?r3PMSLwufT9A9bUvFUK3uVW9mirxrQTFa/mbEIGVXXRLysypNHgxZyYKazih?=
 =?us-ascii?Q?vFqERa21SWNCIFd7Oe7uFHJ72ZuBajKYcetyzzkBAihZQlExS181LI3zspIm?=
 =?us-ascii?Q?Sycq7ZVFWPV84nE5cv654x2gFIwn5SECLK8JB28QfccTdhnqQiHyKuYY8lr2?=
 =?us-ascii?Q?c+IUXjQ+OThvBqkbzyb+WSHOtJbRHbb/Utc4RjQUZeF6We8IX+i2Z23mGZNU?=
 =?us-ascii?Q?d7W3H0rjjhBY3aa775ySMOTTqDaaRB2jgstF5QMdXUlmC6BevAaJzrp6gbl0?=
 =?us-ascii?Q?vvww1hWTaEmU8c7Q1xbbPc+2Tbd6WtiDCl9el57Y2rv60CzDlD5Srvq37QH9?=
 =?us-ascii?Q?0md3YSMhYl0iA8lvlRJ6rZbUXTgS84PGWM8Fe9EiZWTk4R5mDpXudgbd5pKj?=
 =?us-ascii?Q?O1DX1UXaKcPr9tYQkQI+zV2WGkzfGZPmo8raxBn1dUn2e/Fr5hqBaWLyfrzq?=
 =?us-ascii?Q?C64OPP/NLAMKfoaD4y1We+b/ax/Yuq7HcK/6bNdvBZ6en7Gu5Ze9C6PpFM48?=
 =?us-ascii?Q?Vz1rXBpJWZyLkaBnTP4d0WnUx9EJD2iFDD9a73rEC/I/mO7eXaX50AJG1/cl?=
 =?us-ascii?Q?p8qs/0clj8BvGK3NL1CPXKY33Cxb30it1brOauwBNFlGuYRT4Pk2hU1sjOF1?=
 =?us-ascii?Q?tkzMQrjtkZOkjdgSoaq3Bsxi2Vp1xS5ZFiWPD5TDPURcSI4wdRjFBvw3j12v?=
 =?us-ascii?Q?fO1ea329bu2JG/955M6OWtI65cF6czDEqYby6pXARqsNzWnoJIM16Ix9R+3c?=
 =?us-ascii?Q?A9m/EwWzHTYDBtApTkv1gXjAXjYJLwQbRZ3SihdTqNf5a/ObtfHj6oGMWUKv?=
 =?us-ascii?Q?kNKJ1kA6kSoXw9DhVqG0VYBhR2kem3C0MSc9ga9m4dB2/TMI0gyJzpvvIyOw?=
 =?us-ascii?Q?v3whbAULzmT7z0nbVBs+8hF5bwe0s8gY?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 11:21:19.1496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51af6d05-bf57-4298-8e17-08dcd4af5b21
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR08MB9812

From: Ajay Joshi <ajayjoshi@micron.com>

The current completion percentage calculation
does not account for the relative time since
the start of the background activity, this leads
to showing incorrect start percentage vs what has
actually been completed.

This patch calculates the percentage based on the actual
elapsed time since the start of the operation.

Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background operations")

Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c2ed251bb3..873d60c069 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2708,7 +2708,8 @@ static void bg_timercb(void *opaque)
         }
     } else {
         /* estimate only */
-        cci->bg.complete_pct = 100 * now / total_time;
+        cci->bg.complete_pct =
+            100 * (now - cci->bg.starttime) / cci->bg.runtime;
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
-- 
2.34.1

