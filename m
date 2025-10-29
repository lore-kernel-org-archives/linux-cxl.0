Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A328F5
	for <linux-cxl@vger.kernel.org>; Wed, 29 Oct 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702380; cv=fail; b=fbUuBjBcl/5ZL3B3YamhcN0FZ1DifURFAIHCGUB0yFeeG/xHsY9ShfKp80rKz/ZIdgzia1rXiGe6YSTw95JZ8eDf5h2gj/fy66GH0kKcsa0JIRVfuNp54yUV3c0AQHG7W+SbXvpDAD2AW2deY74qFiOUi77tDDyNT/5KmSfl2V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702380; c=relaxed/simple;
	bh=Pd5nza2X6XC8wkq0cQSzZMXbS9YCVi+r+s4f0Sa5F5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kIEOPcSP0YsVkrOXhdt4r3zRpHoKK6qGMG7WbfAVNKtH9EhEcggltaPscMu3qGU/dykZ+pPIFei0/GKc8Sjoa/BVWWdKKdMWr03R3rIDWO5KSHUzuviYTKoxFy+Pv9+87GFi5VWApCAXhnIrRMHDl4csmXAjgXCCoM2pknnYfac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKeaNtYr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKeaNtYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761702379; x=1793238379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pd5nza2X6XC8wkq0cQSzZMXbS9YCVi+r+s4f0Sa5F5E=;
  b=nKeaNtYrwWD93U4hAra3AhpjMooyRccW9OxsVDqqaJ4UufTSivKCToZZ
   WllReh/UiKR+JXO0ZoYA3h4Kx9UzZO5wgILYd+uzKlhwQ1FCJQ6+rv9Bk
   cCyXWkUOTVZUq4SmS+c9p4bWa4aXbGli7vxxqs452BArrxABteT1j5GYQ
   1V9pjIRa2skVyuOr041dNQ2iCEwIRZTCI0pI/8REIF8kx9n31oTeyVRL9
   +qEV5SCV5CCQ7quQmQ9MwUJhig8Wt/54I9v5xXSEd0hd/ld2AmFllSvMn
   PzFog+Qx5Uk+opgdlUUXXgNJNQySeTTW/3Zxmdfh7dp0sJlSbQx91C6Vx
   Q==;
X-CSE-ConnectionGUID: jvjcwEKZTCicmrmRi09ODg==
X-CSE-MsgGUID: C5f8Z8NzT4WPJrtWRH+FSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74491219"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="74491219"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:46:17 -0700
X-CSE-ConnectionGUID: Da6WM8O+TtiXMLu9oZXVNw==
X-CSE-MsgGUID: 2DTyXvUvS/u3nszF1r2d0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185860080"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 18:46:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:46:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 18:46:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 18:46:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WECdbp+1lCKB4YwRESBuyOX77wn7FdedZQkFF+0c7RRrJyIDs9bdWravRVZbLVskRZASk162JOWcaJT7ehSuNb8k5ymPLUFA8St2KhNJyz5RIaA8viZEb037aocqrWqn8quPj/27sArXLSJXqEmQsgwo4mpM+c61lRzgh0K//iTbgd/oAkU/h5jcq4xzpPhHl/3adiyfCg83S0+AF7Kj1xXTH1zmjTP1s2HnecZWttxHUjTogkXdwQHRetq7jdhbbbQeZScM7iixGc8JdFkY89gU+DG754g6QjJ9H4tCGBYEJp4hwyM/qU2o5VJP0AgMpDxi5rBsacrJtzagPXTrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb7O5Ymq6L36vK4uA08/alQPwf8akzLMED1GLktq0YU=;
 b=G8jJhWos4MaLAZLNSmVUCATJuzHXg/8mJ+F2dLl3OlQDzBYPwbhK1uYQ+XSSPXQF4zZ06WDtAdXTz9+U+qkTzsdx7SDNEfXhEskOnVputOiwB+QmAg3HZObWYZFZAIi5OSSoG20A90mmO0h2XAx/cpZZv8Mx28xviCXOxlVEAcFE2s5dtwavj5EMz5949TvkkfE1AceKfQqZr36YsutkoZETd0TdHHf4z10/fr6B31P9fO5gmenXSVVVDRYWMYI5Ynfd8zMlLm8QxbsgxZ/4H8ADN7JIZ1TvrRdHosnTxPZ20WDm/MObSJbABVR5ar4hCaWvMyH4Q/L9DmDTsNL59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 01:46:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 01:46:12 +0000
Date: Tue, 28 Oct 2025 18:46:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] cxl: Adjust extended linear cache failure emission in
 cxl_acpi
