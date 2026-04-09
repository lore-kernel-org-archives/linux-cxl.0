Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EEB3DE425;
	Thu,  9 Apr 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749498; cv=fail; b=cCmbEi4xAO8DlPSR9OWdmQq8jGyrCSTAdGwQqZQ33sUyzyOhxKaQWPL0JZvvL7WAhhz9/RMmUUbJApZheuogQWL/uGwshMbIQx2kcz4Rj9VxLdtOyqZ5gyi3xoMnkMkgzq7cSxa636skgQDvda91DipcyqQ/KU/5vsy+gHPMqGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749498; c=relaxed/simple;
	bh=sbp3BWvDBYnYWiGsgpzGCJTbcuhCVXVfo5O5B2+6YXU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HCUYSHd+u/y7qx1hV9gJty4UIGidFXPTZ/q3CMNRh3NuMxLoANSnZ1KfkuKzpS0jPzNDlZeJBUOiAamGkNCYrgFpArroVA+wwEh3EKoc0C5UDpPBbDaZsLH9IZG4q/TE7KSFVShuqIyV7OuVxt0gLvfbm+5+967QC61EthKCL4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t41+UoRs; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t41+UoRs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLbsYS0uOmFivOAY76PCm8z2X31Ywd/fUM5puclaN4c5zNtYfBJ0eJQDF6/QYbAPzJ9QeDuxkkVYxhcVYqSzLlJHwT9Cy203VoYMT8OjSCwcEG0wUAUQknV7puXdEIY39+ztx+PTeiE7RpMysz1hjU1/zOaFvenxSBB250purhnfF3WqtBPx3vzXEiZ/YCLSCQTNfw09xXclTyj6YMSTpOUD9i4ds3uy//S4f8fFvmcYj+yoKBUiGtQdV3bzur9Dqz7SavzF2vpSx0TSpbrO4ImCj5XzUML7PsTa370s3+HQcpr6+TLxM/nvtKzbZBGVjCvJqTSZMjLsvQxkFXRSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRSfdECaCt57zfW2ZLcyDqijFNt3qirYSCiTtt9BsUo=;
 b=exySLvUsROWAgDtPsTxyAc4pdGHxj0RiKDRC9UWJOw/UX+ePw6axSD4slxNOzqlRNoWNgxYaOG55ChXiWJxDXsPQ8PezNqYQCkq+hMQXr2Y9NqxfcP5xC5QT743YK8yxq+EBE1inpwzDt6i9ohFZuuWTRRJtVZ1cLyjovce56qG18uqZIZ/NvvAmh0FL5iRMc7MZRe+Jaa5TouSdDWrxCUM4sxipabLi2cMsdEr9inagZm9/Ra7V8eXBQYG8RbQ3Sbl0q0W92iRWUnU4zNwtcbZ4mraHgnINMJ9hI9MXMAe7krOyYo1P5TrCTl6AdvdR1IGqz/3UKAvJcOC1Mvm3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRSfdECaCt57zfW2ZLcyDqijFNt3qirYSCiTtt9BsUo=;
 b=t41+UoRsibUl6UCDlNiqKGr6Xiwnnq/H5OKukVlGPGJaWzc41LekrNR/zjnxRAR3ztdUssgl7FRMa6X78xvsJAMJXa7/TPoA4uwaoWkdxA0tMTbyHNYw/kmEehORb1L+dHrLnvVpAC4TR/XMXnyFdciHi9idXqNdU9quOynLSTjZFwinDH+6MaPN+7Hw8KNQVE4K99jYmVybYq1hQ1ailgazi2NAJBtmiOy+du89J1/CYO5DDVs1iqYJHiqWLWTfF1tukPMcxGA64Mpg8LXjPE93YMz6FwX2tWEoabUCCjNUclocHYwQY54Q4oq2gNCmSDcx6a6K7maXAGXVuUW4Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17) by SN7PR12MB6958.namprd12.prod.outlook.com
 (2603:10b6:806:262::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 15:44:51 +0000
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688]) by CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 15:44:49 +0000
From: KobaK <kobak@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koba Ko <kobak@nvidia.com>
Subject: [PATCH] cxl/region: Validate partition index before array access
Date: Thu,  9 Apr 2026 23:44:45 +0800
Message-ID: <20260409154445.2416120-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHXPR12MB999244:EE_|SN7PR12MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 27172e1e-d31c-4593-9e60-08de964eef00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2DeABJTQluGnadILbadasAfTnLfE77WgK7JXfqlMQRh2jY5iLLUfw2lsbOKgy+o0hkzQ+ltyDPdXzLRji5SAxRuT1QyaAp6s2S7rw56O0wARUSzGP11kzhBr1rtnaRob3hnoIXKNEFF3gktc6tq/uNBtN/12ZpIPvmdA4ZQ5zYY6RNchxUrAvYVlA/KmADB698GB5fONkGsXi4joLSPmZW2d4nYpafzGgcC0uZiGf3fOhDnTIY2tJJuGVNg35Cl0wq0DhndInmqRDKi8yLctsIcrrEy26+IaeCekV5flQ4Hc9y7BDASRhpFyKdPLXRBxefoUJc/bxUc5MOlBZh41mDiipoG5xVfTGMhAnX9BAS5PJn4x4I69jW3+taHnNDh5WB3V+YpJKQMU8W4ULeYqMzTHxve8EqV35osxzRWD3+pb70+J78vqRt1jXeeuwE63oWsdRSmh3+L2Y/Lsc2y0GdPoVovDtiCrvCzxDYzU3QPDSpN2gL/eL49xvvvAhpTf92t/XQOftsEdolPHipw9IGFjAukcgWcb/k/+th33T4ShlUyJObxsoJNFrio9ePzx4ndh3bM0F9sUG+GuWJxz0IticpN7Ylo4cpzkVSQWt4ovuuLTRy0q3ADy4vjmn8D6/IKoEXHiREz+sRa0Rw0GjZayRMht5/Y0Te/d3hsJrJHkIu1LdRwXX7+GjxE+AeSuxUFuziBarfZBkyfJJkYPJvfVyLJN7UOjH3Ns8f01TzY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHXPR12MB999244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/W8WKbzH3yYdENIqDhVf4Hxt3k8e3l0zeVGYk+zNFfCySzbrpFLBL00U8Ac8?=
 =?us-ascii?Q?nZuFsr73zGXfnECZ3Kgv9SYMglR+p5zFq3k9skF+K3bBEwumpzKJr4Fb0Q9k?=
 =?us-ascii?Q?JPH2TB07sNpAvLCNaLu0Ce/8Ew1WkEeMFMQReZBm2AiANJ6xS+lb161onmS2?=
 =?us-ascii?Q?A2uNJWJ+o96p0IgbfbsU7FwODzQ29AAyvtebWLK5J6P27zSrRS3WMPMIAw89?=
 =?us-ascii?Q?qd4GmJpdRTYe0+ocrIEAVKuSonJJNxG/W4q00gbwvdJiFPbEMU/qY1SVY+HQ?=
 =?us-ascii?Q?nOJfryEFbdVRx8tKMc22xmfqmaA4QdlKlVDPvGrqWrytpmFlAadXV8FBsltb?=
 =?us-ascii?Q?NKjfQM0xubCuhx0BDtszilawMXeKZIq8Q12V7IygODUlCkfy56TRtuvtar9I?=
 =?us-ascii?Q?7Qv7xUzbe0PXEn3A+R23zEH0A0aybY65ogLIKTXpo8dALlv+m/QZsW/8ad2o?=
 =?us-ascii?Q?hlLewynH6U6HuYrInbicbFKiGKxr4mJa8igUofBf/01iZNE+J1/bN1ZM7pHv?=
 =?us-ascii?Q?Ux86nPXmLVmXmcq8v2hfoMSzNWk75D3fkDEsHEqIHTEcwuBnZxdt6OMCqKNG?=
 =?us-ascii?Q?X5JHkSPj/lbcu9BvaDdJWmjWe6Nm9NzcgQk0zr9Zo3JBaYEaxqKSatZUMvLM?=
 =?us-ascii?Q?P4siXnbnbmjNsXsFgMLamA4VfQQ2DBN8V2dfwqt49cPfxXFl+/OFsbjtdsUZ?=
 =?us-ascii?Q?CaoXDsjoTYUvIcqCHHUCfSp2H4UNkPnv1Blufeduac+qi/cTtwWqQOKcqAqw?=
 =?us-ascii?Q?Zqw6RTeC/dxxI1PrNTKHKYaDK/RdBxYxgdi1+jm0rWQJwtRvtetVoI837Y4e?=
 =?us-ascii?Q?750rkBxLqNRAsM/mNn+eQpCQZzlxtn5NIJdmHmDjmDglw2wxFL2UtgNENUrg?=
 =?us-ascii?Q?/rZKiALmDMvunWedcuVTzvwVkDChwj/+I/049C24+JnGnUZBDp3bHJ+S+djt?=
 =?us-ascii?Q?IlSpzLkxJqp3APt03ZKyXaSUPBiRLfghJzfwBt25HhmGfn/2rKmx/IInc6vy?=
 =?us-ascii?Q?5S0t4TqdWPkFHEM4w2UEBQFlGmMegaL/L8JckXWqS8dq2LD1JCKyhhYDfCpa?=
 =?us-ascii?Q?HwiQJJL91QOsS3A6R5QIpSL/TPbF4C+CavWNNUm5OPyVpHbELojRcXxkxWp2?=
 =?us-ascii?Q?ueWXj1vVtQOlrleBl329uocK5kBORxYtyJteu8XOk/T01YxbXSCJsB0VTyUz?=
 =?us-ascii?Q?qe8TCYGlNm4HCpjStrc3J9irOaBnPvnX24utauQ0KBEVD+rcAxu/6cESTXHF?=
 =?us-ascii?Q?jzBQFjeVE7G3r0wEraLfDXZwf3RHB7Z4EsPHBQp/W3zb+7pSo5nyTmE8BMpz?=
 =?us-ascii?Q?UyERIyhjTfPon3O8vXcJKv4xcSa/rOv8I4dxs5OvnUfyl6AOdk6DwbfJOvL0?=
 =?us-ascii?Q?PGN+bi1YwyOqsgLByLg2BszkstTR8gZYLoRzduzg31ZsEktxBcevERLJUTV0?=
 =?us-ascii?Q?OVu/Dqo7Bsi+IObchQDBASNLOu04lUvbvjL4T2AkJKVFW/jJ3ABtmnzsUCQP?=
 =?us-ascii?Q?PRiYYgk3UqDX3BvyZAsws4bS/OK++ASLM/qX5b8UDGRv+BruE+6U/Evr4R0t?=
 =?us-ascii?Q?o4MUqu0/XFYYYD6WJOPKAqJa6ad4NpkEuqhVzcLaJ1b4g9Sqf58oDVkAKxM/?=
 =?us-ascii?Q?NKjEVWN7Xc6p+m0f9T1bvapoEczLNO6+1pBt/ugoORf5JBxjE2cksTIz/y9j?=
 =?us-ascii?Q?3CsFnhHbEcmpaYGa26R4jW0vjplPvu81AlXk0X1oXdjJIdE1RRvBJaSFPB3W?=
 =?us-ascii?Q?TM2m0Hrpbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27172e1e-d31c-4593-9e60-08de964eef00
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:44:49.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibQ2nuDSKP+/uLpxtRJwD8ZjXI8v4XzdjszLC+OHn0yLPzB6lU+8ngAgsQGVDeg6YD7kHnNuzJr1rO0gWMJ4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6958

From: Koba Ko <kobak@nvidia.com>

Check partition index bounds before accessing cxlds->part[] to prevent
out-of-bounds access when part is -1 or invalid.

The partition index is read from cxled->part without validation. If it's
negative or exceeds nr_partitions, accessing cxlds->part[part].mode will
cause out-of-bounds array access.

Fixes: 5ec67596e368 ("cxl/region: Drop goto pattern of construct_region()")
Signed-off-by: Koba Ko <kobak@nvidia.com>
---
 drivers/cxl/core/region.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index edc267c6cf77a..6be46636db7ee 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3712,6 +3712,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
+	if (part < 0 || part >= cxlds->nr_partitions) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: invalid partition index %d (max %u)\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			part, cxlds->nr_partitions);
+		return ERR_PTR(-ENXIO);
+	}
+
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
 				       atomic_read(&cxlrd->region_id),
-- 
2.43.0

