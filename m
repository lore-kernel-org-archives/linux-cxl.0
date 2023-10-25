Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A52D610
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3BSW1gl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA510D4
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698199134; x=1729735134;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Vkno7vO7/fwlg6gJJM/SRMG3Q0fVM5NJa0fDJLEIhMI=;
  b=I3BSW1glhG2qS/RtUxGcOrhJRqhfFjEF6l5mCeolBDyt0xV9rxAmhV1X
   NtKNYLBSZH/EdXzHdA0f1KSYx77OaVWXEjQqLG7wsim+HYotjCuFnVwv6
   dVPmahjAvduQZTRiIu9pLhKyM5EgYXqdC/qRyQondnDcGHZ87edLrxKxw
   +bF2Y6/fsSJUHW1vyRIthiXv2L+cAeGEiXhOZ+20+t+bdzAGuBPk2aylY
   1w7hlV/Lk9Hpnq/broQwzmNXXIKSh+dvCdFRU8AWE37XGFGxWMETzYFZ0
   5qO2U6qoJxvmGhdjymSmyqxZjD+wHNOt6lP6dDO4wdX4Q6rhEbUMmlfRM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5832014"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="5832014"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 18:58:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="824505286"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="824505286"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 18:58:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 18:58:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 18:58:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 18:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPUoYq6Z3WxvUrCdshaWMNQdixWX9DICt9MBD9wsq8tO5RPD+TPoMcfAQZPxV17icypGyZApcOmzHgQvhpN9Ob6W1l60oMMAtVw8loVKNsp2Y+0cbmLik8MYj1UxCWJ2emQ6eNkfSYaa2P9cf/lD4mo3U1Naa9mYw4IojvTS6FTMOoWBwcFMAzweV0nT2m3XIkkDUP7jvDAdI2iRR94W72dlZX2v86hBFFUm7W/aySryVCGxOQ6ObSFLyFGBllkz7t+kiwRv2J6zUKL7LOXxs9TbQ1TpEzQMK1wZF1cL+q9Sw2hKtsVUsqpRD4fywX/lZlsdMdvhQhA1220ywp6Sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdLSGj4lWQSAYHV96B4n8EUP7L/kjfDa/TwJuxnrZHo=;
 b=KZDVuxNitM4Ezg0YGhBjOszeqJiTArPvqTMY851HBo6NfDNpIVsOC5wCoDsdAN85KTPFcUQ2l5ux5ep4e7PcMBI9mg3JivECrcsNJCjGKV84JqUHumiKtqcDMA/rb0OLPr+VzUgP6ZzaE1rRMn1Mxwq8Wr+hatIWNIV4HCwyBK07yfopr/sECOP3MIp8fFdWwtTItS+lsZP+UNNoaKQs42CKcXjBwRpT3QGLOUnco87FH2shN5EXwdAayFuMRltYTYqM4JzHbncuSTTet2bLcU65g2bJ4aMy69wmQPZ2zYVbzsIiQ0k/7PjGnLdDQWcWP3W5eUycZWoQvtYK2NbQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 01:58:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 01:58:49 +0000
