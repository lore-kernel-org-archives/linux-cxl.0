Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023839;
	b=PHGL6sfnjkhlXnNpN6K+5kkM3AHDdLiQP7Dd6RW+LEjvjOkT0qJBjTw/xi0nCZOhh4OJ
	 0KPKs/yS86ld2h7TpmQEg4lHPW0rDGuPNJPNmpAb+UjOILQxmqLIRZRiFgj74p9daz/RN
	 WpzkMl68mlzE0dXkjg9Di3GKYUg35iHyzJp9hDYomFnL1xdDNIO1P8Mf66oSxg4MtmUgN
	 3Mvuq8bLCJHEfFu9yRyh8BHDeAjlhzxeMb7rvdfgntxQradGoNxZROBKfyhB8WErMD/dQ
	 Z/IWAau29x/p8uGCgZFXBMTIUpB2uPBTAMPAP8kXkKs+JflNXSd3kOm7p0BEag0egdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023839;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=slpPZK64i1uGTDULigDtcDVEsfPad+EQPK6ts1t7FhE=;
	b=mgMRXYBEFhCeycQoZRUxsA+bJ5yxuE7KNBVFh5qITzeLDQlN35OfmHcdzHhw4xcB8HfJ
	 x2L3u3uivm5YMo074jnRohJ5ydCM7FJAdfi1SLHZ6X8fAWJWPIx2UkkUQxlocEIZvfRaB
	 CPe+YPrsxtmYidtmJZLwfMHwyDxMdj8VwdbSDFHA1cZuEYGichALBZCuyvxKJXbhtHZmB
	 d9G/pv6b05AnTTlm7IV/zkMvegYir/cnmZmc3alhYlBGI91fHQI+5oInUrX7evQXerV55
	 AREd39PVTpfg3EDRwE/0255AAUdRE6qc/jdcZo4UrKF2WTuDZWUbUXt+hZR0rJ3i3mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X27oq81r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.55
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B434606A325
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 17:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B434606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X27oq81r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp2LdbAtMaPBi+EwaJmhN7dbfpmzJZk7pD701MFphc7vn3+ANEdCqosaKfygJUCCvCQ4/7/u1ZWTPzCXTkLNSEvOgZPoBi07SWmi/NDAks+2kNZfsAaaBIpAB6C6X7FsIf3ZNgPrPcso4hy1BHcdIIvMW2VZyHTpjZPvAHgQlZOe3Dhi4k3mAu5e0Dev1S++CM6MXvxCV27bveFsK9XovDeTFpx//7MFvveUfj3HV2ZDXIaFE+BHatGAkVh/OzRXEvJ9ACnPvl6NOalWHqCtkp4SAceQKvbC00+mhSndAJ7bwOB5I+11xi6XqFMJMHYlOY55UDozR9QQqmxlJzXAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slpPZK64i1uGTDULigDtcDVEsfPad+EQPK6ts1t7FhE=;
 b=pGcbejDyVY/1AsnaBHQF+cB5q7Z7QRgT9fhKNdqJeOPtpaBACF4IhiOMwJSvp3vTFL3H76PBniNboaZXia9KunzxOGtMox7rGRxWpq3CfqlxFxJqn1z+74d+Qur4QSguzkpomoaTN5xXoMisKyIVqtcY+rkmR8Esbi2bdOuh5BP33gaOd42gtJYGSxB/R53p/lv9N4t8Z2nRsy9FsEzlsrtIePnJw7h9dXTI4w2Uea26lf1Hx3W+kj7q6NJuT1WepXE2cBFr1AI8r2IrPtiT1hbT7en42Cxyr20jooc4rDMZ1jB/SKN46KRBR+7PhqjFL+eUd4+6fUf3cYfW8y1Txw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slpPZK64i1uGTDULigDtcDVEsfPad+EQPK6ts1t7FhE=;
 b=X27oq81rzsfYX003Y5QnU7uJbJM2hFApKwL2XWLdq2tmrdphqHSpQGtBcL//PZ/ljNbdJFOVxUeHvLY9BRPqyKQ0acWunM2t/a45dD96OOkrCUnyBMvNCYfUWV0cOBquA0vomEn6QqPgtVcS5YC6xk9MZzQH/OBoNwXhsb50PdY=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:43:47 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::8b) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 18 Nov 2026 17:43:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 17:43:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:45 -0600
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 18 Nov 2026 11:43:45 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 2/3] cxl: make explicit removal of endpoint and decoder for Type2
Date: Wed, 18 Nov 2026 19:14:30 +0000
Message-ID: <20261118191431.21781-3-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118191431.21781-1-alucerop@amd.com>
References: <20261118191431.21781-1-alucerop@amd.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: e6491e26-15f2-42b6-43c0-08df459b7f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|5023799004|261026121527099003|261022105027099003|56012099006|11063799006|261102123227099003|261102130727099003|10067099003|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	s5lhyVeZdUhcl4ehLP5T/QzultBmlbKzPXuDfKbVd1T1wQmA3rAHyAtqEg1mHppO34BKHhFn4UHA9nxta2J001e6LfZEZxCcwsaCg6ftzvRQ6f6F+h1Nifw0m7ZzfC4tpf4zAbcQfp0Ak5XuUeUNBDUyRANBIJ3TMDpaS1hjCS84TCv06ngQ5BwuhHf1n+LyUDWWyTfKOcaPTsuQMjBYsBOikjVN6fIJsjCPGzXR5wS5E/zO/ToLZQVqbs8DBuXsPnyhxO7wZ2XuiT+rgmu6HoE8qAVu9wkfOQB6haKgCg2mup8Zsf/noY21wSR1OngauJuYRcI0l9fHAurdoqg7KbPE82+uhL50sDlDYdqIIJc3h/ok55GXSrljub465BkFjsb1rbkIVvTSDwEZcQVet5y9WfqYi+aFo063GIikG+0wvMJmnUf1Y9nhprcjlgyiUqFkUWXztGBYVI1taZXx9eTMvgCoYComWXySjC4/Uy2B7qN/eI7jDqyecVsRZrh1MHqygRKK3Hwv8z1ooYHebuOzGd6arIY70bEuRk8Eqluab5Z7kSZb7GOE4Gu0NVj72KXRROIKVs0LCRwZbh5a1vKBmOlI1lU0SF45kl6fHUVH6FR/jQbajC1R/wsFz/OFV84H49HkXhxCBlC5kcGmAndmTrNSQkJsHOpQPtk3B0fnHaw4y8GbbHqPTFwfEvW2V55y+RbJjm5T2iHTY9DZGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(5023799004)(261026121527099003)(261022105027099003)(56012099006)(11063799006)(261102123227099003)(261102130727099003)(10067099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hWL/ubmGhk1eHWRoe0PDjbhjP2iMok+szVqx3NMUVnLnCma4x09JUj25zqHqV9CGH6mZ/sX+Q8T+anBXRGxZqyEOUMWqMJipmhkyVtlZf4XmOGRCJ1dKyGgpPaO6ndhBJdeVLYGzNRz8HSpIiR4vOleHQLLwHwawC/2JV/lEYDSu1c9NrIYDG43+8EefgAHOHC4llyYVJARojYvu8QK3/U7xIsCXsapPt1W8iuFB1i7qq5OQo/63n4L+qFhUezcy4FtQZ5+fWy0sRQNinLAdHplNtxBIIjFexoew24yZeXJ8AEnLG/xOzzTUYFN8mUWbMhVDt0K9fKSh4RDhgt5o8gM5FgwCWXlj3IduxpgIkRyogPQZyepAVUIv9dW9R9B1R/2GbJmrwpvnTo1SGlqBFp3FlpdZzf7cW+BRzIcGW34NKDTZq+y+FC4OCSq8hdh1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:43:47.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6491e26-15f2-42b6-43c0-08df459b7f9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

From: Alejandro Lucero <alucerop@amd.com>

Current design relies on devm for CXL devices unwinding but this is not
working well for Type2.

No unwinding should happen while the Type2 driver is still using the HPA
range, and although the driver is signalled about the unwinding, devm
locking interdependencies force that signalling to be asynchronous
leading to the driver still using the HPA while those CXL objects
building the path have already disappeared.

This is currently safe because Type2 does only support autodiscovery
regions implying the physical decoders building up the path are not
reset, but this is semantically wrong and it will create issues with the
coming support of adhoc region creation by Type2.

Remove devm actions for endpoint and decoder for a Type2 device. Invoke
removal of them explicitly for a Type2 when it is safe to do so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 16 ++++++++++++++--
 drivers/cxl/core/port.c   | 23 +++++++++++++++++++++--
 drivers/cxl/core/region.c | 28 +++++++++++++++++++++++++---
 drivers/cxl/cxl.h         |  3 +++
 drivers/cxl/cxlmem.h      | 11 +++++++++++
 drivers/cxl/port.c        |  5 -----
 6 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 7333fe7594bd..c699c5561037 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -758,6 +758,14 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct device *dev = &cxlmd->dev;
 
 	trace_cxl_memdev_unregister(cxlmd, "start");
+
+	/*
+	 * Type2 requires to explicitly remove endpoint while Type3 relies on
+	 * devm mechanisms.
+	 */
+	if (cxlmd->attach)
+		delete_endpoint(cxlmd);
+
 	cdev_device_del(&cxlmd->cdev, dev);
 	cxl_memdev_shutdown(dev);
 	put_device(dev);
@@ -776,10 +784,14 @@ static void detach_memdev(struct work_struct *work)
 	 * is required. In that case, @cxlmd detach escalates to parent device
 	 * detach.
 	 */
-	if (cxlmd->attach)
+	if (cxlmd->attach) {
 		device_release_driver(cxlmd->dev.parent);
-	else
+
+		/* Type2 attach region did a get. */
+		put_device(&cxlmd->endpoint->dev);
+	} else {
 		device_release_driver(&cxlmd->dev);
+	}
 
 	put_device(&cxlmd->dev);
 	trace_cxl_memdev_detach(cxlmd, "done");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 9ccb0d185904..de109fb60038 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1480,14 +1480,24 @@ static struct device *grandparent(struct device *dev)
 	return NULL;
 }
 
