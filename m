Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEC280CC1
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233851; cv=fail; b=TKvR/646kqQfN7xdCzvYY0CoKCd/UOxXd8xHpQpeGajDEGLzy8P8K92bxNGI9rUyCVrc1mb3Mex/cMhAM1zJqzmpNOORSw3YP+M/Qpb+FE8Os0I/PYf0sp2DJKuHW17xw2thgYFF/bv9Hpg1RudvJP+cgJqf5MsQpZEu/jGfJIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233851; c=relaxed/simple;
	bh=HHWrEuJS4GTz2olkNtp0Cl/t62p0mCSa2UbVO4w+psI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EyW8H12abTzI3czr5cZarnoffJDxUaYvksEBQIZDcs8D7F6H9YNel90zFq28lVWfjvyFROybrV3HPuAbFQ+TLjNuhZANy9zgsTMBGq8tUD7+joqzvz7FhbsMHNrOT74jgCTPadzbTod3d00OGzWfe4SsT33btg/KbblX4fP/zA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JiJKrAPG; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JiJKrAPG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktFvp5ZU1g2smFrRJCbTemM59kvct34d1NIy0tkUjrEXhMc8X/q0LOCjjRkhCuaLlihFuH5yLqC5y3NFwn52O9J2EsemxmrpsaDrjXD+JmzonCQso+rSQDW6QOIlxsrNY0Am4VGMNS2Blw8uMQq8x3T/arUW2p5mzmXcK8T+4vWfXloiMEcHfJFxRk7uYEHb9fbha/GP10ZUwWVtn/LtoisJjBE151Tz1j9mlPBZtG+g3xr3RombfNPVgrMgY1madoiRR9CSLkJPU2qYGJXNpXbX27TRhxISA7W/6kJsiL43iQTXUvGfhadjLXS7CtVikrlDoauiiAqjmnseDXxJxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcLVcpIMS9yVRaFlKTecuevCjkQtZJAycMeP5vlKOJI=;
 b=GQ6oKscdjrHGxP69dyCzrocaZZMsU+OVJZogp7ej/mVSLt9ohjMMQZbBTx8WnpXIU2EJflcOjJEPQBkO+Vn4jqOwFjHr2zQ8TysUbRCt7uya9v1YwDh1T3JxZCsZaUx0pqAasQi4JMGaDFX23SsykfHAWil9L5NkfMLSqheTHveuqn66xyBr0+aZB8O42AF84xEY9YQGcPewj778XWDMoqlAQ3/1neU9MhYAetgQpzFOgTdrTHygwocD51PxAxzj4kzk109y6jPYcCC4gKDU/Ycq96XTudD8cgZHe7QsFKD2iaebiJxczIfnAI0UJGBuJDk+NuYQYymv7Lu5/0FPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcLVcpIMS9yVRaFlKTecuevCjkQtZJAycMeP5vlKOJI=;
 b=JiJKrAPGgFGSUnhQeQuqqtZ+SiiXdZrGBx1sF1+BSVAKbx8yk10EbZ9IQcegjwHfVC4DtfzG6tsl5E+wTCLGv/3gbbE0bmgmWQfAIm6gMAxcJiNTzK15x7TWZlBq0vT2fdCzGh8jylvCA166gfgafphONKfwgJ8xURFzTaN5XWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:37:25 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8880.021; Fri, 11 Jul 2025
 11:37:25 +0000
Date: Fri, 11 Jul 2025 13:37:20 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [REWORK][PATCH] cxl: Remove core/acpi.c and cxl core dependency on
 ACPI
