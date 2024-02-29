Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64213383B0
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233206; cv=fail; b=hZ+vLQzzvGTPj8a91ddI1mbPsnm2shpWvT4CkhIC7659kW28r7izx/6USHPouCUviBb6ErRInBbFbA6yeE7hRSFKirM7xcaL8+iy7e8RrgQldP/T/Cub/wcaicVOPiygNJe1n5mHlkgM4zckyiOGObI23kOcEUNm5pahmbBF+XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233206; c=relaxed/simple;
	bh=hj71FTndbBqoH8wISKRpXqzw2wgL7ny2lm9nkleJiGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hSzlIoGmnXbU45kUMQbkUIJ1Ua17EGh4LlzsaUo1kRKBXR5t6ZSE8rchiGY+/1yEye6KYc+hTudSqyY0F5dgXhzDICHcmWJUpi84MYb57OhdJOU1jvaPpaGT3wPKJwqKLKI3MDIiVKUs1KFLSTa8nrcBRjke7rohTnBmcg+EiA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H004FheH; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H004FheH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709233204; x=1740769204;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hj71FTndbBqoH8wISKRpXqzw2wgL7ny2lm9nkleJiGI=;
  b=H004FheH1xyysmUlQoUv8Cu72IgDFu9+joeXYByKBmS+XDvgPmE6Fy4q
   XAzcw8uSoAl7LWc238z0wWNfbHbnciRPNVGioVkVq95q2aWLZS+JLrJ8c
   78AHa+TP5fcQ+vFpKwxa6b+CopGn7xHiyMuO2TW7jrUhv+rylLBL1lfKJ
   wfqQxzeQO/h08+DxU1lYD/KmE3i32TIMFMBwB1C8301oO7tQgHTYGK/DW
   O+h6Z/++9qVMoMziBGIMgjEW9WETfmbl+VohuhxwrIeXLkc56xYkYIio6
   QXM0fyGVPJeuLrNl14OIO0zvJvfZ8d3x45Q9MbfQP0tKOu7zpvDI298nG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3598603"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3598603"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="31111717"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 10:59:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 10:59:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 10:59:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 10:59:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 10:59:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYvaoNa2eRIPm1VESt2+rxpb/sACFP+Jd+KUAscSpwoiQ8pAffhCt+oF6fGjSZX7zeUzTNsBmHvNkNxziY2NBnq2KP/zJuNMr9xWiHsj0Eo1Hm60PmzKJAecN7owKMxFNp8JQmcBlVnqwGc2kwt/qVQsLzzXpznNRfi6m4vKE+9GeIY5DVE9igj/WDQHqEjTx+gaGJcxB4QkSxfRLNHMi/vBVPLqNKtFSeDt/r7+3Q71SQwRj9QpEp8p907H7qlY032ofjn33nIlVNCGNQmGhFPZU5CCDi1WhrlDpFzEjFstDg0ovm3rd5XN6mcRuBuq4f0t1gg+OgzcMi9dzaNRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc1gfhP1o0eqncC//7BhmyDC45nQt+c/PdV1a3VqnCY=;
 b=ngj2hrs+h8t5NjwSBzy+VLLhciKsSvFjfnszV2YwfI2FsZ9KTJtsR3kMEeYaEMsz1mpDsnaG9XyXcVXIawCPCLUDSb6NI/Qw/zUaEO8PbiJwIsgifL0ZYxkUcNuW+4PFMP3NwepBt4rwUXcY7ZR4mGuCi6BE7JLr1trKfuPSk6TUvMid7uszLFPT+ouKBdRTNlLpJgUrqz0Ai8EHouzM+/Xb9O4e30mB2m9ap5hYAhlj6iqgoupQJZcUcxQZ6SWfrUcTAXJGBcrebvpcX+a9H40np8ap5WkXweRvRxhNHKfr9ZChOtuOELzVgvN0vMI1hbrTVNhi7d5ak/hzXEjiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Thu, 29 Feb
 2024 18:59:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 18:59:47 +0000
Date: Thu, 29 Feb 2024 10:59:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 2/2] cxl/test: Replace an illegal CFMWS definition with a
 useful x3 CFMWS
