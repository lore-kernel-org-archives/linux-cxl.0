Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6B241679;
	Thu, 19 Jun 2025 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309482; cv=fail; b=Pn75w48l/pD9ArSEhnqPxFhSD7UdFOedP8dx6o3kBXSP8dIl+rg8hpUDhbdbQ7e/+0wlRXJhDDMNoE6MIbe3SeU3Xn1z94BICALNZ2/Nkifue1HNObjVK6OHlV913H+hRvWokRStmwIFdEu77boOKuHEDP+UStU/qC2oJPYk2AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309482; c=relaxed/simple;
	bh=LDvsV0DGcRDAdp3JtbYKbuQbEZnLb09suAJaoor8vwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQhfXIg65gISNojtpCrWDYUXLBSf+1WH6cZhnaDJFWTgrTS8CxqcM+WNg0z+bd3M5Lb8ja4C4g6iFG1zdI6IE3WH7ORy86VFxwkHyB6fGJnfbR3DeXrZVJ+kZeNlnSk/HbISQwRLVxvp7zeMNfu3wOHcH6hLVWQfEwak5boMEQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mk1dAVg5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mk1dAVg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309481; x=1781845481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LDvsV0DGcRDAdp3JtbYKbuQbEZnLb09suAJaoor8vwA=;
  b=mk1dAVg5DIaCprqxsECLTptkcyU4/AMsofhh3oZU8uZDEX4SGijmuu7O
   9840+XJCN76pWXxZAe27CLoRbVsNwDwp4jaSewtGNLw+3EBkR/b/+AHQp
   rEzkkGCfhOnqW2AafbbkQT9i3N/2lQxt0835xsY3QUkL1z5tuaSJL/dbj
   akKuWisYAgMhzp+ahp+48c6HrU1cLkTSMsnZYnrOPiVrjv24D9kTimfQ0
   sma7ZtC2Ekn+u8b1oAcT+LPWZOAp36cvIbJylyc0PSb/qFHPpYS+7ZbS6
   L60kb9efZkyxoU1zjEkghG98geNElsp+ASq0LHssKgUbwEwQttSKxrzWn
   A==;
X-CSE-ConnectionGUID: hne7M+zmSliXL4JHUWK/uQ==
X-CSE-MsgGUID: 52Vrr3lrTNqiO4jUSgImAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702189"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702189"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:33 -0700
X-CSE-ConnectionGUID: 8uytarNPRYG8dvs04bNXLg==
X-CSE-MsgGUID: cgYIiE1UTtic1qjGFsujlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="154413090"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/fnt9/1iEDZ24DMe9tShwCVZXW4hqSnRAaaQcDUZcXMhd6hAmwN04MMd7vSwn7Kgki19Ghiqhbcu3xWFt0v9kG6j+aBCscCEKGqo+05foPxwBWQvubum/kubCNRIpbkntW4f3a35kTUtS6BeQ7GW/ObPzZjD/9U9LSZqdisLMn8vZ8Jx+CnrQIkYOxP9jXJp+54jyjs26i+cwjn/K/UhLWOlUb9pxpNjipYCu1LT9Pa9Z0P5KHvGuvQrUajkPKKaO11eD/kqh4bWAgKjyhRRvXSNtCLR2qNcSo79eisG6kA1JZRb4BXoIhAc1YNiQp7Rm2fpiqRAIPTICj2twWinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhKcjLIdZ1mz9Pq4aWSe64rXB5Z8OmgL0uNNmDF+kI8=;
 b=NE+V9i0QGejkbisJD+ZHXYp374lxW2Zk6MisS6RmTh35ZZNxPu1zgfXKcDKNXyb0kHeT7YAdP6xELTkhD3x2OxzBK8It5iyhAsSqYpteDNYxcKbp70qEQhDjJthSLt0gLLUDjlihiPV3vRDNBKcJwWLzR1Xy2SK2ZjDv9f4LpnV7RJ3AX1dmdDHyLlB4Xdm3vHwb/0LZw6dfrNUxC/wiGwwgGwAjrIYHG8RPxUpS0BnpuBG3Dxqd9K0wU0ep/NnqSdwrDqCJq33G0q34UJYel++pIYiZXI+p266nDa6Jcb1HXMRwG/WCTSJRWvWNLqLI+MK/SxRRmaXf8Pzc4IDSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:22 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 2/8] cxl/mbox: Convert poison list mutex to ACQUIRE()
