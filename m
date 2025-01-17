Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585A19CC27
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154388; cv=fail; b=k+qF4VhbPuXJDCPSwVM8feD/eynkPLTFfen0FsLrSDakUyUojMsc09axbB5t9DbrJid8JTlXq5t0Btt8UoJJTXEoPYi7rAJizKjYyr5YNUA9ipPyMhWjlRNU3G1elTr4DB8WAK+WCeJatlaV7TG3Bz2t/59VNHC+ktuAnIqQD9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154388; c=relaxed/simple;
	bh=hIjvdA+IIOZh3BMRBWFEhJ9T31T+NtRN3XkntBbSmeE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KxWq0aN0ZnEAH/YQUPstheS+TYI/yK0gJdqGky8Xc4QXKpvccHdzV0bX3vPeDCvmf1eHvFvvUTGMENjs10cTfOqIDrA0N/uPrBMgz0WamgY7a7jHhjt+4QP0PMxlYfAP8fQmLr6UGK83wM1s+MOSojKV3yNQms0XHTFeVXhXA0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcE851MV; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcE851MV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737154387; x=1768690387;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hIjvdA+IIOZh3BMRBWFEhJ9T31T+NtRN3XkntBbSmeE=;
  b=TcE851MV2hde61cUMS35xTgn8/SO2t0AIDkZpQev8jgMIHx4/3YNyZCd
   rNAUGrdZY4PmGTsL5KtFW8JJr5mqozOnGbkwycGQ/yKu9T+nq6jEQbKU6
   SCBsRmzZqjxdUdqeq25u1hKrNLzoKMq54RWUNLyFoqneA0fwSzl9i62tz
   +G2x0h4MqUvkoFstcVzjmShok3dG6ZzA0Vb+mMmTGmCwV85a+B/4HqIxU
   X1rE1ndGsUwu1/qKEkt0vvq6eEGZW0tApcAXZZzEyiQDvySvqJewAPA5q
   mkArEWmmqZH986VT+M1wREtydIwFuE8w723d4aOCkAq8/dJn5Vz5TaNCP
   Q==;
X-CSE-ConnectionGUID: gzcEUFdJQlmOC+1sQpTleg==
X-CSE-MsgGUID: wsaytJHpQy2sUIP/DDoQuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48996670"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="48996670"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 14:53:06 -0800
X-CSE-ConnectionGUID: d4lH0DgPThi4+pDsAg3TdQ==
X-CSE-MsgGUID: j+26Z6YyRomzWuqnESNMhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="106107786"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 14:53:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 14:53:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 14:53:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 14:53:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYs+uHByQV0iZIWbobiZNEjKKXpMxeQRp1RyllyRCYnwrYadDW+pgoMUY1uTxXjIXuYZKO76CvpslOvWKXmvONp14c99f8Ng3pFr/qqE2PEdUNOdKhhijrkThz2Rqv2CQU5lbYIVmlVzeC+5iuRKo/oIvtej0xjMaDf3GIjSqwTO9ieZc0Qn1Win7n1+73KHXgPcV1CJ6qUxehlIXtFIKWDIhI6TOutDQIR7J3Cu+lWuh3sCcEevMJ6heebbj6qaEVyn+5zfmSfh/2eGdIA0IhAa8R4AgNxlZz9p5R70sDWgOzsjf14wSzCneBghyOSelElRZyXH9Ug61BSx7Vzl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7i9dPej609WPlt8BmUIO+QUbrhYAX8b7wz63ckVBnY=;
 b=Bqvw5yzDpckwwtvl4iqUcXbmBtbnhHlZCoPVDkhQynvkXFVmZHc8mgHIa/ezCT/x50swp8f1wgJir6pscbT08ptJGColCcpPkNcywIQGW0HRRE+RPJbwltlnEacGUTqe+XWHv+8zbWO6bPrEYzeN7p9rQhT6HC9YwUmUCIj7CwYi+ffvf2iOHapZASj3TM+P6356Q4mfYv6Bnf129AJsYkeTQGzONAYzVsqoPMhEusCEPmzDGl8KcH+CXsahuDz/75/WmXPavgZLVK2gJJxri8Yzas0KZPPQRIw/jRQ9hbLNGYX47pnA1mxKLnZjgQZ6SP0AeVU9nZesii97kLjGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 22:52:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 22:52:49 +0000
Date: Fri, 17 Jan 2025 14:52:47 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <678adf3f21dc1_20fa2945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
 <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
 <4f1417ec-953f-d8e2-183e-38da67dd536b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f1417ec-953f-d8e2-183e-38da67dd536b@amd.com>
