Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB622D4DD;
	Fri, 11 Jul 2025 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277797; cv=fail; b=EjYGUKnDXxre/qX2eiKxRca0XVY7XZFdBEsrcBw27Mylxo3J9zylcjmVrQWNo8xpv+nei+uzitBYmwzaSWgSaK79rKIg4/PIAxHOZxlybuiMWLDyCGZ8TQ1e8yXMY9IjYkr68ZfE0RIJNrVbNWULj3PZn36ekKghMu4RK/hUaEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277797; c=relaxed/simple;
	bh=6EqswWVMdwnerB8eA/d3IwYal7GVA54Z+vPuOBLxC54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNxE1aT7bnHfDuMlZ7IQZnLGDYlGkRSQbZI2KsBjRKSbw/Bw9ofnjXQNE8OZX192V7wmsOreYjnYoBWmaP7hshyrckj/ZEEEhelfkP7bq7vNkl71YBVhyBeDQPOOPn02vzxd2kdqN0DlsxCAvSirkqpgFWtSMH7EjVtcFLU4DJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcZzvX01; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcZzvX01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277796; x=1783813796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6EqswWVMdwnerB8eA/d3IwYal7GVA54Z+vPuOBLxC54=;
  b=EcZzvX01P1q6wV5h0lEbkvUeSx2K0s22TXla23S0/ZjZP8VlBcslg3pE
   T/E8ItR1tXlTFR7dRcJgj8wtaPRRB30OiuDUCwMP67hH0Bq/WwK+fJFJo
   MEdhGIQVE148xyHrCMbfRvHsSoMUWS2Grh3eWnq+tOVSxisvORR1JjNpH
   4VUD7IK9CJyxrr9ZDZDf+9/FBeLULz1u0+ToycjOefi01sJi2kYeNjlyj
   dPtiYjGYbDSnAgpPmfR+C6+ohxE5VPkqKmVGpu9VRBhb7xwsADh/PaUB6
   yRs/kYaSe4DyuQNrllqdFWJU+vz6Hy3xgXVw729ZwAHONREzPa/QE1pZu
   w==;
X-CSE-ConnectionGUID: OZNtFQKrSvyDM7zHkp+x5A==
X-CSE-MsgGUID: WNLfIuLWQfut9jqmfKupnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54448311"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54448311"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:55 -0700
X-CSE-ConnectionGUID: pagHV7NqTFGesmKiIBSIZw==
X-CSE-MsgGUID: 8CuE706RSsyqwwkAmWJbuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162160566"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlImjkUEyEf9RC/Kd2XbDZK2M0uXlekZQp2Q6QKZfARkhMCm1g57l0Litg8xeS5rB6gju6TuQBqJBx0nvLkL6uG0G2h+GUxKg8aotLUiQYbvp9EpNkxpratTEFtO9gSJWRFBpjJUXMA2wuryavphhMNLDD3L18lV0O1aWQpaUcLQ2FslYeLhf58qCALvvEICcLRuFv44joqxewJUQP0EimTT/T6EWbwVcxPJWJlJA3qJ1/E/lALe+8PN/ThMlXW9LC7RgRqh3DUw/hiGMMWhGX7h9GG49zGBSaLh95vs9pT2NGRCAqfGW4GueLiGG742Fw4D63zOsgI1W/Jv3INl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ6nLMtUugtT3IpiilcdtuOrDbZmx4UbrbE8fHFqjt4=;
 b=xwWKBAriamR5Bh2MX1+FLpoQkEYyU1xPLL7Ww0hPhp1GfOc7ecwd0+ErskPJYwlo4EX19jfw1ZTQOo3tUtV8y3oBeLXojkJQ/UZ0wLSBNMloyDStCbEfPDWmGEWgbo66YNXweiIbabmWKmkzYeP5kEk0TbRkbzw1z87iBd+hk8ysbnCPxKGa1MqPJwG+s9uGLTURYVD5ffL8uX7UBJPDMrHTQDxgTslI0b2wAPLeY3O2ISrD3T3J7pqY2V6RiAqHd7Bl2NbLbjXR+IXdjElioDixKIZDiezzyGoBJb9JQ/PzqULFITHJFqW8lsrMU+R/AKL6jrDiE+wbs0Z7Ja0STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 23:49:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:36 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, David Lechner <dlechner@baylibre.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v3 1/8] cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks
Date: Fri, 11 Jul 2025 16:49:25 -0700
Message-ID: <20250711234932.671292-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711234932.671292-1-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2cb777-1992-428f-5283-08ddc0d597a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vpAg8NXkJMr6n96SnJhwNoKgkckiT90Wc4BUYNFgeucUVbk2hexXqUsaSQyb?=
 =?us-ascii?Q?UYSEAjvgst1hy9+pwi6eobb9gTFk7v/rOSrSozcva9mUPaRyZzkJHRpvyMkQ?=
 =?us-ascii?Q?sULNGARJGBGTamKXRyk5m5KPdHB+AAT0cyRE2LhZh/8v8o/VC6k4SCWm0Ci3?=
 =?us-ascii?Q?kX5wiEBghvqv6CHTE9j59jrX52wy6vaBdg6rVyEywx35CJNd5ohzLlaajmaF?=
 =?us-ascii?Q?bLof4lQ1Ecceh8xXI9Ad/RFy/5dlSSJyK4dkcyKW50JFzqS182MsYJcsLoCV?=
 =?us-ascii?Q?JODbBlkJ2Lx8TawSUy9n7Ql23IIQRi27U4prQgKxXzmBDXJjrsalNtZJPVCj?=
 =?us-ascii?Q?a+XuLPd8dVQkgYIrPQ0mk7BE2XsCxmYfMZUK1Ub5+pZe1LByaBTtJvMgqauN?=
 =?us-ascii?Q?khOhun8ZhmlOVUek4Mi6SY5XuRAJeAA4IdUr5xjwvyNcFsVO6c0mKlPIVbMB?=
 =?us-ascii?Q?MKzCVdsamm+v20q5ap82c5kpDUmYDwniswBDs7onq6LkdfFpeNxzN4Pjb3y5?=
 =?us-ascii?Q?x13UdjbTXU2qUny4OiSIIF7ZwqHK8pnYJtItF1S0v5fQmlWCjGS5O6F68ARh?=
 =?us-ascii?Q?nnunsKuCvHHYBJAOmfC+Q19MwEpUzmYQCBTA/Cl6iBlCQuxUPdXbLft67b5v?=
 =?us-ascii?Q?8nxCLbgAtNhSc5/XqtBpV0AlRLsTdltdFfOwhdN2EO01k+s2Ao5nWlN0d6Vu?=
 =?us-ascii?Q?EIcwHA/p7fW7eVwTb1fdKttcSLOP9FcbptfZQwNYGNrY/6JWxAe6p+U7T6UX?=
 =?us-ascii?Q?MNZXkJLgobrV5eRqSyLBUMtGSdBtoCXhfirMFEQQq38XgmNP9Q4nil3+PbJU?=
 =?us-ascii?Q?1oZ1i+K6qpaZXfts6s0xQCuv0hFQpS8GqTyFgH77x8/g2kADCRX6lpvJJaUJ?=
 =?us-ascii?Q?PXzHcIsgGZsb6D5pDnZApAF9dKhSBDlYh8Yw+O36rX//dR5N1R9TbQpO/7UA?=
 =?us-ascii?Q?0NS5LrbN0eACDvSk14xadFvpTh1GpG8njv+k+b7ffoeLmX161FFv07bSuuOY?=
 =?us-ascii?Q?jtcw9OXIt7anfSwbnXMq0uK86KrECWqUgrWhNDunjWgA6D0DiiQY/wLaGCWC?=
 =?us-ascii?Q?wVw04B94PfKMwu0hIK/zuaRB+V7RXKbZ1B1NnF5kJmyyuNXLv7Ru3UOuxMj7?=
 =?us-ascii?Q?uTQQ/CsfK/YvaycN6ed1X3rKW3zo8s3snM2KvefYZJVmdlfX61o2dyqocdPZ?=
 =?us-ascii?Q?5HsBBu0xu+EkCwE0N41NuC+Q5dcbM6B+hWUy/IN7NCNnT408qC76YM9cUBxK?=
 =?us-ascii?Q?GbtgJ0KoJNZ8+Mn61K2TB5RbKZVUq4yXq4ZsQK3pcGbbDLdsBCyGwLsKlGrY?=
 =?us-ascii?Q?hv5EBSqta8Er0z0eIigeSHQJd7jMEZLBFr33ynfPWty0VG5VPDWL2xY7Pnw3?=
 =?us-ascii?Q?EAuv36Y40W8gGIQbhUimSOeoPiQa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XbEPQOL/Ey2NQhR1Ipv3/sXSFq36scfdhgz3Y7ZJf34FPRvfAQbmkbMETRVs?=
 =?us-ascii?Q?ftz3IkLRgR3sTRyDcme7cX/sgJijUQ0EhXj2l0mJ87lYHJtCgGicrefNn59k?=
 =?us-ascii?Q?zYd9qEeN8VLLIXaS7ubuyavNsGDLUQrNFrv7NqXmXZXAferTxRosNMayyyx0?=
 =?us-ascii?Q?wld2OkVxJxHWm5gTRfog6LAXWVpdAIm8Zsl9OPF28JR5aPq3knNkDXfKlumV?=
 =?us-ascii?Q?jLkm/c2nEpMihci5qrcQDH/bcpKMB+XvQ3tVHC3iksStCivc3N5qrzUtsW0B?=
 =?us-ascii?Q?qzeAw/f4LaFTMp2u1o6Oy9bv8Dri4r3Uaje4i86o5cm+ownMQWZlW1A50rKw?=
 =?us-ascii?Q?eeqhFLSZrwcy32z86Bxk/++A5t2geGyZookrGmtBqu6F1hHI4uuo41FIYK1k?=
 =?us-ascii?Q?eI+cumPY7Mjf0ne1TL2XrZXCU/VfpD76IYxXRLKAgXmg4Nai7fd6Qm/ZyurV?=
 =?us-ascii?Q?fdEij+MC9Hljjyol4n2qAVyTBDw3FXKzHhMC5rD6Qng3bHUuz41SiAlBskCb?=
 =?us-ascii?Q?tGj7nMRyfotDIpa3ClGDElO6xwz1nIOMuwZI5xiaUePKXjkv1ZLuIBmkjpQk?=
 =?us-ascii?Q?PlQ25TWyUO6BmdkSjMWyY+uSTf6MHm5XhR0CDj6W2+raNw0cyrJh+kn19M/T?=
 =?us-ascii?Q?hkoa0aAR1j9soxIetEvfM1yYevXISMhe6qcYRUTdx4TSgEeb6rG5xD8c/t3h?=
 =?us-ascii?Q?g1BZc1dd3BJPEA4UyxM6iFpenB6fvNwuGqZXOkzBqNZc9shXcuv+ylXo4gTC?=
 =?us-ascii?Q?fH0nGoVP8A6YK9SRB6SoijfS6C9Xz3EzGaZMajH/1Anfr/f+d/GSwyySKfrs?=
 =?us-ascii?Q?pUyUlFgRyHGRvmTTk+cLxB136oBqGxYJC7z13+xTClw5DSAnU0JR3Wb0vd4z?=
 =?us-ascii?Q?oWl6oDgQ7+07A9POvljhXtpx9aGkQHZRrEtErVIe6kouUk5Zh2eLNjFqT+mh?=
 =?us-ascii?Q?UsrWFEeeBw6t6KyyPvFFrevI0BVlTTc+ZnQxwIS8AzyjaMXxg0qOLwV7JMEN?=
 =?us-ascii?Q?ORXMuUr1AXg1AYzBL/WSUQrRm/CuWwrSFe5r1vkGg6aKFos7ZkOoBNYDXVP2?=
 =?us-ascii?Q?h0tI1p+cyhEAiM1at4y5vmjSxKgtZ49GgnHKro4cKvrST/r/5wQB/x64irgO?=
 =?us-ascii?Q?4aRohdhG/PldFkQWxTAAM36EJr8ImQ0+yJyFvbrO+0Kd0gS0UGWd5RgqAvBs?=
 =?us-ascii?Q?OGbj91URagdbXsO33MB9gWu2E4Kpc5wNeLjnrhtFAyGWSYokYs8YTCaWZWVG?=
 =?us-ascii?Q?rYkf+dTVMcY2nDOL6cVf/4YN5i/KIUbWT+zAnXjanYFulTCPz6MG+JyhhMFZ?=
 =?us-ascii?Q?VH9dIcT3OAS5uGrwm2EqaAqF2bk7ybS7mtItodOiAXg1NQLK6OBOrMzhDINv?=
 =?us-ascii?Q?WBjtKIqVYAa9HAhAfLCRN46fYpkHOQw8ghr3MHw7Yi2k9ZBcM8duCpRKEXox?=
 =?us-ascii?Q?6PPFCtSzKI9tpffJyX1hCOo68XNox2lrBurqObtDfYMWXwrBXTk9A8NbSrv/?=
 =?us-ascii?Q?QyK3vTzU0J+csZEY+8UaeAy7qneIxLBvfx1ZovLCIgNMWYNFx57kT+/Psxjt?=
 =?us-ascii?Q?Kf+TUJ7Q3ewTv5qF3zbWAAH8pN4AZSRkqfhlAnDRklarZXe0hm8bN9H8GdQ5?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2cb777-1992-428f-5283-08ddc0d597a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:36.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2jIJNLsNkgGK13RdL8PFZKbpUTXZigemgtQnyELgbDAEpBh6HyYCMRZL8BbK/s4Kg8CQ9AFLUSv+yeD13MSR3UEWDE+PTy9dynF7qwoCG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

