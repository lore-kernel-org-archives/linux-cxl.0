Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E44A02
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053141; cv=fail; b=R9/NSv06WtH7at74t5+JSzKH7pskQ65TgUUaZz3vNb7L+c4Nfq3SWD9Y3z/PslGXq/qp9ptrZaB/FlJYtJw9JAUzMt6f6ywwT+DgQBrrle2SnXrlg4OkhLh3iD4na8RahsY5cIKRPE9PlCUFsZyMrMQUYBjJw7uN8YVlRtVZaPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053141; c=relaxed/simple;
	bh=3LSqGrAsf1HaZgRy89GHzJTOEOwKinyJwbR2M2tQDCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCZ1TnhKepIltAgeOWiNHV5DfehFZh9IzRi2Gkya1Limv334+tXtwDoRS926uPMBz3GZSI9j8L0e9jlXb82lQFW2OL12Rkp/YcdKroGvCnL2Z1VcytDhQTldhuxIdNFAcyKn1WY/A6iXUvcTAExZBd+nq6a47o2SbMpr0ld+5H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=lIGFuv7+; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="lIGFuv7+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoDNua4Z7vQlZOsDeaJLZl3o+EPQecLdw7JDxfVOddAVTDkY2aVhoaavYUjtWQay2qHlb3Zr2HGI5hgxJZ6rYU4NMoOBJfB0nJ1PfsfTDtLIxermQNadgMLgfLomg2/OC5JDuoRrsxPh1RLgifTADC2Is1dcJ1KhnYv/MmkCHKV4X8fnUL+jQp37YrC8ClIIT3JzS+QZWzb5lNEmEVKo6zxpbLyhpx9VOnh8kyb+l2BUADVHisQTg0yWBpA53KikFfwR5hQn025oQs2uYZSPECk82ljId0qsPEbq/KK27NthISLLKiz3zZvnXRZOYzfmGlMN7z4DNLyz/Cuhfcqvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JruA7bIz5D+vHYd9vD3hyuYlR0r+T0FgOAM7ybt3bWU=;
 b=lxqU7rKsXsA3MMb2Pperk5hN/yc3iUsn/yr6SjSBahFGHIxxS2tYRqdPJHxI1rm54e2Uifn1q8zEbPPSC0TmAF0mYZjUyuTcu22DjWpit7waBIfE10YVIoSHAfB+BHKVf63raZMndzvxlKNYvChUZCBGdQ8LEkTybqe9p2RCojq09nXsoNXruq26PceSHXquxkVnYD2/HvvXjbfvuP9apSGQdlIMJ0i3pYOlDn7gVT1FFK5GyrcASV8X4UGesoq5g9offbDidb5jvYJJDMMxgHLUns1kzLHsSB7/Gez0v+wwPtMmjI7vLNgo+iYbFJpJT0cE11b8nAD0hjcj6//k+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JruA7bIz5D+vHYd9vD3hyuYlR0r+T0FgOAM7ybt3bWU=;
 b=lIGFuv7++VMSGwOGQ4q2ao1Ad+Snevywb359LtLlvK91vssUkRdFt2EmJ4Zby0jh2ZHcjpvGywovxFiCGJaPeO8jbQolFV2UU3v8Totg2x/X/wqAqpZwyg05rV2I4Pzl/VXLhguOpokTh35ksM8uR9Cv2JKJxQr57Ib6KDvKEAnsucAIy8x/5EDwG8CEf+djbiYc5uJjBEKym9nosc7wRGsPX0+RE6p5S/TZlGGsAAq5OldYPyD115BtmmVdyxL+e9FeaFvfdXT/CPYzzpnkCMKJI/5tu4DiP44IThEj3XJpU65GmEMxJ84dLrdu5nInoEnqrV+P5yBHQG2ga+pH8w==
Received: from SA1P222CA0042.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::16)
 by CH4PR08MB10537.namprd08.prod.outlook.com (2603:10b6:610:241::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 04:32:12 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::57) by SA1P222CA0042.outlook.office365.com
 (2603:10b6:806:2d0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 04:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:32:12 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:32:11 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:32:10 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH 2/4] cxl: Add default timeout for bg mailbox commands
