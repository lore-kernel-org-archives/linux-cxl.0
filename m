Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387ED40910F
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809323; cv=fail; b=D5gStMZFjl4Tb1sl7/MQuxLSDS/CCXyXGRBH3HQzU21Z6ZJLD8BIsh0lJehNddOi/rDqvAH7kvmmEyEgzNKOJcOkj1CBeuci90HPErqiznRmxW2XYFbB6mXmpYwGtvG5Dc/D7U/16WPtT/f7O9iicKFb3IEcLKPVjNuC27D0zWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809323; c=relaxed/simple;
	bh=+cjndgIOL6bf2ClV9IRBQ/sVYERxfAnRJGIcZvp4PIo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s6mSexdogs9Sj5jjyzExmvJYSMbmoqP5eFjPTDI53x9y24s+l7nOCUyk8gb4SEf1/ddpmQ0t8tQF7fvTsxo4rz7QLWRdO5w88DegyTa08RmSQzjZUfrn9NGjqJ/HxOxeNoTPCMIYztl8MIUS/m0gPmyvlbSTXHvP4sYtx45+Lgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLzPR4Id; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLzPR4Id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790809320; x=1822345320;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+cjndgIOL6bf2ClV9IRBQ/sVYERxfAnRJGIcZvp4PIo=;
  b=CLzPR4IdaOqIVmZR/cQ2tly1RkvA6ZE9ERAdtspRodu0aoFFNN+rlsZf
   xpUFiD+O3gQn46GXgbIlrAj7j7UG/OsvDDog23U+7JZbGn69NwbZWzr9c
   LWR8OFlTMAveWrHJTkxOAjCb7WxlB8kIh/H743M5FrR2uVdKIiONxR2dq
   /KYVGBiBeXSqq+Z5upwB0NX1yG1+zWQRhjLZXN2tBthd4LRYghg+ME+lt
   UfeELLLT6TaKRsjiST2A8B23meStqad0RjcAlJNiX60zfWolmQ4OzPkSS
   ZnSqz+wv4oZuJsUQ1LCkqiKFezsu0YnT44gE0q630ewBHyqc142blHHx0
   A==;
X-CSE-ConnectionGUID: Y+DJVxfuRO2cBIXqD7KP9w==
X-CSE-MsgGUID: k0xDfYLhTViyZdoN0EmR2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="90418731"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="90418731"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:01:59 -0700
X-CSE-ConnectionGUID: Fz6ZbmN6RPK0fISEK5XAEg==
X-CSE-MsgGUID: JDoo5paFTtml4nByRyoCww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="272272772"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 16:01:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:01:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:01:57 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfHzDhcz37JhToy5JI0OjaPX79vPI5efYS+cp6du6HQI8WAmXaaB7nVldGRRyJ2kJ89nlEAU60u+/a8+Jyoe2SemYgRU8BzV9OzIlroVe1HCVhmCukMNjbJkkh06NQX5QU7xEMKcm7+Ycj/bJPVNEhY4e1oW/Y5HlBGfQ5Yi2jk6B+yTFd9ppuNKT6VbZ3xSS8pa2/hW3tThiKCfUAGRQq+4HFn0yvkauMgB+xgbaj/EdNbyVD6P6R1BGATA5m/KPRE3IsjgdqV7VOcQ/2efRUexBwPqJxsEZrQncEhn6Mw1ldVm3s4GXF/yWekbObtHh7WmXEtKU2LzbePZLft35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EWXyg/lxXjGDhhzxyF2veDHhShAAlnA57DBk9TT1rs=;
 b=eDPc2ezo5p4XGBTyWuiUJQu1LxH3neiBh6rTEpVDSvsMfPoOa6vgcLppSha9mMJyNistw99PWH/Lj/KqqOF7PdxpHmD6TjuKS6G52NWFHkX1lrBRPoWfFMe7QDqyty1Lbjq9meaHMrSUaexKtjTQVnENpJGSGSALyaWhA8g5yv9g/+96oHTUn0cn32snKEWjoMfzWHGKcg0ba+cfAnXutnOvmu8ZIcEUr/dPjivWWAmdQceVhfU/2X1JjtXnrQmWqPVc3K/+TdX3DLZL058Pl3CV1MsgpPlCOGlctfLkXK9vfDJxR90m8a7kpTr/OGrL/kMF6yrJMZME9tr3LhwlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 23:00:33 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 23:00:31 +0000
Date: Wed, 30 Sep 2026 16:00:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<ming.li@zohomail.com>, <icheng@nvidia.com>
Subject: Re: [PATCH v3 3/3] cxl/port: Attach endpoints to a dport under the
 lock that pins it
