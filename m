Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917792356A8;
	Wed,  5 Mar 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188002; cv=fail; b=jfROCkaOZoHvhyZXp0CwRGoHLgS8FhTGNV1EVBgUuw87Cj+M8MW+fNPCQklkEVDMnsOsXpj+VTUHQ8XG5GpiXyuXlXIEn+Cd60Qedq6GGiAiY4o+kA0c1A21SztbL2QfdCa+1/Awy+RAM9embuhYFuRVNPLGP1hOHkE1aUmx8sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188002; c=relaxed/simple;
	bh=4Hy7ETXX/dzvuzYgvBulDDeLWAQ9oK61o/H6FMTSJSk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8lI9qssbhELFmKjuDKbySSxxoVUpD6q5NTGsidsjCfgCpBuphRww5XrHP6smZmNngu88a2JkUwy0qvoABGmo9BI1RTjYeudt4av/ZmnDf8IENljtC5vTHOxDyM0RZT9QDEYnwVCiP5UxuXJcAW7rghwPuRdwECAmOjbI5O2mIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDQ6RnWy; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDQ6RnWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741188000; x=1772724000;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4Hy7ETXX/dzvuzYgvBulDDeLWAQ9oK61o/H6FMTSJSk=;
  b=lDQ6RnWylOqfk2jKjmQZDr7X7kZp3RTrRyVhlpwnE9bwazDIBV7vxu2C
   rm+r1sZfaqRsHqYW4kbNPqLy4moXrSnwIC43isuhe2Tv32Y6KicsmuZ1t
   yHnO8l3caZFeipw3TdklA0zQE3wbXzhdfBt4ebd2Fd5ZNxQpu1cyeAQ7h
   VygYl15oW7sCTWYT1GOCqfVw4V/0Bxtkz9DRVMkdEjJcmhFEfk/qOsPbS
   ppCU4jY8B/fXwSKqyqu2s386vVlXbd9YaFXYr+XG8OxubJ8vv9zfmE4t9
   qdfV5Ncy2h/gmO2rxw8jrZkGsjWpER1IOlxEKDUNQisbh7h0c7s8ojc6C
   A==;
