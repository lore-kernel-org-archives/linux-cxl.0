Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658A39DBE0
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955120; cv=fail; b=cpNPcm0iaw6TRYaWc8ok0eEOvuV/78EvxCnLGAZavFXAmgMFedZq55sHmr3jf74eFaysop52cId1q3lCI/cTGShF3KroBGwT2Il2xbD/M8QAupxqBijIWyOFgSIBtdAlB1WD2TaX9D1FPr5jq9tC3B+QbXB9+nIWuIm+g6n1bE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955120; c=relaxed/simple;
	bh=1Zok2eaptmdOjN1ETzHSvqWsgzv1hLf/ZfaMuRngjDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LO3vmSSJdAEYBCNTQF5AVoSq16mI0YcgcRwPUWgXkYKMP/lOjzX24LJkOVDMQ2fMGn+MDM2k5r93hPCYr8QHKZqym/toso87miX2atMYzrkEr2JKIz+dCS3eSkHP9C0Wl6XvsXTBvSY8uCeVdQcapK1WEozeruPjcxSAJShOU2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FcU1R0KP; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FcU1R0KP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOX8Bv6AHajTjLk1HHxLkgC4x302TgGWxAfsA5B6e2qnZsTd9RhEmljD+wLbAUGwrGJrvva8LAQtxgo+Z117UmDDbvSGYAoa7s2PMHp/J2+isgH7rQTkQRDVj8kL5rQGXWDX0HdXxat5aBKgVWyM1TrNEU4v3UsYx8XjPjYUSJywBe+6740MbsC8Tf8s5PPtD4jGoEORILIc7jpNwtEHvQLFpspbk1P9BQJd7t2FsxK5hYAaEcIIZjTVZND4BLfATNGS94m3zefeCvBCUJgGwX+eZABjrKifSGdW9EEigeIi6BisRPviTHTpj2/+wfVgPzWs3W6GOGlU9qVuvyjgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIERtJ2oZmkNW5M9o8XhdfwLFjDA1JWSqRriHkscV+o=;
 b=qDPLGGl6D9IVowg+39OrGO7KJOF4qS98pSDlSX42JYSy0NZebqaEReJglc/CS/CG4sQDw3A9eeLBtL0G9OC2s5/mHBEKUDlWXavcsT5eB2ziKpkis+omTOtDR0tAGlhiB4/M0NAGnytf0ZWKxg6h4deEXTQDFQKHHEqbOdEVQWVxtCkMhEA16owamyKmmIUDnG90gHgYJethidU1HScwfOIqmdoLs7VPS1uU9m4UpECT4RiEScuP7SytI+EJBCtWjuwN1HG0IiSCFE8p4270FSNpgteiy01U6RbuOOR5oSHYVYxl1/xiek9/W2iaJUGslyaLZGHuzM5UfmFC5JXcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIERtJ2oZmkNW5M9o8XhdfwLFjDA1JWSqRriHkscV+o=;
 b=FcU1R0KPWsVgjTTuKyVbxBlfRguUWXbSEjU+K2nFa8vJTljRszmJwIn14c48XrXs/LlGwZPNHH2lPzwqxJP+wCUxH3mTHB+kR1l3l3dWEX5UFuYr3QQH3AFRwQhaoKvGsyH3pCPIBhyL+nH58/s5z88B3xF7msm3As026YEe4C4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 22:11:56 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 22:11:56 +0000
