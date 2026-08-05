Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2D3515E6;
	Wed,  5 Aug 2026 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785915775; cv=fail; b=HrXsemECCO+aW4MzjpcJh4QZmL4zv0AKd3oi6rewDrJffh1TFWo/d6zvzaBM93hxDvdQkfbPVJfB8oYWI8U3NdDGJxerWPqYVibXvQaSTcQnNMtVNyiAH94gVYEHgd6KfqEvqyliMB17KjzbVNvZsvXTJRJjGndO8v9v0NnoXhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785915775; c=relaxed/simple;
	bh=EZHms4qXVef8tti30Rkm08wj93+uPFIHzLwbYNMyogc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nefb3XdRQ7IGEgkMo97XubCwWstaPTFbN/Q9dv20f24uqTpvjsewnDvusaw9dpcrADXUFmI1jVSVowyRFwbVoq/BgNwLGGPCgMujqOLY9k7zd/xKdGsUPjQp99AtfWhj5fTRqU+WErcw/TDXQ/twWFqZKpGl9LyBfxtC375ATQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sLhHqdfE; arc=fail smtp.client-ip=40.93.195.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sLhHqdfE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjJyElFTP1oxD9xwbV9okPNv2Ke+kDWzu+USxB6G8bYzGTbL0a0UU5pus+DygKC0asDcM2k+/gsbLWkzpNLU5GD3NJgBip9M4NlBrTSadRCaaDTjfPRW+6+CtP30Wv+aYQTc+mKy0EuUdNAUIV1yTa4YXXdBlHk5at1wg+YgqZ7J1021fasPaLPYQUb6rvUaFJAcYp7DiogKm2xf7Bbx4DjjbBrx+8SzQ+uNAbhJjZ5IIcVX217IEb38A04lgWnSJB3malhPdtfhlsWa10+y63xeO+IhJdZidxE54sIEKD/svQwQymbgNKZ+pZ0mNC1iNWe8EOLFrxzYAMftNgjI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciXtTSUApIRZK32G5tnpo7fNyWW4dwzCK7k1Zh315IM=;
 b=MyMLZpJ3gyHP0Yd/zm1GjPV11ZUE8UGOXcM+I8VuFo0zqL0oE46GV1JwkkV1eVV2ncp0NL2q9o5OCusPVc4a9tRoGpEqvtxzYNtv13/sI05aFbPnPcw+2jrbWsqCma63NI5q9ZHP9aychjwSo8MrdBHJOerRmvri4J2yNwpbGg5gpmr1GZ+l372nyvhj1NHoS0f34Ytldcw6P3MZtTDf0pMWijTMvFQutZ5839dfdJypm6cQvCsWxCKOx9/TwQongXVUs16JUsIW5JTnMMOiCMODq407UTlF1szk/pKNkoQnPI3MTC4IeKlrYFpFCyht9Ch5JBaGMb7KP2IA3/gHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciXtTSUApIRZK32G5tnpo7fNyWW4dwzCK7k1Zh315IM=;
 b=sLhHqdfEbQywCzwRG7raxWhdfHfXF/o0J38JT3SBAAmInEs2AvaFtyM4bMVwmy3gV0h5YpVusXBo5jtdhHc7VNoojpG8Iy/bh07fPkXxEwJ/wzTl9FX9qRtKorXo26E5NnOB/blaUTjYTkIGRnziKX+jIVAuO+3fpEJ4a3UybfdlYD9f7+Q3uYHrjmST9RTorIjG3LUJJigpM+AzTk+rmHPN1ldZJVksG2FA4nOnofgjTY9VfX5MvJTBRcNiam3yWk3V2p3PjjaQd/QdpfyNOOO/wXlM9KIU56oBrTb3Ho4ZTpoWIYb2sOf28N6H6La2HaF5iT/EbObEAKBmlgYVJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Wed, 5 Aug
 2026 07:42:49 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 07:42:49 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [RFC PATCH 3/3] cxl/test: Exercise Type-2 automatic region creation
