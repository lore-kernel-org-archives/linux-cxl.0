Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBAB2405E7
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762153; cv=fail; b=YFRsvKeAHPPgINd984Ak4ODGi5R5cP4jSxH9vvIgqkMZDWY/zKJYy0LsTCUrAi+tblyQGedL5vgWXCb5nfl+CtKrwOSoJgjj40sNyzi9AZOiIii8K7iHnZmkuPGaiTlNrkvO2pWN4xEFjIIHudJu7wRYBWXXco8K5OeVnFm0HmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762153; c=relaxed/simple;
	bh=tm5VdRPPq20jfnj6krdTuHy6otytHMKgBWaffz29qgg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nOphDwM6gx4hcR3muH9pDBe6vUi3NDUBtrU3SyTex0oswCD5jISHsIjnpPtOl5eH6CB8ezVDqpqz9bzknjt6ClkVFRZXlYXb+f7tRpChtv+WDRAd/tYhkL9+yPOW8rMQEmuG/BDQCxM5rVkA3TWfq2l3r8S/OK3Z6Y/wo1QPKIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsY2iXNa; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsY2iXNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772762150; x=1804298150;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=tm5VdRPPq20jfnj6krdTuHy6otytHMKgBWaffz29qgg=;
  b=GsY2iXNaS8Vnx1hL33Tp2lg8nww5PGcqIPf8opG3WtE2vGNQ33AxAlHx
   0tqDTGNCK5enVKS33XDUvFELPgd8BR2eght/qlmNPyP+avmpYQ/1PeHbI
   abVLUH/FyKLfSrfxfJJBz3G6AEreKINbXHQkxhjBjnkb1uFwp6Vf0VPm6
   CSZ4JzrV0nqj8zZHbvtRGX8KTpV+UFOFP8knTqoV11MTpPD/aD9FhuQa3
   BKh7/SLjxwD08Fs8hLV//b0HRpNVCAFt78dhirrGTkZ6R45daQ7VfeXin
   2/7KaCq0dNKu7XxvKKOgeAl32LrzBMXUeL7DMHIZ0YQS71o9niBhgOkU/
   g==;
X-CSE-ConnectionGUID: EHuWPRxXQLG+uCry8218fg==
X-CSE-MsgGUID: 2CuVMnv7QoGIGfPP+/mEEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="84577798"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="84577798"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:55:49 -0800
X-CSE-ConnectionGUID: AKz5TA+lQIKUL0YphfUk2Q==
X-CSE-MsgGUID: nYa3phhDQ12WtLuvF63obA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223824513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 17:55:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 17:55:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 17:55:48 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 17:55:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+rGlr7daMu8c+N5+kyMnPwxBr+JMk9rpKDuJVweTJDXAxWqHX8fjckdMGL2qC4ynzSm9MJ31MV8RbabRYxfFcufDQL6k+95wJoWH1Kjp/ZGFK4juegnUeAncHC6rbDNQ55BaCqVWeKXu8UjMN1YbTel/7dfJgDVfI4HjhOGUFn4pew66R0e1ab6yxrpgRrdmM++rp7+hD0Df83R6T7xXQ6u5nOY9IGqm0RzADT7DfEcX2SSiwV1rqO3xHzivXsRen3Br5XKc92OFVF1U3xYErgQkXCo1WlkHkGBPp0vnwhmXJOeAyFzjeZXFsnH72sQRqyC18810Hmewp+XtNOWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnEIFP2XVi6On8C4UGhnEtIz1BIM9iEKNctywRWlmqY=;
 b=hL9Ip9UQnJxAY8J8XNvUpYE0KF8mpfyB2Ngaw8r182eJKbi7xiyC2tDW3GazCMcccuRu1384cmxe+oVjdCr9pMNp/6Wlku337/c+lV0+BSLpN0lZF8HSN4Id3CB79erjohBi4Tka+W8+f7zzhWYNXeP8YWQpqI+yoRdYSED3nmN4mtmAG5eIUuZrk+yZYV/dyokC2OXi9Tfsb0kH/J+zNXChnKmPa3y27XflR412LZjsCqORbRKKsIZnKZ2zITSeMnYk+ZtgOVu/NFS8qzRMPb07MGcwWdwttEnUmrw40uHNeuBjzABBZiqmJBzrp8vo4NNnhGJUtTad1XJoAP84Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 01:55:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 01:55:45 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 5 Mar 2026 17:55:43 -0800
