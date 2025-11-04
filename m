Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B3215F42;
	Tue,  4 Nov 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273049; cv=fail; b=pDNP51pB/Os/6y2d7wqmzzTBWYQ3XmI+EfQ2Xm1kGT9vVpwHdSCFF6U6sIhGwgA4XKFpcsUarOPRsmFaXKNPKNLPphO+8LuZTzdECri61A6oUC0UHrEa3LOSjys1Al5l1wIGWvzo66kRrM51mbNe2GJQOZwKxJznQzegIOV+Z58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273049; c=relaxed/simple;
	bh=kpjxQX8qqC/V+5tlBSBTNYSbN3xiWMlbU2qdpEotm4E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UM2RtTPHr8ZgjAvgXtMfNEW3fNLezb/DhECDtTo8FXMagek73Nn4RskimItssA1Q+USOOSFyPEvWUNLbZ9QykEbtvjdzlPoO6GIaT0b3mlIupYD3MVnTjhGj55qml7c66oJYBdCTz+ICXp33MTiadBqXBMnN3utRcOA/zIO/po0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTVnRMec; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTVnRMec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762273047; x=1793809047;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kpjxQX8qqC/V+5tlBSBTNYSbN3xiWMlbU2qdpEotm4E=;
  b=CTVnRMecxbfFGvedBvQfMhUCSTZ+x7RrC5kpbQAxlboxtw/ZEbIWiAxS
   thVEgrpE/32/lCncQJUT/kVJXk2ABgWQT6vO8W7t42+rmtKzI8IDqRBMY
   rrkqAQqagTTpp9api+tj68pS9CItXtL/cD5re5CqgIKIZmGWBcJtO9WDc
   cyw3IKaJy7Vs032kYGVI+5n7UqcfzfnUU0NFKZRmPXkivcvNf1UjE8pdp
   jFXJe8bDWI3ha0+AIkuHFwxhMsc80Ty23W0Xe8U0UHTDsM6Kpc7T6Od4y
   7nP67M41GyVFmZCMLzmLKpDs/JlpjWtBQ/UdvIW4s9l2HMnUkbekoYEPW
   A==;
X-CSE-ConnectionGUID: TewPYQsKSgir0emoVtk80g==
X-CSE-MsgGUID: hZW8NDphRS6kSuIkg99i7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="82002093"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="82002093"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:17:26 -0800
X-CSE-ConnectionGUID: X5SyO7/sRXuw9gFwjLKxcg==
X-CSE-MsgGUID: i+pH3TyqSYu2S7/GG4dqYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="217850872"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:17:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 08:17:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 08:17:25 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 08:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efpBEmPnpdJdA/xHEIndDNUhORzJgv4N/4qQlNeJqqadRrO9BNfMyV9oE0Y7Fp+knjartHYp86RSnWqIco1p3OfvFZVM+L+IHTD3HkuAzAlYFR1wSAqqsdKChJgrxRVXQ+LycCgsc1vEfMUbhsmxneoouMTdmGDz6bG3ICICT8NRWlrvy1rs5hnL/egtPIpB8mlaYfcXOB52of3AcM6aUIMLM5hex/CAyQQmZt6duH2iniEOLynuPHr3KEXV6P9p6u2OfBe8wQHXU10gB+ZflP4x6awvC9Ka9u5xp4Mf9+JdfLDxoGm5ZGpW2uXzr5ajLVJ9vmmsKTQ6G3V+w9KFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUL2Atv7uSrVVrO5bOftbU8QPnUYICZxaWpZAaPW8c0=;
 b=mG5YU+qWbHpiZzpWIwsGBekGvSZfp8zKmPsG+SUza0o4HiF+hmk5fpCggfff28vCq7iOUhkB6gUYeu/mCUnB3SYoc5K03QIxkgeyPl01fQF5ZjjAbIGNDuQ3ApfHr0NtC4GjQS+1CbvUdVqffHuDdy/pAvBUzwJSDiTxi28DbZPncebpZtvfUrA/FEzCljWmt8gqlBh9u0EYDAbDQW0OuA/hMLmh0OTm2LI1zpGRXWR6CF0J+MhxV5ErI0uVgSvmpUgKzpHlUddSoY/6mUVAZmiWfFI0zaN5BeGQzyZBkLmSG534oX25DAmdBFIMofyAZe1uAUL8e5KyvwZyy0QxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 16:17:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 16:17:22 +0000
