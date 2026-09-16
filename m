Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599EE4D957E
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584368; cv=fail; b=iiXaUFP/gK7u9Kwrrv79ub3MVRfSX/D16DZgL0xmpAda/qEoaPmq6PGowFnxkER4r1xu9DY52p06c/4YdDa/G8rVLZ+THJ2NHnPbDImaojZqa8uRarbVugQdtHFKC1xucPTgyIXsmg/Io2A5YYigK5NfV9eocGKk/U6gEglkG38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584368; c=relaxed/simple;
	bh=QxQPZtPGhBUzwZSC/Fc9vqZTBI3ePYqNrPcpyFVcIik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6UOYx4msQtJTNkjW0v8KLOvk2GK44iidApL/Q2WnSRbC4JRreX2gFV0Y5Eqf60GDw1qFSD32W4XvGUC+gaCgkR8Q99ekHzcxAWRAIAdI0ICP5fGt6igrPIDLzlEvWJKfKC6rYcYwxdbckqI+eoPzbzfC/E8QebBh3klV/OX7lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sx2qOMPK; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sx2qOMPK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo80nOeU/azPoWHZG/6mpgweGvaCC4rS0/jhYr7st8GnlpzBrmN06Btg9RPJvzF+erPB27k+XGSTR0PUCZTyFN8h+rZTdjxY52UqBefceiqiyPVzuRQN3wt8ZcmmqLWvWuVs+2S+qLzbdJ13b2LrVvA6rOBhNsa6szg/ueL6kzdixePK3kH9xO9dEaIEki3wLHYYo5IDNwIkXJTJuiHdblL4XctfUu4XmcmOex2xhteComlpb4qmI8HRvxtX+HQZYkb+xGPojW6AWi3/R633HCMVvxOctcQMOpnFx/Rxtgez9pbBc2V9t3vz41lKEcXZwIaHl4GrZIbmiFhg3bcq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HYIhY8xUk/GnlniUBc+xfrSYEnR9rtzijxwlV84+ls=;
 b=R1MUO5WCjMTQGgzCy3O8hxXIAHvs8x39iGkyq8Ffwl9qPBjKZTcx4p59WE3YP+MhS6/VKAsGNVcV3oSKg8XWcabvtv7jORTbEXhWDi85lZNDCPoOXMaoxUtzGRk5lkVxhm4RjJlr1TSSZ7C+lEHdDKOAGkASd/NtZp9NlTjXIEwLL5AvmeHgkUVngLiSmO59BWioSUcOufJZNnZS6FdqPwT5Gr6aEKaFWdsUDb2dNh3OvgnzTMJHwgcYv7Q/T1aE7yIE6ZuNUUtdaPwrVNuEnrmX/TvG8AJqD2rzpLmXQmdiPjc+FQpR2IMuaBHYQxW2C3YuFWgPCMDHS1l/wAc+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HYIhY8xUk/GnlniUBc+xfrSYEnR9rtzijxwlV84+ls=;
 b=sx2qOMPKofCoRnZy1/wYke2YLRzmd4ueYMGEMH3K5QTozemi0mTGIrmMBiP5n6CxGmfK2wCKN1yT4ukJgADDlQzO6XypQiQvSkG4NaY1A/dEJOw0gvHb4640+uxzcbKboTYN7SjoGhSGaJjL0Vt0XqNqsV4G8W3IkxtFlH7AUgo6Cic6FYYvsHsPO+i/05Jz6iOHsV7LgvZ/H4bujr2YdnxkzYE3EBdFhxRcj3Sia61/24/1//tclXafo5cmAWLFZUOG1Lk77zEjCSLkpEhtaRyAXeFHcfi0Jp4IvWXlzWl92op5y1/X0EAD9H1gVKRz92OMr1M5GzQntV02HkhIfQ==
