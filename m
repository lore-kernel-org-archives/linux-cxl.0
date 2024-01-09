Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556AC17C7
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUBI0hrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704763061; x=1736299061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Oa8s5kaVXQuleyM+lvLRuK774aYQ92se3q+wH/icui8=;
  b=hUBI0hrSnPxp/7YbQ4WUZELbnjUi2/cQPWMtQO/TQmwO0Y1uq9LJRJRE
   1j+psTLfvtugXn3M3bfHqtFsVOXX01tsUOBueIAog67ootGYl2L/rSyN3
   8Rl5F83fYpIqitS9CTxrMje5/sxMvbGKNCpKh5AMg/JDRBvCpbpB3FS44
   e9+TKx2STThl2XvO8qucdK2AehPa/SKy4d8z4x78bQFbejbEvx4xvMoVf
   +Tn1YySg4dWVyuSWUgBh16+hjCeT12NPQjUPAZeduwXFoERvAP1KJkEJN
   0OPgRQHcUH6eBvM+zBLb9a9Ysq0mzv7H3lIENL7e9T0eubo27O3RjiIEY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4809439"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4809439"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 17:17:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="774674865"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="774674865"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 17:17:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 17:17:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 17:17:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 17:17:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 17:17:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwPMTYis940baQmeNCv/p1Nw0GS36KRDUzjpoihzVEhAZxZ8mOr+JPrqubyW5eUe/gYUpD+O487DUeDAHySBaWltjWAGjS5G+bnL+wa2NETORiM1gJsZ9KmrrO4kOQP6OHR9eWD+/l39ex3QaHhYuevv7sMM5RViEscEtc7HwYXEmMgvDKcm0KTalARcY5xexyBvj3Io5PpDtWKyfzUPfccsViDZZZb2zfTT95csX7B+VL1LI08bkkn1HiEhbXhod0fz1oWhJuEf0Pl+MLdzFBKJJTTz66yQs04sjEXWelxPCaaMrHrTdhhsHLBXhhNb7SOcyCbcpvX88iLfs9p97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoXLj1+uQ8FTLMmS6DJ+21hZ36yBEp+x5z2Fhh7dOxg=;
 b=hWLpocgOgA/DKgfGI2fs6o0jCPcDQCsHCcV3xfuLy5ar8TKdJv1gMeTAFX9NAKDq4kMZduC64I8fenEZeqGAZ8l3sMf1afeKnwh4GQHDB+1BeP3gScBLr/br4WhDS7PfJPsE/kWyMOKinAZUfktCl2g/r+29vCC41GWuw7kq/m2PYt+FNYtYs/uGcVMtov1j6bvWsFl9vzc5DiW2XSlrz0BU0Y5E0NXpqFK2QqBYkxaWCsBPplf2HUhwXJKTOEZtuQgACEiqoJ2wDWTZE7VwfR/LKrmIPDSzog7GoV+Aua3ATddnMGVPAevRHcU+bHJyfTpu9cgJYBGQqisYU8DEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 9 Jan
 2024 01:17:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 01:17:37 +0000
Date: Mon, 8 Jan 2024 17:17:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Robert Richter <rrichter@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>
Subject: RE: [PATCH 2/3] cxl: Cleanup unnecessary uages of cxl_port local
 vars from cxl_root
