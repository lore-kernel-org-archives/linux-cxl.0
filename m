Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9A3A29F
	for <linux-cxl@vger.kernel.org>; Wed, 31 Jan 2024 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739857; cv=fail; b=mGS8CFmFjTSqnafuev/f876OK65DU9VNd51p0+hqkgdjY1RURGwVdsyzyNtDScoUWwwWO+nzedqisceU/4Ov7jo9qPu/9lwAykGOcktRlkhezh9ZOBDuShViO3GP2QW5uPFOm4fbtuFlGhF+0IHHxCdv7c/4U1mvSEIY267R6mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739857; c=relaxed/simple;
	bh=U6JPY3LJTevdkA1gXLL6CEehCOSaeb75GsU0/1vHFKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZUk33v1DxIAZVCGZVdLvNDeRqLubjnRwZMeOiAvsBpVK9NEsL/8gl2651lZxpm1wRsvsXXLCdx4x6Hw8YhJiyjYyBqr9EvYCD7v2i7f+cJZ1olyUGL4TvpWjNkP7mi66P6gs1XKlDnwDXDAAa+mLtDh3LtIQiZDENuOnehbghqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lL1xS7Oi; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lL1xS7Oi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706739855; x=1738275855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U6JPY3LJTevdkA1gXLL6CEehCOSaeb75GsU0/1vHFKA=;
  b=lL1xS7OiptHAUQOeuxOFnb56aslsO8rd2cs8yWiekkrgY0JsXWHgKSnY
   e3N8ROzXkl3SDp1X/AaTTAMO5kfaps/jGHId/UrGIQ4mzx8udnOjC464F
   dC4kqw3BsgDrLX/Ofux0xYcDQmtJ5ws1dbrjlxTg+6PohinR+wJGo4yIl
   a9LMjMtxNrFLtCHvLet4bmCBl5z660F+I6M99iDR0f5h7EXYt1bBGvz+N
   rS4cieW0jVh2zep8IV7VkHjsGLz2UhikxzseHn1sb4knN0MlFwDjPKDmf
   6Uots1vlixd7lvzRSCFMXJdpjT53UZcg6Bl+O51D6O4DfA/Gc/rZhyxit
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22244029"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22244029"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 14:24:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931994400"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="931994400"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 14:24:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 14:24:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 14:24:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 14:24:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK3c6QI6IgJnaPJM235P1kp6Ry1OytZ+Fy7z5akTPgm7izTyKT/LjFTn2fWrdFYxzKJ3xFp4EddIs/VRHUmMOI6g28wUK7rvxDGPKUVl+0K2/hLOCp/Ve/dr09TFrx5UYmCdC1PgycXLsypY0AaohLbqNBSctj+LutzroBVNCTJnA+1bByjemDA2vcOFsp4b3v4gDAr4bD/uuUoBDxFITesowataX67Yq4iG1FxEXRj1lhg3vQwPQd62mZ2daRWvBL0zTgDd/sqRi9KdYwd7oHzKyh77KfisqftkEAxUDwGvb76AiewFQx52ROM8RrHLRgtYGBRYCvJPDy4N1VCqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LE37YnUIG36DxzXTSSU7dBe6AtlgeGsna/jXFJClyY=;
 b=AqeVa2mPJ1h1xbNjZ6Dq8ZCnYiAlyhDa089/qMTxtu12kA3uPEB8NWNL8wFTNInOkadOMDqZQMVlZQqSOmIp9m6SQMnXj0zQqxCsETDZBRaScpONZk0sNJmitdoBiaGLXop1CteE49B3Ymk/XzuLoRNSkL346gojBsnM/113FhldNUQKsBNXipygS5W9ZspG1Ck8Ripm+pbGsHXEK/tzCWDb6hkuW8lmZzrhYwUT8Hhm07Oqi8vCJIzrSY5acVaa+qFNVTcbzo8rcbyOnARMmz8IGoFwJu3gNzn68F/3e2zV6eL/OW0xgb1OoZM5GGy8KfAaHF/Qgukikhnlv5f+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO6PR11MB5666.namprd11.prod.outlook.com (2603:10b6:303:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 22:24:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 22:24:09 +0000
Date: Wed, 31 Jan 2024 14:24:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Wonjae Lee <wj28.lee@samsung.com>
Subject: RE: [PATCH v3 0/2] Allow out of order auto-region assembly
Message-ID: <65bac886d1459_37ad29475@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1706736863.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1706736863.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO6PR11MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0ed6e5-b830-4c58-9f1c-08dc22ab5809
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cAHpombuyAFnSXTK2r6te0paIDwoBQZA9pZh7M8ySe7PXNwt1GyxZws8fmU7vucy6RTnC6YBW9gtlNpPC18Vb+jtLdYEKIC90VNtHN5ouoq3/qdizMOmgc+xank1ytOQ2dxIprhM9PcnMBCWbH6KXSH107ZhlUUX7QkNHBpcrxMf813STUvMmX+F1bTr/yHJWvnshNFU75hgG6UCSkhXkcgb6Wms5Cm8f1+rXfLo2DGTAFDxG5Z06awumPrVNOjfoFTPXyBHj5xMRa5+g6ivI7IiSetfFGtsA3FThUMKeqwZn35U+CvkTHmaHjYWYGSk0cjsDtbuizoC3BpdW1TJUrsyWX4BeMS9pHHuvDbEJMbhjPT5Ls6ry11k3F/CcE/RJiatQUf2cuWnakOQ8eauSwZSjBWItkF9lhq+TIrgIRwEwlES87gcMFDAbL6+n2R1uNvwwsk1YT0R9RgZfSNO55QZEh/eGwBnX/0NXUgOBpTrgttqZcZZ+m0GOoDl9THTmahp6tXJRtUi2rB7/MmmI1+d9XzRmYamKdOo6SWuBvacnqMmks8l12ta0IEhjfV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(8936002)(66946007)(8676002)(4326008)(5660300002)(4744005)(2906002)(86362001)(110136005)(316002)(66476007)(82960400001)(66556008)(6506007)(9686003)(478600001)(6512007)(38100700002)(6486002)(6666004)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bcqqo3Pscc489U/ibZLqseWbUkL7gjOgzy6HKsxqjhhRAtcH17ap7cHvrSwI?=
 =?us-ascii?Q?JfRA1j90TgCY9mM9HeIV+e+zcB5fDA3EzhzzfoqfncBc2tz/b4kTXi+I3mJz?=
 =?us-ascii?Q?4Iww6wbTt0QkIGHaFhFgbTwPWuCkcW28ooukgnTCFk5xb3XW5XEGyGK1hp3P?=
 =?us-ascii?Q?ELi2m0b8Z2gvKp3wY+PbevHqx6a0AET/+Z57XL7r9v2Gb6PuEpNbYm1fRTU/?=
 =?us-ascii?Q?n1hH4vloldB66yR/c21zOiv+Hh4lMSLICtKcIF2ofKPUJ+VwKBqPbsQvDH9k?=
 =?us-ascii?Q?WiugGC5zo0XLsl5/yZP+10a07CDvDAFuavsIhjSeHGYZX4Hs8wAbF6cvYW/N?=
 =?us-ascii?Q?YSpvqsAGh3ry0zOocfvnU5W2ixs9kPEEb4y99VM4NKTlDZivBX6a1FA8EuFJ?=
 =?us-ascii?Q?aqrXFlCvovJd0IdbMqCmwoJif4qrIPhZ3Apn1mJse7lHPn/jPLQoiQjP49jb?=
 =?us-ascii?Q?p/lDv1DX++HiRJOFGbY5qvXse7tQNhKwWUR9rJVXqbUmkwNgChFKGyB3NHzj?=
 =?us-ascii?Q?1hsfzbQn5U9IFjFjF7bug/r8Vh3xzXKB4XLh6iICKs6xVzvA3qUmTT3QfUVm?=
 =?us-ascii?Q?W7cOroj01Wn380+b7UgA8S77DQrwfuYHQRIgI2ecccjexs3ph6sDofLRVxm0?=
 =?us-ascii?Q?nhXi/Xww0Qo4qAp9o2GMBLXK77Hf2wgzeZ66QrNAnAIDfjoIDigIKsaJ0yR5?=
 =?us-ascii?Q?XEGzw5j9p2CUfUJrlgII6kZzibC04sUsxnJ29iVn2ARIreOufZGNc1H6XFeQ?=
 =?us-ascii?Q?LWJ4t9tcbPLLP8O/V4cK5PcWTrvI1rKMtgBaRZs0bo7bbAZ9v8dR4JeQhBPd?=
 =?us-ascii?Q?qhMRoukUUS9kMKoLdF++hwMOnJ8c0RpQmsTmiZAqrQPCDuwqk2N6Sw+nZRMS?=
 =?us-ascii?Q?mq8GB88o9t3NNKQGd91Y+toCxEXVLb9/WFAHXz8nfq5kibhAh2w0UgwE0xOS?=
 =?us-ascii?Q?Ln/CDTHTvyzNcaISh8g8CrgolqI4erX2Y80L0YMTQgcwfytGo6ieDR92iVUW?=
 =?us-ascii?Q?ya5OdtlIzX3RdYRz8w0hPS9/LUmnGjOqqWnjkfdj3XWK9u447Yh3iUxwYEWX?=
 =?us-ascii?Q?JDocLsOjrlZ9X7dqGKzH0Knla4qUAsaJVY0ieNTIOkvBtbIv/hgLoECN9eDq?=
 =?us-ascii?Q?ysJkEgLjWhnHj9EPY95BE4eOsbw4uDroFMJ8acGoVUF3tu1e//IlRj/Dipdw?=
 =?us-ascii?Q?W42go6wkeQwm5N2L2GG18mOLe71Va+KAjMMUYKNXEQXOoRvB6tDI5Ih9oR4Y?=
 =?us-ascii?Q?7N63L5Ud5tC3OXB2LNyQbSGAt2n7L1prrlyWUCTVPUXxJ1nKoqAcNVfmEXN9?=
 =?us-ascii?Q?/WPDs+/0d3nEbdf1smmMBCpe23jo7Twxc8dtJ2KPao461NznAKgGVPd1vkY2?=
 =?us-ascii?Q?JrA3KgyDQ/TpQY++VCKpfw9PcoGmSVM2N6wvno3xJJTqxnujLM3UzNPteASo?=
 =?us-ascii?Q?082uL/a0kBbtQDiqrHscRPsmJt677IE+Kov389S53rME53JyjsnwcfuljbRc?=
 =?us-ascii?Q?edHSx4DEMmNc4pcUBX96CVJ53baw7IAMpy7lNDus4eoHoEO1juLzdWXplu/Y?=
 =?us-ascii?Q?ANIuJVqzLaUtsoHIL1HR1ZFPeLHQampO8vCoP6+okto8dAtGpsTZGVYrfBVq?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0ed6e5-b830-4c58-9f1c-08dc22ab5809
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 22:24:09.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VnWBVSxijrxty4d453zWbZhO2qgiGHa98XPtrxHaXt6jJEh0T4IXiPQB9Lo3Z11EAH3bP1GFYHPmcjOa/tcZ66Q32hWVmqSQ7XJktkmtu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5666
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add a precursor tidy-up patch to existing Patch 2.
> 
> 
> Alison Schofield (2):
>   cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
>   cxl/region: Allow out of order assembly of autodiscovered regions

These look good to me now. It would be nice to get a Tested-by from
Wonjae to close the loop. I'll give that a day or so to show up.

Thanks, Alison!
