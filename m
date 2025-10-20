Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D462DF6E6;
	Mon, 20 Oct 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944242; cv=fail; b=pkWPx2dWvKm4hKSYUKelT0ZYJuQ2HleKwAvDXlCsIFu0910wHLgJZJ6aFzAm4RLTxC1mayEP93TOj5+nsV0VdC/LRtU0iOq/ZtuN8PslBFkf8wF2U1FEKYvxhDAT0PZfl/Sbprt9GghXfh2zd9FtIUtulQNzNXWejZSq34HJ+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944242; c=relaxed/simple;
	bh=Qa1rCz07SPqPHVihN4TcAZJkwr+bfS+aidq5QOLX8kU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZ97uSgaHwu0ASrOWpPqqCMvjCr3xseVcyEZ7Iq66GULHompYw5VNCfFm3yuTpl+GyT0BsHNGXE3Lh1iZPpvi+m6PwOPYLeVxuy8+FNC85qtB9kfQ24z2knc32cbiPU6P89arueLvqz0rnhX2AfGem6vDzFkrzR0HV1cwIMes98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXLBCecR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXLBCecR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760944240; x=1792480240;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qa1rCz07SPqPHVihN4TcAZJkwr+bfS+aidq5QOLX8kU=;
  b=JXLBCecRgQAwAQXodAsJgH4Ok1wh5JPYRoxgzioEnypn8wmqp3JR3lhk
   TWZpe7PZgQ+E/yVmvOlMBVG5l0Ho9iZWT/Z4Mu2caMffwm5Bm+bCpkRUV
   7jtafJwQZ2ORw7D/hs9Zvbbosks8q/Ky7aTr+u5fMebqLd5Z+n9MINDEm
   OY9LFwyAutcTzYnEpeVh4pBpqeDL0Uu9i+o5DlJD3N27wKKJRBbpHQ62H
   8LYe0tMYbq9s9wvKKORpJD75CMGiMOvft5jhQkuHyUd3GHUU2NoGv8YcC
   c6EDLXsY17EI9S4O9IF7xJLSBqgJkD9oKedwhbuNFqIvSWZe0hXlNBTR1
   w==;
X-CSE-ConnectionGUID: aEjvF85BQc+ZTVBkUMew8Q==
X-CSE-MsgGUID: 8zVY8w55Q628eRYrzDel/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63203042"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63203042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 00:09:51 -0700
X-CSE-ConnectionGUID: 8R2PuUneQ4q0f+zMrd3fYg==
X-CSE-MsgGUID: 6YRNaEFSQSeOoL1raanEUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="187524702"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 00:09:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 00:09:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 00:09:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 00:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGeuKw5rMGR52D5b23a2IkY+qoQG6Jbbo2NB58M1GD1SdB78z+CzK0J/G2I9WEaxDEhNo64awtPBOK3N3JkjtxN9cj1Cs2O5ltS9VmckTbEgsLuTTKaQOJ7V/TrM2pcInRiPEy6wgk8SL0slaSZYqYma0Hw+/V2oxpDhkHAQbs34oelTgutvzlGzzVatC45ZT2YqwllR44hjkEmZKpgQxjh0qg3Ue+f8uEEodRWv6+2trheoscMroK3CYWnMEfT2eNRPMC9xX08NRcbovYVVbW90sALtOtdKXy0/xEHZm5pf63IB/4ESXaD0zWQKBgsIBEPX7giJiVeBIH+IwpvcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV2ZL1tOYMS2P6j8SbXOpk7NZUR1eZllS+F1ATgLHKc=;
 b=CxkkIcR7Xe6OwcU1vEsS1tIv8+wpP/PBbXa5jfJJ0jToTNkH5dmVTvRE7wtZRBzRBcjIDaQswhgMBE+ZQdErZJxzuGyeal0E4qzOSbZZ/kphK2WrLF2hEU0OsZXsbOGc0WFJ6NRLTj0pFci4dsxcfqP6hSvlFxrpIJK6KglvAA9ZAQSdm+k+YW6GV0RF2GQ2dVX53pVCWbB32J+ZSEraWBqxO9Ci4+aXOelc26/9tfz6IRTzJg6I9dPW5WnmxChu09ragV5K0tXhlzjgQH/5hXcpob7DQzWB9S2/LUg0t2PJaQWrD06/kAh3lwdwf3hAneq5biFh3ULU1hzOWiZ1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 07:09:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 07:09:42 +0000