Date: Wed,  5 Aug 2026 15:40:42 +0800
Message-ID: <20260805074042.30173-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805074042.30173-1-icheng@nvidia.com>
References: <20260805074042.30173-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0096.apcprd01.prod.exchangelabs.com
 (2603:1096:990:58::10) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c31873c-6d7e-4ea1-d5a4-08def2c525a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T/hRp59bBvAlXYtz2z1fY6JAV6ZPcWtrkz4HQP+UzxcHnkrCtOPtVAjn7VgEBrNkgsHgoYkqr+tFe3tmncp7eaTyzjy3MyJ7cJzRsFiTbns2JO2U8BeBD3y5alYgGdFtyG56NYjCLcTLmtuKtW73WlE8/qPfOMH6UM6axRtzaXIup+RP0a/B7MvkBuNFzLf3ZtcbjTz2GqdI62Dto75Zu0F1sHhe6gZB+zyy7tpS2EeZGvP4t2SUV+0yHMvfLa/xYfSU2EedaYTfF1byL/sz6UBjXb0Ne2rtv47A5868ctJDH/u7tzGwhDJOUigRMOaA6mgiMOfg/irz8zaax9qIIPdK9ynGSXPfg+GGirbo+mGnNAwb2x8YLNgTVLk7onscl50AYsjnhoXFw5uOabmQyfx6NzKrmVU0v0FewWC3SF8Elv8KSclGeuth92MTOgI84iScmkzuVmiXj2jHFS+UwwlgI71uDQSPPItmpUFqbTPr1JEQAtiuyKqhJ5tCSvM2JkSK90gE+gbAydr9DaF7pWsXvQkdNf0jtFKmnWkIVFGE5Lq0ECB8tJnWls9iXqZqPrMYjNnARUzLROhODM1jJk3WHMYKl6H3ZNo9gv2TVBZPndSyK0lN4mmS5GXrLkpKbnDFjxaUCHVbfSpG7hOyHRGZEE5A72Vtt4ZzNvWpBTI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?82lgNC4gP4ITv5iaFRPOucPtDgJkNiYuxmlEoePZw/j3BB/ErDVUaLS0r2f+?=
 =?us-ascii?Q?FajoS0hMD21V6W4Ro7fWM5RhVIDoMFi7cyHwH28ExcILueZkG9Q9+ZmLN87M?=
 =?us-ascii?Q?S8Kyo++v9lFAVDxgPN9SBMmhWFo0wbR7Mom2t+MwXuQryyMGQkpTr8BYO1su?=
 =?us-ascii?Q?u8ZFR0+gCnIO59Ewt/K1w2YONCm9RdO10ouQLPkiyM3cAZZ5CVkxaA+R27rI?=
 =?us-ascii?Q?4niiFn05oZlenQWiKWlgSTtSmSnmVD09GkA6nolILBOKxr60seCag7SpFGZt?=
 =?us-ascii?Q?snhYu9VhylPInO/NCzS9xqpNNUovJ7D6pkeN/NjZzyrFYRQ6z9iENxOeaJC0?=
 =?us-ascii?Q?qbaGJSQr4wq+vHz5k51GG2zXznROry2/XSqkP/HYWaQ66jvZs+doEnM0r1Yr?=
 =?us-ascii?Q?R42RaOGFehQULtL7gO7Fho9wrysgFu/MxPqmA3O2EFowP9JIV+0L4DyWP29Q?=
 =?us-ascii?Q?qDBho3EvN4Xtd0B3FDyKsNc8egEWEKzPyrmN718Q9CjHiBwvaRDtbqyNtbgm?=
 =?us-ascii?Q?GbQXHvLUIhVl9Vj0CA/h9pAhetCxiKZIwdQ/7wCsr9xTOyeYC672kI3YeYPO?=
 =?us-ascii?Q?NC6XkiOTddgDRj4CnqFdeAnAL5igzOpsrOcvy53Ug15LUq9tbhDkP+tSwz/T?=
 =?us-ascii?Q?oT5yLwxxu+VQGMR+UOksM4irm8Uhe16Uf9mHviKNdBeAg1INKZu37mjqI29G?=
 =?us-ascii?Q?d1t4M/gjDWvZTb0ImR35SXEBr4s4ehRB8kduQSDiT6RH16KTfn6tUpHGl0G5?=
 =?us-ascii?Q?U4a2jW9o9v1vGfgz72scBUT1C8nyb9jmU3t2a3N5tNIp7OPU7bZHjSdXlojh?=
 =?us-ascii?Q?rlWP0StYD2Ju3PqM1J5XN6JcNQbb3EvfhuM/huHq+Hk+02tRsxPrAae5WM7t?=
 =?us-ascii?Q?jzB8eU59yKRmX6VgAjB3+YP8Omza2Obt0CbwoL4eYkIXe7BjO1VVbD7eH3+s?=
 =?us-ascii?Q?NYhSjFqFAcgu4UzNecgaPSlh4zK53yXq5otWSca/zbkkxLOKtU8SFXdp+kPf?=
 =?us-ascii?Q?xk7VEBpxnqV1IsCe1V4jrdRpoWKPHWJCRF9leGW+XhRWEbp/UbsdhKjJ1Pz6?=
 =?us-ascii?Q?q5rA6KyEhJmcz8xA80eqcNNZeMr0OoF6XYN7D/z58+Xh52Hc8G3JgfBVifZy?=
 =?us-ascii?Q?G7DUdZ7d7nOrQyRMlj4Xzf2aWq5/5v74MGgzSUidj2PRDe3UBNGnkWzJTnTv?=
 =?us-ascii?Q?SF+qeCy1jtLqa238YQJPmgx1kSYRFABWWfgg+pTwyx8CGud2fcQ5jYEaJgNs?=
 =?us-ascii?Q?VrpRsuDtZ/a43aPT8L3Wt3Jk2IwEFWSBWrPauAAUbOfjiI4XN8RM1Pe3dsMP?=
 =?us-ascii?Q?te5WXSDdqv1XQLSQGkAhvU7/SIwVbdmgNBWxWJOdCMiJT4sk0P78YAb+11aC?=
 =?us-ascii?Q?9zjnX7RsKqeY6HPFXPotabeF5B+vFkKnJaLrBVmcJwwRxKN8MeJalKDdm5G1?=
 =?us-ascii?Q?37gIvTA/8d2di/Eo9gA9hkspiCieCsPOlA34Yqrm/nSznjIBgY0i3DFmbuZ6?=
 =?us-ascii?Q?4vT47U8a90xwE6L7wkuxxhaVTlR68iWhzW/FNDT8kOZoEvBpbs20+K5WFUGC?=
 =?us-ascii?Q?rPlf64srbF2wVBEsUFcn7sc1CDokpkNsjbteRV1WxHGlybcfnbFmrdUD2flh?=
 =?us-ascii?Q?pHOYsiWweiKU+e+4r1XygPiQJ5uoz2KDt+YYGLZPVoRnCLby5XFZTfokedxO?=
 =?us-ascii?Q?kMtbLBl4Ww16laXlSP9tZfc95jccKFzyIrAqHpfSAd2Cqh7rLL05BjGUO+pS?=
 =?us-ascii?Q?uwcIuevRaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c31873c-6d7e-4ea1-d5a4-08def2c525a5
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 07:42:49.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ob9i6BG/LtHC2lik01xgUgDjyj2fyR4u2ph7zg9UBaXVqpLlz9jsxEfXiY5cRc4XX+UWKL9ooey1fGidLby6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

