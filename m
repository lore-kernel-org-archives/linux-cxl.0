Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AAF4A02
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729053153; cv=fail; b=n9EgK/tMaynpvyzMWh71pjAl5zggECk50ktc3WNh49nvByt+SQ2mMFrKu+qFolPY0ew6R0R1Yvc7Gf45j8TsHXwdZfvStpfbDhtpxIFLPF8cXP/HfMiOJhWH7Tas3OcadIOo1s4YswYXARwLEEeDgQcOKwrVW+6dclt9tRnXfeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729053153; c=relaxed/simple;
	bh=FkA8Sv45BcZ4/5KrragA43CSj30yKeSewAzppnfrPik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M2EFC6AYIEp3AElmYmARCR+uEVEeNUxvO4Gg2KSRZiOEBZcAeJxw2uhYJg5XUVaRWGodAVBp4arxJ0jNYwioHyZ5aMEsGIcC08zy+vmHSI6oaIe9prig/nJ6NEqio7Ka0mEoCllDvzOFzAUw4LMLbY8frEWB3kzen1MkOp7wu74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=UXo5mwgz; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="UXo5mwgz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf9UDJh5Yn86/yCJJ9iQ34AGMjhsuj+D9s0RHIXz6Z/nb9x902McUgo73vCQfzMecBFqp3Ue15YPOsmOsRaqBFNZv5YD0kUJ3f5LyfVm/RtcJToYFCJ3DKeEuk81Of0trb0LqLMU/C0C5gMhNdrowwuVjrh5JJbymGGPfXDtlxwax9K0UiKPEA0opFXBG75SaQosX7SwMuBhiHhaqYmlvB9uEQ3LqdE5mUqVGTd0n3vrHHjQ86oL05W6HdIqM7FYkxa+bbVgk8Zvf9rSzXx/8k5AY6aO5tkmO0jKeTkQSnwlnZB/ERqk8G8iHsUzDPzI7Hy9TjTnapPCWOCxBpMwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhOni2X4nF6GkGRErIXEdUg71yRkUrm6UeubFRjx4h8=;
 b=lZlRYW9p22y1CWFlMLvgBCno/Hf1bxX+QV1tHE5+9M3i89VcclSFBoDIRc47I9HU2cHQMC+Jr/WO5s6cAuz6cktntouRqnLk+0ddAtekmumCgf7KOqe5HvhgtRGNX2RxCA9mGg6DIkGWIfIplI2qDhcXLUpy69dl1moU+hPerpjjV6XwzMb54otbzIn1A5bkG9ctjwr06ID1hR2aihE7eTxJmHAjmx9jVh+2wW+OXp81y0PY9I65B0E/kAzszXgUcEbljYiKJkp0WXQiQHQzb537RmukvO3sEvt3Ohtr25O14NOJC7OfTUB5h25+tTs41MSSdFIqSPnc4VJIBR2n7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhOni2X4nF6GkGRErIXEdUg71yRkUrm6UeubFRjx4h8=;
 b=UXo5mwgz0LVaiEAIGMdA/2nNNfmbYAWkv3cE/oTtJgi2AoVTSRJYf4xA+RAsoDDyWJWYbkJCEJROyYbowAodCeCLXek78x13GmzjfgN7Z4De81iPg+xlkhl0/kPB7uyS84a7gES8oqz7wK7CRdyLScl1RUXv+nJcKJhz7qzanFJaqaIJSoF0aa0hZ+ffx1sh7DHySDIee4Ol8zZgSwVd7X1YNls0hYKdtclqG+jhyb48948VMeY6wYt6VfkyG0x2yU3Mq2tJL+3HMU34CppsySbnmfRLuiNvnWF/J+/wdO4qiNb/ZIQ8IHqxR4PTR7ndM9amjMP/jQ+KPOc0/moDHw==
Received: from BL6PEPF00016412.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:a) by IA3PR08MB10532.namprd08.prod.outlook.com
 (2603:10b6:208:504::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 04:32:26 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2a01:111:f403:f903::4) by BL6PEPF00016412.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Wed, 16 Oct 2024 04:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:32:26 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 22:32:25 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 22:32:25 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH 3/4] cxl: Abort background operation in case of timeout
Thread-Topic: [RFC PATCH 3/4] cxl: Abort background operation in case of
 timeout
