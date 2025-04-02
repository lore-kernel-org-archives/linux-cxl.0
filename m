Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29372155382;
	Wed,  2 Apr 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743631199; cv=fail; b=KsiEfSCp7WfHkret7XerZ7QmqRZkK19WkpsRa+95zT/uyMT2URliUcVqLaPG8aeaYbrNWpV2+rdkmFCpLVWXut214jW6EgE6vVAQARjK0LAW9CfLeWSH/VH77WGPTI49+aFh42TSexXa9IRt+9BQrf0u+dc6bBYdAXcMCy31lJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743631199; c=relaxed/simple;
	bh=3pKDCQwWgM6hZIZVD/eZDYsMTg20AOF8mQiGNz1NYcg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gXqyuK/ILTdL61+W7gIZGzTnzJPAMSx9yOmHbplfT2xtPWYKOGkaXf6iChNzwbt6kUHtqZUgkKaDJVo7z5NqHFHLouC5/nKal8xM8Yp/HMQcG8Uj+J3SCIXidmOOaoaph+Q5jOpnzeh++YtnMHd8H84nHILxv+B0ZmxrQDlD38A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNCyck9L; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNCyck9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743631198; x=1775167198;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3pKDCQwWgM6hZIZVD/eZDYsMTg20AOF8mQiGNz1NYcg=;
  b=QNCyck9LkrHGBQgZeeggLOp2kLf2WmZZcXb+2XvnSuCCWB0uUgdWekxf
   i8eptRUHF0K6Y5JvfPZyQlhr6gjzpy7A4yTj66ss6axyCJIjrl0tRLb1P
   ucyTOND3yfMHg6P6D6FzRP5RW+3RLH8+qDHmFxgKEp5+KeWEZ0cK946xD
   pA5oKc26DSoMdLFGbJdWG6JDuVsU0UF5ETHbucZRGsdaaYifxXE94gXS1
   fTWIyog00n5wfmUK0auJyylMfg7IIBIuWajEdcwL/0asMjFBtdfL75zAV
   YAHS5cZ+8a07M9IqJskXzKV8GkNszy8ufcNgadihKg0ZpHiJybE9PPdMC
   g==;
X-CSE-ConnectionGUID: 8I9SX+puQw6zI1CLwH5Q6g==
X-CSE-MsgGUID: o+sACFoaSBCcnvHl3QB4mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44914428"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="44914428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 14:59:56 -0700
X-CSE-ConnectionGUID: YxKUZdiKSgi5Zaop46waQw==
X-CSE-MsgGUID: NAcew38xSHiNQeEBtgNOwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="126721721"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 14:59:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 14:59:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 14:59:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 14:59:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGyCftVuYjhJoNz05xJ8cmosdcIaf5txI9tsdjb4ESDvcn7C31LPVCU98xDR7R1slDkIk94j91a+0qxtrRCeopQx8l46qpp1wXJtqXyDntvfaR6We//2LeMeQToB8x0YlyabNTc5ZA0h9jLaHP5NLi4btE4nyn1BVAjDUt+BQN7Rs9M8fSFRh/P5a2BpRo1M//2xtLuFh1e+KgU0pLBeLpm/dDgm2O7zkl6j9U1k1K10qVNbQlRJXqcn2TMKHcN/M1h61oC9wFOyM1xn5N8xX0o2gbo8crMVbfdKoAuB5DY4datm8b8ocTa9MADRrnRy65c+TwZtDjJV79qw9zW9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pKDCQwWgM6hZIZVD/eZDYsMTg20AOF8mQiGNz1NYcg=;
 b=xQVv7Lj3SuNdO72cl41Hw3Ko6woly8pHGtfBpeUCYdY4kf9MYmUt61P+bdGcVWcnFcsPh7lVRHOz1cMditwag+AmCRkthCNjaRGNA9OrkXC316qB85ikd60UgxPtMWiZsC1+X8nR0BZ55K5LMMZD7jHT4yExSj4WezApLibEDMCxDh/IaQ0+VaKqonjEvavOpD3n2Bw+L/1VVouWkCGbvmdiquukKBtsDNe/2IUnYYfQVG8bqSVORoZQNWqUCdXy7j3Ut0MVsbsx64YJI/3zJj2mQq3wbOAqAPMZRR3VUsfg+cNhnQayXg8VrEW4787t7Mp97S9cpVyD9n+92JbboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Wed, 2 Apr
 2025 21:59:21 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 21:59:21 +0000
Date: Wed, 2 Apr 2025 14:59:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: core/region - ignore interleave granularity when
 ways=1
