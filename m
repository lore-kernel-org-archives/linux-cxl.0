Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B18F4E
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584799; cv=fail; b=WyEMKMC3B+0ivxYUT44jXBA29CfP71Pr+CnD86rJPiprmzEiIeO5rmn9/sh4g5awFajf2o/WrseUik3HfJCjS9gWU85X55bW5XUoOgbyL0FTVyON/iVV7Jo06pCAetOQjIxMSIEP+544DbuRPduHoVAeKi/Sj+bg0BjKjx54IYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584799; c=relaxed/simple;
	bh=7u1c59EaGUlgkb3b3p/SkQJ0Q7s1nPck4n/ze0sozxE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S1jcZzWe4DRCnQGmihjrGbjUFOKQTwdg2LLymLuIoX0QeaPV6i+UKfrpLLw6YPx8VsTu1PmH7pzZevf0yWwMCrlkWBWAdYW5w/A4KebpQQrmrSSgsHjy13Op/CcVxafwASBvxpXca0zch8QtcyyRzjyxHGj0hpFSQBwYniWKQnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIQpfUmk; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIQpfUmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709584797; x=1741120797;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7u1c59EaGUlgkb3b3p/SkQJ0Q7s1nPck4n/ze0sozxE=;
  b=gIQpfUmkNs0lGq+tEZBOuepwnGCTqdVwqshXkKtaq7Vgn/7C1PwEpSqj
   pKzCD/oPHG6DsIzPsGK1GKZc+Hs+1B8hpa6VPLyaZWttRELvERH/ca+gu
   OlCMe+xAz5r6lPr9e9rKSraw+hqiQ7mef4CL02B48teAB0uh0VGjlkmDq
   B6oiHGFhCQgcH1nasa3i04sjN9Zovfy73WV3OARhLZhTPyuE94EqSXLfF
   y1r11uxsvYLU1wlKKVfwKlgYJ9BhwCpROdwqp6y7QSumHRvVI+YcGQkhM
   Gg0FgrG1U1EwucXUbACAZyVbxMT9QSywx4lrkIb4KEskzexUDfauVJBHG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3956309"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3956309"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 12:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13782296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 12:39:57 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 12:39:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 12:39:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 12:39:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 12:39:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3KZbvrTb9xJ6lMmDQsGyrAvNvBEZOFapUV/9TDKrZLrFfhzpHnqydgjCxjU+wMwCPsGMJIITdVLg4+zo1vumJSbWC3uSZh/HGHqeFQhGeMngGEjfB4o+HEG338TRcYlNOCx438b9QTrUTpuWGYbXgspf5wAl4lQHYqh5tcv82CKWHxjSLKtq2wmQuKSdejNd0fMFi+/iuGkYQUAsMGlOWQByDVI5MKkhxcmrwtcKfTpCiTTb5UZDD8bGALUCV50WY481dvMsODNSwzc5v3pEnJIfYwDQBa0UBnK7C5KiYepB7ya8djBc2lWJ43vrg3M9J1cRevWgYQ6Ch9is80i8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJVNo/H6euE24p4LbCMOfq6c754QiQocLlwhTY0ZvYM=;
 b=aRPctHBD+mTLEfOfeiaFO95IlD+Tv3t9rnov1yEQjHONmOkXmQgprKnyEN7dk+BHfDBk98JM8ly/EYYJ47Sb1wNY2yDX8US47p6zFKKdLLDYF9exV1zbSzYHFi/Yu8O4829/WWVKQYbKhe7TJZS3MoS692saUcoKJWOfhJUbqAM6CTwmVAAGKpQzi0GR6KCbJsJaoVy3eyCh5HgeR16j+kQKOeA+pU2iuNa2ZcFQS0QQCbOWD18svlNhru2UJCQ7XQJjLzEgFWHVqpwpgOn8exbqn30Vt7Nf30c8+4O2gDRS2OBSQPnHm7QZghOALp94MQ6kUf/B3Iqp3P1sYDX9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18; Mon, 4 Mar
 2024 20:39:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 20:39:51 +0000
