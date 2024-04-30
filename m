Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AADDA1
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495220; cv=fail; b=WILE5YMYn3imiRf6kvBC8O2j0bzEEKmDvGwCIUYEl9k88JnhOBcjh0MKj49EJqGcPLALBf8Vu5xQmA450pXPjIuS60fqPZsvWCIvORx2XQUUT3F148NovSPDDIPjl02AjX67hMFAOHQJjrtsi80cx23+JIjmxA82h9SkKmjTiCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495220; c=relaxed/simple;
	bh=UXXK+cFqEXaQikBxKCYVWhkoEyGGcbG/feDZG+7DtCI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pib7Z9wii+YQjuVB8Bc+vATp/qKos9gaI7T/zcr7Te7LUjsVKv/4za4Q8Esshld8dTvmWbz5kKJ+XTgtZtYQRzRf3De0b/M4Cnxke3k84gdu7oIp9V1L8XdqFwdEHA9DGZRwtJrZ0J2mao0DZvcg3ItRt5WrBvfvBpufCnf+B2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BARxH4a9; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BARxH4a9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495219; x=1746031219;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UXXK+cFqEXaQikBxKCYVWhkoEyGGcbG/feDZG+7DtCI=;
  b=BARxH4a9dgCm+hHKlfQxDompVLc5VavccKxtNvayCVk0lJioTkOInX8S
   mIJh7GiT1ZPQOZO0QHXPBL3p0M9aBK+Y2Yg0yky7vNSFHR1YFK1SnwJW0
   i4UwBFSfuqiTx0sQ0yvNbXb3FwTciTc5L1NvJAerXvu5GL62c/sMdnLAQ
   PEAa8xdAxgwj3ETewpLPD7sZgziTiGdTYSSJdwcLMOSnoFPhjKwGgP/ip
   SY0Rx0mCknAz8F7v/11bO6CTUzQvVywnxkxdAf/skwMHwROJnZStilFNU
   n1i8I/1UN5EUu2XMF31lmdlNGlTD15nY553aC9Bz5Sn1/GSAs0w0RCwaz
   w==;
X-CSE-ConnectionGUID: skhbC7XUSvubUJC7g/eAsA==
X-CSE-MsgGUID: hRa4S2+qRDi8DEmO8xKICg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="35600967"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="35600967"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:40:18 -0700
X-CSE-ConnectionGUID: REfWh1egQ4Cp3euSqgs59g==
X-CSE-MsgGUID: Abi6BQ1HQsqSB30xNuOazA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27130494"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 09:40:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 09:40:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 09:40:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 09:40:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 09:40:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crCJxVh0dk1DnTWxhfUXlGdMyiytgdAXI8Uga0zabvHRNVvKFdon0uH8Hq1WvCFkpgGtYzVk6WeY61LkJShhceYyWzremBC9656HsZ4D0lVKR/CpZFXtM5N4kZPSqjPSagaCwevgSkn56GZKBtnzt7El3QVGMBxYxop8NCy7EgdynLc3mBVtvqr5bLbzLHJ4NY2mb6AYR3aVr9ruVt3turFB2aIFMlaZMvPax98cEBoa5ZAR11OzfLKtLR7XAWRT720TDX/rjVOm+rrqBWHSoQ5JChkhdlTmmlQKsqw6pPhUFUw2ZwwClSrl4KKJc7+mP9RQ3Ir2VDj8nDb8jrJWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4cwN6lR0eznEAfxb81I6X5WuTVfFiV8534DFJ0Thuk=;
 b=n+GBu78Gnz8a9biqrbL6Iz0Jg1xOVr0vZYlXzIwhwSXanRvEy+KShrqLzhIFXZloy4u704HfYFF9ph/PKmAPFDxhUmDKDIp8+26J3HsnH1xc3QrgHFAP6/5U47WwFFvzyKOFsTujrLj0YPbrwO/uXvAKzPSXTLCwkMQQq0Vo6ai2WPmb5Gul9GDf6Yq/wqeYaBHy+Ip6vO1mZEVsVaSjWiCerAuO68HRuNFqFa2keBXpac3Hi7ZFChO01JfngGxY8W7jsxbX/YN12MebWt9jcA+wojFJFB3dSZtNR9naHJr4jnEaxUZaR7RhUWApTfQj4ZoGYe78NDNpvF+iSCno0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:40:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d543:d6c2:6eee:4ec%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:40:13 +0000