Message-ID: <aHD3cDOZ4R3Vm7YA@rric.localdomain>
References: <20250610172938.139428-1-dave.jiang@intel.com>
 <5282f0d4-a25b-4fc5-9890-9f50052bd4df@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5282f0d4-a25b-4fc5-9890-9f50052bd4df@intel.com>
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6da714-a053-4baa-8954-08ddc06f4e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Ss8lrJAWXpc5GWBnlWzm8tX3wVIr7yvni9mUmkE/BqjPQiUFQ81r48aH4Jc?=
 =?us-ascii?Q?oXzJDK3KkyZKhJ6uv48o57JFjGPomBPkG3vDDFpyWfb14fbFeFZoteMFblrf?=
 =?us-ascii?Q?s1Woy1RWOVx36pWCiVKgzz7dJelMfXSXPC9AS/CTeV9xQU1+lBPjXPW8ucjK?=
 =?us-ascii?Q?VtTXY4R5k/jgdVKX7c5ACiiy4W9L9DGVBGb3BLzdQiyEdq1LVm/JcSzMc3/3?=
 =?us-ascii?Q?PhPOhd74PlQcsuWTsloZLKZw9qyR2dlIr+Ze0hXME7tvNuLyQtoCiuVfV68W?=
 =?us-ascii?Q?HHwWXv3jp4E0Jj7Won4ERs5L6fGc3fLBFgq3c3F0E1qiWxumIJkI+JV/P3Jg?=
 =?us-ascii?Q?4yvYfzC77+YUDjEEfQfyPoS9K03yS4JwgczRWO+IzvipLHbm89xAKtE3qEUe?=
 =?us-ascii?Q?zgbNpS/J+/7DXs3wwUG7jS7sNgy2NE8LmoIamWD4PjS3zJcq6jKeBOWidEfD?=
 =?us-ascii?Q?MGrFAa0kgK4kRHrPHeMYyFfo49dU7kTuOj0JzhG/jbpTU31Lt+ATKCesfcd1?=
 =?us-ascii?Q?ni/Pv+J+XbJFtUiNPg/eADLHHQdK9MkPe6suVubkWfbcsD60Ue855cLsP66v?=
 =?us-ascii?Q?oN/VmWx7nDVxHC1ESmzzIosPQ6j/VGUv5afxg8yx4ksf9zJymjzhIj0jNeca?=
 =?us-ascii?Q?CxOWrdACvH42Hxx9vjOnF6ze4jK0lK0dM4C6CSdzGGDbQ75zMqGMnWfHo3RZ?=
 =?us-ascii?Q?p2iKvmiA2KEBnbpIctXWnab+kr8o6AgegOWdPhTyR2H3Rtc2XcqLM0qSeeem?=
 =?us-ascii?Q?KH60J1vwSHGvRletziBE+dPF9oEftSdG4TDdBWqrBhhV/rddMQtJqhdjBrn/?=
 =?us-ascii?Q?FrhtvoOtHYjBLO0vpAsKqxZW1Wyb0CSjUgR3r8pfSzGQdpHfuRks+Xl2HhjV?=
 =?us-ascii?Q?bwgaRPK21aejpGq4E8uzU5GFVAVhMgBoS5Qn0t1d0rMIqGlbNHHR0X1YCIFI?=
 =?us-ascii?Q?f1fbmLyIQGtusZPN6cszRpMC0OQT2gwAaDlRnQwzhc8G/IdBFQ8/J3paoDBM?=
 =?us-ascii?Q?g6OSXqfaprEqCtlHIpWIEolL2rMrW8O29Kaj1OTrmfthE8TXS0XeruJBbaJH?=
 =?us-ascii?Q?tZVNyrYVZcOAZn+tx01M2/yIvZpdd4mAqZCTxn5h5BIPgyOzFaf2lVS+FQzW?=
 =?us-ascii?Q?xCpmOBKQDr+48ZLBOsQRfLG1K0hL0p/3onX/+uew6qbjJ/KVMThigpfuLQ71?=
 =?us-ascii?Q?JwL1+3cwZlZFRdYuY8btodlHXU61GPsULo+LRXS/0IejJo4zznJA7ZqKdXtZ?=
 =?us-ascii?Q?5SJ0T9vEuRVz0TP4OH6XDu4tXHH0Gjgtf+n82FaSb+WkzzO2FsfUfNZpkIZI?=
 =?us-ascii?Q?aLOFcIFNpBmED4XawXJc1tKmPhS49yGv+6ucJftyfxe4bej9c1ONumLS25Ba?=
 =?us-ascii?Q?bnwNSBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUC6tMQ3PvOLkVwYRaxshebBVSlF8K/wAFwa/Ab2tgNr15+4bgJHk/6GrJrv?=
 =?us-ascii?Q?LDr8oFqlflkBMB3RhZk3NlDoXXcsECTsYarneK+OQeonqG0/UexjdRe1Pcie?=
 =?us-ascii?Q?807zJNkWy7vG29tEYiGL/q/uPXelohwhh9YZOPBUyBl8FCx7jR66F67V89ES?=
 =?us-ascii?Q?nCQM/zEaBFhwgwF2UQZQlLFmiCHbf1hfYidRqBNptvNqII9Oyh7Mqau5T4iZ?=
 =?us-ascii?Q?OqyzWVmx2H6du2kqXChT/2PNsfLcE6vyDkXxcqfQBgIiDlb3OVnqN72quFZc?=
 =?us-ascii?Q?9x9dUQU4ezS3KEDnHIZMuTwcsXReMU//bR+Q64eIXG/Mhw6p/LKWPS0fqP/A?=
 =?us-ascii?Q?owW8dblFPixx4fEK2Bak4T+vOhnBLF2EW2kBdUo2+ynQQmx5+6vYAcO0X/g9?=
 =?us-ascii?Q?axof4HAlPFE7/ALjO980TCFgsx9h/epi5MtKov5YN9aJH+wmQaeJPOPGyzgk?=
 =?us-ascii?Q?NOz85N5gtQGho+2k9TNd8eZkTUAdqOh5beWXdS9pwfTvwZIpQwOB84SsGHEy?=
 =?us-ascii?Q?TkYnBSxwHetaO3KFXRLtajqz2IeFuYMcy6IwFIMfYoIsmJsDzzBrPREtSBHT?=
 =?us-ascii?Q?ilcrAD33RBojbFqHKnQfeNnUNKSJ4mIkD0LUz16U+wbMxz/5/B1jdUg0Vbm0?=
 =?us-ascii?Q?fM2R3LPTvyjsK1llH7R9QB/bcsS5KHgZZsSSyiIgVdI4pnbhlk/P9JtCDRUS?=
 =?us-ascii?Q?rLsAyprFa4pHGVifRQz+FdQmsYaUQBRpvy7HJ23Sd1vJuWZhYk05Est+3afA?=
 =?us-ascii?Q?MTz2E4wFo6hiMJE537MVftsy+4a4LH5TGvuVzhINzx2I4dnLU3TN8fi20x1H?=
 =?us-ascii?Q?yArYvNCfTJg73BLbeYnuTed/pKiWYfQgngmMJB2nWLYw9PHvazvct5xNuZaV?=
 =?us-ascii?Q?QZLJTQgrNXZGI8yoNvprcLlm7U8qZ+j8L45/ZFO7TVa5mYJyb+gA/j6S1fpf?=
 =?us-ascii?Q?75Qho09VD0Axgyc0rJXMSguvZz+ADM+ZZAXgFrEalOYDgQNeRoklyo76BKrl?=
 =?us-ascii?Q?7Qe20Z5dKiuVQyNVn4pq9kY8jw9G0y1Xr6TQQtj9tl1BCDO4a0HIz0TiQ+n4?=
 =?us-ascii?Q?1o+Zps3FV78fIX0NlviMdx1wAUnXXmpRyM2U/KcMKRzL1FgAQdvWQyLGz3/K?=
 =?us-ascii?Q?MFMzphsWL/jGUv1pxuC47sOHOdHDbBE+uBqON/Ox7+ge+rn8Dk7FV7wFO9ug?=
 =?us-ascii?Q?Q7/TH9xSUbE8W/1cbsy54RGXb+mb5RTyYl9rSlq8GERSTzn3Pliik0j346Ob?=
 =?us-ascii?Q?kxVpwiQH44B6LYnPtbITvgwAnjFtqWJi2YozYXdxpSEiGyfpFlXwPQyMjLjU?=
 =?us-ascii?Q?0W3JtIuAtK7zSg3zSDzHrb8ttTjjSrInj9BrACys8+z2W7cfkzdERblNX0P2?=
 =?us-ascii?Q?0LLeLqsSJEWnf3Ix82zla1pL3XJhB0NgjKPIS2YF005Ixq3tL060l3qbz+gL?=
 =?us-ascii?Q?indd8RP7OlTqsq857hvT9VNPMGRoD5K9W3V2QguaEXFmIMIx0m6Bv1WbWSfM?=
 =?us-ascii?Q?qAnUsiQd5rOqaFrVbPNkc55/CqhdiFKQ5PWMogepLIT97nNCYcSiW1KGXVAe?=
 =?us-ascii?Q?VjQb+xSxC6w94mtPa6fq8cZ8ERriaZcvEi8UX2Iz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6da714-a053-4baa-8954-08ddc06f4e92
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:37:25.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wtav3EV14n3q181VVVRgQ3FdKrmoCIBqPFcGb6G3zkl50iTJ9CEOk4y5LWJWXRoK2iQ4xEk5eHA8LeF1uIsWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213

