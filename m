Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AB29B8E5;
	Thu,  8 Jan 2026 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850960; cv=fail; b=WxzW26G2I2ofVcFeko2woK9GX3yqHO5MWRQ+nZxE+yvT7vA77qc3gzMQx+SjvRIJ7qg2i3cz5diCu6aqmpePlgmwnuZsJ8fWrEQ68fl4oyssE9lYjNhpmMUhkN0/Sfm+6bF4xg9uhIpjUDRREtvo2P2Esq5AXUGj4P9DWyaINiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850960; c=relaxed/simple;
	bh=5hdtv4PgYQBee8ob69DCnTQA1Pf/z9f5UYlLqICvyhE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gfYtzPPtrxmrHELPo+J8Te+mKpziKdRwX23HqEt8A7P+d3cLCCCrrMHv09L2k3XYPStUwJKjVMu+x+grd4J2bowLvtTWginRTRLmTeyhR6ztswsdS2LM+hktAMAFXaOx1BHNvjxU3CqyRyaNdPixlxc+I31F5pRYqshB4VsmKMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMANyyDm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMANyyDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767850959; x=1799386959;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5hdtv4PgYQBee8ob69DCnTQA1Pf/z9f5UYlLqICvyhE=;
  b=jMANyyDmZuS3MQEhf13A8i2ZNpNG3DyvQcFv5ljMcmNQaUVG6mgOOx4U
   zsThHnQb7P8AJm3G2ww5vdSofI3aqOLTk7Spasb9czivK92WcbwtiUu0j
   DuypRFtYE/U32KntYyNLsk5u6DpyHWHZpgX82vhsYVzXrgH4Rx+h9ifSq
   pQZXhvmNo8xWnT31M8SAJkzNSdOdVjETL3W8GQfukXS3UyyN5+1J/dO0w
   4GwhTeQLxlIij5Chy99Mn0gmOBbE7W8oe6VGRwEIkon5dKDmq0XxkQzTG
   SVKeUufKxQ1wzAAfopg1qeLq8UiCMokkAhu9uJSlRHsQ5geoUTgdFyOqS
   g==;
