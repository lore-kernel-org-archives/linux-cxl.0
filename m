Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42195334C33;
	Wed,  1 Apr 2026 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054412; cv=fail; b=KwSRqAaVfaeKbrmM3EX9GTz+vAUi9OHxIVu6SEX8n/LXO6PcuV/UZazCxP1WQjKsgEQBZnIzS3j5a1BnCwYVSAPGOXrm8MfYdF7xElI1Z+J7mCQrdKF4kf0BLA/t7j4DueZpRK7kvQKpWr+DAOVffWpsSXyE/sBbRs4RdAcWDZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054412; c=relaxed/simple;
	bh=mLITaaSF/hQEef0DYZDw4Z3svxbDWJfm5lv7Nzj4wGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbZsVv4S+V9Sjc8r3Yh9L7ZRn61JmSFsl0+uMXjH2CTuS5WcCwbn5zQXqtkKgtxS/hC6BAovoqfmyPyYsLpcCqEAHTmxTRYlAmdOG6Oraw3CpEBS0S4lEpLfrfFmXMloH0vc1MMW3+IzL4bA5LTOMyh4eMlA5y1FEACaiqnwmZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MqgRsil5; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MqgRsil5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0K2DddsO//24Dn1LEssv1r5kK4MaJzeSyp/AeGRX+nzB6VnxcBDyDL3xYlN7TBr8Twgsye4KRLGcaK1+zzJX39tqCM3To/2yd4JU4wCbgHS2mnviBza1rhX7A4rFJiFwPsphJtLrmcVYyUc0Ob3HvfKzg6Suo8SIIh8ae46QkeFhkNoK2ShEqWzVFeoJcZ5f5J8j3lYGkya9/PFq0HpDu34K3dFqhr9RhoHxvb/LhEDvh/HX7fCENhppl1V/+f/uZ7i1fO1dfBw5ILGTgoAOFtVcbnmzXVNmwpbKO7TfV403YxmCNp93IRWiRu3dSqmtGXHPaFDlkyTu5jxop+UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkRf7wEtNWI768/BsZFgMUeT3a2fRvjzSz9z+MtPQ+c=;
 b=JQqID6mj+KJYGOU2ZKbketVq/AFWJ6o8yhYKgFIKr5J/skuDnKSSk/AxLFcKQWaoD+cr3UgMWXpfJ8xDubSbNN9jozgNqp7CClklQSnDcLU9F6TSw59dn/uqir3NhatvAJYdzOqpVNTaYqQDS4ZbPiEPhsavLCyUpHGDPaJDgnY4jC6n2H1T/z0+Fhw6xbmRdCybR9XR+I2jvvt00jV/zigtssymaU5VjfSW5y+HiQEwrYlWXrjktv13fW8pJro2S+o0MIJrpo9DfutgFlarVFujJFskxNvmh2cBU8eYvlaAOeI8I6Nl454524cok2+fxLwE5riodzi3Thz3z/4bPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkRf7wEtNWI768/BsZFgMUeT3a2fRvjzSz9z+MtPQ+c=;
 b=MqgRsil5JNVSyV5kNIeG3w2QaXxB+8nH779WWzGKa4jEYuao0lwUyz/qh6bpvNQq8RawZxTkzOTZc4JomQzfblAekJ9c4itWpgMUO0nqZA5SHCLImbgkM7r6XyWidZN8mQocuV5lwvq1dLWffnRT3/Hspzn+EhJ0AdcsGCNsLRhUMfuVqjQLc+1eq7O9n5cbydSMVmrF5WKRYXF6NFXqpUsG5iupK8djwnX28NpCjeI/Gm1hwNFCaE8K1YXycyrbazcSPGamHkfxaVaeKimctVW1CzHpVUdw48LBrzSZqmv4mfHiKqb7HL0g4STO/mMpf2BjSg6x73zAiapLvHwvew==
