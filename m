Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4D1BDE6
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724813133; cv=fail; b=SV9E2GhBELARnmhQkQHoPDbepjExM5+GoewBax1IFP/0ISLZCUvrmI8v9h2pHqIM3vjy1ucalJAh+0tCkcbmK8bv4iUr8HJE0JNWV44qntKXjkhY75X3bW/OhvzpjGq1CB54Sa5Go/kV9bpklmAP1Wgr6n4F22XoOmuGU/MxdAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724813133; c=relaxed/simple;
	bh=Pvmu4cJgpN7zW99GdvgKiVL69mwzXuq6RNPBx1WhkZQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oUUkbrhPn7fORzLdIOgyW7pmaVfILP8ZPJE9Z1QnIwSpsWkeZu+sTdwgHuOFuPmK+6XPVyXt4HAIBK4WjLekjXRZqyGLhgK77kNi1RFna3BmLvG0+NeopOEw7InxgcakpnORi6Oj/VwaLhK+YaMo7gLhiB9QlbfaofOCU+AM85E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIFAyDVI; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIFAyDVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724813132; x=1756349132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pvmu4cJgpN7zW99GdvgKiVL69mwzXuq6RNPBx1WhkZQ=;
  b=MIFAyDVIrwPudveqJkNP45sy903MAxM0zoowKc4VQ4958MfAGDOAtwNl
   0GvE03gYCT3kks6mACxmV6cdnn4x2zuG9K8nYUCcl3VS48MwzMBDrRZWt
   lfR8fIKVvbn0xSTX9pIlQnXAxHKjAg3Di52Z3sbyyg9IdllJlsNOdKoro
   bFbd3/ZDbaflxn/g9iA3p1cKNMF9BlF9kgmnCDWyUT3BXjOH+bNdp5H7B
   xAW2W7j3XNGYplkhy97tZXkg6U7TbsGGUL8wRmmYGPeN0RCXx4YWzIKvh
   HrbgyFgGxFpCM1obBmnaaWTYZ+DlfjPPhhtwNS8bFG6jI6mCTx5ZxzExY
   Q==;
