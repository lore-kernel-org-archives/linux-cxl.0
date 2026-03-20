Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A78E6FC5;
	Fri, 20 Mar 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773973833; cv=fail; b=alQi6QeuxdJWfXc3DcsrQqlkfggtx77KKQ+GfnwSCrWPXjn7yy2WHPu5TtUa3WqmDIaDkkjJ8zGB0/h0J4nmMf0bMZWmrKeC9Snb97qIRnOqQ6lTQZxZzPEPZsSEGdpAFRW3CQ2z231JR99G/EsJGhZfw/Qzz18Psjh9kFEocao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773973833; c=relaxed/simple;
	bh=1LNTi06EHnAv84NKWot95z/jey/7cmlzIf/IQL7bxXM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=unuKpTyhOEwfzCDMfJ25L6+klWKGzgGUtS7BlfJ5WqcVWIFI9Zqrr1O+7famD0moPXOzlpKoTCTNg1PpDQn0Ks4u6u8b/SNNBH5fZSO8hiC7c9ElH9AuKCI9WJGOOMXsd/00pLOfSaXCT0IqlPYNQq9zxShgfVNu+tmwM96dPgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzZ+LxOX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzZ+LxOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773973831; x=1805509831;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=1LNTi06EHnAv84NKWot95z/jey/7cmlzIf/IQL7bxXM=;
  b=lzZ+LxOX8l6ZB5/NYjSoTZzVJmsmalCvpsvY30RgNT+riWOm/b4VVQpt
   uH345Es8tREi+Ml0qPLIh+8gQlHDs6t0R18rLnHRWwMie+iTBBsRVcGqa
   thvGSsJkGoUR5v0DAf8P9CKp5hxhRN4ugGsiwIATkpuOOw7ul77T5bZQI
   qu46IcaoTDC7WIS8JZCdSVFLEOKI/tlkbtLd3bVf1qKGxzFSotOhggxxm
   6+oPYVj5k2npViNJyAY/DARsInrDgRY8qlmg+0VJ0TQk1UMoQFBxB5Z/b
   AzpW6Vq/Rfi10QNPn3sZokov6redtQsLD/SMqcHS4iaR4OzY/7V+j/M4K
   w==;
