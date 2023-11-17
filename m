Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIPsyT24"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCDC1989
	for <linux-cxl@vger.kernel.org>; Fri, 17 Nov 2023 07:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700236278; x=1731772278;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8PF+vt9RfhNN/u7vR+N/d8ZVXy9EvPe6LP3EMWrH5oI=;
  b=jIPsyT24whtjAOLfv5LOBicdxYQ/TLLMnhay7V6sJYt6anJO4oHucnxX
   Apdp/O3z1yKHTEJBy5CfN8bJJg/ikRT9BwtPbKY9y5ECFYVbMss3W64m1
   uOri+JwoDeAarYofFy+HKfyS9qJCrRj/z3oaUts54cNCJg4iN8Wp//0Re
   BnFaMxB7zGrOHTcoIOF15GCO+STcPwxQjDUj+23BlAhdtm9FvLsFW2Rr1
   TwosYN9XuCYt8ohy6GkiEfilokY4qo6PsebZo5oo2sBiJf6pfPX2W2lRb
   rJZhkagM8OERIK9Qpp9GAxAC28+oSCcvPB16x1moKEWEXZtWsQlRmBaI9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="9980170"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9980170"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 07:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="836094612"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836094612"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 07:51:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 07:51:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 07:51:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 07:51:16 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 07:51:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6aK8JtXl6Ui0d3zDRiNMmTeueMUOMaMvz+9hH077UigNv1aLn7pNWQ1ZdxOw7vh62CTshWv6EY5E1j0vI7JZPi/eTZq69Or7pjraPwPGrYA0m8irUfVt7tbIIwAaJQOBwbfxPCkE0/VORfbK8hS2YKZi8wVT+SdRYvXeKWbzVte8Uuf4pdeHh6NOWhUA9EzUiah5Z8gPTZlFm5qYF7AmBM0Y9Cqnwd3quscFMxPt+YaB2wRrgDQCxjGyq9kW6mZmZ0hNSiquwN/haKiMRHl6gmF2XU7b1zQg9idkAlhVXsWW2Z7kOuL3Yus/UTz69PUuMUVeISvQEeCXXQRvQ91uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njvBtWdUc9M3Il2qNwLD9vx4ryAjgK2M+EI4x2LeYgA=;
 b=LwX73U+Y3DJVo1h9X/7+lGjF8j+iFiIVqr6eUXeJ8QjSHb8WSIiGuCvVSH3GOTmtiv2u7bS+6X/l9XxHv8mDk+iJfGWPkkynHo5fsoe1jRjbCqsOnms9NVFDqincuAuuiudlXUtyjrw/qVsax/D+w0fB7ZrvFN6PzKaqNwcmRe8IBfvM4FzZD3cEeISksQHnB607wfaoNg2Y0WIgqKVko09GSbB0s1bQW8VdvtG0n+kmBUzGfGSiosTH1GTIwLbpmXMqjGg50+jrcV81LvFlWFebI8yc4MedyI59AJcLvCEuE3nkAqKeiRO9vAnx0UwaNgFMjiglC7qLN1jO6b+EGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 15:51:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 15:51:13 +0000
Message-ID: <ef0c8b12-260c-48fa-9d6f-fa750d8ed18c@intel.com>
Date: Fri, 17 Nov 2023 08:51:13 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [ndctl PATCH] test/security.sh: test keyctl before excuting
To: Li Zhijian <lizhijian@fujitsu.com>, <linux-cxl@vger.kernel.org>, "Vishal
 Verma" <vishal.l.verma@intel.com>
