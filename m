Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72E1F8679;
	Tue,  7 Jan 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259107; cv=fail; b=DUjH9sLWOnYu+mTvG8kDDW3XkyVlYyoQK9dqdjnjZRxINbI/YW1JXJa6oGa0ny5vpuOmEyXbkh+rRIc/NSZ146//kW/uvApXbONkEQLO6ysPwSsGPUZhEhlSGEqDCDmGh5pfbyeee+YOilNcus82niX8q3DYJ++yuw8xz+t41Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259107; c=relaxed/simple;
	bh=oM54NXk5g+NykARbvWACRxLsWnrBJJpLfAtBItrsZ9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0dAGqRys/BFlYH40uogl+UISa6yXmoYjenSgVzMPzeKD580idSIHzUd9NbokjF6dy6TEL2unkbq1H/i3h4/mqyl3a8npK6iToS3AWOQdWfUY77pTDtjZI05UsPTY/P4pyYBpl/+Fb53M+aF/U6Wqcf1Pbqt/8ugszcvn9uY3qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GVrwzWSc; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GVrwzWSc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMU1Kw2f4mY4+L4TN986tSf+kzN+FDn6ojwUe+PXuCb5i2w7S4ZnBsks5JWIpH35pDouxq1eV4VM4Yb2MHGTglFLxk3aaH3IUyLNCvTBZJWd4eZt2H6N5zB1WO7hN8WlOT3xCg72dPsZ8ZDDhduoZdV8wWzCm0UR9VaRHLaUzviPqUezAMOY067k6wBh3/g0UIn+gMrdevqtBIwJM3+zqNVw/4Kkg4NMguIGVhIInSbMkNTEB5pBcswumzAuqKr4pY6IcEmCVuqNe38zht5g5AvbAJgzus+yChNwH4LsiMaY5uaw75gjFhwN5NU6uxaYqZ8O1ASl5ZXRo6BAj2Iegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FurV+X161dObJOCkRnyxwhHSQmGs7l1/YgFylg/ByQw=;
 b=aDv4p2GPYUdD4fghO4Uf/LNxLGckJvxpZBWf0gtKBL183GNMJ8SXaUvWaTIQYYSCYKZSoIsstftnRqUAzvIy3RoDbcNaQ51R+g/qiq4s7fXSIpoUPc4KnlOgkhL6caWBgESbUBOq1erUQsmqq9JL/X/fAFA2bNJ+W6dPbSB7t21KG1RmQHT6HOHVYDkd8TCVN43IaJOO6DfbNrXroC/fGDPLo+Z3Zty+FJHFgXY2tZ93C3zOraTeclw7ubkMMV4CU768yeHvgO/Jda928V4ebYzoSynZZcOgg3SH2LMUqUHg2uhjuf52VQp+MmExVC+KCXc5nHIqKLyO2uOsh9Ryng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FurV+X161dObJOCkRnyxwhHSQmGs7l1/YgFylg/ByQw=;
 b=GVrwzWSc8w9dNWZuMdvLFE56FY5mCD5MNUMCLYa5MvNLK+voozakFpc9oQ7oig5iiZWVNgbts6mMlAIDnoWAMXMIUUvQ1BJyyYcxlmlYNldOimhYaYVOup486LuXG4JDz80XZq3SB1AL6vZxN5QEmg0ai/8XnA+TaqkEEUsbEZQ=
Received: from SJ0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:a03:39f::15)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 14:11:36 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::19) by SJ0PR03CA0220.outlook.office365.com
 (2603:10b6:a03:39f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:36 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:33 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 15/29] cxl/region: Use an endpoint's SPA range to find a region