-static void delete_endpoint(void *data)
+static void cxld_unregister(void *dev);
+
+void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct device *host = port_to_host(endpoint);
+	struct cxl_attach_region *attach =
+		container_of(cxlmd->attach, typeof(*attach), attach);
 
 	trace_cxl_delete_endpoint(&endpoint->dev, "start");
 
+	/* Type2 requires to explicitly remove region and decoder */
+	if (attach && attach->cxlr) {
+		endpoint_unregister_region(attach->cxlr);
+		cxld_unregister(&attach->cxled->cxld.dev);
+	}
+
 	scoped_guard(device, host) {
 		if (host->driver && !endpoint->dead) {
 			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
@@ -1509,7 +1519,10 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 	get_device(host);
 	get_device(&endpoint->dev);
 	cxlmd->depth = endpoint->depth;
-	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
+	/* Only Type3 relies on devm for decoder unwinding. */
+	if (cxlmd->cxlds->type == CXL_DEVTYPE_CLASSMEM)
+		return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
 
@@ -2413,6 +2426,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_bus_drain, "CXL");
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 {
 	trace_schedule_cxl_memdev_detach(cxlmd);
+
+	if (cxlmd->detach_scheduled)
+		return 0;
+
+	cxlmd->detach_scheduled = true;
+
 	return queue_work(cxl_bus_wq, &cxlmd->detach_work);
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, "CXL");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index efbd53a37405..6a188041791c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2593,7 +2593,7 @@ static void unregister_region(struct cxl_region *cxlr)
 	trace_cxl_unregister_region(&cxlr->dev, "done");
 }
 