X-CSE-ConnectionGUID: P3x0kXSHQe+SoYXCDc5z+A==
X-CSE-MsgGUID: FFuePa5NSLm9T6YCBtafig==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69299421"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69299421"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:42:38 -0800
X-CSE-ConnectionGUID: QT9OJIR5QQCJpnz/ufFKig==
X-CSE-MsgGUID: 3xKPm8IqQ3Sgzd/uYFFhgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207253856"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 21:42:38 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 21:42:37 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 7 Jan 2026 21:42:37 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 7 Jan 2026 21:42:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbecN8l7V+Tu58PLSxDF6ntjxi7dG9r21L0RY0+PE+CJTgcwz2y8hpQ6iFcMvKSFFXSChMEbNLi1xhDCSzH51vMy0kVfTPrC118DR+qp2mLmUBO1YyL+gnigarw24MK7e9PLOLrl0fzbFseAX1zIXU0PlKaKjJBZejvfSZx3SxSBMRFPRkhou0Vg2sEaJ4ecb+ZezvDZAmJgNs+DNeZtDlDSUkJSr5hVstltgczrEAHKk7/+18oKtnCSRrA9Y+9DJFcA8dAcfrLA7f0Ncw8PvW9hUCzo7MRqYaZKJRZkf+IeJ89pY2gv//yZFZQyoXZ62reeELMLk42I+AdmEu0peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95a20ktfUnTlkdu9O4Bqa+lrNrqiOiiuRAJsGguc5l8=;
 b=GImcCACSG4P1ZUFK7J7ryIgKlDJZdbM+fOwMUpwHMPULcRZmaf9haIU9S5TpmX+Sqx4Fxi2OmWS2aUExxANkYrjcp35cFra7CT5NKFZpbSrLQstrY7PZ7njdJzcigO6dHe2YmhBKRCyB9oTp/N4SNWLvI34Y0/4r9vNUBhCJ5TwjuPM0PRilGQDyY+NdLyYSrZ4LPGcXhDsUhv90auEIhg9+w2RPuDoDkq0LcP4Jw6gLBdTyOVnSuEQGAV+02aYVx5TXnFEUiQpLe4XA1yx9/PWdso9taY1QYNuqcAiDYCvVAPNjoT2kBuv6d3MBZPi7nRbv1/OumPU+pSl8C4+vfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5006.namprd11.prod.outlook.com (2603:10b6:a03:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 05:42:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 05:42:35 +0000
Date: Wed, 7 Jan 2026 21:42:31 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <corbet@lwn.net>, <rakuram.e96@gmail.com>,
	<alucerop@amd.com>
Subject: Re: [PATCH v3 2/2] Documentation/driver-api/cxl: device hotplug
 section
Message-ID: <aV9DxzUfDzX1rtQO@aschofie-mobl2.lan>
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-3-gourry@gourry.net>
 <aV3CsPl8Zsp5JtGu@aschofie-mobl2.lan>
 <aV6BqOarpY0PUt7h@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aV6BqOarpY0PUt7h@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abd593d-371f-46b9-d9ee-08de4e78b98f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jaE/E+x6MFzYsLBRuXbWoKBk8ouoov9jsDDenDmTG0RnldbgsnttPIpy4Teb?=
 =?us-ascii?Q?/wfetF0ojvyf99aFNfEj3bfmO8oosjXRvcX7o8L1GP9NMTQUjLKGkSkX7qdn?=
 =?us-ascii?Q?LWpDBZ+kUJFh5OISricfHIwrryDwEHVKxIH9Iptc50V95XQE9CGZMB9U+ZNN?=
 =?us-ascii?Q?JZyq1KGmiHKQ8v3tnqC0EQxOnHElSU1QlEUIVcFMLbRhVR255XoVA4cf0xNA?=
 =?us-ascii?Q?LUbXB743fvoU6YsagliQLusRHoF0mfo683FEkHd4PvYMu1WehFrcql8ZUcn9?=
 =?us-ascii?Q?PJjxBN/Ps3/o/qid1KQQONgSIz33MlfoeuEkgfYXUz4+MUV9FCxe5xPe0bru?=
 =?us-ascii?Q?Yy+R2QVs9J66BZOWeSfdjJN8aoxcl3fcDP1c68Zbiyu3i0cdqY0H5esCb1jd?=
 =?us-ascii?Q?V+aECNoNXa1iVxu+xoiXRZnQ6RfQf98oE2uX5I133JrOdEffPyBArJ/+77So?=
 =?us-ascii?Q?Ly7U+iDFKATjvm1Fg5grDLw6FgW1vpSZy3S0jY1BS+RLQRGb9g9ppxYa1JQS?=
 =?us-ascii?Q?rERoUqepadVb+yv4+OdJ67BddnYE67cW8FrwYyep09VL2RZ7fivlL2bBF1sx?=
 =?us-ascii?Q?ZzC4H82IQ9f99dU1Y9Jn7sQyOipWIFbACyR/VnqiehP2cUohzcHFM5arj02k?=
 =?us-ascii?Q?q66abn6xjV7meieJ+R8bVoORESe7eITZzI76fJVrRdgdIPNwqd11BzM+lz1z?=
 =?us-ascii?Q?R0F2TW/YisxCysO+c5aJ7mbq4OBlYFW86hfrQ6X+nhqCqeRSVTKKYRWzP2Mw?=
 =?us-ascii?Q?6761nPu1lwcAqvzM1FiAjsWyd4V8C4UPf57A8neNp8AXhos721Mkr7G+fg6A?=
 =?us-ascii?Q?zK+IDY06YVVssgAd+CNkDfTH0BCC6pU/b25ppa+qARxI+TsuhOj3mhlDX1UZ?=
 =?us-ascii?Q?OmBojnw6rgZRfYLtZXBpzwJNtzC7NaSLLLXAD90OJEnmnowLLuGelpFKaabz?=
 =?us-ascii?Q?Uj5M3Jvgl9EQP7N8zflDaYHMR29KyqcSF4567Hjy253MGrDMF4JRnFefnzl/?=
 =?us-ascii?Q?5KuuN63zdbFkKLFl7OWozfL6E0MVD2RRKeIxOXpSTegIpDtMp/E0YZMGnIXP?=
 =?us-ascii?Q?TaH1xtF8OEUwkGfqQbZe9zY7LV0m4+4IXXybSJHZoDzvfOKhwslxN0Vd/BjJ?=
 =?us-ascii?Q?1fmK2Xc/by+DQTsI0PlkTARHcApLt5mMIBrkEMqlBpwYy9sZqT9w8ucq5JSn?=
 =?us-ascii?Q?ZtOODKoj5AgYks7zMeHAahAPaF/C3saQWXYB+8f6SIYRugH/EFNroWJ3Olxf?=
 =?us-ascii?Q?rOdASdVAtWlBMyMD5jC//ywIDrXDHymwgwLgYya+rt+8MwkdUxo4LzU+G94c?=
 =?us-ascii?Q?1C1BKiLK+WwWIFaaaTDhuhq6DMlGxDZ3URtHOGj6BYqZWU0h/GfNVrOgFS9l?=
 =?us-ascii?Q?2v8GHCdcuzVLkzLw5eB2b2peKuogJ+QJhdDAdEJTOPeKoTfr4EBkcZmR5itc?=
 =?us-ascii?Q?qbKOXdPZrkhuFI2EJk0Ib+LD8+U7tQbK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCPS6vvwIdYK0aImUegIslcs2J9+vfA+bhsdvhOGIt4ul+eZK1Xe78Pty9HH?=
 =?us-ascii?Q?sl0HWVXeI787HT87q5gbv9p02ourytBE4rR4YWK+RYEpjE/9jkIJIW+se5vX?=
 =?us-ascii?Q?yLzSldh3h+31TKo1mlwVCDuLRvctsoPDMnptCiS593ckCMjXpwx6QjDl1p0k?=
 =?us-ascii?Q?jpr3tpZySZ4m0vjlKJiFdMf/F+LkUJTSaY5WgrUINuMiIPQUkqpQbeqYt6Wr?=
 =?us-ascii?Q?BexLCCySiPXI0Lz7mQnRrJwhggrEHurQR1HsFba1f7XGvtLo882lsJQ+Tgx6?=
 =?us-ascii?Q?lYhU1M+/BKr6i6fMAHMJn61REYYT8jA2ZMxtP4mIIfHPtyppqAASOBuAbvsk?=
 =?us-ascii?Q?+AgeQLVG/F5T7jpIS1KpPKyVaclcHh+nzYo+qjGP9vrE8uaO//yR1w86G6nf?=
 =?us-ascii?Q?21DEA3jOjOOQ5XSK2B3bdJ06352rKtVZpHGXUwC4ORW3uv5NuVBgWjtPZPL4?=
 =?us-ascii?Q?7B87X71dU6H3dWDdZD6fMGVtVrZQGyglCJxFZAlfSylVAbh1iODasmD+khu5?=
 =?us-ascii?Q?cIATHdUnEzV4Dm+PodeVgH/P1llcX0j5OmjvEV44E3Zko5qCPqCSLcyWA15Z?=
 =?us-ascii?Q?XSX8ngP+FiKcy3KOQVnofPUL3tEhx1r8XCSyhAGRDO6epZqstjyWsJfWmG0b?=
 =?us-ascii?Q?OwPiQfb7heU8NXJ9SAwoZIxhG/tDuIHpj4fGS1YKhdt4ljiViCq6zlK+vjgI?=
 =?us-ascii?Q?ws2Iu5Qa2++drBXanqvxa5Zk/5hik/jtN7X951xFO0bW7zA6QGql3P1EEcJ2?=
 =?us-ascii?Q?PWnhhNdRBo4Sfdhw7JFxPPeh8IFrD9YmgskGrBQz7hcwLEyTcPET/ZNUjyTz?=
 =?us-ascii?Q?1DScvWkFeZJHDNFwrFhL2bOkvwSRQjNhBMKgukzpKCsDE70X49JoEfJvuHSY?=
 =?us-ascii?Q?L2ys5kGxnmWECRufHmw9JF4mzht2lRTmdoe5sIH88c6Y406sXrwvgQ4nlCd6?=
 =?us-ascii?Q?lpYvS2u0pTJSU7xS+4kWkCWIxy95orYZDf9kKBUAwiTaLFRTyicoIZ6LTlJU?=
 =?us-ascii?Q?jXcQKAOFN3i6Ba5OyrxAnhhDn0SNWPjYEkN2x8H4qHBVEuAlo3OvXgrUQEZK?=
 =?us-ascii?Q?5dBXst6EPFM5gkd0PVK+DUjM+N7QYsqizkKjV3F8EkQ0CAicf4KYIIab7p3V?=
 =?us-ascii?Q?O0P4jrJbiFAKz/84A2piR5Bv9i9u27QmVaiWVU/RrcjNB/vvajFmdGAIcKTI?=
 =?us-ascii?Q?qwUJc/YVCCro9hZz3xkOsefN8rCH4muCy5Pj5JfNf1jeziss8f6V8j3IK73M?=
 =?us-ascii?Q?CAI0fteUc9ef4YEmmsKM4foljKD1mexAOrpCvOIR4vr1Huxyxh7pMmG8Aq0H?=
 =?us-ascii?Q?UKCBg3ZyoH77wb9uJcIQGS61QXRgvr6E5RasfQaDuM8nXJnur7mTE66wa4fn?=
 =?us-ascii?Q?LX7f4KAV2WDI7IHOInkB8pNwLuwDuOP91HEidETJ7Evwkl9OjEP+iHapqGpi?=
 =?us-ascii?Q?Z1FU0u3l+CiJfFdIaqrWcaC2RYmayb03QHbBYOEHScU91QGWNj6jyc6TEusZ?=
 =?us-ascii?Q?O12vuxNp2bslJpbEwlVZ6xI27QSIGizwjjl4CqXBKaHmgV5bMWGb+5TpEAN0?=
 =?us-ascii?Q?vDMvaQ6S7jGjPH0XmwAVwL8ul6FjQemrvuPLs+eaQ3JlucU1gFo/IcDm+Y3/?=
 =?us-ascii?Q?yLm9FS7o4YotzMlpeZj4FGN+kEZucD7lp9MjLs+5w6HV6YdmbXJOIl1A5FlP?=
 =?us-ascii?Q?3Yny50zfjBY4O2V81hQzi+tweG4SjamLSB5afVBBT1xdPvgx7DTIre4xKSY3?=
 =?us-ascii?Q?dZCCvYx8U5yH8FXjTDFGTCEdcInvkQ4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abd593d-371f-46b9-d9ee-08de4e78b98f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 05:42:35.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fb1Et4/HEnoVFdwzr8jwf5Q9DRnE6nEhw7WoO6UyPXw2h4prRYV/aH+txjB7722juMrc9Z2xf5U4od4uGmot1YtfCeNGpH8qn3LxbtM+V7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5006
X-OriginatorOrg: intel.com

On Wed, Jan 07, 2026 at 10:54:16AM -0500, Gregory Price wrote:
> On Tue, Jan 06, 2026 at 06:19:28PM -0800, Alison Schofield wrote:
> > On Fri, Dec 19, 2025 at 12:05:38PM -0500, Gregory Price wrote:
> > > Describe cxl memory device hotplug implications, in particular how the
> > > platform CEDT CFMWS must be described to support successful hot-add of
> > > memory devices.
> > 
> > Who is the intended audience for this doc?
> > 
> > Maybe it's already in another section not being edited, but I'd
> > expect to see CXL spec references.
> >

I'm fine with this merged. I starting to read it as more prescriptive
than it is wanting to be. It drives home the point that "You can't add
memory you haven't described in some way since the beginning of time". 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip
