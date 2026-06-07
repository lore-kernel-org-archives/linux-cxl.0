Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EA23C8A0;
	Sun,  7 Jun 2026 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780810743; cv=fail; b=hDtsnooYBcb+9VABA7O9XOV5ixPxwv38i6V4X3HENKOzTwpROvBXRbkqbQ4VJNf8PjjRujWoBH/rhyWfsJXh0O/anfg+9r/l0sJ2IcYBLKlJJzoX0bGGTlDbuNnPqlKa72uvukTcfT4dBh2TgLxhJeWVAtXO0yYWA93N35CuwPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780810743; c=relaxed/simple;
	bh=EldBKuCgXNT4+/74xWvgaOq+wdp4yklkX1GDowNGSc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sM6rHLeBgxC2e+wSWY56J3B3/Z9xFvPXkwMva3jM0HP63neo44AfNtOLCt6hsdK++r1qyYsVQ25kAAo1zsD9+/vcj4FPehB8oaq/fH+lGbIlzNhVsDshegbf2gFTxQJz3vFI2S/EtU+Mpj/WLd16+rH6pZ9K99L5HYKmhM6vpVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuvZkFtW; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuvZkFtW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4935UTeXN0bekXjckbfh6oF4OvP7HTDP9OQKY8fGGs77DQyscjJzVihi8iUZNmShrPAlZYXOT21vbSj8AuhorFTiemMp3sWerJzMez+7fLY7KT8d8zeZefyputswMAufWLSGuS37XRyxYrLPBLgS+HFU+rhHczJ1gtF/+jQ0eUBo8bMqkvGkYULlMSECVo+LKH8iXG6Jm1FF9lcHJ5VrMzB1jKesxc4BjqBYV1x8wxP5waO7wEKX4Y7IfsUsoSo3WUrsD/hICGRp/DVXkSZFE8lrIxJNwUWer/RcOqCgt9gSv23ZaXQ1lvJBWofumLw9fUwUB4nV6vd3RMH/XbCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRvhi/TdFx4PMWO4F20Th25564Z3++Ci6JYPptRA9mk=;
 b=d+DRicp1QPE36mAiqLADXVVGdvNVm4E7ZNP5pvTM6MfiYiOy7z/RVdU7xM46KdfCgeM38yPr00mdWxV6Rh/2xAtb340j7vNSUDhoBnanAF91knMHQMTQR7u2Ofx8l73AvpCEqI/p+qn6Ft3nbRStO3Z/0v93cvXB/dxWr4GSWTR3NSvKVN2SFApyYvFaCU08hSY+GOOValIwbzNc9UHn5+3rzQHSsBgHrPN9bbCgA1/MX8x1k8mEmLKFUfKVwQ+Qvbb54MiwGQ2u1+nbi4frm6wsIlRgQs5b4ASftZUmiurmuFa9/K+mu72XgzCbhXQ4Xyh15SEUEY4dJgtEvGwVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRvhi/TdFx4PMWO4F20Th25564Z3++Ci6JYPptRA9mk=;
 b=AuvZkFtWCf11q8P37063jJK/kSGh/3yReQXq7zdykzzkJEAtOKCJ2Vvwet0nihQWYPmgbtTVRBOC1ewqxjdgFk53uVS+2xFUAQxDd8B5a/9tfZLFj2fU8ubbPgbRNRVJKTtH242wECBxcQVypS4pzr/dG10D2lZRR52GQif4hcC4Y18hJ2zhUBxeJra9j9lAvoEtpgHyL6PFUKS8BUlITGRbCTRaYsABHWo0NLa6ltIIc7EiyAT9DpG8KiKD7aRqd48Lvfl5xxi2zamMqJ4sz0YBrSTl6wsnCrnW74oQbIcZ5wWOg9CvuLDjta3t+8GgddufObY+JaABf6xII9cWkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 05:38:58 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0092.010; Sun, 7 Jun 2026
 05:38:58 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 1/2] cxl/hdm: Allow zero sized HDM decoders
Date: Sun,  7 Jun 2026 13:38:36 +0800
Message-ID: <20260607053837.4389-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607053837.4389-1-icheng@nvidia.com>
References: <20260607053837.4389-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 1415890d-8ea6-4fca-af12-08dec4571151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|5023799004|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	mVLHaSuOA6gGsbhy3VTvUe++4Mzl9ubQn8SfFvNRGaIZLNP5cn84OxJSaumlCVjWFj7LjKznGNbc3C6akNP3Jm1ohBsNJ+Lxdi/SZprSGGb+2IZa1nnD1BmChxVMt/yrIUXZvmfP5bSYtYUbNuDeGf3S/AAS8DpME/uDMeXWVNwPM8zicLGLny2teubwp585ZJfbMzWDvCK+0uUcL45s0p1ccpQsfA+q3xwj0upOu+panug5A5YLZOl/nG+jYrN+/6ps+Z1Q+V/s5aEEvgCRmf+jJ9+oMnHLR+qmiyeh43p3Pzytb29MOQIM4uw1hQTlwXrJf+gxtCqypKnKfACbGf6NYb8mO3cjFHFN8lYmTk7Q1hf6GiTJxSDHkSDvsM1jVgxmzJmxhqTEF1u66nTlPA0G6YSfTGnnjIRm9dAlIqA/DsUFeT2soNFaiCVm9ntyYKqz1OWy5KLSGJ+lwZE5i+URFjbJ+p05HP26pF9C+YUOyHUT5i712PfdDUo35jBnGlT/wtc432ozYwzqRqMTVF7fSkgYoqa/yyIsBWT2/QWpQ2+SFmFotiQXeJevLGKbhy92lI8i+kkeWKWJMGR/SDmq2nNbQ1+3nj2LvEmhg+pJjlbUToozIle17MChpcBJpXb0cMdkKxHldnO9i5X9Og3Uhxv6mwFEsZi9zZ8CffDNoOmTj+ru+oO11YPS9lMp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4XoWZceubp20WrnysbMTSNVhBpaOnYuK+sl5DwRJB0Jcvddc3koQjqr2viO?=
 =?us-ascii?Q?rQlYrrSUS/6eVSUGlojpE+tjV6bMaynsY+yN0S2kcGy6Xy2CySJzEKvTp7Hx?=
 =?us-ascii?Q?wJ9J0QMq9THbINbGK4XTNEMwM7gOmTKxhaUUUuKM0Fp0ByUZXOS4X08yxt0a?=
 =?us-ascii?Q?x05MXyVjm941BRkcEcyUxrTZUp6nbWpTAQgpQ6FurqrFa5DbDM/Gqxm2gdSN?=
 =?us-ascii?Q?YOVkvIL0rpx7Ys+sVIkPi42WTXq5WhOp+1lIa5ZYP8fdzPMOcR6nC/OotDSj?=
 =?us-ascii?Q?ipHSVchSGb1BL1zzrdJAVqIg9JmzuOOB4dXAJcuQl02njJef6oUxL1+RU5q5?=
 =?us-ascii?Q?H3ogjb/b4ZirQcuKoIMXVzrTEjPIYCKZlsmUcqsRhAyPbLRs+Hzzd9C/g7H4?=
 =?us-ascii?Q?eXXjZTNj86pJt5Me+Ve9PdKvm+PksIOmLKPbJXK+/ZuxQ/q3qeCPiGFqL6Kz?=
 =?us-ascii?Q?5TCGUr2Kwk5O3Cfsdj+dKQGm9FaYHdlZZggT3I75SiNH/ZomRTLgFog/+4sd?=
 =?us-ascii?Q?KuEUDHRdfq2n7+9f/ZXe4/z3I6mcBZFUkCG2982lWEJ47u1NZGZHvUVyH2W8?=
 =?us-ascii?Q?P5+6vFkuwjG/EjjwzuG5JiXkvggyAAw4sJ3Bw9H1XB/4JlZZ/ppl5gMzbWhM?=
 =?us-ascii?Q?sehke3GbCUF94AEEBnuupKLANRsgikTmQrLUm1rZRh/vtkOPeo73gDBN5pw/?=
 =?us-ascii?Q?Dugvhn7oj6a60zc3h8iljoq5UI7MMIV+KKzw/IPnhCMde0fzFiwffUoEnxds?=
 =?us-ascii?Q?d/nv5oH7MfuGQMc95Gq5fHmdMLVM/6/S14yFj0hYDW09fkDhQ2VHl4/2y55p?=
 =?us-ascii?Q?0by6MM5zSiH2INFvqCxpU1EfGrmNhlBzjk8jR1p3s80bhaBZYRRYVREKiqpX?=
 =?us-ascii?Q?UWtD7dse4B3oSsnRg4fS8Bkx8lX8LZFLiIK+PL7wTQS4ZTNo3nuQGcbxGil0?=
 =?us-ascii?Q?7VGDMrPXiMgDTeeFsNWiLRxeZG7wpoKEEw9Efi7tJdwv7AIFdBJV0LhX2muy?=
 =?us-ascii?Q?zxutjDDgk+0pAjjZPHyxh6cFsCwBC45ylFckFTz4m0DlzqhjzMX3vWJhVl+E?=
 =?us-ascii?Q?3WWc3UjSnMao/7GDRljkcobPvOaVmkv9j0m/TrO1F7SPHZfJGJ7VVz4FxGtS?=
 =?us-ascii?Q?4X9bkomdffjaAs6rz+MoRm61KrPKH84e9YDh2Fq1yUSbWCn6PMtjRvavVkfy?=
 =?us-ascii?Q?a5QUIGwwVRgoveJSJJZaP9G5QVP6CZxEcyoAAIviLRN+wyHEUK00zC9YTg0R?=
 =?us-ascii?Q?sLIUs6OzNwVAo+M791kBdPBSB59RgQB1pXC1YqrnwMCxhnimY+xnzshAo04a?=
 =?us-ascii?Q?iyjlx6PZetyNIry7sNziFpoOrqH8hSLnWLlWmlTEkWR2ib4hnEAm3i2iGpgI?=
 =?us-ascii?Q?/F6oo2FNniSO2exfTNzzMvqiLU7nOv9Hv7ZPNJUI1YXt/RUh1yEW6uS/Lg+n?=
 =?us-ascii?Q?VxN8Su2TViX3g+E6AFLMo8oUPESRSGAMC66+AE07nnHptRMtuU+YdeDICt3m?=
 =?us-ascii?Q?iYZRiKe5J7qJWmjAvaPt093E89yQZ00hUZGRbMjWygZBI6gSZfQadvC2aqIB?=
 =?us-ascii?Q?y9mXNK3V+iaeLktZJVMMCweySMvq8kD/kj0f8EMd9W/aEdJ3yCTr7CM7bpch?=
 =?us-ascii?Q?4sFmPGtxI9jhXoUH8PldOq41kAEmLmubhjMxQNGEO08d6PDo+kwLseZ4fVN7?=
 =?us-ascii?Q?fXDPR5s14hxaS7ehj/Eh1YIPgSaWqnMLzWcQEbL262qGXLZmO9GDRX6zIYPh?=
 =?us-ascii?Q?6LEsNupLKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1415890d-8ea6-4fca-af12-08dec4571151
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 05:38:58.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUxoxdVKAAsUqjn7usJI7lPOYEzre9MBE0dV++AVUNoxlv4bmwiXx8rlWnPuE5xrxnQMCrBi0LDEWOB6fV0b0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

