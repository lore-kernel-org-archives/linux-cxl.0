Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E919E968
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785483870; cv=fail; b=MyBK+7ytcAQxE20dD0t99Uk63odvpljV3TFEOJmZ+9xz6WEm749TT5W5LIRVbVSTT0Dv68i8gnTFok6D1XanPQNtLammVlKfB5kJJxcl+i5vE2kz7b3uo33/82amfRQ2F5ITLIIgQJKKkUtBLuljFDjdgWVxsbLyHQ+3/jaMPMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785483870; c=relaxed/simple;
	bh=784wOH4kAgwSKJF18Ubz7c9XealF3KHT6Dh3egJu4ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pNUk3pJUNYQujtB17kHlkbxJySFGLGiZ9MXXTY4zTas9Hr/+uVkPe7EH8QmX4PLT71i8ZGeTU2spoZQjSxslw9Wv8I8jcf7D0zn4URZ9nuikg7FoGlq6gEy88qmqs1wUxx/3uYSCSQ7fXdZdEn9h+eqPf7gCsuJhw0FFm7hp/y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gxUvUmjv; arc=fail smtp.client-ip=52.101.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gxUvUmjv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRICO5Zpxf5sPT5NfgZ9Ctp8BAqKQPTxDOtUzcT8qcN2iAgeZBLcCEs/1mmL+7Deh1OehrORBtmDE/hL/+JbJ9ApLCKw8X87RNMdMVOBmpzlGCLXpAcqbnhTaLwPrQgc+2yDw9y5/VZg0IKVO3O+nh6UPuR1YLxvOGBmo6haOwxu/z9jsnqBPuvZgUlibVBNN4m+fr2uo4azMFaCtur2far5KXdy9jNpJoa0DdQ74phDDCY8xDQWxFE6XCUKLWy7MuTsO94cEK6LfcwSsdm64y03Eod7YHJ5xXbjx+laVpl8CWdjGk3wbfujIuwZiUYmUHx4vq/IWqtYHeZZaLrOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsxANrZHdchk5Aic9SUh+dwHRbhxDyhBE4sQz8AjQi4=;
 b=PRtlXIxIXA6/GnsikMRS2CcZIq/eIuqjrz5tFKp1POgQAJjlZ7X8lB6HkfYj5mMXHLwiJ05kLFRjBbkfN9iYJKo1uPqxd4clkTsj+XkP1MFPtXDIGrFEopEP0hRHyWfWbY3xTGSzrsT563eCi9nzE2r1wZIuQCchHMbJvYNxkZLd/Zy7ZDskwwLYmHgu+pdUa1O4zgFj4zds1Ba3ib8AJFAucSKBMW5br/faaZH1HuOlwXKquHVpT5qXipUmmlqZHUEPSslUYtjh5U94y7tvhl/j0xjlrOvmIHGchPJGYB8Pq/VJpbG0XiBdNImJOgAlwD0qqftGoEKKqkEXX/crMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsxANrZHdchk5Aic9SUh+dwHRbhxDyhBE4sQz8AjQi4=;
 b=gxUvUmjvf1ZqWqt1XY/xcpS3csPV4I9aDe4b6XuQ29bJQVqh6vsAc+GIKbvLfPmMPuhCYtd3s/Y/Upaz+lKHbp5rbC+WLVyT8HM+uOmhZ1J9lL5R0pMHLruwIko2p+1YJ7IfzvUMZ2xBp+RyI1cpXeNTTDHJJHtD7w9QWg1MYzt0dIf5hjjlMuSHjLX3u6yCcmyhfr0uwrqCqcevem8AB6cbhe3q4cocQCJ9IzRsHrFl00R3Q18H2n0le1Y+236hjI3aZctNVyhjqCE6EhzwMDHh8tU/MkpqQzRuwEjZN6VNi3v3X1WSiLCEY7Pd5aBNY3MqQO5HzSJnCovoo5EZIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 07:44:25 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:44:25 +0000
Date: Fri, 31 Jul 2026 15:44:18 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cxl/test: Add a 2-way 16K root decoder for
 passthrough testing
