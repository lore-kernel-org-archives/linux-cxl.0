Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F0A23
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973530; cv=fail; b=R94BmyNElNlLI0KaCTxs+UejdHlwYlCwGp+Ww4iZ3EARrKxFkCMtUtG0y2Q9TwYyGTk9RTXZBcwkK3axRc8oyxZrQ2BW7u2VqHYEEQB3ukoGzhWF9JU2qFlhh/C8ObNWGEQCbjWhyv5z65eGhndfEUbfXjCZZZ6m6dddKWRo24Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973530; c=relaxed/simple;
	bh=z/fkLEX0FZBVG9oz2jqtirXSoJkl0bJ/F+o+s3Q/+8o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l+NIXDjs+WJys1YA/ENrG4NggUiI+FUqXnrzNzELifKbR+xJth64iPlAtdTjAQJZce5aBUHdhwsyQ8Fec5dJgR42b05/an+efZKRMPSQozAVfsDaRmRBEMuOxRpCiYiHLqsVmeEXetM+rM0Ar/MRUfBVXQOoGfhRPXBBj3fNfSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tvf27+c7; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tvf27+c7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738973529; x=1770509529;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z/fkLEX0FZBVG9oz2jqtirXSoJkl0bJ/F+o+s3Q/+8o=;
  b=Tvf27+c7ddF7Ex+2eP6vxEwBDwwQ8NOgynieNhBuN7V+UAkNXXRbtBh6
   013iATObQ2YSnquMm/8Zc+xmNUNB1tuGlQUac+7YjnBFLEHZ5/GuEZnn4
   C6avA49zDukJi8Zm8sj9Z1I49bPh1qtkMP5R5msgULXbUmxs7hByaHGt6
   KMN/d/9FZo9OKWFB7mnp8SlTwOwhBbjO2d55LpQQpc5RC7E9V/dvZkgzM
   Ppks4au05Q2x5OLHqYmg1i4Y0jByz+I9lZdpUp1b1/08F4eUtl7mWci8n
   UItOB5VSbPOEW1VkXXPZV+I2VmoZwEPvbO3E9y3pJZpjUjgB+uMW16RKL
   Q==;
X-CSE-ConnectionGUID: QBMGOqFDTWOUW1jtBP8hcg==
X-CSE-MsgGUID: UT179XLASD2kjnDdvAzuqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50252623"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50252623"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:12:08 -0800
X-CSE-ConnectionGUID: sr4pi1jJScOYZr3froHHIg==
X-CSE-MsgGUID: 9IRVJRgVRk+X5sBA9pSkPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111510149"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 16:12:07 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 16:12:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 16:12:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 16:12:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmiIorais5hK0FNHsiGG937cbDWnimlTULu5LKqxHeKMCnlCF+R26SYYdqAsyxRZN2GjOarClW4ZvAI2YeJoM9BDMaxqeHTXncG0xmaZldz6iCjO6Hk+otvY5nerSiiw8wKxVSnXk3x7MS5cq/VuXxs8TG8dpJeZAb6Sikk1i72uAGXb5fB/c+m7oZ+4J8e5WywZPEkYT+0fBOBq4Z5Uy6rLrH42UKoaYJCwwMobS/0WucJqZWT7uDo7DA/ixjqSQikmT9y2HWPrqFg27FU8zH8gPh1zOP530857n/HNDjPWXsF8kMO0hu8baRz5Fo83LN0ed2f21miXfvs9Nabx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFuQdG/QBvhbMBAjBaZ9q87V7y68N14eKoiBaCY1gOE=;
 b=a6T0kRnAzPfSpOb401gzemPhUP54Z/0x2+8FbmrDm7tUysaxzG0yci5GYASYVncoTBSJbwVUNg+hkAlqzo/+YbKQ6/yafEqv447a+mJCdrSPSrXkOWTMHmhpCjXf8HB8+mZ5jUpUqcShw9xPwID1SmcnWtwCAj9A1bnPRJfcmSBxCRxR4EU01S+jam7MQDEDUdAhFTLbrHc5+MLW0ZOmz6MnKwtGyXzROllTU80Q2798o2/hXoLBsH4/BBU0eVM5Sgw7Smc56o9SYhetcI3J+NwL5CfmQo+CziLf3NNcSK7einEI0e5NaLpNLw74xJA3SXJL99ILoHz4cIMFwcJCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Sat, 8 Feb
 2025 00:12:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 00:12:05 +0000
