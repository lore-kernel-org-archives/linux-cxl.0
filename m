Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794952188;
	b=BifuzHpLGm+ocVShU6NJKr5bS3+3vxS7R2TiVoEcXH7BtA2zz2niMUJUaZHPcFulZ1N/
	 JUAc9sKGEDXq6pZzQCtOXirkvo3Bcw0WZf8Cpr6mzxyHe9YE0pFrJiB8TS4RGSbz9L6Zt
	 5thw3oYU6OEFMbTx1bYRigvA/OWRRo3ekTeZezdKF0TTiMufGb0KFj4j2GKs/4zxluH46
	 MACLl72evWzuq/FomgOHEKLdDmOSGP5vZ6lyVXFuIgXJcmO7qUl+ZWdqcxEakjJGNUHg9
	 253pNSkMXWuaH6oVapWcdhExiSXwGj89IpTPW3nZZUuR3dlODWssvb7PVIViZgP+DiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952188;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TZ5DQzNk1KewNT3jxQP//IaZlUzEFeiJXzWL0OZq2+8=;
	b=sa6sbSyjoRNcn51uZpmUVAlm5hUzTyyDRcwhe228VYFf4FYI7DgGpZUBnp6j09p/TPlN
	 CZRtAAozI84hV4v2dhA4vJaJs03mdOyzkZwCS349xcYlJl57J/rIjysCYy8Nv6bQ05jco
	 UZPLVAdHxyHbg0j14cFrZR27MjKBVCCrFlW1UwNYeticXR2h8Xr6AZrS0LXLpFSpC4TQ3
	 jlNVmA1+/ld2aBb+Y2LUCSW1FRsMLndK9pBCyBEiHsSi87CGuYfNUQZN7Ay14v28PmjSt
	 IV7E8aOKUcSKIGaKosB2CZNiMYypihstRevfSyLAovd5vfSkq6r2yXxfhVkeOYNgZdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Il+Sm8Pu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.66
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FCA606A31C;
	Tue, 17 Nov 2026 21:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35FCA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Il+Sm8Pu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AY7GCIvVEDK0P3WDP7rE8BOR2LoyDU6FfAE6YcgN7j/HoGdh7hS9HB0tPPCdgBcsmSymvGQ3lLPPUopFJXpnbIw2dlveKbpmJ6PKM3hovj1NH2dC5L8aEUJyEj8qMlIEtKKAargN2CceU54YV1R1OslfX5CdqssfXh9/xUPLatCuceuwu+iaXkFg82VQpimPVT6///sS8iv3CwH2J3zY3V46tDAFr33Go9d/uSn1YznNVXesXnOgW12JTDxfjSMiHVx0V7avPChIeorxw7/v9JnJ0thjk5O7K4SmZW32/NMWKLnIYvkOoAKT5L9NsPGv9zIRpnji0YO9RbyVoHgZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ5DQzNk1KewNT3jxQP//IaZlUzEFeiJXzWL0OZq2+8=;
 b=M8vT63tvNd003VCrPmqIMuV6Y822/4lWhtenu70Y/sienuoshoRI+0WU07VXsEDnhBgGBXCeo+W84BYiDQsrVHupzQzOx/X33bi9D+Zg54fPn2HeiIx/eUYf4LMu8yipOIUqVP8RZ4CCqdCAF5Le71A7QTMNDwtgNbWlU3/PqDSgXl4460IWSwWrssNCt0WZ00hP4J7mPsHy96XPvIvN2vF8DePulS55Bth0bCXxLa/vkNAUfoVKCtugRl02l+R6hQVvw9EcpYEljwa3PnK2y7gK4DKOF9TK5hYQKrHlwoPUZ8ml92UqdTuvqut6Tf01aoyl7qa8NZDT/mSSLFzMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xcena.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ5DQzNk1KewNT3jxQP//IaZlUzEFeiJXzWL0OZq2+8=;
 b=Il+Sm8PugBD+WrFo83lNA8EWQlaK6EDOhzgpZmUvY56C0L4xQS1LoE5s5dilAHv7LcDu7J0sun/3XL461rr3TZelLUtZuD3BRYCeBDo3rRVYXivTl0HBqoFfgjhycqPpYrW7t4OFIZdnKvxVi+le59jWTVi3FaO7+h5sr76G9FE=