To: Keith Busch <kbusch@kernel.org>, <dan.j.williams@intel.com>
CC: Keith Busch <kbusch@meta.com>, <linux-cxl@vger.kernel.org>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
Message-ID: <69aa341fcf526_6423c1002c@dwillia2-mobl4.notmuch>
In-Reply-To: <aaotQCg0TspiiaDH@kbusch-mbp>
References: <20260305204057.1516948-1-kbusch@meta.com>
 <69aa28d0d9076_6423c100da@dwillia2-mobl4.notmuch>
 <aaotQCg0TspiiaDH@kbusch-mbp>
Subject: Re: [PATCH] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate
 mismatch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: c596daf9-8989-456f-82ea-08de7b237b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: +EqGGujvYOE/H7TN3IUipYfOV+Bw1V7WAJ2vJdSC/judKOCzlhSJvk6pvDLnV2Z3T9axk3Dd3Xs36cHK3+tkYJ+WrHTmYbTYzwlWObmoZx+nzdIMyP0Gx1kobo9QeRBvAGNPuyqF6faUsJun6K4dCXmhq01T8wl0CWbfiVKkOMRqBrHRHUsJueJ1+L4ZIK+jYz2Yrx1lF+Xc8XRL1fmtjmwX4nuuEYobsYgY6GLDW9jhxtdcQkMHZF4D3Am7TiBBuzM+ODiyfft3JJEXuD3zwt+KLi+IqevK/0hniKwDmK3a9JdHwkUXzuKPztOV8u4X783gIAvNsQKfQXNcSdghhlPSmPHPbIhIVUJMyryILNrUFYE7drlyE5wyaE1akk2ZM5mZ+U1Xy4JAi6Dw5cVaxYLPge3l14zPCM22kv0d5b55NOqtjNSNwBkuPPFeV6mKGYlS1bpShx4kbbYZqMRHpJ3be2H66GLQ1LB1oGSlq22RnlFeDAWVj03GGTrGvhPmMNiIZlNroUnpgrInw409go0x3XmhJhADD+FMQxLSfCaNB9C48SlhHGX8q9mVuruGlUaXOVYZGp9O5uOI7Anlj0TrTl75YgsEHl1/xJKz5Nrz96ZAsesELAgo0+ywle4rM7kM6mlGI4LobXaqyQRqNALky4uifaFda3ISYHAyLd5TMnA8cccdKCeLR6uRVbfQTDAk0nCi0XN7jT4U4CunYnQSbsfdAe3ggQOfCH0gfwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC9kV2V3ekdqamg5M1JuTGx4WndoMGJNNGFvS0hCVHJSeGNvaXgwYURsVjVM?=
 =?utf-8?B?UlVPTjF2Q3BKV2VyZkc1dFVDMTFUdlZXOStXUDAvRTJMb1VQcFZKOG9XQ2d2?=
 =?utf-8?B?UVgxdm5sZnNGUmFTZEhXOXpZUEJOVDIyTWx2MHZ5UjZVVlFIeXhwMEdhM3pm?=
 =?utf-8?B?eDRUSTNSc3ZMQnQ0NitrRjNpK0x5WHhhdXJmdW9YQzJ5cnJ0SVFwaUpEa09V?=
 =?utf-8?B?c293ZkhOSkFSbk9ydUFqY0tOUE5lWXVXY3M4NGJnT3lqWEVnNjlvU1FDWXBW?=
 =?utf-8?B?SkJIaDZhSDhCbGozdENxSHV3Y3ZSSGkrMEpSRThsU0o3TGtSMDk5cGJTcXBW?=
 =?utf-8?B?SGZiNHllNlV4UVhQelU0QWQzRkZpVG9Dc3ZWVkc1aXFnSmZPNHE2TDdzZHU1?=
 =?utf-8?B?QVJLUFJYckE0enZlTkk2bFQvQWMxdm52eTlYMXF0VzFkb3VpMHkwOWh2ZEJn?=
 =?utf-8?B?aTQrYjJFcmwwSnZaSVR5bDdNMDU1MFVpU04vclRtYnlXVlZRQzVoOHpvbVp5?=
 =?utf-8?B?V2VaTnRUM1NMOFN2VVlvRUZhUVFaSW9aR0xsS0k4OEdSdDRlUzJsVDBuSmxj?=
 =?utf-8?B?WVBxUVBBUEU4b2l0cGg4NE9HaFNkV3gzcTQ5Uno1SStCNjZyWTNJNDk5WFY2?=
 =?utf-8?B?R296WkYyWUwrYjNNQ3VieGpwNE00MU0va2p0THVoamNBdDFBY29paytsMk1u?=
 =?utf-8?B?RVhWdEhQVkRIYldFQmtneWhZRzBndEI2YWpXeDJXZmZVSkppejVlaXE1aVZH?=
 =?utf-8?B?UXAyNVIzNW1sWThFN2ZrRnhRQjQ1RVVndktkYWlqZDdiVTNSWW1uTUJici96?=
 =?utf-8?B?N01VbE5BLzZ0UlRZRGMybmkyVDRwRkY2bDRFQ3hjaHNuTUVMV0sxa0IwbWNE?=
 =?utf-8?B?dUdGVElNaXZoYU44M2JSL3paK0RxRXVycFEwSFFVSE5Tb0RvN1pDRTBCZGdz?=
 =?utf-8?B?VGowUTVmekhaeklvZ1NQYkR3YzRLN3Zmd21iZEpUQ1RPZXdtVXZvb0R4UkpS?=
 =?utf-8?B?c0ROT2Mwa25GUFV6Zm1aa3QxRDZ3eDBWeEQ0cGJISjRYeitYeTVmQnAwQzhB?=
 =?utf-8?B?NDFTVVkvc1JpVWZPNE9OWENQMk9PazE4YmxLWXZyTUR2ck52NWZBZVZkdHEy?=
 =?utf-8?B?NmtobWg3ZkNua3liQUtiKytKazdpcmZ0QVNqcDZmdjhPQ1hVM1lIa0ZoVmVG?=
 =?utf-8?B?eXVpUWszQ1Y2Qk8rN1hkN2xRQlhDbzYxbWdaUzZYVVRiVmpaSzBxd1Q5UWNM?=
 =?utf-8?B?TzlHZEI2cWxmNGRYck9iZzFLNm55bzN0N3R5cEJrNThORjh5eHJzZ0dBOC85?=
 =?utf-8?B?RzhkTCswRUlSTmVGWHBBQWJHejZHVXVkVEtmWEpEcmxBTW45M0tTMzM1aWQ2?=
 =?utf-8?B?STVTTGdYZFJybjVFd29wRmp3OWdidURiNGROdGl5Mk9mQ2Z2ZUpQclZQUkI3?=
 =?utf-8?B?ZHhMVk9OaVpDcWRGTDJRcEVzYnp2Qmk1VlpaNzF6MER4aWpsc1ZqMzJ5NGJt?=
 =?utf-8?B?T0JaZEZhTEhmaFBwaUN0U2c2cUo2ZXlpTktSQ1ErTld4UVdJeVhhSDlCNHNr?=
 =?utf-8?B?a2xLU0ptMjV5YnROWlRKZVFCRW9QWU5KTlRmNWd4Yk5zM1VSOGNkUnNyUDl0?=
 =?utf-8?B?aVpwN0h2OE9UeWpoTHNnOTZUTzJYOXJOSTRkdDkySkJoNmRqMzFxY2lmbCtL?=
 =?utf-8?B?cE1mYUY3U0xGZ2tzSnh5bjBQNk1ndU1BVk1zKzhRVHhUSUdEK3dCNTF4UVVa?=
 =?utf-8?B?QXhJcWxmb2d5SHBzeUJyMitHQURPR2xrdmNOMXgrTmFoVWJ2anhLclpDQnpa?=
 =?utf-8?B?UldYQjF5YmorL0lwYWdxNzArVGVlK1VsTFk5TThleXZkVHdoRUFjVzR2OVJC?=
 =?utf-8?B?VDBvSHpsU0RBRTk0RFB0TGVkMzU4bDdIeDJuOTZSVnFzMWNGeWlZTnpjWmJC?=
 =?utf-8?B?TWIzNlpWQ1JibXU4ZDNKVFlXN1Uwd1FpN0cwZjZMNlUyeTF0dEV4dHU1RldM?=
 =?utf-8?B?ZzJMekVxVHRSMXhXMUhpdDN6K3N1enV2TXNnM2h1TW5kbE8zc2lNTVlWNjNW?=
 =?utf-8?B?QlkxZ2hVMHdIWGZ1WFpkNnh4TFU3RnV2K2hoUHlGNURHVGx0bWtuakhxVFJj?=
 =?utf-8?B?OVU1NWVuQXlCdlFCVjZyZDNQUmRGNlZ4c29qcjdleE56UGNwaE5seEJNbU1a?=
 =?utf-8?B?WExxMHlESUpYaHB3TUg1V1pMZ3F0bXZyOUZkdE96ZGNoczFGM2dFc3pTcTVS?=
 =?utf-8?B?YUxycnROZ012TjBOdDRZejZsTUJnV1UzdHFqUVZOS0d1ZTNMWTV5VTNHSWp5?=
 =?utf-8?B?RUxEOUl4OEhTd0x3VWNnMG9oY2lndFNBZUxPYVE5eXZHT29BWlo3UC8wcGg4?=
 =?utf-8?Q?qJK1ag+QKq9Xeoko=3D?=
