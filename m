Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD121C32
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 05:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722921579; cv=fail; b=UL2rBJle/ONpb6n1L/u74yr0V+vNfRDaEEFMxMH0H8Ply76v2nL5XWypjVZCp6eicH5vsln2U5BhaexnXC8QS5dIyrd2q17yl55p73iaHTLh2isdavUWqvILppX/qJACgFPlgPhZqPWsALOJW3KZxUkTtVPK30e6efBnduI/2ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722921579; c=relaxed/simple;
	bh=tSiw90NRERpaOnoBWCNKkP/qc1c9yZp28mbPEWuFUco=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jf7+Q+jz6/XpvCLGfzaPbPAe8Mqk/ci2qbt0ql/rXBZDH2aiJpxm48saGvw5yzEj3W60pxAqR46Mnet+fCUZBNq8aiHAisE9bMuduAhjzzSJWrPbScIVkSHk3S4sgEEG6hGet3KHZ/cp0PSE+FUAxREoyVuXr2J0bGcsHiG0l2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeyyeftB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeyyeftB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722921578; x=1754457578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tSiw90NRERpaOnoBWCNKkP/qc1c9yZp28mbPEWuFUco=;
  b=VeyyeftB9rDd73l2rSqaXoBkEdauBfqGz7CTSwU41rOnRxGA/bSzXtOv
   dd7i92zs87cELmAbwzS49rx3ni1PqNH60dWzZDdLbabhuN3+fXvcJCyfk
   JZhr7TAkN9i6F/XxBeBGe9WXdbzjYP3zsbZbXJ2/JB8BBsEp9nhWonrKb
   melv4GOb6JKVUPpYf9U0sV33SwLxmTuv4pyuLMA1j/5DlUejP/Mo4up4s
   xqpp/aAi0hDzYFoczwBIEqHXPohTZG75iXgUh+eH6JIcGgDS5ji7HzUot
   tQqB1IqzmzpqdxlrvUAXHWMxNeQMzaz14xZpPwn8ZzQhBGh4i2TNNelIN
   w==;
X-CSE-ConnectionGUID: XZAAbGfBQPemB4xXQ8S+4w==
X-CSE-MsgGUID: WqOrwFtgQIWDErnk7gIQ5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20732625"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="20732625"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 22:19:36 -0700
X-CSE-ConnectionGUID: AQ/Ypl/TSE6Vzw+iVe0azA==
X-CSE-MsgGUID: iaASojbwT1WxYKOrQ7a8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56083181"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 22:19:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 22:19:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 22:19:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 22:19:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 22:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrb22F3V/80szU8v5Zp2JgkMf19uCR1c8jwvuvsZeXlw/n1lTlRlR4lxyeOHaQ8uc8/7Hru4w3uMuWCcn0pvi1/wImYeUnxJY8m4yiR/HvYeYUVzkXUftNxl9UJ4uoLHHkiauDyDKwKQL4DSz6aVx2HGfdg7BNrZ4I4TXuNZr1DWv4xGHdPJiseyKIG2EwI6KhS73/YOzFNu/AKfZRx+/WfC2sSBDbvMLrK3h9gEgj5nNmhhqo30x32FS7htsb7svFLO2WSLnHPlo8y31kCxL6U1uvtPjwMNqs48zoCke9cgqpB6eOB0LnAUQgZd5xipkI4nTJnqWG2g+qXePTGmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyemAu2CkZkB2cMlb9CBLOZJUodVGvrwpAdCpirbxbk=;
 b=fRi2Unween86Bkaogj/CI0TNlpiDX0AN7kwnAOLylRgHEnyn4uDmilG22H6et78M9/B3VRCBw7+mWXPn1ckLix1qy5zQi5PG5crHXF4lDfIPWMtipY+8j3YV7qzDL/y+iCQc8Ahi4hGkHfdyZC16S/5hP9X56cB2nSu5+ifdt6SELN33++42tejKfxL4lgNas1qQ6rqWMxbBtnEihpXZqpH62kVxkT1s4pSO5XdcC19B+P5ZGrkkZapxkwoot8gSnCmtc3O9spVdflfNBBIOo5fKtZJN4zmRrKDunmFOQiIr6hPlW+JciJ40NYs1JrF8e9TZFistAhQLGZIxPKXMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 05:19:24 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 05:19:24 +0000
