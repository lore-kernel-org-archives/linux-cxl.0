Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526A8614E
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015090; cv=fail; b=lyNpGf42wTIRp91QlyCsVFE+utL+GQsfiTtXOtwtSxmj+BaPolxtPEkQwXi2nzcQUpvLB7QA8NhsMNJGaa3SzEmFjK7iu06HkuSosmp0XgixiqD23I/u3OUzZG1aGVBS6ArzNZ7+SL5iD8d7I/fLAL7iuEoJRelPSWxsLaxNcdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015090; c=relaxed/simple;
	bh=b7iuCbdhgIojawiUWHHL3iOLAgAGmZg5B3H1S0GzvSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fnDzOAKPVrUtRyOGzVNUVJu1Ywwa1ex7hcQefIlmNq+S7usNJqi2+B8ZDu1txMCm7wDSbMPBS6fZABL8JoZUmxPtDKxpJSzv3EAoBhQwOh7T25Hn3gkiNvGJHUu/0hD73jQqI4Ek3D9hrhIuJJrBmGZpPwAvn8GIObYUhdES9RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6q/6D28; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6q/6D28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729015088; x=1760551088;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=b7iuCbdhgIojawiUWHHL3iOLAgAGmZg5B3H1S0GzvSU=;
  b=L6q/6D28tklSHX9m/nMZk+DM/F7B6YjxW3Grdr84OV/B+LuasojwwqKA
   JAJ7YaqhlO7ghs0mCd1SFkfGxfcsw93fGI5HBKnSQA5hCeKdXE1mK7qCQ
   4gWTMOgDLwNCw/hLNsE3epvr1M/eyQlRiA5Kwr4oL5c8nFHDzkGz/DURd
   8wfffocQHH6XtIFclwvODTKKy5064pMBchYjMuWW0wrHrMwP3GYwj7UAQ
   UD6UNG1cOwhyg3aPSJo+z0mFKPfRc/kT8bLAUf9W2innvKC6lq1HJ7gJ/
   CkPA71/ZvWXj8AomuoRMIp+7EuUMv6VPFk3RAeBcC+q3Wt1ogmgxc9v4v
   Q==;
X-CSE-ConnectionGUID: Pilqt8MBQYqux53jc3oQLw==
X-CSE-MsgGUID: ZGduZt1jR8SVBhlQjOaVXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28557100"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="28557100"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 10:58:07 -0700
X-CSE-ConnectionGUID: +G6f6+0DQ/aI+yEsBXrNBA==
X-CSE-MsgGUID: g8cQxcpgT7Ol2kNoZuMJAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="101300335"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 10:58:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 10:58:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 10:58:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 10:58:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 10:58:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr6knNMm/3mI8a59VH9tvSbmBKA4NyLJYpn+qS2q0QfQWTHvF8mxbRCg9cR2aWipu8v+s+v8yg0U9tyv5pCB4FjZda+PKZQtyWbBSpwFgUyindt8z8FU0WuUtnJCT5rcLeznLuodIs2LqLRPdTOj6qkdZOc1ff82rkIhWO9hgX3CshBVv7ogPmTSkiqnf3NKKlZFEAJudZ0+kDC1gaqt74VAVqon/NevWAzAOVC7kHxDB2z/0SEMaJ2cbrSAoSOawV2Iwcl7ja26ox3U9t/CzRVl6ottb4Nli4QOxdswtBdhWKmSNQB5OpwTwUolo+uNpaopuX6NZ7XMHAccY2joAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LM4WDeSZfA5OOME/PLp+tXc56pLDgQ0w5s490skGJU=;
 b=XGE8P085gatJII+rew1/2ZeOYeDLMTEn3xPGEKBIMS6395jkFqlTULYqxBUJKl41jLvQXXVdS1CzkLyNOIY+VdEfHGe7Z/G+jAboV30fZBtWhyfhifgJ5PCeT3TLahMrYoOza49Qw2ymPilejp8zxAa+6e+OOfbTgowEwp/weeIaJ4k/2mAkaN88OZpWJ6luLWhPkpL1BIQOTa3ZBAuiAUQ32keRQD2LdsJEk8HCPR/QXdUrsh5K7eEFQnhkk962ufaczpOZgLQGJ24PiZzQBQ1zZPlaJWMcBg8XaA9+mz11XJcmGbyX4DigyEt4d2Ig+VLDHJWdLXtrIlGXwy1FBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 17:58:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 17:58:01 +0000
