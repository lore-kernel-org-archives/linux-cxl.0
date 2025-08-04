Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C611F4CBE;
	Mon,  4 Aug 2025 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754345406; cv=fail; b=UBoHhQGz4gD1nAMhkoi8DWWpnDELyL/uCE331QRDK5MBS26rRu6rnyEi+kYFmWuNv5WO3lQofd4sSynCafYIiEo7254NncIrg6JNKemZOu9tu8Kgwds19qcp9BZ8jEh1GM+2iI0Uy/+f2iNvdudr/ksNVM2SngcrSR3l5rN0Yms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754345406; c=relaxed/simple;
	bh=7uWAXnUzA/zx0y1XKMppjfbSX1St6QriAyQwDjbfqmY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=siape3OsXLvBGmKPJGhNLBa6CBHu8L3RbELCJ0gycASGE+oi2y6hYFnM7uOxS8jH1hMrjHKhLkXWyW4tJvdMmF9rG2C4woJVTW+BiTMJDVm7qThFSjIRQmjyNkSF0/v4n+nQq4mTy1gPXuRJc0jLNqZpfjvSbz7hQGvyRW0HTuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLPTFfv4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLPTFfv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754345405; x=1785881405;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=7uWAXnUzA/zx0y1XKMppjfbSX1St6QriAyQwDjbfqmY=;
  b=bLPTFfv4+Kkif6hXsJYQ9MYyhadUnilOm7sCnYOb7p+1P49AmVaLyBmu
   t8M9FiBGbjxTfPpeW7Hcw8+F71BeJamMw6Zof18wlvrnWMY7V8tCkBLBz
   1jYL5flFJxLJCiYYCPGiWq0f4GPtPm1fVHSwnFhP+jBKP6i2iqhVie6pM
   h6hQSSIGzLqbyr3ZnUrgyeDEEoic04IkI7qmhce+QDxM4SoS+o+JVgucy
   dCZ2X3GfdrJpgpwdjAZx+bjaYHFo/JqJDTYAdkXNPEF3C5Vv9p+PYpl9t
   GqW357EEGuDOBcpEQ/8U9d+s6CCpFXNyv7fesnSi6TsPrJZ3ctH0bb+sW
   A==;
X-CSE-ConnectionGUID: 95xoDGVIQfqHxbgZhjy9jA==
X-CSE-MsgGUID: oW0J+MhNRWimvXwwrpPEOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="60263040"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="60263040"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 15:10:05 -0700
X-CSE-ConnectionGUID: 0Sugx/i3QYKszYCPdV+Khw==
X-CSE-MsgGUID: XKFf54XMTR+oPJYz/JcxTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="195121466"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 15:10:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 15:10:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 15:10:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 15:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rc07DanOLGEjGxokRBDKDJzRaXH3jPThb/1TISJIKXPkhxFedpfUVw8jNvu1TZCvMKXQojuG5DzgLZYulpQUY6Md6kl4ZFiV1STPNBA6wEEWACTgEq20ILrS2VmKyeaYmUwKuAWHRkTNgej8zgXWDGtBnprgvcYfzoJ78d9a1jHnCf0+24NBqI0Ic4Zp9Pi+hy1R0eK3zDhPRqO0mRjRAWlnOyhlux3T+2Q283ULTnPrmZ3C7qPi4zv6IlUYEgQQNA9gLs/pTcW9aBB9suYKT9oMf3g14Zf4BeV/qXUHlAwBvz/oe4JBtgD3/yQRKYr7yftoogjpvgwR05Okn9nA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BN75yFvZScQm4v4azJBYlQI4ZnSetNCIB2buQmYdU0=;
 b=X+ud6pT8BdpN9RhCQzmJFDQFfM2YDrybkcAifApuw8GwTVJJkplFz2Uw3Dak8LgFieBH1fsr5OalZlNvceC5Am+n7hlaUdrhmZttWdR9ZvU1ELe2t1sdhJR0KvnlK72S53EgKeX8TW3iLCjy38wAFb5fjUB+LG5msihz/aC9bzLbmLopI+EU0L64CPZOil5IBqzzhfjYoEz3zX+bkzVXT+3E5gABXYnLNSCS5ac0DWeCx/ZG1stbFetzsAOl1RPfVhrYgGUpKoWcw4atiZVp4UPt61KXhYdLrC9VRN2KSfI0sUITyesgGwoBvWhrqAWLt3VK04E5qZMjc8mdLbt4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 22:09:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:09:58 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <dave.jiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	"David Lechner" <dlechner@baylibre.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] cleanup: Fix unused guard error function with DEFINE_CLASS_IS_COND_GUARD
