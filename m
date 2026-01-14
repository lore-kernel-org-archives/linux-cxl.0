Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7C2D6E53;
	Wed, 14 Jan 2026 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360787; cv=fail; b=Q7G5QSCHuYGlMfSDJ5h27d9NUsYk6o/1AtgMDafJu9wBCw/Z1iELJcuM50ueE5dqVGCcRaPI7cnT5fPXADhlEggAlIhd/mf0MEOtXJ4mmSHUVmm00hGSmnwi0DMnh+KGgy+kpyewolA3Lw7kIQUOF5NAjkiR5ltyIq0+dWH7vRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360787; c=relaxed/simple;
	bh=ZFb3qukhge2Ezf0k2SB7BqEmcf6wRf//0BmioCzx/UM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PrJ/FbtW/02oBfGPczOmkI7iYaMW9ry9tvHtLJ5ySlFccH4h8tlRWO+Tw7Zs1pfaBICHfEsGDBA37Os/kdW8NOhPM5UgffMgSrMTo7nj8o41ByO7MqMY4tnyTYmzTqdMei+/gX1sifAT/syYBpw2KRc8w0XbelkU8Tbl3XpFmPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcsRCDw9; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcsRCDw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360786; x=1799896786;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZFb3qukhge2Ezf0k2SB7BqEmcf6wRf//0BmioCzx/UM=;
  b=LcsRCDw92b4A6Rx/H0/AcuZX9QwzgFYcjhO+I1hy+J0oxfiNPDi76AqL
   dn0Xahr5qskPiZ1WiDeyKT7H23BwyjV/IOxoKle72vfk3ilyDiqN22zAU
   +u+dgVSK8rH4nQ7GDTZJpxLG34tuYoQqdDZNMXxPJpuxNTVpt8WpKkVBV
   sinDObObmp8kKjjIXlz/OpQfp3ckUJy2SKsCXBNEK87CrfiIx/WPApHiS
   fqAGfmZnEZAqilVBy65HhbUaGI5gHNDiFa/niiwi/VEyQ06qnMgC6O2iV
   9mM2IvvBJswGBvbWGAQwaYubxG+4rpu/OWy8Gh8fygA77P9Lmp6vqpmgk
   Q==;
X-CSE-ConnectionGUID: GHAxMmJTReCzDK7UHIZPCg==
X-CSE-MsgGUID: MCDBvEY7TcGlXBAVmO5iiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69576611"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69576611"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:19:45 -0800
X-CSE-ConnectionGUID: 7lziQw+pTj6wzLXWuRzuAg==
X-CSE-MsgGUID: ATnNq0M+S3+7W/5+qovXCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="235808530"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:19:17 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:19:12 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:19:12 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:19:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtKquAdvBfT9ZjT286zh4JyPZ87QTUIK0mSY7jflcmmzBJxlb72+quvphVdfqtXwVGj1X7p17VHuChIvjkrFvvizAVGXUk57gnnJWb4x0TincCPxshTyxxXk0esx+6s2noo9Vo/FVX/jEGOcf4ptWittAw7oUp7UEQHeEBAIVzT2WvjCnDkZcStVQx15fJQVtKmnY+1m6DBzL3Qqa1zvfuoGHSjLGyrdHd3ESo6ntoxxLgZg+Lk8J924QCA5T86MelUuri3vhj1EJggVsENJIIjXMKzSKTebMupiujUE7/qnF6JPITCB1wolhXsu5WovWGsBDNmGsOB8n6aGXDP1oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsezYnSzLH9GC2EiMlqksq7qdi0dBSTctQ0oc6syjas=;
 b=aiuP2wYzGGOhpujrZbh3kr4TVUtPkL/wTcEm1gcfAm8pzwkWd9JKsxpDfpKivWGiEqodfwvPs6MUEz5MQv7f/OMcSNoBvrVMz00Ov8cL4Tjv6/dRAuCHo1Bh3GjT4bO4erWQNl/MjFvY0NR+oH2NPb2FsgfKCNnCYC+XT5WO2Zdg8xcKxQMkJPmk5z54JPPRpBzB+gVe4re2uLkVZB5BsYDjMhpzCixjYRHhCSVBsUnvaW0HZYSh1gCJyEiJPP9LECDNgMCIBIwgW19gss5ANgmsAJxqjfsIH6LxKGzdwpsIedtVbTXEdrVMhpl1Ez0no9nBVftdnMVclCf8uqdmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH0PR11MB7166.namprd11.prod.outlook.com
 (2603:10b6:510:1e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 03:19:10 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:19:10 +0000
Date: Tue, 13 Jan 2026 19:19:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 07/13] cxl/region: Use region data to get the root
 decoder
