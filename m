Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B63D352F99
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897396; cv=fail; b=EvI4EixW4S4XGslOaCNN/B87WNbl4e0VqEadeUwhmpzxqN7FbWKlAVvdsBaYHMLqdQz5QpRRwsA5es7hrb8lcwCaEtww2bo4g3/1gVhgHdG2BZggRoDZLsrMbM1hvp0tvcnC24Y/co5EUzPtbYCDMtqSrwM5QFdpHt26wXJSuCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897396; c=relaxed/simple;
	bh=0Hucl28/moZrAfTDSx2HFyGjy5GUvdSzT1wuuxW6KyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJct526OhO5/7CCYo3PQCx85EsFmoCursnB7UtMu1r6Vg2OTfM8q9GKC3aEtBuSchBVcnWEhdJNT3gfsMraZOoe7zYV7xiGURL+8SPwL/OcYehG2BhxtWoqWFnRonX/TWFDwWLZfNZEclA5F5I6OrOhZB0mRAx0zq7QnMCv+DAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NxHV6yzJ; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NxHV6yzJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN9LwVWSjewwSV5y1ymp5CwHkkJsUzAYto7dtYPw9BhaWWhsFmbKKlhrHgiS4d9fMulXdcQTGQ0yW5g7bwcyIHhU0jE0hChA39pAL94nAw7knAp3PENuT0CiGZmPF7koLb5jr+DZpLyiGPamsKL+EmWQHq4+fhfiPOormyASRS39CmNSZU7N/48Q3raCCVectOu3oDOktj6Y5gjKLHbxprTtDfXy2jCT5QIsXk/YcP4vNxNCnBdGJtw3xTdqo63wIhdYrAvo3W7n2Rvw8uP6ongpGo57Yq2hh031iVk3zjJofwBrD1W0QOHuGv/LbJMgeoDNCOr2DQoafWrNDL5r3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnHWQpsU4kIjI8QVAcHcnxYqU2bw77fC0/MalxmcjxE=;
 b=ykSZJTKumJ658ppHqKiUFU79k4RkMumtViafCJEeeHrjFprVyDJlPXFTXTCl/d2r+pe3dooyDvK0ipFrQnXlqZKkUD013sCkKBF52F8xwx6koZYcsDw3WE51leSbeCroh1M2u8zOjRJj/erYgMDR2uICx0PcvHAvuYxeLWflPUvR6zyuh+Z6wrvJqmRQWBGjLdDv7LoNqKuFPF4Ig3pv6EPF3TwjeyNHopyUvywn1ACC9J69wc01b3IiUs+162ddrLytN1C8ebZlFikg3hURe15a7iR7V+tppK8iBMpRk5n2dKgbqu+w79wMQBPAb5ToxNmu6dd4aEpYo4eNGYBeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnHWQpsU4kIjI8QVAcHcnxYqU2bw77fC0/MalxmcjxE=;
 b=NxHV6yzJ7s0I9znf3GdRocvkYFUZUnYXw9u5ILCJKIz9NM+T928M2Uw16gtzDzAJJXPIiRFlUlwSjayIIynWddDAs+JqEoOtBgOQuWh/zbv2uH5Fai8gTABPlTtDUNRVVf3gnSSF4hkeVKm5xWCBMttPxAosgJbq356XPKygEkA=
Received: from BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:43:07 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::64) by BLAPR03CA0047.outlook.office365.com
 (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 21:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:43:07 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:43:01 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 11/17] cxl/core, port: Update devm_cxl_add_endpoint()
