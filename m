Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36A14F9FB
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 01:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957096; cv=fail; b=kH74Cxayh2SJuPEX3CRcSAjb7rrJRcB6ki4Ttcn+YdVnephLx8JyYK4diI8r6/7kQpm1yHukxxaexfBtezdBdjfTAoXuGS9n8Pyssd2dSH9l8Ot79gCJPG4Evc0fvatYXFvnasnIGUwBC22TxASa6rhHEZGK24ce1TKKZpwFRzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957096; c=relaxed/simple;
	bh=6XDhSk8wP2GWJs8DPcQN0lCJ+z01LMlkXJ/+CGQUk34=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r6ujqqJmk+VcmeJ92doDAOnzRUjD2sO90pAnS6BJU6YnchhjXQ5l6IhjaJoRsB+aqyvntqaXV6XjiWZ+lgGwYyZf/zv47ytqr3ucQ8I4vXpIWfUfl8fb2Wy6r4vrWidnnz3Y0byNCG3+5+c+3HypUdDsMKIZSz2nqWEEPCttXMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESvv4ZV1; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESvv4ZV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728957095; x=1760493095;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6XDhSk8wP2GWJs8DPcQN0lCJ+z01LMlkXJ/+CGQUk34=;
  b=ESvv4ZV1ni+dpESXYdX8B8XNOCJEqrd7WwNLI5DeMKvto1kiJsdbjIVn
   Cu9r3EBaVh2SYh/UEIbNn2/MDm41KblkRGl0h5oGWUPcZjmzo3zR6YDBg
   VpUEl0Uk6NLWorTpka/pT9/JwH4U6jBVZCi89Aeq+P/zc9mE21DlgL4N1
   kySKAsT/aaD3+uVgC/jrp3HqZgtKG+chBb6H44Ivd0APKIKb8eu5a92na
   JgwrYtwaeD/v7TRnbMXJnuFsr1LSAxEe+F72bf3JJIRAk92ssMf1UBrmE
   HXiO5sK6/l+qL00bYnlp37+NOta64F/V3Eb1CpYx+Fo4UBx/rNeH/XSNO
   g==;
X-CSE-ConnectionGUID: gUxOli9WTiad92lylqGFKQ==
X-CSE-MsgGUID: xcLU6hRoT3iv2zhOm2wzJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="15948963"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="15948963"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:51:34 -0700
X-CSE-ConnectionGUID: oTNC48cBTtamNs+z45SgRg==
X-CSE-MsgGUID: yvkK8AZxQ1SIgR4ljmlkZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="78561243"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 18:51:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 18:51:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 18:51:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 18:51:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8U3eexl6OKx2kLqEl7Lncft2KjKu5TPJFsfQTYQiA5qMeZ+N5jpYp7Esw1/fNinplcXwqzvXrQ6idYTz5iw6itgq+A6+W9dCeVHZoiS+OYDGul/aV2vA/C/InYqdRG0Xi0Qo+aZJV0GFLvo+0d23h1vpXOac2ZuOF1IIerVqWNwEMw7170BSP/RGF8l50/sweh9FZrj2cmasfhyRfMrAslyrN+RSaTuCHzYj0f5Agk/eUYP14aDkn0z6Sx++ecQtpI4iLNP/bYXpotIA3lpk+Z0/m6n+VFYcQaMn3c/weIFrdDpKrRczJ6o9VSpdpdOcFmBvT7MEhpQ8YPenXq+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2QdJ3xUfhgzXG2kXEgE7Gauv4CH7PkHLPVzfzL0pg4=;
 b=kJikO4Bt6dwXh1Yy5G4h+B0ETtksLNBRGy8B87eh/5h243YBKoM95J6vRHRHS9yaYb4eqd5Fa17itF/YpEEJu8jPoXKKRBPNBaKOMY1faIw85tuLXPauGvgRagdsZd0Y6uXROBUqe6oKVj39fUpy+fffoaP6144Rrw5rS2SI5SP5gUObli2pBUP1JsHTnnOTLzbHG02uheiMqvI4dwxtKBchqLqcN2QLelfqwkQ8PWoAfZFj/KeBqc0Ta+K10GD7IgD89xz00bL4DPwVLgyZY+OGESOhsA7Fz/SjYz4z6fxFdCukW+dFxbzvqDnSG9XR2ttH2J4bUg4SDrN70UdaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 01:51:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 01:51:30 +0000
