Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023834;
	b=r1U/QIFDN/OrSU/acnYQ4Dg4cywf6/N4kN3jTgx86ruU0b2tPSqYHHv1iiR9C5BdOrKm
	 qDKHNqUbYtCyIGb80NOtJ5VEchgE4UuYVfuuWFYdRZRbhXSTvs39cy0zf/6PCYCL9hOEy
	 dRvVu+vXEPYB5jGlNgw8Hl5y0rXTqaGCmKSli9vcK2qdR2gcCLGJhCiRVWSUm6nvQRfOe
	 y5fhKFZamy2JcjGhSUSRA14i7vK5qYNlUSyF3y6hD98m2FdGKZcpsHV7zTGn3F1X3gyC0
	 T0vphPAqyslI+v5uKbsLYqjWNcRGpLRa5vTMenzXci4fIvRbVLfYGT1oJSnoapeVJ2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023834;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=BoNk0Ib408kVS0sKyC0B764eyW3kNLbX6YJwhKMgfTg=;
	b=f47wfJBxhrAqrOHE5xRX6ScKWKHlt5Z1I+sGtgZXyng4CuyqNwTqSLAZQRNyLSdAu42Y
	 1tqmaoDfoSlgNNp/Eo0fKlNu4gTduYMzo85sBJL8WLnxipiRFe4BLX40sCreMrhU1MJLK
	 ep/i15/iRvCutdQfMsTVKC098JANB2bE7RKLtzI9iDvBj+w16q61+MR0ALrOtg82F9xcO
	 Fn5p1vGGuOZUFmdJjdt2sJI60reaULsJNWZOcrEeIX0TgIXwP1t+ZVzZzdEoT/qtRg72T
	 hIU+3n92sVcPIWS81Ofy64kzQ0Bk3lpgKzqmiQ96G9u6cB6y5hUSCHSiZ936eE8kLkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1QLArWcn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.34
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92232606A320
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 17:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92232606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1QLArWcn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyiK9i0tufqLo6gK2ChjHEisYoovpDeQhlg2NDpOq17bxmzNWgst2qyYvZpgZ0JCzA4msp7+2R3mQPSWmahPRV/q7zzLWLxgsZKHvj+J7BTc5Ukn3nZM5WmFIz+v00pnGMCQDfJf/JZGOeqFsxXFVN7xtLnbdwKRh4cCBoO3e91VBRUpd/P6RWV9jM/C8O/FJpmkCpE1Jqi4om42rWlLPXO+T1r2+ibCWzVXfTwO5X3W3C5PQDifASaNZFSkP7SIBNGd2HxmZmaa2ZzymyrIA1hTGhVMNXWMwKUuee+MEovX5ljyg0hRRnSk7O2+zH6LaImPypSO79Djr6eRzYmDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoNk0Ib408kVS0sKyC0B764eyW3kNLbX6YJwhKMgfTg=;
 b=ZccUUonqxIiJj+1YiwGY2t3ciUdJa08l0LTVjAYC2iisLMhHeaHgUQPHS4/vzdbcRwbADM+WTTWOipImA6/XQ8Db/vZEgq0v7YMrrEo9pa+yyZWDzBa3ZWeuUbWlKg4dOiwRdQpIU07XWzsm2oK33UVEQyOr9E/PucYSFzQoVc0hXADLfZWqELDvtxh48EDMuVDfnDvqhgPW2ThGWIonjwui+TEXL7ahUmQhd+oI2x6GavR1TSioDH+IaKHkw2sRdbYkKCNKt8/RnEmlAOjbRVOJstFyh3qcijC8rk1Re70cfrYVhdRbgVh3CuUMzpX8xbQ8Nkn274L/DC1YlsrhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoNk0Ib408kVS0sKyC0B764eyW3kNLbX6YJwhKMgfTg=;
 b=1QLArWcnoX6aD2AikqYtPPnMaNhtI901xiRmQQ7wzVeLmCSDDdDoNOxobkniigXmBk3MzkrLMVMcVQwquP4RzKyPPekYi3LK1z7yUq0pKIdyOadYETMqJ/f2iT1mB1pBMnnr97hO7ttwNbyfaTGDQxkDoEnuA+qfu5uAQHoFmRo=
