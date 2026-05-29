Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC033E0C46;
	Fri, 29 May 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068334; cv=fail; b=EyIwqcXdmJV3Y8UNxi/ctrmlvApv62NLbGysAWSMtp4tbbNvORrMVuBkwM3VSZ2kGUIxdUUSe1OvtIW3V+7jhA3IXWAE2VrGcX/28LSWNA0jzzxWfCjgfDZQWBz45Ca4I3JkbaQvYrHQxa8OqugxX3ndchn2O6P4exbPlaiCz9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068334; c=relaxed/simple;
	bh=3ja3/9qZ51yW4fPV6NBvd4o6NnA1AEkiLO2W2cosxJM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lOO18YtPFQvIsy+C3vnJD4K0jyY36HPNRJXhFP5btAAW7T9aAh1nsySa323cGJkTsL4I4ot3N6EjLU41nkONHjPhIv1Q6bNncNLDupZAcDP3wZetMbx9HcdhTyRotRy7hN99B7sTd4RUv98mDUN0iiUfwx9I+am8umsKnkyhfFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqwqSoOn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqwqSoOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780068332; x=1811604332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3ja3/9qZ51yW4fPV6NBvd4o6NnA1AEkiLO2W2cosxJM=;
  b=nqwqSoOn2SEfixs3UIjrKrt33908SeeSVZqOEf3wZOf816bnCFE3hT/S
   owjo5QxK7HVJSFsDOe+SoQziIlyotIZR6SsM/tchg+SID4jj+mva6FURz
   ctgfe8IQHSeTuGTKDZO1+Q3yt+saZT976NhHwCTEuk3SfrXLepRVb65n+
   8yZOn8hvOoonf2p6E+zoPEqtPo3Tf4+MExXuGTPPn+9juKCEh6/ED2D5j
   hr5LToBpk0PzVVAcGkbwBelzM4Ncu71YxsG6Sn0SswKJnqaVnZLKhSe6c
   oxwE1/pBDZzAajtqpxUCgIhSKPvsPoKNfQ6fM5dKAnRx4q14lvkxGotts
   g==;
X-CSE-ConnectionGUID: PLoOg1MBS+WIhigp+2w8Qg==
X-CSE-MsgGUID: moiWA1CBQ0SqQvV/Uj9juw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="81036294"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81036294"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:25:31 -0700
X-CSE-ConnectionGUID: Sqscb8WvRt68w4Agsy5PMA==
X-CSE-MsgGUID: igfWZinvTKmeE/r+VjZgPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246889439"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 08:25:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:25:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 08:25:30 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0P+02Q/rdU1jQELrHzd4btjSTRPhFZz5g3FQlj1flDmag4JtUxbsavLvCWcac/9WgcQSunQFch9iw45SJNRlBKat3CyGm34gWK3tuYRCYBN7lI+Z6Fi2QRDT98xF1I0F05bVxZZsMLptc93/JcBhnmjEPnRAFA8qeGEYUQccLTLnNS78y/W9FmS3L6BXbFgqtnN9Cj+3yPNRpKFYoQ/1KgVznx+xkGCt8WXqXZRL3FDgvu190KN/dSSmEaesBWjmK8Vg89DBu0Hjpff9E/77gJq9Ffmn+wwVUZ66TNXg85gVKpJY6dsRVQoddznfPUxBMo1YZ6LR0AzP+xS2aaY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i2tjORDKmN9nBRSyd+uHK8sFajTCxx8QngLWR70OWg=;
 b=VerH1xrNrDmpnKhCd481zi7KKg3r71fsI1T04hPJOVPvXvsCG7exEzNan4eus1go5HHO0qaKXETZltiOyewuxy7EH+qGMGDN+RsZJGkWQtYMlaQlODP/zfDdIBOA/8IblNL0XXfy/KHd7ZIOZX/E4Gk6aE2jYqR38lvVMyzwXTKicLNziLv+TiznM0z+63xKC/9QkS8pcKOQC+xpy2kSWXkFexadW9JF3OAY6HkS2/W41NMfErE0NUQmP4WfjPKUCqpE28R7FHfwGko3XzMFclwr3VOM9d8vJXMW3NBbpp3Up/feM9JW7rYapjfRDQc2YRCDc7GW7oAxPQ1IdAHnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 15:25:27 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 15:25:27 +0000
