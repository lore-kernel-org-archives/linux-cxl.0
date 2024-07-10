Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DAC1802B
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jul 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578973; cv=fail; b=u8YdHjpqjWK9ztDXJizwbbmEPlFNclNmNKOVIc3w15+Gx3/ihnQc9H0BHvgQOodD3aJe4I/rERfBs7BcI7X9sIySn0OXbEPEE9qlfQIxNSjVmfgH1BnD3d/YQ2zikdcGm8qqNMAecqcUkjnevpVCjWSe2lZTlLy5qSspimVaSQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578973; c=relaxed/simple;
	bh=NRy+ftZS+5dfG6Au1BCG8ic9wsfYlj16nhA7JDqjR/8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P2hPSZgEUfMQeFlGRjWi7BYntP9vP7qnI/DRWjVX24L09OgzEozpDvBW3Gn7/Zr6MG/eY1uOlvbHDjFpv8CyPyxIVTR66+lnt/ZmWWFv5b27aT28VRPrzj9ZRUZNAv6h+g+tEadtPUiVVD3c+ZimhWGVyD6nCP4o+0TDnezO9ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5Tq3Ld2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5Tq3Ld2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720578972; x=1752114972;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NRy+ftZS+5dfG6Au1BCG8ic9wsfYlj16nhA7JDqjR/8=;
  b=B5Tq3Ld2auaPUqOiTtueC44n/M2/VzYIQKTFrtqh8/a8zTKSXTrFPg52
   odeaiDf+aJit3deiBWWBsn+H5TGa8jfIhaM58zKKXTMHLLmn/QilgCZB1
   1WU0lwkMgaCHc76FdWZHwwkVf+X2forLCoWN62kB0BEm+z/IWNzIKSSXj
   ECTe+09sjEIRL94pq6DWsKvT9kvFCbBBFgz4y/9XqPpN52ZXl5YW5EioH
   wXHd8/a7b5zgIo/5uimr9vYdRlGUFmJBrSWS/ajnGpLx6B9e/mSLl9t0P
   JVJ4crXK/cXG5ath8slj7AMHgtgMF+woxjKtNxVwFcDdSIFbdk9QXdxvt
   g==;
