Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A821ABD1;
	Wed,  7 May 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602606; cv=fail; b=Pop4Ar1nu+oNaAajDbfpUcJBPn9/hkpZALgZ/m5g4ia5H+zO28ZssMkH4pFcCcjBsHF4xenNqCR41CpNzEz4e9jMsSDvzU3I6UAX43XdefM75Dvrwz07vzg6WBdjQX9AOThUtJeyBLsuoglwCTLvIhVJFd5CX76UWL8UWnWy/dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602606; c=relaxed/simple;
	bh=S1/gjY+kaD2gl+nZiKDvKuvze65136CWSi4FUCkKBeg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YyWQv0HY0KAgg/aKDjtwf9zr1nD359kfgJh/Pl84zyIQFHR0qt0tlZUSmXOtIgTXuJtXdkwji20CU17D/jymew92P9zLMdr7kHD1MUzW47X2m+HLhHm3nPOFdaP6kaSK/d5Hc+SBkUf513OAdayCyBDXhySrpdIH6X6JbJWI/ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7S74Wrv; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7S74Wrv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602604; x=1778138604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=S1/gjY+kaD2gl+nZiKDvKuvze65136CWSi4FUCkKBeg=;
  b=g7S74Wrvf7kUktKn0hqnjaok93rsTUiP5VK+Wvf7YCrK1xXcowCC92UA
   6v0Np9z3mCI68guHu+5T/PjFDsaBIsMwwDRnclS2nG7Nj6j8pBPdxESD6
   cOMMlR9V5BWNnVjinkqbc7GOn8zoiTzw1dPO/z0yaFZL3FXPrlBuBBj7L
   Kbcq8BZhMdzkOtXL97m4eECShMR4t4HtGz4xs6PEpt9qo6s/LOs+og29m
   FVdXQhR4mQGPEsja2XTPFlrYlfIz9QJtoT5ZX48RP033dKSicNRkbtZlQ
   3k58i7w7ZllRbkM/s/m0CYtO4EiQO6E2Wa2tlS8MBircbwD38CBCW3emR
   w==;
X-CSE-ConnectionGUID: ff4ms4fUSiuBDwrJbzT3uQ==
X-CSE-MsgGUID: +F1q7Aj8TTe8Pul6sdMwxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47564218"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47564218"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:23 -0700
X-CSE-ConnectionGUID: pKjtqs1nSgyH+3YB/TezWQ==
X-CSE-MsgGUID: 3Sxf+GUvRHeIBNPgFLjllA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="140984963"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jiuaWDD/ry2soqPuY7Q3sOl8Gm5VxeEB5RTb130GsDqMNhrUnMZ/uJsML5LJy9+2FNVaBPwI2onjXWaBdmsfbxsaHfrXZhB2IlqNB3TUAdkyh9UfSAxPRWW9R3qGuXHADMXQPkWgxZXQSgWf4xokTtrPwR8fgiEpXPug/I7gJ4Duu6eCgBlwf1Sf3k7mlNhxzIZzFgvSbfoc5ejwxtVH/wx0B8307PB66GbEVA6CWOuSGUutOqZyMaRE0qoYGmxSWWt9HXrBXw7arfBDLVGGa5OAD4VdkTtcEvxVSqXE8+4CoWVyREKl9B3pz/2WvKYB/MhOt6perOFKUZqCmpBaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQxgccs4NaUy0c801mwjJPro2VScZCn20iN8rIPr3rc=;
 b=VEr/NdEwE5nC0ZQWD+fCnFtUGl3J4lLCMYExIcI6UZCuKV3PqJi31lJjFTa7Zo9Y+IxOeawAKNL7RadHdw1nueqyB4PNBsC30UT8h4udxGaRuuJo5ERrG72T6NxW2nsCzX3fja95rtsjLCISFu8igBLXpCHFIa/54WmrwlQdkFZlL/7zFAupNmXUvI0RHV9riHKEgsB7abZGuXnMGQYIbYrnmnjA1lV1Su66RyEEeb3z+4p5BQGe/P4mbHsYZOxd2/g5UtwiZyvYhuuXrv1oq88yXhVUh9RQVxOwjg0tdjKYy2Xrtu0eR4qpThjFJheOWWrRxRdKaaV3Chcn63cDDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:49 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for conditional locking