Date: Wed, 18 Jun 2025 22:04:10 -0700
Message-ID: <20250619050416.782871-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bea30a4-265e-43b2-7882-08ddaeeec0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SsaLRP1oWRivzZyts+QMdyEBXMRvaPa1qdOvE1Tuh5FT0OS8T90K4G1HjgFY?=
 =?us-ascii?Q?d4uqqK6sPoDwnmd8ZE2Og10AA5QpQqxUEdnjfg9XbCUVzxyqG8qM2lEqPsr1?=
 =?us-ascii?Q?vyzomzht0hU36Vh3XEPseAPbhhlfaJSgqjrGvhAHruFehVl5clfOf7QNkA/v?=
 =?us-ascii?Q?xVpYGacKce6sN5r6G7i726MIVotREwctfHoZ+weCKHkxQhFmckxBnTb3ZJDx?=
 =?us-ascii?Q?9Xh0dazX2fEhdw0LcNswEQkDs9sWOgVcU0LkQ+1DUQv6xSuJay84Ue8FyQUo?=
 =?us-ascii?Q?Ip0W2SL4+5TqQWypIAOJSlDAtQ6wldacfAhXS5vrisCwAZtBFWRGSW2ypY2x?=
 =?us-ascii?Q?FQ6B8a7m4puLPhDlDC/3zRlJhpTlupi19MTXL122vGKFzyU3+ECCTu2CLVqP?=
 =?us-ascii?Q?lgAbM9RxHehvXTEpdw4/awxv4cqN222jKh21J6a/1Xg5ZqaFurd7q7Z9QzI2?=
 =?us-ascii?Q?Ti11jKWdPRDz8JN2UHxtb8t7O+nwQ+nFWHrMg3t6y4Gx64x7FSRC122AYtuy?=
 =?us-ascii?Q?NfOauaeTlW7FBqPVD3pPzVuOy/LjvNcOdgsSliZdhR4x5BLBXpCGsxLhlMjT?=
 =?us-ascii?Q?owthuDk1gFT+Kaz+Oxn2tME5I/wDKEnOCM+3sPnYyRFz825tBZrPmYK6fZyy?=
 =?us-ascii?Q?EKrwR1MY2ZgRVnasEbsPT1tcNGbk5X8fR3Og1Z5V9yQ1X3Yu8cjdjh6+kP+s?=
 =?us-ascii?Q?doMPnVJoG6Ho1UyNmRHgNEqnk9NuDi8KattKjlKtAIOBG8B9HjiNkOfWUZuK?=
 =?us-ascii?Q?tVLq9+8TqrX0A/jdUiTGBFm1QId2ac7MrJAir+7FcXA6MY9QciUpXSSFcMzZ?=
 =?us-ascii?Q?q6vAki5K/npF4P6mgiU0ED2+k/rAyWZr3ws/gVoT5BEK/HWtlW2htlxKnjaV?=
 =?us-ascii?Q?JgwtyM9ftJjRWehiOwUuIoZBaZN/vSjAvHVCEpTh/KJ7pGoFIPVtol0ndlct?=
 =?us-ascii?Q?9+6o5TOfvMztGPiHvtmUOsCSr1qAGvRRIC1QLQ9cTD02fcMPzrfm4mPLylBa?=
 =?us-ascii?Q?cbQ0lMzD0K9uC+/LEwLHMN1Xc4A5vPL76Z2PExLLT1IU78kqnUUA1gGAb3P+?=
 =?us-ascii?Q?ZwUDu5N6iGIS8yHjcBftLFWbApyBbR6sUFOAcdcGPaTWHPeqkvb+5F/wfmj4?=
 =?us-ascii?Q?jKrS/7vuC18jPMSS6aaxbXOQCisjHTsFlqONCTgxD74k9z6NPc0Jc8sTYJ6m?=
 =?us-ascii?Q?ISKS8jI2f0IJrozgujYsMMHo7decJEkIMovplVGUfkVMpIXUQY9rJ9hlAhDN?=
 =?us-ascii?Q?beVtLNdvLKCRJ8P7Cf62PDbh0EptB7isGyoluE43pAVJOPHslfazKGOZv7tq?=
 =?us-ascii?Q?sREz7+3IsGSu+smQ/l71jbFXqX2o84a6r6KVgH0mq0O1bS6XaJHVrLVHO0aG?=
 =?us-ascii?Q?VHb0P5Fo3PGDhytGl5NdA4NlkJAR530oiEmoXqW+hf++6fqgK2FmO23Y7KCs?=
 =?us-ascii?Q?oxriHugCLQw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARtz3eHXJYbF723yn/kEiIsrjc66h2NMaFrgutG5xTU+1uBPAi4hQBXeiDQO?=
 =?us-ascii?Q?p4M5LUkeKBqsyuu1JyMPaIJMkbnOIkwdFEKeML91kTUa3BOeEkVZOLG8cVa1?=
 =?us-ascii?Q?nhWPRnuu+brOSw1JQmPSogEt08oYOLqH4j6kviA6kw9m5BxAkXzL6Oop40Go?=
 =?us-ascii?Q?nGKBU2Uaj2upwFPaSnpOCbwER+q4blekmkemyUeAIHGZt8EHbbi2Qa4yFhxe?=
 =?us-ascii?Q?fofufkhsH9njvqjCMXb5xBVe0OaeC+PZSCv6UaDrcotUvn3sqnmDXR8mke4P?=
 =?us-ascii?Q?T+PBXcquajVIhxVYJEL7JPFS7MTm/cESC3BetLWJ0IjsK/n6H3SYeZaCNLok?=
 =?us-ascii?Q?mBYvVdG8iUUkhGKet//hinuFv1yoHnufbz2pw41s42f3/+L8T1N7HwDGyMFE?=
 =?us-ascii?Q?EBNpSFDtpY7eiEHr730pHn/QT6tTBHEUxyH6JdY99LQclHDabWvZveGCe2mD?=
 =?us-ascii?Q?AHp7VfGOK+53BLfWVwJtP5R32gkz9ZxyYMEUNIhnuG7yg4p4KNz3wQTNQNFR?=
 =?us-ascii?Q?ktsvzch31BXNf3uyC2YF9WUo/hueqd+utJHFeZFgETLZ2e2HAnRfYs+WuZPk?=
 =?us-ascii?Q?FPQMgN5fA/T9SYFgeS16HkBofdIV2OTmiJIoWbEnrHAgoZux79byHOGnpM+T?=
 =?us-ascii?Q?dvO/E4DzOBXI/hBrpHNbEZ36lCqwSfRNDie+neayMT3LoIktKM1nq/nBvPgz?=
 =?us-ascii?Q?UsPtZZ32zn00BNc3oo7afEYvGOSM0jNDD/KXbxTd9ppMYVklB2HaFVnaX2B/?=
 =?us-ascii?Q?JE3zU5btGT9USn3uZifADI/Z4BRAF2B00KKnghyxkJdQE3gAv4hnXXPueTSa?=
 =?us-ascii?Q?Js5/WczyFIcoW8rB1Eb+H/Lqa3RLDlcUkpgTZsUzRYs1HDa0jS6Py4+rKZ2m?=
 =?us-ascii?Q?x2ktbHK3nx2DMuAPOB8wRpw+F2s9dP4Q5Wu2BLKQmooqjHuQ22WNyUd09/Sz?=
 =?us-ascii?Q?ZoYySRQ06poP7qfScNDQlt4v/rx7H4xxMzeTfMd6m6FpNWInDcK6W8tpLTXB?=
 =?us-ascii?Q?F+zW047FK767gR/uYxfl9NVDvNkhs3NMGxHEG0BT9RyxB9r6rCw7uvjNZ0+P?=
 =?us-ascii?Q?1OvsTOZyr89tyWCmXeefr1UOlgq0d1tIwEbxYcqxZx5LvkSW4CoiSoO5JiLw?=
 =?us-ascii?Q?kGtf2A4MAy5RSnkPmZ2wyt2vW5AjgRyZPigqTkECLfESPrs27i8D2rMeKMZQ?=
 =?us-ascii?Q?rzZODbNzsDDEI3exD9XnfrPY9HLDlknri8xX5OzkCW4Jm8t4DDx6nLgCgBTU?=
 =?us-ascii?Q?mu5iHNJFtNCWmv7WukpqNamdyjeSDOkmL8+jr+mNdQ7942wPCIXF+r60lQmy?=
 =?us-ascii?Q?06v7XONtjGe5epJmLlV3fMM0g9cGIcymauzMomLtnHr8Mx9d+FDn+KoubUZI?=
 =?us-ascii?Q?IkD8gBZ9/B8ZAIkOT+JDvUjTwJOwu8HGeS1HLxCFUVqVj18iHi6SRCLltLho?=
 =?us-ascii?Q?WY3BHLqxBi2pPvY2soblJD4Xb2i/gN65KrXkNSLx5110i4OXQ8rxIrQm1+oY?=
 =?us-ascii?Q?9or8pLsUjruWWeUN9mdeEr4/13HUUPWF+newqLVy+Y8RVsTmw0MiOoD4aMXE?=
 =?us-ascii?Q?z+6h8BvALyCf3QOsxTDMEzkmq+D0WhAvXt4ba3C/DNl1/HnbaK4pkQre9UXH?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bea30a4-265e-43b2-7882-08ddaeeec0e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:22.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv8f/4XKF/3oYhJ6LrQed5gXCgHoJt0JUqYb7jh/ZOhdLubDffhmeEk8LsFm7UK63JebdWMPT6PC28yjAGwLV7b0X2CihOO+/tKDAclxOjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

