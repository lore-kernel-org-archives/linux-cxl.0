Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EC18A95E
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054806; cv=fail; b=K66MK56VtI68ZEhl6ikOrmmjkkaKYV9jfUw2uJOT14YFexLGHcbtZi583GuWBkztOfgrw0wmSTFYZGIbvQ1hRqmSoXX3wvngg+PxqLUK6vsD81HnZY5GcPRKio66FcjJwqg3T+OkFB3+p2BAHL4dNExRRtq6tM5JJgBSAM7q7bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054806; c=relaxed/simple;
	bh=YWZaz8HUJ7zNFnEPrOgcbdWU2SjlwKpb4inu5VyeJNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gl9tHk9DbvaZAlZ3enOanXYzjE4CI/y810bZKALHNzVFsogTMC2wxVAxRsXP2Wv7rguJ44UCxCB31x6h66xVJdi/cT4GzLoQwnQxMu99AplzXpzZ52kKgjSuokb3haBV4tCE6+HmyJV0BPLscWvwN6yYRJSYb9CcacWGWEiH5iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=MhL1pxcH; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="MhL1pxcH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2BNLy3Tys/WnV6hGSWHzcQsUqT4RsakSdiY/xqljWp1vmOIE/O5j57V6cQ+nlVaw98vP8ZyiBI2ULa5WvoEJRrzWFQpqFgMd3zxvXb62K6cCbbekFJZ+QbZ+jqH4Mq9DphGt9ruEMyAtWI9hu34ggMZkm3fWBSkCzehIuLsgHPRTp+UsiUVAirH3gy1Ss/3dBWrMla+HpJEMPLKftAzK+SIwU3unTffNpdAZ4cOCq9aJMiEs2PZHZoQO43bwXo8VqsDQZkFPaGgYAepddqb4fG0aUow9aexhY3Ii81dUVk8izBToqV8C3ZVzc7FWmM4T/zCAJppqKnczaHLAvXmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnqzN35w1JAXkYGkRioMhmLqElHTtYzdKgcq/Yeosbc=;
 b=rWnVCp1jBKtTWG84LtfiIPArWjNzt7bZVJlyvTUgEjBdnzQb+YjuSULfZA1RjsoQApU1k/8QVqZoBEzl51hQ202E1wshXpIYdzuiCmZm+UdKhogsDmflWo97J2E5+6PtkbYGvK0dJQlPCrZ7ACVMfHMGXUML0Nmu4g4EHQjEbfwnO9nhovFm+D3K4P6CRzSsIvAdVtFhnL4+C75Wl0b108QAgBwARZnN61S1ORiOIwFjQBHSpvtwFSocuADZkxgyLHXjG74Hnuncr1PfHSWdI6SFWZO55zJUBBSQDMPYNf4lYDHVQzN4P5M+Pma+J4UuAK6xNeevto+rFpOMFalsdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnqzN35w1JAXkYGkRioMhmLqElHTtYzdKgcq/Yeosbc=;
 b=MhL1pxcH6MMG0cQlGWR7rJJPJazvtzTNo8msmgN/Cgkj0CiIlnBmavLeinBAprzb15BUveExzHc4pGm/Pzyk4PHEMXVsuzCFtc98Ubz+CidF6HxghQImYZoyym7QZ4kl3pQ6FERVXn3nQKSftQZSj6Tqzp0pgXd70FOdBvy/VGQUMS810dy5g2adlt6ZONcZ46ntJ2A+Dk+utb0rajJF7UV/iMHeIf8+zsCa6bwG/0TmWBJvwbMWcErXhFWelqmzLrtDrrDgNvpocrfZP27iyjsb654C782A90UU1+llxr4ovQ8+2Fxff7DAawjdPLYEY+5nBHJDVXrQaxujgY9W1A==
Received: from CH0P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::29)
 by SN4PR0801MB7725.namprd08.prod.outlook.com (2603:10b6:806:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 04:59:58 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::10) by CH0P223CA0012.outlook.office365.com
 (2603:10b6:610:116::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Wed, 16 Oct 2024 04:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:59:58 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:59:56 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:59:56 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH v2 1/4] cxl: Enable mailbox ops with background only if
 request abort operation is supported.
Thread-Topic: [RFC PATCH v2 1/4] cxl: Enable mailbox ops with background only
 if request abort operation is supported.