Date: Mon, 20 Oct 2025 00:09:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Vishal Aslot <vaslot@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "open list:COMPUTE EXPRESS LINK (CXL)"
	<linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015024019.1189713-2-vaslot@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: a73683a6-7637-4e5f-68c5-08de0fa7a428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o0zHJoK/yuo7lLOZKEQpRNqe/jsDRloixTeRUde+ihbRSChQQLbEDjiveqcB?=
 =?us-ascii?Q?klj0TQoLCNGB+1fNZsHUL1XJ6SS/p5xhaQYo9oojQH0dpYExFRjX1+g7qThC?=
 =?us-ascii?Q?DGTmPwf7801xNOX2OrogNUSebOvNrurtuQSGRyPt6sFG+bBD607+Mcaz3XMl?=
 =?us-ascii?Q?w8G4QhI3+1pZUNle/lniCpaGN+qZZWj9jX6QnZABWo0yInxg9nOvbvpU3Yew?=
 =?us-ascii?Q?2m53HVDoc+xFfwz2TFtAaam6Hzrh9jFJNWCtnMhGclVMWmKkiWh78t3MzO5I?=
 =?us-ascii?Q?FgvOhltlprXGth8+gbsdIkQJi3KMazH4RrdM3L5a3dab48asCxm9VJgaEX6v?=
 =?us-ascii?Q?2UH/Ylh3h73f8qvvyXbTaRzfTDH9gxHQ4S1lvbfHAoQUrZUAfObsWylGDmbD?=
 =?us-ascii?Q?1cZ4nrKZKT4zQvQT5xDmfuY7/7CwFIYXa97ctCp3wBpO2KBz/zwsSIqbWW+g?=
 =?us-ascii?Q?4jJyVpsiYrRsvX0r0Iwmbc4+spot4ui62P0uWVNm0VPjNYthy9tHMuxDKjMY?=
 =?us-ascii?Q?9bcBmU9qPLcxNgH2bkxfu5MV/qwNJPWmFSn/2IwVdNvYrSo6pSNjqQS0g4eu?=
 =?us-ascii?Q?4/GZFOPK2KMEljU6IYcldCJQ/jqUg4NTXL16wOhcPZKoMLI3Cv77J/3s//ex?=
 =?us-ascii?Q?fNtoMb7pr6UW75ioYc8Unvcwd00d8m+41PGZrkEvNxg/BQCw3QarPx7fJFxL?=
 =?us-ascii?Q?H9iDX8V5+yCf9V8zhGFHY1X9++4oF4BQN8+6rEN06ed86840JM8XnX0wu9Ec?=
 =?us-ascii?Q?qY5JJzKfde1MJmS38Tiiiq1ufRLptrCTUE/XSGGB78WOrQjBWWmd/u4mS/Ly?=
 =?us-ascii?Q?MeYSAyc7xHkvvboFuw2enUEvHv4xukhJOdqrecVmV3fuOV/AVrizkLSHzj8J?=
 =?us-ascii?Q?SfdP2wHZKH7Fn1jA2gNGKv61OB1tR3E7PXUvp+MVf9R8BeW1Y2ZOfkObtPke?=
 =?us-ascii?Q?fYNE8ofT2HCbE93+owQZhxM83OFZGiFcTk4hyQ5Z0hwhUXHMkcoyhGagZUew?=
 =?us-ascii?Q?COljgyYW2ySuaq76pasnvepTjx/toI+1N5YPSnQplrXLZ6UWpRTdwceVgFoc?=
 =?us-ascii?Q?AHyC6RM/x7aqNn6Xz6dj8N9Nxy9ixzHAZtXFul6nZfemfqBr3Ac+yjhV3FvB?=
 =?us-ascii?Q?3KxMBrB5ybcaBh/nVx/Q5WKBEns3aM4TFkoK+JLVeCgEoniqrt4VcMc4OPfQ?=
 =?us-ascii?Q?dDv86Cr6itFCHnFCZZ9J2PIgU0MDUZcWp53CcfVisK8vdug34EUgGh3nDyVA?=
 =?us-ascii?Q?4g4DJLOgU4gUiIHks6H9BxRhOKEKSs9NVHY7D631+O+WY0qZ3NSohR4tzfwu?=
 =?us-ascii?Q?e/iUqmWgZLBMR9+lsg4qQByppytV6U8jH5nHc38VUf5XFHpNDhGgbyTr/XNW?=
 =?us-ascii?Q?Wli4XuvUvQGwiz7+wxLl08sco0bI9drYCz3KLPFiFccxmmexJ9C2vkq4k6FB?=
 =?us-ascii?Q?CBNYNVvPLeWdA93UZysSyXGez34ywbHl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1B27bAMGHTRr3t2y9240CnJjzvToHiapRDbOYBO0ZSSmUDF6Dkb0MwgfKZoW?=
 =?us-ascii?Q?AygFyqDOOLB7JJIvSJmezgWXXFhd8YwzyHy77xeRR+5EEokmQWBGEv/6cFHM?=
 =?us-ascii?Q?v0noFb1Jn07Cp9zrBmFnW6cjS3ru+mm3u2W8XIo3e1uGlvS0RiO1mmCngm+7?=
 =?us-ascii?Q?rW/+suPz1wzxW4GCKtWYBFl/QvtjuEpZ82MoxAPEaW7Czq1JrPW5/2UvoqmJ?=
 =?us-ascii?Q?f8ReCJckjBb+/tA5uRRF5bprqpaFPK/4QkMxTlyep3q6+/CghUg8FJmHNbpJ?=
 =?us-ascii?Q?E26iDsSXyztRMsBBFcy2rm7LAS3zxP4NnQo21A5Lvt/mvxQb/YmOLFM7Kyca?=
 =?us-ascii?Q?5y49gI9nqd1lwzC9oyOyJsZiah8BKrL2eyH90AIeoxi1gL4z88DItAfoVp+r?=
 =?us-ascii?Q?SkkXxCu6ibttrwhYun9KlAcCH6VZOOOmhab8tCvnvo15Z6Wnnvyei0sH81UG?=
 =?us-ascii?Q?KNopCPQRkai6imqS7KRL0WbmeoqhvGi6l/5D0ekZMxBC+BkNyRWJq2oUhOCb?=
 =?us-ascii?Q?DR9s+2awEbB770MZCOF+k5TnNMozfdCbQsdu21kh0lYie3ajNakgnGpyBvwL?=
 =?us-ascii?Q?wAVmx0K8tMval3w3iQlYM9VCPq/IUqdtIvA7egaTCAOD5IJscE1jwDVDgVD8?=
 =?us-ascii?Q?CZZLVtQaz74tg7Sa0O3LPThH0WmXOcFZSoHAonVTeJiZwt3bdEvOju0Srd5e?=
 =?us-ascii?Q?qcPXlFz3fHfbzgPpLthfx3pJOfB6TG60V4l0NHAnW+rcCGHOzVg+pmKv4VWY?=
 =?us-ascii?Q?ZezfHq9Ouo0MmkZf3oDWNee1tQl9lToiCGQIjS+MLw4iPT8aMzqocQ6dGIUQ?=
 =?us-ascii?Q?VzkcGmIcDmGu+VLV1GdCjYl2xzcM7UBx9s/h20rmKdY5zvLCLmaxsm0g6Rui?=
 =?us-ascii?Q?c6bT8rb9YKtGh8iLuUiCwZBrMeulvHvuLYQUVkNOlt7S1MGXIyrmEv4Fq4rm?=
 =?us-ascii?Q?DMSFq7YdZ3ZWavKMCQnk9G/prT82x/iNhP/LktuE3zNHmm+XLfHghTbyw72x?=
 =?us-ascii?Q?hF+A5Lu664tfXZ1l4+f9bEZANVv6VVp2Cnb1oBYGoH+twyRPR2EZGb8CZBvY?=
 =?us-ascii?Q?GLtNRiaQGoJn4qrAjSU7vYAVRUrWo4qUl+nkm2nZXC5kY1BeGIs5dzzjkI20?=
 =?us-ascii?Q?KNnzUmd+Mzr5dUrXX7SQCVHEn9Cr8g2h4FYDViKrBUMx0dO7LEmwO0mjLCgi?=
 =?us-ascii?Q?u6XnjGITNAUaxtt9jjlKRcuFd++hlzfLuHzkHZQlP3R7tHwMimu7Wxi9ojxU?=
 =?us-ascii?Q?qwXqdX6IgUb8fmqvyWD22fNP4iNT9hcZUgXRQ4ZxQQyXpSKXOkmhNwC90Ork?=
 =?us-ascii?Q?myn5EEt/Cs4BUe2NvGM5/u92QJtBQjcONJQl1koCyrFImRW1JS8VHWMp+A/M?=
 =?us-ascii?Q?UOUlSDmFd6dz3OEVlj4dLcOEG9WCrgnBM41QDvfJSf2WvyjS9Wb1ifGHdCcV?=
 =?us-ascii?Q?laBzj8r1IOlW486800BHSnMPPeFQSxmdg9zVR5s5k7ucZQRgaOCVU9Khf2SG?=
 =?us-ascii?Q?pGkyP8fswiIflkXq+IyYXrW4Kn9ESWrm185eO9iSOw5oofcQDjVq+x6LIk7M?=
 =?us-ascii?Q?+Ngi+Y4OT8djyxgVDJY34yCWuwB/doh2L9CV3ryNNbvKxoO5HzL7j+stvREa?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a73683a6-7637-4e5f-68c5-08de0fa7a428
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 07:09:42.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8+HeyJ2PXNGBqKPAdsZDlZbvH3Wn5JjVHPdtMBM/B2O7h2P9zPFp2qPhNxPfxlb5qPKjIuM94XB7HIN/mydunUig/aOA25DuQACkuLfuWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-OriginatorOrg: intel.com

