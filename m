Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A0419412A;
	Wed,  2 Oct 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903751; cv=fail; b=WHs6K2oB7dVnXbXf2mrRzpCbGIdFrXV8dXpiiSq6Nmox445Y1Ob4tUMubIZaoohVxuw363UyM2UUYDAKoEoO5iOFAjL0O3F9IcEZVAEz2LrIhsWJY/R8QzOgk1sLQlJR5tllf8kT7Q/9NOROdQvZJ6kvrTn/gOcOtrNFX2VrHtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903751; c=relaxed/simple;
	bh=uCVi/rGDwI17FKIsQx42z4+Z4oXS/H+veSgRJWDqYZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T6ytUxbjHsoyVIzKn2g0EafYEokPqVKiHIFOkYSA47ejVplI/TDEijpHc/fjv1+mlbUHwznPGsaHDT7CBunYkGYQlcEBgrs5qwWqUOOJHkkE8fcmb9gG/c6L04wjY1a1vHq9VAK4NAVhqsH7kJjpshWX0vCmhMVWZHycXDujH28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q6/ZQg0q; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q6/ZQg0q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMufMB3Rbmk8fmENWhHXZMHfgt1mCJYbi3W6yj85LVMbU7MHI2zz/UQuh0BoEKiCSIBgqFxACeZCjUoKAM+MXXXxxi92DbArujXgUBGzoHONL+BuZKttTEsK0P1GRwHwuGLXNiOQ7yzsaRpfwMQPVKG7rjaVqNwMlNlMsxaz3QiVyV0iGyRG/M4ofBtlvEurEULPvWYlh06qCyqjQwCErUom8xGzY2bU4qwN+UUX4URqAqIxUD6AgS8NzZlXKEc+HjWBuCO8D6KlZw3Zi/wvtXcawDf2ZWHrcdQr64x/TPjnBnYsh5QevmQJRrlxO+dToBrIsu/xhD+OzW+oZOiHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPQ4KIOybiRtLywHyu24pslUPkVFisWfU+GD2SwwSlY=;
 b=OEzmwNHb0EvPr150ClYHcmQb1lAFVZ1w6sp8/6ohITH1rHm5XhC4tuLkZbOPmNfSOw3zUR9Zi3TSgAodozO6gxe9VZwI+Zi4LQNT64qXlmnB/5iMMq8U6uE95ocy02GdIcfUe9rIsbGPpOLF7j0QT6plZUBQ7c1H3PU2J/FaII9fQ7sjcN4uF3DPLg9S3uRE38NYo7N62FYoCrRMtgyZFJfSZEyjRrSjT4xT8ujrTJE1z2AQIc1hIo2WlMDZhwFEc3WGFS3KbBoeNLIFhyfE96rhrQSqmHEPL1/k8Z2IPqvakOptvxgQxhHCIigBpyzFEbtIXYawNR5dWSGsr6Sv4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPQ4KIOybiRtLywHyu24pslUPkVFisWfU+GD2SwwSlY=;
 b=q6/ZQg0qvJGKzSPBy7Kh8M7ThRg5WrS2geI20guQVc7v94lbTjr2b9+Nl7587qLJV52GLOzFiEBbY8IdCd3p/OdaQbqtwRyqrx8lyvQR6RQow7qrEQGXMy933pWdAZ/aI/heWzv14dH/20w7RV1jwvKAPM2ROV6UDmalO3G4WoM=
