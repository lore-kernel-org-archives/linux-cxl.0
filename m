Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569801AA795;
	Fri, 17 Jan 2025 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149510; cv=fail; b=iHk859hrAB27XJE/NXzL/cL6Jf9YxECRc+OsfExQdDuOeffe6oOGpeQ61q9344cHUqeHzn31zRvXDqVS6YvrcwoXaUXbv9fZZpGJmIHWpXtUY8gSuzBNVkYP7fDQThGH59x3uNZzWuhU4nHkObb+vD41aiJP8oniopcuFw9GU+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149510; c=relaxed/simple;
	bh=GJYqIEBd++/FYoB1b7ZjKIJwZtTfvClAm6luTFtPu+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iJjZ28vRlrY0TCEOfHsn6+f1iBcEQ3EQdhXr2+yN8WsC/ueuvCdywQ5kjuKMcxHRj0blbZPvs15Atn8lBk5W2GSdpKAl7ToOLcZb9TH3pmt3fh1TNxgiDVv15uQjDGCsxVgw3dLE0CqdQn1L5vvvOl4VMv9s3RujvoqrVZeoFwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lg4YDHEO; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lg4YDHEO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cru6L+pSpTMfmMoIfXVlEvOeHEqV6Fs8Gm5KKe9wc6OfTt0KVzZAB9WnD2vi8dtmnuhfJGsJeVrRlgkTdvHx2XLPnILKna4fSsH/2kF/34XGEgPNCd/nf7eToGUBeGIfW3We3wte8IFax1ucxBrmnAjP41SzqyxfPWheK82jNWrtr1vGYOvraSb+AgqGur3gT81VccWCvaS/XJTW7QD70I/Yms/sUW9fsIV1mWnf61LCxh1eOG6Ttb6ZDgB5yfp1cjkyO1dnFSZVOH9yJbTOfea4mMdXZ8Et28rsven1x0hyaQGGSwgb+WSE4pKN6UMwlitxzgWRBJIM4r4j7TT66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBC4r60f4UZ9pihbrzqNaUcJmM6Lp2bMfRvPjte7U5c=;
 b=r+b3GRrWWAvspm4SdReAjgBqRgCW4vzTPU8SSzDxQzVSIAt82TZxvBeGHYVBdtotJbKtsKl7m650h+C3lMTNDwoUmcFFOazGPgRbG7UV4Y7e8ZJRCz/xluAo75+eVSSgkte16MsoVoW3IqJpMyrp9amKQ55j0XUgbkG1oPWzAVWkIUZbouE9Se1k1ooZdrTC+fae68p8jTpWVRFdPARvmAVnTWQoAk0uHWvdo0fvNEQuVv1njve7fxSNl0RxrK4/9aHKR8dkteyu01UDEBksYY4cYBT0aro8ILdlWZO8dzVGNyT0cxi5NlgIv3UtSJqdxjJnR2lBSggFeNXjM7JAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBC4r60f4UZ9pihbrzqNaUcJmM6Lp2bMfRvPjte7U5c=;
 b=lg4YDHEO66BxHC8CWfHAOLU70WTaDtd4/qZD7HnBcsp1/a3vOfjpWQ3xtGhHKvnBFYIK6WHWlqzurA0nHbcUkI4ATWp4+qzjb4ccK7wSqIqAKbVRtwrBOAsiWFygcSWNsywz1/8XIuvUXjHZ1SVj7IwFZrMrySFGS2A/6fVxJgA=
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 21:31:45 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::41) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 21:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 17 Jan 2025 21:31:45 +0000
Received: from [10.236.177.252] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 15:31:42 -0600
Message-ID: <42f95f6a-8c92-40b3-9ad2-623ff4d8267c@amd.com>
Date: Fri, 17 Jan 2025 15:31:43 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/29] cxl/region: Use an endpoint's SPA range to find
 a region
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-16-rrichter@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250107141015.3367194-16-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: d703ee2d-f8cd-4639-ee56-08dd373e5784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTA1Vmc2Q0hMSWNWeXo4SDJtR1doTVVyNysyQjd3S2JaS3lpOEthMmRzZHBa?=
 =?utf-8?B?NG9iR3J1cTQvOVJxRUkra0REdlpreERNN0o3N002NTNSMGpjSktzTlBneWNG?=
 =?utf-8?B?MnlWY2I1ZXN5OFNwNEJ1RnhhN1NJOVpibVFlSHI2RzFCOXlrVVdlT21kZ2di?=
 =?utf-8?B?TFc2Z0g5WDd6cHJPYTdiMFlHUEdYWlpmK2J5bGV3OEs5a1hjRzBJT3NyL3Z1?=
 =?utf-8?B?anNpR1dpQ2VsUHpYRHR1eWRrNVQrby9lM1NUMkUwRU9yMzFzR2JIWi82S1BJ?=
 =?utf-8?B?RW5PeW8yc0Ird1RvQ1RKRUN4UHpCanNnazlacm03cWNUWUdlRmVNdGhZZ0to?=
 =?utf-8?B?eTFPT09mYW94RUUxUkJGaHJQYVFsYkg0RlpPa1N1MU1CelN2M3J1VlA2QnJq?=
 =?utf-8?B?ZDIvejBFdENBNm16WHVOV1pmMXVKV0V5b1UxZkRDbW42b1NoNGYyQUQ2aHJu?=
 =?utf-8?B?MlpWMlFhTzJmVm84MHp4MnhMYVMyRzg0VjF4RlEzOHdIYnZna3Njem05ZHVp?=
 =?utf-8?B?L2dXQ0xESlAyVjZIY0lPZVdrSG5jaUpUUWxyU0JkaDhyTERBQ3JMajlJa2J2?=
 =?utf-8?B?OFd4RW1abFpGeUZmdGo3VVhDR2oxVFhlQ05zZFh5cGpzV1JUa0tjZ2JFWWJj?=
 =?utf-8?B?WU5KL0F6VmJQTmJwNWw2eWg3OE1JeWI1K2xRUTlOYmVnQTVGNUdIaUt5UW9U?=
 =?utf-8?B?WW9rSFFhRGpCaVlLSkx3cjhXNWwyY1E5TVR1eTYyQjR2NXdJQlFTaXE3QUov?=
 =?utf-8?B?Q0Y0OWYzNzlsKzZ3bEtvQ1UwLzA2N1BYVnRHc1dRSTRmQ1VwT2VNbmtjRGZ4?=
 =?utf-8?B?T1ZPMXN4dTEvNlE1WHhOSzhQZ0RST01saXZUSlFIYXJGSzR1dGJ2a3JIM3lD?=
 =?utf-8?B?SmJHdlQyTUVUU2ZQMHl6VStvNUhVZXYxS2h6RGJSQ0NwZUVXbmh6b2VMbWRy?=
 =?utf-8?B?QUxQMmZOd2dFTFpqeTdPTVNEN0Y3c2FPMW9aV0djNTFPM1k5WVV2bVZWbXlU?=
 =?utf-8?B?RThydzQ5bFdNTUhqKzlTYkhjUVF3TWtnTWtTQWNTSTBXQ1dDckJDN2xJWlhk?=
 =?utf-8?B?SmovRlFrQzdCU0l6TGNCV2t2RVIyT25yZk9SRGU5TmJadEJYNFpZbCt1OHZK?=
 =?utf-8?B?MEQ3R25keVVoSm1uam1vWU5pNkhJM0x6U1MwQm1YYVN1K2EyY2ZRbzJQSC9h?=
 =?utf-8?B?b2k2MHYySFNLcTluWSs4NW1MVDgrYmJDbHZUMWhQZGFzSUp3aGRaTEdDcVFt?=
 =?utf-8?B?cnBFUElIdUk5eEtWM0tFSndxamdjQzlseGdpNDVjUFlEZ0xTV2lIdmt0SUhS?=
 =?utf-8?B?WlNueFRaN1MxVEt4eEdPRzhnT0g4MjRhMGM4RGZGaEllZXFwblpGaGFybjBi?=
 =?utf-8?B?NGFHVVpWSElwaThtVVRVclN1eGlvbXl0dFRUZjNLTXgxY0xzNlFBU0Y1T2J2?=
 =?utf-8?B?Qm9Na2ZpMXh0MG9wL0lxTWdTTUM3LzFBNlJkcCtYVVRDWmlkdHRJSnJraWJ1?=
 =?utf-8?B?MWhiR0JEd1c4RlNXcFlHZFUydnR4am9rcVF4WkUzNndINHYyV0pWK0ZBZVhW?=
 =?utf-8?B?WUw2cXB4bCtHUmFVSHdvaGJCcDh2YklkMUNGc29JSlZDcWdXSmM2a0FhWEcx?=
 =?utf-8?B?YW93eFpxbW9KVEZuZW9RUmd4YUltSEhRdzBCZTNRSWlVcXdGNTQxOTJtRmNn?=
 =?utf-8?B?dUdwckR1blpUOC95MzlISWhvUFdPYlM2OVFXcDdZL2ZMVG9VT3hqSzdxUHFh?=
 =?utf-8?B?d0NsNWt1R1VHbmtvd25KUWV6NzJ4WW9VTzBmY05NZ2U3S2VwYkNZdkVKY2Ju?=
 =?utf-8?B?Vkt6eXE2S25HbjRidUZ6aTdaWFc4dzE2WCs0cEp6WXdKUnZMTUlDVHhacml2?=
 =?utf-8?B?Vk9tSDZGZWVGVUhNSmsva3QzUjlmVzVoM0RXY1FDMS9nQTRjaHY4WDlFQzF6?=
 =?utf-8?B?Vis4U0pFRnVvR0pFeURzc1R5UUExQWc2Wk1rTE5heWhaVmZWZkZBOENvanZH?=
 =?utf-8?Q?yGYTXc7mIGZe8sVa76aW2dCyJXyevU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:31:45.1526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d703ee2d-f8cd-4639-ee56-08dd373e5784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904

