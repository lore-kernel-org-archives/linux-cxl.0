Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B53B47F0
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522536; cv=fail; b=DeASBHE8h+WyBMbvnHNFV74axJd4/k0nUMPVf5DFVOpFNcyT9tUVDasYr/PcSWPFk61zYXBVEshyc6ECDJ0WDaexW/58E1SMBMuqXHgUXz8F87BR4yAMhHgVOJfQtk3mDwnrFRoxFGUHyHCY04hSGQgbghE+zaMMIfgmEPTQ+LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522536; c=relaxed/simple;
	bh=WozP1kZ50TVWyQRjwLE6d20//T8JiSHQcA4FAQKu+eo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dUtbTQxn7vbi2C6D9eveLDanShAQSV44SJGOi/OgFlrV/99AtqSPORCrK2daMUHZelYqYxNIn7/euoTusrouRnziBvyjCYiF/5AkuQ1m9ts0yGLemW34cBOPIN7RhAmKBXcvDnC3lnkvicfeb1TNJObwiPaIkA8D9r1H47TohiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsqEPesi; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsqEPesi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789522527; x=1821058527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WozP1kZ50TVWyQRjwLE6d20//T8JiSHQcA4FAQKu+eo=;
  b=hsqEPesi/KL6oj5ZQKHh6OurwLk4khPY4npwtJPxKJZKHMw3kTuoegQV
   0hfEqO6+y9roAd33N8e9uAHcb+POALRZ5d3hEvYuLNSoy/gQNMtJJoNW0
   wR+pLmKKQWmeC/iYkApWOslP7w46FcQxjmP6h4aRrvRKkhUICylFJsn7r
   YH07ybzc/bRNw7v9MO+urDtwrspFNLkqNDHCGr31c56CPepPNfmRe2HBJ
   50UfRNYJBQOHB3Rpbofh380PRJM2sZAK8JE0moLw4hXWCrfx70V4JTrUL
   IJx8UEmlI6vj8ApEeJN7u51skCz1+jeXThGaKhjgZ/96vagoxyEmUIit4
   g==;
X-CSE-ConnectionGUID: f0EiDBsqS7i5Av67QjluNA==
X-CSE-MsgGUID: kf2GFLnSTFGmpB0MO4I56w==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="406338"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="406338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:35:23 -0700
X-CSE-ConnectionGUID: +cayZg2qS0y/xDJROrbF0g==
X-CSE-MsgGUID: 6+DTetv8T2yrpfwukNK+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="275141851"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:35:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:35:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:35:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:35:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsgJadWP2QIrRp7Yf4BYQAugIZzRKHPgbwP4a3jEFuC3rW4J+vTb6FuHCLVAYs/Cx32nyll4+rrgsvaILNK0sN43alc90aNxctovi3JxSMEb+ElbrjFlkcjmog+lEHneE2JkOSSoCi7POSNRbq07hE5/uhh7O1kGJlL6y8Xq0akMKB0YwBkadVCCcNmFjFIy+PO9NOdLR4VitS9J0CtaS34yTVnSuPW+nTq++Pwbuvohk5UlqRZkJ4aohz7RmGeHB8qgeBVR5G6H2D4A6KKcjH34DsJWUh7NhB8fHcDAdxakyiefWxQrjVXiYf6C1udG4FtXiLYV2gihTmHi5cBdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCnwzt7pjAxtrx8hKYtwhv5UUzqXFIaEJRlHilLk5IA=;
 b=dE0Ksu+jutwd/1J04MXh1SOxrUlahhGutb61lyhGGKp0Ab+pRNl4XsQJlGDXu1CIALaNnVZxuSSRH1eBikQellQpOpEwAeZIbEOFDYDHWv5isQtAezVLYcjcyD8MdoISXTuWA+/0fc9yMIo/3SOGenhjhpzRU6vPZJjDSv8QLRXRmDKWJPul6n1CALfK2xQZgR59qZMgB+URAtjXOEX7VNQ+nF6vLK1TgAj1Q3qjdVd/FzRijVGxpNKjLZCO/q45AwBQIUVZq6FzvQw4w8X8mAEwdmSPf6rNneENnrUR1fXQQaGTEqaq2GqlteRHoDtD/xggqAH7EygZHu0kX07TWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6431.namprd11.prod.outlook.com (2603:10b6:8:b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 01:35:12 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:35:11 +0000
Date: Tue, 15 Sep 2026 18:35:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
	<wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
	<habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 6/8] cxl/mem: Configure dynamic capacity
 interrupts
