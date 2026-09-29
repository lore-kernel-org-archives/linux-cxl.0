Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586023D47B8;
	Tue, 29 Sep 2026 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647464; cv=fail; b=QxUkN3a2MIKcwlcO+VzadIODGNmh2oYezNs1E5R9+tMTMNE696JxQTJxNjimfs4syRyPZp91OCIu5eMjOR1jj4xu/cqjdu7DvOK4EcTagzbrPAp5zxoTgyX7aY+34+fOq7TP1Wuj/rOdPWdYnZTi1bzuotgMLcuWtF4HJNrPgW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647464; c=relaxed/simple;
	bh=nXzqf1cCT/Kdq827Ed/djMT3Hj2hNs/OzsuYBhGYIzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVyvIO5Rw+8Qk84E60AyL/qX+G31oAu4pP5n9//ngtP3xJjE7wp1o0We+adxyvYMBlsA1b/PIBrz+dd9t45Oluw6cOzBJRZlui1EpufqFiRUCprtehVqrSGEBPqzwlXFDgz7QxZoppi+RR5XZxvtjHQPuBgMfE6/RmR3Lg6q8Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snKJvvc8; arc=fail smtp.client-ip=40.107.200.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snKJvvc8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufe37/Iyx8v9Pul3Mew/0AlPxKw84yApfYQFxdn2HEa84ZkMCOkG4VuSmfLg2vjDWtDX5ouBBMgvDsc8+TLuWzxNlD4CKSZ68VobaFtJTwmyNsCSMc+014fD83y9EuSnR4DHB0axaA1Ydxh7XzSn3DTQe9gYtrhsputOhWZMDJurIkmFLcTXydSq1AlRwMfyeZcctKEl7na+ztzWJZNpa53bwY2AWw1y0mY5MOvYeUqcDDxN2xD5HqQLFSo5Kz1bFHmg1wULOXMA1G26kQL9ROGhI6PRK/VWPmrnLAyq4LhEc7TELnb2WdzYvojGZO00feneYxoey3+p3aoTCPfMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6w0yG12IljnodwlKqFLqGt/42S0I0GRQT9BXk71n5U=;
 b=FvEwK3gLBLXqsTHkmxKgBnhi8sv1pkxSNx9V0Oa/bVCNUiAY4/X4kQMwZAh8Ho4toG/Ns4sVq9eRf46izJT8OaHB1zr7iuDzVF8yYiDDI2Aj11UKIDTc9G0Zo1GvY8LF5NQbbA8gX0uH18s7cZDfz9CN1v0rTs+DDROkDE6zsHdAvDAtR+YiYvLe5km15UMqSTpEmZeB+IL6n7Q1hTOAe7mYXSc0MQOx5HQDv1Y/0nhui7W7OYfmHeb5DEaI4A4WC15NOS93dYBw/iE1h1quSjHlvaulNbjGp+K5gK8J731psrDOkxu+IkZOUh2Cgo1p9fwpMi+aa+kpxVDUrhF2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6w0yG12IljnodwlKqFLqGt/42S0I0GRQT9BXk71n5U=;
 b=snKJvvc8h08PVzxEyM9YBKCuWoSTf9YoD00NQ2pU1bQk/ITqkE+k0owxzJntgTXMQa3YskZ9Jcg71CkDKSAtLAVZMvZpdEmyqGP5VxFIMHs8fzZrwVJIRoiE915QdXbyPE7Rji0/4XtPY52ByOZhASIoBMWVFL4+XM3IcguHPFyyjMzRUhec/2olu8m8wuU1RgYMSRBe56NeB9Zi6BB2hsr1dXjrPTNdV+06ddw8oozI5woLBEnlm7EeodpQC6gsxN+ekLV6o9KA1Blr4QMq5UFKABT/nT1PdNbAQ3x3tt/dm6AeY7oJMmzOUZBhAtff7kUj9CDzFsIK1W66P/8EcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 02:04:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 02:04:19 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org
