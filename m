Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A7358375;
	Wed, 11 Mar 2026 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261335; cv=fail; b=XUF4asfE7CWOgmtWCJcGao3iWaJ/Cq77C66qoqMGEls8zkOsiVZL7Z4Bz9KN/Qt1DCspC8mNMR5JQigODtYcAImXhBs5mA/1zfBQOoQ2irJODxX/ZU7D3rQDyMo/BQiwEE/j+tA9mJcscZOKABFCJSTMlIrGJmFLotBNS+rbcis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261335; c=relaxed/simple;
	bh=3nq8XY2OV3X098s0CUAit0TepHy7Ig8vVAkhyLZlfY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HekPTtBK1hRjgaa/2c0vX9ZtgiIfSRopowNK4mK86KCwdmsbSmnCpaws6KsnNrB+kaQSkeY3AzD/MQ49Sn3uCzBp7Fww8PtI35HDt0075bq3OKXetYx6WgM/qjhJe56wtUV7zU3Q736yGGw73za0z8rK2NbY0WAePaYY0ByWwyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eV1HxA6L; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eV1HxA6L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEzCxlVo1YxCz9QAlDNjCzpHqHkbff3+VIH7kK66qsvejs8VQrY2/hmqeDo6oPFpUnT3zJYb+UETNEMzRoDltMBX06t2QYtb51eEV9HOjet/GaNtN9xsBPJEnBNeGrcylFa0VvQSX2kpD9cuBNBny7XOQkpGURq64D40KzqYfDSfJxCjnCVLGb38phReoGeKVB/FBnWmr5JGTsuAfBEsZyxLqpaFPxA/42WooNN4oWkU6HqNs0lb/AdcXmrJv7qtQ+uYhM9ZHooHv/ZNW7bGe7Y5PT3JYoBTxQwzP6OYfCepLWpVMJk1qe6Yrkqs3G/LdxFMJzdgaXTTzKTgJG4HaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Osg+XKa6H5aPMgxAt/rEU3OitwvLW1Z0Dy4kp30Qvg=;
 b=X+KqgbO/x8PRtde2h/yALeCUUG5vgoDxtCTnySSILAxNwZFHSCDWWniNu7WCXjXghP1H/P5BfKXPIp4zzUA39ZuNEQYKhDTCsSgYHY+FFiJETUWQsBF96SZU9q6J91arEwHag46+wAWVjHMlRJ5vSD3q0/08J/B3pNpvd6IKRVgJclh3rVEjqJjse/LHRgvX7mHqtk8V7XhQqKRr529mR1IWLta5G4MwVV9vVDOaLG6coYXAjU8SxBmZkOTb/2Vzl90LWuHCWskLu3OMe5TBSA8lk2AA726mRgN7rD65/pp74jqEmNEBP6Ba4pnM5KZ/B/z9lwPe70a46D1BAaiR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Osg+XKa6H5aPMgxAt/rEU3OitwvLW1Z0Dy4kp30Qvg=;
 b=eV1HxA6LopMio6it4W2YR5G/7m19anL/LGCTFcwQdoCP9jH4iA4RcC2EmNvfQqiH8aTF3TA1fwuWqlxv+sM3Yp2MDSLepfBoTjqzcJbrYxqOe+BB8eitfCgkq7iV+/s3Z40RRg3ajC3AvPnTzIJo4g5sRyOzRwWEhP32jyv1BSQT6xK/arB9wqhGjcm1+3cHzPoEtCowb7PJnGvh3qCf9U3Zgr3wxRUTPPA2zBxLgLuEwcplxtViQZrsEuVI32DOTxLV3zIDjSnq/484iY8d9EQ4NprbK1aLo1fWD1daJKcT7vNNT7VsQkhAVaR3xbgA37tEIHD/CZpNmjS9tBI5Zw==
