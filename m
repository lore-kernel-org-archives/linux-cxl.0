Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103E35C1B2
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992625; cv=fail; b=a23jHiTKJCguhETH7/VuSCDggLl/yCZzmtkLSbiRMXl5T4XUCCax2wCUeT/fhqVpHUJnsJdKbsnMqIlyom1stgZE6+OMW9ARStl/3ugQ/8mUR3DIeonYB6wnxFVd5EvwwqEZRfbdhN1mpNKy21AlrQ9FSzl85Q0fmzBaz1DiLJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992625; c=relaxed/simple;
	bh=JzeqcId46qKbeL1rx8vp3iED2d15BNLVoLpCFtmiUag=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0Myuj/cT6DssBP149V+e4e0SnovkTdFLwScklWAiBLThfXMdnFPFDGS0ndJwxnqrkkoupEjGC5jG844QeDw4MuxGWnQCzhNHBiwjMaEZdx1BhHezO36qCWGh94k1itGoZLT4jSzQkV1fyx+EVuDXqiP1b6u1gLl1gMz/eP85m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERyQe7B7; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERyQe7B7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783992622; x=1815528622;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JzeqcId46qKbeL1rx8vp3iED2d15BNLVoLpCFtmiUag=;
  b=ERyQe7B7Va1fqf94l0DkrLuGdfwqJEs8+5YriAF8/u2LrVWoHGuJD3HK
   gUuaFFu5TqkPNU4Cfgv9rX/VpxBntO8I8l+9nZ/MFMzWex9GMI/fxafJP
   1bOx3gC11yDmXv7Dre1msP7+Kj62Khz1QZo9M0UCoLaj6Uuuxk3PJZqIJ
   TvMOym53nmAtevlJmquG1WJEjEwhKBoZ93x6JKQm0PsvobJAR+8tmPa/K
   0grakIPEANaBvjvyGZJ9hEgy0+qpszYTmooaZioBo/NjmRQ7MNSeuhNPA
   3bELIJvilb6QRtUsa3FqE6qWzQQkq9K9n/KrYXPZJciAgsOKAif94qvxP
   A==;
X-CSE-ConnectionGUID: yYaaJuqBTTO8i0Ta7fY7ew==
X-CSE-MsgGUID: oUuy+aXJSHmH4Z3M039CHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84463959"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84463959"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:30:22 -0700
X-CSE-ConnectionGUID: 7xxFo00eRq+4O4yVl88s5w==
X-CSE-MsgGUID: QAeoM4c9QAqtRf07L5GCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="253088723"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 18:30:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 18:30:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 18:30:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 18:30:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OyOa2fU+zOS9Fw4RCUmgbG+6gim7ED+Y9CRrIInvUw7ZdILENGWghskQ22ZAT87eg95PMhrkH1F5uUbM1T5Ltfq529THq0zzvM3DDgwXTR2yGBBxBLa88RcD9IrKfl/2FsUqmwkNZugZo9WazKdHZSEZ0tYc+D7IgWmu6N2pY0lLFsFNxVEy7CP6Ky7NDZFG8zHgo0xiKSaEseHXrJY5iehziLJea3kAVVzDEz84Gx9hjG2WJdcI0gBt3xY5JiLrFWRdB2RTD0HQIDfO5D/Hcpp8+0O1SEus/6GPIDpjD3E040QZ6kMEn9BLNpdGJX5RdAEcgf0zF6mOOtnY+nmsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYhN57A+TX5/I5NJEuY1qQVyYSmo/OnJKe6TMZJKryg=;
 b=hmFQWRFb5DlPj0ESFXgpQ0GDtHo3lv1ITgBREUgG/86FVYY1/ODfHaBheadIr2rwpXNmxbcQS0zRV9AwGt5LO78x9CZtdwVYSPYDIYYY3UWYjIPeEqOJ74MAJzAVT2nMekKLFnx0HZKpdPUEu2beHt2B2BmSKDkSiw99abudEvytTigfCUvYKlbijRNJSf1wGRmGCf0ycgWHfgkFoQ6kVi+Te7Wkw3BfXHHfo5ZklSqXeNWYshNH7aWl7ZKpYu33nQcHYZbB6CjX5cSHxoLNLtcAX5HWXNRGUWeZsFmCLOwyBqE9+W1vQQ40OAoltjcjiZbIVNRDSDrxnFdY8ggaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by CY8PR11MB6866.namprd11.prod.outlook.com
 (2603:10b6:930:5e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 01:30:12 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d1c4:2ff2:daa1:d1a3]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d1c4:2ff2:daa1:d1a3%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 01:30:11 +0000