Date: Tue, 4 Nov 2025 08:17:13 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 00/14] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aQonCRITOLOH0cG3@aschofie-mobl2.lan>
References: <20251103184804.509762-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f85c33b-a4a8-43fa-330b-08de1bbda26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pH0S1Kg4kFLojUc+mzXjoOFErs8dm3k6LG6qcE1pHR9txbjL4/JBD/eYXtBB?=
 =?us-ascii?Q?5XXxa/NwFreTje23PK6S+aLZyfPOhkYqUZfZd47BYQKFfPCq+aGTZkcd33XC?=
 =?us-ascii?Q?KArusr0l3SXdKlfTyKsaCXtZ2N+BwiU6FnU4vRPoX4vl5Ubfv6vby+xayMEg?=
 =?us-ascii?Q?dDfhBoKUBNJbD7yf644IOTF8QBs9X7ZEVUrfbUbnf55gwZcmEbcpxJ4gG1St?=
 =?us-ascii?Q?wK7v7WqzqnlH/1ktKzkeFAKYfpL4cKIWeKmZj6VtAljyaee8kvLPnJtbkNbR?=
 =?us-ascii?Q?QzF0+4T5TfIBV4TJka6wOex7KC7oIbRM4Dm7EEMLH/JyxNqjjgaHOhFxCLEF?=
 =?us-ascii?Q?iVIiqBmfKgNi2jNzrZDL9CL5CpTihK6PN1F5fCn0ORBr4urZo+m8mGfx5qXl?=
 =?us-ascii?Q?IjfYEfC7/1BSKjjqNs+gXFgvw0SIGVwzAt/JL25mLW+YV2ry8wrwj0j2yWtC?=
 =?us-ascii?Q?eZQR8vZZtnyRADxx+xfEWRabXvNlI1Ey+aA7QWY3ZygZ6tESEmnfH3NBpa9E?=
 =?us-ascii?Q?ECwZLATagPdwT9QpPOm9QwZHV6CYWjm8SFPF1yXIsz7KoWhKAuxNn6fwLADb?=
 =?us-ascii?Q?0HmiI5lb7v+i1xTkoIc4v2+cg2baVgvOsyokYey4cPaG/786ph4tftUg0r1j?=
 =?us-ascii?Q?K7niKUugcCMMC82D41jEs5RZQqWsyasCAFSLNZAmzqTWncpd4qgs5f3aINDy?=
 =?us-ascii?Q?Ki36/IQPIecf3CTQxGaYHYiDOoERDvkylUySeBqdFmypfUF7A8wq0J/A/Lc6?=
 =?us-ascii?Q?PpLvfZEWvc7brloUSL8MRxRUmnS2iuXsWtiYDM6Z7PYEbKNbHn52g0F5vcWQ?=
 =?us-ascii?Q?Gh8VR1j12VvV+RLWdzH9/amgNfteAPTYMUf1EnX2bva82qkGYgDxrfDb92WI?=
 =?us-ascii?Q?T4lfIF9t6ZeEwyIprNp+aqqVfBkArow8qmNIGmTns54KrWWMjmPT9IUeyC2o?=
 =?us-ascii?Q?ExMgwEPwNVA4zm9zmc7wGI0rF68ichmYnJmL2QTV0TjHrfCHdmHeNQ3YzgSy?=
 =?us-ascii?Q?HGOrKkAODpyy348ZgZe/BxqMzkyorUoynBn6BHGYbIE86+GRvK8p23FsduRk?=
 =?us-ascii?Q?vuU+KddcbDCWCWW8g6wf3SP01nvTaLZRgMpBcibtLva84J6GneHF9WuVpE8C?=
 =?us-ascii?Q?n6PzmltMlgKRP1MocRTOxfvylzo4/baaBVMgKNcj9dSKnsgbv8y8Jn6fXXG8?=
 =?us-ascii?Q?m4HqvwkwL7CBj2Gcgoj9ao4PszXWa0dLfl3W6ufrf+3TiGTfANGlWXYIMAXp?=
 =?us-ascii?Q?WEzpLY4zvUIj3bl1wGKHsPUJ6G1bn2vz8CI/F6NVSiPWGpe7CteofJ7+unpV?=
 =?us-ascii?Q?PfNy1UBkQL5z/STUZuQppFop7m3QeMYt2u4WXpnb6axoD2LufH8Vk/IJl3pu?=
 =?us-ascii?Q?0nBMo5eTtDqmsB6xN9nRIWC9WCmH07IyPZs+z5jjA/MvBaeHyGQ67QGk+/LK?=
 =?us-ascii?Q?e7vEo3mYc4hdWtdEU/JM+1KvflEnEHjAeez638Swft4oyKLbbneoJQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lf6juW6mWjLf0YzAJnpkz8KtxJwB0PLPdNyJ8nkANDczRzamTL6ID27dr/7W?=
 =?us-ascii?Q?41wnDm9Kkp0mG8+T0f5sDFmLbeNNhPYxC0TsNmb7v3PKbXsY/sjbPpJgz9QU?=
 =?us-ascii?Q?qcqKGwef75/j6VwAOpMwG6t+UlXiiBzEooqP2ZXvpwS/hXnBQUb0U6WEd1uP?=
 =?us-ascii?Q?sfGVRCisVe7GLNYRUGGvAyl3SQ/C3NgEeSj26r7a5cJWpg7qkfiHgwjlBHzZ?=
 =?us-ascii?Q?jj3nZAIz6L5JP72USsf3CXMFLNLEIChNxLM5DDkvRm7QwkH25C4SCN48dIY+?=
 =?us-ascii?Q?DcwM5wvSd/QOYdyht2WkHLbWnifRGFZR3xgNeA+T8D46hkbELJlfD6ltdqMX?=
 =?us-ascii?Q?ggri6QXvwL5CdpMVEIkxA49FUc8Jugc8X9ev5q+fToAxdmxsAtIiTLM9U9oE?=
 =?us-ascii?Q?Gmy5H42cD5urJKg7HgO7g6QpKG7T+nHINNu1O/jOe5sdLfnZyx+4VoqTsBP/?=
 =?us-ascii?Q?NX2Nj3vxWppl8L3qLEIDghSjudiL5yHzdrMdx2YhR5boI3/SuCXjbDFJqk59?=
 =?us-ascii?Q?KptyBqBN7I2Wiv3kk5ArYkCP0PC0hwi9P9QNnBDkpgavSEfys06Viu0R4VCH?=
 =?us-ascii?Q?rHBoLs0nNEgr5e81Nvtn8kmKJSBBNsdRuqNwbKQb1HUkP0BYBgrIEplgxTHj?=
 =?us-ascii?Q?AXP3O5rFDx0N8l+AHc+KIWuWEPQMI3o/IsNqBQ+oL0dccGpOSCOnZK6MBsy7?=
 =?us-ascii?Q?u5CRUKlp0OOvhPpDUBrwmX54QOf2XD11rdvnN2bFhBq68A3iDQ2R2oHn5Qlu?=
 =?us-ascii?Q?LefCJETR5SKXDhYUx9RkMYV4Fnraim43eh29L9dsMIwD9nfL7vSpe+Wi4y2X?=
 =?us-ascii?Q?js3WVln5KCDTDEAljtVfBHljF3sdzQ6Nwk+FKTa7+S24sbGGhp9GYCx25j6a?=
 =?us-ascii?Q?AzPFQ3eRoSUFsYLf3h4SuY4P41jUP/X4Sgnmzpc1cHAilwNGsS9FkHayuhWv?=
 =?us-ascii?Q?xIRopcN62mYS9s8hn35xCeBYtDYCP6qO+n5IsdDnZe9U5s1ZiROkZfwByswx?=
 =?us-ascii?Q?4TqSsrCKkStgydvpDrIF1lQovud1tNQgfOwU7TsO9iOKVx4XEs41dDaDVQbi?=
 =?us-ascii?Q?trIe4Aeh1PW3pWcv8WZSbytuIKbNEtR0zFh36KA6ytjt0O8ttW81QA3Y2NoI?=
 =?us-ascii?Q?KelPSpvFPmYtwQf57odpqgxP1LueNunt/wcFb3t2wFp+HKtprlOZBfPHlodH?=
 =?us-ascii?Q?uAvtYmdzhaPXPJTFkSMSaVRuW1lkYn96/0jdSyNggXhSvIk53utOdDmHhLk5?=
 =?us-ascii?Q?StpYmGBmCTHqTzGKkoGUUHksn4RsLWWefX3f4QQwnf2vInjtxZ6TnvBH2cd8?=
 =?us-ascii?Q?T2c734e0M0rBW0In8V2S7MM/YKiZ4GfWaQP6VAIovwhY5GGhuyt/kaPKwfzo?=
 =?us-ascii?Q?L1cRySpBDp/KOz4GgCvpWlUjsbKEpMv+0xFYSxFH7xJlNDJn3I2PDvEGb1/0?=
 =?us-ascii?Q?J9gpeYl5skxKrlw53g7694yUjeWqmEHLbrujuFInrmo7tz75052HolVBXkVA?=
 =?us-ascii?Q?pIGNFs6jlymuKPiRMfxc5OAddf+PP3e8y73DIx/66Y3lhz/tJHcGXGjd7icE?=
 =?us-ascii?Q?27zH+9pMOaVRLjc2fpe6PbfoHlbkACRYMveqi6S+rKNLg4StFVxM6o2pJM3Z?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f85c33b-a4a8-43fa-330b-08de1bbda26c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:17:22.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsGlALU0HAFhAMZksRrIaFlQyR70cFp/5z/+WKH18TRoaeXV580HNQB3v5Q1ptb1g/WPBtkCYF23eN6DnxTeHNXDSRvYIyi3ry90XKmEmWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