Date: Mon, 4 Aug 2025 15:09:54 -0700
Message-ID: <20250804220955.1453135-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:a03:167::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5b1470-070a-4a64-6522-08ddd3a3a62f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3cW4mrJCMmYrrw7vXwPVTlFwzFQcnWW6iA9mUCrIaLbRjvfInyWkEZ/SpNxo?=
 =?us-ascii?Q?miEebd8A+d/OFiKorLdT11hFuixKo3QkJWoo6YDKPoEfHpy4qkwGCOqbHGPt?=
 =?us-ascii?Q?wSy3oqAeNutvYkYTm8km3dKcNdoSj2tl139i11H0rN3vSX28WPdtwQniXwVd?=
 =?us-ascii?Q?YSQB2QAmOzLa/ecr1/sxBW4MwG8J0VFwkWD9s3byGEVkiVPB7W74kZDoRBNq?=
 =?us-ascii?Q?S2AywscJsxvcoKuuoHO3Ne41TjUlXaPulOOlrv9/dm6avZHbG3YF7C63yFyL?=
 =?us-ascii?Q?r9Xj+8frRlqn0iTJmWUj9nRE7CUFC8Xt8mUmXhndovUQnO1CwMe1XJXmG5qH?=
 =?us-ascii?Q?GPb54LHEB1wa2aNLeslVmQPMiJUOyrbrx56NTty25iTgeh/x86zAecVg3/9G?=
 =?us-ascii?Q?BeJQcEFYBxfKCpw+621X1KvHXawjSWuHqzf89ZKz/S0JPkpKQ/pUpWszNikG?=
 =?us-ascii?Q?4rdQw7xSF8Pzlfi35ohji6FqSfDb39iYepMFSNPbi8mN6HssBqfLVqFsF+Kn?=
 =?us-ascii?Q?PZhpD2V2tI/Oj+/UULElntNiD/NyqoQSfPqK7s/xTafuR1JnpkCO8YHkApfS?=
 =?us-ascii?Q?x+fQZTiJ+aODRs7wU1B8ddwBBApCY7LP/wvTN3emGBaCZaFComPxn/dhdySS?=
 =?us-ascii?Q?3hSsuPinnxN0kAoqyDmSZMrILhFAQ7VyYYPV5BKd6IGMcGxq4+OhkMKGEts3?=
 =?us-ascii?Q?wbxxrEpFnWLkhgMP23362sf1/joEq8TjhRIvL+y6iUxLTeoas0XpGmNS3Cju?=
 =?us-ascii?Q?CeCvlCV/PbfBuyugUOlih1JZuXciNw8pwHmj6Om0MuNEFbgqZQLm6RpKNukr?=
 =?us-ascii?Q?g2bPpAuFkK5XZe2wkeVyYDX24LFLSAkDU4G3qr1gsmg1Hfo9bFL/bkDvbZ4c?=
 =?us-ascii?Q?1qmdSeqOBneo9feNjh/xn8lWFv1rHsvj4PwwmbxqK8foYFZ2kGhcIy+0ySxo?=
 =?us-ascii?Q?oxC3Pjag4E50dH4tghuGFYw1SaQfFI4/FVD28e1O+wwd/aKmiYoRwkiAP1m+?=
 =?us-ascii?Q?Fez6gRyX54YaeAtuFA55YAeNd3+v5+tgQBEJyuptkE35d2uuG4HVhmSWQIWQ?=
 =?us-ascii?Q?JMeB9gXYYvLOTP/m/bFqv70USDVYaO+tCQrZQnOCRCFkSHVEdrPjiWfCjPBQ?=
 =?us-ascii?Q?2w8N1nszioq57hG5i0HLD8z+sPgp7sz6sW8QnXEDB59h8gBw1taVY8Ic1lD9?=
 =?us-ascii?Q?aoVxzVOZVO4+hOATkTdVQbOByJusj76n5vlnOZ59rrY6ES0IY5JuuuLk3dDF?=
 =?us-ascii?Q?HFXsXqiw0+F4E5PNaIrsytmFG0HVDoB6agH573Ht3cMee3LWt6LzdL3o8raU?=
 =?us-ascii?Q?thrQnxgSgfT1J42m6WkTwjgpF3rLocpC7zPnfjHEL6aPlveuxob73DggjZCt?=
 =?us-ascii?Q?VaenyOE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WtysL2QOByLhDkzZhmy5XSkqjtJ1nS8UecFhqcnDOBlsXLWSGUdkXionK1y3?=
 =?us-ascii?Q?Dfc4TlDoOdfLyKuE55InNtN1sl5OelqLOA0GmZ+hLuIa5U3IR4KnsT14yQzH?=
 =?us-ascii?Q?PhKLfkMYyOWc8gGb1irSMfPHkxh+YQJsz8WVNO3znpjwt46LpOIas+Qj/afP?=
 =?us-ascii?Q?MJ8cQr1bWUFhhNmSrpsHZJjOVRH8647UW4T9FdlAMwpqUUfgTJGgnYKeb1p7?=
 =?us-ascii?Q?ax8sRpM9RgRDmiXCVyztD+BTICHPwciaL5Nq/yg2qMU5BHqm9W4GTK6D/gsh?=
 =?us-ascii?Q?pj8XVtmwySQdYD1X6UsL4moV9oZ4BTjwjyqmgANhmQl35+UcR5h1khNzVfO8?=
 =?us-ascii?Q?voTOrmcuZIxbA9zgGYVz6qKxqy2ray3CtLeOWeuUev1+KEnrNRf+Jnv1M+rG?=
 =?us-ascii?Q?lItYlCdNqLdWW4bTxgukVN0RfZO6IpwhApsQaj2cl4l+palbJnBvMJK4kODB?=
 =?us-ascii?Q?UbW6o/R2q10pCEBwyYc4qB74cWD7H4O/14Iw4f93MxtnuOd5IvTY8iemZaeX?=
 =?us-ascii?Q?FzH+wB7LOjHUorij0ubWKj2WJAhRq9QVz5mIvm2rfKDWQ7CZ8+grDOVuoWvm?=
 =?us-ascii?Q?CYrOf8vYvViGHjQiZFDntb+bj6kKLqFDVX8Nrx22xZWhz0UcE/Wk/b+WPk7h?=
 =?us-ascii?Q?54Httjx96nxzTFR6LLkknlv6W8xkHPo9dJ0weeCEWQOeIc3MP4lbslcziW2q?=
 =?us-ascii?Q?Wy+L4ulAsyfIkFqLdDqrStvCl6kKxZJy8SxUVo7/X4v6Aap81rLcK+8qH+5G?=
 =?us-ascii?Q?vS7BNnRXLeYNQApVvMantXOSnWT/EOdGMmgrkDNbWgI1C0AjX23js63v3NdN?=
 =?us-ascii?Q?JYCDuxX1lJdTOQ5BPkMNiaWEZ9E3RsPAtt7Yz0OoxBEAHRCdJ/9rEpemUIJg?=
 =?us-ascii?Q?+fGXTuST6WKDUhKc4CzBLaN7tnyt2Zmj7eU0Qd+sWr4swEsOqf+eiwMWVj4z?=
 =?us-ascii?Q?dYdgB0116YJDk4nMerSc18xYFhEvR5r3AC6lV5o89okFf0bPvNQP8nzWO4W3?=
 =?us-ascii?Q?xIiXV7EcgGhNPLeeI8moNfridLFtFskiyJ/Yg0Te2c/h612qNb3t8iijFKur?=
 =?us-ascii?Q?lLQy9r2WuZALrX7iflkovKNaDNqRIa/Hn790vCHIMRaY6Hep9mH0ttBp3Q2M?=
 =?us-ascii?Q?W1HK5e+M7/XYYin6hecikG5OTX3ke2IiSAmqwhcJx1YH6sH8m0/h7jEKn3Cg?=
 =?us-ascii?Q?59qohi7mWobmy0fC+GyJeQIe6fh66Q7+2g4B5RcL+okT29F/FLQ7fuI8Fysw?=
 =?us-ascii?Q?sLm2821eX4Ka2xH2FS6+iEZ1pqNF7BQT3moXOgXt292+pleMWkKET78fQY90?=
 =?us-ascii?Q?HPrt4rhNzQD2MVATBEUXIkPq8KpoV3vjPUWGnhoHlHvoN7XexVC+5rrGY3LR?=
 =?us-ascii?Q?YkKpsmHtVZ+1H6wFdOBU1hCs+QeZLShSMpuXBxDuRjkYTzvZkHm6FzH9qlfD?=
 =?us-ascii?Q?p7UZNAbRNCt9BRU/1a2kctMj/imfozlB7xFSw900KEH7dF7bM/18wyoDb4tB?=
 =?us-ascii?Q?dz6v1upLsXqZILSG5R0T+7bLiM8d4hMOi/JWqLQtA//IM4Ez/B1GHmgXPIpc?=
 =?us-ascii?Q?EQsR2gBZuxYGxaSd19vvjhol5K45ApCM8bwvenHzXyq6LqtOjkv03Y5prFuy?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5b1470-070a-4a64-6522-08ddd3a3a62f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:09:57.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWZ6h9hFyW09lTT7GP8VDG3o0kFH33gDet1XAJi6LRqrv9SL3AnDUeA9JvJ3fJ69LRQMsi85JD2AUNk9n7RnBtZvv7A9oQhfkXLxVGpMO00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com

