Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9612ED869;
	Thu,  4 Sep 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757026219; cv=fail; b=qnU0sTgf50WlGQJsqul5kUOXypAkO+l7jkXTpvAi9qywPstZYhYojM3VaYYGxQe4nhEejyNPp2N5VUlUkIDBGWjnAtRXlTq0mdvLFGh03X2ltooJnkGNMI6/vIF6uX+L2OMCC28r3eWlQacCCoQZnbcR56i/wgwkQ4NjGZLC6R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757026219; c=relaxed/simple;
	bh=VbDE/kRSFXC+wWDRXrFulNdF9bNXzD7mO0u+ToILiDk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H012H4q80tsvvl7uiophh1pFbU7cMymgYD9u38bqX5MBxkKVRXEaKtZus53r3o0Zg8ab0LnD+/43dgKu+GZ8Ub1IDqM7hPFk6rYAbRyjkZATgCcOYgKQJ9cdrDEZoPLv0hgpMswQbCkzXNONCIdwWwrIDXklgwi9Rt6dxTM7v6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+qUj1dH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+qUj1dH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757026218; x=1788562218;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=VbDE/kRSFXC+wWDRXrFulNdF9bNXzD7mO0u+ToILiDk=;
  b=P+qUj1dH73xw/rCiOBIK+Ez4pRP9YVU0DY/gWQ8fIWEYGbl6sjvO1SyM
   AFqooZNWH30Rx5Jvzhleae+u5Og9TWeUXKcCwtmouLYbBMiOntiYt6vjW
   xGptB0+7MGh1MIKpZochTPAl4Y2QWwaxL4gTNg9ozUHVBZBjasfeZrywT
   +clI8Ynfu+Ky1iYxETO42yFraHFYoAOgjaIh4XzRwyqZ03ZbI1wISF1Mj
   wZ1fIlgf2bNBAZ/HHeiA5nk57cqY/jI2Pr60WAhU3wv+fDWP6zIE3zSkE
   JPYeM/jRQkvzE6fBFiRYSUgchhVRCH09k9t0/AO72Of2TbCVh33GkKNC/
   Q==;