Hi Dave,

On 03.07.25 16:49:11, Dave Jiang wrote:
> 
> 
> On 6/10/25 10:29 AM, Dave Jiang wrote:
> > It was a mistake to introduce core/acpi.c and putting ACPI dependency on
> > cxl_core when adding the extended linear cache support. Add a callback
> > in the cxl_root_decoder to retrieve the extended linear cache size from
> > ACPI via the cxl_acpi driver.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Applied to cxl/next
> 1a45e1cd694fdf2d2a22e3c70a6917ff39fe77ab

I am sorry to come back to this patch that late in the process. While
rebasing my current region rework and address translation patches I
came across your patch and realized that I have a much more simpler
rework of that in my patch queue. I extracted that patch below from my
series I am working on. Could you take a look at it? The changes are
less intrusive and part of my rework required for address translation.
If it looks good to you and during review, I rather prefer to replace
your patch with this one. Note that I have follow on patches that
reduce more code and remove the cxl_extended_linear_cache_resize()
function entirely.

Patch below bases on:

 ac0fe6a57317 cxl: make cxl_bus_type constant

Many thanks,

-Robert




From fd3f1f5b33313bb10a2e51861031015ac48a8cd1 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@amd.com>
Date: Fri, 11 Jul 2025 11:56:56 +0200
Subject: [PATCH] cxl: Remove core/acpi.c and cxl core dependency on ACPI

