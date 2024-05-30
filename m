Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514443207
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051687; cv=fail; b=dyZMIm+w48HHQRf/20tfBzByFUap0An6eYiGnFBVPl214qebxJXpwhzj0g1kBvsRcInSpwa9zt03ojDivn1QLL09v3QmYI1o0/xtXzl663u4CHUtu9rCXQDiFUnTyrlQDLCNZQodQrINw6/UtYpXxF+zrgkMhezjhr58PNsvE6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051687; c=relaxed/simple;
	bh=tt8imH/gfoaBO4HB1A/DzKYZP4YqDJJlU6HM5Vr5k8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NwDwpqys9Ng+xlLBBmnrDrVXUZTyHeB8MAoY37/mzsxP0inVaTIFADaMjo3M4C88NoIyy2Z+QjWMGSOkF/ASdFUO0Mgn7bbedARKB9Vk5s/YEm+hKfYtTIrm9LvZdLjsQf7+BeDsFH2DlBvHxid2BHyfBKJp7XQzRRseCRWPSF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=scma/xzP; arc=fail smtp.client-ip=40.107.255.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="scma/xzP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd328yd74lgerl+mVsOXCf8UxQza+ATwY5KbvjLRJDyI1KT/M+27+mUkTGRmR/CIwpCWh5sVILzDypvsdZ4UvFBQPmpZFVnwAOOw4WlBzRQoBi3buhNXTA8zff5OCLp2N3DgVKbOH/TRkWUAmhlFd5+jWCfZHoqPthPPXl9VjhobCc9lRVhCgjRUv02z7TsCEamHo1V1TjJDsnYjUiMMqE/cW2CtAk14KM7gAy3rdl1+fz6xvGxBJE8/TUWO4pyCr/cYkjioyfI7+WDNwIyd1VTaY3zfTH/1yMMAcGYNb3UrDjF81vqcJZI224Lz+Zg6aSYrN0TrP72R9D50mbg/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKQ5bmBFxWbZF30kNiSTrGcx8tC/2eDqcYnPKimkCu0=;
 b=K4KKOPWv55FLWLvdRT9U4AP5pGPJ3MNbZmZPUd2W3FLrwK0I/I/pYrdYPCSUITYzZ8UqBHmOcOQxqSvFRMnCBKc2G1zzxR0UHFTxMCM6Prp8Sg7812eQGzAfcTAAqKwSnloIUmtgjS2WtehLkCH6SFJ/gKyZ7ccah+m5CZsVZX0mMbnLR+A5mj01dIWgqg24lm+/mM0qcqWBErCLjJlb7kPlJyl8g/79dKUDxv2MxPnuCZ6cdLkS7k+pQwbqWp/FR9cJP93ff83k1pZSIrOAbZrlDTdFUVjYn+ke2sQ5x+PrqNDrc4vUNXA0quevN+lq6A4Uu9ikpa2H6PyAStfbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKQ5bmBFxWbZF30kNiSTrGcx8tC/2eDqcYnPKimkCu0=;
 b=scma/xzP25Ffku7TAtoNI98o2bKLgO4yp34LUPc62KD2PXwcg7XpVHmHxwffhoxKQgjg4NPUxV8GNd1Uwrjz/fas8hDg2fd24wj8Ny/9XG4lFaQUxLQN176zTrRKvkC4TedaAGLr+j560PnIgN1itsORop/t1Am85shv9ICqgnz8ixklODUJ6Qr7jc5gHq2E8VHHQ1+a7tQl9D82LNPBFrDghfDW6mZJ0XNtSSpPNzCgUz/xPinTvRVf2uyHY6nkgMl0LNL+0xvDJcMcCyq08Et9ifsOFPK0sQYkL5MyLCCz9SgtfQap6Mdf65ZHw78T2VEaqplztMjgcoTmEl7RTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com (2603:1096:101:83::14)
 by TYSPR06MB7047.apcprd06.prod.outlook.com (2603:1096:400:46d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 06:47:59 +0000
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916]) by SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916%3]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 06:47:59 +0000
From: Foryun Ma <foryun.ma@jaguarmicro.com>
To: alison.schofield@intel.com
Cc: angus.chen@jaguarmicro.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	foryun.ma@jaguarmicro.com,
	linux-cxl@vger.kernel.org,
	rrichter@amd.com
