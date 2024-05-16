Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85966D1AF
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847155; cv=fail; b=Kwr8JfWfVyiZwsMu+AM0ovnXgzssp67wY5Nu+stQM5pa3rFx0ZMQRwf7jd0xAHlMM9zCOoD2cQ12KsdGUwkSgmF9Y70YNa212IFlEWWRvg/qi6JzUEMj6H/YX5WqGeIGD1T+HbjsRDwtb+ZFhiJf5PoCDJblyeKG8KrAmj9zNvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847155; c=relaxed/simple;
	bh=d1UgFdx6n698+MZvZ0KRcE28EnUCsUVGrR2aVFAo5JY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcLz7EOaFlvjsDFxvy1nrPvpFJ0YI5OfyWMd4o8LmGLMoqSmrIW4vCIdoo7YyFP7PU4VVqMdsr1t02ilqDy46INgX3i9dg17VMeperFSZNJXAXzgNdvOYeBoZeTVzbRecTLupoHepaKUlmx7gd+ir/2x1M4E2hNycqkyAsXekJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TdKO4KGl; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TdKO4KGl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXy0gsiJB1jmdvsXSjdns7vuFOeuzZhH58I37x/CmNHCrYGbio+1+VWuRMqIrJs4GtfPcVa+S2eQDd5R4nj/xP54DzMQ2i9GB6rKI0Rx7fRDGwdBj+LKraxg4EbHF4j+ZEdkaVDRDVHPCdKBhCPTLIGkRmb1xxGw/yFvPwv36bw2LeM0SJzQ8UXBbBehtGQucK5SYFJG/a5JcXY3jz2seGBGzWfV6ugGlSRfJTZ0sqsb2o1hyi7dP34qw83dTlQjlgov64eE+2mRIR8EEX/UprXPUYz8sD+c5d9CAKChG3xxJ/zf7a8B808Sy4spJDbqQF2n6keOZ3uwtQjlqsOuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U947/xOg81oQsK5saZT33sZnO1Pan0/p75dO8s/pZ4=;
 b=Z4oL7+bgl0yU4Qlt8NmpY7R5Eu8VjKHXd4KlhgRwhNYPLP3XewWRZrSubznlif4pJ5Bc3omLMiBb937SV0BXs731MF7fwmcijfdPmNaKTx1D4JjKTKHKWDZyjpIRtFtVTELsvF8eKYPiU5Pn04B8fXZ1WE31MjWkhmruSkSID8lNXdXQPykQ52gk9SMDC5PIV5RlNpaQ7hSpySJEUyvJQ5Qa3gET07qX34OLxcI+TohMasx6fPVBPXn3VYK5LyNH5XRaorQKLcTIMFaQeUWAkpDbQG2U4jKUw+qcxYSrrfAtWFp6bX6TaYKrxmRP0NRSpdBQiVa06qkGHMGMZW7Yng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U947/xOg81oQsK5saZT33sZnO1Pan0/p75dO8s/pZ4=;
 b=TdKO4KGlCAJ62ASB/s+LU1Pe+CqHvsuASk0Rs/8D+2V533FGh0lojKv4HX1PUpu91kOJYyQSNYtvxmBHUDKM08Orlo452sMZLP2S/e0ebgG8Z+YkyTRKl8Netcr/vT1A6Ta5SSf+2tKnVmox9yKoph0lDg/LGHDCzzhqR1SSp4g=
Received: from MN2PR19CA0046.namprd19.prod.outlook.com (2603:10b6:208:19b::23)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 08:12:29 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::37) by MN2PR19CA0046.outlook.office365.com
 (2603:10b6:208:19b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:24 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:23 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 08/13] cxl: add cxl_get_hpa_freespace
