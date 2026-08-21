Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DF436BF8;
	Fri, 21 Aug 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323356; cv=fail; b=fJ+3Z5vWCpAvWn4iIwO2p33uTpH4OhHcYflLtwq9vpBYOv+N4YwXWgwly2vmW5HE+vvPf4ApsPOWAmOxso4O3Q+wM9WB9oLQFgTtUTBWuTFYStYjSR40hOKqw/6e8nRajwPOL3zv3xFAK6sm9FOIjx79SAypnN6Md6U6m0I/CHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323356; c=relaxed/simple;
	bh=0EGmrmKn+I/KfUjnhkqHJXRDaNa6GMjuP/jRIryQWTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lY6+lEZnzy00n146o3knaZ6eZX3YD62ZfpojOKZm7c5KZ1shSAwped++KYin/yyOkJYGIRn0WLfw5qkk6lg8+3LO0kamlAWVrDxhxZ3whBsvBeDGavUo6zpy6wy/oWS4sJDZY9fCVr0zj574T1xi4TltlEimw/HMc/G9MBoCQ6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hUviM4+f; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hUviM4+f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJJ4GRqwUI+5N1uYA7rrrAjllJ20MyQK+a8KXeuiagIhlAOAx8XH/M4TEX9MrgGxPG099eRbqiJilySw6B81oDarxGd9G+x0IsqtrhqnsIqlYPnzk15ZG/fmpN233zWOxWnJoGiq1k9QhTHBiqGf/iMJjCOgTzz8pluPJCfs/QqSKr7tw6VHbMUINMfH1KIxDVptdWZOGMtk441LCAgd+DyPnsxobOt9HiN8kk0Ej6ax0giwbcKQshIVl+XqSDw5EFt/pOteD5emOukU+O2dmKFaoDdZwHsQfCGkL9gUyrVtgOkjXWIxMpagdA/oiiv/Z8O2beVTsyqFEzXaSAMsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PP5+kR294StNLV6R9ZHboIS8N1C32t7qjueNQzQ+4Tk=;
 b=gaUVkDbNqjfEiIviEmbGfvXJWzdexrA06WIjcqs9pgy09g9D7n5COGkM5eienhCdvjyiYIR5c/5O/UDqk65YjnRkDFeUkayUBmiHUT1u5m5hICQVZPDUIFl6wY5ucCAVaz7cJBYu5Js0tOjahr1debmZD/SgOZbevGu8EoG85vdp2Lu6LbWMAVxrzO21l9FDG7Kn/jQZLrp3BteG20HJqwkZMGcKTvgXVxsYWyVKYLE5olGjCD7LsfmnLt5hf+NKiHh7U6RvQbdurcHWfuqymgem1j2/OHWYFAnylXgPbcD3xZazY1apsCo13+4IsqNkqstt0uJgwOU0unU40q9w4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PP5+kR294StNLV6R9ZHboIS8N1C32t7qjueNQzQ+4Tk=;
 b=hUviM4+fq2GLi0LQfB2+k+t+gpvvFsx3wIhbDTRHlG+vkW4CkxF/EcyNjlNj4mFpaJhUk2LJ20ygFtIetKlKDD+p6ByL2u+5zE5mXNL8LPvk+Uuzdk/AF29HPwKXuoAnToELx6Bx0hOIIJSxWJ9hY7af9Z1TGCGYtgvZNa7/kuw=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 21 Aug
 2026 14:42:27 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::8) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 14:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 14:42:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 09:42:26 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 21 Aug 2026 09:42:25 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 1/2] cxl/memdev: add support for mutipf device
