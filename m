Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FBB23315A
	for <linux-cxl@vger.kernel.org>; Mon,  9 Dec 2024 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776523; cv=fail; b=hNWkMMcbO17yVnSuIfY8OCPZw5aqAO2sbLU8vblEeNBnL9T3xtxy621USPHSifulKltP/nLh0OBpRQi22N44vTnF2c6mHX62yz4chG0xYgsaXu5S1lWUf/QUfFbKzXFWLjfZYv9tqA2Cd6lQZDhouCFjHG/whA+jWlnp7VCmzJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776523; c=relaxed/simple;
	bh=edrHIQ4FkKfQeiaOYEOE7nkTBVbVFBFd24eEDvdom0M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ysz7gq3IPloPk6mjiw8d+y7Nf7wUUeHPOoQxzaMxW0OHYBJKE2L6iw730K461HpUgiH3D/+Btkvo61AdbdvE2IKA7lZYPByZIOzU8rLVzZNRm0HvBaxeFkNDpIxSVcM9Pxdn3rMFDLxP+mCXOz95Ba9AFZUgvB/Au96ELjWgo/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBhNYGYZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBhNYGYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733776521; x=1765312521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=edrHIQ4FkKfQeiaOYEOE7nkTBVbVFBFd24eEDvdom0M=;
  b=dBhNYGYZTCSSj3p+Otly9gynpWHYtw290iuN9xwp7FSTZNuJfDUVcXgC
   3KXDLBt/13JqSZuTDmiLZgfM/x5NBAIAdhJ8MCmy0bEf2edfZx+QXpKER
   B9EDG89YLvEMJgG5E1GLT7N/MBbXekcDD3nFNzxUN9uLQsaUVmDswS21t
   ATpd43FyWU10giy/1a0VC2YrWGxr25vVTlHEqPmIfcjpr/KyD/E0D8qR2
   IQeh2GEGc5xqkNRkgpUinAGDMEXrQnI3IoFO9FTsc5iCxthoGxSKHs7Rg
   JfIbq8NUNIZvmavE1qHlGWB7SVFxTqEtyKgqrwQOG4HcBucd1SvLzlhVL
   A==;
X-CSE-ConnectionGUID: oaJxd5nFTZ6R4LeXwtnmRQ==
X-CSE-MsgGUID: wNxo/HFqQvm/fr5XD8CPew==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33830146"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="33830146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 12:35:20 -0800
X-CSE-ConnectionGUID: xZfN3oS/R9mDnIxYowQECA==
X-CSE-MsgGUID: JUG7Yqg9QOm0f3WqlBw6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100222987"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 12:35:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 12:35:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:35:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 12:35:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9wxNTNbZZnufNrRTMoHOhQT1z5Sn+UmpHTQoTOCmEQ8CPstSddDYM2ewsdQZOoLCYlX6YU161zY76jugTvRk8lHTWgw1V1przHDQJqGBg/0MilDRdsaP1eiTvw6ZV+tSoQaCg+ifAts14y6pPN4DUtrysP1cm4LwR5RMQZm/XMP92BHCOyvQFvMkP6TMBWSMII1HNfOwzjsS5ahMRIE/wYJoG+xEh6VLxtHDPhmUvnTAkYQ3tCJd2NJWr9NodZwASdM2H3naiVTC0eo6dWvQ+reyxb0QD1XDM42VS4VERSgzc4t/nxKah/Dqskpn6CN4jjyEHNPqtbJHwrHM50JFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUKaFUBuxNKzs+RqQdm/Zc0w2sVmSAfYmS0iNbQ5i/A=;
 b=yIMl2tbwF45yZgh1zBv81O8dnFYkMrB21NL1Tukvt9seRPPE+0EqpFHELyyX0etduF3/xZMKoIDUPPvkMtN7pUmENfQKHtcACSbOw4n+dJohySljej4Ey8c6KVvyye3029d601bp2zIGzXyWmg02Dwx5vjDZrd7QEP4PImKRX+rQkK/HsVSG1XbBaOLtqZedosoiy/fT58VQoigYtLhLwAUZcmAXwaelL6qVjADYLPbZ+Wa8CUvkSh4MEQq8coDktnNLbSiXlX90fDuM/q8gKvd8sTdSeZ/o4zzKyQS0jChmsnHf5I7zK44DAKZwRklEos+hFMwuCngN5lW4W2xC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 20:35:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 20:35:17 +0000
