Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696541872
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888354; cv=fail; b=X67wLKwdP/7JXhFBSV4ne4P6WIwQJ8iDq67ogMW58B46w6F12AZ7qR0boQOJs1JOy7wB2TCsX00brcSqgXLKWc7vLZ8bpKzP46g9lhcLoQcrFZJYLJJ1A8/U2G9bMjYf/jt9BpEhMzR+M9dQSd20OBihnv0N8ygePO3qxtZ/L6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888354; c=relaxed/simple;
	bh=qKRO5P970GAGDnaZxezlyEhlr19sd9pwvnblnxhawGE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W1IQF2LnxG0j05/TukxL33Sv4MoNGjjn0w2raczRkx9FR6t4+AI/J7JzZauTKg74S1CEhWGeQvlvB65toQ5c+BBGSBKZAmvFy0mFl/SffRn//9+31NppGfrojGC9KxD4aerv+JoWiyDAgdrf4O6iTwhaHptU7FAdF5RZw0CUgUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwnSQiyM; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwnSQiyM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706888352; x=1738424352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qKRO5P970GAGDnaZxezlyEhlr19sd9pwvnblnxhawGE=;
  b=IwnSQiyMIzMO+8lxMeK4l63PEFZbf2Xtl/rsREnWeC3a4E9XFWiJlIYT
   tnQDsLPoCQLNh9pbVgg/+OJQxDrVhkNiGN3YXogLhU2JJiPx8G8nVenjl
   yCcxNwwy88HJz+osGSvsc4ofXOg7uG0QbFmlOa/I/WERHr5EoB/7f4Lxz
   BiMpjGYW25CtbXXFKXD6ejVPKy8AjbOr/fcnKPFY6p0hV8E4BXTcsxfBh
   VsmjS0CJfefGHVTUImDZ+Az/MgdI59m3e2XxicC+2qZ6x5yNsdKJdKAmg
   NOxfJMiZ3pz4jS9oskzE8wnL5h6A+ZsBv5en5TdTadWHd5lYCgCxCH1Zo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="351560"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="351560"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4847147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 07:39:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 07:39:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 07:39:06 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 07:39:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOzlNx0kOj8LKVSpb6dmZaksrnGT8yo2ossp29nruB+th1OqdNhsWYxrIbM/jfnp6r4oimCbIhXwlcl+T6R3CCduSQa9JDJOyOwLEtmfN0zRxC/bRRq01XeNWU4bG6PksZ1qXUfwkXLOw4gfuoJ9K3Iu/EqKttbR5OMe98x7e/w54XQsov5/Blc0tS6/IP4mzA/6XSpoEv1MqinKoWdTXNt3UnzoJlQfKegeKax9Dyln8gdqKaHkbgP05ldKDeFoy55MzREfkCazUsv5pzZJlX3wUnHfmHKBH/9xPd0UMg/Aeyn2NtYUIniU3cs+UGPbZnbWmuVG5Jd+BH8am7/lkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyzxxo4WbVsWTty5nYtNmjzi6ew4PhPOAHKPAlZz8Ig=;
 b=UsUnOWYU3rYz0VMKz8yyz3pUk8aFgS8JBHPpcVYmwlLTMtjIcNkxB4iKQgrLkJ6WwA0qfTogPSg8PAnSy3cFpSyo/IbBJl/EnQRyIRLiEITk2Or1INISmeWENIP5a92pEKQ0/uesJj5s1HaviNj3+DJ5jAWwF/eM2GYJIc+m5ivtAG+rj71EtuelOymrE/y51/gjYGht9cvwdaji7FsEaEUJDJSNbvTY+i58BpkTMjMClusJupXJxktBxZwxFYdVVB+ikdTh2jW2jIjGKrfd4TDX1RE6Dn/wMU6mpniw8at2AgXCk7imCzzXLY6LZtjVjwJ0kTp7rrg6jTAyRWWhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.28; Fri, 2 Feb
 2024 15:39:02 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::c403:9b0a:1267:d225%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:39:02 +0000
Message-ID: <354ca78e-6bc4-4e48-b070-f0093453026d@intel.com>
Date: Fri, 2 Feb 2024 08:38:57 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state' *_perf_list
 to single 'struct cxl_dpa_perf'