Message-ID: <67edb335dea8c_1a6d929437@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250402193443.944654-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250402193443.944654-1-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e07eab-f54d-4187-c838-08dd72319f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NgBx5sXaXefQ2u3haU2Mdr/Xxh+Z2PzsayaUmROKazuqsR+4UJ3UBZgsN7Pj?=
 =?us-ascii?Q?pSXNVZmfI1RHDwFpyaKqs6LuqrRh/fT6CZVT6CDwNZCvfEzl1QX3vV7E7Kcy?=
 =?us-ascii?Q?UTLgtWW28gLD8NoEQ560M84zlAG02QKf1OEAWQR0MNZQiYQYyY1S3nhyL9ff?=
 =?us-ascii?Q?8+I5PgS6A+iqMIfgrr3xn+wA1nkmzkQxTRd4dnVLuLgPLo4DHbVOSG7sT6bY?=
 =?us-ascii?Q?V8cws9E30kH6v9KtxvQj8YI2Cw3bMkRee5afoYsOJovQZYDHeoJjig1P6LmJ?=
 =?us-ascii?Q?q3bKPlS1FwKbWhF9KClD50Fb5rmjP/AIm+ARmBzG7+L3JM6HCADCySlmIWhw?=
 =?us-ascii?Q?DYoONzeGr1ini87arlNL+YrsZJGzVEwFh1n3haCJS+xTHFyam7vm/T1LfqJG?=
 =?us-ascii?Q?UkAQ3QTMjEW3N15hHkoGJIImxx0OS8JU1mM4F0rkPYVXqVsmaBSkL0oT5KkP?=
 =?us-ascii?Q?GkRln4i6SoD+vaVFeBFos75NXurWKoOkC96Q6K6Aek+ifXn7wYQBRvKIMn7e?=
 =?us-ascii?Q?XTiGJX6Z0AntHRYr48+PQJW/pFAVyQPnjJ5Zgx6oUbk67zYDVONQxEHAWC4r?=
 =?us-ascii?Q?ZOKmfaqavRaG4JUmOK1085PFnY0kG7lznmPHwu/XI41aqWJALatnjaX/r/lk?=
 =?us-ascii?Q?FJXasnD5XgDkX2Jmcx7Tz56Bb4uoMmeQ/yWO5RvFROjOOJSGh2C3p7gFdYxm?=
 =?us-ascii?Q?ie3jF8uuG7bTfJw7rfvqDQiJS6jSRJz7lFC+Rcwq/P9FZrkwDmn/0al24Hy/?=
 =?us-ascii?Q?501gRhDPHDCmwdgaZiZ8ODqlRQYTKUxAeOfbnrAYpoiWMb4J9x40qxqHam0+?=
 =?us-ascii?Q?i+jMwDXi9jqF27A2Fk8QXWI3ABsPLclnH5zOvp2onGvaTK7OdinIzaWf5l3B?=
 =?us-ascii?Q?boUbShIFrHUB1Me35xrzZlj7hLHG2vKsDXt9BhIoLUCGpFTOyMBRc0uJgThS?=
 =?us-ascii?Q?fhKrjYXl6lLycoqPmWhMFJ/k59hKZWKvI/s5EkLO6TqEwMNPoa2ocwysqMhV?=
 =?us-ascii?Q?EqNiWNQpRT8SkykMphzKx+71kwAgdXXlVxtudFEV3u04gluLsOH8i/LdHFq+?=
 =?us-ascii?Q?kPgxjQGgVFZWhWaU5n0SFparU+k9Yuxrw5PWBQxNuhnKumcFcfoexE51/Epa?=
 =?us-ascii?Q?0t8msQkbFeikXsH2kqhUcrg66221GOuJXe5udoc5XOK3NBZgAZqRj/ZBPZad?=
 =?us-ascii?Q?D7/CN2LK58XUJaN9CTenpSKHpu3jZf5grksbSWBOCHnrTRe+G0E0la8HmdcB?=
 =?us-ascii?Q?KSof/K0ctSdLKUy3kFx1wxUzSvwr8N6mmoLj1k6JrbrebLW6LTUIwKdof6Kn?=
 =?us-ascii?Q?IIOkhUluQhK9XNd+nIP5xa3rtuZ24Q/Q749W7Fsu2b8zNWIvSy2f2Bj88Js/?=
 =?us-ascii?Q?+Ddw1HfMGOHRgkAWfsyM4itY++5B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GYwnE5GIP6/8t1LkpJqeRxmP9F9wV9Do7Kj/+WNubrjM63G8Z/WUAweyy6tz?=
 =?us-ascii?Q?dm35uL3gno0yfdIIjydGEZGNlhE+dbw755FtnAH76hYS8vhqdwT4TKueF8jW?=
 =?us-ascii?Q?waqCywkk2+nsWkv8vnZgqZd+P8QycIbDqKKiF7/CYichiSzMl0ccY7LPzZov?=
 =?us-ascii?Q?PoJJj//1VAmSIHOXsHGKovZwfr5dZTezZ8hYKT+rEuvEJAL69C7BtTkNiMEb?=
 =?us-ascii?Q?FTQfcpP31lSx50xkH5EaZrzZHKm3lds/a1NDJIfSYZTUwv6H9ufdL/8tC0NB?=
 =?us-ascii?Q?Ig4E3OKA7yD3Z0q2Rnfo2GOwl4zV1oxjs7ePCxXle2H6xdN5v2MHEOO0sUct?=
 =?us-ascii?Q?locEFqN/utmZvl6mTAknbWGBm3CIAeVdzfiZ0wIeoH3PxtqQrHUAWIyb2fQo?=
 =?us-ascii?Q?N61xGVxk2lZT8ekhWzzkJ9z2iK6/8aIcVzllwyBGGRpW7nRhTCrFk86O8ZRX?=
 =?us-ascii?Q?jFa4MG0WGJvF7y6qs+w0NXqnnXB6iJeNbHrGYISF7xnHaTbBcnJDIG8cQ3+3?=
 =?us-ascii?Q?sTLCCjYYOyYu9YiDHdKHALkq2+e7Q1aVCaNaHwIIEX/nzHhBHEUZoPzt/yKB?=
 =?us-ascii?Q?P0OIxdgWqViF1zqSYjjZTm+3VmtC8DNbPKreSAVDfF5EHgyzGWyaMJIIgL38?=
 =?us-ascii?Q?2Mh21caQ7aqYmlM5aZstQbEzV3F4z1wBFErvuvIdWk2qC5DEr9zRKAN6YexM?=
 =?us-ascii?Q?Ei4GJ6/MJXQ917SmHNHcpoEUxB6ZYIMAdBMLJl8ghUaXL6jCcyL97aB7n/mz?=
 =?us-ascii?Q?2mE+mWB01UudOdhktyBJ0UTYGXYx7notTfntbWC+E33j4oXGXoRacRa6OrD+?=
 =?us-ascii?Q?eWhugUR2VfizIlergGwliqqidak/FL+55df4aXaU3+SFwQ+DFZBFW2xE7ifa?=
 =?us-ascii?Q?S6g6k637z1n8mR8N5JYXpnUa32zEqN64KK94naFfYcL0hQmXyEIEvXvjm8lX?=
 =?us-ascii?Q?2tueqvxCz1Exk2IUZWludI1VI8G5ppFirDttswghh4XHDpsnB2BQuLVEbF5o?=
 =?us-ascii?Q?2VvVTghIf2gMz32nigNXa7w1EA/Byy7+ecLv0k+BRpGuP+fKqdyrX1i8x9Uv?=
 =?us-ascii?Q?MUaDB6qyVfvjgwV8HtD9spQTb87w7wX/F3Qrvz2v3beDo6Gsqp0On5n5aF+z?=
 =?us-ascii?Q?UYAvn6Q5QxPxbQma+rhyJw7s591MG5sU9hee7p4Cn1Z6MTir8PKkkXMmAZLI?=
 =?us-ascii?Q?dMEiSByiYYYjK8X39rj1pVGTkfh+erccGjJRwbS5Ko9txydZLxRj/lNoMsLX?=
 =?us-ascii?Q?Fvr6mLgKlkqmfG5y3vvRlihdQVRSK3b0zkmyycV5WOyZWd91qu71PPtyaQ+l?=
 =?us-ascii?Q?pVyhZQN6nhyL8o0UY6vbH1rstFCl6gqDmom55Ppo+n+4cxtD7cJWE7Hn9Dop?=
 =?us-ascii?Q?HpW2OK0ItzvnxDyu0iesVPha2ez1tTuSTH7fndxnLgLKahWMb/oMdU8JSpwA?=
 =?us-ascii?Q?paENaJufGtinYBPrIb4khyECm9UO9+rb7OSSDMdk9jdPbsPBuCZ7nBUav8wx?=
 =?us-ascii?Q?AOHjsuLnBsqV937RDP+KVt2x9kTWqSIJ4zs72NVhB4SjF8n/G3yfcnCK2fjr?=
 =?us-ascii?Q?iSNCRWCaU10nAVlj5AzYiN3nO3uZuma5fY9SabbwkinuBQQTZZZQjATCpR0q?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e07eab-f54d-4187-c838-08dd72319f69
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 21:59:21.1262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3tjBd9BuhNC4gG/IMpXUsCpYRa5VDKWjRqDb22iKnHTqD5to6ax7SZBOwg3jWyS0TA/aMcgrG/zbB1eUToVXQjCnIa3QxHcKuSsgMd1OS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

Gregory Price wrote:
> When validating decoder IW/IG when setting up regions, the granularity
> is irrelevant when iw=1 - all accesses will always route to the only
> target anyway - so all ig values are "correct". Loosen the requirement
> that `ig = (parent_iw * parent_ig)` when iw=1.

Can you say a bit more here about the real world impact like we chatted
about on Discord? Something like:

---
The platform BIOS on "platform-X" specifies a 512-byte
interleave-granularity CXL Window when 256-byte is expected. This leads
to Linux erroneously rejecting the region configuration of 2 devices
attached to an x1 host bridge.
---

That way distros and platform-X folks can flag the importance of this fix.