X-CSE-ConnectionGUID: Qnwzv3W/QxONPjWRpq7clQ==
X-CSE-MsgGUID: /816toyiTPqWjfDq3ODjcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59301025"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59301025"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 15:50:17 -0700
X-CSE-ConnectionGUID: XoRaMLIzS+CrpQKMzVIS1w==
X-CSE-MsgGUID: 3UM2hc3USGSnDlvsj48t4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="171905255"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 15:50:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 15:50:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 15:50:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 15:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeKxAjgGEuCRrmR/AXsPMxq+zkA9k4SNKIAyOouHJ2bgxM9pK2D+/6a/ROFmw2ML/ev8uQnD4CRGqTdvtaQsntO99oZgxKl+EccLOZJURFS4IHrxhiLDTvinzsSsogQmEl9gr478f+DNVCA8lRLPf28v0Cbx4bqCtrEa2AUBd5nkWCsaHWpflO7ZZoqB/5LwMIiEY7l2quABTdytkbdhc6/nz4/vXsPQvvNgkLwMvm5netyjvIivB40StooY3NXYlHafN8/zNB3h+hYpmZ3vqSh9lP2UB9fLv21xlILCwuQMoLmmHTNjYYwgHR4OxoDzHmCbawD7dTcBCJJrnjAo7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ps07zmFKFxT/5HW0/qSPZan45yxEDZoyJs365Irs8c=;
 b=QYadtmvDTSh4p+dmY0gOIJ9qhR6fed3RUyXCRM/5w7Vm9X94fF74yZf8G5Sq8yHjr6dXp+bkTZm6ojZXq0tSYQi42D4HSMhd9V33kDkH11BDaMtg4PZfBBCPy8o+pcAmEGjQTuWVPZKuDfBkaUXYBiwnK5NcsfmZ0DY08Ynnw2KPqgt1Y355JEMiD13SVelBgzr2+njbyin3oi6jyScnPa60FPq2YL3Bw2VhRX/6Tyv33iUw3oLzE2qLt+dVhdJB52bZZ687WNnGFkx+DLElBT4cui1hCOUfaG6TeJ2Uus8xsldMfr8Aw7SHM0WxVxEJK1VsEiOSSLeEnW31DZkeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4728.namprd11.prod.outlook.com (2603:10b6:208:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 22:50:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 22:50:12 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, "David
 Lechner" <dlechner@baylibre.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] cleanup: Fix "unused function" warnings with conditional guards
Date: Thu, 4 Sep 2025 15:50:10 -0700
Message-ID: <20250904225010.1804783-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0365.namprd04.prod.outlook.com
 (2603:10b6:303:81::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1c36f6-40bc-4184-34a5-08ddec05681a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9kBFGJqU/8IoIWpK8SGOfrbkDRVlPZqzidJUU11Krb4VDWfbS3mdROTfJrwk?=
 =?us-ascii?Q?O6z23r0RyIJ2ichwL71GKkdYTmgSvWDMfvuqj+b+Wm5TWp6jXFuctCxnAryl?=
 =?us-ascii?Q?GfWLTHUYAj/+/rDIH6wk43SaIf33llYe60dikmrPEhIR5x31R/dYCsSiWUUi?=
 =?us-ascii?Q?frdST43F+A8xpJDE/9Jzw6ZIiHYbVQ1QobZkOPcnDB/of7bgdQWQtxtPFgH3?=
 =?us-ascii?Q?dTAkypE5HNUAcEDbb8uw0mk/BT+DN1hwRsMODlttlg/0gpn68z4oqbR/DdFh?=
 =?us-ascii?Q?DaJJO9/thH9j+AAjq8f4LUkTcCMZW1qzxziTWD3wyQwO6vQZ9HqMn4Wy60rY?=
 =?us-ascii?Q?Tain7iDeQC9BnSHc79TdrLYhEamYhfj4iBS/D1cfbB3FtXkFpePPQSs3XYTf?=
 =?us-ascii?Q?NImNy/o6t8HDWzPpiaF/2ZlKAJkejKb5E3crUBcURPcWp4MizGFxKa+Daa7W?=
 =?us-ascii?Q?erALR/Z+Al26wprpWPzdLMjtTGNRWqZ6QNjAoorX4CtUHKG/wn3LHFCtBFAS?=
 =?us-ascii?Q?u+R0vL68Pu/cwB0YMXD7XteW/RM0UvKceitft8LKAf20SS4+jqAB0Vizhhh3?=
 =?us-ascii?Q?YX4VbORsjqyn3ptFPfz0C3WvshDnLKsbl0K7kJ2qI/amXukCcOp5uMqyIRlj?=
 =?us-ascii?Q?GVBdLMKBrWKX/0lvLyQb4CqDMZXwyJ88bq8O0BjnTQjurbL/NedN8JkxxUKJ?=
 =?us-ascii?Q?Qja209rJNQ/35nDAw2W/RQ6jEo+W7VyDbRflOeVqBKX8lfuc1tcnhBBtIpxK?=
 =?us-ascii?Q?BcX/BxWrGa20GZAqOL3qklTDFykM23BtTwL0HAEpbxLR2HryIQebGcsnW45d?=
 =?us-ascii?Q?THHpBy0Ml+KUxC4HvqZGyWskGHaSKwnIaTdhuq9/s3L5EDywBj+hazUY2/Ch?=
 =?us-ascii?Q?0pNMb2+1NSO6F5Xm3AjInv/iymM0ndT/70XneKcT4fJrXZ5e/ljASgeewj/Q?=
 =?us-ascii?Q?CxhUpyoMhJ4QFZv2ErU8RnjRl6WjrtW/XZ2T36un7eRqBk1PmxftzjJDvdBd?=
 =?us-ascii?Q?lRskC22uNn9HHJm3CJCZNJ9FPrHdU32AT3h5g1HRCk1qaFX6JXsbhx6l6N22?=
 =?us-ascii?Q?3rKmCcU4SxZSbj5K5BKvXPdndsDfcoXQO9WJ2HmJ6wVH82Wltj126iSAAMMP?=
 =?us-ascii?Q?HL9s473Ap2MxkiFQl+qFnMh/4TWv7S4je1LQGZsmczGn88JZO2db+OaMoKLA?=
 =?us-ascii?Q?aHMNPctojvsPkOUzjPoBl0xNi8kQWE33RZGvg7kb/N8TND8B6RaD97EWQnnn?=
 =?us-ascii?Q?Ss6BAHxQR9ROMTsiPwx0pPl0orIWR5BaSQmUAmy4Tc37MudNLKHc3TqmGxph?=
 =?us-ascii?Q?SR9dJdTbTST2OeTfNf/k/qjSnsVaY18QrtEBHExqYkByHV+BwiOw5fHO3IWB?=
 =?us-ascii?Q?/0dvhgRrYPPwA8FBk4GMpQ7E74xX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K6eycvbryAqqCmAZVTZioruE8lw3Vq7xWQSiFgP5Wk2+Ip96sGlpNQfPSn1z?=
 =?us-ascii?Q?MMAVnuY0GEgbjolYDQqgIpGbospxb/m3y7dxo9wvfV/epqMG618SDHcc77E3?=
 =?us-ascii?Q?PXMJs8DEqZgyPc7NpagLtqWbL/Ynpcxpaa88lE/kVLjWR4asnzv4UDouuPzT?=
 =?us-ascii?Q?vgYbCv1fQkd/aRlT7i5BJLssctPutErJ65UeYQtwtQZwweevlsS/zthUMvNy?=
 =?us-ascii?Q?n050EE9an357QXq8snt9TivMel/YSLJLiHxoZqj6pyJSs+KPnRY3Zgt17HYV?=
 =?us-ascii?Q?lcgXwMn30idQvzyhXi/g72tBk0oSPgDS5dXVVqeX3ls4zMx9AmWrCcoDEJsr?=
 =?us-ascii?Q?OhbQMf1bK/q5BlxIsbCocoCzWpZhwO7EPATCOqVj8CmJL8ugG1i/yjDRAOdW?=
 =?us-ascii?Q?jZMJU5F2FJmLoCvEAAsrVH1drZBpXNeC/uMdOVkszOYjMYRHYmGvfQuplpRc?=
 =?us-ascii?Q?v9AAummFAUhfnOkPtrXVjl+kqD/AaoG+2/UmkBTPs/PnB/9wKASQHUExJGnC?=
 =?us-ascii?Q?QUdYAF55ZD8THIQynbfCgmIZL7Cz13QDeWezGs8hRQOsmrxNNoDDp2kC+3LK?=
 =?us-ascii?Q?gdkvZSB+tghH4r6E9YSZqbQf3bdbxFCO4cPJjqf6PXpxJqosf94ee9ZnXnN9?=
 =?us-ascii?Q?fAt/g8ebquB/ijziWJs49p5FhLxw9ixJ5iZpHWg0oUyOj+N7wCW8KgTaziTn?=
 =?us-ascii?Q?9iljaqsr4b1GtWps0zrIq89uOj98zAoHn911Ea0E4Dx/UXcHHES0+lBBCFFb?=
 =?us-ascii?Q?ppZGvRpo3J0lyU1U6v0h58lhPMBD6ELVNl7IBwmGQxozzI1Ktt25uVh8Nd9j?=
 =?us-ascii?Q?n8Hbo2f8hyXTjxCKMcVuseBemdRAqJ4K6vAPGzh6Yez4YjGmFzK65/SJXatp?=
 =?us-ascii?Q?UzZZ+pLVauxntZXm4CE3F1yMbH6iDdEmYqeuWcgqXQHKYAfNIOUQf4LWMC2e?=
 =?us-ascii?Q?dhMJYRplKc6wNYsv8bq8nMdlDami9H2SVNREqkKj9nxucyPLP6WSXaq8y+yS?=
 =?us-ascii?Q?uR7ZRXrVklnh9TzzSpdA/TZYBbp7mowVs/3oF/2eO3rOfxlG2jyOZclKCvuq?=
 =?us-ascii?Q?btYlQ5U8l8gen0vmYBBy+ar0BaI3H1+GPtsTO8biLYtUO1h3oNNN02VNTiBf?=
 =?us-ascii?Q?e1OOIH4xbRX7T0t2ZjCvZ4yqgSI8mDP3R0P+7WdQOwNjch64Pp0/tloujTq/?=
 =?us-ascii?Q?hST+FkhhnbboJdFHdqBva8l7lx3ZadWcoHBSEWSpi+uQg1PiyXqml7fbRMu2?=
 =?us-ascii?Q?N+b5l6qqNWX0ckXQ56m2I1DrjywbX/6dKy84WOnt25PbA0MvgZfHw0DVTL4A?=
 =?us-ascii?Q?NaL9psABL+9ZkqsVWOxNbJ3ZyXYVXGYHbugm74AcRa+yR7ozI2t+lxK/j9oc?=
 =?us-ascii?Q?NhcIWM+7Fr0g41y0hDK97ssNjGtcR0rsSAzGM6fP8eCraQfV+8SO+dFQ8Ymk?=
 =?us-ascii?Q?r/SRqC0heN0pQ03lIc4OWEo1GUZl0/YzJdapxcWP4nmi73mCWHQtnYejiDcW?=
 =?us-ascii?Q?t0xIU8FYBOE/rb4AMVWJb41Uk3+jHu6cVL+C2rdfhM7ld5eedlRLKxVLKJUz?=
 =?us-ascii?Q?+sVuU+Wz+3gVEw14A3NJEbdqzd8yEZetq8dKSx0JGv2wEx4ywfly/NDQ6/ik?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1c36f6-40bc-4184-34a5-08ddec05681a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 22:50:12.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDTXwWJWz07MNa08xPO24Us3+x5Hy3yqN6qow2ujN5SyPlqK5yc8Yya7LO59AF+7/3wlqLvdFqjGjMWQx7/NjzpF67772WZCLNRU/tf4/0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
X-OriginatorOrg: intel.com

While the warning could simply be moved to W=2 [1], there is some small
value, and not much cost to fixing it.

The issue, Andy reports that the "lock_timer" scheme in
kernel/time/posix-timers.c, with its custom usage of
DEFINE_CLASS_IS_COND_GUARD(), results in:

kernel/time/posix-timers.c:89:1: error: unused function 'class_lock_timer_lock_err' [-Werror,-Wunused-function]
   89 | DEFINE_CLASS_IS_COND_GUARD(lock_timer);

...with a clang W=1 build. This warning has some value because it can catch
when a conditional guard is defined, but not evaluated by a conditional
acquisition helper like scoped_cond_guard() or ACQUIRE().

Andy also reports that plain DEFINE_GUARD() also encounters this warning:

drivers/pwm/core.c:54:1: error: unused function 'class_pwmchip_lock_err' [-Werror,-Wunused-function]
   54 | DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))

