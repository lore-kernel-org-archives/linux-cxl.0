Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED26CA64;
	Thu,  3 Apr 2025 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656299; cv=fail; b=dOyQw2W4FpkE3aGu7LK83plu27iHtSC3NZUrxhX2ePLk/w2w/LBvz+NJH07qFumLuVJ9a6Y0LhrTY26dZmZLij6Y6R9gUZXXvaYfg9qN5WBcll6PZGR0lzwfivR4FPFnZM6td0AIkW143N9cwNgxEswg34WB8TrjU421loadPPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656299; c=relaxed/simple;
	bh=zhX15dT4Az8dfBI2jfMvl/iQKB8NzM5jY7jTdEDvS4Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pIXLGRUCL5CxsFVyN8kEwQ5ZeIi3peu9UZOnQX39zcQPlluJ+HPg6u7zHBPjsp3jOejyJNMMXR0pnRoXfvdpeMWhl1uwqapHEZaDtOVyrlPpwFtDnLL1qKXgO7uAyKNgzkzTaofykD8IlCwZaqMLTayp/SVaWiG57mwNje67tjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrgJbyCh; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrgJbyCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743656297; x=1775192297;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zhX15dT4Az8dfBI2jfMvl/iQKB8NzM5jY7jTdEDvS4Y=;
  b=hrgJbyCh4y4udoPD9SsnTBt6ynddYF83xRaZv+gtvewAcUy1G+1OFI7+
   KpB/ylZxYUg3rGJ2D9Bf02DEKs5hAoDrO8ew2QeULOCrgH4cKzwvcuWvv
   C7krHRDNEetv9VV5INCMAnN7A+Bz1e4b3VH+wDO47YRyUNwKPU9e9aVti
   8AtY6C4srLDcTfRouXiHHtGh1uBM8PDRqdYk67dC2MOarY5EYY+t31QSs
   qLERMW2Fx+8oNRodUczXqYuOxKFo50g1rL4u/M47usIp1lpY6ZZ36bkSx
   VTQDi7tVrcA0HVmBxyooQqQ+FXeBf+IQu5OvD643AyhHMtPlhQGBeMq/M
   A==;
X-CSE-ConnectionGUID: AQmyx+7GRNifeJ1fivPmhw==
X-CSE-MsgGUID: min3gdoZRyOudeG5es+piw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44940492"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44940492"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 21:58:17 -0700
X-CSE-ConnectionGUID: qAGFLxsvTMSUOXzZwS15ZA==
X-CSE-MsgGUID: 2lFt/fdkS4it36cz5jpkbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="164126552"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 21:58:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 21:58:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 21:58:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 21:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCRorihXFCzmxnsMFuStvqVEOPTnMZlkvn/umKkUA8M1eV6iNHM+swbT79Qh3SKynKpOPbpcWNOnCkmed1GJw9BTMlNLJsyQ2yxyQRSN92ci7MqaogBvp+NeK+OLT6VM2pqwQRD5NhkIlswehybXdzWBCw+sT2TNAFB4zk+Km/vr31OXX9A2YizQX4ikF1wraKhO2MLX/TNxXyZP1XMNxC7h/hT3ygkFDHLb+XdFOzqCPhpFsm6k4LswUUJ73Ami8uOUWO3kpvbEKd7mkoq7nhbeg+tlyCc3AshPv1nK3uYWNGwIfoWEcPbYelVSX2zay5cXY2rNXONJyWXtzg7xcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA/uxszyU9bh8Yja8D29d7xZBVBZnAHVmsEzn8xuN60=;
 b=tfj7VoayD8VNo4RFaoz0ccseo2uYw9hQ7W1/s7CM+cqRBatgJxNUAZIJDga+U0mDnMJt8C3HEV1ehkASmGivJjVSvEkOBSvh0YGqospBNpgIJvORyi4V7KGNg5nhdI96Vs354dHGcixn09fpmbF4Elp5UEkNrY91bs/999kE73h6+HtNc3q74bNpUWCXILDltcYSxVzJ2EZlAdPYRP7t2C9PSIZ2/SRQq/Bt8/C+EHvvaVNcumv5Ge16Spl6PHTSIhe131vepB8pryIYmfGM0VodcrNwe5w88AW5cXRr8MU3jhA8yWHIG2+D+XIbWgvlzt6JN3plgt2rsSeseORDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 04:57:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 04:57:32 +0000