Date: Mon, 9 Dec 2024 12:35:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <67575482962f5_10a08329434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-10-dave.jiang@intel.com>
 <675251891af76_250732949@dwillia2-xfh.jf.intel.com.notmuch>
 <20241209133053.GA2347147@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241209133053.GA2347147@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:303:8f::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d33852-57cb-47b8-e966-08dd1890fdd3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6497poxaXiutkIHs2iSJTveqrfFxIIQfsTVmc4ztlt6SNp5usHobystd/2w?=
 =?us-ascii?Q?K52VfbJ81iqTfp7sA7GG6W0p0WdXYAe3UD/dP+elnJw+JbHR6HuwG3TcxgVv?=
 =?us-ascii?Q?h6jUQijrjhkaM8WMuqRePC2S7inrhk/fK3MhIYipeYYKzAZL1VlHTRow+zgb?=
 =?us-ascii?Q?1AJCFHGwr45D5lySfVvt8JTiF4BIpgq1TPTv2dKMeatPDhuKqEeWqnDPm1DB?=
 =?us-ascii?Q?3O6KL0/4j/ZeiqzBUqR/qXtL5teljujU9P7D0VJqJWizQunJHYRE52XzLcNv?=
 =?us-ascii?Q?fKz39uGttD8Zsii7EE7rWm52my5I3hb83v3oCFSyCfbLG6D8dImRp0j8hBDT?=
 =?us-ascii?Q?U27u1SbERKk0If5eCH+BuFEzyVBG8YgjVwwtMnkNCxX1kVnIzZt5znpN/+SM?=
 =?us-ascii?Q?DALZdk7CaeFXhDZZ/qW4ZL+IyIgZeB03Eb3XaT6NAauKzG8m5xfZzQQKalqT?=
 =?us-ascii?Q?aVPLRQH7dEu7wC76XoIoZ06vEDiXKVQF1zn+Ij6nZdTYygTc/5ErnQdPuBoV?=
 =?us-ascii?Q?H1SjN9aeIFCwKIqCPQQgsPN6GAPCoTPoRFU2M6BT3u6b/uIuaZVMkhcw+I0K?=
 =?us-ascii?Q?7OfCUZaPDe+uX23ehMkeg9GsTqxm10vVyrDO8riRhGN62kVIpQd6PjwLbgSV?=
 =?us-ascii?Q?GGOP6PWzjB8QQ6YZiv/Q6o9TZmKS8sdhILzQPonUrJFWVLNWurt5kRdMLtli?=
 =?us-ascii?Q?Giu7yd5V5g89oY1R9qMOW/04oZRZLRFsVRQ73PR2/1TvVSyDICG6Ev6c4t1F?=
 =?us-ascii?Q?LHkirPZQmTRQhtPGRmFsrmKxAm3pmcY92rIJpjc8op+GxGoj3X7lwYxOqMCW?=
 =?us-ascii?Q?7M8srlIvOkcn1L/9sgr+aKcY04IVz6kV4gHmXEThaimsHKeK3yaXnsw25h1V?=
 =?us-ascii?Q?e7ohGpw+8bk/ihgX9TfP5AIVWi0in0N/QSvDrzD+JSMoMxsFrdKywKn+whgG?=
 =?us-ascii?Q?ble1YAKS3h1EWooJQoWq8uQ1eOiWgSaimM4jz2IXTk4Hbq03mxKvqlYBy6/t?=
 =?us-ascii?Q?175FZFQndkJ5LkSfJUiXe9j/DDIzBrFHFsOhak/anBzyTp9pxzPDYX9vzAmL?=
 =?us-ascii?Q?y71zyDu5AwCXF1gGVyU5h4kwwXG3k2s5VEIr1xiIlYJrxgDREKUWO3cAVsD9?=
 =?us-ascii?Q?3/fTyfNJkB99eASN9qiPy5cK0+DZIz6kS6dVsSQkVJ7C7ACZc+xZVqvbZscM?=
 =?us-ascii?Q?qn4G2pDGV45Oxpo2xMpWgMZnfSavLwuVZ51PF0btH/izyQ4WZvS2bnDugY8w?=
 =?us-ascii?Q?KE8gAFKsAY7SCAU2ueoOW7zORtXaI9MhEySu9WJgX5lt9UTC7CDyOcYSgNR5?=
 =?us-ascii?Q?+f+39lfdpTkpk30E8sq53QuxlpOgp92oSxmHmu6uUdHllg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mbjxg9ImnZRL9gNJro+4O4EHrMuqfCYVJKDUp2wa4G5mjX7jRrB7GPaJs3i6?=
 =?us-ascii?Q?NHE6EDAIcA2quAE7QClFgnQ7t8zCJbmFjPuvmSB6eOciuoBszaA5pePApHCE?=
 =?us-ascii?Q?Qi0oUb2Q5pmAVGr8tTtpoHF7NBEscWZ9ZQvp6UG37fC430ZIx2MD5aYPZXGq?=
 =?us-ascii?Q?W4nm1BlKjULHFmCwLFMYlGi3iJGmhWfNfALtNPOgJKSmIYwlakhp0yXwoA4J?=
 =?us-ascii?Q?XOtEzPFepnVhYtg4EVyWk4VetOA+/mRXStU0X+7XwP7/LHT42Ue8VXRW9oR6?=
 =?us-ascii?Q?e8GL6ZfLLR9uN22+AZmJPwCZeRNbYZ2pbM+yBl1iZUFLbKC4naQ9UbK3gzPo?=
 =?us-ascii?Q?BJLPeor1Pm1M42Kz30wZrZmEBN4S/M5LwlGXTs7/iHSPbwL1O8AbvHlxLIxS?=
 =?us-ascii?Q?b0eOA/+nQ4Z4te/oL6ra6X/d6uZpMne2A1wRhS+ppxqrGVfZQIgHAc8mtzwP?=
 =?us-ascii?Q?OTtFHGM6HODvHCeiXRlvZ/ySu3/qbcMocgfADV+jN5KUjMKHjKfFYH251ePd?=
 =?us-ascii?Q?eZZwd64pV7q1a9e5gCBdVYbA85sfhEMqsnp1PmpzaWoRKCkOXCpZrqCMPGzc?=
 =?us-ascii?Q?zea0csIe1pZH0UmLDGqDe4fzdlDknp29ioc3xZYcZEBJ8CHd9fIwbs2Sw/8h?=
 =?us-ascii?Q?qOW4cMGJBOqTck5X/v1jQZUJkvKkqD/sGOxhNxGmGRbu5+MFKMST8q3Kso0X?=
 =?us-ascii?Q?Hso+w7ZVMLwCp+wxzR8h2lL6CBWPbFKg/1E3c7mvo677xxk0encccMveXJ0X?=
 =?us-ascii?Q?1tPdFxsr2Ml4buP95iWERpRNnmTzAb7ElEwfgb0lHCpUxBahq877TcaCvpNY?=
 =?us-ascii?Q?wQ6EAqyA2KaICuEUqymqfFzy7udQYye8bvnbmeSndR2NxFSvdtY4RdqUP3nx?=
 =?us-ascii?Q?3VUwSRoOoh+LsF5Qj/zMo0GdP1dOwbe2kh19/Jz8+Rkv57abBQqxnrBe+suV?=
 =?us-ascii?Q?HgOV1VYHwiMrQhBzykyqoaa4luEJqCq6pf+YFqPQy+e1jJo8y/56VwOQQXg1?=
 =?us-ascii?Q?K79xiLlHzmFUSZLMbHfgbLIO0HhqBssvJPPbOHy8tA2AJWRvzY0FqPM4RfpU?=
 =?us-ascii?Q?rMJLlL+aV8UybBZcAuoyFaqdj/3p+A8mmwgERMK2LoEhf0ln0ENSLeH4qsFC?=
 =?us-ascii?Q?LClOuqSCevkJXtMYctI1cdayF7A9ZFHvRJsbqvszy6YXEYsMlRc/LIUu6oRB?=
 =?us-ascii?Q?bdTS1t5NbfXJxcIU9Ruv+0y04J9cSajyO57uuYU6dXmCqsmC0icB95Hxe2rQ?=
 =?us-ascii?Q?cVnzQ7U/0MjTJHvHJybUH8AGIqZ4NmFHiLaC7+cBzgO1Px39G+vvC+rj7EN4?=
 =?us-ascii?Q?FK4nruuwR6nKJQNASUU+oxMbZTsmuomCyXqkhRNCM2+Wzv9dzoj9uMgRmQul?=
 =?us-ascii?Q?wKojSNEkCUe1iSQWHNOWTFIRyZL+Du9GYq04KGIwPQP2+KxB3gLkPGZIOhJj?=
 =?us-ascii?Q?3T7Hahv6HBj5aJOa9DvfKjXcQJKyOUKQmj7eKnzV4mKe7ZV9xwn/++pajxLB?=
 =?us-ascii?Q?JNxrnnUx9qWpmMci4Sjxc63WJwfPHNK/P/LIrktEqZFUOAhBgts2lHAT+xvG?=
 =?us-ascii?Q?jm/rHQDeTx9zcF0VIPmFYNfDO/3EWsr2otm3hyYgoPC5xGuzutS6Jimg8ttY?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d33852-57cb-47b8-e966-08dd1890fdd3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 20:35:17.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jUs4wsi9w5CsHmiMLpjcYD8cBr79PiPfxWGI241QWmxQs6aTaWPUIe7JqF+x9Dc/Az6f0Z8p89NS8f2heX25lmyo+8th9fj06oOt8wiYeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Thu, Dec 05, 2024 at 05:21:13PM -0800, Dan Williams wrote:
> > Dave Jiang wrote:
> > > Add a cxl fwctl driver to allow sending of CXL feature
> > > commands from userspace through as ioctls. Create a driver skeleton for
> > > initial setup.
> > 
> > I don't understand why fwctl support of the *existing* mailbox needs
> > yet another sub-device and driver?
> 
> It is how to modprobe the fwctl driver independently from the main cxl
> codebase.
> 
> You want the fwctl parts to be in their own loadable module even if
> cxl core is built in, and the loadable module should auto load when
> cxl is present in the system.
> 
> Spawning a new struct device is the best way to do this.

I agree with that, and CXL is already a multi-device subsystem for the
same purpose. However, a device just for the few subcommands that go
through fwctl feels too fine grained. I would say either move cxl_mbox
to be its own device with a driver that does CXL native commands and CXL
'feature' commands via fwctl, or create a 'CXL features' device that
support any functionality implemented by the 'features' command set of
which fwctl is just the direct command submission ABI for that driver
which may have other ABIs like EDAC associated with it.

The latter is similar to the proposed cxl_fwctl device, but focuses more
on the 'CXL features' aspect and less on the 'this is a fwctl module'.