CXL r3.2 8.2.4.20.12 and 14.13.10 permit committing on HDM decoder with
size 0. BIOS commits and locks such decoders to burn slots for a Type 3
device in a TSP-established TCB. init_hdm_decoder() rejected them with
-ENXIO and aborted port enumeration, so "cxl list" showed nothing.

Enumerate the decoder with its HW LOCK state instead. Skip the DPA
reservation it does not need, but advance port->hdm_end so a following
committed decoder still passes the in-order check in
__cxl_dpa_reserve(). commit_end can now point at a decoder with no DPA
resource, so poison_by_decoder() must still scan the unmapped DPA tail.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2->v3:
      - Advance port->hdm_end for the committed zero-size decoder so a
        following committed decoder still passes the in-order check in
        __cxl_dpa_reserve() .
      - commit_end may now reference a zero-size decoder with no DPA
        resource, so poison_by_decoder() falls through to run
        cxl_get_poison_unmapped() and scan the unmapped DPA tail.

v1->v2:
      - Add zero-size committed decoders to the topology instead of
        skipping them. Drop v1's -ENOSPC sentinel and the matching
        "continue" in devm_cxl_enumerate_decoders(); fall through so
        add_hdm_decoder() registers the decoder.
      - Set port->commit_end unconditionally for any committed decoder,
        not only non-zero-size ones, so subsequent decoders satisfy the
        out-of-order check.
      - Add an explicit early-return before devm_cxl_dpa_reserve() in the
        endpoint-decoder path. __cxl_dpa_reserve() rejects zero-size
        decoders.
      - Spell out TSP and TCB and cite spec sections in commit message.
      - Reorder series, implementation first.
