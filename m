Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEC515961;
	Wed, 14 Oct 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998284; cv=fail; b=BiP/XhWfUtvhnDz4p5OIK+4N7KtB4NkQeRz8jDG4Xf++B9N8V6UbxOG0zG75gy7HNx43OLIk1VpaDFxRXMyXS/1gacmlyw22oT4ISnqe5LvXTjraVKA2ojvpiCHGW1jSPz1M0rg4VT+LJCh6+zlEwhuzJup19XWnmqPtlRWwhQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998284; c=relaxed/simple;
	bh=xLDHvMmIm7qiYI6L9QQklTI4q8/ux+EG2nNMoGA/i6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KVZ/cMl+1d3mmKA1jcHL2OS0tRFpPp3pUIOlj5RN8kgmFL0pGooJTs7QQnV5ukQfPpadY79msXlJEQdBx3XMUQrWAPWTefDh5A7O8vzZ7JV2YrgQQFsTxLR1FJcPeSbvJNR3Qp51VG7VjC1LW3x/4KZBGtetxJJoPwPjhYZhEms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MOujR+5J; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MOujR+5J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTXuE5OGFAGbKB7enZDyfhFmy+hq3Uy3vbL6gY/MHQK9rti3dQwP0uUlQKI69JW7RP875dKhiWn8zdG0DSus4pvMDrwX60guiZ8TJ9XlNF0eal1h9TBGKxQAWXvkeKPS2XQnxYurEeT2rpE0to2CdWdQzYrQx0vng1qldHo41c7J+sTjN+8FLGn/yQ/6mk4mQgeTbnGMXReKqRR/J5FK8RExE9qF8q8fA1Zc3csqZHaA8xMT/tVgvD+qjQXRQFhl8E7XmlL3kTI/ua/iNbKBZqZVtNfAPBmjnvGAl6G4ZH7RX0hxrZnXuYbbElfIoSmZ0mbuT4Cf0pP7CDJOWPudRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo1f0VaOAczZtS0ZybqMu+dt1db/SZzbtjLJW4am3p4=;
 b=j2SwaggVgPhzLuKgiOhkejLGv4cienDwZqK7cnpDJtx2tv3VB3EYRKX7/6yfnbso+h/XK8KlcrkLuVUImE9hea5I8P9d0V+Xc4iGQMopE2GrtRxNQ/lNcVYeh367+L4NZsnoKVRRCVUvZkJGU35GJhs+z8o3OEQoD2Y4alRSS/J63CEdg6cFaw6Bpb0TMc5EgI/R2dVma9nXIelJfX8mFJbpi7kVmSv7NF7cY54J+qhKr+0L7Q1rTsBhv/UhVjCs5NPoyRRMHMWd5tIu2WtTNPd3zsYTAXITWZPTs9mlGEhRkHMBDBqn+Rw3xNMZbnfjItj578mBQMeQq6+kayGuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo1f0VaOAczZtS0ZybqMu+dt1db/SZzbtjLJW4am3p4=;
 b=MOujR+5J52jzziLGMSArYYJV19luTC/3614COmVHiNxlAxG5sPPZwUHqrlVrlNbkoiRD3awsJ0vlCMAkxCt0q+n++W5WnHnzsRXLrp3P8uaqGZ9z4PgPmJEMG7XPWOtC6ZdTPpzpY6epaUVa6RksgFTXyU0ZYG93ND8tc3R+1LM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Wed, 14 Oct
 2026 17:17:55 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 17:17:55 +0000
Message-ID: <fb16beb4-5816-45ed-ad74-3338ee698791@amd.com>
Date: Wed, 14 Oct 2026 18:17:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/3] cxl/mem: Separate provider registration from
 region attachment
To: Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com
Cc: kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007090540.43817-1-icheng@nvidia.com>
 <20261007090540.43817-2-icheng@nvidia.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20261007090540.43817-2-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0302.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::19) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 140a2e80-1ad2-422a-1503-08df2a1715af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	aximHsJOAFjbvkj8JdCJOvnhXvCvTk9P9psd/lMsfBeu/Sewu/df8eBwiSWLkY1rdRh5xQ43gG347MQr5i+3SLKVrRlRN+kQqyijpLCh570wMd+tmgdW842IapJadnaMOtOKVWqICCW7c6SxXAaphsms9n6KJfQUG+p7A86ksCZ902YW2p4vSU5KYptPMSiOEkxosXHc68efXTfLpJAYbJteIrLIkodkpPfgXAbZY6ZAx5Lpl+h5qJcfGrTnEwiEhxltHDVv2Uz4Ae93Hgbl7TQ9IGB6JIU8SpQFXNfTTeuVhoyWRfpLHjB1c57LVPOIoKRJqyL7YDXt5iqWe8YhUduomOwD0dpH6WsbTOfrfr8BhKxsD6ZQvRqvXwa9vXKBMfdVEOg5fYUFM9Ga6XCg02gommKVbIULfQcI3d5CFY0xgpXeg6aQymIpXL71+cK7fT0bvbUkk13qJ4wpaM73nWUQ7QNzFwVNPmY57Ca9bYh9beJjpJB3PZVoIkZny7ZLr2+RD9v7OI4ekqUHX25rt7gAjcepNUoxa4BYMx4KZGMChwr4kDR5y6sOW2xUAHvhwxsUcx2iV2FdR2U8P2VUXLfBG9JUqjCDIMGHuqTXBjjxg2mWD7s+UKrxkUGL2uuwaNJ4GsB/nOHrmpJgVUNwLpVJ3/noXfdWEr2pLgvLupg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTVvNS80OXZoQlQ2b29JVkNlemx1U1FoaHhnQjluSFR4TCtvVDY5bVFLNDRS?=
 =?utf-8?B?d1daeWV2V0F3MUNhdTlzOFZpbmRMQ1dpOU1QTHFKQ3FjK3AwZWV6djBKOXo4?=
 =?utf-8?B?cngxVzBhS1F6eXJWN09RdlVrVmxMMkZKUElUdndyc2dRMUh6S2VxOHlBUitM?=
 =?utf-8?B?QUpiQ0k5UWR6RFdWeXhpcUtvbUZNY0ppTjJVT1UxOXp2Qk9vU2gzbkhySlFV?=
 =?utf-8?B?YUdCMGFsbFVjdXdQWjNhbkQ4NExSNnNyS3JmSEg2Q3BpczE3UjVKaE8rNjBo?=
 =?utf-8?B?ZWgvZTRjSjZZSkd5L1hpV0JsOVBkRmVkdzZObVVCSHFxY2V6cHR3a2xZYkJJ?=
 =?utf-8?B?M21DRmlwazRNN3l0bGtIZXBCWEh3VXNhNS9XVGtBZkh6WTVKOGZJTzBTWDYz?=
 =?utf-8?B?TTVEUVdwN3lLaU91N2xjWEU4MEkvVzVDazlrY3A3d1FlRmNSeVBPU3FQQWxi?=
 =?utf-8?B?L1d0ek5CTDk3RVIva0NxendrZVRTMFJkcmdZalB5OFRCcHY5VUVPeU5iYTlz?=
 =?utf-8?B?NmxrU3dJWUNoZ0JLVWR5eXVNVUNZeWV2M3UxSGNTL2JDRDIzMG1PRW5XcHFn?=
 =?utf-8?B?WktCZjdBUWxvWnMwZjNYdVIrdmtnNFppajhkYmVBclJtVzZqUHZUSWhINzJ5?=
 =?utf-8?B?L0dWcWRGcUdtOXBRdDk3T1VJYnFIZUFEQjZxelRxU1MwSGxSYzl5V2hSUlNz?=
 =?utf-8?B?WHZyMmhrSG5zZSt4WXlrREd4RFh4WGtjNFVmc2twU3BmNGlrVGQ5eXkvR2FE?=
 =?utf-8?B?NEhscXJZNTZTMmNmU3hCYmtpUkJ1clpNbWtORW1tSjJlcnRvamtQekF5UnRx?=
 =?utf-8?B?U29GakxtZnRsRWx0T2M3ZVpxZjBWbUtXVVFBNHhXaWVFOVVhcElxa285Rm50?=
 =?utf-8?B?TVNvQUhjamcvYzArY0UvSEFTa0V3Nkt4eDVnUGtiL3VxMkpzLzlxUDFUYnEx?=
 =?utf-8?B?MXJ3TUxxazExMXd5dHBVWGtEaVZLcFF1ZkIwL3NCZ1R0WURSNmc3a0pla2ti?=
 =?utf-8?B?bUMrT0RydGJqNy83U2I1eGJYMTBCVnMyNmJubWFjbHIrM2ZwY29iUVhNS1hK?=
 =?utf-8?B?Ull5ZkRYSlVXT3M3ajgyejBzZHpDUitGWkRncnJ4WDRBaGtZVS9sS01jUDNn?=
 =?utf-8?B?d0Roa3F5NDVKZUk5UUpxUGZ3R3I3cC80Zlp3SThuOHIwK1Q2WERBdkZxZlNZ?=
 =?utf-8?B?b2pQbUdjbGZtWWVCeTIvNDhYTjMxNG93Qnp1MUxyUG04YzlUcXFoM0lWcUw2?=
 =?utf-8?B?dEs2VnFrNDk2dENTREdQTnNWcUI4am8vZ2RGdFlSckY3QlpiSzNUV1ZkWGcz?=
 =?utf-8?B?MTczSEc0SlcvNVVSTjFydUVSTFMxRFRKUWE5M2xnSXg0emtibFJEd3V3aS9X?=
 =?utf-8?B?a3VZTEpLS3BFei9oWTJ6K3BiZVp1dVU3K3pzNTh6WlJGVHBCd3lLMEppKzI3?=
 =?utf-8?B?ODNNaVBoNEFSUjcyOWU0UFJsb3dCV3JZNERZc0JWWUJYNy9XeEI5cUVDWkxH?=
 =?utf-8?B?ZklHZm5WKzdhRCt6MGU4NXgxYXl4UitkUzgrakJzREQxQmlxZk45SEF1dUww?=
 =?utf-8?B?dDhYbmpKbHlPeitJTFIzQlRpK25xcDdqd3JES2N3dW9mV2FIRUxMK0h0OURL?=
 =?utf-8?B?KytjenZNSC9jL0tEd0pBYVRMZTJjRUxqNk1qZFlCOFU0dGpKbHBkMXZUUE1i?=
 =?utf-8?B?aGVoUGt5djNhRDRLWngyRWdXemMrZTJGV3NjSVg4V1IvamQ2UUxQSGM0SnJF?=
 =?utf-8?B?Qzd4QWdzUE5MamROQ25BaEJlMElrQTZkYkp3bkw5YjNvTFFWaGh1ak5sOWxo?=
 =?utf-8?B?bkQ1MEthQkdILzNyMkhKZUFUNGFVZDAyeUFiVUVXYXpjd2RKZ3hWcHpnNmJy?=
 =?utf-8?B?YWM2VVYvdjhHdDBtek9ScXhHUlF3dDg3SWwwNnVHTFhSOU5mNDFzT2psMWh6?=
 =?utf-8?B?NnBmNzhIWjlmVVNmSEdHM1dseEZZV2NvbktvR1lrL2hJZHUxOEpJSksyUHFW?=
 =?utf-8?B?TUNuYzJuSUpELytKaEd1Ulo2Y2QvK0pkUVBZTkQzejFkdWZYMmpzTFI3K0Q0?=
 =?utf-8?B?ZXBBMnp5azVUbFVkd0c2ekM2ZVovNUp4K0E5akhwc3ZlenYvb2d0WmJaQ0F3?=
 =?utf-8?B?emZ1ZkZGbkhqOE9qSW1TNWtPL2VZZU93N282SFl0MVgzNnVTNndKWFgvQXZz?=
 =?utf-8?B?NTRRdjFrUkZoN2EydWdXSWk5S0dsZ2hGdlRyYjU5TUhmdXlscFBGMmNsaGp2?=
 =?utf-8?B?ZklYbDZBcHN4YWVRUWY0alkyQmhETzNNVExFUzZSUm00eUd6a2J3bndEQVZy?=
 =?utf-8?B?MkQwZGt0MDlpdmk3YUwwQ2dqOEszVi93R1RmYWE2TVVhR3Zvd2FPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140a2e80-1ad2-422a-1503-08df2a1715af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 17:17:54.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz+HR1CmcN8YK42aPvdHAARI2jo1mcB9r6LLW2+IqwYrNG/K9hHFoSNDMUA4O1/ruU+VRMVs2dN9q+OeoRMWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186

