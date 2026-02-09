Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD1B672
	for <linux-cxl@vger.kernel.org>; Mon,  9 Feb 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654552; cv=fail; b=CMmjy+gnn9nYQykh5c8cfSpdeL4dgf2KMp+JSVnTwTp2tB9jIR3XSb3jBgEz5ZtEYEOq75yE9PT0G8yz4FG3Hxt5Wbsq6SEwq3dHZJaZJreiIsrAhiqNavNAw3iKQLHNox/XzBcm8s66MM1Eboy4LAiHoybrRuaXGxwtuqUn48s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654552; c=relaxed/simple;
	bh=9X/74O2is9Q4Ns1+YAM3IQS6Nt3pXiWZgqIphDXb3JM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vE3a9R7+AxV/AuUDQFSmJSlfwnXPhOhcKu72LlpxC6IUX0wrxYsyPO7zjWW+PC6BbCbigk25T/mhd/FaQlXjCBaFp52hPoXx3ugCkqMHWAIrH/Plag8aABFP0bdAwteNc3l37iPq2rz9aGmLu1m04nCSA3S1ty52ZOl+vfgkwNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAQMj6PJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAQMj6PJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770654552; x=1802190552;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9X/74O2is9Q4Ns1+YAM3IQS6Nt3pXiWZgqIphDXb3JM=;
  b=SAQMj6PJF+jXw7VNJadqkeKX3APGVKZKRIWbKZA3yV4H7wMizNzVUcC2
   y4iyrO204chFgZAyWv/7hh6Rhk6hkOO9wrldNWAz0cCriVVdpPehMGL53
   Nrwx8wrM68wnq8ACO3EkOsRlG9xG3i8b7fTfCsnO6PCenxLaMcNbwxsjr
   1rgz1DB8nAXfWKeorE5K04Fl6ILhUMZAorGuAI2S/WiRLXBHSGKSDCGba
   aqD8dAMz0qfWo8jhR8YLDnzJnwbpHIDlQd4U2xo+67qGx20ek4DBnBs+r
   bFaRc4D+GllnsUDYY/jcsjhZiLtAZJDqTq+K5cQyTZofCe6j6xSnp+ajZ
   Q==;
X-CSE-ConnectionGUID: ITsAjxfhTruqy/0LaF4fCQ==
X-CSE-MsgGUID: mPVygRKcSx+BCia/GfUeng==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71660493"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="71660493"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 08:29:11 -0800
X-CSE-ConnectionGUID: r+Z524vASmWX7F6AaAeNtw==
X-CSE-MsgGUID: 7aA4g/AgSPStf00f/pG8ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="241753929"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 08:29:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 08:29:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 08:29:10 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 08:29:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMGn+jk89JhlZjC0/2hcXlExUWU3AoneeQ6YzYG8EoEtqz7pk0MSfs9zQbRSNjidznmeimZwgYVgce01tv+4mP91sza1qT5t70gvvEsuvQ3rrOn9BfYq1bb6bXpsm+v05PUW+F/C27CqdUyrnC8TYnxxAdoCRYBBBVjpN8YDhHVSwSBvfWRkyw+LRX1R9Dl5cycwmnYT+ZYWUSQGEKftqW9tMuludHSxYRR4aix8HPrk6+eTmfmE37/xOwv7toGMjH3mmOomgGtG20kTKwGxUaqScdnAi0FDQxXPyRDnAH1Yywt2Es8uzPvMlk3tVdNdl5UoX3BtLk0UhSvOVozOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGfgJCxkU4KFla88EY7/Dw+KbbeZR3Fqct7Irmsztqk=;
 b=iTosVLP3VqWtbBjbEeJurGUhpT+qkqnghWy1tz7mswyDoDBN3J7npcCm2Mwjji/AMoO5fLSRGMt9dZ9BYB658XfDYetwV5Dw/Trpsfb2W8YrETEx1hRgLBm0hBg9eTzVClQK2Qwsl8nKyw0CkH3YFXgmyXKra5A8rj16QRFiYlRvDWI43TxI+hxNhN5h80XhzYfFtPABJ9kjYMeHJVU+dV9xeNJdzFeYKgDbQIe+kk9+2JgK3QZutFAINe997KrvVkeVvq3K3V/o+zdXz7ioKFDCDHCMxYCBz3goQPO4l8MPrQQEbOmxf+xGRe/8HuPxMA3dpHZr6Qc7bCYnNikgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 16:29:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 16:29:02 +0000
