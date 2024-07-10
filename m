Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D04F8A0
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jul 2024 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591726; cv=fail; b=epHHO7jphstQzRx6uD9UT+8E4J6zNi8Jp/ZLyJrwIr6wKYOlahyGHbdnaB+gFgp7eO2dGxXfs4zawavV090mjQ9hlNg5oreKeb8OnpM7Zl1j0qjRWm4c4NyCvehqf8zrB+G+PGovSUMiTb8Pskepc4TjppkaQ9F6pARXz53/xeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591726; c=relaxed/simple;
	bh=Su3qvrb9KtXHJZ52O5d2pMcjPulvbdwLMmPaL3QbXJg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HwYnFRiS3vv7hJ0EtFfuIpPxRbk3YV2xG6R+wBNaPldgtUUpqOziLsNfCnLHhaEx/ZtnkA20DZAUb/m1+tm803fGcqtlzaaEM8m7kVXQ2xQ/gccijnXFni202cnGhkBeZP9zJORhTdNQ8xp5+obReiinX29Hzzn5X5iMc3WiQTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfZ+a2Hu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfZ+a2Hu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720591725; x=1752127725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Su3qvrb9KtXHJZ52O5d2pMcjPulvbdwLMmPaL3QbXJg=;
  b=VfZ+a2Hu1iMoYfHpeYp7vW+wisGCjTm98+XJI+hoCPN47kfa2YMLVam5
   q756IXpbr7enIpElLzlTDscAxCZx/Jdk9w5SuGuAYf0tCvusmawR44Up8
   7biGfaduOLbrEfdN0XLZHcK/EGDXbsrJAJ/32+txmMvfgySlhaGtm3gvx
   Yrk5gegUlzZN0Uy8Wwq+jZYSRN/rAW3mUuu59pcJVO9TZbiC6MuNk/loC
   g4VXJ6xQDx0xwOIy4xeR+PFCkqNgT0035C1yFiT01UIoxM/cncHKweOf2
   AmVKw4WVjetfVpBVjHxF1Lcj+SZG5Z0fk+orXz0EB6ew0+wMCq/d6mI3c
   Q==;
X-CSE-ConnectionGUID: EzcqHAxQQFGF8Csuh/pfpA==
X-CSE-MsgGUID: hD03BvwTSduKjKhTBXxfDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17708805"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17708805"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 23:08:44 -0700
X-CSE-ConnectionGUID: Mu088Fm4QnCPa9e3bgXyfA==
X-CSE-MsgGUID: JX7MpbRTQn2VDW83iIk5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48094415"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 23:08:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 23:08:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 23:08:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 23:08:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 23:08:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al7LC/BBOza5/usXStSWYQHB6CJVWBRRyqinUa8dpCT32Y+0D0SCCGD9DafAmWkWlCe6XeGOXAIq6y+wnrY0bcpKks5lw/ZgALPmQiZ2Fp5Tq3O1XeZwzjT9uyE5VcZpT7bcyxMK4eCQoU1zr0rojZPdqTWXj5U1SPzeYm78ox9OvtN5naEu+LtQWbB6HMDjeANPRPJ2H85zv1LwCmmElMDG+x58A2Sne7YuS0sAJXy71/Yd2d/41jQezgjNnnz6VZlgz6hFBHAYeGYbgmUhwwkjU2M0KyqLRU0l81n7PHdZp3BxeXF5PTU+lRzj/dEamBY2mM9/4TFMFai8EntNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9Z3kpfcbglcpFNugxp1GAmVa+W6RSRpOpvCDFsEYo0=;
 b=Zgcj3+8AGxsIhuySVf5vwwzV0+HkweZyjoZXX2+X8Gd38nFJDwAURQ5lstjEUH+XYzKsXADBXdDbZCM2h0IHDMbh2lmnzMrLH9HUyJGheI8XEP1BXdPOYNhblVihkkv+K4vwL36/4qwf5LyeYzZWOyN2FEfnAflTRxnZ65q1bnixYoxO71R+SIh91c+iUlf5aX9wXSU4dhCqjqn1178Yc3EwK8E8dEN7TzkOaeKw+gKkVuLbagHFzhcII+hps8MxzHftwJQ3wLjbe2BNm7+LH79T+MVu18hd9oS/o7befqaB9jlgehJv3wuXblqqTnVRTSPgqPZSgHIGbtyXno73fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 06:08:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Wed, 10 Jul 2024
 06:08:40 +0000
