Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE01E9B0D;
	Tue,  1 Apr 2025 20:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539563; cv=fail; b=QXZw+hrJC2l8uudY42swG3e2hwobhCdBof7MUrQu3VcHma+FqSJg/rBvF67vGX6G/J+9Eg5ujSZdB9A5zZpH9g3jmdQZjcRZ52x8geIutsD4KofVhfwaztB27NPkQYODYPii9VlMM4xDuIiMa0fBvvJZfmL5tyhS9XVivTJ2g4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539563; c=relaxed/simple;
	bh=c2tqWq80j0FsjmdiJ2z44/RQrO163HpaROHcSW8estE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OL5c2jpZl3KLck0PXV7suhNNeEjWZJiPXuClRPE0ZdwRe/G/pEp1DkXPM5oED09fVosY7XAe5Ic63IuO0tt/5QZ3spU5JosPr39XzgJbYCJ4FPu8R7FQIYW7C16PR+jo048aBNHOA31Jf3um4w4rd9DPBmgp9dq45Db7woDOkVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKLXSOl0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKLXSOl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743539560; x=1775075560;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c2tqWq80j0FsjmdiJ2z44/RQrO163HpaROHcSW8estE=;
  b=UKLXSOl0Iv/9H7NKblbTEx1V+Ln+OHl4T1CNoZ5XlQmvV+QsosNO6sEB
   raESxJ0VqOlQZhBBw5tT/oErp0PZnWkmNEpla/ktUjJIq2/9oNg9hhMwV
   8qYRQowvPHfThk011o3D1M2+6kDQ5D3POoaQyBR070hXCAGVUGGVK4HVF
   OgQ8C8xN5ywmnPDvccs+ZFHRRiCtpZ6kWDO6cnZNI3dfJXZdYpGTa88f4
   2uZwZjYYiaEdL/iwauiTZ8l8FVQcCIUa8Z1rJ21mMEQSSOqW/llrXeEwW
   TrBdKNhPvF2orhgBaobJsIPR+RQF6Y/ok/3BNrxCgbgWS0hnxtMS4NHQX
   w==;