Date: Tue, 15 Oct 2024 10:57:59 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <670ead2735632_3ee2294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
 <20241015173642.00007d1f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015173642.00007d1f@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c1eee3-8dc5-441c-de4b-08dced42e8ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K6ugnFB88p9RZARRC4oECKmrfPp5Kxzm5XPrF+6mcl2GkNqPeAuOmDVi3X9V?=
 =?us-ascii?Q?YcDq2mK79n4MKnTZQ+ua5o97Kvl8ts3IMTjdRgneStTO25N2XrBs695nxk7N?=
 =?us-ascii?Q?DTUu+gElQx39/+xEKmaDiUZh3L/VfaeT8iclTRXvDL7VqsB1o2cGNLpXbts7?=
 =?us-ascii?Q?tHKktUE+NelKwNfLz9+X8guaeRQR2i9xIMHqL4Fde2pmHWlNBGalRcd13iAu?=
 =?us-ascii?Q?V3BPK0zFUpDRubpylmZ2aJdWsreNM5KCPdGOa0quKa6JSkfY7Am+i9BFlZR4?=
 =?us-ascii?Q?E0adx3P+sH9kn43qLjgHdQU4l9Ep0WxMaNI8Jk35ZdfhPEzFJyNbDZTFk3lg?=
 =?us-ascii?Q?ISEyG4LUHirSBs5qcYkaod1q7FoLKbgGxNo/lwd5A43dkvAg9FPWJBhW9UJR?=
 =?us-ascii?Q?hASSd7a+Z28Q53RZEesox9ma6Y24cdHUAGWrHZgJ85BhPSOjTXq1xVRJNoH9?=
 =?us-ascii?Q?8OP3CTdJ9e4fmELtlKkhGU0OMt8wxWn7uehmJ7kZZcEpLrPeTSu/pRIlepbD?=
 =?us-ascii?Q?YBJ2IGS5uoqFkDf2qo7mm8oOPDdxwXxpgwPNwCaAGPo2f1Z4uZPInSt1IIjL?=
 =?us-ascii?Q?2U1ycGM8gziAsn/sRNOujg5HzmDny3xKmw3Ybkk3wQ3cQPcZjB3WS+5WmIrY?=
 =?us-ascii?Q?FhyU01HOiZmQ7ql6TEMfzUqrJkqXujNs7OhaOV9ZyaE8beHwgf0ylQ2bQAnn?=
 =?us-ascii?Q?/qd7LvMKo/GN1l0UNBOLZ6Ug4mJFfO8y9fns0fYsEB9HRPodGP9aqCj7KIh+?=
 =?us-ascii?Q?GUjQLpygvy2TsqipfvE/GEf+DeuVNjPeTEVDHCFka0UfSfKrG5nxanxcFsbA?=
 =?us-ascii?Q?iKn550gl5IF0CCVK5SE/llSsmq6bM7G3Jj9V4ShB7rx+jN/tVp0UbfX4hMMX?=
 =?us-ascii?Q?/0budbPeDeDSzmYfBqzpQ/+LZTg6q95QplrW+J6iTFEfGzFgTguyziFR0Wba?=
 =?us-ascii?Q?hmWhHPLbTGae0tgsd7prgOw/P6rMcRDCOWRscz6TbHFBx8z10lCsbgSOw/p0?=
 =?us-ascii?Q?bq1p+MTlQwL5CJcCkZ4b/hCIVAS3NTx5IemX1HXoGtyFN7zk13jvNQ6vrhKY?=
 =?us-ascii?Q?SM857K2hHw2hwEImBmccZNcB9wkyCW9DlePXOibTUukkgBu8cEt+9G5mzFk0?=
 =?us-ascii?Q?jYCH2g6Z8ZQbDhMcR7yOyCD+s+pi4SjJdyYfU9/9ldKd/kNoGFpGCnI/ivE1?=
 =?us-ascii?Q?omZ3LLMe6YSKA0n8y3v/Csb3DO3mFfomZ+WmL5mBtgUVI3+JmhwBQnM+nUbK?=
 =?us-ascii?Q?OlnG0f7IzJcwfNSErNattv6y/zFASHWtnlWd2Cltbg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJ+Vckdiui3rLPpfbtvT4wZSeDl//hnKIQNDsnP5PSFvPXFHsqWALAiafaBJ?=
 =?us-ascii?Q?ODDVSGtljVJf2By7fwNYTrYTZTtATvYU7ynVNng/oVoxnVpO09Hb0eR6wKY6?=
 =?us-ascii?Q?1InqH9+gPU8B6lGtNbw8roPL5URZRPjQBKPc76uN+5SETMljB8vMx76vviwp?=
 =?us-ascii?Q?Z4AlMRnpY+Z26BPe6bahCrpknqi2BfW2+Yn1vml0uAEiQtLjVQuXxtyJccZx?=
 =?us-ascii?Q?0rVAUN8r0e0jJpioJ+4xjxpks4oN0HVqmNM0d1zPjxyVmw9I5RruNk4nfjJF?=
 =?us-ascii?Q?/tIaHqJqcwvYE3j/gTPUtUWMWFniPBuSRgg3ULxnKLjWYkrRB/CkycE/CTgE?=
 =?us-ascii?Q?R2R6+ZwDbNlA7YpMvvWxaiwP5/C5S8xzCvnKN2ujRTUOd4jNmrBYnwskMhBl?=
 =?us-ascii?Q?WJHr61WShM2s58wq0PLcS/PtlfteSvxAsHN/QmV82g3utkbw+HAmc5MSzy43?=
 =?us-ascii?Q?DBUPPAzIuijvJhuidHE9Dx2CptYvS4XBbuJpflQje7gRuNnbtupqahbBZJnU?=
 =?us-ascii?Q?SERnZJwtLs6MMRqBwX/pL64zNa74DEOAmL1MJNoAMSa+p6DelO4tjqu7Br9Y?=
 =?us-ascii?Q?lvKOGlTdQCYmHcIRJnbnrp9i2ZurUiKNd/kiACvcUT35wquMRPUIzbZweIiI?=
 =?us-ascii?Q?DGEQOJgIMCeVFKwxA3/BOc9IrTelKdCBGPM45HGo+ZCVjcPA5Ot8FjNLeY3Q?=
 =?us-ascii?Q?K+oHCAjwi1cBRbh92I4V+DqNW6EfirBsId7iFE+zBmfvSHwg49TikzcNZqJs?=
 =?us-ascii?Q?GYixvy2Z5hfpCCrHjRus/fVq5avQzmb2n7PP+h1XlOYRvb13VAQdacHsAQjj?=
 =?us-ascii?Q?wvxk8N+t0fqjjZhAYM7/Sj8ajT8Wfbf8z2WWZyLXm126E1OQtv0dOhQ0bmq9?=
 =?us-ascii?Q?cXMFdWbIyfBBz8wXnht234vM7PL9JG69Zw51VHMFPQZDP2W57TCsxuYSt5b8?=
 =?us-ascii?Q?TNe7bTEqIzF5JGXUNIHzLYnCx3qY0PczLJMyxRdMeh81lYyvhbrLLcdLlLoJ?=
 =?us-ascii?Q?ObOBtehz5kyEmJWoFuPEinp0z8FIEiy7WPdOudCvj4uK/iYOplOivAvRzjWx?=
 =?us-ascii?Q?Xh8r7ZgSsn+ZvfM3bCz6snoXcRbM9S3MCWPhU+QwHIcLSrLyynBCpbbX2RAC?=
 =?us-ascii?Q?b0X6BshuSNEX5CUnJ1hAiESyBQwYQZbPHg59TvkxiJsMTm4IrGg7roRQx//y?=
 =?us-ascii?Q?rxJri17zvGOzXLXEkGNXa1plT1TBLobu1rsk486ir6znzBPnDgDq2ngKm0G/?=
 =?us-ascii?Q?7qcTlcO65NtlQPJz9Q3ZoqF5XXq/ep8PBYkN10n+1pp2tQ/RJILhWic9BDO9?=
 =?us-ascii?Q?NkWC8+Muj4gbNUuuKxHJ0cDIQLcfc0mGA3mZOVz9uQ0fgbSnbRzzFxCggzKi?=
 =?us-ascii?Q?znguiSZ8ACqkJAcJuBq0AbJwWloR5cgQ17DeIvEUttCjjxIf5szeB7ARyxdj?=
 =?us-ascii?Q?/XeGFwaeE3z6lz+Oqp1vJnysI73IcWTog97rUSO45S/EGcrB0qRXSnPtgEso?=
 =?us-ascii?Q?EllWgw29TBltAnaQRqwAp6bredFAUcvOjwn58Vu6UVI8RSB9qMh01d2Vhjoo?=
 =?us-ascii?Q?wS6kwqP28YLgvyMtyuKqUSdsIXm6n6M8JcpPeuBtqn8VVDuX6bVKbE9do3Jw?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c1eee3-8dc5-441c-de4b-08dced42e8ff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 17:58:01.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzTMdhlC4vMQdZdjvUJ0ZqXt36qr8G8GpF4js30eZImoh4oClUM4SuoOwvsmaK5E8tZh7gAnVckoZq2fv44RwVXH9MWrcOe1PBvVtMQvrxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 10 Oct 2024 22:34:10 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > It turns out since its original introduction, pre-2.6.12,
