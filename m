Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD3127B70
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544743; cv=fail; b=fScxWtvO46iA08D8KSvbROuWRP3ka3dVAaJ5Gbmf906HDV5gtdAJrV3LwmDzDniHPWagPP2Uj07AdVkFyM7DL5oqD9SFZAqwivnyAnle5SiAlcf5FBfCaPLMFFQCNliGeMfkQvP6D40i9cIVLXRoeBhW1+f/5shN/WBX6tUukPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544743; c=relaxed/simple;
	bh=l8SV3MZbEViGUJWJ1u6IkpC4RpWyNE0YldS9+kM6TYE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zsnjc3d+CYjQT0VLSQ0ejZeJWm5xn3eyqW2OQqxsLgRdlZXZNi4b8hOHt2MXcUNsucvbhErM9Q+HjY3MlvvyhjIkJEu+DUZXQkRs5dx6x3eTKqHj+qh62Ee1USlIYYPGFuVvtL1dPLultWhfkmlVapGIkdbSvlpFANWPlq+4w7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EafSGhHs; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EafSGhHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708544742; x=1740080742;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l8SV3MZbEViGUJWJ1u6IkpC4RpWyNE0YldS9+kM6TYE=;
  b=EafSGhHstVdcyTj3A9N4AwaaQLYXed7yFwynrZt9ack/yrAjeeZJTa2f
   DdhtkcMQQoEMdCnR37TDxBAKuYbjTiK1nbsXsz1fW/yVb4JYYmJplgkkL
   jFRO0NcFnQsgVUeZU0eN6+XjxywqmM91hkqKVCsykAHC6UMEmY9p6oTD8
   wycxqPt0UXyCAkIzDMsX8fKDxMUQrW4Da7SJP8lRs61JL3kQhfh9wVwf5
   oTRJHCQa+cwSga37LLK5Xc+tFUE3/wedwQR46nMcIWYYaBAbtLSjRdVTp
   so6jTu1LcxzCvuVRZUby6C8SC7equpIPoTHHLMwcK/0vuu/n0dAEJVoxT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6558491"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="6558491"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:45:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5142513"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 11:45:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 11:45:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 11:45:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 11:45:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYK84BxdvMyzdcSAjX4eGyQsPo88TqRp+Ww7qh7A3A3vNbFPXyW9uvpzQAIBi7vIC9gQF50d3sJJNV+FCig/1z76smAhCuxpIAazTHJJTL/9RJ/zs/cR38YxYKbG5brOL02BI3G/d5OpiYNv2yYtDBnHtPe19WDaqkwQfIbeuRyUZ0BKdwx0D8J5qgl3yu+9bU4eUQ9C5998+/NcVcN+cMBNlHd+Cok0pAk9gqBb+iZT61znh47J0d2dvFze+dvYLUPNA/ZZOblSBler6XmUFi64sDaj3bMGJj7HDO7zjUPXn7khepSQr/rQNjEzwOpz9zZV6vdVlUxpe8or0QqNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T/5sa+R+FFb6zaGfn5PKnaDgSicSs9RgH+DKASvwgU=;
 b=C2w36iPSipC/PWiN83EWgmvzuGb09ZNbyTOTXspUjdlZID7l+inu9ttk5iZtiwWNmmCNj01ck/IhYoNKJ/pC4X2zO2cwaOs7anxpto/JTd8z8GnrzBuDW6WDGm2e0eOli1dc/2zYmUXtQtpPUiLbao4deSB57jUpmU8p/VL0bWrEni3MoyXwuQrSxyFIcD7nQjoYf5r2sUTi1fK6azJKIBNxPQDeHp6Qb4XuT3Kb0U9DUR2+UmXb06UTE05XwGZJkJ/QR3+7GtaX01JjvI3YEbi3TDRpaxXxUs3LaW0j5qUovLRkna3WxFl8MYqs9Xe1AHeuNyC3NJmDF4RzSTwgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 19:45:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 19:45:37 +0000
Date: Wed, 21 Feb 2024 11:45:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Add post reset warning if the reset is detected as
 Secondary Bus Reset (SBR)
