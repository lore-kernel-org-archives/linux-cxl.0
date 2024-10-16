Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16FF21E3BF
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053128; cv=fail; b=XWdCuW7t1Cqndp2PlCdWlTNQFm0f7VKYSKvfjQ/OxVWOqz53PJJxfSzYTQJljvBHz7fghlLQd7oWUYqIbMGkE1VbFA+w6CZq7OmmA/sKWjk3MyMkVkci/v2aRftFPgM2GQoorLIqHR0BNs62/0GbqcTMaP5ka0UB4wXXoZkRwxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053128; c=relaxed/simple;
	bh=OQUhpoOaLj7HnYDiwjVeaDeiX6rAqex/xaJvRtcp/WM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lgui8pCAJqpHySENDZt8u2CQDlJ0wb8kthDfcFEEvJ8MDbGwtG8BsEXUAKBEgmCWDWfZphuCMH3bzThrTh1r1XloA8YYOYBnMKkdWOnKxhxMb49bfc6NfBR5EXMBKDNfQagWkfTsv+Bg31EI8gZ4YiWb37REBtNybZc+gjFMKbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=ogoOA59i; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="ogoOA59i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjylMRL+EnpvfuZs6lxlPtyZpu2mm/m9S1MEuFCx/PhCSI6fQ53osAvfOB+04lyDTykDHjOfVP/KxDOFzSssnQeZSl6GwcmHOiZcf8SRfOD90eeW2MDcumrIlZO89f0kBIo0rnkwYmSpMQXtFxgW60JB2UI0qiOdNsX5jflvcJzjO5Bl0Nvo1Bilf/kqPDQg95zhoxld9IxeeMwkNzDVzUJstWnqITwm3xPkttqixutOFfHdCRG57fzUTJDYgQy6jRJ+zzc3soUIBejDr0O1h9mP+ith9P8UOz7ldwJip8UfQQ0g1UM8BfI78HfBlzwvSakx+ooRPmlatF8xCi4kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTWJR+n6EqfdLSx3ZcIbttaHeB+3utQINwBGrO1urbI=;
 b=f8TiMlcUHh5BYW/E8ku/j0A2DH7htb+isqe8+qVdJACNycoa/P9j79hZ2Uo6MkclrjuGe/AQbK/Ii3lQB58q3qvSFDW4Pyf9ykGBv9f4BMqxTP2lnqXxrM2ex+WTK7tsO7mEBQhU4tmXv91GYWF1fGsI9caQqAj2GO/J2eg14XyHzKu9Zw1CfiHIUMbEE57mRqNbhxvNOL52qiRk9C3xUDT2f4ryPhlGvgI0DQV8ethD+jnozwu11nGlY6xWddbbmUTHdo0zimMrNhhWgXOS7Tud0e7MScJRb4alE2TJNkv5p5PpZwnVjsblz7c9ox1Y8dT0ZkE3sjde+aAdlx+GEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTWJR+n6EqfdLSx3ZcIbttaHeB+3utQINwBGrO1urbI=;
 b=ogoOA59it7c3ptybODcaALbEl2pBeiMVTWILvu+qTguryH+DIDD8o0wg61VB+EnsbiIZrRzvRaRT3SUlDAzbabBPj0AVmYt03qgTVEbM2IfMY1XWNdTvqcvKHgj8JWR00btdXxs6OwaxrDRjYI+ZiLkHB/3J5/KrkrkMWOFGQQNfj9CaWoOnfH8H/6g5wYr/idmrE/C8TAuz4744UeEOOigleNcZpWOAvglFeoZVgy+mjzBCOQQ9LAK7tJAs2pMhP4LgZ+wPSJCbR+DEFPAxcqtxPa/Gj/U1Ysrhd2ewjx1O93pMKNYbmZOJjxqgmmV+viiQZ+4dwBaG6l6Kt7k0eA==
