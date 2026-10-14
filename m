Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5747252E;
	Wed, 14 Oct 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013952; cv=fail; b=iG9iU6x/2PmXIW7UxlecNdm2TnNQlOiRNb6PEAb88bAxwSRIYTVWqokE5jq1+0PL51uScT5oRmpT0g/Gm8iE4fCXBxghFNm1r8tNR6Nw560X+r6dJn+5CoDFE53nBbRgPD/Of6FL51wuo5SDMZVBaVcMJQDFJfft5k0WQP3JEQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013952; c=relaxed/simple;
	bh=oMV+9c8zfDUiXxl7TdZeEOBK8ke1WoYfrStHkZ2EH+s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ce9oBfzFvD5nCOCIrNOSTeHrHJvLcbZqrLb41OBETx68zDpzO/ErNOsuEkkDBpGCT+l8kL9zcW+SO0j0MEtUpQFnH3cDY9EHQQpvWmNPNrF2eDFY7+l9dmfPkGOTOcXoxa6nS27iOevR0RMlq2zYcF9dPKxqGecwo0NMrutzBFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNn1SX/N; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNn1SX/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792013950; x=1823549950;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oMV+9c8zfDUiXxl7TdZeEOBK8ke1WoYfrStHkZ2EH+s=;
  b=kNn1SX/N0arZ37skG4aNS8wAvsOmBXn1h5fe9gYO7kJ8oICfBGXaY9HC
   6EEyzUkxZVJTHsEhF4XwphbETM0KPirb1wybqZJCQRdM8JJ0WP0dN/JX+
   Lnc8Ki9KotWR7LEql6NuA25wVhM0OubaKBWNii9sucnOD4dcxSW0YeP5U
   QJYWwhJ/8haFHP6Q21VM8b0fHAaLoN7f2j8pcMopEK9YzHRD/KEKMkDKr
   0xyz16NxHfRTbvsfjoM4JJmWuKP09wiXSH4uH60nFH0HQlCO+8IRQbEhN
   6+ahXaE62IAAPFHVEGHSoMOTBSVOngqShrvPrzuZtF+nO2c4nAi9V24gG
   g==;
X-CSE-ConnectionGUID: UOmNyeSeSDqDUrrzeZUWpA==
X-CSE-MsgGUID: S2U3x4c4T/u8Lg6yhYPQOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="661616"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="661616"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:39:10 -0700
X-CSE-ConnectionGUID: 0ACKBt0KRmiw37F0uZGEoQ==
X-CSE-MsgGUID: oDT05MnITcaJ8QB39M3rBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1592696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:39:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:39:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:39:09 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLPIYjD/ji+tLpWpq9yqYE4Xz3aQksR2D+TvWIB17tpxWWVZSzRNgba4028+J1Qx5psu6IpAhA9mYLRP4Oy8kXZrTcHH4bM7FNuBdrXBO1BUeUtj3MzbcmoxyzRo71jVMwpWF7GOO43CBfcH5kmUJ4oVEREYoGFB+0H+b4TADY8GdsXMr4eGEnqKWbDNpm2gEEf/pKYNS7Z1Nb8t3Syms735FYdenUg7M0DyG1+/C4KwfCmO7abbdi3Uxp+V4z043qcR6h5lhfy1ODxJGJtmzYEGEazhz+vW4Pc+4fPewyrL5aSNsotCmO0tnWkY5NUp6qVdfiiahQGtAw6KExFkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9jTxQ02l2ULm2ryLQRx8K7xRNGZi943DrEWjvL/mFw=;
 b=hL8W2GgY8ITQQbeOTIVcOEvIs5j20qklOguKsaNwe+LadXuCq/Bqbx8k69NctjfXVARC1p4iDmSo6uHURlP08oYERsqlCLXLw5eZzdide1UXG5FNGTMWYoLcSOhaYCwYG+4eFc+LcwsSVbyOwFFQ8XNjP3D9T8I9/b5n56f/s9PLEe6ZnBsftkoHS8i547eOu5ZDBBB81jmM3jeUOrsKd54WJRzzRyZPMNqvd0RUAIGPBQO2xYDNElqlNcIPRjU2zw8e5D1EGqy+EPv0efVvjTuyAIFnw7xFHelJQlanJgEq27OIzhkunut9hI8Npg8Vlwh1yl9ybkAocZubzK2HNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 21:39:06 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 21:39:06 +0000