---
 drivers/cxl/core/hdm.c    | 25 +++++++++++++++++------
 drivers/cxl/core/region.c | 42 +++++++++++++++++++--------------------
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..b5fe2b053bc2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1031,13 +1031,17 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			return -ENXIO;
 		}
 
-		if (size == 0) {
-			dev_warn(&port->dev,
-				 "decoder%d.%d: Committed with zero size\n",
-				 port->id, cxld->id);
-			return -ENXIO;
-		}
 		port->commit_end = cxld->id;
+
+		/*
+		 * CXL r3.2 8.2.4.20.12 permits committing an HDM decoder with
+		 * size 0. Enumerate it into the topology with its HW-reported
+		 * LOCK state instead of aborting the port.
+		 */
+		if (size == 0)
+			dev_dbg(&port->dev,
+				"decoder%d.%d: Committed with zero size\n",
+				port->id, cxld->id);
 	} else {
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1096,6 +1100,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (!committed)
 		return 0;
 
+	/*
+	 * A committed zero-size decoder reserves no DPA, but still advance
+	 * the port's DPA watermark.
+	 */
+	if (size == 0) {
+		port->hdm_end = cxld->id;
+		return 0;
+	}
+
 	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
 	if (remainder) {
 		dev_err(&port->dev,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..a353d8e7489d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2907,38 +2907,38 @@ static int poison_by_decoder(struct device *dev, void *arg)
 		return rc;
 
 	cxled = to_cxl_endpoint_decoder(dev);
-	if (!cxled->dpa_res)
-		return rc;
 
-	cxlmd = cxled_to_memdev(cxled);
-	cxlds = cxlmd->cxlds;
-	mode = cxlds->part[cxled->part].mode;
+	if (cxled->dpa_res) {
+		cxlmd = cxled_to_memdev(cxled);
+		cxlds = cxlmd->cxlds;
+		mode = cxlds->part[cxled->part].mode;
+
+		if (cxled->skip) {
+			offset = cxled->dpa_res->start - cxled->skip;
+			length = cxled->skip;
+			rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+			if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
+				rc = 0;
+			if (rc)
+				return rc;
+		}
 
-	if (cxled->skip) {
-		offset = cxled->dpa_res->start - cxled->skip;
-		length = cxled->skip;
-		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		offset = cxled->dpa_res->start;
+		length = cxled->dpa_res->end - offset + 1;
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
 		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
 			rc = 0;
 		if (rc)
 			return rc;
-	}
 
-	offset = cxled->dpa_res->start;
-	length = cxled->dpa_res->end - offset + 1;
-	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-		rc = 0;
-	if (rc)
-		return rc;
-
-	/* Iterate until commit_end is reached */
-	if (cxled->cxld.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
 		ctx->part = cxled->part;
-		return 1;
 	}
 
+	/* Iterate until commit_end is reached */
+	if (cxled->cxld.id == ctx->port->commit_end)
+		return 1;
+
 	return 0;
 }
 
-- 
2.43.0