Received: from CH2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:610:60::13)
 by BLAPR08MB6897.namprd08.prod.outlook.com (2603:10b6:208:324::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.29; Wed, 16 Oct
 2024 04:32:00 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::dc) by CH2PR14CA0003.outlook.office365.com
 (2603:10b6:610:60::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 04:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:32:00 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:31:58 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:31:58 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH 1/4] cxl: Enable mailbox ops with background only if
 request abort operation is supported.
Thread-Topic: [RFC PATCH 1/4] cxl: Enable mailbox ops with background only if
 request abort operation is supported.
Thread-Index: AQHbH0T824gEFEU6X0GTKKw+laHw0rKIxoqM
Date: Wed, 16 Oct 2024 04:31:58 +0000
Message-ID: <435ccacccb02483682117bf200e75874@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>,<20241015205633.127333-2-ravis.opensrc@micron.com>
In-Reply-To: <20241015205633.127333-2-ravis.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|BLAPR08MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4668e0-14f9-4166-a17c-08dced9b7a2b
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?pcZQIRAYZLAmY9SgNlk3uhQM/ezrwvA23Hv0wOFnRgWsGh7m4+KGdtHOBO?=
 =?iso-8859-1?Q?GMmzMqHKUSqd7xotJNxV2VJ3ycrpqHqkvjD66KNQ8a+ASES9ce0bIF2hws?=
 =?iso-8859-1?Q?+wbScLDzUpTkFjm6Ua7mClA/7f/Lf0oMOaXRmS4f8jswEYueCauaW8X1nk?=
 =?iso-8859-1?Q?oCL4iiGrUVcpCzNNUEn85ZSHz/GOJqPeI8mEWDiqu9zkFbG6TRWQfO8aQa?=
 =?iso-8859-1?Q?+jdaCyCB27XjOPQrNQTACt1iXkn4KWUjH/q8lNgFzGNKPZzcvxQeA3WMp1?=
 =?iso-8859-1?Q?XyHsXjQ5B67AqGLfSzb49PiHOv1JYA0dH1AZPFxyHB06FLkcrqWuwTyL6z?=
 =?iso-8859-1?Q?lyOezBTSRkkbte4UMeXgnh8mrdFOXzrJKpTvlKiDDDBX3jmyxvPFCl+Cay?=
 =?iso-8859-1?Q?UIzX4lkIaA5y5qrpxLew1F8tAiGikOrEZmUrrQDoeQwf7yXPOtS8Jc2Ytx?=
 =?iso-8859-1?Q?9EM1nhMMhREYi1nFMU+rF0aWvl4hSDV9VWZcLp2XReXZWSGonR3FOE7PEV?=
 =?iso-8859-1?Q?KZ3aIQm9uDLuUvk1aD1j2934tJrYdhF+RY3zWylpME3xjgRHDNDhrrdAS1?=
 =?iso-8859-1?Q?U4UH2xr2iEX7z6N+PZZ28h6Gm2tGJuP3B0mrYK+kiCiPjbO/MOz874lzZZ?=
 =?iso-8859-1?Q?YODRIxYiHuBaIR/RpPmj5atrYRDtX/Lfd1XnV3r3A8PRXT1dGINV+/nXPF?=
 =?iso-8859-1?Q?d/SKY1Sg+YRlgu5pxIza1bToEkg43lOJ/Qpt4AAhobayoeA5Y1yaWtHT0k?=
 =?iso-8859-1?Q?MRIldOPVF56NrBKBvh0BRBeWGHk4BH6avPFYWgmq53cyhfHWuXvhQ/tCSE?=
 =?iso-8859-1?Q?PU7UfDAooQ1LcycVnzkhcx5mfc7xAcTsH0jZC2GVCsvqXyqXEF6LS4Woho?=
 =?iso-8859-1?Q?eTurEwNgsBzv04hWxh59BHaTY5bd/mYBOhjUocSd96pc9+YxMN9wfYq2im?=
 =?iso-8859-1?Q?Rnl49ZHx59x2YySmI44DFnFRLC9ZVD8hd9HWGV2JOJbSaZiX9N4GoOZl4s?=
 =?iso-8859-1?Q?zEVh7U+5EGYiQ2nVJWxQ+lNchzHM1XQBkn4hJGNNZe8MNvJ5MJwgg2yGpR?=
 =?iso-8859-1?Q?8QcZXXJN1VZWW46QA6mnraREY51rIoA2nSKiViqDoRAA0VEF7P53y0ySkK?=
 =?iso-8859-1?Q?URbQqHdvp8ZYiWSA9XPtsJurIC41n+OmWEkrj+ozIdwEfs0eAhACYRfpIk?=
 =?iso-8859-1?Q?LYI8ysIpvBfPolNKAvctSHa5XWIL4/FLg0bLo6oIM/BFe7+iOPEZZ8+/Hl?=
 =?iso-8859-1?Q?O75iYBzJ4E+a1wEQ2aII0SNrB1oni6UbXx4YF9VFVz4456RiMHZJA+HeSl?=
 =?iso-8859-1?Q?cww4fBsZrNluHovuaDfSa6qMexBVwA+tpHQNglb/acFmFl2ZexAWMb7O+K?=
 =?iso-8859-1?Q?OwX6p3sZlx+7nWs4/CJDLiTJNO8D0LOV/Q08WiiCIaVc5WSiMQAKU34rE0?=
 =?iso-8859-1?Q?Mmh2WePRZFKQcIFO?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:32:00.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4668e0-14f9-4166-a17c-08dced9b7a2b
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR08MB6897

