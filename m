Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6733A95C
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138246; cv=fail; b=HSq2KbOFM1wIas+R65qkCLFgjcBi8W/h8z1epoEM5+e4T6TBqJtrxp6tJh/Zs+LB5ye+zOVuzbvllApH50RgvobvQzV11od6VdG7i1poeQmzs0DwcSKmpSC2senoVh5JGLvbs8ldnZXbA9cKRMQR2vWAZmtGNNcUyWNplwt9UpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138246; c=relaxed/simple;
	bh=Fef1Vaj+g4tgE2BGFc5a6fD11uPL2v93TOYy6Fi6UZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rEJRjjUFoMldhfwDE8CyFoDah7H3gWJH1rLDvb8qgenH8PUOKMHGtS7Eq9LRmxzh2uZmY+Zmit716EK0pvTzDj+b9Ep3wS2+nvPlNUfPRS41eBq8ayFucOKo4cbTE8PXoNx0VkNyxTOvuDORsa0WQPkIKKKRx7eS9taqIEOQryY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ll8+UoRp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ll8+UoRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737138244; x=1768674244;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fef1Vaj+g4tgE2BGFc5a6fD11uPL2v93TOYy6Fi6UZ0=;
  b=ll8+UoRpyl9hV+8XTTETEVdZfzxQxxLsvYUhgv4EnfafNGivwMdzKePx
   WDSda/1SEyT2WdjQQ6uuXiJ70UYRRfQleA+IdlsgLvo+MgkDeXPSiqh7C
   TvfP4/4+4uz+PJudqKFTbDlbklYosHM5eySvj0HG5GqQSb0C8IoUv+Rd0
   TT5WAw9IsNH2D9CoF0BFioHhkFx3e9gD/GsVm7woz0TYISQLwVctslia3
   IuyyxuPnSb36AyUpw7X/AaDV9XEaVr3iArVFTuaoey7W6zRx11iR9ieZ/
   wN2818HxGQywThr9rY0Polo8khPfm7HeNFbK2CnNtYJ0XsiKoO9k/zK2V
   A==;
X-CSE-ConnectionGUID: ijlmp+0MTlynvR00badDqg==
X-CSE-MsgGUID: osDuGiP9Qbi6hf3F+wkakg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37695568"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37695568"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:24:03 -0800
X-CSE-ConnectionGUID: hnMMAn7VQZu6+dC/Rdezrg==
X-CSE-MsgGUID: E4KswvF2ShahQxF8YNj/FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105712491"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 10:24:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 10:24:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 10:24:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 10:24:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcijP6l2HfeqI/c/x7lLBDwysfi1RE7CZc7Ne02wXpD4RuCl+yd8TEnF3c6P0IUlQyzOdhL/F++4t57wS/yJlcnNPAIxxrvajeipcLxhTmZClHs9vf5QwBLFDWSYmx2GkOPwfvQ+a886qV9vpuJNXTTXV4M+S9OvBLZj6gxHGAAO4x8h0Y2Rb64hwQrxcUdpGSuvAje6b1jCSguC0eDKCe/UGD4nqc+Kn6gkQCC+gs9/FhZTXX6jp2AO6YWB3zDE4/RP9CD9Ld1BYKV57xBVe4SsfxWD8s8Px4xrQSbkqDGyGlE22mUIyyOTlZ7tDXYB3oqnOq+FVR9fcRwNtAd2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Xyv2Z7nDVcLbtbnH+mxs/WF5CcZm5PHK4viPoeDu+Q=;
 b=MwfhN6aUOn/VbD4W6Z8L2YxAAyiOhyqaO/wnLyqmS9C3xYFoE0bmRIEwQ+HPZtgN5YjW459+H58cEuiECopCP0jIdlYYnyWwfcECqsKi4Fi5+JKty8HMbWu98QGT/0mKY89EpkbukaHtweKsBtT8lDW4dHhqObed21IBq6aEvrOVZ1hOfIbyxorS3H/D+Q1/p9M5yMVdsDsQgVKUK9S178933BObtfwWwRtfFavFqDBeJxoFuDX/bCWy264blZRKxO0EJ7yfjId7Kc9oJJZlP9vf40K7gHjm3iYnBIn2fMW+HGyMH2ypiLLXCEY0PBt+AhA6q0LACRO1/IlhSCScsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 18:23:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 18:23:54 +0000
