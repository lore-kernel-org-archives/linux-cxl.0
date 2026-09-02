Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBF388E64;
	Wed,  2 Sep 2026 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327588; cv=fail; b=Qurk9l4rrE1gQm0WZb+vt6V6YdyB/I37D+/FrIrbdlJGX1SqBWh9QUyH+CluJHwPDkmZ9wJ05WxzFzZaTcwPOrdeKIp/uUqMDcP4ZjzjYzcrzSKoysg1b/fj243AbaJZyaNaip7iDfVsPWYOY64yIrS579rYCEWxFiPkrafleHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327588; c=relaxed/simple;
	bh=3M5VehCKhJufdxSoI8My/oXlUB+GUKmWdEA/qHI8akA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XupisgKxExWFdFjOVWy0FCvw1EFouMIyy/TeCVL0hEBEsmOg41UDFOo2QZqb24RiUphIV2cm+wfYJQsyzGV+IwAuvlzBaHZgRxkYizWlJiVRINAIvenjRbK9Ud/dfw9bzB/llGtUeiVotYIGC3vhcpzbe3Er3eAhep4OlTiHBd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iuR1az0Y; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iuR1az0Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFL/9C/jt0S02aXMYhXeY7joeIkkxBFpFxJphRfOOdP/z0UuvwW1hMfpNgkYuAAoBRAdnaIxyK5UZeRT/7OHXcL3ofAZyJsKoAHgGGxRIo5u4D+vST3kl5WwMdJMUg5lO64samUtoWrmyEbtkobS8/pBw9KJq0/s82q5kn1NJ0J7QPg0kG718PoQK/P6EWg4Wq+hghHklt3b7Lx8ff91BWfD1XQwczhseWid5jE3hfVZwzP5fXQ7lWyh+0cC7sZmH/O7Ii92VH3tn11QhSzo7E5x0wVrkhDubb9cyCDMArUJLuLP+LZkPYSGlqhkDobhJttQ0MFZ+Rq6ihyMmKKv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWayRs9RCIQet9hDEJ593YX+0uEu85lDQTQjeC2wJws=;
 b=AXS5kXt2g992UL1/KQxlU8D0TlpQypguflEOoh3YgeLTJEn0VOZqi/1hzLCTFje4ppaJfpyz0+kJTg2EbchR0d070SjAZ74N76ff+AtN2K7alOM3bfZoReqhJyvIhvzfSZI8aHX5LNhXn2iK/JYZdoe8/Akbolf9VVgIH00JtfXTB4/QwuELDW4oKst5ArZIWOiI7o94Z6enUTlcIPqqaYiqnOf7TBNHw4X6O8mPEv+IIeyaexK/kPjWQg6vgmq9aGsdWj89jAPwbbTCxdDnTRxm1CY9MbE3zWLK4tyij2e6XWpPc0y9oZxf5q8eVT8wAge+7ZPHyOYVgMA8J8vcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWayRs9RCIQet9hDEJ593YX+0uEu85lDQTQjeC2wJws=;
 b=iuR1az0Y/ifO1v0ph3Dv8JRtmDdu2aijBHP3HpaLHKgerI279rFMRLHtWdqY9bovyjxVa6SHrGg5Zldp6oQ0qK2n3wI1MmaVFAomF4cL7lgvUxGW21tRYUyhfi7HofAF9toRCuaxXxdoc7fN/CnErHNL6iWZ8WV5TKvhLjyCdWXphoF33yW21dBvW7vvZ61xCpg/jyNv4M7NSV9bQmJz90tF/+LexN3PNIGpjXXoX9rVl9wGUfr2XbSUQdjTCbYAR46w09ghV4lIOeRAhNUR03aEaucyN/vSJTFp0yElUVUIFV2nuwbyb9366LgDnc+Av++QwTz+G4j0lUJNJGhmMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:39:39 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:39:39 +0000
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
Subject: [PATCH v7 7/7] cxl/fwctl: Propagate feature RPC delivery errors
Date: Wed,  2 Sep 2026 13:38:39 +0800
Message-ID: <20260902053839.25595-8-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:4:297::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: afca5250-15f4-48e7-cbd5-08df08b494a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5yAbjUWG/zn8+t0bEGuw6wSS6EbzOS8BP6RW2swLye3DyvWXTd9saPvE80TkvArC6KLZeWSSV0Yyl8xAgsUimTm9krOpAmukxLWgZOVIbNu60o/2hg8Y2wXRoVH3gOtrmskxaxsgi462a97L8vrWCpnCzLYRtczVILN2VmRRo5IouuTUDGD21yBKAo1x/uAX75UTXbBGYy4nFNCcpbJAWFFzP8kml8IzM1mvcxUEbvimfckWYE7iiE7D52vDNYW7tPpOtal3VNGnjANJ0RD3WrtywRexqiJOlwMnjOK0afnYxbmcQhvSCnT7QZrB8hPz8yzx6TSyACaIIZWOzVTrgvu0h9q4mTkuEfOgFJFY83lkm+9P6XQs0HCEGH/2QDWYqzMAu9ZwjA/Hu2zXOhOe8qPxFG18hVlPrwZDo98NUHZC4WL7Ih5dMtWbjotPdxylf4iVnIiXqvBvt+PgcjfnIuhm3LDegoJD+W51Fd5fEbMzgfHxIv8LE8cD2ZNCJNwjp60y60+4SgtvZw/Xurd1+8qzLRmULL8+2bRgqckO4M2cuaukc96/E5Lr45+Sh6IjSH+UAmNstAGqYmNllfqtKHE/G6Egomc6re1EX90SwbcX42QprYOdwERnMXNt+HFbnxECi9Qo8cDQWn5HYBe/5FM8QZPBW3hbR5iR570KIKQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j6Ax7CufXbp64fQYAIek8B4dnPD6d2qOc0MC4BEA78biNuT15ZL2KbW9LXMW?=
 =?us-ascii?Q?Y5fOgv0/dsaHFuG9/TXDMdVm5fKjYse8wVp3oI+VX+xuuDmVZ8N55CsNJupF?=
 =?us-ascii?Q?MEGT5ofnRzFjXsFccZ/6j9DsrNMwDvyTUmGMmmSAr/7UEYUihBc5r7V/v+Zz?=
 =?us-ascii?Q?DyAhkJ10ZZljlspF89bwQ5XPiH93Nr3NcNGDYeTVi7IrARsZVUGCtP70nsqC?=
 =?us-ascii?Q?GpMBP0RsPDsp/HDr0TgnEjLO/rZ5CGY4LZRQlXKF/3+e5yNi5zqPx5lQXUog?=
 =?us-ascii?Q?tjAdayaL25sLq0p/h1p7DTvWgP98Iu9iQP1AC7BywbtxrZoA6d82fUOGt0xm?=
 =?us-ascii?Q?WkN+bSG9sg5PkYWsnKowPR7TA4QcNt9FqgeeYQMq+b4hsTwShlRtadwqtURj?=
 =?us-ascii?Q?flD+2nbxfRkXh8qeBhOxjDgLGVCEzpDaD/RFirLS6xfJYTGAZopgnoUTh9/5?=
 =?us-ascii?Q?iy+e8dXsuJi5wFrTJ7Slgkd/i1ttnd0hXrfPyMyn0iJyihNMwmVT/KTFIfQq?=
 =?us-ascii?Q?vIf7PdWx9WTgBZJjCMK4zafF/lh8fd911+6N5AcLTlirgkAhSXDdzhQjzXHv?=
 =?us-ascii?Q?wXsC3/0Drx42jKvSWcYVA5WNwmgn0wlKnGX1x9MuhFlL4ArDnAxsEChLy4x0?=
 =?us-ascii?Q?cptS2h7tSyMEMxtbvWr8dBuT1EEQ4pc1P0dN2a5WxXIjqLzSnm+Ozi0/4b4S?=
 =?us-ascii?Q?LkfpeiBqnCmB1q8v6NPLFp5T1BoAeAs+/KRYstjHqQ3wYGcbBUBb0z6Wc3Ex?=
 =?us-ascii?Q?ykkAWKnXhoSO2+P0a+SEjmdq2fxPM3eXbpMw5XmmeErZ12JXLaDvHBAfWAWf?=
 =?us-ascii?Q?5SQsszF0tZzWSjaBwdzlL6CN1fSx8k+6ohlIjglwmPUr8IJmXWtBawJctJr4?=
 =?us-ascii?Q?tYL4eiI8HWN6nNYa/clx15IBmDiEa2XWy7XK9Et0VFpo2PLHIm2E6hDVfmek?=
 =?us-ascii?Q?RGFCXE7eM61vTVpW03GdU1D43/QP1M5aDNinA4x+tUfmm8GQoa8Fln9tkmk/?=
 =?us-ascii?Q?7HXv465rT2vC4eHykO2ns9fji7npu5GxOP2Bt9NiedyxAhI4vzDWNYWd9Oly?=
 =?us-ascii?Q?rsfXmZaUuCupOjpBYBN1l0GXJ9V02CeUGYNcG9+OdLf6KOWN0ydXBZPJ6sQy?=
 =?us-ascii?Q?fTNqLOsrkGFfmHGLBvYDnlwS1+rUs1q9rIxgIqRrKe0+d82ngR6TNZUCUZwN?=
 =?us-ascii?Q?DHAkLHN3WeR1PzD2nCX/rDLlbKfDn4pz2XyGtAcETIGCoNwaNNzd2vpxEMpu?=
 =?us-ascii?Q?QMV6h/SYudzyGcZ+4HAc3jxj62P48O9GwlCgxXDtlJTHQVu5o7bm0Q3k/0YJ?=
 =?us-ascii?Q?nx1Ic0ELinPpRHBzmtghynWF6Q7uE6GF1PGmT4M7Jwnb17pn8y5yT2vwsI9q?=
 =?us-ascii?Q?B9xp4f7jxoQYtkLM7cS6RU4EXGk/BNiUA7MFP+6hbCh6WVk58t9LLMH5VYXe?=
 =?us-ascii?Q?QOceJfMFw7qjiBfN55tNwdA8YlOKhBYV4XoWmullaWMIC/JtmW3gUiqxjOmk?=
 =?us-ascii?Q?CfKZoJs+424gcswEPjDQQ8AyyXLPZHABUlhwxdv99W+FXTjEVofddogg5ZVl?=
 =?us-ascii?Q?VXUuvgrJVTWQZ6VbWY/lYqEYYNEKQD82UZMUjRb2NeOPDclb54cZt9kwVw3Z?=
 =?us-ascii?Q?ZF+7yB2UlbyX0NHAaojidE79LXqXTW193WsfSBKJba4DW4xfxjEAvtD9vLQf?=
 =?us-ascii?Q?BJjukgvxTFKVq+Jfd6EZvpy/aR2uTdtfoZDKJ/jvuXzGtCys?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afca5250-15f4-48e7-cbd5-08df08b494a4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:39:39.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yJU+5Osqz7yulRvKreCs8dZogHkK72zkamt0Xhi9rSG5wr2xVpGgNz2wp6Bv14dAPVeK6YoYzFyEPqwGRwHFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

