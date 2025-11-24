Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12236D4F1;
	Mon, 24 Nov 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763946865; cv=fail; b=Dgd58PBj/Lwnq38d46V7dkCgycn5pqVHZj2IwaE4P/2wYjnXDpv38tVz3Ovfvwm2atw0WIriOXhjQwyl3ZRtr7tpU4AiQ0JjpPvvXr7BKWmLE2Uv5DX+VF3NGtpMnp892Hb+5PwaWDuwga5htRASS0NAoX3gI3wqMPG5PXjSJN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763946865; c=relaxed/simple;
	bh=9v0Vu96a8UGhAuobvysX5vYy47ukcho/fduwjfXA8I4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VLhogYj72vu4t+YNN4gnaZzIEihoqQT9tlu7bt18/bAtqkbWUaAZ5h74bHzi7IfMu0B0DDiMzLOjLV/76/6s/JhnvuztI3tbegDJmQwc3M6ioQqvbXewVNWwHEDFGoR0b0+SogM6QpTlRMLti6aSUg8sKtAo2FugeLEuuxzlHCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWclhDzq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWclhDzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763946864; x=1795482864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9v0Vu96a8UGhAuobvysX5vYy47ukcho/fduwjfXA8I4=;
  b=HWclhDzq/aGUfVWZDK6NylyFdpJ+w0ZioJD1hBGyO8FSvUyLqbnN9EAD
   /U75XimR1T5f567Njcpvv11A2nDbfNUoH7wPlbTOYGvamHlzAJtk1fC6p
   L20Mam3dwIwQ55rdvAXEkkuzOBvwN3dhGfpeQHeUFaweI+8Z0hAtkiHa2
   o59kC+M9fsXnJtcXV2sqV2eIIeKIELPQYZh6lrdlQ4X8RbnThpaX+MK+2
   D/q8ZYM+Yc92c5tjREUipfHo5UByPu7lakpfB0/O9JhrxeGCcJUtXpOdq
   Vpe9USOODlBlZeyNlIEC8tmJArY9/NN9cF3Eosk8Ca/xhpfrc0dzKIavN
   w==;