Date: Fri, 17 Jan 2025 10:23:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <678aa0381324e_20fa2942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
 <20250117105254.00001dd4@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250117105254.00001dd4@huawei.com>
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: a57a8cd8-e0f5-4d44-57dc-08dd37241974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1igGJMPri2vmjALpXKPSgvTQzDsOAK8dmd0Au9SaKFvmKeT64pD+YUZehAA4?=
 =?us-ascii?Q?p3kmNGsZMYza0ePKEgBwI/91Aqjh3noL+sqlQruJqFB2PHXUK6k/Q/Yf0GAg?=
 =?us-ascii?Q?A9U1FATkrWdFF4gShrIvrqHIi6Rg2G4v+IkVwzuuiUUgl58qgzOOZB1oOPBg?=
 =?us-ascii?Q?zWaeQPzqy29jDVDH4iXHZfcXKoyvD8ED3qSzuYJApZa9Qat2vtpF3cd2l6oD?=
 =?us-ascii?Q?3ehNig7jFBizfS2n0WDPBsRpXGDVucNWpNEk50qKXEwJgV7h0+EvZXjOr0Zt?=
 =?us-ascii?Q?FR1xhPeXiibm9kNfoKgMNRypBtkLPSLi8qAuzbBLqdRRv/ZWQbZCawXNxjvJ?=
 =?us-ascii?Q?8ZzMLjggbuFjHNHDiVYdaoqVq9S0gXwQaVXU26KpZdtHfNOjQv9ei/JplkoK?=
 =?us-ascii?Q?dq/F2WiaIBZWm7XUoIDKTGFp6yXz6evDJqzwMflKBqHi7XY28l+jP4EQ2Z11?=
 =?us-ascii?Q?jHCFs7YaHoOQAWjrQ+m2vPJ6NPaBiYjltKZM44AVExK8cj1L++CNILPAyTDl?=
 =?us-ascii?Q?40Ccj4mnU4QCtj48JgiA/Ko0W99r+riXH/O9ORJsaGEiLKYfYWLEMlDjNVTD?=
 =?us-ascii?Q?2fNxJmSHJL4u/9zG89kqUoQBRI7f2QW6SSCnCAL+6QqBmbFrg4BmmdVAfVGr?=
 =?us-ascii?Q?ZXvry5zw41K33mXrpEd/hYEX+zau5lSOV7rUZAfDkVt3tUy91XTVg+cDMhXO?=
 =?us-ascii?Q?4RSTjx+DqvxUpP84kWIEY8T8loRgeTuThp/Yn+y8KrTLWPKebBZbtpym0eXg?=
 =?us-ascii?Q?2b0rzPDEhixw/KR+uIkTF+ukB+cr6CcfVLeeIfq6iia7FQKIiJ+MYGbVyhWN?=
 =?us-ascii?Q?7rk5Do5lN2DV43DgP16QAS4dk/heylNBztwdd2jCl6XD7pb4bKtNWd4UTXEX?=
 =?us-ascii?Q?wi1IKRE+kSeviksyv68pjJ6K/FP2GK76wBffUwj1RB0UDVfTXeKcve2N+IbL?=
 =?us-ascii?Q?V2i/17SQ6n7ruHJEv8wAQCXz4xu54Jin1Va/M9KJFZAptSH5rIMZpomAD/7C?=
 =?us-ascii?Q?exs3NqzZi6QrJI4WVCSrX8B2I6ChVPHNZM2hkuaU+EKGBVjqe38CX1hjce0Y?=
 =?us-ascii?Q?EkrfZ16tXhRtd5CQP/r9meMrBu18hHtAu5ygT+g+c1hiUVdJ3rdKYLuCtFej?=
 =?us-ascii?Q?Eh5dwukuF3rHvJ6ZuwFqJW/ZNJxGliaIF66+jdk/+wiA6fL2SXjnAmTV4IKx?=
 =?us-ascii?Q?VxmUA0MIS7VRKblMIIuRkt1pjckHAv1lb5lG3z8K3/0BmaAdY6zZtiLwVQRG?=
 =?us-ascii?Q?FSJo1gaZr6ZH01BvmUmsRWEqV299Y01fuGhj4a089yDgauGEjLiWmGOc8zDG?=
 =?us-ascii?Q?hK/LRO6G60r4b/21GwwIpuszzle6hNfpun0M6vbaqfGx4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c1WC6gj1mddteKoK7MkNluOzYy7GEnzLg+yTqlddigdMuVcZ44xGW1Onuzzx?=
 =?us-ascii?Q?NSuBNdF7pKKDBZ//bKWEc1wtMzNORUG3MZk7gXYuzwPoSPJ8VWiFzNbJXEL5?=
 =?us-ascii?Q?NAz6yKN0PWc+x0CaAdKjwHtHWr1KYBQ9dTSt/vqAGPcJ/OAnYttAACm6Cj2R?=
 =?us-ascii?Q?+ikjiwaLmPd7nHTTY81PhFU+1BQP1lH/KNkclSq+cU2f9Kekh6zvCanLfQNs?=
 =?us-ascii?Q?ovzYw9KDvSewfvAiehXimQzbzagti6g8Ig7ADL0sQeAQ+8hZfiwWADuhURpy?=
 =?us-ascii?Q?gfqgiVUifXgRgMEzJEENAL6sNKY529qDGvKimpbTr6EODK3QH6gWx4HHeBHD?=
 =?us-ascii?Q?RgY7af5XzqtpTqdRdNSaHeSY1B1YaDi0t+SC8ysSR+nDMhrykUSjjK/fT/eO?=
 =?us-ascii?Q?5KncdQXJqr4jBTQv8LNIKw4AQ//YjERPWGFaz5dsJghX2u18OkQToqg5QFLz?=
 =?us-ascii?Q?ns53del352caXYn1/yM78KeXzXh4+7nrcMtw2zqui/xpESgtKpRBCG4Xbrsh?=
 =?us-ascii?Q?YE/Pah6w/J3eh5tW5RuWYRei+RiTb+DD1unu9KJcW4p5ZA78Lv13OL1YrPAP?=
 =?us-ascii?Q?wDHRxutu8xGwwcOBMTYz8y//2Jyo18H2f3KdUHmCU9jBbeJyJyXrga49G8ZH?=
 =?us-ascii?Q?4vdkhu18debVYvygAaP2oLfHiwWzBiYI6r68j5FjbUYl0w2A22fNw5UIeZyA?=
 =?us-ascii?Q?2Gc+0UMjYu2VwjePWlGVqxXnqMqRh2Zi8SDSd/uN1ZDnf7F5ZxCx4wt+6WNA?=
 =?us-ascii?Q?hJqZibb6nV5Hdxkfu0ce+8baoIzs8n3nyP3ENmGlwfOS+7zr/KxJWyCEIcCD?=
 =?us-ascii?Q?JjmIwdVNYnDBTooh3mCDJDSyLtWTwFv4+tMwOWr5ohMltwC9JeYY7Fp2L9W+?=
 =?us-ascii?Q?OqGoF8MRzEb/xnYff6vs8ljG0yDYDxPXtB29iIATygQW8NSSouHizwrRsTMm?=
 =?us-ascii?Q?/gDoCLmpMa3hjWvsIC8f5UDIwnee2JYW0JYxAS97JNjzICA9rcIk0c2j1J3u?=
 =?us-ascii?Q?kF3GNVlpIR+YBYK+SjTBUom6qTfojEZWGTA16tjazVOMSi089Vaqqs+CeCyb?=
 =?us-ascii?Q?Hzr5hTyyl6LGggdeDaUAiiDvcLyuJT2ExQbrCHdd+etq/qQot24i1RWauyCH?=
 =?us-ascii?Q?7KQsnz4Fa9ZSdmQzolXxP8Z8fazNX2x1wrGbP23HXBMYxxmj4fPCMpv2VJ3g?=
 =?us-ascii?Q?4h5YZ3CWjYtK5WvjE6d/xvCpRDapUu7iaVJCoEvBopyr9mLAgaswRDrT574q?=
 =?us-ascii?Q?XvcPPK7qHGLUahdtccQBsgf8ZfaY16OrpuC6r2VcG+nauUENKcyKf77R/8X6?=
 =?us-ascii?Q?ZmAb+2WJsWQT/Co2y0nlN/QauykP1pSSk7fnyt7BFRDBMAcSWCc3wBHZvw11?=
 =?us-ascii?Q?gedMjloPRDnKddPWOoHDUHf7pcnqgJ+pwdeZMWgriTimp8Imi4u+zOfZ+VpA?=
 =?us-ascii?Q?nGKNMuNFsoNRN4gA4EVRVTkAPQrZ+vSY91aHx58aKLeGzpMxrbmQEwBHtK4s?=
 =?us-ascii?Q?Bp2fb0NGh30J/Pv97acWHGBwwA+HUqqt/jDX4dRwR3kQUrJutv3UCTsFyEum?=
 =?us-ascii?Q?loNn3gp+W4DIKll2MLVxoG2QBd9cRUIbwJtYJjehqbg8DbBlM2wMw/bgGe8Z?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a57a8cd8-e0f5-4d44-57dc-08dd37241974
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:23:54.3709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iWDKA01zl7SkwZMbsWXmepnDUHSJEsWRdW2U77CQ2GBh7I+8Yoai2PUtqMpJyQE1WoPjIjH9MEVaFW/wOKrsMtrl7RrHbjZQ+pKmIVXnrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 16 Jan 2025 22:10:44 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The pending efforts to add CXL Accelerator (type-2) device [1], and
> > Dynamic Capacity (DCD) support [2], tripped on the
> > no-longer-fit-for-purpose design in the CXL subsystem for tracking
> > device-physical-address (DPA) metadata. Trip hazards include:
> > 
> > - CXL Memory Devices need to consider a PMEM partition, but Accelerator
> >   devices with CXL.mem likely do not in the common case.
> > 
> > - CXL Memory Devices enumerate DPA through Memory Device mailbox
> >   commands like Partition Info, Accelerators devices do not.
> > 
> > - CXL Memory Devices that support DCD support more than 2 partitions.
> >   Some of the driver algorithms are awkward to expand to > 2 partition
> >   cases.
> > 
> > - DPA performance data is a general capability that can be shared with
> >   accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
> >   suitable.
> > 
> > - 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
> >   memory property, it should be phased in favor of a partition id and
> >   the memory property comes from the partition info.
> > 
> > Towards cleaning up those issues and allowing a smoother landing for the
> > aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
> > array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
> > way for Memory Devices and Accelerators to initialize the DPA information
> > in 'struct cxl_dev_state'.
> > 
> > For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
> > get the new data structure initialized, and cleanup some qos_class init.
> > Follow on patches will go further to use the new data structure to
> > cleanup algorithms that are better suited to loop over all possible
> > partitions.
> > 
> > cxl_dpa_setup() follows the locking expectations of mutating the device
> > DPA map, and is suitable for Accelerator drivers to use. Accelerators
> > likely only have one hardcoded 'ram' partition to convey to the
> > cxl_core.
> > 
> > Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> > Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Hi Dan,
> 
> In basic form this seems fine, but I find the nr_paritions variable usage very
> counter intuitive.  It's just how many we configured not how many there
> are, potentially with 0 size (so not a partition).  I'd be happier if we
> can avoid that by just prefilling the lot with zero size and filling in
> the ones we want.  So zero size means doesn't exist and use an iterator where
> appropriate to skip the zero size ones.