On 1/7/25 8:10 AM, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Calculate the SPA range using the newly introduced callback function
> port->to_hpa() that translates the decoder's HPA range to its parent
> port's HPA range of the next outer memory domain. Introduce the helper
> function cxl_port_calc_hpa() for this to calculate address ranges
> using the low-level port->to_hpa() callbacks. Determine the root port
> SPA range by iterating all the ports up to the root. Store the
> endpoint's SPA range and use it to find the endpoint's region.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 85 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 71 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 09a68e266a79..007a2016760d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -824,6 +824,41 @@ static int match_free_decoder(struct device *dev, void *data)
>  	return 1;
>  }
>  
> +static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
> +			     struct range *hpa_range)
> +{
> +	struct range hpa = *hpa_range;
> +	u64 len = range_len(&hpa);
> +
> +	if (!port->to_hpa)
> +		return 0;
> +
> +	/* Translate HPA to the next upper domain. */
> +	hpa.start = port->to_hpa(cxld, hpa.start);
> +	hpa.end = port->to_hpa(cxld, hpa.end);
> +
> +	if (!hpa.start || !hpa.end ||
> +	    hpa.start == ULLONG_MAX || hpa.end == ULLONG_MAX) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: HPA range invalid: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa.start, hpa.end, hpa_range->start,
> +			hpa_range->end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (range_len(&hpa) != len * cxld->interleave_ways) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa.start, hpa.end, hpa_range->start,
> +			hpa_range->end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	*hpa_range = hpa;
> +
> +	return 0;
> +}
> +
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
>  	struct cxl_region_params *p = data;
> @@ -3214,26 +3249,47 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
>  static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *iter = cxled_to_port(cxled);
> -	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_port *parent, *iter = cxled_to_port(cxled);
> +	struct range hpa = cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;

