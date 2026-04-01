Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012046.outbound.protection.outlook.com [40.107.200.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC447A0D8;
	Wed,  1 Apr 2026 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054489; cv=fail; b=nUQiC+s+yzu4e6QtpyQZW1dW0bsuLnmF0AHIpQgKcO7da+xmzXyO1mMrcgHZk0uTWiGSrvx4fFEZfhPV4oWjogqmSSDo9J0CfXWohUbrKMoVRo2gHe49e0krJbb3U/Gcw0vC4HQYmbVACceqfXhjjDl3EDsBuWO9Sogdl8S9vqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054489; c=relaxed/simple;
	bh=Lw0uVcR9spD9eS9Hf3OZfuiyknEVXzWTHirujhvnLmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXiGwfM0Z/+vkilp7adKKa4QaaurWy+8Q9Zqg8nD+fZ5eWqUMt4baPCEk4JZlAAz5EYsUhgKQGRf5S0hrjj6IuTZI3QrTpMyfwPJHy43IRW7og4lmAeyu1+3vmUWwC5msKk2vortYpXPagCgCs7P8Ho4PfM7GEaAkXj6+n/IFmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kUvJXZMr; arc=fail smtp.client-ip=40.107.200.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kUvJXZMr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V723mYaHGpn4ThMeHsiPJTdj0Tbw75UpJvn0f9LQK315NKCUkci18vZ05VX/xl1be0G4RTBoyzZlqRqjMSxUXHqhwT77ucqHSKJv5glDkjUJXhF29BgxLaE9yTePq9snUpJloIFTTC27htZql6MrSp51pZ33ftOWwITEvGX+UcVNLCIlWEP3O4NTTsK2gos4bzi68vlJWers7BI7GDxXmKIJPn5OPF4tE5BvJ02gbvQ2bDnSpStXz7fcUOMweTHZVszlpp532awLhQHKA1TrUhZJfelTd5gUoUMBhaCoGrtg8sRr2mI0cwuDpljFEGioWta2CHhVd8eUbA8XtfFP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eybHKM7jD3vuFPvkt9PjkwP5OvjxsGzWrZD5j/MYHw0=;
 b=euofFPcs07Y34YrenRojzy797oGBNHg8LPxZ10ymL71T9mZTvlVB11EPuP2QBuGfHA0nkqsUErjRkSb8ksULNKzpUffC7YdEtNEUQIJQ6PPVnZW0uNmvXoGaS78oeIXzW/wMBQbdYK/Wy0asI1MKujkRjBB7MGnQrew/OUTHDUqfEy1f92CIErwtylNsYO/gimLTVAJ7X0fCtz3UyeIpBBmlQboMQC0wK7FjrWj1YKY9tmxk9DXbA09EliWdhFsD6v1bJIwdDuUbA5xjiNZKdQa25UQAIEdd4c3gJZEEIFHGN7yGXYA7Ja+IXGc7RH4NreLuuJ0N01oti9gqOIwDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eybHKM7jD3vuFPvkt9PjkwP5OvjxsGzWrZD5j/MYHw0=;
 b=kUvJXZMrvU+NJaxT65wWaWUSmYZPU64M6uSDqTz9bDJD7aLq7xh58feSzd4UuvJs/4xwwK6cBXQ59R6lutobLqbdwTcBDzdY5aZFqGHG6yN7W728rZ4vXSDjUoedVjL3HCOrIOKrDZkwfx/1Nd0IT+PetD6koDiqaJVMZirOuhIOO37PjB+sNFhjtjHwrMlDbXr3WqAJREK5AVvI99F3RrA2CKpFYRHNHzYbN+1ds/M/JZ9i2ex9WN0ZZj7L/9BopnoFjpTZOjjvPpEoK+n0gAohKV/JAhJNTwQtq9d6Ll4gLlEAKYRJS3kVfVDOj/jVExGhkVUYWiyRr6cZA050bA==
Received: from MN0P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::15)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:41:14 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::72) by MN0P222CA0007.outlook.office365.com
 (2603:10b6:208:531::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 14:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:41:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:40:53 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:40:46 -0700
From: <mhonap@nvidia.com>
To: <alwilliamson@nvidia.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dmatlack@google.com>, <shuah@kernel.org>,
	<jgg@ziepe.ca>, <yishaih@nvidia.com>, <skolothumtho@nvidia.com>,
	<kevin.tian@intel.com>, <ankita@nvidia.com>
CC: <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH v2 10/20] vfio/pci: Export config access helpers
Date: Wed, 1 Apr 2026 20:09:07 +0530
Message-ID: <20260401143917.108413-11-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401143917.108413-1-mhonap@nvidia.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3b081a-2600-4f3f-2b0c-08de8ffcb963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RNZGaHUoGAM3hCrP0nta9/ANtTGTeMTZktHV4NIUDdtHRzcrzw6grKkmob1tAuNkM4hmPgTGfYEeJs2mld9kILX+Jw8gzjgpo+nWrTJizkaO8b3mAthQCVH8NJDqImN23g2xnDDVfzEaHeyox2N1vRQq8Oxwgedc9UEXfZClRSAY2nLPJcSw8Ix8DdiEnIh6oJ0br8NQMef8sUcR0HvH91rynLeZ4fMLOKxE0xuwoKUYEKlqW/7PFLL6jEUNdrDpjmacSG+NU1N6vADcDRH9r8coThO+qE1e+z+DlbJX7gc1794111FmEvydPuwsGKpRQwp9XLpbxpvKSp4B9w4hC4f0hS9B7xO6hhV/RLh56u43Yk0xk+iTc/Ph+FsSm0wM1hq4chqOQYyHvo4OOoG2J1b1WYJUosq6c6BCj90F02UdJXH0rF03RvXQMrEYdSNgvud5G3E0CH6hkb3m576dRTu+Bt5KJSMZjlpvA15C6aJ+EAOCimmVQF42J6mzVSkOe/5rg3TBra2luoVPO5UBepICSvTsVyYZSpO7kyArHPFFldqPL/OEC4AtzdXwZL27K1v5gkTArQB7oTX5aBlG3n6gUjXQ2hHkHwMoiZnMPTv1WJCmTs+I+U/+1Njkm4F24ULAuhGd3jVQGnAGe7pjpyS1R+3H+M3UBxuxjIYRHzrrn4mg5+0SLZe8CVAJvTWqgUvhPfGZjChC5iQMEzGD+K5gk+HVQ1JA51LhAU0KUuP+Qa6iDycVneLniNmcpE8JaovG30BQobwdQ+RumatRV2MGgsjNdPty4/bhl/WGo21iAhSHzBo+O9GGQXxH/biT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qgcrKivPlhqN7ovLM4k5Pra9oW67D+nH6UsQmPCxCBCtSpjt7vUpHUq4rFuVqj3H0aTi5uefrZ79deDjtwEmMM/MPvpOIf1io4OJuoZHBB0ROb2g5qMxgt4TGXrUgwxvnk4b92pcc98pQ/1eLEbeCuHeFb53qJLBEiT/Vmj4+G76esVaw0Yq5mIzTCcIFNUAS8fefjeHUukruoGXqH7DcG6LssW6TVYs1e0f8m1HCRMKuPoiUzaLDfCTbCOAQtsj2ad2k/8dZDYP/6wgsAWbsyWqZEC+SA4/OxuX4xj+YsBKz5+jjpgh91QMg5rmnCbOL7YzQy+Ahoyd2f3F612gzRpadwe7OCZwae/0AbgmwLlC/QC2HlIUSrH4AbvqmMUmlIgG7NYiEOZWdIOBBJMqhiDeiNGOYnhknYrHhQ9ejf8PdXbqGOyFlPlOCRF9aHdG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:41:13.5875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3b081a-2600-4f3f-2b0c-08de8ffcb963
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

