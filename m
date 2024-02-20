Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A881509BF
	for <linux-cxl@vger.kernel.org>; Tue, 20 Feb 2024 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462817; cv=fail; b=g+q11b2Mp+CL4PWLOsEJ56SuRlOYYf0AlvXUW0gjRNedPcGc4PY+ebeMIFDvYFAViGbtH72I/ELcsI3UxBevjSXwQ2aOVTXpVQFHPXaKBTBMQw3Kt3v+dgjNwkj/EDgmwbCxF0M4hGjwUA2eXxGCPq8PYjdVoGNe9Vnc8Y98OC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462817; c=relaxed/simple;
	bh=TMfXuLmKO1nFoy2yGeVZxCrNZGUENqklCp/MPgSp89M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qx/sDTW7aFZEh0JKXqtBDfBh+gjigwI7XkOge/CV1/NQnn2oH1QptGLZ8yZSD02rBvk+njUw4sn6W7pKdSDanofJ1VXEiMyTOkO16RDG3kwfekvDWepFfkp63dB2PrKTPrNS5GymOogqIzftf/MuquOvE6GFYVUSysVEasx6iwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuqGpXuT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuqGpXuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708462816; x=1739998816;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TMfXuLmKO1nFoy2yGeVZxCrNZGUENqklCp/MPgSp89M=;
  b=QuqGpXuTo6iSNG69TJ472+/94U9tcXHZOizwvS6QDq6fwcVz3McAysEu
   bkciyKtXV0tqka9P+N+Vp+uWdcOZyrVkoD6dU0NdDp3r1Y9D8thzlVOWp
   VRz5JA6+h58FD0YEAxy/UP9n9carxTEUH6wVA7VhV8irxr6uB6P8TFYiH
   dK33f7uXEM+oWR/YjXuMSDwAx95m/tj+D/OzzOOlqmZDdYgWvxTkexgOD
   qo8gLHxYhynOxwXK5h3ejatt/bOzf63dQ2VUdJTmSMqjQ6aKe6LxRzNY9
   CIsTEUIfwEuEP32te8Tz6v4zmxau6kw02S4km4WnqsSK7bYGoMrXQ/8LG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2453489"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2453489"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9509073"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 13:00:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 13:00:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 13:00:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 13:00:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 13:00:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I91BrFn0rVSy0QbsP+5uKFALkuS06oVDg2qIdow7kbvlUddi+m/6vZomBhgFpHtf1VI04Zmr/mwwnWCWEcYBNenJmLov8J4a7HlMoIhBXbptkeBZK/hamL/gw6WPZx+RiOSXJMVgtK+ATQfuFFuiQ4+D4TwBLJxr43W3ODmvdH/3tTUnqGCVYiuubGMemmD+1JEfv9syvGBs3ffqsj8AV1uMUp5El2bHUnBC0wdGnfdzliZEocrwISxCbtF55qsmrvoOC7MmNO4RVbsrMGmzq7gqj32nnoXMhVDppi0sXGBLW48qu4M6lPfyB1Ued+jdg4w5iP8ukSsP+ZXkjfp6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq/MOYsPfJSYQA7kErgnE3WZhs8jJFIaUVihrfjvgMo=;
 b=mAmmB9D8tUMpVGA45rkPtLrMa1Br0HCMvsSG29bprZMdopJiEFphKukKsLVwfCBTHpOtTkd37/WItwFSmUxn3Etid+6jWkBqdhAPQKMYbHG6/9gL9a3rknAuYIu6eRLIQGK3XzxYoOf1U7/6+z+Qszc20Sx9kH1iFs2rxy1zgF1q2ckmSSdbDH2p5w1uv+UKsTLY5AvVKQmhdWzB6GXyoR7BY6Z0SUOpqvEnQerKNkPhsGqjUR8uyQ7xs2a82MZbaJskY/x2Ih5Y2xOIyk8tAn/XAXqsuIqWZpEXVOVy7v+ltP9VYCH23EEJ0MluErGkY+rHXKm4h4nyjZM6Lqfzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5517.namprd11.prod.outlook.com (2603:10b6:5:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 21:00:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 21:00:11 +0000
Date: Tue, 20 Feb 2024 13:00:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>
Subject: Re: [PATCH] cxl: Add post reset warning if the reset is detected as
 Secondary Bus Reset (SBR)
Message-ID: <65d512d9f4f4_5e9bf2941f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240219142006.000056a4@Huawei.com>
 <20240220203956.GA1502351@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240220203956.GA1502351@bhelgaas>
X-ClientProxiedBy: MW4PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:303:b9::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fbfc37-94bc-47e1-e463-08dc3256ed9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJwpj1zuFRYWpMZzjdx+S8xbGuOhw3ZXp7FWt+L/lMmc978hQjX8M8qU++cnfefVnozqABx7ytKrYr8eXJv0zawzwJ45WV69qXCTpc7JcfLvpauw4mCT0cRSYM9cFOHT+nNPSgcaXUz75rklVT4ZdSFGt66GIqfOSoTZMCYkuCS7VXsQlHz1lTjzu2Do8vJgwWX0NHz+s+0FivVafwgd2kYGmrWkbzB2qUctg1N2opoXJdnfYGZH/m7EOZ7VcTMc+FFSkJwwkv/G7OLNou6MMpABM5JFK1k11F4TvqI9+528yI8zjtJIYFDEx91Vmz7JbClDsOUIE6Ueb7WugCxIGnqlQrM2uwhY5oj1iK4ODQBPbb36kvfXOAHyKD5DolNC7Nyd60cwS6tAqhmtzJawkhHrO1gNLvdni9BpMUOiV0a+wTSE015c1CwxxEXt7wcv5/OpcoSq+0gjxiQeg8Hk76ZUS6qnX60BPOtiPk+HZ/OpIGIKsxx38bHSqHuLZFwQptuLOp3dzKldweQY+219bOSBdBkoq+hpd9BKfW25p7g7khK+TNHr5hokkFxOfbET
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0em+CKhseudl71t8teN7G/k8fFZRGiMdZq/DsvDf13/tnEaU1WpPPcoJnpG?=
 =?us-ascii?Q?w0QWJbGUvY5DVjXc4XXnoQ5L1BUUIZaH8szUUE7DJlDXrSlggrVDIabq29E4?=
 =?us-ascii?Q?8VPHs7re50ZbS7ClYLC/YECCCbzWxRPRrH0yia0V826DiUWpZ86Zgls6OAqJ?=
 =?us-ascii?Q?Wje4hHaPwHZBSr/k8nZ0W8rv3b6iYG6POuXo6+UCNliGhyI6xKNW/G8dlLsl?=
 =?us-ascii?Q?0KQvhWQ4saQk66oaGgWZfW8Gx+D/Ei+BgqluEbgwwUsKKEGnAfyNLQ70MFZf?=
 =?us-ascii?Q?FJ9vCvgkOPLEv6XErrevK0EeJdxeTvw3b7pQrWO31kII68BqTIWKEXbypMDO?=
 =?us-ascii?Q?t/iF/voTbJTIBrQ0Ko3VyFU0Fbrtv3gjz+sBnH7V30mW1U6a47c0nPDx9zTu?=
 =?us-ascii?Q?/1+mOHQDXfH5cxYUenh7XDusxI+QdxgKzIQ309g7IG9pJuVmtGiAFHRDENU/?=
 =?us-ascii?Q?mJpTpH35YIXXN/llTV4g/GF+B1ewvt3qoOghAYiUDwsRxLY3PtlL5yGug59C?=
 =?us-ascii?Q?cAcqZZz69o1tEPZMRSLD76koYs9S7ADEicijezTPm58bFA8Qdhpsur2nDslH?=
 =?us-ascii?Q?JjMLKmN1xMB3tBR5E7oYowjYroEYNZNO9qSmsIF+sZkFGw01a9DiLcXcksiH?=
 =?us-ascii?Q?WpQtm7PJhxPa38q+D1CF4tQxpP/JJ3Bra/j+B/ymGj+r1k+o5NlXZWYq9zP0?=
 =?us-ascii?Q?t8PP4r65/jPZystMXq4p1c4zc6IjYZuU9uxlzggf4EHfvVlUz1+crkSJGVps?=
 =?us-ascii?Q?QSwq8jZgSJAPZIDOomU43+zJPnlOAA88pWo9RpyUw8hhXs4LN1XOf2qp4g+d?=
 =?us-ascii?Q?QDZDSUL+7/OGqEt4wWjRiwI7H8IJ/gWUlx35Rj/v7EIfzb/YI9DBrEgJCwDw?=
 =?us-ascii?Q?v2UhFH6CIjegm9HGICnFexblwBC16RgOW+GQyynuY4cOEtVaCQQI1L3e8Fk3?=
 =?us-ascii?Q?M4eTduqXz81cXc82oxD1kNDIycTbuiaG4CF07yKLaH8bZ61IsyO57akcdv6c?=
 =?us-ascii?Q?4VRn0POep5XAOtnXUCHmqfixPZagwCOL9uqGi2b2/12SZyvLKjIj+dJjWRSV?=
 =?us-ascii?Q?tj25D7oUUsDnBlrnpTFY6jbq9CCFH6YBwgYqMVYMJogGJFOgUHaVOR65kq5I?=
 =?us-ascii?Q?ax3Xc1Ms5OOmLg2NBCxjwmuCX3lDC/QNd7x6W70WXuQ7qm9itKO3Li+w7+ur?=
 =?us-ascii?Q?W/2orPA67v8teSi7/7chKVRRGUgIB3wVi+vjVaAmfn1BP2nGEVvGA4KaYwIc?=
 =?us-ascii?Q?5kOpjuBhfrmUG8DCl4EEGpXQIl+hlLcONxaHOBFMzgJReSkPzYw8VgqyHO/Z?=
 =?us-ascii?Q?Dct+jZ9ax3sH7NELPmliHqn0YraxaddPa+zys7lpdfBovrexm70ok5UYPrq8?=
 =?us-ascii?Q?fQHoIJecsjP7kB2KwlhAgUmDvifOukFP/I4c1RshD6w8IV2xF6IjJwFwYKCq?=
 =?us-ascii?Q?U9loO9cQJXGOP+uiSt9UgGam+DFiiqRk2M9zR3zHPsvgw2xlBaZNMdudA5Xi?=
 =?us-ascii?Q?F+mtFcMjrG4XwhB/LHU32nKBJp7AlYSJAGoASstPJO+LMmGoc8GFd+x9CRSY?=
 =?us-ascii?Q?3wO/YgCaQKZ0BpLcYjbm1eO0ZWJB+y6ZM1s5Gnn7P6LBTnwLjxn046G3bBLq?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fbfc37-94bc-47e1-e463-08dc3256ed9c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 21:00:11.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djMDOgYRFXlX+koUlyTUUco7+rDMt0rqWRtVhgVZkF6vPLg7JXGC6l9u7jToI0nvGHxmS+RJV29pfYxURqH3C2vTiBOMRk6OctfopjNQt0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5517
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> [+cc Alex, reset expert]
> 
> On Mon, Feb 19, 2024 at 02:20:06PM +0000, Jonathan Cameron wrote:
> > On Thu, 15 Feb 2024 16:23:07 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> > > SBR is equivalent to a device been hot removed and inserted again. Doing a
> > > SBR on a CXL type 3 device is problematic if the exported device memory is
> > > part of system memory that cannot be offlined. The event is equivalent to
> > > violently ripping out that range of memory from the kernel. While the
> > > hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> > > register and the kernel currently does not unmask it, user can unmask
> > > this bit via setpci or similar tool.
> 
> IIUC, this refers to CXL r3.1, sec 8.1.5.2, which says the default
> "Unmask SBR" value is 0, and that when it is 0, the SBR bit in Bridge
> Control has no effect unless the Port is operating in PCIe or RCD
> mode.
> 
> So I guess the scenario is a CXL Port leading to a CXL type 3 device,
> and if the Port has the default "Unmask SBR" of 0, an attempt to reset
> the type 3 device via SBR would have no effect.  But if a user or some
> future kernel *sets* "Unmask SBR", the type 3 device could see a hot
> reset.
> 
> It sounds kind of problematic that when "Unmask SBR" is 0, an attempt
> to reset downstream devices using SBR would fail but the caller of
> pci_reset_function() would think it succeeded.
> 
> > > The driver does not have a way to detect whether a reset coming from the
> > > PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> > > detect is to note if there are active decoders before the reset and check
> > > if the range register memory active bit remains set after reset.
> > > 
> > > A helper function to check is added to detect if the range register memory
> > > active bit is set. A locked helper for cxl_num_decoders_committed() is also
> > > added to allow pci code to call the cxl_num_decoders_committed() while
> > > holding the cxl_region_rwsem.
> > > 
> > > Add a err_handler->reset_prepare() to detect whether there are active
> > > decoders.  Add a err_handler->reset_done() to check if there was active
> > > memory before the reset and it is no longer active after the reset. A
> > > warning is emitted in the case of active memory has been offlined.
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > This feels like we are papering over a hole in the PCI core.
> > Is there no way of detecting Secondary Bus Reset (SBR) and
> > communicate that down to the device?
> > +CC Bjorn. 
> > Most of the logic would be needed in driver anyway though as
> > we don't want to bother warning on SBR if there was no memory mapped.
> > 
> > Bjorn, would you prefer this FLR vs SBR being detected by state
> > change in driver, or a modification to the PCI core so that it
> > provides this info to the drivers?
> 
> I guess this is about pci_reset_function() and similar paths, which
> call .reset_prepare() in pci_dev_save_and_disable() before the reset
> and call .reset_done() afterwards, and the question is whether we
> should pass a new parameter to .reset_done() to tell the driver what
> type of reset was done?
> 
> That seems *possible*, but kind of a hassle because there are several
> different reset methods (six in pci_reset_fn_methods[] plus
> device-specific things in pci_dev_reset_methods[] and a few more in
> various hotplug_slot_ops structs), and I guess we'd have to plumb them
> all to return some indication of what kind of reset they used.
> 
> But even before we get that far, if pci_reset_function() just does
> nothing on these devices because SBRs are masked by default, that
> sounds like it needs to be fixed first.

True, if the administrator asked for SBR the kernel should work to honor
that regardless of any quirks like CXL SBR masking that might be in
effect.

Is that effectively a new reset_method? In other words, teach the kernel
to toggle "Unmask SBR" on demand, but only if the selected reset_method
is "cxl_bus". That at least allows us a place to hook some documentation
around why this is a potentially system-catastrophic event.

Otherwise CXL SBR masking is in effect modeled as just another way to
indicate a PCI_DEV_FLAGS_NO_BUS_RESET quirk.