Message-ID: <65d652df1e420_5c762941d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240215232307.2793530-1-dave.jiang@intel.com>
 <20240219142006.000056a4@Huawei.com>
 <65d4ed7338566_6c7452941e@dwillia2-xfh.jf.intel.com.notmuch>
 <a251128e-ba9e-49fb-a237-f3b8c2b605e2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a251128e-ba9e-49fb-a237-f3b8c2b605e2@intel.com>
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a1947d-c676-41dd-2d6d-08dc3315ad4e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93ttihbnr7bLBmj8U/oY8JXyyOdWELqH14CwrOO4L5GeVEXeNMeaXge+o+TZZ+C4TlTc+zAGejoTPmSFvftBcTIO02POUKKxE9da3MkSRegXpkpW/f8s0kAYdtZpm1eumIKccbfRxvsKpdiPwg0ox/Tx1R+h29zks5XckLTuaFabR9S7nx+k4NAk6/kO1zLutk+CZAPDaDfODj4oTosAQu19Yp5RKnwt6H3POqV20S4jrxWM82I/AySN5BuwRprFQd36x2ltkpWqhjd3hQJVzDQwAWXxS8gsBRVgUpylkG6Qj7Uj4mBIX397RDbjpePVQtfnU5o0vNOEwfv7hQi6PnCLqSYwLGp52zLL8fOpnk+Tksnl27uuWhLYnpYLxV31xhD2OoJ54hYxpkUhsDZ9ttBYhGuPvzWqUR9Sj4J+cRW7IPfsaWOpLBZhaaCar7lRHN13CEqFK9kKZSJFkldpWDeTXaj8caDvEHYKwTY6QsTXCSUVN911wq/qKJLoOMpsWNJOJqloEDtC9TPc+9mXKB7Q3l0+5n4+llZ31t9L0W9qgrU9oFZLRpQqlWRHph6u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYwS9NUXzOHaN/uB6Xc4ySiskB6CTdrBq9TDexx6Pot79OjfqeyoqkAsyPGi?=
 =?us-ascii?Q?yRez5x9FVMQlNTxDTmuqW+C5c//1AmRC9i5ghO7FRN90w/1bBwk9x6Fn46dN?=
 =?us-ascii?Q?ge+oyGtRf/zYQWYu6UdurN/mrn8+e9CNJq0E4zUX8xAIjcLtMpgp0r47LGSn?=
 =?us-ascii?Q?LMIievjtEmp8XfzIkE0cB4OROWlWq02WveXQCrHFD47s8hipMvpvwf+1xSYV?=
 =?us-ascii?Q?YZj4cVW1I/NlfE5shTpG/LrIp0LfrA1FxCtGeWratd7URIjB5S5Y61ypKbQG?=
 =?us-ascii?Q?Vt7fEOYtQUzPL2TMA77/AUDRs2mUIHGCQYIeuiO6Vnbzkx8DJfjHBo+/2sbE?=
 =?us-ascii?Q?iI8OXLnGXanzDQy2SVzS0vChLqiq9G/MsV9fDCuU5CPSq38aale5tUd7GBOs?=
 =?us-ascii?Q?aIk0XrQM3VrNnm09OMfNodnTMZTYbD86A/K4pO6mWEQk0+VU0ZeUcrv8fybN?=
 =?us-ascii?Q?epnkKkycGRh8afZQd25ZsVKL29TUcfnYh9bEgPI7uHSKmjkfAqNf2httC6Ep?=
 =?us-ascii?Q?T0ksndcFXFOYJU7G3l2Hc69e8cv99QxEGsXomkfK6XsrChmafNqBOHHZq8kV?=
 =?us-ascii?Q?JKI+16NPMRV7EJeVW0EI4bQT1puvEdw4Z1Tp240jBhvi9FhiTde3y5qa0RTp?=
 =?us-ascii?Q?YsgA8SK7XyLUCp90wAHJnY5clhcb75fsE8OLoKubAMHqoiBM8e04IC1iLpTA?=
 =?us-ascii?Q?5yQe1FCzf1LqCL+zNIWjHCgN/f4KNnJ3OqxdisH09guyKKuGRWZw9QfSrmvK?=
 =?us-ascii?Q?sg9I158t119tyJbgihvU03UxmYXDPjKbPKlCF1OqpWOT8k7FU8ExZZDWNr6S?=
 =?us-ascii?Q?Uj8HlqdbuU94KfeKeD/zR6IOxTnzGRkRLCrTUNpHQAd/GeDWzKR0YTIs+8NH?=
 =?us-ascii?Q?kPVQ2fvgOzhTa28MxgPvI0xDobpBvokkyA/V9Fo0OUD67vhQ1uGG0yGGYEfh?=
 =?us-ascii?Q?YQIBmFLN9Yop0K4ZNPIAjR5ECFv//KgpSx0y6kp+Pu9urfuwbcLTzgpVle9j?=
 =?us-ascii?Q?PrrLXRCIkB2S9lcuKqXM3RYT8uz1y8kJzBrjLq7z3vbxcXuREd4C0HCd+NYn?=
 =?us-ascii?Q?n2aS+4zInEHN/mWMWyhfCHfwr5R0hg32YRDHg4SV2hMwdV6vWrawkSP9dKNe?=
 =?us-ascii?Q?OR7D33L2X1RPEPoYz7HFRvR5Ho5ps7jhlgWKG8iWPg6Z9YYnFL0EQHIgNSLu?=
 =?us-ascii?Q?cuAIXYbevPyDKVGt6cxQ4aa+N4SBl7tdkIyjYXUKb9x6PbOI4r5i02U7s1t0?=
 =?us-ascii?Q?st5A9fooHzwSZE2ZOc1PqdA/4zxdv45XxyC31GOE2EAstuWmTN9viXy7+w6Q?=
 =?us-ascii?Q?b+WkiKaDmYT6sm5LTFVBwVG2XBQlvFhGJ/d148xM9NBaiLnQPEKVEUfQtJs4?=
 =?us-ascii?Q?yq91bvVcsisgmfiID/aSqc6sOyG3zQE1Rj2vNxUtCcBZauVrTS6RVeYaMCUC?=
 =?us-ascii?Q?kku20Exxkql6p9Xwpti29HoqILI/oQg8s+vM5vy5cSlc5+1bBqy/svr1eReY?=
 =?us-ascii?Q?n4i+a6tFEHn0DLC2Eg28blZ+mDtPYJgZ/A7DirOHw3ce0TYUwf+LLaZ5TErh?=
 =?us-ascii?Q?hHNjMUTcfAAd81YC0ue1Wt7KFeC0qXwCDrKNDCswbT3/IGUeIIckJuRYbHMk?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a1947d-c676-41dd-2d6d-08dc3315ad4e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:45:37.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiCcs4tPoRJrjfud3jnokU2zfKqNteP/MZI5vUS39K08NivXjefxeLErWzvtEu9DIspRmZrKv1Wt/9VONZ17D8wTb2mhIPUGH9vJ1LFtfic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com