-static void endpoint_unregister_region(void *_cxlr)
+void endpoint_unregister_region(void *_cxlr)
 {
 	struct cxl_region *cxlr = _cxlr;
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
@@ -4177,11 +4177,33 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	/* Only teardown regions that pass validation, ignore the rest */
 	get_device(&cxlr->dev);
 
-	rc = devm_add_action_or_reset(&endpoint->dev,
-				      endpoint_unregister_region, cxlr);
+	/*
+	 * While region in use by the Type2 device driver, no unbinding can
+	 * happen. Keeping a reference to the endpoint device avoids release.
+	 * The endpoint can be released after unwinding from the memdev forced
+	 * with the below actions.
+	 */
+	get_device(&endpoint->dev);
+
+	/*
+	 * All these next devm actions are necessary for dealing with unbind
+	 * triggered through sysfs with the CXL objects linked to a Type2.
+	 */
+	rc = devm_add_action_or_reset(&cxlr->dev, schedule_detach, cxlmd);
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(&endpoint->dev, schedule_detach, cxlmd);
+
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(&cxlmd->dev, schedule_detach, cxlmd);
 	if (rc)
 		return rc;
 
+	attach->cxlr = cxlr;
+	attach->cxled = cxled;
 	attach->hpa_range = (struct range) {
 		.start = cxlr->params.res->start,
 		.end = cxlr->params.res->end,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index baa6df2d362a..eaa663f25699 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -942,6 +942,9 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 			     struct access_coordinate *c1,
 			     struct access_coordinate *c2);
 
+void endpoint_unregister_region(void *_cxlr);
+void delete_endpoint(void *data);
+
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 					    struct device *dport_dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 35268d1c387c..8e9f6ff14d98 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -51,6 +51,7 @@
  * @err_rec_array: List of xarrarys to store the memdev error records to
  *		   check attributes for a memory repair operation are from
  *		   current boot.
+ * @detach_scheduled: shows if work does exist already for detaching the memdev.
  */
 struct cxl_memdev {
 	struct device dev;
@@ -66,8 +67,14 @@ struct cxl_memdev {
 	u8 scrub_cycle;
 	int scrub_region_id;
 	struct cxl_mem_err_rec *err_rec_array;
+	bool detach_scheduled;
 };
 
+static inline void schedule_detach(void *cxlmd)
+{
+	schedule_cxl_memdev_detach(cxlmd);
+}
+
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
 {
 	return container_of(dev, struct cxl_memdev, dev);
@@ -104,6 +111,8 @@ struct cxl_memdev_attach {
 /**
  * struct cxl_attach_region - coordinate mapping a region at memdev registration
  * @attach: common core attachment descriptor
+ * @cxlr: region attached.
+ * @cxled: endpoint decoder linked to the region.
  * @hpa_range: physical address range of the region
  *
  * For the common simple case of a CXL device with private (non-general purpose
@@ -112,6 +121,8 @@ struct cxl_memdev_attach {
  */
 struct cxl_attach_region {
 	struct cxl_memdev_attach attach;
+	struct cxl_region *cxlr;
+	struct cxl_endpoint_decoder *cxled;
 	struct range hpa_range;
 };
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c12fd0b89883..1b93853b0779 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -26,11 +26,6 @@
  * PCIe topology.
  */
 
-static void schedule_detach(void *cxlmd)
-{
-	schedule_cxl_memdev_detach(cxlmd);
-}
-
 static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
-- 
2.34.1

