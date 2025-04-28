Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC31B3934;
	Mon, 28 Apr 2025 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876664; cv=fail; b=oIX8sz/huT3UcLvi4F+KF46BtZSJlLp4rBDwN2HO26yPkt4ntFSZfsRK0pmPY/oPrDEVbyAwRViLZin8ozQF39nmtU9Zb4jS5teo8engfrXbTZi7xtrC0g+tbiRt3/v9Om6EA2ildksANPXxbTEOA3xCDskDqhu7mW5NUg+l3Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876664; c=relaxed/simple;
	bh=MI8mwOgHxYRW3OHmTuVQwaQ2DNUc1a+skDc9b8d4dX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+ganqlGYbta3r2kbm6FhRd2eLKzkcn5MFk3Dp4r+Il88etkJl0ZpHJxL0ccSCdaobmvhR/oVbDWRs+1iO6BBm8UqABQmjpe8+x9Juq8Nyt2DRxY9lP9S9FoyUBX0yqwM0+/C1npL4jIgQPIUTNAlBZ4VqCKs8cl6u/z3jTk8Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NSbMNLdt; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSbMNLdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C32Sluy3mic5kU3C4HmVc/V/B9SE1KAZcknUIfIUAKn1jwWFNgNaxS6iIE3eij4gulEXcmDJ/sG7fk808/OLq5TKvmzKy4xE9Bg3ygMOI2oXw9SAVrWlcL4uFPC7QruHxtAMs67no/95IhwZp4eyNWRLmV+qwDnGzNMuMeoBfiysd1z1U36WxVl5b3vETIpI/sIJmoyoqKfdo6jthbi5AVhP3gAjClF6q1XCpBB7O5r0NCv0TJ2SumYRHYB4024DKyrzvvQbszd5t1nskMiZ/EWPhWGJPl5GTUrPrJJksYNzTLbMKzu7RJe6n2XE7eblpWjj+3ZkET7YjqLLFLrMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7XGyyxhtM7r/pgr7DHdDtSAOUhRElAzvOEIvHep3K8=;
 b=tIPLkJbYeikBmx+9K0oy5GlzP9wRBAB29WKpmi2tB16BEHu3KzbZrz5mtRhjkl313MvzayWG/h15KG1X1pqKpgcb6+djUOXm4E64WgWgRz6Qt16vUhPE9sw0QNte/tlBANPjs544yv5xnNXUpZI7+Ihr68TVdEl3584R9aJjtAklHDgRwbdwFQfQf1HWkdJvnuTu7HQQV4U0n2ZAO7/c5jS1TtMK856bhKhh5hBez79DYR6EJuyHPzp3gMPAOatt6jM/uYlS4DN8lpmMcqn7HRLzTkTDqxqhlDXZyfK2JBQ3muD5NJP8zTjXw2ptJdVawRuOF4udNOA9smlxCl/vLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7XGyyxhtM7r/pgr7DHdDtSAOUhRElAzvOEIvHep3K8=;
 b=NSbMNLdtzjoQXDchOq6f0cbxiAlusAParJ3puFZnsNlfckXwLncAG3Qm4Oo/Neyypcn4XqTVbjGB2QshYc7fD9eeL1aQdhmJCKNNUnkyxnytslN7vhDbrGYZtwqr63W+Xwes1zhHlgEUG9w93Ms4+E7C5xOS2+iZwIN9XEKIG9U=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:44:18 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::c5) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 21:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:44:08 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 09/14] cxl/region: Factor out code to find the root decoder
