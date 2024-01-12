Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91934745DE
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/bNnKtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705076351; x=1736612351;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z9McYJgvMRtn4UJgUhZbycoSEZUTrosgg2L9uQQS4mM=;
  b=C/bNnKtAjxPUYpGZZIJm78TMLjZSRO1CdSV+hks9s7xxhkqUxYtB+itL
   B9HKNRmGZkjNss9ikue8HNBj6glS0Dv/89QIBcFhPZAuMo54XO5UDX4G+
   brrPn/PyrRcCkrEiiINutkdOjt3cIg69G6T7nDNEhX6+dv8PHRt2aaUnj
   pELB9FbsLQ1/OjAi3AVvbSSMAXtFRfxfVHoQT15cKeqUpogYYvIiIFIPO
   9yaqNE9N2bdAreWOoSNzoIp9cYJVuMFWo8LFcXwAQFQLBNYgOjgrRJjk9
   KzE3IGsYw3EBqAm36bLmHKt6meD3hlEyjh+/UyAo7Tiup0sg2yAcYLjNN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="389653531"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="389653531"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 08:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1029972434"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="1029972434"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 08:19:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 08:19:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 08:19:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 08:19:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 08:19:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwdVhBxzZMLY3LLzRekOlI/sWUfoG0jCFUJFSslFcYNrz/0Dx8f4/JF6HNf9QXoym2O6dxqSyrdV60WhtJ7zVgtot3omcU71m/6i/26ojjKty+TKVdQVUr9UqzEXnKSGprHxwBPLFcI7dibH4aBRH6tx1lHpoSxvpfJFtGXw27ok0oqUZIxZllPlVV+MzzjuhpMutlOa2gzHay1lklz20PIUcRpZBg+0BRay3AMz0ubsx5Zy1htPVbOnbmiElaPxQF9gsYK5zu9gO8kMoqW/g4GQ942yB9ubHJoGoyWnmNPgMnVmWi918aNY5oGLe9R6DPN8gJN//Cw7QpArg7B3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdsrWbWr+PsQtmhKUAu4LfGSyaEp22v7ZkUv0+X97kk=;
 b=Q/koBkcdFGrmImEBtWXi32y+SWKMB9YdlEIqKOs/hX1aRJaLL36I0pRqTy/VAmuk/rLcz9XeeVfQWo92RTFMH0ErlwSH4xZ9gJY5NQACMC+kA5zp0niILOiwH5uJzSQ5QngXj7dqkmWxFcFXnEQWiG8qhcMTj9Cyf9MdjsLN/8txiuHcGsYR+3Ba685gaTrDNYvbDuOQTagsDs5EE/+gGX59KaeMP+qdr2yeEaNyNyPaSHGt6GdZMagoQzIfp4RsYJtZdkJqe5Diyhvt3eYs66eNOC4emLct3cstNiMFB6JboLS354u14GstbLMBfz7CMA8VBsycOyTos56ZQxuwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB7126.namprd11.prod.outlook.com (2603:10b6:303:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 16:19:07 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 16:19:07 +0000
Message-ID: <f99083ca-b916-4325-8f08-f63ac79b5411@intel.com>
Date: Fri, 12 Jan 2024 09:19:05 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/core: use sysfs_emit() for attr's _show()
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <20240112062709.2490947-1-ruansy.fnst@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240112062709.2490947-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc036b8-d8aa-4d9c-80c4-08dc138a33a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4QoJp5HLjejlh5DYcQdqDM9DMlIYZUR7XH9coeSLqz/Zp5XEmcd1kjoIES490Ns0nEqOVDM/un4SYrI1xyTgy1Z2ZauDJTVOCIcBVc12KU1cE4+BW4trIQauGcUmE+gbjIMYIPHVApTtxiKk8MW/uMvrBnMR+xPhFGLNpti2PyaSrH48lQwyKva0rwM/xZIVX4aj3/0E71IRMaZMbKl6u/uABS+jD2Fz0KAFGirV6hQVCOa6Ka6QmF5UErHUDM/in3f/HXmmLwKAfuLzb4avPlyKbSatP8ZlCUoUrwq7/PXfnF4exqqcaCfFJywV8iJOzB0iTK1lWFu66vM8T61Q3O4CdE72GWIjtkWARMvQikYA1SkFXK7rGhlu3+/TgMH8aSTjJGQcNfKzEpQjnwP6rySv1XN60rZHXkQPYDgwZc3FOl5tbhPCwHI5btTv421oHlsLycc9LrupEHkoHDlKzyt7XVtsNR8ueX7IPInMsfIw9Z/RATVnQ2h2nzdapWCkSQxsU+3XwmIzSaKZMj1SiYTeXD/yzoWnxYzKkNozgIJPZICPGCH9nvLcHZ0EqWbU3nvGUJeSMvCPC0T3SKrZsDi/FBJAwsX1rGZrqH2bGaiu8+Eyg24FbUuS5LZQZ82
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(53546011)(478600001)(6506007)(31696002)(6486002)(26005)(2616005)(41300700001)(83380400001)(6512007)(5660300002)(44832011)(2906002)(38100700002)(4744005)(8936002)(31686004)(82960400001)(66946007)(6636002)(66556008)(66476007)(4326008)(316002)(8676002)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhMRDV6T25qRUtZWnhmWi8za2pkL3MvaXZqbWxoVVhqTUZGZGpRbFhWaEZj?=
 =?utf-8?B?R1NRZ1dKK0EwTHY3bWNzZHJDOUM1TG44UlJKK3FoYjlWb1dYRHZKSWdoeGFD?=
 =?utf-8?B?SGtFaTdrbm8wd3ZCRVJ3WFF2endjV1NWeFFOcGpGSHFBQWdaOHlsd242ZTBw?=
 =?utf-8?B?eS9HWSs3WHpKWElhR0dURmNLUXVha1JWK2huWnVBbFdHb1ZoWHBGclpnOU1T?=
 =?utf-8?B?YnNHVDRiK2ExRlpGcndiNjI2alE0VFZzYkxvNEVhczJqanlvMy9kR25PZ3cr?=
 =?utf-8?B?eG96Q1FzenhXVHR2ZG9hbUpkbm53L29pOGFid3d0NXNlQzFQRmt1MkJmaDZh?=
 =?utf-8?B?ZnlnNVJFVW1qTEo2YWUyaGMwMDEvUUJWcHd6ZVJQVjd4SWlHTHhlMy9qVHh3?=
 =?utf-8?B?aDVMaGpWQWlMcS8yaVE0dU11cjBLWGRNMTZNUUN1bnVyWUJjMDdTK2I2RGtO?=
 =?utf-8?B?ZEFydi85SFJzMXNWVVFtM2EvQ0pjeWVLeUxFdlFpMnh2aUFTeWNLcmd1NHdw?=
 =?utf-8?B?bkZQREhDdnlKUWRRSHhZZUxJamE0UHFtNkd5YlhmazNtbE96Q3hCbm0vbmZQ?=
 =?utf-8?B?cVIzWUFHa1k2dTdsYmlUblFISzZValBManVEV21BSGtDYytST0ttT0tpakRW?=
 =?utf-8?B?NWI4ZmVJaHVrWmsrRmZ6MURPeVNsZG0wNnhVUDdsektjQlNIZnl1eWViU2c0?=
 =?utf-8?B?eG5vdmphcjFqTnZXL2gzWC9kNU1xWHlmdjVOMytSSUJNb3lmTWZJR05Qa1Yz?=
 =?utf-8?B?bFhhK1RsOTFCclE4LzV1Vm5Id2tsUThlUkEvdklXcDVzbk84clMycUw2Y2V3?=
 =?utf-8?B?NmFNSFovaUU3OWZZTUdZWVJwMVhENEl4U05Xa1llNHk0UFZrV202MWpsYmp2?=
 =?utf-8?B?Tk9rUzJIYjI1STArcFlQU1o2ZDVUWFZBbVF4UU5oY2xMMjY0a1VDMWJPeHA3?=
 =?utf-8?B?VVNSeWJCazZtcTVUQXE5NjVtZHZOV1gyb0k0bVpBNWZKWE13RGdOaWhiTEpK?=
 =?utf-8?B?OFpwaGtubmdqelkzL3NNQlpHWkllMk5ubkxnZ0RsMllOdE1MRUtlMERwVGR5?=
 =?utf-8?B?bmg5UmpqYTJENkZIS0JrRGk3L0p1R2djYVI1VEFMZkVNbWJZZm13UGV1bklF?=
 =?utf-8?B?SStSQys1cDB4cENjOGxUeFZvZkxyY3JFTGhNNHlKRGswazlIZG9NQVk5bkVP?=
 =?utf-8?B?WC9YdHhmeXJTVXNPRmpDNGJmR2MyY1pkLzl1azZhbUFnYkhiNDJWTXMwb0Qv?=
 =?utf-8?B?Ni9KVnFKMTFBUFJIZlZtamErRlk0ZG5SOWNPUktRbGpkRkF3WnFSWUNkSy9h?=
 =?utf-8?B?Rng4UmF2a25lZWxGN2h3QVBaR0VKMG9uNGtmSnUwcnZGZjFWL0FlSFdZNEIz?=
 =?utf-8?B?S2Jid0JxeFFSbG1KWks0UXl4RDlEaEtvbUZsOVNmVkxqdG1MclFIQnV3WmE5?=
 =?utf-8?B?WEtEdEFiNytTM2lYMVB6dVJOem56YmdVVVZ3RmJVakpLTFc1TVBKQis2K2or?=
 =?utf-8?B?Zlo0WXlYSzBSQnFaNVlZdGFiOXJJN2h4dUJ3K21ja3hpcjV2UDliVWdUT05m?=
 =?utf-8?B?UjhOMmpYWFllUUpoUjBIRmk5cnIxbWFkeW0xM0toeDIvblNVcXhTRjZaOFZV?=
 =?utf-8?B?d1ppTzNZeDk2a0JFbXBBdVdtS21UZ0pnQ3VFbGZNc2oyUVBabTlMVEtEaGVr?=
 =?utf-8?B?Q0pVM0xsaDdwQmd2Sll2Y2dwSTJva2EweEsrcElvWkM5WEFMTStqdlYvNkw0?=
 =?utf-8?B?U290OUJsWkM3b2hrVWg1eVlMUWdJeEE0eFZ5QzVjOHJ2MlJwVndOM25Qc1k2?=
 =?utf-8?B?eVdhR3VsY2tPZ0l4WlBTUWltVnNmZEc2KzVOdzhUbndyU3I1M2VFcDVITm8z?=
 =?utf-8?B?b2ptMWNvTkJOS1lpdUFEbkVBbDRUc21tMjdyTkUwbnFPM2FLc0w0VzAwSUlo?=
 =?utf-8?B?NVFtU2ZWOEpNVEtvSURtRHY1UVVqUUtNczdPTWIxeHpZV3BMckFnbTc1bkZa?=
 =?utf-8?B?MVdpTjNjdk1EbEdHVm4rUnpMYmoxbW9NWkllMVVEMkZja0xSRFdDZVpGdUJq?=
 =?utf-8?B?S1Y3a21uL0d1alFFUWFaRHM5NEkvYTJLMzNoQUl6aWxUdmVqdWIyeU1vRDRK?=
 =?utf-8?Q?OYuX46djSR4PsyYSz9OIsexd3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc036b8-d8aa-4d9c-80c4-08dc138a33a8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:19:07.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etetSejuz/U8h1NW78+K6v/QiFtI3zio+PAb/dwMwD13CrdocKcpU2gFbEeUuauNLTjFfIQ9eJYZTn53dP2Tiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7126
X-OriginatorOrg: intel.com



On 1/11/24 23:27, Shiyang Ruan wrote:
> sprintf() is deprecated for sysfs, use preferred sysfs_emit() instead.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 2f43d368ba07..dae8802ecdb0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -114,7 +114,7 @@ static DEVICE_ATTR_RO(serial);
>  static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_to_node(dev));
> +	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
