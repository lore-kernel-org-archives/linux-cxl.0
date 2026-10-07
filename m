Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B16495AF1;
	Wed,  7 Oct 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364017; cv=fail; b=FbJhIxRAs/vBW6UXgj9ibQ6qW8HnF6YyRvas3G8YQ3itKV9OZV8qzhkjvuzmj48dy+kfFb/KmoPyeVeIIeOXK9J/+p1Epv9vwbzaWSOACT2q3qbtvyfRW3NtC1MerR1mKbqJm0oNMttIoGiNfIzGMTjTptCfu4iTI6Ng5VIYd0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364017; c=relaxed/simple;
	bh=jDcNznOAArcFiz8xAav/fVy3ij7DLV5/JkBsEuis64w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVfhiN+4xUN+motldzOtwWUUPdibGUaM9pdpZpULL3vOOVi4qmD1nnUgWfEaj0iC1npy8U3KrVueVMHOZy4yO5Fl3u7XcBIrkKY3J5POiDQizznQwFhJP+z0cdCBdJVJ2WARFYnDKgkfIkNfap13mVCS0z+XH+bEQaXMKeEvUA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ntb4U0n9; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ntb4U0n9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfdQwV90H0OD9ZacSStBEndJAX1R4iq5DoJev5Cm8689AbQWbao+uGbMeLkb7od4b2mujQ1xOeo+J6aXbwNWD5U8ocuxyIh/H1ZIcVc07/O7Qsv4ZJ6nNxAZ+gZGBQ9ClOvSOwMo/zYvaW4N//hXQJKGu8xzwJsBRyrUe/xjFpmQrSrFtyzhdG2RObr3BkKu/2IKwSNpvtQmoN/gvCsK+rm7dvDsBkxfnBqxiAPsF6Yt3sGo623W2J4IR0hpxXP64OREblZIzqKB5guT78YqiZ0RBImbG5ZNpDYFyT7ktMNo07B3lXqWgwQFjXb+GXcDJHMTE1SypRpMer1UMac/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym7Cgc9lfaST3vCgYAFqBUwBX3nfwTSY+N7mmwDRxoA=;
 b=gSlehxRB9Yk1V0U90ycRxC52QXE10gnhamHdv4AeCMFqJniqfR3h+gmTo2zA5jCd2YroJe+vOI8/HcKU3UnzlwtRADIpdXgxDej4vF+gNA8awoIouQSHcYC0XwZ8u2pbv+bHhDc7isrNq3XB13kSiBkspejps5dmYiXw4ZDgDdamRcOZT/i7apdR/2NNN3EvLvyMT8T29LT1TD7F8Uc7E6dBRMmsgU2IQKcC7NhHPto6gY+mRhAwoS1YuUm9sSukVDUMWe5nBAa70N5KmSql41FrUM+nM8nFf1q27mAVIq5nWa7xKH5CUCKXEiL40HwNZPIa9/s/HePBGFkNHasgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym7Cgc9lfaST3vCgYAFqBUwBX3nfwTSY+N7mmwDRxoA=;
 b=Ntb4U0n9u7HAvLDG/rB3EE7cRMRE7Tine9rp1dNpvgv4KZkvPZUTM9PWTVUoesUuSWfs3/+bIfewhtX0Py8YtsVu8bO0ZczinIgcfUGwJ47TH1oHeJIEUNGz+FCkSyLo5GNLEJpO9o/pYgSVjf7ipMt4WLXH7RosCva+b//4pREbySiG6zrUng51cQpm9JMDtnfVamgMKzn54SOKHewYObmid387s2DAY2jiV31YTKutS4sUGT6CZcL7FsA/9nT2VIYYve54bOczAanYHbMoXMLgoq2bOk4MSJXXhoJ/RQnjc2XEM4GpfoBwmVF+v4mAVT6jj2qldutAOIrEs/ZpfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:05:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 09:05:54 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com