Cc: ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 1/4] PCI: Reject all-ones responses in pci_dev_wait()
Date: Tue, 29 Sep 2026 10:04:02 +0800
Message-ID: <20260929020405.9724-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929020405.9724-1-icheng@nvidia.com>
References: <20260929020405.9724-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0003.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::9)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aebd45-26d0-4565-d4f5-08df1dcdf8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IFVd52c2r9OajzMlLBSfkILXmp0MRUlffPeAbDR5OScTPk5ynkadcIcgkqf5OM+LiBKsHS3GYdszs5INBhINrcKBxn3ILVyGN1B3uoeARD5wuaRk63VBGFMzpw9QP0T2pRQbscjlcghbjc4EujPZVlpikwaZyullROSuTLawJe+sUqLMticLMmfGfSavCWtfaKORKZe7zPBrUg2utp9BxV5u7n+JRpv6s4C7kaZ/yuDsjma4TzmAT4x402Y6tYhvRO75t3o3fuemrmdW0bYWv7JyPX3RoumcMtE8Xhzb5EibxMXXHN81IeqwC4veZu2MgRQSjds/cihGt4uvEKSvELwFuZ5E2HtpoFX5z2RiJYaqe91pN2VJVSL63h4MVBoYLwxJsxdxswy413s+CmW+6xT9OoLJSK0S05zH9oanYzMvkYV/zBTeVH8gE5cknrZPR+CtB1MEOMTQL+sagsCD/nUE1bY7fCSUhenlSpP4AnrM8uJ6z8EO7f0pS8530DfqdJi4gKIpYvQqrQJERw+xK2ixn2MLYm+3yOoIGekJXYYBgFeMb6qMq+uSD1RiNWhkjUQHHP9XHSRyOdU7cQo+Nt3v1/7rFOoEkXQbsrrcnEzKfjFVEs0T1J7QN2XKEZ0zFAvWhtVOGPB35AtajDKfcrVHRKa8YD5apy9RCz4OyMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ey9Vvu5KcKqmDhEQkfFUYCxwNAfIz8+QQbzh2/fF8z25UAGypMQLNCwjw+6V?=
 =?us-ascii?Q?P7MsCKbl7uq8Actb2+7ZoPkscsCAOnvyB8aVNBL/V+9Ogbl9NqUQle2SF3SQ?=
 =?us-ascii?Q?oqVne9KR7jjdl63SzKZ3ggXSW+aqANnjsDOqUqyS0r6AAhj5y/qRUKMLG99t?=
 =?us-ascii?Q?wNg/MjKtGfVQz9ronMxMID6jqo04I594VULu1rCyDmPurPrFrlejG8/OgmE+?=
 =?us-ascii?Q?7Ve/zkeiOMjmLsmvVibof+qXna7pQl8UkZFHGtrtkPXeeCzlgjVQLzHh7zIY?=
 =?us-ascii?Q?JyqDVFMszZK+QzEOSJ4W9UIcsmAEuPoSLHYecwlwcpp/iJP7Ty60eY/dS4NO?=
 =?us-ascii?Q?cJ5L9P1B+uz1Cprk/dJs7K/2KMFfYXfl+EF8nVVArLXbYUy66wK1Cv26+neK?=
 =?us-ascii?Q?CX0V0ZlbH1sFAFnJHpDqD8RVoAz/FyasNilJnlWFbCSPfUcOyH1svyAjd2+C?=
 =?us-ascii?Q?ZV9dcwiIVNkcq4EhISGl+bjVQk/zOiYM9yX5zMZozuK4ADip4oSx4QRMSKwE?=
 =?us-ascii?Q?1OEwwSQ3eYKFvLoo6QclKF+opU6/68H2JAjJi0ZpjUFWM1sITZv+NkGiWdMT?=
 =?us-ascii?Q?QAZbCXcKgyn7OAVpZg9R/Xgb01U+lMIxZ2mjKIlnTIeupZIPFqMy4t3hdBV2?=
 =?us-ascii?Q?AHqohMd8DUyvZxtXfp2GqWmcChGgulNc4834wMWAEDSU4YUi+M+rwsLtN27Y?=
 =?us-ascii?Q?1f0QVThBPOS+iMq/wM75iiHZdpYELSiyT1BJboTigoVjqW4eq60jRKwL5znk?=
 =?us-ascii?Q?iyJ5Bn9L6lrHzUwIQ58oGDbjtk/UIevLCa6XHbznNj+G7Ugm8ZEPGHqOZTyn?=
 =?us-ascii?Q?ED6IGO39ynHxvdUMIjfrVcMP64O4Z9c200jCj+rfcx/VzlW8G5d1mXpexw+Y?=
 =?us-ascii?Q?I0lu9Z9W5giYc2CMrzSDRILFxsCE0VRjsAne518ezIGHM7NkeimLKQb6U6bX?=
 =?us-ascii?Q?yYXi6agOLOADg5/SbSLNDogbIol1lERX67DO/doqnZ6ZDDN4yknZL+vhc8UC?=
 =?us-ascii?Q?gVFTaBw96pglr7Nk+OHi2/rg+StoAK4WOlxZ0Taw9QnQOOkj27hlkNtMsUk4?=
 =?us-ascii?Q?42Rq6P0HscrtjMIqWBM7Rdlv5kYUM/d/EL+l2466Kyw0DyCUG52i23aI686D?=
 =?us-ascii?Q?E6FYuOMMzobp/39hL6w3hyw7lYqFHQPUh/S67A1JrJaKxBTbLna95foZvCVn?=
 =?us-ascii?Q?O3mbZI+auUM0JLTvogzgA+a87SxlEIeExQUMp8PR38g07JHB/gBvr6IlEFX8?=
 =?us-ascii?Q?VW9afj/OEV0QscjxKEOWKU4OEEdC6fcUH2YzZyz/r3DwOST7QXH3Lf1m/n6Q?=
 =?us-ascii?Q?s1HJtrbqYr4b5Vh+V/1FmeAc8m3bzn6nk7R6EhImJE54h3/EjFISd/HYDGm5?=
 =?us-ascii?Q?4kuY/sO4AHuA9Qh0mB/aLhdKVdvp7avDTztdK1MsWll61CtBSpXpdp/ZI/Tw?=
 =?us-ascii?Q?7WYL61s4HA+mIV/6hhD7/i6kJJuLwjCgmK49keOvnfHK/C+nsdZMnGDKaQwx?=
 =?us-ascii?Q?hiqRktCH3JEkCaZKIWSrVWaM4Y4yR77L/yKtbxMH+GZrR2JO048Gv5+f/npF?=
 =?us-ascii?Q?AZBM5Mc+oYEuohBN9xcrB6Sex+7OxAcHyVYk1RxeCNVZCkHlN+CZs4XQREmL?=
 =?us-ascii?Q?inaepCDIdW+GIl11XaD8xdaxslUUkOkBSkTtPreh0ykVm/LS3dIHfES3gdOO?=
 =?us-ascii?Q?84TNlrJ6zCuhj6XpUVSPNsUeGGOSyBGvrQ4k/2LeMuR3MW4LR2qMn+LBQWFg?=
 =?us-ascii?Q?e1JtOLcvzQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aebd45-26d0-4565-d4f5-08df1dcdf8b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:04:19.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdws0b1pcjdY+b8bSR/iKdjsj2/7eBsB2Jy1SI+ApiCNWe+OhDg3Tj+IuVoWzSb8cxohQlIV8dji3FfxmxH84g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

