Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BEC4A1D
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jan 2024 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219358; cv=fail; b=TTr+MNfMdx05ORsWjaigScAqInjE7APXfTHHIdbI/13SPdwmIPLJn/PsZcNwS2CwYdtwnBtuonr5aFLUhh1XbCiDMlVzh7BIDwt2/5MDt8tOfqB5yb0yiWDZsXXg3I5ZCAyIefbwh9ykzVRgLTXxZfxbV95jRxDI7NjHkfE/gxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219358; c=relaxed/simple;
	bh=hDpI20pJFJVUFE7PDK+H8EaqQYpWET7ll3/pdO/Bf4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eiVe0jbLZsYfeoyPvF1AxBPZWQV32Wti4Gj97+egyzJxyPKCAySLcvNOlTKj7vR3nzZ2wf8oe2Nccj7A9DbwDkCJfFVoQoJmvHbhSvyCqViMZF5lak+gwrwLU5us7H9ecQyf9RC92LCG1uEtjp741L5aZM11tcRqOP9U9sebzHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTUN3LSO; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTUN3LSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706219357; x=1737755357;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hDpI20pJFJVUFE7PDK+H8EaqQYpWET7ll3/pdO/Bf4s=;
  b=hTUN3LSORX6AGyOMWDThyQk0xAfky8jnAKCvJfHrZ0hsHmOb9aEmCZsq
   QaieC4bJEBezziKXpMVRY/KpRZeaXtudhCPJjy+eyyhfVeJGXes14xhKf
   GKGmfY2kSJXCyCoJjNFfTXuFAbSs9guFbhQ2uJdGsO/LjmCaYyjCXTErG
   Yhz3TDnJoyzxygZ/fZ5xrKyuEGL8+10aZH6XiDEThj+ns435+t9ZvK5wW
   vSolxz3Q/StWTgzZTXSElWvNl6twaDRp4fVmohMi4nscqzinQsK/deJeO
   BBVOkki8B+H3BQ5yUyRt2s4P3JCl7kb7IS5SbQVM/gB2uOkJrdEB+XFBr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15841501"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15841501"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="877179324"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="877179324"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 13:49:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 13:49:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 13:49:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 13:49:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljku2E4Nn5xz9n/lSEQ+YHT2eywhH9c+IwjYmB9LWqzqy2YwxdP420z2qsaS6lXPM8YfSsWlcfgyoyfuw2kTj/694p0TAoHzYBLYAfjz7hygWbZDDSETJPrA/HtWvd9kEDsoIXZhkoq84HozQXo1yd8PGSWaVVw/fw6j27WR0wqiSEPLORTImEHtvQeJ2j2FkYv4qHFcYiYorZ6tAWXNKZ0VrYfpX63MPBKvYq4Lk83p9UmDGGtR28YNIt/U3DAns48IZNxhQ2XbXW12ATPSum18qevDpZ0kOCeoVMXg6LGJdptI/zqiDU7W54xqVA9MZ03HKPl8X5GE6lRq1dE8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3XzqARUUU9xQJP9Aq3YsIo1Igfbp8YFkec6b4znG2s=;
 b=Lc/WdGU6Wn+FN7878pBm6WMjiky9jpsyXHBLpY2cIVC9IPqXNBIMOoHT1M6WH0vli7zykKBOXmkCz2wDVfHiWfVenJiFSIQL1vKOweyNnEK59wVaj42gAeAOW9ktIc19U+AwWfZtRSI86uhgIstdW1ABKcVAKCShs9a7pTkhIqNbLA/dHzRm23z+/akIr7BKXeRAp3DJ5VHBwiEzjj9OsQ7iYKxbHlKspkVWbi1pJ+rGoCLDH8Q9ZqQ6s6jWCnhPeglnRTvgeIlIms5cc4qs/AoUPK15B9tR9bhODuwxndNmORvPDpo71yJkULtshGkt9GgV0PpAX/B0+QZR76V8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Thu, 25 Jan
 2024 21:49:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 21:49:10 +0000
Date: Thu, 25 Jan 2024 13:49:08 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
	<linux-cxl@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Mike Rapoport
	<rppt@kernel.org>