Add a second mock Type-2 accelerator with an independent single-target
CFMWS and an uncommitted manual DEVMEM decoder. Keep the existing
FW-precomitted accelerator unchanged.

Verify that devm_cxl_probe_mem() creates the missing region and returns
a valid 512 MB HPA range. Preserve the manual decoder config after reset
so the fallback remains available across unbind and rebind.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 tools/testing/cxl/test/accel.c |  7 ++++
 tools/testing/cxl/test/cxl.c   | 61 ++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
index 8e6f4687ca02..7e5d76a7f8c4 100644
--- a/tools/testing/cxl/test/accel.c
+++ b/tools/testing/cxl/test/accel.c
@@ -38,6 +38,13 @@ static int cxl_mock_accel_probe(struct platform_device *pdev)
 	cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
+	if (mock_range.start > mock_range.end ||
+	    range_len(&mock_range) != SZ_512M) {
+		dev_err(dev,
+			"accelerator%d returned invalid HPA range %pra (expected 512 MiB)\n",
+			pdev->id, &mock_range);
+		return -ERANGE;
+	}
 	cxl_accel->cxlmd = cxlmd;
 
 	dev_dbg(dev, "Probed mock accelerator with range %pra\n", &mock_range);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8ab2ce1262f3..305a0c3705da 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -28,7 +28,7 @@ static bool type2_test;
 #define NR_CXL_SWITCH_PORTS 2
 #define NR_CXL_PORT_DECODERS 8
 #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
-#define NR_CXL_TYPE2_ACCEL 1
+#define NR_CXL_TYPE2_ACCEL 2
 
 #define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
 static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
