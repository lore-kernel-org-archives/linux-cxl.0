Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A517C991;
	Wed,  4 Sep 2024 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494347; cv=fail; b=tvuajLZ6/DkIouyKRTSJz1b2mn26/NKoWhrCenL1SKgswrsaiM5KR27MQFRp4mwHtsxl7Qvmmp+sHnOyxx+rwndQgltOh5/Zs7qNZkTYI06L6IcB/F3wLmDt4a9tH9NyB0HwRnhnmhJhtzUo2sliVSDdP/ohdPwYlcCtKW+JA8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494347; c=relaxed/simple;
	bh=WzvhJCJPYtVPBxA2Y+ATLrWdxfbUIDOGeOEj1B0wkak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+KCw2O5Vxd8Z2cETaTJrvJHbiZr6tof6YSvArStSKY4JE2UjF6J5QUKkbhtHSmJHWECt16y3Bt7HHVhY+SyL4QZ3NojyLBKpHOB600VRxVa4j/lQUfBo+n1j3SM1EWpifUmcc4coTFZ/uIv2fc8mCEYmlgh2TkqV3S4g8ELcNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1RkIZiB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1RkIZiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725494345; x=1757030345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WzvhJCJPYtVPBxA2Y+ATLrWdxfbUIDOGeOEj1B0wkak=;
  b=I1RkIZiB1bXjEk6ZL2fWgWblsUj0DgfWD9/hRlZqOvRZmIKcxA5j81DW
   nfuk0VaGQmqvUxStMgUeZp6Ko+dxnGvhdVXUaObr+JryecWXkO33ve0Ln
   6OE3wzwGVjph7ukbNpIGtvF1g3ZbNKxvhLkRry69riJY3aZUh7fQ5PeBx
   J8NbAO0X5ZvS8bMl0JDqXv+rB+tl2m37BTIKVQcG0deTLs4r+U43Qz5Gc
   M6e8WEs0pwXdTPowpUQtG+M6KY6I4NN68DixlQLQ/UZ31gcM35eCkU6zE
   RQARLPLfexlx4lDsdDElMtl8pnqvXsFgqlu1OMD1DVhzJhzoMMpMIQAS2
   Q==;
