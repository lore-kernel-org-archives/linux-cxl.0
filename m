Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFE1D61B5
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972628; cv=fail; b=W1jID22Ak1QceUeSEMenURGfpojZhWNHlQpK2AqEnbJW8qJXcTgtG5DnZfHLtkUHuBI6zcryAXgCGR7zMuLLGoTH6d3F349YEJXGSWFSzFl5X3yFtFEs9/j+UPqbOFteRgvtkoNM66terhHfvF2aS+4ZKzMDQYz+1uYg2osE/Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972628; c=relaxed/simple;
	bh=ux6XREwB2B6ntg8KVDZKEoPfJM921pzE/MXptkSyn/o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cp2TxeY1dOC2vP8dx+8vmdSdyf1BcwkDjH854xCgb6iaporeqmKToNjw/a0GlDedzx+Z3uGQ+3rMCxLLbD2NMIbqv1eUyeCyEaXonOmlMH0OjKYua8xotk+sJsjXpiTVn29AJGEjc+IUzzsErFSB94kO4tZK85YTosDugLz6oks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLqwhiZc; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLqwhiZc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738972627; x=1770508627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ux6XREwB2B6ntg8KVDZKEoPfJM921pzE/MXptkSyn/o=;
  b=OLqwhiZczuUH+o9ofGCSw5VLKmGIG7UdAzeVigYZRa+8Mbyo2EsOC7Pj
   B7tEGVQY+Z09NGz23kzDeo5sOseRdNM/Fyyfiyx5Ey+qll18iSWmLuoHI
   +W6wbQSnFCZiUQc+Gew3Z8epXfBQkPZfFCTcQ6xwqDGaBONHaTK5/rtku
   1GDwnUaXuwNzkc3kil8VDByUC+yGaCyTvail1Bx2c/F6GJvF8FU3YHEHc
   hMIuyDKKeGMccCF9LezfQVgPgg56r1rVDkZDBklIeWXoTAHwAFCjUIOUF
   Qkf8lbBr8KQrQtg1iRiNbfZn/MnFbXiZEeceJfQi1Ya/CIC5/N0f16jQR
   g==;
X-CSE-ConnectionGUID: OBl5h2VcS8Whc5VAbrXfZw==
X-CSE-MsgGUID: vM1Jf8P+QAeYp8nbMDV2rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39649942"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="39649942"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 15:57:01 -0800
X-CSE-ConnectionGUID: OKiD0tGPQKuvZLLHh33ZnQ==
X-CSE-MsgGUID: 6udC/XEDQR+j/43jna5dyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116872280"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 15:57:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 15:56:59 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 15:56:59 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 15:56:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQlvHkTOvAMuXUeZfzpdxd+eUeWk0W0lXR5IxL7OsmAI9ILxRnop2gU3ner2lc4fkOYHZvcsjlCN8mEMAk20Y5OvO7i4pfCy9QGfCHRN16LAx9le1gjY1idTfcCECsXWqboKgCgKNRkN1C/uMATuJRlZhFT5U8ONflYIHd8AmObUGcBKMz5Ph58f1/ZxMHUBiCsNSXNryW8m150JTJujzrorOhUAAxPEeYkttKFhQEcttoNEW0mohFDcOeFDB9llUDDCK2UWA8jKMZ4aFb8986GvPzFLJOA0rwo6rwDXmBf7p7idt59jqgahG2C9C33IAg+scMAHWCK/fUU4owkQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFo/zD3zlIfuaVWJiUatxfcwujpAmRZLKUb5WsBGVZg=;
 b=NyYnq/KKAXNOtWVGXjUP53uL8gTOjb5yToBL5/1VLvCFjAVH1jxb/vAJFLCXMmn5pVZhL5KtiWFWFe56a90d+0JawbuJlyHvHxOcEvbhKWaGlBPUNLziUPGpKTPGri6XwauU2jG129Pg+YdN06S7EhSN620YxAJDO8tMaumYb/DCcub4BTkIFFB9m+sb0abH9qDxSTnPbJghwTohOZUfvCdVfAC5ak1/YwfpWYDrgI5AAOqT3ig8iXxeu9VWkuxm69vRsqt+EE9SdTHFP7vIvc75tgXqdI59zefwFNdMAuW5sMTsxZKVCzUvd0lAAFh1HzImn0HqzWa/MGSKuls0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 23:56:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 23:56:56 +0000