Date: Mon, 28 Apr 2025 23:43:12 +0200
Message-ID: <20250428214318.1682212-10-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 25119b82-3f25-468c-46b4-08dd869dd137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zSsLqEQ/1aykuhcV1PuVuzTHH/vecigvS0lpLXViRnJEapi+2aXy+1X7skj8?=
 =?us-ascii?Q?+Q8Ro+g19dSAcHVxTHn4DVbUXi297WTeqOep3ziCpJIYrPx7RwtY4a8ZnfoE?=
 =?us-ascii?Q?7YnKhFsL5FdR1JQLwzxmtpXjQFReJHoyBiQDTZg00L0sqPDdIpBRK5g3KKg0?=
 =?us-ascii?Q?VnJ9W3kC/vcnkZw81MJXAsWcn+NiwlR3m9aBNXzw2o1MWOnneWAqa/N0cODa?=
 =?us-ascii?Q?kCCTROQ0memLJ1Ru0eZoEQYQqWckIYKsG4NC3iNERgU37oQeP+W+1ulDTjF1?=
 =?us-ascii?Q?xaSkY6273+Rqwxs9uU34MU/F/FUzmnXBFgPBPJVrNgSLmhN6BfAhnVSOLw15?=
 =?us-ascii?Q?b9qPd5DmJULVS4kcWCgKGJf1nff8cS4KXc4kedhIKRhZZ6e4JYw9k92m3AnB?=
 =?us-ascii?Q?1uZD0cvmVKaxlDSe9FVnUSHL2fkWBJknbfxkWJqMvk9QKYOeuvT+2GSuHTbJ?=
 =?us-ascii?Q?OhjtS8dfJM5sgkyZjoooiMurF85Q9gMi6VBcIbdkSnafb5VLs8NUr7i85KTj?=
 =?us-ascii?Q?i1HK2UgDthWdAjqi3beVNq7HT1tfH7L+TcetW4hDsaVPX4ZDLvZkAO+sOO/v?=
 =?us-ascii?Q?WggI5IpYdpaMvSZv9/kB4u2reBGoGhjL2VPoZjIrpkjKPs0rqA4oM9O964Z6?=
 =?us-ascii?Q?8shUV5dTCtpSPdnn+4OiKJlAS9JxPke1MoVxwmqYKmXd7kC0xlvw9522mgQl?=
 =?us-ascii?Q?BfuC+liMyxXxWCusmSzec5WGhx0ly5Dl4Hsa+T3BhsP89qDCfqlaw1eKaG7Y?=
 =?us-ascii?Q?61RdYsL2FZo96APD5ayTNC7Tc5+QBiLLyBI91i04EC62UZrbpnMcefQl9SEc?=
 =?us-ascii?Q?9D//cOlihznPlhI1rklekNsnV42japvWJSJCbu1BzJj1dByxdAzTA+IGJy2S?=
 =?us-ascii?Q?FwUG+PcD/NhO+z5+3AqgzB1q9YApraeWSum1hJBRFzwRpYIKbaTRpCv2vmqr?=
 =?us-ascii?Q?ITCXEoFAbhdRKQ9PXtTW/+napBuotMOt9Iua7AdOC4+Pz4jB+a2Z2UEn8j5r?=
 =?us-ascii?Q?oiXacqu/GBHlDT7Zj/PKm6u1tCyiYBui+Q0Pawk/EvbHD9/UQx9O6qzmGvKL?=
 =?us-ascii?Q?imNz6hp1oJLOnaERxxyi11CU8XCU7nazls05n8Jjh7qAkUajIl2Sor4ioesI?=
 =?us-ascii?Q?YtOpmOUWOw7TWkEz4r1oO4iImjx9aC7R6eZhMc4TMNoTXtC30uXH4QoGOKK+?=
 =?us-ascii?Q?hMouWN8MnQPS/bmhPgR9zL6UwncSJJLjbshbnbfIJGJvP+aSleE2X6HsQJCN?=
 =?us-ascii?Q?daRx0aDxdJv6Ynlhj2vpUuWTnooofSweT3DJhL9DIV/VDUPEXULZvqo+BfCd?=
 =?us-ascii?Q?U5B6u6ziK7L9BEKhLeD3SrblogAV+La7bDOcIUWg9bycq7YC2XjPkPeSdRSx?=
 =?us-ascii?Q?HxRZfavn5JftRy6n9Me6kHNEIeAZLGI1r53HRh44V2krndzPbmPFMQT16Bsh?=
 =?us-ascii?Q?dCl7ODmn1DWnnRnmA4DcBQm6TG9nVOTE4iDwurmv49e4RAeyvhCVWY2l44CJ?=
 =?us-ascii?Q?rTFUkFPzic5BTWiBQdsTv9USBrYj2ucFbofq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:13.2970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25119b82-3f25-468c-46b4-08dd869dd137
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474

In function cxl_add_to_region() there is code to determine the root
decoder associated to an endpoint decoder. Factor out that code for
later reuse. This has the benefit of reducing cxl_add_to_region()'s
function complexity.

The reference count must be decremented after using the root decoder.
cxl_find_root_decoder() is paired with the put_cxl_root_decoder
cleanup helper that can be used for this.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++++----------------
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 256d4dd631c5..0128dec80274 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3219,6 +3219,29 @@ static int match_root_decoder_by_range(struct device *dev,
 	return range_contains(r1, r2);
 }
 
+static struct cxl_root_decoder *
+cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct range *hpa = &cxld->hpa_range;
+	struct device *cxlrd_dev;
+
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
+				      match_root_decoder_by_range);
+	if (!cxlrd_dev) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s no CXL window for range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
+			cxld->hpa_range.start, cxld->hpa_range.end);
+		return NULL;
+	}
+
+	return to_cxl_root_decoder(cxlrd_dev);
+}
+
 static int match_region_by_range(struct device *dev, const void *data)
 {
 	struct cxl_region_params *p;
@@ -3387,29 +3410,17 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxled_to_port(cxled);
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
+	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) = NULL;
 	struct range *hpa = &cxled->cxld.hpa_range;
-	struct cxl_decoder *cxld = &cxled->cxld;
-	struct device *cxlrd_dev, *region_dev;
-	struct cxl_root_decoder *cxlrd;
+	struct device *region_dev;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
-				      match_root_decoder_by_range);
-	if (!cxlrd_dev) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
+	cxlrd = cxl_find_root_decoder(cxled);
+	if (!cxlrd)
 		return -ENXIO;
-	}
-
-	cxlrd = to_cxl_root_decoder(cxlrd_dev);
 
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
@@ -3427,7 +3438,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	rc = PTR_ERR_OR_ZERO(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
@@ -3448,8 +3459,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	}
 
 	put_device(region_dev);
-out:
-	put_device(cxlrd_dev);
+
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ea06850ecaea..acfda0cf3f70 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -740,6 +740,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
-- 
2.39.5

