Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8D34751B
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455892; cv=fail; b=CNPMRZGRq/naBUavzRbdgMNSRsQPiltBBWaZZttGX347fBr8XRP0g7CIiM0ijyx4raAv6vqvy3pgIB/khBEftGkb3ge5BGVUYAEDImrb+42NC/OWEnny1ZO7iHysmB2CR5VkXo3idKQ9rXqoB1b5pLE6NFGYgWS8iqk0PgJ2AzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455892; c=relaxed/simple;
	bh=z233/v9TFeVf9EdiaEynOBBmEzsDjwMuhsRSp85GxF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ATqFqP96XEOhLbAK82kgcc7krjXlUg/siFr47iCfyL5cMBtsp1EYkNTH0vrNy1z/Hp70+uN1APKIyNAbqztVbyoiCtezk9FhOWtkMQvlB//WYSqDVsajy6Hgwbx7GQllLJV3XFPUazSt9spWUBsm4b+sYDbkNmJrJpY5FxDOcM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dxiuUB8T; arc=fail smtp.client-ip=52.101.53.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dxiuUB8T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSzyCYTRD3ZsN17dhn/2plxayPMvKfYGkhjSEtb2O3r6djZ3MJEDH61/9tcdoyM9tdRXS5Dwsw0HWTiCpjG8Gd0HLFHt3syMYYVpLUFQtI8dxH5yFrbHQkYynRKDA8BvTQQTr4CcbN5lAcWHNuj1BUTzuZBb4Mh55D5NeOdEfqYILwED16uP6dcZb2WPqXZbrWtRiKjr19sZqvTgD+7Ns9kzwacDz6UNG2/TihB1mYKkvvAb3sxhQtY65cQmu9qZDCz65Cdv0zgppKF+AERc6xJWCIxf9MVo1cPn/8Mk4tLxH97twVogTQeRq4KJvUe3ge78u2tY47ywVD15F+kJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ1QZlCmCQKK8guwiY8nq4Xsi2WZgko+vWlEBSEBmhg=;
 b=eSYeVP8M/3qeZ6aWDXbL6pwNmCkvAxDUtBJQHXqlc0cyra5nkeVbVQr9b9JLqpUNvgY9nFczkoxfLx9xYC8MAe2CjUy+9tYWxtjRqhVlrTi7WapRu7O1XDXl5Y8EzHE6nB14vDqbm3r7lhCOnFWZJyzusz9//ASSmMmbtFqin2pnwc4S8w49wzznd/R/xlhdvAhZ0ummkBiLqWbEf78rv3c45qjngRTnABE/DI8fJ4l3NHxYfAZ6Q/5K8nua3wnoIsz2+rtk53TbjCuC2MTy/UVvGaSCdE3nzWS5yso7ik8PifgHiMmJV9QrwrsnRZo9J36EJMKN7l3BulD7KHcnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ1QZlCmCQKK8guwiY8nq4Xsi2WZgko+vWlEBSEBmhg=;
 b=dxiuUB8T30U7Z83R5Vdq7KFP4jyEb4QHiXqT9ifHfdSw0zBWJRllEdXalpAnHiDA4kqDh3K21JbxK8FC219EHEeQVHzx/D1nIjlCxxaTxm3BKlRbndHvW0AYL141zpwC1z/9SnJGbrGcytatffxUWC4Aa5pkpc+fx8bL7g7Sl+Vfgm6zS6HfOz0YEjPSrWFTIx5VRgnp8F8x9lvJ98UyD9zCT22tADDAxyBxfmuL5bWnR9BEcyh2POO48SFvl57XWPbiVedNmLuumwoupW//GxHl/lmDW/g4i+fV0Q4iPThE6999sbTFFd7hj9/vLTMjhf0OYh+H0kOlE01YJz1PwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:04:47 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:04:46 +0000
Date: Tue, 15 Sep 2026 15:04:42 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, 
	jic23@kernel.org, dave.jiang@intel.com, gourry@gourry.net, ming.li@zohomail.com, 
	vishal.l.verma@intel.com, dave@stgolabs.net, benjamin.cheatham@amd.com, 
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, 
	Wonjae Lee <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, 
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 1/8] cxl/mbox: Flag support for Dynamic
 Capacity Devices (DCD)
