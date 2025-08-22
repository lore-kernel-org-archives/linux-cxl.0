Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B14216E26
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856776; cv=fail; b=u0XexawiEbCI/mNAU09ElgW23IxyqFwxoZ1IUfOP8mEYBLPrO0A0mxWPOwKAY8xO+zJGKJyjciFrojNXGtAO9fIfrWI22+lAfjOhSlWoySKNn9hiG44glwjOE3nLAWc2fOEY0NloNAY0T2q6a2I8xF83PGIOEqBIX8JW6mYzwgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856776; c=relaxed/simple;
	bh=CdKjDbI2OmxfEoCQHQxnKodn0uto8B/5CnkjB9bWv9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=djHD8fQMGqbqvg4wUkoWSy6htXVKmUj+g5sIWGrQ4ONipWX7OubC+RBjjMMcRlGCPv9+ZFd7rl9eGXsqKgisU44B0LaigQOs3kcx/eQ6ctDe/MP6QiwpWEGcVEGkwGTkovj4mf9ic+CMlq6ahwBMT00fYCqiNAOgFIlmyTrKDGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DFgdGJ9g; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DFgdGJ9g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIvHOvCX+zXlGFzR9x7IT1/I58QYx/QUbSMlWvhKEQ0THE73dz0XclfakH5isbqF17d/5Ok7EBFZ4hhBKoFfPCfy4vOjnUWQ/Bk3zKOJS4h7Ykn5Su2m2dpBtSIHNk0p09tA32LZR997lD815y6RwA/INl6UjNFzPwVb319teceLkV3UHQTK6qmX/P9zFoMuM64FMUjJZYw6MtzvClOHwLk7ducEbPDjxG8Sr8SXEUJhm1U9sI1z2myPd3iC2qIEP1k/rr3CRo2jrtKLvrg2fvVzoSHjc7IZHxVLCSf51CQ15A09hPG4xdlyESIxJRfAYmd5iBeRpqIr/OMdCgZ0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifEVKslBzEjkXgss/0nhemQGOqhFtpQXak7u34KJ0yI=;
 b=dp/qUrQttql0uIvrbmTbR2W5Pc4wP6ssEbc3qWXq7Jty8mBlMWG0fVyzjXJZDvFiya8Iy70Fb/PF4WubGW4mDEKGfOFwBawWUUE/LiC+EHqZ1L71z7D7q84yv1GkKXO52u928ImXHfCiDKMBfGvOGbqBqKEKSkZNPxuYiw1/e994ZAdsp4THYH+xyK6pLUblrlr73XrFcLBbMexsquaCftSFLj3toa0Kn9g90k5fyZIuidtQzf5lFAt000xSqbvZF53ljt2WVHzOynboF/HosmAaevim8Ea0MSU73I73J7nPlsUHinOlqTY7RwJk+fP5wuvRL6IVqwWyYaTToLYaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifEVKslBzEjkXgss/0nhemQGOqhFtpQXak7u34KJ0yI=;
 b=DFgdGJ9ggaSF47YPX1Dou3tKFHUmsSJrxCfotWvlCNeozJycAvYIXO1hAhFTTkf54ich29Wok+QcdtQNG3W5zVMbm2es/B95B664BMvgPjzUSaMOHKGAe9QAKgrZ+Ukpk5ldazbHsf9UYjly5q1Au6izXnj84lIYShYG/nlfvCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 09:59:33 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Fri, 22 Aug 2025
 09:59:33 +0000