Date: Fri, 29 May 2026 08:25:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] cxl/region: Fix out-of-bounds access in
 cxl_cancel_auto_attach()
Message-ID: <ahmv41kf-g9Yk2pu@aschofie-mobl2.lan>
References: <20260529132533.1144383-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529132533.1144383-1-ming.li@zohomail.com>
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 84adf38f-cee1-4d15-b004-08debd9682f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: DCX51hhH7T2OZnb7NvajMa9DzNwPojwy10dj6hKLAV9opYLVhq1eA3NRbkD7TLuiUujuDoe18sbLCnefREerIHyNKT1/zQ7ncNILiejDzR3gspntBQnj61BpZpRfytvWo5wZEHtun4mQK70Y78lifMMt7onychs/687YXbCOT20PKIfVplebgbkz5/liJa5j45O8Satwrr+FXElM24dqkJMdHtiHdif5Z0rXKP77XWn+FcmX5Nm+7CGfKhuKjYs/rdqLy1rV/d5mNs2bbdn1nMXyxkx6arAoZbXEyqFGkRJo6GkctK6n7AvJ0Hfsv2fopOJuSNr23/grFv2mizuj1IyEXOTwRSX0ESr7ZTrf4l9BLcIwceR9UF9+gtZ++L3fmpknNTKd82mijYj77SChSxfB291/4H4BKfmbpta2nTWiHkb4aBAL/ZxhosWrZCX6vO18EQ2JjRSvRlIttc9EX9Utt0oUwYXwcHREvlsnZWiKFZsGhIREVTQgBtgfGA2S/hzfooLYaJg0QzLVWhY51yPNXxi9jShen8oPAiQ0ubFGBPzd61XN+ESfdgKM7JuM+9eIKE1UN/c79SagHE7BMof40VxVBZYj9rJu0YlIuMiW1tTu3ephfGzDRJtyQqj8ZpXoYPYdw33jfJgo8Z9M8c8vBHBOSUPk+CMKtYD6mR+tU22eyHqdGlhnV2R+MY4B0mohnLHc6E5b2U7oFDkC0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jfogH1ASJrQx9LgSSDQEEAl4bzw0f6uLNoj/s/1cTIJaBpb0Q2FwmvTgvSAq?=
 =?us-ascii?Q?CZSGhqwPPEf1Dw0sQ8UyUMddDmON7VW8SqxV3ymVe2bpCJnPqCGh0AaMgdbn?=
 =?us-ascii?Q?bNxDOLr8Q6aPHQ53Bw7eK+l0AmFOGBaKsqROc2SEuTP6/DCgOTBmJRFH8bDD?=
 =?us-ascii?Q?1OlWnoYA/d21doGOiB2FOEE10VGNIRddypjDl7lh+qGwFyw4+eGgsptDm0SM?=
 =?us-ascii?Q?9riE60Rk0SNUBhNFoki86Tqgl0TU1/TwhH6TloMMz0i7PRAgSqh4Lyz5e0mC?=
 =?us-ascii?Q?UFG6g3rabezXhD6ULOOLyE8fextckuVBzsMav83obC810V+vdt+yKq0qvvOn?=
 =?us-ascii?Q?K60jM/jylP/Te7/5m/EFvMUBIDYvkesJ0jnW2enLt12BHTVuYxlZhbU7C/qh?=
 =?us-ascii?Q?begzIpbCWwpcKQsxS/zD++CWUg4ffexexI3pm/5Avnm05LfRFSRad3fGV+OU?=
 =?us-ascii?Q?y6guLeFbrG5Mgcd0gw54rhqnOP8Q757Fo9DgxDAdJt7q3srhgojdwFDzO72Q?=
 =?us-ascii?Q?KaVz4JVnzXcRqjV1E43fuOXMRzSFFmBmwOXRkMkf2bz7VHqeKso+xpJp3ayz?=
 =?us-ascii?Q?nVQEJerS8Q9ST6pfqP1UkvFt+014vqp81zz6QzxxynTyx8h6uXlgKZAVG1a2?=
 =?us-ascii?Q?Wiv4MK2kBuEbjjezOQjFRbiRKwDbavjyPcEQ8sCgKPKUO8LU+i7OFrWP/0J+?=
 =?us-ascii?Q?fEDZk4dvqW+DKtylo3GvOrHZ16ps3cg60SePzUPSVwLIw3gD/Q1IYaGExwuE?=
 =?us-ascii?Q?GPIU0IiunWGJ1h+j3ulk+utz2TD7P5gko61QsW82lwhbqKXUN0Lqtc954Fm5?=
 =?us-ascii?Q?6wE36gUlSLqG+SiG7cOOA2S0PcX2SRz7VlLxEg0qQcSVp2er6GN8zp/ZYWwx?=
 =?us-ascii?Q?zZX7JTuBXKZcSy2zByFYfJXAeynET2R9l0xncP2MwbgLOyHP6Iz6JCHQv1Fv?=
 =?us-ascii?Q?Fp0X7JBb2kr0aOriBTyC2OjY/YVV4Jdfdv+40S8Rt3pEUmxt3q5f+hx41Rcv?=
 =?us-ascii?Q?QSoJP0VG+U04lMqtAy+mczBEqq9slaZ0dQZUYZueQDUZQ2YXZIuaDWlqnQHQ?=
 =?us-ascii?Q?qguWV/KzHenl12Vjej8OBOdjmhcRvVjLv9FYNt2/PGbmQmKUKGEKShkV4wds?=
 =?us-ascii?Q?4CaGTA18vRItN6S9k/U/EXW1ja65E98XMSumTfMkC/tKcwNSM2MO3jyBIiol?=
 =?us-ascii?Q?hBZOMKBcpFvUQa0GH90nAuNlsW3wLFYpvN2vLlS0297jEVKu5FHgCckff1Qo?=
 =?us-ascii?Q?vnGlnMpcwsB4z3UX3jPQfeyNvU60L4xfrhL90+LQANos/1HOqNB55FIuV/HV?=
 =?us-ascii?Q?hq8y1X/pkgqKm2nHYZhl10L7onRb0dJCpKJRBC2q3amPuNEkI7Wh4Sy2tEYU?=
 =?us-ascii?Q?suhQZ9iYjUGlM9jMaq4xMUzkuwj3e5gSSsu8MrazDvqWqXJPSlztv3sCK/Qz?=
 =?us-ascii?Q?qZcTrwMEpAhp01WWT34/NPxFE5PUKFtPmQ3gVthStj0vAkCVB5DNVX7GsSMA?=
 =?us-ascii?Q?Kifps2szPUm6H7dxd515asgKWCT6+uJHiDnwqRreQVoRRmeruy4NAZciPrc8?=
 =?us-ascii?Q?V7xB5ifEkla6miHL0cIKAEg0oYdXqhvhdit3wUAEAEpx47BSlBPsQLYdrXTh?=
 =?us-ascii?Q?8/AIsyZlEu4AKueSkaxWHvcY28q1BLoh/OCBN7qesMBlvRgcmDZm3bh0A/nX?=
 =?us-ascii?Q?dHcIrnrnbIVXR3gkWNphiWuWgcGTQHcAkQWT6HOH+tbqn619BqTtJ+9X+FK1?=
 =?us-ascii?Q?MC4QTHS5jRflifKc8Fu+ftZp0kHXdX0=3D?=
