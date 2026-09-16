Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162E22425B;
	Wed, 16 Sep 2026 00:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518535; cv=fail; b=OoEdob+oF79srbOAhYoZkkCzC9FN8fXLgW/q1i3Uwl5e1oAHdO5tvpsQ2zbJoRlisCqUh2M9XaB2RU4AnMtpB4djN3bxV9DqFEsJocV6RXVBWZMCLUvFpfFQ0aC44fg15N2pDL+6Q/t4O2FTPV7eMS5cXbLhZyMSq6PhdCDwe2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518535; c=relaxed/simple;
	bh=oru5w6axS18zqvefAx8CIF/8ELT+3zvLvFJtW1r1HQs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mb47rfdvkhjySNGnKSYlgKdHqx4+wih7VRtaW+h+mga6iubM3G1d8dfMXRPv886h82ESZ84X91q9HPkXHtv5pCN9CQeAxSS72TZK19Lf1nuLWlv/8uG3SrLbqEcjOj+4s/nz5iXU/D7aDbCgGjNKEyFpKCCTFxr2CchNDB+yBPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYz04+ZC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYz04+ZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789518533; x=1821054533;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oru5w6axS18zqvefAx8CIF/8ELT+3zvLvFJtW1r1HQs=;
  b=NYz04+ZCjklHlLUrw+mgyZwb8BRHsna+eP/YWxGqj2VgIzbn2UcDaQ4e
   9FMQ95b+qBS/mNCb0+BvpFuHiJZym2a9THeB5VTLKlhDwMYD70BTgShuj
   LboxtK1A/DoG5DQ76tMXyxBn8UepHRYhUSWNjTtfOuEUleCo8JgeXKnah
   171XEAcTgsCFxpE9wFGcZ1om9Nsu8ubS2zCXcaMCSCRGsuMRM5l68+Efc
   fZ3WYGlmWRXgvFoXsjKHU6VTuPIImoQNPT2iPIFoms3mTew2BExIxe/t7
   iE5dKRulRl3z/VvXFVkejXYFbfX0jixDjE3+WCCSFetUjiJloVj5tpMYk
   g==;
