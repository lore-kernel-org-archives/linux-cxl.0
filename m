Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04514EC47
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054810; cv=fail; b=h2Bc/6lbQivO2+XB/Kwtc2wYIYAqGL+4GZdLBzMA33FpT5+NTEeGYErMfZfiHoLygVEFlsRuJKHt7IYrEB2hg1N5t7Cx3EkMhY0W+ourcvL/ikk9hiOz/Z1rYWZqDm91AjjLmp0y7WIkhATBUEFAFjY4Uuh4Oi7ullw7p2O97Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054810; c=relaxed/simple;
	bh=hvGCQuQMbS3+8mKEJaclt8XpGEaq5tzEavpoj0rQH2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eS2Nc0I58sXw9XjCBKIYUfAbXrplmWwon4yMG/tp4TxmaAHFN7iMuacN/OaADRjUEayVslL19lT4m/IWIRHL9mlq7Bsrt8VLpSkLJxcQPu/g3QATja21oI3DrAhnMFtd5yjGQY6ZjILT2EvQgfeWKwwmL1gG0+dbEoIz9eGkUyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=LtTnTML8; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="LtTnTML8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzFcRqqAb6ghU8YGnhTrsv1zjGlvKzT/fgMlXaEJ7IFps/sJXkepIzo7eY4Qd0xVfBmH3DiigeY4OLOVRdxN/zMbs4C4OUlVAI10ii3tADA88eFxu6aN1rEeP7AT5Y1ya6XP6FQ+NMdCV7dY3R6fuQEs3VjTU0w62kVfW3ADG5V+FwraKeRcdxMVkaqdr5xCj68zyrcTFhcfnxpzKNIGP6zyEZtj+KgCw7Des13KxnGuDpkoicP05Qv1+j5dBPMHEtrZu99ffKbDJhfWZhC/Udyy9HWZEsrvQ355mZIBdD7IBk+nNlFZX5OM1gHiU6BZfy2Ff6A3232DMQRVdt+1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiTFRp+BRDIiztyw55CWSZVIYEJnAmCSncMzI64OZ/Y=;
 b=RL7AGzaq4eDYL3SG/1QsuTgKdPC01Mpydaq/6tAp16hj8NOMJQi0SVsNSO57hobJczcdMBXtRfIdwESfaugWBcRqFrGN8KlLuBoRko/huVF9NzctO1vAyitsOy2vo6rgDf6ihwguplESgf3rg12zSGLi0z3ti27cVsZOPc68rHmZ+R1yw9Si3MmyEbIxgOzqwltmctftDtOzQqL4XzQotFlZubQicdn+bUKPcY7/Hf96cwi0GfA3spnHvOtPNqSr6o4xj3F6eDeyxq73A61pd6X7F6avhabom6NcSbrNeVIsey82d9e7H8n2GwuXbCBoHI8MY0qzNTtve57xB8V7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiTFRp+BRDIiztyw55CWSZVIYEJnAmCSncMzI64OZ/Y=;
 b=LtTnTML8tHQu0nuhnCUNrgoMm6FMtDqmrEtFA0KtzP2dd6EE8vMN/FtvA9DKGTpSwOZbFLlbMeCnC3Fzoz0zTK+xqm2R4IhgmRaenoFSeMsGeRno14A9mqgilaKAs5xXHQNtU+rIxJGR4kWP2VjM/hgOK9D+Xjaldd0zLC5i7i4TsxnmMIUqviazX+P5dMPs3+Y9q9xPbg8AbBhj2puj7pEu6ZMQmnSXNbtzGP8iK5dtcvlFrry+yy0XC5Ab9Tp1DpSxiJEwIJGcGkFs9jT3HO/nqcR/1V731klv6DAEs6tNQ4RwTiuvcXGFAYS7MYXcoY8+0/DvMP99evQtEbgfRw==
Received: from BY5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:1d0::18)
 by DS0PR08MB8561.namprd08.prod.outlook.com (2603:10b6:8:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:00:02 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::f8) by BY5PR04CA0008.outlook.office365.com
 (2603:10b6:a03:1d0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:00:01 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 23:00:00 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 23:00:00 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH v2 3/4] cxl: Abort background operation in case of timeout
Thread-Topic: [RFC PATCH v2 3/4] cxl: Abort background operation in case of
 timeout