Message-ID: <761baeba-2394-4b1b-932e-826d99cf289d@amd.com>
Date: Fri, 28 Aug 2026 17:11:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/ras: Pass the PCI device's struct device to
 match_memdev_by_parent()
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 ming.li@zohomail.com
References: <20260828215726.1077498-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260828215726.1077498-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::28) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: a87aa156-0c79-4bb0-b7c8-08df05515f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k+JrylrzaDQgd5/qxYHG253C9mZ8txfpzXyNTF+Y6oRruLkWYI4+C/bVAbcT89GzOWw18THgsVEgYuVw11BDVo07dXpnokSYxyPk1rrAN9pKRE74yOFtr4kRrwUnso62R7RAUqKF+jojHlUbSDD8ILL2XZsWCZYeH5jaIdsf/8dq/yF9nBosASM+0JycRwIQzt5rs/8KfovnGAHFTi4hgu/ptivZD0NdDb+V7TFGTXvxL9u9kHOfP/wwuFfKBAyXo+hF4NQKKJyyQchHI/V9SgUgNSTAQBVouEhQXKeHbEgg638B/oauJYQAQGdiwlXHhea0+ue3UqE7BeOKRSlfmKtsZ6uFr73NuXBWNXc2TEhx9LUVEnKE1Y458opN3n2F0Hb8IAt9M4px0m5ZANmbTfhNq9o3pvTBj/hC24Xq2DDDVb1HkpfLxi00u9/S0IaoWLvXN2jNcLzkT3jL64/iNEDLoRiZrwQK5rPqSODzYvJ3pY1x1u1pKtEup5g7+aiAs2qa3HZ0UoT+egfNsYII8REASCYECZMbt7yBeuwk54HK0NS4McuO9+3oWB8sJnH2ALm0ygR73DvZDqzYJI10w6hNT09hZcMh+WqeuMvM9Nro68VrLF7vVn5SJXdmFdPi2jF8FGikg+qA/Tg2PeWn7kU4lmyz/LVmLl7X55VIOcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWpKRVZncTVIM2dJOHJzbW4wSm9pdGZHUGlsTGtaWDFONEFsUlE2eVAyRVV4?=
 =?utf-8?B?SGlVdXQvT2MwZDhCRmRUNW1ma1ZCeDlLdFNtK1gxMlhLNUYvenNCZEltVUh1?=
 =?utf-8?B?RVFrL3lHazNFRUNQRy9Oc0ZVR3JQNDdlNEZRNGE2dXlnaTl3ZjcxQnhYS21H?=
 =?utf-8?B?dGduUUVqNWcyMnRmWUdaNzdxMVRXRXgzVUNMMzJSRW1MdEZxMnkrTUk1REhV?=
 =?utf-8?B?Y2RYMkFIVC9za0lLRS9LVUJnUTV4SCtjVlFMbXRKb2hsVzdmazB3YkR5dndL?=
 =?utf-8?B?Z1NmM2VxcHFnWHdrSThuRTZQY1FPdlFQM3VQQmtmbWtidHp0bTFweFlEQi9j?=
 =?utf-8?B?RXJydXUzSzZXakZieVNVRmtTY3BkWlJnd0Z6ZjMxREhYT0N0TXZQSmJiVWx2?=
 =?utf-8?B?bnMyY0tHU3NuSzVWdi96SHdOTmtrUEdmMjhoYkRQRHQ5TE9XclQydGJxS21Y?=
 =?utf-8?B?WUY2MWJMZWFvc2dzS0xneGxoRXNpWUYralNMZkpHZTJsWStlUU02S1RlYSty?=
 =?utf-8?B?dXZsMFZxWFluRlhiei9LRUkyOERpekhUL3hhdjY1SWNWekZpYjZiUjl1RVpZ?=
 =?utf-8?B?Rm9wWHlwQ0RrME1nMTBHRzVKeitHN2VZbDdqbnJaVjBqSXJiT3FzZW5kdlJi?=
 =?utf-8?B?dkxjcDBxaldYbnp0SDh3SWswN09wdlNzOGpTZDFjcWljaSsxRUJTUjVMTnB3?=
 =?utf-8?B?ZnlweHIwaUwrOU1qcUhaL0dpZVRWVG96UXNtbjY5SHJ2R0V5RjJUTll3eTVF?=
 =?utf-8?B?czAwNkY3dkZsMUkvZjJBVjZ6V25BZFk5Mk5CZHFWMTU3dWFieFJialI5Mkx3?=
 =?utf-8?B?ZmR2bDcyUklta2JQSXhtMHRubkhLdHV0NWRIQ1Y3TVRsM2c3ZTRIVGJueWFX?=
 =?utf-8?B?TEYrL2VtS2xBTzBOMGlaRkY3dHhwSXFGZlJESVA4cXZ1TU9NRjRKZjRnWnJk?=
 =?utf-8?B?dnJjMk93SEF6cWxsNTk1U1BzZHVhRnlsdE1kaUZkaVp2NjFoNHJURURueG4z?=
 =?utf-8?B?R2pEVlh6WFNVWmVvRHlpR0VWWEhLWVVQZWVkb0dCNGFMamw2RVlTZFJqVEhF?=
 =?utf-8?B?S3ZrREs2K1NhTks0N0c4NlhVTVRpOFhhTGFuUk51STRnSmtvU1BCeGxTZkdX?=
 =?utf-8?B?T0lvQUxSTkhwVmEwSEFleUZZYWRlL0F0T0N6ZTRpblV6WTBveks1b1NCTEJE?=
 =?utf-8?B?azRYOS92TTFPMGlKWkJpbkx3Zk1Nd1pCaVd2Y1JPdUJPUC9UWWc0SmdKNWJ5?=
 =?utf-8?B?dDlqQWFXVFIwVlYwTkdReW96TmRDOU9HeUlIQzhOL1Jhc2R0dDd0aXYwQXI1?=
 =?utf-8?B?RE53UysyWXprTm1MV2t1QkRVSzA1STVWNk1USWFUUEtJaDFFT1Iybk1NMDhE?=
 =?utf-8?B?ZEdGcFBFVitHMWhHSVBBTTJDNzFrU2piY0Q3aXcrb1d1ekF6dGZuUHB0STd0?=
 =?utf-8?B?bnBVZmpEVFEwTUpaaEkvN3NRblpOUE5MVVB6Y3lNUEJhOC8rbGZPbVdiUFVH?=
 =?utf-8?B?cURrckJRelNQb0l4YTJPL0tVdTNZQnFVdWhNRGgzenBNeWhUMkVLQkIxajMw?=
 =?utf-8?B?K1IzZTVVa1g2YjVSelo3SVVHN1Jnb2Zwd2VaTDFoUS9PMnFyS0tCbUJ2amd2?=
 =?utf-8?B?U0tYdVFuaVZjSHhNUDhrOVIwYytPaHBzZHlXb0phYTF5TkVneUc5dGloOGRn?=
 =?utf-8?B?dWdUSmcxMGM4ZkpqZnJieGlXSkh0RjlndEE1cnFwNlp5YnNSSDdRRE1HYWpr?=
 =?utf-8?B?QU15U3RzeVBUdGo4OW40amttSjJ1cjlrNFRlQzZBLzhZN0xpU2Y4bzhKMURV?=
 =?utf-8?B?MnkrSStxU2hJdGJkQ1QvYXFDSkoybTZJMW4xVkprNFdQSXFFaFVvOHVJYndi?=
 =?utf-8?B?QmMyanFRajdNaGladTIvYk5OR2JCeFlCRXRyaDVnVWJNSmtZSEp6R2dJY2cv?=
 =?utf-8?B?RngwaVNhUTgwbVE4NjRHZjdBZy9FcUxza2hvM0lWa2c0Q1EzU25vblRWTmFO?=
 =?utf-8?B?VjRQSFJZb3didEUxVVZUcHR3QkRUNElja3JmSHZoT0lOTEhYbWlLWXZpQi9O?=
 =?utf-8?B?NjMreGZkR01ENnpsZmRLcE4yWVhnMVo1eU9rUCs0Z3Q4M0xmN0tmd2Zva2FO?=
 =?utf-8?B?M0tNaFJSMm8zV3FQVi85dUNwaTEyQno1U0FFb2kwM1VCbytZNHkrK0RrcSsv?=
 =?utf-8?B?S3dLQjZYOHU1SExvVnI2K3hRRnY5VnZXdlZMRVhlYzBUYWJ0RlN3ZDV1VHlW?=
 =?utf-8?B?OE9KK0pVK1cxTUZmRzlHQnZzTTRJYTRaRW1xWE8wTDhXTW5EL3pjUlhLRTJy?=
 =?utf-8?Q?NqFeo9OtQrU2OZ011A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87aa156-0c79-4bb0-b7c8-08df05515f42
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 22:11:55.9958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh9k9YBjQybC3dglYNUCKv88gvNgXXm2qhDVRWh1apqpub4RIJRv6zt21OMvdR4Yzs6aOk5UDnM6UAyqy7U20g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

On 8/28/2026 4:57 PM, Dave Jiang wrote:
> cxl_cper_handle_prot_err() hands bus_find_device() the 'struct pci_dev'
> where match_memdev_by_parent() expects the embedded 'struct device'. The
> comparison never matches. The lookup always fails and CXL endpoint
> protocol errors reported via CPER are dropped without a trace event,
> leaving only the root port, downstream and upstream cases reporting.
> 
> Pass &pdev->dev, and rename the callback parameter to match what it is.
> 
> Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/ras.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index c91db125a971..a2c7c9479f2b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -70,9 +70,9 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
>  	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
>  }
>  
> -static int match_memdev_by_parent(struct device *dev, const void *uport)
> +static int match_memdev_by_parent(struct device *dev, const void *parent)
>  {
> -	if (is_cxl_memdev(dev) && dev->parent == uport)
> +	if (is_cxl_memdev(dev) && dev->parent == parent)
>  		return 1;
>  	return 0;
>  }
> @@ -108,7 +108,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		return;
>  
>  	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> +		&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
>  	if (!mem_dev)
>  		return;
>  
> 

Looks good. Feel free to add my RB:
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

-Terry

> base-commit: 751627a8c5cde68e0b396126449749e8bfbe592d