Message-ID: <amxRzTxrPiwhlsx1@MWDK4CY14F>
References: <cover.1784940306.git.alison.schofield@intel.com>
 <e89552a2c51b63657da50c9286d48ab858016721.1784940306.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89552a2c51b63657da50c9286d48ab858016721.1784940306.git.alison.schofield@intel.com>
X-ClientProxiedBy: JH0PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 28006ae1-c1ef-47f5-02c6-08deeed78a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|3023799007|4143699003|11063799006|6133799003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rTW2MS3VPv5Avfd52BgRhIPmZQ+gEZ+ZA8pJ8WHHzE9bMVcNzeXpJvxYG15WtEIa74NSdtm0JYgvjnXSsgGiflde9Z3/LkCOyK7rB6jUyxNUjkOnIcWiCWUG0zawPDj/dNPD+e2SJrIjEeQTgl2rLEwQCBfRQRBFuiJfr6wltDZFDKG1Ki7AzwksxgQrHRjvlUJVQaGMs/cR6a+jPTZix+Lvv3XlxGP6l15BAzl6hxzx/aWz8qeziOlBs/kjXYhtAZtZ/Xn9OEybkbT3Mup614+gzMXPkgWUD6lqNWsAyBoIzBG47HcvzxKr7cVVyxHSu4u0K4ZpKJQ864rdO70lxXa9c7ECuOUe9gwG59xQ9QGYh2L45uShmYmAEtOEb5sAHDQcTvMB8HmkMkyYy1+1YSBrrGc9lZfAlz9w8F5Hn/NO9gJqnG4w1BpcvQpeNbodcWJCjoWzR18cmv1US1v0ZU/lNYs5OmW2h/sAkANi+VHMuBXZfsMp/VGqS2aefdaS/DiurEudlKAk61Bi9L27aZju8IG7zRQD3TOxfF7T2MaWo8XXMbz0RbDhkwE50nDA6Z22E1fvj8OKQxeoq4o7bKOmRIxpqG4LYgZYa5aZj5Dfdk4WS6+H20GsH71jAMl1rbbQKePj1Wi4Mes5l7Xl69tQs98rPLjRL2ISpN6+mtM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(3023799007)(4143699003)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUq8FsuMwTIBmHHI5E3EeRpYThAg/O47nyWB6Wd5Pff7YDYxp15rqyON6+bX?=
 =?us-ascii?Q?0KJUaO1Zf1pjZJlfjIhdJODWxN7+/l8r9CYskimERQM0morQs2L5hctL34fy?=
 =?us-ascii?Q?EgA67tkICRvzjyEZaaBOfkcT+OGHv8KkKEDiJ9J6mwWc7IJ8Rl6SzmA2fPMC?=
 =?us-ascii?Q?uXXgvQYM6j2R81QymYfe0HkNx80LxpP3Noj4vJ6nM24To8llHU0Wcg/h+Au5?=
 =?us-ascii?Q?qjNH7Or3tWxX+qj/G0ti3bqsNk6PuJ/arnlMoin7QG4X1jWVjGaXqb/msAgZ?=
 =?us-ascii?Q?x/glpdN4AS+C3sWWxEd9QMCpSdbbOH85At39EG8ExH2FQuh0H5k7eY89Cvxl?=
 =?us-ascii?Q?rflpcIkST+/15kHO0B5fFl2Bv+C7RMujkFHZrXiaShpV1U+dHDYdjgM/187j?=
 =?us-ascii?Q?/0KoS1XWCcELiOLFyNIarGMOoEfkDLBi95BRZiD/Htd9swCparY5z7Gap7Y8?=
 =?us-ascii?Q?XZnfN9EGouLYtaHaxRctq2vrRPYSrbZvdkrp9715K5cEP/AGdc3V+U8wSv0f?=
 =?us-ascii?Q?AQFUcIrH3I6RwUqh72KN59oN8c3zOWEwatSFjQZeQH1vRM72HUlwrhlMG90O?=
 =?us-ascii?Q?G5+8WzFscZhEFKA6aQbRk29SfYRp2kMJ6jVTLdhLiUMpx4X4RgUS24NARGuO?=
 =?us-ascii?Q?y2jO+M3+f22hkYfNzGddped0Bd8qCXgKV5dH0kUIcMpM5z/xa5fxQGh6PvAQ?=
 =?us-ascii?Q?yiFpdzoKyE4KijvAb+X41jHTzydsEQOHGVxnU/kG+OEOlhE5ohBKOJpfPRZ6?=
 =?us-ascii?Q?YjBDonBeEYfydRwyrATBwo3xIW2vTZlERPsEAabvq/go97u86cMiwDNk63KW?=
 =?us-ascii?Q?MVcLhHNuL3WdE5+KP6mcv8QTqjV6pKtxIC9Ai+6eXntHXthalWRC7iYOxyRp?=
 =?us-ascii?Q?MixqotMwWrxUF0gLsRULb+63pOAI6lCI39Z2a+O6OWxU33XoltyY6Te2ENFF?=
 =?us-ascii?Q?8wGXhaPcOZea+zgZbnZATRq0kW6LT5LC0g5VbZ3XIl146xp+1+9KdTQdCA24?=
 =?us-ascii?Q?o9yMBii7/KiIz9ank4tc2rRFkB3vyN1ByxxMLuLbNzu2Ny0V43Zobcyk6m8/?=
 =?us-ascii?Q?z6kKbN7me14aOQWVYP5m6jAAzBFq8ISggiDXNBDdtSnHe17btPXwt1a1isIC?=
 =?us-ascii?Q?McMlw6DzQelc50u3JT5UezY0X4kCVFf7MWHN2fiWjP+uvZwrx94uOx82PdIN?=
 =?us-ascii?Q?F9UYNXMHnK8bg970vuuTrewPVuU3WnKa+C0keIkSNoU4cXrt764Mf3eavmEG?=
 =?us-ascii?Q?V6rjVkduFMNHa1/ZL1cCI+5OLW8thD5ksE4kkXExNRRZY6ZAtHDK/zQShvA9?=
 =?us-ascii?Q?b+K5SyXToWvRC8RZpkhVABRaxswahaG5QklRxrZe/yfrfdm87fTkjmP9HMTK?=
 =?us-ascii?Q?L7R6PJRwf/KwqhQqIM6MVJZqgiezMMXeuk7Q2nbW3TQyhkoqQcIQQ/aK2KSM?=
 =?us-ascii?Q?YFolmUgHv01eJb2tDGbu/rONdnOSAJD5Jijgqf1EdVt/D/G9+cD7X9jnCL+z?=
 =?us-ascii?Q?jEYXrQxszmcLRzBfcek0i+e1EBwS6/dS/ZbLpc35SZC/njGE1datFqEKcklI?=
 =?us-ascii?Q?fxq7f2Ac8uM4tyf6Xadd9SON+05HIzWV0o8jSqf5FfaR56HMaYllgXYRTxF2?=
 =?us-ascii?Q?oLpK86mV1npVKKCL9aLSnyslU1hbgZCiisTvokXwj11Q7uobCKRnofTOi1lO?=
 =?us-ascii?Q?dxOwnjpZYn1VhLX2Bq8LexKmh13o6u1PY4qrE2LxVsH4KTM0aud2/effbVQu?=
 =?us-ascii?Q?bgpqcPylVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28006ae1-c1ef-47f5-02c6-08deeed78a89
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:44:24.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So2ttKPmyrcUU0pPlaLNB3Vhabr1EZuYd9RikHO86rxAztM21GAEVGRoUblUYnx8/Mafai9hw3csbKsm5/sGOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569

