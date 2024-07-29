Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6174055
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jul 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248640; cv=fail; b=D5hFgMbzOa1RmVRofblAplqgDjLTWyXGpPoNAWI5ORmLjH4XQSkUeEOajLKG5ruh0n4QVoOinefrpaVQYsc/6xeQY1KoqQz+Q0CFGXGY0yzCzdfv939A3e9UEAQaz8L49IvlpqflwRUNYpuOuUoqNuebVUpq2L4TqMvDuWJi4yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248640; c=relaxed/simple;
	bh=CYNYZ/PR3U9zqvuw5PfmPxBilp4gmcBTVjipfL7Tzwc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LD5PH5XNrGH9TU3LLv939jvfod1Mj1cKf7lvdH/in0qF0KcYIZmHGE5PkbAEk2RaAHNtabhQ95ZEh5+ehImj1j4gS5wRFsIF0ynlHbDZFoI5O+MaOanJoVsZgeRfTqylhkD4TlfI+Aps98l7glVMgnDFB5EF5K2aWwEn02T33k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=nJVPO8v0; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="nJVPO8v0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntcupzGz/HFoVT6/wOquXrBeCcf5klaOboKGYV4fXPb8p6TQS87RpgrOp4+8rwKC9fu3pP7j8Kjdsl0WQwyPRTPNQ+1WWhWS47igC4OxpBx/EJB81vZLfu6dRLeso/Y4kBzraIDXqHIcRyZNvTQsq16RjjrC5OXKaVipwsdksDKzF4Lx2+/nldyluazUB9D8C0TTGoaHu+Wok848XxJDLRWJ9TV6G9nmbtMcUaZgPq6m8OObKhJ4ia3zBBYkQaFExHJp6jBv82lsPh+TkOz9PWMoUgEf1RmDMRGGHzROeB45wTd6VbStCxVq9709VZS3gvYbIA3xD6Kd+TXCdPrpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIm/9uSIYM8//dw8j0DjxrT//dSN3v4uDnKQ1yvwYQs=;
 b=jL7dPqo0lmYv3dpAJgHm9qxbaq8jHJ+FroUK6pcaEDdosGbzPM/97xX0ytvAqmi3/yYBXTvWKd2E1tiwSaJ9aftUuIT0GjlhjGWw3E8jCMWKifqObXur+g+9dSG58mc8lLKwA8Msq43LmaKP7YgvZVvu6IbxVhcNwwycCtupVmSuG2PsZnejVzkikdlTxZ5jdG1U/neWRvzCILt58RPE0CSIfYtr6baAy1dKWOn3OQe3zZ7f7/NKK85Vf+RflNnA5UZxjbyCigP9raCkxdgyE4GpaOUkB3gjNEe1LXT6Mn7xMTzlNlPh9l2y1Nf8jf38rNoLttvEGGbgOHcBM61puQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIm/9uSIYM8//dw8j0DjxrT//dSN3v4uDnKQ1yvwYQs=;
 b=nJVPO8v0gGq7d3+RyKx445u31JXPYHdsxL2kx2Vpu7BdT+FkCSJYpIe/nv7zOCJd5BBUJ3rI9nl9IPjlCRgHahvddN8AHPFVePjF+bDKjjq7VR+lOKgTGQxoMdsY3NhHUdTyYCss0CBA8vhdZ4+G9cFv8pMOT59Bf33LnnSb+eYK1j7pL+L3jvr+bnulFsE3Uou5PtUwAt9wUZLZQWZUCTgwUiidZqyHM5fv5Jzn/yPa3wyLh8DGGqhNvRbgZEfve50VN/i6POclqcEoRjK/Zla0iLxJSmuIGHPmy3YKUc6gCF7KyDDf22JKl8tXo2sGthGo7RHB1uI1gmmUFb6TbA==