Message-ID: <7d1a47c8-4de5-44a9-b992-7f86d76366eb@intel.com>
Date: Tue, 6 Aug 2024 13:19:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [CXL] There is BUG: slab-out-of-bounds in cxl_setup_parent_dport
 in v6.10
To: Pengfei Xu <pengfei.xu@intel.com>, <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
References: <ZrGFWYKwxa1ld9Iz@xpf.sh.intel.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <ZrGFWYKwxa1ld9Iz@xpf.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|MW4PR11MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f82e3c-e4ac-4aa0-dafa-08dcb5d75586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHFURUU2VWpONVc1TGovNkw5NnZTRkFLcmJjSk9ad2JZS3NTVmNMOHpWUk5w?=
 =?utf-8?B?MjhsMEJESmhtRzRrNk9PQkp0enBQSVlYb3F4QkxIZU1ROTQxSlpoNUo3cUZt?=
 =?utf-8?B?cENVVk5OQWNLRnlZNzNtSUZlL01mazV4SmoxUlpybXNGc1ZUSzZmZmtyU3R1?=
 =?utf-8?B?SFJibnE0ZERPOWZlVDJnYlFKZUtGTnBNcDRaRjlNS05vV0RKK0ZBZFFNeWY2?=
 =?utf-8?B?cW5WZzFrRklWb1ZWYzRFektMT1M0MTM3MjFBK2RXTGVZUDE2b0F3T09Wa2Nl?=
 =?utf-8?B?bnFjY2xPY3ptL1FSS0c5QkdlTUtnVXU5VndjT3FyMTkrUW1XdDRaejdMa3g5?=
 =?utf-8?B?Q1hNYS9NckRLOGJUWGlKcHpyWXlkTFNiMFBQd1ZUYmxKL2RVbGdERUN6d2cw?=
 =?utf-8?B?eWxvVVBmOU9Kek1CRWhoRWJYSk81dlUwckIvak5xS05rdmtxQ3VUQXE4ZVBt?=
 =?utf-8?B?Z1pvRGpsZUphM1RLajA2R0wzLzBWYnZHNjQ5bE1NTWFuSEN0elRsZ0RVa2xP?=
 =?utf-8?B?VkY2MDJVNGljMDhlUENzV20yME92emk1Wi9XajJTSkpoZ2RQaDlicHdaalpB?=
 =?utf-8?B?ZkR4cEEyNjZXTG1lNWRSNTcyZ2JFVzdvYWVkMFFxMFFRTURIZzZmb3FWOW9q?=
 =?utf-8?B?dFlTVVZFWnhQYW5MVnp6T3VzK0w0c1Zpb01vcHplYXNTTFcyWmp6clhnOU5X?=
 =?utf-8?B?YmJ4NHpYZWpoWEJRZ3YwZkJWaVNJeGdxZVJyNEMxamsySUZOSnA1WkQzdElF?=
 =?utf-8?B?RG4zVWhGRC9GcGc5V2ViSU5FMHFhKzhlZ0h0dnNEc1dWakx1SVZJMGYyZ2U4?=
 =?utf-8?B?NzJSYXJPRlVWNmFlUXVVMDg0TUJKWHBBMG9zSDBzTWxKZGxJbG9zekdHTU9W?=
 =?utf-8?B?UG5NZEhoRnl2d2wxL1JFdGpDbzhzdWRMOGVCOSs2RXZraG5hWndNTWdHdDhH?=
 =?utf-8?B?bWszTHJxeVZuaUlJbzU1UElnSWFYTG1IT044bENlb3ZkMzVNTDlpMEhaM1J2?=
 =?utf-8?B?eHBudnNlS3pROXltbHpsZFRKdjlqMlViTGU2Q015Q01naHI3WmpuVDFsSThP?=
 =?utf-8?B?dXRST1BHa1JhWDlUemUvRWQ0Rm5tK2FFTGVaZ0hVQUdMTWlEK0Uvc2VsMlJF?=
 =?utf-8?B?T1dsR2lLV2k2N0ZhOFFLQzhOUml6ekdvZm41ZXJheWtJVW9GajhObmhrKzVi?=
 =?utf-8?B?VnhWNG9GRDJPMDh3UTg1YjRnRTZnaFJsenl1eW43YmJXenJJaTMvRXRIcll0?=
 =?utf-8?B?R1RQN2ZpNk9hRUYxdDlxTjBDOTFnZDZ3SUFPMnJVTVk3VEY2UTluc3Q4a2VJ?=
 =?utf-8?B?cDdWdGJIODBheXRDWExhZ1JVRWkySTlmaTlxaGVkdFB4dkNJTzNQeDJMRjJq?=
 =?utf-8?B?SktMUEdZOU5NazJ5TGF1bi81TDBmT25LK3lrYno0SlIyUTBtbGM2NDR5L0ww?=
 =?utf-8?B?TVlYTFlwR2NTdTZZQ0YvQWlBNmNEMC92Q29KYlQxTUFJRHRDVS9NblJVaVMw?=
 =?utf-8?B?WEZPRm54d3Y4SElQVUZFaDlCRWJZK2t1c0NnZE5nKzZGYmFady9WWWtiWDB3?=
 =?utf-8?B?SFB1ME9HbDRleERvcHBLaDRiM2ZUUUlobkovQmoyV2VWZkVvV0FGM1F5NjRF?=
 =?utf-8?B?SEdzQTIrQW9heVFCYWZOMjhxSlVwdXZkOUxXdHJsOW5kak5pRmRiSUFYMXNQ?=
 =?utf-8?B?b3dYaGVCUTBDM21KR2UwSUdEcDFlR0FtRk9KQSthdGlsTGNiU1RTVE5UTnhT?=
 =?utf-8?Q?qhfIu88tR+ugHUCQJPC2VTb5TiGqU0bGHn4HeWJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpVRVZ6c2dCUFpBN2lYWGRVK1RCSmRaeGRjTjZYNHVqaFdQOUp5WUlRSWNV?=
 =?utf-8?B?dmJmTThXZFEwdUVKVWtzeUR5VTNwSlpLVFpWK0dGMUxkYXc4MU9TbzJDZFh0?=
 =?utf-8?B?dVNjWnBHMHRmbjJOcUxvT05JNk9TZTRjNGdWQUhKbGp6aEpvdStaRDk0Rmxs?=
 =?utf-8?B?ZDZoWkFlUmFTL3MxdDRCUWs0V21SWkxYQ1R3UVZua2dIRVdieWlZMXEyNzly?=
 =?utf-8?B?VlQ1K1BydUtNZjg3UTVaeG9kTEhscEtxOFovWkMwWHpydlVFaUpralM0d0Fp?=
 =?utf-8?B?SWxVbis3NlJrZTZ2V21RemlxSTlMTU1tcGZmZm16aHNSZkVuRTZ2b3U0NC9P?=
 =?utf-8?B?Q1ByQnhpU3VabFVrQnBYVmE0NDUvbWlXR0JEN0xnS2xkZHRXd1hkNGlQSVJG?=
 =?utf-8?B?N1pOSzBoWTNRcjJkNTFDYnBjMFZNUWZUamwzWHFMaGdCbkx0TTlrQzhTdTNn?=
 =?utf-8?B?TFFjdDh0ZlVpenEvNmVxcngxQjZBdTluQys0dDIrdkMvNFNxWFlmanNiSkNt?=
 =?utf-8?B?blR5ZURSKzMzemowSkQ2RWsrL3JjdnB3ay90WWVycnBKeHUvUTZ2Nks5dkJG?=
 =?utf-8?B?M0hhalNDRHlnb0c5WlhGTzcyK2Z2U2JCQzl4M0Y5OFZGeDQ0eUtBM1lpWkZ5?=
 =?utf-8?B?clk0blZ0M3o5T0tPNFpqak5pVG9ncHFSTGxySTFtMGJ5OEt6TFFNd052NnRz?=
 =?utf-8?B?aktaeHgxK2JzNExrSEh1N0VrQlZnMytvck5vMk5kODVaTldEL2wyU1RLdnFV?=
 =?utf-8?B?VFhEOWZKcnU1Uk84MWo0WWxTNUZiUVFYQjFUYk9hMkt2ZW8vV0duRHhMOERE?=
 =?utf-8?B?R29yWVkwc3ptSWt4VXNCandka0dzZEg1VUdpTDkvNlJveW5BT3k5bllQNUlN?=
 =?utf-8?B?dk5wNDdiSlFqbnhBaFhxUHg0RERyVnBrV0lOUlBIVjNtbm9XUCtKcktFSHRZ?=
 =?utf-8?B?bnc2WDAvTjlVelhFbVRuc2pTWC95cFN0aExCOXF3ejVJQlBZckFWYVd6RlpU?=
 =?utf-8?B?dHNDYVN4eVlacS9LSGQ1V3AwTjU3a1dYM2JwMUR0YkZNMU5uNUloODREMW9T?=
 =?utf-8?B?NTY4TkQvYXpHcklpc2Y3Ly9hSGxzNWJBdVJVMFMvUzJGQ2tPdTFCbXU5VG9W?=
 =?utf-8?B?LzhpT0QrNThuc0F6bkVOVysweG94YVVYMEUzUnhJSGhrNWROOU03Ti8xOXNl?=
 =?utf-8?B?VWR5WXFTM3hjSVg3MEVRZHppQ0RHcDhoQ3pSRStjSzVyaFB3SVJrRnAzTlZq?=
 =?utf-8?B?SlhRUUtrellhdWpFR3hsNzlXUHJ0cjE5dkMvdnNqdW5QVFlXdkJEQ1cyK2tL?=
 =?utf-8?B?L1hZcEtEWHdQRnduSkhzZnJPTDdoTmdzaE43VWtDdXFlSjROV3MveXZyZ3lT?=
 =?utf-8?B?TjVVM1k2cyt4b1dCL3huMmFEdkMxNTUwYUlHeE5jRFlmcUptdFg2YURQRnUr?=
 =?utf-8?B?OVd4SlZOOGpMRG5IUk05TjNOUmFKc3I1a1ZSeDhpNytpN1BuL1BYeFp0eis3?=
 =?utf-8?B?cXdIanNvOVE4ZS9iZmNmNHBHRk84cTZ0R3RGZ3c3NEViSFRUa01rTjJzeGNr?=
 =?utf-8?B?bjMxYkNPZDB0STFCdjcrUWJaUFpFRzBjbnpsQVZDVTZ4ZEdNMFNnMjNSOTRk?=
 =?utf-8?B?M2VZVUZETzZiOFV0V2lEcm1tZDlic0JqaDZUVndONFNxSzJYT3hOY1FXQzha?=
 =?utf-8?B?R0QxNkFxNFFHaDFyUTRUSnp4bVBMQ1NrbndjRUdrUlJpWHRVSmtvRkhsWlpp?=
 =?utf-8?B?ZXVQcnBnSUJ1N2RMTUZNODF2UVQ2RkJaL1RNejNwSm1ETzF2ZHJLN29Wc09Q?=
 =?utf-8?B?Szhsa3hRM2ZOMWpRV1k5RnVoaHZzc2YzZitPTkpJM0thdUdRZ3Z6NTRTdmdw?=
 =?utf-8?B?NkFKSmp3V2NvQ21UM1JHL091OEExWnlUWmRSWXlRZmdUQ3pUcFdYcU1rRWFG?=
 =?utf-8?B?Y3JMQ2NzcTlEd3ZvNkRqei9zWFppR1pncmI1aDA1cjJWYkpNWnM3bTh6NVA4?=
 =?utf-8?B?VHhFaFBpSFo2ZGlKN21DNkN2Wk9MWGoxQkNGT1JyQVp2c05CVGhCbnVERS9S?=
 =?utf-8?B?MEk2QjBWM2dYMDdGU2t0VlBIS3NpMEUrc1RxTGtTNFdJOTF3dUdpemtPNmtJ?=
 =?utf-8?Q?gQVLgJrtKqqmhFVPLpNoholSM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f82e3c-e4ac-4aa0-dafa-08dcb5d75586
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 05:19:24.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKo9Vj68u43b57tBSRqsfUqAeZpmeP6oW/uucEw9G3KM0ibWJNDVzIDGSZJSJmJ5/qdAt2ydLcyKq2EmrO/g5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809
X-OriginatorOrg: intel.com