Date: Mon, 14 Oct 2024 18:51:27 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Dan Williams <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Vishal Verma
	<vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/port: Prevent out-of-order decoder allocation
Message-ID: <670dca9fe448f_3ee229436@dwillia2-xfh.jf.intel.com.notmuch>
References: <172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com>
 <34f9ecb4-e3a3-496b-91f9-12428045d054@icloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34f9ecb4-e3a3-496b-91f9-12428045d054@icloud.com>
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 27900217-8943-4a3b-7e66-08dcecbbe3a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V8uy6CVvq3nbHfsV2LrUb3jMlHQ32CSY/HhxrsecNTnofHC8jX9uunDZTPHh?=
 =?us-ascii?Q?JdApKYKwUtTFlYLbWmBR7Zc6Z8Vrli+DboUyErccb8FpEg06TlUMjsmrXgru?=
 =?us-ascii?Q?GeBcAh7QXLZBx7HlzkTsdCxD39lGUcNoTqEWgHHWPk46Y5dvUsl+bb+Je7W+?=
 =?us-ascii?Q?TvajgUFgomu8Q23UAA1/Fnyef4m2v6KxfjGwzSJLLu9FizEkXjbiOK/6OAUe?=
 =?us-ascii?Q?LhmbSk+O9Q8MQLl8LcdUmIp94DQBqcDMa6QsL5o2Cq34TlHVkmIZFOa5OEL0?=
 =?us-ascii?Q?KYySOAfLFaBRtM3MzDgel5bs18vE7oK2R6fUh8Rc+sC/IIh0Ucj30tmtoY1T?=
 =?us-ascii?Q?WgO28qTYV48fGiTWqgFdpiNXerAh57vZ/ThBCYlmibWo+zJUgm20NZpBcPkV?=
 =?us-ascii?Q?3g5OA0qgJbNjFaN9dapmG9/DGQSBaRF51vLtDA7011pZlvFJzyoT5yB5uE5X?=
 =?us-ascii?Q?t5CZhPO6igvKMMMgApWzaX9uodkIyOJXlob2EixldNLLMEI/wmLIClXADQqD?=
 =?us-ascii?Q?dWckHKcJz9J0uX72CCZCuK/aHRtPiGhV36e5kzNO5V4LoyGRbFuBZFQfLaNk?=
 =?us-ascii?Q?H/sMXHtoGB4ew13ijBAG8/n4exQftopM6vSFe9rfkxFBiH37YPuiPM2cvwh2?=
 =?us-ascii?Q?UIKnCzKWq7PKk/Fx5iGCiMYMmTNXJ3UYrBCPFVqYr2tVdvT6V70KOV/NOM/4?=
 =?us-ascii?Q?eZ9Q/Hr8SprMmASfLrEjTx2dVr7Dnx+cyc/dvlWZVyu/eRzZ0vrHbgYypFSo?=
 =?us-ascii?Q?4D+g20BH5NMLbP4SCFnHD1g6K0F0sob1+N4O30OmX9DnXQH5G676kQy+CcCv?=
 =?us-ascii?Q?ryOYojb0iYOB+6lQNLvnTARsHF9zETjqg9A2UaHWvbVJckENQArzebt+Wycm?=
 =?us-ascii?Q?IYWKdMDnyn5WKfkwnC7KtyUqj75wGFtrNSckUqCzZkA50p3Z5wBy1l3pduqL?=
 =?us-ascii?Q?Dr2I5NNCtCkbV2OlXF2L5PUjHh2vfEZ37d8eJiweFI7dyFB97+phJTW/4br+?=
 =?us-ascii?Q?/D3T91TOlccRLHhWPILBvb/oAa3ddQiQfFP09HCMPNseCw3b/AxL+OkfgCvH?=
 =?us-ascii?Q?Zq9HTeSBad+SVwfbr2JvDva817RDYHOJV4m/uA8mGifX6z7fX4BjD6vUkpXY?=
 =?us-ascii?Q?T7JKdEdo3OkZpsIalhZTdj7rGE2Hl+zgNEMogyml1uQwNG7M0HFPYUa/xk8r?=
 =?us-ascii?Q?NIPOXKdp97TnjpvW1SCkuF3VX/hQsDWuuluwUEYy4d25PCRWLRLVyHirpHdd?=
 =?us-ascii?Q?6jauIYJkEpSIl433IKNav4IpmJxB8HqlubOaNZ3qL13rX/TFXMBjSrd26vOd?=
 =?us-ascii?Q?fPU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0kC2T4yPqinQ87w8mECfQtZSMfk9QMwRVTpf1YSzrgCzu74VyTmiUoAgV9e?=
 =?us-ascii?Q?bkj42spYkZdIffT+wV7BLbieW6RLAg2bRUP2h0FWhHeJihMZGzI7Ns775hUn?=
 =?us-ascii?Q?zqc7582aq9nXp7UugzjIUZLz8/QGljfKr4r/Wc5oJwpjdvcwu10WKOys29fD?=
 =?us-ascii?Q?WqhQ4iDdjL7IlwetMEZBUenMzWxUOF+PJ4qt7zAhpdUt2UEeRw4hqj6e/gEC?=
 =?us-ascii?Q?7wEqyWp+Wz2DdrkXVW+ju7CjEVq5vD+MxlZZgxfptK0td7OwWJwGkanns6JB?=
 =?us-ascii?Q?ZbLRxSY33h/KFVH5nGVZj/gANVc7sFqOBl/Y2klTiNBx/zbXJLCGoRuozY/B?=
 =?us-ascii?Q?7sTh3hBYsDPq38f98Scdh1T7kACqEjYUQafWofNoJZlqpIqxDMb7FPpNHWjs?=
 =?us-ascii?Q?Hhtg9Nk96haHetMu8oUy09GdXfyngm2kbFwLJyvwug8EoD5yxVU2R5AJEtk1?=
 =?us-ascii?Q?Bknn7TLYk+1O+MdlqwoShseQAYQ2xOlUgCKGUHNXM/fHAOUM6uBe3Zwe/ZFN?=
 =?us-ascii?Q?eCgUgD2MgxbpUIl0atLunGJbaM6li2ivt2rPyCyKKnAyI6SAL/OvYenP1sW5?=
 =?us-ascii?Q?aEvBggDP1hWq7Hi0MXbbVSrOcuKteZMVi6JCYDqGu7rFB7bhjAoYCi1s+dla?=
 =?us-ascii?Q?kngIB7I/vzxpc3nrBiEuGtF3UXx5HRmxoHOQ5RSTRoyjr8a0DbqmTMiEH07W?=
 =?us-ascii?Q?rys3/tqOiIN4EpH2QlDohE2xHDKjb6dBrnES4b3k7UWQnve01A1QDESszh5u?=
 =?us-ascii?Q?K62iFwoFvbEdEzUTiuIHlWVvREPetP3IS3gdiRGPib6UPq4Z2X4W/fyj935U?=
 =?us-ascii?Q?Phcaf4aufkoyR1TGkGMPF4G+6+hDYz5xcEG0iJvO6jAIHxE7Q6Krb1BZh6SM?=
 =?us-ascii?Q?y+3TsR2a890Jzp5ib0Mo2KGhZJFz7eXhUqsgHIJPpXKDxP9qE7FiD1uuPmCy?=
 =?us-ascii?Q?cG32/HB1mAbSAz5oZX0RJU3DtokTEeAnD6760HNDunfJwV/JkeTZFxKk7Amg?=
 =?us-ascii?Q?rgJkws8ig3xqz9JmMkx8+AxefCPtqZYaze7VyoSlbcEzkCo1q67swPljk1BW?=
 =?us-ascii?Q?sUiu049Ksvdfr49txc5GgZz+f9Z5vQ5QMq1PtyCcmhQbsHDPBde6HgxE4SIJ?=
 =?us-ascii?Q?53DD1bXqs/lj28JRuEZ9YU21rylvjVVBSAi7IKfrPpP9ChVwxCDHTBR0P62k?=
 =?us-ascii?Q?HOwbpcqsvdceV6PQIN56l4wvO6JMitYbcJH2GgMSPmawlkV47PbTQFRNvpU7?=
 =?us-ascii?Q?V5PjoDV9RI+P44VpCGelwYpegoN+dO/EkjnqXDUrX+3e1ztQF4HQiHL9vUCy?=
 =?us-ascii?Q?WjOEPX+PLMKUHZXksTabTtX5oSgH7NwNTStokwWvcqw0/KQ+RJ87qRKVz/he?=
 =?us-ascii?Q?uJEfFxKEHlcX0CcHZL8R41NrkQTJ/R6LZ0SdgR3lJlljEfriTafzMcm/ZhB9?=
 =?us-ascii?Q?FdoE+r64rGmBZhWyGa96XSxU1odblRHpUu/G0zSVyaz1Ld8t9imiJaktkS4x?=
 =?us-ascii?Q?BaIEM3JDc7EFlGyYfxTs8pOAfJxf+qn/wUVGWBRneT0mgcgS9N/CVhJT7/nY?=
 =?us-ascii?Q?I8RG8cIbwgirBW2jK47Y/qC/lAYoP3OGLdhriHHE866toTbHQ8fohChxx7lk?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27900217-8943-4a3b-7e66-08dcecbbe3a1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 01:51:30.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fae4IAQeDgNxx8q89GKZxuWmLDPsd4DsYSgRwJsQoCid+Nh510EgGWQ/N+2AqWl0o5bOkTDGOM3LeiCGyytvUpOKQVJrgLBXNt6g9UJr758=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7779
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> On 2024/10/15 08:06, Dan Williams wrote:
> > With the recent change to allow out-of-order decoder de-commit it
> > highlights a need to strengthen the in-order decoder commit guarantees.
> > As it stands match_free_decoder() ensures that if 2 regions are racing
> > decoder allocations the one that wins the race will get the lower id
> > decoder, but that still leaves the race to *commit* the decoder.
> > 
> > Rather than have this complicated case of "reserved in-order, but may
> > still commit out-of-order", just arrange for the reservation order to
> > match the commit-order. In other words, prevent subsequent allocations
> > until the last reservation is committed.
> > 
> > This precludes overlapping region creation events and requires the
> > previous regionN to either move forward to the decoder commit stage or
> > drop its reservation before regionN+1 can move forward. That is,
> > provided that regionN and regionN+1 decode through the same switch port.
> > 
> > As a side effect this allows match_free_decoder() to drop its dependency
> > on needing write access to the device_find_child() @data parameter [1].
> > 
> > Reported-by: Zijun Hu <zijun_hu@icloud.com>
> > Closes: http://lore.kernel.org/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com [1]
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > This patch is incremental to "cxl: Initialization and shutdown fixes"
> > 
> > [2]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
> > 
> >  drivers/cxl/core/region.c |   43 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 33 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 3478d2058303..dff618c708dc 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
[..]
> 
> Above checking seems meaningless since there are only one CLDX with ID
> port->commit_end + 1.
> 
> logical of below my proposal maybe what you want.
> https://lore.kernel.org/all/4239bfd4-d5fe-4ac8-a087-9e1584765e61@icloud.com/

No. Consider that port->commit_end + 1 may walk off the end of available
decoders.