X-CSE-ConnectionGUID: d3aQb9EoQ5GWWXNP10OC0g==
X-CSE-MsgGUID: IFciyTlIR2yIfId0huIZRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55516456"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55516456"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 13:32:39 -0700
X-CSE-ConnectionGUID: n6/KCnGMQqe6FxGUIwzBow==
X-CSE-MsgGUID: 2KvQy/0NQKWnmnvSpF6Wfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127312751"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 13:32:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 13:32:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 13:32:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 13:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAEmqqiVCJWpYQUgOb6+YDu5t5P69OpAdxs2LziIbqSkLtzV0C4R2FosD9h6xkVddbe1RHuweFBwGR7YJPhhb3D/wFEHYynjJkTasbF6a8HhMRYfWYJa+cTDu+MTCdR1uWilN6pBh9dFPlVc/ZbS3Br4EEvbGMlitq6jrd5P1RUCSW03GplQS85O2zrp0ofxs/NH2d9pNaL2R2BuyZ3pYmIL0vXrzUYgnrnLWIAYwQ/d+bxMA8wUTezOmnezu+UUfJFHGcBbb4Bg6mVoUjMICTurNHXVe2n7ottff7PE8egGHWUmvi3meNjyShH2p4siKMJjzFk6XSTXzhPwRdpkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ByOVmeDPlPtbyZDl3D8Fax/xViNPdesbqYw2k0Q7/w=;
 b=Ps+Gi6KEdUzlUe8jdKjv4w8DQN7kcIlZlqTVPa64Jd3Kik6qv2m6YwIZVVQqBDd3lxFt+F9lCbDuq1aB0rsDdNExJ2MTp32VGt83czZ5e+mEWxkCR/92Bv2kKeK+AvGIElmszuy/SfEx9XuDssNa79WV/yYigWLJhfwp4Vs1brxkM128cSF+I17an9Pihw/VMaquyffF/X8Dl/uK6X3YpqJNq/L9iIwFQxqLcStJ4vr8Jqj+p5tGe+dN8lDnuaGfSuBTteErGJS+Ipq7BfxWS9OfrftkPAF2pP4WUE0jgoWmHKGkL6IHp+bHpmJZuGC6boWMOy+5yURtSrWx1jicjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV1PR11MB8791.namprd11.prod.outlook.com (2603:10b6:408:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 20:32:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 20:32:36 +0000
Date: Tue, 1 Apr 2025 13:32:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <67ec4d61c3fd6_288d2947b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
 <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
 <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV1PR11MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcc6446-e5f5-4c07-757c-08dd715c56b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?53idKFbTE0omTZSI02Ae39LLCOaBLOJj7DggVnr+6b+mFKgq+UyrNCryXB+v?=
 =?us-ascii?Q?mVU58o8FehLpzHvuhvEcuwuJ5X1MR9Ll/CLOuCrU87WC77i4BvMFsavgtr+9?=
 =?us-ascii?Q?3dfS4P40j2mWokBaoNp8RgZ7e7g1UdaTYcIiL6OOnlgI3xSnDBSfXEJD7wAY?=
 =?us-ascii?Q?hbI5Z794QH5vhSWMcNFFpjBfYnx5PoC49BGo7LFpvLFOJcgd1OpblddP/jrq?=
 =?us-ascii?Q?BCGl6RKhezM4C93XVYyIe2XqITfWXhtcKIBYQs1pGSFQwHBjVzebX6q334Mg?=
 =?us-ascii?Q?Hj2ZiOlHb81c5soLEz8Wu0ryus/Jmy3pxwW347AFZ+at58hbDELYHmjq8nzT?=
 =?us-ascii?Q?CQ3nshYiE/mpCqg+zZ3MZxbWKM5BrkbNeHWrcFO3DFomEzcyW8NwOQKRbY95?=
 =?us-ascii?Q?9PqSmMVB7sDGLgcUccqys85omGBCcYATQm4bjtOcPp9PVzXtAaJL+wKYt/qi?=
 =?us-ascii?Q?JBaQx+GnB/QolOmWinzHPGRn6CMccT9CFaIDcGnmiFeL3nASA9Th/ObOrg13?=
 =?us-ascii?Q?DwOpB+X8XY0tgCtIDmMFLGHmJ858UNdaDA1SL1QWR/88vunLHlo+69jtFai/?=
 =?us-ascii?Q?Y5W5Kk5UDlkE5A4ciyjIwm6wn9KConV5r4NNynVfll0aj3JQtyMmVgPEQyCM?=
 =?us-ascii?Q?/3JENl2jssSCGSl52n3Z6CPJlobDJSQWbuei2O4w/Pu0F8IxvCVFt1Vcwjao?=
 =?us-ascii?Q?eRzQEwre8no/+nHkQj62+ts5yuqCvApnpbIgpMjjgf2LEhAQ779bcxUb0gWu?=
 =?us-ascii?Q?oRIlVuijFiQVZWiSQiBlvDomxke0cOElmpbIJQH8ILg0XQG5L5GN9XpQZX9w?=
 =?us-ascii?Q?wsorFgkUk8adubsiycUDfW0RCN04C+4QhReBFf1qeAU8+fNf/kujYq/Lusc7?=
 =?us-ascii?Q?0HmIImXzQptkIgdaiwRSZ1cnMpmfIF8M0IExr9PBQcMCrnzutClaeMCgI8su?=
 =?us-ascii?Q?9ih4npQfh20xSqGYtcVn47gbd+j/T3XHKU5HX7PGOYltf6/4O75GuyMY7bbX?=
 =?us-ascii?Q?Xa4ucjc3eaUAAP+Uv1n9+yRyEM5lB0AQVtGt+GNdlfkIU9IYdMd7UnmcmlNq?=
 =?us-ascii?Q?Ap55OdtF3w8WrQ/N457dqpMLMY/tTWDiNoeRN+pvwgzhZ8e/m4OR5l8jHNpY?=
 =?us-ascii?Q?2OTt5NLH2YPx0wP+jJ8YwoHwVINcBfqc6ssfbOj5ch4SmiGf6OQCUHGeslV6?=
 =?us-ascii?Q?HeK3UYUstYeKYhgk7rc2HtAx6go0FJztZ4IAsUiOhVxxdaPQAxhLzq/ob8xI?=
 =?us-ascii?Q?IcpWOh1U06nZOnSyYtIYcowGFW+cj/rr1Ax4Ckp29rNk2ucYCNPZogbV4X9r?=
 =?us-ascii?Q?+bAaSL4W/eE8R6P6SG+SRXImOa7w4C/NtYkJXsWIeagRfx1viW/KVW0RLLBq?=
 =?us-ascii?Q?RPU1uIv+VCKmp7Tq46D5DFlg041F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73gcsCLiVFq7rT7dLLdaMYtpNiIU6mpeyuYT8dztgY2QgqYgrlc5j1wiOgyD?=
 =?us-ascii?Q?Kn0dF8Kvv8vFOZwPSfo5jmaBS2ZG1AbkETiXmgROl4ezD1Aky87DpkMHdjl+?=
 =?us-ascii?Q?CH2Atgx+k3sOYmLLRjPI/81PNFYtQ3ULAaPDWKwJbcNWLvmU1x5v1K52CsUR?=
 =?us-ascii?Q?Zn7oeuqbJG8lOk5TIblIUJ2USH5QPc1Rjd/FZwF39VIXWt+p4Zc5RXI3ScsR?=
 =?us-ascii?Q?aY3FQ714cneHaBdS9ZJuUL8pRzM9hJKxElx2tR/VEf01EHe+Z/5GqMDKsIvP?=
 =?us-ascii?Q?e1EI0sj5w9BoE45P8gLnibdNxHq1gUJzkbrA/ZQAh4OmB5YRpjydDcVuEtsV?=
 =?us-ascii?Q?HsBv/vTWQlbXqg+2KR6fLyn/6hwJQl5qi5jhZtU6PDewq8I7By6Q0toUAnTR?=
 =?us-ascii?Q?RRI5+MhwHtJrE4ZPczVXLelMt4ssWPo/5QeeadgOwbVN2fO9LbLyo6KVDQPh?=
 =?us-ascii?Q?eV/LmuVr7oxTog8DjENGlEsVZPZqjhdSdkpZ/VcgKvCQK0A7zd4DsI2mwMYZ?=
 =?us-ascii?Q?TgL9F4bia8yNqOdDXL8xtEsErqGb62mZMI70prlRifkGEfKs0adfODZxwLlD?=
 =?us-ascii?Q?i/lf4F0erIVvFj22A3EGS6kytrBloSqw5Mh2zrtRI8VyGPM1Qot/i8tCtm4B?=
 =?us-ascii?Q?lUQ6tDtxoSc5F2tJwCquOd9bRqDLcLMuJXKGZ9c7mwiQAye+7yqP4IP3EKoi?=
 =?us-ascii?Q?QCWESrEl7Xhz1x8WOW/5/ZJMuR3pRSUGx/twfTOrPaneYP/NbgGk2DYc/Ya7?=
 =?us-ascii?Q?HBjUG76kqJ0/1XzgseCYR44Go+owSzGqQJTXXHqTUFU/3gTOz3B7jERlK9SO?=
 =?us-ascii?Q?/Epvxpegch2JK5IYyr4u//l6zYsFBVTcH/9gOLrk3FMFaBBFERRDlIJ1RFXp?=
 =?us-ascii?Q?fwr3w4AvJbEJD0su9vqZth22qpRF8CwgeMunX8nYQKu4qlj/fMXPF1ygLurd?=
 =?us-ascii?Q?apBp3tIgb7ek8IpKy9Rop9WobH8LGn/aiUPO8Av4Us1XGBfijv2usVjmEphs?=
 =?us-ascii?Q?7Ucq8OUU3FW1ND3bA+dZGc0Ggp2TDS/q9TgvggWVLnVn2coGObKw9nq62hsS?=
 =?us-ascii?Q?AVHDwj491dnPCFe3bZNU8y/PbZJ4iyjhKaZ3qaSBbdBK9TIWH8sLcai3EkfR?=
 =?us-ascii?Q?knKlgbvRGECne+c152gdQwPLy2u4lHv4RdcK2D+Rr3QvPZf4fflW1rQ9BGcz?=
 =?us-ascii?Q?Yd341IOBda+c78Lqoe6pIH9Rv0iGqogv/X+RNyNDO5GLbB3XjwwOpRiAiDSD?=
 =?us-ascii?Q?EEjBKkVZlaYtXOdRUzdKuP0HuKrVTUvf/uTdeTXy36f3navAnpV5yOQKtJE9?=
 =?us-ascii?Q?9pZrkZlQxLdLk7Xs18LTIaC4FtL56IPn5lfTah1KubGOWy6N6r9NhuPcf+3n?=
 =?us-ascii?Q?J+p2fJUDyf8kueOp5n90xh1K49fAJkI1iVSvbqilZ9QPFDs8LUU862aL1uQV?=
 =?us-ascii?Q?yu64FlZJ3q+vb0muPFMz6dh9mcJ8I4tJzzo9c09r/EemYMOlZcYYl01B3GSL?=
 =?us-ascii?Q?1A8rGPzfJAyPk1SQZfBr+X1W9TawLLwqR0nRKvVAJ1TvfExquyIcHhhM7sLL?=
 =?us-ascii?Q?S+73jse6qrmTv4/WUmAdp4K6OdLJ3S5jUulJdrZyR+pJYxsGQ6uy/uduMwVc?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcc6446-e5f5-4c07-757c-08dd715c56b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:32:36.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mhfILSY2cnTIL2m8Lz4F1tQCwctsJOewPpjF9d1LuEm2VPIAJ1KyEfzPRcBfEeX0ff63DKNCgEc9frANBtF49ItE84i9s8045GBKjorQPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8791
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Tue, Jan 14, 2025 at 09:32:54PM +0100, Fabio M. De Francesco wrote:
> > +/*
> > + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> > + *
> > + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> > + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> > + * the given endpoint decoder HPA range size is always expected aligned and
> > + * also larger than that of the matching root decoder. If there are LMH's,
> > + * the root decoder range end is always less than SZ_4G.
> > + */
> 
> Is there any reason to limit this memory-hole handling to only low
> memory holes? I have observed systems where the following memory
> hole situation occurs:
> 
> (example, not exact sizes)
> CFMW1:   [  0xc0000000 - 0xdfffffff  ] 512MB range
> Reserved [  0xe0000000 - 0xffffffff  ] 512MB range
> CFMW2:   [ 0x100000000 - 0x15fffffff ] 1.5GB range
> 
> 2 CXL Memory Devices w/ 1GB capacity each (again, an example).
> 
> Note that 1 device has its capacity split across the hole, but
> if the devices are interleaved then both devices have their capacity
> split across the hole.
> 
> It seems with some mild modification, this patch set could be
> re-used to handle this memory hole scenario as well
> (w/ addr translation - Robert's patch set)
> 
> Is there a reason not to handle more than just LMH's in this set?

This discussion was referenced recently on an IM and I wanted to share
my response to it:

The rules for when to apply this memory hole quirk are explicit and
suitable to add to the CXL specification. I want the same standard for
any other quirk and ideally some proof-of-work to get that quirk
recognized by the specification. Otherwise, I worry that generalizing
for all the possible ways that platform BIOS tries to be clever means we
end up with something that has no rules.

The spec is there to allow software to delineate valid configurations vs
mistakes, and this slow drip of "Linux does not understand this platform
configuration" is a spec gap.