References: <20231117083947.2211323-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231117083947.2211323-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a2e3b8-ac0d-4849-79a9-08dbe78506e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBDi7hNTd57sjWnaWP0Jchxj9fGEU++r8K9IciB4DTLQVrmqNYAGlXtGfHmnC701gfbwXCPpYFhjFP89WvPgWfRmGYfPXOEGR2JGfnmPt0BBzuw+TinCI8T9VTDmXbdKXtX7+/szULrA2QljSfQN3e4oZwHK4VtTX3ML25AzcxyTOJShBwv+2x1a58WeZO9oXhbEN6hEC/zxyurJ9NkWK5gq700ls+i6FMgvR17XMCELUu2F6KoKI19kO3BUwiikKtOqykGV7bAOem7Hcr7rzC/O8uOW5NvY0Yu1QzRBtWEG5qyHLPmxwGlM6UCMnaUy61vtV++n/l9w467b5yUK2r3vTwI8lH0/N0t1dUueEwOqCuxR56OFfaqPwhkMIdsxZUES9miPQ66T296QskTf05JwfpSpbDYiFYIMF6KMUwNPW/+3Z1DUCbe3i93xWuqrvGIGmHwaBISmthlsnMbW6BU7C01toPafKO6Xm2Icttgp+QL/6nP6wgEkaaSUcsYmIGLwRXVne2fyWlwZo+crE1lU+Z9IH+gG8bX+1IW3Ari6k1m8NU8UUqtDroWtP0j0+KJQ1H3g6NIB9m+GMewW28+JI2JY74Veq3LvybqrxBoyEXACuj5WzCJZFoJK2tou
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(53546011)(6506007)(83380400001)(38100700002)(82960400001)(6512007)(2616005)(36756003)(41300700001)(44832011)(5660300002)(2906002)(4744005)(15650500001)(8676002)(8936002)(31696002)(316002)(66556008)(66476007)(86362001)(6636002)(110136005)(66946007)(26005)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2w1Zk9lSEI1bW5vQlBycjd2ci9VdTZMN244Skkrb0RzemQ0bzlDbzJadysy?=
 =?utf-8?B?ZzBHa0tUSmtIZXZTd2ZMenAzR3N3Q0M1dkFJOUFMbWtwNXlpSmVSY1IwZ3lu?=
 =?utf-8?B?dEtoZ3IrbFJyRG45NUpQKzU1V1Z2RUZ6cWVRWDVQNDFOMmorMjVmOXJhMzZI?=
 =?utf-8?B?cXlHRlp5QlhPd2hFQnVZUk9FUmFjK05iMHhOQnJqYXZOeGRtdFpqQUh2ZUpD?=
 =?utf-8?B?L3k4L2VOVklOdW5zMGZuSHE3VmRuMm9iQmFyUGtvQlFvYUIyWHlTTzZEZU5x?=
 =?utf-8?B?Z2YxUnNtRjdoTkZKYWNseCtoNnhrZFM2TlNEOHRCS0FISTRIVDRoMGxZeVMw?=
 =?utf-8?B?NDlWTjFMeWFHSVMyUnZIZGl3TlFpMDNEWE5CRWdwN3pWcUxpT2JoZ2FMcXJF?=
 =?utf-8?B?MmZnTUN3ZVN4ZUZKYWJSbHNKWlhCeUpTSUNXcjRoc2pycUZRTkpuUmRIOVVz?=
 =?utf-8?B?Tmt0bURiektwUUdGV2hFelBsaEh6K2xkQ1hURlJnTXVnL20waTZOU3Q5d05P?=
 =?utf-8?B?dWhObjRzT2hCMVFMd0NFZHVobkVQOU5kMi8xMHplUFZTd0syVWZBLzgvMkNn?=
 =?utf-8?B?cmszVmtTUjNnNVpxZXFVNXpSbUdjOW52ZHZqeFBGdDZZdTFIR0kzeTlqbGIx?=
 =?utf-8?B?L2VQK1cyNFNmejk5UXhid1lpRDl3VkhiNmpGS0xLeS9XbXRRcDBocTJsRVkz?=
 =?utf-8?B?MGVZb1JLVXNKV1lnaWhxR0pCVmZFZ0tUL2FEUGM0M2ZORlBtam9xWGpiMWxn?=
 =?utf-8?B?c0FoanpNZ3c1OGhscUQ0QXpZTGpXMDRMd0pnSWVmeUFTWnpmVFBMS2F2UDEr?=
 =?utf-8?B?YTdNeVh1dXc0SGFvWWxGMnNEME54aUdOc2hLS29BSHlnWXd4dDdUU1dwaG94?=
 =?utf-8?B?QXZpMWRkdmxIWXZzSGpWeUw0cm4vcXoxTzZrc21qbDMzZXZYSG1pSVJDb3dl?=
 =?utf-8?B?cmVHemd4NkN3UmsyWDk4b1JSNUF6NzQ3RXJobitodW8wcC9KZVF6T3diZFVp?=
 =?utf-8?B?ZnRxZUpjZHpXSjhYNnNLYWlEYzJrT2lRYWRidlFSRER1Wm9KQ2hjYWRlcll2?=
 =?utf-8?B?OTJ1TEN1VlNkSllicklxOGg0cjNPYWxuK0JjQjFRaVlYK3ZjQWxzVm1Eb210?=
 =?utf-8?B?NjQyYlJpTlNSd0xzc210bkJVK0xvd2xZaTFjVUVyV3NYOEF5dXFyU21YR3Fi?=
 =?utf-8?B?ZmFiTStrYWhXZkxnMDROU0dDTSsrYzZ1NHBWQnF3dWxONnVzM1RXVSthcFds?=
 =?utf-8?B?bFYwMEZPaFJYdnY1SnVUemlsTGMyeUZMUmQ2UkczY3dSTUE2dXExTkd3bnRC?=
 =?utf-8?B?NkU5cythQzQ0WURldGIvQ09ZMUh4TkVXZXgxVlRmRDhqS1JWUWFqWW1wL21v?=
 =?utf-8?B?clFrVlAzRUJ6eFhjUEV3cVNWeXJmRkNuMkhYb05GQ1BvS1gvNzI1VUpnR3R2?=
 =?utf-8?B?bGxJeFNQNmMvSHpSYVdneTNZQWJ6YXFEWWZKSVRibjc4bWo5NCtKRlptdXlI?=
 =?utf-8?B?SWdSSklUVlJvZktWSmdaOXFTbnJxVFlRL24wdEpBYklOUjNtSkRWcWEvU0t4?=
 =?utf-8?B?eXkzTlhHZjZIQTluejVsc0QyQmhBVlNsVDhta2o3eDVKSFFSdmtGNmhnelk3?=
 =?utf-8?B?TXhGT01iQTlhVVF0RERraGg2NzFNUzRpNndBZTdDbTB5cEJ0dFpHY2QwNjhH?=
 =?utf-8?B?UWwyWWtBc3BHaFErb2NIbHJPR2VKSTQvZWI1MUpkMUw0UTVHZWdKd2Vybis1?=
 =?utf-8?B?YituWUlkM1RiQmd6SzBYSjAyUFNVQkNrSXlNSHFvbEJsL0JjYXRnWDBHaTM0?=
 =?utf-8?B?bHp0TnlybkJra1JVQlF6V3FXZlMrd1UyVEJ2S2NJWldiTk9JMVpHK1JxbVdH?=
 =?utf-8?B?dkhVeGREK1ZjaWdrMEFJYUQ5TW5hUVRYM0NxVDV1WDUyaGlqcENicnR2NHNL?=
 =?utf-8?B?UmRSUThEQnlhNlUvQ0xBVG56QklzRW11OUl1cC9FdU40cUVZaDluaW5CRm4z?=
 =?utf-8?B?SE5KL2tRK3N6TGxIdVpZYlQzd0ZFbXNpMk5DTUFOSGFzQytlNHJJU2pjSGsv?=
 =?utf-8?B?R1ByVlp4RndTL3NGbXQxWG1zR2U5Mk14S2dFVHZ2d1pOa084QWtpSDJRMUI4?=
 =?utf-8?Q?ejHUqIG3SklqH/O1Fz4gMk9NU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a2e3b8-ac0d-4849-79a9-08dbe78506e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:51:13.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6CBzKRHDFFRnd2n//qknFl/v7RrlIsq4hmfFxgXwYzQxV5+VKBAlytdMfc50XM61brh7zhphmPH4cZd5ZeG+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com



On 11/17/23 01:39, Li Zhijian wrote:
> test keyctl command before executing
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  test/security.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/test/security.sh b/test/security.sh
> index 4713288..f954aec 100755
> --- a/test/security.sh
> +++ b/test/security.sh
> @@ -219,6 +219,8 @@ else
>  	do_skip "Missing input parameters"
>  fi
>  
> +check_prereq "keyctl"
> +
>  uid="$(keyctl show | grep -Eo "_uid.[0-9]+" | head -1 | cut -d. -f2-)"
>  if [ "$uid" -ne 0 ]; then
>  	do_skip "run as root or with a sudo login shell for test to work"
> @@ -227,7 +229,6 @@ fi
>  modprobe "$KMOD_TEST"
>  $CXL list
>  setup
> -check_prereq "keyctl"
>  rc=1
>  detect
>  test_cleanup
