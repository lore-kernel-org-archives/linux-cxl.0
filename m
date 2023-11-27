Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ik7+Yuma"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3727199A
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 09:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701107937; x=1732643937;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rr1PpgN5KbLJpIaoOhxsV+7Bop5AryqowSMMd16VDN0=;
  b=Ik7+YumauKM4+Kiue45ZGIoLD1IzmjtWTyglpjDqE9g6b07PGAy5nPz8
   RwnCk210FTtm0LaYX41rCum4KHojgYGNBklI1rIpD8KRLMuFD79jJOOep
   MWErxYM7D3h+vzv9dqlunuyd2Uknb8Kmb61OgpEUwdcIOTZFnFqLgoT+p
   G4uI/NGyq642vopK8m+O6G5fbG6WZI/PyXizc9M1+5+vhIbjJQYGx8q0b
   pz/tE3lCtDJSLDIQtkkykjwIlSVpWOIcX3bJLblIaxKRVJr93EXZ7hqu+
   KGGCgXOcEdfp3nKglkzl3If/LVzCjv38dRf+4lL58CI3MU8rc+7iso9GY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="423907145"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="423907145"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761677010"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="761677010"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 09:58:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:58:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 09:58:56 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 09:58:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhjfP2EQH7HwBqzHIUxFuiCIdMvM0IFvSY1n6bJEtUmSdky1jQVcycCicXBybL2/n4HlkIrmIx+f3qogMJQNIM6bRWmf7FE+qEhZ4og9AKGH9gn8PYlifRkmmv4qoO81+q/Ho+6spHxA75rtvlhufpsnR7QUdi06fJYhD9CffCqJ5uThuHeWFF++ibQtiydFJSU2Ww/zCgPMXjjI75y7/+1obZqa3njtA5hRd74rjZSwX8jcG7KIJdeh7PDTrjYDE/zm1qyCI+rJVFPIwgK3y2neSCvZ/SSPV9+L+qaVxwwFuCZ/W50Pb9VTpnXSnpy/ULKCuvzCoOhAFoRpiL6BwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl2JeJdqvNCe2I1Ml6G+2iuI2wtqxg4Xw8pr+hXQwas=;
 b=LqwW9o00FGEYmXXOWxiEWomfdx7GCAbpwD3cOwzQiPLpS6VHxBxyZo45cQCPZr9t9LoajOUBjd8OYvIIX8OqO2gsZUWyZ//xL874wInKp+Wxpp6Dk6Gd1ddAqwUjBm58fxis2P3R6Ahh3/1acpA1PbXhICmURQiJI9vL/DsOChQwh+bzev8JqP/sQMXobYdO6EVdj1NYnDDJbS3yns2RJCW9neDNq62RT7g6qlGpMOaa5/BJns8srSoi79nbtJBKLRBk/Y3h3BzcmOZZ1ye/E1YzdWkrBF4UxQNiLXDaAEi/WCszmSowWMs1ADoMqs7L1ISUu4KozU50CVZSckVT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO6PR11MB5570.namprd11.prod.outlook.com (2603:10b6:303:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 17:58:55 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:58:54 +0000