From: Manish Honap <mhonap@nvidia.com>

Promote vfio_raw_config_write() and vfio_raw_config_read() to non-static so
that the CXL DVSEC write handler in the next patch can call them.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 12 ++++++------
 drivers/vfio/pci/vfio_pci_priv.h   |  8 ++++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index dc4e510e6e1b..79aaf270adb2 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -270,9 +270,9 @@ static int vfio_direct_config_read(struct vfio_pci_core_device *vdev, int pos,
 }
 
 /* Raw access skips any kind of virtualization */
-static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
-				 int count, struct perm_bits *perm,
-				 int offset, __le32 val)
+int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
+			  int count, struct perm_bits *perm,
+			  int offset, __le32 val)
 {
 	int ret;
 
@@ -283,9 +283,9 @@ static int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
 	return count;
 }
 
-static int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
-				int count, struct perm_bits *perm,
-				int offset, __le32 *val)
+int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
+			 int count, struct perm_bits *perm,
+			 int offset, __le32 *val)
 {
 	int ret;
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index d7df5538dcde..1082ba43bafe 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -37,6 +37,14 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 ssize_t vfio_pci_config_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			   size_t count, loff_t *ppos, bool iswrite);
 
+int vfio_raw_config_write(struct vfio_pci_core_device *vdev, int pos,
+			  int count, struct perm_bits *perm,
+			  int offset, __le32 val);
+
+int vfio_raw_config_read(struct vfio_pci_core_device *vdev, int pos,
+			 int count, struct perm_bits *perm,
+			 int offset, __le32 *val);
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
-- 
2.25.1

