Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C89DF71;
	Fri,  1 Aug 2025 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078660; cv=fail; b=pmM6a8cFVat2Dv9joraKf9Pi7n8J3nc8nSiWRVhCA7K1bsltRi5tnGo4iGeWSOQGRUVkRTmd5Ls3sjxrPP3oc8Q4Pr0QhNeQzyT+NnisknIclFhB1FIzM4GuRdwCJMswgFV/zZRqSNXUWCvYN6KX1oAiK3UKEGs4ta/9LW6ssWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078660; c=relaxed/simple;
	bh=Rdxew2q670zSBRZoGd9r7vm/Ew1T8N7W4JlIIsZfz1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rIltyt/7gJ6bwum6o7kAB2B7HqKnUapNDJ5dAIM/RMPpVnJjpqVx8O15fO1MhITKeR8gFVTecCksbtoXDN9EZqxoGfGb8rJ9krVNZ7AOw7I1QvYbLlxxehJ9dBE83j78dvHDRlY389DZYynQHxYhlLGctqXapzDtHuiA6hC/WYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tiWG6aPP; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tiWG6aPP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvapoNZpLetWE/C/oDh2dgbPOWSUdsOftBoFqX3LcLqcrVwQPNx+Z0rbENBrZniFPDLmHRcPA8stlBzCMcrC0YTvXQDT9Y9gx8ilU5jHGtdvEnIkq4+EJLEv4vUDkAJPq0q8PA8vUsUMpZVq/7MzBnI29DWUsYubphqbV5QLgBOfBsRuYQaPVy+Az3cRjSxCrZ3uFHkzz1pY+FNqrSjT4vhSsxLuFAprhqY5xMJrRx1j62zFl/A741vgKGNd9zw5mgUI8xGmo0xAR9LXTlRf6lA8mS394+gaR/DopD9ytfoYacDrQcE2fwH7IGPcw/POD4WqxXdWlgNtlfTgrh9VuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nYsygfx1XaSFlqLj40t2fZ8a8vqmO7BRo+LFxLC9iw=;
 b=m3wkPCPlTlJ3B7dbZe2SlqsuWkBxRw5DCz79ZCPXcqN0XGphzuN5cX94cPmE18o32nL57DCpsYhEo1iBL6gX6SOA+UQFG2EfL7MCjruPQfm0DLzaRfwB1pxke5vUrgXo7ylTEVo3VODxQt4dZYqrIWi1YeX+efJw35MrLe1A7UgL4JRSknbj/aUle2ShBjcHV+JQ3zGskp9JCk4AzJA+uvFxkCf9iyKd5nS9X5thd6gCDAy1a/WZ7Cns7icdHUbl0hzMzJtsOTbdRYe0h0kIJllbTsQzCKii93IZcM+GPxnQh6/f+ATr0ZFpXPU0HTbG/kGbNgG0PUP4i6YP7nFLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nYsygfx1XaSFlqLj40t2fZ8a8vqmO7BRo+LFxLC9iw=;
 b=tiWG6aPP41BZ0tHnY8FwMS9WdkWl8XVvD8g5sim3TD6l6nN24A2eI8TyvdL27y7ytZR0eXrqvdzXvjxJ8j0baSJxOzvCEe75141nvfmr6B4SkYLJKvopPrEi1VjrGDhjRqM7qg2eho7K+5jF2kkA3Z5uA+ddJa/oyRqvve7aKgc=
