Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4331DE4CA;
	Fri, 17 Jan 2025 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149519; cv=fail; b=egWtRanMqOuHGP8jlYKnGWxzXDeG7WYaRGLTrgbsoj2IfABXFo90KTO9jOVkby41PXrGg0+30m/dMm7FvnJiH/UTnS7l/winUozBFCuYYt+VgoWG/Ect07HAdLI31OJfdSQpKKnZtMnlAxtXfAfboHGUfh1HHJGvn+908+Kqf/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149519; c=relaxed/simple;
	bh=oaqB9//n92x88i1JB96mRl5EMiM8277gTYIHHz9aaWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=esxvxwdhm2yot6boXh8Dj5buLZtjw3apgieGJKVUaAQJ5KwB5huBLem6GLEO0p/RGOsvtlMOsm3cm2AMVHu1waSUHZojbGJ5LyuLQ13pQ9joojL+cPz0FI4xsg8NbKjNutXX2K7ooyXgRGqnruHrxqF/GeVmKchub/RvOzAe/GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MRbo7eGN; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MRbo7eGN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6tVunQOe/MMk5OnRMOqasbeLSnEsN1Z/ugfnnYW6fUi7lWjTEMwdDZC/yxdV/xG33LrygJQRU8U5i9gYDL7JysnOojdDfdWHxmJntghMGt+z4iLG9MzdqN3WNLRQ+BefXs8i5hWa/Zsb8U+XtFXeidFkFNcJGNjwMKQs/JkY5lICnvNIH2ZA+vfOwtuo5jurNptVmjMGj0gR8ua4cpRGhRqRsSeYcFm/d9n4sD/Y8/J485C66HBhh8yl2Q/JFnPSBix0G5Wh6020dU+rtpj02hv38kcNg2yVNn4wDeo4hmU//nFqLjbyK7CnljZ6W4PXpBVUNXJ6BD8LdkncpBGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiQ9YCu0E3e7+fCJyu71ha24/4iPdYrxFyR3re3HJn4=;
 b=IuJryEvHypWpvxSGAPIzQSYBvR4gsImMZbUaOmYPDNr43KiakCvgSWexDtg5OhH2sI5SJFEyilthfJpFCqYg6Lh/nkEX0gdZ7gdmGs24nvjtlhr4kgJ/GhFfOc3Iskd0pPm1yeZwoWtpzExovj088EMvnewEebdMMAxA0oFMo8b99ZthX0f3ko4EDZvP5/ZyOL2PsrdHEfhtxyzhgg759Wa7VREBAMTJgiXeN7kjvuV2AeTJPIsYiq5iaN/pPa2n3tt4CzY5mHADvfdGUrAWr/b/ja4U4RlxelAlMtFVISkXTT97bl+s7Ux0OFTwVWg7o+YNZ44u8juJ19WV/GBCIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiQ9YCu0E3e7+fCJyu71ha24/4iPdYrxFyR3re3HJn4=;
 b=MRbo7eGNqx11V5Uzd6zEiZcIGdh15kR5hJSET+6ipfC6oAGnKOD9C2lqlxrF808ObbaOCxWOgoBnEVBnFbGxh3QyAN9uQ2KhhPvGEW6MHAW1BBNdmT1AYYsq5x7n8oEmuXhIL6Xb+RyDp59q+/l40rT9uCnwMzvU+4j66lXKpRo=
