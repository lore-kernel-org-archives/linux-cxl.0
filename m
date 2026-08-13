Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6A2E0B71;
	Thu, 13 Aug 2026 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592801; cv=fail; b=A8P7mHuDDBIbvAYYjmF1oxngfNqmeiVs3e4Z/QP+d1w57UIocZOCnTEsaIa/lBH+fm2pDABZ7xwle7HF3fpYdfcImEzkWefbSmWzwLXic0ZVHz6RAxdyWmFCdcIgwo1chTyvABEr1qEXJPkBekJf5c/4H991yl6eH1BX+XEZSqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592801; c=relaxed/simple;
	bh=KrT4k3TG7s9fS+pjqoT2Bm3miv8x1tD65E6VhK4Svyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYmtAO5mpzKfefGu1T2e1KWaT68uMFz/HOrhDDz7Y664jYHKxHz/aD25IALHE5+RgwA68nEYT2gXw8I+Fr+ImCTMGgFg4+eRUr4pPzW0aqnTVHWv4Lx8/ToAXm+T6+RB1BGEH9UAt3Eh1Btz/6AV1rdJ+EmQLHUUFC8vcRFyW2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SdPLgr6s; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SdPLgr6s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URMIER1L5hGs1F4nAEX1+EPBwz8F+CF/qyWHtkH+NuEpIyuGGMwa/Jd678ZnD1UIyH7MOlqmwGaZPzb6xiCfYY5B1aU4IyZBuec6XdGsTkSNHQs6VdjThGX0zoRCxSGpAKT8+QFtJxBL9QB06VgdDjY14GmpoNLx15CTJ3ejlbAqCI+zeyBfr0xTxxB59ipZfM52CtdSBTpDr2JfXfirjYWUKXYCB3rs+lXOTKayEfghYrN0z2xdSQ5TlH+vMqyBrt3soK5W4okSy14gvoza7BXK7+kiAAiWTIV6iapedCIpu6vtQYrqsreJK9BRlvArZJXEIktCINTKwi+N7qbkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LWxNckEhtFx1LAtI3wRSO2VXsg48ej9aYPUUmMJxRo=;
 b=ZDpIxCE/MLFd4uYgxJrGhIMKh5JkVG8G0Xi1JrkGUzwXKvZwukHaIB+zUzpgWxKFNfW1GvKU0F/YuwOOy+HNm2d9yPoUbvBeiql2hGzNnim6sxjpRHyfO/gGvnGboNdE/s1pRI/SK0/6o/s575jiRfoBrw+u91HME67Xw2C2e+/VuUiw68jZZkWehbtkOWrkTh2DZFtplgZNn4/KP1CvyDKBFOIiOLL9TjfxDXpo6bH6nc8y8hmywq/x5bLhz8SxHwgEXN15s9cS8+jDs6HJkt2faXZei0y78ZjipVGtB2OFnkRY5WUA2ip1edKko7kqw3SsNWr05qK1hceQksmAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LWxNckEhtFx1LAtI3wRSO2VXsg48ej9aYPUUmMJxRo=;
 b=SdPLgr6s5FT2L6qCjx+3yORcbNqMlQPjn2+Tto7uOIac1zm0DfyrmcYIBW8KK7BU5BWSD/UjmidJlbAPVQncB2MTouMB6lp/Obg5Au+Y6c4TWx4OXxi302p7xqFo6g3hMLAp/Yke5Je5lLwHPNVLktvbuBddM2TwZw/mInuevVTUjxsgBmDvkkNzKJYv9SvI4ay2WRvQRMqlJ7vGqF0NEJv4SbI3h/SZdF0tc5T0fulCKJCEGOxtnVyyz2UR+U3ucS0utob3135gROgsDh6C89UVhNkq6tOUYOnMTjZ2I5JMrMUHpbsCvbmzMpEsSZRx7pmpxzcF60Vfm9ilgFI2kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:46:35 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:46:35 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v5 7/7] cxl/fwctl: Propagate feature RPC delivery errors
