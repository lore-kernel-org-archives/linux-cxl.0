Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76C144612
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889079; cv=fail; b=gvJdDEDDbGtX6+zYgkAtCRsHTAxz6M8FTXZASoUNwJcomiHp2NFLSGAbNAida1/Riuk4mJ7RPseel3N2pFwaQLSex4/SEURF9EWqpd4kxOel1k+Ftz6iWjjWkQcAN343tcoN0a51tJb5ggIRN4AFrLfCdwGqkc8r2WxSYbZhZxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889079; c=relaxed/simple;
	bh=BHEQ1QL/nv1pWBu5dega2rcD9zGpFGI8hmsTrP226XA=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mrl7EwMewwtU+ReR3Jip9TePxlyy68arH6qz6aab1qSYjQP0mejg8JDEHv9Y5O55X45BPz03GgUFYB+1iiH6xH1RUu9L/1cYxSC0ZVGj73JbOgn6awuNN0tT0qWbDZnT8bC53NTdkl2u85/nihssQxmA5Z8pexNFeMjcOZLC65s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmnED8ZU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmnED8ZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706889078; x=1738425078;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BHEQ1QL/nv1pWBu5dega2rcD9zGpFGI8hmsTrP226XA=;
  b=nmnED8ZUe4ToQ5F/00C11WJXBFAJQRdE1ZHFn/GnO8C1Lo5OqM/EJHrc
   bJLVuFMS8UnDnP+Ro/tiaQkGqOk19I9/QXzOOWO5i3U5FKElj22ntl0vH
   RCAM+HycFy0bns4WQwZCq9Rzooijc+G9yLF2VWbuRHuKQ5BZKgJNnZJdn
   dFh6NQA/84+v4IDlsBJy5xLuvOczGNR0vlzqdrKheA0Ae/bcYmyY1byiQ
   VjaZ+ja4vqSKQSG7wC9zQThFwpmAnHOj7kQVOr2fnhULltu4xeNAH9i2i
   lOcvUUj8VNU/L5tzY7/Q2dtQcR6x+VJGkEvTZlanr40G6UrG+9SvYk/dx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11279604"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="11279604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="31198892"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 07:51:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 07:51:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 07:51:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 07:51:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 07:51:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJevtwrUZtWIyYExTlN9KBarOxARI7UgJ8t7InO+tDNE4094o+YZfq8x44l05sa/b2w1mR5xR2BakmqofOYHwMrLN8Z7WC3EaIgwAq2DZ6KcemZ/xdijd+EqqsxVgh5SQSh6GP9dXmATkzNUB0kyBuSUf3HfjQVmPOWrfoCI+1Y4dXGCDPa7QO9BehZFg1KJSGR50nGUe0d53DpOlNhMxHTBhGzFF1tqn47PtU+KoGQ7CsjbC25HpADw+ykHeBtpCRnIPBOxIUZcY2KwWNaLFz5p5/UpPsqm3pm+c1I6CSRUwPqPuio0cvjQujiTHtxiNmZuZVxa4PY0xcrXncIIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMXuQw7wFbc3bZW5mr/ybOfqFn/NiP+4+UnhRT/mxD8=;
 b=SPH+n4U0E3uck7zYUVV35daryxJlLCn88p2zlQEcNlQ3aq4WfYFlv9sjFgp1rpyGTZN4CvJxGtKghrxEZ2Hb097NnjYHw5cofj/3qln+ghkGkSMrjAV0sipZHBLBD4IXhWK/vA0FDTiIhWEszeE+ZjqDom5QA5/WJU8fp2ceeMRy7b8BdeNXwm0G3wsiElHGtRuLpUlOQp8tkUYnQ2+u1Nr1tqVTQ4uORzLvrZIGYlX7ehz089jTARyzhha1Qez5uU82qLG0W0VVAf93XGmARq5UqG+hPcte+KUpERWIRc2NHtCJRbxGz9aCpoV+OkIRWqYE0kLW/tTwr9cehrKK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 15:51:06 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:51:06 +0000