X-CSE-ConnectionGUID: vRQrQKmoSxq3YpqXW9BJtA==
X-CSE-MsgGUID: GKzkpRsNSKeSt09xuL65DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69800578"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69800578"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 17:14:23 -0800
X-CSE-ConnectionGUID: GR7i+16RRtOiWUFt3vjw1w==
X-CSE-MsgGUID: 31kyJJZlS9mKZzURGAcmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222836934"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2025 17:14:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 23 Nov 2025 17:14:22 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 23 Nov 2025 17:14:22 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 23 Nov 2025 17:14:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spFD3ewEHeqqKXLubitDBJnB/D9tDlnp4A4cDXcLLKIqv4T2fDXRQXJufbuCKEsvUirrQNqcaAP7FkQ08rzg5yfH7XRG2aC0IpbTluLSLTSnDOyLLDULxaa88rj6MB3OI8N/tgU3AOWODANQA0g1AQctwSGRyOi8YoPIkaha1rwZ1e0ekRl80EoapAl3vVfFFHllmSMrxTH0lkQlMwzTKAUXJ/WmFUOukDPxbxxXC/XCJSlpzOk+USVn2yjsCtUUJWTKhHskCPw3pzDEhl3okO0CO38jWzbsbRdrE0Dsmgb6WbbwX3zRiRowGtNtuwCLhWK+7tPn579Gk8JLvlBmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npedPeSffIIQZ80/UY+uhcLbDunaQtT8UcsRLqyM6d4=;
 b=hTTU2Z4lF6MRn3kWlhtmHqpqJxXU420IQ4eWSrSFxvWdYfjYEz0xjQ1K83CO3heOUxon2YizkdvX2efKXK1mqfmv8x+z8daS7gBeSYxZqCEYtTd16QgaLr/PePWMpKI5kdDYzIs5AosbaN+GskAuyeWzDJ6A+5FXdFzEVxmR4GovJWdLjGjPjUUwzOJcLpcpFulK9tVkdYYBzY83a5SRQx6PpV2BMLV93h+xY86tMKX6HwDNlC/seUNnxv6ZmLq1MA/IarJ8rbLy3Y4+qoh3YnZrcg7ebnUmhA5KWawfmM4QdYxEBinkA6toomHCCAQVisbxT93Op3+gIz7cbObI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA3PR11MB7626.namprd11.prod.outlook.com (2603:10b6:806:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Mon, 24 Nov
 2025 01:14:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 01:14:13 +0000
Date: Sun, 23 Nov 2025 17:14:05 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aSOxXX7xX4jYqqvF@aschofie-mobl2.lan>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRs4ILR8EEwnfOtQ@rric.localdomain>
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA3PR11MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e915b5-a8ae-40c8-36cc-08de2af6c7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3y6U1NJcLddUF6mfx51PVvCFZ9YKsyw/dumnORNyeh4Rss+lL/syZJu4Wsn6?=
 =?us-ascii?Q?gspDwVjYrx53ygxJPo1PyfFqdBuPpyhItmYNN41BSz09weIvtTaKhKhoO+r8?=
 =?us-ascii?Q?YLs/fb8zbI1WdFEcDUi/sMgAnHRgU00OEvJoQr8dxMO/Cc4RAIjHpgJTIz34?=
 =?us-ascii?Q?giF++2RfzWXsu4n8GEBtabhJG3vO3re0Ics4dBvOIZdQQOkOcKDF6fJ+HAGn?=
 =?us-ascii?Q?WDdHo2Eqd+LicqQ60Rp9nRiRGFVV3kfnLy5ChagXot94VP6DGdsLhXDEhfwN?=
 =?us-ascii?Q?M6JVS2yPCFcSYBfZh1gmdNxhQy2THW+HEXviRYRKqRbzKeERsT4I1iKTrdy5?=
 =?us-ascii?Q?KKYgaIAUpVigdoT+Zu6luNg1CtYjVGpNr6Hwfh2ZEJJvHlfjtANkwR6xsiqA?=
 =?us-ascii?Q?GIBdfE9EX+BczQYgG4by84LibLyecEIB2LvrE442eSPn5MumDznkLsKJP8oW?=
 =?us-ascii?Q?+nxRXpFr8R+RWJH8p0cQe8brlaj5CaYWTdTlLS98sybRpiFL2YnsasUrcmah?=
 =?us-ascii?Q?AeYHTuuTJHheWqsU65WrzLIh2t/I3icJLtiJJiVP0lP0jX5X0LdiG09Fen+Z?=
 =?us-ascii?Q?sCEb7p79T3vc60FzihRM8BeXnYGS9V6ofPqUqJ8wSuQPQGf1D6pUpG+v5Ze3?=
 =?us-ascii?Q?9FNf6POI0W4PmAQTZ7zEf1trw2uCgzzDZm+yPQIMc2ZT1qHO6hGDotwyj0Dm?=
 =?us-ascii?Q?oK9VHfNlzfNxywUtz5wD7LJQTQ1XnVi7F9GUPgXd26QnISQncLFCXfd00i1z?=
 =?us-ascii?Q?8Nae0T+AjYY+qKdxu7tfoeX5CKEybom9BpnRqOTjHIWhNRk4evSYGMtyMcqf?=
 =?us-ascii?Q?6Gy8YF3i/A2lfRNq/uIYvzQVVnC5vorV61ntXmT9VNawgUxwQ5ISQ7nelJmh?=
 =?us-ascii?Q?L79LSn8edab2FnnU063eIvJhxkq3YdsnB0B71XfokFKScRGSY0WbORs+1ATD?=
 =?us-ascii?Q?wfx/xP6ydCRq5M3lM/3O2T6GAqOXl+l4JP5611MkrJqZZofyoSd9n6Zz87ZC?=
 =?us-ascii?Q?aMwQhDs8aRilnkqjZfwCULnk90S0I/FjXFLwaXFk0JsOoXa5UQkgXeVUzOWM?=
 =?us-ascii?Q?Mh9G948Mz5jgEARAvjumIieIUf9h06ZHZ1pk2dKDGcOm09H2TdTYdn+4WxGl?=
 =?us-ascii?Q?1jqZ79hLc2s3xzZKT8tZCGoxXPGMTYfwioK9EishsWFzZ7MZog2tkl32L34D?=
 =?us-ascii?Q?s+62uD4CWJkw8K2f21uE7bOWgxt6e/H5t3hv6/gRZOYEt+dUJNtrriory5XR?=
 =?us-ascii?Q?C6AIcM0vkiVJuN4it40rnWvEMsh6X6of7a8tyDJFpFSoI/5NDDDh1+cnhTpq?=
 =?us-ascii?Q?QKQioej82QyVHR6aoIfPTL632j0u4vNjPSwpz4y18kicU2SqAZjzDi44G4jY?=
 =?us-ascii?Q?Z6yS116iDl3Q5z1yXMoisjKV5VzE+trGx19yr8tylYMsrlbq7yS2uOJfYzm9?=
 =?us-ascii?Q?8i6876OAp3D3LcEULwsH4oqz2X7OZKxy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXiWmzyCEJNcn7R3pIOryoIwUx68jD5zpkv82FUGu5yOlAv5gfTPhmvrCyMt?=
 =?us-ascii?Q?1GYLFqGGOaGcpcOj6hXrNrDyhKo04ENCm6W6+7CeM3Fp+8do2eVFMHKO7787?=
 =?us-ascii?Q?jVeD9q8TG1AQzOE9xmStebxa0Dt3JKJ7Db9HqhtXLy37z6ECkyq7piXRbpA9?=
 =?us-ascii?Q?q3s/VQCKR2XdHFnqudbGKu36kXRqIYvtg1jd1QgzgaFrPU4JwhhzQlTdszhG?=
 =?us-ascii?Q?ck8I5Oeeq0G4BfxLNk80/m2bqCttsGaFQMT0Q4DDb6FPD6TIAeJZV3dftgH3?=
 =?us-ascii?Q?+Qx4/zdX9iwzhEs3BRTrOTumbeH38h2Xyv4sePRmKqyxMIEvdEmgDPrSkLhc?=
 =?us-ascii?Q?wXDWB3+afvzdo2dHKeNFAnm7gLQO473esPr7VQRGqU8CDOJQ+gGNXYddGK6B?=
 =?us-ascii?Q?IUxHv50hTUk6cayuxKciY65Ic3KWA9fSQ2bHH777ezVhzhW59z8xk6GxcwtJ?=
 =?us-ascii?Q?om0kBFRO7JXgIxDCZWLSPXYg+D8owi6XmTZqYmC9of9D9Dum2BsKKiNQdPx8?=
 =?us-ascii?Q?+JOvUY94ogvU9xaoiBgFQBbIewCzEQo/KwbNOD/v0UyrvMeyqCFefKA+25vf?=
 =?us-ascii?Q?NY7ZysJaU8HXxPYo9NYdvlIBmcCIk3mQ6xAm0IDV8sEnbgLsZ21ROxZPPNjN?=
 =?us-ascii?Q?iR70Fg6uEuWae/rIgtuiTu6lRa6PDUA1pjP0/hLTw1JNnGd0PKQnGxmCwzwx?=
 =?us-ascii?Q?O7LBnZMguc1J9JdxW2Gokp3o4XBoHTm9oBGDk87rdtMm6nV+8nDwlNz2ryC9?=
 =?us-ascii?Q?xd/EGiyBbpgI3eOLBCkMCcgjzSM1OKInwqNRoCMQzyzj6KXa0oiWxC+dSzHm?=
 =?us-ascii?Q?o1EUSmVlGEPVNttPk/vnaMl5ZK1J5J0mCh6rvVZqHusjVTkUdqVYSNijgqBM?=
 =?us-ascii?Q?5SNdBm+q+qSKZjOGJls2Ha6rT8BDWTuw47hTnxB7ZVO533Nca2jV/Gdiezeq?=
 =?us-ascii?Q?xOQrsxmGDIgPjfSboow0sdpL+/fX/GglZtGtuQP8b8AyTsjKYF9kOy8eXg1f?=
 =?us-ascii?Q?kthwiclUWEp3OZVfqySprgyvP8YEHILa8Wt3jfdFlYXVtRFZ71e1tAqgPJSU?=
 =?us-ascii?Q?a5perbBjzuAMqlF8YYP/FrOPh4FEIwysicLRi9CIIHalRHyyIqLZaJCS6gLo?=
 =?us-ascii?Q?EVKLdhHfJQ5blviYQrh9gLksxU5grmBEMymI6CveWvQOIXCwL4bXFt8s9I9w?=
 =?us-ascii?Q?H4eBGQn3+UqWdW4TqS1PyRjiG/wWEl2s82+D1/HvQ3AVNt0rWyIL0iO/VJOm?=
 =?us-ascii?Q?NC5maZw6VBIE3apOYz2hWzeHNwyMHQCpHOLx/T44d+w8rqhcFKA+56Br6fNX?=
 =?us-ascii?Q?M9GCIqftei1b6VD2LFMxJDRi6pEbbnemu/NcgtWLsOu2osU0td7uTYt2dpAK?=
 =?us-ascii?Q?7bzH4P+PMFTc5eigctxkpUp43/FAd2PjbDsGgJV2NK9oV2yArLQ3QBDLVja3?=
 =?us-ascii?Q?Lj0yxLpLSAK2p95cf9sWPex4HGMNaQ7fLfPf0pJBSNxMOVY/HkCGNgXsD8Hz?=
 =?us-ascii?Q?1Xu2NAUQaDpCFHP3B+WBGXfTILq8MXjFFBvN4d3uEZvPfbSxLh2ULlNdnqtp?=
 =?us-ascii?Q?l83yqFNyMqF7RiOZgPDCYxFqaPqpO53J9Y2+qd0/uzB3ciHFNviuR4ozriAK?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e915b5-a8ae-40c8-36cc-08de2af6c7d9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 01:14:13.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akb/YYIGh1dhtQdW3GTOLss6wLkLz4zdJO0a4aU1FSWhrG9DTrpbpxlERekFD8Gy8Vad6FW49YGZW4gprWKk5K5Q7hEUGJaAfEY9LVJ2Uec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7626
X-OriginatorOrg: intel.com

On Mon, Nov 17, 2025 at 03:58:40PM +0100, Robert Richter wrote:
> On 14.11.25 12:01:29, Alison Schofield wrote:
> 
> > Does this work 'as is', no changes required, to support DPA->SPA
> > (used in CXL Events) or SPA->DPA (used in poison by region offset)?
> 
> The PRM handler could be used for to-SPA translations, but it might
> not fit well to other users such as profiling, tracing and error
> handling. Those users are executing in a critical path from a
> performance or stability point of view. Performing a firmware call
> could cause problems here. Since the to-DPA translation is missing
> too, a different approach to solve address translation might work
> better, such as examining the region parameters. The kernel's address
> translation library could possibly be extended and used too. That
> needs to be figured out. Also, my main focus for the patches is region
> enablement.

If address translations are not supported/supportable, a quick exit
on any attempt (DPA->SPA or SPA->DPA) with this config seems needed. 

Better to fail and report ULLONG_MAX than leave open the possibility
of adding the wrong address to trace events or using the wrong address
in poison by region offset action.

Maybe you already know that it fails gracefully? If so, then it comes
down to documenting the limitation.

-- Alison


> 
> Thanks,
> 
> -Robert