To: <wj28.lee@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
 <CGME20240201214822epcas2p3062089e1281f483fb26eea3c80a71475@epcms2p3>
 <20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b027c3-b9f0-45c8-43d7-08dc240514b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4hymj5sZegCjQBsabwaxOjdHMw3542Mxr7ySXmb2emKZvUjA/pm7NUTm358WItOwZhIdxFn1BXzbzbCVMEGeVKpvfxz7J3msbBnp9VRuktUxaX8Kt8YD+n3ajkISzHd9/HJSt8XwDMVS+LoGHJUkl2fTXh6pPvB8avUK4YAGI7EWDni55vUziervdPkC9+IJMYL+mS0pNRpVn43Tz4N67g06EnR80sNBFhyEVtzuK+nXZXoN1TzacJF5aubjTp6Dpr6ygpk6lK5ZnsphWqLOp81XcuKgi2FwalKQbTM9PWpx9O468P2mDVjn2gvToakwZdeUjscujAAdfLdh+bhH8B4o25UOAZ/Bhf30Q6mLXOYzeqEQC3DRX9aIkOx7YPyJNZ83Qh0RC71R3SHG5s58j0FWO8/AX24I/DUCuJlwnp5P149pel0kovh35sepllsY2Xs+eMQVGE3YlnXKcWMDBfz8lWg4HOTrvGsuIqc3hBfkYnT/7xN0rSrvIANd8WOjIV7Mrw2vuSHrEL9+LAeJyo7XJobKyurG3wmNL6ZrNCx02rOetdgkUbF8h2POB2loE0BuF+OMpYV3aGkWIAxvXv/1hZT/bBU8qLKk1LnN9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(66946007)(8676002)(8936002)(4326008)(31696002)(44832011)(316002)(5660300002)(2906002)(86362001)(66556008)(66476007)(6916009)(54906003)(6486002)(966005)(6506007)(53546011)(82960400001)(38100700002)(6512007)(6666004)(83380400001)(478600001)(2616005)(41300700001)(26005)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBwb1RPbHgxT2dvWCtlWUVJM09KVHBoUkFVQ0lhemtIVXBYMkxReC9IR0xC?=
 =?utf-8?B?Z3Z0WXRLaEdkbEl3M09PQmVkUjd2QWdZVE1lazZwU1g0RkFzbVV6aFY3Qm16?=
 =?utf-8?B?ZVNYS3R2UCt0TW44ZDRFS1RzM0xCVGRYckFsbWM0NGJPMm5sM0ZnekUyMWty?=
 =?utf-8?B?Q1prUG1uSWV0RTNsMG9zcWdKL2VZNnFjM0hTbVlMTzVVTElvaEIwT1ZhSExm?=
 =?utf-8?B?NjkzRmIwU0xGemQvNjJzS0hjelQ1ZGxibURkYk5UUFhvMmk1VVBjaXpxamNv?=
 =?utf-8?B?VWRnNHVYd2hKRit2U0gyOURiT0crTXdWeWpCS1hSTUNZdDgvbVlXNDg1N3Ex?=
 =?utf-8?B?MDZXQkJYSjI3RzVHMlBvb1hsQkRrcWtKQVV3MVpVeHpEWjZVaFp0am1FdHBk?=
 =?utf-8?B?UkI4ekR2MmtFWnQybUVuNzJNd2J2ejZoVmZTb0JYZjZzbnJtY1daKy8wVHFF?=
 =?utf-8?B?NXJjdHQ2MWJka3FmVDc4T25IRi8rR2tRb0wxbWw2YXpNVEVRTGxzSlJvZTVX?=
 =?utf-8?B?QlJDRlhyY1RXQlVHOTRha3daWXlldnQxbS8yczBiMjFvT0pXUlY0TmJGbVRB?=
 =?utf-8?B?VEUrS1ZEQXFqSUxmc0dkWEtyZGc4Y3FqSklsVDJuYW90b3VOSzJrN2JFNFJF?=
 =?utf-8?B?c1U0N0VvSGpQZWU5NnljNkxydnBsbDc2VThjaXp0S0ZZWFNPbHdrT1p4aDJE?=
 =?utf-8?B?eVc4VUpxdk5xZmtqWTFBK3ZaWlcyOVFCNEljWGxrbFBPQ3c3SGdDN0h0OUJo?=
 =?utf-8?B?enJnSTdVYzc0aWF3VFN2M2hDYVduVGl0NEZnOCt1bmllZzRuNnJaUXhqZ2Nm?=
 =?utf-8?B?amQ2dWZMK2VZR1l6am9HY1hGeUR1Vm5ZZTY4bHF5Mm8rRThjWDgvNytWN0R3?=
 =?utf-8?B?dmtkVkVXNlRmMTMzUUh2SkFMN0tnbVJYaHJac25rWU50c2dyRVBiK0hRUDVy?=
 =?utf-8?B?RUlCT3lDTEpPOE50bE1lOXhNOC84UDNNcDAyWnF0bXRZTERmZFAyc043Yk5H?=
 =?utf-8?B?SndtR0syRjRCVURSNjg0MHFlaVBwTU0vNEg1WkJSMGlOdStnbThYQmtib0sv?=
 =?utf-8?B?clJRa3ExdWF1emkzSUJpaG9qT0VNamEvNEg2dWFKUW9CRjF3ZEZyNlQwNmkv?=
 =?utf-8?B?OTRLNU1rVDhFMVlhQWhlWWNzbHl6RkVvekRVdnQ2SjdrZERYeVdLQ3krL0h1?=
 =?utf-8?B?d0lCbXh2d1E0MGlkOWt2ZHpPSlVuT0ZWRW0xck1jc3FxUHdZS3hNUEtVRjRE?=
 =?utf-8?B?RjZPNmZZVDY2YWQ0Sm5hNjM0ZTVsVnZKaDcwQjlmb0JWemlhU2dzVEhiSjdm?=
 =?utf-8?B?Uit2MTNCVWRTdkczbnp0aDVuRExqTlpJY3Zyck83TVdwNWxKbjk3L2RGb0tL?=
 =?utf-8?B?Ym01RkNOWi9MYkdxbTBCOUxVd3BzVlFZR1ltNFBFRGIzR3MzU2JxOElBNFRO?=
 =?utf-8?B?VXpHZUt5Y1dJZjZrVFNGenNIRHVyeWdqZVdmclpqUm5uV1NMZmpmUzFuOE1F?=
 =?utf-8?B?T2dGVzlQSWRnaVl3RjRiOGc3YkhNb3VzMWVGNWkxZnBhWm1PYnB4VGYweGhL?=
 =?utf-8?B?V2FPdGxSVW5qRGJYTWh4N0dySmdlcHhMVUovV2dDUWVKWXo1dy9ZR0IvRTFX?=
 =?utf-8?B?dVBhQ3lYbWhEcUV3YWc2N3huZjIxMFFHQ29IcStZa2tBVHVoV1Q0NmRRUGhI?=
 =?utf-8?B?NFkzdDVMYzQ2Ym5NS3NjOHo0eEg2Si9OOXJxb2I5d1hTRmFMTnNTcmp5TTN2?=
 =?utf-8?B?U1R6dnd1SHA0SDFmYUxzNHY1L045aGdTMVQxckdhUGF4N2xKQTUxTVkrQVpF?=
 =?utf-8?B?TWhOTjhmWVorRzdPUHdQbFZzL3NlSUZmZ1FBZnJBSjMyK0I1WWk5bHZtRWNm?=
 =?utf-8?B?b3MwcXBLNWIvOXp3Qm9lcEZlVGJIbnViNmtyTDRBZlB5dWdqc0JBNXl5cFc1?=
 =?utf-8?B?MGZtOGhxQ2FJNHh4QUtjTHhXT1JzSWdHZ3NEaW9pL1cwRjJIUDFmZjhFdmRT?=
 =?utf-8?B?QUk5VG4zWTV6TVpLcFE5cDNGMFFPZU1JcUxMdnBxclFhZlFZWVo3VjU1TEdS?=
 =?utf-8?B?d0thQzJjNldGcUt2c0FzdGZ0Z2puSGFsMktYb3ZyTWZKczlsekVRL3J5SWt3?=
 =?utf-8?Q?PL2H/uDilq6Ai4NwwMXjMS/1B?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b027c3-b9f0-45c8-43d7-08dc240514b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:39:02.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbnJoTezgeereVKyQPBTgwEPUXFXoYU6dDeAIurA44M1GI98ppARxcD982rt4zbZW1xb5zBS1RszDZ3pMYitTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com