X-CSE-ConnectionGUID: WfS9J9ZcQeuHbxCZMyX7rg==
X-CSE-MsgGUID: DiWtX199Qs2rZ62x+Aoq2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17740133"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="17740133"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 19:36:10 -0700
X-CSE-ConnectionGUID: 9SwkBEPMTNO97KcATptpPw==
X-CSE-MsgGUID: 9YhWWyNwR7Sw/zrYYo37bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; 
   d="scan'208";a="48055702"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 19:36:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 19:36:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 19:36:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 19:36:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 19:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZsMD+Q/ip/4wjTw+K0rduYmg0vlAt0R6tNOa1Q1CWPdQLCgKtv3RwOUp/0FFE3YCzrp3+WhAi8j5jw3mx/+hSM1HL2r9GS2FZvMAodk8bTkKoBKKlrVICtzxG1+ldJ3a6ZZt/fR0jz2n97Q8Ole3I/35nkFNl79x9FXkITtKB/PaMy691zjbU+lq1lrkysOGaY+WMyzgLh8YkpqtZU2cqNMODi9KWcsDQ1kp2SYGw8okLV0BLvApYLUS1vgR0xmatH9kHMdSFDfs6e7m3qMch81Ot8FvVbxRwNDtDAJpWjLEXkrq6hDpdq5Go0P/bKooGNjhIVw+YWj/ESGBXOB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdejiyuRAQ10RgUHOhDSCN6EbnikD4dJQtisGj9MaE0=;
 b=Bl0nQByCi82ojJHBwUcLaWKm3+YR8Toe4h6nJE0z+SXHeiqln9gZX19Gn8EtrpcAp1xZupYDnIgoLLHfvdx14JNxmKTtUQCfjxAWPLSMGZwNlimZzutC37mjE43aQ1QVpJJco4t5eNntHImRASJOMKqxX2LP+UBl3GDoec0JMH9bUG5rI3GnUexZcMRUSNQlU1M29Nk7T/dsg3Au3xZaWD2+3YiE6iWsVtHGwaO+qqOhjVuDmDaBHF72OlLz1w8+ji340ycr+Ww1pk7DUPtBMi5VjAi5HW7+Uk84iM2KPD2m+psO8d9E84EUeSTd/Pr73yV/awsr/p4eEkl79GKrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7906.namprd11.prod.outlook.com (2603:10b6:8:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 02:36:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Wed, 10 Jul 2024
 02:36:05 +0000
Date: Tue, 9 Jul 2024 19:36:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	<kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>
Subject: Re: [PATCH v14 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <668df392f2036_102cc2949a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
 <20240618042941.96893-2-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618042941.96893-2-kobayashi.da-06@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e8291e-f245-4f2f-c923-08dca0890bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nfBtYopGcBd7jb21uxbYceGFk0xB+DT9lMgMfueLb2NvYho6c0SjvI2t+EZP?=
 =?us-ascii?Q?moO/19HjOITNBQtdmLb7ywHh8B4kjJFsEAsik1LBB/To6m9QZyXGWRsoCCI9?=
 =?us-ascii?Q?y/03u5UbPCrH7EjtsSaFMCka1KCLQ18wNL0R9m+xM2ZEeFIz4wxieDmP2wWf?=
 =?us-ascii?Q?lWOzOmq/Dc+NgjsLnpzqWGf1EZC83cF2As+l7p+HShJJDvhXzgH1BVR4VItc?=
 =?us-ascii?Q?c6A2hAVD1KEfaDgFCDM985ADNMDgenisrsJamd/o3UuTB1V4QcjKDSRDfRej?=
 =?us-ascii?Q?IR8qeYUtCJrkMqj/zgd/KtE6W6y0NAjPmH/V9ZJQ8xvjBDbBguFTzA3BWQb8?=
 =?us-ascii?Q?VLGDrwoji47JTwx0S6JuTctnghridJSYYCYqb512o6/KJ3qTgznNSnKRdcM8?=
 =?us-ascii?Q?w9jUpNivQ7lzNmUv9cJzWfiM8wJa1HvUJmKmO0N3OLkchKp7F88oEM2WCfd0?=
 =?us-ascii?Q?lFTRNhthjNvEFkKf7dYb17w3oxK6FVifdcZ6Fja5u4aAlLWmM2yIdjUXq25u?=
 =?us-ascii?Q?lIOLaUZUa4BwVTbNUSQcNCnfJ3ZjxOp8Rsb0BIhF2yOCCAy232H/BNY/Q4oP?=
 =?us-ascii?Q?g1KEJCj00vr0xGNAXwHf/axZnOuwjq5MIdEdIIPBpgRkbFTtikLSS0sSvonV?=
 =?us-ascii?Q?pHjVi4NHPeXHAo/vO/juQQgC9bNDkNQLZUmI9dqQ65Heg822xrcWXCvSPLrN?=
 =?us-ascii?Q?ilzewLsRz7a+fgWIEteHTcnVtM50Qx8xHmXkygDc/X3G+Ii2BzXc3Wu9XDE+?=
 =?us-ascii?Q?Bi3nSeIiYISPhZlraNEMjnWBdL/AUIQ7iH6Km4wx0BuZ6UcWSc2Ezai0M7BR?=
 =?us-ascii?Q?suNmC9vGBS3VFzprKqfJLhS6sCIUBD5lF61e+jEfdEeXHNLB0Sb8yFFpVzVt?=
 =?us-ascii?Q?Z4zOxyFpihJHKkVpF1m2Rjv0sob8YA2UU4i+aMDaOivEe9PGQosJkAkQrjpV?=
 =?us-ascii?Q?y3p0JNdQam3YTG4qnxPSQ/7+2w4V+iIINtvzrpmVhU81zndlCVFT1lHChboj?=
 =?us-ascii?Q?I3CJkmnoQawOa/EgyEx/9j7yPKNVOWDfSD709wKHM45FxujXIdD3Ej8nLGsh?=
 =?us-ascii?Q?HmmofatehI5bsBWcgzRLUHl5jClYvk3mXN8jfshfWkiAGCjgHvvqEUVjfE2G?=
 =?us-ascii?Q?OSaWCOx6h0Ru8IMHNIciGDWodD9faL4XEZkH14vh02ITQWpwBT6bXlvaRfJ3?=
 =?us-ascii?Q?aaL/dY8+EqcLBPsW1rJanWLO+s97mQ4hw5TIdkVCn8d4eE5JcSY0mn+TUqcv?=
 =?us-ascii?Q?yHrT6wnmFl4mnB9iexOSpzWATveAcP2g5A2CxT9OyNCznIgr3Lj7/96kQpCR?=
 =?us-ascii?Q?e8SyIZdVA9JNQ5ldmjJSlVd0euz2AZVCl9DzmAtDhXaWiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pTZZzAO2BcnHQmW6gzPpyaS0sXY+ZEP/0MijgQw7TJlQPntCpoxPV4aRUSf5?=
 =?us-ascii?Q?+J41KutPbMlCO+v5Ns302apl+gAzM/yvuJNEQ9AJk8hGVrf1YNGhWLScocgz?=
 =?us-ascii?Q?Gv469lYdlpXqFxL0i8v5pfdYqnPZKXwPvdl9Wa707PtZW+ilzwtc13UtVAm0?=
 =?us-ascii?Q?NzzCTErGsaSfMdHGBKEz5dgiDqRClJOmiG1KCB99f7U1HXVNSddibg6yZwD6?=
 =?us-ascii?Q?TF7uy3DE9r1Izvm9nR2nXYpuoO+YgxOBML5NwMh7dWQNRNgWCOz3CfKAWtIn?=
 =?us-ascii?Q?GL3DOB70uHEvp9apJYc4Y0tR1OmovZtBUayzk1MXuZZd3vTQ3REqO1UlUWMQ?=
 =?us-ascii?Q?WHIScHIzT3MViyW8FjU7Rh/sMdCki268erVvvklicPktSxP/WBFbVeGN1bEG?=
 =?us-ascii?Q?J5jxRdvr5FD9NKW/lyMkhO2S2lZKzom1DRsX3h82EoCGcNygzKrDFbSuErFr?=
 =?us-ascii?Q?VNg+AtVChwV0vYPTWycU4iGwhr7rTPveIqwHfBYKvtrpYbi+6T8tAVc4p3/1?=
 =?us-ascii?Q?M7pOZuSCXnkqqNvCkEREC3zh/Kb1mGTqy2VofcBIDSDBg4omXuOo845oy/Ba?=
 =?us-ascii?Q?bMldBdD91yYH1Pc2PNL//QzTR+u2vjzdx0yRyhaK0scSiwnN4QMBxs0MIVKp?=
 =?us-ascii?Q?qXkOH1k7JC5EK9/Lcp4KnOe4YdQEIuWgWOzM5DuSetDIGsNNUxJTg0hsS9Yp?=
 =?us-ascii?Q?JgJDivFLDzmvT6CGBpnhts9H2JrevpfA+E6uG6z6uVG/dqN8EuuC8y9XaDyP?=
 =?us-ascii?Q?YwgRU/v7JEYN685iWoyf/wrzoFNbYIUV50H8GELRmI1tROrpZrW3mYaWT1Fo?=
 =?us-ascii?Q?zS+GTfQdnYBs/2Q06prekT95xOKGHmtIS1BsfegN55qPGg0k74KYkOO+hhpZ?=
 =?us-ascii?Q?slUqrXuFMkivg8Mmtq8U3ev0tKZYsdq7hcYl9w7k0hQBGhx8/SeEx6G6gXBe?=
 =?us-ascii?Q?r23h0WtQdHYqQa7Nf2ryZ+ifnxUZSb2aeb/Tz9oVwGiQZy78YhTODEZlcA+E?=
 =?us-ascii?Q?X1lIByPe2sG9U41lzgVdMLymG6kHNgSgFU9Z41MYX+d1piCwAxEMANrFv0HF?=
 =?us-ascii?Q?nVh2iRgF1Ozj5R8rqjIoME20wFT4I182zdJ/34vbjVkW0VJ7yj9QhlLsEQ23?=
 =?us-ascii?Q?liKTzfwR820vrBN0s4Tcswb643Q8fMMrbndlLYBScRf/vHKxr2GLbFlDEtv7?=
 =?us-ascii?Q?zuD8u6K12TfcAgZoqJQ5KPjvPzjYkqyvxw3EuCDcp/ghpjOsNIeYlmPMuCE6?=
 =?us-ascii?Q?RgWWHrZLWYJQjA1mDgJT5lQAMMyTKgTsm8BZqwLvGG6ESqkYqvBVic9RcE4U?=
 =?us-ascii?Q?r84sF7ACbYJ5vXlHtGb6Xrs0enGRL/GXSLuVwIsEopw9rsejIBD16V7i82GB?=
 =?us-ascii?Q?oxKDQHhJzSLfFpbbjmP6iBAf/1yySyQ/K89B2XZ4HLBG/6IsUdjBfkaCQtnV?=
 =?us-ascii?Q?zLel21jzWcXujSPQXvOsVp+DBznQOk43a49F/hiM5qaRA4cERq0yF3HGVJP7?=
 =?us-ascii?Q?MGd1T1VNtn0XPV1xzfeO3ug9+Qlrrlc+EggkxJEpnY240NEhNP/rhKdw2TX1?=
 =?us-ascii?Q?tCrEVxhLBeloXidJ+irfVITzSh2rDYm0EbKLpg0TNJLWTA3l/yZ1rsUCJBW9?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e8291e-f245-4f2f-c923-08dca0890bff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 02:36:05.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLKKEDXirGn2fhB6jc4eq4i0u7ROEQ+xZeLHM6ZX44Qhmw8eZoXKJsupDdPDVqpSNLx3Eu7MDLbGdUbvUpBSPO3EFPbLrkajEMBRiAPIlwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7906
X-OriginatorOrg: intel.com

Kobayashi,Daisuke wrote:
> Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
> device link status information. By caching it, avoid the walking 
> memory map area to find the offset when output the register value.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/core/core.h |  6 ++++
>  drivers/cxl/core/regs.c | 61 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  9 ++++++
>  drivers/cxl/pci.c       |  8 ++++--
>  4 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..69006bde7ad5 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -74,6 +74,12 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which);
>  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport);