X-Exchange-RoutingPolicyChecked: S4ufF5Lt+C8/69NwO0mKC8SMMWuvI5O49fd1M/IWF+aT8EtvUodzW7osw0lJxBgvqmNwXmrKnJ7xboyXD3TQMKW23yFSqd4Sh49ez1B/y/uoX0YHsqpJLWmkU2Glmt1qS0RcSLd7XCRvc8LbOEuXm5pB1rk53l4w/XVhm0J7L2vHwp1hBp+l0i2KU5fHV4G+Okb0IlZBFQCtMCLckuXG2D+i1yYJ/WxBC0DOqBwnyVXVAhXhxhTLmh1R2Fl9Ch5Ox2LZOu76KdKravSZI+2MVeFhbNkkSBEBMfxe/ZQuhBPo9sWOYTU3h0WyaYep67GCMl+0Hc1V8PwAjlTjZbWI1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c596daf9-8989-456f-82ea-08de7b237b3f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 01:55:45.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnGry2TsBhQWBppmBahKf1/5QNB35RxLw7+Oe/WxmfQM+gxmktTIWjRBMi7omyqw05WuyCoLuzQmUGdan3+bL4GViWsNhxVQ7XJOcb5oxFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
X-OriginatorOrg: intel.com

Keith Busch wrote:
> On Thu, Mar 05, 2026 at 05:07:28PM -0800, dan.j.williams@intel.com wrote:
> > > The call from cxl_acpi_probe() is guarded by
> > > IS_ENABLED(CONFIG_CXL_PMEM), which evaluates to true for both =y and =m.
> 
> <snip>
> 
> > So I do not think this is sufficient because there is no
> > devm_cxl_add_nvdimm_bridge() stub in the CONFIG_CXL_PMEM=n case, right?
> 
> It's called from a preprocesser "#if 0" section, so it shouldn't be
> compiled in. At least it seems perfectly fine in local testing, but is
> that compiler specific? I think this should have been optimized out.

Oh, duh, yes, the IS_ENABLED() stays there. Hmm, this indeed looks like
it does everything right. I forgot that the dependency checker will make
sure that you can not select CXL_ACPI=y and CXL_PMEM=m.

So,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...this is better than what I proposed.
