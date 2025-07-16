Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1E1581EE
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631289; cv=fail; b=tATuIb8JcM6aNFwmtd9njunHrJNnerTZ3SK+BY6ZR84LuFJyCphsHCRnf98HEBAYIwVKGVYmripq0CJ68ULSWduAVBVOs/fdvjmrqAFzf1l9Zlqb7woXyFECY1dE9rymbudUnSeNN6/3Jxn9BTldZBdTI46J3/RpKGqRE/JIMLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631289; c=relaxed/simple;
	bh=ipr8lvqUs9K52/x+wBOWys4yrjaCYTxb8xlgRckJh98=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FbtAKalpVTngswOEHfDgbR/cIWmlXjvGCCj3LjjtlAWmqRM9rXJrGrE7U552ZOT3b8XjbdIK6zmokq5FXDhxJfadt3IFeq3ZgY36C8TmKkfBVaf9Hi+DN4FxNxYc1nVo35gvAYjRUmDT5vkuX39ea/1kc7jvtFPQf9p0xiMZHdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTp3LyKm; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTp3LyKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752631288; x=1784167288;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ipr8lvqUs9K52/x+wBOWys4yrjaCYTxb8xlgRckJh98=;
  b=XTp3LyKm2e6Snn37ZV0seeayRaSXraCbqyHZF8R0LZHrmYB6N9oVXOIZ
   0oPzv5XjjAbaMCo1Twu5tAjXm6ws5Ha09sEwxj7QaJH1UOuvSUaSbrDKS
   YgdkCSfPz8NtQLq5lSrE3qjcvcipntEqea5dStApNuITCbjtnavOiRhHW
   bKjt0YbsPcDw43TFzZ9P7zdHbVdfD/M7Da1RR/RWPXRF5uTqFPrVbwIaL
   1rhzQOOYAmwQJK6kNS19goyZwZMDjp4D5pvePzGJqamNGp/Vf9Gnq7F3y
   4E2SdmL/s2eqiunpRw8YhQuePfjnzcJyGaytdfz/+n+OKjPmYV9GlyX7C
   g==;