...which *is* a false positive.

Fix those 2 issues by teaching scoped_cond_guard() to check for error
values, and otherwise teach the DEFINE_GUARD() path to mark the conditional
helpers as __maybe_unused.

The compiler does change the polarity of some tests, but the size of the
binary is identical:

Before:
        scoped_timer_get_or_fail(timer_id)
    1246:       44 89 ff                mov    %r15d,%edi
    1249:       e8 d2 5a 00 00          call   6d20 <class_lock_timer_constructor>
    124e:       49 89 c7                mov    %rax,%r15
    1251:       48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
    1257:       0f 92 c0                setb   %al
    125a:       4d 85 ff                test   %r15,%r15
    125d:       0f 95 c1                setne  %cl
    1260:       84 c8                   test   %cl,%al
    1262:       0f 84 85 00 00 00       je     12ed <__ia32_sys_timer_gettime+0x15d>
    ...
    12ed:       48 c7 c3 ea ff ff ff    mov    $0xffffffffffffffea,%rbx
        if (likely((timr)))
    12f4:       4d 85 ff                test   %r15,%r15
    12f7:       74 0c                   je     1305 <__ia32_sys_timer_gettime+0x175>

After:
        scoped_timer_get_or_fail(timer_id)
    1246:       44 89 ff                mov    %r15d,%edi
    1249:       e8 d2 5a 00 00          call   6d20 <class_lock_timer_constructor>
    124e:       49 89 c7                mov    %rax,%r15
    1251:       48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
    1257:       0f 92 c0                setb   %al
    125a:       4d 85 ff                test   %r15,%r15
    125d:       0f 95 c1                setne  %cl
    1260:       84 c8                   test   %cl,%al
    1262:       75 21                   jne    1285 <__ia32_sys_timer_gettime+0xf5>
    1264:       48 c7 c3 ea ff ff ff    mov    $0xffffffffffffffea,%rbx
    126b:       4d 85 ff                test   %r15,%r15
        if (likely((timr)))
    126e:       0f 84 94 00 00 00       je     1308 <__ia32_sys_timer_gettime+0x178>

