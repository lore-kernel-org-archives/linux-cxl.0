Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023063009E5;
	Tue,  9 Dec 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303713; cv=fail; b=TQNHqBxXbyR7HVoDlyTTxkFWfalYRpaEmnhMZmqiErDPFObzte19bKhtDjHGqia4DOOvhSX8MT3Qj5vD0CM+NdHi3WZGHHhQDCxuOxzpycZjo6+xFB7P66zXLQAFE8uJHILophHJD35IT3amrlb7tsbWomXdNA7tEHaeJCIxgz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303713; c=relaxed/simple;
	bh=W1lp4KEKjJWaOnq4ALWV7KUlE9PWCQmRsmfIx9PBwYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lvbj0C4SJ9KkbzsiodyZ6hVmlZTQVvxwYQIyX5x2+iD1hOUP0YBI4GpDTYncdggPR1LC4dTL6+hzNjQLQ7YGDYNT+o+b7hx8lWYMnNXvDUp50uObbrzfHjBJRaPG6FVsf7YP+HjTmr9Cr2+2jIakBcfLtZ9T16tPsHYpo7MaDbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c8Apo8EW; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c8Apo8EW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw5JftQsjkiosNwUdTPYUkBR9DhxPHeAxTdzRO6OOcLSILDMR6NHqgJ3qysSULzpKGTEpYPIPojGTIZAd+yN4JMEOOILbt2LSulKSK63leFl4zlXv/t3uE9dtieQTDcsPuEaHn+wm4qbyaKUznoA2a4HLmOVw8emN9OMj67WHCndV1jIfHTN5PQ4WTc12rp7FKramVrrej+x00tkLi9k8mXJIjg4A0MiOhF/VhuIGv8XSRrnX7Vnynvz5VytVOI7tLO5XqKbnGD9yCR+SnPp1rVuCzc0Oqb7QqoK19KsOMkv54A6RvjVNRiCPXI8zoMym1x6uJP8TYDvojw1kMjSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKZR/vY3KHIhytQDoBbhdY6LMlP8Z1RGBMs2A7YxGRY=;
 b=A8lLPZXhBMFRGagY0SpZNOw0YHRXE5etqNXIc4nzDkIn1sOyApe1IwA4PM1NJWTpi3Vm3+6uqH6SmiPQscUUzVdb3afe4tZ2JHii2m1NmbvcQD/RSN91hzWa/z7fkjytpwOECagnMnRxDtNvZMdtllhBJuORae/PG94h8enRdNQFJczonauwuT9Ymhq5K8eP3i9+rFGtpe2osOEiRqSHDKVd94B2eShqx2Td2izHjXpHU7zEw0bY0pLK5E9n2WIDg7j5e4Y9qrBbePp6TK1+UyEY6o9z0cceeW3USvrd8NilZIxKhctwhPbtbBtpU2XahIIWhbDpEAj2AIgz+QT7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKZR/vY3KHIhytQDoBbhdY6LMlP8Z1RGBMs2A7YxGRY=;
 b=c8Apo8EWxUhRsk1w1/P3HeNYhfW0URwGQJlMl4o4j45rbHjvcV5kTIX8+KEaICfw8+3kpdaH/8VBFIJSpYu7ovrRI+xtL6ubvjxfFL1ZbmEZI1Jh+18ZNp38PNJXNFJ18t7RzbyihEv0WYbBsJe/dTnpBvrI85e4tb47pGN5neA=
Received: from SJ0PR13CA0063.namprd13.prod.outlook.com (2603:10b6:a03:2c4::8)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Tue, 9 Dec 2025 18:08:27 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::3c) by SJ0PR13CA0063.outlook.office365.com
 (2603:10b6:a03:2c4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:27 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:24 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 08/13] cxl: Introduce callback for HPA address ranges translation
