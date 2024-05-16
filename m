Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE684156F2A;
	Thu, 16 May 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715895282; cv=fail; b=GqyaVPBxL7z3RMHyhFbiq1grQAjFmeqwiW5CAHriJwn7igc1oPcms1qbIrJ4RsSpeO/17wQrTVyAUb5qYUQXgZTQs257gmPee0B9dWOYY55CkCW59D4M1XtS9yLNG8ABGRtVshTb+Fxyw2ODbdW6yc3FV5Ro37K08ackRpp1tmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715895282; c=relaxed/simple;
	bh=1VvhfPHvl0lEFGF+olBPE+f8QlHe1VRmlq9vasLsi8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eG8gl8ogbYgbhnCV2TqTAQ0ywP3fEzhqRHR3wmPQf4RuVQqeYpxOkuau7aNOawOkDM58idaPXElRCnFj5hiKsS0AaqddddZqk5IlB7Xuaj8x9hz9OUJ+H/KhZKadEzmIAm4PqF6vWZ1QKhJDlSSWzboVA+L3EzsaOH+7vejDYEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctppHirM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctppHirM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715895281; x=1747431281;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1VvhfPHvl0lEFGF+olBPE+f8QlHe1VRmlq9vasLsi8Y=;
  b=ctppHirMY+44mYa3ukZRHHl3Du7zByz6aOBePQnJceM+KKdh+OW8lBgo
   3OelCmNKSdNWarSgIBPmUPbZ/ISsqUg+UqcL01o6gDHRPR/Ay0LdtxN8G
   Ej/cY7LrQKwgBqYgBUucg7OY4xj4fo3X9MoAesgwoXovNbhtV84Q4Jahi
   zx7XwndffJ5ayq3L9bn+qE46MGbs1NvKVvBWKb6iUruN2sCaPP8h5gdiy
   uU2Cn7JaJ5llMDuni7PtD4CgkWYHIUQn4stYvxaFjB6M6O9agtCYkoibb
   TIbB28nLFeLplvX8WQyvfyVmG5fEwll+urBeRCt4kBb3abV02UanHTUGW
   Q==;
X-CSE-ConnectionGUID: c7oNcoeOQDKqt+pSjjLkHg==
X-CSE-MsgGUID: /1YobECmRkeplcbCTuPFNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11851113"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="11851113"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 14:34:40 -0700
X-CSE-ConnectionGUID: 3vuL5KLgT6qQZo0dzr9sTw==
X-CSE-MsgGUID: ZLqF69bNRiG19CAm0K+mgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="54786079"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 14:34:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 14:34:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 14:34:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 14:34:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY+SV5AakkiwW1wH+CLrwpzoCYeXyqBP2b4v4/XSxSDeLWWG4DOP6HXL2fYhSStyX6RtN9cyc8Hz7TTpHgyHhXofjBLiaM0tMEpHCNIWMZXM0qm96hBQCiHAm1RYn3gU7akT9WMA/5N2em6plcGds5qjrRyyN4zPyMUh2AyrFbVf6cjtScpiQWK93hbtVUpWMO/2/v6TA6O0DvbNrSFO4TrPPB0JisqQ9wsp3NcPPmJ6LQCTPI32lQflhFTblyenvmM8B2VzmxIA/gSeCZboo5uTuizTnUIe29tIZVJFFp2herY0t/yt6Ug6mJbBfLZZuDqxNs4vzx3pdmVyRNm6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUKC7bMmJFBBW/Lr79Xah8jQQC1rQ8GGaAjeHpdyZx4=;
 b=CnvOHZ/GEMeaLVkisee9vjOmIBgD5YO3NT5J81uiMzN4cMBrNNK1ter+D4nT0gNzbcwkLjyyhwcLsj4n6rqyK7A3fqSeF/GlcWADPXRGWpTUOTkLir3ukFZfAt5Et4SS4T9BMQSzm8LLF9zKjKP0Xdsm8NySyzJ/Mg62vpU420edwMPInZOCBwv+coZ+bVNtk4O/6EoTUwGv9KHbLR0luULBroFnZpp1C3AmM8wzg7xyfOi0ahcZSxKXrAyLRqB1u9dtIM8jVuUB8LC/r0WMpAko7vC94JKnsbK6HbCtpniGr7pvvUeMnXKBgyCX98pcERz271OimXcJkDxWjAOJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 21:34:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 21:34:37 +0000