Message-ID: <659c9eaed50a7_127da22949b@dwillia2-xfh.jf.intel.com.notmuch>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170476243490.115624.648453218819673314.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170476243490.115624.648453218819673314.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW2PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:302:1::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: a89b12d8-bc7a-4e91-3758-08dc10b0c448
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6D1e5nMsMqoXXKWimIERwu+VUaoWtlpTr2iBs5N9m+yjpUOE6KVYs2HYZisBjT5XXWTOT6RQpzuc415LVM730aGPJGSn/7xb954rSRDjPXclIenxZy7/lWRqa3oGMB3Polf2MdhW14zx5hXGCSATGd4Ovr79y5xW2sNboUE3kULOiibuWA0WEBanG2ebQXVwQG9Spp1uivsyaDC4fOpI/810tdk3BgRmgScj/jZv6YvKeUDSnIzfKwHzbPxKH/DLFo7wFn62pelPDngCeZlfWnjk3Hv9xjTd5/4Y8sw+LYdLHtocPPcORAUIs7ISkf05ImBmtxjbdDIZwUGk2muccWPiGLrYAxG6ZzVQrqVa3HnFk/DcNZbKgwMQSRjnkgy4L0DuO/vpX0gswKvE2//kpa9rMqeEo1owxkwfPXLTtZevtVXHRnqtA0Dn1/+Jma2A4zeXiWm4CX/UnUw4yL2Z3BRXTSR1BYItnrDv8df6gGLDMLx385lOeqYMyJ/BZcGTX90z5hJbkP+/hOJQhRaSbYYupJkyPebho6UD7J1sPEpQ7IRzL0bwm1QXGOOL5QA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(66556008)(41300700001)(66476007)(2906002)(4744005)(6512007)(4326008)(316002)(5660300002)(8936002)(6486002)(86362001)(8676002)(478600001)(82960400001)(66946007)(9686003)(6666004)(6506007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WzWDM08uAx1qGJJO1uINcv3J65VhuJHIMPpT2ZQo3p6UAXkPtyOfQbKv8hT5?=
 =?us-ascii?Q?uNrzCpmE5yyEjLswxJas4m4JOEN50G+yKhK+OLvkUzL5G5/sScdwHhJTIs33?=
 =?us-ascii?Q?H7KlNt4R8NhVfacvXIuLLytQtBb2xDOImAPuuu+bxXk3Ys7OIVsCV4n5MDGb?=
 =?us-ascii?Q?aMGlp/I9E3SePqSaJnkMGFdneCFep0mBoGU48PcCc7EbETnPk25GtPIvPptb?=
 =?us-ascii?Q?v2+CnMpFZD2HGUOmvzpYjc3vdU1Ozte7lpQNQCrysqjTCg3xfo0pBLgZYsvR?=
 =?us-ascii?Q?xo2Y9ZYiL5OSqKgeyqpbkY76ZtECI/91A06UNUh+zB9DNqqaSy1ta8WlRt1H?=
 =?us-ascii?Q?s7iHnTFsylt3uZuCvypd+Eys8vnBrDMC24BuAozlHJiqceCKFTT7b22P4p8t?=
 =?us-ascii?Q?sQiEPC4iKmDBZy/aqcjDNLNn/7UUHRugrM0DDRwplR9cdt8pe5E3d+fl6lHj?=
 =?us-ascii?Q?ITylXLVW2E1N4BtrVcQf7HPO+1nOGoNXZVw3BeEWQb0qZEZmB3dLI+ud2gXH?=
 =?us-ascii?Q?Kh3hz8j6tcDuTmsY7zSdvhDcUn6ZUk95I2P3YI2U9YS2izlvsoM2BQxzBu5H?=
 =?us-ascii?Q?rUt3xhKprKIGFoeJMsUC4EmwyVLvwSBfe35q7QnRPzEK5vUtRGYcHTIoqXyy?=
 =?us-ascii?Q?8OqQMTT5OOdj/uq69fBxmcV8ax0pYXoOvFjLba13sGRn70tfVN/qeH/Nx0ZV?=
 =?us-ascii?Q?0q7tzcDEeHsmLx3u7FbBejyl/1pYmcEcsOun7weMybfwdRMTgXwJFng4m9v0?=
 =?us-ascii?Q?1QehjNbppK3Is6L/C9U+xBMG6HlCNYr0H085zI0AXEoVYm6foKAf3ewdwEbC?=
 =?us-ascii?Q?qtCtmlQEuFPOj55/8C1st3r1tkmYVS8JcIJflezP0q5D91pQikHt4YYCukjE?=
 =?us-ascii?Q?PQKmMISnIsrZ755KFjz4SDwamj3w25bQnL/bVAG/Q1PJkvVqruwOdaU1EZgV?=
 =?us-ascii?Q?EItI6sdNGxZx5th+0gApF6Y3bS76j26do8/QPpixhBo+THnoymW5kPRRnzSL?=
 =?us-ascii?Q?LwU93/izppg/XktgwxaZLuE74vSDDmTLY5Rw5C5j14rbCPx40X8vipIdIGgX?=
 =?us-ascii?Q?Kk2Q2i42mF5I+b+P0pkNT1Rb4W31gS26DpXZ+OQvJ9mGPpWjnO0ZoSmPDXtu?=
 =?us-ascii?Q?T+Zrv6yOxzOUU5SpaBuzOgyOGRCS8B3mzVI5uATat6k4gHPCU5dcL28Cxazc?=
 =?us-ascii?Q?YssBHHM6gZbCNZHXMx9RU5qu4aeG+KYorc9hSChYbytkxRN3CWbmZ9dH9My7?=
 =?us-ascii?Q?MGtcIFOigtjMBhMBNg3R5m/o2MzX2ERDrV9k+l1/4yfj8hrc66/OoAcOx70n?=
 =?us-ascii?Q?BKb0MPW3zjdXeWuAEAV+A77t0lyhmW55d2MCc5WZ9vHOuGVdAyEsu5N+KqLA?=
 =?us-ascii?Q?rVGBhfFseyYRacm3TDcgD8g8vImBCMkfBtUOKENAcmiOo+vIWYpXpTFu7o4r?=
 =?us-ascii?Q?l2Ih3P6emcqhVV3OH0GD51Q3dFdfl1ZIAhM2j/w1AxJjknhCHHW17PMpudWR?=
 =?us-ascii?Q?ZM/vRmp7Hc4EffhUAQcLvVacunYPXvWQnOVD+E5lfBcqTu1VDvvv872sGev5?=
 =?us-ascii?Q?3Tze7L2VwaJwLE9UP44R3wlHT5QAesWHPrmQj4qLe7ywgEh+hL4E4mH6y7r4?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a89b12d8-bc7a-4e91-3758-08dc10b0c448
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 01:17:37.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCS+2rOwK7nn3bMOsc33A0+no0tHzMCWnA5QVAYvyhxNw/raCeYGCfUsFlpxPy78sLRnz9fHH7khu4TfEY3R2WeBlojTpIZvLhuSbJQXArU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Remove the local vars that points to the 'struct cxl_port' withint 'struct

s/withint/within/

> cxl_root' and refer to the port directly.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c |   13 +++++--------
>  drivers/cxl/port.c      |    5 +----
>  2 files changed, 6 insertions(+), 12 deletions(-)

This one looks ok.