Received: from PH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:5::20)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 20:04:16 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::aa) by PH0PR07CA0015.outlook.office365.com
 (2603:10b6:510:5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.17 via Frontend Transport; Fri,
 1 Aug 2025 20:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 20:04:15 +0000
Received: from [10.236.183.121] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 15:04:13 -0500
Message-ID: <ef74ab77-abf8-4b64-bb3f-9755e9062bee@amd.com>
Date: Fri, 1 Aug 2025 15:04:13 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v4] cxl/core: Change match_*_by_range() signatures
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-2-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250724142144.776992-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ced0d0e-aa7e-4fba-331d-08ddd1369739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW1TUHE0Ymd4alRuWWVGcEp2VlAyVkN3QmpRbkxPVVc4VVVBNWRteEozRm9M?=
 =?utf-8?B?VXBGNWhrMTcxeC8yNXBGSURBcGJhUlZiMjBPWlBTRzdpV3dZUm1vT1NBVzN1?=
 =?utf-8?B?c0phTkNoOFplck41M2RMeWpaOXpycW9XeDl5cnFSNjk1OWwveE1kUXVvWGpH?=
 =?utf-8?B?eG02b1A4ZDBRSHgzVHM1MGp3RXlqV1ZFcmVsWFIrQ2VaSWRWbHlLbHoxMVZM?=
 =?utf-8?B?UGNhS2FtQTI3NjFHWmF2S05abnNSd2hBT2l1QUs0dmFvcVZBdkIyKzJ3aWs0?=
 =?utf-8?B?dFcvblBzUm10b3NYMVB2eG5pRTF4eG1OcWNLZ1NMRjhCTVIyREVLanY4TEtq?=
 =?utf-8?B?dGRKMDVtUnJPUDZmcVh1OUVBcGtVM3JMZ2Q1cVZUQkFyQzVnQUNLdDdzdkVX?=
 =?utf-8?B?aVJDV2NDZ0hpRVVzbjRiSEdhSzlyVE5MVzZncVp0bHk3WVFvUDdQWkZ2ZTgw?=
 =?utf-8?B?Q2ZLR0pRRzhzT29sQWZKN1B2bEFscUtWZjVFekt5QXpuNnBPb0MwM1hyeDJa?=
 =?utf-8?B?VTBPRVQ5bFdLd1ZTNkU3VDdmTlhKYy9kWEtad1crdmhOQnNEUkFsbWZkUEpo?=
 =?utf-8?B?dTJOYmd4MzM1NSthakVYdE0rNkIrWlc3NUF6YVh5STgvVnFaODlmM3BZcUh2?=
 =?utf-8?B?QTV2N3FQSHVJWGF3M3NydHJzaUtTbXh2Sk5qWERWZWFRcXQ5TXBXQ2lzWXFt?=
 =?utf-8?B?dkpIa0dOOHFlUmhxNlNnb1FGWmU2TGFETnBhM3kyaTgrZ01wUWxwc2RyOERN?=
 =?utf-8?B?anVnclRTT2tpOTM5bGt4b1lHWGdMWE83OTJwVy9kYzZTaEljeGpjKzBGbUw2?=
 =?utf-8?B?NGhXMis0anNNMVRLU0FwMVVjUThzMWZaSjZ3N2FndVQ2SUFNaGdQWTV6RUNl?=
 =?utf-8?B?U25ld3YvclRUcEVrNGIyRjZzQWUvTkRpeEhHNHFjQzQ4NnVvek1yYjBYTlVw?=
 =?utf-8?B?R2Ivako5S2dnKzFkanpjUXo2ZE1XbElvREpKbHpNUGNTL3F0Rk9RTjh4OTl3?=
 =?utf-8?B?cmFMaHBFWitvSlYrMzI1cDMxQXZDZjlkdW9TRGZ6NWEyYXp2RFIxRFhOT2VK?=
 =?utf-8?B?TnVkdURaNzVOdjZ3VEJVVUJjZWtUbEpvTy84MDdTcXBXbDd5emJkaHR1ZTBO?=
 =?utf-8?B?WlpoU1QrZFpOYjlOMkZyVWJXMDQyUU1ETnlySXBjOGFHdVk1T3AwRFZWeTQ3?=
 =?utf-8?B?NVoyUUgvTkZuRHdpUlRGbmxXYXBXekdtc3g2UERtaGxCNFFLeWo3c21OTWp6?=
 =?utf-8?B?eWd5MVQ0WVc5RGgyY3NzY0wvZWFxNlV4Z3hSRjM4bldoV2xjWUFscWt3ckdW?=
 =?utf-8?B?THk5YTVya3hxbjA0UlZCbTFIYVhPRTBIelR0VWRQMVNUTEtRSU9wNng2OFZO?=
 =?utf-8?B?bmRyUUVCL0tpY1o5QVNtZWM2a0tWbVlFZVFuOENsN3lXQ0hpbEsxTTVId002?=
 =?utf-8?B?UDBrbytCaUhkLzdld0Nzd0RhQndUVGVzb25rcVRGdUZvR0NoYUdXYlV3RVRt?=
 =?utf-8?B?YjRsT0Q3ZFJ4MGViSFlTamJzWURnSHpnbXk2aUR1czVkcnpsTjJoOCt1dDhF?=
 =?utf-8?B?dm1La1I1alpub0N0dXdQNVBSY2ppUFhiSUIzUUNpQWZpM0FtTUNGWlM3TW5Q?=
 =?utf-8?B?NFBkeE85Q0dRdmQzS1AwNFl1OXB0TXFuWEJpV3VIYlRHekpPU2VBT0N1aGhx?=
 =?utf-8?B?UHk5djdjSWphSWJ1SzZvUU5PY3lFRURCS0ZMS3NhL2pjR0d4SFJFUTJsbm1x?=
 =?utf-8?B?N01lUjlGaXFRcnVTQnltQkU0NXdzQVFzMzBtYzE5cGF2Mml3UGxsNHdzTVM0?=
 =?utf-8?B?dTJ2eElwRUFienYrdzVydCtnNnVKSWwxd1dMS2QvdURnQnpiMHJOZWI1djNK?=
 =?utf-8?B?S2NOb2FLbmM3WnRpNm4vdWNvZklHVEVPUzAyanFZam93RTRlREpRM2tuaTFo?=
 =?utf-8?B?bVRkSjFNdGtrYU1aQkQ4Zk5aN0QzMDhuTXMrdEtJaW1XeTNFVElJZ1RQNHZr?=
 =?utf-8?B?Q3gxeEd5RDVnaGNIM0VscmpzQjQvY0hSc2NocEFUaUJVQ05IQ25FSmtqN1o1?=
 =?utf-8?Q?ACr7nW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 20:04:15.1428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ced0d0e-aa7e-4fba-331d-08ddd1369739
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