Thread-Index: AQHbH4g+o4Yi/F6bYEWlyf9LmgVvoA==
Date: Wed, 16 Oct 2024 04:59:56 +0000
Message-ID: <6e6cc093f70442e792c05e779393442a@micron.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SN4PR0801MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a8f530-4ed0-49c8-61fe-08dced9f624b
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?/r5bfZDXcwLVwpeBCh8vjiyJbGCsY6YeMwa2SR1SMvqQFG2OGcF16W9eJ+?=
 =?iso-8859-1?Q?AMipXNwtKf7j3QBQYlJmd384Kgfh76slHlUCndXx963yJSsxnuSXviocM+?=
 =?iso-8859-1?Q?V7bQYLElhGcosS93OLyx7tF8KUcZ6MCjck/8jpF4/ZjnhVJ4mNNJ2nM9jB?=
 =?iso-8859-1?Q?DgO3KoAxfHjLdmq5Wycntz00M93FIo5spoJSZYn1G/MWRUyzUf2dN+PoxQ?=
 =?iso-8859-1?Q?Cu4l9FKWjCZuH0EIpXXBQrwc3FGZloJAWpOl8ZqnCOv9RlhYiFez3YmUHe?=
 =?iso-8859-1?Q?JJ5ifd1cvK+iZmCHgvGUIfdlmH5grK7JSNnZ4mRBp/hp6/RNL+OUZWPNyK?=
 =?iso-8859-1?Q?nPGayiLxZZR/s3QSQl9IIWPu8DI/CukghOJW/+QyYboWX0s8TeJbAd6iec?=
 =?iso-8859-1?Q?kosTH1XB9ioVUlX5gdcIow1cwfsuI9e1vGY8uT5r4ARcFyfyq5pHlqK+6U?=
 =?iso-8859-1?Q?YVnOTxsrgTF3hNBweHY5QXC+p+c7kC40hJnx51zTGRs+D7bgXhkoZDLdDk?=
 =?iso-8859-1?Q?P87PXThQgrJPqBx9FaXRtALeUOP00RjUeet3zztymp/z06jpwixiFh2od4?=
 =?iso-8859-1?Q?34EvQrxFAS/mdQWfPjAfAB7eI+lpbJ+6yacGKmkWmOeaE4Y7upbJycruR/?=
 =?iso-8859-1?Q?TjZIIMvooWHRnGsu/Q5WAjQ+PjwPIHLGx0pWgIKE92aHmQEaw6/DzUUCEe?=
 =?iso-8859-1?Q?ikbFGhl26em4nOJTCT0lWNKXRdHSQSkff7GpsknOxK5Epp7o9iMdB5VMw2?=
 =?iso-8859-1?Q?wUC+nds/RjeOq5Dq1mZpykrEWzcCOgk44jK8U5ccrWghUEibp/1Tuqa+m8?=
 =?iso-8859-1?Q?TCRS5LSwafKUjXObj0dMxu9IJz8ale2bhnmMzaJmleIOBw/a345b5/So88?=
 =?iso-8859-1?Q?yRcki/LsRnz1KBDoJsCUYEFHkLJmOVkAWWS8IpVjkYynEoKt4hkuv6bpi1?=
 =?iso-8859-1?Q?WUzGonHOJeAlPqj739u8YRs9si0a0CF1u4Sg/Mdyuc77RxcZM0njl6mUAv?=
 =?iso-8859-1?Q?UBxmiVz3e4MCCgifh0fnToXA0qDlwBQTOTyOSZpKmddUJWMjqsipxia9u3?=
 =?iso-8859-1?Q?PBwccoPSMArnaXqJ3+aa0F8IkYHlFS9YKFZtGdCgEaemvpnMk967IsZyYi?=
 =?iso-8859-1?Q?eZXwF6ixXJLMWjVtMVISPOpIw5yGHH+cnD7exLOJ286uu6TkD392fBVZ22?=
 =?iso-8859-1?Q?gHAwOIxG/SweciJKqiayACocHsJfgDzYnvp9nYhKkI0L0e72ZhEsYo1xNJ?=
 =?iso-8859-1?Q?iglxGuw0JKFuH3XKK1FIS3KdESmGsxW3Cwwll6HXwasiJVn5Y8e/I7FybN?=
 =?iso-8859-1?Q?agRN6oXGPrCm8DHtvG8IdFysDZ0of9hizyq1WAEUu99GxhRJaBLWpsBtgz?=
 =?iso-8859-1?Q?wVgR/iCK69oRQuy1iPrKy8KIhzppvjJcZ++IJXxTS/UGOssILJtgSTbJqv?=
 =?iso-8859-1?Q?gRd9ibF3qd76XjIW?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:59:58.3051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a8f530-4ed0-49c8-61fe-08dced9f624b
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB7725

Enabling mailbox commands only if background operation and
request abort cancellation are both supported.

This check is to allow user space commands to initiate
background commands responsibly while complying with any
default background timeout implemented in kernel.

Link:
https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.=
intel.com.notmuch/

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
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
