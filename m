Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85D3A3E78;
	Fri, 29 May 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032623; cv=fail; b=MZYZi1tYgTe+bH9jQLdC8ukSui+4Va25qB9G4s5yr5GFWgMUohHiB35fA1ABBSwLKbf0ZMUwz8ZuAfFUNMd84rUBsKjKYhM6b8conJ1TBPJtx7zVUL2sHRhX31xHGwMJo3QeXy+hKNqCptDpwJYd/Oy57kDoY2iZcivX2642YPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032623; c=relaxed/simple;
	bh=CmliKSG0nU39CoBDsZyIDHVxgNG8R+L1he/+DQcSyIk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ia2WMm4wi/xlOsd3atQygKH38xEqP3kjUWJFGgQ8OtbnZ6YcOMqLjU4YH7OjH/spUJg5YO2xgMxsVU5oq1FpG5cikkcdhBIoeQLTEHujO2hUdKlgz7dteov1qZtekKgmjfMTIW85tnxIqMT5PNOegwaAqy021tripGvzMj0RgEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSpXovI6; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSpXovI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780032620; x=1811568620;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CmliKSG0nU39CoBDsZyIDHVxgNG8R+L1he/+DQcSyIk=;
  b=VSpXovI6RA7R3YUeEvnoFumPF25tNOUM6xE59OyRl2XIOvLGeLBJmBVz
   AW+1lsW2RrCpRlQDSqZ3V1vnBUcshHxdBeW7V/zEJA3uKzhBbIuvWv2iv
   J8Y4CNMsBP35FUQB5tuwAOwDae2fiLnIa3O15aXkTY2V3rEdoJrAr3kG1
   zHqMG5Aft7Kyuhh0wI8KHOz6ivzbrHjbw/7+W0uLobobimCnMHsJRbYww
   FwweT0yxX7DYGAiX38eeOdn4z2mXZ217kfZR+KA21bWUwfllDDgLjntKP
   tR4eWyXagCuJeR97jTS6s4ICPgNV6+ROvpGkAs2hNlXQ0BZKyolFlmS+G
   w==;
X-CSE-ConnectionGUID: Qe8Pct2HRNGl+YVQ6VrIXQ==
X-CSE-MsgGUID: fBfM45K+R7K7hQBRgfwU9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80942928"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="80942928"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:30:19 -0700
X-CSE-ConnectionGUID: BZ4Oz2I8Q4qVCFeX/++H+g==
X-CSE-MsgGUID: POwFwRR4Tju3RFe3JGoAPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="247843689"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 22:30:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 22:30:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 22:30:18 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 22:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4NW2Fnz6AOeI0Z99Mq5Weos+2HZZbbbZK9McrExTf6UzgKzxbEVWzfV7Px7pEheyeRbAqHl55VV4m24O8Fki2yUJZur2NdWuAMcMrxBnqKp5j/uUpiTol/XIGy5veZytCjZ+W8r7gKn9T6q5h6hVD5ImkdCVGqZL+ey5p97IqgQU2NWWkINv0eR++zDQrvzny77/8JdZsUBkcmOYRxgSJNO7wTknOG/plP27lIRzueK9d63SHOWQMlbsIzc0lsjG6KnWVs7rnSwF5I1RqD07IjMPcwA3FvhbLGOxSDmeiQ7DGYU/ZfQi3uKOu7jYjKgkyamHX3tAe19VU85qYu5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZDE+OldyDad3c+9f8haLo7uBVMT36nOIRVoI4mBafk=;
 b=hg7Po3wF57uydb5MBSLw1W/Y3NfQObfK22mPC8ie1m2V/p46yojNNFP9QjaC4BZvt5T3wP8V2h/U8n3D/bvifGXJXoPtN1jZE60GNQ6pAfCH7i3skwreXayGMNNxLdiwPzmBnB+9N3QcAHImlt/sh2ruVYdEL6A3EzWB38l4B5O7svVJ+HqlzniYoCHkHMPlGa4z/2M1IhyGO1vPsgxjWQ2wJWCOjzYeVGSRj+qdEgS9almExehOUkTCW+Ck5d1uDfoVIw70cQ22h9rC6McGkurgDJIVjFjxn1Zj5MJE9Pgi3SWO8GgOV0znxB+lmbGsbJHnDTAkrMR68CXgYfWd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 05:30:14 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 05:30:14 +0000
