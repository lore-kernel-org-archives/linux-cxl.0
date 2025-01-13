Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39914A4D1;
	Mon, 13 Jan 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785346; cv=fail; b=lzHseXLQSQZpfe0ZfgLjKDZlMwzAAIS6OR8O4VsMHdWRxNAbFBm5SucNidmoMxXqr8lTj6kh2c6WwDzV3InWUXCvtbWpjqGY3BYaGuUmgHXu56jB1dWOga7jWxxb5bb4UwPqemuj8o95enQUyi0bDK4U0ytz8kK5C+c6lQKPoMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785346; c=relaxed/simple;
	bh=Fjv4h1CPoU1o77QaeIb+X+iQoCnwt2y9TItFKbAv/6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heOHH4PwMfzGNX+ZHw1j1MuEWzSDIK6U9pkisVXpZegpo/mU9foMOjBxJgJHwvJGJbsaUuBeVU3eOXqJd/PStAhtneCibGe5xJH7zC+KYGwNml2WShMDtDWJnG0jZYpN/kLtm2w/2sWIDcs4a/KWHKjit1tqNDgzM0JYZIwJ6Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXS4DYWn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXS4DYWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736785345; x=1768321345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Fjv4h1CPoU1o77QaeIb+X+iQoCnwt2y9TItFKbAv/6w=;
  b=aXS4DYWnMbueXavfB6/2M7qPsKzHxfbbcuQ6QXrtWTdke3ByNdpAVbAY
   D4DNSk6X8i3BTZAe1FU9HbycEVdDUB+JfhWX7TYqTcjzg7wDKX43plXmK
   hebKlKXGKoO1Ss7hH2GBxtT3B5jo1+ZyA4oDZdiwO6COyx3Qe0WEEJPOS
   ezMzHs0gcZUJnOIDXKif5v3xFNsylhWwvDCpcps2xP/bXQkD1BA/NxKeW
   zQSGuV1BjY/5XJZNLvLqhDxzAUD5mVmpIcRW/THizpNaFPrs7tUWiR3ds
   mDh1CF2T5rEI6mGncFCgDsSyy1NkDI6hjT/BD41m56ac8cCL439jlW56h
   w==;
X-CSE-ConnectionGUID: NAFwdATDRyilL3MNcwz9JA==
X-CSE-MsgGUID: EQSbF6kxQECTOtOmV0u+UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36963995"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36963995"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 08:22:17 -0800
X-CSE-ConnectionGUID: mwI9L6wrTZ2v5u2ihcQuAQ==
X-CSE-MsgGUID: idKMt6IVS7GfgVOHHL/A0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="105040733"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 08:22:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 08:22:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 08:22:15 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 08:22:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKkqQqQC70tKEqdpg6Uv7NnG1IofxuJyb7M5Y5JpOUb9+0xyOHhy2LXGX5jbPcGtBAiHPSwdAhtIHa7vL6UmsFRoEn/XRVNYuUxEXoKPm7oua5pQe77Dcku5y9+JmAYwpPca3d3aSteibMkVRzZO906cyhzSxcx7AFMOX0KeQc2AxzwUMKdxazj/UJiztje8bKKIfo7TL677LAzUszkogYy47+aiorXeNch55Hz8viR2E/KgExTCotiJZM9RMU0RurtmTVhLT4UfZ5GTM6LCxQfDLG+ajl6FfAj968CnNEh1HFPFQ8obmh3Kiwvp+vGKo0VgwbkV9FOK40e71pwmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSqdH32AWOXabyCj0PCCtYpjMFbx4qKMcrcTUT5sZp4=;
 b=Of18UIoazhRnxXspFCJokEWhtfA9yfPVB2xmmurRcW6cZnDNQ7bH7WG4f6se1c/7WEhV+SeOZTrNomQ8QZfEc7nN0YXBSm1wNqVY/yZzV94YfLEIHF/EGFfNJyaveqSTCKRkqEcQ73PMBWBjpVpGshm7JKG/lJm3VAgUGqKADnjVLaeDwFs2QhoFmbMG6TpOEjCZWaY/FabtBemOKCO3qoIyagSLcmbVlQN8hcoTFjXvZ+P/t/wYds/wUrbVDuptZPrI74K35V/rXmq6f7s4sJznOAdZwAmqumS/a6rbRu+GccQhnDJXhakmgxZ7BzwUSf8z2WU7KYpnJ3gmL9GH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 16:22:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8335.012; Mon, 13 Jan 2025
 16:22:09 +0000