Alternatively just merge the suggestion in [1], and call it a day.

Link: http://lore.kernel.org/20250813152142.GP4067720@noisy.programming.kicks-ass.net [1]

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Closes: http://lore.kernel.org/aIo18KZpmKuR4hVZ@black.igk.intel.com
Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Fixes: 857d18f23ab1 ("cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
v1: http://lore.kernel.org/20250804220955.1453135-1-dan.j.williams@intel.com

 include/linux/cleanup.h | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585b7f06..b3a7f6b2142d 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -354,26 +354,30 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 			_ptr = NULL;                                        \
 		}                                                           \
 		return _ptr;                                                \
-	}                                                                   \
-	static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
-	{                                                                   \
-		long _rc = (__force unsigned long)*(_exp);                  \
-		if (!_rc) {                                                 \
-			_rc = -EBUSY;                                       \
-		}                                                           \
-		if (!IS_ERR_VALUE(_rc)) {                                   \
-			_rc = 0;                                            \
-		}                                                           \
-		return _rc;                                                 \
+	}
+
+#define __DEFINE_GUARD_LOCK_ERR(_name, _exp, _attr)                      \
+	static _attr int class_##_name##_lock_err(class_##_name##_t *_T) \
+	{                                                                \
+		long _rc = (__force unsigned long)*(_exp);               \
+		if (!_rc) {                                              \
+			_rc = -EBUSY;                                    \
+		}                                                        \
+		if (!IS_ERR_VALUE(_rc)) {                                \
+			_rc = 0;                                         \
+		}                                                        \
+		return _rc;                                              \
 	}
 
 #define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
-	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+	__DEFINE_GUARD_LOCK_PTR(_name, _T) \
+	__DEFINE_GUARD_LOCK_ERR(_name, _T, __maybe_unused)
 
 #define DEFINE_CLASS_IS_COND_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, true); \
-	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+	__DEFINE_GUARD_LOCK_PTR(_name, _T) \
+	__DEFINE_GUARD_LOCK_ERR(_name, _T, inline)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (!__GUARD_IS_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
@@ -430,7 +434,8 @@ _label:									\
 
 #define __scoped_cond_guard(_name, _fail, _label, args...)		\
 	for (CLASS(_name, scope)(args); true; ({ goto _label; }))	\
-		if (!__guard_ptr(_name)(&scope)) {			\
+		if (!__guard_ptr(_name)(&scope) ||			\
+		     __guard_err(_name)(&scope)) {			\
 			BUILD_BUG_ON(!__is_cond_ptr(_name));		\
 			_fail;						\
 _label:									\
@@ -471,7 +476,8 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
 									\
-__DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
+__DEFINE_GUARD_LOCK_PTR(_name, &_T->lock) \
+__DEFINE_GUARD_LOCK_ERR(_name, &_T->lock, __maybe_unused)
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.51.0