Andy reports that the "lock_timer" scheme in kernel/time/posix-timers.c,
with its custom usage of DEFINE_CLASS_IS_COND_GUARD(), results in:

kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
   89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);

...with a clang W=1 build. Per Nathan, clang catches unused "static inline"
functions in C files since commit 6863f5643dd7 ("kbuild: allow Clang to
find unused static inline functions for W=1 build").

There are 2 ways to solve this, either mark the class_##_lock_err()
function as __maybe_unused, or make sure class_##_lock_err() *is* used /
gets called to disposition the lock status.

At present __lock_timer() only indicates failure with a NULL __guard_ptr().
However, one could imagine that __lock_timer(), or some other custom
conditional locking primitive, wants to pass an ERR_PTR() to indicate the
reason for the lock acquisition failure.

Update __scoped_cond_guard() to check for ERR_PTR() in addition to NULL
@scope values. This allows __lock_timer(), or another open coded
DEFINE_CLASS_IS_COND_GUARD() user, to switch to passing an ERR_PTR() in the
future. In the meantime, this just silences the warning.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: http://lore.kernel.org/aIo18KZpmKuR4hVZ@black.igk.intel.com
Fixes: 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Dave, I am sending this to you to take upstream since the warning came
in through the CXL tree. If anyone else wants to take it just holler.

 include/linux/cleanup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 4eb83dd71cfe..d8e7d1e5561b 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -423,7 +423,8 @@ _label:									\
 
 #define __scoped_cond_guard(_name, _fail, _label, args...)		\
 	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
-		if (!__guard_ptr(_name)(&scope)) {			\
+		if (!__guard_ptr(_name)(&scope) ||			\
+		     __guard_err(_name)(&scope)) {			\
 			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
 			_fail;						\
 _label:									\

base-commit: 857d18f23ab17284d1b6de6f61f4e74958596376
-- 
2.50.1

