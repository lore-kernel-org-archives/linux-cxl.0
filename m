Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E5112E48
	for <linux-cxl@vger.kernel.org>; Thu, 22 Aug 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291293; cv=fail; b=HJ6p/vKhCoXJMW9Zv4RcWcSyL0tjLg6BHG4hpObfwyVWRh/NTiC5dNgT8FJTm21SSHkFvoPgx46nCn74H1k8MD355X1fb6zzZriDbyIR22OyuBT4NfHLJo/b4Xcvj8tAeX23z1hSD+GZHxL+2K1eKi3lXYuUPb5MwFkNw/fNmBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291293; c=relaxed/simple;
	bh=Mnh9vqNSAVvPSQ87G3Mi/ls6MR2TNJ7/LWktCVrWido=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iXqaNSDtqEmWpIvSnFMFMMTWspAGsbpu+R8vxi5rcRzlRO4pkltceYptTB0uSS0r+oHSgU9Gr16B8gM3o/wpHxbiaOcEr7S0v6Z5H4r74mYKyKEKV9of/SNI5BIgjZcxzkJjY07zEWf0ECjJuRfD0V9iOhtpXqqIN9TTEKtk7JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Btv6hy6h; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Btv6hy6h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724291291; x=1755827291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mnh9vqNSAVvPSQ87G3Mi/ls6MR2TNJ7/LWktCVrWido=;
  b=Btv6hy6hxBwBkDrle25OX1B3Q3GejgCFkthE0oUvAHOOI1do/4oWQbGG
   LVVunJnB3tY8zN4Dpkguix9jWffXyXYdNrTetgpYUGh/tFUdcYr22gV5q
   BVe12akLtE98If5KGR7qkfzPaVnMBy4Ijv4brJ5OMxZlxG4uP/sM6gyAv
   gxwyJ26iXOasCzSzPk7QpdsMZ80pLRBm+iaZxaMS4Z5wYxaMntFRzBqLO
   S+DESfPM7RROhzxrTy5W3+VNs9+IZosMuAoAq9AIWMRJVl+nGXUsheBI9
   +lxjyZvtFUAnxenSpa1ockNLFrdGpsYa9sDe2pgJ+D5WYYTTMIPGOfq1z
   Q==;
X-CSE-ConnectionGUID: 5DxqNISbSNOJgfC2NQPkZA==
X-CSE-MsgGUID: Rb0M6XWRRAan3VmV2pNJgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13145253"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="13145253"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:48:11 -0700
X-CSE-ConnectionGUID: vB2XfuJVTo6VKewatneTBA==
X-CSE-MsgGUID: hdFFSV+xTECa5TUq8knqEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61269561"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 18:48:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:48:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:48:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 18:48:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 18:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0FtLPyTDva2+mJ4Prcx/5iRyWz3WOdcQMFJBIg13Tu0EBmgJGac8wN7IOLmODBMU3uftviIwaB2jch81hw972BCXCGPxoZbuau6EsamW6FPLigyaVKlnUqNqUn8m3KQHN7k/0B1Z36dSJlRREmFXW8qxgyJ/TBmpDGTf2VRmhnlWOHQaos1nDjusBUbQXrF73LhCDqrQNgLLJQlOpt6zvtGWXRxa5khD7kUcxUQHdsv0LOhVnoutXJSsfsHJCl4hXysgMtNVz2028+CzWNgRpnquk/O1OPTVXYOFdMsCjaU2Pc3ri9aQaFlLoBu0w5etM/VCdGk1SBMcn1JiEvObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B0f31HsSr81ZDxtaTtKLm7kMf7/ppCdqT4UUEYzGoI=;
 b=s9bNkhGaCA96sVsdF4ZmiG55rQDe5AWEkoRHUr0xtQ+OUig5dq48Ixpf1dPLE/uSTnjUI8IaNlqghYr3WZ0zKI+13hWXjOd+7cUWXgQtYqXM+34+MSDaacP13jGNvXYi0V6DFZ8t7b8gLiQxUSi8rEwOS5+vxaYzxokA4bztZ1tv3S4J8U68tpJ9gngvvnEksFpAFb4upP75XAnZbArRD/LhukuHbMEpFPSm5u1hvKxaGRxICjrJGgVoI+NCSiaqVFnxct71CQoqhODW7j7Yx/cwzQSt6MOifPp3phmG60JVYyV4n3gRnMwRxhJVJR5OrX1GKFMtTktzitYVnfoCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 01:48:07 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 01:48:07 +0000