Message-ID: <ar2UjNmr7vUyEjAu@aschofie-mobl2.lan>
References: <20260930152311.4164036-1-dave.jiang@intel.com>
 <20260930152311.4164036-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930152311.4164036-4-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV8PR11MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 5600a854-f199-4019-9790-08df1f46a0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|10067099003|3023799007|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: +o55lHD4BCIINY7Gwumu5h/iBrUUhcm6JMSsaKzHSoiYRsKlFGTj1HTh8VIuT53font/h48iD0umr80tnpKexUovrhGjbCJOADRE0/KitvxAQX0DlioxAWzhhTl3j2ro+LgekkhCPVKSQx/QkNSnFMM4Ueh3N0IhxNMkHKjB2fb4R8EEuayLZ+XAa6tPbaXJ4OwABZ56z/NEodprvZlNhHO7JCpHDSouwE2m/RCMfPoOO6tSvufqb6f5UlqMGOzQaPwCwzbV1NZUdf5+TWMlnJCvAwVLplf2PDzEv4IiSNXmMKj9pjr4OMcc+4OfxBTN2zZ3PJW9uEJ6lT4fy51CLp0+K0AYRdgdyXOYw87JRpuUk/fAXxt3HI1/v5X6VkqFEzhqXeOX69oXxFBEdQPHYR/7rayiR9k9+5TI8KuXk+Y/2w3ZmpP8cDU26/0xuDaggeusspq718VAns2Cyorp0Tu/Fbf1p432/LcPvWzhmwP9ilHAtaI2YqkYQcq+tDru/LxPZL8Wa38VJQppRirt7fME9O7UozrpMVf7y94Fs40Q/28JYbLBwNZoDyOYND2s5ecTu8JLe2ae9ZNelfzWkprLsh0usdgaisHRi7Vvrc9Hry0eQqMiEPDt25Bnpsbq4i91bNnnUOVLxkU7cZSKt0BBir/JMKTAz8rQQN5mly8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeK4z6AtrHSq6V/Od8AYk3wd/t+BRP3G5Nsb0sCU+J7ZWidceBn5Kx4/bWjN?=
 =?us-ascii?Q?LnwO1e8G/cftQMD5aVnniBNnrWEmLCdfNaZ1zs1+Tv8OxJEbxSmTaZPKs3ac?=
 =?us-ascii?Q?iSoj7LHvU+2iwyDNmuUbIJSe76uNVtdSv/eMokaBzsOC9zx8ojTSqX1HH8u9?=
 =?us-ascii?Q?vvTfn0U0T1oQoxqGHKaLQze5uNpsMjlkwXHT6ol3uF6biENdJu/eh/hkZBvX?=
 =?us-ascii?Q?9qCNhkqP+yiEduOmoZcfnv/1syqMhneC+MhXrbIk5n/ihWzfkepg0lg+BNpl?=
 =?us-ascii?Q?D/BfvDZgy3arHgE12BMRPFMgvpm6w3NqJ2Cvioe+t6nSA8+d6Fx7zwcLDV1/?=
 =?us-ascii?Q?zLWICY/WRtVCk6giw96/M1qc7p7VJ/RRb/uLzdME7UxPXDEtl2T9fvloJZ1b?=
 =?us-ascii?Q?eXrnbklkHIITKQr5jFekcxcIcSJJsZHNYIIZLZHcyTnjAs7FURU+okdDiv8n?=
 =?us-ascii?Q?HUv5pIlxQli6Z6YLpYyl/BeBDrXK8XNCrqEk3Dztm4ifZarV/RoZgzcVYNpq?=
 =?us-ascii?Q?xyxUdjEq8NHnnJLSNamUID+M/S9Kb1l2euoTmXWMVleQT0bhfLJDASVXP7iz?=
 =?us-ascii?Q?0uwElNxQxbE3mEtHziioRazNVHArVFP+E/8iJoPTJIvLA2rMik7TUBlOPxLi?=
 =?us-ascii?Q?NU+/ClQAR169SoTNoMMtIdQTEJ5EDtcsyXEliyyTtXGoqUGgwVQrKhgLswAT?=
 =?us-ascii?Q?LRq0GfqTwnWY1cnTUSEtOU+iuGb94LXANtTohh+5nZgJpC8+hIfAXfiYfrv9?=
 =?us-ascii?Q?QmCKGZUfOtLkoO92lXRiNukGpA2hcBcE48aoESHKufjZdSMDB9wvzlY9Tva8?=
 =?us-ascii?Q?CUEWO8Xs5jrYzGlUpZ2lrCbISuNNE3maYIug3lhnhBJ8c4GWa2M+Y8+nx8ID?=
 =?us-ascii?Q?YAUc25cWpHXKfjJeLrPbAzCpMi+++bJu6uT+yP5bju/lCCdNF6EjJvexlb/7?=
 =?us-ascii?Q?V/tdCUUOdaTc3ikKcjr7+DMnbGlUY3h+WtpdRZVdzWOXvCwo3fLwUCeOnvr0?=
 =?us-ascii?Q?NCIMZticaZOxK/I3vKcYeBFr5m7HFTexlbwYPS8CUoheP/z5F1E5RrWZc2r5?=
 =?us-ascii?Q?FUBEcahIbEbmqxsV1XXLWmpZrJktqsl99yEAuOFF1Vi2I4ZM1T2tzg1iSc4D?=
 =?us-ascii?Q?c5Vk1dbw89Yet2lUbyo7ju6Z8JUZ6pYN7IYfxhj5HktEqt4J27ReWaMgnDsk?=
 =?us-ascii?Q?oRzt61/tOCnIVI9j5/48BMUXP4UF6eynTGqpoR6Wajm+0SwaJMY/J6fWjfV+?=
 =?us-ascii?Q?bgY3U4nEOZEXH2EiUi1psb5iUPYKw9O9OOaF326AZ9JmAVhoTjuhNUYTEorl?=
 =?us-ascii?Q?SO/LS0vdb6/RlkOBShPHsqLu56QDBU9WGI/XxrJ1pCIaByPmqYYB01R/QhEC?=
 =?us-ascii?Q?1BYQEG3DuddyIiFZPW2MsyNkkGhBXtfa+IfjllTFQq0f7dHcs9BbiKGM/6vJ?=
 =?us-ascii?Q?xsFUVHny3gsrp2ROGM8nofNo6Oq41mL4c0dRYNUqIlVpilASXltZR9lKYJvc?=
 =?us-ascii?Q?X0AyH7cI+VIAjeTC9XBx8558lIMKmbspp5O9j1gdTlzETsOcL3saEhgiLsPS?=
 =?us-ascii?Q?TTLIcfZyxfkBn3uUbfuj6YDkloYjQCsvfpi8jYiRZvvzBJ3/I/OOTe49k3P5?=
 =?us-ascii?Q?D6xgQb7aNiNQDqSgfmr3qI94eoIkf6PnHuU6YTsRolNyLUDumsbyDk0xsFsd?=
 =?us-ascii?Q?MSUooZAd8tehxaCo8RCN7zp68DIyBhGO4pgwB+KZTaIogxUg0STCFyQwIEXM?=
 =?us-ascii?Q?ERQh92q7EMGFJgGIwLLM3x3cAzFUgWU=3D?=
