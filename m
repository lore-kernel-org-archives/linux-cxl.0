Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419C134B0;
	Wed, 19 Mar 2025 00:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343423; cv=fail; b=EfvQoZsF6O1xUtO96pu7r8UDuFaBad2Ri7qCUQi5Ki3wP1lJYBS/rN+Jp0EsuC47JEBJbqY0w6hw7XWw8Q0WgoSWjsnrBAF08Sgr7lPWMau0A/1x5qNIx2HrphYkuvnxYRauvDfDjQtT8uNWZojriwW8TC0K0wt/UxHgRpY9FM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343423; c=relaxed/simple;
	bh=aF+zPJM+I6nsqt6bXH88zqsWd/9UngfJAYSrUD1NOoI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EYQqNoTnAnN0w/kumrkhE9GksfKJC5smh0Tn4qnIwabX1BTj0IpaGFnWwetPIyhp8a+vHYf/4y0Qt1O+PIgqw6ySrx2yl+Z6ldwE0o5n/2anHrZHLqp9vreWfp6UNU+qmSW0qqNuQVac7LYDkQ+cLb0p3aIZlJZzmVMx8/ukbWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wu9uujXy; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wu9uujXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742343421; x=1773879421;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aF+zPJM+I6nsqt6bXH88zqsWd/9UngfJAYSrUD1NOoI=;
  b=Wu9uujXyYSGX5ADIUie4bFVTYokZF6rU6iPS1yanda/qG4WJsK/TVD5F
   ssIfEwoxO4B3tN27uGqQ5voom/4qV3duKQ+vRHJ84HWsPnZc1b2MyEl1i
   gw1QbH0awOk3aK1twlUCjphQgKfeuFRR3R8cDa1tNHPhtICwSvghWKM6B
   NPDymGL/zeLnNaQ5ZuwFXh8HH0Tlu3RGziQAjAfzTdmdtQvf7RdaV/Ewj
   hMJzFwPdG2iN0XkOLm5Z3utRXM8CHGDH6ZL0SPTM4oX4cHmnzOwS0JVGb
   YwpDou+S0YT1wbI9iuvI25Np9rTb0LTzw2lg2C+jFCsG17pgccfBZOaTI
   g==;
X-CSE-ConnectionGUID: LoS3dgaySTG2XBbPln+gtA==
X-CSE-MsgGUID: VP00Td7fQgqWyWgQFKy9wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43615570"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="43615570"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 17:17:00 -0700
X-CSE-ConnectionGUID: NjleBCYRSteVyMdIPmkN5Q==
X-CSE-MsgGUID: aaIAJh+3TD6zoqvsetxpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="153264992"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 17:16:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 17:16:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 17:16:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 17:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVQNd46jYqoIopW3Rrqed6hoCQ0qOuP5lPtwCcAFiesob5p4+odcJPf0RhpeH3OiggSJXsenoNcK4r2IaTbeaqkLu3WVMfVi90J/wBM7dxg1CWGPD3KMUffeDEJPHdLBZ9a7q8oeq66bgld1Avtax4R9ow05BoU9ZVj80QY0ph64oTxpMGGyM+v25wMQt2MUYhnkwSkOEkN/PRMu17b238EBqOXLLk3nF+3zZ76N4bPQeNv+NZAUBu54nG348JTj8JC4fDBaCtuEvZY8pHednRitIVfymJfOty8AHwRr+idEmzMs200Jne3GfpTUCWJPYiS0XIAU+1PWpt8sJ2SkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HslB2DV5xAlB21YqFmVNoHffprU7Y//4K9hXb1DiIdA=;
 b=vQB1ToCwXn7FWqodFydDhHOQzR4RXvlATd4AFFTHLLK+RcwgcSzRrdeHiDYwAHijED6tHeUa06ef5pDPwMxh7tuhDP57Idrrx6Eak6pgQuhMhpBxjZM0iaxdeUpIa3fovv1AMN8dPpOcyLPw1YPjEEY6P2BLuVVHZJB1rlcfDO5GIQ1SXulJlI3vx2nQYEWceIU7q4DeqS2XpNYY3Qrb8T61bw9SFjCJ4WvVgQomED0Lr6nIU7XJ43BF8GaQt0y24kWDkTqerntaPLLJ9dATHg/pZ3fyCDC0mJOw6HqQzBk/YTY6LPfhKFh7pFXwINBZTPYQy5tFvJ7+rU/fxTf5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 00:16:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 00:16:14 +0000