Date: Mon, 4 Mar 2024 12:39:49 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <sthanneeru.opensrc@micron.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: Re: [PATCH v2 0/2] Add log related mailbox commands
Message-ID: <65e631951ff61_b62b294e1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d793c29-1587-437d-7022-08dc3c8b3da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrAuIe+5dRz1vy72E3lORrBrZMQ0MUHhmSHdO9UCdkZEfvzONe9qTRLCF8N+pw2djKblSJCROLbvN/ZKISQML/T6s2uT8YJhrRx+JpWxlWZmQSOJfMVJRhZ18gltoRyMI4D8q2Bez9BCfuTp6lrh9Mp7qWoFF9lLM1JeuTTmD64yhRf+4I+e8Zqmj4iIypaQOk4judB+u7GdR3SfcA84KQMd+HBIs078wKajxsTq6L9hyZXZRJCN+v6YQF0F7rcbn/DmlomvPnsyW7elEO34wVshVzruXJGz0fgjuojViB09F43o8pr/Fm7dABNTLORmXQXYZMbV1MlK3Cr6n5yy4S2D1OzrkcQmxZu52Y5JV+UTu8jex6/jZ0DLgN2DUPsvE9BVen5fL/i1Rp79yK0XAEIOtdYXkGtjDDUbxlBgCBfvISakr3xx576foeUeV04dpkkvzDEQXJ2Jpl+iMg7QLUdWul3/R3IzpDH9OAfRJHt2onhRWYlpmlTxomsOmbrgJepgaDAH5uZ2jOLjjjS906C5q4rBlpI54ryFa6Cva0k3C/6TB3jsOx13yjbPfks1Vnebx8fpA2qqLGBZpiN9d8W21CGjgvvx0MvgeVCS8oG5OAU8ULlSTIAHfESKZQ+HI63mAfRv+XfGwEMFcwNQbvLh2IE5ABLCJ8y1mU2GQBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqfOSuO5WtR8Xouvruz2KkvECkbSHwb494mY53cNrEAkQaX0R7cTj/EVEDHO?=
 =?us-ascii?Q?MDBVdtnzwowXU+FtSLRc/KsdRRoPWRWFx3kNS4QihmFW19eokivkfTOVajY4?=
 =?us-ascii?Q?9RQoe2a+YbPOYU5ono3NDJjp7j3nYrRpfOmIcTtWzWaQOPdQTBXf2fAje0ef?=
 =?us-ascii?Q?2l8HGTp/lQ32F/o9sLkk1y4bsSHCWm4klyOMYC5j5lrWvqm7X/Ho18hFHZCR?=
 =?us-ascii?Q?vZW/K7XCuTXj8foAJuPeLnN51ZQiCH8t+amUljq57wUEVTYRp19qIPsfavxJ?=
 =?us-ascii?Q?5LAbPp/kOLmvYXItNrlPHs9vV9HGrQ9S/0CtMZu1GtAnFILqJcsq5I3jCAGv?=
 =?us-ascii?Q?yTEzGI2kgAFkxmZR5oJ9bRNOjbVINd+ux6XlmKZQaaoYt4zWXkToEsailODZ?=
 =?us-ascii?Q?Ko1JbfhHZN1e6RWLHLZYbEnbNXiU+igezrAsO+LXEhEkGsvqKLMCW+4xXXiY?=
 =?us-ascii?Q?JEqKn+0kxKPhnug+530MWsRJQOcnoioN+96jKV9WrX4p/Bgwgtb3HZUr7R09?=
 =?us-ascii?Q?W6u/GXiBVVFKKAU8yjt0KIJ+l/Wop0w+pYJgvr9ShYszGDoqAsJAI7Oj6KJD?=
 =?us-ascii?Q?9XO3aKtCcAafRIEyxikh9Q/bgh0dnCLPidazHF7UboDHDErMmZCmZUaRVs3k?=
 =?us-ascii?Q?SR4TAnD1cfc+3xb/iFPPXvUMulUhqL5raHpA/reWWs8Ghk46NDgJo0Drwu7V?=
 =?us-ascii?Q?6aY+wK6VtmEhhkGu65RkR1K3WPdNThIaR/8k5DFVSaLern6UBoYDkvTbN0xa?=
 =?us-ascii?Q?wX0PK4TBRm6LmCf6piVn3QFXZC8zSqsABsnx442ppYzzm9Gir0aAeytYDbCJ?=
 =?us-ascii?Q?ERSLzbRD8KrC7FABDziLeXBswwtsYNCHbdCmEWwQTJ68/OcO8X/Z6lKzkH8x?=
 =?us-ascii?Q?fNxRd7afLDiO6itc4xXpDr+Y5mm1Gfn+s9vPNXxO9MoG3j9vwyzd+UfMacRS?=
 =?us-ascii?Q?SI6z5u7IOz5WSuK8EyqFo17BGoQZgusobkYKkEScCn4gSzXB78CiAj7+wPiT?=
 =?us-ascii?Q?We6byc2h5rY5Zeqf+FOane8zsDeVCBJn7wPTixlPijMWsjPHAhYeNERkHFf4?=
 =?us-ascii?Q?ygNeVZxfU9MdZ7QWoLMN6/4zC5HdxnjcG6Oa2WEg+kql+IrPqottThYD2CLQ?=
 =?us-ascii?Q?LH2IvPFH9Dingb4tws8+ZqOvEzEvvjMsfwhEi+NT7CsuFVZYROoxxZctWBQz?=
 =?us-ascii?Q?oqn7cWRQtvWAVyRNGoKgP3buX6N41Im3btESoSQf6NCYv65MWmxOhmNbB6aU?=
 =?us-ascii?Q?HoIG6FJO/VRxncHAjxDDqoRvhDfvyMuGBSRVrJ17QMpRpik3PVA0S3JszPmO?=
 =?us-ascii?Q?1KbUX1fhmTKnc0HWoreOfy5XUSGmJgobGNuDaSybrqTq7JkCfa7uDW2w38dS?=
 =?us-ascii?Q?3OV+Rmby6vIAtGKo6YA10KBoOk9tdudTckVcbgrROCytblLVsaRUc56AWPXO?=
 =?us-ascii?Q?4csmGzr01XvR/7ronJoP4Ik+yY/aZaa2HKrAD987yBjV68fggNv/DP/ucDg2?=
 =?us-ascii?Q?Nm5y2WxKKOwXI7QLoAtH1DKsGeIBZ89ckBxEkSz5FkSWd8l0TgNRloGI1TCr?=
 =?us-ascii?Q?/h5n3ai6H8ifq1Iqware6W8UJAsv9A4LPbyNxSD6xdFg+Jw+HpHdUhLwi0dY?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d793c29-1587-437d-7022-08dc3c8b3da0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:39:51.4469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9sWS8slWQ/t+syFI67569s3Nw/IlQ7RBEFSviVzP8f+N3PW4wHtYmy8qNeVFlielFkPNs86bIqleJsiH5C3tz9M0G0r8u03sRz5mZv4Bvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
