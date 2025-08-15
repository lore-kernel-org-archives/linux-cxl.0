Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8B634;
	Fri, 15 Aug 2025 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220274; cv=fail; b=ltT7ev+t5nStnjxj8xJpZuWTECC3YF2HfUn1TA/QzGCzGw8O9IRrDjwAgKM1IAbggjqCvAa1OfVos0aOXlukoJKDucwJBl8vtHZafrSsLV5uyWJRByNzSjsn9Pt6/12Kj/1yO7eXjOSdkKhlG4Vz3zFeAfx/tJf1xaKbmxA1aTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220274; c=relaxed/simple;
	bh=VHCAFJ0ZC1ACIg1FwW4TAmydrekPSAOLPIfrnup0s9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dNE0ywSAVI1UsZJra5Kv/hW9X0WpitniZ8nthV25/tpTNOfvH/c4FCodP5jvdHFKn+8Ytmw23ZFbhDA+OvJgMj0Xud6Xk6HeT5mlc5FljjTzyXUlZvB0qZIMB4D6qZbC3hpgYEHRN2rBjV3YWuAwUug4xfo+qu/1PMaDmlLD5Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrM+Eqag; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrM+Eqag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755220273; x=1786756273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VHCAFJ0ZC1ACIg1FwW4TAmydrekPSAOLPIfrnup0s9g=;
  b=KrM+Eqag2M79W1n8grqwFNYTlVl5tRlA1SQLNxoE5UIQLpjdH8GrTAN/
   lqXkG/60TV4mqlzW4AZEOop9SgqlwR+IS9eSAxsdNl3Je8J7EsYGbAbBz
   uYjiSaMMovrP+I0Ohzo6lkFRATR+UohUVpJURDxE8RbajmeGrz/TtRGIW
   cLR9YMV2RcqboYMEwPGtTXmFgmyetoy74ySk5B518K+yYc8XaW0Kp1PW9
   RFpPn6ol/A2rQIlSKQ304ECo1/S7tEkOP+Sr6D342uqC9xn/FaqUrIJm4
   1g4ty0sQNIGIjchGeZhELTqujVpq6sxWUJpdaSw2rVP2QyVBqt9wdVf3i
   g==;
X-CSE-ConnectionGUID: hi0puhE0RJy/GfPjShw39A==
X-CSE-MsgGUID: KyfAUhNdTYyjNWWPgATDUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="67817025"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="67817025"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 18:11:12 -0700
X-CSE-ConnectionGUID: o+E8M4z5TQWNOYXuNZj/Ww==
X-CSE-MsgGUID: N2diCMcxRe+E/HplXlJ5bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167708545"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 18:11:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 18:11:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 18:11:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.55)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 18:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtCLoVo1kgDpvpVgbrcYzdgX14Lnfp6Rc5wQPbB2eSRshYHx6UoCnJG3rI+YAWu8oLgpsljm69jZ5xk4su1l2mXsCBjr72OjZYw2XiOu0OqwyLtzhnU2gGzBQ1Peo2MSZOfv3WkFCZwohJh9iSmpZPkt1QRah4HDsAijeAid9c76+i+22GsIkRfwH2bb0AkDX8J1v67mlNp3bE4rPKgs7/gHS8rm7l8y/knMcReELx357u4jaxFf7hpaXt2JklAc91OhXbD72/GgPTLy5F/5m2rXUQd9K24Hz7lvTGxLRTtHTQ9hFC/5zlSa6CYF+Fok2lkIa8Bjae1XXxhaRxncTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmspy/xbVDcSPYQxtt32bW2DOxTEoCyXRA/27Wjp06o=;
 b=ovyVFt7BqNB2/0Aq90t0Ag2quvs4Q5IR9+CLldXpU8HfaxQ/oyX0vSQgSaxxHaTXNeSpu6MGJtQAgN9O6tKHMl0E0xGRwmbe4uUIxk8x9GBajrKIb3YPvQsqKXYwpdCwCI2isoaKeFFPEuLhEvIS1gTcIzzLF5jFCQRyLkNxLcbeLU9cx5YXkM62K9Zw/vxcxCVX/9syhAmhZVEiACE9LSSL7reBKawI+5uNnxuWkntyVyjcmlt5+xCh3qC1KyeEEcvlPrWh3QV+u7uCBFL5RdIYASruu5yzOMF0JaGfcXjo/oY0+skYKCy9ZhGRj1ZsJBbd4+eW1xCyxN85srGCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 01:11:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Fri, 15 Aug 2025
 01:11:07 +0000
