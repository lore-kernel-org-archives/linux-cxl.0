Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0362C275114;
	Wed, 11 Mar 2026 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199361; cv=fail; b=io22coadqIeJLsbHoh58sRZzHe8TzA8YEE5ROJNeUYhoPIM3xK/WlH4adtkCHASfYOGutSl9tcUSwkfb1YS3AQwSlzfLkHalJLszR2vxAqLAap9Qyv3vYD9r2EhD6EhgirkTLkJS397nfRC9T0WV/DPprcejCQzyGmmErb9zLiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199361; c=relaxed/simple;
	bh=nvXswjP32k9pRLMBOC2aQnKmkkMR0Ea04RspJ8KbOKw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=qy0ttcBHp075ZcMWAYj2Ahswl92sTlLGLhqb6j50s3SxUunKNMq7wheyNA3gVID1pTrkOFK5aRrY+U0f5CB3KbYfBUixMB4IztUWF2oWDgZmpR9itc/llp8hh/Y6kcWQ8oTlGGTm814uoqbwd8l46gVRJNjCCq4UMqE9XdZVyEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jimx0qwD; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jimx0qwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773199361; x=1804735361;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=nvXswjP32k9pRLMBOC2aQnKmkkMR0Ea04RspJ8KbOKw=;
  b=Jimx0qwDPXQO2wf3dvLn8dPaWa4IES5yA0xNY7KdFXvUHsEYnBpeg+Dm
   dN5YUFHS/hO4Azqx0ecNKBw2ms001V39CLcwKcF8VMe5dZn4Z+8Uip3jK
   zMZ+437K0vWtK1lFCS/qiSGjDbjMAW4Rkj3PT4zbEBxnWVUX1fRBWNprt
   qet0DvR3C82BNevM3JzjVnNYhRLvIH3CUFsKbHH1UJLeJ3ID0Vcbe0pxt
   Kt0F57/ZlSc2XBLm+iJkaIt2BXY3zH0ZGaOFhoVmSfDB2FZsaMX+yzVKM
   zuZsen53qdyxwFKr/e8f8zDmpfNtyAo+vkWLoQva4TSiDLPi9ahnREtRZ
   A==;
X-CSE-ConnectionGUID: /P/HzZFyTN+uURrK2uuNsw==
X-CSE-MsgGUID: TghwBOkOQ7u1NhXR+6sFVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74232979"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74232979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 20:22:40 -0700
X-CSE-ConnectionGUID: XCLBzaCCTZClmukMZyV8Lw==
X-CSE-MsgGUID: RIz5aG0qTGqp+1OgbBuwQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217032957"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 20:22:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 20:22:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 20:22:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 20:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6vED8OUL2FntB5FANBpW7+Yrcls4YiQNtBoarAxGWh3ZmEvxoCWLsNkeP6EcLm/NNLOs0Bt1LmfLzWcqgM2THHidBaDnp3LKekqFAgsWLe19sqopIxvdZSBCOfbMN1Mpsb8qpVsDvv3Rg8BlUvsisBdB1zuV+GbETiYo4wT3ZTu4YjYXiqDAKWyglTD8GdUP8sMpn1JIyTymuAFRrvWKhXtxHQNlICjK+iYx1D3YgxWAr62UfH384XO8MsK8e9y192Ke3g+Rx9JnYK5pWbIWt5IL6IeOoqHVzJ71HFOfU645g9mtdu27PwFQlmKmJus0bhvHLlPc/4v+9+4588TIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvXswjP32k9pRLMBOC2aQnKmkkMR0Ea04RspJ8KbOKw=;
 b=jD3msG1TwPe4kvD/ALxi6n01+uejhrgJvNW+HcX2rvJ41jyad9H/fQcNz3TgF2OUp+O/GZCbTh3+ybB7xP484W5tqsWUbXoMHyublYaLdLt6ky+C2eg2LC6SE5csI0gCPZeRLjAOdZtOOa4Kim672kB8HrUlrbYklEna3yA1hu5yTThTO1QeXgm+E1AdNo8rZzolap0ph5bEzFAc0csh2FYoBCA5Slt5UJd0PLZqFzMSBh9sh+PbF2NVRJgu9IrZDXMw1ZF25mfJyWCwTqusUl/8IyrFYp9Fi2Pu7pFNTxAd/mGF2lDLI9+SSfD01NlEa7wcTDS021YoPA200FLOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 03:22:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 03:22:31 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Mar 2026 20:22:29 -0700
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>, Benjamin Cheatham
	<benjamin.cheatham@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <69b0dff5b6043_2132100cd@dwillia2-mobl4.notmuch>
