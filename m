Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC971D932F;
	Fri, 17 Jan 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149515; cv=fail; b=FamzEmtrd1eZqR1NgWnKAByDT41PSN5YIIgQkNPPkm29uAW6L9oGYrZG9f/WXAYqYXGzF/SqJ1DmkuuFVSoP0RrxyBQwHpjeTA8l4ihF6J1mBERIFLr2MHPaz7p43bdSjxT7yq/h/OyzXv13y3+9FFE6LBBcNZc/DU3z69PfbTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149515; c=relaxed/simple;
	bh=bzIJf/oieDqzNopPzxQ63JBI3vXKf9pXP/WHuPHPwjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DyAVdzPyWzuCBPia1cY3o6QSJZ/eIhQd2Mx6KX2bRgTAZnCma4v9lbbnjQAqd9odXBbaSxW8FMxHr91zQrFX1JEa6ieWNNS7wzWn/WlT6ajGxUjmnSaSo3W9IqfR1rsj78QTT3ZnesTt3jBQqnVp9NW6bwPb5Lv7ayelkr/gpE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0pectoQI; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0pectoQI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIIpRuXAIkoqpoVcCUIWsw4jVpquFDc7X4XoGO5G52I+msrdvMVNR3xDHG+o7ReAIvY3MHnla2yJruuFn9F41Tlx15YhPQdpaQsUwiXQ5au0Aw9BsJ4/JaczDU1+y+izf0Zz7Ou3KIMldGwtx+KCCyD+hq2oLpu5kL+XLXxW6iYzDlDYNUiF3dLVLwjpid+TpmCKmv/Vntftwih5ZDQVRChHfns/ND9JFUTu+Orv3hcrSyzk0qta1K+dLgvxBa2wZTdyVukY4aCvU5U4NUPm0cmvYUl52pBMIJDeXHQwBrkoZgwGANEdC7TbM8Vha3G55jiuo6w0Ln0NBDk/Onqr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IwehwtiL+EbJfSmo7Yw1Yb7wFt5r+a7+gZ+vkH2CAA=;
 b=gTyk3OnlJlKuUuXDB69eh4BVKyWlnqdOZpicuestEVfcmHsFEYlaTQegNn7Gk0MW/C0aD8w1NlnYLZsbNUqv3lhKaO1C4jpYHbId2O0NAfVUWQMaIE0Koof68E+kXM8Nk7M/mABzyXTruSyIuy8rg5edzgQyr07IIPd4wu06lzpLGa74bSvmgF8MFbPLY0gIPWCudLe12Wu/DE3FvH3CxmmoFkEfkZ+jAtjun7u/YmkQeVX03RDIX79Od6XpxmrGY8m1u52RJOrHxy/jG2i3SzwKv2x0W9KT3rSIHEGbiz287XmHD70YFJ1yRKIP4xUH1B6xqXn65v5WHqDIa8TP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IwehwtiL+EbJfSmo7Yw1Yb7wFt5r+a7+gZ+vkH2CAA=;
 b=0pectoQIsnAfu207DMsmb12yrP/3n/IsU1IBsR6JzyNyy0Jn7CGO1e7FH+I+xm0U6Cn+yylBY4qMuUgYJ+Gv2fe22NUXGTrGunDhqYNzMCgcTdjzLQgbnZLlm4AkyuHK37QIo64Yg5wcVwpm30H6yQLVBabmAoX8EgqyYxPL18I=
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 21:31:49 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::f3) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 21:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 17 Jan 2025 21:31:48 +0000
Received: from [10.236.177.252] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 15:31:46 -0600
Message-ID: <27808223-4424-45ed-ba63-cc2b5f80a983@amd.com>
Date: Fri, 17 Jan 2025 15:31:48 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/29] cxl/region: Use translated HPA ranges to
 calculate the endpoint position
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-17-rrichter@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250107141015.3367194-17-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe0dd12-0a93-4bb6-d555-08dd373e59b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXhCZUl4TGJzR1pESmFlOHBlYTdwc0lNNjNXZXlha2tlbHNmblFEbW42STJD?=
 =?utf-8?B?Sk01S2w0NkpkY0FLUCtNUnA2b1hqaUNpYlhPNGRFdWZYYzMyMEEzREpkUmpa?=
 =?utf-8?B?cU5GL0E3cUlsTTBHR2o0NXNIaXlabzU1bXliKy9jTURqNWxmcHBVNFp2K2hW?=
 =?utf-8?B?VjRERkVpTWNjK2tFM0xvbnc3SWpEVXRFUkFPcjA2TVNjdittTnVPUzJzS3kw?=
 =?utf-8?B?L3BXL3hERjRZWkhBZE5nNDRKbUpHMlVBTWoxUHZwbURQWVF1VVNQc1VqQm9m?=
 =?utf-8?B?SUxXRXc0eUl6V2VZdWtkUUZ4OG1Sd1lYVXlTRzZCR3RjWFByeW1UN2dqYWZN?=
 =?utf-8?B?bG5NWE1OQVVqOVhicjc5QTZzN1l5b3BSKzlyMHRVRTc4b042bXhDSGo0WFlJ?=
 =?utf-8?B?SWpaVG92TDR1VmxYQzNvZ0V1aWoycFpCTWJ1a2ZWREllZmpGb0tUOXVDTzh0?=
 =?utf-8?B?TGdHbVVvblJUQmNlSDFCWTJYWWVOak01TEswaytmcy9CWi9BUHZsV2w1a2FG?=
 =?utf-8?B?eTNNVmppUFFoQmptY25MaUVqcmhZeDZzNWpDaVY0V0FBM0FadkJpaStoU2R4?=
 =?utf-8?B?ZHNWNFlwK21TaWtUdWwzcEx2ZjdUVTlQREZIcHBseDhEdlVIM0xhZDZpV1k3?=
 =?utf-8?B?WG0vaFNYRm1UNE5pY3BkT1BLNm9aUnlLMjBIZnl6UnB2VFdIek02QTAwNDVX?=
 =?utf-8?B?T0FXUmx6V3FxNmNtdDVnYkN3N3dlWDhiWSszTHV5c1dWd3lua1ArUndpSEp4?=
 =?utf-8?B?b2VGTUg5UGJrampOb1hFbnM3aDNLM1JMQ0RQWHdaVDArZnZraThKbEhWMVcx?=
 =?utf-8?B?R1N0S09YVGFhdWFpQWptVTJLUDV4ZjVkemdZMnRseE1raDhZK2dBRUNzTkN2?=
 =?utf-8?B?MGp5WWZlMHZSdjA2V3E5WU92b0Q4VXljcnBudENCclpSeDVnVmJuSEhUek9u?=
 =?utf-8?B?QVB4YXBNSUl6U3dTTWYyc1d0WFhMK0RialhtSkJCVkdsRnFXeC9ZQ3dJV2tv?=
 =?utf-8?B?NW80QWFlVnBIZEUvMWh3Uyt6RkVZeDVOeUlRSC9UeUtsVGtlak1uS0pjQmJy?=
 =?utf-8?B?cDdHK1ZVNk90V0RFanhrWk12OFdJUXlHbk1IRkZyeUtoSHE3R0czTEdaVlB5?=
 =?utf-8?B?TnRQcTVjdTlJcy9ENEZYNHAxRzdnd2svRDNMckwyUGF1bWZiRXlhVjJUcGFQ?=
 =?utf-8?B?djJ4bWRkNUVHRFloNGlrd3JqY3EwbjJxbUJ4cW5hYXYzTkpUU3VHWDdxRU5Z?=
 =?utf-8?B?dkc3WktDY1MwVjRiOWhscElLbnVmeDhwanhHSlJRWWl3eWJEa1lPR2p0VzFV?=
 =?utf-8?B?dTJtcHJsN3BjTDFURUlDdHZxeVcweEkxS3U1c2w4NkJWMzlwTWRhR2hUeHgx?=
 =?utf-8?B?VlBWUVZ0cVNGRWZVUE9CK2xNc0ZGcVV4RXJMeXJjVFFNWUp2VjhVL1ZxOFdY?=
 =?utf-8?B?Sis2QnhJcm5BMDF3Y1UyV013WFVLMjlzSEhlRXlwY05YamZ5RXN1bjBkaGdR?=
 =?utf-8?B?TUhscXdBZjgvV3NNZElDV0htRTU0cjdkUktZNitKZlczQ2FhTWt4ckg3Ylkr?=
 =?utf-8?B?ZlRBTHE2QldTclZ1V0FXZjVJU1c1RVA0Y1FQeVdFRkQ3RVQ0ZUZOd1ZRQkla?=
 =?utf-8?B?cTFWWEF3UWxSUnY2NHhmN3RCMm5LS0RVcXN3U1loYkhSZCs0ZVlBTWgwRldk?=
 =?utf-8?B?TXUzNkE2c0UvRDBVcHJrcU1TZEhMU2hvMkhvVmVVSml2RDFOeTZqQlZzRlJE?=
 =?utf-8?B?aEIxSEZ5RGpROXRlaWhSSUF5eThrTTVndnJyS094OW1ZKys1VXcxQlJWRXc4?=
 =?utf-8?B?YVhEU2swcmdvV0dsN2xyRlhBRTZZTjBKWkpmMUtnSUJnMnFWcDBUTDBnNXlq?=
 =?utf-8?B?QjRnZzF0N1FjUDFjVVE4dDFUVFhrRDNzcTNsZTNWNHhuaFc2dHZCVzFxcC9a?=
 =?utf-8?B?Q0JqOXhKUktYVlBTamowYUs2RlhEN0ZXT3ZBRExvVmRON1FYZXJVYlpRUXlq?=
 =?utf-8?B?OTZ0WXJFaHJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:31:48.8089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe0dd12-0a93-4bb6-d555-08dd373e59b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858