Received: from SJ0PR05CA0149.namprd05.prod.outlook.com (2603:10b6:a03:33d::34)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 14:40:02 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::b2) by SJ0PR05CA0149.outlook.office365.com
 (2603:10b6:a03:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Wed,
 1 Apr 2026 14:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 14:40:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 07:39:47 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Apr 2026 07:39:40 -0700
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
Subject: [PATCH v2 01/20] cxl: Add cxl_get_hdm_info() for HDM decoder metadata
Date: Wed, 1 Apr 2026 20:08:58 +0530
Message-ID: <20260401143917.108413-2-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 067925f1-ccb7-4f6a-cd40-08de8ffc8ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IEoMTu+JVJxc+lsiqIp/1+zqei3PadEtH0O8J+oM5J8sbLHEkVXhhVjKAO65T1ooIhpUUkU4qP9W3513daaU+HihJbLYXsatoM3L2JBKaBrP1yQZTrXl+b+thqlAzWEVbN6M1yZ3H4Z1j9i5oMBaupLtmoH9+h+UFzmDqZj+q9Yn4vUzVN7lWIcmwfMl993gSxY/izmT0HNrh00G5yyT5odCSRE9ZM3uFwSdkTveQWWP90jtBcCTYpRxDcV+Zk4MVMFzsVoxaO1ZqFl+E5xO/o9Z9lz+ie8ybXlsItExp/JnN1MfeaEkKWFw9T4Yxs7JyAM2ZQidpcqS+nj7MPoNWTBJJxamlX6dWsP5nAbB9WHu2tU2METoJ6kG35M7hI+/Kstz918ajE1PxWZUfHrnsS5pT6YVPR0vCgGuMBExZIFoHXMIphlHQYxTdhRVxqBQ9HWzlAE/f5wm5kEUfEOatzH7bxWjBE118qH2VoGfmTnzwtguEmgX0WPZ1ServMAUCSO0OhRamf1AL+dFzHP7h+xyRjsFVxLUq/CEL5xnZKRlY7ojFNtVD4QTXhMOg7vd7X+MDyxwwuBluh7UztIWFtW7dwbsWdvt6ihXSmoqJEPl9ByLO5lyk8dj2A5T09GJxtATW0LRXUT+oZDH+GX69scdUp0q3+fA4CjGvmYBnko0OiCqv3CRwpNBAqLUCap1jF2O7I+5OLRb/cxPu0cSi3XDmhb/toSBdBRi2Mt4nvny1QvZvjbrtF5Hj6gnR3boowdB5ymlar2VRepAf57+eR5Ar4qaA3dFWfj2GMYDRxjgXns/2ATkJyI9YhRlqrzn
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kTIHs4Mwhnefzy76luhyMoplRH7nSRMLyIvqJ3furJrlNIW/YsQpBjA1iUO+G/y6IP8qdXGms8MYjZgkDoFPFinURsw+BEWzAxfxNg4Lv6YCqsMPd2M6RjZL5guX4mjIgeVWvsjmDGvcNk3ICVJi79VrDigSKNKhIgXd+XILvH43/3pS11U9aZ2E2l7IrOZcXPI+Xj87RgzfYHnQa3TLV66T7vay75Y/Cu+s0Hce5Hgv5ua0wtwKr2AkT6bB62v1W+cfabL9mKtoLGuDzj2C5Z8GZrN8Rv4UX1ZUaz+hcunbluVbi4rnKNUPutwZ9zzrpt/rQc/T0HwFnYViAX6JMNC3Ff3iP+ESVpBlZS5QeLb09XWaYj5cMJwIrkRLaVOk21gs8/THd/Vj0qNhberGuXOjdhzj2J5ga03DREYoZkq/mq3RLd5WdNv3LpZUP3JK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 14:40:02.3926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067925f1-ccb7-4f6a-cd40-08de8ffc8ee6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617

From: Manish Honap <mhonap@nvidia.com>

cxl_probe_component_regs() finds the HDM decoder block during device probe
and caches its location, but does not record the decoder count and does
not expose the result outside drivers/cxl/.

vfio-cxl needs the decoder count and the byte offset and size of the HDM
block without re-running the probe sequence. Record decoder_cnt in
rmap->count when parsing the HDM capability in cxl_probe_component_regs(),
extend struct cxl_reg_map with a count member, and add cxl_get_hdm_info()
to return offset, size, and count from the cached map.

Export under the CXL namespace; stub to -EOPNOTSUPP when CONFIG_CXL_BUS
is off.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c  | 29 +++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 +
 include/cxl/cxl.h       | 16 ++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ba2d393c540a..a5147602f91f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -449,6 +449,35 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
 
+/**
+ * cxl_get_hdm_info - Get HDM decoder register block location and count
+ * @cxlds: CXL device state (must have component regs enumerated via
+ *	   cxl_probe_component_regs())
+ * @count:  number of HDM decoders in the block (from HDM Capability bits [3:0])
+ * @offset: byte offset of HDM decoder block within the component register BAR
+ * @size:   size in bytes of the HDM decoder block
+ *
+ * Return: 0 on success. -ENODEV if the HDM decoder block is not present.
+ */
+int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
+		     resource_size_t *offset, resource_size_t *size)
+{
+	struct cxl_reg_map *hdm = &cxlds->reg_map.component_map.hdm_decoder;
+
+	if (WARN_ON(!count || !offset || !size))
+		return -EINVAL;
+
+	if (!hdm->valid)
+		return -ENODEV;
+
+	*count	= hdm->count;
+	*offset = hdm->offset;
+	*size	= hdm->size;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hdm_info, "CXL");
+
 #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
 #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
 #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..e828df0629d0 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -85,6 +85,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
 			rmap = &map->hdm_decoder;
+			rmap->count = decoder_cnt;
 			break;
 		}
 		case CXL_CM_CAP_CAP_ID_RAS:
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 50acbd13bcf8..d86faebb99b7 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -80,6 +80,7 @@ struct cxl_reg_map {
 	int id;
 	unsigned long offset;
 	unsigned long size;
+	u8 count;
 };
 
 struct cxl_component_reg_map {
@@ -284,4 +285,19 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     struct cxl_endpoint_decoder **cxled,
 				     int ways);
+
+#ifdef CONFIG_CXL_BUS
+
+int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
+		     resource_size_t *offset, resource_size_t *size);
+
+#else
+
+static inline
+int cxl_get_hdm_info(struct cxl_dev_state *cxlds, u8 *count,
+		     resource_size_t *offset, resource_size_t *size)
+{ return -EOPNOTSUPP; }
+
+#endif /* CONFIG_CXL_BUS */
+
 #endif /* __CXL_CXL_H__ */
-- 
2.25.1