Subject: RE: [PATCH 0/2] x86/numa: Fix NUMA node overlap & init failure
Message-ID: <65b2d754128f0_37ad29453@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1705085543.git.alison.schofield@intel.com>
 <65a1bce74f420_3b8e2942@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65a1bce74f420_3b8e2942@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:303:b5::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbd8d2f-9553-4c47-dab5-08dc1def76a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ysybgRg3WXX0gv9TwFDrbK8JDYtB/9oPcNnBoQ0hClDrSAB6Tbwf8W3qN+Lpfx9k1N5mzQon/i7oxVJggqMeNk/UqQLShcJEoHvBcp9mjxqQL5aZBhIvxF+vheyvMEqan3UEltZjiK23i58wGDP8cVRxdbTQ2jJxHkR1ccRQ1hAWeWMLolUx2ThFB0bSsPhPSiYKh3MvSEXLnxzh1PHEAhlDcZPhHlnPIhIoIlygXCy1qB3+GZy6MNyhTnH9Nri9JzumS+zkM9N9iIb9cAI6NZmuae7362d7kHwHTuEgwYQc/FOrhko7cnPdE0rJ5oZ/dcV2WwBKEEm0nA8U6L6aekqH3Mo46Ze5wyJWbdhS3AxrMzMIAO6V07nOR3gKTvIVrFLA9IgcZNznKbIc/cpWkQkrC1JoCyueTdqPSaKk0GSVmpJAeOZJGT9PVDzteEfMdsyMLWv0xS6fJs5LtURo1O6dtauH3NYQn49T4BZKHpx0sAsY5MNgSvydUHXsJlLhMyCF4sdheQ7y55Yuy+mNbqymZK/kQqbNYimxLMNXl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66899024)(66556008)(8936002)(8676002)(4326008)(66476007)(7416002)(2906002)(66946007)(5660300002)(110136005)(316002)(86362001)(966005)(54906003)(6486002)(38100700002)(82960400001)(6506007)(9686003)(83380400001)(478600001)(6512007)(26005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRo3dc4U9kYkrcHlut/3FT3ltwn3cDgtUlU/rc0OQlt/tGAKWJGv4caHIXk5?=
 =?us-ascii?Q?ituGAtIpTrPs+ftjDpJfWbYfBQohC7ai/jHZZHeDT0QsDxtyNTAJjKpq/FJw?=
 =?us-ascii?Q?C3Kq0uOn7+spOwxbgU9DwZtP63N1oa/KRvzCSLAOZJQV+c5z39dLKP5bDvJN?=
 =?us-ascii?Q?4Y2sYgeTLv2p4Lft124Bwu5w8aFYsaq9vzrdHS3skqsDnrOe4WR3velUsgBE?=
 =?us-ascii?Q?11yez1dR5y7FFVS8WrcwoOGWbxUx94SmrVh6Hov3BipEq9ZFWA2z0v+Ay29U?=
 =?us-ascii?Q?X254Ky6Sd7H0toe87E0PAPHCxVJ3gJUDP/kioV998DEdeYEyWGes66RnB0P+?=
 =?us-ascii?Q?pw7YLeoHxKkDhIYC3MqKkEHw6OACIIaGsHjrStodgLsYPFZK9cj5kWFlshXr?=
 =?us-ascii?Q?4TwQcjuXAFnoKi9X4PBSAqviZ/FDbeJfpFabw1HuCPhIMG+o6n24klyCYfqA?=
 =?us-ascii?Q?gYP2sh/9fPTwSbGLsgdsETibh3zLnD0qxqUMk6oS7me2ZbjVe2um24v2D4PY?=
 =?us-ascii?Q?BzgP8BWtQy3KYixITpf+OHfpZrFEmyP8YisxjKsgvNMzSjUnt+TPuUbr7mc6?=
 =?us-ascii?Q?g0dHLBVmPv2a/U1DCgMEOt1uS/4q4XP6xv3LBF99jNGflJ/dAgUDBQNSV89Y?=
 =?us-ascii?Q?123nkkdyfsBMpiXRmWK4/pdsZchOHIonAmExDT6wmjCw9Tb2p/Xqtc9wWac5?=
 =?us-ascii?Q?0FtG+j4ENRqt4eabcJ8/Jnp6/lWl4X3mto0d92TpIwp+KrSK0G57IZYN3GJ3?=
 =?us-ascii?Q?4aTaAXI7+l770YruUq3N7PykvjBd8ohJ+dtNqDMp8KU9rzAoBvDPqGNz51sd?=
 =?us-ascii?Q?Cei9DVOKqvt+aGfivnzyAEY62W5cnqHR6yoyRO0SE3W9xkGnuVjvRdWFoPEF?=
 =?us-ascii?Q?GW+Y8ckjWIfMJmyOTCMkSp4tZSS7Tns90nC+G8IQjUH45FVWCRspt3/OBN1N?=
 =?us-ascii?Q?Fjz7zyssxomRvXY1cCdTJL3QTMVmi0vm0mV6K35yCeLkO/mkIYKHb7wZPpWk?=
 =?us-ascii?Q?eJfp99zmhzOdHURomR6GHS+/edtbZ1Fs5O0/gBHVq8RKbUhjBk3WZFzwSS53?=
 =?us-ascii?Q?JdsRA5ro58gWPY4Rdr1b5GvZ9M29K7jjXjVQHOtUyBrYDTF6x+/lJelGYFPX?=
 =?us-ascii?Q?QN3hf2VBbzdJY6HboNGcU4plnJxkKSi4MS/SBVi24qKlA1itzqbcpt2MCCrf?=
 =?us-ascii?Q?X69sh3WqD+878t3HYGgbjR48xqfWI2ZLlz7kR7hwhzZt2EJGGOJsCvu6fiXc?=
 =?us-ascii?Q?W2jk0Jx/x3Ksraxa0pxh/B4JFNIxpv2CV6h09KMEe8wWLymcIUkZjTs1+bif?=
 =?us-ascii?Q?9TbyzhS8qa0qhln9nC1V3uVytT8rkwimPn6Yjl3mLxbC4yFZFoLYDmjv7PfW?=
 =?us-ascii?Q?ZuZTeYRd1VqcN1nFbj2yjde8+H9HXFBnCgUAxLbVx4XTehsgzi+TorsGT1RJ?=
 =?us-ascii?Q?B4+lVspG5GVgRv7HH/DhCvYe95zUMRZl//HDErMaaxzRO2Vjez4vwnttIFhd?=
 =?us-ascii?Q?CUzf2ahcQ9kpaPGTwjl+H7ZEK/k4zFrKJJZCuCpzq+Ta5Et6UW9Xwa820FL7?=
 =?us-ascii?Q?8+xkzh8pC/VmXqEXHX3bTkqdMAIDtFvpEzde8ITVaajApcfNmFUFSSROADUM?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbd8d2f-9553-4c47-dab5-08dc1def76a5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 21:49:10.7735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJcLX4TOnZA/AUFvPjUncwAEt8po7fCKQRzF6cbaG0Rz1sviLmy6yG2DFUPY9pGqAD6RsnFScSHPdImAIQoV5dXS/CUzeMPAyAWmwLQ5QZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5564
X-OriginatorOrg: intel.com

Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > A previously posted single patch [1] is obsoleted by this set. The
> > feedback from that review is applied and noted in Patch 1.
> > 
> > While trying to attribute a CXL user report to the bad selection of
> > overlapping memblks, as fixed in Patch 1, I found that two issues,
> > in sequence, lead to NUMA Node overlap and NUMA init failure.
> > 
> > An overlapping NUMA node occurs when a non-overlapping memblk is
> > selected to fill (Patch 1), and then a bad sort (Patch 2) puts the
> > memblk with the greater address ahead of the lesser address memblk
> > in the fill list.
> > 
> > It looked like this:
> > 
> > Existing memblks:
> > 	node 6 [mem 0xb90000000-0xc90000000]
> > 	node 7 [mem 0xc90000000-0xd90000000]
> > 
> > Call to numa_fill_memblks(b90000000,c90000000)
> > 
> > Error (Patch 1): collects 2 blks  
> > 	blk[0] node 6 [0xb90000000-0xc90000000]
> > 	blk[1] node 7 [0xc90000000-0xd90000000]
> > 
> > Error (Patch 2): bad sort of the 2 blks
> > 	blk[0] node 7 [0xc90000000-0xd90000000]
> > 	blk[1] node 6 [0xb90000000-0xc90000000]
> > 
> > Seals the deal with a bad fill:
> > 	blk[0] node 7 [0xb90000000-0xd90000000]
> > 
> > Boom: numa_clean_meminfo() discovers the overlap in Nodes 6 & 7
> > and NUMA init fails.
> > 
> > Since the scenario above is not solely attributed to either patch,
> > the story is explicity shared here.
> > 
> > [1] https://lore.kernel.org/linux-cxl/20240102213206.1493733-1-alison.schofield@intel.com/
> > 
> > Alison Schofield (2):
> >   x86/numa: Fix the address overlap check in numa_fill_memblks()
> >   x86/numa: Fix the sort compare func used in numa_fill_memblks()
> > 
> >  arch/x86/mm/numa.c       | 21 ++++++++-------------
> >  include/linux/memblock.h |  2 ++
> >  mm/memblock.c            |  5 +++--
> >  3 files changed, 13 insertions(+), 15 deletions(-)
> 
> For both fixes:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...if they get picked up into the x86 tree.
> 
> Otherwise I'll circle back and take them through cxl.git with an x86 ack
> since this is all cxl-related fixups to numa_fill_memblks().

Circling back to check on these now that Mike has acked the memblock usage.
Dave or Peter, please pull them into tip/x86/mm, or I can circle back and grab
them next week.