Message-ID: <d9e09c9b-837b-41ed-a0a5-be740ea5481e@intel.com>
Date: Fri, 2 Feb 2024 08:51:01 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state' *_perf_list
 to single 'struct cxl_dpa_perf'
From: Dave Jiang <dave.jiang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Wonjae Lee
	<wj28.lee@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
 <CGME20240201214822epcas2p3062089e1281f483fb26eea3c80a71475@epcms2p3>
 <20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
 <65bc7d62d42e5_65b26294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <fe311247-ba59-4e42-8e7a-e49abfb9cc3d@intel.com>
Content-Language: en-US
In-Reply-To: <fe311247-ba59-4e42-8e7a-e49abfb9cc3d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW3PR11MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0a17c4-3733-4ff2-57fc-08dc2406c42a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHdbgDPQFIwi3DdC48Ao5RAs2gl5wBwI7ds6PDnmKaq5Z7eQz7K7AyLMCmZKnZtVM2NYL4SZpA8il/XrbRzY6Gu1mamWkEX7FnivGnPHZA6LhlJ3RSJKif3oybf3RJshKgehZI51esN72SYkhES+LUW3EsdsdWz4A3IqQKO26SGhfJewHUS+I3uhOc8t4DHqR2W+fYIkbSj3b9ba0K2WOPi8rawX6uED06Tq1kHyUoaBMtDoF9oRY7XA5KRIoFGYVyC82YSfcDg6Z0X5tyJbIwZxmVeXHp6EC5BP+64BpbwYJE9ep6znRfi7ANM/5V0SOGUcZY8pglWpnVIFJ0Vqrxrw/nxIbtvoX05pvhv5rOfPgF61AFClvCNW09NtH2GFm/mzP7Vya0VDB+3S8Tl4/Ok1EWpT76uZwkm1yQVctKejGUQax+8IURWqcjt3Xnve2lHt9KkslpaCjVB8JlidWhB9M4tqBl6tM5BhhUmCzwKr4Ueu62MWgtbAaV/n8JeFbC4KZaWklYkKKmDAGULsmIYSnUxd8/+qXkAgyKFlKYb2NDimWO43fGiWf67bzN6fhXu0fo9SSWiQF3l6LvCcP11vz8VJf5nxxsb/0jY8/Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(2616005)(6512007)(38100700002)(26005)(4326008)(8936002)(2906002)(5660300002)(966005)(66556008)(110136005)(6506007)(66476007)(66946007)(44832011)(54906003)(478600001)(6666004)(6486002)(8676002)(316002)(82960400001)(53546011)(36756003)(86362001)(31696002)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0tHTTRJc1B2R0VqVUE4M2FGT0trYnlySEwySzc2eVJxTzBsb0RQaDEwRTFI?=
 =?utf-8?B?T05WR3FXOFhLbjgvaUJkRUEwdGVKNDZRRTNwcnhhR1VUb2Y4T0xPNzJIUFdJ?=
 =?utf-8?B?am1kTWtPcHFaZldoZFpCWk91SzAzeDFQbDJnUTZYM3RiTEhUZXQ0UzZFL3Rj?=
 =?utf-8?B?SHNMNTlTU1hHS2YwY05MbFRyeTJRNHZ3MEN1YTdHOG8rWnYxa3k2Q29meTdj?=
 =?utf-8?B?UGY5RlVPMU5VYjd1ZVFtWXlmdnpnVG5PUk9yUFg0M2Y2OWF3OEw3WmFVZS9z?=
 =?utf-8?B?ZGRwemRJaVJFTllFWU85RklvbkltTWFVWE1DT2c1RmlWQWEwVTNHZEJiQklv?=
 =?utf-8?B?S3VxUlFyTjVSZEQxdzR4d1hSMHl1U3h2YXRIM2Fyb2l6ang1RHdmWUlIT2g2?=
 =?utf-8?B?ZFpKZGVRSXI2d2J4TVgzOFJSamtVS1ppVUh3cVhVOWdtZ0pGbXpPclRLYkpt?=
 =?utf-8?B?aEZzTjU0bUNDR0UwYmF3bzFzSWVhL1ZTY296dDhCNG5EYlFEUkpnK0k2aFpy?=
 =?utf-8?B?bVh5Y29zZm9xbkNOam9Da3RWTHlzejIwVjJJemh2a20wR3ZWNjlZV2RsT1J1?=
 =?utf-8?B?WE52NnBwRHpTQ1Y4Sk5xNjVkdlNHK0R4Z3NFYmh3YUZNbnJQeFI1TnVEWTRS?=
 =?utf-8?B?c0tORWVEMWtDbGdaM2tlckVNS0VPekFSbzNDWjhHbmx1bkNtcGRLK3dLS3Az?=
 =?utf-8?B?OWFLTHNWRTV1MmxucXNGeUxGNHJLQ0QzTjFMNEp6QW5Jei9GdWMzZ0dXdGtZ?=
 =?utf-8?B?aG1tbE5XRzErS3hKT3ZqazN4V21DWTNHWG1TaHloRWM2TzhiOU9CcHdnSHFM?=
 =?utf-8?B?emd4VFR1bkt3aGovOG5Qa1FZc1NKUE9tQzU2bmxtdnRPQlNhL2w2elFSTkFj?=
 =?utf-8?B?M1hJK1J2TGYycksxekxhMjNrTXFDUGpMUlhrdVkwRGtSK0Z0QnM1aGFhZW1G?=
 =?utf-8?B?YnREU3lBTVBJT0dTOEFjTXpQYlZNMkRrSkZJR2xiMm5aY3p3TERQTHFITTl1?=
 =?utf-8?B?ckx2N3pNdFRSQ0RTUzhXUmdZcDZ0TUVqWi8zdkQzdjlVSmdWT0ZsL3RmbG5M?=
 =?utf-8?B?MVpYa2JSaE15dlI4N3hCSEd1eDNibEMzcXlOaVMrRm4vUE1TZ0dEY2R5YkZp?=
 =?utf-8?B?UGNrRHdyd1orNkZ2am1xYkJCeDBiMmFtOU8wenZzdndlL0Y2MVYxMW5GREpT?=
 =?utf-8?B?bjE3eW52TlZ0R2hqcFpFMEV5enZYQThocU1Gd3dRVFR1L2xKME1tNnQyYll6?=
 =?utf-8?B?ait4cVZNcFB5aUlLL3Urc1puK2dTMWhQc2d0Nmd4WWhSQUNZUDRUZDdybmxr?=
 =?utf-8?B?VFhGV253M3pEMHVmWVpCM3hac3gxemFBZFVVdVpSNk56WVNZT0V4dHhvN25W?=
 =?utf-8?B?QlhmUDBNYWgwbDk5MmJzbndHZHF3Qy9iY3lCV3ZHcTd4cXBRT0JCaGNyY0hX?=
 =?utf-8?B?OHVHTnNpek5ZUm5ZY2YvaEx6R3lYZjl1S1diYXJTVHNPWEMrbUVxOXdhYlJE?=
 =?utf-8?B?b1BSZ2RHK0dtVzBMNHZmcW5nSkw3OUFPckt1MWhpaVhKa1d4VGIwUVRJYXVQ?=
 =?utf-8?B?QS9BVEEyY3dBR0JOaFUySFcrWVFuSjEvTndMdEhrT3RDN0lpdWp2eHZDWnp4?=
 =?utf-8?B?Y1JJR05rc2thNzBIODV0RDJqMHdvWlc3cEtjNFczMGFpTG9EekVPMkVpUnVP?=
 =?utf-8?B?Nm1HbW9QMFRNMWRpVHI2YnBOZHZWRWRUT244OXFObTZmclA5Wnd5OGVVaVd3?=
 =?utf-8?B?RTZqRDBsMGl3R2xVWnJ6cUNXaXk4YWozZWo0VTNKUFlPdGxaMXN5NkdnalZF?=
 =?utf-8?B?cW9paUV2RXEySTc3U3JVK2xDclliSm5TRy9TRWk1WkF2aEM4K0ZHQ2Z1QVlG?=
 =?utf-8?B?R1hXZGRXL09nQURiWmJRQ3RjdVAzZlJnQVk0TTBNem5uay8wUXp4UThkTTJj?=
 =?utf-8?B?K1ZPcDYzSml5UnhkeFc5ZWtVZjQ3d1g4cUJIdGE1SzRJZjVJTHdOMUVrSlZQ?=
 =?utf-8?B?Z2hrd0txR2xYZTluekg3a2pwdVpUT0tiazBlcVNOTHQ3MkVKZ1d5TStEZ3Rw?=
 =?utf-8?B?ZHJ5QkJmb0ZaQ2FVcU9GZytTdE8wamdjSFZlaVllS3lyTnoyR2dTbEw4dEVN?=
 =?utf-8?Q?VskkdFAwxWPaiP4h3CDrYxYEJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0a17c4-3733-4ff2-57fc-08dc2406c42a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:51:06.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuxc1mGicXQ5U0+sbNIFDeLITWQXIXAudBODcWWYoD6p9YwOkgAvPl1oGaAZtrFSl0UODPXsGIFd2yAyBmVL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com



