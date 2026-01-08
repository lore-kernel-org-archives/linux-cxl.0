Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948392EBDD9;
	Thu,  8 Jan 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895638; cv=fail; b=HWpUo0X886Kld8hYrxeHRXzVhNvtbyXveS0Udx4zaNc5hHs54BLUJYGmvKGc03qf/PRhaAKbjZZt24naeSYSG/OGXaURkYG883SjCU5tig6Gr6CbTtX3W7VeQHslje+2/FMfWK6380/8p+xAfcBFKizJXGo/GxIoOSTtVkV2FP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895638; c=relaxed/simple;
	bh=md3puLw8S9ahGIlAFsowrQal6GQVXSQlGQSIsbRx3Eo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bGdaqa7a3uf1EGueQNW+qMwodhOwmGR/9le+z/Dx9umymsExXzQ8y6bNgjPq5SFJx/ozMIhAF5gDttHgwvGzkdXCeKwBcV8btQO8YJj8cvw78grP5s/yFOiErIWS3Z0gtrkwlwMaDP5ulz+nWu1saaToawNfpB6oDi4Gh/ofCNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLsqZvW6; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLsqZvW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767895636; x=1799431636;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=md3puLw8S9ahGIlAFsowrQal6GQVXSQlGQSIsbRx3Eo=;
  b=RLsqZvW6wkQxzYjmYH3OuYCe+TyfjEuPadZtU61e8T7I0u6lDrPFGIKX
   y+/YhIseoh1iuXTgSmuX0AHncilVp63r81Ugz1DjdHaE4brPCnXgyUo/I
   X9pDEvJyX2vu+oLe0ON+9l5+wrSWQa86xQG0l9eGSqhpkukZZA+hDR/fX
   dJZ51twMpJUnHy4C5U2gpI9uZ/G8q9dquYxaMNoDNyYz03YB68szhgjEQ
   cXtwenCBpacmgEFHz8TdmpXon1saxWYU187KJFTizVxYnRFjbTGNB7pDe
   R4RQm0Dnaev5QfTakAYBACeJ57ELO/dj+ol3iMsIi1CfTgTFBSzL+v8a5
   g==;
X-CSE-ConnectionGUID: P1WzBn9JTOifl3oBk0Nlbg==
X-CSE-MsgGUID: UFkMZHmDTc2vyqsHY72pFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69353923"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69353923"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 10:07:16 -0800
X-CSE-ConnectionGUID: ShNA5I/IQ8mZF6ahyo30Cw==
X-CSE-MsgGUID: AWI8Dx4+QfKQruhNuOXA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207404377"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 10:07:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 10:07:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 8 Jan 2026 10:07:15 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 8 Jan 2026 10:07:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqqPBdMCtpeqzhAwuUPFhPn1j9S70IdOEzCaLbmlLOyA0pJ4plUL1+gedxRCoAOqvHAgLpU6mgm8KqbwCPLTGWucMubv/iWga/fP33+MGUul3T+OrqRYGa4vBN4+9p6tBVw3KvT9cv/qRUXLdksbCd4WGM0Q0UzKR2oX4Pf2etiz1n2zYJwc2v7kQ7krcJvnyFUwODUYzGvdr5v6bbnbojLtiFAKJGUzfGcb1rXFRlfcFXSuRkQnj3gRwyePEWlimxZVUd5D138fuX5GNQlAODxH8a+H9ZzFYODycSbvc5LHgmSuTLaUnbzqZ7fo0RMid42Kx6st8ODyvBI6fr4+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMGlSNn/fUaajix+NGKdIiARP+n2lIJDCN4cpVC8I6c=;
 b=clP8zRi2h03k5dELi5Lls28qMBe7Z2LW3el0ag55apr/jRmvGMbANPHrc9Rfnb8FE3qRdeqH0W44KiLVg9lwIbM+aC8dVIApZY+oerFzQozD/kw32f7tCsqrDIZBi1xupOItLxPfMbfFAG1WXlaKDH6IsUEvtl9W1V3DSCgclLZKx867SNYUInZqMBZIcIbBinLrLyYTKTtbnuCvKXu1V5swREwahp55ssrNlAKg2aAL804rp66jf1jlS2UsgzsGjZCudMIYGqXj88YOADlSco+336S2zYGwCVSQylE57KO/0Zz8jHgBtukUKLu4c4BrUTeVXbsZSYV3oCIp+4SB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 18:07:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 18:07:12 +0000