Enabling mailbox commands only if background operation and
request abort cancellation are both supported.

This check is to allow user space commands to initiate
background commands responsibly while complying with any
default background timeout implemented in kernel.

Link:
https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.=
intel.com.notmuch/

Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
---
=A0drivers/cxl/core/mbox.c | 12 ++++++++++--
=A0drivers/cxl/cxlmem.h=A0=A0=A0 | 16 ++++++++++++++++
=A02 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5175138c4fb7..8c0144913b9e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -733,12 +733,20 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds=
, size_t size, u8 *cel)
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < cel_entries; i++) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u16 opcode =3D le16_to_cpu=
(cel_entry[i].opcode);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u16 effect =3D le16_to_cpu(cel_=
entry[i].effect);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct cxl_mem_command *cm=
d =3D cxl_mem_find_command(opcode);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int enabled =3D 0;
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cmd) {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit=
(cmd->info.id, mds->enabled_cmds);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled=
++;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Fo=
r background operation commands, enable only if
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Re=
quest abort background operation is supported.
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!(e=
ffect & CXL_CEL_FLAG_BACKGROUND_OPERATION) ||
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (effect & CXL_CEL_FLAG_REQ_ABORT_BACKGROUND_SUPPORTED)) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 set_bit(cmd->info.id, mds->enabled_cmds);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 enabled++;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cxl_is_poison_command(=
opcode)) {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..d8c0894797ac 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -579,6 +579,22 @@ struct cxl_cel_entry {
=A0=A0=A0=A0=A0=A0=A0=A0 __le16 effect;
=A0} __packed;
=A0
+/*
+ * CEL Entry Effects
+ * CXL rev 3.1 Section 8.2.9.5.2.1; Table 8-75
+ */
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_AFTER_RESET BIT(0)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_IMMEDIATE BIT(1)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_DATA_CHANGE_IMMEDIATE BIT(2)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_POLICY_CHANGE_IMMEDIATE BIT(3)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_LOG_CHANGE_IMMEDIATE BIT(4)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_SECURITY_CHANGE BIT(5)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_BACKGROUND_OPERATION BIT(6)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_SECONDARY_MAILBOX_SUPPORTED BIT(=
7)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_REQ_ABORT_BACKGROUND_SUPPORTED B=
IT(8)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_AFTER_CONV_RESET BIT(=
10)
+#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_AFTER_CXL_RESET BIT(1=
1)
+
=A0struct cxl_mbox_get_log {
=A0=A0=A0=A0=A0=A0=A0=A0 uuid_t uuid;
=A0=A0=A0=A0=A0=A0=A0=A0 __le32 offset;
--=20
2.43.0

    =