Received: from MW4PR04CA0054.namprd04.prod.outlook.com (2603:10b6:303:6a::29)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 21:15:45 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::9f) by MW4PR04CA0054.outlook.office365.com
 (2603:10b6:303:6a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Wed, 2 Oct 2024 21:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 21:15:44 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Oct
 2024 16:15:42 -0500
Message-ID: <85a73846-4d8d-4f28-b748-24904b749bca@amd.com>
Date: Wed, 2 Oct 2024 16:15:42 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] cxl: Set type of region to that of the first endpoint
To: Huang Ying <ying.huang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-5-ying.huang@intel.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240925024647.46735-5-ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: b4384ecc-1ec6-42cf-7336-08dce327610c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri9sQ0pYZ1puSUhhaWpsTUl1QXZTQTZyeFhXbXVEWFlMM2ludDYxeUsxNHBj?=
 =?utf-8?B?a0Z1YzVQUGlNNWswNFRTK2d6NHVhamdnUnBqWWJRc0pLd0xuTVdENWNnMlBN?=
 =?utf-8?B?L1dCcFN4UmJSTW1iZmc3YlRlRXZ6MkRaYWxSam1QZncyRFR1aEJsZFR4RzZ0?=
 =?utf-8?B?bnZ4UkNvVXBDMDJ2ckNhWEkrZ0h4d0dNb01sT0xUdVFVM0s3Rmt1UFMvZHJP?=
 =?utf-8?B?YUNITGtoRU1VYXdnZ2lEZWZUaVBlK1lDRGNlTnN6UHN2TWQ4eVVzODNHZjBO?=
 =?utf-8?B?ODhzVWpoU3Q4RW03RVdrRG1DYnZRUEhzZHlTa1dHUDc5N3dSdjNmTTB0SXg0?=
 =?utf-8?B?ZHgrMUhvbzhtWlhla3VkMnRDTkloNDFvRnNvQWgvY25wWGJYdWlSbC9JQldL?=
 =?utf-8?B?SUVHc2NuU1lHNHNwYy9SeFFOTDNmVlJwY1JXUERESVVKcUo0Y1l2czF3WGFh?=
 =?utf-8?B?bk5Nb2FvaUVsbWVLb3ZZRGZyS20xVk9aQmt1WlVGQ1RESUNURkR0cnlkcWJX?=
 =?utf-8?B?M2RwSlB3OHkwcnBFZ0lxVUdFYktHejA3NVJ0eWpYYmw3cG5rakw5bFMwc2Ew?=
 =?utf-8?B?cXZ2MUc2OEI4NjhvRnVlQmlwL2hiSEV6enp2d09zWElmbHhqdG54a3BEWXhK?=
 =?utf-8?B?SkVXa3NxbzdkanFNUlk2K2dxN0VGT3dhVDNlbzBtMTRsV3lta1FWb2ROc3Fi?=
 =?utf-8?B?SVY0YSttQlFKbzRWU3FtOXF4SmZJZVRKbkVDazdlWjg4YXlzdmZyLzVtQTNw?=
 =?utf-8?B?dHhQSEZwRzcwbDVyVXZ2bGtDRkp2Um1xa2k1THFxTmIrOWttcnBFdWpuQURV?=
 =?utf-8?B?TVNNM1h5Sm9XS0RpZFdEM3M3NnZXMXY1YVlXa29vcG1haGhXZFdTR2g2SUVG?=
 =?utf-8?B?SkVaRHlsdHROZGFmbFZhUUFGakZVWURPMXhGUjZWVkJIUWNHVXhZaWNCU3N6?=
 =?utf-8?B?dGgvQndtcE12cy82cS96dHZ0dlp2TkpVTy84ZG1KcjBMeHN3UkdhZ3RvWXRx?=
 =?utf-8?B?SjZ5Ujh6blVUQmN0ZERjSWljQlliRDA0WUlTdXprVkE0M1pGOHlNeFpCLzJx?=
 =?utf-8?B?SnVFQnVNU3BxMSs2NWhmOUNxRWxuVjBrdGNiR2FRMVpuemdLQ2VxeEhEeWo4?=
 =?utf-8?B?Z3BiNE9FelBVTWg1c3hlOHF3aUxmWXRUUitvTzVMZy9ESCt3aVpSQU9BQ1lY?=
 =?utf-8?B?c2NIeGFzMkRUN2s1WjhvRmlkbHAwUjg2ZEVNaTMrdHJmbCtuaUtGUXhFeUhq?=
 =?utf-8?B?K2dIandhcTlqV25wdXpVeTRzclNGeXJ4OUd2UElEVFY2L1ptZnJwWW9uOFRE?=
 =?utf-8?B?V1V1QWsrUW9XL1g2amllTDVja2J1M0JGaW80ZDlRR3lmTVJaQlZidDNFNGxp?=
 =?utf-8?B?dDdVdFZuanM4dHhGOHJ0OGZTblh3WnpBNE5hWTdtYk10WVl3ajJ3T2tCNnRj?=
 =?utf-8?B?WGZuV3FId01sN0JDYTVMVysyT1pGczV2UlNmMXhOQ1ZLd2t2TkRsc214cmZM?=
 =?utf-8?B?cFMxZkJMdHBPVWVWNGtUSTI2M3V2Z0o2ZzQ1bjBsazRydWRHUTlSOWRTMkdw?=
 =?utf-8?B?c2kzbi93TUhFV1dkYStuSUFvWEpnNytrUzRvYWJlMUlPeGJJUEFGQ3kzd2Ni?=
 =?utf-8?B?N2xhd21jVVZST3lRWTk2L2pOaWhMVlQ5b3Q3VFo3K1hlUC9IV2lSZ1hmb04v?=
 =?utf-8?B?UEdPakIrVXdJbGRsMXVzRmRFRUZSeTRJdTFmeEIvQ1o3NHBNU09HUlFWQ2Vq?=
 =?utf-8?B?aEdUL3VqY2ZaR2RieXVnTXVPNmxBVThNZ3JNZlBYUW5LUVBNMFV3cUhUL0F1?=
 =?utf-8?B?ZUQzTEV2NW9IemlCU3lEQXprNUhzUElwWm92NFBady9jSDlrencrQkx2RWFn?=
 =?utf-8?Q?LEjDqkc9XPBZY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 21:15:44.9640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4384ecc-1ec6-42cf-7336-08dce327610c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

