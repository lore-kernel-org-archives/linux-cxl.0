Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA35219A76
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793619; cv=fail; b=McvDsjLQ5XW3YrPtzzIB7ZNLzg1KmOuYKsowyLQtGJv3ksBi3cqN/7n3EK0IQ7/C14Vd5vO3RlFqjxmU4togP13WWHz6jQ4FBiVK6oykN6BDDTV67hq13CK/puHR5rseV6wNXSnphqzMF4I/S79IH50WSDIp5uGhEpQ4WxEUjH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793619; c=relaxed/simple;
	bh=Tk5rJFZ1AXI6IjUFOjMu4qh2jvAKC43TuM+XlIGL9No=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vlc0BXX0fmE94qw+lQQVXDLXTxvuEPXd5rM8s8/repW4PC4p+6+l++wP0bj4pYsf9F8vuk7pXlzSodd9PgkyyW3uB+CRwkn5QqIlci7xk7oNkbMpLyM8jCkVIn9jMesV+75WuOBVdxfQMqbNxhcb5JYNnuIPNkIg2UzqgRZhuZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VcRZ8Pqo; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VcRZ8Pqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743793617; x=1775329617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tk5rJFZ1AXI6IjUFOjMu4qh2jvAKC43TuM+XlIGL9No=;
  b=VcRZ8PqokWfa/DXTIWuAzZNAXbBXUT5WptkAauIBb1RaoclmQ3jPEuc7
   h4SBnqJvP2EiFHRY3ngJjhSdRzrWszZ3dBtmssNO2t2bW1Tq3FQ5isdYk
   rW1yRPFsJ9uHhEUjY3gdF9o09FHOStTee5q1sLOdpc01B+XFo2QE5Dmx+
   2wcAaUpqCp56UfQWASHkAqcnsgzGbt6NQ/rhaDBnzCYPPU4xbEhlUOVlV
   xpHjr56xOL2CnAWUiXZf3hYTA4ufjqO8TmltZMwo7x76RDCeVPxKGQp/X
   kMwJ78tZtLE4uEMqfhwIE9LpquMGHkrKSMc+kk1WTWgone+xa05PYX3Kz
   A==;
X-CSE-ConnectionGUID: dAPmNP1wSv+PCeeo7YnDkg==
X-CSE-MsgGUID: ZYldOo/PS/acZjYWkzLgMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="56613391"
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="56613391"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 12:06:57 -0700
X-CSE-ConnectionGUID: 3saYcwXaQD6XyqNZvOVgcQ==
X-CSE-MsgGUID: 6KPsG3wKR7G5xpYzrfyHDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="127372904"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 12:06:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 12:06:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 12:06:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 12:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSMlUDwt8HNhRrSMRMIiJuj9DfGu1X2Tf1l/9EG8mJnVqTCFd2y73x61PFKKQZxnjcq2ZnRW24EsgNZl1Ile4QrBlMVNuKfQY2ZuFrOSrGj8KC+2MYFsd/PfA0Y43MUxbQySTdln7oxzTXIy4PJsUpngHvGXq/Qz/KRQi0kEQ9870yYVoSMndApo3VTCwZbwYJ/pLrrvahmrWzfzIQmLDM5/ZQPTg9sLKeD2037H5Df3JEpsh5fII0rbwHA3Lnc6jktE9Vz/4YIq8FeCipUvU+fZ1EwbAeLrcEEP16BloqkxPWRRaVbtb5Rq8lUwYgjSkBfTBx1Uf/Betd5xABLJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMmIF3bsjwxBh2JuGL1HxybcNmlKtQx5hxmR65PFevw=;
 b=JOQAO6nmBa4GBY1z2bcrMpWoeM4ZindcQvt8zThk8R9IojisQW4T+gg9Jn+2v4LCiyfk5yzMJgYnb/VuGJ19gSlrteZ1eCerz0bDN35f27U625J87AOy3d7I4FmMaTQK6eTCy9TM2ysd8LVLBjPIhLkyqaPNrDcntF+xt2s6ILyvCP1Yic9mHa2Gzaebb1na31agGbEQYDHYTNkuMDLxSp4Qz/iMW7X3ExS3IYk4H3NsN3kQkJo3QrD1Wr9+lCX97T6BN9L+xcpz02R182BYsfiL9Fmbo7jGOuMVNYm5hJoy9tcbJDLeJNQn5Og3ErbCcFpXyFoPdjzTeEVVhOhhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA4PR11MB9129.namprd11.prod.outlook.com (2603:10b6:208:55e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 19:06:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8534.052; Fri, 4 Apr 2025
 19:06:53 +0000
Date: Fri, 4 Apr 2025 14:07:18 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<danj.williams@intel.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] cxl: Remove always true condition for
 cxlctl_validate_hw_command()