Received: from BN8PR03CA0005.namprd03.prod.outlook.com (2603:10b6:408:94::18)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 21:31:51 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::56) by BN8PR03CA0005.outlook.office365.com
 (2603:10b6:408:94::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 21:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 17 Jan 2025 21:31:51 +0000
Received: from [10.236.177.252] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 15:31:49 -0600
Message-ID: <b8aee5a6-6209-4091-962a-dc27253e918a@amd.com>
Date: Fri, 17 Jan 2025 15:31:51 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 19/29] cxl/region: Use endpoint's HPA range to find the
 port's decoder
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-20-rrichter@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250107141015.3367194-20-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: bacbe453-5889-4683-ec7c-08dd373e5b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTBlOVZKVFlzU2Z0VFhTaHJ1VXNFN1Z1bkR4ZnNWV3BQVDNkUDFFS0JvL2pm?=
 =?utf-8?B?V2VGUFAvdmJ3Ky83dTRFejhTamdLMER5U25zSG55SjNybGFLK1hPNzhMNEwy?=
 =?utf-8?B?dGU4dDRXSEVTNnBVYUlBUkkzOW1SMEp0RThMQjY2V0ZqOFNETHlJZk1MbWt6?=
 =?utf-8?B?SzBnMlZqbVg3MitTMjRtYlNub3hOQklDbFhWTWlIMDZaYnoyTEtIc1hkU0N3?=
 =?utf-8?B?aHUza1NMM3NCM0FkWUFEakkvSUFtZTFJQm5yMmgrVFVmMlM1V1hubzVkb2dQ?=
 =?utf-8?B?Qm9qenJwM3liTVZWdVZhdXFLaUE1T04vYWE0bmRoL3NWWFFtOUxJR0tIdlNw?=
 =?utf-8?B?S3FKVkI4ODFUVExObjFPMzJnY01tKzhiVi8zSmhYRUkyNUtIcllIcVpQeDB1?=
 =?utf-8?B?NnZLOVhuWXBMTDBzNjlpWHVLbWZFbTFTSWkxeUR6azVyOWZtZDhZc0xRVEhK?=
 =?utf-8?B?VEtJRkdObmZtVk4vaHh5ekZnZjBZVDhWRkppKzAyMTMrT0tiS0s4UFRHSk1m?=
 =?utf-8?B?ckVJWmlxNXRXdlczQ3hxN1JqUXdQeXh4VnMrZWovSE9ZMU04bzByRE1ySVlC?=
 =?utf-8?B?VktoVU1Tbk1UcU12UnFhelFzQ2lFMkN3clZPODNSTGhLUElCMUx2aGd5aXF6?=
 =?utf-8?B?azcvSWk4K29pb1pUakxMdUhWKzBMZUIwWGE2Z0E5U3lzWmJ0VWw1WUpBK1hn?=
 =?utf-8?B?UUhIek1FSUxES0NGNnJhdEdyTmpJS0dBdjBrOC9WWkhhaFJMQWFTYndtd25S?=
 =?utf-8?B?emZlOW5aTE5qazZMeWp1b0V6SHFWMVRqTGV5cC9CK2RSN1dPTWxVUTZXY3ds?=
 =?utf-8?B?dWtlbWVBZ2gyMm93SUlac0psMTM5RzVmL0hIRzVlaVhpN2xBTElZS0tYUFZJ?=
 =?utf-8?B?TmtZSndRcENIeVdqQXp0dm5LZmVkUGtOajlvYk9qRzQ0dzdybUlYSHlxb2dq?=
 =?utf-8?B?L0JnS05laFF1MGxBUWpUR3lSdVZpc3pUY0xFT0kvZUJSQ2FXNGZ6ZStaN3da?=
 =?utf-8?B?c3diL1FyajNienRrZEE2VHRxcUJERlJGS1dYeUMwRXJORWxrSmp5QjByUzl3?=
 =?utf-8?B?aytuWWl4dENTbFI5cVJnR1BKL1kxTFhUMm9KWU1jZUtaVU83ZEkxQitYMUdW?=
 =?utf-8?B?eXAzcTJwYVc4QVRsTG0yamZZMVJOQi9nc3lKYmNudDdQYlZPczJiYXUrZzU3?=
 =?utf-8?B?dldMdm9nVmhsRlRuVmhHTGN2WVNYb2xJYlZXMEJZb2NCUkI4bHRzb0dzQlpa?=
 =?utf-8?B?OWZEY2srUWZEYkhmSFEvRnFPOWM4cGlRTDBhZ0lXMVZES0VacWI2aXhhaUsy?=
 =?utf-8?B?alRlRkU0Qzhtb2VQZ0xkaWlYdDBmMFIyQzdRZzVQcTVnSDd0TXhkTkE1ZGt5?=
 =?utf-8?B?RUJHSjRoZ3VDM3NkczU0MXdVaE1NRjJDaTZaUU5leFVvRFBONFo1enJLbGpm?=
 =?utf-8?B?VmMvbzJXcnJET2xPTmR0RGNlN2p0K0tQQ091dkpRWDVDZ1V3b0FaWmxGK1Iw?=
 =?utf-8?B?bmNwT2NFR1lvS3BnRmk0Ym1JcmVvYUhCdU9xQ243ZnNoZkxma3NwczM1ckhj?=
 =?utf-8?B?cGhSbzZ0NXdqRGpQNzVXSEhpOHFpRDBudmVHMU5aeUtGNWc4bDdqWjdPWFpn?=
 =?utf-8?B?K056M3RQakNiM3FGMjYxVnpLcWpXYlBnOGg4L3dNTGdXSjMxQXdETGZtb2Jq?=
 =?utf-8?B?K2YrMTdWNENEdDNyUUlWSnNGaFRBK0V0aXZjRnlYaEdhV3JvYmVzUVVxbDhH?=
 =?utf-8?B?anVmQlpWTTlGSjhiUWw2SEF2R05rMDUza3FRYUl0US9IbFNSVGRoM25GTEFZ?=
 =?utf-8?B?dGtwNFBidUp5bmFmZUl0VldKanhpYm1LT1N2QXdnSUIzZnUwV0o4b1o3eXJU?=
 =?utf-8?B?T0VaOE1PRW5XdlhNVHVvV25rQU56cnlHbkM4ZE90UUJIZGhhSVNLL1duVGp3?=
 =?utf-8?B?ZFFldU81MGtZUjhHQ2JVT016bGZPaEFlb3FGKzJqM3ZhcEVsNjZqUG0yWVRR?=
 =?utf-8?Q?N3xv9n0uj9aZ3xNZluFxPHIO4Hfa4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:31:51.5423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bacbe453-5889-4683-ec7c-08dd373e5b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