Date: Tue, 9 Dec 2025 19:06:44 +0100
Message-ID: <20251209180659.208842-9-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 941406db-9206-4b54-b83c-08de374df39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3pWTzRjUjUrM0N2NW03QnA4bkdDNE1ham1reGJNTjNnVTlEV2c5aGZKbTdB?=
 =?utf-8?B?aXlkYXRVY0xMS1VwRVdQbS9UOUJtNVhTM1NNV0xIcjBUa2dwVW9oemphQ3B3?=
 =?utf-8?B?L1IzUFRBVVRrV3RrTTV0WTk0S1NDc0l3V0pDVnZ5UG5HZEtTUWpzTTVlSTNn?=
 =?utf-8?B?RlBMeW93eEthMXduQy8vYTdoRkdQZ1A2Q0dva0VVOUdqYTFHbHpYYXVFYkxQ?=
 =?utf-8?B?YU55aDRnbWVkTVdRQXRzZW5yRm41WlZ1VjVMbVZQd3Z5Q3dxQ2RJVXFka3U5?=
 =?utf-8?B?cUZCVjhGOGJYcXZyek9KaDVGT05KeVBBcG16cXFDa3RuSjk5QXIyQmJXODc2?=
 =?utf-8?B?TzJUeEhITGc2Q1ZBSkdlNzV5eU9IZktrbVBNcWpJTmtGMmpPdTJPeC9FdHNZ?=
 =?utf-8?B?ajJoU1Ayb1o0NkhRSk1NWVpNd1Nxbzc3YzJxWDdOaXRuMXFEcUVYUklnSXR6?=
 =?utf-8?B?cTdjS0ZIUklpTWppN04rVExOVSt0M21UNHV3TDZ4eHVjcVBMME1NR0w2dTF6?=
 =?utf-8?B?RE12U2MzR0F5ZTMzWVk5WCtnbU9aVElsWExVaHRETlJUWm5PcmJzYnRTVXk4?=
 =?utf-8?B?VXBZM25PVS9ZVG5CL2RlSWphR1ZyZW5xKzBmSnJwMnpCZjFNNDJSZU13bitr?=
 =?utf-8?B?Q204K1E5ZjVrTFZ2RENicWd3bmpob3h3bHNDUU5uWnJtK3VrcEpESzFVaE5k?=
 =?utf-8?B?aW1KbTJpNTg3WnRibnVJa2V3bC9KdXpWUHp1UGEvMVJ5MkUrLzBZN1p2dzRw?=
 =?utf-8?B?Tkx5bHFUVVFjdVNBUEEzNU9mVXA4TDBBYXpLSlN1Y2JHT29ZNHpSUWxEZlRF?=
 =?utf-8?B?aXlITUJYWGltTFZ6SXV2Zm05eGI5ZmV3eUdLWEdsSzRSN3JrcW41NFliWUl2?=
 =?utf-8?B?Z2NkSFZJUjZyaVZIMFJYcHp2S0tQTzVOR2JFUHlDL0h3TWxzVmQvMWQzRjFY?=
 =?utf-8?B?KyttRmlnVWVWWUt6dzRJbzhzcjIvbEs2SGczeVJ4S1hac3k1R3VxV01KMXRZ?=
 =?utf-8?B?NHU5bVR5anpWN1Y2bHh5dVdSQVZKcVRlUGZMUnNoMnA2cDlMWWZFdUZrNVVz?=
 =?utf-8?B?Sis1ZEYyMlZMUUpFSlg4bDlsWGxVSVNzcm5vLzQrc3hEUUkxM0VMSkJMSzIy?=
 =?utf-8?B?bzl3WEY3QkVNRlp0YVFVRHp4RWtiOE5CQStUcVZEYVJQeWdFY3BJSXJCcVlD?=
 =?utf-8?B?RGlhY0Q0SHE2Z3YzeEIrMG5RMUZOSjgxNGw5VEtoMHo2QXI4MmdYbEhwQ0pt?=
 =?utf-8?B?U0lVR3VEMHloU1NYOFp1R2FQeGowSE5qM29YL2p5cXhkbG1PcFBjY1FQanB2?=
 =?utf-8?B?SmpsUE9NbmFEWVRkbUpoRDNXN3FudEdpVVE0bjdyU21Vc3krbVVsU0M0Si9j?=
 =?utf-8?B?MCtrc2xXMVdXbE1tdFV3cXlWSDFncnNZOEx0K0l5c2hhTGI0d1VmWU5ucHNH?=
 =?utf-8?B?cE9WQi9BaW9QT3N1NTRYQ0Y5VmErRysybE84ZGpiNlN6Ty95bWxYUFRwRjZY?=
 =?utf-8?B?c0Z0bHhIZ0Qzbm4yVGNFaHBxeEFrREhLRnZveHg4eE85b0ZCdWgxbTJBOGlm?=
 =?utf-8?B?RHlIRzFJYmdESXRQT0Jidm41TUhIR2xnOFhtdmtaVndndW0rTER0dzEvdEQv?=
 =?utf-8?B?d2I5dlpja1BtYXRVNDVRT3kxNXdROSsxcjZnZWpibEdiUXVyNDJoUjB5bGc4?=
 =?utf-8?B?cUJ1SCtjQ2dnSzM5cmZGZVY1MlNpTFdlRktZSkZqRURTcHhWNitubXhrWjJ6?=
 =?utf-8?B?TWhVZkVWZDlyNHFhNFg0MlcrVi9jNkYwZlJZb3QzMEMyK3d0RGJMeitDWjc5?=
 =?utf-8?B?ZmdIelZKVGZwTVN2b2dnbGFGcHBnblRoV1VIZTNZYzFtNklhZ1diaXRJa0gv?=
 =?utf-8?B?cTdLRDRYbEVKbm55bGg4bW9JSmRGYTE2MGtTamdNdk8wMnhRMVBDMXNWWTZy?=
 =?utf-8?B?djR0YVRwTTVybUlUek54UjR2Lzg0MWxiZ3dIVllxemcrb3hVVGc5aUYrS0pH?=
 =?utf-8?B?VFpydHlCUU4zekxmNXJkUUIxMjYwSVNzYVFhWjg5VmJ2aHExRmtwNndnWWdn?=
 =?utf-8?B?ZjN5NEFQSEM1TGxSd3dsVXRLUE5LVmZHeEJyRzlHTlAvbTV1UktRUkhPNVhV?=
 =?utf-8?Q?JsLs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:27.1207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 941406db-9206-4b54-b83c-08de374df39f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135

