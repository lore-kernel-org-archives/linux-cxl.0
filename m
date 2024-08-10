Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B946101C4
	for <linux-cxl@vger.kernel.org>; Sat, 10 Aug 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723249118; cv=fail; b=aIU24ZbOsKTtNy31U/Ona3yCyfb9Pyq5IqN7r9mClWPWC8mFTzECSYdDm+1zc8qMRS7Ikzs6niS7EK+ngJpYqGviZYtuhlEsbiQ3Y+tEhfo+1miFtrzVRxglSMLZO9IhfG5kHDy5JJ+zqDnh3cLrAYa8bgbJ9qFLuqJq24klxrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723249118; c=relaxed/simple;
	bh=XnplAqb0tedfrZEvRBGHzOkV0z4rNePqMqN/VS+oBHs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KAlyr0ysF1n2jrGfVSZcRUES4UepaExcRYEVIg6v8FHN4usjm1yt6siQjyUpuVuPC4CkjEGaBIfIP6DWTrMdTVJHfQ5zO1BjVfXWGSjofz1zRZXw9Y1G5SriqyCbdMdSpJELHLBHibJ3z/4TFlUbIVyXZ/PJYTdlSkdhSszp+jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeEEC78l; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeEEC78l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723249116; x=1754785116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XnplAqb0tedfrZEvRBGHzOkV0z4rNePqMqN/VS+oBHs=;
  b=eeEEC78lIQjyGQE1CrXUoXoag+pf2Nct2BNzAbGNhtzk8/QI5Cs53Yi+
   WXfbUNfx6cin1h+TpeHhgiWH+n2aKIDIUAwPKT+q9Aq2gYWaivbAlOGEP
   xq5KU+ja1xHqkb0sfD89H9ZI4ueaUT7APH8ydnRSAHLlLdcGlOReUy65C
   D3BPDjdp1PkGnry0pvwtc1v0mFVUgDum4lMWbyxGuZX4N+QU/kLIGK2to
   YXQVVI00pcLXPXhUBKlnA1K9mISgqmqHop++APSxUSWxSnXrG+cW0eoO0
   h9pJSfZtmPD1mgT4JgOp5dA+yNxkUPtTHNqZYjAZ9ukSSSPuBBBqedC+d
   Q==;
X-CSE-ConnectionGUID: 5gJcGUxxSAm0Gnjftgpsxg==
X-CSE-MsgGUID: aO/ZWKJNR5KmsyFVgOiTUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="24343272"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="24343272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 17:18:35 -0700
X-CSE-ConnectionGUID: mzFz95aIT3ixZnTxJIzU5A==
X-CSE-MsgGUID: KtXJFgqLRZuFzU7uMYwvAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="58429242"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 17:18:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 17:18:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 17:18:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 17:18:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJDWHbwFK+tuHUhp1/+3OCFatsCetG1zlrruOovHFvZniQ4pP95PJ1r1kgteBEpaG/1VTc8ahxFA88J7flgWuApChuvWjDMi0Tcl/qRpOlJpp2z/rAa6mBSiREzwqbsp9BMgV/P0aMbV7vwFMatQfpDMpP5Nof1RYdArvAClduySJRhnUYiQVVl+ZpHko08078YM0K9fA2hNAgW0t+R3XVLhrAofpuVsmSLCj+3rPPJohyZ75/vwpZrOmiINwwDtb/oo1bRZKbQz5Ov7sjgfFEU7M+bqgKoK7EHvnCa27g4HGM/kLck2fKvpo+y9UArOfxZnSg6nAm/ctB50rA5bHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJzzK7A1Z9nNpPyhjRHINQH/YQxnKqwRPYIAF1HOPaQ=;
 b=ld9tOC0SNXtbrnMTbUC4dz2qS03Kenk37hDyzbF//N41uYSmm52vLIgUrqKLbQSr1eGuh94naEJaCEcGaLbj7J5fWajqZiCvFV0xHKhWyRTxUVpjeG4RVHkWYLJ+mBCraVlKJRUW+V3dOSnGTK17Iwtv473GyIr33oyVbVbbjRhm/ZwmjFCkGwnYvbXTYap8wyByeNBWNuCjKlPIaRVpNO87s2Vw+VGHTXUxNlFA4yzdoeoQg7hUUCfD1vBMNucZPxOdCcYgxfHqL3ngPGjbTA1hh4MyKfxSHeCmyx2BmpdsBrIeXA7fsbHoKQi/9QN6wHRXZNU2yCXdf/vzNBvhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6852.namprd11.prod.outlook.com (2603:10b6:806:2a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Sat, 10 Aug
 2024 00:18:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Sat, 10 Aug 2024
 00:18:26 +0000
