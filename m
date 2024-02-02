Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A61474A0
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888461; cv=fail; b=B2nanJ69WT8G136z2ypmqigVDQH17rgxj0pjuIeEoKqcL3D/AjZCbdRKlPedjrEnNwm31Szdywi595lH7KBJsjfiztEA0MTfyGv8YVhEcpuY/X2+iVWDcGf752ehL31bgXNaO9fsqegzATaHAIUXj2Mcp4nN7z4m4ZxsuoohAmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888461; c=relaxed/simple;
	bh=F+FHVOnxsn+L+uHY3WnltO+x2FFMYRdo04Q0Pg/c1Sc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mIlEN8tkkbYgG+03YqLDQ7HTohyrEGmBy/+cKHIg1K1aK9go006qrAdOnwS1HEN3WEzdHCNwTsAd70TaG4cogQru5s7WmuZQWDQ9fQEpN6sjbSjVNtKexSVMFNBhu28sIH1TNkks6xHbE/0hVAx+gLEyhF4w1rGT9f+xjSIuq+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMJ1TFVh; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMJ1TFVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706888460; x=1738424460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F+FHVOnxsn+L+uHY3WnltO+x2FFMYRdo04Q0Pg/c1Sc=;
  b=QMJ1TFVhvAbPfp83pLQvpCwMbJXe1gsfIWnWTAZgP7zkVWzTTLzhvV4d
   Xmi+Kd4McwYChh6pKHY4dI6l+AWtmwdlnur0UpKJs5P9Wmia4ss3BGNwk
   GH6aYbpJpLWjtvdqIxc7AM7VSe4BSPXgmjG+vO2ilGXu+bw7bKA+mJF+n
   rPa8f+YeQ1JaGSJYQsArA9tktPLvXHa5mrSKmtk6CWQR7elx96lB6P/6a
   vFq0rXlLJOb160CMMI7kERsBdgt42XIlD7N2nRfELp+ANeNwPa/ZR5KXB
   H+/wnE52ZzlLo/Cm+0V05JNjAUV1EOCasOqUbiUUWwI+sRiC9Jns0ZABn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="364901"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="364901"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4701366"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 07:40:58 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 07:40:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 07:40:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 07:40:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM95VlMdqU5Tt7BjH1Ar+Tp+WyR5gcKca32+W7dq9nemfPZ547nIu8SDqCmOfmEodtT58EQOv1LvjgG5Wb3fdVlIzdzYy3ETXyt9DFZPuxY6F+lpVbRcyLZsFkpCsmHZd+qnidRDEZ01Mut7c7zYTP74P+56rh+TsVN86siSuMDasq2CSdnBZAT6DY9K1CiMEbuoO/BCWi12NGt1IoUpq4cGp6lXdZ6XIg3J3JczX0/ieIwQP+7C3/ZmHHRW/QBrh9+19NIWyQuon2xJ37nNQJuaG6jifTNP8s1U9vAf557GBhw/tHxpIMzE2QBAP440rO3wvRXKMrlozvC91ZFPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsQpUTnrdKZUq+IA2Z3/affhW6fIAiMnZzzfJs1DJCQ=;
 b=AlEb5BE/BEp/UrcREE2KHfTvkC9OpO0oUXTWbd9qkkkvrkjyv//PkjtV6Qqlk8/6Ldh6peN6EIBTHyKHhYGRsFwOq/X/5yO/ya1TO9jvdLx8LCW+1ysNNrcIvaUAYuON4fcWrQrB6wXd8ntJEC5Fu0rF0mtlEMpb38tS+ba0X7db3bJqdzY0xYYxuAfe42vLPXITTn+EEhDfb0qbyY/dUxIy7QLS00mnMdyurUS/ii9+Wwrp7MXL6nSr78AUARv7EdcSyuJQVjHoqU6UwpOKqw3/f5YjbOzBb0CqgVQrtGADOb5tuUI+LS0jq/jUvvSrOgGmnq+4ZhNekIEYpkh7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:40:55 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:40:55 +0000