Message-ID: <aqnyS8UmkAZmhNX-@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-8-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-8-anisa.su@samsung.com>
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 579c3ffb-a512-42ed-daa3-08df1392bfc0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|11063799006|56012099006|5023799004|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: FsksYLn0st+odh1HJhkb8BP2SrYSI5VxKtwekHP21rK5NkAfyJ/aYkcix0Q5wY1tfzsFM9PpTpii9l6mRwXMUMtoK2J1Ev8aUXZcp8N4dTExEOaaGe9Aivb5bT8BxpvwXu32XZwgens0Ao+Z926lVIrjEvQiCGEbkg3apxHUUDoldUJrn/Nkbzqf/d5LuJz7pkP/RvAdsaxEj/YZCeClV5gofhCKinFW1ONPhbSqdk6tSl81kRJvKaeCTOIOiJrQCy8KWfXCByX2CxRDLJObpmPMOuIEhfAHpS0+xNlQ2/y/W/+9+2Amzgv5hsCqMhzHeafLo88Ypx565B0iALjJE8fl+vAnQfsrkM3MJmiS6gP36LHnqSTuzH2zRu7evo5TIJCl4HnTsm3oVPRIdHvY/ckCuM+wx6OHUkSG4vPiH9N38IlOD4mPfSoRtL/QgU0VfeeQKo8ZfjGavD6IP91WK4njCMNV/B2NTIV/xoNUmmVMrzYShCiDTBJRINE9SaA9GMuPS3GdeYwxGl5ZIKyvoqD39YzaffANiDmsvPIpqeyTE+En2KnhJ2ZidUgZgJBz4a0qgF8hxsc60SWrfco25kaKlq7BZnj+DUZDeU8b1kBbzbmjfeUC/YZOV6Ah0AflcNWZi0gALeWj1kmqqt472XLEOLImnS+Q/fmQmaKSWF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qFBKVlQYF6cVLn4zgGkYg5rD/azkN5dmkX6YVJ7/y5i19EeSVioTVNb96K9m?=
 =?us-ascii?Q?jaCS0N6zqA5Ysbp2T/6zY1ZmYPcRv25porMKOaJUbiXCwr2CiLnAOd5jgLYC?=
 =?us-ascii?Q?KY77A5Cb6JFu7zn5HykQV1RNa2BsA1YhUyZlqEHtbP0Zx4+FSkptqJopnPQs?=
 =?us-ascii?Q?a5nWeUsAchtosswrMicabN4PCiht0IpvWCo4Zz3OHDP3TDx0Kr1KitEHfuEI?=
 =?us-ascii?Q?NFyXphBqWmXY8C1i0henO05ytHKj8UeKNxHNGJ3e8SBZE4UoQjo9lCpPDQOg?=
 =?us-ascii?Q?v8mY1iwyLUyRDQK53Wo355VcAKfDxRLkPAG3NXs85QzQUyuzzeW1WCh/PEfc?=
 =?us-ascii?Q?GHCM/bIEmlWgN/ogkbHUUmaQFo4a5OK3BnexQpbpBOh/bMTmVMwXdL5Tkajy?=
 =?us-ascii?Q?pB7kIJVDDXIQq2vrvFI4GUE1eTKG6//naiIDl0/WnlzTQDO+vVtwXmyLXpb2?=
 =?us-ascii?Q?iqoj9hhJLueyIkeGEPQdEnVKEtCALm7r0HjaDTGsgwIcABubeBQobqdu8qHU?=
 =?us-ascii?Q?HsfZlQtKLAUHZ8UpxWb54ZtC06jmK1G/0sSjVWT8rgCFf64rn8YA7DwhijF5?=
 =?us-ascii?Q?62Pyf+6fSnngpPuuyZz60Hq8Bk94GLFuQscu2FBEp4P6BYXAR+CCgeipGX0b?=
 =?us-ascii?Q?0yhOj3h+t9w1URijrJyequZaocuqF7Zwsq9cDvgP+TDseVgmVLFXPuGxx5ez?=
 =?us-ascii?Q?HBtUpBe3O3M9fFwmqYYmcJJDdwO1Gph0b347MvY6M82Lh7HUh0Utx1AlnNiC?=
 =?us-ascii?Q?oP1M9SYkmNVNoIhI5vbq6UM/NIMJvVp6CswQ+La1JRKxCHQuiLsX+ty6pd94?=
 =?us-ascii?Q?2PilL8vdDifeqecnuAp+J97N+S/75OaP9Et7qzEScToBUOadzMRGHtujfIut?=
 =?us-ascii?Q?vs6yKW9vREVAsQzMLqdaOVs7ai2HewU2ABhATvhUVvmzXtMd6dhfQxOzhoxA?=
 =?us-ascii?Q?SFt+kksxYP5bHacbZYILc/eceN1wMSwy2CyuukaJhTa9et4fTFcnGLr00eA/?=
 =?us-ascii?Q?e2a+Tsa+u17pAbIJdXydEEXdBvUdlxYkUyXOq8uYCF4Kx+HpQqjt2KKa6pu6?=
 =?us-ascii?Q?s/ZNqg+eb5QvQu+7D6msvdh6CKvnR+q68/9xYh7t31JVpHFkSHH1P8cpxLtX?=
 =?us-ascii?Q?B2YLA7j4jWRfJ/dovKAV9rpI7Osp1pZkCO3OOqhDo2Y61Gmn4ihNqavPnVN+?=
 =?us-ascii?Q?FHaJcNLTP3N6WwN8pXYX/KEmlXKUu4Q+CE/VeEVrpTbKrAYZVIjnyFM6c2IG?=
 =?us-ascii?Q?JpQju/Kqz5Xh5ZZKTQEDB500FSh7umreERqA5R3SAKN5itFe6F/0pmSnDp8d?=
 =?us-ascii?Q?5xgVem1wlu4DBR5/NeKC14zfzavR0iX1lHV/ceGXTF0aG5OkandQMZSWu8eu?=
 =?us-ascii?Q?d8Nhv2tYXVYOr4XJw9dHVPAT8iOBy9F3pt+71ROs3KCeY/7oOnXFZJRTJDXV?=
 =?us-ascii?Q?vYyereMxxF2DyCugcUxk+Pzcdvl4zVO4TfS/i9BpgmjdCSzDH/7LW1+Hmlib?=
 =?us-ascii?Q?BxUS7P1qq48SsobKeoqy9G1yFtqn1308tyl/mPwprIDQ6WpbSFvLSkuZRRrt?=
 =?us-ascii?Q?z6HaHtEue1PV743O6Sk73AZYhm4m7XQ+XpjDvoxRFmL5yhSzNxsinTlgGA9X?=
 =?us-ascii?Q?A6Ac1UFxOsVrtuCUx+LkTtCsu8UmZZBKfhx3JgIRe0jkbrnBVjOhyVRZPeh5?=
 =?us-ascii?Q?taKmarpDQfvHMG6MXt0u+f6ZhSCSuKZbXV8gnVDhZp+6e7EdhsGk0MTFkMPC?=
 =?us-ascii?Q?I0WhJ8W/P0TtJTB8tPR/PmoMeCt1pMI=3D?=