On 7/24/2025 9:20 AM, Fabio M. De Francesco wrote:
> Replace struct range parameter with struct cxl_endpoint_decoder of
> which range is a member in the match_*_by_range() functions and rename
> them according to their semantics.
> 
> This is in preparation for expanding these helpers to perform arch
> specific Root Decoders and Region matchings with
> cxl_endpoint_decoder(s).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 60 +++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..f607e7f97184 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1759,27 +1759,29 @@ static int cmp_interleave_pos(const void *a, const void *b)
>  	return cxled_a->pos - cxled_b->pos;
>  }
>  
> -static int match_switch_decoder_by_range(struct device *dev,
> -					 const void *data)
> +static int match_switch_and_ep_decoders(struct device *dev, const void *data)
>  {
> +	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> -	const struct range *r1, *r2 = data;
> -
> +	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxlsd = to_cxl_switch_decoder(dev);
>  	r1 = &cxlsd->cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
>  
>  	if (is_root_decoder(dev))
>  		return range_contains(r1, r2);
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +static int find_pos_and_ways(struct cxl_port *port,
> +			     struct cxl_endpoint_decoder *cxled, int *pos,
> +			     int *ways)
>  {
> +	struct range *range = &cxled->cxld.hpa_range;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
>  	struct device *dev;
> @@ -1789,8 +1791,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	if (!parent)
>  		return rc;
>  
> -	dev = device_find_child(&parent->dev, range,
> -				match_switch_decoder_by_range);
> +	dev = device_find_child(&parent->dev, cxled,
> +				match_switch_and_ep_decoders);
>  	if (!dev) {
>  		dev_err(port->uport_dev,
>  			"failed to find decoder mapping %#llx-%#llx\n",
> @@ -1876,7 +1878,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> +		rc = find_pos_and_ways(iter, cxled, &parent_pos, &parent_ways);
>  		if (rc)
>  			return rc;
>  
> @@ -3215,24 +3217,28 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_decoder_by_range(struct device *dev, const void *data)
> +static int match_root_and_ep_decoders(struct device *dev, const void *data)
>  {
> -	const struct range *r1, *r2 = data;
> -	struct cxl_decoder *cxld;
> +	const struct cxl_endpoint_decoder *cxled = data;
> +	const struct range *r1, *r2;
> +	struct cxl_root_decoder *cxlrd;

Nit: cxlrd should be above the r1, r2 declaration (reverse christmas tree).

>  
> -	if (!is_switch_decoder(dev))
> +	if (!is_root_decoder(dev))
>  		return 0;
>  
> -	cxld = to_cxl_decoder(dev);
> -	r1 = &cxld->hpa_range;
> +	cxlrd = to_cxl_root_decoder(dev);
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +
>  	return range_contains(r1, r2);
>  }

You could reuse the code from match_switch_and_ep_decoders() here by doing:

static int match_root_and_ep_decoders(struct device *dev, const void *data)
{
	if (!is_root_decoder(dev))
		return 0;
	return match_switch_and_ep_decoders(dev, data);
}

