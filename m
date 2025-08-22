Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65582F4A1F
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859058; cv=fail; b=olQUNgCeQDHzhqkCjdjKc8vqn5fd35l3yewPxXYci2gvazb30r4vqBbXZAj0Gs40PXqTgFrn6l+mbjTI3+/gwsWUAIAWGScNuPDrepSm4kC4SwG6W5NpcwvIbTsdSBDua3RyFkRXnCrrSI5MauV32kLBoYESEgzWssIly658tuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859058; c=relaxed/simple;
	bh=u8aqnlFM0F0dIM4iJP/eBjpvX1DY1ABLLtuqEIfVzEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rxph4mPxbz625JUB6VJkrY7E/RFtchi62JZoGgtksnlENGoSRrI61rPklRX3c14pc+15ytdSDqdTidp64Le4I4gFC/k2S2znh7Lfgcrbv72enwrYua2KEMb4s2MmGb6UarxdbhL0OAnRP587HmOtpwmxt36HQTNBGw2VF2/CQW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1p4TT0p8; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1p4TT0p8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jac5zD7lo5DK3EI9fQ3anTtYGBIOgJRa7AKQ/zpJu219Sz58hNlkYvmZ69ZhbDhxWsYMvBirc4/Aoy7HyTDhp9uZc8E3q7sFlYKKDPUOiPUOhAi3iIFSCk72Bixt1j1WXukF2iw7JsagMx7HylNhA41j5A4aY0f5jar6oW/0ma5zx7DRTVymlGpPDcDzYnq/vyY45T/R/3SJWuGXnQvXo/RulrlE/1352+7mEMSPZ+wF4PR87oZAkXDhCTF3nCFk544PiR4sXEjl86hxom8K67dSr5B6h6WV0H5UlDB1yWnkLsC8y7QnxOZjp9yNCjr34Q0Rro1G/tOG73iYkiYNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu523SDlagk+BvYd38ta11Sn2Kp8j+sQi5bUpQTVrXI=;
 b=PZACnssT0WmxMkm+73ysZ9Cx1ofzWUTQGR2sHn/NJCSkMh/wGxD1NMJHC7n+kp/ymYTc8YYZLHQcw7szR2Et/TF7gLYtZv1kAt1e4LH1ZpTcPvqCBzpGHxQlwd2y5LKzcslP6UZfFoYSGlVDA2oOsIvdkaCSybOv4Hu19muhBqh90MmvIFX/GRC9M5DSQClHJaZ98kbCoXT7+qnnNJPUVStAuSfs7HONoTKajnqQWWXqbJ9Sf0TWJgg1Omfk3hAHb4Kui6quHxjB6sfd2V+hfx43lQUCir3dX/SaPBV4IZ+xTJCRVuhAZz09xWkOyjFDUikXf6CA3RuymIa+NFjlWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu523SDlagk+BvYd38ta11Sn2Kp8j+sQi5bUpQTVrXI=;
 b=1p4TT0p8kkD0r9juMmV2hFJAHCSbALrczSh3KS0dkd7b1faxm7ikfloNeceluAg5DFAPFmqAkdnVnscvoRouI2axK5IKk1Hw7qMPAeSdwPuDiHFilQh6G+F81UJvMVTafTgw0TAPMdTsVvo7fXGtTHpmc+22lvv0DQ9k6hqdrcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.13; Fri, 22 Aug 2025 10:37:34 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Fri, 22 Aug 2025
 10:37:34 +0000
Date: Fri, 22 Aug 2025 12:37:28 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 04/11] cxl: Move port register setup to first dport
 appear