Cc: kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/3] cxl/mem: Separate provider registration from region attachment
Date: Wed,  7 Oct 2026 17:05:37 +0800
Message-ID: <20261007090540.43817-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261007090540.43817-1-icheng@nvidia.com>
References: <20261007090540.43817-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e035df-73fe-4c1e-2ca3-08df24523137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	p1GZKkqYfzqJBOKVz+07d/XWr3Wnfkj/FkRjSBO1mthR6GDplvb+Xog3Z+0YjYY06dQqwdqbOcag+3RHAqMakTAkaXyR85TBlB/25hxZpsMn3gwASYNA8xlCqVVZeDiHGOGpma/h8vi/y9aU7sHv99AT5YVkxc48wZzD/AhfGeUujpgj9Hb3GKYlcx85kKzHtk4YMwJMFthxHBOKlqFD6BQJkG0Koi5OTa7UuOroZwzj7lME4T/g3iu/FH73BaUTaH4EEaB1Dd1jaYutat6QDhEPu1KBm4eSStUGyZ2iyQYCPi9Pr9vzs/8ob/FwhWTh6mrqWDoKW+sem1cgFzGgb/N7LwLRwcTB+0IDtKdGrsDFSiccheQulIO22lDfPCsofy4RKQ6r7vXf5CmGp/VHiE3te2V+Cj2lZKTAC7A3hZ+va9jBxxNcgaL09SuJ4KIvZhwj39jgLj+v/UmvvctI+nKuYWMwkJzz1CC8ndhwCE7hD0DctBaO60Xk7JNJIyhiGCqZ3SC783Vuq9Ydb958XSWwfanz4lI7HSBVEutvKGAYIKwI8mu7rh7Q4lnEWGM3LxTbBSUYZeYvdfIybt2iTuzAhIY8RZnBJqOKeEWneQ/M943VP1YS1i5x5Np05UV9Lnes1wNpjTJEC44sVec0oqxFJa/Y57/Cf+AUNI5Xpmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18Trko2AYHB60YwnkvH8PV4N/mXGvrXXbBvLnE6gi8ynSlkMhjoaX+MuxFJa?=
 =?us-ascii?Q?xSjNeJbAwEAZyhmavF9jrJk5rkevndYHQGPKoCWVbmMCleaGZdfyApnXMX+L?=
 =?us-ascii?Q?0GLBqlABooo4mNmkvSCnM414hEFrfLjHNb0SRMZ+/Lf3qBBOg0CdtkKuvD7w?=
 =?us-ascii?Q?KYftvoyvyxmP8nHiERr/Mv9JhkBqN1XqL0znigKSIX+Np//h8P6OgiTaTPGp?=
 =?us-ascii?Q?hmTQ61rHgtroAsg9WsKA/YblvR4AecXuN/ssSWIf4zLt+WGAb27WqLHUauy3?=
 =?us-ascii?Q?sQ6ufXVKDKYj4ZAhKB1j6TfMLRUxvxjPXVmLnKXbiYHesYjHx7LGacRDoaE9?=
 =?us-ascii?Q?A0xVMpMw4HunBs11kHR529HC4wxt7ruxNs8dI/+gAlx9P8GZxgimRPuWFVgR?=
 =?us-ascii?Q?ekxcixUWnW+xuN+kUm8YCQ5FILrGY8TT/muEpIWBpKyybKtLt8/h+RxSXuXL?=
 =?us-ascii?Q?wtZrb3HmLd3exWnxoE8c/m+KQhqNcLTePF2slp0xyPa1SOF8OEXL59esZaed?=
 =?us-ascii?Q?yqzxs+SarP06Ak61QGTm7o79nVeqUKtLYrWP1h8MtXsR6eP2DZ8GDMfcHSOo?=
 =?us-ascii?Q?fz94O1whdO5sr80RjecvTRHEdrReSnqofKDhDtPn/o/Kmw62jtDK99JmS79+?=
 =?us-ascii?Q?6iDjoy6L5TAZDLpbVsO4PwPNvHa7E6g3xdd7hoVEMH5KZkesSzCNw3pUz1Dw?=
 =?us-ascii?Q?xjF9jxm+2jxdLjInAXNuyTdXhGpTM0gIyi/GAn4cbNUsLWiIrnUcIqq2sIyg?=
 =?us-ascii?Q?5s8wh/yGekWsyVZZRGQ69X9V1zZJ/qMJP+c5FkBGvBYSoVuJPdiwGx9ho27U?=
 =?us-ascii?Q?GZBES4Mj4lNhD0qDyolehaw80B58lfWakSE5Sn9AJCf7voq66xLCuHLOBb85?=
 =?us-ascii?Q?y1EuFqn6X/cB4dmYnVdJY9vXZZQi84CuESKxtvQXUsO5hVx5tm1K6UlqYk0A?=
 =?us-ascii?Q?59usLOnRh4cYuXSneUgEHvpuHkeOqgTqmOnZTHd8nRrkZ3KblJQx6J9lB6Lg?=
 =?us-ascii?Q?FEqRJPCLQzNEtojH21hxWyZ/1bt8WD2+/dHQqXvnMQ0ColtaMkw3/IFcvzQU?=
 =?us-ascii?Q?1hgWVGty3IXBEYTISe0diquRDO0CQixMWz67x3njEa1W4UYEQ4udbbCbo3C+?=
 =?us-ascii?Q?/rDc+69OUI3xlJq6fYuD/H1BL2zcPi11CMXeRx5JNsjfPeLFBIyaL/rvmtb+?=
 =?us-ascii?Q?vgqbSWFTSmCzOtg7hW9/AFgz2Svd6f0dnmgTVGPyPfpynMMxP6AmNbAP6Isg?=
 =?us-ascii?Q?E2elbnMp54dfcBC+NTXQk8ZMJGIomur5Q9fAokkPJcWxV+w1x2mQKdaynigC?=
 =?us-ascii?Q?AlHxUMCKRj9KHQCtQKc1MFsG4NN8iuducMTJRV/61Y86jurbE6HfeBKn09Es?=
 =?us-ascii?Q?tzqwTFztfMOFFnp2efrxIrYot2TIXAwOcRYUEarylBuYqznjckEPG7ns8mEG?=
 =?us-ascii?Q?nSJh7hyWyBsiJU/Olr3ruk9GbaXNDA+LLkXG6DZKpY0/cbH2M8kBbXqwWolx?=
 =?us-ascii?Q?IPzP8zQB0OEz0+p00hhaFh2K8yEa4wWLtjyz1l/dnhWpkSYZUSUvf4fN7mJv?=
 =?us-ascii?Q?t6Gqj+LTTrJdcIw31hJ6J8zd5rFHviIaoIkaYP4ZDW/s7F3Tu7H/cHtNZ+ck?=
 =?us-ascii?Q?TegNej/woPQR/BFXRNJ0uHiJfr0OobuWsXOnmQQMbOHSYGdBjEZlwA4jM3vy?=
 =?us-ascii?Q?W4vpMBgKMxuXslZHJMCPYm+QDxEldwIW3a9nAiVEed1Pvu4qNWmS9cYmKzop?=
 =?us-ascii?Q?5obgtVajEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e035df-73fe-4c1e-2ca3-08df24523137
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:05:54.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTpLgeaOwK36uyNSGbjs28nD0sq3EKS2BtBx1bLKKmpCAu2d3jQnJoYjNi48rtThWxftJ/EpQJiZVTh7rNac9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