X-CSE-ConnectionGUID: R1JQIkG/TwOSDboTO1n/yw==
X-CSE-MsgGUID: H8MQujYfTHqdK+7MGODM4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="75177310"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75177310"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:30:30 -0700
X-CSE-ConnectionGUID: RAXSe1Y/QYiA4xYoima0yw==
X-CSE-MsgGUID: XpkHCC/7QoG4mh2gIpoezg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227863199"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 19:30:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:30:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 19:30:29 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 19:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUttpM7nedRdtZZlPIs8LSuGRIHJd/UX4s1hm9bjKozeQzcxnfHmQVJ5/NP2Gl2kGRQInUlC1mqazAtkYTmXY3r+t6dGVgdfM+9M1OeA9Q8/IhceOyMH311g4zoC56KJLSCWqlfXxrpRHthoozLWvNt5ilgod1u9jXh6Y2ocxMEtNkNbH3oL1C94sew/2YapUfyjdPV9hLhLRUQRsfJq5hOijbfh4i4w1Hjk99ZdR0eq63T8J+i5G9dz9Uj8J/udIBJ+Jb7NfT160lo07zKKx97vec4kxtvUu2MU7u2DKziPOeTBRosfos3qJh0xCwi2ddw1mtYwND1XkYieR1SkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtXcvSwqiiWdjcQHjZdL/iqWpdo0WrRJGBJNG8UCTdY=;
 b=ZzfH5PsI10NeuS+4JwBja9++YRNq69DjBOa+A56g+UwQiQrc91ncVNYB53DhCT0FnRS7/Zskib5BkFfJBdJYcirOnuoBVA+EryKCtlQ5PPJGUyJXVuRNqadThhs/uAkgvFHuoWaX0BsGKH2DZWlsYBaSxzBuXKfob/caplLP3quJOaB4yDpKA2Zm8NjfQhOiSjOSuXXmG03XD4Y4qdbFvcEEVD8cPTklrVS66Aiwvl6feDTFw63wMtlriBPRqG0HTfJ7iyE8+089Tg5G4TANofReFfCxS2Yv6JuSXN2VhewxOKQIC/lMhpHNLQ7a8SKUiWtQ8zyLOSUMQf+aEvun5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4564.namprd11.prod.outlook.com (2603:10b6:5:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Fri, 20 Mar
 2026 02:30:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 02:30:26 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 19 Mar 2026 19:30:24 -0700
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Message-ID: <69bcb13ff3e50_7ee31002c@dwillia2-mobl4.notmuch>
In-Reply-To: <20260319-hold_memdev_lock_for_region_poison_inject-clear-v1-1-05243c5a9572@zohomail.com>
References: <20260319-hold_memdev_lock_for_region_poison_inject-clear-v1-1-05243c5a9572@zohomail.com>
Subject: Re: [PATCH] cxl/region: Hold memdev lock during region poison
 injection/clear
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: fd282fdf-3713-431d-6d5f-08de8628a560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: ZYJ3LyofqKcxrqwvqJmizm1ErxuEcl+6GY4tjACZBOnJPtLHtWnpEVakdReBK3IRcUyHZacE0KB3odc+b9TuvtXPnjcxXycLmFT3mMa256afXhyVu3ln4Yx93g34ALfagH/vCwUdJjedbBbRiPuAg+2/YHE0HybkbCaDQ5/pdj0dTLQ76eeIP9xyk0bJ9MuweY3+ZERat0ThdA6ZZRDK7hMot9n0wMDhMyMbCsP1o43qZD5MYeQs6aSZ6FKuO0h0E7+MvUlY157xfhHJ7koS6T1VfMA7uBvIhU5F7miCH93HKXZnJyprvVHEB2oJZuIBa4lu3um60ozBK153nZmQN0+YR6dUWWrZ7UgQf9u+IHA4jf1zsxU+Nz6QF4KM8zh3uYErktWfPqOsgp7osPWhOxI/NQfdE+49qclOmmVG1UFUNBKUHGKj+Qv2euvBcqqsPAyXkdG3pA/ieSaypkVNxzG7fkDMGfyM9vmRWrJy6mLULm6H8owk0YsJh+q0eUHKhpyo19TfMHYzQ+Lbiq/hz4Fn664s7YqW/VZTIZ5kmrikmCcQxFGXjhITFWlmZHjmgS1nRM/wJHC315tRN5QlIl4S02nSG+judR8ylhDb8CFQO3KUKgLc9XHGMpYrm4tMMshvWIxuZSBdgKsqvnJU4QhGrqP9Sbrp9PmK20u1w7IK+W3XudJkKLwdtFXPEOEMlXkpl7XVKnVOeJl+rdHbELBZAsAcMtzpcJvGTtyl0cQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NaN3ZkZzFTS2I4RnBJTW1LWGJFSW10TkVvYUE3U3c3anZubXY5Q3ROTys1?=
 =?utf-8?B?U3RIdDA5SXJZMC9TMkZJNzY5YlJ4a2RlYU4yYkxORkozTURDazdjRDZUdUQy?=
 =?utf-8?B?TnRINGpUZUJKL0MxYVpCZ2tiOUVkTGgyZFhDTzM3WjJSWVZMTE9hT2o5aWpR?=
 =?utf-8?B?Z1VqdVVqRzA5Q3RhOElvbW84Rlc0bWlidUxBenlDZFRUTXMwMGRlL2gwT0Uz?=
 =?utf-8?B?OHAwS1VPbW1oR3YxdDg5U05PK1AzVGxyc2ROekZQdXpEQzZSNEo2dUlXMkxI?=
 =?utf-8?B?bHNLeTFiZUpxR2JZRWFoczlJc1dCMWdTSG5Ubi8wN3UzSWNuQnpiRkt1SEY2?=
 =?utf-8?B?bjVyTVRuVERlYStlU2UvdDZYRmkvZy9xMi9BT0lxd3JYcElxNTVQNDFvb3ow?=
 =?utf-8?B?VkY3U3kzbTZxNFZsZkpja29pMDRabmllKzVoVDU3TzFVYVJKc0tnczdHbXZ6?=
 =?utf-8?B?dkxSazVyaGJiL3pTK3J2MFBncXBjM1ExNFNjU3JoRndBWXRhV1FTUDVhcGc2?=
 =?utf-8?B?KzZPbGwzQVFCdHFsdnpSZ0J3YTF4a2VHd21WckJxeEpHcVZNamdVTzhEN0lk?=
 =?utf-8?B?ZVRKbWZPSkhxUkw3Q28wWkhOVU9WazhUVzVFMStpYkVsTWcrTEo0Q3Z3Z2Zh?=
 =?utf-8?B?b0FXWi9SYXRnSmw1YVVEWXlvVXN6YVVBcUlEU2xaNkI5QXhnNTRnL0ZaTDJJ?=
 =?utf-8?B?NGlTeDh5dzJIVC9STStKUlluRDd5emMwaTNhck1RanhQK1QvcjlVWXBZWkY1?=
 =?utf-8?B?T1A4SDNJZHhHcEhwbXV3ZGVEK3NMV2c1UmxacXF4d21rb3d6NWtBZ2pWSGll?=
 =?utf-8?B?czI4cHNhR21UYUo1SmdiQ1JRNkdmRkRuZjQ3T25RZDNDQXd3ejlWYWI1TmFr?=
 =?utf-8?B?WlhXbWVjaUZEbWU2QUxGZ1hkOFhoeG5UWWUybVpDRVFWYzlRWjlMWUxjVkNF?=
 =?utf-8?B?MnV2ODZ6blN0eEhoVUNJNVlaVGthbFdDUnB1ZDJreTdKTnhFdFVYMkNIZ2dr?=
 =?utf-8?B?V2dLZzBIQWNHamdvQzZCUUhUYy92dW5xTjJ6dVFUVXJMSUlPeXpZVVFEaVYx?=
 =?utf-8?B?UUpWUkRwcVRRNTYxRVJjU1Nsc1JEV1BvT0hRb2Mzemt4elA1eitNM3lXa0FZ?=
 =?utf-8?B?T1VYRlh6Qm5PUHpFUHFDK2NpUDY4MmxvMTd5TER2KzVMdHRBUWFHNUk0bCtQ?=
 =?utf-8?B?OWlNMXVzaXc2bVZmN1hQa3g5ODNtMHNGSHNnRENQeWtnUzdCeGw3UThWeTIy?=
 =?utf-8?B?aGxlWDU3dzZ6MHNFUzduazRRU25TK3JmSC8wSjEwYlVWRUtnV0t2RVdGekYr?=
 =?utf-8?B?R1o1cW11akNJQktITEJ0SXk2czdWdHdDMTVRdTNYMjJ2UDQrb3V6RjVkbHdR?=
 =?utf-8?B?cmQzSkhLTy85a2ZWODU5VW1HZnhoQllSUmF1cTAyM2lLaFJMZDgzRk1MWXNW?=
 =?utf-8?B?WjlqblkwTW9VTVZWM3Q2VFErVjIzYXRmcXdQMFR5ckQ2dkVXckJ6ZWdteTJI?=
 =?utf-8?B?T2NrSVByNkg1eWRnSTdQb1lORHU5SW43RXlyWGFjWWNYU09iTi9pTlFEM1Av?=
 =?utf-8?B?NmoyOUFyQXpNL2xZTDl1VVNCNHhRZ0ZmSWd1bHpvTmRWY1RVckd5T1pXT3l0?=
 =?utf-8?B?bjBhK1pnL0hsaXlhSHM0M2JLaHhMQjR2RVlKbmxuMzREM3FNV2M0Z3IzNHdJ?=
 =?utf-8?B?MDdBOFVQQXZzZ2tvTnlxb2JzakNnMTNuM0RDUFF6ekZkL0hOSGQxNXVvdWFG?=
 =?utf-8?B?SkM0dTExOHBidEJvdWJHQWtWWFQyZTU4NmN3LzROdzBNSlVtcEtVbTZzWUFV?=
 =?utf-8?B?MlVSU3U1RUcvKzJja1d5a2RHcmJ1WHE2VW13OG9STktkUnVQWm8yMzlpN3Ur?=
 =?utf-8?B?T2djdUJleUdLeXJpdkpJUWdDbVVwK2hSUUVFYlVwUG9rdXl6a2dTams3WmRQ?=
 =?utf-8?B?aDdhckc5c2ZFTUJjdWtOaVZpcXRXdDd3MUtUT0l0Y1czaXNGdDc1clVFeVlI?=
 =?utf-8?B?TEsvU2pZaTZHcWl2OUdWS1hZWkZDL2ZqUkpPNGRKK2ZLYnlsaG13YjN6U1lr?=
 =?utf-8?B?NU5NQXhQV3QyNHRMYVE4WlVJUzY1eEY3S2tmdkdUNUZMMDN3UVhleCtqWHB4?=
 =?utf-8?B?eTlVYVhsMjA2cjZXbGtsbWQxWTBwcEt6VkE1YkpOMzhUVTZPRCtnZ2tldkVm?=
 =?utf-8?B?dE85ZzZoUXZtdHo0Q1c4VllqQWxkK0lnNWFJSWFmZVBvRVlHVHVDejZIRllq?=
 =?utf-8?B?MWlXVXdlRkt2SVVqdDhKODJTNkpjVStGMmNTZ1BtNUJMMmFHZjhjR2lUdHRS?=
 =?utf-8?B?NXV1REhob0wyTmhFeS82SU9tdVRCOUdHMlZpSGVTSG9qM2VWMm93TDVheUp2?=
 =?utf-8?Q?RJ9feVtuLBVN1djk=3D?=
X-Exchange-RoutingPolicyChecked: ZwzxkyFHwODtoEotSirw6wgG9f0I4wm7dorfzknxFwUbZrxgt/NNY66y8cwg8awYto0+1eG5rpF/f3rQko14aUfcvOrpyS4qVz7KGSgvlyPPe0HWMa7w6ow7EZeEZ9Ol36KCm0M5ngXoxuxnuzBKt8ypQ1FmHjk7YGv0AXkok2W5gLci9A7Eo62BC2VZ61H6ZwPG7elkwYfow4s/Eco5aw/q926ZI+BFBAGmDQqTltdjIOnKT+a2UDezRnMd+vWVH6TsFEUlrs+NQ5EKOEbMoSrmLzGvt5+rfTYkSDQUsD191IBNODNf/9khEWabZseFDRI4tULulXLeVJhPGniUCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd282fdf-3713-431d-6d5f-08de8628a560
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 02:30:26.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGNeMedtyp7rSF5EHC4mTJWgLZFh15h7OOaRdecRL9dxOY9UGFjHm876t0AZv/OaLgRjdMAvm2vw8wAOlPjpD3His/hnHIxxObzK9se7mFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4564
X-OriginatorOrg: intel.com

Li Ming wrote:
> cxl_dpa_to_region() has expectations that cxlmd->endpoint remains valid
> for the duration of the call. When userspace performs poison injection
> or clearing on a region via debugfs, holding cxl_rwsem.region and
> cxl_rwsem.dpa alone is insufficient, these locks do not prevent the
> retrieved CXL memdev from being destroyed, nor do they protect against
> concurrent driver detachment. Therefore, hold CXL memdev lock in the
> debugfs callbacks to ensure the cxlmd->dev.driver remains stable for the
> entire execution of the callback functions.

I took another look at this and there may be a simpler way to ensure
this safety.

In the case where we already have a region you can be assured that
the device is not going to detach from the region while holding the
proper rwsems. Maybe that was what Alison was referring to about it
being "ok"?

However, the problem is that cxl_dpa_to_region() is sometimes called
from paths where the memdev has unknown association to a region like
cxl_{inject,clear}_poison().

There are two ways to solve that problem. Hold the cxlmd lock, or move
the registration of debugfs *after* creation of cxlmd->endpoint. With
that ordering it would ensure that debugfs is only usable in the
interval here ->endpoint is known to be stable.

If that ends up simpler, we should go that route instead.

> To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
> for avoiding deadlock. the interfaces have to find out the correct CXL
> memdev at first, holding lock in the sequence then checking if the DPA
> data has been changed before holding locks.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/region.c | 112 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 88 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f24b7e754727..1a509acc52a3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4101,12 +4101,70 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
>  	return 0;
>  }
>  
> +static int __cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
> +				      struct dpa_result *res)
> +{
> +	int rc;
> +
> +	*res = (struct dpa_result){ .dpa = ULLONG_MAX, .cxlmd = NULL };
> +
> +	if (validate_region_offset(cxlr, offset))
> +		return -EINVAL;
> +
> +	offset -= cxlr->params.cache_size;
> +	rc = region_offset_to_dpa_result(cxlr, offset, res);
> +	if (rc || !res->cxlmd || res->dpa == ULLONG_MAX) {
> +		dev_dbg(&cxlr->dev,
> +			"Failed to resolve DPA for region offset %#llx rc %d\n",
> +			offset, rc);
> +
> +		return rc ? rc : -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_region_poison_lookup(struct cxl_region *cxlr, u64 offset,
> +				    struct dpa_result *res)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return rc;
> +
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return rc;
> +
> +	rc = __cxl_region_poison_lookup(cxlr, offset, res);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Hold the device reference in case
> +	 * the device is destroyed after that.
> +	 */
> +	get_device(&res->cxlmd->dev);

This is what made me take another look at alternate approaches because
this reference count is messy.

A region always holds an implicit reference on attached memdevs by
holding its endpoint decoders. The only value of a reference is making
sure that if devices are removed while the lock is dropped you can be
sure that no new memdev aliases the allocation of the old memdev. The
pointer does not necessarily need to be live for that.

> +	return 0;
> +}
> +
>  static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>  {
> -	struct dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
>  	struct cxl_region *cxlr = data;
> +	struct dpa_result res1, res2;
>  	int rc;
>  
> +	/* To retrieve the correct memdev */
> +	rc = cxl_region_poison_lookup(cxlr, offset, &res1);
> +	if (rc)
> +		return rc;
> +
> +	struct device *dev __free(put_device) = &res1.cxlmd->dev;

I do not like magic mid-function scopes that are not generated by actual
allocation functions.

> +	ACQUIRE(device_intr, devlock)(dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -4115,20 +4173,18 @@ static int cxl_region_debugfs_poison_inject(void *data, u64 offset)
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
>  		return rc;
>  
> -	if (validate_region_offset(cxlr, offset))
> -		return -EINVAL;
> -
> -	offset -= cxlr->params.cache_size;
> -	rc = region_offset_to_dpa_result(cxlr, offset, &result);
> -	if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
> +	/*
> +	 * Retrieve memdev and DPA data again in case that the data
> +	 * has been changed before holding locks.
> +	 */
> +	rc = __cxl_region_poison_lookup(cxlr, offset, &res2);
> +	if (rc || res2.cxlmd != res1.cxlmd || res2.dpa != res1.dpa) {

Nothing does a put_device() on res2.cxlmd->dev.

So, it seems it would indeed be altogether cleaner to eliminate the
cxlmd->endpoint validity checking altogether by reordering
initialization and teardown.