Date: Wed, 7 May 2025 00:21:39 -0700
Message-ID: <20250507072145.3614298-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507072145.3614298-1-dan.j.williams@intel.com>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b002ce0-ea6b-47f9-df59-08dd8d37d53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SjRExNOPRJIL3Apa1b0OHDvvtS+EkLBqAd0jnkVFPK9eX+wCViz7pCHZtREM?=
 =?us-ascii?Q?qIhstAlY2+5i2CMlEwh2+3UlUHYxB23yowgaViQ9gAI717g+OkZZwhW13Ju+?=
 =?us-ascii?Q?mBrp3M7k/7SVTGoWEoyTjDPzFdrHMpcCNKxy/vatwqBfMOdXNVQD2E3MuVuL?=
 =?us-ascii?Q?Kx64AB25ip3Y+apsBqupIZSYbQzmfA1mX3Te/9YSco8ZSq+pLkH7GXX6KUCy?=
 =?us-ascii?Q?Y03Pa3fL/GoLhiCo6XnMBQZ073gNrYiScGIHfO5LbEPuzk/l8jzVUpRF+iGv?=
 =?us-ascii?Q?TZhF7i5XeYr7quRGZvsR5RiuLPSVVyE3ytlpltneAs9LZ3uc1xf/pW9uOND+?=
 =?us-ascii?Q?idj0Dh5PpX11oN6ltiwrqtXT/wC+sLC4WB3iAlWNn78mIX3GLiDCCeQH9IZP?=
 =?us-ascii?Q?zfkn2xFzW4Joldj7u9v+fqDpCGW0ONUcU7CnSmNDdyTgzAYK02UVqXszaOcd?=
 =?us-ascii?Q?s6cKL6XwEfaeCvX/p9uZ9Kaj9EHXfLH1d5us+dMaYG5TGxf8VmupB0eqxy94?=
 =?us-ascii?Q?b6Z0+MP7qZsrniCTGC2ieM+iPnzm4O8EnhYcmcJB3V7U03lmagn6StVfBrZM?=
 =?us-ascii?Q?hUAifN+POqY6EcxaFa4sm+SCuvaKorANpeUCc4Y9XHfiqP3FcqhbMeQtRbZ1?=
 =?us-ascii?Q?cCo1c7Ow9BtA/vw2tsPDbhoCoZQQxwAd9KS7PSrEdid1jwzuNWvkjL8Xyxda?=
 =?us-ascii?Q?G4gCCFgQ2iS+556nNY4FphHVgaZxjUlbMHvkr7RR4fxPCU9ADWuhPfI3EUA7?=
 =?us-ascii?Q?0vDSggM1BhTt5UdtXGAuTT0/7QUEoKuEzYjtgCJ80tktDL3+s4Flq9EN98cf?=
 =?us-ascii?Q?v7F+ExqwDaofHdDTWW8vXCT2l4D0583oshZ/YadAtWKZwACzCZM++sCflR2P?=
 =?us-ascii?Q?C6R8SRfxPYcXPoWPpoEz3mk359YNqQHqJwqW4flGsvZ5wbwnnLzbzYiPgx/W?=
 =?us-ascii?Q?ORUFqhQW3N7uuFsDYukks4tCTSfByEi+tEqVBmZ7AlXoDHlCwNIXoti8/O14?=
 =?us-ascii?Q?lE7GZYRJAYaWogGqalYqLsEfDVQlQs4q2/6zP6NVxeFhaK7C9na7bIBnGy1W?=
 =?us-ascii?Q?cmCl74EJRu24MgreopJGdryAcNLykg1luY8RI8578xMFtDEQt9kfpHBPyW88?=
 =?us-ascii?Q?tsL0fscByvAZZXQs9wnz5Jxxf8IYvh9UeUzKmzE3Rf1RSCKJnoqLb4eUNqiL?=
 =?us-ascii?Q?45z7JEJZLUdR1dlmqI4BQHsK5HtAYnGnapvq5UjdU/NzqZ97Sx+XuSyVKc7y?=
 =?us-ascii?Q?MyP9wSbRQd79YJodZH6O+8ATxU7MO2/hRxV6hpdsSQOM1ldm2kWivH0GOA1k?=
 =?us-ascii?Q?V/L1GRWk5Cafg0Uv66wLGb1gOuhIuK8d8mjLcaOZBxixMms1OVrtgVPmZnsn?=
 =?us-ascii?Q?B4mQ6O0u5oDocmLPr/H9O5eN4KBvmenkl5r8B38K0rgOjRutyCeBGTDbDwIY?=
 =?us-ascii?Q?Hf/pyzHpzIg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQXHnxWFxkU7iFpgIE0kJNPKdDQKYNnUenll5LrM+B0KijZOllZ29LqkPiUZ?=
 =?us-ascii?Q?fm7R4SdIz3vLuoBgcVccbkSPMzxNzDu/Y25TkQycMy80Tks/opdv+M08Sg/Q?=
 =?us-ascii?Q?xsAehqMsAiQ0a2NbzfmRPu8qQc9TyHvj0xRNrMQgg6yFsH32uGIKg7N3QNpu?=
 =?us-ascii?Q?nzUA3Xe46PZVhDSjhXk8hM3TIu4Y4GCj5H5HSujardYMvR0th+CRRl+T+8oQ?=
 =?us-ascii?Q?lfsSm4mvme9D2F/D6RHZOkVQ8s7azAQgVg13aEFCuiTNN8OPlw6BOqt7Tz3M?=
 =?us-ascii?Q?LYuqAv+evmQ+Ae551PBsEyJ/lbgdWtEcbBRO21gmN3j5TALjMHs2kggtqNG1?=
 =?us-ascii?Q?ntUQOPMG4L/7sNbfQzIizOCf32B2fx6ON/OzYRdLqwys1sw8VBFPGkFyawl1?=
 =?us-ascii?Q?0abw41VfbaDHxtX9BRS+X7mmr+T2hv6ZByVbwu8ZbZs8jzkh99bPa9wMjU9X?=
 =?us-ascii?Q?BPbHnTe7zR58To2jU6jEkKf7Abo+d/w5rqYzJmYrPNjRcur1r8CfvTueTQX/?=
 =?us-ascii?Q?iBmjwKGtmG2V3t8V+j2wrUrzdiE9YJ3DbYVILsuKNlt7iueEMQhqR5NScZUc?=
 =?us-ascii?Q?+JPG7R8RDgVBnSmdwTNR3yPsqjtqHzbZdV9uweKkGTMXPp1Yi6RKS1lT3z96?=
 =?us-ascii?Q?HcIDuttO42zGETG7UB5teSbCJanBM4B8/itp7jZNwFscmjqNvlnWyXIpOLcX?=
 =?us-ascii?Q?bdKY/yllE8j0Or1IoMwmU79F+JWxbTKPBXiMA8Gg45vRA1C+xV17rKwjfcl1?=
 =?us-ascii?Q?tHuGhkuythyseDgGnA9czoS8mc7I9git/pYkaEdV4tBDuVYIYQdSdOvKB8FF?=
 =?us-ascii?Q?7H6ZrHegIALMKVYSgKxxhntvK+lyW+2sbgWyawYnKtYBlEvvQ7hZBo6tz5cU?=
 =?us-ascii?Q?O7i/KvaT+Gpcrcywk01mmkhik0VEmjozt9NR9xHajgS9lwbMx1hZ8h2Vzfyr?=
 =?us-ascii?Q?0AUGDn+gv0/bZQgYcpCAIb7U6Sjbs+0B+8Hm2JqLnB1bhcrks/8kz6BzbC9S?=
 =?us-ascii?Q?AyCWrCU6dINJh8loc/xURgfvneqYzwh5UcaERouy3a8u5gQnnV4XHnGdSU6t?=
 =?us-ascii?Q?jpBK5AoWu+rD1wCOKfyotxdxrm/KSAq3duriztzrv8bDSNbJ99zUGk5NnOzS?=
 =?us-ascii?Q?DyW+h/smbLOpw6XFvUk08/HBRL2zyUlbkc0KHWqmmj4BGQGISR0QAw6WaqWl?=
 =?us-ascii?Q?wxxK1Yci08ay84Eum04yvbE9ebd7rKQ563zJYeTqMZKunD6V/8bAa8NIy7t5?=
 =?us-ascii?Q?LM+UmioihMG4zwB8PD8QTP/a3sQ5UtAK21M6ftdO7R1mX1B50V/MY/qSRelY?=
 =?us-ascii?Q?tvfgja38pnDPx98aV+ZV9g+m+X0uTfFSBsWlhRB50DaiLOclSlN8xu+7NSeJ?=
 =?us-ascii?Q?hAzWstKOexmA/TUi2NxotW8jeYSz/348/NkdHPQ704CmqIBBab/4wAI1W2DG?=
 =?us-ascii?Q?iHfSrz2YDaeGKqHUYCmnaOFlqHoDO4IPHzEOhiT13Uah+sdk1ZEoqScNjuP5?=
 =?us-ascii?Q?adPBsR8zh2t+wUwcyIeYhXEKggM/dV3dc00C9/fKh01K2tca58EbwR8qFpkt?=
 =?us-ascii?Q?oRBZzDyl14CUFQ3+wZlieqYFYVxbfG0MlYcZnecZxA2OXBXgQ21akW9paARl?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b002ce0-ea6b-47f9-df59-08dd8d37d53e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:49.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+e6oqSHDBmB7xAbWxnC9U36jGH8kHoIypNfxGImwlYQ7rhD7AIT9id2kSmzGjaGfuPI47y2i8vjS5xfffYqwp1VEQsXXzn3408hKjdOxeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