Date: Wed, 14 Oct 2026 14:39:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: =?utf-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] cxl/mbox: bound the device-supplied command return
 code
Message-ID: <as_2dlFF5gnbeHZ9@aschofie-mobl2.lan>
References: <20260929060747.3550005-1-huanggaobin23@semi.ac.cn>
 <as7cid_6QQS5gBI-@aschofie-mobl2.lan>
 <49ee762d.402bc.1a13ae337d6.Coremail.huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49ee762d.402bc.1a13ae337d6.Coremail.huanggaobin23@semi.ac.cn>
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc82a03-006b-4405-4c6d-08df2a3b926e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|261009223027099003|260925021911599003|260925021311599003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info: Fw9ji0BtugYuOuwcpRFxazTrM726gI3MPu8ozKhMSTK3hytds9r3SHPB6TBKd90tbxgtuwD1JPtPNx8r3GpaT4MzZbTBacbCLmnzdhOIQcn44w/yHhgpFaFrHIJgP7AiKUHV16x1LW8UeYRV88exnyJa5TLyzXsBdQf0lSTm6YNKHgrozvnKLYHJ+RuFL/Ts2aEI8t02sndLD2rD8fjIY77tGVeTzh3XaxwigMPUfKFdeU+Zv6m4OEAz/3DGZDpQn34fITLuG99O4Q52QnjaNIvhy1xCmbQMEzG9G9sZUGerg4B12te3EEpAZm97I2XyelWJjCg75x8NuM58ZC0hDNEpw8HvQkmFMuF9U5kfBagP78UOatFK7ncHrFWgfZie3McTjrhPdOuSWlm0cfqs1oarEYzM7Nu0G8xhwQKfRIWAlXQcR6IEvWiwTsyGdCtUN6P8AEqHNBJgFs/4iVvVjw+pHsNBr81hiZFCk8YV1ORgIjkMu1WWuzlOprnwDX7Npy/0EgIHt17PE3AHcv+YZa6d/DwxTIaxGxx7n7JpgxKvGwjcit+Yon2b4Fndhm/uogyB7vzaquAsY0EIWu9VAiHsiCIwuGMmdtQJZZ/Dc/K6PvV3r6in23mSxD3yDarT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(260925021911599003)(260925021311599003)(260925022911599003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhBSldnNytaM014WnlFNnA4Uk1teVlLRExWMmhGWnBML0N5eHYvWm1wRzBk?=
 =?utf-8?B?TlNWZ1E2Y01rYWI4QnZoM3ZRNDRudkt1MWFNcXhqTXdQUmp4NEkwNWdudGZN?=
 =?utf-8?B?Unk2TUpnaVZ2TXdOenp6LzlIbUhTOTBaNTNlRDREcElUNHIvUG5lRW15enF5?=
 =?utf-8?B?TnVVSkhXMUVBMHR1MDJQMjRKbEVzMUhyVDZOOGRIaWVvcDJ6NGhYbFJNMlRh?=
 =?utf-8?B?MTBOU0Y5TmRxNXovbmNmZ2ZYT3dtbzltZEpjb0JHbW9TeWZmOHlOZkJNck1K?=
 =?utf-8?B?dmpaNjVVdGpPSktjSS8zYzhXWmp1ZlZEVUZrOG50cnpsSHhwSFBxUEJNRzlN?=
 =?utf-8?B?R0pCTURrb3FNSmtvWERjZjZVK2Q1L0RWMi93OWFDRjVwNkJ2TVQ3ci8wRnpr?=
 =?utf-8?B?NUJ0eUV3bEpDMlhQYjVGRjlGZElndWJTbWFJOWhmVHQvMTZ6RlZ5LzBLb0h0?=
 =?utf-8?B?bGNkQ2R2R0xsNWU5OC9Hc0dyeXBPeTYwREFoMlkwQTY5WndOU2hFSFNSdHcz?=
 =?utf-8?B?bjcwTXVRTEJzd3BJN2FUNFRTR3g3ZUVxOFE5RXRkaDdFZ01FN2FldGtkK3FF?=
 =?utf-8?B?ajl2OUdmandXZ3RhdG9oQ3MyUWNGeEpvU2lWeWFkS2Z3SXhrTzREZUk4NWtw?=
 =?utf-8?B?VVZmSmVHOVNYOHRPSTQyeDdPUThMMWRJWStnZnVQREs3TUNkays2QUxaZ3R5?=
 =?utf-8?B?SVRHSHQzNEU5R0phQXlLTS9qZjZqa0lvcFhXa2hRV29ucHp4ZGxvSjZUNUZM?=
 =?utf-8?B?dTdkY09PWTI5Z1FKam1DL044bXNUeUYrWVNXOWh3YnpaMkdud2RTYmwxaVhV?=
 =?utf-8?B?NDQrODZ2WnkyNjF5OUs5dWhZOFJCL0NEQWZDT29vbnM3QXhVV3BrUkE0Rys5?=
 =?utf-8?B?TW5uTHFReEJ6R3R5UnIwWXBFSm1tVWJSN2Znb2VxWUhmOGNtZE9YcmFuTGpP?=
 =?utf-8?B?VzlTTHBXTjRvd0xGSUhDVmFITDFtUm5KUDU4TlR0bUpzTXZCeTFlS252dWgv?=
 =?utf-8?B?RHhKS3B5RWw5TGNKNkxVK3B6cnFFTEI3d3o4ckgvR09aaDNuaXFHbGY0UFI2?=
 =?utf-8?B?WldzL0JRQWQrd3hTWXVYRFlDSFdHUHlhRG9LNmF1SUxXS2NoWm9nVlV0WWg1?=
 =?utf-8?B?endEMVVaeERzRXNrZW01RS9DdjRLbUZqSHIzUkVXbEJWNVFRV2FQWm55UW5K?=
 =?utf-8?B?bEZRMHhMNGxmM09zQnNqZW51aFc1WkJxUko2eGRCQkRyeEZTTUVvSFI1aStj?=
 =?utf-8?B?UmRaWEtRaGhNM2lhTUo4Rk5tVXpmWlBSYTRZdTB4R1hyODJYZWhHUVJKeVBa?=
 =?utf-8?B?V0RvVU5BeWdWV09QTG43U0tydEV5ZE9mNlZIaFp3S3N2clI0dHNDcExOZll6?=
 =?utf-8?B?Rmo1UW5qcElSQjVuSWFoOEJrOFZFM3RqLzNPR0QwdnN2bm83a1VYWXVjRWJo?=
 =?utf-8?B?RGhjVjZMVHlTNitLMXhpR1g1dTIrOSswaUpUdUJSTEdsMnZSTmQweE1TaTl6?=
 =?utf-8?B?anErRnU4NUNqd3pKbnlrK0ZDYnJQckV2aUZqVVduZmlvbDJORUlXUWxGZkk3?=
 =?utf-8?B?c2NHWWMveW4wRVltNnk3VEE0Nm5mVXZXcGs3VzFDdkhOUStGOTJhOVBmMDV1?=
 =?utf-8?B?YTBaUnNjczZMSGZjc0JwUmtEcnpZL1o3bnowVEhqUHl4M2grZkd4SjVZa3k0?=
 =?utf-8?B?RHZtN3BaM0UzUjFDa01lenBBclU4N2JISzM2N3huTE91SEt2RGoySUpraGlD?=
 =?utf-8?B?ZVozNXpqb29XYlhDTlBaSGdLU25Id3VGbUpqNm1vSFlrRDUxMW5qTGVDQ2RF?=
 =?utf-8?B?ZkVOcGVhazhQOXdUN1p0ZGVxMmVqODF5ZHVKTS9DWUJsZ2FXcWE1elMzVTNB?=
 =?utf-8?B?S2lheUF3a1ZBZndoUkU1VzRwU3JCTnc4eUF4MDVvbFYwUzlnZkdXd1pEZU5J?=
 =?utf-8?B?c3ltNitncnVXcncwYk53SkRLOVZrdk9YUnRzRmczOUNzZVNvbFJvYUEvWFJh?=
 =?utf-8?B?S0RvZTRtcC9pektvZXRaQkdDS3MrS2hva2lyNFU5T2N0SlR2RGh4ZG4rRkJU?=
 =?utf-8?B?RFZHTWxMVytPMEF1Z0N2WFpySVE4SHB6VjRDdnl1dGFvbWVzcVlnU1Rad21R?=
 =?utf-8?B?T2VYQjcxSGpnL0xDWXlIYUNEK000N3NHWkdCVkNnUzU1SnJmcnpKTG8wL0dn?=
 =?utf-8?B?T2oyazU2dU1VY25hMkhWNHZEUTI0eTV0UVFJR1NIbkVFZGFhNUx6VzBOblhh?=
 =?utf-8?B?Q05FQTRLd01zb0NWcFpoOE5DWVhNWnBTenRSMzFiK1pJdVJGaytDUEZ3eEU0?=
 =?utf-8?B?VFVnN2E0NFRmNDVOM1Uvb3NFYmtheDQ1YVBTeCtaTHZtbzFNb1hkdGRwT3g0?=
 =?utf-8?Q?7v9pcWUWJQqlQQCY=3D?=
X-Exchange-RoutingPolicyChecked: zu7JcygIghwbeeRhTu+8VN3oR9YZQ8yZO1A2skTWhFCHx7Yt4zUYDqnUuiBbehF7jSo8Cx8SAao8LrfsTmGoFNF9Fi+oT1JBwA/3dph61ufh12+7HFhxAbFAH/deJZGmu9WmwfGqL8XZzGkmoMrPgVL7mHZGZJ//dBMqnwWGOudqegdKrMBr2Dxmc1BJ/4H9L0SKdjJ95tnDd/t3Lbvgexy3AXBYAZROKmfxtjbNXGKCLWpRmE4MPEhSxyMgFLKXny4Jwc0V4PI0aBewjoup2/dXbA0UdZM8r95fD9WlqRFivQzQSMgZVjfVcU0zRsg/8YzYANQmWxFgxUo5UcY2CQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc82a03-006b-4405-4c6d-08df2a3b926e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:39:05.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMTtDKBR7RGhMLMlfwKASjM89NTEGdDjOx2dk+udMJ9XO6gTDyG/Mro1ZD9o1zYXcySkWwuPu9qa7IyVOdhEfkJh+YQvYEkuaHwIObZmkRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com

On Wed, Oct 14, 2026 at 10:48:51PM +0800, 黄高彬 wrote:
> Hi Alison,
> 
> Thank you for picking it up, and for the corrections.
> 
> > (Sashiko is right here. PADDR and POISONLMT don't map to -ENXIO, so the
> > comment and changelog claim isn't accurate. -ENXIO is still the right
> > fallback for an unknown code.)
> 
> You are both right: the claim should be that an unknown code is still a failure
> and that -ENXIO keeps it in the usual device-error class -- not that every
> non-success entry maps to -ENXIO.  Please use that wording in the version you
> carry; I will not repost the patch on its own.

The version in the v1 cxl-kunit patchset[1] already avoids that claim. It reports
unknown codes as -ENXIO, "the errno used for most device-reported errors".


> 
> > I'm taking this into a series that adds CXL KUnit tests, including a
> > regression test for this table. You'll get CC'd when it posts and I'll need
> > you ACK it since it has your original authorship with changes from me added.
> 
> Understood -- I will ACK as soon as it posts.
> 
> > It looks like the return code you saw is valid for CXL 4.0 and just not added
> > to CXL driver yet. ... CXL 4.0, Table 8-208 ... 001Fh and 0020h
> > I don't think anyone else has sent a patch for that yet, so you can if you
> > like.
> 
> Two things there, and I would rather not collide with your series:
> 
> - The KASAN reproduction used 0x1f, which stops being out of range once 001Fh is
>   in the table.  Out of range is any code past the end of the table, so with
>   001Fh and 0020h added it is 0021h upwards -- the bound itself is unchanged.
> - Adding the two entries is a separate change from the bound.  Do you want it in
>   your series next to the KUnit test, so the boundary and the test move
>   together, or as a standalone patch from me after yours?  Either is fine.  If
>   you would rather have it from me, I will take the names and errno mappings
>   from Table 8-208 and send it separately.

Standalone patch from you please. It doesn't need to wait on the series.
The table can be extended without touching the test.

The test has 2 cases that read the table:
- Walk every code in the table and check each errno return. It loops up
  to the table size, so the new entries your patch adds will get picked
  up automatically.

- Checks codes past the end of the table. Its first code is the table 
  size itself, so today it's 001Fh and w your patch it'll be 0021h.

The test only needs a change if a new code maps to an errno other than
-ENXIO.

This conversation made me aware that the testing page could say more
about maintenance of the unit tests. Take a look here [2]


[1] https://lore.kernel.org/linux-cxl/3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com/
[2] https://lore.kernel.org/linux-cxl/as_1dGrwsPYTlZrp@aschofie-mobl2.lan/


-- Alison


> 
> Thanks,
> Gaobin