Date: Thu, 14 Aug 2025 18:11:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] checkpatch: allow an assignment in if condition for
 ACQUIRE_ERR()
Message-ID: <aJ6JJ8H3qrVd9Hhs@aschofie-mobl2.lan>
References: <20250815010645.2980846-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250815010645.2980846-1-alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:40::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 188acfd7-22e0-4788-fb1f-08dddb989d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nyrNaUKsP4c2mgBW0zxxj0EBu4H2NMTiVWH88fv8047tIf+/rdCTTM4VBlU?=
 =?us-ascii?Q?Cuh5Xbi5nGzHwQxc0tVdY3vtJD+akaBD/w7r8qCURgNRYReOrv3WgLpeE6AS?=
 =?us-ascii?Q?L3RdwWZ1SoJdf4CWnCmdBTcrwNVpklhYiI4zdEeFLOKK8LuaVVyOgNdj4leD?=
 =?us-ascii?Q?I4KPN1pvSRxDisLNMqQZqXfyln+RYOcgpRliEHSRXlS6m7XGE1FB6jdlXLVD?=
 =?us-ascii?Q?I/k+A4Of38aIiRhd5KTGgnZu3IDO6hW6SHMmnXT3vk/8MwctYdUmcDxWV6Gh?=
 =?us-ascii?Q?JIx7AaT4DxQruxz4PVd3A2OE9drgQhzzFtITowP7CXWe5BZfPkp277sgPTUW?=
 =?us-ascii?Q?DI3Fe+LrOzF/gE+h0Up31YejjhVNcPrsuD96+vF+W5qFqZom/530FS0qbh+X?=
 =?us-ascii?Q?pfrATQ4cb/0frQdGSfMzyW6Mqt7HUstATxppmFq7pZk6UyZ4dRofer7UXYUb?=
 =?us-ascii?Q?GL3bxha27GiRKXU6Ggd5ndjoVioOO64CJvITXp3DF23JMIkrVwQ17NP+BkHt?=
 =?us-ascii?Q?IN3bJgHkJ6ZcUEtGqAYPlAeU7Ny45DzpDQiTaq5f6bAgPDs7SEyi2MfLOUcc?=
 =?us-ascii?Q?kbb5VGHjPj93rQBXIWHCFzPIhQAPEdjHZIT15qPJ6EqV6J515k2Bu0t9zONY?=
 =?us-ascii?Q?MAK2ysB4ByfbDZKnWwT/hCy610/qKhm/fciCGiOowy2o8etaE7lzsJ3j9vz5?=
 =?us-ascii?Q?H+Gcqf3ReFWcu7L5hO4PHLFwM0KeT895CK9h7K/hbcgysAF0eme8Esdh94dg?=
 =?us-ascii?Q?wpGvk6rJh4VeQfiJS2DnUIriq6pRCj+gzCkTWTzElE1RB135pkfk7L99bsKu?=
 =?us-ascii?Q?bQUoeQhwhoR1nI6xaXazt26nuAWi9lT9jK5hEXrIvuIiB3xcmjDDPsKWsgHb?=
 =?us-ascii?Q?P7bd68jqfl7aDvDh4iOJ7KwKvAvkgykv0vTnatXcDo/pCvLRKeJfYZARsTJh?=
 =?us-ascii?Q?+S0EYtY/japp1T79UPn+xEyTOHyKZCU1lQvI/l0a6NgLwB7v4g2shM96XkRH?=
 =?us-ascii?Q?fQwulF/5ox+YEheIQlU75Ib6zBD7BnVBBMTYFSmHjQ9g1QKplTMfTPZqCOWv?=
 =?us-ascii?Q?iBitcdi647F1EKRKZDpvZSdrgYEcIFxngleHSzROf7cr6TVl8AcOrBcQd8aV?=
 =?us-ascii?Q?y9viSw01TJs52484k2ktI8qGxnh9gISpvJ8O/t/nJm30ZJGYWDdL2oYAF+a2?=
 =?us-ascii?Q?TDXBEasxwo8/CS42AB3sw647LLV/TcCVoCRviKh6Q20QY3R38IuQ3FV+v6uk?=
 =?us-ascii?Q?s/4SMRd4m2rS1izJjhb1pR2CqCwQMrg4k2i6zUeF935/e2hvjoCLfNHva+f9?=
 =?us-ascii?Q?Ztm7LSyns83bxhxtz4N5CFULRGM0xdhTiDOfLY/v5Ff/AbrhRaDa1GOAjypW?=
 =?us-ascii?Q?QSD7o1dCTZEPTgneiZc9ENxnpZAO/YT5aIAshOYsr32q1cOMwgBaTUGe4uMf?=
 =?us-ascii?Q?H+4vZqo2u/I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBtG0NGpDijY84kUWyHda+3u42+IEx+HtSvAbQCcTBqorNYm7ZicmW1tw+ur?=
 =?us-ascii?Q?8YPZ0Va/XhkA3oJoUOSkIv+jxNEytRBbRoCfRi6vrbyhTEaSKgMXLQOxTm7P?=
 =?us-ascii?Q?v+yu9vpz5bVVOeU65FXZXnzIompTFi7ttLxLm2upRIiHXq0DweLygED9MH9b?=
 =?us-ascii?Q?Y9uCYXE3lgvIwzjTqw4R0rSg7Km5kHU0f/haSijh3KhzMK4TnIP8ghOkfTNm?=
 =?us-ascii?Q?ZJeoxe+N+RfxkSJuKnu03N6Hx3KcxQPmLqNYOXKFvlkDInP/vU/F0/p75feo?=
 =?us-ascii?Q?i7Ow5ZOPO2zX3fLp9pvn9Sa4JV3dpInYVfS0aHK+0L7I0QkoMff37cdQJiwS?=
 =?us-ascii?Q?3oAMqq5a2k2ZdHlP459icvkRKtMr496teCCpdvN0s0QafkXQcF5qSOJhBEFf?=
 =?us-ascii?Q?XEcNl7WSrCCEpxdgaCMQN68Fainl1P8VStrj6s292NKkshhc3PTtgsNqItDw?=
 =?us-ascii?Q?5bzeQIPWWzx9/abLZuVsjugIQxe3pLjSMwaFpU/u8rwW2sS32rnAapicTcmk?=
 =?us-ascii?Q?cAGttAV8xenyknbW7TFLlzPKVsC14dZdNR7W4H9ClhLHxP3wlTphF35EzPLH?=
 =?us-ascii?Q?EnreGosf9X80qfDliCnCNEhBxioQUY558zbX5cdxMwIPjWzEqNSz3TkQtIcS?=
 =?us-ascii?Q?F8gXkugwYmiA743aC8Jcc21S+bRrnA8dfptmB1CGU0P9Y97PS2pwYlMVHoHC?=
 =?us-ascii?Q?DbE0U+xtkwA43sP/iZiIrSkJw/EZZkEz9sdsl/3kl6KXNh2NlrsBj71R4HY6?=
 =?us-ascii?Q?8WinbOT63YG/cE8FLCGXP+4iRR7clFFfzqPHX7+gFvShWywfWW7jZyRxjAb9?=
 =?us-ascii?Q?FWR8BGPRL2XWljFhVfQdlhe02Jwl9FijTKMZsk0+0X4h+sy3Cdx1dmJz3yMq?=
 =?us-ascii?Q?sDja20X+uA5A1LzSidXNxJB+6BCdRmOYPd/D8Bnqc8ON9UvO7vktxL8vKwXV?=
 =?us-ascii?Q?S0rcq4N86ItqMTEwxvz5wcsuvurIXoprWQLvLsDkuwdy/CDNbfn6JATnvben?=
 =?us-ascii?Q?AimWeAltCld783mxehlBSCk/rSHaILWGzl0ehn025kUYU2mbHy+CTBofAneb?=
 =?us-ascii?Q?brbKOoTxcySHA/2yh6qQMLH7Qh1UlAaYD5ANJRYmYme4NMsHA+rWuO8XUFWS?=
 =?us-ascii?Q?7sP4VESTPRbd1xVoF0AyZ+o+dL/fqPuNmcIi4lGF0XKIVP6PHgesGlJ5tz5i?=
 =?us-ascii?Q?jennvUhG2F+N9qTbybGKNxZy8eddeBEdk17Tbo80pQB9N4DH+TMAJvMEC4PL?=
 =?us-ascii?Q?kVGkCXa/3dLlm7dftbUj9EaSW70yEOxIsoD4D+9jeiT/rNNbyaY+OXDgy8p6?=
 =?us-ascii?Q?go6KMOK6cSxnuAnZGGzMhFYDZhGkWYBHVW94XunL5R6xpmt3FjCGErXQIrvY?=
 =?us-ascii?Q?mdSeK+k69tUhpDeL2zhFtleIoTR3OGCH5vj/4V5Jg4V1OLQea4pfgoEYOZe2?=
 =?us-ascii?Q?3s1LHqOnb7+uZHmwu9Vopt68gH16uoUH0KageObA/8SMovBN8YAWTxSS6v1Z?=
 =?us-ascii?Q?RYsAb18d75bjtNgOpR9Ea0ulCYdm91STkvqPeEmsD9PQPagHQgU4GW/RRiL9?=
 =?us-ascii?Q?yy2ojX8zfFrcoJZ8GW62hDPfgs8cC5X5CCXotqVSMeyWYTzYBXx6Irtta+vA?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 188acfd7-22e0-4788-fb1f-08dddb989d13
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 01:11:07.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/YGi+L3bpSjPP+Fncrqzfi+lLlPB+4WMYBbFwMTKDIBfWLangJoGdDgftHLAAEuDougMKobDgM9BRgQZFOtY4TkRLIdYdhzy5QeT88ldi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-OriginatorOrg: intel.com