Date: Tue, 7 Jan 2025 15:10:01 +0100
Message-ID: <20250107141015.3367194-16-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1eab2e-6b99-4113-02b5-08dd2f25328c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzEMgdk7L62e6fIEWI2r4NYf9nmr3fWscVOTQw72socXra3/6LCjrwKemRzy?=
 =?us-ascii?Q?WkeSAXTX4pXoLsILRaptudQYdUnczeeYA3zWLM69Z/es3SR47dMhBJJEDXa8?=
 =?us-ascii?Q?le/ZslpPOSje1vspbbD+s8VPgeS5gYtDv3TqTEJbJ0WGivZvZoYxMOc0IfYG?=
 =?us-ascii?Q?HuEZdviCocd02PYRofe0dqWoIG7hXgIYPRHv0FssovfWc07BTZznoEkSbP+6?=
 =?us-ascii?Q?+a9sgZvULxdsXrFfqnaZjFcSI9f7P5Qv4Oym0TIgo4MfsISJwQz61tiPnbDF?=
 =?us-ascii?Q?y9/WAO70cYxd487UWmyzt73ELPlFvFMScUHqEF0O3jPxaTZ6dxuSF9pigu4f?=
 =?us-ascii?Q?K8Sc5t9ysLgXL8+YClDtO4XM385tb0B0rgo7tpFjl2pcfHepD0KiZDGFRowk?=
 =?us-ascii?Q?ER3ribfzyYS1PA3SltTZh3hI/6yadIs1/B33p5cg46ivt3Mzpf/2NJtnGoqZ?=
 =?us-ascii?Q?I+UHUS3OjrJ/TJmhYQBpCLU5YWoj9ONA4lxwY3hiqB9jUFwf7kJs72mHzN5U?=
 =?us-ascii?Q?8v8UgUKv5fj518fyHye6TnTq0vsgAnYLdtVh/nlZpcNr669225BHg+UxLqPP?=
 =?us-ascii?Q?KVjCSdDbQdMT2QywLw2CygF7qeT6H7XwMgkE/DTJWIOlC3zOrrizbgu+p+a2?=
 =?us-ascii?Q?gU7PIaSizWdo4pXXlYJoV+wIwH0GA1UeK9SfFPvzdl6oP8AOSjh+447gaOVB?=
 =?us-ascii?Q?2uLvIGWR9OPLNWHKA1bbtxwjrZY9QxcB3EWoM/SSgaKJXCzHgVGjUwAGilYL?=
 =?us-ascii?Q?kXkmVweDFggoU8lo/yGyRTggvu7VS+xmoYr0W5+UsToh6pa1baPFHXgDy4gL?=
 =?us-ascii?Q?vGJmNIwSLeWfkwPIaw9Ri0VM47X49MT+DzZP3em+B7qdXY+b6/dkBrRnxRY6?=
 =?us-ascii?Q?ET5f6lwrrKvJPQz7EK6ACGjhL19Fzbpk0izKTxTtFcC/9hC5Di82j6z/g2kd?=
 =?us-ascii?Q?xpnLqyvhgIFEdH5vhizPSx4MJGaCbHVo1QcMrRoylwPlAjUlfb/jGI+F4i4x?=
 =?us-ascii?Q?5/7p/OdB/+9OTQusnohhtkclFWgrCun2cUQPypMmZBza9xA1Br6mT9MI8WUO?=
 =?us-ascii?Q?HpaYXTxMDmTKglfTOQpjj0mhJP07fOnf8+9aqMHvsh6XZBpjejBxjdtkdVIY?=
 =?us-ascii?Q?6kKF03oo1dXsuf1ynEpDFF4z15AlIpXshpzpgXI/+pzxlUhkKqLw7jzlKkxK?=
 =?us-ascii?Q?PJo9hRruBAS6zEe9VlBnAU9kcIw9GZQIy13QrxNdm3GEpOUzXJKEEgkq9KzM?=
 =?us-ascii?Q?KfZkmhm0MG65bfMgt4HvSdV9+l80AIcGCmEcugDUAV7lnDT4ncHrBJ8B7fJc?=
 =?us-ascii?Q?aMomLRxiL82thaeYr70AlYb3b+8RXSAWRqw8G/pVYtM8wAJSl+Dg1FI3ZrWk?=
 =?us-ascii?Q?E37JS3GCB6gTlqcgJYx41pTURKWCQyYElpAg0pp6kYkQdYbi+kx/O4qk08zb?=
 =?us-ascii?Q?YdWzLKyq2HtiUyntw8E3DMrx19dO5ax4ewCpsfaeEAltzN5ZCbDeJb/Nlcnr?=
 =?us-ascii?Q?9dxAYThx4czllE4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:36.3247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1eab2e-6b99-4113-02b5-08dd2f25328c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027

To find the correct region and root port of an endpoint of a system
needing address translation, the endpoint's HPA range must be
translated to each of the parent port address ranges up to the root
decoder.