Date: Fri, 22 Aug 2025 11:59:28 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
Message-ID: <aKg_gBw1Q29BaXdp@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
 <aKXCid-m65ou2WVV@rric.localdomain>
 <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 286c1df9-bf87-45b0-7b03-08dde1629818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CerhJG6UUf3XO/IS5h3O8CkKIVNpJnFySGugxL0XILiQnm8L14ZXkZsD/mdD?=
 =?us-ascii?Q?rmgC/DhbOw3caxHlSIHIe4cNlElz1nKP8lP6b1nk8YuRJBVQyZ0UEzc6mKSd?=
 =?us-ascii?Q?fC6gpt76OuoEnq8KqEa0WWOsWMngCasMRd1oU/mJtIWvMSFpZ3nVk3nrPX+k?=
 =?us-ascii?Q?gY30B5cBO5YNgrT76554/yA0H4CXzzWH5vepArJwx54tGRZc+PIWj5bzZTnt?=
 =?us-ascii?Q?rrZb019skUT0QsLxkCa+NM7IJ/dmQWUI7UkLGZIUbz+xcJPuGn/dDeSVC+bZ?=
 =?us-ascii?Q?xhXTHEq87AfENpc3EA45jgJJMuM89yQuToqrK2T8/FDNppgVRAhEQ/9mh1WG?=
 =?us-ascii?Q?K2RJ0QNbjHjSmA4z55kzEja5iOcpKo/xPlZJ8iPXbGpNSdZFU9dIUH8HADKX?=
 =?us-ascii?Q?SDnXIl1zA+yTt1KvwKD8nBqmMDTxIW0hW5oSQwP/Pc6E04aLY3Y9T8JwNyVA?=
 =?us-ascii?Q?37ElFA8BHoPU1OaPMXGGwDbROVeUryiwav5Pr1GAzrYtjSL+eb6IA6tVOKaF?=
 =?us-ascii?Q?ro4/5Hpxu3afQ00+BfMcVUFxkSIGUonFxiA7GfiRdXRrZW9puYY711nVWu4l?=
 =?us-ascii?Q?n3yaqb0SRd8yxCvw5dgS7QOmsyhMNEhVpYOSb4mLuBNhyYQ/S4jJcVDKZbU+?=
 =?us-ascii?Q?E0BtstP7SI1xTa6tToCOwqrbKSmjl/Hv9LWbIb3RzVP/sspvRz0Kg69KvF2j?=
 =?us-ascii?Q?1QEnSX9De3sKGEgu+jm9vP9TsLXyOrWkVAH0Fg22NzziD0z0dOkf9KZvkxBt?=
 =?us-ascii?Q?zvqzium91QjqBFoqp2iyXf4J1XsrV6eaa5dhVBtjMnZGSdIKxEGIb5QC5A72?=
 =?us-ascii?Q?RHWJRwpdy7k2V7XW3W96g2eDozbNQ3U6COukPVgnu9rD+a/+ITvr/ocmBrMD?=
 =?us-ascii?Q?ZxJcagEirKk+4Im+0wNFQ5NkbGnrSp6r1VB+cmYdQIoBpPGfLzGK/dIG9Tub?=
 =?us-ascii?Q?v6TqpWytE0EtLDa2M2kSyzLFhtm12FeNbuiZoPF4SS5L3LzEcXE4liaegg86?=
 =?us-ascii?Q?0WxrCA7V9cvZS4PRUAhyfnShGvndYAl67kQ9hniq6qfwUSExSgljxpJUpVeI?=
 =?us-ascii?Q?FIcZZAbp8rWs28Ej49zgLelsP9YdiMxgz72e7cobH0wccptt3ZKGohDBlM4C?=
 =?us-ascii?Q?bg1K/0A2HJ+JqxeU4UhRXiZGfPd8/9pofi8cd9jURuQmE5I2HBf41M2hQLyD?=
 =?us-ascii?Q?z1+SZ9NWf5Vwx10YFL5d17iajYyT8lEDVWFt4RRs0ZHYNeGbIMR4F3Hebhc6?=
 =?us-ascii?Q?SaBlRVzeUbADPe5UmXFVQg8NO8fFOKoDHkwGE6WTBbP9XboQWVHMV9qQxCPY?=
 =?us-ascii?Q?ZnEEWEolhQmCTzTVTjNqCm23DxRr7uV2heV7CgJyalZo3HWpZZqhvKO64wnY?=
 =?us-ascii?Q?6Xavzvy4nt3N24+tUh8rg6tWujqnBa42XVtJSCk+FCURTJG3ER4rEdhHi8wo?=
 =?us-ascii?Q?vuSTQoPzBo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T8hNLNieuDANDbHkg/3YNQeuMTaNK9mzfQiTsio9hw9ZeZUCMvZf2orYOYPa?=
 =?us-ascii?Q?v00F94ihZLIzH89NzrD2U0jQDOZW5FE2GpZoKZjw0pS7h8Gl6sjBM/mbRXkG?=
 =?us-ascii?Q?Qvd/lGGcPBiEyUHQMSGk2D96XAPJJJB3RGf1dFai2Swgwwyw8uq7XxTqX99y?=
 =?us-ascii?Q?jsHx/U48KC0uv+CTHRbVDTT1G0mQmmV6Va5nDu5Wmx/UULEQiVN+ymAULakP?=
 =?us-ascii?Q?wSb0gw2wV2upPzDMxlJs1ZtKCjmvY4n8Gvayh6lx/Z55NtkjyIw62wIekm04?=
 =?us-ascii?Q?CkZ5HaG02E0UmnI0JjulYyzDM9fH+D4+iF9U2gKlBsHMfOzNPD8FJYFNBCMU?=
 =?us-ascii?Q?T0p0A7kzEGWIddnqslYE0l9Q/U/yQQ0Pj8kb5Cb4ApOtahf8Auk1iIkbhZEk?=
 =?us-ascii?Q?s1dOy1NwrFnHO2moUTNiwMPFNQRYw5YiJpUsEcEr8inG7X+UDi90B2ku465I?=
 =?us-ascii?Q?4+QDP+59HQ5wM4BvUHn5A4+Pmlz799rGKep7ZGJ8w5YMaA4embguAu17EaXV?=
 =?us-ascii?Q?R0XBK35k+1q5ucbiEuflr6OtkxoQKr1bx1DVC30HeKmX4md3QBwfFc4ZuNb/?=
 =?us-ascii?Q?uDxI3snQ+OMKEMhozA8Vw4XlFM8/0OKG5KtXWpNVKjtN636FYQDlMUZUM1DR?=
 =?us-ascii?Q?JqcltxUF8Sh/a8VFVsx/4BFCk9XQYOPJJXmBINa4ksA309S/1nQgi0q0qBl7?=
 =?us-ascii?Q?L5BUCDMC1QqHzGJaGg8fP9fOzUXnSVYg7h80leorwSrHAvh++JUCrwNfo8li?=
 =?us-ascii?Q?aXFRCl/q9H4qkAnTeFZYEY0V8anXqOGcZD+qS6Xz7Yn5kXKrhJqxDbRgtPHx?=
 =?us-ascii?Q?v2QU/t5JPob7FkS41VY8huL4bfcfFdiPAPb6aUFokHedO3wqMI+x2KWS3aML?=
 =?us-ascii?Q?LFPUoYAS+jsTZcLvALwB2BNaiGRjTsD6aRmFYjfcGOcxKCx1mUlN3gDSXz8n?=
 =?us-ascii?Q?/ksT9ygRts/IjXGTqPLaNR54Q3VQ9sRihWEziEqe/7YD7VbWWpfznT3GZA0l?=
 =?us-ascii?Q?7q27QpkFJwKS014ztMtZDDfWqEFemvYa7gzr+GDMmhIKK/uYV+CzPbFlV1oo?=
 =?us-ascii?Q?jEeMg03ZLJ8gb/YVoS3WPaoZ/Hjf/lWikT10usbPbibb6FLtcPFtO5WELq/A?=
 =?us-ascii?Q?a1I/1JCVt7wAMYuCNWye+oHirGev4i+Zcoi4yMzEIIJuKGOSQwCUztxWCf6E?=
 =?us-ascii?Q?N/NY6W2Vad7KgalU00OrPhpgjhkiQsvRLZ5XNozYL/vIYZJpBKLROD/FRBWC?=
 =?us-ascii?Q?xzZP7b3DtFkuSLPIcCsxAAp9jwRWlb9y9oZKR1pq+JHG11DEi3YdvWpibg9C?=
 =?us-ascii?Q?lVySzGJ91dML8E3PbIcTK0SI9D778CQMk56SlmFXoNYascgfkwqNUIXvBAXC?=
 =?us-ascii?Q?DfrA2iBfrQEhd/1VcQRXeu/OC0OSxVbnAeZ0J5LM+ZsQb5txGgHU7REoA9XP?=
 =?us-ascii?Q?ySemZRBtJiVLZVUpiiXPdsoKu8e23V7bde3oHhKNNKtpNJ6c/gD/uISr5dwl?=
 =?us-ascii?Q?Scz7JZKGaFUiJkqHFpqqKb9sOlRClckP8ekwCL9zybqulCaaaJDZWB+ek0kG?=
 =?us-ascii?Q?HThUc87vlSrMcTMAAIobBClGdIxTMhm3V30a2PH4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286c1df9-bf87-45b0-7b03-08dde1629818
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:59:33.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ep50vqmkQHmpTgOQyBPS1Lo3ejK/vpWwIsv06r4M8XmDrt4AXFt4MbQORGFYhfdaIFKcMVYnVW+vSSB7YL3xMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188