Date: Thu, 28 May 2026 22:30:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.ne>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <fabio.m.de.francesco@linux.intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [RFC PATCH] tools/testing/cxl: Support multi-decoder
 shared-dport topology
Message-ID: <ahkkXoNE8kReYtSt@aschofie-mobl2.lan>
References: <20260521084806.28232-1-icheng@nvidia.com>
 <ag-xchhZdpqE9fXW@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ag-xchhZdpqE9fXW@aschofie-mobl2.lan>
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8510d1-b65c-45c5-917a-08debd435c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099006|6133799003|5023799004|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uxp6BHLWxt+HdjdDffOkKVoxI/w9QKZiJtzC56Ocz1OlpNvf65tHXQwRp/3zmWrb7dP00YV7RmttnErVcgj1r7ntqD33VUedHuYW8kMDCfwrl8aK6SlPiwwL/kyBe9YrqNMtWhsalhvSQ4L+HuZnhSvxAW32VFOvCCf3tQMXAIhqChktjsWeDjIZxtS/FkiNqglHvsj+6rwExsPWdBtmuclWXP9Xf6HFTk8sKN4JK32Uad8aDoQ20gmnyMO+hGe+Kr1ddKrGH6kOvguZamJRU7CdFHVv+154YRPb1tt8TZnX1wmvPqDD1++GSBAF0cmbI5gGAdoEpA7EFxkEbS70+0M8Fe6ZdJPEXWdmCsjQhVwSYxITwCSiL/Y2IpTehjRqlQTat81K6EXJ39B7AYttPUpQiDRkngrcV6dJh/+qYmwrrVD5vVo3ZK7YUrSBXAmI31fGXmQw106cTnkN4eI86fBFnH1oxgnk9v5bYHJBu6giAoFf1rO0vgD+KvkaI+BMBjV64JMsKngEyDyxpuuQrxeT3Vm8UIj1bljwuU2ci9EM3liMqNU4aoOYBavzA0giRn0NGbw7O8XAGzeasiLsefbOUWbV+t/EwTT6t5UMTan8WKMlD8ArQPlkTGsTEN3CXoA2aWaMIwRHP6apInr2pcBiUE954042zYBl9QAm6d6Z1auZLozmsQ/DgU69QaXC9g3zwiafbYLh113/UTHQ9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099006)(6133799003)(5023799004)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+qKhCEVbnoah3VpuckM9HQoyO/QIwol4Kg4R2FK8VrC6u1OSJwpSbKM0mo4?=
 =?us-ascii?Q?3E2ksFeLIozGfbTUf+7KX8CFQngJd5q6suOp4w6frYQAuZ+62erkSOkzaU2c?=
 =?us-ascii?Q?xpV8g/3BLpq1vuCY6dik/OD23IoDKoBNfPaBVsPRxj6I6R8TXv7+/7m0q0jq?=
 =?us-ascii?Q?wqpnWsuFScyVYv7NiIhSdyYQFkpUYW9ynD39wEqtmsnd5hFNvgdvLDXU119C?=
 =?us-ascii?Q?VEUTnknMbEvwEw3E9RvKybVIrGnk7wA2Qb41IuUzSE4UDjufGhNQneCJJJG9?=
 =?us-ascii?Q?9Pi4nwWsEFWXg9x0nLbsq0LrjWtiRwCTJuUCG6KSF4Ok77tX4R5LkA+OiltS?=
 =?us-ascii?Q?cZm3EuTKONpO6K3ZAuyrYZIJBIZC4RjT+QvIu4OhPWVYiQDPqmTcqJg/+Hfr?=
 =?us-ascii?Q?BT6qess/IWmk/PKCQ23LbU+kSDLdLvD0vtizhjXF82guYbQrTbKaRlY2q9ko?=
 =?us-ascii?Q?S8QQZVd5wxpd8Zbyn6juW8ZDvsh7kFIumRn+Eg5Z9pmLv7R5U04Y384j64Co?=
 =?us-ascii?Q?onTNzLCNPWla+kZU3iaZGOXvaUtVUgdgIXfsqBq47+RbVCJ4QSFqpBgU/SFE?=
 =?us-ascii?Q?EVDhGw3wslCiiihQqKDSvU0raTR/qFmV2FzpAVAsayocexXdpfckul39bxe8?=
 =?us-ascii?Q?yc/GgZgA9eWTw7y9tE+rDjnK0Fj2Zm6+6HXvWkpCp2rfGKGZdYW1DqXiTa2m?=
 =?us-ascii?Q?JipN3CcyEZ7GRDeE4mKIUwt46Kt/SjuG+H1kKjDXetiGZo5TvbhcyFzf1DJE?=
 =?us-ascii?Q?hLbPjU8l6CfdKxgIjX8OJSeIY9M+7A4N4Y3iGYBIZokUFuu0zsAJNRCjwZHq?=
 =?us-ascii?Q?c9MrCBVCZwfdMtpF/10nLBLefG7y+kSyVANpl2m2vFO4d8LdVe0HY29Qo0BV?=
 =?us-ascii?Q?MUqDdOfwkTwv3K+DmZjLac3AeZjeRA5V+FdC6/wlNUl9dObm0AP7SzTe+FK9?=
 =?us-ascii?Q?8BdA/yvUV03CIZ6FW9SRN0VMZiyxtCf1GRLDsmRczElLL/qkd8pAHT0vYBa9?=
 =?us-ascii?Q?IiodT8BSiwyNtlE64xkpl85yk4Xh4xI5/CqyUxa3vdYR6xvBhVNNVn6rJG3P?=
 =?us-ascii?Q?l8K719bDW/GS1cLdKwGvZcdciiZY+MG+6hVAnCCoD2R9IE5cUMgEHCa60v03?=
 =?us-ascii?Q?/dzOJT0/3UuDDND4OxeeTHySIwyI77VE/aWUYdzDbVZdTgVT+Eub2sthsZbk?=
 =?us-ascii?Q?2ZJiab1ZgOJ5Zti8M15Ku5JHpIcLCK5gqYrk7u4oQYTRiJ3CZv5rwMG5nEfB?=
 =?us-ascii?Q?SBzsPCNFn3PORvHNL0SDWgj/DDQC1DF7ivDw/monKK1Qvq2q7Kib0GfSgNuH?=
 =?us-ascii?Q?vdnQXICptbrKOsU5u/Bm1Tus8rgH4XztJs0r/TEHl6SIHLVE/pl0WBKC5Saf?=
 =?us-ascii?Q?E8O2XrM4nbuIXdmEeqhUcnzl8x/IK2tXd34/s9gT/+BiZkJfiH+cjuI+vC9s?=
 =?us-ascii?Q?tfUmiuklWgkgP7s6sCU+KZe/m97LvzbAWYtFM76ykDRBI1/OG5MAOs8XUxMx?=
 =?us-ascii?Q?4DbOf/eVbX2wv4XWRkhLkfXJK88+BIbgbQElpFHIFO5SK42ofbxbmqz1immJ?=
 =?us-ascii?Q?STYZKJ45HagpKEzNzvdvtU98DqB0y+c0IDAfv6a739Zxwg/s/+so5wG1S/fm?=
 =?us-ascii?Q?pv+giy6+okajoWMY/1rBE5YGZKY7Z8xm48hwO4pijChTBZdOjK7lHIaOejGo?=
 =?us-ascii?Q?5JJr/WTII/mM92i+708k8b9nnc7826PXO+0yZzIrHAKD/IDXv7sERlBvUCLb?=
 =?us-ascii?Q?6ZWz/4wNjT4NjPaYx1FwbBB+25y5Z+8=3D?=
