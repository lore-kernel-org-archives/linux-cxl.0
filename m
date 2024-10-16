Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D2189BBE
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054771; cv=fail; b=ACscTPJ3G/W/rt3cJ4IFn8wNR3YFioYqQZM2sMsAVeIBZzBiNoWqKW1JGbSCSBxKshQf1Zfj3wqaklENf0ac+HhLeS4O+5oAj+qf2w4g8IsIeti6HnEF+c794El690x+kqofnsoT6cbuLp1gM0MMIog/oVirMq/J9E2zs0zKJeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054771; c=relaxed/simple;
	bh=yBW3jMLL1sae5VCNflFZ9FBCVJiftEGXafgm08z5bHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUub0coAUPUFQAWlabdFQk+081MHdf322puFcWPrsK+VSYWmk9u+EeV1TU5F+EkkzQmscHhfM7/jOCOdZGx7fDwqIgRMCy/8SfHmPjHuG5YZWgmcbTQc+521cPMKAowxi68E8DFpPXVU1NS9OE+vCTwSoRg5Ooa/nVjEunmY+LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=P0uAA7/D; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="P0uAA7/D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fz3hdDpcRuDFa7NwViZl7pGI3Ial0s3Yhfy6LJPSF6E7PAR5ENsHCgsCMTEKUtLr55M9Lqnt7VmWra8UYJzZkk4UCNADMzt3+oaw+N/UvYryNrxd0B2WDlccvMpCHIm1W5rvcT1h5EfZSqABlko8SGFnTZgSfsJtb7noK2CIBp32rRGwj3vw75qi3LSyG39RjiOR6y0556Ay2paOFxOSmtl1dR2yijVYuF/+vlPzu5ZjhdI7FOze/dpGLNA/1drNE2AmPibRiy0ISgwVAfXRUkg3pOqVgOvyGgJGPmtgcRVfP/jIsi4IWLurxE1ViQkkRusGGV2p+yAsB46rYGaHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdd7paudHNUPy0L13A3TF3XyVoi/+uryNdQvgRAV12A=;
 b=nLmUaI6Qk3JmeTKitJeMBoxvFcDpDmGf2yKMQ+U4qHYDv1N7z4E5g7tMZ2smlzJNaPDnFh7CAN+w3SlYnAePwbSmCu02mA2LLpKFcI9mwupQBxINoV+CX2WPnfpE2qRmyGslVQBmuLfgJyS1oIEv7qZ/GAJBmvFAEydH/ki9+y4jlrH6zDo2m3ZcsWlPl8Vqm3Ry0PzilBHgJNEX+Nui1dD5z8fLuRjaPO/X8bZzhfEH2VwhKhur10fP4biIlDjPuM4Sw70aw1f0ZCMW6+FWgVy4jfezXnnSkt+YmInC0nkdjOEbB9IUbj1ngTp6oQtyHKqsL2QWpecWW0U5HZ9+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdd7paudHNUPy0L13A3TF3XyVoi/+uryNdQvgRAV12A=;
 b=P0uAA7/DXx6cDzd9Nu/ONqxunAaw/y60OETZqoSYX8EsXuo/OQoaxnAMcqBhqfd8AjjehaZbWGiFmdyxKxYi43DFXMpeaop49sNZ7/ZZHJnOL6RgNPOv55n/twu7CVmurQL48XMZZClk+GAHkIpyQVOk5ltkJ3mfgrQ3i8/0qrPo9j1GN97N4RqxQJvSlfRC9h7aLwtJPH+jdU8Z0xbrqDqP6wLoap5Ma3bf7KMbUrzvTI8S84+nBaxcyOv0pxZI+JGt3zE1UN6Pafwc5101T9eNqVsT9wuVZ5HGxu9Z+yKKZDaTHf6tb7d67wfkDrrPG2lGcIlxN70ApD0DrlU3fg==
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by CO1PR08MB7239.namprd08.prod.outlook.com (2603:10b6:303:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 04:59:22 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::1a) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Wed, 16 Oct 2024 04:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:59:21 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:59:18 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:59:18 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC v2 0/4] cxl: Support for mailbox background abort operation
Thread-Topic: [RFC v2 0/4] cxl: Support for mailbox background abort operation
Thread-Index: AQHbH4gnxfEFFHX3w02vX4RLPa/4kg==
Date: Wed, 16 Oct 2024 04:59:18 +0000
Message-ID: <2f54623352294ac09fb8ca5cb9c6f6da@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
In-Reply-To: <20241015205633.127333-1-ravis.opensrc@micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CO1PR08MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c18b0b7-c780-47b4-ea83-08dced9f4c7f
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?CE1+nRJPIFnlHb6aGm2V6ZoPDxWStcvsuRf0nWUwSkcT1AIxg2nHZ3BPDc?=
 =?iso-8859-1?Q?7a+XwU4bHxlxEshPMIFSrIV0c9+4X7a/EspRaNQ0bql38sjo9gklAxwhVM?=
 =?iso-8859-1?Q?k8I7bCKDz3HRXPZqcwAQGdmZ9S/Xqvq7G0/oPR83UNW+B8Fka+yhuYURCt?=
 =?iso-8859-1?Q?YIBY4w3VuFhp6sThx5keE16ic287j1V7i0PgmmmgYym2Kgu4l9YBsWy9jk?=
 =?iso-8859-1?Q?iZqfw8YjuzxfOrBW02zkOBA73gI+UIgyOSUoYlaGE0z/7X3o4UK1Eye6pQ?=
 =?iso-8859-1?Q?rFko6NJI0EyBtugQDTjqpbqgkqG3/8JEW3pSFZpOBhgYBxpuAFaT4A8c3D?=
 =?iso-8859-1?Q?z5mjxLaQYa8Tv4Wzh4ts+cKmzN+Fe9UuOs5zK4OYBzYGYNu/O4J5B9FEm9?=
 =?iso-8859-1?Q?UElQCHoYWPAHlRxlNKleVLLNqP+1AlllfCwYad4tMWdGe6cTVMmAkTgj6g?=
 =?iso-8859-1?Q?3qXa9AcHMlcvmXSEgzGk0ScxXEz7NYE0wzq8HZru1srjwu8y32zmIKECp/?=
 =?iso-8859-1?Q?n7581M3NTe9OrLJjTZRtApEiO9z9aX9PxNybELKOP1D1Ap99vMPi8nOVQv?=
 =?iso-8859-1?Q?16e1Nqq4rHFc3lCiRd9/HKkb7NnnYYoUX9S0JhdTIYmE6TZqy+biseZfnF?=
 =?iso-8859-1?Q?UTTO3oQ+jmlopK4w/VOxbvbtGGMlplSGXRnK+nADrOI9YXZtoGAqilHGqd?=
 =?iso-8859-1?Q?KfKdhYd5SJrYzcaZ1ViO6NUqFIZZd1nhJbdQhHj0i1lC67xGlDE/hxO99a?=
 =?iso-8859-1?Q?J1hDQKIB3z8fUR38ZcPjWhmEbI7TF/2XPGW4SaI1xo3TxCHeCz/S1PKXq6?=
 =?iso-8859-1?Q?bUM6YIWln8XjjfLoLwU2KIB9msGmD5ws4rxcNYlgCHaLmux6OLjnvh8JTV?=
 =?iso-8859-1?Q?avjQBvlXLc/IANlLM4uubUxeksg+TqTZDBEmajQjBKiHkgUFFXvdF6/XTL?=
 =?iso-8859-1?Q?i3u6vu4dGKumuFaawYUZHDmzZPWJILPpobJA+sFpvFOCmjnDbf3tMJk0GJ?=
 =?iso-8859-1?Q?23s6TV167M1ZD5zUwPl4Z7RCbHJjm81fJyfruaTnjFDquLLQqSvXmEft2C?=
 =?iso-8859-1?Q?cVVA2bDWUOcLgZMiR7O2+GmY/AEoYvylCiVHGK7BiXM/vEZSCxhOv4diB3?=
 =?iso-8859-1?Q?NTay5ovi27PSvIo0+d2kudjTwqx/6onZjm4dR87C6YDEU00EfcOVicPMGs?=
 =?iso-8859-1?Q?NqcHNaicGTcEkDGuw2EGLXbZz1G/QxMUXh4S9oDdX32K7b3oY4ugQUZ1Rg?=
 =?iso-8859-1?Q?1zlR5TEO6asmGDi3sgLgqY2OGagZoDw225Fp7WTj0pmYS5S+gfpSEEOKDb?=
 =?iso-8859-1?Q?Ob4quVzfnr8HP9JQXOb8Gie7dZXbSpPB23Hyv8DnjIO6gBebKiVF3cMp4u?=
 =?iso-8859-1?Q?46tOKwN2wQc3DXMfsIi4mmgzEVDQc35lvnjkS7T8uFuyDZXZ3491ontfjY?=
 =?iso-8859-1?Q?MeOgPZNeS1jstJiQ?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:59:21.7083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c18b0b7-c780-47b4-ea83-08dced9f4c7f
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7239