Date: Wed, 2 Apr 2025 21:57:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, Gregory Price <gourry@gourry.net>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: RE: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Message-ID: <67ee153a1922_464ec29421@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250402232552.999634-1-gourry@gourry.net>
 <2ce69e60-8a13-4e9f-b28f-1b30162a1ada@fujitsu.com>
 <OS9PR01MB124214F1E05F7D27C50591AF590AE2@OS9PR01MB12421.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OS9PR01MB124214F1E05F7D27C50591AF590AE2@OS9PR01MB12421.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc69b63-7594-49c8-8858-08dd726c0aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gJE27AJowL+7N4xUjVdBs+nBz5KCOM/7grFIMR/sOwB+IzEUjCSKWGHaxA/b?=
 =?us-ascii?Q?Z7n44KFtGRBkBALIAW9jTWJeIZjtD12zf4HiMQ3EfvSZrxwiC9Bn8Gwq0nso?=
 =?us-ascii?Q?HtR68JT/JiNBK8ZuxbzINkbCd5TGiX5krDPNOU9uiI8XSuEFjTLL+HajD1Dz?=
 =?us-ascii?Q?FAZivJYuUliUnXaF7DKeMxA4NlvZm09b0E4XPE6n3Ihvu2jGyxq4442C1WAb?=
 =?us-ascii?Q?6MBw8Z8fKYjwVZc1Pbue+k/cvetVuEFc0p60fdWcPzSKEDUAtBShX0Jj3cIn?=
 =?us-ascii?Q?44BXkllH8uaTfYYUKsJkMpeRjM609XKXLgV3srUm/bA+uynGAObxSAK55hdS?=
 =?us-ascii?Q?5k2fysYEAB6pSizThdtJSNI3DAh/CSlz8ORV9AEzzeLKjHcKBJdVy2UCqMHK?=
 =?us-ascii?Q?WPcAAbNej0PIk14E6RBLhm4pCr0oP/2yFW4I+b5v9/Qbv2BXc42H/yGRPl9R?=
 =?us-ascii?Q?GXIlOGhVH9wsNuT1MRdapi40GM7ijhHzymGxZSkOUs7pKWRBdn+pLjbrNMQe?=
 =?us-ascii?Q?fmYOCs+9rEFUYRxnDxASvNCFnpCHyrnNE+ksV+xIku8zkZAO3cmuabDObPtQ?=
 =?us-ascii?Q?iCaWswR85bT14zSO0/HNaOgU0nFPVp3kVHUIdRaTPhGqyDMcIdAH32hK+BJE?=
 =?us-ascii?Q?kDE2aMYpUBWGdvqA1oBmBSkRjTX7hHWayo7aMsUvM5Cc/OLaxmP4q+uyWk5x?=
 =?us-ascii?Q?/qa7rAtaZjc5FIxLiFeu499bwweDnWcNYWHDR1ouEpjawEC3pG54v+uhIhy7?=
 =?us-ascii?Q?1m8nSpQ/iqu1D/I2g9Ycj+vbDr0SwXBQFDU5G44PrWrOPKCzhzWuKiiFR1wm?=
 =?us-ascii?Q?1kUGqwMu5kBCF5zTQhLuaRvXbIRvUBM6VHko+C7b3CBbuNBUskG3PCA32Zd7?=
 =?us-ascii?Q?uIQoTZ13gnKlElTGmRxVufAHMZuiJaIHUu/pndRkkuaVtj5mEF6MMAtzo6gz?=
 =?us-ascii?Q?9mxgmljky9LQyPLggzgzmj5GsMuuWRAo7C424wBtgPaNH2GM6Nm370ym1e64?=
 =?us-ascii?Q?/uW0A6o5QTJw1Vgc1k87zioe+kr07B9B03HWynD7V6mSfTdkLkQoQS1CuyPX?=
 =?us-ascii?Q?WGyIKDcStcydWgMKEmM4XQmfWkkMGlXTPB6q+Z9W6gdwbFNlU532gUlp7qEM?=
 =?us-ascii?Q?Cov2u1olvAgxnwE8NBS9JFKofNdtpG54B9G4Cb1OckMcT5BBPwbdkVKP8LOV?=
 =?us-ascii?Q?HMq0IK6cXdrVgY+PKZIjELlzYaRJ/b5CCVid34NBeLSYTb2z4dt/ID2HDLL2?=
 =?us-ascii?Q?bLcV03spLXWtEJeYtt2nq+VMG5Nm8rrxTVVuih3z0+7iTjmbvg5KZiXBnYzd?=
 =?us-ascii?Q?x1yBeQ0kkJ3ha9LlCgpU7/x/Hd0ewbL+PXM3f5npacu8uQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C54jUdy6y5vbj/7/60GTUr6Ie8/oMwbH/YSt6sn/nP9eFV80a6tHXM26nfj8?=
 =?us-ascii?Q?abCkyx+CD5+eF2Mshj0UbFfI97NZWDajkpwR6e4E0gCxoemHLVIptPygYcL+?=
 =?us-ascii?Q?irwNb5SwyX1bK7LgKzM0vDYfqCja7/do3G5AG/pTpZqkBewTmkJRMlh2Xyzb?=
 =?us-ascii?Q?NaAHnaELpj7eNlAVag0NQo7KT8+0hJBqzPbYWFjC/0qheczExbImTzAEHqgi?=
 =?us-ascii?Q?9BdtHOr3urHrLFgiuyRNjAxNlTmt4B4fc9UOY0OY1GlbQXh2qrdY7Ln1uD6S?=
 =?us-ascii?Q?EpT2vMmQ3hBxXrjOId8QffWUu4CAmaRnfs3iyV0GeJdYeAtwVBkO88quic8D?=
 =?us-ascii?Q?zvdNezcv3zejFsZuuEYgaRYE+J8mElvdbV93V1DaOqwuXw4WogOrMcHPh4qC?=
 =?us-ascii?Q?K99MEl41nBo3BHceazXoujj4AtTi9Zqxoh6d6ymfaFglEO26xNqXDzW2I1y4?=
 =?us-ascii?Q?bovWWpOxf/RrD3gzvZ6pZMeyH050aKHEbe2cWWjRwdwc8RHstbmdnWKXF5nt?=
 =?us-ascii?Q?3DSktLW1AUpwdSDrKH3PzGx4BB6k84sQb8Kpd27xZOtBNxpH/fyc9SK4NdoZ?=
 =?us-ascii?Q?Zt1sOBP6Mepd48sm4koGssJW/H3Y0su9qJyEAZ/E4O8Mo/MV0lfLeGXbjU1c?=
 =?us-ascii?Q?ecse199bBNrWre9SZfoXQc5FYFRVlWGbmXaBQjClxpDcKonv5KM5bcE0h+Li?=
 =?us-ascii?Q?tiVlDXI28pa97V/7SzktHbDpHZb6Tv6hT1b1xrjOMCvjXiuJZ0AYy9epixFJ?=
 =?us-ascii?Q?F7zBZ5D/rAufsPlMkhQwdaKGwleH2PujnGAQNYNbi1zzLdOMzdeMliLcqNfd?=
 =?us-ascii?Q?CpPljYQRuZwRS00Yjlh9AwrpMDTAZQouUi2xjU6K88kxgFdTP73xdkc9v6DL?=
 =?us-ascii?Q?Fdk0o5O3nvEjTP1p+f54tJkaon78MZ8zaqHpnkAaaZZKDtmQlSvMIkDLxz71?=
 =?us-ascii?Q?j34ZB/eApi6suQKfvRG3ksp7CZKKBLwDpcELTEn0TXM2YVK8P3RwLQUIN67C?=
 =?us-ascii?Q?C0LR/smRRvtI2t5bdZvkevs4SZJvPY/u6SWKWSRQYykfHxp2uLGnIWHFR4/p?=
 =?us-ascii?Q?cTRD3ojWUauILcjO5gMStZUnNe8is6cz0k3cZWLw37Kyjx71Llz1eXCpD/Ze?=
 =?us-ascii?Q?pm/PJspV9a3DmGJW+qZcNWCPDN39ZokjBgGAm2S+5Afk1V8gGQPhw+OWpk0k?=
 =?us-ascii?Q?g/6NBaxQTtpv5UeI1L88bhoAAFblvIJ2S6/nziH6tUV04SaCSt9L233rOjLK?=
 =?us-ascii?Q?KTlRzO/UnepQfVxUvxQBJSPd1VwLeILUzBGaBPf/ykDP91jixp0rCszbfJcr?=
 =?us-ascii?Q?8uXysEbp3pWDWS6Gt5oIVGUK2fLCQxW9xGK1R/BiNTMf1uSJ9X9mei43jD8I?=
 =?us-ascii?Q?zGJieeaphZo8UYprHsrmRvvoHHzEO7XYGN4DcSTVtSx/8xGyW7d9ij5rsJDh?=
 =?us-ascii?Q?WGci5nlGm2out08CKwDDUGtVIYmyXB+FCK3XLeMSyf8mbcuHpqN6lb6BIAFE?=
 =?us-ascii?Q?gawNQHe+sKEmGWHV8XNB2CRTrtZJKgcXrQIU+XkQs++E3tRo5KU3LWZZVYEd?=
 =?us-ascii?Q?I9Kn46EzVNKKzMAvfWWkQXVIha75A3j9bXagBlg5kG/G35nkGjRK+Io4ZmJe?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc69b63-7594-49c8-8858-08dd726c0aff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 04:57:32.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +m8HiDqSqmAYgt6svMSZR/KueNeLcuZjluIQCmnWMy5nsuIEDfJvuTqwQRr/JxdbzyACc/cZvA1qV89+AzZvYxE5e3SewBHIAZM3DC7wUeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
