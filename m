Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008682248A4;
	Wed,  2 Jul 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499655; cv=fail; b=ICOUIw1ffjHW9Kei/ZcsVQtxzNOSx3dYUVVG6k5ZQ3DgJavBJUsLOCH22Ra+BfuVM7Bl3vcwfkM6t17cQq2R0L6bsFSE/v+648u8RDLWVgC97xow1NlfU3FvQPiMszFvK8YqWFoXDt6201oa2YhDnGE9MJclJFaO/yQ98BvS6J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499655; c=relaxed/simple;
	bh=03GXylvCWnGn4ojGx+jfvNeALQtdJ59T5UCraQvzGUU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i2y64nuJoyhuRJh8hoyEwyT32KTfmqI3CyTigWTvjNYYACeYQKfVa5hqC6rdHt+x0d0aHs/OKZRmhobTjcVzRF9ViHKZfvevM/sxMFZETIjMwK+w2gtbWAXmR0RMfx+2/ZdMUhineg9wYBZq0sfFERgJhyWSoYetoUTYEShe3Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q89lAC86; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q89lAC86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751499654; x=1783035654;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=03GXylvCWnGn4ojGx+jfvNeALQtdJ59T5UCraQvzGUU=;
  b=Q89lAC86JFW7Asu3z8TnKlHrRFxoEwZcbLwm2IhvMDN3RQDq8tHDuFJQ
   u261Q5wkzZISfESc+8E87mXVsK17lJ0/hWuDca9iKy/htjhuPDfXSTnzF
   kIJoYGs6YrfDn4eg+nADsjGUnpbrguj8pPJ92OoypBsFib3foEylkt7G9
   YqMDYZ5SpDNnN/aVBbrHiM4cIaH4U9xqb9ueHRK4639/lsDVzXyx0kXwu
   s5pQ8Yu6CUd78ol4YOLsD8YKi9Y1LOT7YZLNpuNupnVGJud6Y83nhP/Gu
   XEyH0a3RCosf3LYAgItunAGiDhEv6wd1DYE0YxTmlMVAIfPKzc50ILkT7
   w==;
X-CSE-ConnectionGUID: myyCKXM7Rd6uc/NXQvx8xw==
X-CSE-MsgGUID: xTPJ5ZB0QqKCfMZJibhcpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="52930108"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="52930108"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 16:40:53 -0700
X-CSE-ConnectionGUID: WBJgDGWJQ0CqNfknKZcCKw==
X-CSE-MsgGUID: j/5IjZI+RZKU8WvQSVLZcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="154959602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 16:40:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 16:40:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 16:40:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 16:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRYRpJXT5KHpVx03r5CMiPxGaiZLgNowhKjFzMCJMScMsr4cqw/cuzblryVWEjoM9mbGz1Mng5MMogvESXaO0mBOrEQv6hjMjDqR4hcsmDs44SrcRGfeJ+utm7ih+VfUmyRYCSbHpY6T8slq9lGuXLNSKrsIoc7Oo6QISNcLyVi1/jMGRBxiD+JEbQNdKBbW+GLj2alEIg8WS0LUQRrD4WKJ46inQhMIoVj1g6GtSH/0A4RM22dpJTMHKRV7iKdEwYhZRH/aCyKbx61egb9QeF10fgwtpUas2eywozqgWuu/jgAx+yHng4/KywHhZ8FQNUS+/3oGPs5ACOWJViOElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU7MudlnJvTgGcrCapP/CRc4O0DLKiiBU6EFk5Ub+wo=;
 b=FTrzY5q4uyzJ4TFHVYbWXQBiWvdDgITuwtEgi94TJCZPDxwElUWY5sbUqlh/x1aM6yPbpiIGN3w9Y+//+e1nfBLagtcKRB9cszt9ncMv96FceAhxaeZ8EgGG9tUGTkbUTWOUkE3lDtzpi6qFRNwJYNfF+F6MzvKlNMSudSWICn+WQTmDJYs+z3h3JHkSXvzmReBxtSNanUoarfGUZfCZnKrzvMNBDg/9OSYN1H3cHmpkEVmRDP1lGS5ByLK+8V6tsfVip8JZXYaQLi74J65PuoA90do5MarcyWwHAkFNw3eTo1qrtnkF8ApGjwsCFcYQyE6ySfkkj7ucSFSGCTKjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 23:39:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 2 Jul 2025
 23:39:34 +0000