Can cut down on the dereferencing a bit here by doing:
	struct cxl_decoder *cxld = &cxled->cxld;
	struct range hpa = cxld->hpa_range;

instead.

>  
> -	while (iter && !is_cxl_root(iter))
> -		iter = to_cxl_port(iter->dev.parent);
> -
> -	if (!iter)
> +	if (!iter || is_cxl_root(iter))
>  		return -ENXIO;
>  
> -	cxld = cxl_port_find_switch_decoder(iter, hpa);
> -	if (!cxld) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> -		return -ENXIO;
> +	while (1) {
> +		parent = parent_port_of(iter);
> +
> +		if (is_cxl_endpoint(iter))
> +			cxld = &cxled->cxld;
> +		else if (!parent || parent->to_hpa)
> +			cxld = cxl_port_find_switch_decoder(iter, &hpa);
> +
> +		if (!cxld) {
> +			dev_err(cxlmd->dev.parent,
> +				"%s:%s no CXL window for range %#llx:%#llx\n",
> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +				hpa.start, hpa.end);
> +			return -ENXIO;
> +		}
> +
> +		/* No parent means the root port was found. */
> +		if (!parent)
> +			break;
> +
> +		/* Translate HPA to the next upper memory domain. */
> +		if (cxl_port_calc_hpa(parent, cxld, &hpa))
> +			return -ENXIO;
> +
> +		iter = parent;
>  	}
>  
> +	dev_dbg(cxld->dev.parent,
> +		"%s:%s: range:%#llx-%#llx\n",
> +		dev_name(&cxled->cxld.dev), dev_name(&cxld->dev),
> +		hpa.start, hpa.end);
> +
>  	cxled->cxlrd = to_cxl_root_decoder(&cxld->dev);
> +	cxled->spa_range = hpa;
>  
>  	return 0;
>  }
> @@ -3358,7 +3414,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  static int cxl_endpoint_add(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> @@ -3370,7 +3425,7 @@ static int cxl_endpoint_add(struct cxl_endpoint_decoder *cxled)
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
> -	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> +	cxlr = cxl_find_region_by_range(cxlrd, &cxled->spa_range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c04f66fe2a93..4ccb2b3b31c9 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -419,6 +419,7 @@ struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct cxl_root_decoder *cxlrd;
>  	struct resource *dpa_res;
> +	struct range spa_range;
>  	resource_size_t skip;
>  	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_state state;