Towards removing all explicit unlock calls in the CXL subsystem, convert
the conditional poison list mutex to use a conditional lock guard.

Rename the lock to have the compiler validate that all existing call sites
are converted.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c | 7 +++----
 drivers/cxl/cxlmem.h    | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2689e6453c5a..81b21effe8cf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1401,8 +1401,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
-	rc = mutex_lock_interruptible(&mds->poison.lock);
-	if (rc)
+	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
 		return rc;
 
 	po = mds->poison.list_out;
@@ -1437,7 +1437,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		}
 	} while (po->flags & CXL_POISON_FLAG_MORE);
 
-	mutex_unlock(&mds->poison.lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
@@ -1473,7 +1472,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 		return rc;
 	}
 
-	mutex_init(&mds->poison.lock);
+	mutex_init(&mds->poison.mutex);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, "CXL");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 551b0ba2caa1..f5b20641e57c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -254,7 +254,7 @@ enum security_cmd_enabled_bits {
  * @max_errors: Maximum media error records held in device cache
  * @enabled_cmds: All poison commands enabled in the CEL
  * @list_out: The poison list payload returned by device
- * @lock: Protect reads of the poison list
+ * @mutex: Protect reads of the poison list
  *
  * Reads of the poison list are synchronized to ensure that a reader
  * does not get an incomplete list because their request overlapped
@@ -265,7 +265,7 @@ struct cxl_poison_state {
 	u32 max_errors;
 	DECLARE_BITMAP(enabled_cmds, CXL_POISON_ENABLED_MAX);
 	struct cxl_mbox_poison_out *list_out;
-	struct mutex lock;  /* Protect reads of poison list */
+	struct mutex mutex;  /* Protect reads of poison list */
 };
 
 /*
-- 
2.49.0