Received: from PH8PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:2d0::18)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Tue, 17 Nov
 2026 21:49:41 +0000
Received: from PH1PEPF00062F24.namprd02.prod.outlook.com
 (2603:10b6:510:2d0:cafe::1e) by PH8PR02CA0007.outlook.office365.com
 (2603:10b6:510:2d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 21:49:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F24.mail.protection.outlook.com (10.167.243.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:49:40 +0000
Received: from [10.236.182.143] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 15:49:40 -0600
Message-ID: <23185fba-5905-4671-8d94-8ae10c78077e@amd.com>
Date: Tue, 17 Nov 2026 15:49:39 -0600
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix self-deadlock when
 cxl_memdev_attach_region() fails
To: <junho.cha@xcena.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Alejandro Lucero <alucerop@amd.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F24:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3fba27-0599-47d4-0e2d-08df44f4af0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|30052699003|82310400026|11063799006|261022115727099003|261021123027099003|10067099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LpV+V8+MixJR/cnJ3pz5hDXb9tjEtmAahfN0QlxbA/QbyNYNLcOfMNIPfHCeck/5838PU/gHWAekNLAAAVUOs0PWme6KXZuL4Ch2dQxTFJVp1mKuzrqYzYSJxICLbZ7Vd1nmJNb5jU7GYv5wGDAp1TZ8DZpB5y45p4l0YamiYVBLQsUsnTRXbiBjMYCFrnoOJsEjJ1NW0fCGsASO0oSZTMoQgGxmfIuhiiljkieCZGLjaAqQC9TMSz6h1ms1qXp7WcArNbojIQQBt1WR3LlowsYFQZ3dSRqBlu7GsQBbUKGYveLnJfZTCdGrEbJBZ48t9rkqxT0qzpuLtuNqRcte4D4EzK0XSbpD55zy8UpqrT+BfBDuuJ6ertWpdz/CHyU0JhOJuCfW+UXVNjRXc2VCCDVvuqFPlZfxEQ15zqj/eJ/dTZ3LGK82lb6vPRM/W6yqQ5fllgVdH86x82xvp9uw0MVZHeR2BYi+DPBOQAHZefZHWmZ4QZfvDZSE/dnvQqzUqO8yy4rVRFa0bCgG3Zwu5YxokiW/QiAPTNGl2YDk8rl60TSTl0oiTbf7/oNLLqQxaXH+Jmt6jfvPyvkR0ShBCEyyxq6Ml5f9bGN3JfZWEFCmpQh91Mj6/TEUNdWrhLS/nFlNOaIOyfKpy7kDODohfo/o0XKAkzI8fwi6ULgbp5S7nhhva2tD9mB9ke3Fxg7o93RR+BcpxCW3YDfe9kpd9Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(30052699003)(82310400026)(11063799006)(261022115727099003)(261021123027099003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pAD9qV94GPzcKtAQ8d1iY3RLC4L423RgLwZ2mEE73oVlASLpqbr7zlDRV3L1jsl4oQBXDYpWHp+MOCZ/sTwxSCIDhJBnm4xas9jW5BS3biQyI1IZ7xKuyTWw7KGUP/CMT0XVcL8JsUBVR50ozA1YAv+p/wAFH6rSbG4zIfkSMcKKEpHq55yli6h7rXAg9542WKYH3hJnoNXXdNnPnxsgB6m7am3kmZVl46sLL4MZ15xWoH+nPyF3I6TRYFxIT7mEKDg6+gBcbNM4S5d3WHdDHelG5klCeQlsXd79CKBLMd+F/N5DjVsTbKXINuieYrTpT9EfewMgiOwBUXaFHxZJI9ha1dgCiRXZoaCbKrYtl0I7zU65wbxraXO9bYj9sLtnNxG5xOHqhAPUlzsi/jurk5xwOFCVVifXfInv2vBZSdVMQ1aY2XdquYZpcj1Ogw2r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:49:40.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3fba27-0599-47d4-0e2d-08df44f4af0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH1PEPF00062F24.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC

On 11/16/2026 8:59 PM, Junho Cha via B4 Relay wrote:
> From: Junho Cha <junho.cha@xcena.com>
> 
> cxl_memdev_attach_region() holds cxl_rwsem.region for read while it
> registers endpoint_unregister_region() with devm_add_action_or_reset().
> If registering the action fails, devm_add_action_or_reset() runs the
> action at once, which reaches cxl_decoder_detach() through
> unregister_region() and detach_target():
> 
>   cxl_memdev_attach_region()
>     down_read(&cxl_rwsem.region)
>     devm_add_action_or_reset()          /* fails with -ENOMEM */
>       endpoint_unregister_region()
>         unregister_region()
>           detach_target()
>             cxl_decoder_detach()
>               down_write_killable(&cxl_rwsem.region)
> 
> The task then waits for a write lock while holding the same rwsem for
> read, and never makes progress.  Before it hangs, lockdep also reports
> a circular dependency: endpoint_unregister_region() takes
> cxlrd->regions_lock under cxl_rwsem.dpa, while cxl_add_to_region()
> takes cxlrd->regions_lock before both rwsems.

I don't think the lockdep dependency is related to this, it's in a completely
different code path. That said, it may be fixable by converting the guard() on
the cxlrd->regions_lock in cxl_add_to_region() to a scoped_guard().
[snip]

> -	struct device *dev __free(put_device) =
> -		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
>  
> -	if (!dev) {
> -		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> -			dev_name(&cxlmd->dev));
> -		return -ENXIO;
> -	}
> +		/*
> +		 * TODO auto-instantiate a region, for now assume this will
> +		 * find an auto-region
> +		 */
> +		struct device *dev __free(put_device) =
> +			device_find_child(&endpoint->dev, NULL,
> +					  first_mapped_decoder);
> +
> +		if (!dev) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"no region found for memdev %s\n",
> +				dev_name(&cxlmd->dev));
> +			return -ENXIO;
> +		}
>  
> -	cxled = to_cxl_endpoint_decoder(dev);
> -	cxlr = cxled->cxld.region;
> +		cxled = to_cxl_endpoint_decoder(dev);
> +		cxlr = cxled->cxld.region;
>  
> -	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> -		dev_dbg(cxlmd->cxlds->dev,
> -			"region %s not committed for memdev %s\n",
> -			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> -		return -ENXIO;
> -	}
> +		if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"region %s not committed for memdev %s\n",
> +				dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +			return -ENXIO;
> +		}
>  
> -	if (cxlr->params.nr_targets > 1) {
> -		dev_dbg(cxlmd->cxlds->dev,
> -			"Only attach to local non-interleaved region\n");
> -		return -ENXIO;
> +		if (cxlr->params.nr_targets > 1) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"Only attach to local non-interleaved region\n");
> +			return -ENXIO;
> +		}
> +
> +		/* Only teardown regions that pass validation */
> +		get_device(&cxlr->dev);
> +		hpa_range = (struct range) {
> +			.start = cxlr->params.res->start,
> +			.end = cxlr->params.res->end,
> +		};
>  	}
>  
> -	/* Only teardown regions that pass validation, ignore the rest */
> -	get_device(&cxlr->dev);
> +	/*
> +	 * On failure the action runs immediately and detaching the region
> +	 * takes cxl_rwsem.region for write, so add it without the rwsem held.
> +	 */
>  	rc = devm_add_action_or_reset(&endpoint->dev,
>  				      endpoint_unregister_region, cxlr);
>  	if (rc)
>  		return rc;
>  

I think this could cause an issue if you have multiple type 2 cards in the same region. Imagine this scenario:

1. 2 type-2 cards both complete the critical section guarded by the cxl_rwsem locks above and have cxlr set to
the same region
2. The first card fails to add the action for some reason and runs cleanup before the other card gets to enter
devm_add_action_or_reset()
	- At this point, the region is deleted and all the decoders detached, etc.
3. The second card then successfully adds the action and passes back an HPA range attached to a dead region

Maybe you can get past this by keeping just the cxl_rwsem.dpa lock through the end of the function? I don't
know if that's too hacky, but I don't recall seeing the dpa lock taken by anything after endpoint_unregister_region()
gets called so it may work.

Thanks,
Ben

