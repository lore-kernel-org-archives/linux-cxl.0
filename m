Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3942288EF
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719709; cv=fail; b=Mq36cZUeRO/GwNjYVgVy2mivtLgCngZ350WRljWwGULsMms+S3z5zUfoj1sI+9hlZGROjsOlyn204ebmHHt8CD57a3NnS1Pzw2C2SdbygPSLShHLEVhzwv8fOmXgTkT41oaZ8sgbcaNb06PezIey2MmM8HSK5+cEre6wTvpMQtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719709; c=relaxed/simple;
	bh=IsecCcTs2uAHa6m8TWIRJuKEFm3JIQe5rm4bs1S8T50=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ncDCv2qJ9ZsZgbl5JPOpuUy17uulIkHL18v+uCX8C93Cl7Ztazc+VrzDXbWbWS2lEyfI2EsiqFQ2sbUavY9RekDeIKGyobI2GF6o7GlAEj6Z/6PoBd3CI7CjcNKpQN64848o+amyxf6F9XBxORL/0HxcTxn9ZzBdWQ+bumLsFls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDAslnyr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDAslnyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738719707; x=1770255707;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IsecCcTs2uAHa6m8TWIRJuKEFm3JIQe5rm4bs1S8T50=;
  b=aDAslnyrWSngyDJwZcSwZfCdBE2rQbixMu/u/YqeEgFnmtyuCoLIOQRE
   5x5W2bNM8Ac6cGotyhPi98iHWGam2eoaZhjGEka5tm4/m5M1b3KJqaNJK
   +6TG9YCjgzXyGczk+Ww+VCi5aM7Hn1psg53swACGRyc+JdvKmBw/XupRM
   hftWsWGzAuzVt5aht6IPoOXGS/Sar80zh2PE0AjfUFosNzbQSdVuTDrr4
   Lmw+7idwZN1f9u0LiSIrEzeYF8SwfwJIEhrf9sOGLCVrfBZ36OKzYiadY
   7EzOZ5M2f9dbQKWqIwYs336sPcFZkk6PH5i5N+mVcCrVfguZm/Am2jJ/g
   g==;
