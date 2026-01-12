Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A50362156;
	Mon, 12 Jan 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233171; cv=fail; b=UdNhPiF5nddYEJAXQf4Ja3LU3XURETjoW6YEtN2Hzx7OIblRzwSGFca0lFy8WsYzug6aGHCdOEQsmokfbsDmwtynSNRugdI8rZTE22Le86ylPNSeuyvZWT/NkksTU7djKJz5KdnddVkWmHrxJDfWqblNM3/nYmBAGoQADQhJSHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233171; c=relaxed/simple;
	bh=FpWMZd7S7wgLJmL3OSjO3jp5px00hNjQm1sBDEykiA8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WgDcZbiShtX+Sk4YZZrtPYMqbc/UM+kPUr8R5iqTiCj0tLhDsIYKvYEq15cWaOkudjH5BwF59acUe/XzwPcM+CwNsNAajd6E6gUhTIZAdz1oJWov2UY0W4Ud6u9velQYNiJtl/s/ghJv+5qwyILgXGbla/GQtO+o8VWOBkBlC3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqB1+A7C; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqB1+A7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768233169; x=1799769169;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FpWMZd7S7wgLJmL3OSjO3jp5px00hNjQm1sBDEykiA8=;
  b=ZqB1+A7CIzVmF40HbqWOX5M5aqESBsdkET6vxKghlyXmb0zJz7VLzeff
   KgPWiXedb3kD7sH1T7rjgOr/r4wLEWYh+j6uyFkvhpKdBo7CvyGVoIhsB
   v58lzAmsfaKG+oc+Q31jNkRq2/FQFIT5x1cC9+nJazbS2Q4n14ByTFx3+
   3ZiRlPzi9YpFLsmt3pJCZ5bI/ncvUqcMbppWpzPb379fxg7Vx1pTW4XzB
   X7VU6z2j8CPWUIlWZ2FTDsYgiu0OY1UoYh4WVdMjflHEUcKNI1m/bFmBa
   UiDjmzArT6GaeaRFSUYqeYaHxqnUjFMRW60tsss+Xai9j+GAa3l6tYnTN
   w==;