Date: Thu, 16 May 2024 16:34:34 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v2] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <66467bea7cc40_8c79294d4@iweiny-mobl.notmuch>
References: <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: afef4e29-8e5a-40aa-8660-08dc75effc8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hz+A58uWT1TCr5oJ6FTT+5cUhQNfwzMOObhFK73qkgAk8cXD3YJpfMRhoUMR?=
 =?us-ascii?Q?U1MO6RFJJ3zbgYD+5TglSMf9Inn0WTS0qa7BV+QIrph/OffLafKO6zVwJmVB?=
 =?us-ascii?Q?f8DC933IbMGrbb2TnJrHFKyPSLnf8oIO+b4ceqTrPG47ufh3c+hDreD/NqyF?=
 =?us-ascii?Q?1+xy6Dne4VVlfXUvlwu+//iB1GIzi3TP6ogz810GJpZlopsPoNz0hgvGlKcs?=
 =?us-ascii?Q?6+4z0PXjxxv+swWtl/qvBbrdmsjyqjRZIUGZMeKFy9djkLdT+cwr4u8EI8nJ?=
 =?us-ascii?Q?aIS9ZQ6t6N2xbhTLNkXZrEcnJafg527PyqMIntsFxCFSim0+hzr2xxpac7mG?=
 =?us-ascii?Q?yCXIjZKeDF+EjTz/dp2jI3bHrQG/opCwwON6eXtwdr59uwkakTeISH2Apxza?=
 =?us-ascii?Q?uP0PlaHED61fQe/IMzJAozy3+dykcfW6noIbE66anKfM5ZsWX1V8JLyqHwOt?=
 =?us-ascii?Q?8zqDZiOAcWCMVPda2KygAJHHoWxMf4rPBz8gNDDhEmfXpbHTPckJC+SsrbzA?=
 =?us-ascii?Q?PuLOQg6C09YlsA3jilp+BAYF//yPg2lBPqkpuU+WxQE1KSk7NC56s9OFgw+T?=
 =?us-ascii?Q?rwthJccUsby5SAXhOUxWpikOIRxN4qPlw3JllL2xD581oly6X5O3/+oDFb9B?=
 =?us-ascii?Q?apybT6ou56STSQxjM7623ZQXjZdpSJopWj3bWZU4E2wmGVOGETBc8T4/Ap7S?=
 =?us-ascii?Q?tp9L/eoK408HcMEEQ0KNErM9F8uOHrFBUoQVmn0WA/sjioiiXucB2Et/ryz8?=
 =?us-ascii?Q?k5GL0uPYwXk7cQgkxxU725+ryLqG459f3AHHICjHjlnKyG4HJO9S2uRNQ1kU?=
 =?us-ascii?Q?8Gu3ABqdK7D8CE95jM4+zBHlD99p/6tw0QtI6ef7JV/rImIaNlh6Q/KEwsIH?=
 =?us-ascii?Q?4VSQ5q3elvaK/y1GmqA9Z5aJlmnWf9UYRHsBJtHGkdLTAdBe0R9QzKPKB8Hw?=
 =?us-ascii?Q?fd9LEWR5PColL7yoC7mqnzESdRsHRxb4P//OkEQsTfH4sE4LqFfXz+XXVtTY?=
 =?us-ascii?Q?tfId5pzF8P6aOc24ly5DH0CPFbGdKNS/EUpzoSZHlqMz0R4wHrOC8cVGkwyy?=
 =?us-ascii?Q?Fm0v1gpeL7J4UtiROWf/l4wvYx7SgAyyIuI/D42dIM09yUCQJ6obppRrFFvB?=
 =?us-ascii?Q?B8auzCbX7Q1qVxKkixf00rTBSMRsgYj4w4bGfCJnaAybjH49R5tTBBuKpwVP?=
 =?us-ascii?Q?k35usdFGOZFybqBB+F+Bpj9H7PDg2RdBZrj2gbpaU3DAVo5ltprUCVjoLOl8?=
 =?us-ascii?Q?AQnhJLScp+MY43LXpPMxvDLEkis/7r6NbZvLuZLy0o4D/CCurriP70q+pLfr?=
 =?us-ascii?Q?MjoC+Kpm1gO/VZv9YeAGSdjU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cuT6wT7Ao0p5b/Xn1BmfLnWi0TVkuXrkBgQuAubG77/GMHrY9CKv4zJJCDFF?=
 =?us-ascii?Q?xmnfTyXD5/IZz5bVmqhn/CaLdvpIT/jztZLeB1EirLliFkclRu9SL/Nf8Ei/?=
 =?us-ascii?Q?D3Gk0+s2hDkZdm6gfOHjJtIioPV4qxVZiKTWZadueL4aQn12XhclA7/xOWBz?=
 =?us-ascii?Q?gK4sAlrNFxlrZGVRtC54Rc7huuIhKC1sTPnk0RrGgJDeRYnCysUChWTE1CYK?=
 =?us-ascii?Q?ZSUgDqLy2DHzglJE3rck2KSfwGwwHO/nJuSX9MpgJE9gX6lO6hhjPcAd5UQ0?=
 =?us-ascii?Q?VNmetAoLI4NAr+0mIVG0w1RT4HXMSdAStIrYkS4yP9fFrwLSQe7yfZhNLJDp?=
 =?us-ascii?Q?wkVPQ6smaojyiNwMqCvfh8merlEVZoY8CWmgcU3FvU8LkHonStDIT6o80E8q?=
 =?us-ascii?Q?h9yVIf7IIfvhTJyO+XD2T+HjbT6WDxuHsOgq1871F+4fxflGRLS9SPJSbJD1?=
 =?us-ascii?Q?Q9wIyDlqAB6czBSc5S65WsSmNL47kVf9cofCQ+SsIgl8UkHE63FedL2+tpZs?=
 =?us-ascii?Q?2IgDCQ8KJWuEFhZsYsjCHZBGCl9mhJpWFMwlH8ctjuCXPvziDPMU3d1SP7c8?=
 =?us-ascii?Q?I0qwsKsKgX8VLu5gZIZeGw1e99BZfL5SmtD+J1ARMsHUzt/UDvpjcNOyYuJ/?=
 =?us-ascii?Q?BEl5GuodAnovsDG/V3J7ENR4lW2+xtX5qXyDSznvpripHrHluwRUYTuPZyP2?=
 =?us-ascii?Q?npi9r9yE39AVfDu0JgEaEv+NexNU3xrvb9BLF7Fu0dKpgo7Th7HbWHyczlWl?=
 =?us-ascii?Q?aC74RCf5vT6Dy5SdveOZXBZNdNUAqhJ2TP/PEWsJjljDLDzFLSv7YvzVs0/D?=
 =?us-ascii?Q?AjyHP7Kt2rZtCaBOVQVjcsgtMVNPeFUJeyLJkAiYRLQvRjagKK1MltYgMjNV?=
 =?us-ascii?Q?rhVlYvdBW0a+9DKxEtT9JZc5mnwZEL6MMJh5m/9mqcj9C5BIxfuNHBQSFwz9?=
 =?us-ascii?Q?D9yx7p2L0uIt12WnLiSB/e51YmoCWC+ekWotXPIDVUlDfXWMzzJh4AIkTqSa?=
 =?us-ascii?Q?aS01exn0kroWFcIS7eRSZtdM3zUOSgi/sJiZmlzUhLEr5D7FRjKcmDmiB+ZZ?=
 =?us-ascii?Q?fYBy6v9GJWoQNj47mag0lUCIHICoOvPmum1qRzyJdwTDUEq9PKfwl5Oa3ag/?=
 =?us-ascii?Q?NG7OT8zEOiVPXhEB2i4sQ2qw+nj3cLTtBf71fastzcm8G4yctfy9oUj+4hKz?=
 =?us-ascii?Q?Au1VjQjcv/qeG19vyQR0S6TcOYit6foKWOYaZ5c5tmL2UXHBDX7CPaDhNWQR?=
 =?us-ascii?Q?GBnG4YP1LToyN7M9OlGZE2YD0jLXZUtdgj1bVQ+fhUPl/qQpn55742s9e5+r?=
 =?us-ascii?Q?m1UDeNBS85VN1Tl3+VzWpLngac+8HfMutpGrIzdMNwaTXXqMRrNPvyrgbQbs?=
 =?us-ascii?Q?tLG+2YeQHsiY5qwTm2i2Ljagc5wc35PkqqQ1YdzWmnkROnmpmsPEdyTKieA4?=
 =?us-ascii?Q?AKl7ZsNjnOdReq/pQ9EHvkAvEqW+OulXCQLj8Xev6JPve1FlXsNeDPQEPRK9?=
 =?us-ascii?Q?YVPLNPy8ogZTwL2JKGrwVbymE7+745cCcgCtgd6V42X8aLMgZh3+yh5EbOG7?=
 =?us-ascii?Q?pibEPK03HGgjB+Ogy9dhgxMjhh4cHr0SBD2vNIkiBXy6rF630R404lgA1mxb?=
 =?us-ascii?Q?Az/QDAhqVnpjuN9GtbQbHPQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afef4e29-8e5a-40aa-8660-08dc75effc8a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 21:34:37.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMK4+uUbwq4pgD8XsajG4nGfZQ/iuLziTyC21BAgTqhI+ndKdXK0j2oqIVTDNnzJ4uJDhUJtaq1PrzQGlWicaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> cxl_event_common was a poor naming choice and caused confusion with the