Received: from DS7PR07CA0015.namprd07.prod.outlook.com (2603:10b6:5:3af::26)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:45:11 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::76) by DS7PR07CA0015.outlook.office365.com
 (2603:10b6:5:3af::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:45:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:44:47 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:44:40 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <ankita@nvidia.com>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
	<pbonzini@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
	<richard.henderson@linaro.org>, <clg@redhat.com>, <cohuck@redhat.com>
CC: <kjaju@nvidia.com>, <vsethi@nvidia.com>, <zhiw@nvidia.com>,
	<mhonap@nvidia.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: [PATCH v2 02/10] hw/vfio/region: Add vfio_region_setup_with_ops()
Date: Thu, 17 Sep 2026 00:14:04 +0530
Message-ID: <20260916184412.3825713-3-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916184412.3825713-1-mhonap@nvidia.com>
References: <20260916184412.3825713-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bcbd0d-7c26-4bf5-bef7-08df1422a32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|56012099006|18002099003|22082099003|921020|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PCiD3oMXSEeCTQvfd4TxTupQcnSmyFmktQn/RU/nj13Ebx6/l1M65jCnlksGX+t83kblmxtaIxTRlAwTuOXab9k6P8p7IzMZUZBr0wIvb+9v+txEKOZxdlI8D9sd/SjUHmsPXh4bi4J0A11Kj4ZYeFjNnqRbvHSXBbmHXbjyDIZDVfq/DoYOC2cGCFtoRNNy3aNBMtUs+txqYo9T0NulDzavrIdNw+dm8Ro19tNmtYTALH4SWR2JLL39armmvOX9Tz+sRekPFeyimKlRpYLhMrFQcowzpkJljJccNZN7/xdwyCtOMyyNmtASc7JZtrG5Fb6+2DiYTv2a2N/w+vsrJno2JjZccSZvN3ZN4BZXTUQ4Dje+2mbdWQjxXfYAucYQg4YXWSiiU2eBv9hJoI56f0HCwVwKY7buXV/6DPInK2+9qmbe2ht1DIG0ylNheJaNR5uGNyQNANuaJfN0xTA4WC4C1d6nJf9ceNjYA53u7SH6o4bET2akWTeHJABEZ0pzKa/4zFnfzFcc2wDdKGHntuHr+S9U9iSyUJznOGpnU6vQrdtuoe6QxJDpXCJks8rP/AqTXbi9Xu/WPFjTw+45kEottiWlb4tcKpdZPaAl4n0zGanR1KlC2fgl4N9MHGqWxu+m7JHQ3iJmJY+ACL3EayixtfHaoWPAPGml64hRUlnCkZZjrqTQKo/QQ3BiudnMjk/7u+7zrsv1MmuMBdC7PzomXKZK9spBeaiaHK+o8e5mol3oETyKaQWvxYAo9EVy
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(56012099006)(18002099003)(22082099003)(921020)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TgKFQhfrDhcCqyA5K6J3nN0dXcxgawTTRPjNm6IAgCSqOFC4aGqQuZj3soy+QgPxPvrr1ou2Cr6COvKjNIlYrlSMDHYq7EBUrUAl0oa0Z3tTe4xkfNERjxy/E/2PDyuzgj1UL6J9WSXr+aIM5FIO7CvAIHz6MWmidSUSnIzkzGIOQpAuSUUOIiaOD9SeAVfsxH4KZyo45I5ujVi4xzK1BkqflZsDNtI4zalAthhxugudQujbmpzhGjZA0QGiSuhfEHuD+rBf9WwwZAgXuKYDkJ9fHFZ64VDo9MD21EFLMHU4wiytFW6qLeYk5CpaY0EbDZSBBN8wZ6gyV3SSyfEKSZhw5xvYx8HZngdbmgaQcK17xs4n53nRBN2O7/6plIN2V6DXbHlnuTSR0Bz+7NP1qFyQJ6vSFXoeX2fYQBtACIULcK6v/cEgqQmQcNzphz2f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:45:10.7543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bcbd0d-7c26-4bf5-bef7-08df1422a32c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device traps its HDM decoder block, so that region needs
custom MemoryRegionOps rather than the pass-through default. Split the
setup body out and let a caller supply the ops; NULL keeps the existing
behaviour.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/vfio/region.c      | 27 ++++++++++++++++++++++++---
 hw/vfio/vfio-region.h |  3 +++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 54ad11a6c8..21b54978b5 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -228,8 +228,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     return 0;
 }
 
-int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
-                      int index, const char *name, Error **errp)
+static int vfio_region_do_setup(Object *obj, VFIODevice *vbasedev,
+                                VFIORegion *region, int index, const char *name,
+                                const MemoryRegionOps *ops, Error **errp)
 {
     struct vfio_region_info *info = NULL;
     int ret;
@@ -249,7 +250,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
-        memory_region_init_io(region->mem, obj, &vfio_region_ops,
+        memory_region_init_io(region->mem, obj, ops,
                               region, name, region->size);
 
         if (!vbasedev->no_mmap &&
@@ -273,6 +274,26 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     return 0;
 }
 
+int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
+                      int index, const char *name, Error **errp)
+{
+    return vfio_region_do_setup(obj, vbasedev, region, index, name,
+                                &vfio_region_ops, errp);
+}
+
+/*
+ * Like vfio_region_setup() but traps the region through @ops instead of the
+ * default pass-through, so a caller can intercept accesses (the CXL HDM
+ * decoder block). A NULL @ops keeps the default.
+ */
+int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
+                               VFIORegion *region, int index, const char *name,
+                               const MemoryRegionOps *ops, Error **errp)
+{
+    return vfio_region_do_setup(obj, vbasedev, region, index, name,
+                                ops ? ops : &vfio_region_ops, errp);
+}
+
 static void vfio_subregion_unmap(VFIORegion *region, int index)
 {
     trace_vfio_region_unmap(memory_region_name(&region->mmaps[index].mem),
diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 58b236f113..8d5699013a 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -39,6 +39,9 @@ uint64_t vfio_region_read(void *opaque,
                           hwaddr addr, unsigned size);
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name, Error **errp);
+int vfio_region_setup_with_ops(Object *obj, VFIODevice *vbasedev,
+                               VFIORegion *region, int index, const char *name,
+                               const MemoryRegionOps *ops, Error **errp);
 int vfio_region_mmap(VFIORegion *region);
 void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
-- 
2.25.1

