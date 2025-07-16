Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035A2D052
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631714; cv=fail; b=BxZPuohWeWefdp3NQkxSBvHUQgMxv/q8ZocFsNe5x4pCqYmH7VtqWRN8R30ng0xsd6fuQfOTbYfl2h5bVcU/ORGybCRp6YMufFf+7tMFVZb2ejvQLfNWolIGBzN+TtToIUmcFdyFbNEzJWowZXL5pNii/N7LquEgEvSQ71clROA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631714; c=relaxed/simple;
	bh=2KykXWBoPzjOsNwsQ4BOfDU9hS4Bortlk2uyG0ROwOs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHKyGPrUy9y/6V4fyDyHbBbPzjX0zsppbQN1k8ls6p5WQSUWwM9gHRCnEdP4b/iwFUigRcZw6gvaevIHi3TTB+K3oQOvO8HlFdmo7xlcZ8zOv4WgYD/CwR6GtmHv0icfXZ3bed6U+kSUP2UeLQJ9/xVnr30UqzEWRpMe+yac9qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1kJRNfI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1kJRNfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631712; x=1784167712;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2KykXWBoPzjOsNwsQ4BOfDU9hS4Bortlk2uyG0ROwOs=;
  b=h1kJRNfIWVpi6acdTXb0BYMc9NTf12R08Ai9T2GbtnJLI7SFIcrZExc4
   i0AuBxSLdKnvtwymB8pJc3g3QJZpvUMU93lXIUX0WoLUcCJkxs80hEDZI
   NA0xamrGrWKkiRALi/biSaU6THJSdE9dWV9lcAMY7YoOqKAufrAd61Br/
   1Ouoc4+X7ym9PuzVBf6fkQrgAsg505RMLEClYAz+W9odMWkbv5mu/o+Zu
   +YRYzcGPKe+4BwbeOncVytBglCMVGgl53/o7U6OMU3plFXfjagRczlp6P
   ghB4FYO6VTg6Vurzdtnf5FDKYL0GPy4yY9O7ZqpTWGY4rZC+ztXOUFTkC
   A==;
X-CSE-ConnectionGUID: rekuTgS1QEWDSPFl+FhZNw==
X-CSE-MsgGUID: DmltizfkSeOM6WWL6I481Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54575738"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54575738"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:08:32 -0700
X-CSE-ConnectionGUID: xQxCK7PuT0+xGhKtmLGetw==
X-CSE-MsgGUID: XNHEhmxRQJCuNsEUevxiYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="158097835"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:08:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:08:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:08:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSlEPEkgRF32HSMee+tst/jSaQial0dZit/KY5cK7eT18/7HJkSDREi3mQa/SzGgramDDj6fCl/eoikxyQqUhoOPny/VitcceMcGSgHsv1KP1iSgEL9KtCA+nubEm9Fjk+GXd8ht7IYfztM9qX2kRvxXqIWvPrEnRwp7XD76qgaRZJCw4+vIiCeqOXTpn0kN4dyOPoBWoZ389mtL46H+oJLahwooeR2PdEq1B1iNQq9tSnodOGEroXMgUkYMTU/31eQEPxBEiAm2+83npknVeJ1SFIsb8WhUzCIVe3Aps4Zujh074aQtE4vkR8iFqJxfVGDYz6k6Fd+X7fwG253eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGE9l4rjkLk012Ma70vqzGFzJnXZu2CMM0s7+p0w7ko=;
 b=n6hdgjrdKAt1vC7hvlrN8IM+V7PrMYD1t+CoffaR0Iw2Ps05SdLNIodskOuUKMHEF3dxGnKMghpUabwCgJX+Uh2Bbf/3wToTHp2urPzRVasn6EfYH4dnuDOvKlg4UjchWGjiuu3Xi8/LpBych7lDQyJaK04/ub5sVDq+qZ+wq1vzC8vsxfGtgp8i5cWbAGoR4JvN51+kINlR38zZwCeDCKmtjrbunoyBvDL6luX4qaiXbzx5vw0Yi4yrmZx0XKXqXt9S6mTS35BKiuTMXc8Y2z/q6U9GDzBLGAdMgSqCwr7qmOtYCsL2i6/r5cSJTQv1ti169WjBEJkUhTpCjtdgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:08:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 02:08:00 +0000
Date: Tue, 15 Jul 2025 19:07:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>
Subject: Re: [PATCH v7 09/10] cxl: Move enumeration of hostbridge ports to
 the memdev probe path
