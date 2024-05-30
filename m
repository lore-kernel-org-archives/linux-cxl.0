Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD62168B8
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032751; cv=fail; b=h+O/MnfCVrnFGXoHkEKy9AtoE8I/RZYrZMruFHDFv+weSzIUKXaEWso45Bdvp/EmjNJetWyrxaxsdmr5pIW15gQKcxlAnOxzZikGPgAFHZHE1FuT2GQs0h8uwbEKy8eRDbM4juVKlsHCxtcvmVsmOXdRIHvsAFahk40Ujxl7gIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032751; c=relaxed/simple;
	bh=VDCmaJX84bINEhonGg9aToXgF6/85GrbP62+ngW5j9E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mYZ+QS0/+kOMAf83321Gfu/6eppR/LudBMgaTKh2F6kNTqb050Iw3WxrFEoc9Eh1Sdqs2DR1i301WTMhn+6+4c5k8GB2KUeJBRtSZijqaSrNoxiS1yacdkkrvhLH7KpiyVYrAH86L8i0ix51xvWHYzZIbE9qKlp74TlHJup/fEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Xdav4ZLX; arc=fail smtp.client-ip=40.107.215.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Xdav4ZLX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5h/csuiwzwIAsuRiHOFUnd1If9JZpfdvWO/EgvXgdVZJSj6daq6umlYLO53NtruKKf1JnW0Ordsnlqtno+vantyUmarEa6XZ4tM5O92ZEBN0/6vX9u39Sk5XricqGWxYQgcCacQ05E+czEazHKlEg/s0t912JhfxQH6ohM/zGajn8bi1MRJB5i9WntrfZU4mcxJ3lPysumdcAtPVg/zwSLCNWt7rR82oEidBBZGONT2gM4+uwBUFHsEkQA3SYKDF4FB/JOlPNCy3OOfOfBi0IhqGookoDdS2fHFNMTWxZxYmSW0GBkacFi3rzwGZebvjHNPwGFaPj2DP/mSQnbtoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTLE/0MLw4Q8J3csVwFsLvIKENlATjBCT7pGgZkDO88=;
 b=fuyyeKMlvKWIlJ9riU/WMIvuB8NKIwrSTlhtxrqANDTopIxHSDUN6oWKF4L+XLvZ7GmfY3f/q3xM0pUsRuxYpQy5ewBgqkBgwzshzIHiK8SIvU0DQvFOKqwCWjbL9ulX2CkGTEKU7a0C6T47puU8x+uhwKeeGngEp7Nq5HMsufkKurBjs0O3G2NhSL3j/pO2sYaaRT0UzqhpY2qC6GtBgYjAinAfHRRNRKbHfSkB306fohJteJZdpMXiKs0o1AGqZZ7NeNMLoGhGqHYtUwmfwtp18loSpxqHJcvPbwwKWAW2SgjhXcOPQG7szDOX1ii3tyRKbteAN1wU01d1XIuKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTLE/0MLw4Q8J3csVwFsLvIKENlATjBCT7pGgZkDO88=;
 b=Xdav4ZLXodwSduNWzv4Epb6gDFtxMCwc2aWhAprjTSzi9vifbuCJrVGZ+WhBPXkzPIsT6PMpNpGdPdzjt/AfKn41GEL92OdBlA0EDgtqhbD/b5N2iXMjOrEW3+CkkERIex7JbPA3b2Wc/HiFpz48XuhHViZLLq0AK7ORAb1bjSb8UsmCSOeuqnvWCjIHVkMp2YlNZadVgurWuZzhnC4g1Uu5z8MW0G5U2EDIj2+m5bIK2TMwfg76UiByMjtZb+AEFXnUH93SQw/8RR/hUI66x6ruzEjBHI41Dz4MAepf4Sw2OWv34p2pQLolZtLmapG0oEr2Qk+d6y9kUcHO1yNZYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com (2603:1096:101:83::14)
 by JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 01:32:21 +0000
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916]) by SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916%3]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 01:32:21 +0000
From: Foryun Ma <foryun.ma@jaguarmicro.com>
To: dave.jiang@intel.com,
	dave@stgolabs.net
Cc: linux-cxl@vger.kernel.org,
	rrichter@amd.com,
	foryun.ma@jaguarmicro.com,
	angus.chen@jaguarmicro.com