devm_cxl_probe_mem() requires a committed region when registering a
provider-owned memdev. If FW has not created a region, registration
fails before the provider can use the endpoint topology to provision
one.

Make the attachment probe callback optional while retaining a non-NULL
descriptor to preserve provider ownership and handling of CXL link loss.
Install endpoint cleanup for FW-discovered provider regions even when
the provider never requests attachment.

This establishes the registration and attachment APIs needed for
explicit region provisioning without introducing region creation or
allocation policy.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
- Rework the patch into a registration/attachment refactor, following
  Alejandro's request to separate region provisioning from memdev
registration.
- Add devm_cxl_register_mem() to establish a provider-owned memdev and
  its endpoint without requiring a comitted region.
- Add devm_cxl_attach_mem_region() to obtain the HPA range of an
  existing committed, single-target region after registration.
- Make the region probe callback optional while preserving provider
  ownership, synchronous endpoint setup, and hdling of CXL link loss.
---
 drivers/cxl/core/region.c | 146 ++++++++++++++++++++++++++------------
 drivers/cxl/cxlmem.h      |  22 ++++--
 drivers/cxl/mem.c         |  69 +++++++++++++++++-
 include/cxl/cxl.h         |   2 +
 4 files changed, 188 insertions(+), 51 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5ef0ca0694ff..7a64a730587d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4111,67 +4111,123 @@ static int first_mapped_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
-/*
- * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
- * simple case of single mapped decoder per memdev.
- */
-int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+static int unregister_memdev_region(struct device *dev, void *data)
 {
-	struct cxl_attach_region *attach =
-		container_of(cxlmd->attach, typeof(*attach), attach);
-	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_region *cxlr;
-	int rc;
 
-	/* hold endpoint lock to setup autoremove of the region */
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		cxlr = cxled->cxld.region;
+		if (!cxlr)
+			return 0;
+		get_device(&cxlr->dev);
+	}
+
+	/* Unregistration needs the region write lock. */
+	endpoint_unregister_region(cxlr);
+	return 0;
+}
+
+static void endpoint_unregister_regions(void *data)
+{
+	struct cxl_port *endpoint = data;
+
+	device_for_each_child(&endpoint->dev, NULL, unregister_memdev_region);
+}
+
+int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+
+	device_lock_assert(&cxlmd->dev);
+	if (IS_ERR_OR_NULL(endpoint))
+		return -ENXIO;
+
 	guard(device)(&endpoint->dev);