Date: Fri, 7 Feb 2025 16:12:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v4 04/15] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <67a6a152630e5_2d1e29438@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-5-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: cd04f635-a9fe-4cd4-2fdc-08dd47d537e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lJ9byt/zs/Mw+7px46eXMwisTzEn6L7Yvk8pQ5jgyeEwRTv6aRSrTHG65s40?=
 =?us-ascii?Q?fsmzif6HVbDmOi27OZkhQcAsVjRkzApA+n3bv1l+AK8y68+v9mWbwxMXRCEA?=
 =?us-ascii?Q?hWoBbdUdl7lOJh4Zo7PjfRV7pNEt3b5B9Bb7OYmJIT3AwUa8ZtzZtUvVWdvR?=
 =?us-ascii?Q?rlOTXVyLCD0sw698TQ4QvGroqhscz5FfQ21lBjK4dHUAal07BLviiwgK2ONb?=
 =?us-ascii?Q?SIDHcnCAUiGwYtIyIckPY0RhcMSzGZkEKBRuvc0DXA9+JbZ5XOytoW4gS072?=
 =?us-ascii?Q?6l/YmyQt4bXqq2nyyJElp0MiP0PYO4PSTgx8GbD286fuWUEHENBign2+zQoi?=
 =?us-ascii?Q?UXP9UI69gSrK3hLBo0uOyi5PckDJKboALmmen3EOogVLgF2XAA3zDTflhI3B?=
 =?us-ascii?Q?UWv42UsMSXO7ZgwSNcW/Sy0Ykla2y14/PdnOjedaTgSX4oWtyWyfxlU/cDfO?=
 =?us-ascii?Q?cTsCr7vGUfJOlt0exrKIDx9vVt+Ed4xCP03O/XZqZPk1muI0+J/T5eqrv3tv?=
 =?us-ascii?Q?Fasvr1Hnb8kGhRyrwBNyjamtnopr1CLuMkvpgLWiSBW0dYQ5GyFegQRvoKHM?=
 =?us-ascii?Q?WUZaf0bTk8FW/whcsfJ/VXbr1pjFy4DNbCitp7pixEUElWjHb2LUdiBizRjD?=
 =?us-ascii?Q?P3DbDxqdfZrEsoa6BMgmGiT2POp9rpGz8ZuC5KXLNu2At9s2lO3NrR/eJv4r?=
 =?us-ascii?Q?iWfAxpGBRnFhZ4VCg5W/JNdoFcUJBMIixlH5BmOSt0pFcEcktIfYVG2WGff7?=
 =?us-ascii?Q?oXFk9uHccaDxlPteA92e0IBuypmhFgYs5+7zQVlH9+Gw8nkKxxv6MeiQW/mO?=
 =?us-ascii?Q?3jzKtYaliLC/cANzPUog3H5mIL34IxntybrrJCZ0WAHeaoyog/BDR826u/E+?=
 =?us-ascii?Q?pptkM3UXHKV8Bad/NP5+r7xODlb9YTZy2jlKGUvimJtZEc0tFngBg9C1C3ow?=
 =?us-ascii?Q?QTUF1z2bXHudR90e3lrhVGbOQRh5SYkmCGH7Df1KQk+gsAwyhPSArYlPuliI?=
 =?us-ascii?Q?TEf2cvsgIKKWXrJW0C2344Bjasogh6ZX8my8vkhejahirYfv2Q9yjC0buwff?=
 =?us-ascii?Q?YLwtTRVNNSui1xkVbwtYDUacxNkmhpBY7iXFPp1wpMFKqxKQnpbZy0DbzmEM?=
 =?us-ascii?Q?NPWSctTC9Zn1Rwkp4X6+D7meJFqyLQ5XnKYOb0ZHA4WZWst9BBbEOMn+gKFi?=
 =?us-ascii?Q?RnBKG5LTzsnTDAaq5enUTXYKmo/fCoAjekZrHenEVTDKAJI65FryV2KA0Tat?=
 =?us-ascii?Q?L6t3Dd7wDa7bGiGckYfX4NpIgmHnP+7+5knwEfdUDU10dDJNR6gSWz1bOQfj?=
 =?us-ascii?Q?kC55/tl/Nip/TpiLDdWoKXlg1K8ABIGLzgmRFMz2TgD1/B+3SnxAlxI/qsyW?=
 =?us-ascii?Q?SgMlGrY3c1YY/FZa4y5ZLL5g9WwO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDo5hQFaKLMjXyWzx4oFE4db7Wh3HAwdL3giByQyYjLLDxHYlPlycKhGMZii?=
 =?us-ascii?Q?uokGNh+eum5qfQjbG4CGOI/kpbO1u+j7BCg+zXgycv0pMMTytk5zjEzA7htE?=
 =?us-ascii?Q?qc5xsAYVEXm0QzLob5cdi4/ZArSDcO0FxWuSktGIJoqSaGESd1g+kZgZCyHm?=
 =?us-ascii?Q?jy2QELIfVOMrDJv0gT8clJnE5ZXjYZGmFinGjXiAS1xayM00QYX+LioaCAym?=
 =?us-ascii?Q?KVkeUyCAeTfxvfU+qvJ4jxOp/gsw8O5X4sTig25RTmf6iLRmIr9oF1cgMnpH?=
 =?us-ascii?Q?ypWCP97QSFDrPu1GQzKP8q2Th28wwzWIdjVGEm3P/ZlhaB7ZuJTkjqluNiEa?=
 =?us-ascii?Q?NZOw6Te48w1e8gwMIsa8SNbpifR9Clxjit0zHWRfvKgWkn32ryF+R6rE4ihL?=
 =?us-ascii?Q?KzLVpb3xWATzPKJxdNw1pfDBbWryEeD7qULmoFKEY5q3LxQV8GWlGPF8e2lA?=
 =?us-ascii?Q?5ihDo8z/UkVPuypNrq5S3qujfOAVGknjhZISwp9ZiEpgqPMAOhIDFDMSGPtI?=
 =?us-ascii?Q?nxfIhUIusAI2BTvHVYyFhDASU0/E3ozh1ERvfCa9SfA/fXplY4TQ/R7GaEWU?=
 =?us-ascii?Q?lFMX1jHgyeL08J4SDp4GTI3obpeeOMR5vgaPnuT628sMJ7ChY159dboBf9u0?=
 =?us-ascii?Q?Pg1wj+zPWeFaP6FQaGsb/mLxN5rg/uVSttChoN2XBT9mkzZDUzt0JjahVffc?=
 =?us-ascii?Q?ZoiF8OVJTTxEdv5mJi1GtwnbzJgGGDqJ7QkjIm6anhz5anxarWMS207EKm2P?=
 =?us-ascii?Q?BF7oO+vbss2EIY0TmImYH5lao+Q5USTfZ6/Qhc6ZtqLnl29ZZKpm37EQVfyH?=
 =?us-ascii?Q?5a8Gh1OYcxI3ppqi4esJC6n7f0u1MZhuBjVwWQhsdtpuBjgMHx2gKKl4Q3EL?=
 =?us-ascii?Q?x8hUoPjgzT6Ed0W2MlXH5XM7/Sqsm8ccYTwflBVDmpbZ+dLu7AsizX7gnvL5?=
 =?us-ascii?Q?xFbrHmoFuipvNBHWLRZnH9gqZ/sfaCKjz31oGSShiy/8ixACHUK3dUXUjjKP?=
 =?us-ascii?Q?kXgAbuEBzQjTz2qn5XhPMOvXdS5H3+BlGGvq+IozA4i78bKNPdA5uJW7BhyB?=
 =?us-ascii?Q?NS+1PMRwNW6qKcQxRKtKEmef0F/u/6gr2Tsrz2S+xDKFVYzQ+F5hcJdbAAdj?=
 =?us-ascii?Q?iCpTkOFqorIJ2jMnLS2MOcFBAEJVrLocijqUFgILrAByXOYu1RmuFtSHRD58?=
 =?us-ascii?Q?6E4Vw7z+F7YDESGr1R2P2cPaVTRCAEdhdjhjAnxcZIUvwKP/V8M6KZFxpciq?=
 =?us-ascii?Q?0UWRmnkziNgf7tTYmbk6fRI9XoGGiAPMBxL+bHsFSD1b1ksp4TrS5O61JoVx?=
 =?us-ascii?Q?eR1B4wWwyTvto7IYg+uBiWXZn3/96G3+jaQ1Q1lq/0hQs8qvBuY5rWo4m3g1?=
 =?us-ascii?Q?zgpElEEIFqFIrShJXQOkfFEAhDL/V3QugKxs9eQEVVs2Y+uPzByrFaRSnt7H?=
 =?us-ascii?Q?fSe9JDs79/3NbG7IeFUSE5IAEEmnuQ+v89fC5JpadLIgG2KEZwcG1LmcBYwV?=
 =?us-ascii?Q?riKBlsfkww3W0921Tq/ehOQ/ukaFYYgq/v15FTw2cnnTV6TrQtKXbtF1syQb?=
 =?us-ascii?Q?qIkjowIWe0Km0dNyNbSqcBgSIU+EHT+G6Y7UQ2vRB+wsOrhxlvYyN5jKUCtD?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd04f635-a9fe-4cd4-2fdc-08dd47d537e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 00:12:04.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUOCgAilUaBNvK5M4wwZCOhhwlaITdeaW3iwYvCT+N4259qBhtainl3HS1RO+PAEwmEoO8oWxNBUjwLjZW9MXFPhck8JGqWH4YRaNLUjxb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for GET_FEATURE mailbox command.