Message-ID: <aQFx4DODaAFG4qJN@aschofie-mobl2.lan>
References: <20251003185509.3215900-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251003185509.3215900-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CO1PR11MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d024af0-8cb7-4659-ffe6-08de168cf0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZNJ8Y9fzL/L8KOGnu/7acwEayRIcmPDxwcHyBFxrK10XgGGP+loXEZMg0YQz?=
 =?us-ascii?Q?FiBrNf3GyKcfM/uTSJj7L1RLh04cohBTAa6SjTGUi5i+PQgd2nSxsGGdO3qm?=
 =?us-ascii?Q?rRshY0vVNb5Ya+0n5uoLoqZKRH0Idma/0mYFu3dkL9T2MWzH80k3E8VaKhAt?=
 =?us-ascii?Q?iBG5pPs/VuySt51NP3/MnAupHHvlExLhlTNHKffyIYlHVWhzfhJ8V8Q3Jhy7?=
 =?us-ascii?Q?thevQgqDj8TpfaxJmEWMXXRhvuXk2g5oqTzMZQrfdHPX0dMoY6qKVsKxfN62?=
 =?us-ascii?Q?LZ7IfzBisgvrQEuCHOAu3KTlFyQHMJzudo8kh5wLpW69o+FXT2aJnnuJalFQ?=
 =?us-ascii?Q?70flWzanIaUu04ePCP99kum1OrEvzRSm8+DFvnxo95HoD4M3c9Juf8LaSxjs?=
 =?us-ascii?Q?c6uYg0LCAqSu7D7fgnsRJ/WauUxVFzVu+Q/AysbKr+KbzaoX9A9gqD5noUsU?=
 =?us-ascii?Q?uBcQpHr18UXbGgtHX413ExEkRwy5UWChiy42qmtLIU81FrlsIkbwoJY7IEwf?=
 =?us-ascii?Q?y+0cNpiS7CLGYdjvTgopzP3K1WogVH+G12mxEwnIyvv8TbcDt63Y5oQk7QQH?=
 =?us-ascii?Q?8oCXiMEdWdUb8T0blM7QQEYIbkjXCCMAx3YWK/7YwsHeUAtjPQp0YtFRsch0?=
 =?us-ascii?Q?aTAkRCZ7/DjvNI98PDMHuh7oMUZm7w19bFyC9TPGZIs2Mdgg+lEHyrIoP+ky?=
 =?us-ascii?Q?gXmLNO/6XCGE/RGMDaGWUqVx6oEIy708qq2IY9P9+88o+gGcy9/Lc1tEtQ8m?=
 =?us-ascii?Q?JBZQGRpx0skjTs8z69nt+5WKRXWRWalw6CXlzLFkJ0x4YV2Sze6Yq2yJIP2m?=
 =?us-ascii?Q?gQyu4mLSgfopg6833rRgBZG5dmJ45QPKgkPHa5vDhN8/G+t1e/dd527CRKH1?=
 =?us-ascii?Q?efIBHbMdel+DPzNwC2sRzXyII5tAJUppfpKu27kfrWell06qfOr1evt4tI+r?=
 =?us-ascii?Q?2EjrfvfoWUrgwqW7j4CLvH0/qcdRBbMJjXVWX+RSiBpDkTmzHRGuin7yKh01?=
 =?us-ascii?Q?j4TKvzY6Ut6zckvOrGVV8IcUkcPFr1irpX/yiksiY19nYT0cWeh02ZbmGgPE?=
 =?us-ascii?Q?oSv17eqBxYLFSYEXXGTgeNKAJWd/D/wNTJmp5WKfjW4QtTHrC1UQIEncXvrp?=
 =?us-ascii?Q?KJIGOX/2WZj+4a0yQZAMCKDVNBlfOy4Vukwwq96LwGbgKqJpnv4B7qfgEkTD?=
 =?us-ascii?Q?WV/if1DmvGHfaCWzZEJ0dkncKFhc9W0xam9to9oSz6hD/6YUQF7qCY2bjIjm?=
 =?us-ascii?Q?DyhQEgD8apxcufAGvdpNfqAepW1dhY/yntuYo6qIqvE8+lnR6CTWJLw4Z4mx?=
 =?us-ascii?Q?zPpsmTtyaTvO3SGfb4v8qTOIIgQTxMWEpm8KkG8CScIFYyB2qnjI/+2DOtqG?=
 =?us-ascii?Q?GaZlTVtrR4BrqE4bAFxBvQjsmHU6mNYmq6fROS7aL/UbVOriEEzprr8+7/XD?=
 =?us-ascii?Q?Pqzqo12hy5bzENTmSAxO1far5r/ez9qv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9fk8gjyKAkjlvV72MaNLH417fhLap7oJbYUfBbsX+6JoCzM3AOFIZY7+WEGg?=
 =?us-ascii?Q?IbpJX5CV/snV4Rf1DcQsXpIs83y8KQOCCezJDJ2m/ByETmEGIkdzSShOcZKO?=
 =?us-ascii?Q?rqYLQMHSQJZApvWc6t8+to9qV+b6Lioak1ODFIJh+362LdGcgAM3UokBSZhs?=
 =?us-ascii?Q?CLw3J4rgco5gMKC+tn2DupnbBuFkWwOXhLb20cVQa6Mfaiz4kiZMwywo/WQv?=
 =?us-ascii?Q?PZdCAlO6UpD1qapphfNPRS9UyJSL90NHMwXQSPUSoz3dW6fw70W0oVEY5n66?=
 =?us-ascii?Q?F5nmsZaGdYSkjSmAOT/WdaK3leWb+UzR6ATRnU7wygoreYFeTM2TrcAsQC+4?=
 =?us-ascii?Q?c2QTrCHHhmLQvDRALqFoGFM1z9lOTQwK8r8Uc9NLV0n+kTcNHSwmsrIsZnxi?=
 =?us-ascii?Q?EswWWWEs4rHSUSyzOCaIaF9KH50IS0gddFtWRjnn+9alSOKb0Xs0/UEtf0we?=
 =?us-ascii?Q?TXOIRAaaISOHlW1ttkHMGvASJsF5JHAjLL8u0dsxNwLr3cUxDLuDiKwiVqv3?=
 =?us-ascii?Q?VmEW1bZIW++7kfmoQufAIqTIr9urXJeUiKGpkfTKstRKF/GpY2nndxzmuHDw?=
 =?us-ascii?Q?c6lYcGBD6JDOuInxe8q1BRcY8FScQjLCW6OyJNI135CqdCR0rj6TO0pT1AeM?=
 =?us-ascii?Q?muOjk16EW6zflhLS0odMJXuz4iQNJetuJBzoxFJBeFirQNvpWEiEAgTSfcMH?=
 =?us-ascii?Q?zibtiF1DHTFBynfmuehyV64mr6+Kqz/eMucX3L06T2hwPBvjAtwoQwAT5ORL?=
 =?us-ascii?Q?B1A3Mgz20E4wVQe6AKM1r5w8+qV5jvHi2be/IbM8pDH8FpLtWmn9nIqH13vq?=
 =?us-ascii?Q?BVe/CLuNGWfzNEU+9v1Hm8/7GbJSP9VNIEbYUQh2INTjqJKh8HJbhhlUv+CT?=
 =?us-ascii?Q?2IoBYeeEPmQnNqG3pRr3K7IOYvtBS3cxdapfFovHGis1RFneb6yZ4xy3kfzV?=
 =?us-ascii?Q?y4Zlh98FAZBoKIhFIViKv7dk1V4xPTUYpR341/+Ih/9FSY+LGnBr3s69b/dK?=
 =?us-ascii?Q?J8q7BR6Ho1yRy+YUq84xnk75uCPhwgfLbNJ9AUY8LRpWzizfZ+fgL21kZH+Z?=
 =?us-ascii?Q?Nu7CvNnUjWLleDuFZ9iLgA1MV6Qc3DMZw6kJpaABPPATFJOeTMXy5npRbR34?=
 =?us-ascii?Q?xJBj6z36rQkYfVcshNj2jTHuF7A6cND+XX5afcNtNgvAe+yf3I2tvjxyfBHn?=
 =?us-ascii?Q?ZXvUtM8OBJRp3FBHyqEsyPZMV75YXzcUVwvLfvik5yFQw3tybdFDpxJcVWfr?=
 =?us-ascii?Q?dIz1p7fmsjfrgU2HYhi7txyvvfGUz4K8EqdDbIdNkUyXy2KyLAxYZJrO6HZv?=
 =?us-ascii?Q?McuqY5RECcciIHxZ4saTssuEtGpLzXwDipTREi8ssnWBCsN3iGonrH3mrhXE?=
 =?us-ascii?Q?k5T2nKZyCZBXxaPT584kr4Kaf3TG2uS40h2FqEe4sHRNXUdbb2Km4bTudJuh?=
 =?us-ascii?Q?Na4MPC9oJQ9TNMNdzaY9lkBKlAcwWc4mbzrOwyW0t5Rqx1PWBBJI7jvv6U0r?=
 =?us-ascii?Q?hAw/Y1BW3K+L+/1hrNXH6HSdix8p3jhQG4elfMcrYdqxKjR3udtu0veyd/+f?=
 =?us-ascii?Q?AXXUesjpQXO9YJZ88GzFhS9zw+iEg+1Arti4aEpFTJCH3uE6MKvrLq7EUiOU?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d024af0-8cb7-4659-ffe6-08de168cf0a9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 01:46:12.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dll3DaMCLpRGhK2jLUCVJKnYgSu0yYPZC8H0FMSnPgpch1W7juv8Vcgt7o1/LlphWjSt9r4n/dUp6WsoelJ8kKsjcDy3joP0Jcs0X/k3YBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
X-OriginatorOrg: intel.com

On Fri, Oct 03, 2025 at 11:55:09AM -0700, Dave Jiang wrote:
> The cxl_acpi module spams "Extended linear cache calculation failed"
> when the hmat memory target is not found for a node. This is normal
> when the memory target does not contain extended linear cache
> attributes. Adjust cxl_acpi_set_cache_size() to just return 0 if error
> is returned from hmat_get_extended_linear_cache_size(). That is the
> only error returned from hmat_get_extended_linear_cache_size() as
> -ENOENT.
> 
> Also remove the check for -EOPNOTSUPP in cxl_setup_extended_linear_cache()
> since that errno is never returned by cxl_acpi_set_cache_size().


WFM in cxl-test module. Messages like these are gone:
cxl root0: Extended linear cache calculation failed rc:-2

I'll second Jonathan's logic flip suggestion, and with that,
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Suggeted-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