Date: Thu, 16 May 2024 09:11:57 +0100
Message-ID: <20240516081202.27023-9-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 582bd528-eb4e-4d66-7cd3-08dc757fedd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXJ1ZDFzZTEvVm5TbCtISXJqelRSMUdURkJNekdvSERRNHN3SGRKNlpkS0pv?=
 =?utf-8?B?cGhTaEJnVWtEaXpkeUtSSWdpQzdKeUlsSjFacUpHOVhJNUpiSVN5bis0dUJT?=
 =?utf-8?B?ZlFtRUFpaWJoeHl2WkZSWFFIK3RSU1lmbmVEbHVIKzNsaklrRkE0WFFKSnNT?=
 =?utf-8?B?dzI0WEdIcDRYNVlEcHBkWjNJM3QxMmRqSFZCTTBRWEkrR09jcXM3dVg5TXVx?=
 =?utf-8?B?eXFqdkRzbld6b2VocVJiK3NDQzNocW03WVpwbmtsK1VQQzAwVTJKSStrZ09J?=
 =?utf-8?B?d1JFcjBLUnRxamFoZkEydDVheGszaFJlRDB4YU9Ed1ZwbEZmeUJpck90a1lv?=
 =?utf-8?B?dEFGcVZLQmtNNDhkSVE4d1dTV1gyeUoyY284SjZ3c2lOODRzQUEyMjVLVFdD?=
 =?utf-8?B?cTUyRTIrbEUxaDFURXMxc3g2UjhoVkVzNUxJVkJVWlo2QXpsTTZTVWpEN2xF?=
 =?utf-8?B?RXYxa21PYzBFMjZORlZmZGpKalROcXJoSnFSSngrbXJVNGRURytzOWpPMFh6?=
 =?utf-8?B?bmhwL2dKVHFFSnJxK2lxaVlVRFYvcU9lSnFFRWdDYkptbXdZcUlSQitjMDll?=
 =?utf-8?B?bDg2eDF3S1d6Vjl4cGRoaURiK2tCQXMwa0RURlFQYjVUWG9ub1ZpWlgybmtT?=
 =?utf-8?B?eE9wU1h4ZlJaaFlKK0JXRStQMUlFbnk1QmpWZlQzdHhQV1NQYWJmZ3NGRlo1?=
 =?utf-8?B?SGltSC95M3ZnSXJ5d2pTMVhLS0dpRW5OM0h1K0pYLzVJeDdRNnA0RWlxVUJN?=
 =?utf-8?B?eWVmSFFnVmxEWUNlbFlZa25zWFR3SmlTRk04ejVNQlprczBIL0hmRE1QSlJL?=
 =?utf-8?B?QVR6UGFHdDFKbzRpUmJsZkVEb0RiK042MStYYkFOYzlLUHpXNnVXd2ZxS2l5?=
 =?utf-8?B?UFdNR09GMHNFalpnSlFwcTR4Y1Nmem9hSGJXbDF0eVdTa25DT0d2eEswemls?=
 =?utf-8?B?ZWxxOW5HQTFhSDFVK21kMjRIazFxMmpyTklQUk5wcEVoQ3l5UFFLZlBFbjBn?=
 =?utf-8?B?ZDlnd3IrU3d6aFB5cjhjRWRnSzVzUThSSHF3S0JDS3M4Q0lSRjRESEhaZWJN?=
 =?utf-8?B?bG1PRll1YUtjWlVzNUtjSFJ1bm1Rem9OaVg3ZlZYaG1LYWdjMWFHbktKV2hz?=
 =?utf-8?B?bTV6ZXBsRlE3eGpodWRHRVBBRWJaYjlmOGl6dXgrcURpTHRERFVIckNNM2py?=
 =?utf-8?B?R2FPQnFRbEtDNHhKUkcwMDhmR2EycjZzL2MyQ0RBT1BGQWYyNXgzS0VURXhD?=
 =?utf-8?B?NEJML2c2S0t5czBPcXNheEVYUFR3K2ZhNlh0YnZ4OUdPYXRXL2FDU1dmTVJh?=
 =?utf-8?B?SVFTalBRdC9KdDRXNmZWQUtxSVM5YzNnYWk0cENLTnp4ZGwxZk8rVjFrNkps?=
 =?utf-8?B?L0wweER1azVsQmNFTTVXNEsxM3JMZXFMSFhycFNwNmJjOHV5UkRPTkQxZ09i?=
 =?utf-8?B?cEUyWkVNbWFyczBEOHVoYTRna0wxUkFkZk9sbzc2R01JaFlkM2pTeUtrbm9R?=
 =?utf-8?B?NUdMclhoS29YUnhuQ0lJbm1DcThnTDlOZExDTVZqeUpiS0QyMGFSRk41TFB5?=
 =?utf-8?B?UUJMWE9MYjF2ckNuRmZkQTlwaEZRTjY2amlqZTdWSnJkTjc1c1M5Q0pmZHNP?=
 =?utf-8?B?R0M1bU9BYjZ4SGhvbmYrNEZiS0lJQzNoVnhLLzBwUStCMkNSL3BXOXdHN05l?=
 =?utf-8?B?MG5WVE03Ti9rQTRZUUNmUWV4cTYvS3V6ajM2bzRpc3pHNDhFUytPMWNuRklj?=
 =?utf-8?B?M3c2czlielJMU1FnTXNLajdhZjUxTEwyaWs0cXM2eUhnRlBJcC8vNFhyZjgy?=
 =?utf-8?B?NmNXN0FMWWV1ZDFDTndvbHI0YWJvdW0rQ3RNWkNOcDNCMlFZQzc0OHRLeXRk?=
 =?utf-8?Q?uxjBmF6PJtmAp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:29.0499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582bd528-eb4e-4d66-7cd3-08dc757fedd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516

