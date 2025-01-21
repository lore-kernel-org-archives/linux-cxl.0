Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6154764
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737501285; cv=fail; b=oYg0u3La9iH8/lhUOmIv433ak0pGtOrVZ+55tEpsrvGIypnnU+lawL5KWpQmLuePIoX8aCUQhFPuRsZ4JgvlZcaSHQXlNqu/clOpYU81QyvueX4VpHu8431IlM5LEOYTAb7CKqUDVuOSGL5RZkHKH7fY6dXA1z9221W1Qih4q+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737501285; c=relaxed/simple;
	bh=gCzRfIoEROXv65cKksgSIwOofPVJb3Cad75aAWuzN9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gVRppv7tsyAHZPTF5wI8ARgizpG6P5GcW7NGQoN6sUeym7HR0rvklT+fyL07TNuIlkJMJnuShh2PLzWmPltZiJFvtMuQs/yRADZ8cJoD0n0LLRJ5f26mei64ylueVWhKL0OBM6kOWFits+6zLhv++9YaU9e56UyKm9Ld/dGUyxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/Wkj7iK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/Wkj7iK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737501283; x=1769037283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gCzRfIoEROXv65cKksgSIwOofPVJb3Cad75aAWuzN9g=;
  b=R/Wkj7iKbUu58uxrzaiRdgl0NVYHQbZW3GcloU0Zt0dFJT0qD56knYF1
   PCQdi5yqcqTtO/5EQzeDNrj+5AgusJCwf4Aybx7BCzG6eiOm213Ppocs4
   U01SnJoo84NHWrm11qQ/LFRxvEtuuwg5j/FSxLGUhl643kHZ1toXmkQfp
   BIhKt1/7Sm/CaZ+/7JZyyeLTQyxXhehoxhEJFikB+ZNZmyQ60w8WvNLq6
   5PHb6TO+i/6W3iTpCUMLs76hct4fMeMQBi6/6Ccx9QjIO1aurlUoPu6Lj
   GGU9Fe5ymkFYlJI109AQRzQ1RkNljqYE6EJc5Fql+tag2pN7rmvsmMhoF
   Q==;
X-CSE-ConnectionGUID: PwlH/hkfS/mdIQq6/yqnBw==
X-CSE-MsgGUID: OeXGMiZ3QcW0PYVX0pA9qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37850250"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="37850250"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 15:14:42 -0800
X-CSE-ConnectionGUID: hW0pG8hwSIGY4HezASLauQ==
X-CSE-MsgGUID: Icd31Z8lS5Ccm2niBShfyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="106983057"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 15:14:42 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 15:14:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 15:14:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 15:14:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANNe32RZZwfALiVskRXxbFgWOs98DJQnPgI6wZae3JFSg50fqF/oCzx3pjArg/CF7UlPvimFsp8Ud0rhqelNdBYOsKz0cad320mV9FwUeEnZseABX/KAds+qjKQTERYPvdpzCIURxnsUBiMxnJ7j7u8O56kyaN0ftU69ZsKdZbt33hFb8a6lPFro8jxoP+Msso1+51KhjmwWJ3rVZLH8TtqB9IPBKBkjhLqtoYREBZurky14MGuSpjuxY5y6nCdhz38uqPHR1trx9X/WDLXXb+Rw8DrGz4yRCVPaCkdtP/uq3BmhASAVo9aDCIFnZUHCfHiJmri+eww5bUjw0ta0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7SxaGg7Zjq6x1D61BmQSwEkUtAxcp1NFRMjaCGZov8=;
 b=RKsEf++WQVJIiApY/aaxkWT31omkJu9s0haQYUOgvTedixGXmINxLNrZHL2S+pDEmwC65JzSqj9hlBWg/H70y561vSSq8u0DodaKOw1TYMYX80TRRI7FRykYm3Kz3OvJOXj9h3zt9iFli/C/rbl5HL6JxEvd7AJmswW4VuGyFicN6BYYNlxyexcBEbyYD2105LhCVk7FZ286qCZsrc9TM/SShTOapo+M3jXURPKoJkKRkOvSaE+wzn+wfP94QaReSe8SsMJ7SscrJPgziwImppV3I8S0RY7BHlZ53sRTkNY4x/ATZLyUtPaUu8paMIyoICTGj0uxpbSwLyQ4tC9AsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 23:14:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8356.017; Tue, 21 Jan 2025
 23:14:39 +0000