-	if (!endpoint->dev.driver)
+	if (!endpoint->dev.driver || endpoint->dead)
 		return -ENXIO;
-	guard(rwsem_read)(&cxl_rwsem.region);
-	guard(rwsem_read)(&cxl_rwsem.dpa);
 
 	/*
-	 * TODO auto-instantiate a region, for now assume this will find an
-	 * auto-region
+	 * Endpoint probe may discover provider-owned firmware regions even if
+	 * the provider never requests their HPA range. Run before decoder
+	 * teardown so those regions are unregistered, not just detached.
 	 */
-	struct device *dev __free(put_device) =
-		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
-
-	if (!dev) {
-		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
-			dev_name(&cxlmd->dev));
-		return -ENXIO;
-	}
+	return devm_add_action_or_reset(&endpoint->dev,
+				      endpoint_unregister_regions, endpoint);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_setup_region_cleanup, "cxl_mem");
 
-	cxled = to_cxl_endpoint_decoder(dev);
-	cxlr = cxled->cxld.region;
+/* Caller holds the memdev lock; attach to a single mapped decoder. */
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	int rc;
 
-	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
-		dev_dbg(cxlmd->cxlds->dev,
-			"region %s not committed for memdev %s\n",
-			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
+	device_lock_assert(&cxlmd->dev);
+	if (IS_ERR_OR_NULL(endpoint))
 		return -ENXIO;
-	}
 
-	if (cxlr->params.nr_targets > 1) {
-		dev_dbg(cxlmd->cxlds->dev,
-			"Only attach to local non-interleaved region\n");
+	/* hold endpoint lock to setup autoremove of the region */
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver || endpoint->dead)
 		return -ENXIO;
-	}
 
-	/* Only teardown regions that pass validation, ignore the rest */
-	get_device(&cxlr->dev);
-	rc = devm_add_action_or_reset(&endpoint->dev,
-				      endpoint_unregister_region, cxlr);
-	if (rc)
-		return rc;
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		guard(rwsem_read)(&cxl_rwsem.dpa);
 
-	attach->hpa_range = (struct range) {
-		.start = cxlr->params.res->start,
-		.end = cxlr->params.res->end,
-	};
-	return 0;
+		struct device *dev __free(put_device) =
+			device_find_child(&endpoint->dev, NULL,
+					  first_mapped_decoder);
+		if (!dev) {
+			dev_dbg(cxlmd->cxlds->dev,
+				"no region found for memdev %s\n",
+				dev_name(&cxlmd->dev));
+			return -ENXIO;
+		}
+
+		cxled = to_cxl_endpoint_decoder(dev);
+		cxlr = cxled->cxld.region;
+		if (cxlr->params.state < CXL_CONFIG_COMMIT) {
+			dev_dbg(cxlmd->cxlds->dev,
+				"region %s not committed for memdev %s\n",
+				dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
+			return -ENXIO;
+		}
+
+		if (cxlr->params.nr_targets > 1) {
+			dev_dbg(cxlmd->cxlds->dev,
+				"Only attach to local non-interleaved region\n");
+			return -ENXIO;
+		}
+		if (!cxlr->params.res)
+			return -ENXIO;
+
+		/* Only teardown regions that pass validation, ignore the rest. */
+		if (!devm_is_action_added(&endpoint->dev,
+					  endpoint_unregister_region, cxlr)) {
+			get_device(&cxlr->dev);
+			rc = devm_add_action(&endpoint->dev,
+					     endpoint_unregister_region, cxlr);
+			if (rc)
+				break;
+		}
+
+		*hpa_range = (struct range) {
+			.start = cxlr->params.res->start,
+			.end = cxlr->params.res->end,
+		};
+		return 0;
+	}
+
+	/* devm_add_action() failed; teardown needs the region write lock. */
+	endpoint_unregister_region(cxlr);
+	return rc;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..8c050bc308bd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -97,6 +97,13 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
+/**
+ * struct cxl_memdev_attach - provider ownership and CXL link requirements
+ * @probe: optional region probe callback, called with the memdev locked
+ *
+ * A non-NULL descriptor requires successful synchronous endpoint setup and
+ * preserves provider ownership even when no region probe is requested.
+ */
 struct cxl_memdev_attach {
 	int (*probe)(struct cxl_memdev *cxlmd);
 };