> Hello, Gregory-san, and everyone
> 
> > Hi Gregory and CXL community
> > Cc Goto-san
> > 
> > Wow, our platform has encountered a similar issue, 
> 
> Yes, I actually encountered this issue. The endpoint decoders show the granularity value as 1024 bytes,
> but other decoders show 256 bytes, which is the default value, even when the interleave setting is one.
> 
> As a result, the error message that this patch avoids appeared, and initialization failed, as described in the following email:
> https://lore.kernel.org/linux-cxl/OSYPR01MB53525FD64A9AFBAEEC1E19A390112@OSYPR01MB5352.jpnprd01.prod.outlook.com/T/#m811bdd93bca3887b4c14a2a20b8f21a77dcf2eae
> 
> So, Gregory's patch is welcome for me.
> 
> > and I am intending to consult the community regarding this matter.
> > I drafted similar patch locally, but I wonder if we should "ignore" the IG or
> > "program" the IG to the decoder.
> 
> I'll try to summarize Li-san's question.
> Does anyone know what will happen if the CXL driver does not program the IG value to the decoder?
> Will it work correctly without any problems?

The IG is always valid, either it is the default 0 which is 256, or a
stale value from a previous configuration.

> My initial approach to avoid this problem was to "program" the decoder, as shown below.
> This patch is a very early trial version to avoid the error we encountered.
> However, Li-san's concern is that this patch writes the IG value to the decoders.
> Is this "programming," as shown below, unnecessary?

If the decoder already has iw=1 and ig=1024 when the driver first
enumerates the decoder then that is a platform BIOS compatibility
concern where Linux should try to accommodate without touching the
decoder.

The concern about writing to the HDM control register is that there is a
lag awaiting the "committed" bit being set. See cxld_await_commit(). The
spec is silent on what what happens to inflight transactions between
setting "commit" and awaiting "committed". I interpret that as undefined
behavior and is why the driver is careful to make sure HDM is unmapped
before changing decoders.