X-CSE-ConnectionGUID: kKvWmfBUQ3uJlHIf81ozLw==
X-CSE-MsgGUID: CkJfvdiBTfShTxW14P8UTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65436096"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="65436096"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:01:20 -0700
X-CSE-ConnectionGUID: FAkpTsTtQSC0fAijEyoScw==
X-CSE-MsgGUID: dTvFyddRRI6mQFfsplPevg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161684613"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 19:01:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:01:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 19:01:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 19:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swVJ4TJCd6yGu7FS6dScVSg82EZJBIhGHeyRKyFwCkM9hB3a4Helc7DmCtvPFCVdELxMCtPAsScDgY0AHJ+b1XhWBvJWpit2/y04JLeidezzdFJoLQQ4gYqdytfpK+gYKBGWeAWcEAUx3f/tmOu7c//mkdz7HTcMtmyAETdAAHqgErzXZoA/YOhGH0WxbbzuD/lO6GJ8Sv/p41KerGo6tHMkzMSAPZDMuRnchnKgLEK/qacsX/8/pfVgVefVj75eP37bymOhnA78V496ucaY431/Kn4Fysy1jZNyQ6Q0qc4oBWoWoOPktRNJlEEP6RbuGIBfzOwS47vzKol7oy5Z7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qGkaWxwlA/6XtE3smBV4pUXphrYVmcXoX05Gb5T6EI=;
 b=kR4bVAiXb/8oVp5S+uQeKA3mVrDHH8yJ/yy6nXhLcoemzaI9pk8W8Gy7vWLN7VyRr5imUVHxQluKqg3XjxgcvrBJh7DkEcN5CrBIiZ/Qwm0THjl3Ovec/T4/3AMbGkIJNYvlrfPuOSlksGe4vkeLOUEKc8qNLPHodbOuzZ+oO0mu7sMI2Xtu1aSmM4Cy8O/f1Z7l6wgNpwNaRhgbcfDbOarMyQ8ySSuEDqjRZR0DMBpsKhAhuAMYfFmF6X0Q4VYx7eLc1F60x2tC1FMsc77SDAQ3OnZztpTbpubu/lGakO2fyJqd8YTOfPFHALeKOodh0C8Rggmrb8hmNBmn6xhlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN0PR11MB6205.namprd11.prod.outlook.com (2603:10b6:208:3c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 02:00:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Wed, 16 Jul 2025
 02:00:41 +0000
Date: Tue, 15 Jul 2025 19:00:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 04/10] cxl: Defer dport allocation for switch ports
Message-ID: <aHcHxR2N5fMCBOOe@aschofie-mobl2.lan>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-5-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250714223527.461147-5-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN0PR11MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9fb40a-605d-4a68-7522-08ddc40c9115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gL7hNUR4DpUVKiyeEjynkIMXJgGu3RJMGaiSDd+TK8MjCqtNJ3IqfVFrHRSu?=
 =?us-ascii?Q?evlpngSuUlo86fDGOmg8jY/2Er8v+MynsfgRq0pURT3hHx4s/fBE1GmFYqnA?=
 =?us-ascii?Q?WoeC2vGxHD5+9g2LItFzDFxhsRwc+GAgmClUpjbMpQdjZfK3F3bsYCwybdYh?=
 =?us-ascii?Q?crLlnkPqWOS3+BNvmcg6NpSbl//+V1q87dmWp+kQklXNWPr1E30M695oXa3h?=
 =?us-ascii?Q?RFt2ovYPzvpxJO8zlKeYzcksgQk/4jwqjV1QP7nckGHBYutdUJyXunWsI9Ns?=
 =?us-ascii?Q?uH5dEGRcpGa+CZ1bWhodd72o3CN0iEPDbxbOxzZnIzF5DeEbQeJZfGfO4ECr?=
 =?us-ascii?Q?S/7JeiOHvIBorhdRwVqj23xhVHNqh/2PS99lqm3DDuptXu68VeaMS0GUVTsY?=
 =?us-ascii?Q?ClxC87XOyFOAQbGqCNz3UUcjv4/iRB9iFsoYGmUizGFhgG7ZpWEtJPH4IumX?=
 =?us-ascii?Q?Td1UtWj/CBfoo4ZT7Ws7u1KMisiUtWX6IAoF6JOFHtGsmUi1gLwjP4FbClTG?=
 =?us-ascii?Q?MMiWt3yYLZqLBw7Pn5O7pIfEm8vSedwarECRrCetGTrDqfVkYe39rUgMIk5Y?=
 =?us-ascii?Q?L0wzSdgucLc6MYOzBR8xxKdQ5EBDZDZix/mXcgLV4hlxBPdYM4wSVCwoPWbB?=
 =?us-ascii?Q?rl5vglsHDGXuw7lXZb9uBcB6RRzILQ6HWDhEIzQ62Y9IZQDgqLSvtp/zxVLu?=
 =?us-ascii?Q?qTSyIvTof3ysgfIJr4ZDKR+P5iMLj+YKMxZwaS5jPbl7DonYaI8vUDH2nIdy?=
 =?us-ascii?Q?n+cQDs6WPVR+x4iJlB0qudh2IIj+Im5R5yuqxbRLtlFBYFiJ1e/MQRgTZ+hR?=
 =?us-ascii?Q?YIc+D8vB0F+vJbEvKztcasNL7dXlExVdEhKGhNd1WOQBFahSAXlJwZOfeSvy?=
 =?us-ascii?Q?KvJp38DQQXXySzt4ei4aZrudOEphlDWk9XMP7TczA44yOufHbfx1i1mZ8UxH?=
 =?us-ascii?Q?5r/J/Z8HtFx2gT6Cw/uhQKUjhzJYYelDK3t9Id7vDs54Bwbei88a/IEvZpMg?=
 =?us-ascii?Q?3gtyyXtNBEBWBnIawkVXBpabIubhEAuajcdx9a8Vu/qcslGN/6JETdmfkw82?=
 =?us-ascii?Q?CZfX/W2MUOHQvI47/8G+DXDDsxIZllNhw/aOnV9kAQuCvDpgHR4I9+CC+fLn?=
 =?us-ascii?Q?yvJ/2Q5gSwWq9v1v5+hkCiV2NXgXJ1FfjtbO1WoojkYQcSRYqXA2sBI6RWX7?=
 =?us-ascii?Q?+yVl216D7ldBBnHyTR7s3Bt9zSfX9fbMnCYq1mh/iGUPScncUKdFGiazdUXi?=
 =?us-ascii?Q?TPETFgClQ1QSekUkN/OLxTDsoXudbS1Mr580UZ7FRD6Xu4vlgU5Xa3QhrF/t?=
 =?us-ascii?Q?2PAc/2nIAoLvuouAPQM/NKH9gbznyB/N3xk9UyAB7tgGWrz/uIbSC04M8hEM?=
 =?us-ascii?Q?6ehQgI8pPlKmks/dTmmp5QcUwKJ+lEoqajYWUPMo92Kv/FQ2Z948lsrjrp5w?=
 =?us-ascii?Q?VPpD1bO/J8A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XSKRQojHDOKcYzktwSDSWpd6CzxUsan1A8P++Y6UUPE2g4RUvjq3fk5d1hVO?=
 =?us-ascii?Q?rpzexZJQiQ/dQVNGHGB2+Wvg61d+3OuLu35Mjh3gCu10B2CqmBIS0QMJvw6Q?=
 =?us-ascii?Q?UmzWAU/Hr1uXi8Gakzx1cMG53Qtkwt5+pQ8I4U43cjDTHetpxt6fiTiu4xJ5?=
 =?us-ascii?Q?M8kpwlvM3rluBzvB5BQCvOV++E1J2RDnv+K3oQl0sbtMr6YOsku7q+M5Ekzv?=
 =?us-ascii?Q?MqcLGeBm3M0b4ysL4/JJZrgubOe9rnqXTmxo3cVc8NWSbpjP+K6wScjIrorC?=
 =?us-ascii?Q?36DRvxW2h4QbEHLa8j98WV0PrWv/+Lal8pD9W7AgTyqzn99NJ84/hp22d8zo?=
 =?us-ascii?Q?wZzI/CmBmivQn7KzfPBxdOzm/r8alppDqsGv0KspTyIwj8u1yt22N6vJLhPo?=
 =?us-ascii?Q?kZcN3OsvdvcO6jEuY4e33G00oFgHAW8a9+R+E3TOU8k0iwTx8W9yzfV1FGW4?=
 =?us-ascii?Q?qn1QfK0RXV2ATLCNKgft24nf2SSFNOmt9YKRWf1oUum4QJE52Me907WI/v6Y?=
 =?us-ascii?Q?Vq/jMDKTs9ajAgkVgESfwHM1CJN0KBZhdidBeLF8xJVGwXpXgKvqYoAqb+xL?=
 =?us-ascii?Q?olXViNE8yIehzBYdqzIo5cqp/9J2e0Yz5H+fQmK0PIQlwBWUXfNVY+G4DmXS?=
 =?us-ascii?Q?Ek9Km63vgpPc6JuGhpmdG/oeoF0lUoZH0jvyXG/mw5AvXcysIKuJJEwi+5V+?=
 =?us-ascii?Q?N/PTqf0ajlMIBLuGLZlbAzqxtW5ndPAEF0fFa3jXC90yFTp1jcz+iUE3guk1?=
 =?us-ascii?Q?sOszQh//8lUxdph2Srgk+CXJeBGQvvG5VtFWB+pRsOIKj+Vw/c6oy0vVbV9W?=
 =?us-ascii?Q?awwkvqFejVx6IRHjVEKelo6x6bNUiN4Tms3rOwfoxLjTrht7c7yU6ZMHXTky?=
 =?us-ascii?Q?5bHd/DRZuDeW0gHNhRsUU7hYpenEaxVt9kWyJjOVf6d4yOB0lCy/zMR+6NqY?=
 =?us-ascii?Q?iwlmPviJ9hgTxxmZmMlDiAreqlWnYkNH8DgY3wDvONu7P1NZfJbM7HQG69Or?=
 =?us-ascii?Q?SPM/ml6CL1y25dZy3IsIOnhZWSpafhL10ifGk/Wv599IZ666kVOAmR0A7BGK?=
 =?us-ascii?Q?da7w1yh5enFRvh1IDxyQogjXNtHRy4NMDPEFUDUZRGMY4cmcGRaSdU6TXIWC?=
 =?us-ascii?Q?EuDhuV0SbncY3Bj9lw+3Z/sP1g8txZpHJ6z270GFEOX4Xnp3kVk1sXa/LprS?=
 =?us-ascii?Q?/RsspabbpZf0+7tqgj2kXREzjMqnEt5RIZ8SF6j6NsBNVuqgiLrickQReJWK?=
 =?us-ascii?Q?JAlixqVhmeglksbFh7kvGRHq+5rFzyI0pwB41W+07xDea0iMcz5bazQt+ZMH?=
 =?us-ascii?Q?b1NmaxG/k+PSM4SQm793Hhkd0sIPMMH9uxQSlS9+CkZrGzY+1CSe55KwpHq4?=
 =?us-ascii?Q?LSBn5BDHhhcqkOqx9aijI59IWc83jUrGMjrQ5mtTMKdgKYm2UunQpwV9nyFL?=
 =?us-ascii?Q?31C0wY58VIKwYg2DW/Jl1F+OU8O4U9mmaS+6reDQu1z6LHcaG0yXGdAwV05O?=
 =?us-ascii?Q?IpZWAekncaNAyFcLQghe7Y4cP14f/FK8FWU2pT7vSa0nFXrZlBA2U+I/uKfq?=
 =?us-ascii?Q?r6Pn1Gz9PyhLfVcJTwpZi4fnnP6Iv7GI0Df84p0Bqp5eUzsbyvduC79HL1zZ?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9fb40a-605d-4a68-7522-08ddc40c9115
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:00:41.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVw5eWr2nZgWvf1WUIFZ8ui3y+frC9xxGSyLTlHEaisaGa8o2kFf4yCQLufIx0WHeGxidPBexMS56IB8glb5ftfQ2S7fJcSK7F7aY59juQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6205
X-OriginatorOrg: intel.com