In-Reply-To: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2281b9-ff82-456b-441d-08de7f1d6e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Zdf+MxQema8AFy+DoKHsS6hLXm8FZRo+afCgbffJlXEbsuoNDn/WjzOIHpLZVwXk4bfIft9PXjcbckOoae4UzTPhtqJIcnnqTcd4a0KRQNB5WadEWRqJAFKwW6T866zpvhX2OfXOo3d0Ya2xyAwTTTZyMUICRnXEBw8N61tYRX5zFWyeYVXF2jBFWIUmezL18C9+GZQ4jN1AC/jeL0uNKEelZAYXV4KPwrDAGK0Rzh9DCri2bqetU8v/u4oVzf6XSwRgWMZN5KSukXg9FdHscsXBrPiVPxuBE7H+AOhcRvfy5MROBMuaF6ywEx5HWDk9yK/W+RpkxQgsDBlKuaNIHXWMnLzw6ONL1CXndJ1XDtrb8HevH0jLhJCKFhmV/No+ple3ujG2SDaQa3IucisLqJRTJWR2bYqUcJNRoVXQ/s/rmv6rrmEf0TLMssLDskIPhYuLOTLzfB6VhFyVm7H1ns0AV3Ajuzy9yCSNSrp3Zb0gl8vEPGZV4i3/t4qf4fhXHfjGflnA0LwvivAwIiNE2bdY1lHOKlSUm9mELJLErkp07W+wBxYGWIoioKD2nXOGo+G3ohXpDDh1P/g3NIq02Hbr6sPn/vZgsMzgLc5dN8oU5rA6E7y50rlXFkInew8tSx8k9JK9XUuS7pexCIidaaGYuBX34+Z7FkMlGBsKq+S1KbVDCQG4CbdgB2J5FtF66gkseHWR8C8+WrVB5xZbbeZEsZBYCe1lc2IjAYTBVKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWJpQ2dRaWNYNkkvWFFKeGRIMEpzQXJ4ckFvZnBXbmc1NS96dnlaZGN1Q1or?=
 =?utf-8?B?TmsvdlZkRE14MFgzZ0VHQUdzd3IrSXFoSFYvRFpXQm0vNDZsN01RQzdqaEht?=
 =?utf-8?B?Tk5Oak1TSlo4V04rTzhiaDcwVTZnUmVQRnVLNFV1K3J6RXVLMS9rbGtwdW9T?=
 =?utf-8?B?Sm9sWVdyTlUyQXBVUDBRV0RQWFdqWUN5TGJYTkw4Z21LbDBFRFpmOVlCdnJ3?=
 =?utf-8?B?bUFXMGwrNlpqUG1PVFdqR0oybjN4RWNDQXJpdU5IQnFwVU1WK3o1RUdPamJS?=
 =?utf-8?B?QVJjWC8xeWZ6UFNXWHEzSGkyT1BqOGJpOHI2ZFBIMlUyaTJMSVlSZzZOTGla?=
 =?utf-8?B?UmVPb3BadUJTQTR4UmFyOEVCMTJveGhINndVWlA0dGlhOEs2Qkh3MHdwWUE5?=
 =?utf-8?B?ZjJZclVocFY3bzBGSUZlTHNWL3ZDVGhvbjZHWU5GMk9GcTFvN1BENjlXZVYy?=
 =?utf-8?B?YkptM0g3OEdsMFV5V1Q4a1did3VjMllLNFBuTCtYV1diZGNLRDRKcmRUSnAz?=
 =?utf-8?B?TVFoZks3UmZjZFZXbmNpV09OVDVQa0hxcGc1OHhFUVRCZGtLbURmbW54S3Na?=
 =?utf-8?B?V3pWUFlJaXJLVWJaTW1hSHVHdnhzQ1Z4b00va1lYMk1mZkJ5RVlIOUJEV3cx?=
 =?utf-8?B?cytsSGQ4Q3dhc1l6YmRhc1VjMHhPbVFGcHZPSUxjV3RUdEU2WGRtVXRuUk1N?=
 =?utf-8?B?dlhvTVNKOHd2TGhpaGQ5VU5LdGNzQWJIUFNBb1l3dVNCVnRsMUhGMVZ0dlJW?=
 =?utf-8?B?R05YaGg3MFJwQlZGOHJtR0FVTk5WVDFRNHdYeWJKcUdaT1NvZmVObFVxK282?=
 =?utf-8?B?U1pUVlpJeGk5dWlpR1RqVDVURGpKYi9qTmpEZ3N1N1JrWFlsY2M4VlFRaDF1?=
 =?utf-8?B?a2M0bGpQWUNoSVVHVVNCUFp1Ui9OK3d6Mml1NWtMdlhldE0wOFZaaWk5ckJB?=
 =?utf-8?B?UlNraUlwUXl3SXZGWndNZFhxQ3dLcXJpVWZkOXp3OXpieHJ0S1dHQmN1UUla?=
 =?utf-8?B?YWpmZEdyczJHWkJzcWVOYm9QTXFSdW9obnFuSlJnS3JIRFJSMW9jNktoVVJB?=
 =?utf-8?B?RHhJVUJmMmpQRG8wYVhNZlpiaWdPdXcxT0tJcy9vcVk0dHhUazlKY1BzZ3Rm?=
 =?utf-8?B?UCtWNXVJWERRdFlCYTI3a2l1amNBTmpPKzlVT0dYak1nQVh6QXBNa3dhby9N?=
 =?utf-8?B?RklwdTJyQnNLYWphNXVkUEU0RFJYTWg2Y0FFK2ZCM3FnckNIVnpBQ0gyYThm?=
 =?utf-8?B?OVVmVEpnWG5qUjYxVFF0eUpScXdsUmI1TzlpMnpVeEwxbk1ZSGFiNDZISzli?=
 =?utf-8?B?ejVEaUJHTTBSaVRwcUpUY0Vjc3ZQOEpiVll1SjZ1TitMMy94TUZjVS92bzlR?=
 =?utf-8?B?S2tzYTZCN0liNkY3aFYyb0NsajB6K2hpbDNlTFdFWGRQMjU2MTBDYkY0aEVh?=
 =?utf-8?B?ZTk2Qlpkb1h3anNGb0NnOGlKVE9JQ0xTVXlob3Y4aFh0K0NSWVJJZzVOaHdl?=
 =?utf-8?B?T3ZYZkh2clZVdFFPeGk4Yk1Ra2thYUkycWt3RlN1U0NmendaaHRUV3QyTFRy?=
 =?utf-8?B?MjBZUjRVQ3prSStOc2VxVmVKaTAzY2szK3IyamNtS3FWWWZWeDVJemhGUjZY?=
 =?utf-8?B?Y0Erc28wYVVYNXE4bXh5RzB5WlJpVE1lenJqMXBkR1JGc0R1UE9ZWUFpRjcv?=
 =?utf-8?B?bVpFaXZCZFhidE82Z1owaytjMlZkTVRNZjdxR3RRdlNiRGFHdkltclNTVDZj?=
 =?utf-8?B?KzlZWnNtdlQvZEgwaUljMWw3TzZWYUptUHk5cVJzbFAwenNFUlFzZXZJSnY5?=
 =?utf-8?B?UGtlM1FNSG4wRkRxdWw1YlFtVzUvSG9XSnBnU09lbFhFUThLdCtjNWtIK1Aw?=
 =?utf-8?B?MnNnTjk0MlRTRHNZam1Ld1ZreEJOOWprVHdQZnhBS3NrbG54dnRwbEs3Q25w?=
 =?utf-8?B?Uy82SnFnWFRMNWVlUlZWQ2xKdW8rQ1V2bUFaTW9HWVR5OWNsVk1YNEN4SGdE?=
 =?utf-8?B?NW8vTFpCSDA3akNJbVNEc2kvVCtYS1VsRkNkSkduQWZHSFY2N3JiZE9SaElF?=
 =?utf-8?B?d3JvQlYyU1FXK1cxYWk5cXo2UU82amxoMXhCZGhKaUl6RDlYZkF0TmFnVkkz?=
 =?utf-8?B?YzcvT1k2Y2dSSTdwWUswZFFaZktZNmkzOWtlaE9hb282RUFraWFTM2ZwWi9S?=
 =?utf-8?B?KzRyYW90NTNjOUw3MmswUkdzZlBsK2RHbFdIaWRNRDV2S1BVUWJBYmF6a1pW?=
 =?utf-8?B?aUFZTFR2UlVSemRqZGEvekIzNmticldrdktoVXk1bkUxTkduQXFHd2pxR3pJ?=
 =?utf-8?B?ancxMmdONkw1d1ZyNWlIYVVpczdyeElkd2JORlFYUVdKZUFLbElIM2IzSE5p?=
 =?utf-8?Q?0CwQo0w9sy9SKtQ0=3D?=