@@ -493,7 +493,16 @@ static void cfmws_elc_update(struct acpi_cedt_cfmws *window, int index)
 
 static void update_type2_cfmws(void)
 {
+	struct acpi_cedt_cfmws *window = &mock_cedt.cfmws1.cfmws;
+
 	memcpy(&mock_cedt.cfmws0.cfmws, &type2_cfmws0, sizeof(type2_cfmws0));
+
+	window->header.length = sizeof(*window) +
+				sizeof(mock_cedt.cfmws1.target[0]);
+	window->interleave_ways = 0;
+	window->restrictions = ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
+			       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE;
+	mock_cedt.cfmws1.target[0] = 1;
 }
 
 static int populate_cedt(void)
@@ -814,6 +823,32 @@ static int mock_decoder_commit(struct cxl_decoder *cxld);
 static void mock_decoder_reset(struct cxl_decoder *cxld);
 static void init_disabled_mock_decoder(struct cxl_decoder *cxld);
 
+static bool is_type2_manual_decoder(struct cxl_decoder *cxld,
+				    struct platform_device *pdev)
+{
+	return type2_test && is_endpoint_decoder(&cxld->dev) && pdev &&
+		pdev->id == 1 && !strcmp(pdev->name, "cxl_type2_accel") &&
+		cxld->id == 0;
+}
+
+static void init_type2_manual_decoder(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_decoder *cxld = &cxled->cxld;
+
+	cxld->hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = CXL_DECODER_MIN_GRANULARITY;
+	cxld->target_type = CXL_DECODER_DEVMEM;
+	cxld->flags = 0;
+	cxled->state = CXL_DECODER_STATE_MANUAL;
+	cxled->skip = 0;
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+}
+
 static void cxld_copy(struct cxl_decoder *a, struct cxl_decoder *b)
 {
 	a->id = b->id;
@@ -1089,6 +1124,7 @@ enum cxld_init_type {
 	MOCK_DECODER_INIT_SAVED,
 	MOCK_DECODER_INIT_TYPE3_AUTO,
 	MOCK_DECODER_INIT_TYPE2_AUTO,
+	MOCK_DECODER_INIT_TYPE2_MANUAL,
 };
 
 static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
@@ -1104,6 +1140,8 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	}
 
 	*td = NULL;
+	if (is_type2_manual_decoder(cxld, pdev))
+		return MOCK_DECODER_INIT_TYPE2_MANUAL;
 
 	/*
 	 * The first decoder on the first 2 devices on the first switch
@@ -1121,7 +1159,9 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 			    MOCK_DECODER_INIT_TYPE3_AUTO;
 }
 
-static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_decoder *td)
+static bool mock_decoder_handle_saved(struct cxl_decoder *cxld,
+				      struct cxl_test_decoder *td,
+				      struct platform_device *pdev)
 {
 	bool enabled;
 
@@ -1133,6 +1173,11 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
 	if (enabled)
 		return !cxld_registry_restore(cxld, td);
 
+	if (is_type2_manual_decoder(cxld, pdev)) {
+		init_type2_manual_decoder(to_cxl_endpoint_decoder(&cxld->dev));
+		return false;
+	}
+
 	init_disabled_mock_decoder(cxld);
 	return false;
 }
@@ -1209,6 +1254,13 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	put_device(dev);
 }
 
+static void mock_init_hdm_type2_manual(struct cxl_endpoint_decoder *cxled)
+{
+	init_type2_manual_decoder(cxled);
+
+	WARN_ON_ONCE(!cxld_registry_new(&cxled->cxld));
+}
+
 static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 				      struct cxl_port *port,
 				      struct platform_device *pdev,
@@ -1361,7 +1413,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	case MOCK_DECODER_INIT_SAVED:
 		if (WARN_ON(!td))
 			return false;
-		return mock_decoder_handle_saved(cxld, td);
+		return mock_decoder_handle_saved(cxld, td, pdev);
 	case MOCK_DECODER_INIT_DEFAULT:
 		/*
 		 * The default path picks up all the decoders that are not
@@ -1375,6 +1427,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	case MOCK_DECODER_INIT_TYPE2_AUTO:
 		mock_init_hdm_type2_cxled(cxled, port);
 		return false;
+	case MOCK_DECODER_INIT_TYPE2_MANUAL:
+		mock_init_hdm_type2_manual(cxled);
+		return false;
 	default:
 		return false;
 	}
-- 
2.43.0

