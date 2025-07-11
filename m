Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF722B8B6;
	Fri, 11 Jul 2025 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277799; cv=fail; b=OBLk3FNILNjLkGslNwluaWYX0GHjMr4birCgqgI8FiJXg41TozlHUnt0VY4loJK8zz8UirowLsSamPRcolIKzn01xwycV2/glsFAgYdfUg9yzpr4gOZYB5anUlaTMhJ9j+3auayAwogqEDXzTSEwZ5obCorxtaZESgHKGfp2fQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277799; c=relaxed/simple;
	bh=ZWDjpBrvlTIxrFWwetHChLjHR4EXmNGsL9Hdo2ueBNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zj1LC9Quda0dAKdBhSCPMp7lnWTVUqFla8RxD/0ghjezkTA8msH8+Mvo7FsPEC98NJ5rx8rLK4iRclgFY64HvqmzZygce/b6+NFXSbxv8P/5nNkqogUrsK1opHrLV9meduM7jMBnE0qA7hl9dfQ31zu1aHP4yqFKAOX+30CQVh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqyWDkQf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqyWDkQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277798; x=1783813798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZWDjpBrvlTIxrFWwetHChLjHR4EXmNGsL9Hdo2ueBNg=;
  b=TqyWDkQfx8Q/9iNmknPnBdulWrebhuGwn04n4y6AXyaChGoXGPqKk5wr
   PjmJOdAEYJxl24FzaD1tlpoT9hB/5h5BiKAJQQUS6KWyvbEM9jaIdxoQY
   XrNrvLhhyqBH48U0C9rWKJTGPnDS4Red/6/5iJOP1WRwsHL3GfMBAomRe
   b6OOH0QJ9X59ODN5pYEzOAqVJzgbcqf9ZuRA39gwPmqcaKCDducZt9kNU
   vU6ASgPO/1QI8D3t4jQ45YnNfA+a+XPGv5rqkJrT+62sGZSHTcUJ6v0Dy
   4kqMazEzmp2fu0lBWuRQSi9AW/hW3j/n7ZLWnMJblGUaw8SjalBnGNloC
   w==;
X-CSE-ConnectionGUID: nv9hS9i8Q3WIRuOZeXF4Cw==
X-CSE-MsgGUID: 1juGc77PS4ufzoF/FyBunQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54448317"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54448317"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:56 -0700
X-CSE-ConnectionGUID: 9CX2diFCTauda8SFANVkYw==
X-CSE-MsgGUID: NbkgpAc4SMSJCqLDpG+fqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162160568"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE5DGwdN0YrhN9+kzrRoqv9ab8zGZj54q6BdifrSRTX+HkIBpPJp+OH0fYybwvSCOjaLO1z5s1PTfTjMQTxilA0uGuLKTXGJnAuXg0fAgWpQpD14iITkfGTq664Vcvm1PxiK93DFIuQ7raJZ5KuFNKyTjMWkneu2TT67kHkjwTadZMK3ifH7IuNI9uJsw9RqJfaMGqVPZIeZvQVAVpX0G5nVSup+2QKb6U4N4YaBwxP9vGs4Q1R6AwaqgGYtTXaDOrxo+BM48e4OKK0e2AxkXkgVzF0BnZo6F3MzCCgUPF/6MYLe2zebi7ieM2s8ZkGvLbKiLs+eXIEL6mi8SNxqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4l5a5drc36br//4hsrVqT6OtxNqOG9z7MLn5wHHSh4=;
 b=Ej7R0J1k6VU/RJ1UECYrjASWCV898fKQ3ieTKhkP5+2lTdASOlvyRvaagRJhrXdPEy7Bh1MVxlr78aNsIeNeqiTylOgNbe7OahyLXo9gunT/S5dU+qvPpK39j3KgjOBpACxanwYEWDOfXUPzjmYR9J3W4858OzjaKmGLp9qj4n/R1EdAAH/N73UfQCRuCml6rMAOnwuoaGrLsb9QmC1dsCwK2K37JvP0KPpKvh5D7GhqpBJm8voypJgf4UVCLX2jNiOVuSbAqRVa/p4VkyXTq8k68IGeB7n2rPkCapwn9neb0F/J2iIS/DDAZPOXN0D8G5KSi3EIjYWN2HxL20kJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 23:49:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:37 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 2/8] cxl/mbox: Convert poison list mutex to ACQUIRE()