From Dave [1]:

"""
It was a mistake to introduce core/acpi.c and putting ACPI dependency on
cxl_core when adding the extended linear cache support.
"""

Current implementation calls hmat_get_extended_linear_cache_size() of
the ACPI subsystem. That external reference causes issue running
cxl_test as there is no way to "mock" that function and ignore it when
using cxl test.

Instead of working around that using cxlrd ops and extensively
expanding cxl_test code [1], just move HMAT calls out of the core
module to cxl_acpi. Implement this by adding a @cache_size member to
struct cxl_root_decoder. During initialization the cache size is
determined and added to the root decoder object in cxl_acpi. Later on
in cxl_core the cache_size parameter is used to setup extended linear
caching.

[1] https://patch.msgid.link/20250610172938.139428-1-dave.jiang@intel.com

Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c        | 59 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/Makefile |  1 -
 drivers/cxl/core/acpi.c   | 11 --------
 drivers/cxl/core/core.h   |  2 --
 drivers/cxl/core/region.c |  7 +----
 drivers/cxl/cxl.h         |  1 +
 6 files changed, 61 insertions(+), 20 deletions(-)
 delete mode 100644 drivers/cxl/core/acpi.c

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a1a99ec3f12c..712624cba2b6 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -335,6 +335,63 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
 	return rc;
 }
 
+static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct range *hpa = &cxld->hpa_range;
+	resource_size_t size = range_len(hpa);
+	resource_size_t start = hpa->start;
+	resource_size_t cache_size;
+	struct resource res;
+	int nid, rc;
+
+	res = DEFINE_RES(start, size, 0);
+	nid = phys_to_target_node(start);
+
+	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
+	if (rc)
+		return rc;
+
+	/*
+	 * The cache range is expected to be within the CFMWS.
+	 * Currently there is only support cache_size == cxl_size. CXL
+	 * size is then half of the total CFMWS window size.
+	 */
+	size = size >> 1;
+	if (cache_size && size != cache_size) {
+		dev_warn(&cxld->dev,
+			 "Extended Linear Cache size %pa != CXL size %pa. No Support!",
+			 &cache_size, &size);
+		return -ENXIO;
+	}
+
+	cxlrd->cache_size = cache_size;
+
+	return 0;
+}
+
+static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
+{
+	int rc;
+
+	rc = cxl_acpi_set_cache_size(cxlrd);
+	if (!rc)
+		return;
+
+	if (rc != -EOPNOTSUPP) {
+		/*
+		 * Failing to support extended linear cache region resize does not
+		 * prevent the region from functioning. Only causes cxl list showing
+		 * incorrect region size.
+		 */
+		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
+			 "Extended linear cache calculation failed rc:%d\n", rc);
+	}
+
+	/* Ignoring return code */
+	cxlrd->cache_size = 0;
+}
+
 DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
 	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
@@ -394,6 +451,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
+	cxl_setup_extended_linear_cache(cxlrd);
+
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79e2ef81fde8..5ad8fef210b5 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,7 +15,6 @@ cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-y += ras.o
-cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
deleted file mode 100644
index f13b4dae6ac5..000000000000
--- a/drivers/cxl/core/acpi.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
-#include <linux/acpi.h>
-#include "cxl.h"
-#include "core.h"
-
-int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
-					    int nid, resource_size_t *size)
-{
-	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
-}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 29b61828a847..9462aea9ce9d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -120,8 +120,6 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
-int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
-					    int nid, resource_size_t *size);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..bc542a7142c0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3282,15 +3282,10 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_region_params *p = &cxlr->params;
-	int nid = phys_to_target_node(res->start);
 	resource_size_t size = resource_size(res);
 	resource_size_t cache_size, start;
-	int rc;
-
-	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
-	if (rc)
-		return rc;
 
+	cache_size = cxlrd->cache_size;
 	if (!cache_size)
 		return 0;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e7b66ca1d423..4643a95ca111 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -432,6 +432,7 @@ typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
  */
 struct cxl_root_decoder {
 	struct resource *res;
+	resource_size_t cache_size;
 	atomic_t region_id;
 	cxl_hpa_to_spa_fn hpa_to_spa;
 	void *platform_data;
-- 
2.39.5