Message-ID: <aqjsuqQP0dmgJyJs@MWDK4CY14F>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-3-anisa.su@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-3-anisa.su@samsung.com>
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b252d8a-b412-4df8-2377-08df12f7a067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AoOc86rZEnQh5G6h/K1kIIdebge/cSelRR7DaEYINFKcKqCmy4jRa3XpVCf6ZjXabCkjS33Cc+6uNUhTDWDxuJkS9hz8nOrFOykkQaFJij7Q6HkYDfgsz8oD3fj/UoGoHMAiSRg+fb6N11akqNLaSUKHL3IX1Z1MUCwMEX7Go+AgrJY2j7+7HOlTw8J/zMCKi2PIupurBVoiHLTU7e8fpXt4vzG9TUbUk5FkM57qg8Ggw4VgwZTsYLUqYPhWoHuRuiv3gUneCQXeCAxQexjARGirTqrHR9Bn8ZZ648x7w2diW4MGjAQ7aq/nf98A3SCw2toLcBRXSiTfYGjXnzYtBupPwGGqNoTHmcUO26yA71q36RQ39hEPHoISGMfixU85YbSyK4UEF1QdC1a09UnFF5Dky9lKXb0KZw70rVgbQY3DupZx6NWgeU8f76bUY5MVVbg49MK3N9j23LgUcpqBA9r5MC+bLHCs27HYK3ZeugfO0vfShFXFC02cJ7686mTfg2xUcUL2tzQP3DAgXVB4VfX6TqXlFzkY0XUVFCTCGMZYLG2MY/06eok5Xxe/y4LtS+Fa0kOPS0C1U31nWQalaQAnJfHufWI7rhj8EuQrLDJpqtZKhHHIlXYuVuj7Qc1/ImZHCahN0kySxTAtMMWyxM7+dwbwOTKOc0KhH6JomHw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1cbsNmovjp0nvaDYFY4HoY/aTzEbnZa9wf0sCC5CYeahjfnXsmvedsD6Y7V?=
 =?us-ascii?Q?ENfoVqu1NMmpszRIgVTQ6hm9qYaVGlMf+9WzlG8GOxvP+x8PW2WW5CySrNhh?=
 =?us-ascii?Q?EOKh44kdTkeVcOAUDeAqvZTTEMO0uoI1CG6KgqQFLYgo5lK6BWAryRNSGGc9?=
 =?us-ascii?Q?b0MwdokqOwE/2RWg+sakSWzit59cZPozUvA53U4DQlBHzeeBZ6ROc/dY5kpa?=
 =?us-ascii?Q?rJTJuRBLsIe3pQ8de1ZM43VS3MW4iEiHgWpUHB4qIhneoYLkLIpceoZTdxFN?=
 =?us-ascii?Q?sgsM1gUfIhQqOH81Q5WDNUpcM1DiKNt12Yr5MTtLE3wGFoLeCZK9w65Gi/XG?=
 =?us-ascii?Q?SBMscbURz3xZdr1p5wkGMorka6/0dlrMRaWEYp/mDu5yo51wo8pJaleG0PIB?=
 =?us-ascii?Q?IEOt7m6TbkP7ZQl3M7fTa8WPIfbKDshW3mz9L8nM2G++yWiAn3/HdzOa1FU6?=
 =?us-ascii?Q?uDt84cDsjnNNGcRqvlhCy19Ir2LnlUdZc17uhL7SkKd7Bljg68ff4yKNUSgB?=
 =?us-ascii?Q?ueZsPxRYgVZ3uOKf8q5nuVmkAZMLy1AqGFumMsWQe/HGXQ2JCYoKii3Cui69?=
 =?us-ascii?Q?TSOeV6ZU0XRZgi3PabdKuutwRo7EHptY8ToKnGerNGx8Jk+2KZkueEB+pR7U?=
 =?us-ascii?Q?6EM0NMElw1QE/1+Te3w3xGlwAZPPdHxjIqfq/08WrkAhyKAOYHtIFfQrxVIJ?=
 =?us-ascii?Q?WaPbLGHptZ/l8zAjIU31aFcZL5eGsIbHWF99L7tgcfqKTn9LrFGZQvaNrGN3?=
 =?us-ascii?Q?kan+bt6gZMWhOu99wJtvlH7Crqw2ZzX2Y4lsb9niTmISxxVrVLUtaS/O9uEz?=
 =?us-ascii?Q?C8KTT5y8kzl4zd4UkkZnCE70Z2nCy1SfSWrKRFSJg9XCdQA6AAMDxutwBXMt?=
 =?us-ascii?Q?AgAmS7y1blrxwJ725xykvTQBllEDUry2qdVh5M4xzjG1noG01cKk2mK2EaWR?=
 =?us-ascii?Q?ToGD0C3gLL8CNAYTWKbNLxWqiZOQ/kLkcvnpcHk8u8/8VH7itJ1+JaAbXqpk?=
 =?us-ascii?Q?b/+F16abG58yMFhpzqODEmK1x7uUCMpc/ERTW01OiIES4AhOJZer9ohWaZ48?=
 =?us-ascii?Q?EojSMS+cQ/E+q+9P0NYvf5C61rsvNR5ZXIphmd1lDaYwHb4NTSE0GLEkxSy0?=
 =?us-ascii?Q?rQhZwhsjxLb+J92EXU2XRVNudou0ArWp3RHfYloMcridNdDscKZ7Xp3X3wXW?=
 =?us-ascii?Q?r/5IHjle8Pel5k3Vg+/+YX5BdOCPAbtvWhjg6XSKue5oRE2tX2WUHdo3lOgb?=
 =?us-ascii?Q?nAen5wGZyhoASke+jLmm0gtRbBxl6+iosLEWLG16EJbubQSLqwqnFQsJ1fLQ?=
 =?us-ascii?Q?9ZXkP8l2eBPw9P7aYg9nZt2uBl01DL0BTznV7/k6XPfk9GphTWRVGD41DHka?=
 =?us-ascii?Q?XzkA33wFY1kDJR/7Oujb9+9y+2lHLFF99/RbKmoDoRws0VXc6cn/9PYf5FuC?=
 =?us-ascii?Q?JXe59DsU2vrt6GH+cxsNBkZZV6GphPvzK6eriXS0RR8zOwNumKMPCzrFBfZ6?=
 =?us-ascii?Q?IsULVNDH0eikJu1XXW11VsFGq2W+BsGyLNW0GbhBToCzVvE2mI+89lMSU7x6?=
 =?us-ascii?Q?8LKVSP5p/1eXlZ35UK66CflQv5HpYbOtasYoSCybEkTMx4hF+l+g8v7zFItD?=
 =?us-ascii?Q?x/rxwbVE5HLJZeJKW1oZj5kiAVsE3JuQ6n41N8me8vB9q/MpGzRKWgGiAX5K?=
 =?us-ascii?Q?9bJBKjPmHGbDDGBPz6i0qcr3+q/7bl17g8nRapNHKXd6XasY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b252d8a-b412-4df8-2377-08df12f7a067
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:04:46.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbhlEyKKn1IQnF6Rz5Mtl77Gm0p3WxethVXetHabD5cWArPnQSPcVCYjqd0zVsUP+55HAMfEjmb0ehMcCy3C/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323