> 
> CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
> The settings of a feature can be retrieved using Get Feature command.
> CXL spec r3.2 section 8.2.9.6.2 describes Get Feature command.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/features.c | 50 +++++++++++++++++++++++++++++++++++++
>  include/cxl/features.h      | 37 +++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 77a0bf3a4916..262e4b1cb7fc 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -177,3 +177,53 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
> +
> +size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size, u16 offset,
> +		       u16 *return_code)
> +{
> +	size_t data_to_rd_size, size_out;
> +	struct cxl_mbox_get_feat_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	size_t data_rcvd_size = 0;
> +	int rc;
> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +
> +	if (!feat_out || !feat_out_size)
> +		return 0;
> +
> +	size_out = min(feat_out_size, cxl_mbox->payload_size);
> +	uuid_copy(&pi.uuid, feat_uuid);
> +	pi.selection = selection;
> +	do {
> +		data_to_rd_size = min(feat_out_size - data_rcvd_size,
> +				      cxl_mbox->payload_size);
> +		pi.offset = cpu_to_le16(offset + data_rcvd_size);
> +		pi.count = cpu_to_le16(data_to_rd_size);
> +
> +		mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_FEATURE,
> +			.size_in = sizeof(pi),
> +			.payload_in = &pi,
> +			.size_out = size_out,
> +			.payload_out = feat_out + data_rcvd_size,
> +			.min_out = data_to_rd_size,
> +		};
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0 || !mbox_cmd.size_out) {
> +			if (return_code)
> +				*return_code = mbox_cmd.return_code;
> +			return 0;
> +		}
> +		data_rcvd_size += mbox_cmd.size_out;
> +	} while (data_rcvd_size < feat_out_size);
> +
> +	if (return_code)
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> +
> +	return data_rcvd_size;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");