Thread-Index: AQHbH4hALCnlF+xX6US1cNx8jFL4cw==
Date: Wed, 16 Oct 2024 05:00:00 +0000
Message-ID: <00a0aa82ae12450a8c690e11440c4101@micron.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DS0PR08MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbb406e-eb85-43d6-c80c-08dced9f6452
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?9flGv4LuidLmc163zNULjKn4foX/fi5LbsczLshRVIDYxpCO2JohozVRo7?=
 =?iso-8859-1?Q?Y/yU2ROvze0xiX08RlB7hkTG7/aFsM2EW49bYRsKYK9h+vLUjb6+hrgWsQ?=
 =?iso-8859-1?Q?kNYFtnpaG1zZNNTF6s5Cb1HH7gQoFKpYp6LZq6p8Nkijau+9ik9+oizWw6?=
 =?iso-8859-1?Q?pH3jSemBTtzQg9AZMR1jUeut1u+O8KVIPOmdkJ2Rw7p2BFUcNvGshKnuDl?=
 =?iso-8859-1?Q?qyuATol2IrQ7SCfHv5O6hEW56nutATJU30dNKF2FhZYMUzu2W8CXtKNv2N?=
 =?iso-8859-1?Q?3+WhL7RBZQV0RPQqaPRiU6nehot3u9dCA0fRyDLWxYa64rV+rD++/P48Z1?=
 =?iso-8859-1?Q?XGJPCGLS3L2nQ502WFxj3ePNQIfgF0hiBZTvnUW5hHs3zSPlDhaQdedM8K?=
 =?iso-8859-1?Q?P2NOZuh5JRXSIIslEl9gqkpfID8Ub2NvyORrVvKtqCPEgnijv6XexIQa9i?=
 =?iso-8859-1?Q?qr3Ox9S3H8trCIEytMgILYg1At5c8xbfd+igxaeZdx/VBrRD3SXtmQgGWa?=
 =?iso-8859-1?Q?9Rm5jJUiO7Vi/2kbRcDaqyS40O6qYegljEB08nBVp0BA0UIf0lmkPaDlqP?=
 =?iso-8859-1?Q?1fC7+gGRuDNi+de94kX87NrVWLFgfoKxTuz3YGdbYd8vfgEpEs93SXZaHx?=
 =?iso-8859-1?Q?YXW+99FTselBmJZKu0qZkxjN6ODzY32fd34FFcchVedRTR9rdF5eSLyBg5?=
 =?iso-8859-1?Q?QLHpQkMim3LdZQZs2jzYjVbXildV7s5LKO4eyMLX+1kFt03x3hRi4gP079?=
 =?iso-8859-1?Q?85CX9jRW35CXZa03AY/rBg+V1ZB2lAkispUiLXfIKMh3FHN1lNwjpiGlEj?=
 =?iso-8859-1?Q?B4K0k6AdNY1HFH/PXCo5Uv6oVLL7xHMkETQnpqPA1IYnQEcsHKtQ5agbJt?=
 =?iso-8859-1?Q?5E2Y5k6+fIOyvvF40LKDvMIhTwQPm1BZeL3ZkhTA4L38YD+s6+rhzDuTV9?=
 =?iso-8859-1?Q?FlhWpQ8wIFso7rH5Z+ST3TKL0LkvxT3KxRLkGxJgN7fGCNo4JgO021fZ8O?=
 =?iso-8859-1?Q?hqI1wWZtV6wBO11IZ0/Y04biYDerTVyXXV1lmu4D8/yQ199grnFz4CGKO6?=
 =?iso-8859-1?Q?4Ci9Gt0y4rmNGVVk7oLVccso7ooRXWRboaxTdbt2xKkz74YDs1TFu1Ttk+?=
 =?iso-8859-1?Q?vv93PLZovQY5EnWsV/t02oQt/yHQDdEE1Nb514AO8jRMtez9OHnuERu/S3?=
 =?iso-8859-1?Q?PH6K6zuNjGxSFggl2t+LXyTr9HD7opYYNRQSf2U0gDgEhuaL8o0MKFiDln?=
 =?iso-8859-1?Q?kfeLqZyldDqhLiaLZT9RNhqQ0l8LrW9PKKUw2hqer77mzSPv4+wc+tekyq?=
 =?iso-8859-1?Q?bBRKx+ZoI1Wg9/iniwLJTQhs4KSLMJH9Io5eFzxqK5vApeU34ygqhuFQrJ?=
 =?iso-8859-1?Q?GcMfhmn26UYT1NO895FLuoSCxHuHxxawBxnd9qwSnw2X7LVaiIxGkR0E6g?=
 =?iso-8859-1?Q?2658YlN3gSuucl4t?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:00:01.7716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbb406e-eb85-43d6-c80c-08dced9f6452
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB8561

Adding support for aborting timed out background operations

CXL r3.1 8.2.9.1.5 Request Abort Background Operation.

If the status of a mailbox command is identified as timedout,
an abort background operation request is sent to the device.

Link:
https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.jf.=
intel.com.notmuch/

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
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