Date: Tue, 21 Jan 2025 17:14:35 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: "Fontenot, Nathan" <nafonten@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<linux-mm@kvack.org>, <gourry@gourry.net>
Subject: Re: [PATCH v2 3/4] dax: Update hmem resource/device registration
Message-ID: <67902a5bc53eb_e5f72942b@iweiny-mobl.notmuch>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <9a41f91ed487ea64e187d84fab3bd69a4a5862f9.1737046620.git.nathan.fontenot@amd.com>
 <67898815e6280_1c3f7529466@iweiny-mobl.notmuch>
 <fb3eaa1e-0c87-4859-94b0-373ba50e4d78@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fb3eaa1e-0c87-4859-94b0-373ba50e4d78@amd.com>
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 088d74bb-abff-4abd-50a8-08dd3a71612f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m0ieprDGfq0QLd9Oc4tA38i8P9Rk1lqo+ye+Q5/DryMLDty8kUvQmPL8Ncd4?=
 =?us-ascii?Q?qCxVlot9ukvyba6hB0vCu/a0KUFTEb6OPyFj8LER1R8pUYmDvLmRaN5SXsXo?=
 =?us-ascii?Q?1P5dBueFnyq5MNIG0xl/wV4SX7e5OWr702AW7oEsUSHpOTpycQnbYhOytMOc?=
 =?us-ascii?Q?5gVKBllvIRLwgWTmigJmx1renVovkkRfxBSH0LBkZkbYUx/nTJlJDG3/T6xG?=
 =?us-ascii?Q?rOBptD8+3bKIwBcPISgM+tK+zTSIE4jDNIAoupT38LkJ4g0xAQTs2ZA5knPc?=
 =?us-ascii?Q?rgRDrZyCIAEiBwuT68YeuBupsarVZ79m1OJMCKjHpHpFZxJj5OUJpMpPy4Hg?=
 =?us-ascii?Q?XJAonC3ngXm+Fr+AEoULzKKj82jtL2QKQT5NnLOGRF2Ze3vlDdoGwB8+hXiJ?=
 =?us-ascii?Q?7OXvmzzB50uDd4Znzpi18M4Xxc3O1d986Q9NPOFGakN9BvCwMg3GMmaAAunl?=
 =?us-ascii?Q?hAmNLvD+ozML9wMk0/7ay0dMiOzSFp9yYD8c/VesVIHT7l/nw5j6oGL0FdkL?=
 =?us-ascii?Q?w29ViHHuAUnmOJB2dXyNUfPxwri3MXY0cFa1F1q1/u0ec6Pm1n1hTKc9OQrk?=
 =?us-ascii?Q?/hrCoUmadHRGiDpIByeINYiexwbs9tTz5alQt3W+xIPoQnM7TwVJKkyjTOJP?=
 =?us-ascii?Q?WyzN3rJ7aJk3aeBPBc1ESfyCbPM3eT8H9AT7b35IPLAwr8+el+3mYDyIHuYz?=
 =?us-ascii?Q?6cIAZz49KAt2ACpKtCrevp8MXqLVa3BEXaYqChvPPIlMnaqKWSedxJDkJ3zZ?=
 =?us-ascii?Q?Eeovgu6/3AL98SqiXnkKmOLmrsRNaa4NayJraQax16+EAlfh3iS3fkfd5FTe?=
 =?us-ascii?Q?HNPiCj1RZ9TPWSpe/AaGqEaIbB9RTC9X0W2joAQU0uEeg+MKLshxZ+gOLq08?=
 =?us-ascii?Q?c7NfyIGQZ8ApbNSTG1eRDjMmlFHYVnwvD4zcA91r5Im4psxv1bv5YiGiqZNG?=
 =?us-ascii?Q?C1anvKQbaegUESHAmuhK3WtB97KPR8/gKFInyd6sFfJ5HPLRV6Vu1iPO7OAk?=
 =?us-ascii?Q?a4D/EJCBauwnrIg4nNKBetxXqsUomhFAnNVHairximeCB82c53f1aneou7dF?=
 =?us-ascii?Q?0P2s+MJnDyKhMsVrvQ5wW2zNHVt+zpW2U2VhSfpxGZnGvz6+Myskh3kWYjxY?=
 =?us-ascii?Q?fIWkW6C0Tvq4B5ycNCKlSIH3qsiqO8I92+UddRF3rxC94894CMK91LowcGVV?=
 =?us-ascii?Q?0ZwDbn61Q2Du+Yl+cb0185Pf/aLVbO6S8rEswHWbB8qGFXjnVV8FekkcPMrd?=
 =?us-ascii?Q?ipWHiRgZSIdYmBd+7MKevc6WWPkpEk9XxgyLpHJ2T0QY/V5NRWpVu1Ai8k+4?=
 =?us-ascii?Q?1HjSJ2MExo2lX/ItEIaP9nC+lDfpQfEP+As5jvcKx4fqr6en2yLlf4/vdHDc?=
 =?us-ascii?Q?/Ay4p6vmV4NyCulH7du2F9+UZ2l7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F9WGxko4lLQb/62MUviiHHfY3Ug+8L2WQI5tVNe2d1LQXg4HnVYuOUyBRwix?=
 =?us-ascii?Q?2CIO8J+Vd60BfBk1cLN9R1wE7mh6XM/F1LFKaumPsG5jTrpb9Ov2TxvIndrw?=
 =?us-ascii?Q?xGuvXHCjdq0IkzvbKGI9a1FXZvHTGcdke97CmxuqgMLLJMD6hf3+ETs2tfd2?=
 =?us-ascii?Q?claSkpT4dL/qruf2MQGIfmkBiONRm8apX2ZcSnamDBoOH/Sj7QZynhOquBsr?=
 =?us-ascii?Q?X0qA7egA/5CKFTlMPOGSRmCwEEj1wvKaWt6fhbuXLzFvMpJ7b2tevQ1ZK3YL?=
 =?us-ascii?Q?xNvvp7JmQo/hGfnDezyiv8lIS+XslGy7AD13MkKfB48+6VlgnebfEcBlRi9c?=
 =?us-ascii?Q?zJ413VKJdOK+lMU6hv7UL9kY26ilgTDszZz0XYMfZ3XERhXDzb5Y4oIVAU3T?=
 =?us-ascii?Q?96nz+s5qU/fSaSazbdwxGTcc3EuK5SFmYzRfbcFShzBS250BGOu7ghqB08RN?=
 =?us-ascii?Q?T4GteR7n9O+Skob+TqIntjT6eiSM2qDqdEdx9CWxbk1Ntv6FrCw5hzy9kPV+?=
 =?us-ascii?Q?1ct9w2mdqaiNdFVvt2DsXxTNgwvDYpdAByLz9E0hlZs2kgVENFchiBTXfwsl?=
 =?us-ascii?Q?JlIf7Bzp3UG7lslYhXCesNsrjZzWOiqnuFBlOlKFHiSaiX19PN6QUGvO829Q?=
 =?us-ascii?Q?FkFZf9Lys/ZMChyP/JeGHIULsM1pSdQlnVXWFDcfRxiIQ8ikKkmDjL4jLxD5?=
 =?us-ascii?Q?Ik9bQWD/XMWBRwBbajqLlMVj8KbownAOQabnyUT4TGmX/tV3PISwylOJW4m0?=
 =?us-ascii?Q?yiBxrx5oS6n8l/Ru1EioGy4NR6mnKcEFu8mBBGLLNtZMxDRr/48RmkhoaDpx?=
 =?us-ascii?Q?aclXSRPY2TX72nLBQWDKnNWyaIo4tiEK02dzeSB73MUUvuYN54typLrM+Q9b?=
 =?us-ascii?Q?We+KrR8kIIKrwqDipHm+GAOwNBaKJPcYTi5bzhojHEpI7/WVkwEP+6x33GhY?=
 =?us-ascii?Q?XQvDCszwYvQP0CqBNriYTAUtGkbTw0OJvnMEA48YPzkmKyre+mL/wGpKQCAg?=
 =?us-ascii?Q?c25v8JJf1oYrmF7yYiNRkjalquSPK9Gza37CvJSAOVeEqBq5K2ENapbYV+2r?=
 =?us-ascii?Q?ZDwiCGU/4NiNtgHcfvuenjGWoUE5ItWRMdaoBNW+qY2upjK36Zo/p9rZ7z96?=
 =?us-ascii?Q?Yz/cOm4J4V/m5pjB52YBnjF+eqUFtW3xLFRou4/IAU3cSe0F+qDftD+9VpXX?=
 =?us-ascii?Q?YXFZScBN2S9lhS64uUmoRT5Z9K2uiEZx5Raq6/SPyYKugnsTlEwAPtT9qUlX?=
 =?us-ascii?Q?lxsELTxle3J/fB8hyU11AWxroqe/BygTvnpK5lj4KKbnGeL+tKBOanO8T0hJ?=
 =?us-ascii?Q?Gc3H7SyZeqAWcoNpnrCqXVWneuD4sb8Yq78Z2/xxP9be1ThbM1kt1xW+xMuZ?=
 =?us-ascii?Q?niDvqZdtX21ZJRkwbL4pG1xNnCef+7jqLHnHsE1mNVlzM2ymS/3CsinnzJ1S?=
 =?us-ascii?Q?xEu4tjwSzBImzt8BvAbDidDevd/RE76lJy+eVHA22VI1vqnBdzq40+v/Le2D?=
 =?us-ascii?Q?aS4JG1cfI6beSJ/LmTlVtzUdT6j73NeiOTa9qlosry6mnqsPmQK+2fjTrWj6?=
 =?us-ascii?Q?qaxykIjRyFwaU8hgvX58rUnS5gtsynjjEnJ9gf58?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 088d74bb-abff-4abd-50a8-08dd3a71612f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 23:14:39.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW1kxHw2bUY9T6hZhkvu+Dcp5nojsaTn/M76GOgRVFcU+vo66b0GuB1q5rGtwC2Zkvs9gXugweBi57Gve/jX5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com