X-CSE-ConnectionGUID: U25oBY62SPO8kNsFQN0q5g==
X-CSE-MsgGUID: YtXdt8NMTmycsIPLd6ePpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35568231"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="35568231"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 16:59:04 -0700
X-CSE-ConnectionGUID: 38T9vrQ9Te2Y2HAVLZRX3g==
X-CSE-MsgGUID: tapZtFQWR52OuY0FaTm6Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="69834203"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 16:59:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 16:59:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 16:59:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 16:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF/YNb7B0i00u9vXHfy4xIjKBlh6d3uplmpeUkRHMaknfq2sfmvH6U3LWu2oXQlIki7Z+8Nah2bMdneMakC0qLr4DKoEQj+UBg5ZcSiOYCSpGvxTNfR2+eFnCQhVM11hTuHzGSyHESQkgO1hdtRdiMBahiit1iubE/vd0V/n4JLP+xO639g5H5Q+kuOL9c713hJC742nT4L9lGUOOKyiPJxXdSZsNh9JmtUQ4vnYpZ9i0NshEtJQLjdaWZfl+QPdRvzp/ZGD2z4fmsRtUWqEVIQAhJ1NvOO1Un/cZFqvj6vitQ306SLwa9nMDRAWO4RaPV2pdLwLNjOKxN+zetgP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuNrYcYUlhYRY8TQIzCCxWz/D1j92XesnHNvD5MIjNs=;
 b=SCXy42MPjXYM1mu6iY8fg3R344vz9IupwjM085K9+D7JBg0XHcErcFhvUHLNTxdu4ljJptxecw4IJSrhJsx2dv7TY+t10QTJbYbfVmkQJ5EFP752mMs8M5bzEjug03X6R5/DDHueruIpCOD0FW/sbcEL0iU1IcAsUmGRW9DV7qQYCfKDpWJCEUewdhgw5umqAt+T1Iuu/dKr2tmxGw/vD37iPovH8dgKkmBVofB4WghcFk3ELGAG6EB2Fiwh2NutDDtF+gjc3TTool5pMzrUzHljcajf87+7bjYRICeTvZ0V05XJ8spkDBroSpt8PN0PaJJAuSZ+9S3ohZ45GG01WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6666.namprd11.prod.outlook.com (2603:10b6:303:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 23:59:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 23:59:00 +0000
Date: Wed, 4 Sep 2024 16:58:57 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Huang Ying <ying.huang@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "David
 Hildenbrand" <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alistair
 Popple <apopple@nvidia.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <66d8f441adaf4_286b29450@dwillia2-xfh.jf.intel.com.notmuch>
References: <66c697cf7b95a_760529414@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240822212932.GA351096@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822212932.GA351096@bhelgaas>
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 168a8971-2506-4c3b-fe89-08dccd3d8bfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mQ1UqfspJC5gZQBvw2TBnyNybKKIncl+rQQtaQFtMriijrBCuEd9+wYxXxhq?=
 =?us-ascii?Q?diMsBgMHMz6jMyOF3GdPWM+Ac0Laz8VhKw5EBOOrgntChLMLx5VuI12NemvC?=
 =?us-ascii?Q?gmf5eiJC+YERTeW3tQI6geI5qx9pE2vPmrc1L2vWv6/Q8QDIz5MDKTrpoQVx?=
 =?us-ascii?Q?4ieYEW8lD4sCKIH/m71XptcCAGH0b1ad8QWmK0I9Jfv1/WMSQ/MUh/BnvT/p?=
 =?us-ascii?Q?G36ITWfcu7FJiITUsOLvQ4GZkCjNFwv0dAWMIWwezi0KYJPfwADsGKvyJja2?=
 =?us-ascii?Q?Y1nsrxCWRJmNhBcmj1mjS7GBo1HggB0rHPsQPy0+bj8YF7O5iMsJm4V7ZVZP?=
 =?us-ascii?Q?sA2TYVlvb5fN+HIhgGL501G0zlfAHNVcHQ2RT1UQQYaFaWDA213TCmbYng1U?=
 =?us-ascii?Q?Ao29r5X3J8X9AtGhXnSrF8WLripqC6LtZlhvvR/OFV4pr1wZYrOoELBwJ7Tg?=
 =?us-ascii?Q?xSAjNhYjhsRHQTZYI5p0xVCKCMGzhMge8qXCqCZ1ItI5m+dHOKsmVb4TKAzk?=
 =?us-ascii?Q?36HBErqdsCfF937l9S5dqDBQzc2jr6V2iku599yB6bZoW0GEhg3A0sipKwan?=
 =?us-ascii?Q?03p/eg59FJW/Q3dnRgKsyoXNgvGvrU2ZTOtCpKFtAnxp/x6LyhEN6WoI5Nqt?=
 =?us-ascii?Q?lnRvdCSESzARtlMn11XGePG8kCdykujOGQO99yX/EHYL2WGIFMInOYx9sJwL?=
 =?us-ascii?Q?NblquZY5EKlGIlL+270XbG0adfpXe0FPcB7l3ARz8fTe/jabN0iFEwPZBWqB?=
 =?us-ascii?Q?gNrUbTYdfSWIK3iNUnsES9vkL3xFbaj/f8S9xBQrEW9kuMiPIE+DhDTLlA6X?=
 =?us-ascii?Q?E0jFwHACORZG+I8xZ818vxf+u20pAk3dgLz26FfRlVAS8suD+n65wYf+qaHr?=
 =?us-ascii?Q?gOKfnDytUjJEEGBH0XTE1+k19HD2rPSD+ybe4M+liyvB7NkGLPOSdfrO79k6?=
 =?us-ascii?Q?iB8L4+Iw3hZCL/M+XYF1OwRG96ydaHMtWZJq+fiFIdAJRsT+koWnn0/SWy/1?=
 =?us-ascii?Q?Phc6F14/Znjrvdl4srBWemioRfq/33aAShTo6wY+lOR/5jJD7SDjbkQaquRp?=
 =?us-ascii?Q?KuSiQkNBdiuh//+bY5g/HhlLAczQ62/EMMJrY7knLybaHYQSD+jMe85sOk3u?=
 =?us-ascii?Q?VeJxmUP3whVb8uRk3O82SX2KDO4OupsGr/WQsX/ok1sdZVAhWlg6rPXeBDq0?=
 =?us-ascii?Q?XfdoeA1q7dqAVWHaBHfXwntVVDO7ZyoOjWYJRUsKOkn4DCWebUF4Carw+cQv?=
 =?us-ascii?Q?2HfLDiWLa46yObgbVoAsm+Wv/nt+XwY0BxCet0hOLAzwuTzp4LUdzHRLJ4oa?=
 =?us-ascii?Q?QM5k+gAkk7vyQ2J8nzx3deau1/qbie/97xVgt1Lqk/MmPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?trP1nZEGMZQQCuWw020dTO1lpEGiD6+WX25w168E7ZsfnmmvJCTEnNezxNDY?=
 =?us-ascii?Q?dnzh+XfB+t78rBfnCc0MBtYigdGoUCzQkJJ5hk00+esWsEi10DxVXlw+bb8f?=
 =?us-ascii?Q?UTZXlf/fm+VHoG4xUP4geqLr4C58cG/JTfgA5mwzfpJWoNdLSlQbpHpw6KoB?=
 =?us-ascii?Q?2cn2FRPpdD7SGGoPdERbA42wZi7XCARKnDPLNzurWO0YzSz4oHPMBBzX9POR?=
 =?us-ascii?Q?SyIbFN1NuXsQapHn+oUo+z7lw5a1CmzysJUogeT9H4AC9y6kYQZ+J/TCmcxU?=
 =?us-ascii?Q?3PhhooshLFw/TuvoeUSOlhHho76oJlpXe0we8rdQWHHU5qjFh+XPo/KNCzmK?=
 =?us-ascii?Q?JAFjuB4gEB6b2b8Zhd/AH80Ekq2BOYhTJDC4M9UDjP9CYM0AkePPCmENMduI?=
 =?us-ascii?Q?f1UAaMVeyIZEj97wXS29mNTOFJ5fuhEIjygYyOj+ecay8l2BL7GFx/L533JR?=
 =?us-ascii?Q?OY24FEtG59KqJMtuzVQRlGLwCRY63H1h2pA1Q+wu+vCk5EIi4J/aM1DD5stL?=
 =?us-ascii?Q?U4lKfB3sBHkhxUnCW0oBXxkPP0mWf12wBDwVRZLyTOHS3oiuLzBe3j10Ng7P?=
 =?us-ascii?Q?+6YUCnGJl72diNkdgn55EY5of26DUl/8wwTkM1WHoVbK6BQTdX72yGOe/vVk?=
 =?us-ascii?Q?q7aKX8vIBe0GaSfuMeA4t+lvja+2Qiexv4tSapmycpfrxBpD+ps2S0mzPw9q?=
 =?us-ascii?Q?wdB6Ychd5V0bfy+VjBc2f92lxvbO3IsjnaQYuu9mPqkKkjU04+mubxm6gvDR?=
 =?us-ascii?Q?S2tbELhsNaZz2rirPDShkC9bLmkjKBZF94OUAzj7xNSLqW6Un/hRTga1m7kk?=
 =?us-ascii?Q?t7aR39QZ72L82P1iUyKAZJXtBWW93kFjB7BkkaOpItccj1roHxO4ww2tLPPW?=
 =?us-ascii?Q?lYv8VKhQeGetbdhZwgnl7/ZnZbwwNiPSO4oAdYOp4AaLzyUjUQNSUOlaXHrq?=
 =?us-ascii?Q?S8Up87zQ5X65AGQ421LlfKDjqB/MD6b9ncadQIGIVrqlYur+h2Ln7Eix8VpK?=
 =?us-ascii?Q?0ZaEgoVnOdDmgz6JhxY+fX7sYaHHXdg3BlB3CGy2mZxXcV/FRAKElgGAMzrL?=
 =?us-ascii?Q?diriixNGTz856tK0T4mH3kyUjB73QNQtcRXz1knG6zZsj2iORMElSJBkE3eW?=
 =?us-ascii?Q?BKVxU29Xj1RJjkJ4mUUnPfRKXwDIxiojH5ho70/UgiY9EBszuoR4mOyNL31K?=
 =?us-ascii?Q?6tHKxESQBHSHs53m7x2rRGf6KwfYtweRN/hqIXdz5oBkcLzLrBbO9DZs2i1W?=
 =?us-ascii?Q?0pJ0oI5bY+1kt2HAYf8PVikWavqHuXwv9iw7/kddz4bBYHkotLrpIpGpmjuN?=
 =?us-ascii?Q?qBz/nES9RitZ3t07FZsYGkVF1G2Ed1ib1sVj6wuRs48zip/KD6PintJeVWuZ?=
 =?us-ascii?Q?nRqjBDz6IRj5wAXZdGf3IAYvVOi+ULugLzEz7s8JouS3S5gXwEDSndiwR9yW?=
 =?us-ascii?Q?GHDcWJaZBmXuYMZ0qNZHoCStilaSxE3PQd/vIhCt6pgfcViEdUvaxZPan7e6?=
 =?us-ascii?Q?OyY/FQemMqKlli+3vyZ3pE/SXeZcbwwqH3O2WN5+DiDx0SfH7vSvIxuRLZH+?=
 =?us-ascii?Q?W+lbiiIdmO/dtGbwMs/bsj32x5d2Eb7K2xi3xS3is8xdk8dkIRxIlvNFXp0p?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 168a8971-2506-4c3b-fe89-08dccd3d8bfb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 23:59:00.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6H5GxY5+XOf9LUXFBx6UXT5QQFyLWMtuGawD4W/jWHGciZO7xSIed0GqiBAcLqKXVPPSNgr3AhMP2tCWp2+UcmPQAuSzCp+8QBO34JoTQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6666
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Wed, Aug 21, 2024 at 06:43:43PM -0700, Dan Williams wrote:
> > Hi Bjorn,
> > 
> > Ying is out for the next week or so, so I will address your comments and
> > resubmit as I think this is a potentially urgent fix.
> 
> Sounds good, thanks.

Ying is back now and will handle the next revision.