Date: Fri, 11 Jul 2025 16:49:26 -0700
Message-ID: <20250711234932.671292-3-dan.j.williams@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7342e607-6cef-4502-f801-08ddc0d5984c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pzZTyMl3J/HFMHlQkIVaL9y9JQWM6emk5HT/4n/7TXh6DaDJ1zKfiUzv32E2?=
 =?us-ascii?Q?N61Z+uEer9P0VCMO3Mow9Q/4tJVoanCj5g/YoP3Z1RMreHyD0ov4m9G+Cwcj?=
 =?us-ascii?Q?ZaEkMeeHCLgKoS5jVmyPEWCKRt2s+Ix4vLbQZTCG/Vfl4SMEz8okHA58QHIa?=
 =?us-ascii?Q?4GaPfzwkk9FxM0S0J0erwwx0lK84jBf8e3vcb1z/tYmWY62KmZ22Gds3ZTG4?=
 =?us-ascii?Q?Gd/4/vbYvpIi9L8Ti7PW1T/IQs6UMIwjBIC5dnzRcyAnto+8u3n+nGiVpR8s?=
 =?us-ascii?Q?ROZrZuf+tmx5luUTde4FO72HbwJ9xFaVgrZLXrnko1Ebp8kjyQdpou9ncKzd?=
 =?us-ascii?Q?MxGN8kJ1XfBM0+cpk3DUdn73xAyf/y6a5F34hSIX3zwSbKNul4dev6+M0RLw?=
 =?us-ascii?Q?hAtWSwsuB6RFWwbFDG0HZpztBNLuRODJPoxXjlVMJrGmULuq8d5H0Kzx0qfr?=
 =?us-ascii?Q?bNxQdY5/OMPGuXwN82rDRrWKnnqD59bwcOBrbOxilGxLZOzdYyKLPGE4Wat/?=
 =?us-ascii?Q?ErVVLO1/uM7itYlzrIgbezrEeIDlMZIP6zYGlNOq4Yek8GsRRWjQ6fyd7QDU?=
 =?us-ascii?Q?J+JZu27+jmg/2iqJTmdjCerTdhT65VjSmsuKw68pRGAlX4w6WmAFxq6tgfZR?=
 =?us-ascii?Q?d70XntisvFzWJ66TPNdaQW5cv2GhbRwPmRInF+eax1lwV31vXhL10IKGQZpl?=
 =?us-ascii?Q?FT88H2MEq4HFcEPF/O7zX6tOFzDpvJj50w8tMXWUZOw1TFLBzUi140Xr7lxx?=
 =?us-ascii?Q?Piese1F3c2dMrSlfkHCIITvm6Pu+oezo88oCO+FSYhgZPz/JV7fjgW+Y/GwB?=
 =?us-ascii?Q?FxhDnpUuPyjb47JS31nhF0L2LQqYU9M/xj9OyJJqGcgPMoIQXItHHCvFy72T?=
 =?us-ascii?Q?5ep251dqlsT9Ha6n+ljk790quocUbWPhJ9yMli3H3VjppELWjifBtQNb/B7E?=
 =?us-ascii?Q?LvE3COiIbqDYh16NNrg+uRq6HXPUn5uKecJsnRVzeZHl5TziUkfARnCuTvqj?=
 =?us-ascii?Q?BUXdSIar1Sxi/xl2HjXqdczhmPrSmInnzAm9bV3FXTsCfWiQK0b0BKpbqq8n?=
 =?us-ascii?Q?seFQW5Z5mLpA/c0yxvoJ00IqXyxfuBCPqQcL0UtvW+IOD6LvJZkkbB1iT2um?=
 =?us-ascii?Q?BqMz/gKH6kVZlomBVxiuHwqyxXdBfpgzLNOp1IcNmqRVfHT2IJHN12quA+1f?=
 =?us-ascii?Q?rc2/TLqaodamcdGha0eVaS2qSt9c3m9/RjLzlahw6ZWG3yC1rTNz2tOnqC/U?=
 =?us-ascii?Q?u4L9hq+Sg8emnsviJTIs/rjmR8K4V8VishxaYeBxzW069S+yIs8C/Cnp5hGh?=
 =?us-ascii?Q?7O7hI94cx9DzbVuR9Vjwe8FROFuNf8fnfc0vxQUyzIV8POu8sUpOGdTrbQs8?=
 =?us-ascii?Q?D493Gj4O74srEAMuJOBBKU0t9NNzLuDFwHzmm3glSdv/+QOLw5eGY1gsjfPr?=
 =?us-ascii?Q?UyjvxUAzxJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ynlpkpx1QRJwtl1UlUiqbQBUwIqHvfiPctdiAtMMhULdANVFUHM8McNJknsc?=
 =?us-ascii?Q?Ji5Noz+vps3E5UhS9NUBiBlq9VnP1edcZkQsn8BPCNTH11vXMh6rtf3Wc0sr?=
 =?us-ascii?Q?nC8ge2DQHVNg5IJwGEaBPOv+oBgqwa3APo+3BLHBZDU1x/7t+MObVn9844cH?=
 =?us-ascii?Q?v8KNfWStLkt9XOH2rcFbvRcR4FHAwW74I37uQQfC9RFQIDeGug1u2AROctHC?=
 =?us-ascii?Q?lm2J6OXFGnzxwEJ7IArqQdw7PKGYXLf/4fhR5Z6De9DtWQ2nOY9IP9JjVpAb?=
 =?us-ascii?Q?c1FBP4UhPWs8rcaIxUgATAgTz3oVgfnlpdkdD8lQHJQKuF/F3SitshfsQkiW?=
 =?us-ascii?Q?kHc+daTXO8zzYKFIgtnMykiIf/jBzRw2jLFs38I6R8b02fB9fYTBL2jIPCBo?=
 =?us-ascii?Q?qXXvHDQCJ3CjBFGR0rMHN6nd4/VzGNuJTC4fC0wwvQdhRyiM30wFFfG1ES12?=
 =?us-ascii?Q?SL8j3R/ifimI1yeVSaXhkFAC2wI8MxLuOAf2hysWyxX/eCPu4tgFSkE/lN/u?=
 =?us-ascii?Q?ED9HlxoEdfD4WEjgDBZDdcOb0pWqQNEQbGwPRQ2+vh3la5WlfGcuj6CGuDc+?=
 =?us-ascii?Q?C+wgwKS02rE9i0wrXQO4CEwAp4E7Ki/+/NmPHlqoR/7BztVrWIDawx9QAk48?=
 =?us-ascii?Q?dClC0ZueMpkfAj22AV1w6cTLv/CbL2CTAw2bDLgE2JDYY23ty49SBBHYarZm?=
 =?us-ascii?Q?tndI6DMUNgL8O8fNxavw7kEuH7lg0eBSDLNXrt5zGuYRwKVsNQIRJZBBM8FX?=
 =?us-ascii?Q?rlMKyOTxPFywsXGsMBjAYc11nM46mEZpw44fOawVHt8RjKbknxGA4jcwh+rX?=
 =?us-ascii?Q?pjFB14gEnocA6vzptN/AZAqAEGLGc7jbmznGbEkef1TybvUAb8nYe1wIadHa?=
 =?us-ascii?Q?m5dx9utZlUZbztareSk9vVutHvsJMXWKehG621mzv3IuQBdLmO9YxHa4cIUB?=
 =?us-ascii?Q?OceE7EDKjR+yRESqEkTC5LlwHXzfo51I614jKR5Bt5bH7DISCq11nAcufe+u?=
 =?us-ascii?Q?Qzj+G1/sQ8n7b8h4p2233r4JUwS0uSSfrE8JPohZKzYiQll6hSfpdPowrpI+?=
 =?us-ascii?Q?UYt0ryzJ4dAJzdIe43egwEWhWg8kWJ9d7iWTdt9oys9S4DkqXOtthuGy65sw?=
 =?us-ascii?Q?RZrH7Nqarpv+CyaBUCd9aHgmtH6hn1l0MEKLBuZRFaXukCiP879t7Er5siiG?=
 =?us-ascii?Q?ZyqNCWeeToPcZYX293CVquaQB1I9l+qnFjVkCOLB3TMGcrH64Hq9Lqk8+Wrd?=
 =?us-ascii?Q?KO2pZeHYp/s0YR0hDCQwt2bFltjqaVGMf9eZDWYhm+tuvYMd5z1WVx3HGrNX?=
 =?us-ascii?Q?sSLwnjUKwOZUrgZVt/dacmp3TeQ7b9co9y9cXClUyBM0sEHWsBDttVegHYsE?=
 =?us-ascii?Q?acg0uIAeP5DTNOs73fiCaAdwljSoi90VbZAI/r+B1tdXhmt/905SY71Q782c?=
 =?us-ascii?Q?P+rlRJ0jRZ8Dab4pPSwaszO0ZcQdU15ZBapFM6PcoOZ5BURE9P88PuOBIvKR?=
 =?us-ascii?Q?4WcCwOgGhdD2kbaXJ4iR1nlD2jagQNTgIMCitWCNIhtfBvCTtGZNSO/hmtdC?=
 =?us-ascii?Q?rg3P+e0OcIEFIjyK4FHrv/yTgeP+J8Ps+0iVc1oWcLZ2o/t1JhT2C1BTq1SB?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7342e607-6cef-4502-f801-08ddc0d5984c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:37.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPUZlpIzKBDBDFa+e/A5zN8f7BRmP76iBUKipXpx2n0YMGylPD6lJCAH4FmtokfcLFICnEVGCpuRLOT7kEj7xUCHNSI+WiGKmJj8dAeuY6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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
2.50.0