From: Peter Zijlstra <peterz@infradead.org>

scoped_cond_guard(), automatic cleanup for conditional locks, has a couple
pain points:

* It causes existing straight-line code to be re-indented into a new
  bracketed scope. While this can be mitigated by a new helper function
  to contain the scope, that is not always a comfortable conversion.

* The return code from the conditional lock is tossed in favor of a scheme
  to pass a 'return err;' statement to the macro.

Other attempts to clean this up, to behave more like guard() [1], got hung
up trying to both establish and evaluate the conditional lock in one
statement.

ACQUIRE() solves this by reflecting the result of the condition in the
automatic variable established by the lock CLASS(). The result is
separately retrieved with the ACQUIRE_ERR() helper, effectively a PTR_ERR()
operation.

Link: http://lore.kernel.org/all/Z1LBnX9TpZLR5Dkf@gmail.com [1]
Link: http://patch.msgid.link/20250512105026.GP4439@noisy.programming.kicks-ass.net
Link: http://patch.msgid.link/20250512185817.GA1808@noisy.programming.kicks-ass.net
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
[djbw: wrap Peter's proposal with changelog and comments]
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/cleanup.h | 95 +++++++++++++++++++++++++++++++++++------
 include/linux/mutex.h   |  2 +-
 include/linux/rwsem.h   |  2 +-
 3 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7093e1d08af0..4eb83dd71cfe 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -3,6 +3,8 @@
 #define _LINUX_CLEANUP_H
 
 #include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/args.h>
 
 /**
  * DOC: scope-based cleanup helpers
@@ -61,9 +63,21 @@
  * Observe the lock is held for the remainder of the "if ()" block not
  * the remainder of "func()".
  *
- * Now, when a function uses both __free() and guard(), or multiple
- * instances of __free(), the LIFO order of variable definition order
- * matters. GCC documentation says:
+ * The ACQUIRE() macro can be used in all places that guard() can be
+ * used and additionally support conditional locks
+ *
+ *
+ *	DEFINE_GUARD_COND(pci_dev, _try, pci_dev_trylock(_T))
+ *	...
+ *	ACQUIRE(pci_dev_try, lock)(dev);
+ *	rc = ACQUIRE_ERR(pci_dev_try, &lock);
+ *	if (rc)
+ *		return rc;
+ *	// @lock is held
+ *
+ * Now, when a function uses both __free() and guard()/ACQUIRE(), or
+ * multiple instances of __free(), the LIFO order of variable definition
+ * order matters. GCC documentation says:
  *
  * "When multiple variables in the same scope have cleanup attributes,
  * at exit from the scope their associated cleanup functions are run in
@@ -305,14 +319,46 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *      acquire fails.
  *
  *      Only for conditional locks.
+ *
+ * ACQUIRE(name, var):
+ *	a named instance of the (guard) class, suitable for conditional
+ *	locks when paired with ACQUIRE_ERR().
+ *
+ * ACQUIRE_ERR(name, &var):
+ *	a helper that is effectively a PTR_ERR() conversion of the guard
+ *	pointer. Returns 0 when the lock was acquired and a negative
+ *	error code otherwise.
  */
 
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
-#define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
-	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return (void *)(__force unsigned long)*(_exp); }
+#define __GUARD_IS_ERR(_ptr)                                       \
+	({                                                         \
+		unsigned long _rc = (__force unsigned long)(_ptr); \
+		unlikely((_rc - 1) >= -MAX_ERRNO - 1);             \
+	})
+
+#define __DEFINE_GUARD_LOCK_PTR(_name, _exp)                                \
+	static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{                                                                   \
+		void *_ptr = (void *)(__force unsigned long)*(_exp);        \
+		if (IS_ERR(_ptr)) {                                         \
+			_ptr = NULL;                                        \
+		}                                                           \
+		return _ptr;                                                \
+	}                                                                   \
+	static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
+	{                                                                   \
+		long _rc = (__force unsigned long)*(_exp);                  \
+		if (!_rc) {                                                 \
+			_rc = -EBUSY;                                       \
+		}                                                           \
+		if (!IS_ERR_VALUE(_rc)) {                                   \
+			_rc = 0;                                            \
+		}                                                           \
+		return _rc;                                                 \
+	}
 
 #define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