With RRS software visibility enabled, pci_dev_wait() treats an all-ones
Vendor ID response as reset completion, even though the device is
inaccessible.

Reject all-ones responses and continue polling. Use the existing
Command-register check for VFs, whose Vendor ID can legitimately read as
all ones.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/pci/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..6461274bdbcf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1248,10 +1248,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * If the device is below a Root Port with Configuration RRS
 	 * Software Visibility enabled, reading the Vendor ID returns a
 	 * special data value if the device responded with RRS.  Read the
-	 * Vendor ID until we get non-RRS status.
+	 * Vendor ID until we get neither RRS nor an error response.
 	 *
-	 * If there's no Root Port or Configuration RRS Software Visibility
-	 * is not enabled, the device may still respond with RRS, but
+	 * For VFs, or if there's no Root Port or Configuration RRS Software
+	 * Visibility is not enabled, the device may still respond with RRS, but
 	 * hardware may retry the config request.  If no retries receive
 	 * Successful Completion, hardware generally synthesizes ~0
 	 * (PCI_ERROR_RESPONSE) data to complete the read.  Reading Vendor
@@ -1266,9 +1266,9 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 			return -ENOTTY;
 		}
 
-		if (root && root->config_rrs_sv) {
+		if (root && root->config_rrs_sv && !dev->is_virtfn) {
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id))
+			if (!PCI_POSSIBLE_ERROR(id) && !pci_bus_rrs_vendor_id(id))
 				break;
 		} else {
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
-- 
2.43.0