Date: Fri, 21 Aug 2026 16:51:33 +0100
Message-ID: <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: f01747fe-0ce6-4da6-9bcf-08deff926bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|6133799003|10067099003|5023799004|56012099006|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	c9EKopX1NUZEU6BCcp0yoiFqZovref8pnd4iEEUGA5/GV7U2O15yC3G7CjD178j6XtTfLLOOwRk5FGwvESiTG9dMQOWPwrx+tX92U6msI1YHDjxx6xKhmlp3TgZS8ufTZEb7seMyGSofQaTFsAEbenQ7HfR9CollNtmrsis1baSq60X+WsAyJN4mfqJ3mgNzT8o5jG94ddAS/Jfs9ZtDSxCw0vg6uwkh/vKySpviBCyqO4NOeHy82x9/u6VBUZe9TEYyU19gbyCgpu0P+v2TBjMcrC92X58n/mvC/q7tQAgBSf3cDDTGvAE8KnqRMPsCOwCQJ06AFcHZCIv3Z5HeACBR/OSFp/5gWWRWiDayVUrpR8MKkV1/MST3acebz1WDqgJT0RL+wdGA1nnioup4kKO6mDXG+EPV31JRV2OtQop43U7hXLucTYI13aKI2bPREEBwp91R2BZt/LuoqBMf8E3Gvu4909CjymWFXw/eIuXi/GdyQeO2boetFvq2EIgEigZFKumiAt0Hpc59ziRZgSGaFIB+Nw9h1k+RVPXt44r/D0/6pc0gtH0dP/wNYtH7u6cPg7O2+oC+w/RlFL24i0MgbOEdN9sj5SYKt9FWtU0cdkaphJT9bPtEeMv9Kj5DxcCV8dPOC+jSXaYeM1koJAWFCzXbH+3teWXv/3kHAqDWw9yhO6m+nN4MZLcTWGQ6+n91KQ0RFpSTHmApJ6w71A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VJvETNt3NS6rcZC0O59G2P38a0aPSqgGL3ni1qkwaQz2FlNSFfDVj0ciI7ypyqJDs8yoUskmn9mDU+Qq/2XJqTYGf51uGzT43mN25v1gnH+Jxg0H4S2Upnf/Y26YJmDHPt57fam7u18panQW6zhn49t8Yr8Rds7kfyVpJBezGglvbo7jj20TupPENZERlFrSOaxp4PKd6ditVgse6jUpD2FWieEgTG46DEGIrik4vASF6OWRFcth1GrxHvViWoPMVvFk3sUiCGXYfelgV76124hTX2siwogL7u/Xj7sedRZ/ud39ZYM1V6cq4DjfR3mCLM2qr6LeJDB/uhF+ryP9vtnnXX7s4B5bqfF3NMm6uM1JqYCFFf4bSXHlpvCbigDdvGF0r6RPD8lXpCOwCWjxf/ReVNrb2zJBwSty3PrjrQo4XS8jG9DhAXZIj+QFk0Tl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:42:27.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01747fe-0ce6-4da6-9bcf-08deff926bc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

From: Alejandro Lucero <alucerop@amd.com>

A PCI device can present multiple Physical Functions(PFs) but the CXL
specs restrict to the first one, PF0, the discovery and management of
CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
obtain the CXL.mem range to work with somehow.

Although this could be handled internally by an accelerator/Type2
driver, it requires to properly handle changes to the CXL mem device,
mainly its release by the CXL core, but also potential CXL device
resets. When this release happens, those other PFs need to be told about
it.

Implement a way for non-PF0 PFs to register/unregister to the memdev
linked to the PF0 device. At memdev release, trigger the release of
those non-PF0 PFs devices registered to such memdev from the driver they
are bound to.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 122 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |   1 +
 include/cxl/cxl.h         |   4 ++
 3 files changed, 127 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..327c4da3208f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -26,6 +26,35 @@ static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct device *parent = dev->parent;
+	struct device *sibling;
+	unsigned long index;
+
+	/*
+	 * Type2 multipf support implies other non-PF0 PFs could be having a
+	 * temporal reference to the memdev, only for registering/unregistering
+	 * as sibling, requiring to postpone the memdev release and the sibling
+	 * management until no further references. While detach_memdev() calls
+	 * for pf0 release from its driver (parent device of the memdev device)
+	 * it is not safe to invoke for sibling PFs to be detached at that time
+	 * as it could race with PFs registering/unregistering as memdev siblings.
+	 */
+	if (cxlmd->attach) {
+		xa_for_each(&cxlmd->siblings, index, sibling) {
+			device_release_driver(sibling);
+			xa_erase(&cxlmd->siblings, index);
+		}
+
+		/* Several possibilities trigger a memdev release with one being
+		 * its parent device (Type2 device) released from its driver. If
+		 * so, such release is the context for this function, precluding
+		 * the mutex lock and therefore safely avoiding to invoke the
+		 * release again which would trigger a deadlock.
+		 */
+		if (mutex_trylock(&cxlmd->dev.parent->mutex)) {
+			mutex_unlock(&cxlmd->dev.parent->mutex);
+			device_release_driver(cxlmd->dev.parent);
+		}
+	}
 
 	ida_free(&cxl_memdev_ida, cxlmd->id);
 	kfree(cxlmd);