Date: Mon, 13 Jul 2026 18:30:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>
Subject: Re: [PATCH] cxl/port: Restart port enumeration when a sibling adds
 the dport first
Message-ID: <alWRIKn1y8f00OgO@aschofie-mobl2.lan>
References: <20260712012843.1792090-1-alison.schofield@intel.com>
 <a0d6ec53-7186-46dd-a3c3-6bd380a23f9b@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0d6ec53-7186-46dd-a3c3-6bd380a23f9b@zohomail.com>
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|CY8PR11MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f91c51c-8942-4012-94d8-08dee1477266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|3023799007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: e4+8kv1Auo7FrUL3h5Q+cWnFG8/hnYKZM/V2Ac9kOexHvLM0wHXa9cMzAob2s7qMsVQ46w8b2kZOBgH+QDmePG+R0ON3ZbmMqwBYrWgOfIcqu78m4O50mRW2tQYGaDOxp0UHmqYJdZ25HlhENrYRip4bAgr1uwJsGbudUsp/6AVVTMIDjUlBeCE+s8eWqm4FgliibWhfuYJxOfljSyZU0gPKK89A5ZPELfQ7qK6ySd//ceGvNc2d1c0SZT8z3LynQmBIWm/nqhaFntMlWS9MRVaGLmPC2TFXwzZgsqkMfH+Nm3hdqjCP2cPXkvlavwyaJFnAStzxPI8Q2yjit/dTwMzyvyS3w5XDYcalyxyQkUubXv3IO0diZWdUGMkGr4QwYB4I/rgFO1UhKKxxFemAHvNniOGuVdM7KzTL3cP6J6VVAKxGziMVhz0BtzytrQPf+dFQQ3Af7KWZ7IQmx5vXyiRimqDRzr0hD6uN3ss1+aw3CJSvnyZV55y1QdLADZEwadl3sGRXBrFGrBHmZse6DcgdosQXkv5ibNe4jpfWY6bSuPs1AU5vgeXhd6XfSAFJ5lBkMpFrszPl5IF6IKbOIOHWHM1/NCcTmCzVEmjk8ZG9jqwHI4RM1dcnslRb5C9GtNX4pZgT0aXUQUnmJbUotffwbjV18gk2duiYXM0qyzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?re4wR93Atn/b9sACJLENTCdf2vCXRDO5ChO3dL5aD8nM86A9yDn28UmAhrYZ?=
 =?us-ascii?Q?LU/TGHpLCDFFB1R81ZfinFXYvViAwqO9vup5O+XzpJWgciKKGEdB2w7FQ3jW?=
 =?us-ascii?Q?BkfrFjdVFmRv0rKcqdyEmYSAC1eLJTMaS6JOrf6mDl1cvRpddQg8yzcq2fUl?=
 =?us-ascii?Q?rz9Xrkaehi48esS4hor3wMNqRUbtvRwtyfS/DnSTtsC6AVlxvYEQ8FGrmKm8?=
 =?us-ascii?Q?F2mZOVuQPnWKIOCakm2GU9ErVw4s9IMB9HQoYANnMf1MC28kXXoIau2xccqS?=
 =?us-ascii?Q?2d9/ctcSFvRDticwtnofgb0oW+4EwS4AQJyLDYAJGfY70JwdzLrBbewnYj3O?=
 =?us-ascii?Q?vVnIQ5YRHVVFQbBd33Pr2lNYl5TbNCASMQnIT69f20/X6pYNs1TzyXFnu+tb?=
 =?us-ascii?Q?Nkzb8YT7X/bZQShSuO7D9qKd/8JvBJ4uxotj0b13AeUhXY+/3i59Cfk2oxfn?=
 =?us-ascii?Q?mwvuKVQMmVQNj2izUOPo4X+RLTCt20hQ/qhMXJ4FI6tFyVNfLJYouMJxtd9J?=
 =?us-ascii?Q?KPvbOHaSpq0Yi0O9PpX+xb0v4IXaA0+m667FtlyxFF5dFlx8RXewUkS7PwUh?=
 =?us-ascii?Q?qDVeEEDptH/kerYlMgAd0Mc+Nl7rp7DBrxc1qE5u9M0FXx0WyjtlBCFgJs5H?=
 =?us-ascii?Q?yDMFoqYArm1TsEheP5QPv14QM77kVffOdFB2ePByD0NuCkLQYqYEGKdZK+6u?=
 =?us-ascii?Q?yZ4qUpNv2s9CSlnBeHhChS5PBRcXX13hojXVRTPh3CVvZ32KLfr8LvhTHwlG?=
 =?us-ascii?Q?iUueyBI/P+YrFqFCwVOPNaeN4a/fz/K21/eN0Bq+ZAx2dAmsIe2VP6MFh7ix?=
 =?us-ascii?Q?H3RDlhLdJJ8lwkRr0cw2NV88TPgKSeOnLRz1cWfXlhWgO4vj5f9D5F9rEgBi?=
 =?us-ascii?Q?jdgczh1et+wccO0u80EO4WIaz1lL00jXbk1gh+fOB0bjOH7ltUsjZ2rJ1CQk?=
 =?us-ascii?Q?Mdz1PV++H9G4V7rg9awxaIVrSgHIVR9Ki4QSoM5Krn32h7aHg8Mr6iMkZEpw?=
 =?us-ascii?Q?8YTDNqq1Ho167Sh7zDePYX+tss0+GIcsXxTTJdWKglBBnkcSYttn489gSa21?=
 =?us-ascii?Q?BwdAByfdQnhA/DvOC2uPG00OWj9JAdaO/s0pi9F+cCHiPlX2Uj7aUtn05Tin?=
 =?us-ascii?Q?2jG0oKxN2XkbWDcVdmfUXyZ4bMf/uPrZoJ7MXAPfyJu3QeE+8S313V9W5rVk?=
 =?us-ascii?Q?esJ6B5EzMfvFxn8ORjH6VFDuGxySO3yoXcEFD/cnuR7BsfiQ7V52AxeXfNf1?=
 =?us-ascii?Q?D2IpiqhWV4c0EbvDgkpkN4KELcWo4R3z2hNiPSvFQjSSHzZ4L/qZGbgUGLWW?=
 =?us-ascii?Q?ATo/uViGzq3nI8HvAQ9+6gbv/a7oDeuechEZz0WoG5ovCE72gCBIvbxJs1Cm?=
 =?us-ascii?Q?F12ijRPa1A6qMO898d9UJWeheDk7K1vV3rCSkQ2a01w9e3akgTS9KkIvriPA?=
 =?us-ascii?Q?1RuyIrgkhncQUT+o4Qxnw5JvQWc0ZbX4WqDQyzTIYMfLnPErh4X+NWjUPmrA?=
 =?us-ascii?Q?UE5CCtUqb2ENjcrXeAs2XFR+sh+c9q1qZHnCuu9abcyMO1V28X8AlGyRmCC4?=
 =?us-ascii?Q?GC2GxSQcYRO9EBEnN6nW972UbBJyqbhUCTJjl2PPmpp12y2n+y/PlgG230lM?=
 =?us-ascii?Q?/0TUEnowOUwEdQ5JMLIv3g6hRPzZX9BuFZh6DtGEwdOT1HIUBcJCxNgL3ARu?=
 =?us-ascii?Q?aq9I2dHLWlZfCzFQkse10CtFBbnVaBYlY2KI1T28QfDiSfQTN/FEstNBaC+W?=
 =?us-ascii?Q?nK+B5IoW+mTVbeVgz9gdqKRc/g1l2p8=3D?=