X-Exchange-RoutingPolicyChecked: qU9/BGdHTgJdkS+UV/e/55dIaii8mZkdQboBWC3GrwKYMQb/wh7lg2Gj2K1I3m7Ipu52m9ClmIiYBRtR5LI93Uir0633aU8ifNjHCw46nQpjP5qNRqlVl39bevmPMyWHIQseLLAboZMO4Z9gAUFLC+QGjPAPLeIJD8UqRchGo86QBi++UPlZs2CoVgIOBPppiCS+byoj6nb7Rl5mwL/M3C/2cFrd3hYzCF21zKSYAAr3fvEyprnMA+XeckHipeuzP0N+IgBF+XaIdK5P4fY7UETW8C6eYZTYKeiQJ4g3xc1QjZwMTWmjbo2IejMDj2EJtMeWEK8wuLGaHUgvmTrURQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5600a854-f199-4019-9790-08df1f46a0d7
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:00:31.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PSPzxedVZ9gHEEjHumVCb4FPFD6jbz3A2Qrf3jfLjMZwbT45W7jNxPEwYAyIwaysksmfr6mQAXt6zg5o6xHXmeIzZnTPlHEjAOnttEMWMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com

On Wed, Sep 30, 2026 at 08:23:11AM -0700, Dave Jiang wrote:
> devm_cxl_enumerate_ports() and add_port_attach_ep() look up or create a
> dport under its port's device lock, drop the lock, then pass the dport
> to cxl_add_ep(). add_ep() reads dport->port before taking the lock, and
> cxl_gpf_port_setup() reads and writes the dport with no lock held.
> 
> A concurrent cxl_detach_ep() for another memdev below the same port can
> free the dport in that window: it calls del_dports() under the port lock
> when the last endpoint leaves. The enumerating memdev then dereferences
> freed memory.
> 
> Attach the endpoint and set up GPF while the port lock from the lookup
> is still held. Make add_ep() assert that lock instead of taking it.
> Under the lock, a dport found in port->dports is still live, since
> removal erases it from the xarray before freeing it.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