Date: Mon, 13 Jan 2025 10:22:04 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v6 4/6] cxl/events: Update DRAM Event Record to CXL spec
 rev 3.1
Message-ID: <67853dacb9a2_1817af294c3@iweiny-mobl.notmuch>
References: <20250111091756.1682-1-shiju.jose@huawei.com>
 <20250111091756.1682-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250111091756.1682-5-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:303:6b::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c74f4d-a210-4ccf-ba72-08dd33ee6d7a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N+7aXs75LG/CpeMI6jgTdqOgvx6H44vN5S7h6uivNjwYMkfGoDzvJaDWVfJv?=
 =?us-ascii?Q?3VS4VcowThnl/q6n2MQ4LUzkDmc5YiDobdJ44J1GKToU3zp6sAlO4kx15L7V?=
 =?us-ascii?Q?n7gXKGd9VGcHwWX2tBiEWAWXsA/iM+nIi/MW4FlqKT1ee8Ptaeem0h6wFoPf?=
 =?us-ascii?Q?DioEUEOMxihduTdbde6VOYlvjTqrHNZO+5FuZ7rxTcYnA8H39zQQ4phW7wbr?=
 =?us-ascii?Q?XZ8vY3iWqhoE45L2M2UinFHjKfrYZ626XJ9UQ/tQCx/mVnvhdfvf4wpW+Rvg?=
 =?us-ascii?Q?QaqhXC5weAMXKIWxLBxkN9oCHxv7E8StKDOukWIEa9TWHJ7wbWxfZ1oUUjJV?=
 =?us-ascii?Q?Ebu32hnjeHj3f8gGBm53/UgvlvjnOYjMXAzCJfvBRjy4lzM4krRvnJO9/p6D?=
 =?us-ascii?Q?EJZxQE7SOyzEDfIKtD+qe0zBJO4Pj+gFhDWwaRzpbqoLrQsX9frT6mX283Tj?=
 =?us-ascii?Q?cT/+AJky+1VBrMhx3j/1+//O1gNuJgWmkvhKAh0/p/CgI1GhHwukK4wC8ZWl?=
 =?us-ascii?Q?W9ogtKS3S2kVBtsFqMze7tWgkGDQGCUXjwcAMlZnZXhlsUmSN9PbghBlvgFb?=
 =?us-ascii?Q?8u/ssN5Ol+LbKg+Zgbh6DLfixoW//w0VNV2umFUe1UbCgeFgbDv7ZoQS7Qn5?=
 =?us-ascii?Q?808jclbp4j6GcnW2OwEs1GqvJfHXyPDWCbOo2UDKAzsDyOfu2lWDEhcRiRy6?=
 =?us-ascii?Q?msERJ1cEihThaYfwjnIoICrzEAAHr5AxZLdqkcPOAF7hv0DH0SXwTwc8+EM+?=
 =?us-ascii?Q?r4bpgi61LdAEQy8bgHvaI+6E9VXJY82lf6a11Xjh6edU2HMzWcQH5mxgShWm?=
 =?us-ascii?Q?YN96jgWtJHRjaQSMklmsaRhk/IB2+ZtBdLm0VP+zV4s5Mzpf+lNsbKmuSTme?=
 =?us-ascii?Q?GZ0a+vP30WSt7wXkVsHQQQLawKy9D7SLh1k/m+pjsQBJ6fEvQzXduN3elyFm?=
 =?us-ascii?Q?L2EiZesUL2mrG2TbRBvKiAQBX+nbWrgyyjvqWHrm1aAXnJ+UbOiy3cmmSaID?=
 =?us-ascii?Q?pELXcvTYjBMfQx7uNmPrGRznIwOTK0QoIAsHH0umv/Q+8thJP2hP15RMfzzb?=
 =?us-ascii?Q?Ovdi6MQjcAzJNy4HeM/AeTOUERprOkyp49h3hFOX3cOFmcj2TaaBEJIVJsOC?=
 =?us-ascii?Q?SR8QFiFZg9cGJY/B50++QVN+hBKQDwOTIWLxz6lYR1vGZQGJOupHKTebe8E8?=
 =?us-ascii?Q?m3YgYTAxfbjvl0vlNVz8EwnKJVHbygOxfVMSde4InrPw4f0KlDS7ezcFZJ5r?=
 =?us-ascii?Q?92Qfdhv8zciwSkqJ14g7s/Mf0hQUpXJztK0lPVhzkeLYrwEDsTKcB00vOXtq?=
 =?us-ascii?Q?WEDjeSquFlDRYy0uIyJ2Xaz1O+2zeawoutHqMNIMu4cVo6/aijPoOTysk31h?=
 =?us-ascii?Q?C+gONPvm02qr4Y57DYAXafrCqsxyFQH7YBuVmlssNYGililuxjLoLg6prhwm?=
 =?us-ascii?Q?Q8XjzYCsOGw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yb0LfhJi7TaV4QkpVKIEXLRsoqM25mn3t6CQ/8NjERoQDJ45o+ojjbEVLGnd?=
 =?us-ascii?Q?U3FbyBrQFP8szSSq9cC7FgnJAWn+cWVIyUGKc2wLtwMu04fjVeux15dKlxVV?=
 =?us-ascii?Q?Aq40/Kp9GvL69IAgwh7uLJof1XJvAqAsDGqUBcZ7oO9LTkSfELTkXCemC2iE?=
 =?us-ascii?Q?L2xsLtV2jEe2LGPtmpOtOlFD8NPUDIQRGhN++vVXsX1ibIt34VLDK2UZmL3O?=
 =?us-ascii?Q?Ok3pCR9133d3UGSpLw0QiuE1hxR8d9ogx+W68fAU/i5DtmwIfmEtMuM8iIuP?=
 =?us-ascii?Q?4JN5g3LDck/uKSknBX9AtBtXXQ8XTNDycgOFUF9uhl5OlVAGNMZOawZcJVNb?=
 =?us-ascii?Q?GDDbZlAp6PiX6Apt3QYVbUMDFhjuPF/kBbKbPf6fHm3zFd1+Dw5mxllgxM69?=
 =?us-ascii?Q?iTJ5W2Bz06m7VideNxJPxKpDpRDxvGVMpw6/k1NO8EGgktD9w5KGPZg878os?=
 =?us-ascii?Q?99FKKfETaSsCCTlMN8gNARRL+y1lpmFj6ACRhSzWd17snuwMMCxAuzS/MvLu?=
 =?us-ascii?Q?HOPDGNbOlJUEWVFEdX67rpk3tKQN+xyFyJ9PQSdT582T+igSnuqLCJ0h8mD4?=
 =?us-ascii?Q?mc05CsHgcZBtoDC8r4cfbxSTbL9us7/Geaygr10RP1RchoesdwZzHMPH6cao?=
 =?us-ascii?Q?aVXfQQA37H+q1Mi1t+5q+HWjUNpVK/3vfDKzkU9eTsfOiqG0X96flANL7W1T?=
 =?us-ascii?Q?9ly0egKJtR61Lt+IIqrdb4DLxhfw0W52fG1rJ46wNR6/vVtEKo8Gj0OvTel2?=
 =?us-ascii?Q?9wYPo+amJensKL4mwIdOVpNVtjfjIeTD1+guhFJwishyg9Bj9Nqvlw/Li+FO?=
 =?us-ascii?Q?/rBL5IesPVqSk7IeWrIjML3PGJSt/PqB93TWcw/9XP+CRVmVWkDPSlVmDN60?=
 =?us-ascii?Q?bFh1ljPzlodHu8vOdi31QRA/NdvAvGg/QLK4yIoVTKs5gZfQYZbfxj1AhoYL?=
 =?us-ascii?Q?mXwu7osANiqYw/hK57JRs935nTiUvFkrHD4/x+Tavo8UXyYeq03qKVUAIw4U?=
 =?us-ascii?Q?yvNDAnnQVxI+RPZ8bfF6pOgcefOymLAyOYNPdkYXrPZO1Ckfm5mfg68Xkh/t?=
 =?us-ascii?Q?ZNVkda+wBTS1tRfd/KVhmzoREzK8UmkULglrUcTaGKAKMKew/fOp/SmFVs7I?=
 =?us-ascii?Q?J4kLz1Fmu4Cya70k2FcTrkHGCW9VeM9Lgs5R9oLUunS8ZmcOWDaovjN5GnW0?=
 =?us-ascii?Q?nqRLTvTMQJqbcQ6rSeKJLJhXZqMjS3IrzmmKhiJpVxYZ2Nc1dZ8jH2pzeyh8?=
 =?us-ascii?Q?MC3o8QbNODInKmzJwBRo9pXuG2GfCpjz6EQYAQiqcXBfFIEjzu0NRnat+xNJ?=
 =?us-ascii?Q?NcAnXZ15GjKTifsW2VN+UHMSoB8YPxhwgb30RljnvGD0M9BCAqsAmu54vsxX?=
 =?us-ascii?Q?i+0D7H1IWv6I0OrnM8+L/gPEZRmezibSe5pGC/p7I67lL2h7RKKkU+2xyzdy?=
 =?us-ascii?Q?vGtfaGAXccqXgNPh5mgBW9AtP1f5cEZAlnD8ZOIMPXja6T3yMnilS2wPqT/9?=
 =?us-ascii?Q?UedJmKRziObH+Q3U3KndRZG7ZWUHer/1WFkcGmu8ZULXz2KS9i73kV4JGA1u?=
 =?us-ascii?Q?C9RapmabhgI9hmJo7nJQ9S3ttU5lW39BmGeL1VNh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c74f4d-a210-4ccf-ba72-08dd33ee6d7a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 16:22:09.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD/nQhUUzyfAgQROoHjafngjgyXX192iDhxSUy3WMcW9/QKBNDFOQhbCiESVOq4iV9nkf+Rk7g0okU6yv0pP4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