X-Exchange-RoutingPolicyChecked: R3iM5uNCbTrQNpOF0eUSvBL4fd8XehfIkWZBE6r11n8nvAdTokC7fDaJGf3nmhd5upJMjhXWHLoGwQTzEO61Ydc/6zY7Xh20MAKq2h3YRsoYW2syifHOe132pJ9nTXUX/TnDg7Gs1S5U5D+3Eihqvkvo9FdwvL6YRQm0XGouitfTkI2vdSE41PwfEXmSVY52b3HgDmELiOBe0IfW6npenW1Yne5oLVTBkugsnxRElXCPol7qfPYUUEqOc0litL6sZzGzssfn3wj8ZYdt3NB7Gjv2TDPmEg223IAjOo2hjR23tetRUpeSOw0t/fBvBjKtGHMbgxgPBdFcPfYql5CNJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8510d1-b65c-45c5-917a-08debd435c16
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:30:14.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoqrMXp0nCiJU1GRqZ5SMjaqO0TPRolXd+XKkPFmymghdS8InvzImW8o5UCOUIRCfAEMXYdzvLQIAidRlg3Uh41iF9rRgQoX0O+Re4PBN6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com

On Thu, May 21, 2026 at 06:29:22PM -0700, Alison Schofield wrote:
> On Thu, May 21, 2026 at 04:48:06PM +0800, Richard Cheng wrote:
> > Add "multi_decoder" module param to the cxl_test emulator. When enabled,
> > mock_init_hdm_decoder() addtionally programs decoder X.1 on cxl_mem.0
> > and cxl_mem.4 as a second auto-region carved from the next
> > mock_auto_region_size of HPA in the same CFMWS window.
> > The result is 2 committed switch decoders that share the same
> > downstream-port target_map[].
> > 
> > This is inspired by [1] so the emulator can detect and test for scenario
> > like that.
> > 
> > [1]: https://lore.kernel.org/all/20260108101324.509667-1-rrichter@amd.com/
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> 
> Hi Richard,
> 
> Welcome to cxl-test and thanks for the patch and the explanation.
> Before we add another module param and hardcoded auto-region, I
> want to walk through what's already available and see if it covers
> your need.
> 
> The fix for `3e8aaacdad4f` ("cxl/port: Fix target list setup for
> multiple decoders sharing the same dport") can be duplicated with
> the user create region path using cxl-test default topology as is,
> and that can be replayed as an auto region.
> 
> I've appended a script to demonstrate it. FWIW, I didn't know
> this for sure, and was wondering if the auto and user paths might
> diverge somewhere in this config, but they didn't. I was able to
> watch it fail without Roberts fix, then pass with it applied.
> 
> ICYMI there is a test case in cxl-topology.sh that detects the
> failure pattern but not a config to verify it like you point
> out here.
> 
> Your implemenation did make me aware of a gap in the region replay
> capability. On real HW, BIOS programs the decoders, then the OS walks
> the dports, and update_decoder_targets() is what populates target[]
> from target_map[]. But cxl-test bypasses that ordering. In cxl-test,
> mock_init_hdm_decoder() writes cxlsd->target[] itself on replay,
> which IIUC is why your patch called cxl_port_update_decoder_targets()
> from the mock to reach Robert's line. Lifting that call into the mock
> unconditionally, so replay goes through the same dport-enumeration
> path as real HW would widen what replay actually exercises. I'm not
> sure how we get there, but if you'd have interest and time to take
> a look at that, patches welcomed.

Hi Richard,

I've been working in this space, using region replay and found what
I said above started off true about the bypass, but the bypass does
not actually apply to region replay, only the default auto region.

In real HW ordering-
BIOS programs decoder and writes target_map[] and then the OS walks
dports and update_decoder_targets() reads that target_map[] and
populates cxlsd->target[].  

In cxl-test, the place we would need to fix to be more 'like' real
hardware is the initial mock auto region that gets set up on module load.
It is the path that takes a shortcut by writing cxlds->target[i] = dport
directly and setting target_map[i].

The cxl-test replay_path actually already matches real HW ordering. Target
lists are populated from the target_map[] during dport enumeration.

I still think there is a fix in there. The setup of that auto region
needs to set target_map[], but it needs to stop setting cxlsd->target[]
and let that happen 'naturally' when the dport enumeration happens.
There could be some ordering issue with when dport enumeration fires,
so could get more interesting than that.

It would be a good fixup to make the auto-region more 'authentic',
ie force it through more of the actual auto region driver paths.

-- Alison




> 
> Does the user-create followed by region replay flow cover your need? 
> 
> -- Alison
> From 0fcdebae75d307036d83f8b7be971db305b83660 Mon Sep 17 00:00:00 2001
> From: Alison Schofield <alison.schofield@intel.com>
> Date: Thu, 21 May 2026 17:39:51 -0700
> Subject: [PATCH] WIP test/cxl-multi-decoder-shared-dport.sh
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  test/cxl-multi-decoder-shared-dport.sh | 139 +++++++++++++++++++++++++
>  test/meson.build                       |   2 +
>  2 files changed, 141 insertions(+)
>  create mode 100755 test/cxl-multi-decoder-shared-dport.sh
> 
> diff --git a/test/cxl-multi-decoder-shared-dport.sh b/test/cxl-multi-decoder-shared-dport.sh
> new file mode 100755
> index 000000000000..5f15b23f3a27
> --- /dev/null
> +++ b/test/cxl-multi-decoder-shared-dport.sh
> @@ -0,0 +1,139 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026 Intel Corporation. All rights reserved.
> +
> +. $(dirname $0)/common
> +
> +rc=77
> +
> +set -ex
> +
> +trap 'err $LINENO' ERR
> +
> +check_prereq "jq"
> +
> +modprobe -r cxl_test
> +modprobe cxl_test
> +
> +rc=1
> +
> +# Regression test for kernel commit 3e8aaacdad4f ("cxl/port: Fix target
> +# list setup for multiple decoders sharing the same dport").
> +#
> +# Create two user-space regions on the same root decoder, claiming the
> +# same memdev set. Topology routes both regions through the same switch
> +# downstream ports, so each switch port ends up with two committed
> +# decoders sharing the same dport. cxl_test enumerates dports per
> +# memdev attach, which fires cxl_port_update_decoder_targets() against
> +# the already-committed decoders and lands on the line the kernel
> +# commit fixes. A pre-3e8aaacdad4f kernel stops after the first match
> +# and leaves the second decoder's cxlsd->target[] empty (nr_targets=0).
> +#
> +# replay_regions exercises the same shape after a cxl_acpi unbind/bind,
> +# so the regression is checked on both the user-create and replay
> +# paths.
> +
> +destroy_regions() {
> +	$CXL destroy-region -f -b cxl_test all
> +}
> +
> +# Pick the volatile-capable, 2-target root decoder. The cxl_test
> +# topology routes its 4 targets via 2 switches (HB0/sw0, HB0/sw1),
> +# 2 memdevs per switch. Both regions below claim all 4 memdevs, so
> +# they share the same switch dports by topology.
> +find_x4_ram_decoder() {
> +	decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
> +		select(.volatile_capable == true) |
> +		select(.nr_targets == 2) |
> +		.decoder")
> +
> +	[[ $decoder ]] || err "$LINENO"
> +
> +	# Decoder window must hold two regions
> +	# Each region size is half the window.
> +	decoder_size=$($CXL list -d "$decoder" | jq -r '.[0].size')
> +	[[ -n "$decoder_size" && "$decoder_size" != "null" ]] || err "$LINENO"
> +	region_size=$((decoder_size / 2))
> +
> +	port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
> +		.targets | .[] | select(.position == 0) | .target")
> +	port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
> +		.targets | .[] | select(.position == 1) | .target")
> +
> +	mem0=$($CXL list -M -p "$port_dev0" | jq -r ".[0].memdev")
> +	mem1=$($CXL list -M -p "$port_dev1" | jq -r ".[0].memdev")
> +	mem2=$($CXL list -M -p "$port_dev0" | jq -r ".[1].memdev")
> +	mem3=$($CXL list -M -p "$port_dev1" | jq -r ".[1].memdev")
> +	memdevs="$mem0 $mem1 $mem2 $mem3"
> +}
> +
> +create_region() {
> +	local size="$1"
> +	local region
> +
> +	region=$($CXL create-region -d "$decoder" -m -s "$size" "$memdevs" |
> +		jq -r ".region")
> +
> +	if [[ -z "$region" || "$region" == "null" ]]; then
> +		echo "create-region failed for $decoder"
> +		err "$LINENO"
> +	fi
> +	echo "$region"
> +}
> +
> +# Similar to cxl-topology.sh - test_switch_decoder_target_enumeration()
> +# Counts switch ports where >=2 decoders are programmed (one with
> +# targets, one or more without). After both regions are committed,
> +# every switch port we use should have >=2 decoders programmed.
> +check_shared_dport_enumeration() {
> +	local label="$1"
> +	local issues
> +
> +	issues=$($CXL list -b cxl_test -vvv | jq '
> +		[.. | objects | select(.depth == 2 and has("decoders:" + .port))] |
> +		map({
> +			nr_dports: .nr_dports,
> +			with_targets: ([to_entries[] |
> +				select(.key | startswith("decoders:")) |
> +				.value[] | select(has("mode") == false and
> +				.nr_targets > 0)] | length),
> +			without_targets: ([to_entries[] |
> +				select(.key | startswith("decoders:")) |
> +				.value[] | select(has("mode") == false and
> +				.nr_targets == 0)] | length)
> +		}) |
> +		map(select(.nr_dports > 0 and
> +			   .with_targets >= 1 and
> +			   .without_targets >= 1)) |
> +		length')
> +
> +	if ((issues != 0)); then
> +		echo "$label: $issues switch port(s) with incomplete target enumeration"
> +		echo "(>=1 decoder with targets, >=1 with nr_targets=0)"
> +		return 1
> +	fi
> +	echo "$label: switch decoder target enumeration OK"
> +	return 0
> +}
> +
> +# Start clean so we own all RAM capacity.
> +destroy_regions
> +
> +find_x4_ram_decoder
> +
> +region_a=$(create_region "$region_size")
> +region_b=$(create_region "$region_size")
> +
> +check_shared_dport_enumeration "after user-create" || err "$LINENO"
> +
> +replay_regions || err "$LINENO"
> +
> +check_shared_dport_enumeration "after replay" || err "$LINENO"
> +
> +# Destroy in reverse DPA order
> +$CXL destroy-region -f -b cxl_test "$region_b"
> +$CXL destroy-region -f -b cxl_test "$region_a"
> +
> +check_dmesg "$LINENO"
> +
> +modprobe -r cxl_test
> diff --git a/test/meson.build b/test/meson.build
> index e0e2193bfd51..4abad21102a7 100644
> --- a/test/meson.build
> +++ b/test/meson.build
> @@ -171,6 +171,7 @@ cxl_translate = find_program('cxl-translate.sh')
>  cxl_elc = find_program('cxl-elc.sh')
>  cxl_dax_hmem = find_program('cxl-dax-hmem.sh')
>  cxl_region_replay = find_program('cxl-region-replay.sh')
> +cxl_multi_decoder_shared_dport = find_program('cxl-multi-decoder-shared-dport.sh')
>  
>  tests = [
>    [ 'libndctl',               libndctl,		  'ndctl' ],
> @@ -207,6 +208,7 @@ tests = [
>    [ 'cxl-elc.sh',             cxl_elc,            'cxl'   ],
>    [ 'cxl-dax-hmem.sh',        cxl_dax_hmem,       'cxl'   ],
>    [ 'cxl-region-replay.sh',   cxl_region_replay,  'cxl'   ],
> +  [ 'cxl-multi-decoder-shared-dport.sh', cxl_multi_decoder_shared_dport, 'cxl' ],
>  ]
>  
>  if get_option('destructive').enabled()
> -- 
> 2.37.3
> 
> 
> 
> 
> 
> 
> 
> >  tools/testing/cxl/test/cxl.c | 88 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 81 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb0..929bbee471db 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -17,6 +17,7 @@
> >  static int interleave_arithmetic;
> >  static bool extended_linear_cache;
> >  static bool fail_autoassemble;
> > +static bool multi_decoder;
> >  
> >  #define FAKE_QTG_ID	42
> >  
> > @@ -1041,6 +1042,17 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
> >  	WARN_ON_ONCE(!cxld_registry_new(cxld));
> >  }
> >  
> > +static int decoder_by_id(struct device *dev, const void *data)
> > +{
> > +	int target_id = (int)(uintptr_t)data;
> > +	struct cxl_decoder *cxld;
> > +
> > +	if (!is_switch_decoder(dev))
> > +		return 0;
> > +	cxld = to_cxl_decoder(dev);
> > +	return cxld->id == target_id;
> > +}
> > +
> >  static int first_decoder(struct device *dev, const void *data)
> >  {
> >  	struct cxl_decoder *cxld;
> > @@ -1079,6 +1091,8 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	struct cxl_memdev *cxlmd;
> >  	struct cxl_dport *dport;
> >  	struct device *dev;
> > +	int max_decoder_id;
> > +	int region_decoder_id = 0;
> >  	bool hb0 = false;
> >  	u64 base;
> >  	int i;
> > @@ -1129,9 +1143,16 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
> >  	 *
> >  	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
> > +	 *
> > +	 * When multi_decoder is enabled, additionally program decoder
> > +	 * X.1 of the same endpoints as a second auto-region that shares
> > +	 * the switch's downstream ports with the first region, so that
> > +	 * the same dport ends up in target_map[] of two committed switch
> > +	 * decoders simultaneously.
> >  	 */
> > +	max_decoder_id = multi_decoder ? 1 : 0;
> >  	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
> > -	    pdev->id > 4 || cxld->id > 0) {
> > +	    pdev->id > 4 || cxld->id > max_decoder_id) {
> >  		default_mock_decoder(cxld);
> >  		return false;
> >  	}
> > @@ -1142,9 +1163,14 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  		return false;
> >  	}
> >  
> > +	region_decoder_id = cxld->id;
> > +
> >  	base = window->base_hpa;
> >  	if (extended_linear_cache)
> >  		base += mock_auto_region_size;
> > +	/* Place the second auto-region right after the first. */
> > +	if (region_decoder_id == 1)
> > +		base += mock_auto_region_size;
> >  	cxld->hpa_range = (struct range) {
> >  		.start = base,
> >  		.end = base + mock_auto_region_size - 1,
> > @@ -1156,7 +1182,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	cxld->flags = CXL_DECODER_F_ENABLE;
> >  	cxled->state = CXL_DECODER_STATE_AUTO;
> >  	port->commit_end = cxld->id;
> > -	devm_cxl_dpa_reserve(cxled, 0,
> > +	devm_cxl_dpa_reserve(cxled,
> > +			     region_decoder_id *
> > +				 (mock_auto_region_size / 2),
> >  			     mock_auto_region_size / cxld->interleave_ways, 0);
> >  	cxld->commit = mock_decoder_commit;
> >  	cxld->reset = mock_decoder_reset;
> > @@ -1165,12 +1193,23 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  	/*
> >  	 * Now that endpoint decoder is set up, walk up the hierarchy
> >  	 * and setup the switch and root port decoders targeting @cxlmd.
> > +	 *
> > +	 * For region 0 use switch-decoder slot 0 (selected by
> > +	 * first_decoder()); for region 1 use slot 1 so that the two
> > +	 * regions exercise the multi-decoder / shared-dport scenario.
> >  	 */
> >  	iter = port;
> >  	for (i = 0; i < 2; i++) {
> >  		dport = iter->parent_dport;
> >  		iter = dport->port;
> > -		dev = device_find_child(&iter->dev, NULL, first_decoder);
> > +		if (region_decoder_id == 0) {
> > +			dev = device_find_child(&iter->dev, NULL,
> > +						first_decoder);
> > +		} else {
> > +			dev = device_find_child(&iter->dev,
> > +						(void *)(uintptr_t)region_decoder_id,
> > +						decoder_by_id);
> > +		}
> >  		/*
> >  		 * Ancestor ports are guaranteed to be enumerated before
> >  		 * @port, and all ports have at least one decoder.
> > @@ -1179,23 +1218,36 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  			continue;
> >  
> >  		cxlsd = to_cxl_switch_decoder(dev);
> > +		/*
> > +		 * Region 0 (decoder.0) keeps the historical shortcut of
> > +		 * stamping target[] directly so single-region setup is
> > +		 * unaffected by dport-add ordering quirks of cxl_test.
> > +		 *
> > +		 * Region 1 (decoder.1, only programmed when
> > +		 * multi_decoder=1) intentionally leaves target[]
> > +		 * to update_decoder_targets() at dport-add time.
> > +		 */
> >  		if (i == 0) {
> >  			/* put cxl_mem.4 second in the decode order */
> >  			if (pdev->id == 4) {
> > -				cxlsd->target[1] = dport;
> > +				if (region_decoder_id == 0)
> > +					cxlsd->target[1] = dport;
> >  				cxlsd->cxld.target_map[1] = dport->port_id;
> >  			} else {
> > -				cxlsd->target[0] = dport;
> > +				if (region_decoder_id == 0)
> > +					cxlsd->target[0] = dport;
> >  				cxlsd->cxld.target_map[0] = dport->port_id;
> >  			}
> >  		} else {
> > -			cxlsd->target[0] = dport;
> > +			if (region_decoder_id == 0)
> > +				cxlsd->target[0] = dport;
> >  			cxlsd->cxld.target_map[0] = dport->port_id;
> >  		}
> >  		cxld = &cxlsd->cxld;
> >  		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> >  		cxld->flags = CXL_DECODER_F_ENABLE;
> > -		iter->commit_end = 0;
> > +		if (iter->commit_end < region_decoder_id)
> > +			iter->commit_end = region_decoder_id;
> >  		/*
> >  		 * Switch targets 2 endpoints, while host bridge targets
> >  		 * one root port
> > @@ -1212,6 +1264,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
> >  		cxld->commit = mock_decoder_commit;
> >  		cxld->reset = mock_decoder_reset;
> >  
> > +		/*
> > +		 * For the second region only target_map[] is set above,
> > +		 * not cxlsd->target[]. On real hardware target[] gets
> > +		 * populated when dports are added (BIOS-programmed
> > +		 * decoders are read first, then dports get enumerated).
> > +		 * cxl_test's order is reversed: dports were added long
> > +		 * before this point, so re-fire the update here against
> > +		 * each existing dport to mimic the real-hardware
> > +		 * ordering and exercise update_decoder_targets() with
> > +		 * pre-programmed decoders.
> > +		 */
> > +		if (region_decoder_id == 1) {
> > +			struct cxl_dport *existing;
> > +			unsigned long index;
> > +
> > +			xa_for_each(&iter->dports, index, existing)
> > +				cxl_port_update_decoder_targets(iter,
> > +								existing);
> > +		}
> > +
> >  		cxld_registry_update(cxld);
> >  		put_device(dev);
> >  	}
> > @@ -2049,6 +2121,8 @@ module_param(extended_linear_cache, bool, 0444);
> >  MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
> >  module_param(fail_autoassemble, bool, 0444);
> >  MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
> > +module_param(multi_decoder, bool, 0444);
> > +MODULE_PARM_DESC(multi_decoder, "Auto-program a 2nd decoder per endpoint sharing switch dports");
> >  module_init(cxl_test_init);
> >  module_exit(cxl_test_exit);
> >  MODULE_LICENSE("GPL v2");
> > -- 
> > 2.43.0
> > 
> 
