Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF982941C
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977965; cv=fail; b=bd0kDPaw6AMYz8wzyLPfQraRMvIPlYyGskqsErwKnjXrB4krWRHPU36H38Z990eewzvQ1N0SWEx4k1Mq9sJpEg+xLJedK88bkriuhG+Z1BHeLqzzQWFX/upMWfJj3m4nHZ51gkhDEYRgShgeFD6baUCrp31jEvGNpnhc6CEL+7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977965; c=relaxed/simple;
	bh=aaDgO1SxOOaNvM65ca8GbRSohyAdqnW4wUnEiPt+KgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rnD8QaBQuVf8L56cSECEaA5qBJiitBScjI7F0ij70vOofDeNBQEwQJH0jT7peebeN+LgbBqsNEeN8GoK1VRv0jagqTdxNkR6qGiGFN4lZnyrD9BOnDXQmrkwGjdvIm7y+U1ZNvKcRuPwijupHazVvZ8yWf/4kRLoanxTIxQl6J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gK0PWofd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gK0PWofd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738977962; x=1770513962;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aaDgO1SxOOaNvM65ca8GbRSohyAdqnW4wUnEiPt+KgI=;
  b=gK0PWofd/KYlVmD+gaQ0CBdvR3iw2ucoTJ1eOW8hZxJjpfk91WqGSeUB
   JsAEAnqXPaZs7afN2AP0GFVj6UD1IVM2R2XiGgXl4fziLpCjlPcKQWqyB
   qsx1r1qeKw3vnL1jx2JN80GWmuZhMxV+Fz9jgsyOnZ75jFP/czHjqSbFi
   oPEjVEsjRw182wOmZqmsFQilgGvfLtGAQe8LUldV/eaoSFTPW7rDTh+0c
   3k/hbua2zUC6jTakiEgX4EsJ2XDAxMCVsDEklgQtQnG+myQOx7KAHir1l
   U7/hJ76yw4LWoxZ/oab6ng1URQKIp0TuuJoNG8CGK6ojkp+XXea2xzJo7
   w==;
X-CSE-ConnectionGUID: woTOIxMeTjSdDGNUdra/fw==
X-CSE-MsgGUID: ESHHWR8jR6Go4lEfhnI0AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="51018030"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="51018030"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:26:01 -0800
X-CSE-ConnectionGUID: nrM+A4L2Qiuvn2v1BXHuXQ==
X-CSE-MsgGUID: Wr2ebSewTci0vyHIqKolfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111604587"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 17:26:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 17:25:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 17:25:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 17:25:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHWdjswi/G+g8wZc7F7Vjq+vKmvWtHpUQTDiEdEnMgYH+yjDMLPqQJ7HCP6nOKzWjfRO8z6MOdaflFK7Nd6ZbqhXyT1tGm44uFMpWp+pYQoearRol0Jbh/fg9qAMFADZX03PABMXrArFTekSdZB8U2FzaE/06WqS4/hfAPMvyq4BCbQdxQmLwnlzUDI08GQPXGif7xjE9cJXY6oXAlXDEnGz7AUN1zK6cXBoyZFMVZ9J3VFl1YzxX71S1MWmMt5ITn4o7s+hDNtwIcl7guI+ANLVk3gEZ4YI/GRHMZWaM6O3nX9BRFj6NdUfmm/bqEdkjTNsvFbldw8PRnI2wToniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8ABg+LQscFF26H8fnQ6vsVmHeZJPYiCAVv+zrPJCak=;
 b=vXw4yGZrji7q5b3mRix1xNYOs9+GlJy3BpqOAQCj3XeRjWnLCrqzhOHdpCksPEDxZoSqkjlLAtPU51Obqe9gKjY6Pxs4iyj7t1CpRZvXcXtQaJ/GmfhWx0UKNsef5Ea1j6fRISKuBfrNON7/A8qHlBQcMFJJfsPSvFJfhPNVv/t/LW4LX7OKaARpX8AW5x/3sOcUbx7qxJFCpflldQ0E6wtdSs3dVEU9Ci+9RLI41DfRpS3DRabJm+0NlcWNGzHrqAUuY2PkyavKAfMCFRGwVMYHQYgrVh62Smrwt3DSLoTu52f5CP27E0BHjIOaFstxHdFQDEOU3RWd/U4XRY9umQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sat, 8 Feb
 2025 01:25:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 01:25:55 +0000
Date: Fri, 7 Feb 2025 17:25:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 08/15] cxl: Add support for FWCTL get driver
 information callback