On Tue, Sep 08, 2026 at 03:15:05AM +0800, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Per the CXL 4.0 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
> 
> Detect support for the DCD commands while reading the CEL, including:
> 
> 	Get DC Config
> 	Get DC Extent List
> 	Add DC Response
> 	Release DC
> 
> Leave mds->dcd_supported false. Dynamic capacity is only usable once
> the driver can handle Add and Release Capacity events. Detect and log
> the capability here and let the commit which adds DCD event handling set
> the flag.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Just a small nit below.

 
> ---
> Changes:
> 1. Commit message: explain why mds->dcd_supported is left
>    false and when it's re-enabled in the commit message.
> 
> 2. mbox.c: drop the single use cxl_verify_dcd_cmds() helper and test
>    bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX) directly. Reported by
>    Alison Schofield.
> ---
>  drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 20 ++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01..199bb986d674 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -171,6 +171,33 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
>  	}
>  }
>  
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48
> +
> +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> +}


why not (opcode & 0xff00) == CXL_MBOX_OP_DCD_CMDS
and #define CXL_MBOX_OP_DCD_CMDS 0x4800

so we don't have to shift bits

Best regards,
Richard Cheng.

> +
> +static void cxl_set_dcd_cmd_enabled(u16 opcode, unsigned long *cmd_mask)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, cmd_mask);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static bool cxl_is_poison_command(u16 opcode)
>  {
>  #define CXL_MBOX_OP_POISON_CMDS 0x43
> @@ -759,6 +786,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_cel_entry *cel_entry;
>  	const int cel_entries = size / sizeof(*cel_entry);
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
>  	struct device *dev = mds->cxlds.dev;
>  	int i, ro_cmds = 0, wr_cmds = 0;
>  
> @@ -787,11 +815,22 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  			enabled++;
>  		}
>  
> +		if (cxl_is_dcd_command(opcode)) {
> +			cxl_set_dcd_cmd_enabled(opcode, dcd_cmds);
> +			enabled++;
> +		}
> +
>  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>  			enabled ? "enabled" : "unsupported by driver");
>  	}
>  
>  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
> +	/*
> +	 * Disabled until event handling implemented.
> +	 */
> +	if (bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX))
> +		dev_dbg(dev, "Device supports DCD; capability disabled\n");
> +	mds->dcd_supported = false;
>  }
>  
>  static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..0c8e23276dc6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -252,6 +252,20 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/*
> + * CXL r4.0 Section 8.2.10.9 - Memory Device Command Sets. See Table 8-308.
> + *
> + * The 48h Command Set (Opcodes 4800h - 4803h) defines the device-enabled DCD
> + * commands.
> + */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
>  /* Device enabled poison commands */
>  enum poison_cmd_enabled_bits {
>  	CXL_POISON_ENABLED_LIST,
> @@ -427,6 +441,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @partition_align_bytes: alignment size for partition-able capacity
>   * @active_volatile_bytes: sum of hard + soft volatile
>   * @active_persistent_bytes: sum of hard + soft persistent
> + * @dcd_supported: all DCD commands are supported
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -445,6 +460,7 @@ struct cxl_memdev_state {
>  	u64 partition_align_bytes;
>  	u64 active_volatile_bytes;
>  	u64 active_persistent_bytes;
> +	bool dcd_supported;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> @@ -505,6 +521,10 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> -- 
> 2.43.0
> 