> existing Common Event Record.
> 
> Use cxl_event_media as a common structure to record information about DRAM
> and General Media events because it simplifies handling the two events.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 6aec00139d3a ("cxl/core: Add region info to cxl_general_media and cxl_dram events")
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> Changes for v2:
> 	- Extend the commit message (Alison);
> 	- Add a "Fixes" tag (Alison, thanks).
> 
>  drivers/cxl/core/mbox.c      |  6 ++--
>  drivers/cxl/core/trace.h     |  4 +--
>  include/linux/cxl-event.h    | 70 +++++++++++++++---------------------
>  tools/testing/cxl/test/mem.c |  4 +--
>  4 files changed, 36 insertions(+), 48 deletions(-)

Still not convinced this is worth the churn.
Ira

> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..ad4d7b0f7f4d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,16 +875,16 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		guard(rwsem_read)(&cxl_region_rwsem);
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
>  
> -		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> +		dpa = le64_to_cpu(evt->media_common.phys_addr) & CXL_DPA_MASK;
>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> -						&evt->gen_media);
> +						&evt->media_general);
>  		else if (event_type == CXL_CPER_EVENT_DRAM)
> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->media_dram);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 07a0394b1d99..2c7293761bb2 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -316,7 +316,7 @@ TRACE_EVENT(cxl_generic_event,
>  TRACE_EVENT(cxl_general_media,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> @@ -413,7 +413,7 @@ TRACE_EVENT(cxl_general_media,
>  TRACE_EVENT(cxl_dram,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..e417556cc120 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -32,41 +32,38 @@ struct cxl_event_generic {
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> -struct cxl_event_gen_media {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 device[3];
> -	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> -	u8 reserved[46];
> -} __packed;
> -
>  /*
>   * DRAM Event Record - DER
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
>   */
>  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
> -struct cxl_event_dram {
> +struct cxl_event_media {
>  	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 nibble_mask[3];
> -	u8 bank_group;
> -	u8 bank;
> -	u8 row[3];
> -	u8 column[2];
> -	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> -	u8 reserved[0x17];
> +	struct_group_tagged(cxl_event_media_hdr, media_hdr,
> +		__le64 phys_addr;
> +		u8 descriptor;
> +		u8 type;
> +		u8 transaction_type;
> +		u8 validity_flags[2];
> +		u8 channel;
> +		u8 rank;
> +	);
> +	union {
> +		struct_group(general,
> +			u8 device[3];
> +			u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +			u8 gen_reserved[46];
> +		);
> +		struct_group(dram,
> +			u8 nibble_mask[3];
> +			u8 bank_group;
> +			u8 bank;
> +			u8 row[3];
> +			u8 column[2];
> +			u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> +			u8 dram_reserved[0x17];
> +		);
> +	};
>  } __packed;
>  
>  /*
> @@ -95,21 +92,12 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
>  
> -/*
> - * General Media or DRAM Event Common Fields
> - * - provides common access to phys_addr
> - */
> -struct cxl_event_common {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -} __packed;
> -
>  union cxl_event {
>  	struct cxl_event_generic generic;
> -	struct cxl_event_gen_media gen_media;
> -	struct cxl_event_dram dram;
> +	struct cxl_event_media media_general;
> +	struct cxl_event_media media_dram;
>  	struct cxl_event_mem_module mem_module;
> -	struct cxl_event_common common;
> +	struct cxl_event_media media_common;
>  } __packed;
>  
>  /*
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 6584443144de..0a8fd145c391 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -378,7 +378,7 @@ struct cxl_event_record_raw hardware_replace = {
>  
>  struct cxl_test_gen_media {
>  	uuid_t id;
> -	struct cxl_event_gen_media rec;
> +	struct cxl_event_media rec;
>  } __packed;
>  
>  struct cxl_test_gen_media gen_media = {
> @@ -402,7 +402,7 @@ struct cxl_test_gen_media gen_media = {
>  
>  struct cxl_test_dram {
>  	uuid_t id;
> -	struct cxl_event_dram rec;
> +	struct cxl_event_media rec;
>  } __packed;
>  
>  struct cxl_test_dram dram = {
> -- 
> 2.45.0
> 