Hi Richard,


I think this is good stuff. Just some comments below.

Thanks!


On 07/10/2026 10:05, Richard Cheng wrote:
> devm_cxl_probe_mem() requires a committed region when registering a
> provider-owned memdev. If FW has not created a region


This is mixing kernel parlance with BIOS potential actions like setting 
HDM decoders.


> , registration
> fails before the provider can use the endpoint topology to provision
> one.
>
> Make the attachment probe callback optional while retaining a non-NULL
> descriptor to preserve provider ownership and handling of CXL link loss.
> Install endpoint cleanup for FW-discovered provider regions even when
> the provider never requests attachment.
>
> This establishes the registration and attachment APIs needed for
> explicit region provisioning without introducing region creation or
> allocation policy.
>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
>
> v1 -> v2:
> - Rework the patch into a registration/attachment refactor, following
>    Alejandro's request to separate region provisioning from memdev
> registration.
> - Add devm_cxl_register_mem() to establish a provider-owned memdev and
>    its endpoint without requiring a comitted region.
> - Add devm_cxl_attach_mem_region() to obtain the HPA range of an
>    existing committed, single-target region after registration.
> - Make the region probe callback optional while preserving provider
>    ownership, synchronous endpoint setup, and hdling of CXL link loss.
> ---
>   drivers/cxl/core/region.c | 146 ++++++++++++++++++++++++++------------
>   drivers/cxl/cxlmem.h      |  22 ++++--
>   drivers/cxl/mem.c         |  69 +++++++++++++++++-
>   include/cxl/cxl.h         |   2 +
>   4 files changed, 188 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5ef0ca0694ff..7a64a730587d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4111,67 +4111,123 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>   	return 0;
>   }
>   
> -/*
> - * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
> - * simple case of single mapped decoder per memdev.
> - */
> -int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +static int unregister_memdev_region(struct device *dev, void *data)
>   {
> -	struct cxl_attach_region *attach =
> -		container_of(cxlmd->attach, typeof(*attach), attach);
> -	struct cxl_port *endpoint = cxlmd->endpoint;
>   	struct cxl_endpoint_decoder *cxled;
>   	struct cxl_region *cxlr;
> -	int rc;
>   
> -	/* hold endpoint lock to setup autoremove of the region */
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		cxlr = cxled->cxld.region;
> +		if (!cxlr)
> +			return 0;
> +		get_device(&cxlr->dev);
> +	}
> +
> +	/* Unregistration needs the region write lock. */
> +	endpoint_unregister_region(cxlr);
> +	return 0;
> +}
> +
> +static void endpoint_unregister_regions(void *data)
> +{
> +	struct cxl_port *endpoint = data;
> +
> +	device_for_each_child(&endpoint->dev, NULL, unregister_memdev_region);
> +}
> +
> +int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +
> +	device_lock_assert(&cxlmd->dev);
> +	if (IS_ERR_OR_NULL(endpoint))
> +		return -ENXIO;
> +
>   	guard(device)(&endpoint->dev);
> -	if (!endpoint->dev.driver)
> +	if (!endpoint->dev.driver || endpoint->dead)
>   		return -ENXIO;
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	guard(rwsem_read)(&cxl_rwsem.dpa);
>   
>   	/*
> -	 * TODO auto-instantiate a region, for now assume this will find an
> -	 * auto-region
> +	 * Endpoint probe may discover provider-owned firmware regions even if
> +	 * the provider never requests their HPA range. Run before decoder
> +	 * teardown so those regions are unregistered, not just detached.
>   	 */