On 1/7/25 8:10 AM, Robert Richter wrote:
> To enable address translation, the calculation of the endpoint
> position must use translated HPA ranges. The function
> cxl_endpoint_initialize() already uses translation which could be
> reused to calculate the endpoint position.
> 
> Use translated HPA address ranges for the calculation of endpoint

s/HPA address ranges/HPA ranges/

> position by moving it to cxl_endpoint_initialize(). Create a function
> cxl_port_calc_pos() for use in the iterator there, but keep a
> simplified version of cxl_calc_interleave_pos() for the
> non-auto-discovery code path without address translation since it is
> not support there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 66 ++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 007a2016760d..c1e384e80d10 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1813,26 +1813,29 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  }
>  
>  /**
> - * cxl_calc_interleave_pos() - calculate an endpoint position in a region
> - * @cxled: endpoint decoder member of given region
> + * cxl_port_calc_pos() - calculate an endpoint position for @port
> + * @port: Port the new position is calculated for.
> + * @range: The HPA address range for the port.

Same as above, but it may be better to write Host Physical address range instead for
the extra context.

> + * @pos: Current position in the topology.
>   *
> - * The endpoint position is calculated by traversing the topology from
> - * the endpoint to the root decoder and iteratively applying this
> - * calculation:
> + * The endpoint position for the next port is calculated by applying
> + * this calculation:
>   *
>   *    position = position * parent_ways + parent_pos;
>   *
>   * ...where @position is inferred from switch and root decoder target lists.
>   *
> + * The endpoint position of region can be calculated by traversing the

I would word this as "The endpoint's position in a region can be..." instead since
I think that's what you are doing below. This currently reads like the region's
position is being found.

> + * topology from the endpoint to the root decoder and iteratively
> + * applying the function for each port.
> + *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
> -static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_calc_pos(struct cxl_port *port, struct range *range,
> +			     int pos)
>  {
> -	struct cxl_port *iter, *port = cxled_to_port(cxled);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *range = &cxled->cxld.hpa_range;
> -	int parent_ways = 0, parent_pos = 0, pos = 0;
> +	int parent_ways = 0, parent_pos = 0;
>  	int rc;
>  
>  	/*
> @@ -1864,17 +1867,30 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  	 * complex topologies, including those with switches.
>  	 */
>  
> -	/* Iterate from endpoint to root_port refining the position */
> -	for (iter = port; iter; iter = parent_port_of(iter)) {
> -		if (is_cxl_root(iter))
> -			break;
> +	if (is_cxl_root(port))
> +		return pos;
>  
> -		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> -		if (rc)
> -			return rc;
> +	rc = find_pos_and_ways(port, range, &parent_pos, &parent_ways);
> +	if (rc)
> +		return rc;
>  
> -		pos = pos * parent_ways + parent_pos;
> -	}
> +	return pos * parent_ways + parent_pos;
> +}
> +
> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *range = &cxled->cxld.hpa_range;
> +	int pos = 0;
> +
> +	/*
> +	 * Address translation is only supported for auto-discovery of
> +	 * decoders. There is no need to support address translation
> +	 * here.
> +	 */
> +	for (iter = cxled_to_port(cxled); iter; iter = parent_port_of(iter))
> +		pos = cxl_port_calc_pos(iter, range, pos);
>  
>  	dev_dbg(&cxlmd->dev,
>  		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
> @@ -1892,7 +1908,6 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -3252,6 +3267,7 @@ static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *parent, *iter = cxled_to_port(cxled);
>  	struct range hpa = cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
> +	int pos = 0;
>  
>  	if (!iter || is_cxl_root(iter))
>  		return -ENXIO;
> @@ -3280,16 +3296,22 @@ static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
>  		if (cxl_port_calc_hpa(parent, cxld, &hpa))
>  			return -ENXIO;
>  
> +		/* Iterate from endpoint to root_port refining the position */
> +		pos = cxl_port_calc_pos(iter, &hpa, pos);
> +		if (pos < 0)
> +			return pos;
> +
>  		iter = parent;
>  	}
>  
>  	dev_dbg(cxld->dev.parent,
> -		"%s:%s: range:%#llx-%#llx\n",
> +		"%s:%s: range:%#llx-%#llx pos:%d\n",
>  		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
> -		hpa.start, hpa.end);
> +		hpa.start, hpa.end, pos);
>  
>  	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
>  	cxled->spa_range = hpa;
> +	cxled->pos = pos;
>  
>  	return 0;
>  }