Fontenot, Nathan wrote:
> On 1/16/2025 4:28 PM, Ira Weiny wrote:
> > Nathan Fontenot wrote:
> >> In order to handle registering hmem devices for SOFT RESERVE reources
> >                                                               ^^^^^^^^^
> >                                                               resources
> > 
> >> that are added late in boot update the hmem_register_resource(),
> >> hmem_register_device(), and walk_hmem_resources() interfaces.
> >>
> >> Remove the target_nid arg to hmem_register_resource(). The target nid
> >> value is calculated from the resource start address and not used until
> >> registering a device for the resource. Move the target nid calculation
> >> to hmem_register_device().
> >>
> >> To allow for registering hmem devices outside of the hmem dax driver
> >> probe routine save the dax hmem platform driver during probe. The
> >> hmem_register_device() interface can then drop the host and target
> >> nid parameters.
> >>
> >> There should be no functional changes.
> >>
> >> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> >> ---
> >>  drivers/acpi/numa/hmat.c  |  7 ++-----
> >>  drivers/dax/hmem/device.c | 14 ++++++--------
> >>  drivers/dax/hmem/hmem.c   | 12 ++++++++----
> >>  include/linux/dax.h       |  9 ++++-----
> >>  4 files changed, 20 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> >> index 1a902a02390f..23d4b3ad6d88 100644
> >> --- a/drivers/acpi/numa/hmat.c
> >> +++ b/drivers/acpi/numa/hmat.c
> >> @@ -857,11 +857,8 @@ static void hmat_register_target_devices(struct memory_target *target)
> >>  	if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> >>  		return;
> >>  
> >> -	for (res = target->memregions.child; res; res = res->sibling) {
> >> -		int target_nid = pxm_to_node(target->memory_pxm);
> >> -
> >> -		hmem_register_resource(target_nid, res);
> >> -	}
> >> +	for (res = target->memregions.child; res; res = res->sibling)
> >> +		hmem_register_resource(res);
> >>  }
> >>  
> >>  static void hmat_register_target(struct memory_target *target)
> >> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> >> index f9e1a76a04a9..ae25e08a636f 100644
> >> --- a/drivers/dax/hmem/device.c
> >> +++ b/drivers/dax/hmem/device.c
> >> @@ -17,14 +17,14 @@ static struct resource hmem_active = {
> >>  	.flags = IORESOURCE_MEM,
> >>  };
> >>  
> >> -int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
> >> +int walk_hmem_resources(walk_hmem_fn fn)
> >>  {
> >>  	struct resource *res;
> >>  	int rc = 0;
> >>  
> >>  	mutex_lock(&hmem_resource_lock);
> >>  	for (res = hmem_active.child; res; res = res->sibling) {
> >> -		rc = fn(host, (int) res->desc, res);
> >> +		rc = fn(res);
> >>  		if (rc)
> >>  			break;
> >>  	}
> >> @@ -33,7 +33,7 @@ int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
> >>  }
> >>  EXPORT_SYMBOL_GPL(walk_hmem_resources);
> >>  
> >> -static void __hmem_register_resource(int target_nid, struct resource *res)
> >> +static void __hmem_register_resource(struct resource *res)
> >>  {
> >>  	struct platform_device *pdev;
> >>  	struct resource *new;
> >> @@ -46,8 +46,6 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
> >>  		return;
> >>  	}
> >>  
> >> -	new->desc = target_nid;
> >> -
> >>  	if (platform_initialized)
> >>  		return;
> >>  
> >> @@ -64,19 +62,19 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
> >>  		platform_initialized = true;
> >>  }
> >>  
> >> -void hmem_register_resource(int target_nid, struct resource *res)
> >> +void hmem_register_resource(struct resource *res)
> >>  {
> >>  	if (nohmem)
> >>  		return;
> >>  
> >>  	mutex_lock(&hmem_resource_lock);
> >> -	__hmem_register_resource(target_nid, res);
> >> +	__hmem_register_resource(res);
> >>  	mutex_unlock(&hmem_resource_lock);
> >>  }
> >>  
> >>  static __init int hmem_register_one(struct resource *res, void *data)
> >>  {
> >> -	hmem_register_resource(phys_to_target_node(res->start), res);
> >> +	hmem_register_resource(res);
> >>  
> >>  	return 0;
> >>  }
> >> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> >> index 5e7c53f18491..088f4060d4d5 100644
> >> --- a/drivers/dax/hmem/hmem.c
> >> +++ b/drivers/dax/hmem/hmem.c
> >> @@ -9,6 +9,8 @@
> >>  static bool region_idle;
> >>  module_param_named(region_idle, region_idle, bool, 0644);
> >>  
> >> +static struct platform_device *dax_hmem_pdev;
> > 
> > I don't think you can assume there is only ever 1 hmem platform device.
> > 
> > hmat_register_target_devices() in particular iterates multiple memory
> > regions and will create more than one.
> > 
> > What am I missing?
> 
> You may be correct that there can be more than one hmem platform device.
> I was making this change based on a comment from Dan that it may not matter
> which platform device these are created against.

