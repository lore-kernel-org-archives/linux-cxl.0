Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9F22EF8
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356473; cv=fail; b=Jb/fWvmEeewsY24ASiJPpgC2igvxz/nyl9u12/MBKuK/gH4vMobKVAnukqwuwWqQ9b251LwGUEP6JtpWsS6l2LsgBemWf5lVnD4SkzRCmFo2hKIW2in/tFxXo2xADwlJsmbpZOVMQgOM28qe7KKnEXsaTXM1eqIE8xHUrRTKurI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356473; c=relaxed/simple;
	bh=CuI6QAQCXiO9t1ZUGpwIljolZAj/gI0fg5vXKltnXlw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YUEkSlqC549m5UpZGR2vuRNu5V6GV0ZV1tzGEH82H6Y/pYVf0eDhphFJ3GM666yJCW4Ocgo9znsTaffytdgbBteYaFCVxuKxaIhAT3wdtQhJqe73NLc3QZnHbFaJ0g6s7ZP4tBER8U7pwtxIMjhPBZXjjaBaQ7M6lnQoXI94siM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJeI7qvZ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJeI7qvZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712356472; x=1743892472;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CuI6QAQCXiO9t1ZUGpwIljolZAj/gI0fg5vXKltnXlw=;
  b=eJeI7qvZgDCaJrULbLBm2oxZMURb83zXetmGbj8v/KSaaPdEtDSOLU4k
   WqibpftetWvt2DNubm6ZYMEQvRmeWbjyEyAceopk2zCwQxVUsWHWxVLOe
   URpqfnqe5h8gZqjXGgmyGYab8pFVy2XAYO58P7GGwF4B9IvJQySYjpuHn
   DRyVBsxtoWz6rIoykEkeCBSwkW22GNpKIZ8XX9W5fBvQ9OpwvaoM9GZ34
   vt3wprmazBaoIZyZrgK1nVhbnhYaN8nFdCXnnNWRH57fdKoLUPG25RpMo
   IIFY+H3/n3rfLrafxbx2GdwbmJaDecY3vQR/d/KUXZTr0VKcR6D48O83J
   w==;
X-CSE-ConnectionGUID: 5ABD69i/SOKZ2/2bBHNiiA==
X-CSE-MsgGUID: Wru/tKBHRH+5JC90+shaIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18437646"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18437646"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:34:31 -0700
X-CSE-ConnectionGUID: RmoyLcUvQMmWM+Ux99kcZQ==
X-CSE-MsgGUID: FP/Sv0SfToOU9/DJ/a2IqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19739247"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 15:34:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 15:34:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 15:34:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 15:34:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 15:34:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbAVKLACjGmNzELrkDGMLW1Bvv2ecWq7VA7sJfGKB8IRBMqhbsynBiikblyKbYvJfuBw2p+4unfVjxcwqhIDQDa+ClUnEhAso9VJ6I5qvWYyMoKxkQn/TNJAuzwlFuF0wnXIKUjdPq7zJhOgfDWsG5ThbE65sQKAZM3mf+ii3/bXAuxqwj+0nsj+AbGmZy0iVThbhbNJyyl1Zu3nkzpajZT3kT03kOYLeAtqbcuypx0GqmvzTaEggdT7X7Nre6wRZ9LoZ2YZXMPr6umaUd3gtMeTz7krI0nV+x2OJzBXQgWp2/UsI0/UdhmZKktvgOAssfZQUOKKHFL2C0TLPLUVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijo8Wv2hdpSrgXkIOEJPHW8j6uGpRsUMvGNtyZFJUqA=;
 b=W6hDIwT566Ws0jrxCk7jxJ2dW4ZBVbimRouX2s6UHXdsVZvvRUJcsKahK93GoFE5/hzDrxQ1YyRTZyKZWLO/aVKa0gC0ccbGycpt078cIkFf/ZeA3pxUTiZBiudnLCZr6YyBlTrJR/PTR40MRJkd0n3Aa+ZmKcCs/Kwkq1dCllY6W2+KD30JXJ3zGV1xH0chv8zJXsQ37K3hSQlPo/lc+GjuQv/5xsqPUn02ZTe8aCzjZ8XbGzDOygpCCICFfgL74cqTD6jByB+GeUltaaBFrTCMXR/wqGvNNhOMYajmtEF+mReA5187wheB1e0+4N+2YXGDCcIBiF6OKSF7r/dHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Fri, 5 Apr 2024 22:34:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 5 Apr 2024
 22:34:27 +0000
Date: Fri, 5 Apr 2024 15:34:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v7 3/5] cxl: Fix incorrect region perf data calculation
Message-ID: <66107c715e6ca_2583ad294cd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
 <20240403154844.3403859-4-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403154844.3403859-4-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5969:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aua8QaYz9wrAC8FalIkT7/bABjJdbm5/pQcfp76qTKLlvBQryueAipudyHGq9i5vR1mn6l0OcnKoPS55tc8uU79Bf9YeBavZYl7I20C6XPbgURjoxYmGEDjBZqUV7eeqsBHUxI9cJWZimRhD3T5yIr9rDFeSBxdpRxmTzmo+vyGOTe/Qorpl5uhFexlu4AfTSGIY+1/Lpekr+WCe17O4oGrRWsoXWQaoQzDumocrfN7gxCJn+W/sOm4Zz7q5t1CIcaIMm9ooksCNYwhhP28Vv/CBFIqc6wGxOX4F9mq63SIM7Xs4TCui6gLHPxQlHkpPxb8NrtEil4RBuOHUEtQZ4DH//GsqH1GfBSaQEyHzyBSjKoxHc0T0Mu5HNza6SxMQuV7skAZDLPNRqIwvXj512dErjYv9co27/t3+BpjqUFOsY4FhM65BznTGaRKQ1NBS080znTjVS1UFlZ75SdmS3LveSVf21BxrZpRSh6Ns3Ulbr01EPwClRYPY1ZM1Hcdomnt7HCdSyUleHroxQ/lnW7VtCVXckSk2Plbwzz99NaqDJepcRZi2Vx9/f89aI9Wm+pZMjLXs8UWAhMsJmkjfJxIzQ0PWsvmsGIRNEW+K9b7GVDAnNNBjT+R+JVf8hTo3m+EZOT6kA5tKSYrFos3ITkW10oOBUWmTcJebufT7DIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Avj4Lzm08HbmHG6nGnF11GuBTXjBYvjgppvzQNfqan0midmpbg4ADZFnr5BL?=
 =?us-ascii?Q?pdDr6dNbm1cb4KKNuRMPaskrr21fu3bN0htR5x0QTsJL8WULhZpbu8MoCNfY?=
 =?us-ascii?Q?HX+E5N8cYzaVoiNodClfn+PHjouZ60vGCGCLkBCNn8poQYs3zQGN7nCiqZYW?=
 =?us-ascii?Q?iN7obkVPLz2ueRX5JVmP76ojDud1Dpr3Opnt9CtuVcsh2Q1w82nHbhsMXY9g?=
 =?us-ascii?Q?93XhHTCAxHuIJICTliuDFXLLuEGGi2Vd/GlvuokfZ3SpCRTIYvl2yaO7ZdQS?=
 =?us-ascii?Q?IAIdPo8QwKL0XwODmNhaRAopzjTv2QZn4imSRatvXth9eDBxRD9LUTZyGHZ1?=
 =?us-ascii?Q?3f6HqlkcEPkfAXc8kdCT9uy3IfdI6a0ocO3dbpv05cjo6JEqG7wQ8CDo0IAt?=
 =?us-ascii?Q?lVGdVX4n5eUvvVzM2nyRJyYtVPvRKu6FXVD+mWr8xkCgfe0Q3OwJAuyAYvon?=
 =?us-ascii?Q?/JFl2uauEvYWKqs8gCRmoMlz4WULXvSLG2mq69Ofny+VFA/3SjtwYFVZugj7?=
 =?us-ascii?Q?mjESbjv9HPYnSrvRUJBFOYSjWa8MuOwJGPLUXvJR4ry/67bGUoEqqbpz6A4T?=
 =?us-ascii?Q?Rdw/sbI9BQDOp1rjenL9eQbWkcE5iEPRUX0tcOrraBU0vYRicg8DS/znNFhX?=
 =?us-ascii?Q?r1ZV+m9D7rbDaYaVmjJdQrOJT88bzQRpcosK4MSPTZYWxFyfN7Ou2FriI9nJ?=
 =?us-ascii?Q?FhckWvoysY0Axtqf4+HQVp2ddUPfs8FDFVCh8Ut1sqynADOEc4A5RSjBmRSP?=
 =?us-ascii?Q?18MUOXA3QG1762ShpTjGGwynDodXqu0ix8NB2YrC2qShY1lxtT3r7eElmTHO?=
 =?us-ascii?Q?vlA3TTfJJRijScSMiS3FxEI58MFKHr1pch6tAHS4kcyg2Plwar2tfxreIO/k?=
 =?us-ascii?Q?ET5ZcJCg0WOKhXokKx6AEFG11PXzcIclz37MyMw2FRhJAJCVQI0QVlmHhbMv?=
 =?us-ascii?Q?TiUL6eP9rOhNOjeM+L8p226DDy2nRlY/4ktkbBK7gHc0eQRaNWuIFcLs5/0T?=
 =?us-ascii?Q?mSUN/EJIVJ+buolnVCq5tEzsx5taEtwnJexfFBMcV1h+L/moY9YGotqsHp7c?=
 =?us-ascii?Q?Lh0UqqaKM20EXsEvzpfhylUBCnE00kQk9mYbBpFG6QZxld3yBYaK7qTTbuE4?=
 =?us-ascii?Q?FuLi+DM4lPtCEMX4ZCF+cR4/NfZread63XsJ9Ynmqx2jNtJdzSf6ML1wJBj0?=
 =?us-ascii?Q?dey6LycNHFa7VrCDAJBUx6sP87MvuqD6HgKMUh3ee3VzRaqsrZQj9lfTRtu3?=
 =?us-ascii?Q?nx4EkCp2caZ03P8t4daOwtloBk3JGjDlrMgErql/RcFHOajOqz/YlGQadJyh?=
 =?us-ascii?Q?t1iScaagblx2o9Eq7aPaKbWtJrx+3wAz0kbg09dJEqS1chsh440yYQ1ZOqs5?=
 =?us-ascii?Q?EwOP3897DcZM/ewBk+A1m28z4yvfzwPjd2sHlST+6c7YZgQk94lxcvmPbHEz?=
 =?us-ascii?Q?Zwrs00DsvVforseWIdEn0GKnvwLY3+MrbNFVyfddQlC/jphfAH1+gjiR0zNe?=
 =?us-ascii?Q?fbm8G/ILPdjbZbbtDu3cQc1X84Ud35gEt7m6SBHIZYoKRAO+s1SfyZ35fMZx?=
 =?us-ascii?Q?V/BDUkcZXZmfxt935RJIMc44QhYJGC+MdbRxDlSIDv8IJgz24Ah6+GXWbE4l?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23574cf0-8e29-4cb6-9924-08dc55c08d6b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 22:34:27.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYQS6awxrs3TR/oQV91UjMPQyVGXryxfMLqEVCOFA4cwiT+rBzQHbuZk0lrtRpkZ1XRHcwegK68pAv540ip2UhF4qxDNjMoEFfOwH6n1riY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Current math in cxl_region_perf_data_calculate divides the latency by 1000