Date: Thu, 8 Jan 2026 10:07:06 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <aV_ySgCVvEjLoxZ2@aschofie-mobl2.lan>
References: <20260106172358.350724-1-rrichter@amd.com>
 <aV1XnLrAiONbeA_X@aschofie-mobl2.lan>
 <aV5LdGD8lQm7AYK3@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aV5LdGD8lQm7AYK3@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV8PR11MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0b9d86-2501-4e35-ce55-08de4ee0bf7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iiXclUqclW6KpqX6YW28+e/ngjqhuIg9fa1CeWR8CBaJKPTmd8QCi97dR3p2?=
 =?us-ascii?Q?MpIGIFhWShX9bGkKoCyL+hudPW+s9IOI7GB4ook8wPlMTADu89fVmIyEL7Z0?=
 =?us-ascii?Q?mvZw1Aa2cXmWFrheTvYs5Neyiz7dQ/P8dqTwuXsHqIl7bs1koMOZIr/qwFBf?=
 =?us-ascii?Q?/Swq6dTx6z6Z8e6tvijUUHRd+eF3FqSlTJKwBh3mIFRt1uEV+y6n0VSLOabj?=
 =?us-ascii?Q?d2SknC3L+Wt0U2lbFIqJSko6O7HcuX62ng8gIFMYIH6egVG4SpCzoD4nUTD4?=
 =?us-ascii?Q?YaRGDNEHz1NW635TmB6E/3xagVMX6ey52y509SwuhN8rcnerKb6F/tnmCsXX?=
 =?us-ascii?Q?t/1LPgOZMG19PwWIbwfmbrCTmquP1b232K7qR7Bm5foUZQIJ+4Up9UubmEZx?=
 =?us-ascii?Q?ONWicPo/3wERoTRMaXLtFLL5sv91K+OYQHu+QXXpFSlu/jf7TH3NAaKtjGBu?=
 =?us-ascii?Q?WXNTKK1Acui6idqoubWYDywAFdK6u2l+PfIco9jUNcQNGukeEUg7LM9Q4rpx?=
 =?us-ascii?Q?PV3gnsoX/0BZMXTAm9pLM99RbRcouuouHxLlK5P4kQ4/rquNE6EQT7V2PKXL?=
 =?us-ascii?Q?f+s3hb6Y/ppcoEKIqd9h0n/aJ8seV0sNEGrPkhKRD5ld04s5xcWx0E9Zetwb?=
 =?us-ascii?Q?/3floekWef7/6yfFTJOweBb64GJKUvZjYiSBiQBwIrfeK/fpT4itYpP+j6dl?=
 =?us-ascii?Q?xLuZpstjGSWolMTODr9WP/lMiZ+XFLd5fgtpPZ0w7rtl9Z3cnLFi52bGJ7Vv?=
 =?us-ascii?Q?YWsp5Kv23xY44NL5Oj09cFExH5JH1/THNlUbEGL3Csk6kjC8FVR6ixrRodoj?=
 =?us-ascii?Q?F4qTQ9nostrIJfpienhXfA+MmYCW7FklaFAZ+ALXDT4RpvP74C224TqVpsPe?=
 =?us-ascii?Q?K0LQWimDvjrJZJBFOJMIb2zjC0lIdzA9HVnpWEpeOrYgPid2hXTa9wnz0EP8?=
 =?us-ascii?Q?DuKp87Jwdgiipb8fd6MmyLd+/ARq6MFvYjQj6SN7wwAXie5DUVsuYyZToOya?=
 =?us-ascii?Q?DwfqoFpreuBJlVM03zuFG5S+omSSWIIhDcPeGNYPnOXCmjdiBV/Te9/IWAK6?=
 =?us-ascii?Q?WaZopTN89arBp6psfAFy5JUgAyKx4vVFyVtEKZDDTFFxtcLMR0l17iS6oXon?=
 =?us-ascii?Q?W/kyxPDnZoSYAjLEkLvCP4qYMIHNU5uiPFfn0IfxT77xvzvHoflgOJAiBxos?=
 =?us-ascii?Q?ha1yiC/aG2Vj71vOTJxpzsY5fkcabZrNfUoA1WtwZTql5N6zXcuMI50jQrKX?=
 =?us-ascii?Q?B8B6o+rWg3E95gWwPeEPu1OuRcatTXX07K+2hZ9sfTgLjbLQMUysbYKgCpDN?=
 =?us-ascii?Q?m5ZF9pmXwYCrkuAayeHI26rTh5ccy8JFnnkzCwxFNu2EIUjAFWOJzpYhe4J7?=
 =?us-ascii?Q?3BieQDJT1bKQQNgZsJ5htgI0v41P+ZtJuu0Ew52xdnWG3Lcqlvmb8CIO/Nj+?=
 =?us-ascii?Q?Rfcfygof7x3PLjHsTgNs8OquT/jpDgec?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8eKRUvuoD+CCsTOoVCHro4ThNUsajAa4nca1NIxGDfP4u+RNrEPoApRL83Ik?=
 =?us-ascii?Q?cjtkM+jqt44kGLIXfk7uNmf0mH5YxUJcafRcL1T24+zZOP0M9CuSe8IxmHZU?=
 =?us-ascii?Q?M1qgbA6LX8hCCC6CoTYk1XU7zy567+/7oKn02iO152BLLkxjkaua0tezIQvq?=
 =?us-ascii?Q?IrRtnm4GbUaN/XloK9s6TfaY+17w8+wMEI/LrOzdaAAwT4OfGWqtDVqSy4N6?=
 =?us-ascii?Q?I0MZ6DgyHQzAdfislSB1c+z9ZU/8IYfqBBCK6btRlg7yK94KTnV1+Hx2VVRP?=
 =?us-ascii?Q?ZWNR8yMX89cSRWjRoGLyeNl61XXzJyVx2XIOM0GlXlnvQs1OQ+d5MyBvIc9M?=
 =?us-ascii?Q?qq9CKimhMyACPPaTLs2XiXuNNRfiiTeU/LfmDnEFSO1G4FKalDhHFbbYNe9g?=
 =?us-ascii?Q?32f75GQS8JqEzYRN5yX42nZHVSNVIrn9Ui002SIlidV/vLT++uZfpBoCLJwv?=
 =?us-ascii?Q?moeolBDou9jtDhNIKx3kB2Dgcw0w5HJJBAgvfrRfEqfx9K2wZ8eKj3QF8LjG?=
 =?us-ascii?Q?Jx1SYuv1aolNfg9HcvMafQ86lRWf3g7h/frPKPRNn0qQucyJKkYW8m6zKLCt?=
 =?us-ascii?Q?P5T0kNwF3f5nrJ9yzt+pX+YXYgmvblQFjl7glj0zPRkqNK0wh6sOdPdFdkbj?=
 =?us-ascii?Q?B12cN3YwQJ639DCkDbu/Fs354dHzc/mGaTWmB1UfLN+3W/R192gDRweMKHKx?=
 =?us-ascii?Q?BcKp+1zIOE0x3ueOlOQsX8l4+Hac+8RyaqvDUr39l4BZFnCqiUXD5PScPORn?=
 =?us-ascii?Q?xgFAT9A3idQbgNrBVBsCbf/RYX1Nr3YEopv4JW52RvFjAndI12nTAVL03JzN?=
 =?us-ascii?Q?RpJEGzKitWfRzEFot+bJXGaBpCC1X9AEBtkhO7QQ/fUER/oYhM6Ob/2zXS28?=
 =?us-ascii?Q?wNgfMk+qfjSkt3vdBBg5D+RbswnM/CebxyD9qZnNDS7CBqkUFRA2TL9s1995?=
 =?us-ascii?Q?wRvMaqecdHDzklcBsFjlGSzVuMRYiZoLLaMgwz+LyD++NuGD35+VdObi+fM+?=
 =?us-ascii?Q?0OzRapcsN9UZ5Y22yCJmaEgu2BRQxom9b//RaXBLeUZU0jmGkH7jIToJMcXE?=
 =?us-ascii?Q?cxNjmBs3M2RQIURO1pARt79wyiuXoWoBLJZX3x0dU9MjVfsT+Xj9IdfouNnG?=
 =?us-ascii?Q?UAGkdcYprivcadQWEzwugnLd3sqB/HysKzgcaHo4mq5F77XRkkUar3kWDA1R?=
 =?us-ascii?Q?LCFnxB6JYMJ34r168pdwhThGruFFji5knuVw8m4Ny8P52LxF9/HIP/sfBNnM?=
 =?us-ascii?Q?lzRYKBrOc+8A3g2To6rYvZeLwXAdQnwUSXTvxaG1tmzAANCfvSkxBYr74Q+W?=
 =?us-ascii?Q?jqVWDgeXCfxaqoeuOEfsagw6Mcu/vGx7nd1A9GEUPe3WEXNjpJWZzyRREKhH?=
 =?us-ascii?Q?SpnIO096t4WnS3LIp+T0rggcNn9lveCQDmMXFIyvW2qjdt6vEIOkAhV5IeIQ?=
 =?us-ascii?Q?y+a5Zrw4Bi49ooMPri7lxsuVfjxluB+MEH02zakJ65li2PzKDPN585dKUuQp?=
 =?us-ascii?Q?JOiHnx5s+8ZdxZ+B9AYFArpVoEJF7QjjlsKMmiB6w3db4FxdAMc/XFDjzBmG?=
 =?us-ascii?Q?E+z56aXQXOuyZ+93x9+C4CkTtOgX++dlbh4SFT5fIqZLNvr/f98XdxW00HbQ?=
 =?us-ascii?Q?v5KXRI5+WiIHVZJJi1hHnuqWP/kvIZ1/m4EP+r0VDkOJ8HuCcPQPiCwoAG6K?=
 =?us-ascii?Q?+2lDBpMDFT+Q0oV68NcCYIyTMdyiMK5GWfIdowFlcsBQIb0aMyaUPGmWTuEN?=
 =?us-ascii?Q?4k2syhGYHjwd8ibSFhQWMWrUKogOJsw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0b9d86-2501-4e35-ce55-08de4ee0bf7f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 18:07:12.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEiWH+v5nU91JxYsaOCyr1c26PARxsmD6qOFlSZ6HhRiWfplkYrzVejSD5jiD+VoiJSm++eqtJp6u+6s+k7gF0at/gWnZz1XQhEm9VX5lF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
