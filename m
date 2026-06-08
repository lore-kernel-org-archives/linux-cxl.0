Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3034313E29
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953059; cv=fail; b=k0p5LkVS3dxfvNKGQNg8w4OZzzUgcO58AAEc7/cHOHI2EFu3q+eRmNiVPmOs3vxxvKLtY04IJkA464lL64wZl04qrvOlmHLUknyGWomavVTqAfyRnKOVhfGjpmCCfwl6me/ejKqQ6OVp5eqnkEGNgGJ7WfxO3Pm3ikFRLPqthSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953059; c=relaxed/simple;
	bh=ie/I5Dzc9Uh6hNwMiG9HvS9FtgBCX8MTIMW0V41Rcu8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ByB1pD18yqXbL9E8dlrbDfP5Sq/C+A0NQFLXq80yDNfmxnkPe3UyLn5NB+zk7npzj247clZzBQIDtlysxucA0mqumw3i+G8ShCWchFpBTh2f4UMFn9UblTsfnKHixLK4S6YD33UraVOXXYqkW7KqfRcIA7WX1Cu3jUdPF+9x+Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KIupGurw; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KIupGurw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBMPH0mhXaizvcFtMNNsW1brmuUF58W7Re1KBKLwedCGVYDqawbPGxwhB2jaBu6qa+o4CJword+JTAz9bu4ePOqIlQ1HfE4J7mOW/KXo/A5msmrY86BX+KMCINT+dx1rZQ60o3d5uygGoRSAHyX6IMUtXfky+GDVnpbCrq2KnlPEpkR7eafNXFc/oyYSXCjaiwZSnkZHlPfNwUPq43bQkCgWnIJSwn/neXpFkt2ItUN9oY7s1l8dNtDkSzGoYgf3mJ+fZ2287JCl/qgBydCMtEBvamP34Ygh4jXxq6dF6WW9r6FXWuW2zgAhCXZKIk0TN1ewAbAIl7ggt3BMpvCKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzNuTBqmp2Rr8IAyXLastan7ozHf7VAEjSYwdKd7uVw=;
 b=Gg/VNxALkowy0+j6+ZP35rqm0ej6nBMFNTJx40FeyuSZEizoyUDclAiSJJl4QZwWA/BxusX1gL9uhpoe8ECHq7hPg6mM1APuyRZnXEFY2rOuljsHj1KvoA7kFcAh636S9f+obY0g50z9iFpcSAEAjL6t61+7r2aGnf8ohkV2FOZButJZo1plYr1V+j4RJ1CzayGW1cdptrjjnLzOLZtUN9GEvbPQbdhpClmW/U8uOOTAYXtkUdqMz2UZN24qqhKZ8LcQ+KXQGPZxv9CsMte/vBRR+YtYTuUqao4BnoV/GK1yTrBrMixW2RkOpluBKiMHNywry5l/YKOYBINUTPQmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzNuTBqmp2Rr8IAyXLastan7ozHf7VAEjSYwdKd7uVw=;
 b=KIupGurwpoQWF8jimWPCjeaw1ZjaGdT+w9tMdCEPKliCbbqEoH9I0y1gnWgN2n+JnzL7e11TYHnFXFMwFD+mVJqSAVT0Wzzfarxizmm+3WcPFsrmVrR+bxr+IRzHL6kfaqgxPo+MErmw/9sie3dDRgrfHd07jDrTxLr+5YDd8WE=
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 21:10:52 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::13) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Mon, 8
 Jun 2026 21:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 21:10:51 +0000
