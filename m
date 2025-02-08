Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1484A2B
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 01:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977886; cv=fail; b=at4+GfOtAGKgbsTBIUhQeOGSoDQpDv3I8hdImhkU+OxweJf82Xmv//9d73/cIhYwZc4UA+DoduhevPnww8B9F/jr5JskdDiIqxq3LjdC+q4elmH0CPTzX+67BBW1qaF7S3QEmHoorw9T9YmwyF3PqQ8/oI1JbxMVZXuyMLM0iJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977886; c=relaxed/simple;
	bh=vFVgpXlDwA/koXQlOeJFTPJOFoVodctmZJI3wei6tv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QLsiIb3nzEecj9ZkX04FQelir0m6cR1VRtEDUNuXyZdnqrpiaOWgljPBDlH1QlDTO9OBqI4F3mdblQ3iVFEFYIZhI89+Ybjg74gdMMMk250xQMfnN9+ogLwJFUKwvHkUejxL1Gt0/1dGqXOAEwV4KS+qL+l8m5Rm2tzS2QInpzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfhDKsRS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfhDKsRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738977884; x=1770513884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vFVgpXlDwA/koXQlOeJFTPJOFoVodctmZJI3wei6tv0=;
  b=JfhDKsRS1DZUhcM6Eg7lvpQ5Ws1ImJQGfkRN0Qv5ZQq/DHgeJmN1hMc3
   ZpP5OkInohcYdIGgKZdqYtlkf6+cUC3tYzP24W+7YoHdSAcn0lXr/ITEH
   SrSK5d1sMG0Mp6Zby3VsP82/Zrm6PNmRIPjuOGrypIbMPzvWkMmqPhfJv
   L0YAHD5dqY9kzQUDaTX6Ke73g4vgF9TkiJCr6K+/5BPoB7NYjTeGHhwjm
   lUL4DqLvfADdY7MOUsipqBmJp5gsUs2Agah3aF3+0Z3zlSR6bcvnzg6DA
   QnbdlnupQn1Izm4zxV8WJlVBnZ3GhSseQ2NLcaoXe/YSWBUiI0CWvis72
   g==;
X-CSE-ConnectionGUID: F4ImqzcNSeGM8cYIW6VQew==
X-CSE-MsgGUID: 3kaiI9pzQh6NX5xoYBE2NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50613440"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50613440"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:24:44 -0800
X-CSE-ConnectionGUID: 4yxXAH1sTT29zdFj/MDqBQ==
X-CSE-MsgGUID: a0K4TWWGTfiT3uwAZfajBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="116719844"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 17:24:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 17:24:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 17:24:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 17:24:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8CVP4xEFsPNtpB0lA2kAZh/Kxph2K3olCBXZqNLxxa2tG73P+PhtzSSWVYcgJJxonGCpzbwGd9aNToJKxMWaJpzsUuU6cbmiUe8KZZIP7GN8ChV3DtP3ozbz/LvcboOpt9+opSZ4IInNxCH/eRa/3FBoT/uZKjcrfcTGnb59FcuJOa/19aVU58w1+rS7/wwnM/DJm66IfnOmnY5MMgUiAMlSM49FzqQtUkcXtLuZaSEi9NUt+QfULUPoqNZMfCQqoEsk65gJhPsxWi/53hnO7srcvDhiYMRerhvwx+JVpa3cvETwEWYW7erBuejZOGP3tk4+UFjnqw/7+cOJizzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhiuC9p9WKOub6oGyfp7CH5qeny5YOIjWprBn4FYHYo=;
 b=yRPcVirWQ1YUmkMmi8bUjD1euo0yW0AGf3A6oKgr86j1doF3Yo2nPO4oQ3YlEZu4XdwmzpF0HDch3lLme1kWPlRtGBPKRU9ELfKnZXY08p4h0dFv+FpvV7daO0qVkQLmcSPQOSjww4Eht1lIaE6OdSE1+J9XVwwXDXIFaWIhNg3vzzU5Yd3s2VrC1mHRtczicg50WOkY0CsuK9Vw5m3djBLYgbai6W7J9mibzwVogUeqMgRI5Hmt2OxARLn8MbucikAaxSJUSkUYxVceggVi1vYqjoEeam9VxhaxWFOasqOUMga/29drHtXuLsP4arNb917d738yvR9mIj2DzYHeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sat, 8 Feb
 2025 01:24:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 01:24:19 +0000