From: Alejandro Lucero <alucerop@amd.com>

Based on the requirements from the endpoint and the topology such an
endpoint is attached to, this function informs about maximum host
physical address space possible to request. This is not a reservation
but only information which could change at the point the request based
on this information is made.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c           | 163 ++++++++++++++++++++++++++++
 include/linux/cxl.h                 |   5 +
 include/linux/cxlmem.h              |   5 +
 tools/testing/cxl/type2/pci_type2.c |  23 +++-
 4 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 70e86a7c241d..2731fd4243a1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -702,6 +702,169 @@ static int free_hpa(struct cxl_region *cxlr)
 	return 0;
 }
 
+
+struct cxlrd_max_context {
+	struct device * const *host_bridges;
+	int interleave_ways;
+	unsigned long flags;
+	resource_size_t max_hpa;
+	struct cxl_root_decoder *cxlrd;
+};
+
+static int find_max_hpa(struct device *dev, void *data)
+{
+	struct cxlrd_max_context *ctx = data;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_root_decoder *cxlrd;
+	struct resource *res, *prev;
+	struct cxl_decoder *cxld;
+	resource_size_t max;
+	int found;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxld = &cxlrd->cxlsd.cxld;
+	if ((cxld->flags & ctx->flags) != ctx->flags) {
+		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
+			      cxld->flags, ctx->flags);
+		return 0;
+	}
+
+	/* A Host bridge could have more interleave ways than an
+	 * endpoint, couldn´t it?
+	 *
+	 * What does interleave ways mean here in terms of the requestor?
+	 * Why the FFMWS has 0 interleave ways but root port has 1?
+	 */
+	if (cxld->interleave_ways != ctx->interleave_ways) {
+		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
+		return 0;
+	}
+
+	cxlsd = &cxlrd->cxlsd;
+
+	guard(rwsem_read)(&cxl_region_rwsem);
+	found = 0;
+	for (int i = 0; i < ctx->interleave_ways; i++)
+		for (int j = 0; j < ctx->interleave_ways; j++)
+			if (ctx->host_bridges[i] ==
+					cxlsd->target[j]->dport_dev) {
+				found++;
+				break;
+			}
+
+	if (found != ctx->interleave_ways) {
+		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
+		return 0;
+	}
+
+	/*
+	 * Walk the root decoder resource range relying on cxl_region_rwsem to
+	 * preclude sibling arrival/departure and find the largest free space
+	 * gap.
+	 */
+	lockdep_assert_held_read(&cxl_region_rwsem);
+	max = 0;
+	res = cxlrd->res->child;
+	if (!res)
+		max = resource_size(cxlrd->res);
+	else
+		max = 0;
+
+	for (prev = NULL; res; prev = res, res = res->sibling) {
+		struct resource *next = res->sibling;
+		resource_size_t free = 0;
+
+		if (!prev && res->start > cxlrd->res->start) {
+			free = res->start - cxlrd->res->start;
+			max = max(free, max);
+		}
+		if (prev && res->start > prev->end + 1) {
+			free = res->start - prev->end + 1;
+			max = max(free, max);
+		}
+		if (next && res->end + 1 < next->start) {
+			free = next->start - res->end + 1;
+			max = max(free, max);
+		}
+		if (!next && res->end + 1 < cxlrd->res->end + 1) {
+			free = cxlrd->res->end + 1 - res->end + 1;
+			max = max(free, max);
+		}
+	}
+
+	if (max > ctx->max_hpa) {
+		if (ctx->cxlrd)
+			put_device(CXLRD_DEV(ctx->cxlrd));
+		get_device(CXLRD_DEV(cxlrd));
+		ctx->cxlrd = cxlrd;
+		ctx->max_hpa = max;
+		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
+	}
+	return 0;
+}
+
+/**
+ * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
+ * @endpoint: an endpoint that is mapped by the returned decoder
+ * @host_bridges: array of host-bridges that the decoder must interleave
+ * @interleave_ways: number of entries in @host_bridges
+ * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
+ * @max: output parameter of bytes available in the returned decoder
+ *
+ * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
+ * is a point in time snapshot. If by the time the caller goes to use this root
+ * decoder's capacity the capacity is reduced then caller needs to loop and
+ * retry.
+ *
+ * The returned root decoder has an elevated reference count that needs to be
+ * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
+ * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
+ * does not race.
+ */
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					       struct device *const *host_bridges,
+					       int interleave_ways,
+					       unsigned long flags,
+					       resource_size_t *max)
+{
+
+	struct cxlrd_max_context ctx = {
+		.host_bridges = host_bridges,
+		.interleave_ways = interleave_ways,
+		.flags = flags,
+	};
+	struct cxl_port *root_port;
+	struct cxl_root *root;
+
+	if (!is_cxl_endpoint(endpoint)) {
+		dev_dbg(&endpoint->dev, "hpa requestor is not an endpointr\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	root = find_cxl_root(endpoint);
+	if (!root) {
+		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	root_port = &root->port;
+	down_read(&cxl_region_rwsem);
+	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
+	up_read(&cxl_region_rwsem);
+	put_device(&root_port->dev);
+
+	if (!ctx.cxlrd)
+		return ERR_PTR(-ENOMEM);
+
+	*max = ctx.max_hpa;
+	return ctx.cxlrd;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
+
+
 static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
diff --git a/include/linux/cxl.h b/include/linux/cxl.h
index 036d17db68e0..1b2377062693 100644
--- a/include/linux/cxl.h
+++ b/include/linux/cxl.h
@@ -766,6 +766,11 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
+
+#define CXLED_DEV(cxled)  &cxled->cxld.dev
+
+#define CXLRD_DEV(cxlrd) &cxlrd->cxlsd.cxld.dev
+
 bool is_root_decoder(struct device *dev);
 bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
diff --git a/include/linux/cxlmem.h b/include/linux/cxlmem.h
index 11fe8367b046..342ccd5486d3 100644
--- a/include/linux/cxlmem.h
+++ b/include/linux/cxlmem.h
@@ -865,4 +865,9 @@ struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 
 struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
+struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
+					   struct device *const *host_bridges,
+					   int interleave_ways,
+					   unsigned long flags,
+					   resource_size_t *max);
 #endif /* __CXL_MEM_H__ */
diff --git a/tools/testing/cxl/type2/pci_type2.c b/tools/testing/cxl/type2/pci_type2.c
index 948cc95c5780..deb5eeae501b 100644
--- a/tools/testing/cxl/type2/pci_type2.c
+++ b/tools/testing/cxl/type2/pci_type2.c
@@ -4,6 +4,7 @@
 #include <linux/cxlpci.h>
 #include <linux/cxlmem.h>
 
+struct cxl_root_decoder *cxlrd;
 struct cxl_dev_state *cxlds;
 struct cxl_memdev *cxlmd;
 struct cxl_port *endpoint;
@@ -15,6 +16,7 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 
 {
 	struct cxl_register_map map;
+	resource_size_t max = 0;
 	u16 dvsec;
 	int rc;
 
@@ -79,9 +81,28 @@ static int type2_pci_probe(struct pci_dev *pci_dev,
 		return PTR_ERR(endpoint);
 	}
 
+	pci_info(pci_dev, "cxl hpa_freespace...");
+	cxlrd = cxl_get_hpa_freespace(endpoint, &endpoint->host_bridge, 1,
+				      CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
+				      &max);
+
+	if (IS_ERR(cxlrd)) {
+		dev_dbg(&pci_dev->dev, "cxl_get_hpa_freespace failed\n");
+		rc = PTR_ERR(cxlrd);
+		goto out;
+	}
+
+	if (max < CXL_TYPE2_MEM_SIZE) {
+		dev_dbg(&pci_dev->dev, "%s: no enough free HPA space %llu < %u\n",
+				       __func__, max, CXL_TYPE2_MEM_SIZE);
+		rc = -ENOMEM;
+		goto out;
+	}
+
+out:
 	cxl_release_endpoint(cxlmd, endpoint);
 
-	return 0;
+	return rc;
 }
 
 static void type2_pci_remove(struct pci_dev *pci_dev)
-- 
2.17.1

