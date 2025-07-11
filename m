Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C822A4DA;
	Fri, 11 Jul 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277810; cv=fail; b=VlY70/RJPgJTAHT8O9ok4yeaNc2xVtnQjpWN8o4xjffF9QBjaUvF0EEfb2x9yZgHE3hiB19ygUtoUbUqMxZDq1v+PU86Gxomf63Nk1NjGY+ynnYGAGgY3fvq8UuJK0y+quZuIT1jFUECS1OET+V1PvtZRiuN17sBGasMPHn94Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277810; c=relaxed/simple;
	bh=Dh/TeJwcB4T742nb1Zcm2YVEohZnEOpXvU+gHY77Qp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RqlFZxgJNEX8aNtlW0Jzj6O4dUryYKqIBblHkfes53/kWCgPvmBZ+EhkjSAFCgI97FnGK6zZd0wSg6GSElOF+K5b4sqbEEW/og9Yop40NC+tAIY0S5FBXC8IQjK3Str3THWhL7APTfwSrbZEDoT4YWd9Q3rKYe9fFN4LxBUOuqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFb/Df8E; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFb/Df8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277809; x=1783813809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Dh/TeJwcB4T742nb1Zcm2YVEohZnEOpXvU+gHY77Qp8=;
  b=ZFb/Df8E5UTHVPG5BvC+/FwDgChnRGyy9pdqLIEwB2dm0+ru/GJU1owj
   joYQ6sxLH3q34pMeC/24MisjhZ2OQmOQXiuuExWbJRGmt33FQvLxtQ4hV
   8fwZiSVimYTZEs0TegtiMLdqrrfXZjQ01cewNEi/CcqJzGikf75bxMd46
   mkCNmk4k8cTIieiENbv4Z5zJDS0jxpyEGLM9glPXsFNNvHtw07cPuP3SG
   4OU6WEOqRST3xkVESsJqjQGwsxKGbkpnsxkroahboRMemY6ckkkTpl6k1
   ANYJY+jJdSfvgfypbkrPdvDuQ8Q6RlyMuhbdUUkUOeqRsohz9/dEz7WfM
   Q==;
X-CSE-ConnectionGUID: cd6bOSp5Q3uHL8/6N9lY/Q==
X-CSE-MsgGUID: rAB8Q9ROSmOHJNYHkHfpww==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54448332"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54448332"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:05 -0700
X-CSE-ConnectionGUID: KRL50I1nT5KDWzteEHLEgg==
X-CSE-MsgGUID: D/Vgso6qTeKrSlPaQs9SlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162160576"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxEqzOzISkSfnWbnw4YYmQkIbIpw2LO5WncbNwrGa3r00LjbeO4czA4rDaqczmB79tiObk/Ve7zTxI23Tc0Glx63b6xldQUYn0Jydb4nv/koLjMOPzKfKCwe+VwUjU5zBF19ut950dveHCfcPi7EPuMx6zU9a5XMow2YUeWGBolonX1cwj1kS86VOuQe//2SPaTrm1z0goCu15uRX2Iru4eZ1KXXkw9bh8FY/zvb15MMDQMIS3lxmz+WeLPMcNPxgx+e+la2/oTRJLA42xl3nu3PJ0RPD3lHs9ERR6E7yXNM6rq4gtA/eSQ/kibYXKGP2cHj6a+VymY0mdweasBHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctXxswtHXGzblP3qQpzluAAt7blG+jn27qt3w6NnFVY=;
 b=bACCK5EzDIunREJpWy0gDeW6DooAAzksQfLcRTwgconyndSJgnFLT75jOa2qaIvBARyGLK/x1eoJiAv6SxABfXB8NeYCStiAjNwswxGK/SQ56gKfY20vpQaGinhcIWKGHozgU5Aqp9KXtKkjzQn+26nUip7ascEnbYWtvrd6yMv6JZvIdlIPGw+s0NqWLUx8BMiiefVQk59TsqhexkjZgE3Pg1CqH17olhudcBwMYabv+jexQDAg1oCm62EI/GqbB3vVm/mFFp5YGb8XP9s9CQcJDfCjxzq9DSW2mHGnmh6rIKxdTO7cMFkDpEkx3J+m5WoKYLXYk0jL0RaGDtMIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 23:49:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:40 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 5/8] cxl/region: Split commit_store() into __commit() and queue_reset() helpers