Received: from MN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:52f::28)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 20:35:29 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::78) by MN0PR03CA0001.outlook.office365.com
 (2603:10b6:208:52f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 20:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Wed, 11 Mar 2026 20:35:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:05 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 13:35:04 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 13:34:57 -0700
From: <mhonap@nvidia.com>
To: <aniketa@nvidia.com>, <ankita@nvidia.com>, <alwilliamson@nvidia.com>,
	<vsethi@nvidia.com>, <jgg@nvidia.com>, <mochs@nvidia.com>,
	<skolothumtho@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>
CC: <cjia@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
	<kjaju@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <kvm@vger.kernel.org>, <mhonap@nvidia.com>
Subject: [PATCH 01/20] cxl: Introduce cxl_get_hdm_reg_info()
Date: Thu, 12 Mar 2026 02:04:21 +0530
Message-ID: <20260311203440.752648-2-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260311203440.752648-1-mhonap@nvidia.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fcae79f-0c6a-4c28-58c3-08de7fadbc31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s2gV3E4BhalTfvv37DPfSLKpf6Wo2e95ojmWnb/xRE5etLRm7z4HgRDdTQRr7QOO1/yyQuab+aaru5oYX4Z+is1tZj5qpQdw1ueu6Gj41K6SpZEJ5+IDClMV6+dpoN4maUWESD7QQRmy7RKWGSNVdRRQoNsuxeqmepqpx6wonHm+TU8bLrjES9EOAVNcAIxELcVHjjf3f8R5e5HwTsAsNGcpReS4cAAzJYcXf3ntr5Y0R6DHkWCWTRlDfv2jJD5j+v0F59oOe4hg0n0V93zZ0tpk3XvCwOY2qD694+sGYyhn8odlKyo4lYwlXWQlcYT3klYRr457NXZ61Xs7QTPYuAtCVwAJYtScb3pfPeuJ/xQROD3nIMxWr1POu9FJPjnmj52Wca3Wjn7iiC2ZS6XK+h6A1Ic0I8/ArsQ319Asmi7UzzhqE0acvBO53fIUwzQk2Ypd3fAYeUKY9g+IPQu2Y72zKPDCJ0lhvltUyKIkTfg83NEJRNPvc5rMtrHstxyQvMfSUD4UAXn9Ky293jkLy64Wp+4jUjQY6rO4NoqIz2z/vS3QLy+xCOsTQ2RUYjn7hJv3xXy4TFLRZOviMckCRbNsNKPAF3Sfz4ox0yPE3K5WB9DJZjjoXti5QJpD8VIOvhBkD4am8kNBcmy6u6RKw5ALFg8eEc04i2qhyJr/TE24np/14t/tox7wGnjSFfRemXSDu3Pt+dfun7lmsBXfYnlElB+XBbdKox/N3JlbNerG9cJ2eaJLKLsGkVICxxMfVjyhN9eXmGbw0H45fQ8QCorL2lyhas5vJXSgiKpCamKfNa6Qg4gBR/Brj6bjJ5B7
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZSjH68ZT1uBYukep+B0+tXW1gm0yhAbzAtiMfgSRQ6n4QWfaZ49VvhRKmPxaQSbcFXcJhOYvU40H75OaTStnC1bKIWHTb+2g2OofKtmtxxOHuA3AGvrLeMtiSQwaK51vNc/B8eb3dll+OIpMiRzihcRA6PnZWq0BkcxDHU6fNOqbEox7f3gkOMdNoh7c12vmcrkWK5Mknqq6Bjtfjma2JgSb/Ou+iAVdEoGgobfT7dKTCHEo6j+e4N5R6LC2KkOdDWmEJq2JuOWB+5ydBy7hiVhsf/IIkwbyYQ/J9+MhGh2O8yT5Cg+dDvy53CKdLOHkwT0WLx7cobQZVLDukhASVQiYdWHRCsNJNdP+w3VdHeLzm9KhmnYWQ0xdCxN14JggmhYnyx6vJG4ndtfoaq1Uvxlls64iFxVLmUXF2oljyZ4wa3lrHiNdChr3kVBK47J/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:35:29.4664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcae79f-0c6a-4c28-58c3-08de7fadbc31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

From: Manish Honap <mhonap@nvidia.com>

CXL core has the information of what CXL register groups a device has.
When initializing the device, the CXL core probes the register groups
and saves the information. The probing sequence is quite complicated.

vfio-cxl requires the HDM register information to emulate the HDM decoder
registers.

Introduce cxl_get_hdm_reg_info() for vfio-cxl to leverage the HDM
register information in the CXL core. Thus, it doesn't need to implement
its own probing sequence.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/cxl/core/pci.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ba2d393c540a..52ed0b4f5e78 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -449,6 +449,51 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
 
+/**
+ * cxl_get_hdm_reg_info - Get HDM decoder register block location and count
+ * @cxlds: CXL device state (must have component regs enumerated)
+ * @count: Output: number of HDM decoders (from DVSEC cap). Only set when
+ *         the device has a valid HDM decoder capability.
+ * @offset: Output: byte offset of the HDM decoder register block within the
+ *          component register BAR. Only set when valid.
+ * @size: Output: size in bytes of the HDM decoder register block. Only set
+ *        when valid.
+ *
+ * Reads the CXL component register map and DVSEC capability to return the
+ * Host Managed Device Memory (HDM) decoder register block offset and size,
+ * and the number of HDM decoders. This function requires cxlds->cxl_dvsec
+ * to be non-zero.
+ *
+ * Return: 0 on success. A negative errno is returned when config read
+ * failure or when the decoder registers are not valid.
+ */
+int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,
+			 resource_size_t *offset, resource_size_t *size)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct cxl_component_reg_map *map =
+		&cxlds->reg_map.component_map;
+	int d = cxlds->cxl_dvsec;
+	u16 cap;
+	int rc;
+
+	/* HDM decoder registers not implemented */
+	if (!map->hdm_decoder.valid || !d)
+		return -ENODEV;
+
+	rc = pci_read_config_word(pdev,
+				  d + PCI_DVSEC_CXL_CAP, &cap);
+	if (rc)
+		return rc;
+
+	*count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
+	*offset = map->hdm_decoder.offset;
+	*size = map->hdm_decoder.size;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hdm_reg_info, "CXL");
+
 #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
 #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
 #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 50acbd13bcf8..8456177b523e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -284,4 +284,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     struct cxl_endpoint_decoder **cxled,
 				     int ways);
+
+int cxl_get_hdm_reg_info(struct cxl_dev_state *cxlds, u32 *count,
+			 resource_size_t *offset, resource_size_t *size);
 #endif /* __CXL_CXL_H__ */
-- 
2.25.1