On 2/2/24 08:40, Dave Jiang wrote:
> 
> 
> On 2/1/24 22:28, Dan Williams wrote:
>> Wonjae Lee wrote:
>>> On Thu, Feb 01, 2024 at 02:47:29PM -0700, Dave Jiang wrote:
>>>> In order to address the issue with being able to expose qos_class sysfs
>>>> attributes under 'ram' and 'pmem' sub-directories, the attributes must
>>>> be defined as static attributes rather than under driver->dev_groups.
>>>> To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
>>>> lists, convert the list to a single 'struct cxl_dpa_perf' entry in
>>>> preparation to move the attributes to statically defined.
>>>>
>>>> While theoretically a partition may have multiple qos_class via CDAT, this
>>>> has not been encountered with testing on available hardware. The code is
>>>> simplified for now to not support the complex case until a use case is
>>>> needed to support that.
>>>>
>>>> Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>> v3:
>>>> - Add to commit log about simplification (Dan)
>>>> - Remove check for dev->driver (Dan)
>>>> - Remove check for invalid qos_class (Dan)
>>>> ---
>>>>  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
>>>>  drivers/cxl/core/mbox.c |  4 +-
>>>>  drivers/cxl/cxlmem.h    | 10 ++---
>>>>  drivers/cxl/mem.c       | 28 ++------------
>>>>  4 files changed, 33 insertions(+), 90 deletions(-)
>>>>
>> [..]
>>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>>>> index 6fe11546889f..55b82dfd794b 100644
>>>> --- a/drivers/cxl/core/cdat.c
>>>> +++ b/drivers/cxl/core/cdat.c
>>>> @@ -293,24 +270,25 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>>>>   return 0;
>>>>  }
>>>>
>>>> +static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>>>> +{
>>>> + memset(&dpa_perf, 0, sizeof(*dpa_perf));
>>>
>>> Hello,
>>>
>>> I think you meant dpa_perf instead of &dpa_perf, right?
>>>
>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>>> index 5c93bf9d5253..7091619f12a9 100644
>>> --- a/drivers/cxl/core/cdat.c
>>> +++ b/drivers/cxl/core/cdat.c
>>> @@ -272,7 +272,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>>>
>>>  static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>>>  {
>>> -       memset(&dpa_perf, 0, sizeof(*dpa_perf));
>>> +       memset(dpa_perf, 0, sizeof(*dpa_perf));
>>
>> Good catch!
>>
>> ...or even better kill this function and just do:
>>
>>     *dpa_perf = { 0 };
> 
> We need to reinit the qos_class to -1 as well. 
>


This should do it right? The rest should be zeroed. 

	*dpa_perf = (struct cxl_dpa_perf) {
		.qos_class = CXL_QOS_CLASS_INVALID,
	};