X-Exchange-RoutingPolicyChecked: xFqycNB5YODUxL+/yI9ecxc6tKJ8DGmNCjrTILaorVkFHj7I5G3lR1bvcymUZGqVqsAEgK0RSXLC6U7QHmwYqSCnu42jgYJV86moq4mCoMwNnTYNqKei9YCTXRwzWmsgkfMGQd7VMhsVCOQ4gJSoeWEom2jfCvesdH87X5uI1EtNZ89ybGTklm+vI/iaEnhlmFx2PofMUzT5OnNL1kMYlQPy3A7J0i3WD0gT+/nCl/t1NyVRq5UDvFfKihFdTj2e6Bfz/rtW4eFhiCtoBF5oRSU8U9OmdSWUtDkkgfiftYhmxCSSiYvcEIkDjijxw6EWUd1YZAPjMRxPEhiFIKXE1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 579c3ffb-a512-42ed-daa3-08df1392bfc0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:35:11.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtwTYiQ69aWC0vxn1ic5r3hoJsmZPrm0az215Sc/qR0xpOPc0P2bKzMEYD/Hptzr9wrdgFYCDuW1a/7sy6qA8w3xoK7Cgzff8sWcF53UNT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6431
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:10AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) support extent change notifications
> through the event log mechanism. The interrupt mailbox commands were
> extended in CXL 3.1 to support these notifications. Firmware can't
> configure DCD events to be FW controlled but can retain control of
> memory events.
> 
> Configure DCD event log interrupts on devices supporting dynamic
> capacity. Disable DCD if interrupts are not supported.
> 
> The DCD event log is not drained here. cxl_event_drain_mask() reports
> only the logs the driver can service, and the DCD bit is added by
> the patch introducing DCD event handling. Until then a DCD interrupt
> wakes the event thread, which finds no log it owns and returns.
> 
> Care is taken to preserve the interrupt policy set by the FW if FW first
> has been selected by the BIOS.
> 
> Based on an original patch by Navneet Singh.