Date: Fri, 7 Feb 2025 17:24:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 07/15] cxl: Add FWCTL support to CXL
Message-ID: <67a6b24080c9a_2d1e294ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-8-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-8-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:303:2b::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ede463d-e801-493e-3424-08dd47df4f44
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WAOrzk0fLuzTJe+/z0/QVT8QyBDg3s6vqc/DDQozQO9QibFKcfEEjB5bs5si?=
 =?us-ascii?Q?q9VntXkY0tNtJ7Yr9zj7nJsH+rlCHBo1mQi/ysR2bvDF+oe8irGTDwpWZqi8?=
 =?us-ascii?Q?G5eHhZpzSdUqqwnQsx5xImiAoab9wx2ZsDXA3fLQw946oUkJ00AJmBTqJO+U?=
 =?us-ascii?Q?DTFmZigkEAym+jxiip/n7DHvsQ7ZBqgr1hD8zKHrCTLSjtcOwSjd2a+SElSs?=
 =?us-ascii?Q?9c0zYiH0OIiEtSVDtue6SvFe+9fo0bmVErwMClPhcFZt3RGLEw0laLpkd7Ni?=
 =?us-ascii?Q?nmvi7r7Y/uJnICB4WliMyqFWw5M6xykdMf3Aym8CWTP7f/fVtDuRKqXmE9TP?=
 =?us-ascii?Q?SEKTwDqzFsGL7B6BU/gykK1Jt/b6VPz50lCWQaZiFq2D9zeNEn6voL+mwRG+?=
 =?us-ascii?Q?o0gsGxv9TbJ5rcJ1GZE1LCM+/LoHh0hnTiLBjyoY+GbUYruIX5APqsdrIpEF?=
 =?us-ascii?Q?jXksu+0PE8G1ircJPnb+DQPuSS/3DumO9P8BFEmmNTBxKS0rG4GsmjY22szS?=
 =?us-ascii?Q?ZTN6oZ3Jx9Tgc/lLddBg6LvjCVE9US9+4qW65u3ip1Hysa5BzZQa/sw19ku+?=
 =?us-ascii?Q?/sOTQSs0mpR7E9+CYGJSpaVu4Elcbc78YX3mM6QrCxULfHurkojQBXCILNP6?=
 =?us-ascii?Q?gJ1xpxAhrJFC3Vmyz1+gdMgmYc8YNIiZB0+ebJ89XPsg4tu8njMTohtSNcqM?=
 =?us-ascii?Q?3cGPbujY+4X2wjFiNZcEot4Mhd4VVCbfxXM9n22QkIJKo0QfJgKGGIoPFESi?=
 =?us-ascii?Q?ItzjCQ0i0s9RFRgqRFShabjr6OEbtsQhx7p8br7gFIZ/pOy1AQV3TQBi0QMb?=
 =?us-ascii?Q?H0/VSKebbpMTPcJaKMCTH2zcUDKtOHp+0jYbQSIpnZLlmtEJQsle8CbaLw86?=
 =?us-ascii?Q?Gv/QVgEc++vmuFGG9LZnpxNXtrWqYM+Iu1LsVp5mS7F7Na6b0hlSVhNr+0cW?=
 =?us-ascii?Q?m1aTyR5pJdFnk/wqs7GQh+GTEXLcFyoxPVf9XVnMbb1RSrVMSycdZYlCsfEc?=
 =?us-ascii?Q?5fsjlVt9Y3YB4xtZ+87xMX9QCjvmoaVmDutjSLbu8IzvK5cl72SzoIDrkSOF?=
 =?us-ascii?Q?YMLfrDLQHo4COYsShTY/AoY+zJpgtYAcCyeml0djHaiqvPQLZzTEV7ZtxYP+?=
 =?us-ascii?Q?DaFUWT65XY4LaSqsYSI6yX4J4c7QE+RUDzcOfjur51SEYZdcP/s6a5a0uqHB?=
 =?us-ascii?Q?IzxUSdC/GgicCG6eTtJ9HCOa8YGaVwehM16rI35ZR9eNSkInnn3f21XvKhaV?=
 =?us-ascii?Q?Hs8nX4PxUUOy8VHrSgyktAqdstJa/tFuwUwniARhLoYjIofTldNru0LlvAXe?=
 =?us-ascii?Q?cU/5BJW7RP5Ncazppay0V+qm+NMa4h/62fFcTqkHwUs6zw8jdiIhsJoQP56z?=
 =?us-ascii?Q?hobYrp/WZ1xLjiUmyqenhsDz5mta?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dqsEEj/id1ohHacNKwq/ZdX6nLyLPGsA3MCAU0PABNAJB4Drk11vDaOiax3G?=
 =?us-ascii?Q?EpQ/MQovH56g4IJ7gvnF+SqI49bcNqUyLnPe/BD50C/49S8p61STc5zkRJ5C?=
 =?us-ascii?Q?k3GO1Zw2JQ6L8+tW9E1udscnQNyUdXbSDWoTRYRoEj+IdvEmUFNiVrRFUwQP?=
 =?us-ascii?Q?nMpVUTOW8Lv9vMyPGKHsfOGQZA2/NM4YKE0KLegi2N0mQplVa+SQAi2wfoZv?=
 =?us-ascii?Q?QlC7sWKEtWOWSzI3380E2RPkCyHws+rDeAOPXToipr8ta/TOAVrdCMojoLgj?=
 =?us-ascii?Q?J0LsLtabmJA7RgCK9dibdgIeXYzEqM0x2dcrGv3ftXGyYoqogzDeGPpDRUDe?=
 =?us-ascii?Q?LTzPDAsZp8OTVaVD8Uy5DMsWUXgMLMishz0hA7iRE9lhB/uBwnRyJHNw3QVa?=
 =?us-ascii?Q?PiURhBOQYW3NAEXpFiYmjDUt7zw5dqwSXtxgRbExKET68EfBRCkG+3kITi0/?=
 =?us-ascii?Q?C7fHub1OjaAlgvzbxeZMXZnAd1zht2VMNTpGllM/KFT1UlCAh9lAhfyzSmO9?=
 =?us-ascii?Q?YPeooIygBE4KU0+7KCfo7/OZ7Ypg4djHnmWrwAE6lj2IID1oBqSHThBGlTXO?=
 =?us-ascii?Q?MZ6mJEOQzJ7q/Z7yHMauZEkafCTxuUlWbWplYj05Pc1eSo5hgrncERa4+jBa?=
 =?us-ascii?Q?gcNLQ7zQkGSvuLZp4Ac08e65YdHZyzTq6MxhpnAwRBG3M+80WBtZ/M/PTFWw?=
 =?us-ascii?Q?JV1xf5hynOROtxX7hSgewI+G6iZ5Z/0I9xf07RA6SGDxbLJN2Gnv4yu6cCwh?=
 =?us-ascii?Q?hmYQ22lePWg2XjWSDxx0gZ97llt/VGU2jJwqwGQK/1WsoTTTKkoRhrxRAs8W?=
 =?us-ascii?Q?/AbcWNG2/+GlpmlP3kqsh+Rd0UtHWm2a6tH0D3sSZ41e7T1V1u9T4JwMkowo?=
 =?us-ascii?Q?WBxmYO6sJfelvb2Zj/1jT3lpr9MGeKwNvirfOoFLRVwf5xXoAG1/ZGTmah64?=
 =?us-ascii?Q?pcPbt9lZSnTNYCJq1SOWwkdVDDkMKlJNQpfcKLEMsUgspYv7QnKmjEw/jySE?=
 =?us-ascii?Q?fo5BiRsGONkTKtQmfYKvSNIvg8G01oCRg90GKE7+OByt0WVGKMI8HcztC0DX?=
 =?us-ascii?Q?6SlG+iMRDNdBqQHUzCSySjnRDigz9ha4iYmSWL2/Wa9Ots+jIwqUGZKymtvL?=
 =?us-ascii?Q?CTCo2zctX7MuGrNkHSe354iBSnXiMTiSbJJivLhrdQuhXPl9vVjZfSjuUOJr?=
 =?us-ascii?Q?juaf1nmMqHk8R/zdhXyC6bkQq+jlGzC4Rfdut144Ki1aJjXtdEpR6Lo55PL3?=
 =?us-ascii?Q?CRVLCR4Qp/QaIaWTVY8WS8PNFtqCkrzBlCJaXDfDo1KXSTrjsdsA5MfLQYPa?=
 =?us-ascii?Q?4nDr0rVvjSMSh3ojodcN88CH93jFwlEETnYhD6WSoqU3LvdV7R/TMhFx5YvX?=
 =?us-ascii?Q?qWVHNotTHn6Arum6bmcF9pjhk6eoBaNVegw6rYefJWyQL8V3shKVXyn08uCk?=
 =?us-ascii?Q?ieQXuzrJuFXG/BK/H0o/7T/3r1/BXpqb6es42N7wiJ/RPlju/j/abb7W9WJO?=
 =?us-ascii?Q?9ntJLG+ZbfrQ+74djfI1q+hiTQBUJIhwoC2StSit7GjvZ0v1l9TzkeOXvmrz?=
 =?us-ascii?Q?Ie0ffO3PvJZ2t1Wd1R37rp7lNDXsyIKr4IvqButtgzrTB7vcSG4vgEZPePmx?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ede463d-e801-493e-3424-08dd47df4f44
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:24:19.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKVPS9euMPNDLnmwEBEBRQFlCzujCC2Y1uDatuAApfKtqflOFHRo9ggJVgNg53ZOf5Iwqwp7IFEwMTagRO0IpLAWhshlouGNMbHOTw8lsa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits. The
> CXL PCI probe function will call cxl_setup_fwctl() after the cxl_memdev
> has been enumerated in order to setup FWCTL char device under the
> cxl_memdev like the existing memdev char device for issuing CXL raw
> mailbox commands from userspace via ioctls.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/features.c  | 74 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.c            |  4 ++
>  include/cxl/features.h       | 14 +++++++
>  include/uapi/fwctl/fwctl.h   |  1 +
>  tools/testing/cxl/test/mem.c |  4 ++
>  5 files changed, 97 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 82f21f64452a..81e8ff66c12e 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +#include <linux/fwctl.h>
>  #include <linux/device.h>
>  #include <cxl/mailbox.h>
>  #include <cxl/features.h>
> @@ -167,6 +168,13 @@ static void free_cxlfs(void *_cxlfs)
>  
>  	cxlds->cxlfs = NULL;
>  	kvfree(cxlfs->entries);
> +
> +	if (cxlfs->cxl_fwctl) {
> +		struct cxl_fwctl *fwctl = cxlfs->cxl_fwctl;
> +
> +		fwctl_unregister(&fwctl->fwctl_dev);
> +		fwctl_put(&fwctl->fwctl_dev);
> +	}