Thread-Index: AQHbH0T84BnF40rp+EKe3+kNU9bYZLKIyJ+D
Date: Wed, 16 Oct 2024 04:32:25 +0000
Message-ID: <28ccc1fd7ef74c7e879984f9c0cf3ecc@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>,<20241015205633.127333-4-ravis.opensrc@micron.com>
In-Reply-To: <20241015205633.127333-4-ravis.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|IA3PR08MB10532:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c7960e-8b22-436c-40cd-08dced9b89e5
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?GhItqx/UWIWhQBrLNqpE5/WjPKUB27Lq8sNCL3X3lbyWOK/xpUHpsDNSQ3?=
 =?iso-8859-1?Q?0V1fU+JWeWtEnB5Og4Mq5LxbP6Oq8PsdTk0W6RjVAQay/4jari+oQUUf/c?=
 =?iso-8859-1?Q?1x3BaAbWHGTOQsR22Wkqz6/M00paVXPVojlDjEOs4MgZ/Mpk+o5rdE1WMB?=
 =?iso-8859-1?Q?+yxLphr8Lx1D9Mkem2QDk5If9UMNt9QiHMSI3SPl4WFmlX/JFQIuVfgBOW?=
 =?iso-8859-1?Q?Pg6CO7EUQtyHpjf6NYmZviuaEg774mL/AMMaDV4EOTjFSVOv24xYRTRxyA?=
 =?iso-8859-1?Q?HbDxzq1VGxCHLUgA7QWoJ++aeO42SYbtHgisq/GZuvBeEdEffiGIKagQJ9?=
 =?iso-8859-1?Q?rSkOlVUgATfNiaa324naS3+c83dbEXDBIBcUTRrCFZwcG3B+x4dR4Uv+vr?=
 =?iso-8859-1?Q?HnEos7anRGIHbHQoE3sQtfUA2sUyd9AdpEwH5S2ti0rt9wZ5MAeoWvoYvR?=
 =?iso-8859-1?Q?QKqDFEXATZ9G6ypzcWNtujehMyctdb0yl5RUjpQAiGoqrvtg22xsv1Yftw?=
 =?iso-8859-1?Q?hZmXKXGjbyKvWEyqL5Zxdjmw6FZWs5ZXmbK0eCybeZbdi2IyHjF8F3ze7G?=
 =?iso-8859-1?Q?KCMW+5agjc3Uorih/PvgMwt8e9ePFdguGPQb1RnR+o24vfAdsHXpBjqOY1?=
 =?iso-8859-1?Q?ukguWlHDczijAuhrojgHDl3r6itLWDMEQC9ZD7qLIsCI2GQIiIuODowy47?=
 =?iso-8859-1?Q?MFijnZIYyo2j5NJm5MlBzfP6koNCw/sPikmHerD4QBUCfTdAv/wA+mpqGh?=
 =?iso-8859-1?Q?IMNr8rOIfTdAmLgc1KaeekicRpqAB8CU/9ypN4zSaCRaX2daLI+bCUO3R1?=
 =?iso-8859-1?Q?/kbtAwsgwB60HO1RSknVbXBt4bWlAmeIJvIKpYhCUFEG9gnPDevgLknPAv?=
 =?iso-8859-1?Q?0BKl9Iv6ohLcTdEUIrYi9RD6DTNMY7EVUtGSU2BbF2V1vi+VBnf/aVONYg?=
 =?iso-8859-1?Q?Ydp+uApFXUd0ZxahQ7A2HsYwRpRbup1T6wfTbr++MRPmRF1Njr1CYbWxcf?=
 =?iso-8859-1?Q?//ZRxlAjRKgFNdIPHMOh9NTmJVbcRiFVsPaywzC4ystTndZazo4q2Phsu2?=
 =?iso-8859-1?Q?5juIVl+JBg9aSvd5wWUskeZvYOx1V4F6LnY8J/nBBKI0oT8+NyCgHpCTaM?=
 =?iso-8859-1?Q?rv+Xgloh/2bQ0nYJWSrpZfwbQJppq9Q2w9LxA62J3U4ekCsA7cAMscONP7?=
 =?iso-8859-1?Q?JwWD2uYhXqXABwcvpTtaPhfT28ggjqvUM1gqRNFqOC2bNVHKJqaiE2oKT8?=
 =?iso-8859-1?Q?VZeMEASSvdepfuVRbzQV+/C6DgNh8gSahFL8+/HPRUv8B9GKjT1k+dchC2?=
 =?iso-8859-1?Q?b/Wl2QWUsyI/frwx0uLFjfnYd5vHS674HhMOeQT0/RCLhOPKyXteNsk5Wn?=
 =?iso-8859-1?Q?lBErciLxqCsbWbHo9n7rZe4wACTdkLGBmkkAtzlaq+WBJmbnSzrvO1qLWZ?=
 =?iso-8859-1?Q?N0ibNHDgrNlOINC6?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:32:26.7421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c7960e-8b22-436c-40cd-08dced9b89e5
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR08MB10532

Adding support for aborting timed out background operations

CXL r3.1 8.2.9.1.5 Request Abort Background Operation.

If the status of a mailbox command is identified as timedout,
an abort background operation request is sent to the device.

Link:
https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.=
intel.com.notmuch/

Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
---
=A0drivers/cxl/cxlmem.h |=A0 1 +
=A0drivers/cxl/pci.c=A0=A0=A0 | 11 +++++++++++
=A02 files changed, 12 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d8c0894797ac..808fb8712145 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -516,6 +516,7 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
=A0enum cxl_opcode {
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_INVALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 0x0000,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_RAW=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D CXL_MBOX_OP_INVALID,
+=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION=A0=A0=A0 =3D =
0x0005,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_EVENT_RECORD=A0=A0=A0 =3D 0x0100,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_CLEAR_EVENT_RECORD=A0 =3D 0x0101,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_EVT_INT_POLICY=A0 =3D 0x0102,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d5d6142f6aa3..95c1f329bca2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -394,6 +394,17 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_m=
box,
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 mutex_lock_io(&cxl_mbox->mbox_mutex);
=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
+=A0=A0=A0=A0=A0=A0 if (rc =3D=3D -ETIMEDOUT &&
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->return_code =3D=3D CXL_MBO=
X_CMD_RC_BACKGROUND) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct cxl_mbox_cmd abort_cmd =
=3D {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .opcode=
 =3D CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
+
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D __cxl_pci_mbox_send_cmd(=
cxl_mbox, &abort_cmd);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rc)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D =
-ECANCELED;
+=A0=A0=A0=A0=A0=A0 }
+
=A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&cxl_mbox->mbox_mutex);
=A0
=A0=A0=A0=A0=A0=A0=A0=A0 return rc;
--=20
2.43.0

    =