X-CSE-ConnectionGUID: hfLf/WRPSJmhZXWbGLJO7Q==
X-CSE-MsgGUID: xTYMUz9RQlKyi855VCerSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49924115"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="49924115"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 17:41:45 -0800
X-CSE-ConnectionGUID: Aq6M0e+QRMiSYeIArDaAtg==
X-CSE-MsgGUID: 3e2UzipfSuWPeK8HHKijaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="115737091"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 17:41:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 17:41:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 17:41:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 17:41:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYQPNt3cOefAQWH29cBKbuKuVSSncSJlNDajPB9ZZc1NhIznGu93ZGAQ0xo7+5XGBscjnFhCRAO/qfCDGYkz0GFbzdKLdvulLsXsbSzgKhtdzybYsWh9Qx8yGHVOzXTLUi0G/p+4G/hflLJBWBgtrjftn8mN5y6S/fPWcXRZ+rZ/B8f34GKMIg7ijGBu2cW2CxIdixTlz9gM4FdE2qWVPM500QWSXEqjpahCpTz2tAo9A0b2YEirtLN64BViwNEJLWMw6Bn3nh8q1aVzJQtC0b+gjUcYDLH+ZI2KQHs1jbV1gEjh/TzA9fqgx9D2ZBYvEtyjfI9NUqDIlPPp4NbjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf2zrerDqXX86V+maIoVaXXKlLYOtO3hHd+VfWF/Nsc=;
 b=Mx4XJ/BW4djZLbMHiTHpISRCJc2h8ZzjU8QW71TcP2t3+wwrQfpsyLNKmENVWybXmIAfXoixM05+ECeSUukxTmce7Yi8JSGE/hWbXqMFpERJ8MiACfzOHbmM1yqj0ZNv77QJTt/vuxdd1D16q/TGf7S9BYW2soPz4mSf9r+1oO2lN3hVezAarbHh3R+O+TLkISwQe08A5QLEzRlGYRcMWI28hVFjnF019LE4MsXN+o0B/MWIzUezwlcA4uHJ91ZCNPRYGGrXu0iDe6uxzW99U/SKMsTrQxs7OhnZxw3xccyXyoJ8TSjvPS/C0cOdB8mINXSoxNXCuG3VX2rI+PLrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB7653.namprd11.prod.outlook.com (2603:10b6:806:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 01:41:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 01:41:08 +0000
Date: Tue, 4 Feb 2025 17:41:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 11/16] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67a2c1b1ee289_2d2c2941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-12-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204220430.4146187-12-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbc3134-ea79-4ea1-fafc-08dd458629a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ipidiDBXkVJ2Ui2iEekwUUgtiQBgJRwydSkGthd4e8IZyrwj934GWwmR/rG6?=
 =?us-ascii?Q?lvBej6GYCuav6ekMAsDMNxx5zBkqgi3hZN2hX7tflLvWg1DYHeE6swEncxvd?=
 =?us-ascii?Q?scpjXwEotG/hMsNoVS+sld1ZG8iusTxe8gVBLu6+WLq7SYy8E3ak2IjOIUab?=
 =?us-ascii?Q?8ZjUOTTjAtSvsy+mgB3wY8na4bjvqjBRnXMK0Ip5i5oIfD4TvBD2IMq8kL4V?=
 =?us-ascii?Q?ptTW5EuPY7qSUZ3lsLNKO9Czwqbv/bCOXxdMOeULrE5ZQkSh7J7kZkVRN5cX?=
 =?us-ascii?Q?i1H6h6dxfx2DIz+/ZAckfxN4frkWqPvWqtornzmxCeFEhHtATsRV2fceWiJH?=
 =?us-ascii?Q?dTynhlb+xZzSLwdTnW+f+C76h2XQVVohEAJQZ8DwEjycC1BYJ5C1IX39HViX?=
 =?us-ascii?Q?uK8DScRPQ34krPQIJUFJvw3WqGUIbykbes2yOgLSid+pVmxHMDgrX83ey9PU?=
 =?us-ascii?Q?LUQreiKs+V4SEUkkpmqFIMu0JMNYSztvSLHourVm2MmMTI/xUjlzZin12uFb?=
 =?us-ascii?Q?Q9SKZLeK/zBVMhF/0e+nwk5eJ9Ne+rKdKhO52cEKpnxoCUoe1146ZXM/F7Mm?=
 =?us-ascii?Q?YhzIbWv/IbUlUl4LMAOwL1DvfQiH1eHeTlUTI/H8nhLGTfQz/c2OJQ7ZILjh?=
 =?us-ascii?Q?/yP2pVg/0lLEtb5vWr0j43RW9u43vcjES5nvtr8N2fBDzQiVvfwvNBWS3s2X?=
 =?us-ascii?Q?JjELH6F+wTUVkGzgM91jiqltecjeO19+Tnh6UyTL0tU2ZjNGiAisCiPKTT1S?=
 =?us-ascii?Q?HUUekao9IMfUd0yr1pBFnzi+4wAZ/lvLz4cApakZ8NMOb+f5NW73JpB4Jmge?=
 =?us-ascii?Q?nJi3XIGfA/T62S/4L2ZXLh6yN6tNj8CnFfes2Tn5EBcQAjyJDNNiDxI27cVx?=
 =?us-ascii?Q?Ek5QMpSk9K2qXMJvkBzRWQt1sUrFtfaohxkpFM7MMOCxm87MmeVLLI1nX/2x?=
 =?us-ascii?Q?Po61zyWMU7Y5IBJ1ZFAToYhETbojsVxGC4TEHzcCzajhNFK0kiSUDrHmj7ux?=
 =?us-ascii?Q?goObBorkufDAP6YpSl+qk32Vs1IjJ7F5vFWuNx8WbX//Z0qL9yRuF7Oc+mkT?=
 =?us-ascii?Q?8e5Rr+kIaCql1HoTvMqKVvvB3WNahgolVQs/9pGJRwKSqiJtnWB1ACjkOxpp?=
 =?us-ascii?Q?1po0lWmML6dbPpMZBKX3vghkcIpSPpunHSNWZN9KovKRtndNPbfFAEJ4y9Bs?=
 =?us-ascii?Q?jcYYFa/t1fk7RDnxQtX69c0sTz8KFYJ18oQTF/XQskJDOfmfz093B5vaTKSu?=
 =?us-ascii?Q?9CfFkNwHp76ET1FHOajBxKiIt/I8dLPdVc78Y/DVzRSimow4HZQa5bdRLae3?=
 =?us-ascii?Q?8j0ac9YveY8+nkM0eNYJjYuXSIyXaQzaK9YB4veldSUeNo0XRyg3utBvZHZF?=
 =?us-ascii?Q?ocVI+hrrKl7M/V+pAtLi2i37buOR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1S6E1amBA0xU5U2NNQ6WP5DKUjZ8+r0qb/sQ2w0WqM1TBwmDVaXn+wz7bSI/?=
 =?us-ascii?Q?uR5kk1dLD4/AUlxm3JrfjG63+vN25SKbL1T1Rv81sJ7AcjJoop/tU4DEr2mc?=
 =?us-ascii?Q?UaUe7vxkrvyM+fnlYH6YurraUuShgFkli2eWVb11pvCMf3KDqOtvzfa+Meqm?=
 =?us-ascii?Q?d+NNtzfs1gfta4YLxGsUSm8Mph3xz8k4wXCOkvanY3cUPjgUdudaOdKYKBEY?=
 =?us-ascii?Q?QuXhP8U2r/EALDRWuZgF9WZpz2e1K7Za4SsNOjdwMvY7sPWs8JUN4C44EZjX?=
 =?us-ascii?Q?tksHFygDeBZfqkks3EhoyGE1aQ3xee9wylg0DfO+Bc6tXWHAxLyUsFERk3OI?=
 =?us-ascii?Q?6gxZmHHjTwhZCqi4zALa4QYhwig82iMke9NnDj6IJ9P5SPJwrOpKBov0/i/e?=
 =?us-ascii?Q?hpeIQYsmtJfiikVq84vB7V6ANrSk9qxXW053F5pqtgxqig64VWUqj0S8ztMH?=
 =?us-ascii?Q?K0yIsefG6jZUG0nDHmLMGCXkUehBpe0FSpU446pkJpOCjU5jWfeSu6Ngzq2y?=
 =?us-ascii?Q?aMNaC1kfVfaA8WuAk0wM2cSoNQ2oK34NPfRzwaB10wUyQwKUuEZHcRijl5+m?=
 =?us-ascii?Q?PmkF0bJwnIKru6lRnj2kXO2a6gLaxoq3RF6OERktBKV7CopT1YxLa8vq0PlV?=
 =?us-ascii?Q?LkpJxZB2OXbrjbOe0p73alIRmZ4VQ7NP4Z5cRBPeapgzma9sHLvpTU1Iut45?=
 =?us-ascii?Q?C78Yf4xRe0Sk/71YhDL2ik0z9F5ICCBDoQJOjGbzW3P9qKVRhQaykRZIiThk?=
 =?us-ascii?Q?0nO436hD7MlEx1lU8ncoYsFZbfbF00p5wq0JQkmWX7kSRGhjtwWi9vttx2vc?=
 =?us-ascii?Q?fs0ogc1FfvDWqmufKje05OygW0y2wd3UA5OmYbhog64F1Vwt0Vf1VAT39G8w?=
 =?us-ascii?Q?C3w2oe2gTN1FK0WYtns2aBSRBB0K10nLN3APZRF2n/x+1MU3hmodEL7kstT3?=
 =?us-ascii?Q?iG3EvDh92bXofqEEtbE7nLnYWpdN5/dXyPtPJ+VCb8kN3ufycGhvZmAK2VZH?=
 =?us-ascii?Q?8ZLFDlvpcQlM7NKF6BV9Inl+lpCStkyuRga6d7Y+UEnlqM+KVHXvq7bjmTaH?=
 =?us-ascii?Q?HJ/h0vIb0pX4Qp7XA0kFEB6GUNaXoVQHWg0OsBc2CkTHnvasgTop3z74PSNk?=
 =?us-ascii?Q?js0dgWVyrrzYlcKw6LMfuP/860i0FkqD6FDCbT6O0BqQ+xv5hUh1Fo2VRxIf?=
 =?us-ascii?Q?yb2IdyiDCDOeTR30lWI/RQW4XubZpi4OSUS0pmILI1/ZRsrkwoByN/m5wgLD?=
 =?us-ascii?Q?NIWLIPVNTxN4lIHQJk3y7TQbHgCX+DUCzWGRFqx+dqk24SCW51RIPyi3CdAl?=
 =?us-ascii?Q?iq8qM1ThuJMsAYS2+es/WgxV87PicwvoKJmsQ2sG/wcge9AW6leKKuAwEup2?=
 =?us-ascii?Q?ppuA0bkMZqqqfkSx7lGE9UTM00+XDjlioqXg7ucqUun06CUInlx5QGGFw5pW?=
 =?us-ascii?Q?D6LbFmRab8bVvPWNk6uVT7awmfZkHbuC4RrPRHPJNp0B47zgXAiD3Z0eX2xw?=
 =?us-ascii?Q?YR7gzVz7CKJJS2UJR6eAKY3WbdVC+Tqf6n2pGVhTpDJemafOVb5x+EyFN/GI?=
 =?us-ascii?Q?SdXgfXqT29fmuZNCpv5m1CWYvAW3tSAi0LlhHpkMui902Ow0JW6hp4553UFe?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbc3134-ea79-4ea1-fafc-08dd458629a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:41:08.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtPu5GSgdxygd+CjKoDQ8ZsFj2zg7t2jEHGtHRcZcU9kQZITSDQh/pdVf4NuxMQI9TTBq5nTgvDRe671Qo/7rH8EAC8fY163Y/vCcsfyb40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7653
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the feature reported by Get Supported Features call for the specific
> feature.
> 
> Only "get supported features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get supported features"
> will filter the features that are exclusive to the kernel and only
> report out features that are not kernel only.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Cleanup for loop initializers. (Jonathan)
> - Move is_cxl_feature_exclusive() prototype. (Jonathan)
> - Move cxlctl_fwc_rpc() input param name change. (Jonathan)
> - Use struct_size() for calculation. (Jonathan)
> ---
>  drivers/cxl/core/mbox.c     |   9 ++
>  drivers/cxl/cxl.h           |   1 +
>  drivers/cxl/fwctl.c         | 200 +++++++++++++++++++++++++++++++++++-
>  include/cxl/features.h      |   8 --
>  include/uapi/cxl/features.h |   1 +
>  include/uapi/fwctl/cxl.h    |  37 +++++++
>  6 files changed, 246 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9fe552e3d465..d38a5fc1384f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -92,6 +92,15 @@ int cxl_get_feature_command_id(u16 opcode)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_get_feature_command_id, "CXL");
>  
> +u16 cxl_get_feature_command_opcode(int feature_id)
> +{
> +	if (feature_id >= ARRAY_SIZE(cxl_feature_commands))
> +		return 0xffff;
> +
> +	return cxl_feature_commands[feature_id];
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_feature_command_opcode, "CXL");