X-ClientProxiedBy: MW4PR04CA0303.namprd04.prod.outlook.com
 (2603:10b6:303:82::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: a9589da2-0cb8-4894-c556-08dd3749aa91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DWApOIk1uaow18RS975GrtBNQ+t6hQGd78pFV/YGJKnH33bSmMhaW1QOZkwW?=
 =?us-ascii?Q?2vHADRfGycqgdxd0tGMQM+v1VtxYyRjEsvmXB5Os62HokoE/GRKn3zUEdTBZ?=
 =?us-ascii?Q?39vykTvbCCV4L9CLBGlXtqyU/s1mICOCWp50kYQuobwzumnsxElI5xXzBhGK?=
 =?us-ascii?Q?2nFIkFDCyVC9wwRq8/xjiE1SViN2uu1cD8BsA4PGRe5BbFz5YHybl0RgRNz0?=
 =?us-ascii?Q?aLIpLGkfI+KfjW9eP/79n6LmVGy2F00fWZy4TwKRcwTZZgeX4+gX2EttbiaF?=
 =?us-ascii?Q?0sO1C6xLLC/RneqrCxIIp/aQKRn8rYs6i3+kc6WhENdj401PTakWnNu+ax0z?=
 =?us-ascii?Q?6HLliWzcTaztl4XseT31SSPERTl84CEMqL6Rxmnh7skjicO2L2f6OkucNWR6?=
 =?us-ascii?Q?zXwdC1vZOj5GbaixWCFQc7ddGQVXeTbVEcDVHbZ1OliMyhkHSeWEwLplU6SC?=
 =?us-ascii?Q?HKu4HXgdZGGocg+49dkCAYQ8gWif09DqpJIkkpjwOTbZF84+Yqk66UzTqfwD?=
 =?us-ascii?Q?I1wovxtS0+Av1HJGXW4lL3e1pS07Z9+cRbXwKnzZ/M0ne6jKO4UfqEw876iE?=
 =?us-ascii?Q?Q6g3lUDNQjH3Dw9F/64qONSD79SQge2EytTiXxNEMcW06FX++0jhOj3dzaR3?=
 =?us-ascii?Q?Ws5T4Ssg/+qas/hm5onDLg/7FFj/4Z5Y3oqFl/EO/fZon96yrNRqKiOBhUJM?=
 =?us-ascii?Q?sN2VSGBRGCpEknFEMRPyiERxWUgVvMhYGjVNtBzjRpCIbRoFInVOj6niMjE8?=
 =?us-ascii?Q?FpPdSOqe5iIwwVUmBLjsy62KIvZLAlJQpJeEWfBGT8c9Xt6s19v4KpLQUhDO?=
 =?us-ascii?Q?D3sU9A6KC0plnOA0HPOaQecTjIAB+zN/B9Vs+Xng+Q+x34/XwEzasPx7gqOT?=
 =?us-ascii?Q?2NNzQA4QYjADoH9/nPmh4Cb//Dcoscux/8PXeRixKxC5eJLt+laA7e7SUMJa?=
 =?us-ascii?Q?lrY+Uj+u3oTpWkXwm8DUosgQUBDFUG9ncHsXBMSFullxwi/4MyR2UCuHuar4?=
 =?us-ascii?Q?Lkvgbp60gqrYvvkC5xDhTJhDzaldLO2QZJfW/dOl0eSsfbsCL9c4JdP8WZ3S?=
 =?us-ascii?Q?gcn14Tf3POj5vsF/LBpSKbJctQikulPZ2pmC9RD2AvupMOXlIu/o0ue5Eywg?=
 =?us-ascii?Q?iWWNMI+l2qnmj0DkRtnDbHJfZ+gE1RN8gJRcAC/ESLCrG54LANP4MGS0+Ln1?=
 =?us-ascii?Q?Acteen7QPWtMues8xcp7kO/k1lPwbmyBMoWLJDqdkIQksbln5uiIPXcvgLsd?=
 =?us-ascii?Q?JGfltDmEyebYJZrr4TLch7lHnqh2gvcOAeIPtD96f3+KCYpYvQqacSH1NYss?=
 =?us-ascii?Q?35iqm0mXVAuQY05XQSRVUvoXoVlAzxI1JCmxJZm6av6bFPD3Easj8JSskw6l?=
 =?us-ascii?Q?eD332h1XRlLVrCvusXD3Yod1DuGx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMhLOiNlQDlHfXfDS2yXgPa/7KsFNgyTlA/4zFNSUwLzFKSoN4JBuM/QV2t+?=
 =?us-ascii?Q?BJMSwUbPBzbwong7FRH455GVUFo/8eUVWNDZnUY5b0JbT8HdUACC74sKO+6P?=
 =?us-ascii?Q?P6Koveirn2F4TXcHxqWt0gWwhbYXOuuq3sFzy5H+cIaIn20YHMNl0r9vecQ7?=
 =?us-ascii?Q?YYFmdHGm7absgjStOJHMGJ4XB5jxg9XIRpt6r5c5zp8XH41oKSYESnBLj8oB?=
 =?us-ascii?Q?I4LvRBzMX6zcTog4a61rCqb8Kh/oagtwvxhKKnADvmyadLLD4anGRZ5QuQRp?=
 =?us-ascii?Q?ZNDQBjzaIS+PD807kfg5r1Xv+kEXtTbOhAIXEkKrIC4X6oRZzszeQ5lCTjn+?=
 =?us-ascii?Q?m2xMLceUq3WheaoQXfhLabwiXfS7cf7dBLRgL6cz/bHQc4n9p3loLuzGNZnz?=
 =?us-ascii?Q?NKBrosKByjiE65uR21VGSUQc0ld4ThsEi2sBeV3Tlpx9k93n3/Hpepled5Nn?=
 =?us-ascii?Q?ZBtxyshSWModTqp24kGbH83CA4b5y9B8yuXktUQoQIhJv4kkjbXZt6aHkzmE?=
 =?us-ascii?Q?Gg4jjHUzxWPe16lXhJq/hKy12ITFGsNBN0ldjh8kDexiDE7KEDInq5j5TocI?=
 =?us-ascii?Q?UNrooZ4/5/LiWZlO5u2LfcwLD2np4xyMmz22+qwbYJJRRgjXVCdpASjNK+ci?=
 =?us-ascii?Q?4gWEWbAV7C0WJITYndZG/CfcPoJ7SQtYCdNABsFbyBp4Aup1rrT1WI7Oe70L?=
 =?us-ascii?Q?Zdu5ELZPeoF7Db9TWanTXn5qQqUT379PsI3irKU8QhRRAeW5VHZeFhA7sTGJ?=
 =?us-ascii?Q?SnnVS1ifMO1p1HYqpMi1bixi3O7OBHGsXSCPlosyLnfGWYC3U7bRFw0nwCMo?=
 =?us-ascii?Q?AXnDBkx/i9R1FbcRy1O/h0C2EhuC8hcPmzHoDD3Nk9H7Av+IjSMfybCbIUdy?=
 =?us-ascii?Q?t4PbLRMsemiu0YrSmuHwHVbhAvTJ67kG86ODdcoOJzj/0HtHlvbVkhTrTrux?=
 =?us-ascii?Q?2PwdCiqoMM4Ps9IBtmQunaFCXaDCFsHd/CZjl32YtwiRT4JhAga6IxyuSCMm?=
 =?us-ascii?Q?5e2fndxIEhu4VTugy8VMdAI58tj26+/EcD74+v+PufilPRzRtb44IAj/zrP7?=
 =?us-ascii?Q?msF/YZxpYts3mklIwproPEYsbqktITIfDEVmC+PrV0mY5+PEqMS74h2ny470?=
 =?us-ascii?Q?A6w1V3DFuEpGSphshG/TmrdY/RMyW9tTW0ODFDjQQAweHM57J/5uSaA5rkKP?=
 =?us-ascii?Q?Y9rbzTuG4GQtAQiry5qJ1mRzzdngSVVpp5E312aTFYkFQzHtwBO7id18VLy8?=
 =?us-ascii?Q?yzriTn2yVz53wOIXvaAfUuDsIQk6T+nljLN1X0tJj4N/Yz9TlfLqdm0Tzaxn?=
 =?us-ascii?Q?VdufIZ0YgoB/X5bNtkl5CIGCoqLX4CQkW4Pl5fic0707G9XS+nBcJ5TDJWxH?=
 =?us-ascii?Q?2Ctk58QvNqTns05CZ+f7a7O1ERsdG0cZVmhOAjiUvRM9o8W+/L0r46ECovi/?=
 =?us-ascii?Q?KS443aCmEDI5IBuprUWroVK03eGHr/q52PyXp780+oms1IA/R3FXEZYN3QFI?=
 =?us-ascii?Q?o/J1+6sLDIBIJXH7Er1Vk1XwBAzhGrZXrxQ/455OjS2XqYQK+iE3cgG7DmrQ?=
 =?us-ascii?Q?4qZXtVGp8b0up2s4mb7MAx118ZJdROM32le48k4umsA5UVI74g/5iSR+9U9Z?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9589da2-0cb8-4894-c556-08dd3749aa91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 22:52:49.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwIX/e9zx5hjv4NlPjKGcaWxQguxwDHP9JvnyxO+3CAyvIOYlKvzklIaNucdWkE3dEKISTtU8LKUJ+3rDsecc9Eb0wVsPGHP0kCszFWc3Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +
> > +	guard(rwsem_write)(&cxl_dpa_rwsem);
> > +
> 
> 
> This explains to me what you meant about locking when setting the 
> resources for Type2.
> 
> 
> However, I think this is no necessary because there is no user space, or 
> that is my idea, involved when creating CXL regions for a Type2. It is 
> all up to the accel driver to do so, therefore no locking needed because 
> none is going to traverse the child resource list while 
> initialising/updating it.

Yes, no locking is needed, and that was the status quo for cxl_pci since
it was simple to audit the single user. Going forward, with multiple
users, and the fact that cxl_dev_state is not strictly private to the
cxl_core, some safety is reasonable.

> It does not harm to have it for current Type2 case, and always a good 
> idea to have it for potential future cases.

My main motivation is to help protect against someone thinking that
calling cxl_dpa_setup() twice is a workable model.
