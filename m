Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F44A02
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053165; cv=fail; b=K/fJsAKE50BGRZFlgUQJMqfqriWGOz853yiVdp5uo9ZO1A6aI7B8CnaMqf2OeiieNimMpcQShFEAg2yVTJNy+yxpvo3/sNyxLbKhPCNllcakqZC91vTyoEqKKBrFb8qer8t2HqAprTtWGCOlOVXHPF+0pUbLkSLIxOSf9XbKq+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053165; c=relaxed/simple;
	bh=aTapZ0bRIkmUqTlpaeggEBgwZ3N26DNW4RRel0cOMIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TyG5oFhPOHv4xZHbwLSgQ/8U0W2zf309yIoBUX9j5aQb7zv+L3lmB//NKBhtWDWjlNvLRS6EnbUBgjoJ+ZkS7IZF4Hmc6opL7nNl681IUMkSDLaxBuEEz9wTxywdyCycC4UvFsnRy/va1QkLC6+RfeAwyXmaB84aASRszqyet2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=S5ASmP5K; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="S5ASmP5K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5T3iDnK3EQYje5dv3n7rcQvkb1bjlQkQ+2Tg2Q44aqwW0K4So8A9mbICNqg3XPCLcNtpUVADjVw6rlUqFbr5ZivwoOPtyhITT3SnKesMsNgFh04ZoqYY8X5l93IZK7lRLrYCXxFIMCY+mm4vICQIiwO952qxG+oqsM9bQ4HET8vZpUf+rWFuo8bc59wWP4pXjo13jVDQbV4GKQIOHCL8FKZK0sayQFi+VeNfjl0tBMLrGhub5n9jf4Gl+piJotrWiYFV8eY651wxeqoT6xUEG9SuqyWkJYkafqV81h75+vO2cqDEJvCTzhjs23M9djDZhnhyaLmFpDV7k+8T3+1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMsDbssQmxjL3ysdhAjD2prcKLMvVkp3Zn6eEqvnT7o=;
 b=tPVxbJkc4K1vrP2hxt3XQCnTwyBAJXzsO93LSy7iEIYUCv7OB26CI8vH8nI3J+a4+qnM63MgtA2NDgytlqFg8x5nvEvNcVt60gZjxiWDGVE/kY8052clpRLDy2epOU/1a8svFyAKRFUjvnTaCec6/ryzjZg7ZzGEMsDOhWJctLfQSPnJ04y9jSuauCnzkPNHCGq43GnoVeokj8sGXBVHAQQ0OlCvDAPzjtk/TSvOL9cZ5f6MlJDEL4cz2l53rm3Io3OkVLN2i7McDDnnUQNcn07LPQHVgDDRXk7EZSUCNYx3smlejwhXmLVjUjjnwhT/N96GAdUG++1MmeAh4BOABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMsDbssQmxjL3ysdhAjD2prcKLMvVkp3Zn6eEqvnT7o=;
 b=S5ASmP5KUicJ4CXMkKRYnFQlg6C9ydwoSEBEs08KQNGs7qh8zy/QLIofe/X9g0OwHGP4XXN3BmoCATofWLGw6hxyjl4pPz9LmJZt/EqrJFBaZy9YO6bUXp65rtu7PYQqBOoF9cVxixiJQUJL4cZAuaTUfV0V/ApBiPiGrk2b71pPF348+UzKeInw4vIiPCDSMGr5pDFSKvFVF3Ccq8tdZ6qZ9aZc/lHPgcQLsBMyNEUchjcI2P80PC6RwGEYgoPGn6arCgDpyvU251nwfPEaDt0EgTzL8nLiS5fpfqBdTU5eM1A9i1NNge6FarHEJbansOKVXuG5QtlXG5EDesQ9sA==
Received: from BN9PR03CA0640.namprd03.prod.outlook.com (2603:10b6:408:13b::15)
 by CYXPR08MB8937.namprd08.prod.outlook.com (2603:10b6:930:e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 04:32:36 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::6c) by BN9PR03CA0640.outlook.office365.com
 (2603:10b6:408:13b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Wed, 16 Oct 2024 04:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:32:36 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:32:34 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:32:34 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH 4/4] cxl/mbox: Add Populate Log support
