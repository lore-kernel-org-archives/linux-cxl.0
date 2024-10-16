Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC818A952
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054807; cv=fail; b=H8DXMbRoSG1hwqIIS2SYe47hYkq6EbC16BsTc0DM9kDaQjIwaSgg1B9+QOP+4ocukTkNnQW9vVahRLf2GyKKlp0rMH8ohzrmIn79v+X/7dyRmVlYha67KEYO5Sat1We+kAJCdqBCeGci79UayVwehAv8cTmNw6MQjdnFQ3enOzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054807; c=relaxed/simple;
	bh=fl5VuP1t8TDwTkFqLSciaGdjCxri2p6Odj6TMVBkQxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvLTi8Lopz4oHm0rzA8oNopz0nqjs7ELMY1wrRdoLg6FldZDaENNPTRllHF0I86pjOTMoDVjqwa5tLWI+KGg3l4X1scWirIi4Vm6wv/QrrgSuVHG0stVFfInn8pHuFecagnyPNqQsJaXGLbHuxigbkkFtopCgrtdtt9WXU9uk5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=OY8xfMHl; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="OY8xfMHl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEyPHu5opMWn7PZK192rCdoFjIDZGPRgMeUBiqNBzr4wsbSVa+rHicWxi+Sin/Ud0QNz281EVAti+XvE/bQVIQrsjBl5VBwcTPUwgTkgxYLIuvw0aHjxzX1xgsvVy3Cyqt6EneXOcc9JfFSjFaa4S+W/8vK5pvz2vw0PE6CIxRnLnWrfOAwz63vO/iMx/fbSUa6G/wNTtBHc1LhwDWmtme4GG+hQab7+KVcxzKqKu1hpeb+phV5FA0Q46WnQFoNKu2peIvZbfR42y86mwDf5cb11qMrnBk9/N5/LxncIMsfAEpHnhKaQ4evxTBSUlEpZ2rknL2rjUdiVvPSNsKhKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+tjctFtODAPpu8fwOFTKLTAdBT/wOhOnS29UylBwXw=;
 b=Lh6BPZdnCQPi6OoewpRB1u6Zj8fW9QWSdzD6q4cK5hgNnpH2RLc9efY6CvE+YAkB4xsAuKz0fzdSQfoA5CQyNUstzT9jo7aIttD+X+d0DO7R+qZXVm+3+9v2NGV1ZDACLokxhJlM931PeFJ3RrpKyES/PPjpcHU7x5v/dp248YHoeU/xjf/IvQEgYQwhNnxI1qgSuy8+wtWqzGoGZ8BNGfx2vomDlP2x03NKzd9EZtaaERdXHfbe4HGlqOBTaiaiLbHW5fw+ptI3EhPH569i+naWCE6M4OV+KYZImWGvnWTkNdfv+NQTt41k2esYMr1edCkJkfbSJgRw31hA15eMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+tjctFtODAPpu8fwOFTKLTAdBT/wOhOnS29UylBwXw=;
 b=OY8xfMHlTMuuVBQM1ssqHHHiFc4tK0X6hYcY+IbGrYN7uDdfux2Y1LE+L7S0+Mf5Rkz+xvaopyDgXWp20zHdUoshcu2vtdJJzF25xIvma5Vf3mIrr9+z2XyuSTIwIW1QyMDQp/QFeWAfujaGBSPqfRGbEHbNBHezMORrPupKopnHkavbQ3+ZHqgrsDzkpyTDDwFqWgg9Z20wGDHFRns2LD4pTC84rVM6HuYUnjh1VMxPz9gtdrssNBQqBJ9waHw//PxtFadzxu8EZ5D9Ed3inTCT4viynyf1JijHOfB+gm7ierHOch6/cJt7Os5Ol0BPNS6oHXDp5LTKTYRWsfVB+g==
Received: from SN4PR0501CA0116.namprd05.prod.outlook.com
 (2603:10b6:803:42::33) by CO1PR08MB7224.namprd08.prod.outlook.com
 (2603:10b6:303:fb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 05:00:00 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::59) by SN4PR0501CA0116.outlook.office365.com
 (2603:10b6:803:42::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.12 via Frontend
 Transport; Wed, 16 Oct 2024 05:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:59:59 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:59:58 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:59:58 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH v2 2/4] cxl: Add default timeout for bg mailbox commands
Thread-Topic: [RFC PATCH v2 2/4] cxl: Add default timeout for bg mailbox
 commands