On Mon, Nov 03, 2025 at 07:47:41PM +0100, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. This is another new appoach in
> response to earlier attempts to implement CXL address translation:
> 
>  * v1: [1] and the comments on it, esp. Dan's [2],
>  * v2: [3] and comments on [4], esp. Dave's [5]
>  * v3: [6] and comments on it, esp. Dave's [7]
> 
> This version 4 reworks and simplifies code to use an address
> translation callback bound to the root port. It moves all address
> translation code to a single file, core/atl.c.
> 
> Documentation of CXL Address Translation Support will be added to the
> Kernel's "Compute Express Link: Linux Conventions". This patch
> submission will be the base for a documention patch that describes CXL
> Address Translation support accordingly.

Hi Robert,

I see above that the documentation is expected to follow this patchset.
I'd been holding off expecting to have that in hand to do a decent
review here. Is that doc not necessary for review? Do commit messages,
code comments, and spec references give reviewers all they need?

> 
> The CXL driver currently does not implement address translation which
> assumes the host physical addresses (HPA) and system physical
> addresses (SPA) are equal.
> 
> Systems with different HPA and SPA addresses need address translation.
> If this is the case, the hardware addresses esp. used in the HDM
> decoder configurations are different to the system's or parent port
> address ranges. E.g. AMD Zen5 systems may be configured to use
> 'Normalized addresses'. Then, CXL endpoints have their own physical
> address base which is not the same as the SPA used by the CXL host
> bridge. Thus, addresses need to be translated from the endpoint's to
> its CXL host bridge's address range.
> 
> To enable address translation, the endpoint's HPA range must be
> translated to the CXL host bridge's address range. A callback is
> introduced to translate a decoder's HPA to the CXL host bridge's
> address range. The callback is then used to determine the region
> parameters which includes the SPA translated address range of the
> endpoint decoder and the interleaving configuration. This is stored in
> struct cxl_region which allows an endpoint decoder to determine that
> parameters based on its assigned region.
> 
> Note that only auto-discovery of decoders is supported. Thus, decoders
> are locked and cannot be configured manually.
> 
> Finally, Zen5 address translation is enabled using ACPI PRMT.
> 
> There are 3 additional cleanup patches at the end of the series. It
> might be worth to add them too, but could be dropped if there are
> concerns.

