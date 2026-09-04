Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36431415F22;
	Fri,  4 Sep 2026 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499329; cv=fail; b=TrhZnij/Vwfq6P2bCjO2L0J8TC5mRqTy831y2HvpHug2Gnb1iUVyk5Q4GUkuY6ktHclL//0/KOP1k05Bv2r3rPn6KQ0BLemr+ScdG1HVNS3wGWrj30mgKcLXY6p2gqok1gqZ49Z3BLjo7nXl+lSGuM7ULCGMe4YvfCRL5ODEDeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499329; c=relaxed/simple;
	bh=0YBtiYcFrOqFXWIgsDVAcmzrv7I5/skb0axXrbRCPl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EjqMSrbv61VWGR0jW6wBVWwxH03kG0jUuZ60MMMA5Gd9wpTx17RSdRt6Qo64RerI5ZT29rebXdi0sxnu4vCQ4lB5ZUtnyHC+9GPwkswTwmc+/S2D89hWcTQpMWWshztqkLx1Js3OhfNXqhC7YiuXZjzm9QjAvrxxSPiUx0fRCNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BW7Z0Shy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BW7Z0Shy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788499327; x=1820035327;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0YBtiYcFrOqFXWIgsDVAcmzrv7I5/skb0axXrbRCPl8=;
  b=BW7Z0ShyXT8n7XWI4X5cE+CJcor9vZWnUvY79pDbxBBcZpmvpTw3v0LC
   vKlX7ZQ9QQRgRXoGGGXI3X/NiQZx7/C9IQYCN5xArNIGlY1o/2iFHzF80
   FEXWYRT5mHrzShLWgWsnIqDcWdCKDeYDs6AiLXCqrJU1s7sXz4UzkRqjx
   N5muKFUucekqyoXMTsnEp/ynfkBtSqMxZ1ilq1bGAcUEGdxPdp8klYOpd
   /F5d3UcGcjmx+C1E0SvkGWHwbUDX0FmB2MJYn/uFOzYSff1SRbYNxeqJ1
   TYo4jlVsf6L8aaZIL9Thzh8C15s0hWl2uyBnMbOuwAzjpZmALx2C3KBjA
   g==;