X-Exchange-RoutingPolicyChecked: amdPogGv1vdOFZUuBMbIOP8/5zGkmbHK0Z4YMY8WKdPbM4VBDdTjZdKFMvy++eWt9MqGh4LX5TQoHn1OfxxWDYlEFs6Cp9GAA28Q0kFFBLN0jjvA7INi2ZzhUSbhvrvnZ3XsfTI1n3pnFYk93YuEP0kbcSnzZnI+ToGYeDWhd3ffvPyct2nU3zHplpMF8o0XXWuX6zWKKEB89GfhrzWQm7RtZrXJx+vvb+gQKo9BFTQcVkOMffMGtpXSwcy7n0Y1/m/KcSP4cTKZeKvjozDmtZJaVX3wdIppO+F+7G/ZsTfU15EfDITxFsalIMAKFXV/WWAUVVQmfP8GC9VZqtn2kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f91c51c-8942-4012-94d8-08dee1477266
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 01:30:11.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNp7T9UkHbeiy7umDWqVAQ0s7hfJ/EYsvNIPoKZe8MKndUEN2+zbXjb+1G1dssqTR661M4CnETBY29Dyz4yXDBLZcWuyTs2dESbKFo8Nro4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-OriginatorOrg: intel.com

On Mon, Jul 13, 2026 at 10:45:17AM +0800, Li Ming wrote:
> On 7/12/2026 9:28 AM, Alison Schofield wrote:
> > Endpoint probes can race while enumerating a shared switch. If a
> > sibling probe adds the dport first, the losing probe treats the
> > existing dport as an error and fails to enumerate the endpoint.
> >
> > Treat this race the same as the existing port-created case by
> > restarting the port walk, allowing it to find the existing dport
> > and continue enumeration.
> >
> > This race was discovered while testing a cxl_test mixed-granularity
> > topology, where twelve endpoints behind shared switches are probed in
> > parallel during module load.
> 
> Hi Alison,
> 
> Per commit log, I think the root cause is probe_dport() called in devm_cxl_create_port() twice, and the second time failed because the dport has been added.
> 
> But devm_cxl_create_port() is protected by its parent port's device lock, probe_dport() is called only when a new port is created in devm_cxl_create_port(). If a port can be found, will return -EAGAIN directly in devm_cxl_create_port().
> 
> So If probe_dport() was called twice, is it something wrong in find_cxl_port_by_uport()? Or I miss some details?
> 