Message-ID: <0072fc05-c9c0-4d82-a92b-4048e4d302c1@intel.com>
Date: Thu, 22 Aug 2024 09:47:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cxl/port: Use scoped_guard() to drop
 device_lock()/unlock pair
To: Ira Weiny <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <20240813070552.3353530-1-ming4.li@intel.com>
 <20240813070552.3353530-2-ming4.li@intel.com>
 <66c66105891fe_1719d2946b@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <66c66105891fe_1719d2946b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|DS0PR11MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d02559e-ef21-4196-29d3-08dcc24c784c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3JlcnUwcFIvTjFRdzBXL3duRVBlQzQ4Q0FUTDhocTZ5M1lLZ0Qyb2VQVUZV?=
 =?utf-8?B?cWMvcDJGNld1T1JrWVNEb1p3RHFESit2eWZFOUp0cW94UTBKZnlwbW1Sd2hO?=
 =?utf-8?B?MUFqZEJLYlA0MXRFYS8zRnUveDV3allRTi9NUFRHUm81Mm4wOVJMKzZNdWg4?=
 =?utf-8?B?T2FaZWptRjEyK0ZCV2s4ZSt2Qlo3d3JGVythd0F3amtKWmJsWGgzeEsza2wv?=
 =?utf-8?B?NTZjS3dTZ3dZZUxreDlQM0R0clJlMWlaeURvVCtVakg3NnU2NTRsZ2ZoMXY1?=
 =?utf-8?B?MVdNcmJ3K25ZRmFZanFDeXNFNzlEb1JkaUVGTmpZS1N2SDh1eDF6RHJ2bDRw?=
 =?utf-8?B?ZndESm5MVTVjVUp0ZXJ5N3UvMFVHWSthdTMvc3NpV2h0bXp4RTZqcUt3WnFq?=
 =?utf-8?B?R2ZXWGErcWd0elFKZU44RzVibEdXZ2lTZFpxMHFGRnBEaXZOOWJoYllYTTBL?=
 =?utf-8?B?UkJhWWo1cXJHTHVFUGRvZ1poQkdEZ1hXNkRpOS9xZmI2WWUzRzNZbm10NFE3?=
 =?utf-8?B?eVRyK3N0QUdiUW5NckRQS0piR1NUVzJPZUw5SWh5OTFvcTY5Z0psbUdHV3Rt?=
 =?utf-8?B?TjJseUNqK3NLOXhPSXVRQllpNThTQ1dDMlRMM2V4bGE4dzN4Y0NWTkhoNWVC?=
 =?utf-8?B?OUxqT2Q1cHI2SHNzYnEvS3ZDeHBIenhNK00rVmJ5MVVITEpZTVdlMVc4Uksv?=
 =?utf-8?B?d3BhMWg1andDVStDblR0bmxRZzhSTFF4ZmxoSHh6SGRLUmJyZDRQWnFlUmJo?=
 =?utf-8?B?WE5tZXgyZHEvSlJtK3JSZmhNVkVPMVdndXVoOEs2SjdpQjNDY2FtZkdWSGZm?=
 =?utf-8?B?VEdrTld0YzF1bnRJUkkrc0pINVpiWkMwb2YwZlptMDZmSlJCQ0ZsY1RHdWFX?=
 =?utf-8?B?dHhNVlFFSTQ2V2x0cUFjdFRaalZXdjNsV2p4VkhQQkpCclVrTnRzRko4Vmhk?=
 =?utf-8?B?QitPNEN5OUFWc0Q2WnJNMkt0V2trZnpZb2YzSDNtNERFTFM4UU5xMnM3L3lG?=
 =?utf-8?B?WG5BMVQxOGl5cjhmVFhZWmJlVmpmSEZYbk9aWS9wSUtac2gvM0xaK2lFMVNO?=
 =?utf-8?B?enZ4NUtxWmhYY1g5MlN1czcxWFRjYnJiaWRJVVBjRUdxQXVEODViSS9OTGQ0?=
 =?utf-8?B?YzUzSWNyZ1lPMXNkSUpSQWRUYi9YWkNvVjNZbXU0VFY1d29EMUdaUWdEd2tP?=
 =?utf-8?B?OC9tRGNUc0VId0gzZVhBZDl0ZUVMdEwvRGhJWUdFL09tVnp1S2FxZG1VVnVh?=
 =?utf-8?B?RU52NHJaSUJ3dXczZ0xhSWJlRFJmckViSWVtZmdWN3l0am40Q1F0ME1zeDBa?=
 =?utf-8?B?RHg2djNHWnZMWVU0Ti9kNXpPZXVoUlFIeHVxRzd0S3RQWUY1TmFUb1JHeWxk?=
 =?utf-8?B?aHZmYi9iWjVpdE1xOGRudnVHQW5sWHpPNkYvaVBlRFRQdHpEVEJlNm5FbnA0?=
 =?utf-8?B?RjVJRkVOV2pFblVMMktIK2xHSGplTGQ1TFpsMWZZeGtsMHdLZTNYdGZGajMv?=
 =?utf-8?B?aEhPbzd1NzhyemMwUDluTjBySDNuWVd0azJ0M09sVU9DbjJjQ0pZMzV3Rlhq?=
 =?utf-8?B?cHBjNW51UzhZUTc3TnAvK3daSXpVSXc3aDdnUWl1T2MrVWZ3WXpvbjdZSjE4?=
 =?utf-8?B?aDNXWkhQb2lpZFFieUtmSUt0MWljQXpCSHd3dVZDU01IY2w0VXJWaWI1VEdx?=
 =?utf-8?B?SWEzRlBRZFh3SGFhcTlVQW5OV0JLMTVVcmorR2RaYmV0U1FLOFJPMjJGMDZn?=
 =?utf-8?B?WWcxZEpMVTMyYzk4NnVEN0xYQWJBYk1wQXkvbE53cHBkSThqM2MrUmdxL3Jn?=
 =?utf-8?B?dlIvcThnNTJ3eU1BTDFVdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNDRmxmTUZGcHlZVHhwSmpFczBLYkRCTHIyTlViZUlaaFZzc2dRMkRJQlZk?=
 =?utf-8?B?RGhoWXFvci9hR0hHRXU3L0RWT0VaVVBsTGpkYzgxTzU0UFYydk0rSjd1c2s3?=
 =?utf-8?B?OForU2xrbnJzM0xHeVBKbzFkUG9lSjNJeFNXZnRTdVR3d3Vjak5QMHZiQ01N?=
 =?utf-8?B?TittdmRHR0xQS2cxeldxTmtaR0VwRDlnKzdINUJoU3FScEo2eVpxemZyLzkx?=
 =?utf-8?B?SERaRklnUjBySEExZ29KR01QVHpxZDhBT1hxWDhvbUJXR3ZaaSt5Y0FFZUZy?=
 =?utf-8?B?YW5ic1docTQ3MEVHTmtEUk5ScVJ0eW1qeFpsampxTEh0QU5XR1IvNmtvdVd4?=
 =?utf-8?B?UENVTWxvTTd5SFdxWWZhWGIxN05WRWhmekR2b1d5d09ZUERQMGEzVnFwaWpw?=
 =?utf-8?B?TCsvZFlJSFM1NWhRZWJuZi9vZTh1azZCT29Ja05RTWErNHVLRUxoYWpDYThP?=
 =?utf-8?B?cngyR09HeE9LZEM4a0xyUHRYOHJZZ3RNczlzY2VsdzJIVTZDWmdBVHB3TmJO?=
 =?utf-8?B?WWs4L0xFWFQ3ajZyWjZQY3pBOWsyRkEvdU5kKytBT0NlY0w5ajViUzZ5S0ZG?=
 =?utf-8?B?Kyt2QUY4OVgxUkl2T0pvVlBDTVQxeEs0d1RlOHo0Um01NGR5d2E3a3pzQVM3?=
 =?utf-8?B?K3VtZGJXWlI4VG4wTHl0c2VMV0lUS2d6SDNwWEdyVDREdFBzMDNzVk1vNnNs?=
 =?utf-8?B?TTJpRFZrZkZOTDJFNHREd1c1ODVlN1F4RTdQbFcwUTU2Ukl3dmE1SlhWSHJ0?=
 =?utf-8?B?RG1VU3pPSXk2OEplK0lvUUlWUFBaZmFqSGR6U0hrN0FrMnhMVzNjNjQxYTNF?=
 =?utf-8?B?NmFsdFFkN2Ivbko1TlRDaDkwaHZRSXRKanNpY1BTNzBlWHpQZm1ESmdvenVV?=
 =?utf-8?B?Y3hGODFIOVkzL29JYVA3ZFdMSThNR1ZIbWwyd2hzQW45RW8vN2pqT2VtVDRp?=
 =?utf-8?B?OGZiM0JkWmJ3cmVqM2N4TmhRSUJsbFhLR1hVbGloZTFVd0hxVHoxQm9RdEcz?=
 =?utf-8?B?RkhTY3JaRTZsN3ZxVlJLWFc3dXJKeWYwOVk1eFpDcWlPcUxoS3p2cW5zalhU?=
 =?utf-8?B?UG5jTGNuSWVHRHpaWmtuRUhCTEFQaW00R0Ywam82RU5nbVZoZFptdXhlTEpx?=
 =?utf-8?B?dFFmZktpcmlXRnVWRjhNWTQzWmlCd1VUTG15cmprR2l2eERyempHVGl3aEZF?=
 =?utf-8?B?cndmc0dNYnpiUDE5b0VvdEZ0aCtsbHUvaUZzeTlHVnlMUzNMQmtsTGlORWc3?=
 =?utf-8?B?SGh4RkdzT1oxTU15YnhLbUt4TTdqaC85VWd5VmZ2aDEzKzZkaWoraDhXZzR0?=
 =?utf-8?B?bytkUjBKWFNwNkdiQXlTSEI1ODNSczlJbkRPbWVWM1hMZGZOcUduUS92MGFs?=
 =?utf-8?B?QTFaa0dTTXJJdGM5aGdGTjBjRlU2dFYxYmthTlprcUJSR1QwR2w2VzdNVkN1?=
 =?utf-8?B?MzFYOHlBc2FncDZZenlwUEhSbG5mRDZXbFkraGJoeUpOeHYyanU0SDV2NEFF?=
 =?utf-8?B?S1VMTWRtT3FDc3pNTmRWYVUrNk5BM0t5L2ZmYjJDUDkzUytyTEpRLzlhanNH?=
 =?utf-8?B?VjhSM24yeDIxSmF3SnhWRjJPYzVHeUpZcVI4MzNwK2JJOHRZMjFtQXh0NElu?=
 =?utf-8?B?T2lLdGwxcjBnVmFkR1BWK3FtdC9rZWxyYnA0cENLNSt5N3cwRkF6SUxKVGlG?=
 =?utf-8?B?cy9VYld6eXArekRnZWpraXVuVlFlbGdYQjNUQ1FOUWM0bEYyY3FITFhSelBC?=
 =?utf-8?B?aVVRZHpQaGd4ZmJzbVFLTk5lMDJQUGZoS01hWWxIQkZsK0o4NlNhVjBtMDZY?=
 =?utf-8?B?NU9rd290QUV3TXNvOXk5L21mZ21jMXdnUFlYdS9wQ3BRMHNTMnRqWlc1QXQz?=
 =?utf-8?B?UG4zUzcyMThHQU9QU3NYblRMZmN5ZlMyWVA3czAySTNvQ1dqU2RVSjh2ZUZq?=
 =?utf-8?B?UkhQbDFObkZ5K0tSMFI4TUx5Nzg3VmNyNzlpTENGUWxzdUNLRVNyb2Jpb3N3?=
 =?utf-8?B?R21IWmtyUlB5Y2sxTE1ZeEQzQ1FHdkZOaGh1Y1B5a29WQjFRbGMrYTRXRmxV?=
 =?utf-8?B?ZUdkUkhOb2dQM3FBMTlkWjEzVGxTRTdLS0IzTWhSQmsydGc0Mkp4Q1NKSmFs?=
 =?utf-8?Q?uYh4lIWUOdUEMCBFrAfKDEYhG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d02559e-ef21-4196-29d3-08dcc24c784c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 01:48:07.4595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZAwjYCJsXUO3Gd7zAaz3K2PC9YCS4yF2/rYNFg9cNIUD6CyT5crtGUAy3qKsv9yr+ai0kcUf6Y9DQXqjINU7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-OriginatorOrg: intel.com