X-CSE-ConnectionGUID: 9UQfe5c2S4GOMz0BHvJ1Jg==
X-CSE-MsgGUID: RGuEHFn6TACwRILfQNUZeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92814835"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92814835"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:22:06 -0700
X-CSE-ConnectionGUID: 4JT57pbpRk659rpxq8miQQ==
X-CSE-MsgGUID: kMiDL0B+QQq7ldc7EFzlSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268199507"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:22:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:22:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 22:22:05 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 22:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk0UTHomyw+BQLNijGWVvGFExqRk5wubVPbmCbl2D13HE1/b2jmnfaLShcMLqFRyM6OaHVj553H8zp9yTjU9wKAYu2xdX7lpTivgfTCMsKK1P5l2vZPj7EOrg7oOI4DSIqm/pkJdBPtyMJwc6VoSuU4FjWT+OtqEah18LN+fp30jg9TnyGNFPGbwReQhzFpYAlGflt3FeZJzFqTEfvdtmItJ4IouZ4/ZGBPxrcOp2LMyVFVT05rkl24GGjsVAPxiZRujpFBKXdXYYkEyhGtjvUvz9EpNif8c4lA6GPEgKSlQR49kH03beyL5sw1h9pN6tNGSqkDFi1PxBcoKFqm9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhdRM3sBEwjimuRIg8/kZqTzPuPQWqnX/FERa6fTxbo=;
 b=Nr8gz3eeyncpXJVVytFCQFYhHCmIndmn9RyRKzxgZzQ1opUd58WTNc3zShz3MkrfIRXdrUhCsbnp5oki+YrrcIb4Wj22fhGO/LLWm1ZPjQrUY9kgYDmljO4xX8jFJPNrdV111FCzGyFLtKCiB4bvDaMWD+yoLr7ua57dQZQNxhpjvkQ/7NNOT6PbZDgG+asrt6Vt2ZdoYYzfr1xsMa/YEvSfaKgswJKeNKyADzwfojWDhjO3z71fYbNvVi/R5otsxGCL30dpZLvKlljFMd0H16P+tX5rdwmzw32MZ6I6FL+b+PQkJHF/APQarellQEKX+tEGWiUT5n4+1AMerveZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB529852.namprd11.prod.outlook.com (2603:10b6:806:51a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:22:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:22:02 +0000
Date: Thu, 3 Sep 2026 22:21:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<gourry@gourry.net>, <rrichter@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 7/7] cxl/fwctl: Propagate feature RPC delivery errors
Message-ID: <appVdg55jb6Y3zcs@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <20260902053839.25595-8-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260902053839.25595-8-icheng@nvidia.com>
X-ClientProxiedBy: SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB529852:EE_
X-MS-Office365-Filtering-Correlation-Id: 527ad367-6439-4d1c-79d6-08df0a44737e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|4143699003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CLw7Fi7gLVPlzqijlhJ/OOdTMBCHzBKvgENxG4WBMwsWqF8MdsmxffIjWvvCJx5FPg0SIwSsjCI/E7PQLeXaFHBEck2CiK5zUtvf+YwK/zlAf7MOw5G/pFBzGJgj4f17ICefaEPf85VOOlfK07O3Ivj0Ud2Rjb796cacu2N7elZNjDWSbJkUIshthfo46WA+8qkE8jd8RCGP1aGJMnuievA/DSFS81SDyLTILm7Xk/CgmKPP3LS2rtThq7F2ySX+quqGMOCnviadYd0E8S+BuqFvlWfKpLgTL7O5H8idTv0s8K/sv1DaURq3u2YIoKZaCsa1QPRFaFlU9Iy0u9YAZWwJlEpKypQBikZzOD0Z1LyIfyLXHLAFwO9/gAG7wVxxdOj26y4r9ZkgHCTbMu64JrGKzPlIdTYLlphmfvZ1hILZ2MHDHut+gf0/ta67RTJD0pzVkSnyVa0It8x+zvWRAwBSnJfxOdz4eSQfRU/CiUWuNjNry/C+4KTZ60x03j0Gwejayur+tgvBYLeg8Xyt0P6RhnmDtZIM/0Hw3LU7rgewqDMzEr925S2tEz4IslVjchnAdpzCHX+Abpg/aWEQ1pZ3Z8AGW/t9hSNMhGryMz8knpFwHEo6RzyCRS5IW1YzLgRAKsYJrzIqnAUUSUCn1NR7rISSi5m5u/QqAbjMdeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7NFhOAfP77US9RquxOpUHpy4DUh7o/bznUybX6VHwShQipSwfaqNUfsdKhe?=
 =?us-ascii?Q?yF/CzAXv8Wxe64RRfwY6qaThinb/Kkp3Fta4z6hzeDM2ATXaq7QcnJCmBIWM?=
 =?us-ascii?Q?CQBoCPyh7g+kFlB6lBVTgDAgn+au9e0vZNRTenTbI3zAD1jUKLdNJC6Fw93h?=
 =?us-ascii?Q?GaXJmjKDVRfKAMixiiyKOqVaQ7dlM3TziHEqmrB/8Md7z6dRPliJaVeYJC9p?=
 =?us-ascii?Q?/0Eus2YWJzrj+K1NJ4ZAuRcbSR3hoagd3BNfaVWuUndf5+iIduE8ip2XufBz?=
 =?us-ascii?Q?hDd0r764FyGkOo4pn9O1a4Y6s5WMVgWVmIXNoi552kB4Hvonum2Zv/53dJE1?=
 =?us-ascii?Q?wLQiTT1ihYrDrDEOsmsjDN3YqoY4F0MgaiiqCVyQ0q6K/S3gfCtchPaj9Gbk?=
 =?us-ascii?Q?aj7Pws7NIWLIdMrEncswpAepQjRyK+KdJtvGK8w9SbkeKgowTpT4e6hW1hwS?=
 =?us-ascii?Q?gWwc9MKJgTAlIC2F0MDr0ayl/uU/nwdTrddqPrQtKN+vw1J/Yy07ZWokn1TK?=
 =?us-ascii?Q?eqsBLKqWtOcnds8Bbvhj/x1uZQ/uDU2j7BaKq7HcSLyO9qhk6GETjjiSyR3o?=
 =?us-ascii?Q?2DujCkkGZvrdRtFEdElXREyQSPwpTayoQYeS/ceGMveaKQbEfMnDDCnISO3z?=
 =?us-ascii?Q?L2xWHWlfTxeE59Bw0XLAaVY2fVBtA99sz0PTRow0Pqo2WJBx/n+FwJe/e46f?=
 =?us-ascii?Q?6MPaKXQkXJ4Ba/qN0GcfNHa9kUQxgak9ffVUNTFo5bcm2FL5NuwvTO14/6R6?=
 =?us-ascii?Q?BryP4nq4dMQkGYexu5JnRhQHV9P7t9AIeSMAvZfQD2nxidxNdyM1EA9ZDZC2?=
 =?us-ascii?Q?T0Ydp3fRJ4CfUf1qIaBpO/esSakJTZIzJ0q6SkiU42LkfGsqpA2s2yj6w+xG?=
 =?us-ascii?Q?xLbprU2G5QY+V0Zb1lDeWcwOcHNjvXbc7e7G/37xfPdxoh0AhrsRnzgk2gJe?=
 =?us-ascii?Q?9nv+AxCmdwDP9aiIhL+Jw9+GUbi0Tnh2P/sT5BbpvSC/IzSf+yYT5UC/0G6w?=
 =?us-ascii?Q?xFs15ZSY9Ke6oSVHoSyFtdTzWu5n+Fj3aJWn1FGjnNlm8JHwAg36pfewEKA/?=
 =?us-ascii?Q?yKxz4lw/osIyIhtZiKq990yWsZC6dpzkGzUO/7OpaRfRAk4Pmt7hCKvwWJE9?=
 =?us-ascii?Q?p0kmi7QsoV5XxkLml5a3fXdYsoUQx9Cpus4dqNkJbJr892UFI67XVthYYxE3?=
 =?us-ascii?Q?nc9VI4Mxktmvu+WfUy9g1G8EvlLTHyc9f6lOpD/fDnICHo+tfKCt1EOypZoA?=
 =?us-ascii?Q?WsdzKOSOoC97HrDs6up7fC91CSCxw8NjviKo6QCb3y0yhBlmGzv4SvVZ7h06?=
 =?us-ascii?Q?Qer3hrKUYgCTaT8faI4ygceFe7+M/vxZDkUlKr7xU7DDq/PCcBvUHeFl1I55?=
 =?us-ascii?Q?au0xD9DBQ+edtJEaIiFJnAu6HlMemiadOeod/gViEuzWgA04bQGOWE2zKD47?=
 =?us-ascii?Q?x1aclR7DNEmn2kTHg32cdKKXQrdifezb8tryEHipn03FnGH/VqnGMa0FCm+C?=
 =?us-ascii?Q?/QH6lRUh+x04y+vVww83UWdqXP53UXqf533bT/skbFYfTuj82my9HOEHP8za?=
 =?us-ascii?Q?i2VzEJyqqcTkvhVt7lbxFymc0etasJeWIvd0NVNUFsFPiEsqYtrn/24IdrRC?=
 =?us-ascii?Q?FI+Gi6hAx5X/1VqyvW+ijVkzVJk3kPVZU4vuf38Y6yodlXFkXUWaAibYcAM1?=
 =?us-ascii?Q?PO8O/2smgJGSWlbIKhlgyRzEuAjCdjmtCdsrUgC+nFo8ikdcMNbrQxEclBYP?=
 =?us-ascii?Q?oa5t8RCUdhBuJeIXgPeguELDUzODfmY=3D?=