> with following new fields and new types for Memory Event Type, Transaction
> Type and Validity Flags fields.
> 1. Component Identifier
> 2. Sub-channel
> 3. Advanced Programmable Corrected Memory Error Threshold Event Flags
> 4. Corrected Memory Error Count at Event
> 5. Memory Event Sub-Type
> 
> Update DRAM events record and DRAM trace event for the above spec
> changes. The new fields are inserted in logical places.
> Includes trivial consistency of white space improvements.
> 
> Example trace print of cxl_dram trace event,
> 
> cxl_dram: memdev=mem0 host=0000:0f:00.0 serial=3 log=Informational : \
> time=54799339519 uuid=601dcbb3-9c06-4eab-b8af-4e9bfb5c9624 len=128 \
> flags='0x1' handle=1 related_handle=0 maint_op_class=1 \
> maint_op_sub_class=3 : dpa=18680 dpa_flags='' \
> descriptor='UNCORRECTABLE_EVENT|THRESHOLD_EVENT' type='Data Path Error' \
> sub_type='Media Link CRC Error' transaction_type='Internal Media Scrub' \
> channel=3 rank=17 nibble_mask=3b00b2 bank_group=7 bank=11 row=2 \
> column=77 cor_mask=21 00 00 00 00 00 00 00 2c 00 00 00 00 00 00 00 37 00 \
> 00 00 00 00 00 00 42 00 00 00 00 00 00 00 validity_flags='CHANNEL|RANK|NIBBLE|\
> BANK GROUP|BANK|ROW|COLUMN|CORRECTION MASK|COMPONENT|COMPONENT PLDM FORMAT' \
> comp_id=01 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
> comp_id_pldm_valid_flags='PLDM Entity ID' pldm_entity_id=74 c5 08 9a 1a 0b \
> pldm_resource_id=0x00 hpa=ffffffffffffffff region= \
> region_uuid=00000000-0000-0000-0000-000000000000 sub_channel=5 \
> cme_threshold_ev_flags='Corrected Memory Errors in Multiple Media Components|\
> Exceeded Programmable Threshold' cvme_count=148
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