Date: Fri, 11 Jul 2025 16:49:29 -0700
Message-ID: <20250711234932.671292-6-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 212359d6-5e62-4ec3-8739-08ddc0d599e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g+uUmUvmUjWwiGyVHSU7rTQEOWS/Ol/gMV6DCyFW1QQ+CdGI+/nwfAWm/dqC?=
 =?us-ascii?Q?1qDH8P+efRAgSZ04ct14xYWfyaH9y6r8l4yk37OdDQeJ87zL1IIVLNjNcmh9?=
 =?us-ascii?Q?MrZH+JL3ozhMaavH4B8p5rIVtPIEsoAAvkq02CSCRbhV6oh84McZ6oq48qeo?=
 =?us-ascii?Q?kcBF6iOgqL26SsMxFbeA1QakzrkccSEDxbXw5ret0fqtvJlX2IV5G+HCqzzF?=
 =?us-ascii?Q?hucP3cdEa1WDhyq96EsXlcmwAZkU3K3THEd3NMSb5OEG0lMFxInsWRGXsrZy?=
 =?us-ascii?Q?wJJlOxbp48D2DevbJMunBYt02cP8fyocM4IGOeHV1GiPiGXXVHtKSWqc773X?=
 =?us-ascii?Q?tZcCC07nnCKuNuGndaqEvZerdHPH/NU15nNGrIseSdvDdmhdZG5ffer+T8NO?=
 =?us-ascii?Q?qTQMfmD+F5H4Qz599YnqRc3613szvbxZBbzGLvsMb3VE1orpq6Isz3ppuCNB?=
 =?us-ascii?Q?D/2vpXNQtqt9ROWRLxAD7GBlB22WpwTJIsdmhxrEx8OxIFMBF1BP4B2gs+5W?=
 =?us-ascii?Q?SXVCO92e91Mwsy6aULS5m5fBRXc1WrIT4ifumhIXtTCk913w3Ddw1/Fo3o7I?=
 =?us-ascii?Q?sywDEe9Mnc20dumV6/jUu1Zs++7v1aaAkAmt/lAXGxTv6hNvuJiBvXqNhDjs?=
 =?us-ascii?Q?o9SJ7URpNdISpCnDKBqmJTIEYOtm1JFmp9c/rZ0Y54kfsiMnLnRxeTOjBNhi?=
 =?us-ascii?Q?E7rDd0KgMmXKnIfw4LLaB78hdpqQ07XScfjFeJlqlvhoOL60gNQqGa7IXo8J?=
 =?us-ascii?Q?mCfzWwm9LPrxZh17mEpEx07x5kxCBKde903rJnSXdS9NL/vCWWpF8vcDgFQA?=
 =?us-ascii?Q?3EPKxwTNKLESe4lW/C7WXy1geuCiw6RTd6qsd+GyI1sIwB5sZOuP6GdijZBU?=
 =?us-ascii?Q?WOIp5ZoI3DCMRXg02LukqBE4PZqETuoZX0A3ImAGOgGk/erRMjynRg5PtQ5Y?=
 =?us-ascii?Q?vIjYST9IUYRh491x3/srQ/I2560xKoU/BFWa3ymMoD4V2P2g/VDro4ylB/Pe?=
 =?us-ascii?Q?wlJHofuLyd4yTXoHv21Yn1lAumkyb6Sbz5jnptfsLqzaUTzJvHJM82DytjSJ?=
 =?us-ascii?Q?MFSZyuB57E9J1XvMvxuB+KR0EvSsrq35xvQKhTU/sxiBuvDVIyuWxgdxJBc1?=
 =?us-ascii?Q?7TIQ6YMsPmdUOVLb3G3ULmrMvuNMy0cdQu64l9sUCcYI1MiCL1MM/CHa7ia9?=
 =?us-ascii?Q?0IBP3zCkFepMswqQtL++8Odd75cIl9rNKJwZa5Wcl7N+ljqrvOxL4GyOnk1Z?=
 =?us-ascii?Q?a+kIIGFrAnrB1BqVn5axyRYEWQJdeiR5L65W22SDF/6tZP85PqUme3PuZ9R+?=
 =?us-ascii?Q?3I2kdDvNqUSGsuwy6PLo3nD9ArgTf6tRXiNQzKgrbG8bDKog4D5y0nm0kIOU?=
 =?us-ascii?Q?hh0a4snW3z/KhhLp/AXxdGFjqGRxITjOfO1K1qRCMFGZrWOgciJia68ibljh?=
 =?us-ascii?Q?zQrYwSVWx8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQZoPlN4JC6gZFmilIeyT5KkmOk5oNEOcDcH7ViurMtGL9YZt+YQ9ytnDOJ0?=
 =?us-ascii?Q?WOcGjYdMbk9lE9ZpLIDUoLa4XufoVwuT+Ks1k/dRwGxuXHhm+4fVmeNFaxau?=
 =?us-ascii?Q?VxqmQxAvfhbf837fF7Bs0LpJ/4b27KCAY6QqCkHEOHthfPbiOajJlifrCMuO?=
 =?us-ascii?Q?s+jFLDdHjLK0jnWAHq/kFl2fGMjGV2q+b/mngp0DOrHwZkXBiQRi0ORzbYfu?=
 =?us-ascii?Q?Sz7hsnIQQ/fst8Jcex4LhyvyHYBMJ/5o6CZe0CS568KtTD39ZILv9xABtnMK?=
 =?us-ascii?Q?Vm3o2eP/A+xtriIHDaEB+L+myFVQvlSgo3c/meTObPPyANSeubm7tfekkVdA?=
 =?us-ascii?Q?XuHJkOVb6u5ZIjOKqD/8N6pAuxLD+oTSdIFRRs6c/4awPgAYmCatQemWP/W7?=
 =?us-ascii?Q?2BYzFgkFcsWk1sxnUq/t9Z31VX7DgK+WhAQUucaNhra8F5yMXtUdyMNQVk3h?=
 =?us-ascii?Q?z0WTWFAE03RbtHqlnO5FXcLa+M6x9zbJfpb7LSRWglNfLBafl2ynpSG0ukl6?=
 =?us-ascii?Q?b2WZO81day6ukKHmVwh/28+Yoye+PV/QKV0rTWDoAvQSviS1K27clAXwT9DE?=
 =?us-ascii?Q?2c4IgE6pxKtCvXcYBVy46BWRjTPLWUU3K67TJdVM523y/B6lgvhNy4CU3FLJ?=
 =?us-ascii?Q?7dyG4oaWz+u0qogj0DSw5F2O7kHM41cd1m2UxjzaZYTH6EWZad8/FOWhKta2?=
 =?us-ascii?Q?wjknIZ5PLENoUHmrclPjpuN44mDp3jouY4C4yzqyVUfm6go2lj5nOG+J2RhH?=
 =?us-ascii?Q?mqAlwu6s0OMwznIJAC/Pb2m/KNes7vJk0m87Lygg/R/Ttt/GoLagHxWkFzH4?=
 =?us-ascii?Q?eBFUMTmCLNocr3juUAmQ0R3w/7zUK28Zebb2IsHXN8mjXnTNL1Lst0KIjYRm?=
 =?us-ascii?Q?7qCWsLUxKhHn6hzbbJZ0Sjkf1g4M5Qa6DOSXXOAWKlyHwcTe7qhGTvSCaaQ0?=
 =?us-ascii?Q?4AzaBXq/STMmsKndYErRnuC13rcxnPBp5QSoWIVB+jYN8fFMnrdf2FagzM2q?=
 =?us-ascii?Q?E1hMKVyop9UGy0yaKWZeVuInOxpjMOgLJ9mLSjBcojIBCIJjEUrZWL3PV50j?=
 =?us-ascii?Q?SwYRjMKSp1mcGP6Aed2R534ARPRsVWiIVtK/09j49jiKn9EENu9VDQA9IaCA?=
 =?us-ascii?Q?yd/kunxNO619Lk+IjkDGHNIJiezlZWAGz6i5Cnm474ffRX13gqY9+i8UJSr1?=
 =?us-ascii?Q?D2ubocvmLhjUyIJeL408bJuc1YH+JdWq7sDbWumBMcsIK9qe4fGLuR2s/IqZ?=
 =?us-ascii?Q?EoZ/IuBSXiBHtCpWIz5zbq1uUe1zloDYAB8Z8y6lWQ8EJ0aDoFu3c1vWG/AS?=
 =?us-ascii?Q?XxEV1o4tIrRj0hZXAr1hixFlL4+Xemtvn2EOyicOyeJcGya4Adzda9E9JHFL?=
 =?us-ascii?Q?crfHVX9lah7pw7Bcoy1v9iBMIqoVpdc9sIMuRMHmy0yyD7xmLaTtvVZiE5QA?=
 =?us-ascii?Q?Uu0k07USn4SjwvwVo9yt6HRMpI57xy83G7ANXTCfKnqvHFfVtd+UGUiUShNV?=
 =?us-ascii?Q?/9ZTkZN0Ms64L56cTF3g2b/R+RKeAEanM6pk1jRShFihSBwemiyVtx9nZ+AC?=
 =?us-ascii?Q?aVYuC3/tVA6GOsVUsfdEkbDeR4moh1Ib2ov9SHr6Hgyj3uCw01VELIdTMdwz?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 212359d6-5e62-4ec3-8739-08ddc0d599e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:40.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1onOBTyDEdyLYzCnqfgR2wt+B8PfVN0FKIc9Y0Dh/0er6ST0/+k4LdJiO4Y2vlJ8f/r1JuXnFAQ1bIP7IARuw++x000nQExKf0fLDzNawXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