Message-ID: <65e0d42126766_1138c7294c@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1707891715.git.alison.schofield@intel.com>
 <d8bbae3ea5dc59bd4972236fe06adb5ec85e5c21.1707891715.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d8bbae3ea5dc59bd4972236fe06adb5ec85e5c21.1707891715.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca6f25a-c412-414d-1b84-08dc39589928
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7OwBMeLqT6O3IHKjXBa89EyYchFLIS1vtqRST3uETsQdTOdO6+Y8ScCnfBqeBT0LKRf30MQtszw3L0x8NNKJuSRwoPD1IsKlwDr7IJGq845Zf1eDNT19BMj+k4tk2XeyXK2hqEpKsnKiLzwC4VwMXGkBXdfBlHyjC3U+o75FS4pVbfs+tcwu5m6zkq9EdCvjoBHq5/B1lqmPubWQ7hSy8SxtgRv+dd5EOlbReQeP3xVp8HMHgRljPJ/TaBKmeiIWp8LHDI+SZbHU21CZZWkg/C2zqPH+OQWzQRde+gDoJuLe3vEItfc0SlGBF+euNWczK5tkgBwbWndZrgLnjUre4zqpgTvXBXvmzkaYlo5SaSZoN/tPCm2q0DLEMWXZ++wz1GTT7bI1joee5DuJAQEvaWaUNXzKk8AVytTpDmqy9NQO7VRMJYUtA/vYrfkb4mJLkhHc8A+Pq70GPZ8Vtml+itINhYqgFse2OwCIKF8bldmzOH2d5RYPbHSggibGWs/nGeSdiBnuTEaKRwpgwMzLDn78epA0oKamw+9+F2RjhVKAD3ZAbJ4mhxQfW7QjfJhHWV6qCQcSdcTYxq5K6+GP1shEWpnmFihniFsNNWSllnSHv7D45UI9He+8Mi5tuBaciBfBT5y7O6eIO2kf2UbZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hEJkIoDcozRr9lpakETiTV9ZPAsQTA5qOiS5716kNfYX31nT+GKNzfGIzD2U?=
 =?us-ascii?Q?JX/cxI0CMbXYu4GWlLDSR35YeuIIOGwpWEKr2EASpTF+gJRULrsVMkTJKW5Y?=
 =?us-ascii?Q?g0sdpqIl8vOjxuzkdN4UjxaOokc1I+RDWZ3syyUykI/Cfb8cnWk2SvQiRXWu?=
 =?us-ascii?Q?qj8Eh/B1NUEtI1x9gYrzNAery/bBF9JYKaKO6u8VQVq88V33gaS6th+0iIJY?=
 =?us-ascii?Q?ZJxEuV+ioBuKedNsYFBPa7/BysSLgMxzKHsrGoy8WO0Muuxo7GXifJXeR9UX?=
 =?us-ascii?Q?w2wkqpRKlj78dvzC1eggQMqmGz1EvNHJsw/wc4eDd73SShTN2iXJbEq/X9W3?=
 =?us-ascii?Q?sXyzZ5ieeo2GExfp4DZQwZ3EL5nSKc48tse7TILN+SaiAu6YKSyW+tu0wUxi?=
 =?us-ascii?Q?A916vcfTZyhHcpS2ESXo8y0HwD/m/4UQWhgQmygtrU6KVWC9zOWTYArElj6V?=
 =?us-ascii?Q?wduXTuUz4fe0P9zsUMcbq0OQZ3D4WtKonmf9xAsf/qNlI/2OOmgYsDd8fgcS?=
 =?us-ascii?Q?nkVL+CS5TOXsdBMDQOoPdr0JX4jgpO2ysktV130BOOXkaTBDivKTAO4ZNAN9?=
 =?us-ascii?Q?GL1VzrPVQSjD4YFbt/1tTO6lepR9iGcZhpB5t/LoPDS8o1MSJZbAprHg1uAO?=
 =?us-ascii?Q?2SeWZY2G5ljr3NIzDs5cfSMf38EJyC6FyAq8Z7dOmXiPPxjBYBjQiOrPQCYv?=
 =?us-ascii?Q?6Ef9vdikx8RkMxGrWVDh3xMSqB/u9wvFkIO2WT0wQG3HsVTbHJN6THh2AG9l?=
 =?us-ascii?Q?liRHh+fNl6mWHeRJKJW0qlbT096hxDF9yCdPpPbCw4R214fvLWuVztFJebgS?=
 =?us-ascii?Q?oFR4fPOIvgOeO1InS3Fq0WVtdADma5+fhZb44EfYGeceZYyWNNq2mIMuFLwn?=
 =?us-ascii?Q?bMQXfkevpTv4RbJqTn52GwFAMS5huntDTGfvc2nJddwc75mjdHNkXoNzcxGP?=
 =?us-ascii?Q?CNnISBzwXLZV+iGi98j+3+66HOyAmwxTRdgREEly6QrEfM+Pi+mbU9yDbdeL?=
 =?us-ascii?Q?f0EJEax6ijICNgbq+oo++k8hnJfUTClzn2sBaTyE51gS04b4FD0EbSdeWNZQ?=
 =?us-ascii?Q?1Yd1Z7ReVmEplBgovJ1eqqF3+rS1VUQmnUhp5jzCfDVEQrR01H3Ow4kAL09v?=
 =?us-ascii?Q?EwTALzula1Zmyrx72V/qlDcDPNHLIsw+IpuzisPyIh8boWTw1yajHj+A6X8t?=
 =?us-ascii?Q?7Ix5/VuV69qx77FuZzmWhxTMDcw/MPaAfpTGx1HcD9eBOUi2VF9j0wgcvRn8?=
 =?us-ascii?Q?kNfjLU9t7JWPmH4SEICH/xNf6Y5EDLWDRHAbHX6rR8UPRYl7WOmhpAAZU93W?=
 =?us-ascii?Q?PteOY8bbmxdoD16Pe7JSpnuY/OQX9toyxXxMXOzqEF6UAFTZNX3W8cXVsbQx?=
 =?us-ascii?Q?6CKlcaPuigc6mJVBFVR9HO54Yj0S9JExlfQIrb1W7cHLl9XBQO3WibCrHkez?=
 =?us-ascii?Q?YZU6y+7KJgCR8Rub5sEdYqIuKrr5KfA3go7FStLFxrVD5grCmRLltytgs/IF?=
 =?us-ascii?Q?fUVZeWM84Y+ZHpz5gI4FZ7fS1QZVRo5ZN8kXgh8GEwE6ypBkockPpPDXROUK?=
 =?us-ascii?Q?CikGxwr2RHs4VZ0IH3HmNrNMeu4PqAROhFMQ9sKQmZq2NS2Zt4O2R4bTav/W?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca6f25a-c412-414d-1b84-08dc39589928
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:59:47.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xej0o35F+Cw/cKeA0/RTvubWbt5mhdWnEznUhF5+r8Pp/FFe6BXYkTGCRSLOdbofd3w2McnR+1+8Fh4sTBRHXxpW4J/jbgQo5Bte8HvyEe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/test has a small set (3) of CFMWS's that become available when
> cxl_test is loaded with this module option: interleave_arithmetic=1.
> That gives users of cxl_test access to root decoders that use XOR Math
> for interleave arithmetic rather than the default Modulo.
> 
> The existing x4 CFMWS definition is an invalid configuration because
> it repeats Host Bridges in the interleave set. A patch to remove its
> usage in the CXL unit test cxl-xor-region.sh is in flight.