X-Exchange-RoutingPolicyChecked: ByHnUCy/Rs5sw1wsCfGS4nnUCllKWbcLNWmbR9vulYNVavjSh7ACxBbsHTZcabjvSVW/nwYz6hFxBku7b57qJGi6xlvI0Jn3dtfgCwiCqSn0OKgnSs2ISCEhtxyrZ5wZMsr9we4OGZntICsEALfD50CxVBm8XS4z/vu+EVgocK4H12ToVJDB9NrZZHD/HMIwP46FZ0+d354y8KBgaTpzXcYJDEOs1jWuBxRMyzhXzhoQES9IeFIQsU8pGMEPdso0E2JF9ciCcp4ZAUaSr/gD66/FrD2lYBJu+9+VD5VXKVJpN1d8kjrkDpwOXQ5O8f/+DZXJSOQhjVZS8M9FHt4BRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 527ad367-6439-4d1c-79d6-08df0a44737e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:22:02.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTKi4HnjRhy6wUhr78Wcpjd6VoFWc3CjFGK5vlJpsIehL9TmXNmc3pIonBwbbHA5MnvinTXG1LQvQmqsEITaV74STRpHJQWjjLd/0cMYDSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB529852
X-OriginatorOrg: intel.com

On Wed, Sep 02, 2026 at 01:38:39PM +0800, Richard Cheng wrote:
> FWCTL_RPC requires delivery failures to be returned as ioctl errors,
> while device errors are reported in the output. Get and Set Feature
> instead converted all failures into normal responses, sometimes with a
> SUCCESS device status.
> 
> Initialize the return code to SUCCESS. When the helper fails without a
> device error code, return its errno. Continue reporting actual device
> errors through rpc_out->retval.
> 
> CXL permits Get Feature to return a nonzero short payload when Offset +
> Count runs past the end of the Feature. cxl_internal_send_cmd() reports
> that response as -EIO, so preserve the returned bytes as a successful
> partial transfer. Fixed-format EDAC callers still require complete
> attribute structures, so reject partial payloads before consuming them.
> 
> Map an unexpected zero-length result with a SUCCESS device status to
> -EIO.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/cxl/core/edac.c     | 10 +++++-----
>  drivers/cxl/core/features.c | 28 +++++++++++++++++++---------
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index f1df4b5cfe5b..34b81e8dfbbb 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -89,7 +89,7 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
>  				    rd_data_size, 0, NULL);
>  	if (data_size < 0)
>  		return data_size;
> -	if (!data_size)
> +	if ((size_t)data_size != rd_data_size)
>  		return -EIO;
>  
>  	*cap = rd_attrbs->scrub_cycle_cap;
> @@ -567,7 +567,7 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
>  				    rd_data_size, 0, NULL);
>  	if (data_size < 0)
>  		return data_size;
> -	if (!data_size)
> +	if ((size_t)data_size != rd_data_size)
>  		return -EIO;
>  
>  	fru_rd_attrbs = rd_attrbs->fru_attrbs;
> @@ -602,7 +602,7 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  				    rd_data_size, 0, NULL);
>  	if (data_size < 0)
>  		return data_size;
> -	if (!data_size)
> +	if ((size_t)data_size != rd_data_size)
>  		return -EIO;
>  
>  	struct cxl_ecs_wr_attrbs *wr_attrbs __free(kvfree) =
> @@ -1282,7 +1282,7 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>  				    rd_data_size, 0, &return_code);
>  	if (data_size < 0)
>  		return data_size;
> -	if (!data_size)
> +	if ((size_t)data_size != rd_data_size)
>  		return -EIO;
>  
>  	cxl_sparing_ctx->op_class = rd_attrbs->hdr.op_class;
> @@ -1771,7 +1771,7 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
>  				    rd_data_size, 0, &return_code);
>  	if (data_size < 0)
>  		return data_size;
> -	if (!data_size)
> +	if ((size_t)data_size != rd_data_size)
>  		return -EIO;
>  
>  	cxl_ppr_ctx->op_class = rd_attrbs->hdr.op_class;
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 8d44ce829497..95f47193fb61 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  	int rc;
>  
>  	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
>  
>  	if (!feat_out || !feat_out_size)
>  		return -EINVAL;
> @@ -259,6 +259,17 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  			.min_out = data_to_rd_size,
>  		};
>  		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		/*
> +		 * Per CXL r4.0 8.2.10.6.2, when Offset + Count runs past the
> +		 * end of the Feature the device returns only the bytes up to
> +		 * the Feature size. cxl_internal_send_cmd() reports that as
> +		 * -EIO with a short payload, so stop and return what arrived.
> +		 */
> +		if (rc == -EIO && mbox_cmd.size_out &&
> +		    mbox_cmd.size_out < data_to_rd_size) {
> +			data_rcvd_size += mbox_cmd.size_out;
> +			break;
> +		}
>  		if (rc < 0 || !mbox_cmd.size_out) {
>  			if (return_code)
>  				*return_code = mbox_cmd.return_code;
> @@ -267,9 +278,6 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		data_rcvd_size += mbox_cmd.size_out;
>  	} while (data_rcvd_size < feat_out_size);
>  
> -	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> -
>  	return data_rcvd_size;
>  }
>  
> @@ -289,7 +297,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  	size_t hdr_size;
>  
>  	if (return_code)
> -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
>  
>  	if (feat_data_size > U16_MAX - offset)
>  		return -EINVAL;
> @@ -340,11 +348,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
>  		}
>  
>  		data_sent_size += data_in_size;
> -		if (data_sent_size >= feat_data_size) {
> -			if (return_code)
> -				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> +		if (data_sent_size >= feat_data_size)
>  			return 0;
> -		}
>  
>  		if ((feat_data_size - data_sent_size) <= (cxl_mbox->payload_size - hdr_size)) {
>  			data_in_size = feat_data_size - data_sent_size;
> @@ -492,6 +497,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
>  	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
>  				    feat_in->selection, rpc_out->payload,
>  				    count, offset, &return_code);
> +	if (data_size <= 0 &&
> +	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
> +		return ERR_PTR(data_size ?: -EIO);
>  	*out_len = sizeof(struct fwctl_rpc_cxl_out);
>  	if (data_size <= 0) {
>  		rpc_out->size = 0;
> @@ -544,6 +552,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
>  			     feat_in->version, feat_in->feat_data,
>  			     data_size, flags, offset, &return_code);
> +	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
> +		return ERR_PTR(rc);
>  	*out_len = sizeof(*rpc_out);
>  	if (rc) {
>  		rpc_out->retval = return_code;
> -- 
> 2.53.0
> 