On 1/7/25 8:10 AM, Robert Richter wrote:
> For the implementation of address translation it might not be possible
> to determine the root decoder in the early enumeration state since the
> SPA range is still unknown. Instead, the endpoint's HPA range is known
> and from there the topology can be traversed up to the root port while
> the memory range is adjusted from one memory domain to the next up to
> the root port.
> 
> In a first step, use endpoint's HPA range to find the port's decoder.
> Without address translation there is HPA == SPA. Then, the HPA range
> of the endpoint can be used instead of the root decoder's range as
> both are the same.

I think this can be clearer. Something like:

"In a first step, use endpoint's HPA range to find the port's decoder.
Without address translation HPA == SPA, so the endpoint's HPA range can
be used since it is the same as the root decoder's.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b7f6d8a83e4e..23b86de3d4e7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -861,9 +861,8 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
> -	struct cxl_region_params *p = data;
> +	struct range *r, *hpa = data;
>  	struct cxl_decoder *cxld;
> -	struct range *r;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
> @@ -871,7 +870,7 @@ static int match_auto_decoder(struct device *dev, void *data)
>  	cxld = to_cxl_decoder(dev);
>  	r = &cxld->hpa_range;
>  
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> +	if (hpa && hpa->start == r->start && hpa->end == r->end)
>  		return 1;
>  
>  	return 0;
> @@ -888,7 +887,7 @@ cxl_find_decoder_early(struct cxl_port *port,
>  		return &cxled->cxld;
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
> -		dev = device_find_child(&port->dev, &cxlr->params,
> +		dev = device_find_child(&port->dev, &cxled->cxld.hpa_range,
>  					match_auto_decoder);
>  	else
>  		dev = device_find_child(&port->dev, NULL, match_free_decoder);