Date: Thu, 13 Aug 2026 11:45:38 +0800
Message-ID: <20260813034538.13189-8-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813034538.13189-1-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1b78c5-a2af-4b5b-4f73-08def8ed78ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	A+sLqqvH0AhZjawjqpspND6zyqdxBXpn4ecedlhqPFe/3fQ9ykhom6T+uut8FDoLKbHApINwJSNlw+hE04m+rSrUpDRozjc25X9xHs28WeaqRNl/SFVn5Jb3MnE9DP3AsVB3F7fgFs4AGTmqdL/6QRVOscU9rpTz1BPdX3aNlr9IZ6Mnz/HLBrJ0NA1/z1Om7eh4jLr6ii8HPEtPB96u9d97hJ7P5vI1UKVa2+eUQ3eAL+EIBcwXpMa4HZLBo6rCVjmsR3Rd7wT9DV+RyqJNYnKctgMvdnKi3HLA5GhNSkuVoxSU2DZ7edopnol6X4TCKr1ioyorBaRspNPHX9nBg5M7oOBt49eptdiX/qNgS7IC13s6dBYIYiACpszYafpSht0/unwCuuD2DHy6xVMzkO8+dHG/5l78tOfqD2k8rRH4HRbJ9YKXDBlSiyPxTjChsMX7WXqeRKrTn8vjksXnRJhAM4NFLncnLsnIj8my6FWfviP/FcK6VG1d4fUWuqgpPrHOpz8Xf+WXLoAP1BGAH4joq2mgG02FjDhWxqp+MY/XsuG7hf/lez3y2motsAzGFRLjPLFxEEvnBJL7r5ElIyRkkVnuB7ieWEB0y7m1tjuLmOBlOFBWKiRKHiEHKnIe4GL3HDqv/PQ01bI6siuHTpSwuF8g4DBUjQVQCK5Ziwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKq8n7iuIzoIkv+cvoX5fFCY19UAlzI3weNkOfqVq2olEC0oxkHJ/LeK2MtF?=
 =?us-ascii?Q?9PSzk1xUyqDD2diEfknl5S9furAlof9e4Dv49XXbZeHIOf8XYzhAxtQuPnEp?=
 =?us-ascii?Q?hqv6HyqLWN+INDMHFnTBz3t7zx+tJfTtP1+fqNzqFeQXJ3ScXnuh4megkw5x?=
 =?us-ascii?Q?Rm5XrvJz8F+tvBrjaPVzHs3/WskZoedeij67950fe+dFDz2oOV/8/gw6c6Ml?=
 =?us-ascii?Q?Kwudv0FaXrXSYLHtJXYA6A6M/3jHDtGESsjBCWhNlCmJ00xl8bgP/b6NXjgl?=
 =?us-ascii?Q?lBlqlXDq13KK6OCw/rz6xKrheurc+xlAuK0dBnFxRvTei/dROKb6auq01rFc?=
 =?us-ascii?Q?KbqPn/O/yLD9XSu+iT2VL+m5CEN7XMFWa2pMMLEwo5JXm0J5KNOmR74lO5tX?=
 =?us-ascii?Q?jTWuLxjKBldYucAOspNhtMMdoAofam2434hBbDrTHvLIa6yX6+SEzvtYhOQT?=
 =?us-ascii?Q?UCzUXRyu9JOoDCvMQQOE2zVm4GFOQd9ASlI2Oo6Rlx7DFVFK/V+hYxH/q7jE?=
 =?us-ascii?Q?xfyF40rITocvjISzE98DLkUi9H2nELaFUITIBPzVDJW2OCGXBvUwx2xrkKNz?=
 =?us-ascii?Q?FNq8QUUzNWiYVoAFL17WiindbkZPDWTKxpY2412al4ZdIaUZIYzxAOZ4xEDZ?=
 =?us-ascii?Q?44jRmY2++1Vgmmok76Nm99MQDa/mbzt4a/WATRFbGcUAjJuYwlAwbFEjoZ0u?=
 =?us-ascii?Q?iSRUON9QNu9Vwfw7CnWlLvxE4I7WzNW3BnAo/FAPY8U9A8DVI6dEZ8WMbFBk?=
 =?us-ascii?Q?bWGt5W6FnYNTj+gmPi0SRy3h+ogsXPd9s7pneYcW8E0tUz1dV8PSaqvw8RgG?=
 =?us-ascii?Q?Np0T2c8eMFepCafaK6dtgvzZhBwiwqBPndAm7drvHlxownsESQV3H9crMbmI?=
 =?us-ascii?Q?deqH0iu8savj1MqHG0YdQ/sxLKYy/iEUaZOvOBihZxKgIwY6R9u7bDzWQfkS?=
 =?us-ascii?Q?qXRDU02x/bcxsSh2o/w5jnhVMWOvi9dP76aIqZx4D1CAX92NHADs1/tRe+e1?=
 =?us-ascii?Q?qfHdEVBiJMhO6wKI8gW7rj+ND1st/4h97Y/DAYy5dpQDEAMqjumK2CTWtfhC?=
 =?us-ascii?Q?WRDxDg3YPzuM6MyxG3jRnB/QcY0FEdyxzg1hcVzCXqGydFVJ3rJH+wqpPevD?=
 =?us-ascii?Q?w6W47e2+LTKl9znWuE89Ha1YSy3ck26Mtg0Iyqnghbz72zgwHhzQHqabXMov?=
 =?us-ascii?Q?xIjhg7mxeoOT9NMBSQId9Vj9lk0uHB6sqRa9/RL8BT7wBD/SZV43OWMVI2A8?=
 =?us-ascii?Q?RUs8Wrpb8LUJ/IVmrzbIjaPXg3EcIRnYUVwMraI4PR90AenhErQGdcBMZfQI?=
 =?us-ascii?Q?zE/79DLkKVVbkQGXHNYSsVyhbwnmiA9CF2Cm/OUwCulltua16LW1rfPX0Qoq?=
 =?us-ascii?Q?bN0ZuKIQLKcXT6//Or7Ck/rxSABV1M/bN+VaB1k7jUF/eCveot4zd4qlhkO8?=
 =?us-ascii?Q?m+166pwdv8IAvOTXxn/gktBj4M3NVytXsv4tjzndbO1+FufiO5MAAV83DfgH?=
 =?us-ascii?Q?+LsprBGfEf21/e8KBhJtLu0iGvyRoZMxWa02vNw9qZ4kRJZQ+ScrYoOY9dZU?=
 =?us-ascii?Q?AwZGvLkvV0D/fS98NpNqVs9ujkJXQ1laAeYWeNywcobZSYrAdxZz57LFi7O3?=
 =?us-ascii?Q?0a4UK+A5qPtEgB9fGsHyeyPIoHRGjxleEdo4Tmw2ovasp2kyYbk2gCEZyUun?=
 =?us-ascii?Q?0ftbQAy4oaoQV4f4Me6aqqGqPO8/fzihFiJ1/B4wRF34Bid+OR2hMFGs/QEw?=
 =?us-ascii?Q?AbRxzIwMKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1b78c5-a2af-4b5b-4f73-08def8ed78ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:46:35.6280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfiBFPTm3gaUrodcWhOw7QVBbzDyc8KBnUFbzcg7w8qW04WnO5t5nQvUw9tzzlogoKj0Bknvi+FYSmUCNM7ctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