On 9/24/24 9:46 PM, Huang Ying wrote:
> The type of region is hard-coded as type 3 expander now, because this
> is the only supported device type.  As a preparation to support type 2
> accelerators, we set the type of region to that of the first endpoint.
> Then, we will check whether the type of region is same as the type of
> other endpoints of the region.  Because what we really need is to make
> sure the type of all endpoints of a region is same.
> 
> The target type of endpoint devices comes from expander/accelerator
> device drivers via struct cxl_dev_state.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c        |  1 -
>  drivers/cxl/core/hdm.c    | 28 +++++++++++++---------------
>  drivers/cxl/core/port.c   |  2 ++
>  drivers/cxl/core/region.c | 13 +++++++------
>  drivers/cxl/cxl.h         |  1 +
>  5 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 21486e471305..29c2a44b122c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -382,7 +382,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_EXPANDER;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 478fb6691759..c9accf8be71f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -841,18 +841,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		.end = base + size - 1,
>  	};
>  
> +	if (cxled) {
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +		if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> +			cxld->target_type = CXL_DECODER_EXPANDER;
> +		else
> +			cxld->target_type = CXL_DECODER_ACCEL;
> +	}
> +
>  	/* decoders are enabled if committed */
>  	if (committed) {
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
>  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>  			cxld->flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl)) {
> -			cxld->target_type = CXL_DECODER_EXPANDER;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>  			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
> -		} else {
> -			cxld->target_type = CXL_DECODER_ACCEL;
> +		else
>  			cxld->coherence = CXL_DECODER_DEVCOH;
> -		}
>  
>  		guard(rwsem_write)(&cxl_region_rwsem);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
> @@ -874,21 +881,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  			struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> -			/*
> -			 * Default by devtype until a device arrives that needs
> -			 * more precision.
> -			 */
> -			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> -				cxld->target_type = CXL_DECODER_EXPANDER;
> -			else
> -				cxld->target_type = CXL_DECODER_ACCEL;
>  			if (cxlds->coherence == CXL_DEVCOH_HOSTONLY)
>  				cxld->coherence = CXL_DECODER_HOSTONLYCOH;
>  			else
>  				cxld->coherence = CXL_DECODER_DEVCOH;
>  		} else {
> -			/* To be overridden by region type/coherence at commit time */
> -			cxld->target_type = CXL_DECODER_EXPANDER;
> +			/* To be overridden by region coherence at commit time */
>  			cxld->coherence = CXL_DECODER_HOSTONLYCOH;
>  		}
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2dee78e9b90c..5633b7316cb3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -139,6 +139,8 @@ static ssize_t target_type_show(struct device *dev,
>  		return sysfs_emit(buf, "accelerator\n");
>  	case CXL_DECODER_EXPANDER:
>  		return sysfs_emit(buf, "expander\n");
> +	default:
> +		break;

You can drop this imo. It doesn't change anything functionally considering
the break is immediately followed by a return.

Thanks,
Ben

>  	}
>  	return -ENXIO;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cec7d08b6f44..9c68ec445128 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxled->cxld.target_type != cxlr->type) {
> +	/* Set the type of region to that of the first endpoint */
> +	if (cxlr->type == CXL_DECODER_INVALID) {
> +		cxlr->type = cxled->cxld.target_type;
> +	} else if (cxled->cxld.target_type != cxlr->type) {
>  		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			cxled->cxld.target_type, cxlr->type);
> @@ -2482,7 +2485,6 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>   * @cxlrd: root decoder
>   * @id: memregion id to create, or memregion_free() on failure
>   * @mode: mode for the endpoint decoders of this region
> - * @type: select whether this is an expander or accelerator (type-2 or type-3)
>   *
>   * This is the second step of region initialization. Regions exist within an
>   * address space which is mapped by a @cxlrd.
> @@ -2492,8 +2494,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
>   */
>  static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  					      int id,
> -					      enum cxl_decoder_mode mode,
> -					      enum cxl_decoder_type type)
> +					      enum cxl_decoder_mode mode)
>  {
>  	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
>  	struct cxl_region *cxlr;
> @@ -2504,7 +2505,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (IS_ERR(cxlr))
>  		return cxlr;
>  	cxlr->mode = mode;
> -	cxlr->type = type;
> +	cxlr->type = CXL_DECODER_INVALID;
>  
>  	dev = &cxlr->dev;
>  	rc = dev_set_name(dev, "region%d", id);
> @@ -2576,7 +2577,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
> +	return devm_cxl_add_region(cxlrd, id, mode);
>  }
>  
>  static ssize_t create_pmem_region_store(struct device *dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 99398c868d82..2a2d2c483654 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -324,6 +324,7 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  #define CXL_DECODER_F_MASK        GENMASK(5, 0)
>  
>  enum cxl_decoder_type {
> +	CXL_DECODER_INVALID,
>  	CXL_DECODER_ACCEL = 2,
>  	CXL_DECODER_EXPANDER = 3,
>  };