Date: Fri, 7 Feb 2025 15:56:53 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 02/15] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <67a69dc5c3cd5_2d1e294fc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: a82bc8d8-ed3b-43d9-b717-08dd47d31a57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C16GLt+QZih146mdbIWtpvdyS2bovCuJbZ2+TkY318yGyebkr6KAIOE18EoC?=
 =?us-ascii?Q?9Kq66qleo/SbE2fybMB2yXWEzORiQ1pG+j98Db2Bf0sR0QRrPoAH3fTzTI0J?=
 =?us-ascii?Q?AuN1NgAHLQbV6L5CEBn3BwF4TlwbdSF9yKisl1VgO/e3YwY8mviMndF/ed52?=
 =?us-ascii?Q?Wag5M7OiGXWz5YJCb8nwXEoN5TpEO4Eyh1hTn/Hfqg/Z9CRMzkXD0wT7wMRi?=
 =?us-ascii?Q?+ctafF+yrVeGkKs9VttIw9Ta3r2emCyfElsytgpVfE9RUmZhRJEJEzQqXkV7?=
 =?us-ascii?Q?wqAdbI0zrjHuJZlw2gSP9K8kQEhV9idrh0347tipSyumLqNK4bBXMV2BXteq?=
 =?us-ascii?Q?3Wkn11PXHzJIxhw+LLOVCuzLNn+CfDF7X3ZwMG43gto6cvnHMzUycG2QeYEG?=
 =?us-ascii?Q?TQaassODdEY2oS14sIr+QGzo/g6Tl++U7KsZuLDXsPdJX3hYXHY5RMs6BfkP?=
 =?us-ascii?Q?yFJ6cCcRGayzaaOTmsCIA9Q2Q3+5IvjfIYijZM38Oa/pP/oCWkJA1D+XELhn?=
 =?us-ascii?Q?maKj9LnPqkuat9CMDEocqGNCLehjkDxVjCKm3gaXi0cmg9uZN8RHBDgisOVm?=
 =?us-ascii?Q?FGvr6d/6TUfm6UPO1BgKmMIzJVW2220RCBHkW2Gxt5+8kiX9Ip5NJKbY2fFi?=
 =?us-ascii?Q?Nblz/2aWGhqtDyHuJBujdsqEYI1KKLgTmJ01f+tvqlfuVIX4+Iewc7LisP5l?=
 =?us-ascii?Q?HaiNKdIwJbvYDceRDkkHPfoOm4svLjR8G6BUjFgXCXw+fv37ROdAnLdfNgfR?=
 =?us-ascii?Q?sfAP+hfsgl3JC2LTOFzScP875Urhw1ZiPX/X5smNOrUVxD3FeLQ1dTZjTyEh?=
 =?us-ascii?Q?gEwNrj+bDHrNlfiGwv/jwugp6i3U6PaCwzjPsEUmGphPRGLNBtNs/X6SPrJS?=
 =?us-ascii?Q?ZwRIoCTJXL/2wSJ5kymumjlWv8723dj5v8fYll+aZrapxM8AvZJT47oSv++a?=
 =?us-ascii?Q?wm76UjrhjCe0A1QEdlE5ghYVI/EPMIP1BniTXgjo8w34gXmK6KiTvOZJ1O6f?=
 =?us-ascii?Q?+2K8v8zuz1OKIZFbMfL6ssKeVfxuhOuddEmiApEC30o/dYSSTBTSv2MWwKFw?=
 =?us-ascii?Q?ClPKdlqbn2pWwCwdwJfp8mJ2rgLQYuGvdvxhHctZ3UW3YE7UkNjVqjAfxC01?=
 =?us-ascii?Q?hLG8z5zXOyIAwenuM5nPry6tJSU0lrjgzs57byhVKA/JTJjM5ZlQkMfeRJlH?=
 =?us-ascii?Q?KndmE4ulfl9b8ts4bh9Q+bKlSGLdmhruZJZZDqQ0ThkEHZZikgYD/w8QZIKF?=
 =?us-ascii?Q?mYSpkqNfIq1eLX6M4fOmjEa0gB8vJNrW4DPAZDr05ymzsof/koSvuegUh9WY?=
 =?us-ascii?Q?ehO8s8XXtzo3fe+34VohO0XACpvtkW37SAxOmhnzNaVXBdpWamSrEheO627r?=
 =?us-ascii?Q?eW6bvfZyIiy8JhJdXe1KhC4AdS2L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YsoGqQw4VUXB7bgQxXVIQUO8zROP4b4XAnHfnTRzHTYIlr0HAnQvZ4mzwBo9?=
 =?us-ascii?Q?Lv5ewawKu6h/OZR/hesnsvkeQlfzXrSsnO92NQb2mmST9zLAwwcz533MLfb1?=
 =?us-ascii?Q?poUNr7HM0prg43ORi5/Mc8+RzcCor7cdQMyg7P0VevRnmBxwMHUdpeH0Ku2V?=
 =?us-ascii?Q?2TxVcKVMS4R/fSdyvxVa2Mhh/z4+eNLuFfPbS40vmgFT2FF07k1vfDRvviXP?=
 =?us-ascii?Q?Y6IGDauwGY+dc+WLteVcnQjWX/ZDEfqySti97ryA0fHK8UOuDXgFxvn0t4In?=
 =?us-ascii?Q?qaEXYjzgpcyoqlyQuZshUeCX8HKMUkwr8yCMluYdXA/YZS3SSzNpB6Sq+ZrD?=
 =?us-ascii?Q?P1q0y6VYLO7B2Pn9iXoS7rufNpr3xp/A9/z72FtL0VkngcgcF1MjNfIfh4YN?=
 =?us-ascii?Q?PH5Hw1R/frWqZLiLEF7+0I33j0Ezke1sL9A7aim3aF94+eBEUOOF9wSyVuvl?=
 =?us-ascii?Q?jmIjkSLiqyHa1EDQiapOpGryOzpMcb2hyqkfT90D9gVjN4jkklJ5ixRl0E+d?=
 =?us-ascii?Q?zJnCYYnVCYfckN14ab5a4VW8CCnK4T++76GWH/g/rfyi79iUrNBzT4r2Wr7f?=
 =?us-ascii?Q?BrvIbDb3HQfjVV4oEeataRVevm9t3SSfBOawPVNmt0ZMm6jac1AsBHBYbmsf?=
 =?us-ascii?Q?F9+y7wM8qCkycalxXL5N4ho7l1wPNwGqiGt1bTBkqryA7Bmaf6l4SEMFBG+r?=
 =?us-ascii?Q?3NvNCBS3BM+GyN9UgOYbe6MmewQ7H/jnfDo4aevtXzQP8lIF3wZjnPkuAKLy?=
 =?us-ascii?Q?J0CRXHrof+CPPBQnWe6Q3IpWrss2KUP3dobAEkGMkiNe97W67EWMoolayLtP?=
 =?us-ascii?Q?Q3hXongBaX4ZCcCOcYk/iuy/r3r68HD+bLtAnR1+WvwL8IcA9aq2UrRWLcW8?=
 =?us-ascii?Q?YMwJlpZ+MacTz9NrbbRrKWWRH0K2W9nNFNcfB4uZbTxTMCFyYzKKdSoHTNai?=
 =?us-ascii?Q?EfJtG/R3Vvg9cngYquXQrzcpEzg+1AI6JAz6Fa0lWiJbzucOlFunICk5PEQw?=
 =?us-ascii?Q?1M+z6JIbuOGGeAJqQXekUpz6OkYFkb73t5Apf5OgH1YqHjicpwJeedRVqxPP?=
 =?us-ascii?Q?J01uG5CABHDA1SCVdM+QMxqQE4TcL3DXfSWz3nS9Mn9+DDEpsAZxeIERxPEg?=
 =?us-ascii?Q?YeNYvQChtnIxg5tkkEcVv+nDgXobZ0oJl58kIQx4szOQgIeV8B8W4SXAgnLA?=
 =?us-ascii?Q?4h/q0+vp93yupV08wcmy6tjpefvejcRVllnaxewGUYqSapNaMXbyzj7gL2NM?=
 =?us-ascii?Q?e01WFgoTnDQ2tbKXeogidSgBoNnhd+qCO1etnmVIB2at1g7qUDa+bamhZft4?=
 =?us-ascii?Q?gXU15ISjmyU5/E6CHAr7GahxhMF13ViryzTVb9RjJF3FQpgSpbG6N+2wUWi6?=
 =?us-ascii?Q?uQMOAYt+76xAXtsSu34EhJI2dx/hCL+I2U8psFq7K3902OTUpEzduz8SDycz?=
 =?us-ascii?Q?rHEWdk1BxU3NPf8TekPDOhZkPCdufWhPHKL4Tyub49rPa1vYdZRfn2QGwgdl?=
 =?us-ascii?Q?okcl0anU9+yJQZp0boSCpTLXfG5HhYF9xAz1ua1a1FYyzJecwTB/nxWH96im?=
 =?us-ascii?Q?Cu26rgahra9EI4LOi+YTYl/w0ItDt9bQynk0HMgRRr5BDaKc/+UFZKu0ziBl?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a82bc8d8-ed3b-43d9-b717-08dd47d31a57
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 23:56:56.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4rX+dDTmixp2hvjE/eR39QWik4V72xPE/NEafQIMkK6tTVozGWp4UMIa1LJDhIfIdJdgRKoWknA0xOvuYe0fDCQnFZiYS4cYPkcif2SM3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the Feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature. The retrieved Feature
> entries are stored in the cxl_mailbox context.
> 
> The setup of Features is initiated via devm_cxl_setup_features() during the
> pci probe function before the cxl_memdev is enumerated.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[..]
> +/**
> + * devm_cxl_setup_features() - Allocate and initialize features context
> + * @cxlds: CXL device context
> + *
> + * Return 0 on success or -errno on failure.
> + */
> +int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	int rc;
> +
> +	if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
> +		return -ENODEV;
> +
> +	struct cxl_features_state *cxlfs __free(kfree) =
> +		kzalloc(sizeof(*cxlfs), GFP_KERNEL);
> +	if (!cxlfs)
> +		return -ENOMEM;
> +
> +	cxlfs->cxlds = cxlds;
> +
> +	cxlfs->entries = get_supported_features(cxlfs);
> +	if (!cxlfs->entries)
> +		return -ENOMEM;
> +
> +	cxlds->cxlfs = cxlfs;
> +	rc = devm_add_action_or_reset(cxlds->dev, free_cxlfs, no_free_ptr(cxlfs));
> +	if (rc)
> +		return rc;
> +
> +	return 0;

One small cleanup you can do here when applying is reduce these last 5
lines to:

        return devm_add_action_or_reset(cxlds->dev, free_cxlfs,
                                        no_free_ptr(cxlfs));

[..]
> +/**
> + * struct cxl_features_state - The Features state for the device
> + * @cxlds: Pointer to CXL device state
> + * @cap: Feature commands capability
> + * @entries: CXl feature entry context
> + *	@num_features: total Features supported by the device
> + *	@ent: Flex array of Feature detail entries from the device
> + */
> +struct cxl_features_state {
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_feat_entries {
> +		int num_features;
> +		struct cxl_feat_entry ent[] __counted_by(num_features);
> +	} *entries;
> +};
> +
> +#ifdef CONFIG_CXL_FEATURES
> +inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);

Shouldn't this be:

static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
{
	return cxlds->cxlfs;
}

...no need to do an out of line function for this.

Another small fixup you can do when applying.

Otherwise, this now all looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