X-CSE-ConnectionGUID: auiKVUwZTvq0bDkKzo2S+g==
X-CSE-MsgGUID: wpUm/CqRTvKTFR+Ygh/3LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23483323"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="23483323"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 19:45:31 -0700
X-CSE-ConnectionGUID: UCOPaYFPTeWH2Up3FXV9Sg==
X-CSE-MsgGUID: oerQVhu4TfyN1mfmjqtZ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63243423"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 19:45:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:45:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 19:45:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 19:45:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 19:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPrUA2DLbxFrNmN6fjdROn6fO6DrwZwU61fX18fYb3cmaIPbdCZK44nSyjgpUzQXnWan1fJ1pAP/5vbss9MqbXULUJrRG6ozH3P47oIUlFrqm2z39fka7K7ypVYYstPKtuGlEclfyN8OBwSY9lpx2Cg3FOFlbD8bNX2nfZRQUL6Hdc5bynJVbQdyu74Zvv3REPqdnwzJ0eys+u7CSdCCmcC58KfYFkErQKRqThKEmDokY/JObzmJuwjE6KPHu+7Pc7kOWbhq53qAwmi30G4taLGnmti6wtr30meyycZLymlHEDbnkR7W1zFf1hrTb83vXjA1AQvuMMR1yCEN1Uf9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUE+I0zbwmC3SJM9ZCLAA/GVw1Tni3tZL8BkOdaphTE=;
 b=fZpv/JmScFZkB3x3BtO8LKpp8SE8ooxk4fgzSLJS84TyPw6OUdWOTJD6Slj0Ky1kU1u9oGQkld0ktvSdDRNA3r+Zd3sBX6iNtVMUVxj8oq5dkxRUXKlVjeWqmk/LnT8TFbXfuszDjpwBRcS7OSkeKuT7JswI6G9E/Onbwn0CLAEzzeyYAYAHcmSTcJ0Xy1p9fln5/Fhtsm0+CMpzJpoC8JrkCFhv3lazUvwA5bLXYWVpzuR8so+xKVMZg7EJdNAdHd4cRXv0f8jPOLUExr8+P/c9L1yya+W+DA+dwc9uOJVicb16D9Eb4Dqlmvf51e3n9Z5Nns5q34ADb7zncMS7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19)
 by CY8PR11MB7036.namprd11.prod.outlook.com (2603:10b6:930:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 02:45:27 +0000
Received: from SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67]) by SA1PR11MB7110.namprd11.prod.outlook.com
 ([fe80::48e0:2fb8:7d8f:4a67%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:45:27 +0000
Message-ID: <30e8c934-1017-4e0b-9cb1-e8913b212ba4@intel.com>
Date: Wed, 28 Aug 2024 10:45:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 0/4] Fixes for hdm docoder initialization from DVSEC ranges
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
 <20240827170813.00004d7c@Huawei.com>
Content-Language: en-US
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <20240827170813.00004d7c@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To SA1PR11MB7110.namprd11.prod.outlook.com
 (2603:10b6:806:2b3::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB7110:EE_|CY8PR11MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 4790b3de-9939-490b-2c64-08dcc70b793d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEdLMmpka3VxcHBwZUZweFZRVW53WUlnTXNVLzZuaDl1dWlscmh6L0ozczFq?=
 =?utf-8?B?Wk5hU2llb2hXVHlTRjM5VjhxQkl5YXF4QjN2WFMyaFZwUmZqMmw4ZGNSTlVp?=
 =?utf-8?B?KzhwZG9wQlN6M3grSmxPREhtakg2L09welpNRUpOL3hxN1ZITDJ0MnRiVEta?=
 =?utf-8?B?ZW9QanFucWg5MlRUWFdrcmRYeitzZ1Z0RWVvelhySGVEbnJ0TXZHbElHeGto?=
 =?utf-8?B?elRqSjArcVZsSWcvRDFvQU11SG9BSjRqd1E0V0drNEFxaktsNEhXVm1ELzJK?=
 =?utf-8?B?aDVCZElTMm1aZk5TN2RyS0pXcWdkcm9VTlJMOEs0eFZQTFdVbkcxcXR2NGc1?=
 =?utf-8?B?bXdpWmhCaWlPek9sci9YcWgvRFVYV0xSQW92M0ZITHJNMnprUTM1UnB1VENr?=
 =?utf-8?B?ZzNJZ2ZoZUxGTmJJd281U2NTS3ZnREtZZGJiU3pMTTJKODluSGN0dlRSRUdR?=
 =?utf-8?B?M3JMN0hmcVE3VXcvYVduM3QrNWtvNW9TUWQvSGJ5cStEZnNubmo0YWpJWjFn?=
 =?utf-8?B?ak9sTlNPNGlWcW8vR0J4SEtXT0Y2emRHc3hXVDVRdENrZzZ2dHZRZkZicitR?=
 =?utf-8?B?RjY5VUpIS0hyYTlMamlLUFR6TjRCLzlLTnh2elRIbTdiZWlOSUt2OUd5Sjli?=
 =?utf-8?B?bmVtYWhjMDBua3RNNFFoMHRIUHp6MVVzdGd4WjlYREExT1lLNmZnZzNtT29D?=
 =?utf-8?B?bStsd1pCVTk3ZlcrS05Gek5MdXgrSm5tTU40MlVTR1lGU041K3VWM2RsbGpE?=
 =?utf-8?B?Yi84WXBBUitCYTNhLzRjTnVMWHpMMEFsR0NjUjR3MFQ5a3BhOGZ6SWUza2dr?=
 =?utf-8?B?aXFtajY5dExocktnZ1pycmtNVU94R1VZSHNVVFF3bzl6YmpvTHdKV0RJd0hq?=
 =?utf-8?B?NFpWK0ZZc2o0TzdadG1LM0R4S2NVSlBHMXcybFZNQ3oxUCtlMUtMVzg5YjlR?=
 =?utf-8?B?RVRnd1ZiUUp4RElFSURxczJWd0hFdFhUOXhTV2J6SHBLbWczZm9odndZblBr?=
 =?utf-8?B?QTF0bHZ1NHg4eDRkdG9HbmJWeHVPMUo5NUI4ODdPVFlTY1VqZzBHaEsrY3N1?=
 =?utf-8?B?MUorbG9XN2Zxc0k2YjVQZzdjWDJidzFCTmF6aXNUNFNLYmpXTS9nc3RsOC9u?=
 =?utf-8?B?OG0ycWhLU2lBWFBSbDhSWXYrZnRjUm4zNmpWOW0ydE42Zk52SW0xV1JVdng3?=
 =?utf-8?B?QVFlTEd6K1JzL0pBWmFBa3RkOHd1TWRjUlJ2dm9RSzRsRUxyZXhyWlYydFJP?=
 =?utf-8?B?cWF6amRyOEVMcU54V0RGTW1OR0s5ZjFIMEJmUmlEWlcxOTAzcWRzQkRFVS9i?=
 =?utf-8?B?QmprYzhZZnZjd0xhWkVTbEU3Uk5PWmF2M08wT0llL29YNHd2SWtoNjJYelNl?=
 =?utf-8?B?dTNKS2VzYlg5WTdnUFU2czBlRUgvZTlvRm1MemdDY3g1WVRJMUUrRHFEWnlM?=
 =?utf-8?B?YjdYRjU0TTBMLzd6Ym9rLzR0Q1B3M2JxK2p4djM4WFBIN2NXMGcrQWwrclI1?=
 =?utf-8?B?YVdsODMvSkxPazZYdjh1MUZnbHhlVFFhbzF2TEFER1B1cDI0TFk0aWtOY2Vo?=
 =?utf-8?B?bWR2Ukt3UmxpTkdOL1ozQk4wbkJLUExoclpMck4reHpzRURLQmVCZnczcDIz?=
 =?utf-8?B?UXJsOUFwcUg4L0FIZVF3VFZweHM5WlFiN09mQWZhcnlFOU1MS0pqYUIvT0ht?=
 =?utf-8?B?OUd5bEtZSjdNakpyZXV1b3l6WDRXU04yQ0dFSTVZSTZxdVBDOVNwWnR4Y1dY?=
 =?utf-8?Q?Rob54UmXVH25Cm9LhY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7110.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlF6b0hVa29FeXBtcGJXdWttTm5xYlprc1hwV2ZFWk9LMXFaWTFWV3R0OHc5?=
 =?utf-8?B?THZnUlNOYjJlM2R2ZkJKd0I0dDcwdEJZSCtXU0Zrb1haUnp2MWRHY25hQ3o2?=
 =?utf-8?B?MHZpalVzYlhNN2xTZFBKWDI4cS9zMlgzUWtvU0FGd01iaURVQUJwRVlLMjdm?=
 =?utf-8?B?cU1aN1R4MWp3R25IT2NsY1VjZnE5Ynh6MUZkRytIRGVSVnZEMmVqZWQxaFl1?=
 =?utf-8?B?T3UrZm55cFlHTTEraFh3enRMNnp3M3I4RUZlSkswRTJjZ2hyT2FDTVpNMHBK?=
 =?utf-8?B?U2U0S0pRQ3RUdm1xcTZlQlI0eVFOQlBMdXd0ZXN6TUMxQ3RkNGJ1Z1ZlNktW?=
 =?utf-8?B?bm42UTZZNkhueU5pVUVkWWFnR21OREh6TStEbkJjbjNTNUtoZzYwdG1JNDhv?=
 =?utf-8?B?NjBjWlZveEdpa1NZYUM5VW1hTWlOa0ViRjJHNTl2NFJadm5VOVN0Q2hPQzRL?=
 =?utf-8?B?RHRHSVRvMENOU291bGlhQWRuTXVVbzJGa1cxWjdxQTBqR1N1dWRIbGE0ZUNK?=
 =?utf-8?B?bkhyVnhyU2lYejZBTlIvQ1hQN0xnWUhjYnN1MHN5S0JBdXBlT2xYQmYzaVYr?=
 =?utf-8?B?dTRKT2F2RlJ6TzB5c0ZpQlpjWFFiVDhtOTkrSTI0VmxJeEpSWGE1UTlldlhE?=
 =?utf-8?B?K1diTE5CMDZyZS9FTVV4R01VMFgyWWdVMEc3ckV0MXQ3ZG5aNnpDbUlKb0VH?=
 =?utf-8?B?aTBtVDlFdHJqaUpIenFKZU9GNGIrTlI2SmR1cXFJMDNCc2dwTDFkc3R1UlRC?=
 =?utf-8?B?cGdFbWtrR3VMaDR5VUZNU0hkRDBJUjJvSW83L1pJNWM2eFJkall3RzdaTzVm?=
 =?utf-8?B?eU1ZNVpJZWtKTXBPVWs5ejIrUERkWlg1SVBsbDVqVFU0VzRHOWJCdHZ0cXRW?=
 =?utf-8?B?Q0JXZ2M3aFIya05EYldNQmZ6bVlrbE9ZQUwycnZsc3V5RlZpOWR0alh2MXZ0?=
 =?utf-8?B?YjBiZWN4NHdvVlNTVlhod1FDL2lMOFAvVEFPSE92dlV1RUZoNWc0QWo1emY2?=
 =?utf-8?B?ZzZNUW82VWE3U0pETndhZ2gxNHZodXorWkJiZ0l3ZEI2QjFuTGgyWndyYXBy?=
 =?utf-8?B?WGp1Z0dIbXdVNzVQWmFhNG54R0MwOHZUZjJxTnJZOWRacjdOcWIrVU5WR3Ju?=
 =?utf-8?B?MmxnSURlRGVSNjJlWDYwc3h0b2R0dWxFSFBQZGkybDd4cElCbFNud3MxSFEz?=
 =?utf-8?B?RUdER2JUUnErV1dyNEdHMFBkQXR5V0pLeEFlL0YyNUJBTThUUzJMZjBxM1JQ?=
 =?utf-8?B?TG9yVndCVmZnTWkzbmpTV0JJcHpSSDdSc0RqUFNPTTRCNHM1V0pGK0pBVVJD?=
 =?utf-8?B?OERocmkvSGdXdUdLYXNGVCtzNVAvZTYybk01eTI3TlJsTGl5Y3FNTmZpWUxI?=
 =?utf-8?B?K05MbGVLcU5pYjgrZnYvVDk3bjRkanA2cStRWUlzdSs3WksvcWovbzNCb0pD?=
 =?utf-8?B?a2l2NElCdW1FcXArWHFWMnVmMU5SbG5JZmJhUUsreGQ0NDBLUTZHYlZPQzlU?=
 =?utf-8?B?dU5rMHF2OVRGLy8yVjJ1SjV2TEhEbWhUYmFzSUlSZnhZQnhzcmx4NDQ4MWJr?=
 =?utf-8?B?UTJ5U2VpcEtSYmpjSU8xakxpT3NCSTYrSU8wTzZpb0s5YmVsMmpiMjIrbmlK?=
 =?utf-8?B?VkZBdWJIZ3gzR2tHTnNHMDY4T1R4QnAwU24yc3dUVno1ZG9HRTZCVVhsNHoy?=
 =?utf-8?B?YzIvalI5SS93UFN5T2xod09BM2JhMGxBb3p0MStiQ1QrZnlXa1JiNjhjcHo4?=
 =?utf-8?B?RnhrNGxMUmk1c3RmUFJxZ2diUEhaSzI2YWRRMW1lZWZFS2J1emJYbE1nNGpB?=
 =?utf-8?B?M09Ua2VOZTRWRzZrNXczM25nNjk1WDFsNzVqbE5JNTduMzlvODFmOEw3L012?=
 =?utf-8?B?aG9jeG5rTUs2WjBUK01YZWFBMXpNTG5GS2lZL1pieTU2Z3FuVW5TQmJSNkNr?=
 =?utf-8?B?L3VLNnBpTW1vN01iek9XbEVoam0rK1ZLNW9JdGRDNGZENllQTi9mUWdpSnZj?=
 =?utf-8?B?Q0tvZTVqN0RBMUdQcWM0Z09Wekx1T09NeXpwWFZ5L2ZhZ0NMbXdXTHhFaklo?=
 =?utf-8?B?aDRMVEdHbG1yR2ZTekRmQ05EUE9qVk1TbS96aWdMazg5MWh1TElnZWxxUU1x?=
 =?utf-8?Q?x2lzlMOmDJirEuy29kfN5Gqxq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4790b3de-9939-490b-2c64-08dcc70b793d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7110.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 02:45:27.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCNaxlVz+qEijj5surgIYN0H74btEfiC/6q25CipiVpXwOoNufgeoql3BMpuHQdROf2fr9HEaBr41MkCsZzX0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7036
X-OriginatorOrg: intel.com



On 8/28/2024 12:08 AM, Jonathan Cameron wrote:
> On Tue, 13 Aug 2024 19:05:28 +0800
> Yanfei Xu <yanfei.xu@intel.com> wrote:
> 
>> The first and third patch are intended to fix potential issues regarding to
>> retrieve and record DVSEC ranges. The second and fourth are cleanup.
> 
> typo in patch title.  decoder
> 
> 
> Also, good to include cxl: as prefix to the patch title.
> 

Got it, will do.

>>
>> v2->v3:
>> - improved the commit message of patch1 to indicate potential impact of
>>    the change.  (Dan)
>> - Dropped un-appropriate "Fixes" tag. (Dan)
>> - Dropped the patch2 which is a code movement in original patchset.
>> - Separated the original patch3 into cleanup one and logic change one which
>>    are corresponding to patch2 and patch3 in current patchset. (Dan)
>>
>> v2:https://lore.kernel.org/linux-cxl/20240809093442.646545-1-yanfei.xu@intel.com/T/#t
>>
>> Yanfei Xu (4):
>>    cxl/pci: Fix to record only non-zero ranges
>>    cxl/pci: Remove duplicated implementation of waiting for
>>      memory_info_valid
>>    cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
>>    cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()
>>
>>   drivers/cxl/core/pci.c        | 74 +++++++++--------------------------
>>   drivers/cxl/cxl.h             |  2 +-
>>   drivers/cxl/port.c            |  2 +-
>>   tools/testing/cxl/test/mock.c |  4 +-
>>   4 files changed, 23 insertions(+), 59 deletions(-)
>>
> 
> 

