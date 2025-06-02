Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67742A8F;
	Mon,  2 Jun 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882913; cv=fail; b=u6mKj5IyEgbV53wnu7qunrM1xjD5xsuLZxaPllN311s8rGhXzVNs9IoxhpYBFpZy31yZ0kr5vsJQnTHPPblHOAVkV6zZB4li7JinXzZpiCxXLPuxVCKX9xL3brH8h1eLuQGN4bG4QMN1plSZZ3kfc5RKgHb5M4m7yivARC4ZQqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882913; c=relaxed/simple;
	bh=aFexKLzHeqEqDICHSu/ufWf4p0/IRAXrNbCG7PCdn0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OJnYp5yVQ1i/gCVG05uB9GRQzamaxJPTz4KPvO6xb9hjw6wYsmCKxn4OABloHLB20so/jEDymg+krq7ril8jMsS7hogZXG6d4JCraUqYHG5kciDZndNjJO0i5d0k3Cjq+k1z7OFXBeX+bt3GIH11r76iWuqunSXixyBIn/EnG38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtujNv9N; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtujNv9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748882912; x=1780418912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aFexKLzHeqEqDICHSu/ufWf4p0/IRAXrNbCG7PCdn0o=;
  b=YtujNv9NZ9q17WHASs+20snWGe5OJ0nk2kG/WM0wPc8giTefoN6YYal8
   r6QCtybLFI9wj7BDFJRxDP1/NKPqDOLVIZryfySy1sZMLouvk9fwOOHgv
   HQmsxz4TteY1qAgGQ3fJeJTk4jHM/dlckyL37OMyMX9adJg1Dfi3YkT7s
   SY4p3S6XWG0S+kznF7DLhBiApg+rFVsPUjr7eCrTOGC8TQrqmhsdOR2UE
   ttFF+/nvsC1V0qdSnKIIq2mWxnWIHlES9ZtIYdN0sU197Xo/Gg1Xfiyl5
   5nvtXCgsJ27no67OuGw5TR9obWf9pkUVpAbQZAUZXMXw2NCh44179wTHq
   A==;
X-CSE-ConnectionGUID: ptS0GBNZTVyof4kTc4uN5w==
X-CSE-MsgGUID: l4A2iOe7RGSxjAA87ZsUgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61514472"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="61514472"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 09:48:31 -0700
X-CSE-ConnectionGUID: KpDLG5saT0CMLxJX9peDag==
X-CSE-MsgGUID: mbqU+FgZTjqOOvuS+uvKUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="145542005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 09:48:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 09:48:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 09:48:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 09:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1gXi3t3K3CA2UjUbYOCEiAJj6xZAHHRXFT/HV+DfW1C0UWnvIySNX8YX6N1dp6DU7b1hnxRYoHF6U4Yh/l9BmnU4hnl/iSNWtdrzS9GyYbrAq3Dll/yBijluIgHXu/vAtOLoL5rYW0lEViRYnErqu2ukSbnLQ+LgT+k3SryheKrfJkOXmfGbluryXD9izXZZYGiSW/kCp/TKXbOFKr7vAPSGS0UBHQfcrVNBHCL8uXuQ56LpX/xviJ+KRrK5zG1zgfR9kmFqXIWw++xDQ4SouMtqMUQZX8FRgQvgSRXA23dtnQ3BsulL72RF+LWHSS2vnDI1AlFuWKix/8M0fjIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKlHbeulXuPR/SBgxkal2GEWchYelxMFxB1W66s1xV8=;
 b=eyYERyLjPjnWjBmXde0J97wgGAPPSTPVvvVtWhsgp75NkxwfFNjoui0Nfpg6hV4a4OB9tY27sg9dViINpcUbn3seiQbBKoNUoPoOAZQEtug0xuSGRbKcS38p46tWhKdV7RwpvY4xUAjv25+w3d3L1o3xb3gICY7OoIoR33hhRNer9106VeV02Xcyd0lRD9W/gnsLrjVakfxIJj1GGA6kHsiY0du6rya8LkUuPsX+IMNdjSxxNwUMH0zzBDlbEfswxkWEH9LyGidWisEufriTIFgq3B+AQqDDNZewpgM8UT/9UgGkAzf29Zj6TDWuiiAVqEYL4DzfV7kTB/vKu1Dn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by PH3PPFD114713BA.namprd11.prod.outlook.com (2603:10b6:518:1::d50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Mon, 2 Jun
 2025 16:48:28 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%3]) with mapi id 15.20.8769.031; Mon, 2 Jun 2025
 16:48:28 +0000