On Thu, Aug 14, 2025 at 06:06:43PM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>

Appended is the file.c used in testing. It's annotated with what is
expected to pass thru vs trigger.


/*
 * Test file for checkpatch.pl ACQUIRE_ERR exception
 * This file contains various assignment-in-if patterns to verify
 * that the checkpatch modification works correctly.
 *
 * Usage: ./scripts/checkpatch.pl --file this_filename.c --strict 
 *
 * Expect: total: 16 errors, 3 warnings, 1 checks
 */

/*
 * Valid ACQUIRE_ERR() usage patterns that should be allowed
 * Should all pass,  no checkpatch errors
 */
int test_cases_that_should_pass(void)
{
	/* Basic ACQUIRE_ERR usage - should be allowed */
	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem_ptr)))
		return rc;

	/* ACQUIRE_ERR with different variable names - should be allowed */
	if ((ret = ACQUIRE_ERR(mutex_lock, &obj->ptr)))
		goto error_exit;

	/* ACQUIRE_ERR with longer variable names - should be allowed */
	if ((return_code = ACQUIRE_ERR(spinlock_acquire, rwsem_ptr)))
		return return_code;

	/* ACQUIRE_ERR with struct member assignment - should be allowed */
	if ((obj->value = ACQUIRE_ERR(lock_type, &rwsem_ptr)))
		return -EBUSY;

	/* Different whitespace patterns - should all be allowed */
	if ((rc = ACQUIRE_ERR(lock_type, &ptr)))
		return rc;

	if ((rc = ACQUIRE_ERR(lock_type, &ptr)))
		return rc;

	if ((rc = ACQUIRE_ERR(lock_type, &ptr)))
		return rc;

	/* Multi-line ACQUIRE_ERR - should be allowed */
	if ((rc = ACQUIRE_ERR(very_long_lock_type_name,
			      &ptr)))
		return rc;

	/* Multiple ACQUIRE_ERR assignments - should be allowed */
	if ((rc = ACQUIRE_ERR(lock_type, &ptr)) || (ret = ACQUIRE_ERR(other_lock, &rwsem_ptr)))
		return rc;

	/* ACQUIRE_ERR in complex but all-ACQUIRE_ERR expression - should be allowed */
	if ((obj->value = ACQUIRE_ERR(lock1, &ptr)) && (rc = ACQUIRE_ERR(lock2, &rwsem_ptr)))
		return rc;

	/* Comparison operators - should be allowed */
	if (rc == ACQUIRE_ERR(lock_type, &rwsem_ptr))
		return rc;

	if (rc != ACQUIRE_ERR(lock_type, &rwsem_ptr))
		return rc;

	if (rc < ACQUIRE_ERR(lock_type, &rwsem_ptr))
		return rc;

	/* Function calls without assignment - should be allowed */
	if (ACQUIRE_ERR(lock_type, &rwsem_ptr))
		return -EBUSY;

	/* Regular conditionals - should be allowed */
	if (rc)
		return rc;

	if (obj && obj->value)
		return obj->value;

	return 0;
}