Received: from BN9PR03CA0682.namprd03.prod.outlook.com (2603:10b6:408:10e::27)
 by CO1PR08MB6609.namprd08.prod.outlook.com (2603:10b6:303:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 10:23:53 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::30) by BN9PR03CA0682.outlook.office365.com
 (2603:10b6:408:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Mon, 29 Jul 2024 10:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 10:23:52 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 04:23:50 -0600
Received: from AJAYJOSH-LAP.sing.micron.com (10.3.66.158) by
 RestrictedRelay17EX19B.micron.com (137.201.21.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 29 Jul 2024 04:23:46 -0600
From: <ajay.opensrc@micron.com>
To: <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <john@jagalactic.com>,
	<emirakhur@micron.com>, <ajayjoshi@micron.com>, <sthanneeru@micron.com>,
	<ravis.opensrc@micron.com>, <arramesh@micron.com>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH] hw/cxl: Fix background completion percentage calculation
Date: Mon, 29 Jul 2024 15:53:38 +0530
Message-ID: <20240729102338.22337-1-ajay.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CO1PR08MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 0879b874-c728-428c-d902-08dcafb88b98
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KQb/WtHvg53WRdcGCPNV242wO5DtwYiSZVSkwy5lcagE6nq0Fv19yk/IoYJ6?=
 =?us-ascii?Q?aWCgv+r+WaP8dgu/oLQ+0DWM8QWbI+0uPhPuQB1m4GRzOSWicFyfqyVDKoB9?=
 =?us-ascii?Q?R7VcIGgPzF/U1lCtjMW05OsIfkackzwPujqjbdF6iZzV3zi8KaXCwo0zQ8bn?=
 =?us-ascii?Q?oXitjmfVSpcVPfCEAI3lHlBhW5pb2FEhGjZA+/ArKh/zx12N2UPzkAid65SU?=
 =?us-ascii?Q?QGWYbLnae2XxhjSd71hAO6gqIqSuvjBtW97RWJEMUeH7QHJ+Btdctlx8I1Q5?=
 =?us-ascii?Q?oFRhC9RuVHXA8XyKsFI3JaSbYRA+iM11UxgVl8war+m0AZ5fcf8oW/G6jVUn?=
 =?us-ascii?Q?ie85BOEc0X0wF8VIK41bp0qLQ7ontFO0Fze1Bn8xkjxrsoXbjjcYVTzd+OAz?=
 =?us-ascii?Q?ocAoSHifkVgO7yHLzJho6sC14TenXxU/SJNjpRIVxmYpVTu1vD2tdV/iSf++?=
 =?us-ascii?Q?D0D8e2mqlj4boPVZ0lkqWxc7LiUHePa1RkilMDWjRfaq7NtC0DmrDIhNpbBm?=
 =?us-ascii?Q?HbIE8J1tUaPdO1kV0g4Ro5DlTjz2ilgnaFlmqsglVMYkv7AmUbzYMPx5PYIO?=
 =?us-ascii?Q?TRRx+yjE9qvNRpjVMVyJX8SEkQ0Aopd/Gl6dE0LAkyBN+1A6CrXKz8FX1TiW?=
 =?us-ascii?Q?NwMe7x91Bc+/8Ou4ynx96x0EzeFZoJB2Bve6vFoTWoGXrLBUU1mFpSMYbCrr?=
 =?us-ascii?Q?Q9GF6lgmXNVzts+LZidK1HnDtACc8y6k7TX8jQiHa809Eme2uNz2gVjDInbJ?=
 =?us-ascii?Q?Kk8KhyPQgZMYgUdv1Kh6P86JATfYeQTrTqoF15PSOpI5rZjidP9QlpI/T11l?=
 =?us-ascii?Q?4eCRb+dFMFBKzgk7O7WFTUXj+rsX4kegKP1S3UbUW29bzmF4Jb3+7Vd0rliv?=
 =?us-ascii?Q?+s2FUnWdYFKxrswibkGhppADSuCJh+b5FgtTGeSSt+1T+lwv2N/rNWJzTgpy?=
 =?us-ascii?Q?sLhjN1ET6znvVRXyhWWz6t7U5e4YAqagXMaQJyayvfIaIS6ROyKYf53WYUoe?=
 =?us-ascii?Q?+U0Zdhiqe9JZ3m001Y6hI1gYr8UAf3KSDK9g8E94KtcAPmJlEWcjDK2Afqlm?=
 =?us-ascii?Q?uzZmkD8NLVL3R3i8pOuibuWub1xIq0M+nmWN8NP2+hMgy7jkHV+wJkFoANen?=
 =?us-ascii?Q?4Jiu1ODchW4/ZZJt/mslrOw7QtLamxS8/NQ9janK9d03uiduEtYfwuoSnt/p?=
 =?us-ascii?Q?QfYBlh9NHoI9XhoiXiXJPbPDIASkYJdt9+2LJvzVWur14KGuvrgff0BnK+wZ?=
 =?us-ascii?Q?Qbbi217yONcfiAglZmeqx27FQMI828uok5Oe5CLAMqKxM83MXO6tJgwPlxp+?=
 =?us-ascii?Q?vS3ONhI3ISxQTmzHjKTGyXhz8HF7UOkpH4eG/O38K/jUcCCnhmaB//TMLIHf?=
 =?us-ascii?Q?LZYMGIbKTCdnq1hOWGGQqdEULWT3nwx0w2mr1pfUTxSKBCSawIQoicHNONt+?=
 =?us-ascii?Q?SSxg+iAS2InsSpVETvN9bmwIbEVAXyaU?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 10:23:52.9098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0879b874-c728-428c-d902-08dcafb88b98
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB6609

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