On Mon, Jul 14, 2025 at 03:35:21PM -0700, Dave Jiang wrote:
> The current implementation enumerates the dports during the cxl_port
> driver probe. Without an endpoint connected, the dport may not be
> active during port probe. This scheme may prevent a valid hardware
> dport id to be retrieved and MMIO registers to be read when an endpoint
> is hot-plugged. Move the dport allocation and setup to behind memdev
> probe so the endpoint is guaranteed to be connected.
> 
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> ACPI0017.N device. Through that it enumerate downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> use add_host_bridge_uport() to create the ports that enumerates the PCI
> RPs as the dports of these ports. Every time a port is created, the port
> driver is attached and drv->probe() is called and
> devm_cxl_port_enumerate_dports() is envoked to enumerate and probe
> the dports.
> 
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()
> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
> 
> The last phase is creating endpoint port which happens for all endpoint
> devices.
> 
> In this commit, the port create and its dport probing in cxl_acpi is not
> changed. That will be handled in a different patch later on. The behavior
> change is only for CXL switch ports. Only the dport that is part of the
> path for an endpoint device to the RP will be probed. This happens
> naturally by the code walking up the device hierarchy and identifying the
> upstream device and the downstream device.
> 
> There are two points where the interception of dport creation happens
> during the devm_cxl_enumerate_ports() path. The first location is right
> before the function calls add_port_attach_ep() where it does the dport
> allocation for the RP. Once the dport is allocated, the iteration path
> is reset to the beginning to try again. The second location happens
> in add_port_attach_ep() after the location where either the port is
> discovered or allocated new if it does not exist.
> 
> Locking of port device during __cxl_port_add_dport() protects modifications
> against the port and its dports while multiple endpoints can be probing at
> the same time and the same port is being modified concurrently.
> 
> While the decoders are allocated during the port driver probe,
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.

Appreciate the explanation in commit log!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