Subject: [PATCH v2] cxl/core/pci: Move reading of control register to immediately before usage
Date: Thu, 30 May 2024 14:47:51 +0800
Message-Id: <20240530064751.586-1-foryun.ma@jaguarmicro.com>
X-Mailer: git-send-email 2.40.1.windows.1
In-Reply-To: <Zlf1xa3O0DNu8Tv3@aschofie-mobl2>
References: <Zlf1xa3O0DNu8Tv3@aschofie-mobl2>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To SEYPR06MB5256.apcprd06.prod.outlook.com
 (2603:1096:101:83::14)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5256:EE_|TYSPR06MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 0205bd59-cdff-4cbd-253b-08dc8074717a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9u4gYUVar1cYUUfut7V09zq8mNHan+Qb19fSYaZMSOdBkWNT0P/Z8vKqfxCV?=
 =?us-ascii?Q?+UZiRWi0iOYDjPhh8oQwo5G3E6o8n/YlskxhsUXnGOSjxhsHJHY+y9PBCC0l?=
 =?us-ascii?Q?YKNpQ02VcA/X9uoYvw0z3Bq7I0mIRjS9tSD5651qHtU6Us1RLwwnmIFrj3B+?=
 =?us-ascii?Q?bsNsHM5D8+3tbf1CNAr2IaWNQe/yH7S1inVl8tP7XKBG8GSBJLIC+uoPX7ni?=
 =?us-ascii?Q?7UIkHRIVMKE7jvN0lrN86h2PAYYmRHNbLALdtMvi71WnhP4uHZ4YWYGAgW+a?=
 =?us-ascii?Q?jDmPZAtmYecz03tFcNpHqZ5obUMBklgQzl9j/NpbghQKoeHVMlVSzrs6xRpL?=
 =?us-ascii?Q?L2KICmx98LF/cmWs7oC3ZFF62PyJWE8vBIObxXHpj+Cew3koJA4hlKBwr4iQ?=
 =?us-ascii?Q?bBrVRHeI8PO0h/tmj94lxkosbAk9QW4ZimJcAwR9o5AZ0xYmMzKykFRUVzLq?=
 =?us-ascii?Q?336gZEw465E5v8yZaeJXQjJXNKT374cshgPHwitF1syU3yYCzTIibXIYy3gv?=
 =?us-ascii?Q?USSpOLcxgOZeVen7tdBjRuh7/h8e2uQjT9/yeIjKA8V3iE+vVhLf0ah9lQxt?=
 =?us-ascii?Q?meJbwnosWn8rjLfkEnmQ0zD4P5UyizOeYJcdLZPi9ZQqZkKC/DhECx/rjP48?=
 =?us-ascii?Q?bAYGTPlkb8cWyu9gAdymHgULX5U1xeDecwuzaxZRyfrCxLmiPF17k7knm0Qe?=
 =?us-ascii?Q?k9kevReJ0+9lFkzOLG6858RMzvseFk3Dz7ZqXpCz4wvuXJgCLLmdYY+ABn1I?=
 =?us-ascii?Q?cIAcfA5eQhHkHlphQo7+4REIO3PyeE4fxziiLKfUOPkWfu+/mefhGvtMBpo8?=
 =?us-ascii?Q?dUK/UwDz9ulQVdGsctN5AD2CqggmZQ7izXSo0NXFOBmoykUM8EQSI3R34Jn8?=
 =?us-ascii?Q?3t+gth/vwfuTAaDmCxR2jPjz1MoXik/LzkMD4oay9Nhsj6nI8/pDVI6iYvgP?=
 =?us-ascii?Q?TGHKDTOOtKEEEQD0tWK+cy6Zj3ftopsnWC8dyzV++NMxpCEk2RKvL36O0erD?=
 =?us-ascii?Q?jPgyWTHbpysG/S1dYaO47/GWlXMPzZNDL0gAGWPgm5jpfJIXovpCp2p85oo8?=
 =?us-ascii?Q?oJTYFN043ApZt69eIBOEpALjSNrcuEkSPajTDh3MSW//y8EfQY4/vFXAj44r?=
 =?us-ascii?Q?/PXBQmbM0JycyARNH0f5Eg58UfApvpFjxdyT0UNZQzzIdnKbtAWlCST0ym0Q?=
 =?us-ascii?Q?y9s3LkiZQAROX9+aFyL52NF8JQshbVWej/3z6UU/YxTG5jQnj9NtquWGHgYe?=
 =?us-ascii?Q?Nh4/Cei4OxMbJeAKbHJkDpsI+jbaPAx9Bd5oXD5zXn1MAjQDzjboqVQzN4QT?=
 =?us-ascii?Q?gyUdCqKVjsslDdyX9CMnHfNbpOy2iLpENs9XIqL8vmAnRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5256.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWf+uy3tmC8cn7Tnuln8lG52MYBuX/ukJnny4DbM5k51HlM7y65iv92mBNX9?=
 =?us-ascii?Q?h38JbHl+tPQngcIF3NZX1HWOIlG304hxBIzFrxCX8xarJBq8vKrIsDYtkWeG?=
 =?us-ascii?Q?IC01Yc99eqf+StJMM/8Wj6zFZY7LnKW2gINvzHZGpjkp6t3uSuVVP5lDV1IQ?=
 =?us-ascii?Q?1zZnXy/s5+sJZyXbl/vzLCklcVC0Pr7A20Z4dxtH7YfDGbELzA9VydHq0RLc?=
 =?us-ascii?Q?p/WzJvUx9FsOC9GsIn/OXs5MRFqEyZSSM9tz2MAYBFuHs6CDy4pV+zYcYnZE?=
 =?us-ascii?Q?hNhWrsr7Cf/3KhCFtDdXX/c5snqyO+JFrUMXTz7CE0RBaWDYiD2XOok0E0Md?=
 =?us-ascii?Q?vl+Kv20Fm8xz1GCswq4DNWasoe4jyOdV/E0NC5Vegh6+p/7ciJMRdssSktQw?=
 =?us-ascii?Q?M7epiCBWVXtKpkcNaHSEsv5sO/sE0aLADJBxHuTWvrCgQwAZsGqath8yVJoR?=
 =?us-ascii?Q?DTXeUZqA5kIQ/iNbcOsJgyiuQkXwsSXaQOk3QXj1REH920Aq+awcSNhOzSq2?=
 =?us-ascii?Q?B3pj7DFDOqpnTGOL5+RbrKIu8htDSvLOsjFfw4GI4KE+Ltk8rv6CiwRsvbDL?=
 =?us-ascii?Q?V0LJa1hiGczkpBKt+VocO21oq9ptcKHuYesnY3eb8wHjWyH5AHw0xz/Y+UQa?=
 =?us-ascii?Q?tXcMudq6w3iQ9fdRYFwj1zv/MSaBEuIqomoIxJNGCuJWu1g7Q8TFAyTS0Rw+?=
 =?us-ascii?Q?Wm+u0/N1gM5q2c6l/+gtDp7hCzkF32gqv1CKfhos9W7J9tQMJYWWgEs27Kzj?=
 =?us-ascii?Q?M84Hk413woQwuBk1srnqgZTxoMlKJHvd8/1taXrx+CX2Ml0Ek4Qt3jtq8k5N?=
 =?us-ascii?Q?TFOKDo87Sp7EmQ/pePxeB4kHLL4cLrco4slKOVcIiVe6HoviZqthVqxKDd7F?=
 =?us-ascii?Q?GrDO8QB2jXdW6rMtDqNGl45e5Sem2GPgZLb811fh0OWlz4zSPZsZ3qknB+oi?=
 =?us-ascii?Q?k9d25EtbSMehcLGuqJsVctN0aMAMSS6CRXXNKEZ/sv9xSQBC3udX7Qshkgmn?=
 =?us-ascii?Q?nsRhJ2Rx+7SqLFsaAXrelO/zX07zXB6AXrwUFMZucHaNWKoW70rTRUITvl7V?=
 =?us-ascii?Q?ppaA+gD2V94zJS7yfxjg2vHHx/wSMbvz7qJtpq4LleKdqQkjxCibQ+ycVUru?=
 =?us-ascii?Q?E9B7dAemmLtZMdjZ75+OUZi+4WycXRah1KzJXdIOVMVPhrsPOabwcy7IvfyV?=
 =?us-ascii?Q?4BO56ElLu2MIgL+tkyWdlied9s7U+h0zNGHALwTVmBEdYPd6qMFNDQAg3Fl/?=
 =?us-ascii?Q?J6wSkLLHllj77JICWEfrouJup0CRvhFx+Ek96RfDCjQHiu23/c/sCcWfIdp3?=
 =?us-ascii?Q?XPoo6iYXN82fvowe8+eq0Y/SThNVDAYcB4foiO7puB22/1jdyq5jNSSGqVYk?=
 =?us-ascii?Q?xEagJn5lEsnr9tkvA5DRPY8LVj6Zv0D5ZYSWu3srdRaGAaTJunlgGjUO5Pb7?=
 =?us-ascii?Q?fgiTe1YCfhhldd7Jk8vP33eoaNPHBAjESS2Ml/Z2waIbvSS24+vZDPSrREA/?=
 =?us-ascii?Q?ZrUR5cAGtPtClt8cyk0EBDR5+WEtBFb3koPO+gMQIHjyR4X82lbHz+mrOLG8?=
 =?us-ascii?Q?/hQbHoREdV4iZ+NyweDRj60vfSd2fFgYUPAAlsgoV0z+HPwuyyT9Wxn21z7u?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0205bd59-cdff-4cbd-253b-08dc8074717a
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5256.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 06:47:59.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra9H6ihco0iLTX7yeF7E6Azot4T/5shAoPEsWDfdnzDgCfF6Ff0n7fleOuvpHzbnr0yzkZX16vSJWqfrGnbzXGKdxNrhdMHjG+82lIJlDtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7047

Relocate the reading of the DVSEC control register to immediately
before usage and avoid unnecessary PCI config access from the read
if DVSEC capability check, hdm_count check, or device validity check
results in failure.

Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>

V1->V2: change the subject and commit log, suggested by dave.jiang
	and add change log, suggested by Alison Schofield
---
 drivers/cxl/core/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8567dd11eaac..627be83881e9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -338,10 +338,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 	if (rc)
 		return rc;
 
-	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
-	if (rc)
-		return rc;
-
 	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
 		dev_dbg(dev, "Not MEM Capable\n");
 		return -ENXIO;
@@ -363,6 +359,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 		return rc;
 	}
 
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	if (rc)
+		return rc;
+
 	/*
 	 * The current DVSEC values are moot if the memory capability is
 	 * disabled, and they will remain moot after the HDM Decoder
-- 
2.34.1