FWCTL_RPC requires delivery failures to be returned as ioctl errors,
while device errors are reported in the output. Get and Set Feature
instead converted all failures into normal responses, sometimes with a
SUCCESS device status.

Initialize the return code to SUCCESS. When the helper fails without a
device error code, return its errno. Continue reporting actual device
errors through rpc_out->retval.

CXL permits Get Feature to return a nonzero short payload when Offset +
Count runs past the end of the Feature. cxl_internal_send_cmd() reports
that response as -EIO, so preserve the returned bytes as a successful
partial transfer. Fixed-format EDAC callers still require complete
attribute structures, so reject partial payloads before consuming them.

Map an unexpected zero-length result with a SUCCESS device status to
-EIO.

Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/edac.c     | 10 +++++-----
 drivers/cxl/core/features.c | 28 +++++++++++++++++++---------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index f1df4b5cfe5b..34b81e8dfbbb 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -89,7 +89,7 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
 				    rd_data_size, 0, NULL);
 	if (data_size < 0)
 		return data_size;
-	if (!data_size)
+	if ((size_t)data_size != rd_data_size)
 		return -EIO;
 
 	*cap = rd_attrbs->scrub_cycle_cap;
@@ -567,7 +567,7 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
 				    rd_data_size, 0, NULL);
 	if (data_size < 0)
 		return data_size;
