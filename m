Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBC33F6
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717471334; cv=fail; b=dT2HyZI3sdJWaUaUzNbH5XaEKHCdRX7jc9RhcCXvfUFm8WFQB+WTyvx03kKxAfaAL4Ztx4bH26GrlIUmarJmKvTtWQRbJ3iIKElZGVOVxKytI4SMnm5RYUnoR524JnqyProPitmopH4DyEnRPClVybU3wuC76qG2RnIhGyBsqKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717471334; c=relaxed/simple;
	bh=JJdpZnkQwmMqgfjcZBa2SeiMA3kkLB9RoVT3ExNgypk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i8FqB84JZWorKX6G+JICvVwoR3JqeLfvS5A25SkBr+y6D9HyBEylMx+npw02iBFB3xrP0eLARjCTOdI1Ds/CmFar5T140qBrPT78VoydKoXJ4q7WFbCE0zpFp11/IQA/hEZKtXMAUepyyjxqjooClsQzGDeZKfbpxPS4uNUsxGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=AuCAdOK1; arc=fail smtp.client-ip=40.107.117.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="AuCAdOK1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEMoFWw/32sNU99JXg10cE8XpMLddApf4GjO+0ZvDZjyuusrQnSDKsYsFvzfAW5ssSf1pz8TwR0bq7rWMHPB8rS/16HLQzMNn3GohbsFcJEeDpWNfYI1g02uMpe3Ejgxdx/VpQqjEbR30kZHlQF1C+AKbD0e4P4Wcsw1rRN7LKOA6eHhIvkc5WvWmtgpZDDmLoUob/BzcPT4nj0q7blrNi8DEObQ2ydMyQoxEVzWBggkddEvyWiAW7F+ahYoAVPTAy4l+6ZbnntE4Av4jGBkR8XhndUozlne9gX/GRDMiIFtVkpjhXlh0VrvFPrx77f6jMRHtNb+VtKaOa1GaVcd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUXvXaFWjhhXre86HZMjj6346v0eVy2kwNu6q+/H8xE=;
 b=kGAUJZ08bAfV9UG9643PJj7V8V6JpRDpExoJBOI1cleyZyLfZyDl13StGB6VaRuC4irP3UqOG3COst2JeJbAosqmyvRdwwOa7Nbygh8E8eYyAlK8Bl1cS2ew/t0Hwb43hweoPnKZR6Cc3FAaCeLWWYtYrUTWvc/VuRlwBlxX3f/2v0m0dFnZ1zwQOiT38qdPPeVv5Xh56CI2SlM4rFrVJnvAUR0MhFJ8F5ULEEULtg8fRTZalRQz7pUp/bFIQsf6fctJn0nBLmbeIssRcO+1zSOK/Zow0xRiKac+e/XTc7K0QcwdssxeVOtPKK+UUb0nybWlXEOfpscqGvs9c/YU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUXvXaFWjhhXre86HZMjj6346v0eVy2kwNu6q+/H8xE=;
 b=AuCAdOK18/U8glL5obyVUIrR2VuLwzKMkgXiNOW/gZubh7w8GLIJSWI0icsx6HX7KBgIuUpJqUrCIcAznUUbDXANrbrRs8hNzy3787NTNowqt+fmFMO/FUiz8IJxK1WBi8/AZMjdrMU5sgw3qjXE+J9rKrYdRJbwaLo/DElU+ydkEe1BXP7SiHRo5ni6YZe5+PnPnykqxfoH1BaHln/67+A3HPgGei7JTK1Hyo0xAwbpf9cpHIxm8Fsqh6UeYBDTFAtgaeC3qKA/4hWYeF41NyeN+iwn0eZYPjEkmM9QylT6pfRSvRxLoLs+ohlERxlOEdQsnK3hzMi7nF2tmGqqmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com (2603:1096:101:83::14)
 by SEYPR06MB6036.apcprd06.prod.outlook.com (2603:1096:101:da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 03:22:03 +0000
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916]) by SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:22:03 +0000
From: Foryun Ma <foryun.ma@jaguarmicro.com>
To: alison.schofield@intel.com
Cc: dan.j.williams@intel.com,
	angus.chen@jaguarmicro.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	foryun.ma@jaguarmicro.com,
	linux-cxl@vger.kernel.org,
	rrichter@amd.com