Hi Ming,

Thanks for the review and good catch! The commit log is vague and I've
reworded it for v2.

You're right about devm_cxl_create_port(): two probes both entering it
serialize on parent_port->dev and the loser then finds the port and
returns -EAGAIN without a second probe_dport(). find_cxl_port_by_uport()
is fine.

The -EBUSY comes from a different path. Two endpoints behind the same
switch race to add the shared dport and once one publishes the port the
other takes the port-found path instead of devm_cxl_create_port():

  cxl_mem probe (endpoint 0)          cxl_mem probe (endpoint 1)
  --------------------------          --------------------------
  find(uport) == NULL
  add_port_attach_ep()
   devm_cxl_create_port()
    devm_cxl_add_port()
    /* port published,     */
    /* dport not added yet  */
                                       find(uport) succeeds
                                       find_or_add_dport()
                                        probe_dport()
                                        /* adds shared dport */
                                        return -EAGAIN
    guard(device)(&port->dev)
    probe_dport()
    dport_exists() == true
    return -EBUSY

Before this patch, add_port_attach_ep() treated that -EBUSY as fatal and
dropped endpoint 0. Treating it like -EAGAIN restarts the walk, and that
finds the now present dport and continues.

Sending a v2 w commit msg update. Please take a look.

Thanks,
Alison


> 
> Ming
> 
> > Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/port.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 1215ee4f4035..65f2d2f1eb00 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -1749,8 +1749,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> >  					     parent_dport, uport_dev,
> >  					     dport_dev);
> >  		if (IS_ERR(dport)) {
> > -			/* Port already exists, restart iteration */
> > -			if (PTR_ERR(dport) == -EAGAIN)
> > +			/* Port or dport already exists, restart iteration */
> > +			if (PTR_ERR(dport) == -EAGAIN || PTR_ERR(dport) == -EBUSY)
> >  				return 0;
> >  			return PTR_ERR(dport);
> >  		}
> 
> 