X-CSE-ConnectionGUID: UIhEDnKfQKquest5o6nFiQ==
X-CSE-MsgGUID: Iq+FvCA+QxO8niq+/4Ha3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101239139"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101239139"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:28:52 -0700
X-CSE-ConnectionGUID: OwXZTVlDRFGaNFYGXQ0N2Q==
X-CSE-MsgGUID: soPIR3mCQEa52kjDS8Y4FA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:28:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:28:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 17:28:51 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 17:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1sicojMq0DYuMDPODe+guIiYJW/u/SLmq/0UIAza0V9zzmL542Pw/f0xnypjZSugSNamWpW3b3QiwSSCcQBXNKwxBO1/ix7ZJxr+sz5muDH512gRB5jGqqr6eyV1f7+FGLvovL2YmSk/UhtninpMDRdyDs/qzgqmqNpqpFHn4PKtwRmi6sJ+AKGjgBk8bzisE8cgze+mRudquW0uSx6ai5JYRzvkBTdKP0B5W/p9Ln6uH9kmsDke3p6yDTFAMKPEuoeWavMMwLlO14EbD+Ln91L3N4BAELpEbvadYXzjzSpRoeaPKgK6kkoW90ZurvGLx1hfaW8JJIHncaI6oQ7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAQNUwH0GB8Gun3OT4FnbK25kzyU0kUM17oMrWTy4EI=;
 b=es3P+t8nB+Cwbp5dRLWEsD6aNTXAXL006X04/o1G6ZFy+Iwn897OVndZ3T79sV4j9RSWUXNoTAV3m8HgdugDN74jvcr4vPzzJFUo2MzxqPq8Mdg6c5JKQOEhK06dKcOIm2Xm8l6eGXVctN0lAU4iMrAbVOgasd0llAnxBuYM1kuhs8pxY9JjyBIZumPYrmLDlWacnIPGjpi+/CHNZ0Tvm0XdxKnmbhKqAFueDTiu7USe8n4VbQiuNiOUNXdTT2jZOFMm99GG7VH0xEX2aoSP2Z0A/qA1w1G4l0Stf9bxAyE0kcv1rXBPMh12CwJatU7rj7dk/NhOIWe4BFozWdP2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA4PR11MB9420.namprd11.prod.outlook.com (2603:10b6:208:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 00:28:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 00:28:47 +0000
Date: Tue, 15 Sep 2026 17:28:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 5/7] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Message-ID: <aqniugvoJ6POAnxj@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <20260902053839.25595-6-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053839.25595-6-icheng@nvidia.com>
X-ClientProxiedBy: SJ2P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA4PR11MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: d406607d-ba0f-4ce7-496c-08df1389790c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pJEZIt19kA/guL+DHbk2dq/e/tUMXF/zwY1B5EgOYpPLsl2PBkm4A54V2V4bqslYWhr7TBqyXdLkUb5TPfmAmH1HtkjhLpZ/TMiaSBELA/TbS5E1/Zz9YT15Z7UQf40ik8/fm0/tjpITV4Nf5qAx64Iy8wddtr26HJh1aUZA/AaVH60u3LTm8fxpsw6EXxccphJJiQsO+DkBAGx2Wc1/ShrR/OUu7pARAhKqulXt2iq18+6wWcntx+Lp0ox98rUrxn1cgBWZShVNWK2mwB6qRdP9+eY48iaC48F7KicbAJUBvZ3muAhrOuulLo3j39/DU6cDhCnQcVR0ZdAEMqGYBjPDy7YW4+fPxGZ29Tv49pRs+cucIhIoFJqsx2fIdVmOlOG0ijJo16RW84n8jiISz6TQDy4depAJ6tAuWyE/u/4iM6mlU9877VxcdLQkf4ZZVF27iiWbpv+oJQUqToE507/Yfk067BDoLEuprnMlop5UYrCHkbhbYDCxoCGRJEdmhdJDAzVeyZgA17emf15K6kvlMPNDD1g77W89W7EZtNfxVyD/jkbeChU+XDVFChAsgJAR7X/3IxVzY0GxJuX75l/WuU7++g4fPvc0Gdt0slc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4l7LAqk61CKpcVRnt5yOj1YSMwDe0tWe5j9qHDDqfIWg6+7sK5U3xECCK5K?=
 =?us-ascii?Q?IbDqt/895atpHpmGavTx9COOSDPGi5bBP6oGp/nDpLop72B4sxCjEd9qAvTG?=
 =?us-ascii?Q?s9PMOfIE6OtStrK22udC0aZhbYOrX1xB6bRyxKZPFArXZg3Ip0xKyVUO2cek?=
 =?us-ascii?Q?HwABjgtG4I9tLqina2y7Y0Rfk3bGDW4B4iRd4A87Hcgzsve4D9SWAJi2jGpI?=
 =?us-ascii?Q?BIOpvJWL5DYZ7PYs/gyIKksxXC4O5BBgDiI//WbkCktZrCGxGM5TEdXLcBSA?=
 =?us-ascii?Q?vSZj87HhITGb2qhg8vptqQHrQO68mIZ3HFGbfOT04ajgJUwJKhueDyZGcCdf?=
 =?us-ascii?Q?P1gZbmyNJOcH65KqUah5O3iGaMkuN6vMMEqjAQDy7QZ24Rpra0u64rTpE6NC?=
 =?us-ascii?Q?0vtz16X2kUNFz+X45h4dKLJ8JUq+MWCfCegbP64g+ugkNaQXuXQJ4kYSqpb/?=
 =?us-ascii?Q?IOk95EujC584zvZ+CpeSbRymi39K1e7MsD3Wtym5lEHx01/KtoJEcDC8i1nZ?=
 =?us-ascii?Q?+t+Al3DoVFX9GMTHZmaNbyfiJbn++znZI1HnBSsMpmLlFvqMu8GdeFzPGSvL?=
 =?us-ascii?Q?UqusdDvqtkwdCHD2TdosWcbUZIT7QnnLoMbzkKIzbTmNDGm8sh8K+R5/iKB+?=
 =?us-ascii?Q?c+/j/KT5seLKsHoQQsUzfGwuZjNVFrVaDgMWjBsk75i127zM9NPXhp1OXR+P?=
 =?us-ascii?Q?AQddriu21i/BDhx6vzKVIV11nudsICAS0SC8Z5WoGum71Drx6qJH3eBDlnCu?=
 =?us-ascii?Q?78Sm42oAOvmNUN5hUqM/TE02XXr9VY1+nmXduXHemsIortTtH9d1zqIal3ZN?=
 =?us-ascii?Q?Dc9XDvNbhXFwQdOfwxnUI8qoafKJHJgFlemCQgas8XEQAH7YJ0KvTYF9tOdP?=
 =?us-ascii?Q?z1FN8/zNyzX7dKiqcA6eHnRju0+9rUJrqi/36R8jMa8ZaTVWeym1c61NbGhy?=
 =?us-ascii?Q?Gs0PwskyGSrSDDT2gMFeYnVrtbmJZtJ5h17sb+UcGT2eZGLSIfSp4wU8Rke9?=
 =?us-ascii?Q?u3mUvLuxWooRhJh9jvWFupRlpakAo/Vd+cYWZ4Kd99XYtSj6hCYUvAvqt8ak?=
 =?us-ascii?Q?DVRw0szAoPHd8Rqb2atirsP++/zhlsH58ZluTJHAHld01/Ko4Y9dEXacESz4?=
 =?us-ascii?Q?4VaVGIx6Q6GyFBTEdi8hRRnkI7ZQ+OIk+OWaXOmAJnbTVD4WR1MA+Hk4VUgF?=
 =?us-ascii?Q?MJe4lINqBdFIRLZwSHe+k7HGjXYaknpKGRhrrhWqaWn01pA7TWAxIuuDMiJ4?=
 =?us-ascii?Q?uM5fDrcp015oqovI2G4VaujqIJj0PXRhPXki5InKebGWpFBvsNDqybp2wFeF?=
 =?us-ascii?Q?kE/0PVe978A+N0I3RMr7nZEnamKpwQGFaOn/oDk05h1tS6Ct0YJRBH5VzvFC?=
 =?us-ascii?Q?ZyApsvRas6gXjTqEtN5YIqICvkCvwJXT4JAcWM3vDSYfjCeexrhxC8hPKkh5?=
 =?us-ascii?Q?Sg3+UDazlTj8V7zLXLIERT0KotATCnCc8q+PPlr3lzhUy+azjdgMgzlJIeY+?=
 =?us-ascii?Q?pr1Ib/cUMiyRUPNJBcwpkTvY1rNOTnlnXDrq+KbUQT1DWeAVq/Q3O7mMgz9L?=
 =?us-ascii?Q?Xxm9st99YYB1coFtDw4IcR1kV1mdyIcHWsTHOVeakx4efoduWXR+x9z3HejU?=
 =?us-ascii?Q?PRSGPgv5mefCL1bp9V5vLc74/C4EVH+DIPNo7O3/sE/0I8ja82+vXhq5pR59?=
 =?us-ascii?Q?bxAbx8Sv8BxL2qgm4TXIqWA4bVIR7hh1vUrfRPqFV+YX18H/PpWQddB846FH?=
 =?us-ascii?Q?ot9wfbo0FrMLUXXG2K1DDvtB7bAX9Ws=3D?=