On Fri, Jul 24, 2026 at 06:08:55PM +0800, Alison Schofield wrote:
> The cxl-test topologies do not provide a configuration where pass-
> through decoders compute a granularity above the 16K max encodable
> in hardware. The widest power-of-2 root decoder currently available
> is 2-way at 4K granularity, so a passthrough decoder below it
> computes at most 16K.
>

I think 2-way with 4K granularity computes 8K, not 16K.
The conclusion does hold, just the number.

 
> Add a CFMWS entry for a 2-way root decoder at 16K granularity. This
> topology supports a region configuration spanning the two multi-port
> host bridges and placing one endpoint under each bridge. The
> intermediate switch decoders are then passthrough decoders with a
> computed granularity of 32K.
> 
> This allows a CXL unit test to be added for this case.
> 
> Place the new window in the XOR topology set so the default modulo
> topology used by most cxl-test coverage is unchanged.
> 
> Assisted-by: Claude:Opus-4-8
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 48 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index ef92dd35e030..5b87a3f5673f 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -188,10 +188,18 @@ static struct {
>  		struct acpi_cedt_cfmws cfmws;
>  		u32 target[3];
>  	} cfmws8;
> +	struct {
> +		struct acpi_cedt_cfmws cfmws;
> +		u32 target[2];
> +	} cfmws9;
>  	struct {
>  		struct acpi_cedt_cxims cxims;
>  		u64 xormap_list[2];
>  	} cxims0;
> +	struct {
> +		struct acpi_cedt_cxims cxims;
> +		u64 xormap_list[1];
> +	} cxims1;
>  } __packed mock_cedt = {
>  	.cedt = {
>  		.header = {
> @@ -371,6 +379,28 @@ static struct {
>  		},
>  		.target = { 0, 1, 2, },
>  	},
> +	/*
> +	 * A 2-way root at 16K granularity. A passthrough decoder below this
> +	 * root computes a 32K granularity (16K * 2), which exceeds the maximum
> +	 * encodable in hardware. It exercises the passthrough granularity path
> +	 * in cxl_port_setup_targets().
> +	 */
> +	.cfmws9 = {
> +		.cfmws = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CFMWS,
> +				.length = sizeof(mock_cedt.cfmws9),
> +			},
> +			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> +			.interleave_ways = 1,
> +			.granularity = 6,
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
> +					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> +			.qtg_id = FAKE_QTG_ID,
> +			.window_size = SZ_256M * 8UL,
> +		},
> +		.target = { 0, 1, },
> +	},
>  	.cxims0 = {
>  		.cxims = {
>  			.header = {
> @@ -382,6 +412,18 @@ static struct {
>  		},
>  		.xormap_list = { 0x404100, 0x808200, },
>  	},
> +	/* CXIMS for the 16K (hbig = 6) 2-way root, cfmws9 */
> +	.cxims1 = {
> +		.cxims = {
> +			.header = {
> +				.type = ACPI_CEDT_TYPE_CXIMS,
> +				.length = sizeof(mock_cedt.cxims1),
> +			},
> +			.hbig = 6,
> +			.nr_xormaps = 1,
> +		},
> +		.xormap_list = { 0x0, },
> +	},
>  };
>  
>  struct acpi_cedt_cfmws *mock_cfmws[] = {
> @@ -395,6 +437,7 @@ struct acpi_cedt_cfmws *mock_cfmws[] = {
>  	[6] = &mock_cedt.cfmws6.cfmws,
>  	[7] = &mock_cedt.cfmws7.cfmws,
>  	[8] = &mock_cedt.cfmws8.cfmws,
> +	[9] = &mock_cedt.cfmws9.cfmws,
>  };
>  
>  static int cfmws_start;
> @@ -402,10 +445,11 @@ static int cfmws_end;
>  #define CFMWS_MOD_ARRAY_START 0
>  #define CFMWS_MOD_ARRAY_END   5
>  #define CFMWS_XOR_ARRAY_START 6
> -#define CFMWS_XOR_ARRAY_END   8
> +#define CFMWS_XOR_ARRAY_END   9
>  
> -struct acpi_cedt_cxims *mock_cxims[1] = {
> +struct acpi_cedt_cxims *mock_cxims[2] = {
>  	[0] = &mock_cedt.cxims0.cxims,
> +	[1] = &mock_cedt.cxims1.cxims,
>  };
>  
>  struct cxl_mock_res {
> -- 
> 2.37.3
> 
> 

Reviewed-by: Richard Cheng <icheng@nvidia.com>

Best regards,
Richard Cheng.