X-Exchange-RoutingPolicyChecked: Wt6HCbtIqUHo9HWU7FCbVMAOlI/IIRiSd5q1M+aqaAndBsS3A85w1vO/rswmwmIxtW5FvKxo6XEyR3Qt4OrZCg6iB42W7ARcRK7KWJosV06vwLmB01IGjXbQGBFDVaLuEzYnlCsNwDtLK9TEkW6vf1zM4g8qJRd0easeUqMYhw9jAHK0vw8oYT+ltKlKiGxmrISXRvKSljo5SPGS/FoPGI/4jUieu4Km5/eOW+NFHgiRzQ5CllN072E4+HiexTMSuTGp83hQmOTc/N3W5YPtu+gGG9FG4BoJ3s00p/Iww8Dx5Ad4dGXRZ3yDnH3Wrhu88/Y8BqAKRvAWOtvjg00r+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 84adf38f-cee1-4d15-b004-08debd9682f1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:25:27.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioCCwPl+dqnSVBpPWIQa/5DAh1HwRlZgWS3Mkn9QlEIXk0oKmvfW2hc4rYdLUnpTFIy7Coge3jRX7w3/G3vi3Un1e55ZNJlVwvL7g9S/pqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com

On Fri, May 29, 2026 at 09:25:33PM +0800, Li Ming wrote:
> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
> accessing p->targets[]. However, cxled->pos can be set to negative errno
> in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
> causes the driver to use a negative index to access p->targets[],
> resulting in out-of-bounds access.
> 
> Fix it by walking p->targets[] instead of using cxled->pos directly.
> 
> Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
> Signed-off-by: Li Ming <ming.li@zohomail.com>


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
> Changes from v2:
> - Revert "Fix potential 'hole' issue." changes. (Alison)
> 
> Changes from v1:
> - Update commit log. (Dave)
> - Update comment in cxl_region_sort_targets(). (Dave)
> - Fix potential 'hole' issue. (Alison & Sashiko review)
> ---
>  drivers/cxl/core/region.c | 40 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..eb96cb3cae83 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2011,8 +2011,9 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
> -		 * cxled->pos so that follow-on code paths can reliably
> -		 * do p->targets[cxled->pos] to self-reference their entry.
> +		 * cxled->pos so that cxl_calc_interleave_pos() emits its
> +		 * dev_dbg() for every member. which is useful for auto
> +		 * discovery debug.
>  		 */
>  		if (cxled->pos < 0)
>  			rc = -ENXIO;
> @@ -2202,18 +2203,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -static int cxl_region_by_target(struct device *dev, const void *data)
> +static int cxl_region_remove_target(struct device *dev, void *data)
>  {
> -	const struct cxl_endpoint_decoder *cxled = data;
> +	struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> +	int i;
>  
>  	if (!is_cxl_region(dev))
>  		return 0;
>  
>  	cxlr = to_cxl_region(dev);
>  	p = &cxlr->params;
> -	return p->targets[cxled->pos] == cxled;
> +	for (i = 0; i < p->nr_targets; i++) {
> +		if (p->targets[i] == cxled) {
> +			p->nr_targets--;
> +			cxled->state = CXL_DECODER_STATE_AUTO;
> +			cxled->pos = -1;
> +			p->targets[i] = NULL;
> +
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  /*
> @@ -2222,25 +2235,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
>   */
>  static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_region_params *p;
> -	struct cxl_region *cxlr;
> -	int pos = cxled->pos;
> -
>  	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
>  		return;
>  
> -	struct device *dev __free(put_device) =
> -		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
> -	if (!dev)
> -		return;
> -
> -	cxlr = to_cxl_region(dev);
> -	p = &cxlr->params;
> -
> -	p->nr_targets--;
> -	cxled->state = CXL_DECODER_STATE_AUTO;
> -	cxled->pos = -1;
> -	p->targets[pos] = NULL;
> +	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
>  }
>  
>  static struct cxl_region *
> -- 
> 2.43.0
> 