Date: Tue, 11 Nov 2025 15:40:26 -0600
Message-ID: <20251111214032.8188-12-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 005d024a-93a3-4de8-9f2e-08de216b4d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1p6uFM1vws+JC2kwuywT3HFc5TybPR5d6vNNcWSQThdLiB4eIJ4ovqTQ0JSW?=
 =?us-ascii?Q?U5U7OgxQnUWIKaoUenCBBeUSb2rCqAU4P6EreTgVyZDgrCVyUBvnSj7m72zZ?=
 =?us-ascii?Q?7JWOcJHRZyxuScGrWtzdk59VCbmfQF9cpHI4eD8MYnVW0WorvOPoPo7c6l46?=
 =?us-ascii?Q?Xh1E3cGzgOJNedfwEvs6L404krJ9Uv1WjalUBQG6RRCpChtJ9cDbtQmyCTqh?=
 =?us-ascii?Q?DywMqNW/Q2mbIKjo29ggLD3d3Zajz++G1NLtdJhQqWbCznzwfeLT8MEpnDmo?=
 =?us-ascii?Q?BYU9/kCMaCNVLCNn5+Gwml/4Yd+rKGVxRzYM9+tCu0O+K301cJ5I07Doqulz?=
 =?us-ascii?Q?OdL3qXRCDyafJ+f8Bp/iW71cdPJAaiPDSVsoTOHRhKZSOASF4Xks72YHkc6o?=
 =?us-ascii?Q?oq9STgAEjd8YayM2iXepsG8ILdLLAjkWDDPbBoE0Em/vrY8BlSKHc4EF+LDn?=
 =?us-ascii?Q?vgYTqpFtJ0tOuBGDnTmovBQWtv9tJtdfiJBmuHEMWhzCaeKV+G9n9zIq9t2k?=
 =?us-ascii?Q?3y57GKO+oBDL1uxcriYx1Y6JtKBChFQkLxnRAoLxHPz+UkxCmzL2BZnYPj6S?=
 =?us-ascii?Q?tWp18lUIHopKoWQKP355WSo+V0WtsNJ7iuVCrwECoWCY20RClK6fJ2qd8CjL?=
 =?us-ascii?Q?HwPpcVixwOVKbp4cYeSbDZONfJ0IjIdljvgULHxREJVE1qX1pwYkeSPCUABS?=
 =?us-ascii?Q?9ePySFiHVlR1OxG4+/nAEI+bagVTu8X1oP+YTQagmDlP0Nay4Bu2MG8ng2VC?=
 =?us-ascii?Q?J++KEzHTR3Xda72kq6Ck7TjcD/Q/9/MtYSVunexH8hcWo9+vnjQD/y7w5sI9?=
 =?us-ascii?Q?U/nIuhefWFE6THSVtfnAhKyUBPOrceLkfLPg+uMnuTIiQwe3UqVIW/bFifRx?=
 =?us-ascii?Q?lIecHKpNCY9SqPa8VRF4WbkznMz6/moM8zBQt7dwYRVHxd9TYcaVCPQqs40N?=
 =?us-ascii?Q?DNZwgs138qjG27Wq3V+g+rL6+9i9zwcNGxyQ2l+RQlqh5fouLTR9LLV/OSQ1?=
 =?us-ascii?Q?A06qrxwrZi687NLyYYhnLoqO+X1Q5ShKa2NNoAQiYox0le3WvkwEoC+/mV8V?=
 =?us-ascii?Q?QLhEVV9pyHFYUpwzFFTlSHSJr8XLBoLtVspzE6k3a0HJlOb3syaA8U9T3l2Q?=
 =?us-ascii?Q?ZROeCNcWgTxLJ218uEaAf+9oSu2+skWDHXlvvzO2575tGjqdLhtdBbtIzzRu?=
 =?us-ascii?Q?JnNXLyz4+I1VIWUJOGy3dC/R7jwrWi8AOZXKxSaUaekvUTzsvCgkiH7PMzm5?=
 =?us-ascii?Q?jOAi9kV8lrzvx66qS5J3rUgwrtDkXQ6YNFvKqYxrDO3OsWjIzdVe4WzKC4G2?=
 =?us-ascii?Q?eopDvDhIaV6uDAORyTqM76dD/TdG3NEmUFUiFsrNWvKCSnNhMdogvWDr7F8i?=
 =?us-ascii?Q?ANy2pg5q18fJcJxHT0HqB7KbYWkFYz1tqJzwtbGqu7z7MmnsKVGs+3eM/jF2?=
 =?us-ascii?Q?P8kgSyJxbRbys0uio9fBXQtRwlrHfc0BGM+Yay9nDbkLbvFLNCQytugJaHOH?=
 =?us-ascii?Q?ZcurOLW3uqy/lYjLWInX1swkTpKRAxPtly57+lSDFaG4K/HRCPSes5cPZEze?=
 =?us-ascii?Q?bfX25ppZCvONFxh2t2s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:43:07.5621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005d024a-93a3-4de8-9f2e-08de216b4d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

Update devm_cxl_add_endpoint(), and other functions it calls, to use
struct device instead of struct cxl_memdev to allow adding struct
cxl_cachedev endpoints to the port heirarchy.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     | 10 ++++++++++
 drivers/cxl/core/port.c | 37 +++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h       |  3 ++-
 drivers/cxl/mem.c       |  2 +-
 drivers/cxl/port.c      | 13 ++++++++-----
 drivers/cxl/private.h   |  2 +-
 6 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 4c9280c0ea72..dcc9816d9b37 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -81,6 +81,16 @@ static int cxl_cache_probe(struct device *dev)
 	scoped_guard(device, endpoint_parent) {
 		if (!cxlds->cxlmd)
 			cxl_dport_init_ras_reporting(dport, dev);
+
+		if (!endpoint_parent->driver) {
+			dev_err(dev, "CXL port topology %s not enabled\n",
+				dev_name(endpoint_parent));
+			return -ENXIO;
+		}
+
+		rc = devm_cxl_add_endpoint(endpoint_parent, dev, dport);
+		if (rc)
+			return rc;
 	}
 
 	return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e79ec29d0bb6..dc001e136782 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -844,10 +844,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