On 2/1/24 21:21, Wonjae Lee wrote:
> On Thu, Feb 01, 2024 at 02:47:29PM -0700, Dave Jiang wrote:
>> In order to address the issue with being able to expose qos_class sysfs
>> attributes under 'ram' and 'pmem' sub-directories, the attributes must
>> be defined as static attributes rather than under driver->dev_groups.
>> To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
>> lists, convert the list to a single 'struct cxl_dpa_perf' entry in
>> preparation to move the attributes to statically defined.
>>
>> While theoretically a partition may have multiple qos_class via CDAT, this
>> has not been encountered with testing on available hardware. The code is
>> simplified for now to not support the complex case until a use case is
>> needed to support that.
>>
>> Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Add to commit log about simplification (Dan)
>> - Remove check for dev->driver (Dan)
>> - Remove check for invalid qos_class (Dan)
>> ---
>>  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
>>  drivers/cxl/core/mbox.c |  4 +-
>>  drivers/cxl/cxlmem.h    | 10 ++---
>>  drivers/cxl/mem.c       | 28 ++------------
>>  4 files changed, 33 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 6fe11546889f..55b82dfd794b 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -210,19 +210,12 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>   return 0;
>>  }
>>
>> -static void add_perf_entry(struct device *dev, struct dsmas_entry *dent,
>> -            struct list_head *list)
>> +static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>> +               struct cxl_dpa_perf *dpa_perf)
>>  {
>> - struct cxl_dpa_perf *dpa_perf;
>> -
>> - dpa_perf = kzalloc(sizeof(*dpa_perf), GFP_KERNEL);
>> - if (!dpa_perf)
>> -     return;
>> -
>>   dpa_perf->dpa_range = dent->dpa_range;
>>   dpa_perf->coord = dent->coord;
>>   dpa_perf->qos_class = dent->qos_class;
>> - list_add_tail(&dpa_perf->list, list);
>>   dev_dbg(dev,
>>       "DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
>>       dent->dpa_range.start, dpa_perf->qos_class,
>> @@ -230,20 +223,6 @@ static void add_perf_entry(struct device *dev, struct dsmas_entry *dent,
>>       dent->coord.read_latency, dent->coord.write_latency);
>>  }
>>
>> -static void free_perf_ents(void *data)
>> -{
>> - struct cxl_memdev_state *mds = data;
>> - struct cxl_dpa_perf *dpa_perf, *n;
>> - LIST_HEAD(discard);
>> -
>> - list_splice_tail_init(&mds->ram_perf_list, &discard);
>> - list_splice_tail_init(&mds->pmem_perf_list, &discard);
>> - list_for_each_entry_safe(dpa_perf, n, &discard, list) {
>> -     list_del(&dpa_perf->list);
>> -     kfree(dpa_perf);
>> - }
>> -}
>> -
>>  static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>>                    struct xarray *dsmas_xa)
>>  {
>> @@ -263,16 +242,14 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>>   xa_for_each(dsmas_xa, index, dent) {
>>       if (resource_size(&cxlds->ram_res) &&
>>           range_contains(&ram_range, &dent->dpa_range))
>> -         add_perf_entry(dev, dent, &mds->ram_perf_list);
>> +         update_perf_entry(dev, dent, &mds->ram_perf);
>>       else if (resource_size(&cxlds->pmem_res) &&
>>            range_contains(&pmem_range, &dent->dpa_range))
>> -         add_perf_entry(dev, dent, &mds->pmem_perf_list);
>> +         update_perf_entry(dev, dent, &mds->pmem_perf);
>>       else
>>           dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
>>               dent->dpa_range.start);
>>   }
>> -
>> - devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
>>  }
>>
>>  static int match_cxlrd_qos_class(struct device *dev, void *data)
>> @@ -293,24 +270,25 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>>   return 0;
>>  }
>>
>> +static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>> +{
>> + memset(&dpa_perf, 0, sizeof(*dpa_perf));
> 
> Hello,
> 
> I think you meant dpa_perf instead of &dpa_perf, right?

Yes thank you!

> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c93bf9d5253..7091619f12a9 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -272,7 +272,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
> 
>  static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>  {
> -       memset(&dpa_perf, 0, sizeof(*dpa_perf));
> +       memset(dpa_perf, 0, sizeof(*dpa_perf));
>         dpa_perf->qos_class = CXL_QOS_CLASS_INVALID;
>  }
> 
> Thanks,
> Wonjae