I think this is going to lead to use after free bugs.

Consider that this free_cxlfs() call is a devm action that was
registered *before* devm_cxl_add_memdev(). That means that the memdev
gets destroyed before fwctl is unregistered. That sounds like a recipe
for use after free bugs because userspace could still be using the fwctl
interface after the memdev has been unregistered.

More below...

[..]
> +DEFINE_FREE(free_fwctl, struct cxl_fwctl *, if (_T) fwctl_put(&_T->fwctl_dev))
> +
> +int cxl_setup_fwctl(struct cxl_memdev *cxlmd)

This needs to be devm_...

> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_features_state *cxlfs;
> +	int rc;
> +
> +	cxlfs = to_cxlfs(cxlds);
> +	if (!cxlfs)
> +		return -ENODEV;
> +
> +	/* No need to setup FWCTL if there are no user allowed features found */
> +	if (!cxlfs->entries->num_user_features)
> +		return -ENODEV;
> +
> +	struct cxl_fwctl *fwctl __free(free_fwctl) =
> +		fwctl_alloc_device(&cxlmd->dev, &cxlctl_ops,
> +				   struct cxl_fwctl, fwctl_dev);
> +	if (!fwctl)
> +		return -ENOMEM;
> +
> +	fwctl->cxlmd = cxlmd;
> +	rc = fwctl_register(&fwctl->fwctl_dev);
> +	if (rc)
> +		return rc;