Message-ID: <67a6b2a16d552_2d1e29483@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-9-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-9-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:303:b8::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: c889b860-d172-490d-7a37-08dd47df88f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UCIgr/fILqgKe1GwCjdWc3ij7EMExMxziJiKsh2VBmHMuFUHCgaaRoGx83I8?=
 =?us-ascii?Q?naDmf0r3wMLrYq0C5sxx6EppEM0WbGSrDxEFpw200+K8DfJyy5jcX+SXbExv?=
 =?us-ascii?Q?XYNpU97Hv+td8bs8b12+rnRcYSRspAyaapcSJ6Z3TbF8821V1wLJjcPHAc/W?=
 =?us-ascii?Q?iF+NW8g1LveIoGd1zY5tL1DTwieHo/C4/AOMVZ4qR9oVEWVKPOWwDpsVDhZf?=
 =?us-ascii?Q?I6waybYim4hvpP07prkNwNKCxyELZKAjOamOw+UX6t4JF08OIu3WpMjcT8wo?=
 =?us-ascii?Q?nfIbEx9Xcar4nevhPimhkNKsYCsmReoLao2XUWOXUCQDfEeaAN2hKNnWzqRA?=
 =?us-ascii?Q?NYT7BTdrSiARxLQ4hH9dmHGrlbxBHcJ+fkmD7O8phwUErdvjNZb9XYEYG5WG?=
 =?us-ascii?Q?VMOQz2ZFdsHVHBDIYbKo/HsorDRR4r6kVwbRdDq8KEuxSM8DcWxMirHv/mwV?=
 =?us-ascii?Q?UXl/nVEKIZN8Bgjvvj/CeQCbYl6eNJBjWhDNIvhJazT7C6DT6fP+yBG3lhff?=
 =?us-ascii?Q?wvT0p3FNk+g0J1R8iBXcjeP+0FKQf3EMp05nJlBUJ9ZtwSwBjyo/4QtjLnja?=
 =?us-ascii?Q?B36VAzk+0CA6n3ge/p9PO4YISkVt7TEWy1wn9KMl1AHVEzz8LCwd333L6X3C?=
 =?us-ascii?Q?G4oRgJfwuAdNrGekH/RjDMNuLh6DyqjIuvFNBLra781RQ74r4DWbQ2B/I04B?=
 =?us-ascii?Q?yu59hHtpQeBl1svobKBwl+a6xJK7oAjyPgRP1WUlph8yr1jhQ1zFO3HzTkiZ?=
 =?us-ascii?Q?rgY9MUghjZK5qIOTO/efBdtyh6evcu6umqwl9zkLJk1tIXqcMjR5ilGkumHg?=
 =?us-ascii?Q?J3f8sJ54Wcf30fPrlRJSeoEowMZsmLn7BKRd0NttnnAgx1MjNYpUovMO7cuM?=
 =?us-ascii?Q?Sl6J8UAS09SM4GsdR9xAWU3HJYIUOVymCeuHhg2q69liyI0GFy2GEPc3bONZ?=
 =?us-ascii?Q?G5e9CMukodOduwAMCQv9PS5vhQh4VRt+AGnLyWNgaEgU9ivFWYrMoj5meGyx?=
 =?us-ascii?Q?QIo4szuoOzCQuRXNhFwsTw1raUGaoSZr3nvmk7KwEDMfXh07sJTfTJvhazMw?=
 =?us-ascii?Q?pIKVCGOPNXQBuznzvc0ncPHf3MgnbqdVmz2YJpjHkoHBUy2NRiDPlqrvcP+A?=
 =?us-ascii?Q?5vv0Gt3cYDsDx0KD3MmHavafFqDEs5V77eWWXXLAMAg7I/5PgQalQ1/pa0iz?=
 =?us-ascii?Q?qMsWAtfW/bJpqLGL5WlgtZWh2LkhRpu9m+50sflf+z1SqsIhMu4I4dp/baE9?=
 =?us-ascii?Q?TywqKVs8M2PkXTngxs5DmtTXrpHTjEppBapwIVsaDfbMlQojs66hdILl6YhI?=
 =?us-ascii?Q?kxB5khmkRu3HQaUsT6W/P/AqXuk00gf5QfTC6sdtT/xBTUgL1wv+i8eizPC7?=
 =?us-ascii?Q?o9MRzUYH/yuMvOn8e/Qx+z9OSmL3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IppGKsGEQMz3f31blvB2oebWZEFKcNEjNmCR3b9ps6nd3BL9xo7O5suSM73F?=
 =?us-ascii?Q?79CwyrvG1KHZfKZmLkVRqOeCqbYS+k4s1iyyC2EjBboT8ENaAl4Z/g6JKb+P?=
 =?us-ascii?Q?YThP2sT+lmImNdwNUyKTFtw29FF2tpBZDEmfBmA9L0oRHWi8O5hMsvx6okEv?=
 =?us-ascii?Q?GzehkD3KRQ4Of4Ww910jzGCpIR8i9iqQ6K5NDEKxj8YbLzConqm04jhWZSTv?=
 =?us-ascii?Q?bBoTp+VZH7yafzpTD7QXMoM2rvQChej/Pm1nvvKMtYEFAQ6dmWy0e8FUwAOV?=
 =?us-ascii?Q?qMR8RnFrtP/5KLY4Da3uWLVkDQVixtVL+WJpHOhleysi8mqzKqjiEVlBbsT8?=
 =?us-ascii?Q?JkNhPEUZxcyb3OjsukSz3T2PrVgos3rLWqT6MS7c0cUPR32fQETRyhJus10V?=
 =?us-ascii?Q?TR43Sgfm3mTy6dTNlDCQDIqhPmGDLG9ypoOmYNzRdGj9GSHUFS5GLQvaVU2q?=
 =?us-ascii?Q?73OJpVZNLxXfLUaLJ95YCG7yU2tGFG8Zb+xETX2vk6/oQAvd/BgjrGhXt513?=
 =?us-ascii?Q?XNWm+xYww8E0r722baH8Y9bod/ahqCu0Ufye9ptQzkBbhKnsT0vMPx9PfG7I?=
 =?us-ascii?Q?vGsi8QOZfsbH8eM4tv+aB33Dh+ptOodMarW92wIY+U1U0a19yOOpf8vfWoRb?=
 =?us-ascii?Q?9tbrmZejS8toFUd33Rabq6K/NnpOntkNsjPghHr9nU2PMN2XlUBVvTvtYFxf?=
 =?us-ascii?Q?gBVlfyKYCkbn5TnlfaFCR6Z0Js8/ewFxmUASJ/FiA+X+4wBb6KrqSEvDDt2V?=
 =?us-ascii?Q?oQMypgxdkiJKeElXp2PDHgXBlNPU6H/T5mkD7Ir8FncOwwYGkpqe59RWbf+i?=
 =?us-ascii?Q?wE70MVX2m5naX37U+TbHgdkx5UqfDqi00f+PIuuw3pFUHJhPphcfakFi1Me+?=
 =?us-ascii?Q?ubBhVkbNfYPTNYxW/5rhJ5fLulJUdSqQZAkCRH/oQYg5w6R5YC4dsVSIR0oX?=
 =?us-ascii?Q?tH3hJu5QvuaxXtHfiLvI/MSgJLYFIppD0W+++IxevZa3TFEkUMI683hV+w4g?=
 =?us-ascii?Q?tF6r0IQDbp8Mg7YHdOviswoKeJmQduqb1Qw8m+KvGf+MCBX+c0iRURM15EMd?=
 =?us-ascii?Q?AjBUDqfwXWu48iE+spo+CgDWRDEcBEH/LhwLRqnufU/ScWF+70kTU82Zm9S9?=
 =?us-ascii?Q?dhMb2Y3MpO8ahUyoLQcnFXYrDZm0iBkvjM9cC+NkREcwVPEHkanuFC0VTl3n?=
 =?us-ascii?Q?RfudSqBgSsEDyIYcjxw+f7F59WyAezLtfAFEtdAGbf294btF1kTQUvANG9Q/?=
 =?us-ascii?Q?xacnCbhFDcLH9llL/XOYL99MReHoHZDsNI6f7GOiirdqDvhbljJdugfhrEq5?=
 =?us-ascii?Q?Atj6h1Ek43ta9PhVTSjKqyF+LuWefWsEuVVN33kblhCk3ypwiyjQfuDE7x8H?=
 =?us-ascii?Q?Dgz5Pml+YL7/DSFxfWWiwYcTsIxTKlcMfP6eH751mpJ1AH/BVopfdsZHbsaU?=
 =?us-ascii?Q?kJxeD3AS9Jsc0Ehx9Nm2Ng2dWxBRsjS32jCHB4opL54bFWK4yWH7JZhad3Ms?=
 =?us-ascii?Q?BbJ57KKdqHKh1tysTgOSQ/Jdr1Yn6nTeJ0wxe8pGgzatYtW22qE2090GlNR8?=
 =?us-ascii?Q?Ewloaf+qVQtA97z9m+h9SuQ5+94tB+2DBVOtEN5gykt3Z76X9+LHnbL8GMsI?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c889b860-d172-490d-7a37-08dd47df88f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:25:55.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMvX1Gtyt+PIbh7bXDdVAX1TF5NO2AgvyGX/Hyffigop/41VHVDPev2XF+f139M9PJcliVLkQRwHUazKybF/uZMkIE6J4j+oqeLFVsgDsmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add definition for fwctl_ops->info() to return driver information. The
> function will return a data structure with a reserved u32. This is setup
> for future usages.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