Message-ID: <aKhIaEJULPR_NgOG@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814222151.3520500-5-dave.jiang@intel.com>
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fe1345-7b64-467e-8d1e-08dde167e779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0FuE0+OE2qjzjLK86jBmMQX41Wwv/T50YMUT8ikK3LlTCDdVcES7jVp+b0JF?=
 =?us-ascii?Q?4YzhFX1c8O2ozY+Rs8mafRlZP3n845QesfbG8x6MdYaaCyKtc2QO81s8NZAS?=
 =?us-ascii?Q?d56po0c99htMN+7w1WW0RiW6RxeyV0QOfaprQCL5Qzv3VuYoVwJb1aQ90GOy?=
 =?us-ascii?Q?kmkz1eRdBN9LjH9CUGeyg3bbmE2XGjNFnStrPE5PXvmwxVL85+FamyT2ZPel?=
 =?us-ascii?Q?sBnmLSnXrV3RpBFtuCY1li8PAXPZ/uu8M3/OMb+xsHp4Awl22UlCwWIgTaXN?=
 =?us-ascii?Q?yUrZLUC7A8JO+4yBkp/Uts9cdK2qrSJaGvAsQ/XVQMSivdR4IflNM8CC83s/?=
 =?us-ascii?Q?UOKSUvyH0v1AouimEByQDu6GJ64rl+dYpLznSLkkggiwWKd6aWPaiYFkYqLH?=
 =?us-ascii?Q?7aWtmfkIT9FteZn/E8S+QZd/HCEJ7zkhmA+AOm9c+aZrgPb9hmmsy7AX3KB3?=
 =?us-ascii?Q?e8Onahb3i9XOjFT2n7qV10XTZarmXSkkWh1lY3Tfoj7swQfnEuOXzEaXqPu5?=
 =?us-ascii?Q?ogtal3SwGAhqdeYpU/VDgLG5CG9F1+b3d4Jcp0DqLvzgECA3bdmqt5iVRs6v?=
 =?us-ascii?Q?ESo86q6oBCHm+i/HXH1XH4TqrMmDSB7QynDgO5dZlFmRgbFJj1jdgfeCsphB?=
 =?us-ascii?Q?qoIwCjGIDFvqcNc77jkdqLKINkIPd0RIE38O+HsQJSAsYLVXW9D7n/GEWL+W?=
 =?us-ascii?Q?EaBOi1OhZp4vS9NTtxEGDGAxgeNQGWSSAzFXgYtbfBdHr8Hlc7ePMGHXcEP2?=
 =?us-ascii?Q?/dIVzN9wdIFvIJePohmzSQk+kGqd1vhynzgLEEy/8TEocP5pnbWR1kIRe3b+?=
 =?us-ascii?Q?RM8snH82EHstpbkzfyaYUOiNQF/QXjq8bhDoeDRCxMSeY/KMpMtU6WW2HgD8?=
 =?us-ascii?Q?2xqzUMRWqIQUEkqAProcelbjTJLTx9+AUCz32b9vEg55xvscm+TfJfbjTrVK?=
 =?us-ascii?Q?SMsQBJv7sImf0uKGvlH9HJN3qNSt26ZXeOuyfPG976PWCuTKYzl3QRW7A51C?=
 =?us-ascii?Q?Pxtz8CMW4swSs3ESGSPOieoj3MCuscDuT5zltwzBduwDwBhgvkduoQyse33V?=
 =?us-ascii?Q?cA43oATzBVwd+YSCbkA0tnBmB94iibnzPvxLANQIzDc5XKdE6aqQzgrqsf9C?=
 =?us-ascii?Q?S2gCwdszhxmvabhu2YXEx0xvI0V+XWR/LuYIh3QwgHMWMlwuYIvrEw6duMKi?=
 =?us-ascii?Q?bSeXGIqNFKt2jIJEiXviBeE1pKJkJ6xce9T5D36aEwwR3jwN3/GJadZ8x4Bw?=
 =?us-ascii?Q?jTVQ1ita0NOnfuclnfrblXgCVLoxwLurO5bDos0HGYmWJBak6HOcZLSpffbZ?=
 =?us-ascii?Q?eIwc5MKS2YbD5gZMn66QXVhG5UqWWGYQBIttBp2Q31kWOr6dlCVA7OEl8OeQ?=
 =?us-ascii?Q?W2qjfw0FLy9Drhb+3uVXY47RXlpoT+I3PmPaViJ0c/kuexTO1AZRbjm7m4yq?=
 =?us-ascii?Q?JnnH4YGXLz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2nZekxedlYaOJkbu7oqvSnkedrlJWGzON5rSCVS+QnKoXXpoSoWzSTIORKj?=
 =?us-ascii?Q?hjSIoGaQ7NT3jrkFkLCXfYaOy2UNeeYKCul41kCvn6OvHBZuuTG7cDYdsUMk?=
 =?us-ascii?Q?1h5YYSCME5bZR4k6bLsdUGaGfssZA1Q/xUBN/uko6270MokbtrBDoOM2ackq?=
 =?us-ascii?Q?lVTEE2lKnWZTmVYjbqfAEDOdiKmd7cmjAJpxCEgZy5d6wvfCBv92J+nqmft9?=
 =?us-ascii?Q?yNYq6XYysFPq//SnTd+jQFLmV7aFeqpftN7SE2OXPXXKjYbb6uz/6gmyjIDa?=
 =?us-ascii?Q?mFAnEPL6tkwHqd6PM3pBsGcLfeOXCiai5KdgOJh8DmnkGocPOGTNoz9CQ51F?=
 =?us-ascii?Q?RMzcnuCPKB/ol1m6oDclG/dJJpdEP5ArYHYWyWcwRxtCUoVKbhSSd/JZ2YRT?=
 =?us-ascii?Q?ejfhdMqxrS0LNo5yMqKGYYwqkJp/HZg0udjxxu4iAj85/OGlbEdPB6uYoCbe?=
 =?us-ascii?Q?zLhuhCF+GIaKwx5LFihGh+MiO2/mS26flvvClpfSHxHf3JLIMo52gYnvrzKI?=
 =?us-ascii?Q?FWymiX3ctLJSRWXBiiL7YJAOa5BmgB8SyYRrYKzyU1FhXW11XG/637NaAr2N?=
 =?us-ascii?Q?AbqsS26AvPaMfII1q9Mp6bWp3VzHimH64utk2QXiWFfaFOdFYhZnQuauENJ1?=
 =?us-ascii?Q?o9JnVxaYekmXjmSqPKlj6FrQA/qFrBBvM8d4X4V7dedzV54ya4vAF7E/8fdu?=
 =?us-ascii?Q?+QjhfyyjYagvpmIvkowY5+LRXw0OzpdJhCKcwLxEKbUVW6te04scTzP8Qpkq?=
 =?us-ascii?Q?ehDalrHjsuX6VHJE2x4UDm9jDouXNqmrW5g42aiOD33qVPHB2tHGcGpFmJ1P?=
 =?us-ascii?Q?vxx+u6y9pMXS2rFEylDai60V0Zca91BofRfoJiys+ZVv6yHOy2+GeazrkfC+?=
 =?us-ascii?Q?jG+ej152HZdh+WPczS5U4KM+7HdUu5eOLvG1LcsoGhA40dVbUz4Wxi3Ou11+?=
 =?us-ascii?Q?WQa+g/gekvr1YS+wSuFnZYLIhoJswpzxSynd7x7vPRRK5yugj1DAGp8xEVyQ?=
 =?us-ascii?Q?GYSsi9IcGW8/uFGI7TGFaGNVJt7T9b475radOMu1bUYNhcB/LM6ej5lj2Rh7?=
 =?us-ascii?Q?dpwDq496HA3GH/noOJeX0/yBTdcAGwKldzqANpiZX1D0xDKJWZm9HFlwmuXH?=
 =?us-ascii?Q?HJaOK3cQndqB5Tm/FozkTTd4OTLKHfqn95yxxrzdlUONGcPaIXzydUBYkIk/?=
 =?us-ascii?Q?r15+EUfADyTrIZitTEeE8zn+kDaHQIPDRLV3SEUrR5YGJSOP3RI+XOmUCcra?=
 =?us-ascii?Q?1ruGYzaXO8SHsOVBio9LYnQUwC3iKyDcDPBJ7BCFUbyWhlN7H2XY1w5VJOAm?=
 =?us-ascii?Q?l6ERLxklubIeU47dbgDc6EZ69DKkwvlK+mCr4irsDOWylwyWZITvkosaYTH6?=
 =?us-ascii?Q?0q9s34tkix4b2PyG1rxhxWSTQqfQqJjOhSWZjg3O8g1BywvtZtXLTTnn8ooc?=
 =?us-ascii?Q?qA4/nFCOlRyik5YCWlcVv6Bmww3zs0vFX3ABAIqRDl0psF86udJyfOLF24Ye?=
 =?us-ascii?Q?Alm/3/PW7/D3QwKe0nCCGweCTot3Cq/0jpk6QQQR8APQmWJ+WRbAlGbm3is7?=
 =?us-ascii?Q?lNt88gTpInWMZ3fjkTo8lYou5IRVboYgIMK/m8Ix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fe1345-7b64-467e-8d1e-08dde167e779
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:37:33.9659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2li81eC/xiyf8TVPOyDcKvAuxyNyE9clY0kwQTliw97zMv/Uj5SqCPvIhrj8nd2WsXSRSj+tp7hsMM+Im65yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887