Message-ID: <fe311247-ba59-4e42-8e7a-e49abfb9cc3d@intel.com>
Date: Fri, 2 Feb 2024 08:40:51 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state' *_perf_list
 to single 'struct cxl_dpa_perf'
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65bc7d62d42e5_65b26294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH0PR11MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b843de7-7eaa-452f-fec7-08dc2405580f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USqqLR5+B5oUGVJcTr44SB/iAfLpdglb20UdU/3ougqBWxWGaSLfb9+X5hPIOmmUWQR6/rCVxj+2lKbUnTv9znu1iday6HU1kgxB8NpslcaqpyJI9k38TJ8UhhJ5BdIN2wBqjm5jpoYOouChVZxrtkIibj/Y0B8PFQHnlPUi028QMkg9XlIAokjdMOC9Hejs7NZt3wQJpP9GuGjIFy+SmGZoXcAVv6hQDbxKsa/1zXk4S84zYoTHSqjrHZ9zXqsyaVZ6S+S1AKoWK7yaojloTvP2RSxDXwh3x4dOULqXtl/bS6afK7jTcmK/+ZKmcImMD6JHouGRUmRobrkAiGbXJRXwx83fiFzzQ17gh0F86zEVRgtBXkQczlwq5HIVtJnG4f4Io1mdYCkuTDZR9+LsinwvbhwnAGzBu8TRuodd1fjX91KHgi7zOljxuX+nnsqI0q7MOaWGnJxqV0I4nrhgKEjYUVxKYACfBKc+/K78+2uDNATqI3fZJJ9MU4PnPHYc03KRnb6iqJziLwKtUDxvvbWfs9UM7Jq5tN1OGHvKi1Fby1M0bIiTswtZqEUEn8V72X3G0NMZc9isQq+E7C0e7GfXfTmYbid070ej8FOuqzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(44832011)(8676002)(4326008)(2906002)(86362001)(31696002)(8936002)(110136005)(5660300002)(54906003)(66476007)(316002)(6486002)(478600001)(36756003)(38100700002)(66946007)(82960400001)(53546011)(6506007)(6512007)(966005)(6666004)(83380400001)(66556008)(26005)(2616005)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjhyUitFKzEzQnhGYjA5Z2lOSDdnOGp3aG5nRy9CaUswNk01REJDY3FSaTJ0?=
 =?utf-8?B?ZjRrcDZBT0JvYVBWWUFqNWRhSkNtdzRHeG16SWRHY1ZBZW9JOFNJQlV1UmFl?=
 =?utf-8?B?MzdzUzI4ZlRvM2NLQ3RUa3ZKWnNSc3RUV0ZHbXNneFRVYXkzSWpIYXBreVla?=
 =?utf-8?B?VTNkaS9vdUw0UExaZlRGbHRVaW9BaGgrcjJSTk1ybncyL09ZRlpjVFhCazR3?=
 =?utf-8?B?dzRLT0p3bG5oNmhGWUFIZEVTY0lpU2hNKzhtaTZ5RUlVNWszZ1F4RHRoMlE2?=
 =?utf-8?B?TEFjNWx6NjZOZ1FWLzVLVXQxc0haOWp5MCtJYWttY3JGelVrdzg3T1RpYVRV?=
 =?utf-8?B?TGtSdFRSSVJ0YjhVNTN3MXNOcDVweUhyUmdVa1lPb0FFWXJMYzk3MVhkZWtQ?=
 =?utf-8?B?a1E0ekFIYTNDZHNSakw0VEdpWlc0YVJEWG9pWW1PMkV4cGUrS2NzcUo5SWJE?=
 =?utf-8?B?RVhtY2NCbDJnNkNIWVVhYm53UkpHR25CejA3VmJIenJSWEd2MlR2bG9xdHdP?=
 =?utf-8?B?d3R0UTN4dXlBRTAxNTJWTk9MbUhTWUx1MVFVMlAyZHJobTAyZHduNlpaM21C?=
 =?utf-8?B?Tnp6WFJJT3p6VVVzaTlia0VzUFNaMGVHTHR4RGorNm9lLzZMd2JJM3BNQitE?=
 =?utf-8?B?R05FZFNCZnhTM1JIRG5jdDFEdmZ5YTFLU29GUExoQUJndk5MdGJBN25vMWRM?=
 =?utf-8?B?ZTZpK3JtdkNHeXFoV3NpU011MXE3ZnV1Ykc3SHpFNENFZFJDZ1dJMlptdndy?=
 =?utf-8?B?ZktpZ3NTNTJDRG5rTW1Oenp4TDBDS1Y5aVFTR0hHUUM3RVBkUks4bTIyUThK?=
 =?utf-8?B?MHFNZDYrRnFQRzRvQVp5M2dQeWlWcDlMZTJLU0dGNEYraFlIN3ltWUNwSnNH?=
 =?utf-8?B?UEY0dTlrNzZIazVrVUJKOG9wTFNOU0dUdmp1aUFzOWFkUUdMMDl5ZEM2Z1dV?=
 =?utf-8?B?TUJtSmszRmNZV3p2T2x3RlNKNm9sV244Q2JGUyszL3ZyWDVRcFVuK1FrVE9n?=
 =?utf-8?B?QitHU0xLV1hyQ0s5NHEvZDdRK1pZQ1R3ckhyTC8ranJEYmdtQXo0cXVFQUFq?=
 =?utf-8?B?MTFzV3NhZ0lQOUt2Snlkc1NjRTB0L3ZLZUl2OE5VSjR4UloxTmRrYkxRWitV?=
 =?utf-8?B?bUI1aDlPMEU0R2NOUUZYMzBkdmY5RlRlTDFJZVFBQzcwa3FEcmZVUG03WVJD?=
 =?utf-8?B?Sm0wTHk4V3Q4S3lnZHNOemRZTmtoTFpQbEV2SFhic2JSdDRUMERSemFmZ3Za?=
 =?utf-8?B?UjM0L1FnWVd4eVIwWWxsajhCeU45Sk9MSHoxOVcyckxRWnk3REVFeFhWcStY?=
 =?utf-8?B?T0IzZXlwa3dza2kxMDhRMWFpV2FVS29ZOUtMUFVwcXpCQ29US0orbTdRMllh?=
 =?utf-8?B?UmhuOXNLYzlSYzRicVovWUFGNzNvaFExbUJhNkFaZUpnS2pib2NrTmd4NUhh?=
 =?utf-8?B?QVU2M1FsYTlCUy9kQzN6SVc4WFVNSUFmcWx5SVM5RS9hbDNScmlPOGpFMVBJ?=
 =?utf-8?B?R25hek5SR0FDbTJyRmFMY2FHalFOQVZyZjQ4NzFwL0JUZEUrS2Fqdm1WcmJS?=
 =?utf-8?B?ZVFpSzNNeUJVZ3k3dVF5a3VTU20zc0p6c1JUSEZXdkNtbVNoeHRIZ2tHNkxT?=
 =?utf-8?B?V292T28wVkY4cTBmZk9ROEZwMFpDNkQ0Q2FjV0ZEZHhvVEQwWUdDUDhMclNS?=
 =?utf-8?B?VnRVcXZOWGlLMHNNZUxUQkp6dUlwd1JXNXY3ZmFoMUZhbXVCNzJONjNKdlh1?=
 =?utf-8?B?RTQza3YybVpWWmpoaHRMTGF4dldiM1FmRzVRa1VuRkhhbDU2cDRXby9LTkhj?=
 =?utf-8?B?Mlh4SHN2OHVoa2g4eHlWd0VheC9pWSt5Z1dMYmFRdEZjV2hnU0Z2UUNnQnJL?=
 =?utf-8?B?QUFaSEhiK0xXd3FmTjlaVHFhMFFkZW4zOUE5WHduRjFXdjN1Ykt1MUQ5WUk2?=
 =?utf-8?B?eDRqamwzSDAvWHMvRmxsS0VFS3dPTWpjYWx0eVZOTHZtTVdIU2ZCMFRwZUM0?=
 =?utf-8?B?aTZOT2VDRnAxQXhLZHdSbHFTSEJDUGNhMUo1OHV6ZjdreDZGVm95SFhzbnI4?=
 =?utf-8?B?cC8veVdKN3R5WDZJb21uUzFyaHZyWnZIU3lYQ3p2aUI4ZlpEMjROV0kvemxX?=
 =?utf-8?Q?DldE0TtEWy+ygN5+6QcxAbxDj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b843de7-7eaa-452f-fec7-08dc2405580f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:40:55.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+oXUksBjH3fIxTUsJyquUNHDCr2nGEvo/s95eOdjXBzk/2EI7xZsdS98NWAo3obowqrA40wULUEiaLDEZGkzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-OriginatorOrg: intel.com