Thread-Topic: [RFC PATCH 2/4] cxl: Add default timeout for bg mailbox commands
Thread-Index: AQHbH0T8FAWXHcmfvEmE9UciY2LNybKIx7fB
Date: Wed, 16 Oct 2024 04:32:10 +0000
Message-ID: <15a291283358440aadbabca5f1400919@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>,<20241015205633.127333-3-ravis.opensrc@micron.com>
In-Reply-To: <20241015205633.127333-3-ravis.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CH4PR08MB10537:EE_
X-MS-Office365-Filtering-Correlation-Id: 73518fbe-6f6a-427e-6618-08dced9b815f
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ySbis7yWCWdUfiGgRj0t7W8BfyrCMg1Ocu0+sNtEzx0rJVGyOFwWX+D9Ko?=
 =?iso-8859-1?Q?Rn7UgnUvOpIVRdMH+ibdsE1LGNuUvMOx1pKXpfW5OCFhbRP/uN/4XZW+a/?=
 =?iso-8859-1?Q?7XEgnW8btu0joRDda0569K1SB0P2X9TEo6qIoYokrTtTm5PtA9SNxaNsEV?=
 =?iso-8859-1?Q?IwPN3iLEm/LM2XhhY4R2+30tSLqUSmAjs9sqp0fDtxS2MVYB1lx9zevlpL?=
 =?iso-8859-1?Q?v+PeBR95QU7JukEQOPqaFq7fwZiSKZPb5f73HiGVhDJ2c8zXX9WXe3h81o?=
 =?iso-8859-1?Q?V3ecoPGhppKx/PIkTVEEisYRlI62ZBfkTt21tp9Wzp7d2BJwXoT2zWemmw?=
 =?iso-8859-1?Q?nH69hFOsyPB8xd4gfpggzc4F+n388ZM3FsQumd7KIPVgtyDvdao9OHIINJ?=
 =?iso-8859-1?Q?dd4sQpPLTkQbrHDJrsCwtz2HEn3ZopYerA8ILvAncxXD+Ip8MErMnnvRjs?=
 =?iso-8859-1?Q?yAn20iazykahNeHkE+bJOpWAjVc7BfEwLr6HIs2mTtKqSeOYmhoCyAwCtz?=
 =?iso-8859-1?Q?f/J0Fzsky64FkrMTyZlhCUHWtYkhT1HEs3EzM2UPHiSShk0VkLj2SWwDow?=
 =?iso-8859-1?Q?i0iCkwXOg3iRJLHbDpKs7R7+X/zigfuTfWTQWOpFMWL5+/8Vv4ON52k27l?=
 =?iso-8859-1?Q?P00otBKigDWEiEG2dQAuVAy82Cs8jI96ggSkxwuWtbhFFJgjCqpczoACUP?=
 =?iso-8859-1?Q?gXw2RKdGzoCcbIzAOPmsdrRW1clwLFqtxPdqAGFeqFORpCOs/7UKWkipq3?=
 =?iso-8859-1?Q?qdoPOvgZOX/uYs+506aKu6GhRBH296pBDJmz3AE+DKi8/6DGsiSwwsxj8l?=
 =?iso-8859-1?Q?pPLsvreWCt8fLiUBLsyJqhTgFREeAH0Et5OoVAslk+idm3j8ApaePOqjEw?=
 =?iso-8859-1?Q?H+9FgaHMG3Sx/GBrS3RJcIotJFqC+xv/ouhVU+pHyASFJFkspJ+H8ZmoSV?=
 =?iso-8859-1?Q?bk4X74CRm3uXv24rEh4ixsrUFH1cVN5rIt/hwi4xgktaNqPQHKN0A/A2sJ?=
 =?iso-8859-1?Q?4jtHGgCuxWMX9dag4nOPJoZWLvzasDLrGuhvd4AD7kNId8rpwM2fnQUecL?=
 =?iso-8859-1?Q?SMUvJuyF1F6uU+FW1uJTHmVqeO3W2I3rynoUQaTLfED5xnYptK66wivuvX?=
 =?iso-8859-1?Q?wWbV6AP1WyUOTY8ADq86lvIt8GenyLpGrJwj9zDYO2NBruqfENIrFznIQa?=
 =?iso-8859-1?Q?PszLmU6/YbmKJjMjzsMNhtJbA2BQvHSJ0Vz1TpmTWnNTCfBBCh2V1/lCu3?=
 =?iso-8859-1?Q?I5fXa3egymr0Vnygn7K6jUS/PreY1nKrlTOhITWEyBFXrS/eKQnHIaDzte?=
 =?iso-8859-1?Q?EUItTJMnHEjU7XoP6lH3Uyke2rW/Ns4SRywctNsX9mq5nMjPoFKcKM0iUq?=
 =?iso-8859-1?Q?rNtnRiU1fZKATZAg/jnFb/3MaitYVh3dPBcMCBE4M6PM49hO+vaPW9uwpy?=
 =?iso-8859-1?Q?fAhEG5w33OZ5Tm++?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:32:12.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73518fbe-6f6a-427e-6618-08dced9b815f
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR08MB10537

Allows 5s wait when no timeout parameter is explicitly mentioned.

It is useful for mailbox commands to be executed in background
when initiated from userspace.

Link:
https://lore.kernel.org/linux-mm/20240215123410.00003b8c@Huawei.com/T/

Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
---
=A0drivers/cxl/pci.c | 13 +++++++++++++
=A01 file changed, 13 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..d5d6142f6aa3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -41,6 +41,10 @@
=A0/* CXL 2.0 - 8.2.8.4 */
=A0#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
=A0
+/* Default timeout for background operations */
+#define CXL_BG_POLL_CNT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 5
+#define CXL_BG_POLL_INTERVAL_MS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 1000
+
=A0/*
=A0 * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
=A0 * dictate how long to wait for the mailbox to become ready. The new
@@ -317,6 +321,15 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox =
*cxl_mbox,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(dev, "Mailbox back=
ground operation (0x%04x) started\n",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mb=
ox_cmd->opcode);
=A0
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Add a default timeout of 5=
 seconds when background operation
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * starts but no timeout is s=
pecified.
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!mbox_cmd->poll_interval_ms=
) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mbox_cm=
d->poll_interval_ms =3D CXL_BG_POLL_INTERVAL_MS;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mbox_cm=
d->poll_count =3D CXL_BG_POLL_CNT;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 timeout =3D mbox_cmd->poll=
_interval_ms;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < mbox_cmd=
->poll_count; i++) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
--=20
2.43.0

    =