On 8/22/2024 5:49 AM, Ira Weiny wrote:
> Li Ming wrote:
>> A device_lock() and device_unlock() pair can be replaced by a
>> scope-based resource management function scoped_guard() which can make
>> the code more readable and safer. Some device_lock() and device_unlock()
>> pairs in CXL subsystem can be simply replaced by a scoped_guard().
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming4.li@intel.com>
>> ---
>>  drivers/cxl/core/mbox.c   | 26 ++++++------
>>  drivers/cxl/core/port.c   | 87 ++++++++++++++++++---------------------
>>  drivers/cxl/core/region.c | 25 ++++++-----
>>  drivers/cxl/mem.c         | 22 +++++-----
>>  drivers/cxl/pmem.c        | 16 ++++---
>>  5 files changed, 82 insertions(+), 94 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index e5cdeafdf76e..a8ab5f2697be 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -1214,19 +1214,19 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>>  	int rc;
>>  
>>  	/* synchronize with cxl_mem_probe() and decoder write operations */
>> -	device_lock(&cxlmd->dev);
>> -	endpoint = cxlmd->endpoint;
>> -	down_read(&cxl_region_rwsem);
>> -	/*
>> -	 * Require an endpoint to be safe otherwise the driver can not
>> -	 * be sure that the device is unmapped.
>> -	 */
>> -	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
>> -		rc = __cxl_mem_sanitize(mds, cmd);
>> -	else
>> -		rc = -EBUSY;
>> -	up_read(&cxl_region_rwsem);
>> -	device_unlock(&cxlmd->dev);
>> +	scoped_guard(device, &cxlmd->dev) {
>> +		endpoint = cxlmd->endpoint;
>> +		down_read(&cxl_region_rwsem);
>> +		/*
>> +		 * Require an endpoint to be safe otherwise the driver can not
>> +		 * be sure that the device is unmapped.
>> +		 */
>> +		if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
>> +			rc = __cxl_mem_sanitize(mds, cmd);
>> +		else
>> +			rc = -EBUSY;
>> +		up_read(&cxl_region_rwsem);
>> +	}
>>  
>>  	return rc;
>>  }
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 6119cb3ad25c..53e2593daa95 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1260,14 +1260,12 @@ static int add_ep(struct cxl_ep *new)
>>  	struct cxl_port *port = new->dport->port;
>>  	int rc;
>>  
>> -	device_lock(&port->dev);
>> -	if (port->dead) {
>> -		device_unlock(&port->dev);
>> -		return -ENXIO;
>> +	scoped_guard(device, &port->dev) {
>> +		if (port->dead)
>> +			return -ENXIO;
>> +		rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
>> +			       GFP_KERNEL);
>>  	}
>> -	rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
>> -		       GFP_KERNEL);
>> -	device_unlock(&port->dev);
>>  
>>  	return rc;
>>  }
>> @@ -1393,14 +1391,14 @@ static void delete_endpoint(void *data)
>>  	struct cxl_port *endpoint = cxlmd->endpoint;
>>  	struct device *host = endpoint_host(endpoint);
>>  
>> -	device_lock(host);
>> -	if (host->driver && !endpoint->dead) {
>> -		devm_release_action(host, cxl_unlink_parent_dport, endpoint);
>> -		devm_release_action(host, cxl_unlink_uport, endpoint);
>> -		devm_release_action(host, unregister_port, endpoint);
>> +	scoped_guard(device, host) {
>> +		if (host->driver && !endpoint->dead) {
>> +			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
>> +			devm_release_action(host, cxl_unlink_uport, endpoint);
>> +			devm_release_action(host, unregister_port, endpoint);
>> +		}
>> +		cxlmd->endpoint = NULL;
>>  	}
>> -	cxlmd->endpoint = NULL;
>> -	device_unlock(host);
>>  	put_device(&endpoint->dev);
>>  	put_device(host);
>>  }
>> @@ -1562,40 +1560,36 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  		return -EAGAIN;
>>  	}
>>  
>> -	device_lock(&parent_port->dev);
>> -	if (!parent_port->dev.driver) {
>> -		dev_warn(&cxlmd->dev,
>> -			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
>> -			 dev_name(&parent_port->dev), dev_name(uport_dev));
>> -		port = ERR_PTR(-ENXIO);
>> -		goto out;
>> -	}
>> +	scoped_guard(device, &parent_port->dev) {
>> +		if (!parent_port->dev.driver) {
>> +			dev_warn(&cxlmd->dev,
>> +				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
>> +				 dev_name(&parent_port->dev), dev_name(uport_dev));
>> +			return -ENXIO;
>> +		}
>>  
>> -	port = find_cxl_port_at(parent_port, dport_dev, &dport);
>> -	if (!port) {
>> -		component_reg_phys = find_component_registers(uport_dev);
>> -		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>> -					 component_reg_phys, parent_dport);
>> -		/* retry find to pick up the new dport information */
>> -		if (!IS_ERR(port))
>> +		port = find_cxl_port_at(parent_port, dport_dev, &dport);
>> +		if (!port) {
>> +			component_reg_phys = find_component_registers(uport_dev);
>> +			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>> +						 component_reg_phys, parent_dport);
>> +			if (IS_ERR(port))
>> +				return PTR_ERR(port);
>> +
>> +			/* retry find to pick up the new dport information */
>>  			port = find_cxl_port_at(parent_port, dport_dev, &dport);
> Can this call to find_cxl_port_at() fail?

I have thought about it during making this changes.

I was also confused if the find_cxl_port_at() could fail. my understanding is that this new cxl port is just added before calling find_cxl_port_at() with holding the lock of parent_port, the find_cxl_port_at() will always get the cxl_port in this case. other threads have no chance to release the new cxl_port in this case.


>> +		}
>>  	}
>> -out:
>> -	device_unlock(&parent_port->dev);
>>  
>> -	if (IS_ERR(port))
>             ^^^^^^^^^^^^
> Does this need to be checked above?
>
> It seems like the logic is changing for the call to cxl_add_ep() but it
> might be ok?
>
> Ira