Subject: [PATCH] cxl/core/pci: Move reading of control register to immediately before usage
Date: Thu, 30 May 2024 09:32:16 +0800
Message-Id: <20240530013216.491-1-foryun.ma@jaguarmicro.com>
X-Mailer: git-send-email 2.40.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::8) To SEYPR06MB5256.apcprd06.prod.outlook.com
 (2603:1096:101:83::14)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5256:EE_|JH0PR06MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b47819e-70b4-412a-716d-08dc80485996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXuUvH0w8nvoaBC6j5BOdwoA18YLqdRHWrpJVD5wRX3L4pbMDKIWxBo3Ryed?=
 =?us-ascii?Q?AGsiT1SNaMNFP3mphpLA0Y8PTytjOgNbg150wLZ+bOayaQB2qncj0KDRzQTF?=
 =?us-ascii?Q?5IVPkoJBaNY+kVDOFOAfHfHgp44lL14GbRClfPi81pUUKFGFj0StjDQJQu7J?=
 =?us-ascii?Q?iAwUkErCICBHoLy5s5l4wM0OgvtLNZ7uTdr90mJHm28pPscKaMOaYqm/TtJQ?=
 =?us-ascii?Q?p8oiGmvtXOL08jon5EBHkkwb1b7dNPbLp0SOGJ2MiMwXmajCO+uktiOcov1j?=
 =?us-ascii?Q?ANMnLMf7oKbAUgZ/tF/0eJRG5fzyZmRKtr0rhoa0bRNYfaUZjUfuD5jCR36T?=
 =?us-ascii?Q?keVKMoBYnNxpvq9Vi17ggi7l0tN/GuzC6nTT6C/auqojAeOPWD17lGeHyFwr?=
 =?us-ascii?Q?ZgE80lU6bmQ6tFHEgy9M/Qlsmp3C/GlGJIJodcdqCWD69uBDNaG9DfOZ2+KC?=
 =?us-ascii?Q?qCfMdB0yDKwT6vn/Ktj4AZA1PJ2hxosX+rcjwBxRWYDBrkujxK85o80Gm6wg?=
 =?us-ascii?Q?kgjg4Xi4+vehRjKFNalflPvHcsuUUCuH4MLE7pQx6+c6lYev9veZqXGLALmM?=
 =?us-ascii?Q?CGeYfXn0d3jXscnqcDNo9kXt5J2u4hqWIgt1FcL7fhjjzdz2eIqtWPztafyk?=
 =?us-ascii?Q?Ng3YRIoeZYQVovT0G1vND5SzgBm6ftc2D+NUa6gFofmdY5vB5T7W+tUhH2Jp?=
 =?us-ascii?Q?Hb6IBUEqEfYoJS4Cf8GDnR0vswkJ1QQf6LTY67RuhdSBRF9d96HsgBV4ayzt?=
 =?us-ascii?Q?vKwbyWwTM7pw+6KugX48MVm6RPgstDCi5cwitHVG6jMI7wiUyd1EZqIDck1P?=
 =?us-ascii?Q?LbTLF95JZaQhsDeOo4ZdrvZBLpWfi3LH3YL9G0d46hvSx9r29jVVcOPisGLp?=
 =?us-ascii?Q?bgTPq7CyWaVBYRz3Wk5K8b7HTg14RcyVbVrqpLUN0tCfoQH5hD80ToYDLK3x?=
 =?us-ascii?Q?+ohdm0DQp+fQ2QoRjGzsCjnc9bjJF+SnfSc44PDbl6IMuTY3nnVTmxPPMvPE?=
 =?us-ascii?Q?/G66Y2eWiUW3FoBS3Ze5Jwwp/JGZga8uHki6FgpOVBtnnxhreJfEjR3Dhlyk?=
 =?us-ascii?Q?SbHZBF3CdOgb4Pb5YcHSg+ItY8EUkpEwuNWLil+/vjrrWLZnriMfmjsSf+Cp?=
 =?us-ascii?Q?fBr3vRxyvd2bsazPcFTPqul/05FMLl2PDZRT4KJHYQXBjmVI5d0aunHh+SYI?=
 =?us-ascii?Q?tNNJG5EKWcVzDkZQ+f8RQjsXuUdlV27JX+iVaBqH0inkiKaCYdOKw/8BkKOe?=
 =?us-ascii?Q?gjinVrDOvKLuPQOlMVOXawsIV4VM9NpTfevWn43+CABGQmygUX4lC8m4gCSL?=
 =?us-ascii?Q?MuLRontnLQyBfAZedtnXGhjcsxiA346VMgTUJygtOvBgvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5256.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aE13EWjJ1KVry2QO2ald92aG8QEvnMXICG6k+Y3wNgOqbCFg4J9wYBtw0lyH?=
 =?us-ascii?Q?EBDetFHlEHFeqCvfvWhuNOUD3yeovvf6IeSP2vnXsXDZCzGgElCagXecll1h?=
 =?us-ascii?Q?GLqjqvN/Ar2nucO1L9kllBlWfX7TPApVvKGezIowGbn60pObM3p2C5FvbWcs?=
 =?us-ascii?Q?NX5S5A2MOfZSOv7wvgsAydaJAnaRTXWMCIHlot2kFJ/TOkiC+VqOwpHPcjBG?=
 =?us-ascii?Q?gXocTgbFftxECd5cfKVlKVuQ4j3Mo6r8g4T4vqGl1VyKgS+FrSoX0bW/Hwc7?=
 =?us-ascii?Q?CbMXqie15p505BhDgHsz84ve8D6bpwHq2GCzzhKRISHo5Gcg0I6+ZHsFyeeG?=
 =?us-ascii?Q?GwLcU2ZfPk4ZtT7hnB8jLp1XRfTgPDifHKcrHac56Lu7434Ae2M0H3DmovcF?=
 =?us-ascii?Q?BVFJIFGumFKzwn7k38HZ6vRpoyE/LP9cVEa5tuz0ul5gGYIwXJlyLelmojUU?=
 =?us-ascii?Q?8AV7yd8vcok1rkUZhgtmZVOAzd1iCsDqT4x5jcBBbi/9R5i6ktbd1uPUW8kq?=
 =?us-ascii?Q?kTK989s/U19tyYFIt+8lAuK9JHUAlH4ikkNbtSUQqR5vzQMoPPBeButShzzV?=
 =?us-ascii?Q?7lCDWULeDT8yIJzIyMO9zVMCrkyBqEqYvOpeOzBzkGCvXW7xl9sAhhZQ0YKv?=
 =?us-ascii?Q?+zGNFEryJ96nilvBrtLcxsfCghZdLAIpRttcEXOgDAHjWNBQVKnGPXU+IOG3?=
 =?us-ascii?Q?tCoGFAOA5WfAkl/D1hUuCpUH8MIRjAlXG/tQrMt213k1PdJG1Cu2QsUxJXRt?=
 =?us-ascii?Q?SZx1bK/xi6uYIvqRh8jzpimeSv2+/PSLLZDKL7AUTmHm9994jMbMd4tppQWk?=
 =?us-ascii?Q?qkp5K8B/ynsavPbiJ/3/npWtcnjGXcIn5xupqtaCWat3wUXlnvqkYUz7Bozt?=
 =?us-ascii?Q?zTeqo6Bl0h0cbfOZq/hqBe+DBHkkazJEudvhKNnYaUM6TZ5srtoTTiM0bAN2?=
 =?us-ascii?Q?N+UvCILapXn0DDovL7+DAfR5oMMdl4/93jq8XRosjkfwfi3oHlCztgmgzujd?=
 =?us-ascii?Q?yNY1jWNj8uqtjzcChOwSokqGgFXAqEqikIcl22e6Jc9ERiXF2oyi6LoHqqUo?=
 =?us-ascii?Q?p+eJ6kECe/LLH8x2M9X9HOLHzEDYPjZVVMrlrEfGeunB1Ow3bjkaARyhAPs9?=
 =?us-ascii?Q?kkCXQUghxKVYXDq0eBS0mYFg15OkyrNxIHjbZMrGq6DheVF5tEFg2DV8vQcO?=
 =?us-ascii?Q?CET+lK7JDLDXrGiN9PgrqenCVI3EOAjc8oWkB92HtwI+M1NjfS83lEo2ag//?=
 =?us-ascii?Q?t/qB7Oi2v2cy1PLVamOXJcJ+ybkv3FtBnTsrrummGw+IOAnTIL1vb4xvARTN?=
 =?us-ascii?Q?da2dZ9UFbTLPWamqyCvGhfYU+ibHWkXybwmIfOkMzlZ1aAyaLHvIAfnhqRuX?=
 =?us-ascii?Q?Gk32tlLw71IUXK9/qP2wg3nZWZ0bc9/SFp51sF24Z8SAKyaoZoVW1tz8/xmz?=
 =?us-ascii?Q?cLUEA/R5P83CKbVbSRVyuPDDwXFJtFXgURhGyfnQSxImxI766NKF5gzXxNP1?=
 =?us-ascii?Q?CmwCQ1jtRINbMXf3JF/o1myaowyeeiN3+p7tsumN134pghww+LDBuDfw3CR8?=
 =?us-ascii?Q?uorUPEy8AFddUiOSilqOqHGtnznNbX/CUNrUT1eYGirtaMmoUHVpI6xOXUg+?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b47819e-70b4-412a-716d-08dc80485996
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5256.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 01:32:21.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CI4sJb6H8ewE++Lcxz7rOFLAetJ5JaeNV87OI8Y1+M4M2JYObAfxCpaa8MRf+XdxFnQSlnzlMxXHj8g2DNNj3xnFJc8Wq4iLYzF7D7PrCAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6849

Relocate the reading of the DVSEC control register to immediately
before usage and avoid unnecessary PCI config access from the read
if DVSEC capability check, hdm_count check, or device validity check
results in failure.

Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>
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