Introduce a callback to translate an endpoint's HPA range to the
address range of the root port which is the System Physical Address
(SPA) range used by a region. The callback can be set if a platform
needs to handle address translation.

The callback is attached to the root port. An endpoint's root port can
easily be determined in the PCI hierarchy without any CXL specific
knowledge. This allows the early use of address translation for CXL
enumeration. Address translation is esp. needed for the detection of
the root decoders. Thus, the callback is embedded in struct
cxl_root_ops instead of struct cxl_rd_ops.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 24 ++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e4efb281def4..c7ac78f1b644 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3480,6 +3480,15 @@ static int match_root_decoder(struct device *dev, const void *data)
 	return range_contains(r1, r2);
 }
 
+static int cxl_root_setup_translation(struct cxl_root *cxl_root,
+				      struct cxl_region_context *ctx)
+{
+	if (!cxl_root->ops.translation_setup_root)
+		return 0;
+
+	return cxl_root->ops.translation_setup_root(cxl_root, ctx);
+}
+
 /*
  * Note, when finished with the device, drop the reference with
  * put_device() or use the put_cxl_root_decoder helper.
@@ -3492,6 +3501,21 @@ get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct device *cxlrd_dev;
+	int rc;
+
+	/*
+	 * Adjust the endpoint's HPA range and interleaving
+	 * configuration to the root decoder’s memory space before
+	 * setting up the root decoder.
+	 */
+	rc = cxl_root_setup_translation(cxl_root, ctx);
+	if (rc) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s Failed to setup translation for address range %#llx:%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			ctx->hpa_range.start, ctx->hpa_range.end);
+		return ERR_PTR(rc);
+	}
 
 	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
 				      match_root_decoder);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0e15dc6e169f..8ea334d81edf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -652,6 +652,7 @@ struct cxl_root_ops {
 	int (*qos_class)(struct cxl_root *cxl_root,
 			 struct access_coordinate *coord, int entries,
 			 int *qos_class);
+	int (*translation_setup_root)(struct cxl_root *cxl_root, void *data);
 };
 
 /**
-- 
2.47.3