This patchset introduces the Request Background Abort operation as outlined
in CXL 3.1, section 8.2.9.1.5. It ensures that only background operations
supporting request background abort are allowed. A default timeout of
5 seconds is specified for operations where a timeout is not explicitly
defined. If this timeout expires, a Request Abort command is issued to
terminate the ongoing background operation.

This patchset is based on suggestion from Dan Williams, as referenced here:
https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.=
intel.com.notmuch/

(1) Patch 1: Enables only those background mailbox commands
=A0=A0=A0 that also support request abort through their CEL.
(2) Patch 2: A default timeout of 5 secs for mailbox commands
=A0=A0=A0 that do not have an explicitly mentioned timeout.
(3) Patch 3: Adds support for sending an abort when a mailbox
=A0=A0=A0 background operation times out.
(4) Patch 4: Adds support for the Populate Log command,
=A0=A0=A0 a background operation that can potentially support abort.

v2:
* Added missing signature tags

v1:
https://lore.kernel.org/linux-cxl/c3312b1ce2374fb28a899b0bdb01c6a4@micron.c=
om/T/#t

Ravi Shankar (4):
=A0 cxl: Enable mailbox ops with background only if request abort
=A0=A0=A0 operation is supported.
=A0 cxl: Add default timeout for bg mailbox commands
=A0 cxl: Abort background operation in case of timeout
=A0 cxl/mbox: Add Populate Log support

=A0drivers/cxl/core/mbox.c=A0=A0=A0=A0=A0 | 13 +++++++++++--
=A0drivers/cxl/cxlmem.h=A0=A0=A0=A0=A0=A0=A0=A0 | 18 ++++++++++++++++++
=A0drivers/cxl/pci.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 24 ++++++++++++++++=
++++++++
=A0include/uapi/linux/cxl_mem.h |=A0 1 +
=A04 files changed, 54 insertions(+), 2 deletions(-)

--=20
2.43.0

    =