Received: from [172.31.129.70] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 16:10:50 -0500
Message-ID: <d5b9470c-cdf3-4bcd-853d-f5e6c1ee174e@amd.com>
Date: Mon, 8 Jun 2026 16:10:49 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/5] cxl: Add HDM-DB region creation
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<gourry@gourry.net>, <dongjoo.seo1@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-5-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260605003329.2584012-5-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 923543bf-f720-4361-afcb-08dec5a26bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099006|11063799006|5023799004|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AzkJjCxRzHtWvmHKmou+N0RyM8Q9mnCUZdB+jrUO/JORCPgdAe9sNFjGhpjN5wdPUPkyX8Qe9u6koQhs+wqgty72wyNeUkBmUJtvC6SG68pMJYeONPM4C4Ysx3605z0sgJcaTXxb7ma+7Ed/YzV5e8WQVz+CLKjbOmXhbMMbny8H0aG7Zpt9H+ZkShyN0BtCdO3MAENSRf5kEWG41HfmZjRDjYRCTEXLqj6xuyrv0U05btD/0UR7MPqM2RkyATlnch+zZXvKFk3iIxpPkLaFC6u4L/7sIS1dUe+JJSoYfmPgOdGwHOd+7VA7ju03+AwHEGdMPCJS66ocqJ5jsaIkBP/EK0f/7ebhOw1x3+OJZJXGf85GewU/bW6a5eZLLDGPRfq81fa67tZbeZABf+e+O7SV0yt4V170QUThDpA3LjhFpxWoL7BGQ5rcR6j4vcO+nszNE6U0qiEOGGYh/w+ScfNHw9houz9neJAKWGiYZLSgQL3qIcSJFbfuJrP/D+Ii0Sm90rbi0Rs0FKKhNBTG8M3iZOaqs2GVRFzfNWVcj6uDQfvjZFUXC+ik2n1u2EpIVbT1gm0pkxeSySPHgwN1ysDpJBM82/+K6K8T6Z4DZEziE1yAXh3CtOE22kBF5g7GXYIjEBq/UPajQXiTEkafvipUxe5hM35tWEn/7J2K+Z5ucs2A2C4lvGvQSdgLjRPcUByuEo5fYMQQwysLOr47+nFpl9xWhbsVM5cqUQCtkV8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kJfE6m4W/0SLXwZR2MR5z5lM6/d+UqH3EXiQBFvmYeZcVOL6RRXabI8JebDvjXK4Wwo+ZvQ7gAbXT9Ez6hu0MucCitC+My5l/U9PZ782spFn0fsmmszKfDgd/oac/wWY7czbXBoI08MkB4V6wbeiXAZSCvNHWg6OymS2orS9aXGUPH2ebJQ7fkrJsEGHcfWXnj050WeZVs4YZ7ycz3doFmz+mi7CITM8XmfmzyXj+jz+blmzzX/k4z+s+IMn4r5Q5oMfOzXI3CPRTvXw5uuT+pc9tZ+Qlbgc60V9G6hyf0mh6+3VfyPuCGSK0prarE2SsKwG4YHnknZIIKc8ewfCqLdhOGO2BepDhhWevWH3p453vAgyUNSSWbAAuzIgq6epEWm+VKqVmfP/Xq3RUbOnvdOFAI2mLZbigYcdKvNHBTORrk7bHiha8Xm+tLnYzBu3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 21:10:51.6817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 923543bf-f720-4361-afcb-08dec5a26bd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
> A region inherits its coherency from the chosen root decoder: HDM-DB
> if the root has CXL_DECODER_F_BI, otherwise HDM-H.
> 
> Surface the topology through read-only sysfs:
> 
>   - decoderX.Y/cap_bi (root): CFMWS BI restriction.
>   - decoderX.Y/bi (endpoint): '1' when configured for HDM-DB.
> 
> cxl_region_attach() rejects endpoints whose device or HDM cannot
> serve the region's type; target_type is inherited from cxlr->type
> in cxl_rr_assign_decoder().
> 
> The HDM Decoder Control BI bit is set at commit time only when the
> target_type is DEVMEM and the BI capability is advertised
> (cxlds->bi for endpoints, root F_BI for switches).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 +++++++--
>  drivers/cxl/acpi.c                      | 11 +++++-
>  drivers/cxl/core/hdm.c                  | 14 +++++++
>  drivers/cxl/core/port.c                 | 29 ++++++++++++--
>  drivers/cxl/core/region.c               | 51 +++++++++++++++++--------
>  drivers/cxl/cxl.h                       |  1 +
>  6 files changed, 100 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 16a9b3d2e2c0..f631a94f098d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -297,7 +297,7 @@ Description:
>  		Each entry in the list is a dport id.
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
> +What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3,bi}
>  Date:		June, 2021
>  KernelVersion:	v5.14
>  Contact:	linux-cxl@vger.kernel.org
> @@ -306,8 +306,9 @@ Description:
>  		represents a fixed memory window identified by platform
>  		firmware. A fixed window may only support a subset of memory
>  		types. The 'cap_*' attributes indicate whether persistent
> -		memory, volatile memory, accelerator memory, and / or expander
> -		memory may be mapped behind this decoder's memory window.
> +		memory, volatile memory, accelerator memory, expander memory,
> +		and / or back-invalidate (HDM-DB) memory may be mapped behind
> +		this decoder's memory window.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/target_type
> @@ -426,6 +427,17 @@ Description:
>  		current cached value.
>  
>  
> +What:		/sys/bus/cxl/devices/decoderX.Y/bi
> +Date:		June, 2026
> +KernelVersion:	v7.2
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Shows '1' if this endpoint decoder is currently configured
> +		for HDM-DB (device-managed coherency with back-invalidate).
> +		The HDM-DB state is inherited from the region the decoder is
> +		attached to, which is in turn set from the chosen root
> +		decoder's CFMWS BI restriction (see cap_bi).
> +
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>  Date:		May, 2022
>  KernelVersion:	v6.0
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..6a9ba82719e9 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  		flags |= CXL_DECODER_F_PMEM;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
>  		flags |= CXL_DECODER_F_LOCK;
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
> +		flags |= CXL_DECODER_F_BI;
>  
>  	return flags;
>  }
> @@ -198,6 +200,12 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>  			cfmws->header.length, expected_len);
>  
> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
> +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
> +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -437,7 +445,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  
>  	cxld = &cxlrd->cxlsd.cxld;
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +	cxld->target_type = (cxld->flags & CXL_DECODER_F_TYPE2) ?
> +		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
>  	cxld->hpa_range = (struct range) {
>  		.start = cfmws->base_hpa,
>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4a41cde9fdba..70c797c77b70 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -705,9 +705,23 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  
>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  {
> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM;
> +
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +		struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +
> +		bi = bi && cxlds->bi;
> +	} else if (cxld->region) {
> +		struct cxl_root_decoder *cxlrd = cxld->region->cxlrd;
> +
> +		bi = bi && (cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI);
> +	}
> +

Minor optimization, but you could wrap do the following instead of the above:

if (bi) {
	if (is_endpoint_decoder(&cxld->dev)) {
		...

		bi = cxlds->bi;
	} else if (cxld->region) {
		...
		
		bi = cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI;
	}
}
>  	u32p_replace_bits(ctrl,
>  			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
>  }
>  
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c5aacd7054f1..2b463a8b06a7 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -131,6 +131,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
>  CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
>  CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
> +CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
>  
>  static ssize_t target_type_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
> @@ -233,6 +234,18 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(mode);
>  
> +static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxled->cxld.region &&
> +			  cxled->cxld.target_type == CXL_DECODER_DEVMEM);
> +}
> +static DEVICE_ATTR_RO(bi);