@@ -323,23 +369,37 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	DEFINE_CLASS(_name, _type, if (!__GUARD_IS_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	DEFINE_CLASS_IS_GUARD(_name)
 
-#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+#define DEFINE_GUARD_COND_4(_name, _ext, _lock, _cond) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
-		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
+		     ({ void *_t = _T; int _RET = (_lock); if (_T && !(_cond)) _t = ERR_PTR(_RET); _t; }), \
 		     class_##_name##_t _T) \
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
-	{ return class_##_name##_lock_ptr(_T); }
+	{ return class_##_name##_lock_ptr(_T); } \
+	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_err(_T); }
+
+/*
+ * Default binary condition; success on 'true'.
+ */
+#define DEFINE_GUARD_COND_3(_name, _ext, _lock) \
+	DEFINE_GUARD_COND_4(_name, _ext, _lock, _RET)
+
+#define DEFINE_GUARD_COND(X...) CONCATENATE(DEFINE_GUARD_COND_, COUNT_ARGS(X))(X)
 
 #define guard(_name) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __guard_err(_name) class_##_name##_lock_err
 #define __is_cond_ptr(_name) class_##_name##_is_conditional
 
+#define ACQUIRE(_name, _var)     CLASS(_name, _var)
+#define ACQUIRE_ERR(_name, _var) __guard_err(_name)(_var)
+
 /*
  * Helper macro for scoped_guard().
  *
@@ -401,7 +461,7 @@ typedef struct {							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
-	if (_T->lock) { _unlock; }					\
+	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
 									\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
@@ -433,15 +493,22 @@ __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
-#define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+#define DEFINE_LOCK_GUARD_1_COND_4(_name, _ext, _lock, _cond)		\
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
-		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
+		        int _RET = (_lock);                             \
+		        if (_T->lock && !(_cond)) _T->lock = ERR_PTR(_RET);\
 			_t; }),						\
 		     typeof_member(class_##_name##_t, lock) l)		\
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
-	{ return class_##_name##_lock_ptr(_T); }
+	{ return class_##_name##_lock_ptr(_T); } \
+	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_err(_T); }
+
+#define DEFINE_LOCK_GUARD_1_COND_3(_name, _ext, _lock) \
+	DEFINE_LOCK_GUARD_1_COND_4(_name, _ext, _lock, _RET)
 
+#define DEFINE_LOCK_GUARD_1_COND(X...) CONCATENATE(DEFINE_LOCK_GUARD_1_COND_, COUNT_ARGS(X))(X)
 
 #endif /* _LINUX_CLEANUP_H */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a039fa8c1780..9d5d7ed5c101 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -224,7 +224,7 @@ extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
-DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T), _RET == 0)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c8b543d428b0..c810deb88d13 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -240,7 +240,7 @@ extern void up_write(struct rw_semaphore *sem);
 
 DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
 DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
-DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
+DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
 
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
-- 
2.50.0