The PMEM-only device case did give me pause. Is that 2 partitions with a
zero-sized first partition, or is that just 1 partition?

Ultimately I do think the code should further evolve to treat that as
1-PMEM-partition, but as far as I can see that depends on 'enum
cxl_decoder_mode' being eliminated and teaching all code paths to search
for the position of the PMEM partition.

> Without that tidied up, to me this is more confusing than the previous code.

I was going to save PMEM at a partition other than 1 for the DCD series,
but let me take another pass at adding that to this series.

[..]
> > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +
> > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > +
> > +	if (cxlds->nr_partitions)
> > +		return -EBUSY;
> > +
> > +	if (!info->size || !info->nr_partitions) {
> > +		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > +		cxlds->nr_partitions = 0;
> > +		return 0;
> > +	}
> > +
> > +	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
> > +
> > +	for (int i = 0; i < info->nr_partitions; i++) {
> > +		const char *desc;
> > +		int rc;
> > +
> > +		if (i == CXL_PARTITION_RAM)
> > +			desc = "ram";
> > +		else if (i == CXL_PARTITION_PMEM)
> > +			desc = "pmem";
> > +		else
> > +			desc = "";
> > +		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
> > +				 info->range[i].start,
> > +				 range_len(&info->range[i]), desc);
> > +		if (rc)
> > +			return rc;
> > +		cxlds->nr_partitions++;
> I'd just initialize the rest to 0 length similar to what is happening
> if we have pmem only anyway.  Then this nr_patitions goes away and
> stops being a possible source of confusion.