X-OriginatorOrg: intel.com

Any specific reason to include linux-mm on this enabling? I suspect this
topic is only of interest to linux-cxl. Lets drop linux-mm from a v3
posting.

sthanneeru.opensrc@ wrote:
> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> Add support to expose following mailbox commands to userspace
> for clearing and populating the Vendor debug log and
> Component State dump log in certain scenarios,
> allowing for the aggregation of results over time.

What is missing for me here is why the ioctl() ABI is suitable for both
of these. The Vendor Debug Log seems straightforward to enable via
ioctl() since there is no background operation entanglement, no
population complexity, and no reference to other payloads.

The Component State Dump has several caveats in my mind for ioctl() not
being a suitable ABI:

1/ Populate Log has an unreasonable expectation that the submitter can
monopolize the mailbox indefinitely. At least that can be solved by
Linux only supporting automatically populated Component State Dump logs.

2/ Automatic log population requires the caller to handle races with
auto-population. The kernel need not export that complexity to
userspace. This is not fatal to the proposal, but it has interactions
with caveat 3.

3/ The Component State Dump format wants to reference events in the
Event Log, if the Event Log has been cleared then, per the spec, the
Component State Dump must not reference the Event Handle. To me that
implies that the code that clears event records must be careful to not
destroy linkage to component state information. That suggests that the
proper place to dump the component state log is an addendum to the
current trace events, before that code clears the event record.

Something roughly like this:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9adda4795eb7..498b2a0b3e76 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -941,7 +941,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 }
 
 static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
-                                   enum cxl_event_log_type type)
+                                   enum cxl_event_log_type type,
+                                   struct cxl_component_state_dump *csd)
 {
        struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
        struct device *dev = mds->cxlds.dev;
@@ -977,9 +978,12 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
                if (!nr_rec)
                        break;
 
-               for (i = 0; i < nr_rec; i++)
+               for (i = 0; i < nr_rec; i++) {
                        __cxl_event_trace_record(cxlmd, type,
                                                 &payload->records[i]);
+                       if (is_event_referenced(csd, type, &payload->records[i]))
+                               trace_csd(csd, ...);
+               }
 
                if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
                        trace_cxl_overflow(cxlmd, type, payload);

...but in general this cover letter needs to comment on the long term
suitability of the ABI.