On Tue, Oct 14, 2025 at 07:40:05PM -0700, Vishal Aslot wrote:
> The cxl core in linux updated to supported committed
> decoders of zero size, because this is allowed by
> the CXL spec.

Tell more about what the spec allows?

> 
> This patch updates cxl_test to enable decoders 1 and 2
> in the host-bridge 0 port, in a switch uport under hb0,
> and the endpoints ports with size zero simulating
> committed zero sized decoders.

Decoders 1 & 2 - those are after decoder 0, the autoregion.
That's a problem ATM, when we try to teardown the autoregion we
get out of order resets. Like I asked in the other patch, if there
are rules about where these zero size decoders may appear, that
may make the solution here simpler.

Add the skip to mock_devm_enumerate_decoders() to clean up -
a bunch like this:
[   94.222456] cxl decoder0.0: unsupported mode 223426864
that were followed by construct region failures...
[   94.222456] cxl decoder0.0: unsupported mode 223426864
[   94.223790] probe of endpoint13 returned 0 after 136794 usecs
[   94.224595] cxl_mock_mem cxl_mem.6: mem3:decoder15.1: construct_region failed assign region: -22

FWIW - cxl-test mocks the init, enumerate, commit, and reset of the
decoders, so all those need to be coordinated w the 'real' driver.
That may sound like a pain and it could lead to bugs that are only
in cxl-test - but it lets us then test region creation paths.

-- Alison