The scoped_cond_guard() helper has two problems. First, with "convert to
cleanup" style patches, it results in messy diffs that re-indent large
swaths of code. Second, it swallows return values from interruptible /
killable locks, i.e. the return value of those is not always -EINTR.

The last attempt at improving this situation, if_not_guard() [1], was
reverted with a suggestion:

    "I really think the basic issue is that 'cond_guard' itself is a pretty
     broken concept. It simply doesn't work very well in the C syntax."

However, the observation is that just exposing the CLASS() to callers
solves: the safety concern (compiler enforced "expected expression"
checks), conveying the conditional acquisition state of the lock, and
avoiding re-indentation caused by scoped_cond_guard(). See the commit below
for the analysis of the revert.

Commit b4d83c8323b0 ("headers/cleanup.h: Remove the if_not_guard() facility")

The DEFINE_ACQUIRE() macro wraps a lock type like 'struct mutex' into a
'struct mutex_acquire' type that can only be acquired and automatically
released by scope-based helpers. E.g.:

    [scoped_]guard(mutex_acquire)(...)
    CLASS(mutex_intr_acquire, ...)
    CLASS(mutex_try_acquire, ...)

Use DEFINE_ACQUIRE to create the new classes above and use
mutex_intr_acquire in the CXL subsystem to demonstrate the conversion.