On 2/1/24 22:28, Dan Williams wrote:
> Wonjae Lee wrote:
>> On Thu, Feb 01, 2024 at 02:47:29PM -0700, Dave Jiang wrote:
>>> In order to address the issue with being able to expose qos_class sysfs
>>> attributes under 'ram' and 'pmem' sub-directories, the attributes must
>>> be defined as static attributes rather than under driver->dev_groups.
>>> To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
>>> lists, convert the list to a single 'struct cxl_dpa_perf' entry in
>>> preparation to move the attributes to statically defined.
>>>
>>> While theoretically a partition may have multiple qos_class via CDAT, this
>>> has not been encountered with testing on available hardware. The code is
>>> simplified for now to not support the complex case until a use case is
>>> needed to support that.
>>>
>>> Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>> v3:
>>> - Add to commit log about simplification (Dan)
>>> - Remove check for dev->driver (Dan)
>>> - Remove check for invalid qos_class (Dan)
>>> ---
>>>  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
>>>  drivers/cxl/core/mbox.c |  4 +-
>>>  drivers/cxl/cxlmem.h    | 10 ++---
>>>  drivers/cxl/mem.c       | 28 ++------------
>>>  4 files changed, 33 insertions(+), 90 deletions(-)
>>>
> [..]
>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>>> index 6fe11546889f..55b82dfd794b 100644
>>> --- a/drivers/cxl/core/cdat.c
>>> +++ b/drivers/cxl/core/cdat.c
>>> @@ -293,24 +270,25 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>>>   return 0;
>>>  }
>>>
>>> +static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>>> +{
>>> + memset(&dpa_perf, 0, sizeof(*dpa_perf));
>>
>> Hello,
>>
>> I think you meant dpa_perf instead of &dpa_perf, right?
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 5c93bf9d5253..7091619f12a9 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -272,7 +272,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>>
>>  static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>>  {
>> -       memset(&dpa_perf, 0, sizeof(*dpa_perf));
>> +       memset(dpa_perf, 0, sizeof(*dpa_perf));
> 
> Good catch!
> 
> ...or even better kill this function and just do:
> 
>     *dpa_perf = { 0 };

We need to reinit the qos_class to -1 as well. 