/*
 * Should all trigger ERROR or WARNING or CHECK
 *
 * Non-ACQUIRE_ERR assignments that should still be caught
 * And, cases that pass ASSIGN_IN_IF, but fail other rules
 */
int test_cases_that_should_fail(void)
{
	/* ERROR: do not use assignment in if condition */
	if ((rc = regular_function()))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((value = obj->value))
		return value;

	/* ERROR: do not use assignment in if condition */
	if ((rc = value + 1))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((rc = ACQUIRE(rwsem_write_kill, &rwsem_ptr)))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((rc = some_ACQUIRE_ERR_helper_function()))
		return rc;

	/* ERROR: do not use assignment in if condition */
	ret = ACQUIRE_ERR(lock_type, &rwsem_ptr);
	if ((rc = ret))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((rc = regular_function())) /* ACQUIRE_ERR pattern in comment */
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((rc = regular_function() + ACQUIRE_ERR(lock_type, &rwsem_ptr)))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((rc = regular_function()) || (ret = ACQUIRE_ERR(lock_type, &rwsem_ptr)))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((ret = ACQUIRE_ERR(lock_type, &rwsem_ptr)) || (rc = regular_function()))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((rc = regular_function()) || (value = obj->value))
		return rc;

	/* ERROR: do not use assignment in if condition */
	if ((rc = regular_function()) && (value = 22))
		return rc;

	/* Next set should pass the ASSIGN_IN_IF check but fail other rules */

	/* ERROR: trailing whitespace */
	/* WARNING: please, no space before tabs */
	if ((rc = ACQUIRE_ERR(lock_type, &ptr)))   	
		return rc;

	/* ERROR: space required before the open brace '{' */
	/* WARNING: braces {} are not necessary for single statement blocks */
	if ((rc = ACQUIRE_ERR(lock_type, &ptr))){
		return rc;
	}

	/* CHECK: line length of 150 exceeds 100 columns */
	if ((rc = ACQUIRE_ERR(very_very_very_very_very_very_very_very_very_very_very_very_long_lock_type_name_that_exceeds_typical_line_limit, &ptr)))
		return rc;

	/* ERROR: space required after that ',' (ctx:VxO) */
	/* ERROR: space required before that '&' (ctx:OxV) */
	if ((rc = ACQUIRE_ERR(lock_type,&ptr)))
		return rc;
}