Received: from SJ0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:33a::14)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:43:46 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::38) by SJ0PR03CA0009.outlook.office365.com
 (2603:10b6:a03:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 18 Nov 2026 17:43:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 17:43:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:45 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:44 -0600
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 18 Nov 2026 11:43:43 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 1/3] cxl: add tracepoints to the unwinding code path
Date: Wed, 18 Nov 2026 19:14:29 +0000
Message-ID: <20261118191431.21781-2-alucerop@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 54934b08-9f3d-4244-f69f-08df459b7ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|5023799004|261022113327099003|261022075727099003|261021123027099003|261102130727099003|11063799006|56012099006|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|32116099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Rb84FaBoDfGuSYwBXbin2vUAuazA/Fz/uTSTTNL8DfW9kTerjSBjGUlxRS05VXcDJYA9qZJfJGMED9qYVP+4D8I25YBoOyx8KwHeVBHQQxncCnF+h3raXoBwMLZcP2OqCTZOcr3zCJzyEUeImPIgKUBYd1oPF/ouDKh5K9KZCFvrW3GUHXp3kvyGYWtjhPBuhRH1HWgIfbulK8j1euzHPxOM7Dj1+wOeqJVrW2KqVt0Wsv9nygrMA7Q7vU2ETlFMM3f71oFPcZA/1EzzXWyLyg0OoN6Y70BxEVTU9aeAaueckAW9LVuv0XYBlWxuDoJnk2JgdZWvG2WlvoQUKYRdAyk6DsrsQzF/Kw16Cyg/3a1OsGAWw/bhrnkgsad2yNXlglWjjGsdGDALjwntKTMeRp6tMXx59Fj0Hu3TSinnwPsUS9o5gn3l7VXE/Wre9FwCSu1mnYLEEpFV1XhKDVBwU4furtKiZesCUuS6811s/jeVKaX2OIdEUEWrJi6Fp/VePNHG484y1s8t5WLDPQ/yoild5KNcOAs2R/SWKx6D6y99rO1cMe73lAPWyDzD9CwwAfKtG+a9w5UC4bFfEEKmAQlN9MrAHYLqPbWRWMVrY5qzhhuTlgUhycHgWWBarz7BN9iHIbd2FNBbnNgzeiVvzbDOdOcbyk40fkVNyRk/Wjza/i7cTC2Jsw0f6HlDx87dmUzK1jqYP3tt0wETBRxDew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(5023799004)(261022113327099003)(261022075727099003)(261021123027099003)(261102130727099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(32116099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/3ShtozmPYIY3o0m+Oh3vh6itRwl/VC95tgCwO+gjyZ6Hc0Qt9k9EqcsyQPN8xvDDgGff2/DRMH3YrFVPXXU6H9XQsEOAXn6UQoAuH/z7NMkZz1CoXW04ysuXVN76anDtxjC4rdeBlzlX9gnyrSMABuHufevWpOOamKP0hFH3EsSHj0O39cM8gNrVhe6BaAeP8FGNpVqZiyYP1HV5Uxk+uua1BleiWk+zn0rDh65qh+07CUN43yibBA9EImDd7wF6YrY8BDbIVc8dedHj8kEtlgHVUYtE5MZTMYlDbcLog5XLlsEXEkYdJ3kcYqUsGElHQ4K7TRPCgINFXkF9HDiw4DMzFljAHpi5CSuzdi+qQuF6pyuy0fz6WW/azsTi4VBwwl4YwCSx7wYi6mLGSSKAcakkZE3MPlrNdXAAF3I/7Y50Jjz2re+8tdA3uVfAtwW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:43:45.7651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54934b08-9f3d-4244-f69f-08df459b7ec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

From: Alejandro Lucero <alucerop@amd.com>

Once all CXL objects/devices are created for a Type2/3 device, the way
those same objects are removed depends on the triggering point with
several possibilities:

 - Type2 driver removed.
 - Through the sysfs unbind files linked to the cxl drivers.

Add tracepoints to the different functions invoked when the unwinding
happens which will help to visualize the process and debug potential
problems. As those functions can trigger further unwinding, add start
and done tracepoints for easily seeing the unwinding action graph.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c            | 10 +++
 drivers/cxl/core/port.c              | 16 +++++
 drivers/cxl/core/region.c            | 14 +++++
 drivers/cxl/cxl_memdev_tracepoints.h | 58 ++++++++++++++++++
 drivers/cxl/cxl_port_tracepoints.h   | 91 ++++++++++++++++++++++++++++
 drivers/cxl/cxl_region_tracepoints.h | 78 ++++++++++++++++++++++++
 6 files changed, 267 insertions(+)
 create mode 100644 drivers/cxl/cxl_memdev_tracepoints.h
 create mode 100644 drivers/cxl/cxl_port_tracepoints.h
 create mode 100644 drivers/cxl/cxl_region_tracepoints.h

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 787988e92965..7333fe7594bd 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -11,6 +11,9 @@
 #include "trace.h"
 #include "core.h"
 
+#define CREATE_TRACE_POINTS
+#include "cxl_memdev_tracepoints.h"
+
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 
 /*
@@ -27,9 +30,11 @@ static void cxl_memdev_release(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct device *parent = dev->parent;
 
+	trace_cxl_memdev_release(cxlmd, "start");
 	ida_free(&cxl_memdev_ida, cxlmd->id);
 	kfree(cxlmd);
 	put_device(parent);
+	trace_cxl_memdev_release(cxlmd, "done");
 }
 
 static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
@@ -752,9 +757,11 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
+	trace_cxl_memdev_unregister(cxlmd, "start");
 	cdev_device_del(&cxlmd->cdev, dev);
 	cxl_memdev_shutdown(dev);
 	put_device(dev);
+	trace_cxl_memdev_unregister(cxlmd, "done");
 }
 
 static void detach_memdev(struct work_struct *work)
@@ -763,6 +770,7 @@ static void detach_memdev(struct work_struct *work)
 
 	cxlmd = container_of(work, typeof(*cxlmd), detach_work);
 
+	trace_cxl_memdev_detach(cxlmd, "start");
 	/*
 	 * When the creator of @cxlmd sets ->attach it indicates CXL operation
 	 * is required. In that case, @cxlmd detach escalates to parent device
@@ -772,7 +780,9 @@ static void detach_memdev(struct work_struct *work)
 		device_release_driver(cxlmd->dev.parent);
 	else
 		device_release_driver(&cxlmd->dev);
+
 	put_device(&cxlmd->dev);
+	trace_cxl_memdev_detach(cxlmd, "done");
 }
 
 static struct lock_class_key cxl_memdev_key;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f3705ea44db7..9ccb0d185904 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -17,6 +17,9 @@
 #include <cxl.h>
 #include "core.h"
 
+#define CREATE_TRACE_POINTS
+#include "cxl_port_tracepoints.h"
+
 /**
  * DOC: cxl core
  *
@@ -34,6 +37,7 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
@@ -540,8 +544,10 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, "CXL");
 
 static void cxl_ep_release(struct cxl_ep *ep)
 {
+	trace_cxl_ep_release(ep->ep, "start");
 	put_device(ep->ep);
 	kfree(ep);
+	trace_cxl_ep_release(ep->ep, "done");
 }
 
 static void cxl_ep_remove(struct cxl_port *port, struct cxl_ep *ep)
@@ -558,6 +564,7 @@ static void cxl_port_release(struct device *dev)
 	unsigned long index;
 	struct cxl_ep *ep;
 
+	trace_cxl_port_release(dev, "start");
 	xa_for_each(&port->endpoints, index, ep)
 		cxl_ep_remove(port, ep);
 	xa_destroy(&port->endpoints);
@@ -571,6 +578,7 @@ static void cxl_port_release(struct device *dev)
 		put_device(dev->parent);
 		kfree(port);
 	}
+	trace_cxl_port_release(dev, "done");
 }
 
 static ssize_t decoders_committed_show(struct device *dev,
@@ -1478,6 +1486,8 @@ static void delete_endpoint(void *data)
 	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct device *host = port_to_host(endpoint);
 
+	trace_cxl_delete_endpoint(&endpoint->dev, "start");
+
 	scoped_guard(device, host) {
 		if (host->driver && !endpoint->dead) {
 			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
@@ -1488,6 +1498,7 @@ static void delete_endpoint(void *data)
 	}
 	put_device(&endpoint->dev);
 	put_device(host);
+	trace_cxl_delete_endpoint(&endpoint->dev, "done");
 }
 
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
@@ -1553,6 +1564,7 @@ static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 
+	trace_cxl_detach_ep(&cxlmd->dev, "start");
 	for (int i = cxlmd->depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
@@ -1595,6 +1607,7 @@ static void cxl_detach_ep(void *data)
 		}
 		device_unlock(&parent_port->dev);
 	}
+	trace_cxl_detach_ep(&cxlmd->dev, "done");
 }
 
 static resource_size_t find_component_registers(struct device *dev)
@@ -2283,6 +2296,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
 
 static void cxld_unregister(void *dev)
 {
+	trace_cxld_unregister(dev, "start");
 	if (is_endpoint_decoder(dev))
 		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
 				   DETACH_INVALIDATE);
@@ -2290,6 +2304,7 @@ static void cxld_unregister(void *dev)
 		kill_regions(to_cxl_root_decoder(dev));
 
 	device_unregister(dev);
+	trace_cxld_unregister(dev, "done");
 }
 
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
@@ -2397,6 +2412,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_bus_drain, "CXL");
 
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 {
+	trace_schedule_cxl_memdev_detach(cxlmd);
 	return queue_work(cxl_bus_wq, &cxlmd->detach_work);
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, "CXL");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..efbd53a37405 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -18,6 +18,9 @@
 #include "core.h"
 #include "mce.h"
 
+#define CREATE_TRACE_POINTS
+#include "cxl_region_tracepoints.h"
+
 /**
  * DOC: cxl core region
  *
@@ -2275,6 +2278,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (!cxled) {
+		trace_cxl_decoder_detach(&cxlr->dev, "start");
 		p = &cxlr->params;
 
 		if (pos >= p->interleave_ways) {
@@ -2292,6 +2296,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 			cxl_cancel_auto_attach(cxled);
 			return NULL;
 		}
+		trace_cxl_decoder_detach(&cxlr->dev, "start");
 		p = &cxlr->params;
 	}
 
@@ -2329,6 +2334,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 	};
 
 	get_device(&cxlr->dev);
+	trace_cxl_decoder_detach(&cxlr->dev, "done");
 	return cxlr;
 }
 
@@ -2360,6 +2366,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	}
 
 	if (detach) {
+		trace_cxl_decoder_detach_release_driver(&detach->dev);
 		device_release_driver(&detach->dev);
 		put_device(&detach->dev);
 	}
@@ -2521,6 +2528,7 @@ static void cxl_region_release(struct device *dev)
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
+	trace_cxl_region_release(dev, "start");
 	/*
 	 * Try to reuse the recently idled id rather than the cached
 	 * next id to prevent the region id space from increasing
@@ -2536,6 +2544,7 @@ static void cxl_region_release(struct device *dev)
 out:
 	put_device(dev->parent);
 	kfree(cxlr);
+	trace_cxl_region_release(dev, "done");
 }
 
 const struct device_type cxl_region_type = {
@@ -2565,6 +2574,7 @@ static void unregister_region(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
+	trace_cxl_unregister_region(&cxlr->dev, "start");
 	xa_erase(&cxlrd->regions, cxlr->id);
 	device_del(&cxlr->dev);
 
@@ -2580,6 +2590,7 @@ static void unregister_region(struct cxl_region *cxlr)
 
 	cxl_region_iomem_release(cxlr);
 	put_device(&cxlr->dev);
+	trace_cxl_unregister_region(&cxlr->dev, "done");
 }
 
 static void endpoint_unregister_region(void *_cxlr)
@@ -2587,10 +2598,12 @@ static void endpoint_unregister_region(void *_cxlr)
 	struct cxl_region *cxlr = _cxlr;
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 
+	trace_cxl_endpoint_unregister_region(&cxlr->dev, "start");
 	guard(mutex)(&cxlrd->regions_lock);
 	if (xa_load(&cxlrd->regions, cxlr->id))
 		unregister_region(cxlr);
 	put_device(&cxlr->dev);
+	trace_cxl_endpoint_unregister_region(&cxlr->dev, "done");
 }
 
 static struct lock_class_key cxl_region_key;
@@ -4163,6 +4176,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 
 	/* Only teardown regions that pass validation, ignore the rest */
 	get_device(&cxlr->dev);
+
 	rc = devm_add_action_or_reset(&endpoint->dev,
 				      endpoint_unregister_region, cxlr);
 	if (rc)
diff --git a/drivers/cxl/cxl_memdev_tracepoints.h b/drivers/cxl/cxl_memdev_tracepoints.h
new file mode 100644
index 000000000000..6e8206cf178a
--- /dev/null
+++ b/drivers/cxl/cxl_memdev_tracepoints.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Tracepoints for CXL subsystem
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl_unwinding
+
+#include <linux/tracepoint.h>
+#include "cxlmem.h"
+
+TRACE_EVENT(cxl_memdev_release,
+	    TP_PROTO(struct cxl_memdev *cxlmd, char *action),
+	    TP_ARGS(cxlmd, action),
+	    TP_STRUCT__entry(__string(devname, cxlmd->dev.kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_memdev_unregister,
+	    TP_PROTO(struct cxl_memdev *cxlmd, char *action),
+	    TP_ARGS(cxlmd, action),
+	    TP_STRUCT__entry(__string(devname, cxlmd->dev.kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_memdev_detach,
+	    TP_PROTO(struct cxl_memdev *cxlmd, char *action),
+	    TP_ARGS(cxlmd, action),
+	    TP_STRUCT__entry(__string(devname, cxlmd->dev.kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cxl_memdev_tracepoints
+
+#include <trace/define_trace.h>
diff --git a/drivers/cxl/cxl_port_tracepoints.h b/drivers/cxl/cxl_port_tracepoints.h
new file mode 100644
index 000000000000..faefa418d968
--- /dev/null
+++ b/drivers/cxl/cxl_port_tracepoints.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Tracepoints for CXL subsystem
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl_unwinding
+
+#include <linux/tracepoint.h>
+#include "cxlmem.h"
+
+TRACE_EVENT(schedule_cxl_memdev_detach,
+	    TP_PROTO(struct cxl_memdev *cxlmd),
+	    TP_ARGS(cxlmd),
+	    TP_STRUCT__entry(__string(devname, cxlmd->dev.kobj.name)),
+	    TP_fast_assign(__assign_str(devname);
+	    ),
+	    TP_printk("%s", __get_str(devname))
+);
+
+TRACE_EVENT(cxl_detach_ep,
+	    TP_PROTO(struct device *ep, char *action),
+	    TP_ARGS(ep, action),
+	    TP_STRUCT__entry(__string(devname, ep->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_ep_release,
+	    TP_PROTO(struct device *ep, char *action),
+	    TP_ARGS(ep, action),
+	    TP_STRUCT__entry(__string(devname, ep->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_port_release,
+	    TP_PROTO(struct device *dev, char *action),
+	    TP_ARGS(dev, action),
+	    TP_STRUCT__entry(__string(devname, dev->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_delete_endpoint,
+	    TP_PROTO(struct device *dev, char *action),
+	    TP_ARGS(dev, action),
+	    TP_STRUCT__entry(__string(devname, dev->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxld_unregister,
+	    TP_PROTO(struct device *dev, char *action),
+	    TP_ARGS(dev, action),
+	    TP_STRUCT__entry(__string(devname, dev->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cxl_port_tracepoints
+
+#include <trace/define_trace.h>
diff --git a/drivers/cxl/cxl_region_tracepoints.h b/drivers/cxl/cxl_region_tracepoints.h
new file mode 100644
index 000000000000..977eb45b6aad
--- /dev/null
+++ b/drivers/cxl/cxl_region_tracepoints.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Tracepoints for CXL subsystem
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl_unwinding
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(cxl_decoder_detach,
+	    TP_PROTO(struct device *dev, char *action),
+	    TP_ARGS(dev, action),
+	    TP_STRUCT__entry(__string(devname, dev->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_decoder_detach_release_driver,
+	    TP_PROTO(struct device *ep),
+	    TP_ARGS(ep),
+	    TP_STRUCT__entry(__string(devname, ep->kobj.name)),
+	    TP_fast_assign(__assign_str(devname);
+	    ),
+	    TP_printk("%s", __get_str(devname))
+);
+
+TRACE_EVENT(cxl_region_release,
+	    TP_PROTO(struct device *dev, char *action),
+	    TP_ARGS(dev, action),
+	    TP_STRUCT__entry(__string(devname, dev->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_unregister_region,
+	    TP_PROTO(struct device *dev, char *action),
+	    TP_ARGS(dev, action),
+	    TP_STRUCT__entry(__string(devname, dev->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+TRACE_EVENT(cxl_endpoint_unregister_region,
+	    TP_PROTO(struct device *dev, char *action),
+	    TP_ARGS(dev, action),
+	    TP_STRUCT__entry(__string(devname, dev->kobj.name)
+			     __string(action, action)
+	    ),
+	    TP_fast_assign(__assign_str(devname);
+			   __assign_str(action);
+	    ),
+	    TP_printk("%s, %s", __get_str(devname), __get_str(action))
+);
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cxl_region_tracepoints
+
+#include <trace/define_trace.h>
-- 
2.34.1