I don't think this needs to be exported. The only consumer in this
series is within drivers/cxl/core/features.c, and the EDAC consumer will
also be from within drivers/cxl/core/features.c with new exports for the
cxl_mem and cxl_region drivers to registers with EDAC.

> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index e8861e690701..85036604fdba 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -65,6 +65,29 @@ struct cxl_mbox_get_sup_feats_out {
>  	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
>  } __packed;
>  
> +/*
> + * Get Feature CXL spec r3.2 Spec 8.2.9.6.2
> + */
> +
> +/*
> + * Get Feature input payload
> + * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
> + */
> +struct cxl_mbox_get_feat_in {
> +	uuid_t uuid;
> +	__le16 offset;
> +	__le16 count;
> +	u8 selection;
> +}  __packed;
> +
> +/* Selection field for 'struct cxl_mbox_get_feat_in' */
> +enum cxl_get_feat_selection {
> +	CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
> +	CXL_GET_FEAT_SEL_SAVED_VALUE,
> +	CXL_GET_FEAT_SEL_MAX
> +};
> +
>  /**
>   * struct cxl_features_state - The Features state for the device
>   * @cxlds: Pointer to CXL device state
> @@ -81,9 +104,14 @@ struct cxl_features_state {
>  	} *entries;
>  };
>  
> +struct cxl_mailbox;
>  #ifdef CONFIG_CXL_FEATURES
>  inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
>  int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
> +size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> +		       enum cxl_get_feat_selection selection,
> +		       void *feat_out, size_t feat_out_size, u16 offset,
> +		       u16 *return_code);
>  #else
>  static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>  {
> @@ -94,6 +122,15 @@ static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox,
> +				     const uuid_t *feat_uuid,
> +				     enum cxl_get_feat_selection selection,
> +				     void *feat_out, size_t feat_out_size,
> +				     u16 offset, u16 *return_code)
> +{
> +	return 0;
> +}

With no callers external to drivers/cxl/core/features.c, this can also
go away.

I am fine if you just fix this up locally on applying.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