Date: Fri, 9 Aug 2024 17:18:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: <y-goto@fujitsu.com>, <mj@ucw.cz>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v15 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <66b6b1cfdbfe0_2575294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
 <20240716042540.89639-3-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716042540.89639-3-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:303:dc::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f4092c-fe4b-4349-7925-08dcb8d1f465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ABjOUE5OAJYfQiAwlhVESoneZcCDgjhJ1gzeNYxw8VOsXPGCUATnAU1dt+bV?=
 =?us-ascii?Q?zhVrQNSjjzXQ45zPc59tlEFXOS/kmDCc9vOi8xTBSOPE4A7sjxl3U5sULlER?=
 =?us-ascii?Q?WkpJZnLmYgA0q2ON0tjJrxC1E+7+3Yj1qyPLm5FYkTWvRxdcTz0NcEeSiMIq?=
 =?us-ascii?Q?b7NeyCfedKo6pm0RgBmTXapVj0Ub920p7VebQa7NHVwf+qMfG4x/mT/3Ffvy?=
 =?us-ascii?Q?sknD1AmBUiAD20h+lvn3DmGiob3n12Dg/r+VeebNNgbzmvlizXqOrZfyagmp?=
 =?us-ascii?Q?99lf081ZK1W5Y1Jpy33d9cDsTiUkByGtxnOEny67zlfAUsG+YL5OQF3RsxLM?=
 =?us-ascii?Q?9ljsAc8bdy0Yhase3oVpGfdF5yT3BaXv8QV+R+1wGpPNcm4TGCeb9tdBDKEp?=
 =?us-ascii?Q?RenzBsH57WBIiHRYtuSrbhkTsrm43Nh6GraMSXd5nGB9aXa+S5KWqF2fpnoC?=
 =?us-ascii?Q?uoFWXgrKTWgm18H5JyjyKbayVknGtB3X6KJMudZeIGNShKmh1ZTAQpF6pF9u?=
 =?us-ascii?Q?TUg4FKWtbEgkmKW0lfXhygoAjOkoyYPEqEnr62cstNVqnpsRj2QvhYYB76T9?=
 =?us-ascii?Q?0kLJ6yD2LuL23MFxJfr++Ta+7odlgqJWdIdnD1fykfsdnkFN9hwpNkj3qeEz?=
 =?us-ascii?Q?pnIkn66+r05hEpKRyF7kFNStBLJ3/swoMtl0LIc9hWNE0AvRq1YuVurI5an0?=
 =?us-ascii?Q?0dNrwkRQXkCJxjZ1U921h8jkZnFHNqvqRrLMSF4ksr6Drj645CY5+qFU9zhN?=
 =?us-ascii?Q?Nwxw6J868aPd5MicXQqhIcKtAxzLmVgDcu4nPODkpSfMSMdUhQetnhw9ozoh?=
 =?us-ascii?Q?cHUh306uqjwLXgUxBWEIv98Z29JNnJU0MPVM2PgNkwR6dMIx20jIEzbRYFHd?=
 =?us-ascii?Q?CJvPQjdKvXTWJGL8AQYxAXXZkXd8NvkdRbg31yNd6fym0kZZBHfAqh0fxstP?=
 =?us-ascii?Q?qAqCyMfrUFGNrCO2iFN1th7dG7vOkJ4gvJHvFoJz9NqXN8YLGaz0P9BflNST?=
 =?us-ascii?Q?DTWymvjGNqrDhd5yp90FPrvOEIsqROSKubpgfnJtt7TQA5w+Dgw8h8+EWZeo?=
 =?us-ascii?Q?mp8nfh8uUMOCSILWZoROEEKEO2fJxVqh3p5vP43bFGqLhjjoANLYKYkLr4SE?=
 =?us-ascii?Q?z7ovNignJA7QCNSmjLLx71ocWK6kJPvgqgNVofQN4pBBEmZ5axLlbk8PHe01?=
 =?us-ascii?Q?EYPbgrhpRwZn/iFPyFhsZQHLePIOJRn+OwfNfprZWWzkNsvf8pMFcpYp2Kyp?=
 =?us-ascii?Q?Ou0S7Ef+2M451EgRmjZrD5XXbgTZipl9yP/yDSUxUi5IKWLdh/+uunkyAAwt?=
 =?us-ascii?Q?WBF9EHNcJ0Ml3ndVFFgwxkD9Fb4+1JCUJm6mPZ9x2T8T1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZV+WAeyG2hN/dqUQVFBTfPDTxgZfU7x0/nsNqeM5VVOD/BKtOvVm/ULVl7ib?=
 =?us-ascii?Q?QK+pydlIuUVlKDLcAvmDTAT20IDsqpu7YkolGjGfBQZTLeHc8qL5R3ITWp2W?=
 =?us-ascii?Q?h2ZXZLXh0ZCkDXnLUdspJa7hKzmLcePJCwCqOrWAi2Lkov4CC1TIgCvAMWMC?=
 =?us-ascii?Q?GMwcua39Na+6AcnSynJcSp3lyWYMkPGSDRlxx8jsvhLrpHJ9xJ97UvHjGLyJ?=
 =?us-ascii?Q?m54MoKbYrdtRgugoxmpbMAtXJsI5+YQlbtuxtN95ObP/J+cZDM7vX8UT+n4j?=
 =?us-ascii?Q?U5dM6T+5aZ2YsEoy+O6s7cV51+9hSCjYe2949rL8/NSiXVOObAWvaHjH4YW7?=
 =?us-ascii?Q?UiZFdMHnysUJiRxrUoqzp5HL99CzBbYCZyo1+XL29GYBwHilb4gzQj94z/cA?=
 =?us-ascii?Q?ykUJZ7yMNUGcjD8d8DZpVmkLhYwBMEQVbx6PVItjRBa53CD+Mw/K8klb9fz1?=
 =?us-ascii?Q?nAqRWMTeLELoL0IPTTzpp+fuXa9kcPPZ37goKTrn7g3F0M01ZDUal5WAPinL?=
 =?us-ascii?Q?wAGWhH783pCvzY09S4dp2H8lrPqqbsYM+ZRS51joSZdjUaZi9pJvyqqlH51r?=
 =?us-ascii?Q?7IbY/VK8b9HJrZQprAXaRCcOiTWi3dFfPMW0opSxKLWUsaeh3caw91DbfOSt?=
 =?us-ascii?Q?uzoLIG0UvkbO/QUKpXzrfR4naODNOLnU/0nENe0RUCDaxlhlHbIjWbAcvq6m?=
 =?us-ascii?Q?W8SecpJRdgAHos1SMWLsqSPFiY9b2BJUt1A5LtYhhOKgkLBDQIlkfaVvotCW?=
 =?us-ascii?Q?7wvN2fjMLT3lYgMuliL3Csa/s80PBgl9wqywu9A61y2f6/53EY3az1eQtGqy?=
 =?us-ascii?Q?3n/nktwXfhskPy9Q6Uzf+E3lp5jHg8BgDNfZyYd3GfAfOgmY9eRchNobb13o?=
 =?us-ascii?Q?5D6cccnmN/E94kwe0sXD8bOXJcKOZX0dkxlLrVF5kHz0w83rMB3QIj+mwqRe?=
 =?us-ascii?Q?OOpsqY8vEaZrakX5JcP8ilwjUOAxAIecr/+D9NgFacmmkQ67OLV5ZVDBCAUt?=
 =?us-ascii?Q?DQPa1PiNWyxxredTSTEZyOcaPbkRWu3oqg9Cr9Rmtwxw4/uD/2D+YRbAjCXZ?=
 =?us-ascii?Q?n3/pwptqjo/PBOBRdTqRUsg6fNaAH7tad5P5c+uqzTQ4DVyocflv50726P3c?=
 =?us-ascii?Q?1iHKLF24NhnghEkTCPjovvTAiZqnQlu8VpYuGS9gxepjGQKSnaXTWTVPdZ35?=
 =?us-ascii?Q?Bi+Un69zjExNTvn0BUwEhs/mL+4hFXCO7Nz/29ygdgUHKeoO5q6Fv6Y3dGyE?=
 =?us-ascii?Q?IJZq7wpGhHNX6dmzpunZeMdK43jS9mMLtQp1SvnW4vdJ5ItDtOeOmVwnmEku?=
 =?us-ascii?Q?XDIBDAPVCn/Zjo9jJb+XinCQwO1yXcmnOMPXAPlFG2i0HS7TfEhUmIRrKDib?=
 =?us-ascii?Q?OWuSR4S354nWUSbQ1wTdy3OkcauPlnDLCAH6g2+sIVbgg2+CxHvsPYmdTKy0?=
 =?us-ascii?Q?8t6kCdGx/JorYld2qbWruRq2UXLENbobaw9fL2PU6/BQgvFOkmLB+sXQudy4?=
 =?us-ascii?Q?7KczEO8hlFJt5lbzgwUUq7g0HcVL5n209AiK1uW9v6cmwTQLxe/+jOUzWZGb?=
 =?us-ascii?Q?z7if31mWSclgEbjK4D/guI/uHpEdJaHtRD5ag6nps8BBNinspAjqhEP7SDy0?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f4092c-fe4b-4349-7925-08dcb8d1f465
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 00:18:26.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g64pq/DqhU3irGwlz6VRpXPtppLMP+khKRR1J4nDJsKApWEzD5GmeKJ34xkCE7rSkHyrv4HguNud+df8hFKuoFmMYm+FESLeGJi1miA0Gz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6852
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the
> link status and control registers invisible to existing PCI user tooling.
> 
> Export those registers via sysfs with the expectation that PCI user
> tooling will alternatively look for these sysfs files when attempting to
> access to these CXL 1.1 endpoints registers.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/pci.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5e7e66f28420..c149c04b029e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -795,6 +795,86 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size_t width)
> +{
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *endpoint_parent;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	port = cxl_mem_find_port(cxlmd, &dport);

In order to avoid a memory leak this needs to be declared as:

	struct cxl_port *port __free(put_cxl_port) = cxl_mem_find_port(cxlmd, &dport));