If my understanding is correct, you meat that above 'IS_ERR(port)' can help to check the result of the above 'port = find_cxl_port_at(parent_port, dport_dev, &dport)', but actually It cannot, because the return of find_cxl_port_at() is a correct cxl port or a NULL. It can help if it is a 'IS_ERR_OR_NULL()'.


>
>> -		rc = PTR_ERR(port);
>> -	else {
>> -		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>> -			dev_name(&port->dev), dev_name(port->uport_dev));
>> -		rc = cxl_add_ep(dport, &cxlmd->dev);
>> -		if (rc == -EBUSY) {
>> -			/*
>> -			 * "can't" happen, but this error code means
>> -			 * something to the caller, so translate it.
>> -			 */
>> -			rc = -ENXIO;
>> -		}
>> +	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>> +		dev_name(&port->dev), dev_name(port->uport_dev));
>> +	rc = cxl_add_ep(dport, &cxlmd->dev);
>> +	if (rc == -EBUSY) {
>> +		/*
>> +		 * "can't" happen, but this error code means
>> +		 * something to the caller, so translate it.
>> +		 */
>> +		rc = -ENXIO;
>>  	}
>>  
>>  	return rc;
>> @@ -1986,9 +1980,8 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>>  
>>  	port = to_cxl_port(cxld->dev.parent);
>>  
>> -	device_lock(&port->dev);
>> -	rc = cxl_decoder_add_locked(cxld, target_map);
>> -	device_unlock(&port->dev);
>> +	scoped_guard(device, &port->dev)
>> +		rc = cxl_decoder_add_locked(cxld, target_map);
>>  
>>  	return rc;
>>  }
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..a3ce7cbe5c6c 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3094,11 +3094,11 @@ static void cxlr_release_nvdimm(void *_cxlr)
>>  	struct cxl_region *cxlr = _cxlr;
>>  	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
>>  
>> -	device_lock(&cxl_nvb->dev);
>> -	if (cxlr->cxlr_pmem)
>> -		devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
>> -				    cxlr->cxlr_pmem);
>> -	device_unlock(&cxl_nvb->dev);
>> +	scoped_guard(device, &cxl_nvb->dev) {
>> +		if (cxlr->cxlr_pmem)
>> +			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
>> +					    cxlr->cxlr_pmem);
>> +	}
>>  	cxlr->cxl_nvb = NULL;
>>  	put_device(&cxl_nvb->dev);
>>  }
>> @@ -3134,14 +3134,13 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>>  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
>>  		dev_name(dev));
>>  
>> -	device_lock(&cxl_nvb->dev);
>> -	if (cxl_nvb->dev.driver)
>> -		rc = devm_add_action_or_reset(&cxl_nvb->dev,
>> -					      cxlr_pmem_unregister, cxlr_pmem);
>> -	else
>> -		rc = -ENXIO;
>> -	device_unlock(&cxl_nvb->dev);
>> -
>> +	scoped_guard(device, &cxl_nvb->dev) {
>> +		if (cxl_nvb->dev.driver)
>> +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
>> +						      cxlr_pmem_unregister, cxlr_pmem);
>> +		else
>> +			rc = -ENXIO;
>> +	}
>>  	if (rc)
>>  		goto err_bridge;
>>  
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index ab9b8ab8df44..ae94018a01bd 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -168,19 +168,17 @@ static int cxl_mem_probe(struct device *dev)
>>  
>>  	cxl_setup_parent_dport(dev, dport);
>>  
>> -	device_lock(endpoint_parent);
>> -	if (!endpoint_parent->driver) {
>> -		dev_err(dev, "CXL port topology %s not enabled\n",
>> -			dev_name(endpoint_parent));
>> -		rc = -ENXIO;
>> -		goto unlock;
>> -	}
>> +	scoped_guard(device, endpoint_parent) {
>> +		if (!endpoint_parent->driver) {
>> +			dev_err(dev, "CXL port topology %s not enabled\n",
>> +				dev_name(endpoint_parent));
>> +			return -ENXIO;
>> +		}
>>  
>> -	rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>> -unlock:
>> -	device_unlock(endpoint_parent);
>> -	if (rc)
>> -		return rc;
>> +		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>> +		if (rc)
>> +			return rc;
>> +	}
>>  
>>  	/*
>>  	 * The kernel may be operating out of CXL memory on this device,
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 4ef93da22335..647c7e25ef3a 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -233,15 +233,13 @@ static int detach_nvdimm(struct device *dev, void *data)
>>  	if (!is_cxl_nvdimm(dev))
>>  		return 0;
>>  
>> -	device_lock(dev);
>> -	if (!dev->driver)
>> -		goto out;
>> -
>> -	cxl_nvd = to_cxl_nvdimm(dev);
>> -	if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
>> -		release = true;
>> -out:
>> -	device_unlock(dev);
>> +	scoped_guard(device, dev) {
>> +		if (dev->driver) {
>> +			cxl_nvd = to_cxl_nvdimm(dev);
>> +			if (cxl_nvd->cxlmd && cxl_nvd->cxlmd->cxl_nvb == data)
>> +				release = true;
>> +		}
>> +	}
>>  	if (release)
>>  		device_release_driver(dev);
>>  	return 0;
>> -- 
>> 2.40.1
>>
>