Date: Tue, 24 Oct 2023 18:58:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: set root decoder granularity based on region params
Message-ID: <65387657991e_725832949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f@uscas1p2.samsung.com>
 <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
 <651e0eddb7f6c_ae7e72946c@dwillia2-xfh.jf.intel.com.notmuch>
 <A9AA55AC-F925-4B7F-866B-7AB849CB6F36@ssi.samsung.com>
 <6538679925e75_72583294bb@dwillia2-xfh.jf.intel.com.notmuch>
 <ZThwgJM2pSyTFaXQ@ubuntu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZThwgJM2pSyTFaXQ@ubuntu>
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: a506af21-6397-460a-5be8-08dbd4fdede5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f5R4eXY1f5aUQWon7VkGlcN684pZx1fjY1/cH/PkzQHjL2xBakRnNN9hpO+JvoteQ+PubEreXCMaOllGSp3yHKXWG+LSUTRkJJGnmV8Qqg9/PUErwwDKi+nQ0r8Sb/nyjXYwwaT48UxY5O19Xrik6DJwj6hi9Ar0qn+KMYgRxXxwxg+kDzYAE2OWehgFlKyFP9RlLNMwAjTgUd39ZCWRBcZbAtWCQikMwQV/RDpc7KeaIwCR1Qtb+daWgOtBupDhH/ycsrVD3ULgimqvIgDPnmB9WSXblcAF1YwplHVcmU4SHG2AQU8OIKPYob5lxn206wxhoG9qNPXw/PhG9i1KuJwFSG7Rsdo2tUrFaNtCuU8J2oXHbq9rKoJ6EXk9+Q1x7/KkdKHVvk08WW2tuyVk80SstLGGpOz9NImhEw2c0mp2UdUWnxwFE8qa8NvGCA0hpfsNlFIpeODiiM05U+P+9ZKGoRQsrMe82u0caiuFd/78gpH70K+pJ+O0J47hWmA41pfwhOSpJX51GUv1SdJ/4r7LDMaxyZaS3BdO/OCYEGcNpdm9nxZiNu/vM35JzL/gkGj1sZj6pkhiwE2go8CekmRMtHKfd3x9YbW3K75kLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6512007)(26005)(9686003)(41300700001)(6506007)(4744005)(8676002)(4326008)(8936002)(966005)(2906002)(6486002)(478600001)(5660300002)(66556008)(66476007)(66946007)(316002)(110136005)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1EQWp1YVZ4U3NGcHBLMjhJM1dlT2pPd0hMaHdTcFBBSmpJNWxMQU9pNE9W?=
 =?utf-8?B?aWpZSUVPS05RYVUrWEovTzBGWnlid25QRnFqbThrVDZEUTdnNzRJRTN6aHN0?=
 =?utf-8?B?WTYyYVJFNU5tVzdiM013SzgvOENYeEN6OWwxMDZHcEJkVlZ3RW9kOVROZG10?=
 =?utf-8?B?REZQRml3blRXZ1ZzWEFRMkpvZHBpQ3gvUktCc0xSMWxaUTNPQ0tRbWlmUUpX?=
 =?utf-8?B?cW5HVEZKYU9TdXBPNEVUWm9uYXdEV0JRSVA1cnpkWHVaRGREd0ptMytVY09K?=
 =?utf-8?B?d3lzTEk2TlBzS3oyVWhiN05BVUs1M294aWk0OFV4TURTN08zcktaWUpJNzhW?=
 =?utf-8?B?c0dFSlh5VnQrTjQyc1JGNDhsK25GT1JiTDlab1g5RU1QSTUzUXBXcnBSaDNj?=
 =?utf-8?B?T3c5ZU8yd1puVmlRQW94dDA1bEZiMFQyb2xJN251c25zektrSHN3aE0zVXdG?=
 =?utf-8?B?NUZ0cVZxM1NoZE5UQmNMUFBrQk56NG5qODQ5cFJ4QlRBeHVzZmhQeTd5VHpW?=
 =?utf-8?B?UkYrTTA2cW5tcS8wUGo0cGticjl6UHQ4UVEwelJ3SVdQQnkyS3VYb1BSdjE1?=
 =?utf-8?B?d3RmR2xMeTEwTWxaN1VaRFZRbkdnRFN0bE00VFZnN1l5cVRmc0h6dGp6VXUz?=
 =?utf-8?B?V0J6dGdiRkg0dWp4VFBNS3hXVXhRbXZnZkNrMVFQSkYwclJlN3RuS3UzNXVz?=
 =?utf-8?B?R0ZvdDdaN3pHWFZuemt0aE1vYkFXWlNjYlhPN3VqV3c0YU0xVEtmSVA4dXRQ?=
 =?utf-8?B?Sk5JRXhTWDBCdVNMekdvYWM4eEZteGhROTVRUFY2QXRFRFhvZEpWakF0WHdF?=
 =?utf-8?B?RVM4UzBDUDZFb1NvMWFaeFUzaHdHd2d4NHRscEF6ckxGOG9OajhkSUl5b2lW?=
 =?utf-8?B?eG80V3g0emxBSitTT0RJclY1NnRUNm5FN0V2bml1WUkvbG02VVFpdXMvZ1RU?=
 =?utf-8?B?SzI0NUd0SVgrZ2xkUnh2QVB5VGVaY2NjbEVMN3cwS1UzbUtLYmptRldHYkJE?=
 =?utf-8?B?M29hRW9NRCtuazhqajNhbzhsOWhVeDNjaUJ4L2EzUUR5ckx4VDVwS1hnRHRa?=
 =?utf-8?B?c0FjQTFjdEtRc3JxelpFYytPVGN3bXljQ2piT1ExZ1IxM0dJcXcxZ1ZVOUc4?=
 =?utf-8?B?RDBkZTBwWnBzT2wwajRIS0gwdUZxYVRLcDZkcmZldHNjZmtDL2RjV2gwRWhK?=
 =?utf-8?B?OXAvcTkzdmN2dFZxKzNrWFplajlpQnlISVhYaTFHZGpycGMzN2JrdFV2NHho?=
 =?utf-8?B?ZUFDNUJ0UWIyWVNmRm9sdjlBdEk4Nm9wSzA1MXVoVHp1OE9HcnE2Z3lpMTlG?=
 =?utf-8?B?SFR6RndHWXFKanJqZHRMTCs1R3ZlMitWTEEweTN2cXVFdDNHY2hVYXZGL09V?=
 =?utf-8?B?VytPQWk1azZQaXhFemFpNTVmaTZ4ZE5VZW14MnNkUHlucFRaTHRaMlhIWUEw?=
 =?utf-8?B?NmgvOUx5d29QbFZYR0xVMU5UYlVpZUF2VXU5UWJyU08xMzcxWHk5MjlhN1pR?=
 =?utf-8?B?ZmVseEQwcmQzMDVGYTRoS3E4MVpWWHFMWDRrbDNNZ2lYSm9ic3c0dUJaZm5j?=
 =?utf-8?B?M1Fzbyt3NU55OWd1QkRIQ3hybkdXM3d1L1p2a1lUdVZyRjZVZnNzcDZxeHNR?=
 =?utf-8?B?dTF4M2tkWFNxNHA2UXVRd2RrOEdLYjBrRGEyR29LSlhEZEVidDFlOGhaNHpP?=
 =?utf-8?B?emUxeHUrVUhmOVFKVWFCK1BzcERkWE8zSlhQNWN4WmVCTmRyMExaK1dMWU90?=
 =?utf-8?B?QXlWRGthNFZkeCtpSkdaTTYrQUhnc3JlV1krenhKenZWWGlRa0tHeUNDUWI5?=
 =?utf-8?B?Z2JHaU9Zd2lzeHlSUWdUV2ltVFBMTzczZWl1Qk5QeFNGV0ZiVDkwUllXbC9Y?=
 =?utf-8?B?UXF3N041c0VVbmwycURXdlJxZGhEcWJrWUtYVmorYnZGYzZqaXBUOFZjNHdP?=
 =?utf-8?B?L2dUZE42eCtMYkdCSWxIMnp1WWN0a3djVDBITWdUT1l0QU1UYnJiMWJVTVgw?=
 =?utf-8?B?SGV6LzZKWXFydG51b3d6Nm9ZU200T1hreHBGeUNCRy9EeTAvMERoUFhqZ1J4?=
 =?utf-8?B?MFZIODc5cEFVeTBkQXBQaDdQNDJtL2l1YmFldlVRbnFyZWNxRjRDL0t4RmFq?=
 =?utf-8?B?L0Z4Qy9idzF5WHgxSUpkRHpYUXVlN1ZlbGsyNkxCZ3cxVmt3NU1YUzYvZlll?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a506af21-6397-460a-5be8-08dbd4fdede5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 01:58:48.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnqEGh6z2GucQcUcon4okCLhtRMj5l+iebJEP2jqwiO3XjAb2fmUPdHPLi3I3b/i7RSmCeg/M2RdetSGWQ2k676WxJSH6dP7rwh91VYwluo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-OriginatorOrg: intel.com

Jim Harris wrote:
> On Tue, Oct 24, 2023 at 05:55:53PM -0700, Dan Williams wrote:
> > Jim Harris wrote:
> > [..]
> > > > So I think this is only valid in the cxlrd->cxlsd.cxld.interleave_ways == 1
> > > > case as interleave_granularity_store() forbids regions that do not match
> > > > the granularity of the root.
> > > 
> > > That’s correct. And now I think it’s better to put this assignment in
> > > interleave_granularity_store() instead since we are already doing
> > > root decoder related checking there, and we would then just be setting
> > > this granularity once instead of once per memdev.
> > 
> > Did you ever send the interleave_granularity_store() version of this
> > patch? I can't seem to find it.
> 
> I found a third approach that was much simpler than the effective_granularity
> approach. It's in this thread with a completely different title.

Oh, this one
http://lore.kernel.org/r/169660931834.684402.2774329392272976121.stgit@bgt-140510-bm03.eng.stellus.in?

I'll go comment.