On 8/6/2024 10:07 AM, Pengfei Xu wrote:
> Hi Robert Richter and CXL experts,
>
> There is BUG: slab-out-of-bounds in cxl_setup_parent_dport in v6.10 when
> boot up CXL qemu environment.
>
> It's a kernel tools/testing/cxl testing in qemu simulated CXL environment.
>
> Related kconfig and dmesg are in attached of link:
> https://bugzilla.kernel.org/show_bug.cgi?id=219127
>
> It seems to be related to commit:
> f05fd10d138d cxl/pci: Add RCH downstream port AER register discovery
>
> KASAN and CXL kconfig could trigger this problem:
> "
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> CONFIG_KASAN_INLINE=y
> CONFIG_KASAN_STACK=y
>
> CONFIG_CXL_BUS=m
> CONFIG_CXL_PCI=m
> CONFIG_CXL_MEM_RAW_COMMANDS=y
> CONFIG_CXL_ACPI=m
> CONFIG_CXL_PMEM=m
> CONFIG_CXL_MEM=m
> CONFIG_CXL_PORT=y
> CONFIG_CXL_SUSPEND=y
> CONFIG_CXL_REGION_INVALIDATION_TEST=y
> CONFIG_NVDIMM_SECURITY_TEST=y
> "
>
> Dmesg info:
> "
> [   24.413405] ==================================================================
> [   24.416332] BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> [   24.419291] Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
> [   24.427232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
> [   24.430089] Call Trace:
> [   24.432534]  <TASK>
> [   24.434891]  dump_stack_lvl+0xea/0x150
> [   24.438131]  print_report+0xce/0x610
> [   24.440498]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> [   24.443129]  ? kasan_complete_mode_report_info+0x40/0x200
> [   24.445602]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> [   24.448221]  kasan_report+0xcc/0x110
> [   24.450527]  ? cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> [   24.453140]  __asan_report_load1_noabort+0x18/0x20
> [   24.455455]  cxl_setup_parent_dport+0x480/0x530 [cxl_core]
> [   24.457986]  cxl_mem_probe+0x49b/0xaa0 [cxl_mem]
> [   24.460285]  ? __pfx_cxl_mem_probe+0x10/0x10 [cxl_mem]
> [   24.462592]  ? sysfs_create_link+0x75/0xd0
> [   24.464775]  cxl_bus_probe+0x5e/0xc0 [cxl_core]
> [   24.467153]  ? __pfx_cxl_bus_probe+0x10/0x10 [cxl_core]
> [   24.469632]  really_probe+0x27c/0xac0
> [   24.471750]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [   24.474087]  __driver_probe_device+0x1f3/0x460
> [   24.476288]  ? parse_option_str+0x149/0x190
> [   24.478435]  driver_probe_device+0x56/0x1b0
> [   24.480543]  __device_attach_driver+0x1e7/0x300
> [   24.482682]  bus_for_each_drv+0x159/0x1e0
> [   24.484818]  ? __pfx___device_attach_driver+0x10/0x10
> [   24.486935]  ? __pfx_bus_for_each_drv+0x10/0x10
> [   24.489037]  ? _raw_spin_unlock_irqrestore+0x45/0x70
> [   24.491097]  __device_attach+0x215/0x4f0
> [   24.493055]  ? __pfx___device_attach+0x10/0x10
> [   24.495032]  ? do_raw_spin_unlock+0x15c/0x210
> [   24.497020]  device_initial_probe+0x24/0x30
> [   24.498922]  bus_probe_device+0x18e/0x1d0
> [   24.500732]  device_add+0x11b6/0x1b60
> [   24.502485]  ? __pfx_device_add+0x10/0x10
> [   24.504275]  ? __pfx_exact_lock+0x10/0x10
> [   24.506063]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   24.507931]  ? kobject_get+0xc5/0x160
> [   24.509619]  cdev_device_add+0x13c/0x280
> [   24.511319]  devm_cxl_add_memdev+0x547/0x6f0 [cxl_core]
> [   24.513287]  cxl_mock_mem_probe+0xf1d/0x1d30 [cxl_mock_mem]
> [   24.515133]  ? __pfx_cxl_mock_mem_probe+0x10/0x10 [cxl_mock_mem]
> [   24.516998]  platform_probe+0x10a/0x200
> [   24.518813]  ? __pfx_platform_probe+0x10/0x10
> [   24.520638]  really_probe+0x27c/0xac0
> [   24.522340]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [   24.524194]  __driver_probe_device+0x1f3/0x460
> [   24.525972]  ? parse_option_str+0x149/0x190
> [   24.527763]  driver_probe_device+0x56/0x1b0
> [   24.529555]  __driver_attach+0x277/0x570
> [   24.531278]  ? __pfx___driver_attach+0x10/0x10
> [   24.532912]  bus_for_each_dev+0x142/0x1e0
> [   24.534474]  ? __pfx_bus_for_each_dev+0x10/0x10
> [   24.536094]  ? _raw_spin_unlock+0x31/0x60
> [   24.537676]  driver_attach+0x49/0x60
> [   24.539220]  bus_add_driver+0x2f3/0x6b0
> [   24.540781]  driver_register+0x170/0x4b0
> [   24.542334]  ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
> [   24.544104]  __platform_driver_register+0x66/0x80
> [   24.545782]  ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
> [   24.547579]  cxl_mock_mem_driver_init+0x25/0xff0 [cxl_mock_mem]
> [   24.549362]  do_one_initcall+0x114/0x5d0
> [   24.550991]  ? __pfx_do_one_initcall+0x10/0x10
> [   24.552593]  ? __kasan_kmalloc+0x88/0xa0
> [   24.554089]  ? kasan_poison+0x3e/0x60
> [   24.555511]  ? kasan_unpoison+0x2c/0x60
> [   24.557076]  ? kasan_poison+0x3e/0x60
> [   24.558573]  ? __asan_register_globals+0x62/0x80
> [   24.560188]  ? __pfx_cxl_mock_mem_driver_init+0x10/0x10 [cxl_mock_mem]
> [   24.562019]  do_init_module+0x277/0x750
> [   24.563556]  load_module+0x5d1d/0x74f0
> [   24.565124]  ? __pfx_load_module+0x10/0x10
> [   24.566656]  ? __pfx_ima_post_read_file+0x10/0x10
> [   24.568235]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   24.569875]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   24.571521]  ? security_kernel_post_read_file+0xa2/0xd0
> [   24.573189]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   24.574851]  ? kernel_read_file+0x503/0x820
> [   24.576441]  ? __pfx_kernel_read_file+0x10/0x10
> [   24.577887]  ? __pfx___lock_acquire+0x10/0x10
> [   24.579390]  init_module_from_file+0x12c/0x1a0
> [   24.580988]  ? init_module_from_file+0x12c/0x1a0
> [   24.582575]  ? __pfx_init_module_from_file+0x10/0x10
> [   24.584234]  ? __this_cpu_preempt_check+0x21/0x30
> [   24.585831]  ? do_raw_spin_unlock+0x15c/0x210
> [   24.587460]  idempotent_init_module+0x3f1/0x690
> [   24.589126]  ? __pfx_idempotent_init_module+0x10/0x10
> [   24.590808]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   24.592513]  ? __fget_light+0x17d/0x210
> [   24.594058]  __x64_sys_finit_module+0x10e/0x1a0
> [   24.595643]  x64_sys_call+0x137a/0x20d0
> [   24.597160]  do_syscall_64+0x6d/0x140
> [   24.598688]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   24.600350] RIP: 0033:0x7fbac6f3185d
> [   24.601923] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
> [   24.606145] RSP: 002b:00007ffd13414db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   24.608143] RAX: ffffffffffffffda RBX: 0000564200192ca0 RCX: 00007fbac6f3185d
> [   24.610130] RDX: 0000000000000000 RSI: 00007fbac758707d RDI: 0000000000000006
> [   24.612106] RBP: 00007ffd13414e70 R08: 0000000000000000 R09: 00007ffd13414e00
> [   24.614112] R10: 0000000000000006 R11: 0000000000000246 R12: 00007fbac758707d
> [   24.616113] R13: 0000000000020000 R14: 0000564200159890 R15: 0000564200195a20
> [   24.618182]  </TASK>[   24.621370] Allocated by task 615:
> [   24.623062]  kasan_save_stack+0x2c/0x60
> [   24.624851]  kasan_save_track+0x18/0x40
> [   24.626603]  kasan_save_alloc_info+0x3c/0x50
> [   24.628411]  __kasan_kmalloc+0x88/0xa0
> [   24.630155]  __kmalloc_noprof+0x1dd/0x4a0
> [   24.631899]  platform_device_alloc+0x3a/0x230
> [   24.633595]  fq_codel_reset+0x6c/0x370 [sch_fq_codel]
> [   24.635477]  do_one_initcall+0x114/0x5d0
> [   24.637164]  do_init_module+0x277/0x750
> [   24.638818]  load_module+0x5d1d/0x74f0
> [   24.640483]  init_module_from_file+0x12c/0x1a0
> [   24.642214]  idempotent_init_module+0x3f1/0x690
> [   24.644013]  __x64_sys_finit_module+0x10e/0x1a0
> [   24.645772]  x64_sys_call+0x137a/0x20d0
> [   24.647459]  do_syscall_64+0x6d/0x140
> [   24.649117]  entry_SYSCALL_64_after_hwframe+0x76/0x7e[   24.652407] The buggy address belongs to the object at ff11000067601000
>                 which belongs to the cache kmalloc-2k of size 2048
> [   24.656105] The buggy address is located 23 bytes to the right of
>                 allocated 1249-byte region [ff11000067601000, ff110000676014e1)[   24.661503] The buggy address belongs to the physical page:
> [   24.663371] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x67600
> [   24.665505] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [   24.667605] flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
> [   24.669656] page_type: 0xffffefff(slab)
> [   24.671471] raw: 000fffffc0000040 ff1100000d83d200 dead000000000122 0000000000000000
> [   24.673568] raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
> [   24.675767] head: 000fffffc0000040 ff1100000d83d200 dead000000000122 0000000000000000
> [   24.678014] head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
> [   24.680121] head: 000fffffc0000003 ffd40000019d8001 ffffffffffffffff 0000000000000000
> [   24.682313] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> [   24.684465] page dumped because: kasan: bad access detected[   24.688127] Memory state around the buggy address:
> [   24.690046]  ff11000067601380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   24.692171]  ff11000067601400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   24.694384] >ff11000067601480: 00 00 00 00 00 00 00 00 00 00 00 00 01 fc fc fc
> [   24.696415]                                                                 ^
> [   24.698485]  ff11000067601500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   24.700609]  ff11000067601580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   24.702598] ==================================================================
> "
>
> I hope it's helpful.
>
> Best Regards,
> Thanks!
>
Hi Pengfei,

I can reproduce it on my environment with your configuration. I confirm the bug is the same as the bug I hit recently, I have sent out a patch for review, the link is https://lore.kernel.org/linux-cxl/20240806041547.1958787-1-ming4.li@intel.com/T/#u

the root cause is that cxl-test module creates an RCH topology, and using platform_device to create RCH downstream port in the RCH topology. There is a wrong pci_host_bridge got from to_pci_host_bridge(dport->dport_dev) in cxl_setup_parent_dport().