...and a devm action needs to be registered here to make sure fwctl is
torn down before the memdev is torn down.

> +
> +	cxlfs->cxl_fwctl = no_free_ptr(fwctl);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_fwctl, "CXL");
> +
> +MODULE_IMPORT_NS("FWCTL");
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3e666ec51580..b093cb16de3e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1013,6 +1013,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_setup_fwctl(cxlmd);
> +	if (rc)
> +		dev_dbg(&pdev->dev, "No CXL FWCTL setup\n");
> +
>  	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
>  	if (pmu_count < 0)
>  		return pmu_count;
> diff --git a/include/cxl/features.h b/include/cxl/features.h
> index 1ab97e676c03..d0c94756e452 100644
> --- a/include/cxl/features.h
> +++ b/include/cxl/features.h
> @@ -4,6 +4,7 @@
>  #define __CXL_FEATURES_H__
>  
>  #include <linux/uuid.h>
> +#include <linux/fwctl.h>
>  
>  /* Feature UUIDs used by the kernel */
>  #define CXL_FEAT_PATROL_SCRUB_UUID						\
> @@ -158,6 +159,9 @@ enum cxl_set_feat_flag_data_transfer {
>   * @entries: CXl feature entry context
>   *	@num_features: total Features supported by the device
>   *	@ent: Flex array of Feature detail entries from the device
> + * @fwctl: CXL Firmware Control context
> + *	@fwctl_dev: Firmware Control device
> + *	@cxlfs: Pointer to CXL Features state
>   */
>  struct cxl_features_state {
>  	struct cxl_dev_state *cxlds;
> @@ -166,12 +170,17 @@ struct cxl_features_state {
>  		int num_user_features;
>  		struct cxl_feat_entry ent[] __counted_by(num_features);
>  	} *entries;
> +	struct cxl_fwctl {
> +		struct fwctl_device fwctl_dev;
> +		struct cxl_memdev *cxlmd;

Is this backpointer necessary?

Just look it up from the fwctl dev.

static inline struct cxl_memdev *fwctl_to_memdev(struct fwctl_device *fwctl_dev)
{
	return to_cxl_memdev(fwctl_dev->dev.parent);
}

...then no need for 'struct cxl_fwctl' definition.