Date: Mon, 2 Jun 2025 09:48:20 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>
CC: Li Ming <ming.li@zohomail.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Message-ID: <aD3V1MbVV7RZmbu0@aschofie-mobl2.lan>
References: <20250530122852.10139-1-ming.li@zohomail.com>
 <aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
 <bba0fc4616d54babb2b0113967acc95f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bba0fc4616d54babb2b0113967acc95f@huawei.com>
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|PH3PPFD114713BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a1f996-8d5d-4b1b-7c22-08dda1f54c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?diuQ1s+Mf9m2pEcNH6sWxQJXWu0WToFE1QzHNIlP/OOzV7nIOHkIznLSvnML?=
 =?us-ascii?Q?yJVKt1uJPMwgzefLtjItMweR0XlI5GV5kPF4BaBRQMp+mRZ+JltIOBPlQFcs?=
 =?us-ascii?Q?MzuH0QVf4BLTkXoHlUTtMQ2enRgHAB+V3zC7r2wPgG+s70hjahE1ZuEJsf1u?=
 =?us-ascii?Q?MyVQb423u9IKMoZeQzXgmtFXL/szV7U3L1J6Dsg9gspwbr/QwQ3wokmOXNmr?=
 =?us-ascii?Q?6KsoPUpSG5RRE5TN3cOY5ZN9ZhMdjvKPa3uxSRp+QJ8Unt0kJm5Cy9ZOYXRy?=
 =?us-ascii?Q?pEe0dl/9ggiZikUj++gFi76YXjudt1FlB77ATkfNWnBjE6XN21YWu4qPvpCM?=
 =?us-ascii?Q?KmdisFrHYn8DizaHCkOqXVMyvw0jOeLFHY1sHBs3Qax+GV7Z+urokbEZZj+i?=
 =?us-ascii?Q?QPhJGPrKcshJkET1Ke44ZRLdvs1y0rNUyVd3qNkO0CzezZt4At/wRxEm9KvD?=
 =?us-ascii?Q?VTvFOFmlHvYHvjddCoB3Pak9pHVygjhAGJABadXn3qI0ZQeKLv5S5R9qQCXe?=
 =?us-ascii?Q?NmpNDYnyWmHDsIUQ4l8pBptQIez4UXhkSu9h+oPS0QBaeg9eimqqWjylWMZJ?=
 =?us-ascii?Q?KxrbqveprOvM8NqN2xAV5RLxzxG8csVHPUw//1bgdJw6nRN0rDfasRaWSPck?=
 =?us-ascii?Q?egOifnSa++UsBu7AbzVtP4TmOUt27yHIRpzqM6jeoUDpC9Nf36mvcTsYzrkk?=
 =?us-ascii?Q?GuaTObFQgJPw03ZJcIm0T1QDNWp68eYLd7jZV4EXyG3AufCzCQOSKD1yqzGZ?=
 =?us-ascii?Q?mYqlMfvMGDVKO/mQPTOTV7ceF1QgivtxM6uMV4ccHCnDtXRUXb43H2hhrfRb?=
 =?us-ascii?Q?xsOThrGHwn6qJR6RX50WW29snmFxRnYJwEdgB0Xc6OtiXQQROKCbsGQGA7Eh?=
 =?us-ascii?Q?LAdrlUE8UsfVoEJKA819F8mq/nTdhmvgnvrMQcOHtmKtOOgPwcRaQ44ewrHy?=
 =?us-ascii?Q?cRu/Ej+oYfXy7+iZDNuNRZAT+pAboBV6X0y2sBd3vnR8eazW461AqElFSzWD?=
 =?us-ascii?Q?tcQHaknVpzQupDsNiS+FzMveptk99SCi4FHhodQCplEZbvaHG/cFxL6qUWNy?=
 =?us-ascii?Q?+L6xv092gV9GYjRTqwQ4B+fvMsTpZNOyNMuxSeQH4Z6knLyZ6znXuFkgSQAD?=
 =?us-ascii?Q?6qOaVmQCYXfqqa3s67nKl+MtSaXw28pusNwdX7AF9oZiAktHzMTd9zT9Rafc?=
 =?us-ascii?Q?KVkuLbLwotoJm0hfP06jQai1N23/hYZ4Fwn8VDrbR9xQjrKbXpDKLGEO8Xnw?=
 =?us-ascii?Q?Fc2CnsT7yjlZ9BdC1Nmts3ekSLAop0EAM9LQlRDMyVrjyE0R5zKsgYDzPMQt?=
 =?us-ascii?Q?0Zv6ZjhdrM6yBfeB5gNJCjQURUBn1xPvhisuEnBhv5Lh11bReBWBHQBG5ziV?=
 =?us-ascii?Q?UUC5UWtcwaXEpFNOK9NUXofY6hShuNIfKiUGzJBVMfloWUm8G4KJbqibO7dC?=
 =?us-ascii?Q?wQLmG0on1ao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rHcFRpiu11Fw3MYN9E0RjNt8OQ6gE5jKRYx4GtpGAlh30rX+Z+tj9pHnxI7H?=
 =?us-ascii?Q?RIwxz821d8YnCMVT0bdSIKkz4yd6Ducz8TUSNLgN0p2Mk7dCzfYcu24E0Ilk?=
 =?us-ascii?Q?RQbVGToDcGdD5ehm0PpjszsMzW4FwSomYJotQCodtIEUnYYJwo9wBXO3NbGG?=
 =?us-ascii?Q?oMKAzSWgvZMVRDSskN4QI8ryvQHDsMP/QcOi0svz/Xso5b1JoHRdxRjC0DaK?=
 =?us-ascii?Q?TdVtIjXb9wlRM/kowjFNUFRD7rkuV+F500hef9zQtO8fvA6dsZME9FsXV8k3?=
 =?us-ascii?Q?Pj/DKP8vxxwstysXoPa0H85Y/WTXkuEM6YYq5mfD7Z8q8JjSXX6QGeCloxXr?=
 =?us-ascii?Q?lruMivbWeIZihXGdYN5NP+a0rn2jaPcgb3xJOxqKoz1auALZLupM+tI4LRxU?=
 =?us-ascii?Q?vf3VIxbG6y/IrES5BhXAenogiNAoub4dfaEUmQgypIc7P+/cNvJ0OP9HMJAy?=
 =?us-ascii?Q?769WkyuIFhJfwrJdisYbBpcDEJI3ycx3qr9uxd8B3sfZwHcEYMrozb5KCEyw?=
 =?us-ascii?Q?S7lrTzqxP/qPNsLC84EoCXuMqNRUj5m/G5gLaivmgUzAL4iIRhxXbYpLJ6M4?=
 =?us-ascii?Q?hFilAQl1ipH+nF1RVPH79DX699buMfA9Dga6Ahw1XyuSd0asZcuXp8Zxt3BS?=
 =?us-ascii?Q?WcfMaX7D8MrNK9JmYOfOsHCmgTSbWKd8QFcgTJHQHSjn1R9Qw7B2SH6FiZyo?=
 =?us-ascii?Q?6WxT4JF6V2lPSBleT7y0i5s7EVrxU5HiDzBwqaAw6zwodGni1X0zH7HzRCMW?=
 =?us-ascii?Q?jgxAXdK4uuQSFWNzoucNjCc/DQaZDBsrejPsYkirDP/zbXPvEwjonn5SRrBI?=
 =?us-ascii?Q?QeeloRAtad+S3msxxklhAG0bXbZz/85ZP6kIxynU9h6J9EiOUg+ExwIq6aFI?=
 =?us-ascii?Q?SlbJata+v9TTlsgakXbs7N1oe9ylF1NtTAtULOvNIhCntzGB+7X6/q84gDvK?=
 =?us-ascii?Q?zvbDBNjb00Ca/JZLAIjl/1naCTDW1X/UvWFTF+l6++mNoSr1WqZzgiS3Y4jT?=
 =?us-ascii?Q?juFtdCx9QyIwf9MEvA0yxn2FBHOmkYppkgOygWNwp1g6fV/rySnUKX0CW4t9?=
 =?us-ascii?Q?71PvDCQZ5+C/jmMV59yTXkP6i5ckIQCQShocqTihxhmdKDmqG7m8U4u9t+tV?=
 =?us-ascii?Q?sUUNMhEcjDNVlXuZoScAZTBA95k4l6e8auPduT/OpNvw9UxMQ6XqDWonpOGi?=
 =?us-ascii?Q?1nv90m/ISJ+egUiw8dfbdEki9ER0yx5TMBfUglT+AE9Yf1PZih1222kBrvJ3?=
 =?us-ascii?Q?kDBhWDDPs1bbBhq+/XcKZ3vpfEvMKFk6cMJryptLAsL0mUttOV3xgbUzXw4Z?=
 =?us-ascii?Q?8yL+ZVLfrEgnFQgdv1ZNrzAgdExnhbGXvkSyVO/pYb8RXr7PQ3B4YahcWSL6?=
 =?us-ascii?Q?E5NkZTNQHP9rqz7BKZkWq9GYEfdXkWTKyHYA1Z+c+nH62tAw4g2d7f1xKY6X?=
 =?us-ascii?Q?C837O1+0IREUNvu+q9fLQiZCoaMNTw/DTT6rPnfXazZorIR6eEpQqLmA0lem?=
 =?us-ascii?Q?g3GO6nfvSWX0Nn9+P+IBIwtc6Oe3DyrtsTdmAZP2g9V/VFaUzk9JPP4zUhjN?=
 =?us-ascii?Q?LHbUV5SgLVvyRDY3mFy6ECcboBSD61rWgtncYfGCp2f9IrG22Po4Fx85CJXS?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a1f996-8d5d-4b1b-7c22-08dda1f54c99
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 16:48:28.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzYKhcQ2QhegMUe1UZEcnTJhn0zIBDx0EwDN9rvY8kAXnUWH1Hj2aFmXK8uRQweA+/VcnYpLjyUKMIjJkV7kVKY5PSHcuo7Hh9PYgmVDDZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD114713BA
X-OriginatorOrg: intel.com