Modulo teaching other code that wants to ask "what is the size of the
PMEM partition" to use a helper that hides the "find the device's PMEM
partition".


> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 3502f1633ad2..7dca5c8c3494 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1241,57 +1241,36 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
> 
> > -int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> > +int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> >  {
> >  	struct cxl_dev_state *cxlds = &mds->cxlds;
> > -	struct resource *ram_res = to_ram_res(cxlds);
> > -	struct resource *pmem_res = to_pmem_res(cxlds);
> >  	struct device *dev = cxlds->dev;
> >  	int rc;
> >  
> >  	if (!cxlds->media_ready) {
> > -		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > -		*ram_res = DEFINE_RES_MEM(0, 0);
> > -		*pmem_res = DEFINE_RES_MEM(0, 0);
> > +		info->size = 0;
> >  		return 0;
> >  	}
> >  
> > -	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
> > +	info->size = mds->total_bytes;
> >  
> >  	if (mds->partition_align_bytes == 0) {
> Obviously nothing to do with your patch as such, but maybe tidy this up
> by making active values == fixed values when we don't have partition control.
> That seems logical anyway to me and means we only end up with one lot of
> range setup in here.  I can't immediately see any side effects of doing this.

Yeah, I mentioned this in another thread. There is no reason
for 'struct cxl_memdev_state' to carry these values at all. They are
just temporary init-data.

So, cxl_dev_state_identify() becomes cxl_mem_identify(), since
it is a memory-device command. Move it inside of cxl_mem_dpa_fetch()
since it is just temporary init-data for 'struct cxl_dpa_info'.

[..]
> > -		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> > -				 mds->volatile_only_bytes, "ram");
> > -		if (rc)
> > -			return rc;
> > -		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> > -				   mds->volatile_only_bytes,
> > -				   mds->persistent_only_bytes, "pmem");
> > +		info->range[CXL_PARTITION_RAM] = (struct range) {
> > +			.start = 0,
> > +			.end = mds->volatile_only_bytes - 1,
> > +		};
> > +		info->nr_partitions++;
> > +
> > +		if (!mds->persistent_only_bytes)
> > +			return 0;
> > +
> > +		info->range[CXL_PARTITION_PMEM] = (struct range) {
> > +			.start = mds->volatile_only_bytes,
> > +			.end = mds->volatile_only_bytes +
> > +			       mds->persistent_only_bytes - 1,
> > +		};
> > +		info->nr_partitions++;
> 
> This nr partitions makes some sense though I'd be tempted to add a type
> array to info so that we can just not pass empty ones if we don't want to.
> Makes this code a little more complex, but not a lot and means
> nr->partitions becomes the ones that actually exist.