> > bus_rescan_devices() has skipped devices that might be in the process of
> > attaching or detaching from their driver. For CXL this behavior is
> > unwanted and expects that cxl_bus_rescan() is a probe barrier.
> > 
> > That behavior is simple enough to achieve with bus_for_each_dev() paired
> > with call to device_attach(), and it is unclear why bus_rescan_devices()
> > took the positition of lockless consumption of dev->driver which is
> 
> position

Thanks, checkpatch spell check miss.

> > racy.
> 
> Feels like should be +CC a few folk related to the driver core, GregKH
> etc to get a sanity check on if they can recall why. +CC Greg.

I went spelunking through the history, and it just seems like "it has
always been that way". The callers have never seemed to care that
bus_rescan_devices() was not a probe barrier.

I considered creating a new helper called bus_rescan_devices_sync() that
uses device_attach() internally, but given the limited usage of
bus_rescan_devices() throughout the kernel, it did not seem worth it.

> > The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> > is merely by inspection since the bug that triggered the discovery of
> > this potential problem [1] is fixed by other means.  However, a stable
> > backport should do no harm.
> > 
> > Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> > Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Fix itself looks fine to me as it will check the dev->driver
> under the device lock.
> 
> > ---
> >  drivers/cxl/core/port.c |   13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index e666ec6a9085..b7828b6c7826 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -2084,11 +2084,18 @@ static void cxl_bus_remove(struct device *dev)
> >  
> >  static struct workqueue_struct *cxl_bus_wq;
> >  
> > -static void cxl_bus_rescan_queue(struct work_struct *w)
> > +static int attach_device(struct device *dev, void *data)
> 
> That naming is never going to be a problem :)
> I'd prefix this with something more specific

I don't immediately see a problem since that symbol is private to the
cxl core. Any alternate name ideas?
