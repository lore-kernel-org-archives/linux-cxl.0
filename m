Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD1B665
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jul 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444954; cv=fail; b=XCzfx916I23cJ2fPVtVGcCJsF7TUCf7Q33d4f7tLf/OPfybeoF7n5XUbub4QFbLyXueYA439doMuiaPhf+57i7s++UgxIUgiqt7zkWv6TOKtjYv9xww5IYatJheG+Sru81ATlXLShwOKae4X5NNGtamPRzGzvvkRc7yHKEdDUZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444954; c=relaxed/simple;
	bh=C4wr/EubilsL2bLVS7GQ3i1MV/pm7JT5Ec/7RkjHF1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZmFd//1uUIWQrWGvJYszllXDX6YtRMmmMmTuP3OF/gmtTtVBDSMBPxMVZwsP+pHZawv1lPt1NPfCoT/QNdAFysMkteUqz7YRJwA8wv4aSMtjgdBH3+ZitdThrf9eVRI/ZN9vZTYlveHCp4tzVOFOUN8TpHzSW2VEFmaKlZHc/x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KU8+hBgX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KU8+hBgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720444952; x=1751980952;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C4wr/EubilsL2bLVS7GQ3i1MV/pm7JT5Ec/7RkjHF1Q=;
  b=KU8+hBgXQXHLyznp0//puYVPGM0CTn0iKiE0P3guXjhoKdu75cCtv4Eb
   i3VagFR0Vq3DVrIE4BQSE94Ue87K/jT66uRaII+9k5Tnteg8kLyBd0AY0
   ogTjJIkIWpMqm6kiSM3BzcI4/100vhBYMtiXk9wu6fhMnLfldG7m1y+FQ
   d/Qis5nAT9XQFVn4cL+V6sqOW20OyhYfuufK0DKM240xoifRu3zphdFXC
   C2zW6VdQ515h1GoMlKpfPMR0q8KGCMwKGFPQ/4nJUngnqwlFJglm69ndX
   m9vgMGUFre2oCQ5SYikH+GKpPRB9rBu8nm5OX5Akis/iPjtr8Bu3jm6OE
   Q==;
X-CSE-ConnectionGUID: gi6SIEF7TWS1idBHlM6axw==
X-CSE-MsgGUID: AVCfyBOnRem79ZNlLWm54Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17774204"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17774204"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 06:22:32 -0700
X-CSE-ConnectionGUID: YQz+Sl5QRZKRG2BsnpzwWw==
X-CSE-MsgGUID: Ly8M80dsQpuLDFNFQREQuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47474110"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 06:22:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 06:22:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 06:22:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 06:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3tMjzxXzOf13XqRSEZj6B96NjGVFJpOCGLpei+E6u1ojSyELuWWoso28d3CF+TbwesImCctB7Zz6omQOva8ktqfw9BV9ChApnKC/VOs83Zl3jzk5ihE/ZJxsC0lWg/ZaavIG38qK4CeWsQHVOOa2gPxcyLOejdsKLB5y0vD4jWjo8DFkMc/oSlmlz32QMnAzw+SCwywJIlknmITNTYBdJhldtY6GazeQp3ulMVue+PJD12sj/BD9mkc/dNRhREGp5bY1K13DYebxitAxisldqfQyhknoQw5zHGpzRvHUXK06n8+k4nJpXP2z/sAct/aoL2JLJSBAObw3zp7cjGHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIFNaTbpVOUNIZGoxClGrroVDAZmVF2E0QzLppO5Iuc=;
 b=RFbVk3pAep5PVVtNDK5YQ95f75pIFdCO9EmNas4FCNMfDNeNVgb+peI3RNVdGW/UB4b8WYTuJXndiQ5pmqT0eBkfFIZZ09L62rjs3sC2FAUeXuV6kmUg6o/TxH5m1GPmes0LECd0QxhugiZbY7tp8qQ7GL7bMw2dYoPL6DZMQU7g10RPYOFoCyvDVlq4qY1+qaVV+BeKqsSa4hJBJMdGPGZEWa1WMI1yUl6+a9SdrFHjpKijDkkXR3FY/sylcMuNCF4770pJNegWHO/i3erzjFU//++xRGLvEMoyNKuGDL0S/zGlmNo7d0DNsWshcoVbIXwfe9IPmoC8kF4IkPFj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 13:22:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.7741.029; Mon, 8 Jul 2024
 13:22:29 +0000
Date: Mon, 8 Jul 2024 08:22:24 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Adam Manzanares <a.manzanares@samsung.com>, <dave.jiang@intel.com>,
	<Jonathan.Cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2] Documentation: CXL Maturity Map