I peeked at the 3 trailing patches and they don't seem to depend upon
the series. I'd suggest submitting those individually for review.
That'll pull in more reviewers to those, ie folks who might not jump
into the entire patchset.

Thanks!
Alison

> 
> This series bases on cxl/next.
> 
> V4:
>  * rebased onto v6.18-rc2 (cxl/next),
>  * updated sob-chain,
>  * reworked and simplified code to use an address translation callback
>    bound to the root port,
>  * moved all address translation code to core/atl.c,
>  * cxlr->cxlrd change, updated patch description (Alison),
>  * use DEFINE_RANGE() (Jonathan),
>  * change name to @hpa_range (Dave, Jonathan),
>  * updated patch description if there is a no-op (Gregory),
>  * use Designated initializers for struct cxl_region_context (Dave),
>  * move callback handler to struct cxl_root_ops (Dave),
>  * move hanler inialization to acpi_probe() (Dave),
>  * updated comment where Normalized Addressing is checked (Dave),
>  * limit PRM enablement only to AMD supported kernel configs (AMD_NB)
>    (Jonathan),
>  * added 3 related optional cleanup patches at the end of the series,
> 
> V3:
>  * rebased onto cxl/next,
>  * complete rework to reduce number of required changes/patches and to
>    remove platform specific code (Dan and Dave),
>  * changed implementation allowing to add address translation to the
>    CXL specification (documention patch in preparation),
>  * simplified and generalized determination of interleaving
>    parameters using the address translation callback,
>  * depend only on the existence of the ACPI PRM GUID for CXL Address
>    Translation enablement, removed platform checks,
>  * small changes to region code only which does not require a full
>    rework and refactoring of the code, just separating region
>    parameter setup and region construction,
>  * moved code to new core/atl.c file,
>  * fixed subsys_initcall order dependency of EFI runtime services
>    (Gregory and Joshua),
> 
> V2:
>  * rebased onto cxl/next,
>  * split of v1 in two parts:
>    * removed cleanups and updates from this series to post them as a
>      separate series (Dave),
>    * this part 2 applies on top of part 1, v3,
>  * added tags to SOB chain,
>  * reworked architecture, vendor and platform setup (Jonathan):
>    * added patch "cxl/x86: Prepare for architectural platform setup",
>    * added function arch_cxl_port_platform_setup() plus a __weak
>      versions for archs other than x86,
>    * moved code to core/x86,
>  * added comment to cxl_to_hpa_fn (Ben),
>  * updated year in copyright statement (Ben),
>  * cxl_port_calc_hpa(): Removed HPA check for zero (Jonathan), return
>    1 if modified,
>  * cxl_port_calc_pos(): Updated description and wording (Ben),
>  * added sereral patches around interleaving and SPA calculation in
>    cxl_endpoint_decoder_initialize(),
>  * reworked iterator in cxl_endpoint_decoder_initialize() (Gregory),
>  * fixed region interleaving parameters() (Alison),
>  * fixed check in cxl_region_attach() (Alison),
>  * Clarified in coverletter that not all ports in a system must
>    implement the to_hpa() callback (Terry).
> 
> [1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
> [2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/
> [3] https://patchwork.kernel.org/project/cxl/cover/20250218132356.1809075-1-rrichter@amd.com/
> [4] https://patchwork.kernel.org/project/cxl/cover/20250715191143.1023512-1-rrichter@amd.com/
> [5] https://lore.kernel.org/all/78284b12-3e0b-4758-af18-397f32136c3f@intel.com/
> [6] https://patchwork.kernel.org/project/cxl/cover/20250912144514.526441-1-rrichter@amd.com/
> [7] https://lore.kernel.org/all/20250912144514.526441-8-rrichter@amd.com/T/#m23c2adb9d1e20770ccd5d11475288bda382b0af5
> 
> Robert Richter (14):
>   cxl/region: Store root decoder in struct cxl_region
>   cxl/region: Store HPA range in struct cxl_region
>   cxl/region: Rename misleading variable name @hpa to @hpa_range
>   cxl/region: Add @hpa_range argument to function
>     cxl_calc_interleave_pos()
>   cxl: Simplify cxl_root_ops allocation and handling
>   cxl/region: Separate region parameter setup and region construction
>   cxl/region: Use region data to get the root decoder
>   cxl: Introduce callback for HPA address ranges translation
>   cxl/acpi: Prepare use of EFI runtime services
>   cxl: Enable AMD Zen5 address translation using ACPI PRMT
>   cxl/atl: Lock decoders that need address translation
>   cxl: Simplify cxl_rd_ops allocation and handling
>   cxl/acpi: Group xor arithmetric setup code in a single block
>   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
> 
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/acpi.c        |  32 +++---
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/atl.c    | 205 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/cdat.c   |   8 +-
>  drivers/cxl/core/core.h   |   9 ++
>  drivers/cxl/core/port.c   |   9 +-
>  drivers/cxl/core/region.c | 185 +++++++++++++++++++---------------
>  drivers/cxl/cxl.h         |  33 ++++--
>  9 files changed, 366 insertions(+), 120 deletions(-)
>  create mode 100644 drivers/cxl/core/atl.c
> 
> 
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> -- 
> 2.47.3
> 
> 