Thread-Topic: [RFC PATCH 4/4] cxl/mbox: Add Populate Log support
Thread-Index: AQHbH0T8IOYHNAqJ+EGmcawYiH9jE7KIyOyR
Date: Wed, 16 Oct 2024 04:32:34 +0000
Message-ID: <a67bf703fe3f4e9c8d1d8588d734d2b0@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>,<20241015205633.127333-5-ravis.opensrc@micron.com>
In-Reply-To: <20241015205633.127333-5-ravis.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CYXPR08MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcd3ebe-6b64-4d69-ef9c-08dced9b8f7a
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?JlJ/G8ClHGgfzQrxLdI8DHb3RCyZEolGidBWwzhtRvQGTMqp6ehDIG+It1?=
 =?iso-8859-1?Q?Jal1ut1bISNToasl2BGEMrgmhJ+cpIWDik/zHqGrnb2hp3Y+XWcF6qOK+N?=
 =?iso-8859-1?Q?BZnKjiS3blPlvd46RUoTz9SgBx6LD5uVpIJbx/vGALwhBe96LbnGD+3QIL?=
 =?iso-8859-1?Q?H7G5V+vjHMHUHp+0BKIH+nKaryx2UTTAz7iQTrPTS6MpuYJAk8NXlMPONX?=
 =?iso-8859-1?Q?aMZQQKg3KgufnNsuQF07USjL0XV2MaQa/jyhWCexK8li0yafTBCdE+RMlr?=
 =?iso-8859-1?Q?Y4yhIGguI87akFBo8MU9Wb9QmIDMz4CrzLPm2oe+o/LiWzV3+f/rhjXHfx?=
 =?iso-8859-1?Q?wHvg9UEnjzpqTlxs9M8INz68H6GzJCy5AZIW8VBHMO3VZkni+gwg+oCf1u?=
 =?iso-8859-1?Q?OxhO2QsLj6oci6qINw2wYxrLG1hNPxzToB6itC77RSWFa1Y+24Gj74+/S/?=
 =?iso-8859-1?Q?jfj/AI0Lw9PqGPknDeyF+OdU8ZMnhqcE/J8NUrg19ujUceQqzC3eHnWKc0?=
 =?iso-8859-1?Q?WmQy9LYjplyG1mTFO/8aH0OMQULGqcrojp2TD8Xxoc1G1H57uvUCmc7SLe?=
 =?iso-8859-1?Q?iaHTo7/Md0GlOTu71zTR0rk9PXAZBL0IW05DGxVAri87cD6S9JU1MW/wSS?=
 =?iso-8859-1?Q?1fEbTEd5BdkOwiN6r7m8YQ7fOJA5CGnvsXuUC+uciV/TIpvvtSNn4EY/Xp?=
 =?iso-8859-1?Q?ruE9+Kvf05dCt/EDHuZcQy38DK5X2HQJdO3cWsGKXWdk3LyS2Js8KFSLst?=
 =?iso-8859-1?Q?n2HDg1IXBU0vOvnuC7+99pNMfuOaI17Ld42RnGG8G4dEcmLpnODqpM8otM?=
 =?iso-8859-1?Q?5Xt/0g5eGcBeTUqetYVAuKbKo/JoXQLpi7aPUhWwU7pJGYosFlHf4aHW7z?=
 =?iso-8859-1?Q?COb3ljPC3pxgvniaRhGwZZNvrMmXI5QrS4tOL8XisMvXg0RoMCsgjjZXHI?=
 =?iso-8859-1?Q?ht/dZEHCjoVRf2zTfuoq9QuZGnytYe2xqzcKyfA5Fcmfyng7lMsJwIZ/93?=
 =?iso-8859-1?Q?Vcb82ZJdm5MbHSIrvfaGwPT2g4Q0xrRFnEBGlKAcA4L0BKYNCff7FkA6ku?=
 =?iso-8859-1?Q?crgfNjR+eQL7+P/Kw2u32gEr4EHiYzrzgUFRMS2n0xdONx8BmjSpyh8rTJ?=
 =?iso-8859-1?Q?NWJfx2ciYZfWLNTyaULa15GRfQVRISXOFtFQJSvfvUQvYQC4btvIYBortb?=
 =?iso-8859-1?Q?bgvEo+3y0TDWWBBVbhnsglQhVfjzh5jrkAsN86m/UAfYsAWJI4Et++QyUU?=
 =?iso-8859-1?Q?w0P3ut8Reo+RxAXtsFTivm54g+1Rij2gJW8tgBrr0h4e90bTyqDesbKbXp?=
 =?iso-8859-1?Q?CTwwIyiz8D8mCNz6LVnYriF8iCXEv0WyJZ+iW6MviIsPLHWAS/S605l+hz?=
 =?iso-8859-1?Q?SRW8J8MMcPAfQUkl5MGdxZYtz4Zv3KLlIU8Rla+uvP2NZsGQqTHICabi3I?=
 =?iso-8859-1?Q?elYTQxxaljEyvGbq?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:32:36.1273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcd3ebe-6b64-4d69-ef9c-08dced9b8f7a
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB8937

Adding UAPI support for
=A0CXL r3.1 8.2.9.5.5 Populate Log.

Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
---
=A0drivers/cxl/core/mbox.c=A0=A0=A0=A0=A0 | 1 +
=A0drivers/cxl/cxlmem.h=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
=A0include/uapi/linux/cxl_mem.h | 1 +
=A03 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8c0144913b9e..48c2fc8b4bcd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -59,6 +59,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_CO=
MMAND_ID_MAX] =3D {
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_SUP_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAY=
LOAD, 0),
+=A0=A0=A0=A0=A0=A0 CXL_CMD(POPULATE_LOG, 0x10, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 808fb8712145..6320d8cd3ca3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -530,6 +530,7 @@ enum cxl_opcode {
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_LOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 0x0401,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_LOG_CAPS=A0=A0=A0=A0=A0=A0=A0 =3D =
0x0402,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_CLEAR_LOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D 0x0403,
+=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_POPULATE_LOG=A0=A0=A0=A0=A0=A0=A0 =3D 0x040=
4,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_IDENTIFY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D 0x4000,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_PARTITION_INFO=A0 =3D 0x4100,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c6c0fe27495d..040ca37046ed 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,6 +50,7 @@
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(GET_LOG_CAPS, "Get Log Capabilities"),=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(CLEAR_LOG, "Clear Log"),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-=
List"),=A0=A0=A0=A0=A0=A0=A0=A0 \
+=A0=A0=A0=A0=A0=A0 ___C(POPULATE_LOG, "Populate Log"),=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")
=A0
=A0#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
--=20
2.43.0

    =