Message-ID: <aHcJfcWmb6WtCDlX@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-10-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-10-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 342b97e2-e27c-4e83-e92e-08ddc40d971d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HHStdMgpsXifTF1c9WBouTZ56Gp2H+FF8NXfuJ++tcZ19nTfiSo8vkZDOR5Z?=
 =?us-ascii?Q?5aBOHzOVp1LXv37b0sZgJJ8So27dNGcWOht97opVWfPB4DrSLd/HhxveWNrX?=
 =?us-ascii?Q?azapymEXWFnwrBr5aLMu2BPueIEixpSiCcRnxQzPoEB7y48scVXKDb0nVouY?=
 =?us-ascii?Q?hYsbwFrwJlYb+Vzy6Cbxudqh9b2XNS3dDJy+F8ePiWpear3mfnSwu2Du/J6y?=
 =?us-ascii?Q?5IKrLawVHMTI8jsEEa89TJ0lteo4OBR1fOanFXY5ro+J4ezRXswqE9AUqJgJ?=
 =?us-ascii?Q?8fWxgUvSUIIhQFXVhK0bVVuCCh34iP9GT9X+63ACVpvUY43cDE3/NiJdYQET?=
 =?us-ascii?Q?bh8/o0oIrPPMME93MWOIKNLidXxfkEKwdrOMhEfdQmRaIpa8Wzq8OjRiPGf9?=
 =?us-ascii?Q?G0XAA14sfE6VbIAamiAWNbixHUCh46WuU0b8sRJBXFeFjcqap5Mv/tdj7qb5?=
 =?us-ascii?Q?Xyh705der60QlLUrKmGvclZr5k+PUcToEbYr2GyrTHLpvKwC5pOZU+bDFLtR?=
 =?us-ascii?Q?KuGK1YjphWjHeWFQG4olda0hG+5OYsSL0U4UtnwJAeA7t/8BLDPzPURCZqHF?=
 =?us-ascii?Q?oEmjbUPHrJX0KxMGYoGHFn6wFhv5jDWLUvAN+fGVJXBlhlEhg55/pkYL7Xvn?=
 =?us-ascii?Q?L129ocD5BfmM+u0PpqckqnrXZgmgujlp0g+UKQqSlputiceOg2l24lc5iatG?=
 =?us-ascii?Q?Qlpv0XpKHDaA4q91mqrVKas6vu1ngqJ5DOUJBb7qBWgdX/uPDTTkCvOgv8xS?=
 =?us-ascii?Q?I2T7EQM/GT8SB7mVljYRTCqq4h+u/aFF1PXx3Kp6IdJ46q03PqhmQhI+jqQL?=
 =?us-ascii?Q?QhfiYgD9ib6TvnziYhPnDM/q0ZPcrJTlGTcFQQNb6svdy5o/YS9T+Abh5+Hm?=
 =?us-ascii?Q?bmbJFKexQGSTw3IqoV0fmNlAoeTBzPZ4+72TjiZJ0wK3D0gYgNYTvYaqlhA1?=
 =?us-ascii?Q?m/A7iZ7K26XDWFtvJ0leRvcTGkgKtY7v6jQWfCPUnYY3GX8LmwvkGyLm6q4d?=
 =?us-ascii?Q?XOKnxcw8EgWp/46hAgcuN2WSi/ddUU6VS2Aq9oJO45xl4X4BrW631j/CJ7Lh?=
 =?us-ascii?Q?9xvh6Rv5nTkzXrhE5WMYwrDrhqpt4Ck0c5/U6I3EVM1gjF+Aura/N2K2a9Wv?=
 =?us-ascii?Q?CQhU+NjK50fdcl3h8SeEDekRggtI7raorGNRiM3ZvfIrqqCga5/9pjochZhL?=
 =?us-ascii?Q?ztDaRNX4BKQRPAgbGKQvm6vnkwVBHAIXYlrv5Mm3eJGN7pOQErrR7aj4Br21?=
 =?us-ascii?Q?JjoOWjwIhKxj2NZmZvxg1Bb7N79soHkBNZCKlsfl+B2P2pjKjZVQ4DI7yn4I?=
 =?us-ascii?Q?WvNtbu4vQgXvb9lCkw+Wfm9nRWe25kO75OEyRRjjrRvKggj+gJZdlixxZWtK?=
 =?us-ascii?Q?qoIYqqXBwRuIDzaLs4jFQJ9//ai1nqf6A0H00m+0HXwtXRaOlGkbgJvTnMcE?=
 =?us-ascii?Q?K5ZdxfruKhc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7RhXl6Ix//TcP3OxjmI2PImQA4bVL4pT/hebeX7XcJGXiT5EHp/N8bV+j2+i?=
 =?us-ascii?Q?IrAnQwGmM9yQRxR0K93Z/Mwbw41Nk1JUrLsdhzzP3X1fuG3pJwFjZkf/SpYj?=
 =?us-ascii?Q?3oHteVzJThKrJDoy+SKN+t1JX9n4WyeSJDaJRggGoYb1quOtObcgg3qrg7Gt?=
 =?us-ascii?Q?kk1QG7ZDR4Ai06IAXnSgSXLEttgjTijPtvplIpjdHekW3VoFY0F3xmnhFf5R?=
 =?us-ascii?Q?aq75kQYSjLbPPteGCMIHCK9eDGhwz4kNBKoRgrK5ls6tSODUNkzGOY18B6cY?=
 =?us-ascii?Q?NopskAJKagJl1tYZyJuJqem6oRWANrWL/NZXG9SioQN5pHREziQp6OIu7/hx?=
 =?us-ascii?Q?uabaynY9SyWV1B+KUaHo4Sch/v7byQyU3E1Yd7QGS+yeXvPbHd/4ZYGlSL9o?=
 =?us-ascii?Q?KwVhxLoMRHBoMrbCHBgg7InGGonMvwQALfaFw+i6Ixfry2AeBOd6uGkXB/72?=
 =?us-ascii?Q?OeM/X+q9GWww13K/THsE688bv0M5OmJT0MRQfadfOgdOG8QNlBe73wRt24Xm?=
 =?us-ascii?Q?LMcaVGjNSH2Wkg4nxli9NSpfTuv6Bd0tZb43u7GUkumC//vXmsliVgTgRYtR?=
 =?us-ascii?Q?lRexZUX9bkCvdPZyLKXR4pR73JoghgVP9oI1NXDS9LOpC/ZkJFhmxQDC1z11?=
 =?us-ascii?Q?OJmYBTz8iScntzTaDGoMuFZ04AhsEdHP/H+Kk422rmaqXEFUQKX27pxKsoHF?=
 =?us-ascii?Q?iW7VOsA+RohH8eLtrMpeV9L3qfvdB9SHxNXNRZW76d4qM7jg5m2cmA069ZZg?=
 =?us-ascii?Q?dGICWj2acJdgmvOE4CCZAkTOs1DocOtfcluheVgNe1V3jmJSbKiF4huyTL6d?=
 =?us-ascii?Q?Q+mYo/i5uXQ/uZmpVbojJQrLB8J8seyqiyj+vJXu+USPDe79nv6f2wEnnN5A?=
 =?us-ascii?Q?3OhQD9vhkI3dxDSCRhGeTFhkEboIuK7Ul5H9PGCUbFh/5cGZor39fztWsiXj?=
 =?us-ascii?Q?O9P6fIqi4NHfEcYBAMNSWXlij9f3bnLFnbRL7QUMrxwL/yqSDlP5UGckhLWG?=
 =?us-ascii?Q?h9EhO3lz/OSvWLo1v05vBOtBsdD10EuaklEAw4bCUyejt0H3z6b4t1P4h50c?=
 =?us-ascii?Q?VWgJyW5P686YbkaInQ9BsnsocNdQVjkT9iqDh5s0QnqHWqLzoRjQC90UBeFl?=
 =?us-ascii?Q?rkmfZorrO1H9n2YKVbooQXnQoYSie5Il+foqr/3EIfTpqKS5uw50HLMtM5Q5?=
 =?us-ascii?Q?E8pEq+LI/drmcTGbrvlavGPRpahhJMPI1JoJ8FHKt4br6FeeXHqSwVW20nhc?=
 =?us-ascii?Q?yABFv8Y4jVmtu73DLjiJPG0wy6P8qyZUoCFwnJM65TT/DbTLfYGgSIyj0Wo6?=
 =?us-ascii?Q?39BloT30ModxV263mAegiEpp93VQn4CT5gCK5h2KSUXD/JGV4YVQ8NcP853f?=
 =?us-ascii?Q?KBbeLXsBZIHSVa24J/g+6dNs7r/eMM7LmzOgk78EPPZLklCbm8dTqtSPuLEl?=
 =?us-ascii?Q?2NcXBayPozTW+PV6BP+o7DXv6c0+XbZMlMChOl9fx21aYLf9/DWfE4Oz/PSP?=
 =?us-ascii?Q?PJIyBSV2i5LIC9HaHrQXfbzC9xCQbuDyy3/wHJMvxeeRNcETXX49J+XhZTV6?=
 =?us-ascii?Q?12TLUYTobDoqpb+Impl7aHbkSvfHWDkpdmRov3du+o8BGTOD0sGqUnr0SrBG?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 342b97e2-e27c-4e83-e92e-08ddc40d971d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:08:00.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGRgBkhZUZgOfJSh8jW6WpOttBfuu4TM5cEz6kCesT4MnIGCwcbSBC7pp91C2LQhZHvwde3KetsBtwPcW2pv5arJW4d5XVyl6OP8AgVGZdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:26PM -0700, Dave Jiang wrote:
> Current enuemration scheme in cxl_acpi module creates the ports under the
> root port by enumerating the hostbridges after the dports under the root
> port is created. However error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed when certain
> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
> DVSEC ID 7 blocks which will trigger the error message. This behavior
> is defined by the spec and not a hardware quirk.
> 
> Setup an association in cxl_port to tie the host bridge device to the
> associated cxl_root. The cxl_root provides a callback that's setup
> by the cxl_acpi probe function in order to create a port per host bridge
> that was previously done during cxl_acpi probe. Add the calling of the
> callback in devm_cxl_enumerate_ports(). The observed behavior is that
> ports that are not connected to endpoint device(s) are no longer
> enumerated. This should also remove any excessive noise of port probe
> failing on those inactive ports.

Another needed and much appreciated commit log!
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