Changes from v12 LGTM!

With Jonathan's event mask change applied, you can add:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Also, please add your Co-developed-by here. This patch has evolved
under your ownership and that should be reflected in the tags.


> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> ---
> Changes:
> 1. pci.c: disable DCD when the device supports the DCD commands but its
>    interrupt policy is too short to carry dcd_settings. The Set is sized
>    by the device's own policy length, so on a short policy dcd_settings
>    is never sent, and the re-read afterwards leaves the driver's own
>    value in the struct because the device does not return that byte.
>    cxl_irqsetup() would then arm the DCD interrupt from a setting the
>    device never accepted. A conforming device cannot be in that state,
>    DCD is CXL 3.x and a 3.x policy carries the field, but nothing tied
>    the two facts together. Reported by Alison Schofield.
> 
> 2. pci.c: move the DCD bit out of cxl_event_drain_mask(), dropping the
>    mds argument it no longer needs, so the bit lands with the code that
>    drains the log as described above.  Requested by Alison Schofield.
> ---
>  drivers/cxl/cxl.h    |   4 +-
>  drivers/cxl/cxlmem.h |   2 +
>  drivers/cxl/pci.c    | 124 ++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 109 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..d6e02bd0cf50 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -192,11 +192,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  
>  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>  				 CXLDEV_EVENT_STATUS_WARN |	\
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +				 CXLDEV_EVENT_STATUS_FATAL |	\
> +				 CXLDEV_EVENT_STATUS_DCD)
>  
>  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
>  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9fd5af2e41d4..9106affd7c81 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -240,7 +240,9 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dcd_settings;
>  } __packed;
> +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
>  
>  /**
>   * struct cxl_event_state - Event log driver state
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7b754af2168d..1ea505b1f40e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -510,11 +510,23 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  	return true;
>  }
>  
> +/* Event logs the driver drains: standard logs when native_cxl */
> +static u32 cxl_event_drain_mask(struct pci_host_bridge *host_bridge)
> +{
> +	if (host_bridge->native_cxl_error)
> +		return CXLDEV_EVENT_STATUS_ALL & ~CXLDEV_EVENT_STATUS_DCD;
> +
> +	return 0;
> +}
> +
>  static irqreturn_t cxl_event_thread(int irq, void *id)
>  {
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct pci_host_bridge *host_bridge =
> +		pci_find_host_bridge(to_pci_dev(cxlds->dev)->bus);
> +	u32 mask = cxl_event_drain_mask(host_bridge);
>  	u32 status;
>  
>  	do {
> @@ -523,8 +535,8 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &= CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver or owned by BIOS */
> +		status &= mask;
>  		if (!status)
>  			break;
>  		cxl_mem_get_event_records(mds, status);
> @@ -551,42 +563,62 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  }
>  
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    size_t *policy_size)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd = {
>  		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
>  		.payload_out = policy,
>  		.size_out = sizeof(*policy),
> +		/* CXL 2.0 firmware omits dcd_settings; accept the shorter reply */
> +		.min_out = CXL_EVENT_INT_POLICY_BASE_SIZE,
>  	};
>  	int rc;
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> -	if (rc < 0)
> +	if (rc < 0) {
>  		dev_err(mds->cxlds.dev,
>  			"Failed to get event interrupt policy : %d", rc);
> +		return rc;
> +	}
>  
> +	if (policy_size)
> +		*policy_size = mbox_cmd.size_out;
>  	return rc;
>  }
>  
>  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> -				    struct cxl_event_interrupt_policy *policy)
> +				    struct cxl_event_interrupt_policy *policy,
> +				    bool native_cxl, size_t policy_size)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	*policy = (struct cxl_event_interrupt_policy) {
> -		.info_settings = CXL_INT_MSI_MSIX,
> -		.warn_settings = CXL_INT_MSI_MSIX,
> -		.failure_settings = CXL_INT_MSI_MSIX,
> -		.fatal_settings = CXL_INT_MSI_MSIX,
> -	};
> +	/* memory event policy is left if FW has control */
> +	if (native_cxl) {
> +		*policy = (struct cxl_event_interrupt_policy) {
> +			.info_settings = CXL_INT_MSI_MSIX,
> +			.warn_settings = CXL_INT_MSI_MSIX,
> +			.failure_settings = CXL_INT_MSI_MSIX,
> +			.fatal_settings = CXL_INT_MSI_MSIX,
> +			.dcd_settings = 0,
> +		};
> +	}
> +
> +	/*
> +	 * A CXL 3.0+ device can carry dcd_settings field without DCD command
> +	 * support, so size the request by the device's policy_size and only
> +	 * enable the DCD interrupt when DCD commands are supported.
> +	 */
> +	if (cxl_dcd_supported(mds))
> +		policy->dcd_settings = CXL_INT_MSI_MSIX;
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
>  		.payload_in = policy,
> -		.size_in = sizeof(*policy),
> +		.size_in = policy_size,
>  	};
>  
>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> @@ -597,7 +629,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  	}
>  
>  	/* Retrieve final interrupt settings */
> -	return cxl_event_get_int_policy(mds, policy);
> +	return cxl_event_get_int_policy(mds, policy, NULL);
>  }
>  
>  static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> @@ -633,6 +665,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
>  	return 0;
>  }
>  
> +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> +			struct cxl_event_interrupt_policy *policy,
> +			bool native_cxl)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	int rc;
> +
> +	if (native_cxl) {
> +		rc = cxl_event_irqsetup(mds, policy);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> +			cxl_disable_dcd(mds);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static bool cxl_event_int_is_fw(u8 setting)
>  {
>  	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> @@ -651,32 +707,54 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
> -	struct cxl_event_interrupt_policy policy;
> +	struct cxl_event_interrupt_policy policy = { 0 };
> +	bool native_cxl = host_bridge->native_cxl_error;
> +	size_t policy_size;
> +	u32 mask;
>  	int rc;
>  
>  	/*
>  	 * When BIOS maintains CXL error reporting control, it will process
>  	 * event records.  Only one agent can do so.
> +	 *
> +	 * If BIOS has control of events and DCD is not supported skip event
> +	 * configuration.
>  	 */
> -	if (!host_bridge->native_cxl_error)
> +	if (!native_cxl && !cxl_dcd_supported(mds))
>  		return 0;
>  
>  	if (!irq_avail) {
>  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
> +		if (cxl_dcd_supported(mds)) {
> +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> +			cxl_disable_dcd(mds);
> +		}
>  		return 0;
>  	}
>  
> -	rc = cxl_event_get_int_policy(mds, &policy);
> +	rc = cxl_event_get_int_policy(mds, &policy, &policy_size);
>  	if (rc)
>  		return rc;
>  
> -	if (cxl_event_fw_owns_mem_logs(&policy)) {
> +	/*
> +	 * dcd_settings cannot be sent to a device whose policy is too short
> +	 * to hold it, so the device would never accept the setting
> +	 * cxl_irqsetup() arms the DCD interrupt with.
> +	 */
> +	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
> +		dev_warn(mds->cxlds.dev,
> +			 "DCD supported but interrupt policy is only %zu bytes\n",
> +			 policy_size);
> +		cxl_disable_dcd(mds);
> +	}
> +
> +	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
>  		dev_err(mds->cxlds.dev,
>  			"FW still in control of Event Logs despite _OSC settings\n");
>  		return -EBUSY;
>  	}
>  
> -	rc = cxl_event_config_msgnums(mds, &policy);
> +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
>  	if (rc)
>  		return rc;
>  
> @@ -684,11 +762,17 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_event_irqsetup(mds, &policy);
> +	rc = cxl_irqsetup(mds, &policy, native_cxl);
>  	if (rc)
>  		return rc;
>  
> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> +	mask = cxl_event_drain_mask(host_bridge);
> +	if (mask)
> +		cxl_mem_get_event_records(mds, mask);
> +
> +	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
> +		native_cxl ? "OS" : "BIOS",
> +		cxl_dcd_supported(mds) ? "supported" : "not supported");
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