The complexity of dropping the lock is removed in favor of splitting commit
operations to a helper, and leaving all the complexities of "decommit" for
commit_store() to coordinate the different locking contexts.

The CPU cache-invalidation in the decommit path is solely handled now by
cxl_region_decode_reset(). Previously the CPU caches were being needlessly
flushed twice in the decommit path where the first flush had no guarantee
that the memory would not be immediately re-dirtied.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 99 +++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..3a77aec2c447 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -349,30 +349,42 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 	return rc;
 }
 
-static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t len)
+static int queue_reset(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	bool commit;
-	ssize_t rc;
+	int rc;
 
-	rc = kstrtobool(buf, &commit);
+	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
+	/* Already in the requested state? */
+	if (p->state < CXL_CONFIG_COMMIT)
+		goto out;
+
+	p->state = CXL_CONFIG_RESET_PENDING;
+
+out:
+	up_write(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static int __commit(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
 	/* Already in the requested state? */
-	if (commit && p->state >= CXL_CONFIG_COMMIT)
-		goto out;
-	if (!commit && p->state < CXL_CONFIG_COMMIT)
+	if (p->state >= CXL_CONFIG_COMMIT)
 		goto out;
 
 	/* Not ready to commit? */
-	if (commit && p->state < CXL_CONFIG_ACTIVE) {
+	if (p->state < CXL_CONFIG_ACTIVE) {
 		rc = -ENXIO;
 		goto out;
 	}
@@ -385,31 +397,60 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		goto out;
 
-	if (commit) {
-		rc = cxl_region_decode_commit(cxlr);
-		if (rc == 0)
-			p->state = CXL_CONFIG_COMMIT;
-	} else {
-		p->state = CXL_CONFIG_RESET_PENDING;
-		up_write(&cxl_region_rwsem);
-		device_release_driver(&cxlr->dev);
-		down_write(&cxl_region_rwsem);
-
-		/*
-		 * The lock was dropped, so need to revalidate that the reset is
-		 * still pending.
-		 */
-		if (p->state == CXL_CONFIG_RESET_PENDING) {
-			cxl_region_decode_reset(cxlr, p->interleave_ways);
-			p->state = CXL_CONFIG_ACTIVE;
-		}
-	}
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc == 0)
+		p->state = CXL_CONFIG_COMMIT;
 
 out:
 	up_write(&cxl_region_rwsem);
 
+	return rc;
+}
+
+static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	bool commit;
+	ssize_t rc;
+
+	rc = kstrtobool(buf, &commit);
 	if (rc)
 		return rc;
+
+	if (commit) {
+		rc = __commit(cxlr);
+		if (rc)
+			return rc;
+		return len;
+	}
+
+	rc = queue_reset(cxlr);
+	if (rc)
+		return rc;
+
+	/*
+	 * Unmap the region and depend the reset-pending state to ensure
+	 * it does not go active again until post reset
+	 */
+	device_release_driver(&cxlr->dev);
+
+	/*
+	 * With the reset pending take cxl_region_rwsem unconditionally
+	 * to ensure the reset gets handled before returning.
+	 */
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Revalidate that the reset is still pending in case another
+	 * thread already handled this reset.
+	 */
+	if (p->state == CXL_CONFIG_RESET_PENDING) {
+		cxl_region_decode_reset(cxlr, p->interleave_ways);
+		p->state = CXL_CONFIG_ACTIVE;
+	}
+
 	return len;
 }
 
-- 
2.50.0