X-CSE-ConnectionGUID: bELfhZO8TwicKDnN61CWZw==
X-CSE-MsgGUID: efZm2fXNQiy/+JOkPOSGcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42043223"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42043223"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:19:59 -0800
X-CSE-ConnectionGUID: xiefwSDwTHufBXVAVyfkjQ==
X-CSE-MsgGUID: wvGrNux9QuqfXhyoxK7Lhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118879108"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 07:19:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 07:19:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 07:19:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 07:19:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOEm99DqE8ls0N2CcIA27moM1eOGUVTqBS6e/YISvPmYoWTX6I2dcIbzKyxCXKWtbZ1ndVVmdruxMKeSyqxrUQyV2KdWzk7Q/DhrZcEoM4WGqUvTlhf6fojspMb2y2uRb39Ikt+v8JvzMtolXiKm0nN4D1FuCD40qOXykJROIQxf8grvE9OHL/Tjj28g2gm+OHBYb++AiRIaLx0zKZejY2zaqiMovnx+WtC4DNO7Rhvcqhkn7IzpLBMqcP/zEDJ9zX6JVr3hZgozqkWglEQlqqedlRhYFolYv+saf54q1tiPx2+pJiL2rj3MFG7u2S1HeX94dzwotU94L8JDsX7vSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMf5fQertKa0TCBKFcLpVrVs2YG9o4f4UXF2i486NPk=;
 b=Qflji07XlErj3jAldVazf54O9jaM7dcAGt0zmaFdjgV4qBKf6mLcIXKHl2vQLFi28JwS3jgKksiz9wsW97wITocgAeFaf9II8aSaO9Jm5Euac1fhcGfO+XEyTXQqmDqhqZVkxqZbmrdZob36fSxBpt2o56ZkpflMlY526kNdj179sIAxjXdwLmGfzLZyCHvpBX3rb7ncAR2PNNP1kz/ul1zU8M5PzPE2JeJOPrneVbpPT+PDvF08QRzuXaikzzLoCAGSRIrr8BzIt8WcOHCyN1WsW0YmATGGfeM9IamUmHpRo+OGEdy+VLk0wSwj5iv1S6quXHQv/e/r7jvflR7Wpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7634.namprd11.prod.outlook.com (2603:10b6:510:28d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 15:19:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 15:19:53 +0000
Date: Wed, 5 Mar 2025 09:19:59 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Terry Bowman <terry.bowman@amd.com>, Robert Richter
	<rrichter@amd.com>
Subject: Re: [PATCH 2/2] cxl/pci: Check link status and only enable active
 dports
Message-ID: <67c86b9f770e8_77ff4294ed@iweiny-mobl.notmuch>
References: <20250305100123.3077031-1-rrichter@amd.com>
 <20250305100123.3077031-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305100123.3077031-3-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:303:6a::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: a6564a99-b920-42a9-906e-08dd5bf92de0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Wk3mx2mli66iFRXzKa7fJ+MlkSFnilQ6p31dzPMmuH5fXPimMyj6zMOAcbd?=
 =?us-ascii?Q?+SOe15H45+SKw1gwTKSlzjd0JSmeBK6NQoEedHwDJT7sD7lO39InPx8jRO3P?=
 =?us-ascii?Q?bj/0FgBXzP2h8Q0i4ZXhuPbT3VstzP1xe/5xydrhMnemsl3KHIlphqJcm03u?=
 =?us-ascii?Q?Sl9xCnSsCvvwl51cqqjSMYXI00KfgER6eRsoYYYDzqJAM0ORR8NEZVVZqgQs?=
 =?us-ascii?Q?HITrPdh+AIvg5IR6z4FkTqlrBYHUzxK7BQT8HiJjgDKBYgvW1hfn19L8Hvgg?=
 =?us-ascii?Q?mWTjLhhaS+3LzHMQjU9MHQ5t8is5WzKNfk5/XBwtuMFM6yxqa0UyMzs29Z9k?=
 =?us-ascii?Q?1bGeEnH/IXal17jbMeHgU9qCG47i0hEwfGlSQ5NbUe6gM+7eteNaHAhrtGTm?=
 =?us-ascii?Q?mDBzwZukdUATC4YPFdZNz8Ro41r4wqpaiJJSGWVv5WrBPwgBkOoqwxJ3rg77?=
 =?us-ascii?Q?Js1KRUFnoZRgo+28vjoeJeOjTxTntZQVkTV7+ckabyryijhmhi9ySzUCyXNm?=
 =?us-ascii?Q?b0+JvPiIjTYcLljGMQULBU8C61qWl+GgaNN1rKTvuuHf8GjykkFeqMI5tNw6?=
 =?us-ascii?Q?vsB2RGpA3nqBhc2zJTWwo2uJRRNapBpTjoD3ZTMx23vjxyIyTFyznYO755wi?=
 =?us-ascii?Q?p0w+u4vt5B42Np8VHLsXKMkrNJB0k4tBpvazgMwkAmiRQFnonJi6FNgalHjC?=
 =?us-ascii?Q?LgA09kYBX2lx8qAhjqeaKEfKUo0Ixk9bEr9BLqzaiTE57/4J7maQsm82ap1J?=
 =?us-ascii?Q?MH+gfpjdqisQllBkI68vmjQes54ALzrJZWGQOhddnu+jWp1J4JLjNYrJ6EIi?=
 =?us-ascii?Q?s4pqOPu/gIpuz1f+5Sbgv6HP2Zub9V7o3zA2v2+RBw8E/swGNiRJBet6eTfR?=
 =?us-ascii?Q?uyeYks6KWmRxpc1wjqRKt9bQg/lljO5Rd+2VbAGmnM6Zv3XKoirZjL3AgocA?=
 =?us-ascii?Q?7GuM8iZc0cx9nTmnsyNmUUL0BUjwgBmNtdT0An5S+ncB7Hk+GDYdza2JXUyi?=
 =?us-ascii?Q?3s6BXmyhenZ9ZofTWgKf5F8515p93bAfDdr33V5wYTFhRSgIjnihteEbOO+i?=
 =?us-ascii?Q?UDSwxXVCPivEeQ6qAaHo663NDBZh1K39hGCoqijfD1uTKbHKzu035KbOaD9G?=
 =?us-ascii?Q?dfVrwTwIarHsrmbJxOUPNDWOo56lklnHg0NLiEdy8Y0W4uj3ERLwknto5nV8?=
 =?us-ascii?Q?krif7OHa92XGRqGWQPNrjtQbdF/S6kCom0IAUTFnxDKLi5aZD+RLBhffNC1b?=
 =?us-ascii?Q?h4bl8S+OYRw/i6ykZyOqCtlrwMY15yj1YtMm+I1rvmJ4yleGryVbLqVWtnhH?=
 =?us-ascii?Q?QetHqQaN9cE/+AkNU2v4MljC+8coXWIK6hBxcYcdpp50llM1UWAk9rxdzkaA?=
 =?us-ascii?Q?vGX/aP+in0/nTrHxTjtSMnst595u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOjIQxBuK9KfIVFqnW7FF0M03o4hOPYhIXUDb66Lo3R1YUYFEiJ5qphB8cpb?=
 =?us-ascii?Q?K92hR+QWlNE9tek0K2Ey0rFovdVgxrAWWdJndSU6OJQybVqh9rRPCm44r7yt?=
 =?us-ascii?Q?G/NOLoBsEgZviKiNkLBXRmXbkGQFO+xylLEW+ORBLp8iYBFxYoImZA5giOsH?=
 =?us-ascii?Q?a/VkodtnyuBq6HKwD/R39tBnUBG1ed29cpb//R2iKyWqPptTJtv4aP+u6yZx?=
 =?us-ascii?Q?CuZFtgxcSeHLhPRD1Yf9eH5k13N/sitiyTd949wF71xN9aFgj7dHCIVJ8fYx?=
 =?us-ascii?Q?PzBtbeX0fT2aUtVyewyh6luwnGEGi4W/c6MJxgCiFibD+11o/6BPGSwW+IE7?=
 =?us-ascii?Q?xsuEIXaY0jhPoZm1HG19aTv0FvWrSUjNI8pjptAgCzutLPgxwLtbNJS8laL0?=
 =?us-ascii?Q?EhKrK+/J5ta1MBIAGJIvVfDTprwKyBzQNaWYZSytx3FSfrosNoE2fl4JN6HW?=
 =?us-ascii?Q?CobeZ/sQwAF0mH6pzUkNY3QzFdAuh7kYReXMEtPSt6O09DV8iNy+crrAXWUX?=
 =?us-ascii?Q?njNe8Zkgp3xzxDzloa0XHJtL7NRXMTrYvc3T0N8TEleSr0kMUKWe8LjHaaVF?=
 =?us-ascii?Q?IqxR7VVeD+4+O+8/vtxoi6eXpphFRKV+5bQKVnBBBskAhwkwFHOk1Qbf0aY1?=
 =?us-ascii?Q?yzLLZR4EsK1IqzpPTCCBLbaSPnaFnxjDWW5VZdFTyCotZU2Pba5PAElpu5ic?=
 =?us-ascii?Q?UPoLcyfNE7XRpZFCIPoQsyZYZUoko8fYq2Uxhdmyu4Ht/kz/nqmQLJENs5sR?=
 =?us-ascii?Q?9hIbuT5Z4CzBPwigfLIAslRmDsm5aYDuMheMtJ0meU+nIwMirz6j9K4FYft6?=
 =?us-ascii?Q?ShU3h206MoDbix8mR5woG3T5uYQfNesc+mjxlZRORmksTjDW7cFawkCy7YUy?=
 =?us-ascii?Q?uWDKCiqKm+0axhVx1BntDRFetDg2nOy0zDpaexoTqV9OlPmTqr/5fmzO0FAz?=
 =?us-ascii?Q?7Nqo69RCNQYjThtIGsEM+y9kXl7dummBy+FazLBU0KKrJrachih7RW24/AfE?=
 =?us-ascii?Q?hBt2oP5JzAja0N1pA6ju6+yOgVKwlM6gBqvbSRrFjflc4mlE3eKv9d683urx?=
 =?us-ascii?Q?3P70cPqOxCMcvVw5XA7pxRY8u8jPWIwVNP5vb5B71FwE6pn0+FvpmhzcUPSl?=
 =?us-ascii?Q?WlEioJqiZumnUkhhxnTZNh4RIb7XSKOTaMjcevGU5NLuZsVKhLN4DWZKdRxn?=
 =?us-ascii?Q?uxxinlUR+CpcWsO9gYswtvv+tFlNSW6f12Io70+nuMznPwW6D3cmDQod98+2?=
 =?us-ascii?Q?DUr8OzMdBucpCVvko+YWuQgFJA0VRI9SjMMMsPdD+M9F/zM1jsOeF2x3XV+f?=
 =?us-ascii?Q?7Ns9+MbhllJnxelcbhlIFSkM+I3SNPZTMn3yISOLZYYd3RS7ipftrdaF5+lD?=
 =?us-ascii?Q?AJPnPKzk/NHy/CDrE1Zkcr3XewLbE5jTwAcxiuGk1aIYVTmzRe/YtfjjrRU9?=
 =?us-ascii?Q?FWA0xMOTq6kaibugrX+0SwW7obqeqx8+TzT359ycy0FniPhiKIslkNFCCd4C?=
 =?us-ascii?Q?3nFjO7l3B55RO4wRK0ZZFzXYQJ6ekyjrmacuj5TAqzWS79oLoOhGqrEa6CN2?=
 =?us-ascii?Q?iikb2pL4UvXMRhGkTTzydwj1URWgTIsOwn1WXncx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6564a99-b920-42a9-906e-08dd5bf92de0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 15:19:53.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/hUYwx2fz9fbJgYadcfheCVVx2nOnSIcXoJBfrrzxAl+MPfs8pbQRBJE+mJBTt7p/oHzOFL4Hndgf4l/5QM+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7634
X-OriginatorOrg: intel.com

Robert Richter wrote:
> When downstream ports are enumerated, some of them may not be
> connected to a corresponding endpoint or upstream switch port. The
> dport is inactive and its link status is down then. For permanently
> disabled ports a HwInit configuration mechanism (set by hardware or
> firmware) may assign a (further unused) default port number. The port
> number may be set to the same value accross other inactive links.
> Those duplicate port numbers cause the downstream port enumeration to
> fail including the root or switch port initialization
> (cxl_switch_port_probe()) and all its active downstream ports.
> 
> Prevent a port initialization failure by checking the link status and
> only enabling active dports. If a dport is inactive, there is no
> matching component (endpoint or switch) connected to and thus, it must
> not be enumerated and added to the kernel's CXL device hierarchy.
> There is no device that will connect to an inactive dport.

This makes much more sense.

Wouldn't it be better to use this patch and leave the old error
messages/failures on duplicate port ids?  IOW drop patch 1?

What happens if a link is having issues (perhaps going up and down) and
RAS events fire for this dport?  Does the lack of a dport object cause
issues?

Ira

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 524b8749cc0b..72683e1b41e3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -32,6 +32,26 @@ struct cxl_walk_context {
>  	int count;
>  };
>  
> +static int get_port_num(struct pci_dev *pdev)
> +{
> +	u32 lnkcap, port_num;
> +	u16 lnksta;
> +
> +	if (pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &lnkcap))
> +		return -ENXIO;
> +
> +	/* Skip inactive links */
> +	if (lnkcap & PCI_EXP_LNKCAP_DLLLARC) {
> +		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> +		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA))
> +			return -ENOENT;
> +	}
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +
> +	return port_num;
> +}
> +
>  static int match_add_dports(struct pci_dev *pdev, void *data)
>  {
>  	struct cxl_walk_context *ctx = data;
> @@ -39,7 +59,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	int type = pci_pcie_type(pdev);
>  	struct cxl_register_map map;
>  	struct cxl_dport *dport;
> -	u32 lnkcap, port_num;
> +	int port_num;
>  	int rc;
>  
>  	if (pdev->bus != ctx->bus)
> @@ -48,15 +68,17 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  		return 0;
>  	if (type != ctx->type)
>  		return 0;
> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> -				  &lnkcap))
> +
> +	port_num = get_port_num(pdev);
> +	if (port_num == -ENOENT)
> +		pci_dbg(pdev, "Skipping dport, link is down\n");
> +	if (port_num < 0)
>  		return 0;
>  
>  	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>  	if (rc)
>  		dev_dbg(&port->dev, "failed to find component registers\n");
>  
> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>  	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>  	if (IS_ERR(dport)) {
>  		rc = PTR_ERR(dport);
> -- 
> 2.39.5
> 