I would put this as a description for the function instead of a comment 
here.


> -	struct device *dev __free(put_device) =
> -		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> -
> -	if (!dev) {
> -		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> -			dev_name(&cxlmd->dev));
> -		return -ENXIO;
> -	}
> +	return devm_add_action_or_reset(&endpoint->dev,
> +				      endpoint_unregister_regions, endpoint);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_setup_region_cleanup, "cxl_mem");
>   
> -	cxled = to_cxl_endpoint_decoder(dev);
> -	cxlr = cxled->cxld.region;
> +/* Caller holds the memdev lock; attach to a single mapped decoder. */
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	int rc;
>   
> -	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> -		dev_dbg(cxlmd->cxlds->dev,
> -			"region %s not committed for memdev %s\n",
> -			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +	device_lock_assert(&cxlmd->dev);
> +	if (IS_ERR_OR_NULL(endpoint))
>   		return -ENXIO;
> -	}
>   
> -	if (cxlr->params.nr_targets > 1) {
> -		dev_dbg(cxlmd->cxlds->dev,
> -			"Only attach to local non-interleaved region\n");
> +	/* hold endpoint lock to setup autoremove of the region */
> +	guard(device)(&endpoint->dev);
> +	if (!endpoint->dev.driver || endpoint->dead)
>   		return -ENXIO;
> -	}
>   
> -	/* Only teardown regions that pass validation, ignore the rest */
> -	get_device(&cxlr->dev);
> -	rc = devm_add_action_or_reset(&endpoint->dev,
> -				      endpoint_unregister_region, cxlr);
> -	if (rc)
> -		return rc;
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		guard(rwsem_read)(&cxl_rwsem.dpa);
>   
> -	attach->hpa_range = (struct range) {
> -		.start = cxlr->params.res->start,
> -		.end = cxlr->params.res->end,
> -	};
> -	return 0;
> +		struct device *dev __free(put_device) =
> +			device_find_child(&endpoint->dev, NULL,
> +					  first_mapped_decoder);
> +		if (!dev) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"no region found for memdev %s\n",
> +				dev_name(&cxlmd->dev));
> +			return -ENXIO;
> +		}
> +
> +		cxled = to_cxl_endpoint_decoder(dev);
> +		cxlr = cxled->cxld.region;
> +		if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"region %s not committed for memdev %s\n",
> +				dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +			return -ENXIO;
> +		}
> +
> +		if (cxlr->params.nr_targets > 1) {
> +			dev_dbg(cxlmd->cxlds->dev,
> +				"Only attach to local non-interleaved region\n");
> +			return -ENXIO;
> +		}
> +		if (!cxlr->params.res)
> +			return -ENXIO;
> +
> +		/* Only teardown regions that pass validation, ignore the rest. */
> +		if (!devm_is_action_added(&endpoint->dev,
> +					  endpoint_unregister_region, cxlr)) {
> +			get_device(&cxlr->dev);
> +			rc = devm_add_action(&endpoint->dev,
> +					     endpoint_unregister_region, cxlr);
> +			if (rc)
> +				break;
> +		}
> +
> +		*hpa_range = (struct range) {
> +			.start = cxlr->params.res->start,
> +			.end = cxlr->params.res->end,
> +		};
> +		return 0;
> +	}
> +
> +	/* devm_add_action() failed; teardown needs the region write lock. */
> +	endpoint_unregister_region(cxlr);
> +	return rc;
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..8c050bc308bd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -97,6 +97,13 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>   	return is_cxl_memdev(port->uport_dev);
>   }
>   
> +/**
> + * struct cxl_memdev_attach - provider ownership and CXL link requirements
> + * @probe: optional region probe callback, called with the memdev locked
> + *
> + * A non-NULL descriptor requires successful synchronous endpoint setup and
> + * preserves provider ownership even when no region probe is requested.
> + */
>   struct cxl_memdev_attach {
>   	int (*probe)(struct cxl_memdev *cxlmd);
>   };
> @@ -107,8 +114,8 @@ struct cxl_memdev_attach {
>    * @hpa_range: physical address range of the region
>    *
>    * For the common simple case of a CXL device with private (non-general purpose
> - * / "accelerator") memory, enumerate firmware instantiated region, or
> - * instantiate a region for the device's capacity. Destroy the region on detach.
> + * / "accelerator") memory, enumerate a firmware-instantiated region and
> + * report its range. Destroy the region on detach.
>    */
>   struct cxl_attach_region {
>   	struct cxl_memdev_attach attach;
> @@ -116,12 +123,19 @@ struct cxl_attach_region {
>   };
>   
>   #ifdef CONFIG_CXL_REGION
> -int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
> +int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd);
>   #else
> -static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
> +					   struct range *hpa_range)
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd)
> +{
> +	return 0;
> +}
>   #endif
>   
>   struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 3959ec963026..aa08d88ab104 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -172,7 +172,10 @@ static int cxl_mem_probe(struct device *dev)
>   	}
>   
>   	if (cxlmd->attach) {
> -		rc = cxlmd->attach->probe(cxlmd);
> +		if (cxlmd->attach->probe)
> +			rc = cxlmd->attach->probe(cxlmd);
> +		else
> +			rc = cxl_memdev_setup_region_cleanup(cxlmd);
>   		if (rc)
>   			return rc;
>   	}
> @@ -215,6 +218,68 @@ struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
>   
> +/**
> + * devm_cxl_register_mem - Register a provider-owned CXL memory device
> + * @cxlds: CXL device state to associate with the memdev
> + *
> + * Establish the CXL port topology and endpoint synchronously, without requiring
> + * a committed region. The provider retains ownership of its memory, including
> + * any firmware-discovered regions, and must detach if the CXL link is lost.
> + *
> + * The parent of the resulting device and the devm context for allocations is
> + * @cxlds->dev. Returns the registered memdev or an ERR_PTR() on failure.
> + */
> +struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev_attach *attach;
> +
> +	attach = devm_kzalloc(cxlds->dev, sizeof(*attach), GFP_KERNEL);
> +	if (!attach)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return __devm_cxl_add_memdev(cxlds, attach);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_register_mem, "CXL");
> +
> +/**
> + * devm_cxl_attach_mem_region - Attach a registered memdev to its region
> + * @cxlmd: provider-owned memdev returned by devm_cxl_register_mem()
> + * @hpa_range: CXL.mem physical address range result
> + *
> + * Attach to an existing committed, single-target region. This does not create
> + * or program a region. Repeated attachment to the same region returns the same
> + * range without adding another cleanup action. Failure leaves the memdev
> + * registered so that the provider can decide how to proceed.
> + *
> + * The region is removed when the endpoint detaches. Returns zero on success or
> + * a negative errno; @hpa_range is empty on failure.
> + */
> +int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd,