Why is this function public? If it only has a caller within regs.c it
can be marked static.

> +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> +#define PCI_CAP_EXP_SIZEOF		0x3c
>  
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..8a7cef1cf87d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -505,6 +505,67 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  	return offset;
>  }
>  
> +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
> +{
> +	resource_size_t rcrb = dport->rcrb.base;
> +	void __iomem *addr;
> +	u32 cap_hdr;
> +	u16 offset;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> +		return CXL_RESOURCE_NONE;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr) {
> +		dev_err(dev, "Failed to map region %pr\n", addr);
> +		release_mem_region(rcrb, SZ_4K);
> +		return CXL_RESOURCE_NONE;
> +	}
> +
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
> +	cap_hdr = readl(addr + offset);
> +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
> +		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0 || offset > SZ_4K) {
> +			offset = 0;
> +			break;
> +		}
> +		cap_hdr = readl(addr + offset);

I would feel better if this duplicated __pci_find_next_cap_ttl() as
__rcrb_find_next_cap_ttl() and built an rcrb_find_capability() helper on
top of that.

> +	}
> +
> +	iounmap(addr);
> +	release_mem_region(rcrb, SZ_4K);
> +	if (!offset)
> +		return CXL_RESOURCE_NONE;
> +
> +	return offset;
> +}
> +
> +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev)
> +{
> +	void __iomem *dport_pcie_cap = NULL;
> +	resource_size_t rcd_pcie_offset;
> +	struct cxl_rcrb_info *ri;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	port = cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return -EPROBE_DEFER;

There is a missing put_device() for this find. It also seems silly to
find the port again after already finding it for
cxl_rcrb_get_comp_regs().

> +
> +	ri = &dport->rcrb;
> +	rcd_pcie_offset = cxl_rcrb_to_linkcap(&pdev->dev, dport);
> +	if (rcd_pcie_offset > 0)

This looks broken if cxl_rcrb_to_linkcap() returns CXL_RESOURCE_NONE.

Also, lets s/rcd_pcie_offset/pos/ since @pos is already the common
variable name for tracking PCI config register offsets.

> +		dport_pcie_cap = devm_cxl_iomap_block(&pdev->dev,
> +						      ri->base + rcd_pcie_offset,
> +						      PCI_CAP_EXP_SIZEOF);
> +
> +	dport->regs.rcd_pcie_cap = dport_pcie_cap;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_map_rcd_linkcap, CXL);
> +
>  resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..7e37ad6d84d6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -230,6 +230,14 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_rch_regs, rch_regs,
>  		void __iomem *dport_aer;
>  	);
> +
> +	/*
> +	 * RCD upstream port specific PCIe cap register
> +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> +		void __iomem *rcd_pcie_cap;
> +	);
>  };
>  
>  struct cxl_reg_map {
> @@ -299,6 +307,7 @@ int cxl_setup_regs(struct cxl_register_map *map);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> +int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev);
>  
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..bbc55732d6c1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -512,11 +512,15 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	 * is an RCH and try to extract the Component Registers from
>  	 * an RCRB.
>  	 */
> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>  		rc = cxl_rcrb_get_comp_regs(pdev, map);
> +		if (rc)
> +			return rc;
>  
> -	if (rc)
> +		cxl_dport_map_rcd_linkcap(pdev);

There is a chance that the port gets removed between finding it for
cxl_rcrb_get_comp_regs() and finding it again for
cxl_dport_map_rcd_linkcap(), so this misses the need to return
EPROBE_DEFER if that latter race is lost. However, is also a chance that
race can be lost *internal* to cxl_rcrb_get_comp_regs().

The only guarantee of cxl_pci_find_port() is that it returns a 'struct
cxl_port' instance that will not be freed until put_device(&port->dev),
but it makes no guarantee that the dport information is stable over that
lifetime. I think this needs a leading fix patch that finds and locks
the port and then passes that port to cxl_rcrb_get_comp_regs() and
cxl_dport_map_rcd_linkcap().

Otherwise I think you could crash the kernel with a test that repeatedly
reloads the cxl_acpi module while also reloading cxl_pci.

Ugh, I was going to say copy what cxl_mem_probe() does around locking
endpoint_parent before attaching further ports, but that also appears to
not handle the same race. I.e. I think cxl_mem_probe() needs a fix to do
this as well. I will copy you on a proposed patch for that.