Message-ID: <668be81061f64_b9f329417@iweiny-mobl.notmuch>
References: <172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: f5308080-7ef9-420e-7367-08dc9f510408
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hkk3uRx+1QHn98WFlaAbpDq8fURxmHcY6kQTsHOdG5HUUyOMK8LvUdIIRV2F?=
 =?us-ascii?Q?YlY5/YpJa0JlHUg6jMMM4HjoiVlw3OnyrVh2gSce5iv1caPQKhmOYsOux4qu?=
 =?us-ascii?Q?/6tWziZ/p6y8pgkcNY2tDh7G4VIk8NFGIxygDkYSYN+B8GQ3jfKaf4TY9opN?=
 =?us-ascii?Q?sT7w2L+8lnVWlvLMGoBprwCtOCSIdC1gCbTpe7tXmdKJkPh0QIa1isR0+Hq9?=
 =?us-ascii?Q?zVps0YroUE2NiGy+BhC0KyO7ana/bowCM4eX5UyTSnZrg4wSYXEx02cHRNW2?=
 =?us-ascii?Q?B8gnAm69ZB4PC0+Sfg7JOuwU5IHqZGElqDrq0w0zUCOEKbYDZn4tqdjcjs2/?=
 =?us-ascii?Q?Ic/8ipPYx2i6DsxHWYcwGCj+RFpYXDfHqazNq6OFNpmsHlMx22s0fxc2Fn/h?=
 =?us-ascii?Q?1U3VWUTsn0VCnQ6tQ3FCxcu5FuAYh8uHpdH6VEthJTIn0gri9cvSU1M7yxfR?=
 =?us-ascii?Q?rr05UqWn8l5jQGYD/47rXa/WxQR2jnLUQ3D5oyU3jfWlymbNfl8CEd0YFXY8?=
 =?us-ascii?Q?YePCC/WWhArlR9uz0q7+oec7WKQfI3kTesKIjDtL2P97hXD6P84h6ApzHW1s?=
 =?us-ascii?Q?Epo3z8s6FNcc7bIEo8TraRROKYdPLppOKtQlAoxRzZJAzXRg5pAvTjKn5RDE?=
 =?us-ascii?Q?64yYgIbm4QM7csqNjuRpgVlJIW+uJ987lafJSK7D9b8sD6kNDMx5NlGPJTLx?=
 =?us-ascii?Q?beYlxLHDsrlqN9Ij42oHbtJA24IYRxUEAHEwADL+2MlfYhYXStHxCvhFGJz4?=
 =?us-ascii?Q?4DulZiwinXIUWI8bUwayxcsrUGB8FIyyetggeWHeF/wfSjxp64sv8dPLUyFj?=
 =?us-ascii?Q?mjQy+WSA/8Ftq/qanlIzjy9ODcBl4TkFOqfhR+FtCeOIQBWDpcFPh5NIcHvo?=
 =?us-ascii?Q?a9CqyOqgu72fNvrJtV1aIAVoag7sUThYIPmwSOR68RpLeJBZOJ86uwPxbF/j?=
 =?us-ascii?Q?AfT27S4T3rx7o31OmgxxUua+55a4aFydX1La41OvSplC1P/0Vp6ql7HPPkOt?=
 =?us-ascii?Q?3/p7ISfYWxRsWj2S4BDos7V2rwWeuEhSYtO4YwxwGRlNfava0zlau3HYBkhh?=
 =?us-ascii?Q?3sI/mjcKNQHn4mGnLbG2J7Bl8fwiMufcA7rRDncZEbQrxbJCDxxUPVnX6tGl?=
 =?us-ascii?Q?FxMsSRh09JW8fWaNZxwiC14KBCTLe9locpBxyVLhu9DKCNgh7WggSzusGOrR?=
 =?us-ascii?Q?+MLh6vYqZHAXarUK8PFOtDfF8olRhoX8gBqXk8RweaiQ3IKnOt4bG4zgccIt?=
 =?us-ascii?Q?j4sB2PEuK1vYeSOMWeU1sbLt6myEXUDHYSj3BTGsDCGJTDfQ+eqiBX1IBu/5?=
 =?us-ascii?Q?EYLSpbl3FC7SV0VbGcf2FM+Ajhb8vI3QXMM3oUD2OT+I7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQhU1OmD6shcwuApPYnBYpyanYuKiV0mqE4uKkxkHW3tVXZ2ZrNib7E1tqJQ?=
 =?us-ascii?Q?XJ1Fd+kyCIWidRy+PsbPCayvERILoma907hn4zKU3AAHROBrzLbFM3kz7FWU?=
 =?us-ascii?Q?SZ5Whpiebr5d51IxEJ5CIlTCKNJ+irBmprG+BKLeNP1BZzTxi2t4j5Vwg3T9?=
 =?us-ascii?Q?j65catYNPRvtg5fA3TYlir8bGcJq4iynjDrAYDuMjxh8JXEzraiDVt2CKkVA?=
 =?us-ascii?Q?BW7tXxH1Rr9tkkawCnCmOj99Afcwx1Hn6SxzZvegetripvdrmP+cj2MmNrBG?=
 =?us-ascii?Q?6mMkIYGLJjBeLaSnRiQLrg+rojHzquRF4ebWOIuaifsn42oQSNeoVwppj6DT?=
 =?us-ascii?Q?CCObywGYSzyV8zZc725UQQ8biogVnZJtWhns/3yjZ/gjmPaDV2I+ou1vXeF7?=
 =?us-ascii?Q?vTO4QYaUsla1FWmKcpatb5eEhMvjXARqMhN91/qIvRVP+M76jAf8iz/S5+Kv?=
 =?us-ascii?Q?FGkMudlP9eyNNbqpM2k9/TuMEKfZnVsQu5Cub/7V3mcxNtdbGBS4MGHaPOYt?=
 =?us-ascii?Q?MO3h295MI+h7mSASjQA97V4Ty+jiPUQHzuAnPmgQ/9be7I2xCFLT1qdik5EN?=
 =?us-ascii?Q?B6IhB3pe+4Yg5hVjqJ9wQcVpDHVh6257eCaoq2mNXB5V8D5NdmFdVc7+mlu7?=
 =?us-ascii?Q?+RvFniLrlGSXSRTRQOFJ1+uJf0iTt3Dqu5zZG8t361EAw7V1uEPetas8z+PL?=
 =?us-ascii?Q?LnvFVzN0oB6gekxvbFex/AmoFhWflcLfVb5g15df8lFsrXY6pJ7mQIxJjmAC?=
 =?us-ascii?Q?sMgdW6uCZ9xcXPuJ5kYgviCdwtJgi0Yh6u7xkGoBzVTRRvEj8270stHNFSUZ?=
 =?us-ascii?Q?LoaNh5Q3+/62JF2mtqpzhGKc1BGvStQZi5+NdY3upvc8Opj+wktpvBsnn7xo?=
 =?us-ascii?Q?SC67ZjOGU8m/dIuKuLsX/YuBZS+wmzvGEsWxPHsHRoBEpaa6KcQ5fwYY0OPD?=
 =?us-ascii?Q?JeR1leqsWnfFjgG9YtnoAFY1WUsYT3aaeNXUCoVnLEuSKjbJ8w9GxVcofHh6?=
 =?us-ascii?Q?W/hZckipTR2rHJkxUrFS5fRyAUkt+QnK8pNOGfoWfx67HVanA3ngYfQEp4Lu?=
 =?us-ascii?Q?eOkMvha4R9r5Qa1gwrBcXAPdMxV4AR43PbvrOFw6PD5K9nYkvCYqvQB7IUV/?=
 =?us-ascii?Q?jyVB6jG4efL3OBZoR3idt6w6/hsd9lzPzXuFojSi0yqfnqA3bL6Ii2Dhc9ka?=
 =?us-ascii?Q?rldHa+C11bvcg0nP108jeENMUAZvqCVMvj7n0avBdP1qu6G8L3Hle77m4PpI?=
 =?us-ascii?Q?w2+ZHWJU3hmk89mlLRUq8o/Bys4NZHnGHBIosHWDS98fGUOJb/tSOazYVFDS?=
 =?us-ascii?Q?1fhwdO6NS/lq3/OaZJB7gfZsNBAt1yfS0lBO3bLgrrhTr9QLEQTTU213C3Rq?=
 =?us-ascii?Q?oO4KIr7SAMPgepYyj6Cm7exmUXVxcLSHVGiImI9ZRXURHB0lzDtWya+yYi8t?=
 =?us-ascii?Q?we6aMmAO+k7zCGevSrvp2WcXNdg0WW6UC1PSGiqxKErPvfnEcmMnlvsUSwEc?=
 =?us-ascii?Q?sRKD0RNzW7v9F14dQ8/RPsa2dslwOjkEr539gW8ORiEzsf+0GhbPhNvUhdp7?=
 =?us-ascii?Q?t0cKyGPhfRbbddEJCbFgGV74z8QXeBW+JY56dOLQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5308080-7ef9-420e-7367-08dc9f510408
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 13:22:29.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7zIVY9U2lBYzSHRiGvevJGSuZknht0rW+tTeM12uwnv/V7prKUBIdEgOQiPgUp/zX2PXSR8TTb4YQ6Tlquslw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Provide a survey of the work-in-progress maturity (implementation
> status) of various aspects of the CXL subsystem.
> 
> Clarify that in addition to ongoing upkeep relative to specification
> updates, there are some long running themes in the driver that respond
> to the discovery of new corner cases (bugs) and new use cases (feature
> extensions).
> 
> The primary audience is distribution maintainers, but it also serves as
> a guide for kernel developers to understand what aspects of the CXL
> subsystem need more help. It is a landing page to document ongoing
> progress, and a guide to discern exposure to work-in-progress features.
> 
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
