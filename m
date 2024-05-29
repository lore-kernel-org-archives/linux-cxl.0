Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27D175B1
	for <linux-cxl@vger.kernel.org>; Wed, 29 May 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975292; cv=fail; b=jPqHHISR6nPlNghovH/D2OYT+DZDg7oCQNTYspAPlJboyvNh7g94I4Ca+tzXMnVh1hPINi2grKhw/pYKsxxD/4Pl/4trBRR2yqxPzEhjCvHg+OaAyjI1k7OYCXa7dGNU1cHlCiaZyCHTUThNB9n4FP34AoJK3j7NIBSyX/OM3KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975292; c=relaxed/simple;
	bh=0e+fmVZaxfPLZWOYg115CipW5EIaZozyLP/cxR/dHCs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Xh7Bo3mFaDcpqJzzEIkSvD0r/CnBvZEK+L97SebOBczYxRcCrdtOTXR2lUbpg1Al4BL+WWNRB1zsWtcCh4IniX+yFbD+VRHu6zFWRq5uqqVrT3zVAMQyOI2rgY/t1LCInDFj6o1szYrMyIwxiY3CIqcPNnFGiat/Ky0T+vpVhP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=XT3vBXkZ; arc=fail smtp.client-ip=40.107.215.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="XT3vBXkZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6PWX0vv15IpsnD4hcmOejAwT5eRYp+DAVop+34zp7NczvuM6QCCEZhJDFuPl495LlQJXV0hJVVcv+wCNEET905eWc3yL94NceZy7oY6tTaWXNaYqwp6uIZ8tAgtsccPU7mVXGBGHEYJt6cjmKegHLlsM5yGfOsH29lQC1rJeuBrYu2GacpaiZZnMVu7XXIZYY12hAl91hz0nEImAgQ8C6G18lY8vzl02QGzEHC98kcI9nn2LT5k8n7k9KYpzrG9KWnJk065gZJ/ZYkjpEy63qJMv6E63ezUnTKibTS+ITWn4pscoguTlVjOlttS6zRIEeqruwlSQyAJxFjIDLU51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIAjF0jbVHSk2+kNQesJxhziO+RuAyiMdaHkS8BolpM=;
 b=eJleM/10vbA7dqCFKwmBLblrfS8jojwhg3F88xIltr8LyZd/RtT7/wI2qqRp+MoGO7AJPcwd5wQiDD0YyY/EuxmArSBuUOw6lfwSvMZPHZO7xorvPjRD11HqhBm3jbtTK8WmNpFoL1+y/NE01dHS6U/jFJqPPTMjXDEVGfEvTpUL0bYou+nAe6cFzhU9ZhBU/r53GJlgwbYj6vPe/cRfwPwPH4lSLEml1bPqvqk/w4BNJVdGOQOHR5DFiljLOW++F0sCep88ghiZMOyGbZr2KrucyH4gmoQPXFX/cWNxx1eothLBHtxK+1VrNXrM73jkSCZTX+wwa9owj+Yljytz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIAjF0jbVHSk2+kNQesJxhziO+RuAyiMdaHkS8BolpM=;
 b=XT3vBXkZOBMKUS0RKfGkIjHi0crPTtf6R1vyox6LgIdTsYKRorfUni5SdNC+omATAvgIwyO+VtTYBdib4qB7NX1S/awUoBx6g+/qmJ2MDlPOtzrpPY1BCbfREXOUjQPsxNT9i//4z4rtbrE4aMJjd7UEftFYc81V7FHaMxHBkp6jj8f0q3b3+1PxRfHO8GF6cXBXAEqzD7yTqSl0tV0L7XK7mO0DbU/r/pSiTybAXPkzX4mh9Xyw+R7n+XbSStid1UybEUx/3SN1h6V62zo2/DcS2qAypSpQG/GI7ywkYxR1ukbtu1x/zMozVcF8G9WpmVrOeORE4wcyGvwfQpU4iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com (2603:1096:101:83::14)
 by TYSPR06MB6526.apcprd06.prod.outlook.com (2603:1096:400:481::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 09:34:43 +0000
Received: from SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916]) by SEYPR06MB5256.apcprd06.prod.outlook.com
 ([fe80::ea7:4953:3160:4916%3]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 09:34:43 +0000
From: Foryun Ma <foryun.ma@jaguarmicro.com>
To: dave.jiang@intel.com,
	dave@stgolabs.net
Cc: linux-cxl@vger.kernel.org,
	rrichter@amd.com,
	foryun.ma@jaguarmicro.com,
	angus.chen@jaguarmicro.com
Subject: [PATCH] cxl/pci: the ctrl register should be read when it is being used
Date: Wed, 29 May 2024 17:33:54 +0800
Message-Id: <20240529093354.409-1-foryun.ma@jaguarmicro.com>
X-Mailer: git-send-email 2.40.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To SEYPR06MB5256.apcprd06.prod.outlook.com
 (2603:1096:101:83::14)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5256:EE_|TYSPR06MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 345b9a36-5c42-4a7a-dd11-08dc7fc29221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c6n/j5wj86UxAMsEwqCC5oAQCix8Avbff5YZiq+N5nUyHZHshItS6Rq9SaYS?=
 =?us-ascii?Q?sPCSrXdXLGv/I8NrV0I5TZ9sQFxiEy3UmBXdPcApyA86mqVLTK1Iy0sgLQWm?=
 =?us-ascii?Q?kgB3QfcvrNzt98OqL2P9jeYbGYTB5XO6NaIyIl1Akf8/8LzLAV0GRGgD3c09?=
 =?us-ascii?Q?nEbwFUNFGp9r07yuXuSdVKq77qXlHV6mCswpfEG2fnHy25HAe8dtP6mFw6fy?=
 =?us-ascii?Q?nBw/XSf5IMemHuyftt0XcNfmi0sBikENvpTzMifODPGV8fmiCHDdLRS81IfE?=
 =?us-ascii?Q?dtMDkKs39I9fiMN9SjMyEtCDjvzLrjm5mkTQ2ZhM2rIfJi+iitD0IeZo+TwD?=
 =?us-ascii?Q?2/EQgTF284cqmwUjfkFFcg+s8npaYUTXF62tJciaKHYAr4knSAmWRUPvKUWK?=
 =?us-ascii?Q?W3GmpvvIhJVF4K5F5bT/PrANB76P6lXbeR6nTE5eRAX/w1fsmv3AmTvJiOfn?=
 =?us-ascii?Q?JDfPGDx7uRLc3zvBmZZDUY3c5gKoA/6Fsjiri2d167zyTmGpGZ7ZdbEw0f2d?=
 =?us-ascii?Q?rUUyskfOTpkOaYCxdKeaApPJJV5ISEqcFWpQUytRTARN2MMK8wnCxdDV56Cx?=
 =?us-ascii?Q?780CdMz2obhx936RRJ5TS/3zcw/R2RRrit0sfUTDt3H8mzuwmahjWVDb9bSs?=
 =?us-ascii?Q?xT0gDhyB+nLtmOvPACHN/0kdSgQHPee/D4rFhyCmVPhUm7nua6zvQSYZdXvZ?=
 =?us-ascii?Q?pq2DnIsAC5mvPAGOvwyHW7H/dxzKhWPRr9BiuQ8PqJpPa7Fv1NBIlaPrNtK1?=
 =?us-ascii?Q?AMmQdfLKPKoTZjIjDjLUB+7j7x5DzTcC9++P89VcG+syWegVVRGcAm7IAeS8?=
 =?us-ascii?Q?AT52snT+8V2cw+S8S8vJKAWKG6pZrtKcw9NwAAZjc6nDbhniKJD7946k1XZv?=
 =?us-ascii?Q?HxsS5dHIxCpwfS3mDt3UziN2tHdu4MXbkEnwDo0Dv/GxdyfqGJ7vBpW6wbA4?=
 =?us-ascii?Q?0tOLxBDdtbTmcBWo2Ke6AlnL/8FbqRkx2SlfitZ4hRE3vpW6b55i/baIZmn3?=
 =?us-ascii?Q?5bv5i9xoT+bCA1y96fJwOLkZ1Cr3wH/zjbHqg9gCo1FjKWaR4WZqtCa8w6qe?=
 =?us-ascii?Q?D9UTWpEA460I3IXMdKudmRbNT4aZeJSo47atOOJaOCJcapvhSFD7hRYvD7BQ?=
 =?us-ascii?Q?NonPfTS7IOzmKHbGCb/hDabotLFcswwDTXnDDNKN/hEa/uqSoIQXqmDMXAnG?=
 =?us-ascii?Q?LdfFgBUKIMVq8nosUlxI2cH2kx5BqVjlokfAXD/NKXiUVtztLaLVXzkvnV/b?=
 =?us-ascii?Q?Z+uoJJxo9fuxOxR8bPo48rzW8DunU2lxKrnx29XgMX038aDtVcdX2KSTm41S?=
 =?us-ascii?Q?Qqy+JfvqaEZsDJ9DVhUwfS3E59vRL9Gp1jUVu+4DYaC1Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5256.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ORw9tvF3L43Gpb7AdBa5kRKaw/2SaLbCjd5VQj2fsEFwBJxQU6G/19hPkfOD?=
 =?us-ascii?Q?ktCvVF8CJxXmAdV3ouC0NzCGPqO8VzyYN9ZTHSewdBO/ReihkPs2kIN2+SeC?=
 =?us-ascii?Q?BuMNmyCZB1b+ytod9I++cCDBmzDOIY+F5d2B6s7DirgOG95JcNCCDs8XfgM6?=
 =?us-ascii?Q?YcXmg055pxyHN0t5QjjfQCaDW/fkbTyip85v4ihxJasgo9Fxxk7muBDt00VZ?=
 =?us-ascii?Q?buM+nPtA1UkcfoSb38g/cmPg8G5QJVKQJri6IrTics15Yvc2QMtk4T2ZfIU9?=
 =?us-ascii?Q?w5gg01cZK96MD/RRMIlJeehHmYbaeVmgxfvflnbOB7gL77dgHgzk/RPxKJKp?=
 =?us-ascii?Q?teuIhUjGAyRftU8AHzeelFWU56kxC/9z2hRsP2nOQVD176lKZEKxy0xmAsKm?=
 =?us-ascii?Q?YljJ4KxE40RDAGR9OFvWonZH9Z1EB4bRATY3YUX3OzqtbgrGIosPDoOpZ0iQ?=
 =?us-ascii?Q?bnxCVNfsGcoCt9yoG0Oe7MSnrZZk/S5mLjGLTDryJzVEq4W0sR7Znokqppge?=
 =?us-ascii?Q?Qf4jwlLqoJXIeFT/n7zXIsSTGsat+2GRdUnvYy/eplIyNH7lVZFNl8MjM0sV?=
 =?us-ascii?Q?Yq76pEoGstrlLkNsLDmcK19VRSDZ20yOqwiFw86mmLI9TjwOTSGkKVAcqeIh?=
 =?us-ascii?Q?vDZ4BkwtvvmfgONINlt/98JcNaA5Y/+yLC3Wtr6dOZo000qcNqjSxOsQkuDE?=
 =?us-ascii?Q?mocEVRnTDWWKuV5Z3BmkcrwxaP6njHrsKaRcaAqloEQR9AVPdh/AQHbUVvx8?=
 =?us-ascii?Q?KJBO6sRH6gsAAAH0OqviBaJgLnlbC0+ylecsH7XJVAi8HZwKTBwpVfi90cp6?=
 =?us-ascii?Q?7mEoBqhS87MLmb+gGaZbPDfK7Qq7ePEAhQA9gXoDxxE1qfs7K4zBFkvUaSja?=
 =?us-ascii?Q?SZ9uw2rs0806ner3o3kjZUDjHrzUcnh0WHLNxSooIysXNabZCrtu+XcazVjA?=
 =?us-ascii?Q?4uP3sCSrgadI/BHK+h3v/Un30ZyVG2h0BsVr5/UCiMpc67kEcX4Sb10bxw4A?=
 =?us-ascii?Q?Lx0FFjb6wp3DxZzqAfzunxtCeKiRUmtpH0pwIBq6a/xzUVYVH8sxGqnE7OMb?=
 =?us-ascii?Q?UUeL4G3XsWFD3Yzy3f3Q62fnE4rJYAsa/VRBY1lJb/qQO7PqXw0nn/L/preh?=
 =?us-ascii?Q?rA0QyFVyxVJyRmze+kobRhR6jW5LkTNoyUwUnSpz01OzQL6p6rypTNFcfzR0?=
 =?us-ascii?Q?gpUjcWwpurub5zKcMDhC4fNYqY9Zf0ssVfemoDZXGpcEXNJmw24vDaR5H7Hv?=
 =?us-ascii?Q?hXYIlS+jANzXZJF/Rr+69O0/QGL9qV8Ir4GMeAKnGCHOtoIns6IQdMkASjdD?=
 =?us-ascii?Q?NliJ1kq2+5pF3ttADkY2hPO2T4xmiupQkoBMMuvZNUBlMQEiauD+z6cOSWYJ?=
 =?us-ascii?Q?Rqxlk4pimPYrgNfxyLZHpij4+3qF+NwxbFZI2U3bM05t8foXqkSAcFHfhotL?=
 =?us-ascii?Q?wAg1oG0NS465UTKTN5538O65y/fnYJiwOicpXXAp3LmikgugvInuvybMPbKY?=
 =?us-ascii?Q?qstXFX6DgKP4YdgXQMFuYb3IFljNikS+8YcSFl2iE5j41JyB+OxXH4EY5f4d?=
 =?us-ascii?Q?xK2wMnnqBMGWwSGs2ELidA65taMxeMe6AK6HPm4kOnjYaa3bGtc4bVU6pgJO?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345b9a36-5c42-4a7a-dd11-08dc7fc29221
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5256.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 09:34:43.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09WkJSWKJ7qDSLqN2zEJSJJckgmnjPbdNl289YYO5XVgXBXt7mtDG8kR7PVx+QNI+AdoPC5aAgdg0LiuGF0iWT8DzPtPZTPsmijvIPrFb5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6526

When the cap register and wait_for_valid checks fail, the ctrl register
read will be redundant.

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