The commentary about "in flight" has me confused... posted patches that
I have missed, or work-in-progress patches on your workstation?

> Coincidentally, there is another CFMWS definition queued for addition
> here and a patch to use it in the CXL unit test is also in flight.
> Rather than tear this CFMWS out and adjust the indexes only to follow
> it with another patch to introduce a new CFMWS, do a switch in place.

It sounds like you are saying to squash 2 patches into one, but unless I
am missing someting only you knew there were 2 patches to begin with.]

> Transform the illegal x4 CFMWS definition into a useful x3 version.

Maybe just drop the commentary about in-flight and just describe the end
state.

> Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> I realize this switcheroo is atypical for a patch. It seemed to be a
> cleaner repair, especially when trying to push this cxl/test change
> with the acpi driver patch in this set. Say the word and I'll split.
> 
> Also, I'm not looking to put back a 4-way HB interleave at the moment,
> because it's not a unique case (similar to 2-way in the calc) and also
> because I have a patchset in the works that supports all the HB interleave
> configs. This sets focus is repairing, not enhancing.

It's cxl_test, the rules are more relaxed so I think it is fine to say
"x4 window is dead, long live the new x3 window".

>  tools/testing/cxl/test/cxl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a3cdbb2be038..e7e4afabc97a 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -329,14 +329,14 @@ static struct {
>  				.length = sizeof(mock_cedt.cfmws8),
>  			},
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> -			.interleave_ways = 2,
> +			.interleave_ways = 8,
>  			.granularity = 0,
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = 0,
> -			.window_size = SZ_256M * 16UL,
> +			.window_size = SZ_256M * 12UL,
>  		},
> -		.target = { 0, 1, 0, 1, },
> +		.target = { 0, 1, 2 },

I tried this patch out and was surprised that none of the existing tests
noticed this change. That at least makes it easier to coordinate, but
was surprising.
