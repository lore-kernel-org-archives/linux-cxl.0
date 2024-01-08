Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34854BF3
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSQYsIrR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704736751; x=1736272751;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t8KMNTUda68W2uxcFa8v5DWd5l+45Fc396Fqp2VTDR8=;
  b=kSQYsIrRg0MwF38oxQyRs8TQeOVbxEOgRFuO13kz1TPou80ut5XV0kBZ
   Vk6yFqWtRN0DUDmMyW0HoR8auln9OO56aiUBoTaX4QtH9ksscevZiKfZv
   1mq/EhiOsXWmCt6KFYqrp/x6RrLxPgxijYGFhKQgCe88Gxlr3vgE4aPMe
   wYpZbUV/57R6hKICrWgIywf4UOrYyaVDQq9uCVhnvndIgv1DM+tPl+BHp
   bFXKRcfz8ksX/aL6zUrqMVzL9aw0weaTt+VmbTGpiQepU6Ici0g72/9XW
   zCe/F10+2skoZiUS5LLE3mQ5/KED+QUpbuV9x5xQDMEl8Kgd1ttiZqZt9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="396834528"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="396834528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 09:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781496127"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="781496127"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 09:59:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 09:59:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 09:59:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 09:59:09 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 09:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loYFL2vSQOL8U/CRdloIe/ZMLSIkchilNnduCWf8gxjLU9H/YY18o39yg0/lfe1tXvwnH1Gv1k+kSRmniL7WV58OEhP3xP2bx3+h/cjI/6622DO5ERhlVAO4Vl3UT2mtqS6GxVrxXtjPKXTkqmFvspf6e2EvSeTricSe7RuOz3NWU6oE79GluKwXU32STgHCQOH/lrI6z058S4PV2PtSUdF2HlGyXqFqaOlNGK/J8pbCyTLbY/pGFFr+x0/qNY7K9HVj24Y9KA8iC0JgMynOItGT6nb9xdKee6E6idj9xiJf2R2F9tw9jEBKPW8lE3ssoC9nibltL0kSs6WSvc7ihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lYF0sEah8iYsZuUNVgf0iqgQQgUAXQY8hei/dIZTUE=;
 b=RWY4qBivg+2rPyiRyIiEnYj5/S9zlPLhFUf4FehnbNjagEZar18L9UUUiV23M/8zRigTECLCFeIRzYnUS4n/zJ/1QNuwqxBnJTxHvBE4iLBhHrGXBMC/rIkOwCRkmnHeN8adr/fhhTyzbobKEUxoz05/s1+klo6j/cTHbowCfuqZ9HrngPnDMrthntOgqOaD2suPaqr3R8IGPh2o2ijioAlFnZPqcT4+YHgfCGRNkh4MGRtvfhdPxk7bKHd+CGSfW7TuNcwjQiRkQxrSNN1SX4+TKw/V2FzP8ePApQnavM+Guyu7SlBrLrrqUs+nD3cVYkaQ3V01iCrfI/EbyWcn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5014.namprd11.prod.outlook.com (2603:10b6:510:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 17:59:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:59:05 +0000
Date: Mon, 8 Jan 2024 09:59:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, "Huang,
 Ying" <ying.huang@intel.com>, <x86@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] x86/numa: Make numa_fill_memblks() @end parameter
 exclusive
Message-ID: <659c37e5c1e7a_127da2294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102213206.1493733-1-alison.schofield@intel.com>
 <65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <ZZWsOxhYRAdPNNCv@aschofie-mobl2>
 <6595c10982cf_8dc6829433@dwillia2-xfh.jf.intel.com.notmuch>
 <ZZwzxqxJjZlsXGjG@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZwzxqxJjZlsXGjG@aschofie-mobl2>
X-ClientProxiedBy: MWH0EPF00056D05.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:e) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bde9351-76e3-4f80-0590-08dc107380da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54BdR+0mr3f7bZHYcLvaCSLzQqpH9h77ZCQK1dAwfmIIZpMgMVdJJNZvMrzVvyH9RttE3rIBpXnXLtnbR3vsnB0iBXcO5IjMpB1APezg0FtKcmIegmWu/0tkXA8XVjBPf0dpy09Jcgkkf/bD57g96OYTAEIEUtiPIgzkzkoUphhGDzjOrqP1iWktTINhPna4spFAZK5i5ECaqT8V0EhFde5Cm+dvPoZ9Zt51EXXambBeAS/jEIyh/5wVMqyGTEGGMLT+ipRTk0Iq6+xBLU9EshKZtdE/WM4qMNth2zKe0wRtKOYR+X/xJNhUdM/OWAKJtAiBKAK7uttR5FB5MVquF8W9pZ/vgVZBj7+04iCGoEVi/GEgz0ds5lj5uvVPcDJh2i8fnjf45QKNEZjfyc2FXgru3Fx3NCQuMm/a3QYJ5a/vXe3YzqM7lrStTrbXW0HTv/EkJCkib5cA6Djw8VcJ29EY4i6ADQQ1RG/pPrwEsam8fu67dub9IV33//cszGzPTW5zOII4Bm1Um1w8P1VPu8njVzjGkQY0t9EEKX/UlIKLKnOo2SuH5IvMwyrwz4GI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66476007)(66556008)(316002)(4326008)(8676002)(8936002)(478600001)(26005)(83380400001)(2906002)(5660300002)(38100700002)(41300700001)(7416002)(82960400001)(86362001)(6666004)(6512007)(6506007)(9686003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4koIr06NARxlv8H7RHcKxdRMjV7+AbBCzcJNBtNNWHYjgiQJf/93LowF74ZC?=
 =?us-ascii?Q?msrEmgLwZCpvX3YirSrlAw41dRbN8VU9B2PbIViH5NrOxrQ/Be6m0aeSwyks?=
 =?us-ascii?Q?iu385Lf2UTTZlhjFpo5evwaG4CsK8pdKXIN7aZY1L8YvQoMxNz/L0YD/YKdr?=
 =?us-ascii?Q?FFN8cHN443zyjNTQtTPp3oUP5Z/uB+HVPveTfTsb9P7U+BT4JjtDHcDvoY9G?=
 =?us-ascii?Q?HuWgWml9yQ+IbWe+3+g/XODZt84rYCuY6N5jTQe4wSIfzBFt1NGboE2NA+5+?=
 =?us-ascii?Q?ZWrH69oDMJLEAeeld+4Br+TFYZnm0MlvDntg6F74YBv+KdEQaq5CaDeNabf3?=
 =?us-ascii?Q?LJxqq3zogSB5Goat4v+A6kui+Re/c6CffKK3NaEqG4WuSPKxHs1iBFC23bSR?=
 =?us-ascii?Q?3S/lnYUDmpK2SIvFn1MX/EQW02bzSOoJQK09rD2Xj1mwbIqsh/Paq4xsosIB?=
 =?us-ascii?Q?ieWaohdblyNj8+LkEZuPADBmtLQD1KOfVPSnJA8YPgdp7aHfAdJdO+Ai0rEF?=
 =?us-ascii?Q?1cSO+hQnZ6MT6ywP/lTID0xFdl1GJO0bswQNwbLxqtYTtHOgQtD03gGEdd4P?=
 =?us-ascii?Q?r+EgMAyEFUrotYORmlp44lbP8KUktE0tRSe2U6rbjUcUCz27r+140/e6+f9J?=
 =?us-ascii?Q?24IoIs3dXLs/aPkj3IQ2WBKBwq7Ke19K7XYpEQt02CayTr7SMWXMJShfW1Yd?=
 =?us-ascii?Q?mKKt6HnyObh16ByCsK4w2Leo3kXQizIo88cuVlLqIaCjCbjB+BgkYnY4Q0NR?=
 =?us-ascii?Q?2tKGFI6ih9pvfJ8rWubWwYp8znjVqmfqUau/AgT/wKRkeIFjhSbYbR4eYDbU?=
 =?us-ascii?Q?a9Ahnz4XQ2RfGb3Bz5FmA14r+RWB0lybMlmwd54nimtSdTCeNUDUztYf5+wR?=
 =?us-ascii?Q?Zh4B5DdcLGKCyCfeiDlpUck02UbPNCmhBo444PBNDvLceMN+QEUlr4TiSFt8?=
 =?us-ascii?Q?AClKX5JiSP2jIrmv6ATO4SChokmCruLdGdJ0gDBXivorLD0ZqIDOyGXAPohp?=
 =?us-ascii?Q?QrBXVF5Y92NDJkO/n2sQXb+0phzcxEQO27flarsZ0+IIO6bv/I2q5Htk8AOn?=
 =?us-ascii?Q?HjBA+vheNlOuJE/kWnX2PcDXDG94IT3Z7wQelMU2DnsexsLWYmtZloumtU3t?=
 =?us-ascii?Q?KlfDWf9It2imM6buaIQx6Un/fLfUXnUKjHCiX7qNnl2SzGYFrSZggR4l2nSH?=
 =?us-ascii?Q?0z5iHtwz1Lf2cW3Hx0G9lJnjGVBUEZFwCj4c3/8VByCPMk9AkaGd3G5A0BdJ?=
 =?us-ascii?Q?mg32lQd5e08ruYXnHkio6pAd7LoBgEmYifeagimFi/Yc85D0DKiBYEmtqTHx?=
 =?us-ascii?Q?MX2luf6S3HNJIH+iyH2xso+aNnDYj2yHkOGE5/J1h/CRmxIO7H+Dm4tqqPT3?=
 =?us-ascii?Q?XWlSpr59Lwd2CbseXh2Rg5TUTXGz450xuDgifS72fuTpAJY36vtm3VH+k/RJ?=
 =?us-ascii?Q?2/P0WZys5GJSxNomCPhdFNUdVK8hcoWpZ5XG+j4PDQNz8Dsqe7FkgeCbhjfh?=
 =?us-ascii?Q?XzIimaInIV6uaYyql5Jx403orT816H5/GuFwp/dLDOyDkAhsWvsgtDHgCuNZ?=
 =?us-ascii?Q?/nJXaOUn4/fmsvnuLGnkK/L6MndwVFx4b/Ya25U/i99vi7aYLiL60YEXTQjO?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bde9351-76e3-4f80-0590-08dc107380da
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 17:59:05.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvl2ZGytUeU/XNm0+r8LIyIragbA1God2w7Hz6B2jGm62CzWCW4FqEc5XJxh5FB+8x6tb/Y5GmXjKdkaNdBVZY39OzDg0qwnU7jdBE4+RkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5014
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> > I think your memblock observation points to a third way. Lets uplevel
> > and steal memblock_addrs_overlap() and use it for this broken
> > comparison. That nods to an eventual full memblock conversion and keeps
> > the inclusive math status quo in memblock and numa_memblk related code.
> > 
> 
> Thanks for calling my attention to the available memblock helper.  
> I went ahead and used memblock_addrs_overlap() for the comparison
> and verified that it fixes the case where an existing memblk is
> extended rather than creating a new node and memblock. It actually
> is not clear how that relates to what the user reported: numa init
> failure due to nodes overlapping, so I'm holding off rev'ing this
> patch until that user reported failure is understood.

Oh, I understood the problem as numa_cleanup_meminfo() finds an
unexpected overlap and fails (returns -EINVAL) which causes NUMA
operation to be disabled altogether.

Otherwise, yes, it would be good to get confirmation from $reporter that
this fixes their issue.