is this devm prefix required here?


> +			       struct range *hpa_range)
> +{
> +	if (!hpa_range)
> +		return -EINVAL;
> +	*hpa_range = DEFINE_RANGE(0, -1);
> +
> +	if (!cxlmd->attach)
> +		return -EINVAL;
> +
> +	guard(device)(&cxlmd->dev);
> +	if (!cxlmd->dev.driver || !cxlmd->cxlds)
> +		return -ENXIO;
> +
> +	return cxl_memdev_attach_region(cxlmd, hpa_range);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_attach_mem_region, "CXL");
> +
> +static int cxl_probe_mem_region(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> +
> +	return cxl_memdev_attach_region(cxlmd, &attach->hpa_range);
> +}
> +
>   /**
>    * devm_cxl_probe_mem - Add a CXL memory device and probe its region
>    * @cxlds: CXL device state to associate with the memdev
> @@ -242,7 +307,7 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>   
>   	*attach = (struct cxl_attach_region) {
>   		.attach = {
> -			   .probe = cxl_memdev_attach_region,
> +			   .probe = cxl_probe_mem_region,
>   		},
>   		.hpa_range = { 0, -1 },
>   	};
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..3019e3ea5f09 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -224,6 +224,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>   						      sizeof(drv_struct), mbox);	\
>   	})
>   
> +struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds);
> +int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
>   struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>   				      struct range *range);
>   