This can move to drivers/cxl/core/features.c, and it looks like
@feature_id and @cxl_feature_commands are misnamed.

This should be named in terms of fwctl command id to CXL opcode, right?


> +
>  /*
>   * Commands that RAW doesn't permit. The rationale for each:
>   *
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2d6f7c87e5e8..451b2c7e995b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -912,6 +912,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
>  int cxl_get_feature_command_id(u16 opcode);
> +u16 cxl_get_feature_command_opcode(int feature_id);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
> index 85dee01d89d1..39c01ef4dbf2 100644
> --- a/drivers/cxl/fwctl.c
> +++ b/drivers/cxl/fwctl.c
> @@ -35,11 +35,207 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  	return info;
>  }
>  
> +static struct cxl_feat_entry *
> +get_support_feature_info(struct cxl_features_state *cxlfs,
> +			 const struct fwctl_rpc_cxl *rpc_in)
> +{
> +	struct cxl_feat_entry *feat;
> +	uuid_t uuid;
> +
> +	if (rpc_in->op_size < sizeof(uuid))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
> +			   sizeof(uuid)))
> +		return ERR_PTR(-EFAULT);
> +
> +	for (int i = 0; i < cxlfs->num_features; i++) {
> +		feat = &cxlfs->entries[i];
> +		if (uuid_equal(&uuid, &feat->uuid))
> +			return feat;
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
> +					   const struct fwctl_rpc_cxl *rpc_in,
> +					   size_t *out_len)
> +{
> +	struct cxl_mbox_get_sup_feats_out *feat_out;
> +	struct cxl_mbox_get_sup_feats_in feat_in;
> +	struct cxl_feat_entry *pos;
> +	size_t out_size;
> +	int requested;
> +	u32 count;
> +	u16 start;
> +	int i;
> +
> +	if (rpc_in->op_size != sizeof(feat_in))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
> +			   rpc_in->op_size))
> +		return ERR_PTR(-EFAULT);
> +
> +	count = le32_to_cpu(feat_in.count);
> +	start = le16_to_cpu(feat_in.start_idx);
> +	requested = count / sizeof(*pos);
> +
> +	/*
> +	 * Make sure that the total requested number of entries is not greater
> +	 * than the total number of supported features allowed for userspace.
> +	 */
> +	if (start >= cxlfs->num_user_features)
> +		return ERR_PTR(-EINVAL);
> +
> +	requested = min_t(int, requested, cxlfs->num_user_features - start);
> +
> +	out_size = sizeof(struct fwctl_rpc_cxl_out) +
> +		struct_size(feat_out, ents, requested);
> +
> +	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> +		kvzalloc(out_size, GFP_KERNEL);
> +	if (!rpc_out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rpc_out->size = struct_size(feat_out, ents, requested);
> +	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
> +	if (requested == 0) {
> +		feat_out->num_entries = cpu_to_le16(requested);
> +		feat_out->supported_feats =
> +			cpu_to_le16(cxlfs->num_user_features);
> +		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +		*out_len = out_size;
> +		return no_free_ptr(rpc_out);
> +	}
> +
> +	for (i = 0, pos = &feat_out->ents[0];
> +	     i < cxlfs->num_features; i++, pos++) {
> +		if (i == requested)
> +			break;
> +
> +		memcpy(pos, &cxlfs->entries[i], sizeof(*pos));
> +		/*
> +		 * If the feature is exclusive, set the set_feat_size to 0 to
> +		 * indicate that the feature is not changeable.
> +		 */
> +		if (is_cxl_feature_exclusive(pos))
> +			pos->set_feat_size = 0;
> +	}
> +
> +	feat_out->num_entries = cpu_to_le16(requested);
> +	feat_out->supported_feats = cpu_to_le16(cxlfs->num_features);
> +	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> +	*out_len = out_size;
> +
> +	return no_free_ptr(rpc_out);
> +}
> +
> +static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
> +					 const struct fwctl_rpc_cxl *rpc_in,
> +					 enum fwctl_rpc_scope scope)
> +{
> +	struct cxl_feat_entry *feat;
> +	u16 effects, mask;
> +	u32 flags;
> +
> +	feat = get_support_feature_info(cxlfs, rpc_in);
> +	if (IS_ERR(feat))
> +		return false;
> +
> +	/* Ensure that the attribute is changeable */
> +	flags = le32_to_cpu(feat->flags);
> +	if (!(flags & CXL_FEATURE_F_CHANGEABLE))
> +		return false;
> +
> +	effects = le16_to_cpu(feat->effects);
> +
> +	/*
> +	 * Reserved bits are set, rejecting since the effects is not
> +	 * comprehended by the driver.
> +	 */
> +	if (effects & CXL_CMD_EFFECTS_RESERVED) {
> +		dev_warn_once(&cxlfs->cxlmd->dev,
> +			      "Reserved bits set in the Feature effects field!\n");
> +		return false;
> +	}
> +
> +	/* Currently no user background command support */
> +	if (effects & CXL_CMD_BACKGROUND)
> +		return false;
> +
> +	/* Effects cause immediate change, highest security scope is needed */
> +	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
> +	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
> +	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
> +	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
> +	if (effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
> +		return true;
> +
> +	/* These effects supported for all WRITE scope */
> +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> +	     effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> +	     effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET) &&
> +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> +		return true;

Jonathan and I came to the realization that bit[0,9:11] do not matter
because if they are not set there is no effect, and if they are set the
write is still allowed because the effect is post-reset.

The safety check that can be added is that if a Set has no immediate nor
post-reset effect then it is probably a device bug. In that case err on
the side of caution. I.e. all Set Feature must have at least one
immediate or reset effect.