@@ -107,8 +114,8 @@ struct cxl_memdev_attach {
  * @hpa_range: physical address range of the region
  *
  * For the common simple case of a CXL device with private (non-general purpose
- * / "accelerator") memory, enumerate firmware instantiated region, or
- * instantiate a region for the device's capacity. Destroy the region on detach.
+ * / "accelerator") memory, enumerate a firmware-instantiated region and
+ * report its range. Destroy the region on detach.
  */
 struct cxl_attach_region {
 	struct cxl_memdev_attach attach;
@@ -116,12 +123,19 @@ struct cxl_attach_region {
 };
 
 #ifdef CONFIG_CXL_REGION
-int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
+int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
+int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd);
 #else
-static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
+static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
+					   struct range *hpa_range)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd)
+{
+	return 0;
+}
 #endif
 
 struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3959ec963026..aa08d88ab104 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -172,7 +172,10 @@ static int cxl_mem_probe(struct device *dev)
 	}
 
 	if (cxlmd->attach) {
-		rc = cxlmd->attach->probe(cxlmd);
+		if (cxlmd->attach->probe)
+			rc = cxlmd->attach->probe(cxlmd);
+		else
+			rc = cxl_memdev_setup_region_cleanup(cxlmd);
 		if (rc)
 			return rc;
 	}
@@ -215,6 +218,68 @@ struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
 
+/**
+ * devm_cxl_register_mem - Register a provider-owned CXL memory device
+ * @cxlds: CXL device state to associate with the memdev
+ *
+ * Establish the CXL port topology and endpoint synchronously, without requiring
+ * a committed region. The provider retains ownership of its memory, including
+ * any firmware-discovered regions, and must detach if the CXL link is lost.
+ *
+ * The parent of the resulting device and the devm context for allocations is
+ * @cxlds->dev. Returns the registered memdev or an ERR_PTR() on failure.
+ */
+struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev_attach *attach;
+
+	attach = devm_kzalloc(cxlds->dev, sizeof(*attach), GFP_KERNEL);
+	if (!attach)
+		return ERR_PTR(-ENOMEM);
+
+	return __devm_cxl_add_memdev(cxlds, attach);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_register_mem, "CXL");
+
+/**
+ * devm_cxl_attach_mem_region - Attach a registered memdev to its region
+ * @cxlmd: provider-owned memdev returned by devm_cxl_register_mem()
+ * @hpa_range: CXL.mem physical address range result
+ *
+ * Attach to an existing committed, single-target region. This does not create
+ * or program a region. Repeated attachment to the same region returns the same
+ * range without adding another cleanup action. Failure leaves the memdev
+ * registered so that the provider can decide how to proceed.
+ *
+ * The region is removed when the endpoint detaches. Returns zero on success or
+ * a negative errno; @hpa_range is empty on failure.
+ */
+int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd,
+			       struct range *hpa_range)
+{
+	if (!hpa_range)
+		return -EINVAL;
+	*hpa_range = DEFINE_RANGE(0, -1);
+
+	if (!cxlmd->attach)
+		return -EINVAL;
+
+	guard(device)(&cxlmd->dev);
+	if (!cxlmd->dev.driver || !cxlmd->cxlds)
+		return -ENXIO;
+
+	return cxl_memdev_attach_region(cxlmd, hpa_range);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_attach_mem_region, "CXL");
+
+static int cxl_probe_mem_region(struct cxl_memdev *cxlmd)
+{
+	struct cxl_attach_region *attach =
+		container_of(cxlmd->attach, typeof(*attach), attach);
+
+	return cxl_memdev_attach_region(cxlmd, &attach->hpa_range);
+}
+
 /**
  * devm_cxl_probe_mem - Add a CXL memory device and probe its region
  * @cxlds: CXL device state to associate with the memdev
@@ -242,7 +307,7 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 
 	*attach = (struct cxl_attach_region) {
 		.attach = {
-			   .probe = cxl_memdev_attach_region,
+			   .probe = cxl_probe_mem_region,
 		},
 		.hpa_range = { 0, -1 },
 	};
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..3019e3ea5f09 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -224,6 +224,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 						      sizeof(drv_struct), mbox);	\
 	})
 
+struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds);
+int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
 
-- 
2.43.0