Date: Tue, 18 Mar 2025 17:16:11 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <nifan.cxl@gmail.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<linux-kernel@vger.kernel.org>, <anisa.su887@gmail.com>
Subject: Re: [RFC] cxl/region: set numa node for target memdevs when a region
 is committed
Message-ID: <67da0ccb80781_201f029449@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250314164629.6937-1-nifan.cxl@gmail.com>
 <ac564c1e-95e4-46d0-95c7-7f72c8fee0c2@intel.com>
 <67d9e4d43360e_201f0294d6@dwillia2-xfh.jf.intel.com.notmuch>
 <Z9n9qpySEkwbXN_F@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z9n9qpySEkwbXN_F@debian>
X-ClientProxiedBy: MW4PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:303:8c::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 24526cea-1443-4d63-431f-08dd667b428f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JJcJid0n+vi8UuslRHG3ictopdSQxJLx486I0pjTRCS9RpeDAcqHmYyAt5s1?=
 =?us-ascii?Q?a1a1Sj5nBbhj3Mn9BbYt0AkNF+yTLwz2dnpMIwl6mPeC7k/WSa8E5Sr0FBjS?=
 =?us-ascii?Q?MEqrzU0sXOluYwBgQTBp0QUTQ/a+fCSxeFRCy/aYJbHmi5H1BYqJqjCxfVk+?=
 =?us-ascii?Q?8v7tKpF4o6U2DJrdYLSZW63vO3Je7700lUMUJap+2kDtv1nGNHxX5O+TPMdf?=
 =?us-ascii?Q?OraWU0n+UMV7WMRAkE1cx2zUsqmPMOL4zTgmRVYVBENImT6nazq3WUfuvYSP?=
 =?us-ascii?Q?Y0MhZKHoZM/75CR2XKiza6gaSjbuaL85Jk7DSf9I/LzDrRySL0G9uFFtm/ky?=
 =?us-ascii?Q?YCu5BwdB7OW5f5yD02W6v9dw8HmGfqMqvukKA3zWGlhi6RnlfjyXBp73YBez?=
 =?us-ascii?Q?RWvlBxZHbDG14O0LeNCgT3dYudKxpU7GN7Ahjcko5Kk+OJn7xMr1kErwJV5H?=
 =?us-ascii?Q?0jo/Yy2AHbCW6ITt6dImmMSyL+SDs0wD37qRuP59gvBwt7KrAfBTMVIgjEn0?=
 =?us-ascii?Q?nxb/n0H2o9H7lEqAJYpbcHu9Kp2P56SIhMe6lb8gJj5yfZ39JAwcvBoJC1eD?=
 =?us-ascii?Q?AvnQWOXyPG/XdpxEndvGElfr9GgEQ3Cil42/7mVKaxF3wubmelePOT5PCTYs?=
 =?us-ascii?Q?LEDPXnyH0RkUMG+4K3igm3IZsVY1N4XKwIWopoSACLaYiSAfj7im+NkWZack?=
 =?us-ascii?Q?5crD9K/8H36wIwyuIw0LBtlgZCR6HA9oEEfv4CUJ25zE7UGh31s/POQllljv?=
 =?us-ascii?Q?Xn7EeXfiVqYyb2cJ9k2I6ajzPe38dMdC8eTkvzcazUIVPYwIS64MEjS4W71i?=
 =?us-ascii?Q?bKmH4FlfcR7eDdgBXe/pPeK0IvIRkRCQZ9CIkvHC8dCsflEEYRIGgUR5Yroy?=
 =?us-ascii?Q?4kUPQgenqdd7kvV6/XbERXMRb1+ikSeskqXoSn17nMU1Tp3X1AtsYvCRCyX3?=
 =?us-ascii?Q?7oj3zYdjScLW7m9+Q5ZgXEbpdXs0ypbGTcmDAhdElmAuW8NT4GGdW5P8gGkz?=
 =?us-ascii?Q?6diNh48FtqFnUWZ+0g6RoWt2ADYk4ENjdF5sBlfKLwBNj/ngoWMJhODyiuKW?=
 =?us-ascii?Q?j9t2sOXzYHf66qa1x33UoAwtJdPMOcnuJnarao8eNGsaaM0Nc7C9DpHchtQR?=
 =?us-ascii?Q?6VpIxoKbM22/8VtcKHMaAoEN2sVALfkKvl66SLktKAigfrnCQbzBTgA/dCIX?=
 =?us-ascii?Q?ufB0eJGnkJXqdNOXaqr8iRLtHd7/8TZpt4f2Ry+F2m2ZydBOVjTxrD1/xC/j?=
 =?us-ascii?Q?SMMVUieV3u22bq+eNSca3BbGuQBFDK9CSdfzTfYB/u9BzsvYx92VdgGhiK8y?=
 =?us-ascii?Q?LMGvzMStxQVi4YVcpC4AW1/CgjDWT66vhoxSKMSoUGR8AucbwPwJBR1aUXWG?=
 =?us-ascii?Q?UnEMb0kb63bY1u/o0M+skeM5ypBh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KHjwDo4yDVSYIU4BX+48L20QMmjPNvAEGKkufefpagSILTbvLyOUsfUAPLox?=
 =?us-ascii?Q?iHW3N7VNf/ZkoqsxIQu9cPfh7qXk45i65WHAF/2On3FM3T+ORG85dLWSnBn4?=
 =?us-ascii?Q?YaaYjPEKjguhNj6bHJGbZYskjV3kr9ASd/jT3nhgROCmJu86/gkqP2V48vV1?=
 =?us-ascii?Q?Y3z6dDr6QUHbYWfl1yg3vuMfnMzR7rgcXLzONFk0TZ7QFJ98665v5/1FFelT?=
 =?us-ascii?Q?gwd/rKQ1MhDl24/Zxn2tZIazVV5nchHsAnu33KkJOCH+nV31Giu1rYJrgDhA?=
 =?us-ascii?Q?zrFXhlz5xqrpITQC/Qq+4lh8S5xW6fhO/dqSFBCbzxDJidBPO3cYwGPXNF/C?=
 =?us-ascii?Q?ghvDQ1kG9rpvTAC2o5mjafkgJpohnCYVwVCKs1PTS4uNtwoeaW/xXSHdS1CA?=
 =?us-ascii?Q?uQFb8yqihPjEYp90LU2EvMDAVt4L6TdYtBLemilnCEEAorgpq+4j/qUGOJqp?=
 =?us-ascii?Q?RYiJLLO+U+88KsYQGBQH+XbXdeSshXjS+XqDmfIVc3kz3BMDsh8DRtNlieua?=
 =?us-ascii?Q?/3pexaaOwl9BbWu/cIsx+BVj9eoFMBoFS5Wm+X5TndSKD2kloo7igEGeQsg5?=
 =?us-ascii?Q?k/Ih1cc/BPQ8e9ExLKJsiosw3/d+QvnmvBsT6s6L/3Zm2yLiEBHF/OqQ2euX?=
 =?us-ascii?Q?9rvppLNOvKdyO0RDOIZBmyr6OFDt4KtAssGkZ9oNWmSl2JAqgPe3b+Ysb5hc?=
 =?us-ascii?Q?J9GwsqUijmmLlwbw/aGl44p62xG5VwqdHgkAfvPwl7rNiE6p2g7AZY22xHHY?=
 =?us-ascii?Q?mDFxyaEVW++zEOO0S/CnD4r3Rd9WPrLcHRAQEVI+XdeGqHPji9+xdRTxNoBP?=
 =?us-ascii?Q?61tFq62obiU/xPqErt2B2zWhMMWWaEwgwdTBmcjzVF+eiHGr88zrpgLyfNxi?=
 =?us-ascii?Q?rMliVlpN+/TxzgeZTPIa55wJfpOyfcFuU8hr3OknNdiRBz9aiXd/CFn8cf7g?=
 =?us-ascii?Q?0xIQFDeCS6H5mJI54fBkE0n2ps7ENOUeSlcoJUEe1c88HmqDTGRZO1KyXARP?=
 =?us-ascii?Q?2XK9G7vsxxh2ulSfgk3SoeF9co3xmrkIb8mpsjcoHzOm5uoSpXjeXmusd5Tm?=
 =?us-ascii?Q?1UlrX6EkbW/lgt0rHa4cWnRGE2O+TT81c4s7ZC3uAYcuiDFPk0RZU7C0aLyC?=
 =?us-ascii?Q?FnfYrBWZYez8v8mKKtJErrNWIgmf2b0Kfov6p7fx1VMiYNN7NXY6H14DmakL?=
 =?us-ascii?Q?2W+40U6emFTe9HbfcTklrw2dIVMpEeM5DSK3/Gj4BvvUo0H9wDYAfmQU7VqK?=
 =?us-ascii?Q?EE9fQmHAs1IszlH7JB4zsN8swcmP6QmNOoOBtGTnV6WEKPnb59ospHD8gC/O?=
 =?us-ascii?Q?iONTY/sYRuxTShAwqvYHwv/tmLT7o+y5+RBQiW5HlVQ1fd8dhYE5YtbNTfVO?=
 =?us-ascii?Q?SZA5/+hqu0oJv5jtXi8cAUUxi+E9R0Dkpz9LTXxE0jcbwwE8/sYzGrhxVt/S?=
 =?us-ascii?Q?7bR0bUutr0cduuKiD8k/R92lGI1GADlx+oGpBWIOia+OYpWX/K86oq++VCLo?=
 =?us-ascii?Q?7upcjjeeGKnmzGkdiESQ1b33feqq50tKZDvuoGoP9R+3BxiIKAYvAi7992DE?=
 =?us-ascii?Q?tyoy61KABeLhFtQEhNQy937xYwchAnQr1MyN74u1yEvXFv+mTHBZSz/K2myH?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24526cea-1443-4d63-431f-08dd667b428f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 00:16:14.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9k3/ZCNY6SYB18rKtFdHiduNfwzznLqNjT5rvdT8y89DNt2AqydlK7N2iJBW7bbNHSqbKIkD9s+grW9Vy/VyofTuXDTDj9iYzEmxTqP8Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-OriginatorOrg: intel.com