X-OriginatorOrg: intel.com

On Wed, Jan 07, 2026 at 01:03:00PM +0100, Robert Richter wrote:
> On 06.01.26 10:42:36, Alison Schofield wrote:
> > On Tue, Jan 06, 2026 at 06:23:58PM +0100, Robert Richter wrote:
> 
> > > @@ -3207,8 +3220,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
> > >  		cxled = p->targets[i];
> > >  		if (cxled->pos != pos)
> > >  			continue;
> > > +
> > > +		dpa = cxl_dpa_resource_start(cxled);
> > 
> > We want to return -ENXIO, not 0 in this case.
> > So jump out here immediately - right?
> > 
> > 		if (dpa == REsOURCE_SIZE_MAX)
> > 			return -ENXIO;
> 
> The users of region_offset_to_dpa_result() handle the
> RESOURCE_SIZE_MAX case. For that reason the dpa is not checked here.
> I did not want to change the function interface with that fix.

region_offset_to_dpa_result() intends to return an rc when it knows
it would return a bad result. This is that case. With this proposed
change, we avoid adding to a RESOURCE_SIZE_MAX, which is defensive,
but isn't quitting immediately correct? These fixups are all about
stopping when any ingredient to the calc looks bad. It looks bad,
let's stop right away.

Seeing that the callsites do this:

	rc = region_offset_to_dpa_result(cxlr, offset, &result);
        if (rc || !result.cxlmd || result.dpa == ULLONG_MAX) {
		...this failed

shows that they do some defensive programming and don't rely only 
on the rc. But the inverse does not seem right - relying on that.

Staring at it more, I guess you could refactor the function to be
a void and get rid of the rc entirely.

Is that the real simplification needed here?

-- Alison

> 
> Thanks for review.
> 
> -Robert
> 
> > 
> > 
> > > +		if (dpa != RESOURCE_SIZE_MAX)
> > > +			dpa += dpa_offset;
> > > +
> > >  		result->cxlmd = cxled_to_memdev(cxled);
> > > -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> > > +		result->dpa = dpa;
> > >  
> > >  		return 0;
> > >  	}