Message-ID: <aWcLKytCUXoNwcy-@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-8-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-8-rrichter@amd.com>
X-ClientProxiedBy: BYAPR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::16) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 2882cb0d-cf2b-4317-e856-08de531baf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ja0JJQOYnpRbnfnnHLsOOO1G4xw30zHsfe+NYUZ56sbHptWC1uLqxM78e9wq?=
 =?us-ascii?Q?Ux9qLtpSNGFT/8+72U2EGrXMlbLnfVOdIc6EkbTTJvfwsnvuab2TonhEOReg?=
 =?us-ascii?Q?2mCyaURkezPbrjqy2cP9u/wzpvgobMKV4iKopWejsg9oxYOx2DmIaWXquMrK?=
 =?us-ascii?Q?BMIYygQe92DLxwSG3HowbR7mm1V0KmudCT8K4mRuEe42hmbf/Sqpxr8zsdf0?=
 =?us-ascii?Q?wm9p6QAo/GzarZ/aBlgJTTQhU5S0Br8ZiPSs8rMkR4QW69ULIQNmEUpMPEtR?=
 =?us-ascii?Q?Vd+vDKOFnQCEFnpwntxCk9BVxv3T7knGowTGqedw8MMoSo7ucOqDSzfxxKim?=
 =?us-ascii?Q?EqZv/ov7H7SXnjCUCmdOYm7a67PFmZQjkNnobcIUKzqxtFzvrdV44RzDLMOG?=
 =?us-ascii?Q?R067jtwimFrsRW5y4ld8rFU/Pm/EbWuAbEZ5BIZ2em2P4vWiyX0UZNU67Q5N?=
 =?us-ascii?Q?7UvlDVR7eC3MwNNAREBGA7UTgQvZx5EXTdUDIcJriYI8h/HRamSL/Z4EvgRX?=
 =?us-ascii?Q?LBbtXTJ2p2p6Df2MGZhWnmm9/KE7hECUVMfq0aYzgRPqzz1YG6bFUOdfg+Mj?=
 =?us-ascii?Q?xVrMMUDCIwu6soPRKnmECypTxuaJUQxxbBDW541U1Kms3OlbdKMMquBKTuad?=
 =?us-ascii?Q?tfZDNozICQgA7KHFYdSCGEreJN+nLu3iMWu8t+7tCCQYtOq3FFv5hbtRZvsG?=
 =?us-ascii?Q?zBuzTNvfDbaEZNTFlqOpHnpwxxpLh0AxrSTfP+7H5VNZGlyGc7zgyNSdyTjT?=
 =?us-ascii?Q?CqnbuakG82FxPaqL61WV8xd5KY2bzVMvxDf/RfyxxelyAX5Xp1c8hX07ZnA0?=
 =?us-ascii?Q?1UvF3mmx8Fmj0vh+Dr5d8bWMVMHNNqXdHBPtWhViaJD6x5IYUNwAdUQc9S3b?=
 =?us-ascii?Q?1NbpHCsQ06zsZCAd19uTxyfyCxEanXBemWz7Zwo12V8ptxgMITaI8JWVJkc0?=
 =?us-ascii?Q?L5mv/Wo0hACe0e0KCPttkspReaOk/5bT3DUGqEmH5vxbKaxevJEvPq+rXD3N?=
 =?us-ascii?Q?Vwx81ROkrOmVy8KYfSM8qI8CJB5Dhsh5n30Nj0kCumMoPIVmarjq4GUIHKPY?=
 =?us-ascii?Q?hT38jOnhFprEoZIRNBS8/YdiXzOVSdUzD/dKT06XdAztx6WuVe8bVBSlK8Ng?=
 =?us-ascii?Q?YSyEeLvdHX0y5GpBSgkYt09kwhAyzfxwjdYxWMkdJ5XDl0SExk6C+U0/8cIf?=
 =?us-ascii?Q?hZf3MrSI1mOh8JyInseHY+7ocYgOyfKLn0G8XbvcQpH7n3AK6GPW7yx4lj1W?=
 =?us-ascii?Q?bsNbN9vUPA29tTx+bnfkivk75XU+G5MgfdZYaOiTZ1AdRdcafys0HgvvfiXp?=
 =?us-ascii?Q?d16I3r8qzuqP/h2Df/5zWrqZmKzlTEeX5X7hDZ50RcCRgMTWiTpYzdly4sun?=
 =?us-ascii?Q?U8TT/HNEcuS55L62lRSBt/HTtLHdwQMUebDPaTufUSYt/PdRhm7077TzOZj8?=
 =?us-ascii?Q?wxpzZkiEvOUPiplPc3gxRrpyAoR0r5UJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qcyx76w6dw4vk5RMfVUoFT6zeVJW62EtiUo0Z69oRnm/qgPKa4Gv7uPv9VmT?=
 =?us-ascii?Q?VJczZUJswy4NhrTBBWqK6a8hZUWA8416ltpKs+TdmyG+3sfH+H4APtbSakHz?=
 =?us-ascii?Q?REKs307cnmgQwK9EskqNU1T1qUM3hlAE2Fh+GMczrQGFRccAYRGxZ0YCMegg?=
 =?us-ascii?Q?VjqDC1NgJkZu2cNnCK8bsZuuFYp89UonxQp6EUyB1PpPZUbo3eil6LVw/ZWh?=
 =?us-ascii?Q?o3GABycs9jNUOk7ipMs8S5H4ZBbNo3i8Z5ZGg8o4tyKy5fXtERgKgNNociem?=
 =?us-ascii?Q?nwltrNDpeEnaAq4oGCBq38bc1lRoLe0aUaL6BkEo1iNeO4VYJeIUsEmoNYXS?=
 =?us-ascii?Q?PHBQ5vBv7YR2qBWRfw4WDC39sSOFh61zt0o3NtFkCXONZWm30YZP3MP6GhIo?=
 =?us-ascii?Q?77Oh3YS9U0SXJkefYKPMuEzKjhffe3D6qfn2H1H/zuC221ZXzDCDQ5htEIJJ?=
 =?us-ascii?Q?t/IITSXjU2pPihQWlOdpwpibAS9U/IbXHx982Os+CsH32TemzMtDoQqprp4N?=
 =?us-ascii?Q?vFP15kw0cCUqO1eFdQpTRlMdoRx2faHBVDwcUTJs5slqcymDSx5a7/a/vtyz?=
 =?us-ascii?Q?aaK56K2UFJxxYkyFXqdwRPbQDdrOZOC7tfqHHgdcl5qdMmGeSEmJqD3ALHn7?=
 =?us-ascii?Q?CMtffIO7NQ9xq1rivLq+2xsl7yYiXQpqWo5Y1vX4L326bx/SmzcZIPaiYYPe?=
 =?us-ascii?Q?14KE7NB2dC5nmO3QYpGm4JXBjst4V9b4RCoPTayWkOQM5qmpH8sIkDFiDrHH?=
 =?us-ascii?Q?xDay0yhYAHdVapdLtvm6RVtn/arQgWHsfASvPxSkxlAe9Pf6+lIH7e1Uw4IT?=
 =?us-ascii?Q?hFs6Tcp6xVvk9O/lDFmKEEpIMJddPE95vTJ3kdq4huomAuTw9dW8gaTTYcSt?=
 =?us-ascii?Q?tS+AdIBdX0jVtnZLDeLmBXAc6jGHVeNWfvskYMYoR8keNDlG51ZsyQUdf6tO?=
 =?us-ascii?Q?nt8j3tGIgoknv+Nh6CUgMOJIfpuXv3V77pIXBrWkPbPdY1HUQ7yYvVNMF9Di?=
 =?us-ascii?Q?XiKvCIsWwQ/lsdWNsunkZu8/gUwFjts8e7RODmATl/mDqPGh8tNno4jl2iaf?=
 =?us-ascii?Q?tCQk4WhbOPIA+JOSQpUKCPF5Xc2m0VJEJN0UtgEoSXonH8w6O0x7Ch4LWRB/?=
 =?us-ascii?Q?QCCFFnzVfasqRU+7y+6A21afREB7EKY9H4GkT6Hs+tuEBKZjlbFD8gCT0N8C?=
 =?us-ascii?Q?KxtRUew0DRNu3NwZOh/umR1tlwawU2dCxgGmgjpixnvpDf4V5ztvDjwxLboH?=
 =?us-ascii?Q?fVd4mYjVmiekQ95txVK5lO/GfH9V+xaU7M1w3FJXensfdlPX5xjk2UQPejzD?=
 =?us-ascii?Q?fPZhOr877/7+FPatHwsoMd0oK9Ym1Tg7lMxNv5lQLAeN4T4UOTpXzujgbmts?=
 =?us-ascii?Q?u2YOoA7jiUMCSfJwKUp+emaZMw4rou76tTbeeSNj/7GRnA4dSKJ5hOYxzH36?=
 =?us-ascii?Q?198Y4fwYt3koMXrONd3igKiA3PzdJW3PinOoBS5qAu/hpBbDxjbcbUHFV4PH?=
 =?us-ascii?Q?wo3r5K1LQ7LGVDpncxzea7z/ppYIIZaQWjQh+Yl7AxvyMh5mfjlrgEibVUcR?=
 =?us-ascii?Q?uGy+vLqpRySeVx5opE7CBLut2EbHwaBhb6GMIpDGHSqJPDlyMva5TCWHeJ+4?=
 =?us-ascii?Q?6/SZK21uav0cVI8oTDCsG3MkwL/grGfucjh0I6wuQeFuyfUyxo/N7kD9kttv?=
 =?us-ascii?Q?y8IF8S4PphAVno+OEaKWL0lJaO4T/TkV283Iry7huKT6RIxnM9hiHu5Jp0uW?=
 =?us-ascii?Q?8oRKUE76o3zQ/icG/kScY9a519hejRo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2882cb0d-cf2b-4317-e856-08de531baf33
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:19:10.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW6012tG4bRKrojavmfL1UqWT5s5yYcf6yDL9aieDB60gHW+qS4GwAwJM4Gw4BaT4fIgiO2H4wHcB/l5+X+EShQ7l/jNbAqFCPA+DXJgDGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:52PM +0100, Robert Richter wrote:
> To find a region's root decoder, the endpoint's HPA range is used to
> search the matching decoder by its range. With address translation the
> endpoint decoder's range is in a different address space and thus
> cannot be used to determine the root decoder.
> 
> The region parameters are encapsulated within struc cxl_region_context

maybe s/struc/struct upon applying 

> and may include the translated Host Physical Address (HPA) range. Use
> this context to identify the root decoder rather than relying on the
> endpoint.
> 
> Modify cxl_find_root_decoder() and add the region context as
> parameter. Rename this function to get_cxl_root_decoder() as a
> counterpart to put_cxl_root_decoder(). Simplify the implementation by
> removing function cxl_port_find_switch_decode(). The function is
> unnecessary because it is not referenced or utilized elsewhere in the
> code.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