On 14.08.25 15:21:44, Dave Jiang wrote:
> This patch moves the port register setup to when the first dport appears
> via the memdev probe path. At this point, the CXL link should be
> established and the register access is expected to succeed. This change
> addresses an error message observed when PCIe hotplug is enabled on
> an Intel platform. The error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed for the
> hostbridge during cxl_acpi driver probe. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3
> and/or DVSEC ID 7 blocks which will trigger the error message. This
> behavior is defined by the spec and not a hardware quirk.
> 
> This change also needs the dport enumeration to be moved to the memdev
> probe path in order to address the issue. This change is just part of
> the code refactoring and is not a wholly contained fix itself.
> 
> Suggested-by: Dan Williamsn <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 16 +++++++++++++---
>  drivers/cxl/cxl.h       |  2 ++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 48e76673aaf3..25209952f469 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -867,9 +867,7 @@ static int cxl_port_add(struct cxl_port *port,
>  		if (rc)
>  			return rc;
>  
> -		rc = cxl_port_setup_regs(port, component_reg_phys);
> -		if (rc)
> -			return rc;
> +		port->component_reg_phys = component_reg_phys;
>  	} else {
>  		rc = dev_set_name(dev, "root%d", port->id);
>  		if (rc)
> @@ -1200,6 +1198,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_debugfs_create_dport_dir(dport);
>  
> +	/*
> +	 * Setup port register if this is the first dport showed up. Having
> +	 * a dport also means that there is at least 1 active link.
> +	 */
> +	if (port->nr_dports == 1 &&
> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);

All that delays decoder enablement and visibility in sysfs. I think we
need a different approach to handle late CHBRC availablity. Let's see
your response to my other mail.

-Robert

> +		if (rc)
> +			return ERR_PTR(rc);
> +		port->component_reg_phys = CXL_RESOURCE_NONE;
> +	}
> +
>  	return dport;
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4b858f3d44c6..87a905db5ffb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @component_reg_phys: Physical address of component register
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -622,6 +623,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	resource_size_t component_reg_phys;
>  };
>  
>  /**
> -- 
> 2.50.1
> 