FWCTL_RPC requires delivery failures to be returned as ioctl errors,
while device errors are reported in the output. Get and Set Feature
instead converted all failures into normal responses, sometimes with a
SUCCESS device status.

Initialize the return code to SUCCESS. When the helper fails without a
device error code, return its errno. Continue reporting actual device
errors through rpc_out->retval.

Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/features.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 8d44ce829497..30e00faaf3a9 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	int rc;
 
 	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_INPUT;
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 
 	if (!feat_out || !feat_out_size)
 		return -EINVAL;
@@ -289,7 +289,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	size_t hdr_size;
 
 	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_INPUT;
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 
 	if (feat_data_size > U16_MAX - offset)
 		return -EINVAL;
@@ -492,6 +492,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
 				    feat_in->selection, rpc_out->payload,
 				    count, offset, &return_code);
+	if (data_size < 0 &&
+	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
+		return ERR_PTR(data_size);
 	*out_len = sizeof(struct fwctl_rpc_cxl_out);
 	if (data_size <= 0) {
 		rpc_out->size = 0;
@@ -544,6 +547,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
 			     feat_in->version, feat_in->feat_data,
 			     data_size, flags, offset, &return_code);
+	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
+		return ERR_PTR(rc);
 	*out_len = sizeof(*rpc_out);
 	if (rc) {
 		rpc_out->retval = return_code;
-- 
2.43.0