Message-ID: <67f02de69d89c_9fe8529481@iweiny-mobl.notmuch>
References: <20250404165418.3032414-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250404165418.3032414-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:303:b5::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA4PR11MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: d807ae1b-fcbd-4e87-d3a1-08dd73abdcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?idA/y3oOwpGuDCmWKYtPF62H1d6VzKzfvW0F7mvH9D0q18l8hkKar0Kp4vjr?=
 =?us-ascii?Q?hrnLHj/LdASWJs0AavsOyb7UAl3pMnBFg2ismbVmFmKtGiH2bNdSz9UK3VvV?=
 =?us-ascii?Q?AEgVDONSYWo/PPBsfewvAfTuFWsSNm0PiiwtMgn5M1X196nvd/UxM3iQjw8f?=
 =?us-ascii?Q?qc/CB8RrEOugoSfAqqh6qv18gT91ZrSAPdoLJNRS8jXau7RIHiDyMvDjqpu8?=
 =?us-ascii?Q?tB/8gv+POOxBFL/cCMbPf7s4oXMbV6kWPZzenphmw5CnI/tZLNFg2SGo8O/i?=
 =?us-ascii?Q?g8hAVwtKbWQLbC7iEouKVCE0V5/ADEGTOxEVEEAjEzQVDbVpEW1Zhx9nONgK?=
 =?us-ascii?Q?1NoT3YKuMKczLPRhUluWocCYyrp4+YszmtmKZyN1MnvUiM+eJmOGjZyx6/TZ?=
 =?us-ascii?Q?ot5K/sQcbJdntuuXooGUcnwbjj5VUfKJ9+ATHksgTS2P1f0BNG4WJZCkb89b?=
 =?us-ascii?Q?m3OIR3vxRSoeAp32tWulgQG7y12VzhXbp8JxSk+FAGikc0t3s66oG9i3DUfa?=
 =?us-ascii?Q?oZ3nJ8cp7HbenMSFgGbC3qGzJ/f/41YqiQxqYFOjacgDgg0SF5p5ymxet07U?=
 =?us-ascii?Q?5JjVXrdbdjW4RfnQ+Oo2Y7dcB6+VhsYeumbo6DZ+DakXy1L1MyOxw11xW7j0?=
 =?us-ascii?Q?JE/Urgu/cfvPRFDEVQcbZgy3clQPtBso2qoJsnoKVJVsGYGvzxKSMOsGVQQx?=
 =?us-ascii?Q?BfFRr6F58k7BoEvC5qCPJO36c0Wuh1S8ylGaksLd9z8JTu1LHO3UIPtNfYnz?=
 =?us-ascii?Q?86ObasbdWLM0K4fBFnCZM/w1vkJjYdwXXugzp1oLj09FnL4Qq4wsepHLbZx6?=
 =?us-ascii?Q?jCCyDa9AlL+yXAoYug0/SizVIijvrOjJvGuAuS7C6/49jagMhIlrv4QPzLGn?=
 =?us-ascii?Q?KKH9lgSTSE//jS9hZySLyHl2lDG2cc8XM9cUTVBIAsVkeS1FV+nfZEiF0NMF?=
 =?us-ascii?Q?pL3MMvJm6xCHxC/+4sSG4dMhqOAAVSB7b6LY84FBon8IGdhh3Q9ApRu3FoVg?=
 =?us-ascii?Q?mwjxpx4g2PkBxj93NVy8CepI0hwIz6D64Vzto4Rk63HAK+qj4HWHomNT7Cyk?=
 =?us-ascii?Q?J47c0GYGTlp3e/j3hrDU8BEo/Jj3+5wDxk3IB4x4FMU5vy+gjA/iVqX44mCQ?=
 =?us-ascii?Q?/z/Rma11GFHwBPXge+U2Z1qfo1jZrM6yoNzGDohW0WjUuHyVvdi1co5xzI1h?=
 =?us-ascii?Q?ksZo30ZwMJJLSViNdVwpC7ncHW084R5Q85VKn+5Mgqty+G/WAdPOfWnEO7ne?=
 =?us-ascii?Q?d0g36dvfHrcgg3DIh9Aec3Zx2GPWaPkD3o0DXLaTMR5/yp5VwgOapfJmPjGk?=
 =?us-ascii?Q?XRkpg1NM1vzkaFP6ByS/zy1Q2ugMKm3dAIZ4lfRyJv4+rQpf5/slimfOPLv6?=
 =?us-ascii?Q?+9YvfzEMkzEb7loKaIstT7eb6Z/s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eNupTdENi386qeURc+fG3+7kC18yAwCcKdzqfTUZmvarlEYhx0SGjky2EvC7?=
 =?us-ascii?Q?NDyXL62xGEyAZTUak+9Fe/YUJ3VriEiPFpFw4Fof+AtN8a8sHR4QA8SyA0BI?=
 =?us-ascii?Q?T7lF6JLiEeZvS+CeXOfcSgBYoU3YA8TKkQX74x5mvV/KPxQj2qfwzPnNirpj?=
 =?us-ascii?Q?iBOoRKJWRrYK205+x229bDmV/mnC/LfHu7xsfIv7oKFl2ZQKJSycmTmrbd0L?=
 =?us-ascii?Q?Sn81eq9xKdvoL4y8RoLlvHGqTTZicq873F9/FCeikObYSn/bPTwCQRojZ4DN?=
 =?us-ascii?Q?tl1Tr56TfjaptbYN/ttXht5VvgxQzj9Vm6AEFmBYBAPcct2vqy3EvffYW2TV?=
 =?us-ascii?Q?MUHsF5+OHfQToNR8WK9FxGrCr97i4PNdCDjI1jhusOluiGZsj6/PrDvXZQzT?=
 =?us-ascii?Q?qW1mR9Yw6ujTu5RSiq5aXgrTYEtc2Yfw9sZnH+fWUXYzgpQoARRrSR92P6wS?=
 =?us-ascii?Q?79UXQvlkaJ+u+VyR+AYg49dAyMvgqtq2/H4YSuiH5AF/CI5JkamY+VcBWpoT?=
 =?us-ascii?Q?hanZJkzte2II6rlkdrBrqoEBlbGh1vkQp+v8hLUiOqYjzaHBetuPDUr9/C4/?=
 =?us-ascii?Q?sFW81FdZODZm+Im0IDxeeFfVL7qg/Cpt83muBskNRp178Jg4cdsElgBA5Fi6?=
 =?us-ascii?Q?Al7g2N4DNByCG0+eOPATJzv5zkmpe/DGV04EkEDnuFoaeGBsoj/QeIrki3D0?=
 =?us-ascii?Q?d7EVPLE/6YbyjriwS7Jfe5rRVQ5oFP06mRisLjO8pbGd0vM9lMoGMxUZ7Ivh?=
 =?us-ascii?Q?PSNRZa2oeE/RFDAbNynmObkJL+QVxB/4KK/8JI+kSt6o4UnhJkeRdJiDLIca?=
 =?us-ascii?Q?BYJFUXPXcPTc+he8S/LHsR3ZvR7XUzWhCKikW6P8tqktbSb33C3ER+bOfDcs?=
 =?us-ascii?Q?QD4D51XPGPbKS4XIvJJV0L/tu/9ON83cVmAMR8YzRfpeWfRXP9gAbEK/1CTz?=
 =?us-ascii?Q?Q1yH2brSNmLCUWmG9XsAJ/QIvUraQuYZPCH94M4ZMzONaFePhfZ/jbp0F2+h?=
 =?us-ascii?Q?IulJJcfite5cdbtY2GjUzXqxGGEOHVsj63JfhZlliYzE4YIgRS38iiRRyKm/?=
 =?us-ascii?Q?96bYhf9Kir30PtOCAoT5KUqHrpZKjzymwwVpfcKNtVzG07c5BwJV63lyTji2?=
 =?us-ascii?Q?lwhzIs2KHv+gBPHxxLySfT9nnl9uM+wtMnmLB2PLQxx41WyADLFTph2lRQup?=
 =?us-ascii?Q?rVIGPjKYgI7VlH24zLK6Z2VyIttSDhd43co/Hyrt+0ihCwVpmImSOEBdFoH2?=
 =?us-ascii?Q?hmtd+tKMXU2+k7xeFiS8fNu8hVVvKmsst/S+v4bEHawGIghy8iN1c95uYrjC?=
 =?us-ascii?Q?y79TET+mzuzsgE8QMKDqVthuZ4UWNnOP6A5IuHq2fZq783ljoelTwqksNBde?=
 =?us-ascii?Q?eYM4PLuLaJZ/8/4LlM/4nbweysQOwbIIqIGyWb5M8FfRDd05x3yyFxo63xaI?=
 =?us-ascii?Q?kDNbQdNSpYax0c6GtaPRGs4KXfcDr8en329+4CAeH6TzKszGl1StP09CHgit?=
 =?us-ascii?Q?mPsnfsVW1ZdCi3NU42s9oloeBLnBh46aTJnCfIT8o5E7w9siGEoKGeB+KXKM?=
 =?us-ascii?Q?uNa3eSl49JQ6VAL8Sq9fIuXkOfzss+f0rR16m5xy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d807ae1b-fcbd-4e87-d3a1-08dd73abdcc2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:06:53.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ng371Jxt93689gNNAKt4suhXNTb/SdeJFxBc0SK74JD3fcGyceqX16l3aPnsiNEWEFPU7qdM6OD8s8FowChgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9129
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> smatch warnings:
> drivers/cxl/core/features.c:441 cxlctl_validate_hw_command() warn: always true condition '(scope >= 0) => (0-u32max >= 0)'
> 
> Remove the check entirely as it has no effect. Expectation is both of these
> operations should be allowed for all check levels. They are read only and
> have no change effects.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504041033.2HBboAZR-lkp@intel.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