-	if (!data_size)
+	if ((size_t)data_size != rd_data_size)
 		return -EIO;
 
 	fru_rd_attrbs = rd_attrbs->fru_attrbs;
@@ -602,7 +602,7 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
 				    rd_data_size, 0, NULL);
 	if (data_size < 0)
 		return data_size;
-	if (!data_size)
+	if ((size_t)data_size != rd_data_size)
 		return -EIO;
 
 	struct cxl_ecs_wr_attrbs *wr_attrbs __free(kvfree) =
@@ -1282,7 +1282,7 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
 				    rd_data_size, 0, &return_code);
 	if (data_size < 0)
 		return data_size;
-	if (!data_size)
+	if ((size_t)data_size != rd_data_size)
 		return -EIO;
 
 	cxl_sparing_ctx->op_class = rd_attrbs->hdr.op_class;
@@ -1771,7 +1771,7 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
 				    rd_data_size, 0, &return_code);
 	if (data_size < 0)
 		return data_size;
-	if (!data_size)
+	if ((size_t)data_size != rd_data_size)
 		return -EIO;
 
 	cxl_ppr_ctx->op_class = rd_attrbs->hdr.op_class;
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 8d44ce829497..95f47193fb61 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	int rc;
 
 	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_INPUT;
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 
 	if (!feat_out || !feat_out_size)
 		return -EINVAL;
