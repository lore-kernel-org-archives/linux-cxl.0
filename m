Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530633CD1
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230171; cv=fail; b=quTuZa2LzhnYd1ORES4NG4NrFvgOENlZaW+BHa6Fe0ICyzEr9tZhl3HhSUnnzkO/6ktKqOhrlbj2CGnp5tszC/PpVcGjKLew3ZAPuNNTAtoWF/MIhMWInbKB1ZrTjv/NVQBhU+rTChCn8IVE91chfhi3I5MsM98vo/gVXPqB964=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230171; c=relaxed/simple;
	bh=XyJSu46lC5haPJ3XnipIYX2E+rE8dCVMkiWqXQJyKl4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dAlQGpHFGgCLfIJ0wEKYgRmvsk0Udt4erUZUCnWdPfnv63/fhpzkVHGB6vEYhJ35cQIXGKcMzk2tfUQLNudpTiSmh15j1yVjYtAdNXG3m5LP4tUULGOpUfiOx+97yAozLwaIV6zK0eTwnVWTI9AGDWyH2tqM+00xOe5h4fvO0RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWWduQuZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWWduQuZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723230170; x=1754766170;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XyJSu46lC5haPJ3XnipIYX2E+rE8dCVMkiWqXQJyKl4=;
  b=UWWduQuZtjRIg06X9MRt3rSiDEiT02KA5r5Gx5cvHaWUSBp+izKgSdop
   jvl9lRZ3q/JO3gnLwGKeV1P4d/91zWYyw7ZNpwgLqBEU3tsWAWkb1piPV
   Z9/vXp5tvttaEbxbvQo8ZRZFT0ig0TAGbiD2f/xxjGIDbkyZe1ki7+2qI
   lKRh7/IYAJ3FJAz0lQZDJJs4DS+ZP+3zzPE5/ilPh4HcORHDLaZTCorSs
   zLsf3PrMR2Xq8G6QZ7JdY0I1f6l83KfGx8u8pabqM5/7noj2+07nYvvdR
   /EBOjt7esHQBINt/qbMsL1+2pUCZeO3Z+p1BZ2k9AtVM0dN0g43d891aR
   A==;