> +	if (!port)
> +		return -EINVAL;

This return code should be ENXIO to represent that the memdev is
disconnected from a CXL port toplogy that connect to the platform root.

> +	endpoint_parent = port->uport_dev;

The @endpoint_parent name only makes sense in cxl_mem_probe() where the
device upstream of the endpoint can either be a CXL downstream switch
port, a downstream port of a CXL hostbridge, or the CXL root object
directly.

I would rename "port"=>"root" and "endpoint_parent"=>"root_dev", because
this is a known RCD topology where the parent of a
root-complex-integrated-endpoint is the ACPI0017 device.

> +	if (!endpoint_parent)
> +		return -ENXIO;

@endpoint_parent is never NULL, the uport_dev field is always populated
in @port instances near where they are allocated so can't be NULL here.

> +	guard(device)(endpoint_parent);
> +	if (!endpoint_parent->driver)
> +		return -ENXIO;
> +
> +	if (dport->regs.rcd_pcie_cap == NULL)
> +		return -EINVAL;

This should never happen because it is mandatory for this rcd_pcie_cap
to be populated for the driver to load. So this check can be deleted.

> +
> +	switch (width) {
> +	case sizeof(u16):

That's an odd way to "2", just use "2" and "4" for the case statements.

> +		return sysfs_emit(buf, "%x\n",
> +				  readw(dport->regs.rcd_pcie_cap + offset));
> +	case sizeof(u32):
> +		return sysfs_emit(buf, "%x\n",
> +				  readl(dport->regs.rcd_pcie_cap + offset));

Make those format strings "%#x\n" so that it is unambiguous that these
are hexadecimal values.

> +	default:
> +		return -EINVAL;
> +	}
> +}
[..]

Rest of the patch looks good to me.