Agree, that's the end goal.

> 
> > +		return 0;
> >  	}
> >  
> >  	rc = cxl_mem_get_partition_info(mds);
> > @@ -1300,15 +1279,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >  		return rc;
> >  	}
> >  
> > -	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
> > -			 mds->active_volatile_bytes, "ram");
> > -	if (rc)
> > -		return rc;
> > -	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
> > -			   mds->active_volatile_bytes,
> > -			   mds->active_persistent_bytes, "pmem");
> > +	info->range[CXL_PARTITION_RAM] = (struct range) {
> > +		.start = 0,
> > +		.end = mds->active_volatile_bytes - 1,
> > +	};
> > +	info->nr_partitions++;
> > +
> > +	if (!mds->active_persistent_bytes)
> > +		return 0;
> > +
> > +	info->range[CXL_PARTITION_PMEM] = (struct range) {
> > +		.start = mds->active_volatile_bytes,
> > +		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
> > +	};
> > +	info->nr_partitions++;
> > +
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 78e92e24d7b5..2e728d4b7327 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -97,6 +97,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  			 resource_size_t base, resource_size_t len,
> >  			 resource_size_t skipped);
> >  
> > +/* Well known, spec defined partition indices */
> > +enum cxl_partition {
> > +	CXL_PARTITION_RAM,
> > +	CXL_PARTITION_PMEM,
> > +	CXL_PARTITION_MAX,
> > +};
> > +
> > +struct cxl_dpa_info {
> > +	u64 size;
> > +	struct range range[CXL_PARTITION_MAX];
> > +	int nr_partitions;
> > +};
> 
> blank line seems appropriate here.