Date: Wed, 2 Jul 2025 16:39:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, David Lechner <dlechner@baylibre.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, "Fabio M . De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, "Ira
 Weiny" <ira.weiny@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Shiju Jose <shiju.jose@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 0/8] cleanup: Introduce ACQUIRE(), a guard() for
 conditional locks
Message-ID: <aGXDMZB6omShJpoj@aschofie-mobl2.lan>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
X-ClientProxiedBy: SJ0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:a03:333::22) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: b41be93a-a702-4b49-c30f-08ddb9c1b302
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Wq7vBTw/05OV6fmllVXBs1eK7DepzG2tyYaKYzKxl5Dgw9Al6TXmcyfv3iF?=
 =?us-ascii?Q?cxHHxBCiXYpPfg0vzcXjUAXsmO2qH0M4zPblMyY28fJUmnIxY2sCxPmlCLcr?=
 =?us-ascii?Q?SrNU3+F96f8zh8nduyDRNWr6bd8FSiJ7xqf1HwSaGye6RM7rxkOWyTq24sPU?=
 =?us-ascii?Q?BI8yjBJZfDUBrOrQZiiZL3AkCqhtiq12xiuJyhfJa9JbTX9TnrWLXtGiLz1p?=
 =?us-ascii?Q?LNwVjDruj1RHwCFeqIfzAco9ZcCYgf0I3JZgOsnin8ZDTA731O0klobVNN+L?=
 =?us-ascii?Q?LbDalTOHWeS+KGrcTrkfwba30hP6b0MQrWnaXvJf6/8cuPduuIQauvreLhK3?=
 =?us-ascii?Q?Bw8YhK5yddI4KMy0fyAfchKDsaT75RRWy3uGoUBmIWBH1t4TriYdZL9IWXuI?=
 =?us-ascii?Q?8w4sjzXG+dlVr4KC1B7m5A/fT5IzMgyMBUFolHN8PCFMm/WJxTYqcxwhyMzX?=
 =?us-ascii?Q?Bgxs4NVV1RM0NFD/uqUS+ZM+n0XtlmYvYmh6kVcneIMvhGYSvBEVwuqqkRxw?=
 =?us-ascii?Q?lMUr4zRcIj3nW6xu4KxXYgWyPz5I0VwVALfccSefDRRXywtJD9h3TnipaHfK?=
 =?us-ascii?Q?INexhC8/ilPEW+2AO7BGeFgcTaLDGi5+AIN9Ss4tGoyBpg+gvXtESBEteiaP?=
 =?us-ascii?Q?iEQtiWO6eIlYht67PI31iuLzECXI8mNvOd8XkA7M2ZPWzG9af5SihS56LeVY?=
 =?us-ascii?Q?eTwIDhLw1TRrvkxFZqiksbvWM0nCMJNk3tYsCrlEJnpVcqVKJjxAlwSvEr/R?=
 =?us-ascii?Q?DXfrwHpcTH/aK+mJB9xtazIHLwptpgIzFq0/J6DVSNdwYdAGWpBcT+pDCwkX?=
 =?us-ascii?Q?o4Gmwz0su7e1Te+45vwFTslzUoCiuaC4iHXi1RNK6/wrqG1pVaH9C8p5Ec3L?=
 =?us-ascii?Q?kxLLoiNUWXGF0DniVMljIWM64hUA7px2vK2uL/TcfaC0REId6pBluwY+tSE6?=
 =?us-ascii?Q?Navu/JFi1GL2kxa4m7/ZoAZuUOAiyVjEqgyIrUqTezz6zbPFVQMkD98Fc7pY?=
 =?us-ascii?Q?rVD/e9YYYIrZlR8gWEtVzLjh8LGDBHirynBjbDdH1P0CsbQd/x1jdUMZEVnu?=
 =?us-ascii?Q?cHzcjcVAdLCXOJBHHhNiJC+kHJkKOzR6bePOJQM9LEFyMjSjVBolgHGW8jT1?=
 =?us-ascii?Q?/lZw96zyMzGPbhRngqYlblA8ORBqiVQcMXVOAe8tkn4mhwRhWZC6Tk5KA5oY?=
 =?us-ascii?Q?JOWy9WsTkG6Arlf3DzsrtLtehfZIsQttmyiO1btGItttePRiwk3GBs3vekOc?=
 =?us-ascii?Q?jRiD+QF7r0UFz3Z/zS2v9sd1cSAlwvJOm9EgzrIr5Y7atZMSeSiHt6KhTy5z?=
 =?us-ascii?Q?xUv3R9GAgbd9O/mdAwyrzCrKJdvaYdKR8fVYjvtgjalxiYticlzYcbsA6eaD?=
 =?us-ascii?Q?oVqutUmAedGJk7uaFQlnYfbil77PIKMdk7a4TDLvKksWQIBtSs1yL8oLldx1?=
 =?us-ascii?Q?eXcLu6jJ1rE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6vAlh9QQeRoYIpqpjpRfogaWiiF6CXa846xWfQiA12WDa8F35EzE8egvRlan?=
 =?us-ascii?Q?vaX4Phh6hl8ALxHchehrESlkF7NINlXdvt4qRJrcI41O4Xa5DW3gHoMQ3bdF?=
 =?us-ascii?Q?B5QC4TiXSiJ0rft0BrGSJxns5jF3OEbaqIHycL1yIttnINxOUqRzfNDQSeaR?=
 =?us-ascii?Q?ioAOIgaDd6MeQAg/DRRiCvSuqcEiUqXk39VpXNOmnAEM1EGwleXr2YTue7xz?=
 =?us-ascii?Q?dfuc16y3HFZkZDFpAX9Xn/tYknSy5VE+THVDl6RISLd/L/hU43BFWyI1Wai/?=
 =?us-ascii?Q?b/PsL33RDtgJYQOzVEyDwKElINRYLvxYtsGUsbuR5VOpeOwQTy5U4u9rwyE+?=
 =?us-ascii?Q?8Z/7TMiCdcHYScbX4Zgm0QRTwABRmhFy34cvjW35mu/j6aQ+sCY46Sjy54ap?=
 =?us-ascii?Q?lao+LJie5prN7kCoMNCFcA9vC9hd+qLVj8gqQSEPbzxwgz5t3JFZEiNe46m2?=
 =?us-ascii?Q?F5Htu2aaUFYopUTp8M9KZxtDn6S+Vn1ClWlm9Ksg/kfvebpCjhlinZBematj?=
 =?us-ascii?Q?14qr21WxeYrXkVGSqbcF+colgZIVMIYWvv1+SKhtToZZnc7/cMTWD2+FltcQ?=
 =?us-ascii?Q?UYtQaGHzf/pg/YgYzRPx5g2F6grVz2cVKEWM8dYrKmWd9M94WJgVF6gdNlpg?=
 =?us-ascii?Q?PSIGQVzA4r05sHzvsrClx0BEsYiojtjSI5Jtk/5wfwfghS1d0/6VjV+sI0jp?=
 =?us-ascii?Q?ivIjEa3t6R58d9kucf6y1MEhtr4DmzU9HNlY+WEMZqzbWKYHgMj+SP5R3Hh/?=
 =?us-ascii?Q?EvsfWpNW5nKv9+kI6tluJaqZa4N1MB0BpAZn1AaRi4PA7ucAjzIETBGsembf?=
 =?us-ascii?Q?NjWhC1K9v10ZdDasSh0fD4YQ0lIxWyaoNMWLR7Di8GDH3VmETDKFseziw6/Q?=
 =?us-ascii?Q?/Sol3u/7O24C0uLYyqpPBqZzRwyz8MtByGSBh5MwbwfdqhPHvyToMxHy4fzI?=
 =?us-ascii?Q?76TZsSfTYQcORaMjy7g4to8nTuQmtKt2brRXJip+BcIzF+R6k/HBvccR7A/m?=
 =?us-ascii?Q?/illxkeCGMSTTfNB8IuW/fSLvMXH8iI2OWwToCxL/Qzdl5I5O4ot2N2Ygg9I?=
 =?us-ascii?Q?eqrKvGrIwxiSNgX2VjVSyGSrzgPIIPu1AZvbK1Z3pQWPcTBlj3Sitc8Wyy3K?=
 =?us-ascii?Q?VPfCWmYexz1028tangg8/2g01gsUNMAqVBmjuwK0g2VRgD7Ztc450DRSzhbK?=
 =?us-ascii?Q?Ha3nEbrL1RcbpwTal78i+g/HBkStZHn0NWIplEKrhIyi5BMHc4IvLEGpHLF8?=
 =?us-ascii?Q?mmcGJ8+Czd9KwIRkJFl7tbcu/dgOkec8brYcZ6kMivhuC6CKpfa5KeHl/+UE?=
 =?us-ascii?Q?usbf4NL50wfUpPVlypPJCTnUZBHXz6VSHsr4ODaKyNx8/edpb5Yw32oTIEkN?=
 =?us-ascii?Q?Gqsgned01E5OIp0JJbuY7dnHFmO/jSlZDUOekineo/Rd8b6TDz7FQak5APLF?=
 =?us-ascii?Q?znokf0Rr0aFdieyP57JCU2sVXuwMzOA5eV0Tpg2n27E8UewsmkjxyBo1DrnG?=
 =?us-ascii?Q?CozGj68ZtFbuyGmLpcM5h29WktmS0OI98oumxcOPETFDO9j2jPHdr79YYU96?=
 =?us-ascii?Q?GQIyXte//0sftSTDp+Plj0vUP+lcGTx0+PrSGb09TTU8BK+aOfJVEhsnqaXW?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b41be93a-a702-4b49-c30f-08ddb9c1b302
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 23:39:34.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uYFJhnCvdwZq5f4rDueJ68+NuW4arrskCHK5aMJFFXeHuNO4EqGT1Yhm0SZDdC9G6o180c8jHvVz5Os9nSIQW2q1LM7KeZ438XHYBXrvkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com