> every time the function gets called. This causes the region latency to be
> divided by 1000 per memory device and the math is incorrect. This is user
> visible as the latency access_coordinate exposed via sysfs will show
> incorrect latency data.
> 
> Normalize values from CDAT to nanoseconds. Adjust sub-nanoseconds latency
> to at least 1. Remove adjustment of perf numbers from the generic target
> since hmat handling code has already normalized those numbers. Now all
> computation and stored numbers should be in nanoseconds.
> 
> cxl_hb_get_perf_coordinates() is removed and HB coords are calculated
> in the port access_coordinate calculation path since it no longer need
> to be treated special.
> 
> Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v7:
> - Remove min_not_zero(). Incorrectly set everything to 1. DIV_ROUNDUP()
>   will ensure sub-nanoseconds values not 0 unless value 0 to begin with.
>   (Jonathan)
> - Reflowed patch order
> - Remove cxl_hb_get_perf_coordinates() as change made function unnessary.
> - Add hb access_coordinate back to port caclculation.
> ---
>  drivers/cxl/acpi.c      | 13 +-----
>  drivers/cxl/core/cdat.c | 89 ++++++++++++++++-------------------------
>  drivers/cxl/core/port.c | 36 ++---------------
>  drivers/cxl/cxl.h       |  2 -
>  4 files changed, 40 insertions(+), 100 deletions(-)

yum... bug fix that removes more than double the code it adds.

[..]
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index eddbbe21450c..48704976693e 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -20,6 +20,31 @@ struct dsmas_entry {
>  	int qos_class;
>  };
>  
> +static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> +{
> +	u32 value;
> +
> +	/*
> +	 * Check for invalid and overflow values
> +	 */
> +	if (entry == 0xffff || !entry)
> +		return 0;
> +	else if (base > (UINT_MAX / (entry)))
> +		return 0;
> +
> +	value = entry * base;

Might be worth a reminder comment here that CDAT fields follow the
format of HMAT fields when a future reader wonders why these type names
are not CDAT_ACCESS_LATENCY, etc. Bonus points for a "see Table 5
Device Scoped Latency and Bandwidth Information Structure in Coherent
Device Attribute Table (CDAT) Specification v1.01"

Either way you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