On Mon, Jun 02, 2025 at 08:23:34AM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Alison Schofield <alison.schofield@intel.com>
> >Sent: 30 May 2025 19:28
> >To: Li Ming <ming.li@zohomail.com>
> >Cc: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
> >dave.jiang@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
> >dan.j.williams@intel.com; Shiju Jose <shiju.jose@huawei.com>; linux-
> >cxl@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
> >miscalculation
> >
> >On Fri, May 30, 2025 at 08:28:52PM +0800, Li Ming wrote:
> >> When trying to update the scrub_cycle value of a cxl region, which
> >> means updating the scrub_cycle value of each memdev under a cxl
> >> region. cxl driver needs to guarantee the new scrub_cycle value is
> >> greater than the min_scrub_cycle value of a memdev, otherwise the
> >> updating operation will fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).
> >>
> >> Current implementation logic of getting the min_scrub_cycle value of a
> >> cxl region is that getting the min_scrub_cycle value of each memdevs
> >> under the cxl region, then using the minimum min_scrub_cycle value as
> >> the region's min_scrub_cycle. Checking if the new scrub_cycle value is
> >> greater than this value. If yes, updating the new scrub_cycle value to
> >> each memdevs. The issue is that the new scrub_cycle value is possibly
> >> greater than the minimum min_scrub_cycle value of all memdevs but less
> >> than the maximum min_scrub_cycle value of all memdevs if memdevs have
> >> a different min_scrub_cycle value. The updating operation will always
> >> fail on these memdevs which have a greater min_scrub_cycle than the
> >> new scrub_cycle.
> >>
> >> The correct implementation logic is to get the maximum value of these
> >> memdevs' min_scrub_cycle, check if the new scrub_cycle value is
> >> greater than the value. If yes, the new scrub_cycle value is fit for the region.
> >>
> >> The change also impacts the result of
> >> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
> >> minimum min_scrub_cycle value among all memdevs under the region
> >> before the change. The interface will return the maximum
> >> min_scrub_cycle value among all memdevs under the region with the change.
> >>
> >> Signed-off-by: Li Ming <ming.li@zohomail.com>
> >> ---
> >> I made this change based on my understanding on the SPEC and current
> >> CXL EDAC code, but I am not sure if it is a bug or it is designed this way.
> >
> >The attribute is defined to show (per Documentation/ABI/testing/sysfs-edac-
> >scrub)
> >   "Supported minimum scrub cycle duration in seconds by the memory
> >scrubber."
> >
> >Your fix, making the min the max of the mins, looks needed.
> >
> >I took a look at the max attribute. If the min is the max on the mins, then the
> >max should be the max of the maxes. But, not true. We do this:
> >
> >instead: *max = U8_MAX * 3600; /* Max set by register size */
> >
> >The comment isn't helping me, esp since the sysfs description doesn't explain
> >that we are using a constant max.
> CXL spec r3.2 Table 8-222. Device Patrol Scrub Control Feature Readable Attributes
> does not define a field for "max scrub cycle supported".  Thus for max scrub 
> cycle, returning max value of (U8_MAX) of patrol scrub cycle field. 

