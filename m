Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7321322F;
	Mon, 28 Apr 2025 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876636; cv=fail; b=FvZN/M1ag21om+r+R4scXRV3XNejcd3gI9325XTyNI8gDv6SDv13JhOq0wvMRdruAXHJnZzzUW7Xun+I0NdUzG/jL7OxkG/5gbdKF/6R76Pn3Os9gJNAlX2Igy0QkuFPVaTOeiSfKISxTaNa6gwtNkrcFx94Qs11JLOLZFsrAZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876636; c=relaxed/simple;
	bh=dA76GPQkGL5gtp+aLxEFSZNABClO5UBqLBuzgC9utOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XV8oGkGIaksqbr0+KArLyfCeIcuDteceTRI1U/Mw3aWlVA5jRtmcyfswxt6Fq9uS34GuZtlm9/x1ojGY8B1Fe2RKJXza44RsWIfV4rXhGMNEWq9UP0VOIKikXo6Ht73HouIxu30MIeqKKrIqOgd2DIG5lBPYBUXUSS/kPJl9WYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rBOdA0oq; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rBOdA0oq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VH/K/zMBQppyqSmRk+ZRiJ6HhYU5e/9XlY8S/FrMlM38Z5PbTYb4yb1CpaJYVJYo+TUShtHAx0aUjWeK3yVmW7VoYqjBrgWRD5htHe0hFFdpunjUx4kto1OF5EYKytE2iM2aMFClkKm7YkbYW5Y72whOAx8NA+6kILwd63wGmeV5bRnDYqvOm1EWlXiGy7G9bYR3KPWzTOBJEh7gsTqMOBqZudY+NPKiy5uq0/p0NNWcNDZ1j8psJiS0QvO/8wM/NhTO8nqG3DOdeqMGaqyiSdF8pPbhyYjl7Z71seqNSZ0Q2yPrJ69IzAcjIG4Dk4vDMc5qKF/l961srqtMaRr13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAPrJ/XOJ497G4afTNY9T856wLA7xIIWtTRO9/CiB+4=;
 b=SNx4h/yJ3s+WYyD79XtJ6rsAJS4ktKwIAOpvXD1FsdTT0fDcCu0zZHb7TkMkaWFEvnBkP+bOAuOxx81TwiaqjVneJizHg3tq77MNVP4Dc3KO163kTR9kwZ4iMVhrPDIEMy/0dO02NLF7Lxmb2ggRum08CScS3J/QrYXfPPDlKreWXfJjyXPzWfQu4tw2hn/ZgicdFZC0yk3N63YjST3HHz+uwcKdIzv5g95eSWmGhyEwr7XYtD1QGMm8hiYpwO8o9PinixxJuEHeYz3pEEG7M7KcJ/Ui68jxhhzwcxNKSkOllx4NpXAzB8RtiyDSynABLeDUBYjexfwqSJRoQCxnkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAPrJ/XOJ497G4afTNY9T856wLA7xIIWtTRO9/CiB+4=;
 b=rBOdA0oqSMK0gkm4kMfy8lMLUG/lToOOPt6sKMUgzirXEeUhgbS55GRkgtBJJ3UFr5yWy6gWwgkrlQyC009jUn8Wg/+6mX+YcW2NvxN2rIqMyn4UGoTQ8CUrCqP0zetjCM3+WGh5tUeDACuJpR3a4PRnenY/qpgIf5b0UWR1Y2Q=
Received: from SJ0PR03CA0160.namprd03.prod.outlook.com (2603:10b6:a03:338::15)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 21:43:51 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::33) by SJ0PR03CA0160.outlook.office365.com
 (2603:10b6:a03:338::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 28 Apr 2025 21:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:43:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:43:46 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 04/14] cxl: Introduce parent_port_of() helper