X-CSE-ConnectionGUID: Hzc6W+DGT8a0nwOyAoUNHg==
X-CSE-MsgGUID: qL5HBnp+RxGQKn9R0fjc+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69563942"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="69563942"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:52:48 -0800
X-CSE-ConnectionGUID: W6rqR/ppRCGdyoS2FKSS2Q==
X-CSE-MsgGUID: bVHSs8k/RXGf+NiQr8GtcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="204528569"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:52:48 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 07:52:47 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 07:52:47 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 07:52:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCCH1qMTe93MRXQyB1pQFx09lrl9NHo8EZkcQbgGFx4O6BazZIXaOskRlJeFAM0ab+s5osddJBFJAC4YMKd8W8GFMua/pI2iwt6X40Of0mE5wtqrttz3lF5WBu1sLD7TG+a85I2INfUCaFfoJVshRzBQwoYNlXh6HgjNW9oMo3cs6Nl2lJ1tJ7pl9s9UNK91sNbU74wPqG4pLx66uCUD09sDdMYilKCkGivL7TosCzNpNRx/UGNNTRFoQdH8LVaOdeYQkozbwUd6eUS/aX3PEDrbsmy2fsBBDi1rw9Zx3Pm4sHkA1zj2WP9SYhyuidNEAk9UcN01UgmMRJGXwDboMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn0zJt0y0MRPzWv4BoNJ3xROU1nwSq3ZKOxNUFrIky4=;
 b=WbCRPjH+3qkNC+uCqg39yoexYg2qZc+9xqFM4BPAlyCYm4fyan+u79PW949CwaERca1xSc/2CNTkKeV7RGfYQLiayafuefmmwd/sxH5UzgWN2Fst7ybW19DBEbj+b25W0iYNSJshFxATVIeIQ76AwJP2Kp+c8DeY76GtPMSCAbT4p8AHZLJRCbmzbE5xzmlxq1bFtyttC+srFBJFlMgdACb/IHjtHlnbcZeTkzLrdOIB3ntxM/RFDf/Sp26JCZ2dN6zNOMfkdxBTr+rcF7YSorKC7zirsYgQDr7RAqdBeRTEL+D8GCY5Lb5Lf5zUdrSy6nyxk2403YxBLxYx30gbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11)
 by PH3PPFC80959CE8.namprd11.prod.outlook.com (2603:10b6:518:1::d4b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 15:52:45 +0000
Received: from IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2]) by IA4PR11MB9131.namprd11.prod.outlook.com
 ([fe80::7187:92a3:991:56e2%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:52:45 +0000
Date: Mon, 12 Jan 2026 09:55:51 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH 1/1] cxl/hdm: Fix potential infinite loop in
 __cxl_dpa_reserve()
Message-ID: <69651987bbcfb_ec82610076@iweiny-mobl.notmuch>
References: <20260112120526.530232-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112120526.530232-1-ming.li@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::8) To IA4PR11MB9131.namprd11.prod.outlook.com
 (2603:10b6:208:55c::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9131:EE_|PH3PPFC80959CE8:EE_
X-MS-Office365-Filtering-Correlation-Id: 978b608f-3954-49a9-bd06-08de51f2a0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Af0je+f4h0CQyL/+bfTwdlO+J6SMu6pOsibPDbFCPxpKBFKMyehNIX1LGomv?=
 =?us-ascii?Q?CfO4L+l14+aLhEra6NpGCTxuDnVCfLeuhAL3zPUkabzfxO5pVWIfPfzXc0Hr?=
 =?us-ascii?Q?2vSt/aPDvmgi50Ws749NqHv14YCjTIHQuvwUG0dYI+DnWVkdtUEsNZhAn/bR?=
 =?us-ascii?Q?9Jd034ewPZCTk9hKdmSEjMn9jfaIw2k0itYn67QWDCb1iBpfYLaZcROyvQLb?=
 =?us-ascii?Q?gUKxV+iIr8/v8p9gFIozftOeQftzTVp63+0SCNUDaSvvIraGuQok2c6QU6N1?=
 =?us-ascii?Q?1Wmv6gGa7sEhWnAAzlDaLjsM168uAjoZRNusyMtjA2Iifn6G8N6AJv5zxama?=
 =?us-ascii?Q?fR/WBX/a/f82NDnewapDVMbxnUKExrC5HwJZwv48jGVg8VTJ7MY1B31zrgXT?=
 =?us-ascii?Q?KrpeiRgILAXGLgXMz5BcMVtDN8l20n4Ly7Wk5E3q+d9JeBVfQLwmGff5bGP9?=
 =?us-ascii?Q?S6/56Hd2908GiKJR1NgK9x4fs6PFlhTAI3zItfjdf0Zr+RdQ4jr4SMurTVpV?=
 =?us-ascii?Q?cWs4+/33/40OaqXIdfbPFNv6SPMuFpm93dIgW+3K1QWO70/zL5/oPDJWz6bj?=
 =?us-ascii?Q?JOskWmVHMWjmxnJcJ91MDA7UsC05YYJXG8djfmtGJzv2FPnqeQf6RzG1fhda?=
 =?us-ascii?Q?oDo8WLSXU0vaYdeCO1076C21nlK0ffp3v1AGAi7nV9EWKipedfDLddUUG1c6?=
 =?us-ascii?Q?MgwuQpTMUNJpAoUeztCWbmzUtr1Og1GWdL+pEkgmIKX2z8aCQRSdOkqFmzQK?=
 =?us-ascii?Q?76+O4ab67uFIEhqxGa2iIQA8iX0fIQ3/ebAYJ5UYbj5PzsV1NqNutHyFp9Cx?=
 =?us-ascii?Q?MBKJ0PZGuM8wKe0JWISeXBHVWoObUUsiuw3ZEvf9m2w/Y5PVvpeksmir4v3m?=
 =?us-ascii?Q?a0kww23XZOge7F3oSGJObj2g892CE+CzrydxClTSkxTDq0fKzPgZ0sGiLjp0?=
 =?us-ascii?Q?BFV5sXfnHsGkajKfzTHZvC+5MSEL7IB648ybG3z/ZIKOk6s8jnGWeoZGE5II?=
 =?us-ascii?Q?qtIR6Y8wc2mo/2VlBDqHHsMbeGAWDeKvojOLoAEfoc1BTRo7Oy70cLlr9guK?=
 =?us-ascii?Q?Ek2bZgu0NeKxk+HVwPzMALccVfHwVzjkPPPdUl2qoIX/9LrY9RKT6Dg1zuIh?=
 =?us-ascii?Q?5//a1Nbi7bX2+LImSfC6w1AuUPf2PVTol/0wQ5zITMsh2+dgKvoSadnMMOCC?=
 =?us-ascii?Q?2TFWuXp3Wt+c9ze4QFHdHg+Rbz7U8VV3z83lyb/Rp2gnPXM8V5qucoqgrBxj?=
 =?us-ascii?Q?SDeJBo9ytq95nkV5LkcmWi9svB41+PxNG4Dfb1JNVlxWKEcHcTcVIgzEItwc?=
 =?us-ascii?Q?oDpJ5xFcLJx7UJdZZuHlDUeUkArETrrskUIOdtLA4PqB5lRv94fkRSjFAB9r?=
 =?us-ascii?Q?PYpMG+6SvbUJsVKFryoZCPZW3ethGL/mden3cyE9ZKdg46XFEF5k7SIuHibr?=
 =?us-ascii?Q?JYsPhsEnz25hY7oP9UE7Qe+byVNhrJAI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR11MB9131.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxCOGbKnwr+0vkCE9ZA1joUM3g/XlENBBG3H8UcqJhyRR7Mh6B4DuKlgsEwB?=
 =?us-ascii?Q?oOAedDFIF0Vba5Rw2/zQe/70A5RJf7ME6xgugs4OOXXckJvLaJVeELc0jFNv?=
 =?us-ascii?Q?Ss6yyXa1dJE3jVbSPilhOj9zGmQYjB8bZO7f4HKax+svWOWhKPzbzNVPfK1I?=
 =?us-ascii?Q?PZajDHFLfERUTjLRzrgTSeh+dLI/GteEf/+81Ee38j74eQDbg3aRqK3TTNMI?=
 =?us-ascii?Q?M+EkoIfca6Y4apJJe0QT/lqYBffoUqbbj8yVRpNPSR3URC9tbENrImZAQGov?=
 =?us-ascii?Q?aXLwMjEyTFdwQnX5fncy5t5lPpUnyKOaKRcPKvb/7BJ6TIRbUvL1bikqVaGh?=
 =?us-ascii?Q?q2CZFqSdZqV9Qdg9b/0nNC5jsiudAq990ABRI6VajAM6AVCJsB+960Btni+o?=
 =?us-ascii?Q?oq1mfAo8lS6rrC9D+2cdgbZyNLHIUrr/nEQc03QA63sb0CtIgjJgLZGrZRvX?=
 =?us-ascii?Q?wipPcwWDauypLKdoCxdweAf1+w16jXA/km+F2q06rkiEvnnBWYcvt7dvyCpZ?=
 =?us-ascii?Q?jfthd/soc7wJ82D8jFtwRrGOdDt/MKv5vNVI2ph2Zd2BazkWowJqTUYZmExV?=
 =?us-ascii?Q?11g1vzZ+bo/RPA4B9M93HI8GBxjeejjMOjY9SZJhLZVSvm2OdzeniizR/72Q?=
 =?us-ascii?Q?Dq0S6zeFbkfIaBfVEclBEjPgslU89hZyzlodt1XlV88r/4ow6vinuYMzl+Qm?=
 =?us-ascii?Q?w0nyM2ZcVXKq2eB3ZcvYKernF0XPCdN76/gG/tydzgXULgynu23AovtmObVA?=
 =?us-ascii?Q?zj8oKrWqiexVMhRG5/HswNL050dnNltArP7xpYnku2R9GkDscU4+s4dU/SCH?=
 =?us-ascii?Q?KrYaO2NwEv0PCzDiiSwtBk4h9Z7UeYHGMNKrQwVmgFCHcbVR7kMdjTxknjIs?=
 =?us-ascii?Q?MF3fNS+f685+fCU2aVoOCMsZYXY/zyApELc39EgFR+NrlJoxPryZy0NHyncB?=
 =?us-ascii?Q?8Kc/+/tKF1sviS8w4f8bi9G9RvfWgwsJilt/j7hfrn4/5wLomgz3FIuFqK6k?=
 =?us-ascii?Q?hEHaCTXnFIR4W5upx9a2zvSSgon+Y41+wGvaujEW0Hrg9pT9lB+2AfzreJmJ?=
 =?us-ascii?Q?7gCMVBELy8W6a4VCkkdW4Xq0td8Y8yhiEe0ROB2DtuAb40h3yWMFfe6WTS1l?=
 =?us-ascii?Q?iFNGKwc3hlEl+EjXp1HP3tx4l6P2ng2E32rXmyfoS+DTN/kLlf/zDgQFE8Pe?=
 =?us-ascii?Q?2jrVNTczmfrXbT8QtHaGTG7/d9cndk14FxivC0BQ/RPLELyF6CINkwwuBS48?=
 =?us-ascii?Q?WpnoRIq/WdpVzW8Xam5U38w7cKOT8/90D81FdqX8uBJLEL0Pkr6tr3WYhIMH?=
 =?us-ascii?Q?qCnfXa3dEjCDyQPuyQnTS8+ZH449lg2MCYbRk4NoMH+fXxNMZ/0KXvJym+iO?=
 =?us-ascii?Q?6kLTyVMPmxGDi7fmdrwYxPlBzL9K6URowBGcF88IZZ5gVKGcHfkXSxLF8cUA?=
 =?us-ascii?Q?xCb+tvY220mJ4ZuxLYjpOH/JpSlJlmfU4IlT2jJYJeyBsNE1NwquiCXKLUD/?=
 =?us-ascii?Q?9H4Nlux3iAlIRd3dz8psGJauKuE8AzcYGOtyjZTglgELwtFcX8Rv7UuX2yTf?=
 =?us-ascii?Q?wsAbclSHUKNkIYx+S3RoCZLmN5weLxOBmeNIERMfsB46SKuvUY18qtn+6J+G?=
 =?us-ascii?Q?Zd13ny0HpjjlgZnt7N9glH/jRlpiVLnL8XzjkXNMTRB4WQGx3V9elU5eSxMf?=
 =?us-ascii?Q?BuXkESbuj+6aQQ6TLMe+BtnfUmkcDLjTzdtyn3sNYXaCDhNqvH0ylFLXOueV?=
 =?us-ascii?Q?xAMP5rbpLQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 978b608f-3954-49a9-bd06-08de51f2a0b2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9131.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 15:52:45.4894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4uWNerB5RZH4EXRaPfJCXpg8znqwGTWP2DriQpFMhXUm7yEX5fEecqz76EHc81WaQ34NCzz4qfGEmZpHDYcdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC80959CE8
X-OriginatorOrg: intel.com

Li Ming wrote:
> In __cxl_dpa_reserve(), it will check if the new resource range is
> included in one of paritions of the cxl memory device.
> cxlds->nr_paritions is used to represent how many partitions information
> the cxl memory device has. In the loop, if driver cannot find a
> partition including the new resource range, it will be an infinite loop.
> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")

Technically the bug was introduced in:

Fixes: 991d98f17d31 ("cxl: Make cxl_dpa_alloc() DPA partition number agnostic")

With that,
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