Link: https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com [1]
Cc: David Lechner <dlechner@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c |  9 +++---
 drivers/cxl/cxlmem.h    |  2 +-
 include/linux/cleanup.h | 62 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mutex.h   | 24 ++++++++++++++++
 4 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d72764056ce6..cec9dfb22567 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1394,9 +1394,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
-	rc = mutex_lock_interruptible(&mds->poison.lock);
-	if (rc)
-		return rc;
+	CLASS(mutex_intr_acquire, lock)(&mds->poison.lock);
+	if (IS_ERR(lock))
+		return PTR_ERR(lock);
 
 	po = mds->poison.list_out;
 	pi.offset = cpu_to_le64(offset);
@@ -1430,7 +1430,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		}
 	} while (po->flags & CXL_POISON_FLAG_MORE);
 
-	mutex_unlock(&mds->poison.lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
@@ -1466,7 +1465,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 		return rc;
 	}
 
-	mutex_init(&mds->poison.lock);
+	mutex_acquire_init(&mds->poison.lock);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, "CXL");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3ec6b906371b..9b4ab5d1a7c4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -257,7 +257,7 @@ struct cxl_poison_state {
 	u32 max_errors;
 	DECLARE_BITMAP(enabled_cmds, CXL_POISON_ENABLED_MAX);
 	struct cxl_mbox_poison_out *list_out;
-	struct mutex lock;  /* Protect reads of poison list */
+	struct mutex_acquire lock;  /* Protect reads of poison list */
 };
 
 /*
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7e57047e1564..926b95daa4b5 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -424,5 +424,67 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); }
 
+/*
+ * DEFINE_ACQUIRE(acquire_class_name, lock_type, unlock, cond_lock):
+ *	Define a CLASS() that instantiates and acquires a conditional lock
+ *	within an existing scope. In contrast to DEFINE_GUARD[_COND](), which
+ *	hides the variable tracking the lock scope, CLASS(@acquire_class_name,
+ *	@lock) instantiates @lock as either an ERR_PTR() or a cookie that drops
+ *	the lock when it goes out of scope. An "_acquire" suffix is appended to
+ *	@lock_type to provide type-safety against mixing explicit and implicit
+ *	(scope-based) cleanup.
+ *
+ * Ex.
+ *
+ * DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
+ *                mutex_lock_interruptible)
+ *
+ *	int interruptible_operation(...)
+ *	{
+ *		...
+ *		CLASS(mutex_intr_acquire, lock)(&obj->lock);
+ *	     if (IS_ERR(lock))
+ *			return PTR_ERR(lock);
+ *		...
+ *	} <= obj->lock dropped here.
+ *
+ * Attempts to perform:
+ *
+ * mutex_unlock(&obj->lock);
+ *
+ * ...fail because obj->lock is a 'struct mutex_acquire' not 'struct mutex'
+ * instance.
+ *
+ * Also, attempts to use the CLASS() conditionally require the ambiguous
+ * scope to be clarified (compiler enforced):
+ *
+ *	if (...)
+ *		CLASS(mutex_intr_acquire, lock)(&obj->lock); // <-- "error: expected expression"
+ *		if (IS_ERR(lock))
+ *			return PTR_ERR(lock);
+ *
+ * vs:
+ *
+ *	if (...) {
+ *		CLASS(mutex_intr_acquire, lock)(&obj->lock);
+ *		if (IS_ERR(lock))
+ *			return PTR_ERR(lock);
+ *	} // <-- lock released here
+ */
+#define DEFINE_ACQUIRE(_name, _locktype, _unlock, _cond_lock)                \
+	DEFINE_CLASS(_name, struct _locktype##_acquire *,                    \
+		     if (!IS_ERR_OR_NULL(_T)) _unlock(&_T->_locktype), ({    \
+			     struct _locktype##_acquire *lock_result;        \
+			     int ret = _cond_lock(&to_lock->_locktype);      \
+                                                                             \
+			     if (ret)                                        \
+				     lock_result = ERR_PTR(ret);             \
+			     else                                            \
+				     lock_result =                           \
+					     (struct _locktype##_acquire     \
+						      *)&to_lock->_locktype; \
+			     lock_result;                                    \
+		     }),                                                     \
+		     struct _locktype##_acquire *to_lock)
 
 #endif /* _LINUX_CLEANUP_H */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2143d05116be..283111f43b0f 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -64,6 +64,8 @@ do {									\
 	__mutex_init((mutex), #mutex, &__key);				\
 } while (0)
 
+#define mutex_acquire_init(lock) mutex_init(&(lock)->mutex)
+
 /**
  * mutex_init_with_key - initialize a mutex with a given lockdep key
  * @mutex: the mutex to be initialized
@@ -202,6 +204,28 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
 DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
+/* mutex type that only implements scope-based unlock */
+struct mutex_acquire {
+	/* private: */
+	struct mutex mutex;
+};
+DEFINE_GUARD(mutex_acquire, struct mutex_acquire *, mutex_lock(&_T->mutex),
+	     mutex_unlock(&_T->mutex))
+DEFINE_GUARD_COND(mutex_acquire, _try, mutex_trylock(&_T->mutex))
+DEFINE_GUARD_COND(mutex_acquire, _intr, mutex_lock_interruptible(&_T->mutex) == 0)
+DEFINE_ACQUIRE(mutex_intr_acquire, mutex, mutex_unlock,
+	       mutex_lock_interruptible)
+
+static inline int mutex_try_or_busy(struct mutex *lock)
+{
+	int ret[] = { -EBUSY, 0 };
+
+	return ret[mutex_trylock(lock)];
+}
+
+DEFINE_ACQUIRE(mutex_try_acquire, mutex, mutex_unlock,
+	       mutex_try_or_busy)
+
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
 #endif /* __LINUX_MUTEX_H */
-- 
2.49.0