Added.

> 
> > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> > +
> >  static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> >  					 struct cxl_memdev *cxlmd)
> >  {
> > @@ -408,6 +422,16 @@ struct cxl_dpa_perf {
> >  	int qos_class;
> >  };
> >  
> 
> >  /**
> >   * struct cxl_dev_state - The driver device state
> >   *
> > @@ -423,8 +447,8 @@ struct cxl_dpa_perf {
> >   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> >   * @media_ready: Indicate whether the device media is usable
> >   * @dpa_res: Overall DPA resource tree for the device
> > - * @_pmem_res: Active Persistent memory capacity configuration
> > - * @_ram_res: Active Volatile memory capacity configuration
> > + * @part: DPA partition array
> > + * @nr_partitions: Number of DPA partitions
> 
> This needs more. It is not the number of partitions present I think, it
> is the number that a particular driver is potentially interested in.
> 
> >   * @serial: PCIe Device Serial Number
> >   * @type: Generic Memory Class device or Vendor Specific Memory device
> >   * @cxl_mbox: CXL mailbox context
> > @@ -438,21 +462,39 @@ struct cxl_dev_state {
> >  	bool rcd;
> >  	bool media_ready;
> >  	struct resource dpa_res;
> > -	struct resource _pmem_res;
> > -	struct resource _ram_res;
> > +	struct cxl_dpa_partition part[CXL_PARTITION_MAX];
> > +	unsigned int nr_partitions;
> >  	u64 serial;
> >  	enum cxl_devtype type;
> >  	struct cxl_mailbox cxl_mbox;
> >  };
> >  
> > -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> >  {
> > -	return &cxlds->_ram_res;
> > +	if (cxlds->nr_partitions > 0)
> > +		return &cxlds->part[CXL_PARTITION_RAM].res;
> > +	return NULL;
> >  }
> >  
> > -static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> > +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> >  {
> > -	return &cxlds->_pmem_res;
> > +	if (cxlds->nr_partitions > 1)
> 
> This is very confusing as nr_partitions is being used not to indicate
> number of partitions but whether a driver has filled in the data for them
> (which may well be empty).
> 
> I'd rather see that as a bitmap, or a 'not set' value initialized by
> the core that is then replaced when they are set.

...or even better, not require PMEM to be at partition1.

[..]