If that is true I think there should be a big comment around this code
explaining why it is ok to have the platform device being allocated in
this call unregistered when a different platform device (host) is
released.

IOW hmem_register_device() calls two devm_*() functions using host as the
device used to trigger an action.  It is not entirely clear to me why that
change is safe here.

> 
> I could be wrong in that assumption. If so we'll need to figure lout how to
> determine which platform device a soft reserve resource would be created
> against when they are added later in boot from a notification by the
> srmem notification chain.

I see that it would be more difficult to track.  And I'm ok if it really
does work.  But just looking at the commit message and code I don't see
how this does not at least introduce a functional change.

Ira

> 
> -Nathan
> 
> > Ira
> > 
> >> +
> >>  static int dax_hmem_probe(struct platform_device *pdev)
> >>  {
> >>  	unsigned long flags = IORESOURCE_DAX_KMEM;
> >> @@ -59,13 +61,13 @@ static void release_hmem(void *pdev)
> >>  	platform_device_unregister(pdev);
> >>  }
> >>  
> >> -static int hmem_register_device(struct device *host, int target_nid,
> >> -				const struct resource *res)
> >> +static int hmem_register_device(const struct resource *res)
> >>  {
> >> +	struct device *host = &dax_hmem_pdev->dev;
> >>  	struct platform_device *pdev;
> >>  	struct memregion_info info;
> >> +	int target_nid, rc;
> >>  	long id;
> >> -	int rc;
> >>  
> >>  	if (IS_ENABLED(CONFIG_CXL_REGION) &&
> >>  	    region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> >> @@ -94,6 +96,7 @@ static int hmem_register_device(struct device *host, int target_nid,
> >>  		return -ENOMEM;
> >>  	}
> >>  
> >> +	target_nid = phys_to_target_node(res->start);
> >>  	pdev->dev.numa_node = numa_map_to_online_node(target_nid);
> >>  	info = (struct memregion_info) {
> >>  		.target_node = target_nid,
> >> @@ -125,7 +128,8 @@ static int hmem_register_device(struct device *host, int target_nid,
> >>  
> >>  static int dax_hmem_platform_probe(struct platform_device *pdev)
> >>  {
> >> -	return walk_hmem_resources(&pdev->dev, hmem_register_device);
> >> +	dax_hmem_pdev = pdev;
> >> +	return walk_hmem_resources(hmem_register_device);
> >>  }
> >>  
> >>  static struct platform_driver dax_hmem_platform_driver = {
> >> diff --git a/include/linux/dax.h b/include/linux/dax.h
> >> index 9d3e3327af4c..beaa4bcb515c 100644
> >> --- a/include/linux/dax.h
> >> +++ b/include/linux/dax.h
> >> @@ -276,14 +276,13 @@ static inline int dax_mem2blk_err(int err)
> >>  }
> >>  
> >>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
> >> -void hmem_register_resource(int target_nid, struct resource *r);
> >> +void hmem_register_resource(struct resource *r);
> >>  #else
> >> -static inline void hmem_register_resource(int target_nid, struct resource *r)
> >> +static inline void hmem_register_resource(struct resource *r)
> >>  {
> >>  }
> >>  #endif
> >>  
> >> -typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
> >> -			    const struct resource *res);
> >> -int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
> >> +typedef int (*walk_hmem_fn)(const struct resource *res);
> >> +int walk_hmem_resources(walk_hmem_fn fn);
> >>  #endif
> >> -- 
> >> 2.43.0
> >>
> >>
> > 
> > 
> 