X-CSE-ConnectionGUID: x/+yyQRzT2updXvBbYSo2g==
X-CSE-MsgGUID: L+eLd6p/SKGrVnd/4ie6EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21275461"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21275461"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:02:46 -0700
X-CSE-ConnectionGUID: 4MTKJWAqSAqFUtWoQ3lbzw==
X-CSE-MsgGUID: PIiHWtBxR/Gwn4Z0pXC5Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="58216089"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 12:02:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:02:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 12:02:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 12:02:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNT4S4dG1eNjxl1gobKchmBtVn/MG2AQc7WmeH4qpSVP4hkhlZ/YTVWtp63U6HBMO32usHP+VVGfagvmz9+OdCa/rxMDGOrW/bHFU++sElpQBPUPJ0h7VQksdlSFoyClt9WEjIAKu6YU2pfDgVwB9sK5vczlKCAHcQZV9R+hK9wsoSd9KvM0k6i8F59nMA+FneU0DDee+2Si26jnjbMLRPgZQCoNN/pnI2VzL6niwS/d1cXUTsuYDv9YvqHSX1YatEab3buqB1fz3gb7UeS94/P1qJYclLfKl9o4zO5W9FGVkDOG2rUeLXl+cPJUrU6GJsGhbGGCaeGFc4WC5BWptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKYyliI8WeoWsh/4GqkuU4ykaoWihRYIXiNizCw+MuU=;
 b=fszicSs/jNTDq29bqIcivS+CXEI7vaGNRiZN7x9X3ftetYgprLRhW4kkI2uh/u+4m9SYM6nIJbA3v8JtYEh519k2ACIF/0OSWMQ5lOjb96lVRetNbEWXCTG+TjasIPNfHzBWcC3BTbOljc9KIU1ZMsrocWwoyowMUzCvCEn1YjqnzGvRx7rsYa3qS5pMufvHEXFufG1LfFJWMO9v4oYNHLCtLqfI4h7nuW3cl68PpiT/U/lyvas1lol2i4XVZIXR383AXZ0tUlQWMAmuZn8eKV3HWZv2+suYlL0b+UyYf19zaOttS3VOgnMt5cvAbi5cJC33tZ0Rg44PctDZoY6fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7999.namprd11.prod.outlook.com (2603:10b6:8:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Fri, 9 Aug
 2024 19:02:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 19:02:37 +0000
Date: Fri, 9 Aug 2024 12:02:34 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>, <yanfei.xu@intel.com>
Subject: Re: [v2 2/4] cxl/pci: Don't set up decoders for disallowed DVSEC
 ranges
Message-ID: <66b667ca7ad47_257529424@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-3-yanfei.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809093442.646545-3-yanfei.xu@intel.com>
X-ClientProxiedBy: MW4PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:303:6b::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: c31c58d2-9833-4498-4bba-08dcb8a5d58c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2CDIDzLhWuRsvJE25FBwH7kRAf8dPIGr2pZMLNMP8F7wgkhxsnrqmUfxxuJW?=
 =?us-ascii?Q?b8lrFxW5VczdTv+eAFttN1vGCNN6G8wIASGKg/oGxRczms2ArwezF57IfzEf?=
 =?us-ascii?Q?DwhOvkabPLXQtv2H2qjwQYfO3/CJq7hLK0g+/Qjh0zcmDlXs/a1ZmwnHqM37?=
 =?us-ascii?Q?UtG3poNkSMCt1/UQ+CU2dia6ze31BEp1rCBJ87cQU3Noum7BcM9porMC+IQr?=
 =?us-ascii?Q?6JEj1i26X4cI4UYZ9DpflFTNT+l34IZLewUytm1+J4kR85E+2ec4IQV+raIA?=
 =?us-ascii?Q?0LCe398oVq853jh2P+96usuJXja8YNpIntUAzaJnYTiyPbaJVIydBviAKBlK?=
 =?us-ascii?Q?AgIwTIhGWD6lcJwDtiqOQWihj48Y9XPiwbZrVuKKLxVmNwRsRU+n9xOneeSn?=
 =?us-ascii?Q?WFn+yUQpa02w5CnT3nXtwoaS4DcUiWVJWY1hRZ8p2JbOTNuYNXNEOM3cs93X?=
 =?us-ascii?Q?oY0BVjmJxWjuvjDqaEUA7QrfddJXi9vC4IOQHtrnQkApj0gJP7uh8PqfN/v/?=
 =?us-ascii?Q?62oZJLWUU11qHLln++3K82LeaEf9qysSrHXwNKiUV3ksRod2l0Okuq3zMK2w?=
 =?us-ascii?Q?4e7FDRSkIntuo7K2m9QrUIeeY7TZbFd/GI6GX2O+XA7IBhy6wxnUAjgrNn7K?=
 =?us-ascii?Q?kH10ZgXIleWrfKKhmxwuRQe/xdZqVAOIc2fsdx5t0+iUiQcZ+guwKXwXdSr0?=
 =?us-ascii?Q?8+0sN3/6xv+hXiAKuDe0z3CnHzjL2OqYh1Kub+u/FLKecqzUQt1vmK6ftbSq?=
 =?us-ascii?Q?w4A1YvXkz03z/Gy3OdKD5LnFPLfe1x9POQBUn+5ABmhprHngBKmxaBbRJKzh?=
 =?us-ascii?Q?R/dJBjtTvBzMI0/RsrYLYoJGy4Isn7vI1KG3GYbcKW9wa1CY9RoC88m7BceW?=
 =?us-ascii?Q?2JmREIrzvI5AyULbHhmFKM5/NY7TFDiPUtAIA0Yt2KEAQGb5MHgC9gHPT81F?=
 =?us-ascii?Q?yrrEDe7Nw8lKDM1ly/ZG2S+x5s9tKElrG1O4klSr1F9psYLFOB0Gn5KrjTMT?=
 =?us-ascii?Q?Dv3Rze/IjVG6pobf/LJWrY1SfduB3C/7w5RxMv52SzHfXm7mZlElm7ic0egC?=
 =?us-ascii?Q?LrDDtpKwtbioVWKoGn3oM5yQbnRQMt/yj3m1zEofqeb92DnznRBRTlqK7ZJU?=
 =?us-ascii?Q?NMfRuXQgCDEC34StRGUQVwj2qSYBgHfxaSdNeezFAYiD/ekeT6PJ/i4tnzvs?=
 =?us-ascii?Q?PcJ3qYqrxfeYediXfSEEhWOZYsrP+3f1aTFPxN66GMFWmzdJE/sELiIHfk8N?=
 =?us-ascii?Q?zhdQIm5waWYKaNipiDcJqocJvqhpFmDidtCRi2J8ieFL6f0xdwD9bt/FtADO?=
 =?us-ascii?Q?Z7sKliCdcLM8KYKyxUuCEU0ls5FQfYUt+VP4eE21CYCKuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l8Kz1qotl7kjqkPGfQ0WlP6FuieBuVydJW+z9jyULVwjF0T71yqaV4cgZhAo?=
 =?us-ascii?Q?+fLwH6wVRNxycaDBn6ZoR+kCvp03Hunum8vjcRLOiBeS61AP4HQCH5V61E3I?=
 =?us-ascii?Q?9vle+2/iTsLp7gEJyZBJGIhc3YOhSQPQ4XgkClV9MauKETQQPoTsCgaBUr6V?=
 =?us-ascii?Q?IVNBFReJqHjtU9LzsGrJwGxn57sBaBzpHIhI2fMmU+FXMP2FaXe9OUivZwxV?=
 =?us-ascii?Q?kxDgK1HlWESy7BtFnAMxk2ZuJT/Z7HAS89LLmb1dc5398tldSyn64Mhr9kke?=
 =?us-ascii?Q?kzLBOMc37B2e2iJ7pUKwEg99W3dz7VvfuVnv5QJ3mmjjuAWrSST4b3Um2k0O?=
 =?us-ascii?Q?cAxMCta0SgRkp1hWY0cnz9mTm3cmrX1DeZqiD2bTtzwVpy2QkC6RZrC7uhV/?=
 =?us-ascii?Q?aWkx01OQgIepOUC3sPbrfxBNP/6XVmVoIkYuo9GtUbcz9dDfqdm89eUAAwAI?=
 =?us-ascii?Q?mub4gggZRK69NezpL81gCXQauTaUuO5tSQp8pS3AwQ5v5z4lM7vp1OL8nFPe?=
 =?us-ascii?Q?km1J3k2h5Uu9wMASO1k4AKDrhefI6H7LUoO8fVQrs/vBC1CH8roH4XcBqgL6?=
 =?us-ascii?Q?jv2oARXMg4DbIz6KRqsJgq0pcQZuhlhPy3nylMzBXz6Mgn7CAoexxTojOuj1?=
 =?us-ascii?Q?R1yEA5VGk2g1o+2wdblTBwlof6aRrFGBawIHIXuqiVhipodDAr2OJyStHbmQ?=
 =?us-ascii?Q?r3kkmH52CWmb+Y5WCRmHNLxtfq91xOiFgruMBjhV3ovnw6jdli0eCJy4l/Sy?=
 =?us-ascii?Q?UCwMMqT+JABTM3bjiRfmRwzkX/MVQ1ZyX35aIHpEyXptJ7YpOpcSuhrbd0zV?=
 =?us-ascii?Q?utcRbYvOLIccGWnaIr/sKJ1Mwb/dzIOC/hnRqjydsmkGg9zodZDjt+FhMiSe?=
 =?us-ascii?Q?ou5K3fWymitP/7I3R1+kl8UT65kK0431pZKgM3nC4dTBaScRh+dzX5390IKW?=
 =?us-ascii?Q?jMUZRCiXXw9FffyASZF7FSsqAr7+HcpXqCh3THWVkMMyvP10IJ6kQ1NKCH9L?=
 =?us-ascii?Q?YQkLWQp347WtOGW+PeG5HDFRrCgPr9RFlOB5G1mUyhxEavG/4vi99sjd1Nhk?=
 =?us-ascii?Q?yI9EoQROylxlsVSiOXD1E4FWGOzva0yXAwThSWj3g+8xoD5OVVbnQ1X1ZD88?=
 =?us-ascii?Q?hbgo7NzYRkNlHW6cLWF9+B163RKkPemNav20h0ej1EJndGLxPb9uw7TRsIj9?=
 =?us-ascii?Q?cE5Vd3aC7RcrTVXAPH1bfJvp0K4ukBk0ZFgqMg68/GYUqVU5FjEEz617dKrk?=
 =?us-ascii?Q?7g2XUUvidaWTE3lOWLrczKflAO2txUdeRe3tkYX/G0uOjHKgf5VBdNGkX47k?=
 =?us-ascii?Q?XAfGhAHex+Z/AZkUR7DIYr11bQ9mkwoth6h9ruyy+OzmrBw8WgJxuzplF1AQ?=
 =?us-ascii?Q?PBwkjtDhQBtZ+qh27XLxfhpJAUFyIrUM6aX3R1zp2AFqt1dajykm9uRJUZeU?=
 =?us-ascii?Q?Vax3oZrpWiJJFd+4DTUEQbqo5opIWiB/8MpzEOySXZfEQTQW0whVlwrmxYli?=
 =?us-ascii?Q?1OekhlKVUi2jOejbzRCiUDFQetJ11rW+KV/IyOdx7Tl96s5J43atKTmHoIRo?=
 =?us-ascii?Q?aTXdJwHPHiYmO4pThCu9lbCQ1UOJPjokYFgWAreWbSnJVi+EhgEZnLK25+em?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c31c58d2-9833-4498-4bba-08dcb8a5d58c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:02:37.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI//tXhxBSnNOFF5RPphb5+jsI69ePaXJbZA1W2k03sHxQhQU3OH5x1zruoexzpDds0eUY45ktbIbTW+n4RhmnVmXyaYQecqR6WqQTCXHNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7999
X-OriginatorOrg: intel.com

Yanfei Xu wrote:
> Since it shouldn't create and configure decoders for disallowed
> ranges, move the check of dvsec_range_allowed() earlier into
> cxl_dvsec_rr_decode() to filter the disallowed DVSEC ranges out
> at firtst.

"Fixes" explain the user visible side effect of the problem. There is no
problem being fixed with this. It is maybe a conceptual cleanup, but to
me the risk and thrash is not worth the reward. Unless I am missing
something this is just code movement for no value.

The "risk" is that I think this breaks cases where BIOS has enabled HDM
decoders. I.e.

        /*
         * If the HDM Decoder Capability is already enabled then assume
         * that some other agent like platform firmware set it up.
         */     
        if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
                return devm_cxl_enable_mem(&port->dev, cxlds);

...the DVSEC range resgister values do not matter when HDM decoders are
enabled.
