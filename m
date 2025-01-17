Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B9113C9D4
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737145987; cv=fail; b=gPvi/0zzCo/6dSyWT87lvrjA5Sl6t6tTWb4cbu4zVxgoRBNSdrvUJHCZh/2KRSsZ8UUO/kWf2Hr3jC4XScYYXK1qRu1awITy7ZP3jM/WVHTY23KZQmxeUpoblQR4FcqUv1vMwQRgXdLvUA2xDo5uCGPSOsDel3lOIJpPXByiUlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737145987; c=relaxed/simple;
	bh=G8boLpVlmRCwTYRPcyRWecxcA21Dupg9YzKRQEGljfk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j3is1vWfoD3LMet/wJua4cejNapQ8JthmMXKac3JvoBNp8eL/80LLMjfrKZLkUXWhRfp6hXBWng8dFwrYyukqoL4/Yrx9Ig/WTfluyJB4Liwr71+QRjmWUhGiujsArNXtDyDxPVDQ36tnHn9N3cAwx0zOYpTv9NAuWYZu7Md3w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmVevG5M; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmVevG5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737145984; x=1768681984;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G8boLpVlmRCwTYRPcyRWecxcA21Dupg9YzKRQEGljfk=;
  b=GmVevG5Mqy7iwC9Kz5/7o0Mr7dSjU8EMpdrHciWY1bvrqFBzXMDBK2hB
   N5qQp8zuysipgLDE3E007NBSnL74aZonfsPVf0wCdnKNrMzB/NNJnWgU3
   FXTj4/w9xfS9MwnVuN8wyE21OUjtUw3otfjliEgBHffV9Y44+9Mm72BeR
   jt563XWN8sko47pzvAEWDtudsHymJcwJxJBnNDID1mtYhDE+g/NiKbzLT
   VT6NcPO8vFitSBREjZFxeozf+j0ul8tUlPPSKn2Cx9XQSW07vy5B4Bk2i
   xCIyCK0ljP5NEBkBpOmSFIKH00zj7ZL4N1Ob/SsBIFbIvL+QcVbxvfO7h
   A==;
X-CSE-ConnectionGUID: P1rJ713QTN6XrrhJ6OyJsQ==
X-CSE-MsgGUID: 3zwcXR2VThKXfJvQ1XzcRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="62964412"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="62964412"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 12:33:03 -0800
X-CSE-ConnectionGUID: IUpRv8tGQfW7eezMqPjB2w==
X-CSE-MsgGUID: 42chQ/+OSGq9UhRipftbWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="110896357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 12:33:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 12:33:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 12:33:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 12:33:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPyx4rziNPBXlAi7r8UkBq0PpaaualD/n+TQkdmj6IKsmgVcXJHnadUTz1dEzknUHc9GRqf1R+QPASOo1IQPw4XS5ggMG8LXtMAV82+Tp0bqKxhdi6GAgfJ6sbXeBdihj4ajIk71mHrp08hwKrt2mgocdmXENTI2Q0pjmACNkDDPXCoJnLArg6SPpA9mJIqrqltJLIgPG/igsBxSxOdSakq8h3aXRaxRXUhO41AjbGhB5Xj92Eig8FQFMsLZbI4Z6l4tdA9RTisVEEP8IX6BqtgbOtEa7u4+AfPMk6ADdq2cqcMUJpPPma0Aju/HMEMO5yk4+0oXopcRnKe1RhsVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB3e0KKTKU6CmlxTAk30s1aJUFp/mi0w8241fArwgzQ=;
 b=uYN+5IgPh289aUWcOD2H8R2IWit5hLj6kC34RxEr4R6Uia1MEoa4UPF510wbVb+2CZJ16n7giGMc+/yYUNvhN+Z7Z+O85Z3Vo0UDPBrwwxUWR6WtdZ9kdrIl7h5GxFsBSU2nL6AHbO0HYFBc78rCT/hslqEqYpvATxMBXrSh/2Om5ZxtH6mgr3+aoFZFr3A1MgD8CxzrfaMJr5v8DU1qOCQL6gfZzA+dZsvIoSXfkWwah/Nav51DfqhRS7VoniBYN2B5iq5KBpcU3fjVmjVv8btCTWTdf8Cd53dK12ECT3FRUs9KNw8mDlZY6n5uZcOS5qndWZmNT3F8tBW8+K8jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 20:32:17 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 20:32:17 +0000