On Wed, Jun 18, 2025 at 10:04:08PM -0700, Dan Williams wrote:
> Changes since v1: [1]
> * Peter took one look at v1 and rewrote it into something significantly
>   better. Unlike my attempt that required suffering a new parallel
>   universe of lock guards, the rewrite reuses existing lock guards.
>   ACQUIRE() can be used any place guard() can be used, and adds
>   ACQUIRE_ERR() to pass the result of conditional locks.
> 
> [1]: http://lore.kernel.org/20250507072145.3614298-1-dan.j.williams@intel.com
> 
> Note, all the code in patch1 is Peter's I just wrapped it in a changelog
> and added some commentary. Peter, forgive me if you were still in the
> process of circling back to this topic. I marked the patch attributed to
> you as: "Not-yet-signed-off-by". Otherwise, my motivation for going
> ahead with a formal submission are the multiple patchsets in my review /
> development queue where I would like to use ACQUIRE().
> 
> The orginal motivation of v1 for this work is that the CXL subsystem
> adopted scope-based helpers and achieved some decent cleanups. However,
> that work stalled with conditional locks. It stalled due to the pain
> points of scoped_cond_guard() detailed in patch1.
> 
> This work also allows for replacing open-coded equivalents like
> rwsem_read_intr_acquire() that went upstream in v6.16:
> 
>     0c6e6f1357cb cxl/edac: Add CXL memory device patrol scrub control feature
> 
> The open question from the discussion [2] was whether it was worth
> defining a __GUARD_IS_ERR() asm helper. I left that alone.
> 
> Lastly, this version of ACQUIRE_ERR() matches Peter's original proposal
> to have the caller pass the lock scope variable by reference [3]. My
> change of heart came from looking at the conversion and wanting
> ACQUIRE_ERR() to be more visually distinct from ACQUIRE() especially
> because it is accessing lock condition metadata, not the lock itself.
> 
> E.g.
> 
>        ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
>        if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
>                return ret;
> 
> Yes, checkpatch disagrees with assignment in if(), but cleanup.h already
> demands other expections for historical style, and a compact / limited
> idiom for ACQUIRE_ERR() feels reasonable.

Hi Dan,

I've been building upon this set and applying this diff to squelch
those checkpatch ERRORs. Please take a look and consider adding for
review in next version.

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c..193a03fa7114 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5682,7 +5682,14 @@ sub process {
 			my ($s, $c) = ($stat, $cond);
 			my $fixed_assign_in_if = 0;
 
-			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
+			if ($c =~ /\bif\s*\((.*[^<>!=]=[^=].*)\)/s) {
+				my $expr = $1;
+
+				# Allow ACQUIRE_ERR() special case
+				if ($expr =~ /\w+\s*=\s*ACQUIRE_ERR\s*\(/) {
+					next;
+				}
+
 				if (ERROR("ASSIGN_IN_IF",
 					  "do not use assignment in if condition\n" . $herecurr) &&
 				    $fix && $perl_version_ok) {



snip