Date: Tue, 30 Apr 2024 09:40:10 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "Shiyang
 Ruan" <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 4/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <66311eea8d5b7_1c364b2943f@iweiny-mobl.notmuch>
References: <cover.1714435815.git.alison.schofield@intel.com>
 <ff90c45820c502c5f39c671fb159cc7b2ca8123b.1714435815.git.alison.schofield@intel.com>
 <66305516ba200_1b13712942b@iweiny-mobl.notmuch>
 <ZjBv1zWDbdYYtjQ5@aschofie-mobl2>
 <66311ba6a186f_1c235f294e3@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66311ba6a186f_1c235f294e3@iweiny-mobl.notmuch>
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 9903d108-53ac-4e1b-b56c-08dc6934356c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w2QVHU/3TcIYq1d/7sz5gwyKhW4ziM72PQ6oMjM7LBamH9fN2vqXJYgzSr0k?=
 =?us-ascii?Q?NH7/Y0SgonZhy/YvYYrEw3eOKbmLT7sQ0GpCudBvJwzwUCZvQT7a+t21sHQV?=
 =?us-ascii?Q?b8YK8PZzmnXTNU35RpAox3Ep1fQr9D6dI+ab1j4BXg0f2OLrpW66Q2TVWI/s?=
 =?us-ascii?Q?Q9jRAl7UnpVq1VXqH7ZjgQoXkgpvT9iicmnbRCKZU2eU6hvseosRfVLBEPnJ?=
 =?us-ascii?Q?8QJ5yS6g1h+9pnCUe4Q2Sz2/k9ZYgJ1uMwZzfTJXz0g3DGKVrFGsjapFRukY?=
 =?us-ascii?Q?IV/6NxGyJk9m1s0+PNJbHQnPMk5ZgSCDNkY/+z1a2MDfhIFu0WlcE2BqeXSI?=
 =?us-ascii?Q?ULQi6h7f03p5L+sxxHrUPEpqeOMHkAXinKNJuCpxR4DAQ7LdQBJuLYGKMyJD?=
 =?us-ascii?Q?gA2L8wT6oRvg5CrXzijnEiCPPbSf0q3pD05+by1GETa5ALEhTQyVx0eMeuDz?=
 =?us-ascii?Q?KIsCPm23PHICxr7nt0ML+ESBtLdfrUtwGinX73CnNpXMJh74KlOwrLyZToQF?=
 =?us-ascii?Q?dcmxGsxmgnn+1QDIb+M23jIkWhp0mD1iQoo9wnzGlk1zqgGKQVM7NopBb28o?=
 =?us-ascii?Q?piiXCJoICxti0vz28CANf7EdqYr7Y167EwpzK3xsKSnMuTcXQTVKKjdnzRaF?=
 =?us-ascii?Q?HY6Ks0fFTB/ag+ZB8DMsh1mfM3hxOzOWG5GtUfYYN98dboYGbO8G6X7coqlZ?=
 =?us-ascii?Q?+6V21L50FChgQZGDVtxptaE5kURo0huQxn4ryr5KwF1TXo1CZByoC9deD/gO?=
 =?us-ascii?Q?BWyVjBA6ZqyPoeZ7r+HoWFtrlt/DL3sS8IYJnhDHxx7hjDOHPn3DIYKJJf7o?=
 =?us-ascii?Q?f8Qp7yKljZZ69VCHBX9oENhUFxEDM/VK9pav3YCCZnOijg5HnlNrlJq5qIt+?=
 =?us-ascii?Q?ZK4iqcnzqSx//xzdWJ61UPCwAygUh1Ch08uZPj4KylUaCD6yMIWUvBXcqN8+?=
 =?us-ascii?Q?Z7YPyYYBvbHoF4dfagUZo6ifG7YqhwV6LEHuUSOX81f7YLZfBH5u7rvq19NG?=
 =?us-ascii?Q?ACoe91AjjSOujeCMu4VwTQVWRS/ueX88og1tfvkFE0Wd4gTh4nU3wcNXKY3o?=
 =?us-ascii?Q?OMR98Hkc63xDAkLyv5I51/bFN1jvrIvV+RUw58nP4Pd6WiygKQDEvzMTHWe/?=
 =?us-ascii?Q?0pP3rJRaq0KF/PeWQglF8j/AvO5WReNmjBzgj3rtBJyB/xSd8lp5JVgEsy+Z?=
 =?us-ascii?Q?W8/nFGBkz0Apakz24mhHr6Es1mbBU6lIhvupKp4DTMY0SO9BDxc6NEoSa6iB?=
 =?us-ascii?Q?O1ExGJlVBy7KS5XSh1nOED5Ul4QOpJ1dewpvls9tWA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5qaH0jeOQGVfIC4JCZGCx4WGGWgBvniRTfDYGCOEWO6AHfjK8mfPjs3qRPZQ?=
 =?us-ascii?Q?cM3xBcmVck2gHiTdRjrnayApvQfRr5ChFxfWwr1cE/RMd8vBsbNTRQNrKUH+?=
 =?us-ascii?Q?mTTzcYW1wkbNeXxMURZWeShtEHsR4dg2cBdOYTB7i3TVtX6TyMwRyoPqXjJh?=
 =?us-ascii?Q?teItc4GeADp5M+0vCW/l6ivLLyntOIcdTbl/X6i8ygfWGAg/l8I3fqiRb1sj?=
 =?us-ascii?Q?VRXPcVu2hzPc7BKjlr8hE2nkTYZsIfZiicGXzdM/juH1qeeWosAvrKMR/+N4?=
 =?us-ascii?Q?1OYGTGfAawm766f44BgpQg/TcLUyXpOZAjv+BC9RIHC432e3RV9iRK6Xvsxd?=
 =?us-ascii?Q?2fDUfSmqOiNHF9jkb22oCzMclsKb49AB+uVkjvHlMVyL+qjOOo1yT2h0YD8c?=
 =?us-ascii?Q?NioOrZ9K0wvEpAMsK/IoZNs7iBT13YEFYnGVenQJLw4gYI1achf+GpwWj3dc?=
 =?us-ascii?Q?KKym/5ah0O6MWgVk6AszACMyyRyTV946ogKBzvCWa08k18Dxqj4ZizM1Igm9?=
 =?us-ascii?Q?e4qXKXj96493BtgMEHcfZOeyMWJgJ/OId3fnNrTyR2Oz+QiG+TpV8lABHYlP?=
 =?us-ascii?Q?LldKcteNBHEltFApOu9xvsBPF8y5s1WF7En64bkdFOdvmp2lKH0Uuxea4HmQ?=
 =?us-ascii?Q?t0C9Q/3XiJx6HQUtMTT+wdnwUAAAhy0bqU4KQD3wwnJCL/Pizn+NgYLNnchW?=
 =?us-ascii?Q?VVdsRzbgrAu7NRFWMgRJjpPEAwp7JQXkgY+QSPVdphet+H7hfsRZPdiCQDKQ?=
 =?us-ascii?Q?USBDK0V7ka0fuFSJ4U6PiWAQFrpLyUDKaqjJXSEqYJWsN8NwNPIlGoOybdpD?=
 =?us-ascii?Q?VGu3gzJvC6pQKUjsyX8VeOJp/bTwE1LuleafeTqmPQzGB2wriUT7SywSIeFX?=
 =?us-ascii?Q?nQKrye3A8Mmdi/LcCu9vFOV9Itm55INaMpDQ8amD19B5/G3iDLUeXoz5fPth?=
 =?us-ascii?Q?d95swlfmwEGvH8TyOFD1uDdj3luF0kM+/sTghZhGgoWbZ3jOi6vKPxywFRa3?=
 =?us-ascii?Q?0d0/pUon8xvXRIAKEBQcGcUYu7rkHzbYtoMGNhGYDoVlo75PdIn46CQc6PvS?=
 =?us-ascii?Q?bBKGzYp3vhelygucyh8PVkpGzoPhSRtcV22aIbzLKk7lmJzf/iF3jodtTX4O?=
 =?us-ascii?Q?JFMX2VIOETw5XGvjS6eH7RWSAbgQMFvGBJqvk4dPyzqMdEVPSVWJlp2PG5+p?=
 =?us-ascii?Q?3h0cugqn1EEXpYuWSu8xiPXVnVnt0WTGSdtkvtzsRB5LbpMG9LjqlwypnstO?=
 =?us-ascii?Q?Ox4Zp9gpVdItBqnkppxUBW7jvU7+NcINSDLy6a6kn1Nibx8+TtxWhynY9oLg?=
 =?us-ascii?Q?bQASEs7EdFfxa3x8FAjr04klyNrAKIwvy0jCBcRI8g2JkTcOKJxJduZbQ0NL?=
 =?us-ascii?Q?iaDzWJM9yx0+L9hmTDM5279u3Hl/6xkorCkbKw0aQncpV62OntiFVkAwGq5T?=
 =?us-ascii?Q?spev8Z3Xzi7ZG05s77+8YJ7s4476A3JPspSWlPlzesOTToypG371Ymfwx56n?=
 =?us-ascii?Q?kh/YXTEpdOwxYjcrVV4ujkumwXksRrQU+zx+RyhvUaclic5HyXRAY6Gl0ppk?=
 =?us-ascii?Q?gBb330sDX4tnKPVl/01vM3aNLuF4vPVptZsU+EN5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9903d108-53ac-4e1b-b56c-08dc6934356c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:40:13.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIAMeJoPBXRYvGZ6ELZY+FXejf/5znY3v6AzJb1orfRxgD8b+v0ZUngsDaXb2StIel3aq+LynVbrkM6vreIuwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Alison Schofield wrote:
> > On Mon, Apr 29, 2024 at 07:19:02PM -0700, Ira Weiny wrote:
> > > alison.schofield@ wrote:
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > 
> > > [snip]
> > > 
> > > > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > > > index 03fa6d50d46f..5342755777cc 100644
> > > > --- a/include/linux/cxl-event.h
> > > > +++ b/include/linux/cxl-event.h
> > > > @@ -91,11 +91,21 @@ struct cxl_event_mem_module {
> > > >  	u8 reserved[0x3d];
> > > >  } __packed;
> > > >  
> > > > +/*
> > > > + * General Media or DRAM Event Common Fields
> > > > + * - provides common access to phys_addr
> > > > + */
> > > > +struct cxl_event_common {
> > > > +	struct cxl_event_record_hdr hdr;
> > > > +	__le64 phys_addr;
> > > > +} __packed;
> > > 
> > > Was this left over from a previous version?
> > > 
> > > I don't see it used.  Nor is it a defined event in the spec AFAIK.
> > > 
> > 
> > I introduced it in v4. It is for the 'convenience' of getting at that
> > common phys_addr field. You snipped the usage away. I'll paste it back 
> > here:
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > 
> > @@ -842,14 +842,38 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  			    enum cxl_event_type event_type,
> >  			    const uuid_t *uuid, union cxl_event *evt)
> >  {
> > 
> > my snip...
> > 
> > +	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> > +		u64 dpa, hpa = ULLONG_MAX;
> > +		struct cxl_region *cxlr;
> > +
> > +		/*
> > +		 * These trace points are annotated with HPA and region
> > +		 * translations. Take topology mutation locks and lookup
> > +		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
> > +		 */
> > +		guard(rwsem_read)(&cxl_region_rwsem);
> > +		guard(rwsem_read)(&cxl_dpa_rwsem);
> > +
> > +		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> > 
> > Used above. OK?
> 
> Ah sneaky.  It was not clear to me from your comment why this new 'event'
> existed.

Almost forgot.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