Is there not a register bit that enables BI in the decoder? I think it would be
better to present the hardware value here.

Is it possible to have the decoder be configured for BI if there's no region? If so,
I'd remove the region check here.
> +
>  static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> @@ -329,6 +342,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_ram.attr,
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
> +	&dev_attr_cap_bi.attr,
>  	&dev_attr_target_list.attr,
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
> @@ -339,16 +353,22 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  
>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
> +	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
> +			       CXL_DECODER_F_PMEM;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>  {
> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
> +	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
> +			       CXL_DECODER_F_RAM;
>  
> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>  }
>  
>  static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
> @@ -402,6 +422,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>  static struct attribute *cxl_decoder_endpoint_attrs[] = {
>  	&dev_attr_target_type.attr,
>  	&dev_attr_mode.attr,
> +	&dev_attr_bi.attr,
>  	&dev_attr_dpa_size.attr,
>  	&dev_attr_dpa_resource.attr,
>  	SET_CXL_REGION_ATTR(region)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..3f9ddacfae4e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1129,17 +1129,6 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  		return -EBUSY;
>  	}
>  
> -	/*
> -	 * Endpoints should already match the region type, but backstop that
> -	 * assumption with an assertion. Switch-decoders change mapping-type
> -	 * based on what is mapped when they are assigned to a region.
> -	 */
> -	dev_WARN_ONCE(&cxlr->dev,
> -		      port == cxled_to_port(cxled) &&
> -			      cxld->target_type != cxlr->type,
> -		      "%s:%s mismatch decoder type %d -> %d\n",
> -		      dev_name(&cxled_to_memdev(cxled)->dev),
> -		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);

I'm not sure it's possible, but it would be good to leave this in and just
skip it if the decoder is configured for BI so that we don't silently allow
broken configurations.

>  	cxld->target_type = cxlr->type;
>  	cxl_rr->decoder = cxld;
>  	return 0;
> @@ -2034,6 +2023,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_port *ep_port, *root_port;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	int rc = -ENXIO;
>  
>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> @@ -2083,10 +2073,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> -	if (cxled->cxld.target_type != cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);
> +	/*
> +	 * Verify the device and HDM are capable of the region's flavor before
> +	 * proceeding. The endpoint decoder's target_type is then inherited
> +	 * from cxlr->type later in cxl_rr_assign_decoder().
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxlds->type == CXL_DEVTYPE_CLASSMEM && !cxlds->bi) {
> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
> +	if (!cxlhdm)
> +		return -ENXIO;
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
> +		dev_dbg(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
> +		return -ENXIO;
> +	}
> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
> +		dev_dbg(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));

I'd upgrade to a dev_warn() for both of these prints. A broken configuration
should be a warning IMO.

>  		return -ENXIO;
>  	}
>  
> @@ -2772,6 +2783,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  				   size_t len, enum cxl_partition_mode mode)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	enum cxl_decoder_type target_type;
>  	struct cxl_region *cxlr;
>  	int rc, id;
>  
> @@ -2779,7 +2791,14 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
> +	/*
> +	 * The CFMWS dictates endpoint coherency: a BI-restricted window
> +	 * produces an HDM-DB region; otherwise HDM-H.
> +	 */
> +	target_type = (cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI) ?
> +			CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
> +
> +	cxlr = __create_region(cxlrd, mode, id, target_type);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 917a6aee5936..73d4d2d4616d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -287,6 +287,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_BI    BIT(7)
>  #define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
>  enum cxl_decoder_type {