Thread-Index: AQHbH4g/djwl0+QCQUi1njK/EXQOVA==
Date: Wed, 16 Oct 2024 04:59:58 +0000
Message-ID: <913b851a25344bb1832ddc902eb0aa5f@micron.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CO1PR08MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 071b215e-6a71-4cbc-4b89-08dced9f634b
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?Xr9mEYqeaNeQNKwUfy/CLj7HYd9bwEG6ioiKGHMnHRmMpUXtQFgLDHKZl0?=
 =?iso-8859-1?Q?FgzUTMIMWBgHobUU1U8NOe18tG+PgP5oiyHPikMO/Yy5eRlr8E/BjBSYI4?=
 =?iso-8859-1?Q?UBmrwVKjSixF2lfwhULOFgYtg3ZChRNMfOiofeGipmd/hfxxl7ZxzHAYD4?=
 =?iso-8859-1?Q?FnrHXlGERVTlGtHvzPg2UDePz9LYkrpFTfsctDjcCpgiOnVQ57li7HvoF+?=
 =?iso-8859-1?Q?OkEudX19I3GQrorXSeIkYjaKk/jCsM9bXZqSZEyNpMHv7IOmmDgZaeOisV?=
 =?iso-8859-1?Q?Yr17IDRinyanrV5R100pY4dtwKyT44oruwW0QCcTEC8hVy1AvW6etYfUdP?=
 =?iso-8859-1?Q?dAHtAfHPuBBYeDBQY5QNQu08w84t+gOkWAGl3OOO2fk66kplBM/RfJZBhg?=
 =?iso-8859-1?Q?E7u7r3XWDivwdYyNDF65afVahdQ7ooOEG+7TXeydrucyChAeOplc6rsZmW?=
 =?iso-8859-1?Q?HQ4RhSGX1JhVv55xfcK31s4gGt5oE0NuUGAYDdUdCkIQeWTsu3zbcNHgsg?=
 =?iso-8859-1?Q?A4PMKKUibcwV+rF9Hpx4p+oXe1IwJk+jSmoZQ4opXZ3SKc/zxgmMffRcl7?=
 =?iso-8859-1?Q?B7Bhq63iWS2GXdZ8gTrPNXVMztQ2+a6lu/W+ie9WMnJ9cFQ3fj2le56FNo?=
 =?iso-8859-1?Q?iman2mKVDXtNZo579u0lcF1bM7iF1DgDEjB4olwiDNywxbFaahBqku9oPn?=
 =?iso-8859-1?Q?rYswsUSABDawID3lemvXjlDXf0Bqhm2zAEFvxXnkb4dws5DyORiAYk5Tiy?=
 =?iso-8859-1?Q?aYcAJKmK6XbLfuIhxfFnFycLqM6VR3Szdh/FISspcu3Gpp6q4X1JForYog?=
 =?iso-8859-1?Q?+6fJ/+vlKHN2CUqNL9tp7jLjAmb0blJsYM1ZYQ0N0OCPeW/Yn4iW68QxX5?=
 =?iso-8859-1?Q?clGmQ/NwOP6kGeCoAkM11YvtBiyCeG/6lONH0UYduEW8lEvkQgK+3nnh+5?=
 =?iso-8859-1?Q?hSxVcjLbgl1ZKMXTEneg80gtZ5Seyo57WYxiH+604AcZil4AmcMvN8TxkK?=
 =?iso-8859-1?Q?lEQ75gHvjJ/tM7xBZxY6r8eKIhuNeOpAB4mO+Rgtv2FHXv6dp8EvEiWbBw?=
 =?iso-8859-1?Q?3mXy78jG7ijhy05wJhE+C54twrLxN7QmdAgY93XVPlMlInqbgEiAM+EaWK?=
 =?iso-8859-1?Q?yCw3FoVopJ/GkveLhqBBTG4XSbwC2W/ZFzY0VMWLsAWp4bpHswHYZvoi0g?=
 =?iso-8859-1?Q?aG6LTJyYA3s3v7r2tksynTWJjpUVJSkZe+bblxSAOky0arVFYP56diOMWz?=
 =?iso-8859-1?Q?8nll4nlU26XOASwCoS44qsCpwvpwKWJazp8dylUhMm4y4tfByOHr7wuO3g?=
 =?iso-8859-1?Q?vT743Panvnj+eW3QQB3rNamzKZACOU8zKSoWEs8WDuymgjCVMyXquIRfXa?=
 =?iso-8859-1?Q?VBlZXE0yEDyocCLiUk2JAh8BGwj34TozGJzHEyz6jxrb+OIRqmirb3/XF6?=
 =?iso-8859-1?Q?Zd02oHMNlXTqjbe8?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:59:59.9979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 071b215e-6a71-4cbc-4b89-08dced9f634b
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR08MB7224

Allows 5s wait when no timeout parameter is explicitly mentioned.

It is useful for mailbox commands to be executed in background
when initiated from userspace.

Link:
https://lore.kernel.org/linux-mm/20240215123410.00003b8c@Huawei.com/T/

Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
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