Date: Fri, 17 Jan 2025 14:32:13 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <678abe4d4c449_1f2d2b2945d@iweiny-mobl.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
 <20250117105254.00001dd4@huawei.com>
 <678aa0381324e_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <678aa0381324e_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 83345a6b-5cfe-4eb5-e048-08dd373608ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/7NHJb/xgobDp5Y9gMk2V7/6te6R73ralWoSMGvO9ZlPL6SmWJFfF4Lagp1p?=
 =?us-ascii?Q?bsnx/5c0RLnqDp9Ng6CH1LXTIqkNaOu6RpHSoQjQm8+gQkY6fIvnAhZ0oA58?=
 =?us-ascii?Q?dqgNHdTBiv7I+uwXz10SNYFPcPjS4OIFwnMn5Oa6RxWq3ZdGQsyrfQEDMGxD?=
 =?us-ascii?Q?aM3ZDDWp9+thtqSh/K0FDH4gklgFWeieZpGhrgF4tDUJdW/ApsgIfl7143k2?=
 =?us-ascii?Q?fkimW//FrGqc8MDCMRYqsM68LuXlebrv5gxybJmIa5wIJt9kMuZ1gdL0g+XT?=
 =?us-ascii?Q?kskr5OMJQUadEn1K4w9U6PFxExu1ke3kgbf1g0GIz+uLAmbdyZ9lzISOccnm?=
 =?us-ascii?Q?TVR4QPkMfXUuYe5oX5KPbeHdJo/btgLWaoEkDBG3Yf7P5WQk86h+VY3Rd4+z?=
 =?us-ascii?Q?yG2dlxUqjtl9cht57DUVqM8wMUm6d9t1fRvBYd1j3UBlJpVmuDrA2kd5HX86?=
 =?us-ascii?Q?pMTyOpcW2+67mBBpmmZwzJklWxNc54YLTX8utKkgQX1zjNnDSmKYQJdg7aMO?=
 =?us-ascii?Q?o3B5Y/kpwdXh7SPG/VUd6maJGEfkw6JgiQpeTHq+eyP6f3V1n0TtXU/bZ6iE?=
 =?us-ascii?Q?rKkRiOVnWEMTmKm+OcE/34OhhwUZ/33XJGPd+xQbnsHl8G6IoJ50UHxd+J6R?=
 =?us-ascii?Q?IFwi67ClJhuqvcrc8GOIhh69IiUHX0ml+tAG+/yV0AuAL3ZrtReDETRMQD9e?=
 =?us-ascii?Q?rnIhhHDEd1BVInHpk30TzGc9ERUvqta8WRoECqMXqktB1Fay+FnQBrGtN7WT?=
 =?us-ascii?Q?3/L18x2S0vePO/CHhjflIZMFZKP6jxCjM+xDfzvenGOskSUTSmsxP4pEkmvi?=
 =?us-ascii?Q?dQft2cBDvk0JHqjwGIIker+wKH+p0T8FUC0C19cBgzlPoPGT48Z6uj0eQ0UL?=
 =?us-ascii?Q?W2TJbCgOrl4hmvluSV1ZMcD58DQWKT4nFuWLo3yqPMl3azfAcVp1I3yNBdI3?=
 =?us-ascii?Q?8A3Va3eFuu79l6jUU/3MAPmHNjUITiep3VcAY6auTAQEbxQVUHPifDDRFPxf?=
 =?us-ascii?Q?QVP9VuxA2QCsr91wG07idAqP9CkAxKjlzEVQmLUaDQPPNbG1LjdlZOgdeMl8?=
 =?us-ascii?Q?/J8Fxyh7mgNy2SeygvhrP4SM0kO5k9rIHUJ6NjrdFf5ZZ+oDo8NT8pvEaiBb?=
 =?us-ascii?Q?3pp1zZP2FhHMBtHv2r2l63BHLb4Vmp/1HXWT3hNMB39g/u/XblCieUEOlCTm?=
 =?us-ascii?Q?omv1GeTrKvxsjnDF3wgH+mZIa2ruOEsULKICc+zCLTztdzL9bNNts7DlOsb1?=
 =?us-ascii?Q?ij04qfsugccjT2Vy3bslwJbEcoL2ek0Jd3j9yNBLeAVhLpkjuNi7XV+OXDvh?=
 =?us-ascii?Q?ZCCzkBEDIuRNEeMjqe78EgJFghYN8owDD23/pRjhmAHmtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSgolWc88hd1COp1Cemb3EzzGOxh0SDd4w+x9Eev7GspbfMC0UL9MQrvG8kV?=
 =?us-ascii?Q?gkp6TniAEPvbBXJSS+/yTQ3+43IT3GJjnwEZSPW27LMvs2GYVYsgUjHMn165?=
 =?us-ascii?Q?mujvuaYOEWuytLqdLAywFqpKdmGYe4rmpMiKvEJ79ahflB8EmPXX99p0VAf1?=
 =?us-ascii?Q?qf0beSwtQ6egA9dGqJ7CGxXDSzsYCX3G/wRP+3wvdAMljpTqnJ1hafuMbaTq?=
 =?us-ascii?Q?nwYzvBT4lVsyQUNizL0wDMMWHclf46L+kZRLDNVGtUq0aXB8dEJNGkcz98YD?=
 =?us-ascii?Q?TNYOjfVvsmNkxvk8jZkJffVS0ac9hi82w+AHWUhjFLzHCmQlftiqUc1bTYrL?=
 =?us-ascii?Q?m0zwr4/JE3kC30K3rv/knSy4/aV5FQrD7Mw3/sJVyiLwNCLzNe6ONZpVtt8I?=
 =?us-ascii?Q?FMeBKvdEXmwqOozAvQ+qfql3TwXLlhfDApE8yufmnediRwRiIe2ojgp/P+/4?=
 =?us-ascii?Q?aqVQAEsEvvsgsWmLtYpyyOuLKm9svejtfq10sfTAEuhwaqKc2QODudhzf0bF?=
 =?us-ascii?Q?mJT8ThApLxKiuv+Tt6j+XEa5f3pghW1nZ3xKvP09iymBMftwsjk2Nc2+PToI?=
 =?us-ascii?Q?9797GzrqmW1ZUp9JFk0kqP6kQqKhXXoz5eeIvtHzOmP1cv6CAm+6SJwIHYVl?=
 =?us-ascii?Q?LIv47BWSeyxTQFPOA/SZ88Zqi6k/qNCq2DDyTCppkaHPlcGBnELLaKdSBaew?=
 =?us-ascii?Q?fFb3qKaOjDQGa8T3x3Ql6ixG0xXGHlvZueRNJSzbkHLpgoWZEg6LO4VLlCo/?=
 =?us-ascii?Q?L/ZPKR651GNqZrT0C+/zyArNDRepN6iLfx3zFO/20SNTL5lOOCRdxr5FzaMm?=
 =?us-ascii?Q?NgSwNgqWRRhZvO/PGX9M0fHgdNCpd2BMRmwkSH+GdQXJwu9kn2IhiTvRyfcJ?=
 =?us-ascii?Q?D7artzS6D7GyDvyBoaRJGDijfS7hPuvpYToW8g8lYYk2cxiXUChiYzw8iCbU?=
 =?us-ascii?Q?bIfV7KVnpY3AiJHcCRtkzhHYHmPeRhCuTNtpduUz7mYE9KUGxQSnJmWtxaE+?=
 =?us-ascii?Q?nDOTV92hdpzezF6bFQS1zHWaMdd6/Uzm9HzrpHa8LsEewxKyJtI+cgmLX2Ln?=
 =?us-ascii?Q?K8Gdm7SiYku5CaPQwRG3umM/VnFmAnSGub8SdrQ2I4RZyMF+plzQcL/Btl8J?=
 =?us-ascii?Q?FSeOHos01sawbBhiYrt6Sb+JiaUOwXqnR4m3KHJHwvLOIKV+ZDYnK7omDq3C?=
 =?us-ascii?Q?3y0qXMHfE/1lfNNIjbQ2TQZWb+xRRhiDeyD+M07PD026TFhdIBYucvKQCkzH?=
 =?us-ascii?Q?qAQ2YnV58na/ExeYPo/JyKWDJbYUNTIwaGRes9ZZ4IeaICKfqyZ9anZv5+zr?=
 =?us-ascii?Q?yHjLaNh/T+H41XW69Si7aJLR5gI1gYn6hTLKVhOoyRg6AraLralFkt5CTZbG?=
 =?us-ascii?Q?2XZGZiKmZdE/kRg9lhElWgntupZx2NOCP3fFGa2FtsupHpQWt021MNUK+h78?=
 =?us-ascii?Q?+bqT4ivLAkcLJWGjSFqg33/a2sZbJAMzDXJxASlABpInhPaZpNvTuga+TTUN?=
 =?us-ascii?Q?JL77UGlpUMdNHiy2jh4otErqbz809TucHx4nAztaNviLgIUtpnddy5Z/bYkW?=
 =?us-ascii?Q?W1p/wcUiDwSa4KqTjmYWwdhYC3O7AUxao2DsllTS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83345a6b-5cfe-4eb5-e048-08dd373608ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 20:32:17.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnqL+FYSFPSDW3hrMC+1tSvPVWr/D9o2IQSYHhn9VpGtq/YbE3PlKVfabfOHDLeFzgSO4/kFHr+R/VtLrL/vHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Jonathan Cameron wrote:
> > On Thu, 16 Jan 2025 22:10:44 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > The pending efforts to add CXL Accelerator (type-2) device [1], and
> > > Dynamic Capacity (DCD) support [2], tripped on the
> > > no-longer-fit-for-purpose design in the CXL subsystem for tracking
> > > device-physical-address (DPA) metadata. Trip hazards include:
> > > 
> > > - CXL Memory Devices need to consider a PMEM partition, but Accelerator
> > >   devices with CXL.mem likely do not in the common case.
> > > 
> > > - CXL Memory Devices enumerate DPA through Memory Device mailbox
> > >   commands like Partition Info, Accelerators devices do not.
> > > 
> > > - CXL Memory Devices that support DCD support more than 2 partitions.
> > >   Some of the driver algorithms are awkward to expand to > 2 partition
> > >   cases.
> > > 
> > > - DPA performance data is a general capability that can be shared with
> > >   accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
> > >   suitable.
> > > 
> > > - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
> > >   memory property, it should be phased in favor of a partition id and
> > >   the memory property comes from the partition info.
> > > 
> > > Towards cleaning up those issues and allowing a smoother landing for the
> > > aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> > > array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> > > way for Memory Devices and Accelerators to initialize the DPA information
> > > in 'struct cxl_dev_state'.
> > > 
> > > For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> > > get the new data structure initialized, and cleanup some qos_class init.
> > > Follow on patches will go further to use the new data structure to
> > > cleanup algorithms that are better suited to loop over all possible
> > > partitions.
> > > 
> > > cxl_dpa_setup() follows the locking expectations of mutating the device
> > > DPA map, and is suitable for Accelerator drivers to use. Accelerators
> > > likely only have one hardcoded 'ram' partition to convey to the
> > > cxl_core.
> > > 
> > > Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> > > Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Alejandro Lucero <alucerop@amd.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > Hi Dan,
> > 
> > In basic form this seems fine, but I find the nr_paritions variable usage very
> > counter intuitive.  It's just how many we configured not how many there
> > are, potentially with 0 size (so not a partition).  I'd be happier if we
> > can avoid that by just prefilling the lot with zero size and filling in
> > the ones we want.  So zero size means doesn't exist and use an iterator where
> > appropriate to skip the zero size ones.
> 
> The PMEM-only device case did give me pause. Is that 2 partitions with a
> zero-sized first partition, or is that just 1 partition?
> 
> Ultimately I do think the code should further evolve to treat that as
> 1-PMEM-partition, but as far as I can see that depends on 'enum
> cxl_decoder_mode' being eliminated and teaching all code paths to search
> for the position of the PMEM partition.

I was of the same mind that the decoder names could be used to index the
array.  For ram/pmem this is baked into the user API but for DCD one could
imagine not just specifying partition dc0 but rather a 'ram' dcd
partition.

> 
> > Without that tidied up, to me this is more confusing than the previous code.
> 
> I was going to save PMEM at a partition other than 1 for the DCD series,
> but let me take another pass at adding that to this series.
> 
> [..]
> > > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> > > +{
> > > +	struct device *dev = cxlds->dev;
> > > +
> > > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > > +
> > > +	if (cxlds->nr_partitions)
> > > +		return -EBUSY;
> > > +
> > > +	if (!info->size || !info->nr_partitions) {
> > > +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > > +		cxlds->nr_partitions = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> > > +
> > > +	for (int i = 0; i < info->nr_partitions; i++) {
> > > +		const char *desc;
> > > +		int rc;
> > > +
> > > +		if (i == CXL_PARTITION_RAM)
> > > +			desc = "ram";
> > > +		else if (i == CXL_PARTITION_PMEM)
> > > +			desc = "pmem";
> > > +		else
> > > +			desc = "";
> > > +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> > > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> > > +				 info->range[i].start,
> > > +				 range_len(&info->range[i]), desc);
> > > +		if (rc)
> > > +			return rc;
> > > +		cxlds->nr_partitions++;
> > I'd just initialize the rest to 0 length similar to what is happening
> > if we have pmem only anyway.  Then this nr_patitions goes away and
> > stops being a possible source of confusion.
> 
> Modulo teaching other code that wants to ask "what is the size of the
> PMEM partition" to use a helper that hides the "find the device's PMEM
> partition".
> 
> 
> > 
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 3502f1633ad2..7dca5c8c3494 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -1241,57 +1241,36 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
> > 
> > > -int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> > > +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> > >  {
> > >  	struct cxl_dev_state *cxlds = &mds->cxlds;
> > > -	struct resource *ram_res = to_ram_res(cxlds);
> > > -	struct resource *pmem_res = to_pmem_res(cxlds);
> > >  	struct device *dev = cxlds->dev;
> > >  	int rc;
> > >  
> > >  	if (!cxlds->media_ready) {
> > > -		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > > -		*ram_res = DEFINE_RES_MEM(0, 0);
> > > -		*pmem_res = DEFINE_RES_MEM(0, 0);
> > > +		info->size = 0;
> > >  		return 0;
> > >  	}
> > >  
> > > -	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
> > > +	info->size = mds->total_bytes;
> > >  
> > >  	if (mds->partition_align_bytes == 0) {
> > Obviously nothing to do with your patch as such, but maybe tidy this up
> > by making active values == fixed values when we don't have partition control.
> > That seems logical anyway to me and means we only end up with one lot of
> > range setup in here.  I can't immediately see any side effects of doing this.
> 
> Yeah, I mentioned this in another thread. There is no reason
> for 'struct cxl_memdev_state' to carry these values at all. They are
> just temporary init-data.
> 
> So, cxl_dev_state_identify() becomes cxl_mem_identify(), since
> it is a memory-device command. Move it inside of cxl_mem_dpa_fetch()
> since it is just temporary init-data for 'struct cxl_dpa_info'.

I took a different direction and removed all these temporary variables
which also had the side effect of separating the mbox command processing
from the resource creation.

I do prefer cxl_dpa_info to the way I coded it but I did not anticipate my
structure living long I'm also not a fan of 'cxl_byte_layout':


diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 6d63c29eb0e1..9646465e2cbe 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -463,12 +463,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
  * @exclusive_cmds: Commands that are kernel-internal only
- * @total_bytes: sum of all possible capacities
- * @volatile_only_bytes: hard volatile capacity
- * @persistent_only_bytes: hard persistent capacity
- * @partition_align_bytes: alignment size for partition-able capacity
- * @active_volatile_bytes: sum of hard + soft volatile
- * @active_persistent_bytes: sum of hard + soft persistent
  * @ram_perf: performance data entry matched to RAM partition
  * @pmem_perf: performance data entry matched to PMEM partition
  * @event: event log driver state
@@ -485,12 +479,6 @@ struct cxl_memdev_state {
        char firmware_version[0x10];
        DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
        DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
-       u64 total_bytes;
-       u64 volatile_only_bytes;
-       u64 persistent_only_bytes;
-       u64 partition_align_bytes;
-       u64 active_volatile_bytes;
-       u64 active_persistent_bytes;
 
        struct cxl_dpa_perf ram_perf;
        struct cxl_dpa_perf pmem_perf;
@@ -811,10 +799,19 @@ enum {
 
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
                          struct cxl_mbox_cmd *cmd);
-int cxl_dev_state_identify(struct cxl_memdev_state *mds);
+
+struct cxl_mem_byte_layout {
+       u64 total_bytes;
+       u64 volatile_bytes;
+       u64 persistent_bytes;
+};
+
+int cxl_dev_state_identify(struct cxl_memdev_state *mds,
+                          struct cxl_mem_byte_layout *byte_layout);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
-int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
+int cxl_create_range_info(struct cxl_dev_state *cxlds,
+                             struct cxl_mem_byte_layout *byte_layout);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
                                unsigned long *cmds);


> 
> [..]
> > > -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> > > -				 mds->volatile_only_bytes, "ram");
> > > -		if (rc)
> > > -			return rc;
> > > -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> > > -				   mds->volatile_only_bytes,
> > > -				   mds->persistent_only_bytes, "pmem");
> > > +		info->range[CXL_PARTITION_RAM] = (struct range) {
> > > +			.start = 0,
> > > +			.end = mds->volatile_only_bytes - 1,
> > > +		};
> > > +		info->nr_partitions++;
> > > +
> > > +		if (!mds->persistent_only_bytes)
> > > +			return 0;
> > > +
> > > +		info->range[CXL_PARTITION_PMEM] = (struct range) {
> > > +			.start = mds->volatile_only_bytes,
> > > +			.end = mds->volatile_only_bytes +
> > > +			       mds->persistent_only_bytes - 1,
> > > +		};
> > > +		info->nr_partitions++;
> > 
> > This nr partitions makes some sense though I'd be tempted to add a type
> > array to info so that we can just not pass empty ones if we don't want to.
> > Makes this code a little more complex, but not a lot and means
> > nr->partitions becomes the ones that actually exist.
> 
> Agree, that's the end goal.
> 
> > 
> > > +		return 0;
> > >  	}
> > >  
> > >  	rc = cxl_mem_get_partition_info(mds);
> > > @@ -1300,15 +1279,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> > >  		return rc;
> > >  	}
> > >  
> > > -	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> > > -			 mds->active_volatile_bytes, "ram");
> > > -	if (rc)
> > > -		return rc;
> > > -	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> > > -			   mds->active_volatile_bytes,
> > > -			   mds->active_persistent_bytes, "pmem");
> > > +	info->range[CXL_PARTITION_RAM] = (struct range) {
> > > +		.start = 0,
> > > +		.end = mds->active_volatile_bytes - 1,
> > > +	};
> > > +	info->nr_partitions++;
> > > +
> > > +	if (!mds->active_persistent_bytes)
> > > +		return 0;
> > > +
> > > +	info->range[CXL_PARTITION_PMEM] = (struct range) {
> > > +		.start = mds->active_volatile_bytes,
> > > +		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
> > > +	};
> > > +	info->nr_partitions++;
> > > +
> > > +	return 0;
> > >  }
> > > -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
> > > +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
> > 
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 78e92e24d7b5..2e728d4b7327 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -97,6 +97,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> > >  			 resource_size_t base, resource_size_t len,
> > >  			 resource_size_t skipped);
> > >  
> > > +/* Well known, spec defined partition indices */
> > > +enum cxl_partition {
> > > +	CXL_PARTITION_RAM,
> > > +	CXL_PARTITION_PMEM,
> > > +	CXL_PARTITION_MAX,
> > > +};
> > > +
> > > +struct cxl_dpa_info {
> > > +	u64 size;
> > > +	struct range range[CXL_PARTITION_MAX];
> > > +	int nr_partitions;
> > > +};
> > 
> > blank line seems appropriate here.
> 
> Added.
> 
> > 
> > > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> > > +
> > >  static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> > >  					 struct cxl_memdev *cxlmd)
> > >  {
> > > @@ -408,6 +422,16 @@ struct cxl_dpa_perf {
> > >  	int qos_class;
> > >  };
> > >  
> > 
> > >  /**
> > >   * struct cxl_dev_state - The driver device state
> > >   *
> > > @@ -423,8 +447,8 @@ struct cxl_dpa_perf {
> > >   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> > >   * @media_ready: Indicate whether the device media is usable
> > >   * @dpa_res: Overall DPA resource tree for the device
> > > - * @_pmem_res: Active Persistent memory capacity configuration
> > > - * @_ram_res: Active Volatile memory capacity configuration
> > > + * @part: DPA partition array
> > > + * @nr_partitions: Number of DPA partitions
> > 
> > This needs more. It is not the number of partitions present I think, it
> > is the number that a particular driver is potentially interested in.
> > 
> > >   * @serial: PCIe Device Serial Number
> > >   * @type: Generic Memory Class device or Vendor Specific Memory device
> > >   * @cxl_mbox: CXL mailbox context
> > > @@ -438,21 +462,39 @@ struct cxl_dev_state {
> > >  	bool rcd;
> > >  	bool media_ready;
> > >  	struct resource dpa_res;
> > > -	struct resource _pmem_res;
> > > -	struct resource _ram_res;
> > > +	struct cxl_dpa_partition part[CXL_PARTITION_MAX];
> > > +	unsigned int nr_partitions;
> > >  	u64 serial;
> > >  	enum cxl_devtype type;
> > >  	struct cxl_mailbox cxl_mbox;
> > >  };
> > >  
> > > -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > > +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > >  {
> > > -	return &cxlds->_ram_res;
> > > +	if (cxlds->nr_partitions > 0)
> > > +		return &cxlds->part[CXL_PARTITION_RAM].res;
> > > +	return NULL;
> > >  }
> > >  
> > > -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> > > +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> > >  {
> > > -	return &cxlds->_pmem_res;
> > > +	if (cxlds->nr_partitions > 1)
> > 
> > This is very confusing as nr_partitions is being used not to indicate
> > number of partitions but whether a driver has filled in the data for them
> > (which may well be empty).
> > 
> > I'd rather see that as a bitmap, or a 'not set' value initialized by
> > the core that is then replaced when they are set.
> 
> ...or even better, not require PMEM to be at partition1.

FWIW I think that is a step to far to be rushing into 6.14.

Ira
