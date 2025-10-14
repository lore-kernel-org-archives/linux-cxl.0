Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641538C11;
	Tue, 14 Oct 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760401838; cv=fail; b=fK2+eGylR4DSvS+9Phyk+ZFEzdSBSTW3yatMZjCEsPIbe/4NkV2Xte3TwL6xMxpcs2zqKJ4i+AUvB7DalHRZ6Bmf5Kt5htJNVSruPWmlG1iQhd2I+ocL5OzWtCLEEewk8qgPI22hKzYw6OgeaInhV1nGiAqwTfuYzhGS5Xq2mSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760401838; c=relaxed/simple;
	bh=ImiV6PTfVoOiGxi1UP5iXgwsoKDIfQ6JkjefisFSwoE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Gva2eBBvvmU9/reMTWhYjCITzzPLYn42SkzKDkJZiBZ/EJq+ZWTXTdlST9A9qRNy3RhF3Qm7eNpM0i0cBF4GioFTja9gXNzl0ZhX1+P7B1F0dRF4uoUtjn0DuGhP+Fgeae3OELZFlOR5O2fInfgKieB96EISAPvpM9vGwv6WhnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgcBPVtY; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgcBPVtY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760401837; x=1791937837;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=ImiV6PTfVoOiGxi1UP5iXgwsoKDIfQ6JkjefisFSwoE=;
  b=RgcBPVtYG2OqSm+blrWIuS5j1nro1GoAVEEZtbAPyQcM8WJDJNzlzv+P
   bYRh0IgXMWkJqoEGdSox+POEIfZBmxdBNx2uvWQ/jcFbnY2r6U0mmAagM
   Tgmi7HOf6k6zZtQXUd9swADgVoye5P2U881WwSKlT1nazZOZSmIgoq0ZI
   RbR4o/O5/lL/3oVuymqwFpaxYZO5gi6rfOR+Gl76BFcALEUfOTxB8FMCt
   EJzGLuCezLKOsP76eQKIpSjwuq+MK0b+egEhU3VKi6us5G/9z7Hku2o9L
   iD+9Q1aP/yGNW3IsAeKPAIiYW4L44S53Dh4uSY2rfgiikRTpuG+ED7S5K
   Q==;