@@ -259,6 +259,17 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 			.min_out = data_to_rd_size,
 		};
 		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		/*
+		 * Per CXL r4.0 8.2.10.6.2, when Offset + Count runs past the
+		 * end of the Feature the device returns only the bytes up to
+		 * the Feature size. cxl_internal_send_cmd() reports that as
+		 * -EIO with a short payload, so stop and return what arrived.
+		 */
+		if (rc == -EIO && mbox_cmd.size_out &&
+		    mbox_cmd.size_out < data_to_rd_size) {
+			data_rcvd_size += mbox_cmd.size_out;
+			break;
+		}
 		if (rc < 0 || !mbox_cmd.size_out) {
 			if (return_code)
 				*return_code = mbox_cmd.return_code;
@@ -267,9 +278,6 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		data_rcvd_size += mbox_cmd.size_out;
 	} while (data_rcvd_size < feat_out_size);
 
-	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
-
 	return data_rcvd_size;
 }
 
@@ -289,7 +297,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	size_t hdr_size;
 
 	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_INPUT;
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 
 	if (feat_data_size > U16_MAX - offset)
 		return -EINVAL;
@@ -340,11 +348,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 		}
 
 		data_sent_size += data_in_size;
-		if (data_sent_size >= feat_data_size) {
-			if (return_code)
-				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
+		if (data_sent_size >= feat_data_size)
 			return 0;
-		}
 
 		if ((feat_data_size - data_sent_size) <= (cxl_mbox->payload_size - hdr_size)) {
 			data_in_size = feat_data_size - data_sent_size;
@@ -492,6 +497,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
 				    feat_in->selection, rpc_out->payload,
 				    count, offset, &return_code);
+	if (data_size <= 0 &&
+	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
+		return ERR_PTR(data_size ?: -EIO);
 	*out_len = sizeof(struct fwctl_rpc_cxl_out);
 	if (data_size <= 0) {
 		rpc_out->size = 0;
@@ -544,6 +552,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
 			     feat_in->version, feat_in->feat_data,
 			     data_size, flags, offset, &return_code);
+	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
+		return ERR_PTR(rc);
 	*out_len = sizeof(*rpc_out);
 	if (rc) {
 		rpc_out->retval = return_code;
-- 
2.53.0