Date: Mon, 9 Feb 2026 08:28:59 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Test decoder flags as bitmasks
Message-ID: <aYoLS2u-EJCdOv6K@aschofie-mobl2.lan>
References: <20260206181404.1025991-1-alison.schofield@intel.com>
 <af94b779-4feb-46d3-9ea4-e14a1308d0da@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af94b779-4feb-46d3-9ea4-e14a1308d0da@intel.com>
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f97fc9-c0fe-4bb2-6700-08de67f85618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/T7/YoHrFjL0/xexG+gwCMfG+0rMRR0jQdGsDS5x/yloUZBRb6lSGf7DycWQ?=
 =?us-ascii?Q?JJ8J4yCF6udP3eseyoWckNkeQ1rkPkwhApcm0a7eDmoqtHx8FysyeCViw2Q+?=
 =?us-ascii?Q?wQjNhw6LtT6RMBqdfMmNFPaTz14G1Tx/HFA2/ikfANdoWdflxsFD+Ch6j3dz?=
 =?us-ascii?Q?2jHNlXGOcBdceSumT3Y/Nexo6Rjtw4ouPxboZPE61v6S1K9nmeuXGMNNylDl?=
 =?us-ascii?Q?ogSrK9i2nzqTgXUWwcUjQX8RAcqyHRJ8bdkacB7222rtHioQbf1PDf5X+VwG?=
 =?us-ascii?Q?WqpnbkjJNlVlSzwtQv5WO3HwsRRtsJJmBiX7gCsqZsqtOXa3YGL3JMqhrPQ8?=
 =?us-ascii?Q?bH19GT59JN+yqQkiXw7mTbVU/Cx1qJ2r9JLfJlzHwXyFQAdFd0o2XXRdiTWE?=
 =?us-ascii?Q?neRIbz2Uyv6uZMH9SwwHJo9RBL4nIG/iV+E1kAgwGT+RrK9TgeZZUjeIJ2yV?=
 =?us-ascii?Q?PiiSq6lZTbmp5PFz/LibMIJ7oiYCZOcsBm5PAfZojt7ldQd4NSbS4N76DYU0?=
 =?us-ascii?Q?bEwIGybXHhb4PPeyoXYkA7hBSAAZiboPqwa5YVMewSPeFbZdtDj9N+s0Z/Gd?=
 =?us-ascii?Q?520RDqOEOcNuIfqWjitldvW+/XIv4tuG0ljlUzjkNEEl1k+QIZVdnUo+NGu0?=
 =?us-ascii?Q?v0BTqDbWVTM3pZm88kunutO/NHzwKa3fFSV8vJxcYAQXUM5vQ0CUcGcb9gBA?=
 =?us-ascii?Q?xdUoCjFAF5xIWaXeErHzq5yiTKLMcPe/h6lfXtuyVq0Xao9qJnJKpPzCVYIL?=
 =?us-ascii?Q?vmwIrQg+O1ml8znHCfnJqrAo0tqs/S3cfFRJfr985wA+rAo9EKzJ/kKrtg30?=
 =?us-ascii?Q?SXC+NA/KgtXmRNjTC/m08X/764AZqgNjhJa+rVi13Iv7an8QPVTD68PCC4fl?=
 =?us-ascii?Q?0liqR021k8kCyJPaVVA3Wn7xF/T0hlA2oGuwBY4D3+3rccvqDuIXPW88sIZG?=
 =?us-ascii?Q?oMOjVBWNyMn+CdU6xoS1aNUVr7bALzKsqkE8Nv19tFGppllsFyNRgi/q0feG?=
 =?us-ascii?Q?Cet455IKGoiL7s9PT78wro8KtkedGqu/igwXpsoykR5Gvlpu6nYg0zP3bqp5?=
 =?us-ascii?Q?fL/nD0Wxswmh6RY+Hja1qDdi0KzUDZZUXpDPZuOIf6yyjc7+1LUi6G/b9x3U?=
 =?us-ascii?Q?ghbZGizFGNNaPkpj1wVxHEoyLbKc6B4hTv6RDnr7HLHVVpXBOxgOAGvPtcxn?=
 =?us-ascii?Q?mEfN0PY8S12CE2GF7mptiKSCjQmaLlD/hZWRiOLpBFeNApuRYGHpF8HtHJCt?=
 =?us-ascii?Q?8R6vifcBUjSM+QjA6UPCHRJt164uclYPVO1Yww9mCKufn1y0KmKbu1w/Kxbb?=
 =?us-ascii?Q?hWie44bZJ9dNbcKDg2hTyDB0gBLVuY8K4DUK9YfJ6izbLO1EGAlCuXbAYeqT?=
 =?us-ascii?Q?h1Nep/v+uFAsWKOOA+zXct9GaUZKyfEIvL8Yoo6zVhhw3rbpwXEfKHHqP3Ct?=
 =?us-ascii?Q?6WY2O95/rzG65dsD04/jBJvUlEm9tcK92fKVyMVgqErIbMheW+rK/sdaAFlI?=
 =?us-ascii?Q?nCoYfcbLDAiwFGCcbVFPdWEzOK2xEIMq2TF30pg1rmcCXJX+hNoGauM0D4nI?=
 =?us-ascii?Q?P0zNKMRtnYqhCgxs6/g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8bKnlvJI1nHrCihZ0yMm7ZlQ6hVX52FwDrdV3yB2LDuKfqhHtbPvE9xS8NO?=
 =?us-ascii?Q?V4F7l1x9ObjPgcKPwQ84PGAh2fCXCWLaMQMu7k4wIEIQh9vscSZwlMN1pDm2?=
 =?us-ascii?Q?/kr4mB6pIc80m6mxFN5woEs8X03ZvQ12b07V7rtfkonA6yJiuEgs9vfSEBCv?=
 =?us-ascii?Q?wSdTGhdLwA70LcrEvaVRu9g89PBL9+ndnlQlYjE6Ylb7es2M7dLm/KdqQzso?=
 =?us-ascii?Q?cOPlZg3wlK5kpVeNlWfwd5pFqLbfJJkrBTguJNDlWj/OhBei8dg11itJuVpO?=
 =?us-ascii?Q?RyZ9n2yZfSxbp8Rq+gEzlAASvJ9CXPcp8C3uGngjCnaH1RE0Sk9pqcGPGaZg?=
 =?us-ascii?Q?MwyFJdlq3ng9lzYp0CAmUD6s1CE5yCyTAKjPgQEVbCZJR4l9+GvW9PMCRjIa?=
 =?us-ascii?Q?sI9TBpnR+EPkDddfBzfIclIEFM0Dui3Z0e2z0v9r6LZV0COhNv8IJ716mydx?=
 =?us-ascii?Q?KhtFtHW8Az2WglHS5Jbl4YrdwJr6JTK5nn8GYc1qfvDvKULzpJAB273Bf7OQ?=
 =?us-ascii?Q?ghd1wrcwX8bGWFRbwRSHX/4wWpDnICLVcIYtkMH/zssrFi/NgF3OWLrxdjnP?=
 =?us-ascii?Q?oON6nu4Ilv6Y07FW3WeYMC78kTF88UUbI3gAc+GKdF7pSGWsRNPEh+cCyWzi?=
 =?us-ascii?Q?XtxHmcSh6/IbENcxscpeLObBdOYzyQ4O4s6i2ayZyYWRV6LGw56HNB2TgL+R?=
 =?us-ascii?Q?tFXeRdv6goZMFV4ebPBv5pHxLXota/ONlqToDT2qrUJiwiPSDaeg08irJPZ6?=
 =?us-ascii?Q?oP6d0A7lcy+zX5tyBn71ZrzLHE6iAlJ0k/QMJLV/7mhWA2AQQTbX/253mhSV?=
 =?us-ascii?Q?nq9VWAHCy4o50ESCJurkQLronGkrf/DLBneAyXY7RpY8/mutQTxFAISb4/BM?=
 =?us-ascii?Q?Pdr0euBFhMR4BItbfRzKPhG0mBVamQnU/5OWSSPy7maYIf2GmAn9LUlpQmdp?=
 =?us-ascii?Q?kGs4FdxwGtNM8rsq9r+jOJeJ8xIgwmjoY0Z365aKBBNH3z2phvD4nxPXKEzQ?=
 =?us-ascii?Q?mRt7E5+PIAAZ9wJkORPDBD5OC7rNkJvEGPcBZjRWN7G0ELlpbTNMfKwb+UW/?=
 =?us-ascii?Q?v3eqq4TyNFb+/w19jMNJ796Q4ygXqiag6Fiyo5px4HEALqgs/664FSZv9VMv?=
 =?us-ascii?Q?Ku8uR9pSJklFdqF8g8/TD0wn7jy/Ip7xmMhUd86H/1J1KVFQSU0cIPf4xiaz?=
 =?us-ascii?Q?9ohJN1T34W9DeMSlylk0Z51VQOtooeL2YbGGmOBVavlcy89wZdy8J+3XWeRn?=
 =?us-ascii?Q?n25VReuFSqmNkZdJVuLPaDuYdPjomd9EcCex6Xn7zp48IwjSCujkpOFG/XE3?=
 =?us-ascii?Q?f1qNNkLj4PDB36aCLoK+V6xy6msjIDbavhrfIjqyB0ABuVXBBpPz1fJCZmBM?=
 =?us-ascii?Q?brBinDTkol3G1RBdrHP6oi9nbjVePc5l4nZiznQG9kpjDML0GX0mBcQDuEkB?=
 =?us-ascii?Q?6pfZmreNCmHxl4WqvTRoozdwrMkStl5R68gw4ASt4nleRt/+w4qMuBM31LmO?=
 =?us-ascii?Q?HGlCq1Oj6y6lEjwUf9m1jvoKKJeSx9GIZaElXvLex5ox9Q3rfvrxFlsWcz3n?=
 =?us-ascii?Q?28YGMMBm95HqvoYHg+rJKWRX3Cf99XRQ54/ayulfDf7XwI4GX7Wqo9/Z4Dgk?=
 =?us-ascii?Q?Y5ZnrxpPdGwe6FZqqJsTODahjjcQPfVfYaaL6QMBk9A1a1oo83/cxW94Ipzp?=
 =?us-ascii?Q?wJmcctGHi0/HrzZ5hI1GsnJPCZ78/eSkLU0qNv+Cut7XGi1FZU3HnuxnwgoI?=
 =?us-ascii?Q?YHgRQ8dN6H1u7nP2p/95yoQkeuLHUf4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f97fc9-c0fe-4bb2-6700-08de67f85618
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 16:29:02.9086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9VnHXXEJSEhGH5h1OQFsvIaNKQ/QoR4iobK2CcHgmbLW36amMgI7olbe4/hKrVVXLjSnPWgNC1Yqzv6LbDwIx/8Ep4J2e5tJSLm7ViGNRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com

On Fri, Feb 06, 2026 at 12:33:34PM -0700, Dave Jiang wrote:
> 
> 
> On 2/6/26 11:14 AM, Alison Schofield wrote:
> > The CXL decoder flags are defined as bitmasks, not bit indices.
> > Using test_bit() to check them interprets the mask value as a bit
> > index, which is the wrong test.
> > 
> > For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
> > flags word, making the flag sometimes appear set and blocking creation
> > of CXL region debugfs attributes that support poison operations.
> > 
> > For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
> > the test to always return false and allowing resets that should have
> > been blocked.
> > 
> > Replace test_bit() with a bitmask check.
> > 
> > Found with cxl-test.
> > 
> > Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
> > Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> 
> Given it needs to back port and fix 2 different commits, maybe this needs to split?

OK - will do, ignore this patch.

It'll be a 2 patch series because of the dependency, but I believe that
is still preferred by backport folks.