Subject: [PATCH v3] cxl/core/pci: Move reading of control register to immediately before usage
Date: Tue,  4 Jun 2024 11:21:51 +0800
Message-Id: <20240604032151.655-1-foryun.ma@jaguarmicro.com>
X-Mailer: git-send-email 2.40.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To SEYPR06MB5256.apcprd06.prod.outlook.com
 (2603:1096:101:83::14)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5256:EE_|SEYPR06MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: fa603d0c-eeb1-4b7e-e28b-08dc844580f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZou93PaIbPmxEt3SkvVP54aLMCTc7XDfzYZaBeYy9TDBO50pHKdVSYXe6CM?=
 =?us-ascii?Q?j3A992TNNR7QJK8hZvBbQlUJ7MrC2MTzu634u4H6pBsNBVw1aBvW5Yp+n3uD?=
 =?us-ascii?Q?fhncf6KyxVTD3kTCCxRq/zkQxkfvuLchaOySc8BkN0CotZ8hvmWa31L94CF2?=
 =?us-ascii?Q?1po8gHyQeF0NuUP7cAEH2+NXcG9ajbQDOT+V5zEffn2vJRESjJI4Qj2ztNi/?=
 =?us-ascii?Q?dLX3LMJIm2XOanqpbmvdtKj+7wMKXInRvsx+p//fivGimTdG/fpYo/Q/B7ea?=
 =?us-ascii?Q?yI0DI2HTG99tv88MruOQ2nGDa3bbVVT4Kd1FFLWA9OIvR37KK2FjEoZlY2zB?=
 =?us-ascii?Q?OLli+/Yljnq4jjvh8CIA2d1NiSqWcup/UkMbyz0RF8bveUn1IbkaL/8y5oD3?=
 =?us-ascii?Q?282y323PykvKhivpWlXDzAcgGsXCjE+oOu7Q/CO3VaBypH1wEpmC4LLQfXSd?=
 =?us-ascii?Q?Gnb6/vNDFlkGtqcRzUx1DQzYipYsvnHE6X8lJugRSA7abZWXYiQX6yoB90RP?=
 =?us-ascii?Q?WBDIhdOez03KLB84uqcdbIjzcEWKRyjtc/tZi4XFWIbr5ZkXst8Orf1imA37?=
 =?us-ascii?Q?5VH7rViwx9916eGqvmZyF3HvOGdDGtIBfpZYHn0F7ASYY4vzcSC6F375eGc2?=
 =?us-ascii?Q?b5pp+BMPCVw947ZF/gxo50dUSXQdWDlqpIMxEzABcv2cv6d8US5f28nTG5sz?=
 =?us-ascii?Q?lA7JzLMhYMa9u5qv/8jh6Dflp1jD3u/5wigg6782ASQfwGmaVa6hDeB4NJ8D?=
 =?us-ascii?Q?WPtrICOMOqPRU9i8pB6oGzyr5AoF9P8h/X49ZbKrxB3nvoKdi2K9V8e22qXY?=
 =?us-ascii?Q?VhbMOsrjlDQU+RzrlSoB+Per3ydDQyj7kulBOaaA3+qRxjZHmoSpPBZ/r1we?=
 =?us-ascii?Q?Bf3Wdwos7JGJn09gb3Bsg892mhQo/VjACqOVAUTQf7uHPfsSxiwSUueQ/KSZ?=
 =?us-ascii?Q?q1+LtUegRJ1C/OpMUDdu8qBzaHLxMYHBI0hnskfEDhNUBSrQOmCYOaHM7tFt?=
 =?us-ascii?Q?CN65wzIUiIptMYm1mfPEjg4HGN9NBUhZ3nHQ7C/oGG6UY658CLBzIu7hr7Ha?=
 =?us-ascii?Q?VC1TsSfaeHEn2iGYxnouywCrhivIkJwZ7CcX86LVBBfM7FAwimF4GM2EgW8n?=
 =?us-ascii?Q?P9YZMxIzO7xzfzQN1VVV1aaQNL/NYSGhZwds4F99Ef3Kx1u1I1vGzTaZef57?=
 =?us-ascii?Q?iJNj5KZYYlgNjYWtndQ9FVe4za5kwC97wap2ib24EfgpWQUWSGCgd4J7+C9s?=
 =?us-ascii?Q?IF6R4fDztpU1sriFOsNMocjllNZy2vQn4NoC01yhQZq/NEkoeHaFDlMtaHBq?=
 =?us-ascii?Q?t9gvA6KeE5YoP4kvtNs9VgVjev29nPDmRDf244PgQgcqtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5256.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+NPnTHc7g60KoTON6RX3LtlcL7HVpaI2jCmE1nVV6r96aGDrIeE4xr5k6xAr?=
 =?us-ascii?Q?5QU0iT14BPpJf5V61jrwzpbFZFRoUUhxaM6GjyEeyGL9ZLgBHt/XM7w7LZyW?=
 =?us-ascii?Q?7Qi/LS4T6dz1gka+WDp+pIocVIOYZkk2ejkKAuG3z65K04BBVcbeW5e3yvu+?=
 =?us-ascii?Q?JG0iKRr4NGU8Yk7u7zqthySSgDQMFYMW/B0ajWuAJjYey7nNCW24Q8TxOqBD?=
 =?us-ascii?Q?ljK+veLpCw/xHcBl2O7HfA6ox2vZLwSYmQKrbx3BRycU9kejQrmGrNK8wQOO?=
 =?us-ascii?Q?6xT0TPfuZGicg4nwQ7ktadAr+MEMoQ9JL+v6SpSsunmfCmq/sFS5yyyUB7bU?=
 =?us-ascii?Q?HXV6y5vMqW9D++x8WR86Nt4RthLCnRmeSM/gAVIpHJQJ+sRUnna7JHoI5j96?=
 =?us-ascii?Q?N69v483RR4ejkF0Wfmhp3KClgHW6P1Jy46TiLPn5zZtLml0ROD41QxWcY9He?=
 =?us-ascii?Q?YCkv46hvCzR3RKblqX9P9ExMdk4/s+0Uztg9UzjPzrVKqfYtLbzRpA0iEqkF?=
 =?us-ascii?Q?R2bt3x5Q3PRbpc4HVhQg+oyaTGZ9ICP78zytuFzhprjgUdsBfhJ6jdTWVMm0?=
 =?us-ascii?Q?9FWN1Xqoi+RoR2U6gYy/iHbdO8pwW07KMC/ozVivMtCDlELvmZ9k+FKNiTYf?=
 =?us-ascii?Q?ENSwwAFcuXmodZk+/Jql6izTE7mJN9+JIWSyOMCKewDt8VrxLmY0rdMYn4cn?=
 =?us-ascii?Q?UuKYXt79Kv3qS7F+aSgzEiFmOEwgWlS3JmsHg1tIjIEL69cJWcNvZQ7+OKtY?=
 =?us-ascii?Q?fmMFnDYn+/IZ9ccH/GwatxZ5xHtp+zbaHBAmB/r8WXo0zQY6ZqmONhHpVpza?=
 =?us-ascii?Q?fLdTpt6e/QP6u3nUN07sEfuJhDbq/cI60Aq4Nx8GvBFz10aMpUzmqKs3kz5M?=
 =?us-ascii?Q?0ZfwaUaT+YXE72E3SpPKj+VD0HvRrsepM5dE8wgjo6wku/2YDbXM4TSB0lOm?=
 =?us-ascii?Q?pviAL4p6SudrNCMeZOrIqUNQKuJTUHRf+b2D45KL7iuu4y/1PAF4FrA6LVkX?=
 =?us-ascii?Q?Zpm99WsRS9FgyUNGLTeSqn5H4+SC3GLAyrYcZ6dbY6Lu86Rg9HJuNf34WtlI?=
 =?us-ascii?Q?OgW0BSb3tc+9DORDoB2qsad4sbExB+qBHOiiraSixRf6rOtxsgPJMyFoUZI3?=
 =?us-ascii?Q?eBC+gSTOu1UiHXfHgJL06MCbWRDfl1DVXRFH+cuE9QYD9E5JqJfau+2wnrcs?=
 =?us-ascii?Q?SA7bzUxZlKs2R7ECXBBYU5TuiKkq/ZYLwOFmQ363SrBxS18N9wXwkNP1gg4y?=
 =?us-ascii?Q?abrH9b7Yeqp26+UMqmKpwIBpe0jwHVk0N+BFNWAcPlxOLFEwI7T3re5TCRHL?=
 =?us-ascii?Q?laJMKsEfILJ7o4DtWFqIA9BfTS9IC1OA8/7RgBY1K4FYULnnTsu0KizHtPuC?=
 =?us-ascii?Q?IV/C+4CHvaV+W60An1ihdLl+f7e+cZmz+PvzPFW3NG75c+Lr3FH6WknbGKk2?=
 =?us-ascii?Q?lf/N83UZ4mK9msAhIKkiuhkwjoVhzNOTCcFaHDRsQpOsX2uCDiNvQO7IsTTd?=
 =?us-ascii?Q?dC4JtwYzBNBgLSmKh2Wx6X5CeqCbmWzdibYpe1Y//JwSKPMoAmPY7+uBIgn5?=
 =?us-ascii?Q?5Ri0+qIEFIRLyHsEz82+fzDwsarVN5KqxfR4ftPjPWJpv+HXlNp/W5F1e4pm?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa603d0c-eeb1-4b7e-e28b-08dc844580f4
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5256.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 03:22:03.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBW4Flhiw2dcQSWxPe+S+Aoz24xkLf4aH9TveIecIq+NJ+HhJA/BqgVE6h1K9HWGd/HF4j6+mpAkgWuA2f5wy7J3cPnq0rhZBpaZMykk7ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6036

Relocate the reading of the DVSEC control register to immediately
before usage and avoid unnecessary PCI config access from the read
if DVSEC capability check, hdm_count check, or device validity check
results in failure.

Signed-off-by: Foryun Ma <foryun.ma@jaguarmicro.com>

---
V2->V3: move the check to after the comment
V1->V2: change the subject and commit log, suggested by dave.jiang
	and add change log, suggested by Alison Schofield
---
 drivers/cxl/core/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8567dd11eaac..a663e7566c48 100644
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
@@ -368,6 +364,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 	 * disabled, and they will remain moot after the HDM Decoder
 	 * capability is enabled.
 	 */
+	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
+	if (rc)
+		return rc;
+
 	info->mem_enabled = FIELD_GET(CXL_DVSEC_MEM_ENABLE, ctrl);
 	if (!info->mem_enabled)
 		return 0;
-- 
2.34.1