-static bool is_cxl_ep_device(struct device *dev)
+bool is_cxl_ep_device(struct device *dev)
 {
 	return is_cxl_memdev(dev) || is_cxl_cachedev(dev);
 }
+EXPORT_SYMBOL_NS_GPL(is_cxl_ep_device, "CXL");
 
 static int cxl_port_setup_endpoint(struct cxl_port *port)
 {
@@ -1424,10 +1425,26 @@ static struct device *endpoint_host(struct cxl_port *endpoint)
 	return &port->dev;
 }
 
+static void cxl_ep_dev_set_endpoint(struct device *ep_dev, struct cxl_port *ep)
+{
+	if (is_cxl_memdev(ep_dev))
+		to_cxl_memdev(ep_dev)->endpoint = ep;
+	else
+		to_cxl_cachedev(ep_dev)->endpoint = ep;
+}
+
+static struct cxl_port *cxl_ep_dev_get_endpoint(struct device *ep_dev)
+{
+	if (is_cxl_memdev(ep_dev))
+		return to_cxl_memdev(ep_dev)->endpoint;
+	else
+		return to_cxl_cachedev(ep_dev)->endpoint;
+}
+
 static void delete_endpoint(void *data)
 {
-	struct cxl_memdev *cxlmd = data;
-	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *ep_dev = data;
+	struct cxl_port *endpoint = cxl_ep_dev_get_endpoint(ep_dev);
 	struct device *host = endpoint_host(endpoint);
 
 	scoped_guard(device, host) {
@@ -1436,21 +1453,25 @@ static void delete_endpoint(void *data)
 			devm_release_action(host, cxl_unlink_uport, endpoint);
 			devm_release_action(host, unregister_port, endpoint);
 		}
-		cxlmd->endpoint = NULL;
+		cxl_ep_dev_set_endpoint(ep_dev, NULL);
 	}
 	put_device(&endpoint->dev);
 	put_device(host);
 }
 
-int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+int cxl_endpoint_autoremove(struct device *ep_dev, struct cxl_port *endpoint)
 {
 	struct device *host = endpoint_host(endpoint);
-	struct device *dev = &cxlmd->dev;
 
 	get_device(host);
 	get_device(&endpoint->dev);
-	cxlmd->depth = endpoint->depth;
-	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
+
+	if (is_cxl_memdev(ep_dev))
+		to_cxl_memdev(ep_dev)->depth = endpoint->depth;
+	else
+		to_cxl_cachedev(ep_dev)->depth = endpoint->depth;
+
+	return devm_add_action_or_reset(ep_dev, delete_endpoint, ep_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6c7b8278bec3..e8d66de469d6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -917,6 +917,7 @@ struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
+bool is_cxl_ep_device(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets);
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
@@ -930,7 +931,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 {
 	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
 }
-int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+int cxl_endpoint_autoremove(struct device *ep_dev, struct cxl_port *endpoint);
 
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 35706ec1b7e1..336ae091aa07 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -139,7 +139,7 @@ static int cxl_mem_probe(struct device *dev)
 			return -ENXIO;
 		}
 
-		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
+		rc = devm_cxl_add_endpoint(endpoint_parent, dev, dport);
 		if (rc)
 			return rc;
 	}
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 14319219d23b..ae38b9965a84 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -178,13 +178,16 @@ static struct cxl_driver cxl_port_driver = {
 	},
 };
 
-int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+int devm_cxl_add_endpoint(struct device *host, struct device *ep_dev,
 			  struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
+	if (!is_cxl_ep_device(ep_dev))
+		return -EINVAL;
+
 	/*
 	 * Now that the path to the root is established record all the
 	 * intervening ports in the chain.
@@ -193,22 +196,22 @@ int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
 		struct cxl_ep *ep;
 
-		ep = cxl_ep_load(iter, &cxlmd->dev);
+		ep = cxl_ep_load(iter, ep_dev);
 		ep->next = down;
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+	endpoint = devm_cxl_add_port(host, ep_dev, CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	rc = cxl_endpoint_autoremove(ep_dev, endpoint);
 	if (rc)
 		return rc;
 
 	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
+		dev_err(ep_dev, "%s failed probe\n",
 			dev_name(&endpoint->dev));
 		return -ENXIO;
 	}
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index 25e6bce2457f..96832ab594d8 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -10,7 +10,7 @@
 
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
-int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+int devm_cxl_add_endpoint(struct device *host, struct device *ep_dev,
 			  struct cxl_dport *parent_dport);
 
 struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds);
-- 
2.51.1