X-Exchange-RoutingPolicyChecked: Q4/gpYSfISuxIgZilfTB1DUCpmkIoj0z6qz9mOdS9s7Lp9L0ttwvyJRb8QW591ImWll6Fda2UDCG70ywmWVVGON71OjGnRTwQiQcZrGWIdeBYST82RwZWQVvY1Sg2ZOz88G6++GKl7nvlrwiG0fM77BqgQBujHloiNZjJrO8B4cnyfyqOGtjFrHuDhTVeYI9FgNt12l6GuRoeiXwwikEniefgZILxOrzBh8OUd7OwlxcHs0NEALxijJXi72ojW1G/u5IsfOODcpYc4d8quq35NStDTnnhXAgOfZsmSemSfTfVCC3X63h89bTgCRfe4zO7GVEyZTHhp92aFI9Ks3eKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2281b9-ff82-456b-441d-08de7f1d6e42
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 03:22:31.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibt1iJMI/SGK4SH7vdbobL+Q+rq5Nf3stFjMBZfMjGzPw+nYf7kUTh9iYUh1EeulDqNaJjORHlKIlmGfWqQZYvQgo0PNj2i5r3W2cxUU0p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> After destroy-region, cxl_region_decode_reset() clears the HDM decoder
> registers (base/size/commit). If the memdev is subsequently bounced
> (disable/enable), port probe re-evaluates decoder capability via
> should_emulate_decoders().