Dave Jiang wrote:
[..]
> > Dave, did you test this? I reacted to the addition of
> > ->active_rr_prereset as a case of putting code logic in a data
> > structure, but I doubt it is even effectice since nothing informs
> > software that the register values changed. I.e. the check should be to
> > walk through all the software committed decoders and see if they are
> > still hardware committed. No need for ->active_rr_prereset.
> 
> I've not got hold of hw to test yet. I just figured to see if this is
> the direction we want to go while I work on getting hold of hw. I
> added ->active_rr_prereset with the thinking that if we find there's
> nothing setup before the reset and after the reset we can skip
> emitting false warnings. But it sounds like we want only
> ->reset_done() to walk through the decoders and emit warning if
> nothing is setup regardless of previous state?

Wait, no. Previous state is already recorded in the 'struct cxl_decoder'
software state, right?  I.e. if CXL_DECODER_F_ENABLE was set before the
reset then when you go to read the hardware state you will see the
mismatch, if SBR was triggered. If FLR is triggered then the decoder's
CXL_DECODER_F_ENABLE state will still match hardware.

> Although would it be sufficient to just detect the range register
> Memory_Active bit? SBR would reset this bit to 0 right?

If the driver just revalidates all the device's decoder instances
against hardware that should be sufficient. Now there is a question
about whether it is sufficient to check one vs all, but might as well
check them all for a quick sanity check.