On 20.08.25 08:20:04, Dave Jiang wrote:
> On 8/20/25 5:41 AM, Robert Richter wrote:
> > Hi Dave,
> > 
> > see my comments below.
> > 
> > On 14.08.25 15:21:45, Dave Jiang wrote:
> 
> <--snip-->
>  
> >> +	if (IS_ERR(new_dport))
> >> +		return new_dport;
> >> +
> >> +	cxl_switch_parse_cdat(port);
> >> +
> >> +	/*
> >> +	 * First instance of dport appearing, need to setup the port, including
> >> +	 * allocating decoders.
> >> +	 */
> >> +	if (port->nr_dports == 1) {
> >> +		rc = cxl_switch_port_setup(port);
> > 
> > Can't this be done with port creation? I don't see a reason doing this
> > late at this point.
> 

> The main reason we are doing this is to move the port register
> probing until we know the CXL link is established. Otherwise when
> cxl_acpi does probe and calls add_host_bridge_uport(), that
> devm_cxl_add_port() can trigger errors if the platform BIOS enables
> PCI hotplug support on Intel platforms. The error messages "cxl
> portN: Couldn't locate the CXL.cache and CXL.mem capability array
> header" is observed. Essentially we can be trying to map registers
> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
> that got pushed out, so did the decoder enumeration.

The code suggests the Component Registers of the CXL Host Bridge are
not yet ready. Is this delayed after the first Root Port is connected
to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
(CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
the pcie config space, which is enumerated not before a CXL endpoint
becomes active. I haven't found a spec refs here. Please explain.

Thanks,

-Robert