Date: Tue, 9 Jul 2024 23:08:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>, <kobayashi.da-06@jp.fujitsu.com>,
	<linux-cxl@vger.kernel.org>
CC: <y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, "Kobayashi,Daisuke"
	<kobayashi.da-06@fujitsu.com>
Subject: Re: [PATCH v14 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <668e256583728_6de229444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
 <20240618042941.96893-2-kobayashi.da-06@fujitsu.com>
 <668df392f2036_102cc2949a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <668df392f2036_102cc2949a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:303:85::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: efe0fc20-93ac-457a-2c9a-08dca0a6be96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Bl5j6V/AACpq9ceXjmXKEKkux6o3R411v98R3EMuvClKqJw0OOXoMQwrwAZ?=
 =?us-ascii?Q?c03nd+fC9+RQEHD+hS3Hz5Lwsnr7RswUbmhqpYkmGJ6RVSKdMehidTlAVPwH?=
 =?us-ascii?Q?1xJ/tZbaC2U+cDh1ASTpHW+Qu0YnITUfJm6nIraY84RxxXAwSsH4pd+263mT?=
 =?us-ascii?Q?sNVDkBDozG2B8XcZB/7KQheC5Exrwv8+8cQyobulUtZGPzc7bFdBGV6CYFEa?=
 =?us-ascii?Q?FAroWbr/tuvytwXzqFcaSYE+wXGsD4KzUo4X17+m/nKOlkEbWDNrpDzQtt25?=
 =?us-ascii?Q?BHI1O9AP67lESl/QrnyxPGzABea3vxxCWRWGyDvMEGAYfjN3TifBahm9l11A?=
 =?us-ascii?Q?qeVtte9zkafp7kgfQCk3qukg3b2qSsM/AHv+o/pgDh7hnVfGzUSS2+RJAFbc?=
 =?us-ascii?Q?dUxCQcIO+/3Nh24ejyZ3VYy/85jk0sA24EqhxVDmVvQSGrhPOfaMYrBr/PGn?=
 =?us-ascii?Q?AWJrNYlvo9xrXuWAOC0M3UWbuJCYEDWmhe4tDEqtTRU0tbFoulGI05pTaGLx?=
 =?us-ascii?Q?jIKfX1Ux5PpSSVlLWdMTs2spXR0h4y0E7EXNNWB9vyAm76Tf09WJChlPjTxm?=
 =?us-ascii?Q?1msdalMaXcoA0njbgQK1uQnWRl3GBlyt2TdO+kYyCTfbXpCQc5EIZnDVje42?=
 =?us-ascii?Q?6czfKTCJ1Qs2Z2Nh/fthzOUnKtgHBfqMbolPmQsu8r6Kmgt62naWLcxaoUZo?=
 =?us-ascii?Q?WEdgRwfqcvc6aAWJ3Tsu0rbtISyzGRt4bjtdqidwDKGrr+X+Yirida8NKOLu?=
 =?us-ascii?Q?cCBqNpmYOTISpH6NeJmuBM/QP6/x5UuyAObldUg6r7OF8e+gKO/mKbKrJ4H2?=
 =?us-ascii?Q?Hw9Z1zsuqk+SHUbpg88aBx2c7joKOTkUph/K60tHHB0BitCTlhODodmV0oAO?=
 =?us-ascii?Q?GKdOeXZpx1FiXvqHPTW95PTYEFCjuzZokVVM8GzQWUP/CJZZvTHGcCkali14?=
 =?us-ascii?Q?oZpqDZpj+YnjRJ7ALac8gYJVtotkjm9GfibA3ub08d75pwRjR7Yd06PMYona?=
 =?us-ascii?Q?QqoUiQBo7BqDsJs3HKQtjFaMtMFAFJJtkPFzDSuPISihVtxNcU6ffbYfeTx3?=
 =?us-ascii?Q?f7GsFYXub6eEyx67MgRyqBKqPbRPCvzAP17aVpNSNKh65Sm1jtGw6jm495Mf?=
 =?us-ascii?Q?KC4U+DVR3gPRWKfsc5fe2F4GO5sK48WylIVTrkkDEEuiWDb7QXlnJAKSnk/z?=
 =?us-ascii?Q?+HG2Vi7Emniye6EHWcC74aRL3f5DFnolLobZ0SAotlAXut+ESRnH/zFuDVne?=
 =?us-ascii?Q?OQbM529cwvBnqDbWBvydncGywzQu3jkeJUtPPruiLRL9TbcCDO8UluN0ws5X?=
 =?us-ascii?Q?7tcq9pZCJvrnIyjIoANTJnuUa1iWEkti8yRfpmtJzBD/Hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ZUUaR/y9ZdUj8mnJMgaQXlEITsAYg3+aXMPU9W5AEobLoj3WTpDKdOqNLuY?=
 =?us-ascii?Q?i+9vApuiQpsUEiO6fd1q+VEtv1k3D/Hj9tV9s1fFQFbLRCIEhpjTrxRIlpye?=
 =?us-ascii?Q?Qbrdu0b0ih1tD6LkGR57iBM7H04lbfIRYfi5ZQdZQlpwxOFOvGtJZW6ucSN5?=
 =?us-ascii?Q?FncGwsdgRsTKJCoHHrlCZV3ag5eDA/0HQH6fE6sp+JQhiahf13v/o84lHXaa?=
 =?us-ascii?Q?M+5pV+wZOK720RlyGf/UjQdmusXFGBhm7e8OIy3KizDM3WPyjqcOMQ2AMmm2?=
 =?us-ascii?Q?SL/VitWj2MQCxZS76idMG3hHaw3o5pYY3Exny0FPGVlratifJUmhoVSlKzIz?=
 =?us-ascii?Q?tOTZa+X6fyL8Tyn7rYNg28DJmykEPDEtPSlIsCkHKhoQ5ygGQiQsIh314h70?=
 =?us-ascii?Q?l6U4xp4hsXxzVGNP1hvWOZQTlNqsNEK471IInsbvDXlOMdOAw5G4Hmt2G0ml?=
 =?us-ascii?Q?L1cFPVybPG9TX0KqRppcAUZFeZfgLmTKS31HT3R6yIfeUd+WyuvOYwFzFZWa?=
 =?us-ascii?Q?6++WHcVN3/DrnTIRG5wVtluLk97HNH59JX3WOnPD37NHSw9q6hq1IYIyS/4/?=
 =?us-ascii?Q?nW8f9HiYVK0vFwzAtfhzCz6Zd3b38N+EqXRIG8rCik/wpwfs6MI1p25pxQPx?=
 =?us-ascii?Q?XQ2b47ECeSxzlyfXHGgQxeFf/xx0c2CUo1fQtHQyY5t0ERUoNiAhQ42AeEtN?=
 =?us-ascii?Q?xreTvMngaz8wVGj2JHYVv3/mXT6hfsr3ujFCpPPViTb7IBRWDiSDkIRb8eNt?=
 =?us-ascii?Q?E47hwH1wB/U4UxQndnfr/zdqMwfYKI87un3PsKM8lOUwHQirek3l0/71Upma?=
 =?us-ascii?Q?/Dsy5aH3D7UvvnDuufslgBnaHXu5jhrZ6y4/qlY1WyG2DqoeLZaU73P1we4U?=
 =?us-ascii?Q?msquXJymxsK4trORL8ycRtQuUSNMOvMuuN24TpvFIS7505xfZxDp9DuB2Oqp?=
 =?us-ascii?Q?jsewY3Fmxzka8oKo+L+krca6vr0WJpblR1by0fYTSBU5lTQ7/XxQaulIVVeY?=
 =?us-ascii?Q?4FBH2yXj8O7DyOpwO8oVH3gcdGi7sPOWy7GqWCvnffcGTE7R77twP9cTypNy?=
 =?us-ascii?Q?Wny6aPXuMt6rRpwCA1XLU7HEwo2LdgFvkgeouvFxYfsfzX2TnybGFb3gS14Y?=
 =?us-ascii?Q?WryLW4QhJzCbSjeM191wWnQR+l20IpfG5ybm/+1b7o21Wxs0LIG0keyo79+X?=
 =?us-ascii?Q?mOlDVNAS/mB7mZmSt1Bwbbs0McAjaDCgVNP/RCMwcK430lMfpXT0RlrOCIS2?=
 =?us-ascii?Q?2ewjz2hBSk8Y4tNRaJdCV9ZYmQKWk6IkxKRD0I2PUWOMGu9UXJ5AqhhdlRd8?=
 =?us-ascii?Q?NN3dFM/sO5nXWvQ1y+Xmiw6A6n/sCmIQ0vMmISjM2k7jTarDzfeKbCPgbJp2?=
 =?us-ascii?Q?KsUZel+HGvOYw0fjzNvjNFpeKK+dQdvm/rwaiGwG7TgOh5j8k3mXoCE2PXkT?=
 =?us-ascii?Q?ulzbufHXVO0qQo0cG/Rreve0tkZTop2azslxqwWRMRwJDhCmWyZOLtSOrqfi?=
 =?us-ascii?Q?YOYKvDT6elwn3wCPGNxLT8MuyheAZpbulTQIEVxn6rLIlYdRFeKBOAoqLFP3?=
 =?us-ascii?Q?+U41LEeCfg7HiHidkLlQLBbp3Wx12u0pW5dgYUMzMep4yN9rQ9CgV23eZjoh?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efe0fc20-93ac-457a-2c9a-08dca0a6be96
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 06:08:40.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoSaPHBu2po+eqmSJShgB9qlE7kZdD4WUrJUKV3XcLOaCgvu3e0mTECNc3G1HS7iXZtqpXJ/aJWD3pD+0Er+C6+n9uaEhAUED+FnEYeFFxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Kobayashi,Daisuke wrote:
> > Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
> > device link status information. By caching it, avoid the walking 
> > memory map area to find the offset when output the register value.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > ---
> >  drivers/cxl/core/core.h |  6 ++++
> >  drivers/cxl/core/regs.c | 61 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |  9 ++++++
> >  drivers/cxl/pci.c       |  8 ++++--
> >  4 files changed, 82 insertions(+), 2 deletions(-)
> > 
[..]
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 2ff361e756d6..bbc55732d6c1 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -512,11 +512,15 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	 * is an RCH and try to extract the Component Registers from
> >  	 * an RCRB.
> >  	 */
> > -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
> > +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
> >  		rc = cxl_rcrb_get_comp_regs(pdev, map);
> > +		if (rc)
> > +			return rc;
> >  
> > -	if (rc)
> > +		cxl_dport_map_rcd_linkcap(pdev);
> 
[..]
> Ugh, I was going to say copy what cxl_mem_probe() does around locking
> endpoint_parent before attaching further ports, but that also appears to
> not handle the same race. I.e. I think cxl_mem_probe() needs a fix to do
> this as well. I will copy you on a proposed patch for that.

I attempted to add the proper locking to keep cxl_dport live, but that
runs into lockdep issues.

So I think a better fix is rework dport lifetime to stay alive until the
final put_device() of the port. In other words dport instances get added
dynamically to the cxl_port, but only get destroyed after all port
references are dropped. Then the @dport result from find_cxl_port() is
not ephemeral.

Given this is a latent bug that affects all current
cxl_{mem,pci}_find_port() users, the planned fix is to just make dport
lifetime longer, and that I will not have time to do that rework before
v6.11 merge window, then I am ok for this lnkcap code to introduce
another instance of the same bug.

So, just make cxl_rcrb_get_comp_regs() and cxl_dport_map_rcd_linkcap()
share the same port reference from one cxl_pci_find_port() call.