Fan Ni wrote:
> On Tue, Mar 18, 2025 at 02:25:40PM -0700, Dan Williams wrote:
> > Dave Jiang wrote:
> > > 
> > > 
> > > On 3/14/25 9:40 AM, nifan.cxl@gmail.com wrote:
> > > > From: Fan Ni <fan.ni@samsung.com>
> > > > 
> > > > There is a sysfs attribute named "numa_node" for cxl memory device.
> > > > however, it is never set so -1 is returned whenever it is read.
> > > > 
> > > > With this change, the numa_node of each target memdev is set based on the
> > > > start address of the hpa_range of the endpoint decoder it associated when a
> > > > cxl region is created; and it is reset when the region decoders are
> > > > reset.
> > > > 
> > > > Open qeustion: do we need to set the numa_node when the memdev is
> > > > probed instead of waiting until a region is created?
> > > 
> > > Typically, the numa node for a PCI device should be dev_to_node(),
> > > where the device resides. So when the device is probed, it should be
> > > set with that. See documentation [1]. Region should have its own NUMA
> > > node based on phys_to_target_node() of the starting address.  
> > 
> > Right, the memdev node is the affinity of device-MMIO to a CPU. The
> > HDM-memory that the device decodes may land in multiple proximity
> > domains and is subject to CDAT, CXL QoS, HMAT Generic Port, etc...
> > 
> > If your memdev node is "NUMA_NO_NODE" then that likely means the
> > affinity information for the PCI device is missing.
> > 
> > I would double check that first. See set_dev_node() in device_add().
> 
> Thanks Dave and Dan for the explanation. 
> Then the issue must be from qemu setup.
> 
> I added some debug code as below
> ---------------------------------------------
> fan:~/cxl/linux-fixes$ git diff
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5a1f05198114..c86a9eb58e99 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3594,6 +3594,10 @@ int device_add(struct device *dev)
>         if (kobj)
>                 dev->kobj.parent = kobj;
>  
> +        dev_dbg(dev, "device: '%s': %s XX node %d\n", dev_name(dev), __func__, dev_to_node(dev));
> +        if (parent) {
> +                dev_dbg(parent, "parent device: '%s': %s XX node %d\n", dev_name(parent), __func__, dev_to_node(parent));
> +        }
>         /* use parent numa_node */
>         if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
>                 set_dev_node(dev, dev_to_node(parent));
> ---------------------------------------------
> 
> The output after loading cxl related drivers looks like below. All
> numa_node is -1 in the cxl topology. 
> 
> Hi Jonathan,
>    do I miss something in the qemu setup ??

IIUC the typical expectation for communicating the affinity of PCI
devices is an ACPI _PXM property for the host bridge object in the
[DS]SDT. As far as I can see QEMU does not build _PXM information for
its host bridges.