X-Exchange-RoutingPolicyChecked: dTbUVvtvbjyIch86CrEbwChxIZc8wZB9Q218mWCVPO+XCjFoKb8AW4ve/h+9Y8jS2BvjO29qmyh76bT9H+0c8O0hESQSzQ3mNdZsE/2kDeyfnyPlKR0DNhCz+XzmVqVkI2v4Jkr1XUzxwKyoKf0YvMeDXYgJI+yoTprLO6/baofjEjmqupTYo1O33qfBXDC+Bs/w7mMh6FhfSpp3A4Ous4wnNZa7APIOKaVUdYOuPTWmIYl5IyH43nngFFmWrBusWyeTfvuXco/YIZl6fnbV+7g+PMIXMMhLhIDbXimDoft5DRu2/yeAn/3Olq0t/hqZKEXFTMUruNZxNPEbmA6+Vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d406607d-ba0f-4ce7-496c-08df1389790c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 00:28:47.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXavu5rS6NyHLwRvIZHDejenwKpOMt+mt3p3uJjN4LlGl2FKrm6mxC/Vu1hrworFET+OXxwDaXmUEgpYZTPSDmcOXQBFq+tkwddqy/GZW4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9420
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 01:38:37PM +0800, Richard Cheng wrote:
> cxl_get_poison_by_memdev() queries Get Poison List per partition but
> never checks the result inside the loop, so a later partition's success
> overwrites an earlier partition's failure and the whole scan reports
> success while that partition's poison went unlisted. Before the loop
> conversion the PMEM query returned early on error. Stop the loop on any
> error not already tolerated as a RAM -EFAULT.

Ignore my previous comment. This is stopping on first failure as all
similar queries do. 

LGTM

Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> 
> Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/memdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..e39b3d13fd56 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  		 */
>  		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
>  			rc = 0;
> +		if (rc)
> +			break;
>  	}
>  	return rc;
>  }
> -- 
> 2.53.0
> 