I do not think this bug is limited to "after destroy region". Simply, if
the driver sees that the HDM capability is enabled before the driver
loads it indicates that whomever left that configuration also intended
for DVSEC range registers to be ignored.

> The existing logic checks each decoder's COMMITTED bit. Since those bits
> are cleared by region teardown, should_emulate_decoders() incorrectly
> falls back to DVSEC range emulation, even though HDM capability is still
> present.

This is 2 separate bugs, right? Bug 1 destroying the register
configuration of auto-assembled regions, fixed by your pending patch.
Bug 2 destroying auto-assembled regions does not clean up DVSEC range
registers making it look like those are set when HDM decode capability
is disabled. That unintentionally / falsely mimics CXL 1.1 platform
firmware behavior triggering should_emulate_decoders().

> DVSEC fallback marks the endpoint decoder as AUTO, which triggers
> cxl_add_to_region() -> construct_region(). That path copies the default
> interleave_granularity (4096) into the region parameters. The resulting
> spurious autodiscovered region consumes the CFMWS HPA space and causes a
> subsequent create-region to fail in hpa_alloc().

I do not think this part is relevant to the fix, right? Once DVSEC is
being falsely used the rest is just knock-on-effects.

> Use the global CXL_HDM_DECODER_ENABLE bit instead of per-decoder COMMITTED
> bits to detect HDM capability. If the HDM decoder block is enabled,

...if the HDM block is enabled the state of the register is irrelevant.

> registers indicate teardown, not absence of HDM support. This prevents the
> unintended DVSEC fallback and subsequent region creation failure.

I think this wants 2 patches. This one you have here to always trust HDM
decoder on setup, and another patch to teardown non-auto
should_emulate_decoders() DVSEC configurations. Those combined with your
"do not teardown auto regions" should squash this crop of setup bugs.