Understand that now, thanks. I'm still wondering if both these deserve
more explanation in Documentation/ABI/testing/sysfs-edac-scrub
explaining the calculations. Like if the device represents an aggregate
of devices, like a region, the min scrub cycle is the max of the mins,
whereas if the device is a single, it's exactly what the device
returned.  And for max, explaining what you replied above.

Regardless of this noise I'm making about the Docs.. I think Ming
should go ahead and v1 the fix for the min calc.

--Alison

> 
> Thanks,
> Shiju
> >
> >
> >>
> >> base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
> >> ---
> >>  drivers/cxl/core/edac.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
> >> 2cbc664e5d62..ad243cfe00e7 100644
> >> --- a/drivers/cxl/core/edac.c
> >> +++ b/drivers/cxl/core/edac.c
> >> @@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct
> >cxl_patrol_scrub_context *cxl_ps_ctx,
> >>  				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
> >{
> >>  	struct cxl_mailbox *cxl_mbox;
> >> -	u8 min_scrub_cycle = U8_MAX;
> >>  	struct cxl_region_params *p;
> >>  	struct cxl_memdev *cxlmd;
> >>  	struct cxl_region *cxlr;
> >> +	u8 min_scrub_cycle = 0;
> >>  	int i, ret;
> >>
> >>  	if (!cxl_ps_ctx->cxlr) {
> >> @@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct
> >cxl_patrol_scrub_context *cxl_ps_ctx,
> >>  		if (ret)
> >>  			return ret;
> >>
> >> +		/*
> >> +		 * The min_scrub_cycle of a region is the maximum value
> >among
> >> +		 * the min_scrub_cycle of all the memdevs under the region.
> >> +		 */
> >>  		if (min_cycle)
> >> -			min_scrub_cycle = min(*min_cycle, min_scrub_cycle);
> >> +			min_scrub_cycle = max(*min_cycle, min_scrub_cycle);
> >>  	}
> >>
> >>  	if (min_cycle)
> >> --
> >> 2.34.1
> >>
> 