Calculate the SPA range using the newly introduced callback function
port->to_hpa() that translates the decoder's HPA range to its parent
port's HPA range of the next outer memory domain. Introduce the helper
function cxl_port_calc_hpa() for this to calculate address ranges
using the low-level port->to_hpa() callbacks. Determine the root port
SPA range by iterating all the ports up to the root. Store the
endpoint's SPA range and use it to find the endpoint's region.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 85 ++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 09a68e266a79..007a2016760d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -824,6 +824,41 @@ static int match_free_decoder(struct device *dev, void *data)
 	return 1;
 }
 
+static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
+			     struct range *hpa_range)
+{
+	struct range hpa = *hpa_range;
+	u64 len = range_len(&hpa);
+
+	if (!port->to_hpa)
+		return 0;
+
+	/* Translate HPA to the next upper domain. */
+	hpa.start = port->to_hpa(cxld, hpa.start);
+	hpa.end = port->to_hpa(cxld, hpa.end);
+
+	if (!hpa.start || !hpa.end ||
+	    hpa.start == ULLONG_MAX || hpa.end == ULLONG_MAX) {
+		dev_warn(&port->dev,
+			"CXL address translation: HPA range invalid: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa.start, hpa.end, hpa_range->start,
+			hpa_range->end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	if (range_len(&hpa) != len * cxld->interleave_ways) {
+		dev_warn(&port->dev,
+			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa.start, hpa.end, hpa_range->start,
+			hpa_range->end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	*hpa_range = hpa;
+
+	return 0;
+}
+
 static int match_auto_decoder(struct device *dev, void *data)
 {
 	struct cxl_region_params *p = data;
@@ -3214,26 +3249,47 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
 static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *iter = cxled_to_port(cxled);
-	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_port *parent, *iter = cxled_to_port(cxled);
+	struct range hpa = cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 
-	while (iter && !is_cxl_root(iter))
-		iter = to_cxl_port(iter->dev.parent);
-
-	if (!iter)
+	if (!iter || is_cxl_root(iter))
 		return -ENXIO;
 
-	cxld = cxl_port_find_switch_decoder(iter, hpa);
-	if (!cxld) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s no CXL window for range %#llx:%#llx\n",
-			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
-			cxld->hpa_range.start, cxld->hpa_range.end);
-		return -ENXIO;
+	while (1) {
+		parent = parent_port_of(iter);
+
+		if (is_cxl_endpoint(iter))
+			cxld = &cxled->cxld;
+		else if (!parent || parent->to_hpa)
+			cxld = cxl_port_find_switch_decoder(iter, &hpa);
+
+		if (!cxld) {
+			dev_err(cxlmd->dev.parent,
+				"%s:%s no CXL window for range %#llx:%#llx\n",
+				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+				hpa.start, hpa.end);
+			return -ENXIO;
+		}
+
+		/* No parent means the root port was found. */
+		if (!parent)
+			break;
+
+		/* Translate HPA to the next upper memory domain. */
+		if (cxl_port_calc_hpa(parent, cxld, &hpa))
+			return -ENXIO;
+
+		iter = parent;
 	}
 
+	dev_dbg(cxld->dev.parent,
+		"%s:%s: range:%#llx-%#llx\n",
+		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
+		hpa.start, hpa.end);
+
 	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
+	cxled->spa_range = hpa;
 
 	return 0;
 }
@@ -3358,7 +3414,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 static int cxl_endpoint_add(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
@@ -3370,7 +3425,7 @@ static int cxl_endpoint_add(struct cxl_endpoint_decoder *cxled)
 	 * one does the construction and the others add to that.
 	 */
 	mutex_lock(&cxlrd->range_lock);
-	cxlr = cxl_find_region_by_range(cxlrd, hpa);
+	cxlr = cxl_find_region_by_range(cxlrd, &cxled->spa_range);
 	if (!cxlr)
 		cxlr = construct_region(cxlrd, cxled);
 	mutex_unlock(&cxlrd->range_lock);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c04f66fe2a93..4ccb2b3b31c9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -419,6 +419,7 @@ struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
 	struct cxl_root_decoder *cxlrd;
 	struct resource *dpa_res;
+	struct range spa_range;
 	resource_size_t skip;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_state state;
-- 
2.39.5