Message-ID: <2e5f09b5-373c-482e-8578-f6098a8cfbcb@intel.com>
Date: Mon, 27 Nov 2023 10:58:52 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] cxl/memdev: Hold region_rwsem during inject and clear
 poison ops
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <cover.1701041440.git.alison.schofield@intel.com>
 <08721dc1df0a51e4e38fecd02425c3475912dfd5.1701041440.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <08721dc1df0a51e4e38fecd02425c3475912dfd5.1701041440.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO6PR11MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6020966a-cf59-4c38-7000-08dbef728573
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0hkE7jqTnZCFs4moOvoKBYxL42GxT0UMQyiDfcjPd6/KlnRFCv/s+liuE6daqX9WS+POu3MMtof323z25V4gNxR2a9GtnVWmuTboLwfL8adUEqFzOc4S+cHB+9LBYT7bb1HsO9NavXFCLDoOsQLIUqF6oUReTVzYpRpMBCJSvMn+xlxL+wbmEnRItr+Oa2NY5UWTsKaouBy5KAs/XsgNXwbSn0wbNNPIaCNzHLptF6Mybn+KvsXFIRDcN1fC8fGudsP1xyX/zq+LV95QbMIKQtuUBMPZYkJiXx8YdSsJx01JKj/pASNFpbX7P3AovppGniFRvsgVYgMNDP0NntPsuvZy3cZsAVkglLSqhwyVFjfWw+pCEuvTXLB/5nKJ8gFbxIfy+VW7RjnoHpyMdf2LIXX/I4gV6yMp5g/I49cUigWV22e8u9rD+YXl8Ot5YeiSAigdoy0EbUn9jWeWWO/lDfKAe2ZgBbOj3FNf/JGJ9wH/JOm5umMaH2ohZ70CEXgByaRpNoL4tPnDaERKqi6I8GBXJdzuONnYJQraG95gyduxDbsjRCA5K6mHETiHXiyb5AvxuotM7DnJvbre3Wz7F+SzepfrehQzkiBiXX2WjiCT3gTAu4fnQMVgQaG5JHp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(31696002)(8676002)(8936002)(6512007)(53546011)(6506007)(110136005)(66946007)(6636002)(66556008)(66476007)(316002)(6486002)(478600001)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(44832011)(2906002)(2616005)(83380400001)(5660300002)(82960400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUVSQnpsMlBpOTViQkhPWWVkWGVyTXJwcWpOSUVSSVhwV0ZIbDJTZTNkQVlP?=
 =?utf-8?B?bHlEakFna2NoeFBjbStFTXE2UjNRV0pQM1BzMUpXOFdqSG1vR2Q4a3ZWaENj?=
 =?utf-8?B?SUozaGhTeFZWQVFRTWIydmdidmFkTEdPY3B1ZWdFMXRmNFlrZUhXSUxtVE5u?=
 =?utf-8?B?OXNVbG1sSHA5dnVHNHVUZ3VKOWdQUUw4Wi9sOEdHY3UycE5EME8yajJlN1VS?=
 =?utf-8?B?NVh2c2xlSVZMSEpoK0d0dzZOUzFvbU95U1FEc3RUOXJ2VlFDalM0K2NJV1ln?=
 =?utf-8?B?Qms0eWFSeU1PbWwwL1pMWWo3UE8wb1kybUZtdDB1R1BNaVlXR0pPNytGTnUz?=
 =?utf-8?B?QVVhYnZpQ3cxbG5sZzRwcStZTERNWXZsMWVPcG1FZDN6Q0R2MkIwN0o5dWNR?=
 =?utf-8?B?WSs1Wm1IUHU5Ym5seittWk1QK2F0OEluMFBhTi9iTTBMQUdNV0xrNTRxa2k5?=
 =?utf-8?B?QUN6dng0QmFMeGpDRTh4Snh1SHp1VGQzVFNTRzJDa21ia1BrdGhBWVRaZGMz?=
 =?utf-8?B?L0Rob3dSc2R1ckZ4RUJ2VXRRbTA3V2w5a1FkNGUzWm9PKzE2aDZjVWtWRloz?=
 =?utf-8?B?RDdMUzhQWllFSU1aWVpSQVdpaFZhN3ZPTkxzcUhYQ2NOcE1oVVVONUVpQXAy?=
 =?utf-8?B?RGJlVTZXRk5vdG5uTmRaSWk1U1BXMWNZYmtHV1JHTGR6ZTFreERvakpTRXM1?=
 =?utf-8?B?ZC9wK0FMcTZoY3pOMmlVUkRzdENvU1dacndNU2xtQ1dpcWxFWWJTZmVCRmhP?=
 =?utf-8?B?VUdSM3JlYlBJdUoxeWZxcnM2STJWZWhxVVBTY0EvZXhNMDNON1g0anNlSklX?=
 =?utf-8?B?czJhTW8xRVgrRlJIaFhBOCtHWTYwYmpNQ0ZKUTJzOW4wdE41ODM2dVhQcnZi?=
 =?utf-8?B?T1ptc3B1N2NYVEc3RmM0WFN4RnlQcm5lWXdyaktFK3VnYnRPS2RQbjRHVXNI?=
 =?utf-8?B?RldidVhnZlhwSTQ2cTA3MWwxcmovUUpHbVplbFl6N2pkUGxtWG9ObC9rUHp1?=
 =?utf-8?B?QnZER1NLZkw3dE1KaU5VQzZSWWpMTFBTZHphL0JpWjZrRG1nVmdSNmZzQWZR?=
 =?utf-8?B?R3M4dlBXdEZ5RVZac0RUQm9iL0RuUW1MODhua0JqaFl6aHRvQ0VndlY4ZUZk?=
 =?utf-8?B?T1lwcXlPTHd5UkVvK1c2YkIzWkZMSTR5alM0QmsvOHVWTTcrUitocmpqdWVL?=
 =?utf-8?B?OFpNT0llanZJejZwTVlMZThSK21FQmJvZFBtWDNLb3l0ZWJwUjh4eHJVTEV5?=
 =?utf-8?B?dVpZcUNBekN6YzBBVW9sWXV3bDlOdW1HaG1KY1BRNFhCdndXQkpHN3RXVnpt?=
 =?utf-8?B?b0Y2QWZNaU40Vk5zNGJVYTN4bjB6bEFTWkh3eDRydmlRWlFsNktDQ0dnTVhr?=
 =?utf-8?B?ZTJ5RzRSTTVUQzFuMmxNbDYwNThxQkcvQjB3Y3d1a2Vid1ZjcXlBSFVnb0kz?=
 =?utf-8?B?WUVhM2NSTXJjcU1Md3laeWtSZitEa01XR3Y2SndtVDU3alJXZkd5RVFXUW5M?=
 =?utf-8?B?dFYzeWRmdTBjNGZmbkh5dkZrTDJnWG1aSEN2UEF5VmtRVlVHS1lmVGdFY1lL?=
 =?utf-8?B?M09wVHo5K0lVVStYRUUwaG1YdlRsNlk1cFpGakQydjFnV3l2bWZUT3RKaVBN?=
 =?utf-8?B?WG5ZZElkOWU1WlZsWDhrMFNKMUx3bjh0Zy9uQUNjSWRxYTlEUGZxSlNzUDlx?=
 =?utf-8?B?SHhyNkpjV29yZGNGY2ZQN1B4Qm5USTRvaVo0cnNEY1NmWWZ0L1J1NjAvdlV1?=
 =?utf-8?B?Zmo2Smo5RmxTMjNPa0hNMzl5SndBN3B1WWJ0eC9lM3hFUWRoY0VsT2dQU3V4?=
 =?utf-8?B?T0lhamQ0SzhjV1FzdVQ0TGk4VGR4YlFvTzJrN3VPRWpiTlFzb255NG5jRk1K?=
 =?utf-8?B?ZFNHclJMRnB5OC9nNjVMMkxId1k5ZExITE04T3hscERGTVoxTGN5Q3RyaTE2?=
 =?utf-8?B?Kzg1UTBFT1d0azQ2Y2psMUhBUm5la25iaXlsbWs2NGdLS201RHI1b0RBcURv?=
 =?utf-8?B?dWZ4UW5ldE12K25tRm5hVDIzaHU2bE12YjFvK2pKKzFwTjFVa0dLZStyYXU3?=
 =?utf-8?B?RlRPYmVXRG12SXhjWHVhT0JsaG54L1dvUFppcEY5ZDczcWhBaTNCdkQ0ZUpz?=
 =?utf-8?Q?+zCG/ijGZxbh7bI23WxXDfJEZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6020966a-cf59-4c38-7000-08dbef728573
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:58:54.8711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq8FQ7g4Rr764XpJyVxn0By4OMnu5j2H2r8I0h/NzUPS1zzdBKSH4sfTqosnyFSEMnytZKlLCmKdnRZbsWr3ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5570
X-OriginatorOrg: intel.com



On 11/26/23 17:09, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Poison inject and clear are supported via debugfs where a privileged
> user can inject and clear poison to a device physical address.
> 
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
> added a lockdep assert that highlighted a gap in poison inject and
> clear functions where holding the dpa_rwsem does not assure that a
> a DPA is not added to a region.
> 
> The impact for inject and clear is that if the DPA address being
> injected or cleared has been attached to a region, but not yet
> committed, the dev_dbg() message intended to alert the debug user
> that they are acting on a mapped address is not emitted. Also, the
> cxl_poison trace event that serves as a log of the inject and clear
> activity will not include region info.
> 
> Close this gap by snapshotting an unchangeable region state during
> poison inject and clear operations. That means holding both the
> region_rwsem and the dpa_rwsem during the inject and clear ops.
> 
> Fixes: d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
> Fixes: 9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5ad1b13e780a..2f43d368ba07 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -331,10 +331,16 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;
> +	}
> +
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
>  		goto out;
> @@ -362,6 +368,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
>  out:
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> @@ -379,10 +386,16 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;
> +	}
> +
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
>  		goto out;
> @@ -419,6 +432,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>  out:
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