X-CSE-ConnectionGUID: 7bD1hrRbT7+9lhSchWGlFQ==
X-CSE-MsgGUID: EOMz7+OoRXamOlDzib5tRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73657387"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="73657387"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 17:30:36 -0700
X-CSE-ConnectionGUID: KIkwEwR9QzSnFh2nCWccyw==
X-CSE-MsgGUID: ySqYoVEUQMq1PXy/l1k7Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="181294854"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 17:30:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 17:30:34 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 17:30:34 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 17:30:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMz8a4eGvcRNJN0T0OOof4gLZtBa/7+0CfhbGAbt0qZ+UxtTDYSdxP6jIN9mD+bqIBgLaLPX7gXtH2O2CTAbxFUHIrqIPrtmu57vqOcVbEQgQ+z9heVf0+xLWj7Tj9yZJIJ+1gIJWHsSmbK+MfS0Sh5r48FsTh7oIE5ZiUCddUUJT290F7FagC1q7WzyF2MTeEHfoYaE0yAAzdvmRjGcqfVnzOF3C/34DBlonMHUU+rkja6CLVJRy//2lKPgpkVL+aYxhsn096YhDpskJc0KwlYlqRgrgPdc6J+HOCPA4jXnYJYz57DWdEi8r9czhm2aQSofx9jilUn8QAMUCmLhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6B5ehHAJDiDqB9saQ/ebCbhymLbPUOrGrR1llSMqKI=;
 b=HNLpLq55UzSecL4Bi15cboI73LqPwDQOoifC4UVctoH5p91EoUwftA6NcNAAwX2bECu7WpUV98SqYJUfIml9ctvT2NrCQ7w3jixXuChyqy6CUgwmNAG301QOsRjJ/rsjkZwuCH5xn3UgZXKwi10CxdjrBokK8AY11wa3F4VuKxmQdEBvnx82OQFj8SFmHVzpYITyDsWWfwMO1Uuk8jdXSJO4HnB4vgx0bg1dh/1PGvW8O0AU1ERCJbNRCfRHkNNlSw0UTvqspgOZJ1BD0W2k5CxCxcIZL2vS0Hxkzi2Rco70Za5eXPCyj0RsHzG+KI6w289vWJXumt88MKD+nTGumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6188.namprd11.prod.outlook.com (2603:10b6:930:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 00:30:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 00:30:31 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 13 Oct 2025 17:30:29 -0700
To: <alison.schofield@intel.com>, Joe Perches <joe@perches.com>, "Andy
 Whitcroft" <apw@canonical.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	"Lukas Bulwahn" <lukas.bulwahn@gmail.com>
CC: Alison Schofield <alison.schofield@intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <68ed99a5b6308_1992810024@dwillia2-mobl4.notmuch>
In-Reply-To: <20250815010645.2980846-1-alison.schofield@intel.com>
References: <20250815010645.2980846-1-alison.schofield@intel.com>
Subject: Re: [PATCH v2] checkpatch: allow an assignment in if condition for
 ACQUIRE_ERR()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c744acd-38d6-4b73-84d0-08de0ab8e1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWpPbmx4dmxNcTcrQXhjeUJUK1ZkdU5TcXBac0I0c29UWUJ3RUk4aG52TXc5?=
 =?utf-8?B?Y2Y1ckxKWnovV2FTKzFPSWkxR0RKWlVMamloY3RFbmdEaHQ2UWNOSUYzL2xU?=
 =?utf-8?B?ZzZseUVpOFBGeDkyS1BUL3NqVEpPbjljQWdGZlB1c2dLZkJDWmtaNmZYVGF3?=
 =?utf-8?B?bjBZcDY1RUU5VW40Y2xIU3h3aWRaaFNwcDFSdEdSeVRYaVNRWHp2S0tsYlBr?=
 =?utf-8?B?SU51VDVJZStuZE5YZEx5Y21COTFNbjdlNG5Za1lLSnlRWkptZGNpMENzSXYr?=
 =?utf-8?B?RWdqbEM2SjF0Z2FWZlJyVW4rT0N4eklncDM5WVkwdHl0d1BocDM1K29HRkpi?=
 =?utf-8?B?OElvYXBlZVdXd0dQMmd1Mm5NWDNWaGlhalJYY1F1S2N2c2JqZ0R5eWg5YXdv?=
 =?utf-8?B?UVpmRklCTzA4QjB5b2ZWNHQxQVRVMzArMnZDR0RBem5DMHB6S3A2ZTJ6VzJZ?=
 =?utf-8?B?SmxrcDFHUHpxY3JGb01jQkxqeVF5NEhQUzUrOTlMZG5jcmdka3ZKSWgva2wr?=
 =?utf-8?B?MW92ME5sQStvR1REbFRSQ1F5T0hLcERVVVZJYjVIQmpuRFpiZkhNMHcxdkkw?=
 =?utf-8?B?djBqaDllUkRuS0I1dXo1SDhBVzJTR3pmMm5TN2ZCb0JaMUlFTjdJa2tuNVdD?=
 =?utf-8?B?R0lHL25xYzk1UFJRc0lPVDdHQnRKbjVCUEFZM0NEYSt4bGN1SUpseHZCbnkv?=
 =?utf-8?B?aFBnbmZlMWkreXlDVE9XMjZwakZZMXB6OXpLRDQyd0tDNEtmV01GR1Y0NWNj?=
 =?utf-8?B?SkZuRWFlWktJYVVRem1lVGtJZ3hJakljOXAvRHlodUtMVlV2UkpRQmQ4QjhN?=
 =?utf-8?B?NFR5ZC9QUnVtK0RkVGttWnNoZzlNZzFuYm5aTjRzREFDY0VLVk9JWlZqV1ZE?=
 =?utf-8?B?Qm5pRHB5ZVNDQ0NvM0V0bUtyVFkzMUpPdEJrbFBmYUV0VnE0T2Eyb1BCOVVo?=
 =?utf-8?B?ZERuMnkzQjZzZ0JJc3FyM2Q1VDk0eFVldCtNcUtLUnlheFZrTHJ5bDc0ZEg2?=
 =?utf-8?B?azNIT0YwTFlkaWt0dHNYTFppV0YwVGhzUEJDRjM4bFNoWE9rZldBS1BhUHph?=
 =?utf-8?B?RUp5bEExNEdHQXE0eTg5aXV0VGZtc0VEMFVDWkg4SEVVOURoUE4zaEo5eUsx?=
 =?utf-8?B?K2lTUEN3VzZJcUtBT2VDajZxZnl1c1VUWUwyQ0ViRnRxOXZ4eExrclQ5bCsy?=
 =?utf-8?B?b0FxSmRZeVc3YWZwbUJDTHlrY0xDY3VhOXFjVlBUY3QyQVdpZ3FzemNIb3pS?=
 =?utf-8?B?ajBra2tWaUV4eWdMV05paUpUR1NBTkJubFFSZ0hzUXUzcHVhTWMrVVJSVW5y?=
 =?utf-8?B?Nzg0eWpIb3hHSzRnc2E5ckduenF0Mjk3ZXp2U0tRcUZWOGs3YnN2bFNFb1lV?=
 =?utf-8?B?cUdkTTZjdENtU3dGMzRSZzhHMEplYmYycGx2WUtPc0k2Q0JJUVRidkJCVmpv?=
 =?utf-8?B?NS9oUlJ2OWZ2K3dMbHJlU003L1U0UC9DSmFvR3RTb1FYbGhRdVlBK1hlcjJm?=
 =?utf-8?B?YzZMQlFsaHZLWEJnSHp3VUIrT2hqVVNzdFhOY3JoUUdvTWJZcTUzcGpWVUpN?=
 =?utf-8?B?SE5BNHRHcVdzVlpNL0ZIVHhxUFlTZ0tTMG1IWVovdDJENFpWa3g1djRCTllq?=
 =?utf-8?B?OEVvQ3p0NlRSVjRyOE1heDNibHQ1bXZMdkVKbDNWRUoyK1hmQzlhUjRDNTZG?=
 =?utf-8?B?Mmt0Q2piSGplRTFQR2c3QTRnanpnM01pamlzUmJjVEx5M3p3Q3dreHNvRWxU?=
 =?utf-8?B?ZU9nK2puVERXTjR3L3Byd1pFVm1jTy9wZE1selNNclZ4NldjZVNpSW9UYXdJ?=
 =?utf-8?B?N3NxVnBNc1RJK2t3dmpRWTAzU2xRZHllTVdkZWRRN2JCTDcveGRGR1hvamti?=
 =?utf-8?B?YXBvK1dmWm1EQ0RxWGV5V3crem8rSnVXMS9TS3dtWlhDOUcwMFQvRWZsM2pZ?=
 =?utf-8?Q?1XF6DitgxgcuBNFoOzM5xxuRgvZCrQ7t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BjQXVyUHdCa0V0U2poNE5lcTVFRVdhRGVsL25acGVrRHNKd25GNVRXSHN1?=
 =?utf-8?B?OWJLdlBnZGFsN0ZtZGp2NlV2VitLRFVWU3M5aEhZZ0Y1eWlPZTZIQU5BQ1Jn?=
 =?utf-8?B?SFE3eWhVZUFQZkJZYWFkbCtpVUVxK0FTSEIyKzk4UTFuVXJhdEZudVRGaWR5?=
 =?utf-8?B?TzE1MjlmOXNzM0tZMXBWK1FMRU4yL1RCSkdUZzAweWdaRFVidFM4akduSnVm?=
 =?utf-8?B?RWFZZ2JFMEdlU0VWZjA1RW9LNWxMMXdjOXg1MmdZYi8zeUx5eEdyUCsvSVlh?=
 =?utf-8?B?Y1VHdnJ5cE5HTk5WR3BCSVJ3bWJPZXZuWjFwakpwVThqODg5c3AwU3N2Y3lO?=
 =?utf-8?B?bzQ3MWFJYlJJLzZXVU5zQUNJM2hpNkFhUDd5d0MzaXkyUTZDWE44MjBlUXBP?=
 =?utf-8?B?VE1idkR3UytvZXIyZ3JMQytTMUE4aFBZUFFWaUdvcW53dGNMYUhvcUdxbjJm?=
 =?utf-8?B?UE9qK2tpVy81eG8wK3FZOEk0RHh1MVgzd2pQYWRoaElxQmNhYkNmM05SM29u?=
 =?utf-8?B?QnRvUzh3cCs1eUV0VVJIdzdnR0JkLzZCQTd1VmFZTGVHUXFLc2tsYm1RR0Zv?=
 =?utf-8?B?RFdWQnA1QXRONmtQWDJYeTlEdmlRUXQxeVJtdjBkLzVpbldyekVUdzM4bWk5?=
 =?utf-8?B?QXhzTDdyemRPWFN3Mit4UGNlSjdOLzNJNkwzYjR2ZS8vTUNmVGtMT3pjK0RD?=
 =?utf-8?B?YkFtS1lqSzJOYkZ2ZHBaWldXd3BSMGwyN2tHY283eXU0UjYrRHliRHE0UE9h?=
 =?utf-8?B?V3FIK0IrSXIvOGxrS2xRQUpvTDIycEZRbmJCOThpQ1lsT2NBMDYvSGJvclFs?=
 =?utf-8?B?bkFjaWNWL2owT1ZKampTQ2RtaG10NWxiM25LV3pxN2NiY3ZPaWdESHVWUHNR?=
 =?utf-8?B?TGlEeG96b0paSXM4OEVRTEFGQVhjZXN1RUV6NGN6ZXhBTWpiSGM1bUY2YTN3?=
 =?utf-8?B?ektHTXRUYlIzVG5qU3cyOTZxLzduSVVFZ2tpWWhwcDhTT0kyVzI3eTVOd3NK?=
 =?utf-8?B?d05HT283RnNFVkVJMVVSYkwzdVZOTGNKaEFNVEw4M2FJVFd0NjYzTXJVcy8v?=
 =?utf-8?B?TFFNdnhtUlJOMEVoaDJlMnltNnBSSGZmalN5bkhwMyt0VEYvRFN0cWtFZzBz?=
 =?utf-8?B?VTVhTno3QUkvMjZYZ3BrbEpyd0ExQmFsWklXY0F4dDBtTEpTdUtQWldHWFlQ?=
 =?utf-8?B?MzFEaDhpbi95dDBHcE8vc1NMVm9HZGhOdXZ5OWE3alBJeUtReTBMNFZCVFpQ?=
 =?utf-8?B?T1M3TXdMVFZ3dTA3aGRoc2ZYQ2VZU3hNdmpnTVRXWVpxYUJyeEZyS3owZ3RP?=
 =?utf-8?B?cE9pYlpkWEw3NnM5MFdoRU9xb3E3N0c2cTA4bllwVE11Ylg4M0MxaDVrdCtC?=
 =?utf-8?B?ZUI5UkE0Wm5lclZzQlF1bUpKV1VvNlFjZkJFQ21IMGxPVkNUVGptRWt5a2lR?=
 =?utf-8?B?aUdabXBMOVVoTER6b0tNQ1FzbmZEejJ6TU15UlNDRllwRHBPK3FFNUhvazF4?=
 =?utf-8?B?Wk05ZU9yNXhkNStzbFNEU09HY2Z4QWYvdVJkR0ZLaGcwWVZzY3AzR05jTWhF?=
 =?utf-8?B?Y3RLYnVqaEoyK0gxYWE5dzRVZUhpRVlUdDRaYjNFbC9scGFqRnNwQU04V0dZ?=
 =?utf-8?B?ZnBncTVhdklleDNBdjhHWVhaQzJIR1NpajUyUmpkY3VUOW9MSVJTTTFheUlh?=
 =?utf-8?B?ZWxtSVl1bWhLeHNaOTdqaThPMk5QTW1xQ3hwMFAvTlJyL05JVHVuMjZHRzZQ?=
 =?utf-8?B?L2NKNXlHTDFKV3hzdnVoTnExSUZkQmxSY0lrV2ZFRTZ2cVVDK3RhM0hSNWxC?=
 =?utf-8?B?K1Mwc1RSSzcyS01VZStnQzVQeUtieXh1d0doalcwWW51cDBSbmlDclBpT00v?=
 =?utf-8?B?WDNLT1BUUXR6MkFDM21NUzJ5a1RPMytwMDFJSE01VTM3eFFrOC9wRE9qK05w?=
 =?utf-8?B?OVZwMVZOMDBEN3VJeFJwVmpaUEVJeXBEekRXZFB5bnZDRmdNKzdraFc4dHJp?=
 =?utf-8?B?NmYyS2s4N1dPTEZZRnBmTEdxMG8wRXMwYWxwdlQxdGtuYmNDeklxd2Y4cGc3?=
 =?utf-8?B?MnpvUmExMDEzTjdVNThTN3I1YXMybWxvdkJTNm5YQ1k4MFZnbHVqZjM0TG5C?=
 =?utf-8?B?UW84MFBxMjdLUE9ZcWRMckFraTRMSHNzL3JycEg0UXpNZVRJUmFPVjNEYVdT?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c744acd-38d6-4b73-84d0-08de0ab8e1c0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 00:30:31.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNHrzjNpbdol8axesyrDs9TdwTmCevJ0ikdmeAUI304T5hmE0aI7O0imP04M5te9GFDMhstfsYg11I9KPOnrFYXLMhrP2wmEwzzTSQv9X7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> New helpers, ACQUIRE() and ACQUIRE_ERR(), were recently introduced
> and employed here [1] to clean up conditional locking paths.
> 
> That led to checkpatch ERRORS:
>         ERROR: do not use assignment in if condition
> 
> on usages like this:
>         ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>         if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>                 return rc;
> 
> That compact format was a deliberate choice by the authors. By making
> this a checkpatch exception, existing ERRORs are quieted, and future
> users of the macro will not be dissuaded by checkpatch from using the
> preferred compact format.
> 
> [1] Commit d03fcf50ba56 ("cxl: Convert to ACQUIRE() for conditional rwsem locking")

Works for me.

Tested-by: Dan Williams <dan.j.williams@intel.com>

I am going to be resubmitting the final (hopefully) version of the
PCI/TSM core implementation [1] which uses this compact style.

It takes the current version of the patch from:

    total: 4 errors, 2 warnings, 1074 lines checked

...to:

    total: 0 errors, 2 warnings, 1074 lines checked

Where one of those warnings I overlooked previously due to the other
errors. The final warning in that set is:

    WARNING: suspect code indent for conditional statements (0, 0)
    #380: FILE: drivers/pci/tsm.c:72:
    +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
    [...]
    +static void pci_tsm_walk_fns(struct pci_dev *pdev,

Which is another cleanup.h usage enlightenment for checkpatch.pl that
would be nice to see.

[1]: http://lore.kernel.org/20250911235647.3248419-5-dan.j.williams@intel.com