Date: Mon, 28 Apr 2025 23:43:07 +0200
Message-ID: <20250428214318.1682212-5-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 2160e3e1-00a4-4b7c-6917-08dd869dc3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCiRy+u+vN0elDdiO15OozdRVC8u0z0FLxK8YL2gXobob7FwFgyba9YtVA2E?=
 =?us-ascii?Q?8ZXcSZVqaqMJUfNVbYsDeIXLA9r+yp5HPqEp1gXXURKibP5LbVGPhCNhAyJM?=
 =?us-ascii?Q?o8ZGvEvx/D90ya8YH5l1E68Inqj0kyJpeKfln6J5u22HyXH+RaSA1LPhfUXl?=
 =?us-ascii?Q?GD6srH7T13zQi6ebXfxceRgE7eSkyHJiapB3WW0oXFEG3PfdxtWQpqJ41S0+?=
 =?us-ascii?Q?3E0CKttcIDnlncwiSAtn031zlTqd6kFstQ78wOmpYosH0hgkl4l+VCTthnkO?=
 =?us-ascii?Q?2KkIZ9+azpxJ5D2XWctYb2qoq/OX6ZoYwGfnZbMead4ouuB1uKa7URsA7WhN?=
 =?us-ascii?Q?ZDIOXowzWLkcdy0ne6EwvNghBukH+onkZILkxGAI1hhrQxtCPnEra9bvgEec?=
 =?us-ascii?Q?kBHBdG8Y9tOf1Rlrw6I/PpB64hHEhxqvtJRnD6dMlsCec9kn7VzyCZ3ehHsp?=
 =?us-ascii?Q?cXc6iv+dPkbl38kQLrcRDC468zWxfKUXSdH8ZwurIPeP3raafzU+AjbLIxNS?=
 =?us-ascii?Q?K1iNwmRr447sxuNGr+BSRFfYQxjlHEKgAn0M5wQ+9pym42FOP7w8qDUwbfME?=
 =?us-ascii?Q?uixsbKpMp9oKfQVtxTyLjOU9ZfrmzI8KYR50tHb7yJdYGIn4jTC4AjTsCmPP?=
 =?us-ascii?Q?Een9iRDRmfrKD/vOEhk1JtM4c9XIYr+s7Lpi0FicWJQIc56FVvKc9sVyIIR3?=
 =?us-ascii?Q?JP4aOpT7UmRd2I1lB7CV9JVaFH56R0sYCacZ5MGLel+VqvO5wmSG4IbPyODz?=
 =?us-ascii?Q?Hm2kLCBXSCpWesrqUCJZMw7jKxAHngh45yKVB87bBc4CJ8hJ6W0DjufkqSRA?=
 =?us-ascii?Q?jLIO6ICIfUHPbPv+D3BRgoq/Sp7gRLxVXEjWPuI/WQMQf3cPr30pSjRQBquz?=
 =?us-ascii?Q?VZNnx4q4VjM7ZDrzxFLvxswveuEQj+O+NkMoxY0aygoqqpX5i7+cURgZ/LCo?=
 =?us-ascii?Q?hsHfR3CyFMqH747Dezr550WpL5rbkLzu7MrFcquv76l5Ocir1uWMnXx0hVnD?=
 =?us-ascii?Q?CTB1rG9LhAIFUV7APHNSt8+cE000JKVMEbh1DlwQz9oj4JK5lgW9xwbdvkUe?=
 =?us-ascii?Q?PMUml8CUxYz5OGNZJKtC2NJrs2l+M4MyyvLXA19n3rbFB5CgpCkaerV2ux8a?=
 =?us-ascii?Q?iYYt7c+reI79vfgvPFt+5qvwmk6iO3X99x7QrneK9qWa2r41uQvE14Y+jYyM?=
 =?us-ascii?Q?TEE2gIkzErScsEXHQpQF6WEZxPbAJJ9vuw36DKN9e7jP8k0haZb2nqfEU6kS?=
 =?us-ascii?Q?s+CWn9pqLnjSht1SMR/suE6mnemkHoOu3O9Ifi0j4mxI6XUE0ZvEqSWO/2l0?=
 =?us-ascii?Q?JS+mSYxaZmKwfO20FjaDq45pRZiVyf12RV4KQ0xi8guWS20+2VhWEA1DnP4p?=
 =?us-ascii?Q?PGcyVSLshmkkcvMggTAy2DCo3dN13clxfG8lzPgbjXOZOqEn3Pg12vbfEh0f?=
 =?us-ascii?Q?TBo3PwMT0cl4GJCiu0+7D1KnaKRT+H/UQGKwxIcWTZHLHF1tT0ZhVlogoXge?=
 =?us-ascii?Q?diKeNKDfhZAkgt8g9Qm2AJ5RcIZxUcDxUaq5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:43:50.5748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2160e3e1-00a4-4b7c-6917-08dd869dc3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523

Often a parent port must be determined. Introduce the parent_port_of()
helper function to avoid open coding of determination of a parent
port.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c   | 14 ++++++++------
 drivers/cxl/core/region.c | 11 ++---------
 drivers/cxl/cxl.h         |  1 +
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fd6646c1a2e..c9087515d743 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -602,17 +602,19 @@ struct cxl_port *to_cxl_port(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_port, "CXL");
 
+struct cxl_port *parent_port_of(struct cxl_port *port)
+{
+	if (!port || !port->parent_dport)
+		return NULL;
+	return port->parent_dport->port;
+}
+
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_port *parent;
+	struct cxl_port *parent = parent_port_of(port);
 	struct device *lock_dev;
 
-	if (is_cxl_root(port))
-		parent = NULL;
-	else
-		parent = to_cxl_port(port->dev.parent);
-
 	/*
 	 * CXL root port's and the first level of ports are unregistered
 	 * under the platform firmware device lock, all other ports are
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6bbe04a532e2..e35209168c9c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1748,13 +1748,6 @@ static int cmp_interleave_pos(const void *a, const void *b)
 	return cxled_a->pos - cxled_b->pos;
 }
 
-static struct cxl_port *next_port(struct cxl_port *port)
-{
-	if (!port->parent_dport)
-		return NULL;
-	return port->parent_dport->port;
-}
-
 static int match_switch_decoder_by_range(struct device *dev,
 					 const void *data)
 {
@@ -1781,7 +1774,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	struct device *dev;
 	int rc = -ENXIO;
 
-	parent = next_port(port);
+	parent = parent_port_of(port);
 	if (!parent)
 		return rc;
 
@@ -1861,7 +1854,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
 	 */
 
 	/* Iterate from endpoint to root_port refining the position */
-	for (iter = port; iter; iter = next_port(iter)) {
+	for (iter = port; iter; iter = parent_port_of(iter)) {
 		if (is_cxl_root(iter))
 			break;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..24cec16d02a6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -724,6 +724,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+struct cxl_port *parent_port_of(struct cxl_port *port);
 void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
-- 
2.39.5