@@ -795,6 +824,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, fops);
+	xa_init(&cxlmd->siblings);
 	return cxlmd;
 
 err:
@@ -802,6 +832,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	return ERR_PTR(rc);
 }
 
+static int match_memdev_by_parent_device(struct device *dev, const void *data)
+{
+	const struct device *pf_dev = data;
+	struct cxl_memdev *cxlmd;
+
+	if (!is_cxl_memdev(dev))
+		return 0;
+
+	cxlmd = to_cxl_memdev(dev);
+	return (cxlmd->cxlds->dev == pf_dev);
+}
+
+/**
+ * cxl_get_pf0_memdev - register as PF0's memdev sibling
+ * @pf0: device for PF0 used to match current memdevs.
+ * @pfx: device to register as sibling to PF0's memdev.
+ * @index: where to register the device in the xarray.
+ * @range: to be set with the PF0's memdev range.
+ *
+ * Return: PF0 memdev pointer or error.
+ */
+struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
+				      unsigned long index, struct range *range)
+{
+	struct cxl_attach_region *attach;
+	struct cxl_memdev *cxlmd;
+	struct device *mem_dev __free(put_device) =
+		bus_find_device(&cxl_bus_type, NULL, pf0,
+				match_memdev_by_parent_device);
+
+	if (!mem_dev)
+		return ERR_PTR(-ENODEV);
+
+	cxlmd = to_cxl_memdev(mem_dev);
+
+	/*
+	 * we got the cxl_memdev and the implicit get_device in bus_find_device
+	 * makes the next steps safe.
+	 */
+
+	xa_store(&cxlmd->siblings, index, pfx, GFP_KERNEL);
+	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
+
+	/*
+	 * The cxlmd object does exist and it can be found in the cxl bus after
+	 * creation but before attach probe setting the proper HPA range. If so,
+	 * the caller will need to try later.
+	 */
+	if (attach->hpa_range.end == -1)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	range->start =  attach->hpa_range.start;
+	range->end =  attach->hpa_range.end;
+
+	return to_cxl_memdev(mem_dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_pf0_memdev, "CXL");
+
+/**
+ * cxl_put_pf0_memdev - unregister as PF0's memdev sibling
+ * @pf0: device for PF0 used to match current memdevs.
+ * @pfx: device to register as sibling to PF0's memdev.
+ * @index: where to unregister the device in the xarray.
+ *
+ */
+void cxl_put_pf0_memdev(struct device *pf0, struct device *pfx,
+			unsigned long index)
+{
+	struct cxl_memdev *cxlmd;
+	struct device *mem_dev __free(put_device) =
+		bus_find_device(&cxl_bus_type, NULL, pf0,
+				match_memdev_by_parent_device);
+
+	/*
+	 * This is not an error but a possibility if triggered by PF0 being
+	 * released which triggers the caller driver releasing pfx. It should
+	 * not happen if the caller driver does the release of pfx independently
+	 * but we do not have a simple way to ensure this here.
+	 */
+	if (!mem_dev)
+		return;
+
+	/*
+	 * we got the cxl_memdev and the implicit get_device in bus_find_device
+	 * makes the next steps safe.
+	 */
+
+	cxlmd = to_cxl_memdev(mem_dev);
+	xa_erase(&cxlmd->siblings, index);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_put_pf0_memdev, "CXL");
+
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..430014c4a046 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -54,6 +54,7 @@
  */
 struct cxl_memdev {
 	struct device dev;
+	struct xarray siblings;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
 	struct work_struct detach_work;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..883ce9f1b73f 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -228,4 +228,8 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
 
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
+				      unsigned long index, struct range *range);
+void cxl_put_pf0_memdev(struct device *pf0, struct device *pfx, unsigned long index);
+//struct range *cxl_get_memdev_region_range(struct cxl_memdev *cxlmd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1

