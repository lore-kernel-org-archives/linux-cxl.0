Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B799922EF8
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356580; cv=fail; b=TRvU/lUDRAL8AOJX2bki7c2zT1gUJVzeATE73KoqWlYBQ+97amYs+dvC817SnTTdsWOj/SHQUz74Ah/O36q6WHPYx/WcMzqSc2G8v6mq10bF+6sfoXQlCV4KHgXza+b4YqpKBhPODa6MDLD8YYRi+N8xSDdmWzFaYWNbEe4HXME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356580; c=relaxed/simple;
	bh=FoMzJ5WOsCLnDyfVdJJ+gzJrxlsJJkP8ZsHdVWz1QfY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AZP81PXsBLcsBqza7bhnDJz00l4erk+zwckbwZBztMRIkYEikHr7BNklW0XKSF+K5qDJbUs8ChaXPeGHOlF3CccEPSZ/2q/CpK6dv4IQV9/cXaN2C/im3hMJspF7dKIN9f1wTRlSQTznhc5DCxBn6J4aeVNxQGsTt/6nnP9Db0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGoHvfhv; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGoHvfhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712356576; x=1743892576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FoMzJ5WOsCLnDyfVdJJ+gzJrxlsJJkP8ZsHdVWz1QfY=;
  b=MGoHvfhvqLbKVXKPw7sOCckEk+QHOdxK7Weoyk4zB9rQ/OzQd5o10kam
   MZw/Y6K46+JVN+R/8CCNshmmJicBS9pfPaPuCSk+Oq1ocwFJ9BpBXxloq
   KQhqCOfPWMTIrzQ8mlVXUMp0q/k4a/h8bTiU/jo+BgHgmFuwWMm7b6cYJ
   JNYZjUM1pWrF9PaaQSutOVBNr0rvL0t8EE74r69DBER3nuie6DxKAY7wt
   IdePeqXfLc7eCGZ9GhO78wT6OfAdyW4gcf1O/+upUwviM89nmyKMpeXvv
   dhZgmAmgm6+LZyKFyiGbHXShWT6N3PkCMJ+ZP8WZCXKSpVkVx1UYE4im3
   w==;
X-CSE-ConnectionGUID: 17Ci0k0yRgKoI3vGJ/2e3g==
X-CSE-MsgGUID: 4r63sX0NS+a0T5tl8eZbvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11478470"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="11478470"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:36:15 -0700
X-CSE-ConnectionGUID: tbI8u0sIQyGhtYItGKORCg==
X-CSE-MsgGUID: Vu4Sl56LRyex8xIBPBnOcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="42483412"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 15:36:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 15:36:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 15:36:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 15:36:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koa2hos0bpMZBDw1pTihnV8GtobvJ41CTfv4qU0ItTst1mtJo5IbOf28naQOAl36YNT1tnafZUchHpp+Hm9vo+ojz9Vf3sQoL6nGo880vwDyIQE84vy2JRiym8OxC+0hvu7V8JOGytyq2LP5IvawG44B5vogsa0oKyr8P7QKWSwmU9ungMFwcEKWaE5LcoP+UOG7uKu/nWyPUNFIgseyHAh7HAoxSkQ29QoMb7LN2Qb9CYZXSHD45plxt/4jwIk4fiMgtAHEt+4tB1wZtdZfRap5JA3UA7gzOR5VtJPDeZ0SzBBwEOubS5PXwLahz48CTBtcrRWTL3R6gmfnc4j3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlIKG5YEvzUur96iuvfx+x5JWZcZjRSh5P2xV4CZf7k=;
 b=mL3wS83BVNH9EllBIBBMCWQP0xreP2irHnaOVjX5H4c+ibuHkXFd822EmA9TkPnG4a9cysnzUaghg4aV/ArQ2a1aZ/Rj7UH8PDoOX3fzn4ER/7JkQiwCB0OsW1sVak/vpMPu5yHqAhqT3tDHOKl1X4v+Dr1qmt9EsQrDSmKRU48KPwNLHGxDjGQv5DOgGMEzlpCE4o3RFNtQSy1eYMmjl6m5I2d0AUIvpZvNRhg9xUp800XHHZ52OUc/zFr1vPluJKnIREzBi9bKRczAfS5B1BhZAvPeNGdNHTRFJqvrf35lAhHk6vkuFJ0z347nLxTONS6VgP84j48U90ueQAOOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5969.namprd11.prod.outlook.com (2603:10b6:8:5c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Fri, 5 Apr 2024 22:36:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 5 Apr 2024
 22:36:12 +0000
Date: Fri, 5 Apr 2024 15:36:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v7 5/5] cxl: Add checks to access_coordinate calculation
 to fail missing data
Message-ID: <66107cd99f69e_2583ad2947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
 <20240403154844.3403859-6-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403154844.3403859-6-dave.jiang@intel.com>
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5969:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0dEnyOPdyA5M9PeXlrMrA0wxbVpofvJnCHn+Bh2zgef2y9J4rHtsFksXiLy6op7+MeNhipouxnEXBeddZjpti5yGtA8TTR2HRiffjEbUTvMLR1ldz4yr4YBy6AIE6Ysy38GEPyPk+XVzCKKsR0xy8CCu1y5mAKr2BghJ88iuH4piZAn8Vkkvsxhytsnha1v5CgLWqkeGcZOtkvmMfltWNX73Kjw3c82OyNgRpzMtbE+pG/wchu4gcTYOJZlV3YBH/ViQIWvwAXXYLVTsRMpAgIcUYBLBBvMxlg3XxcxmE0BwmR+9TgVVwUdC2NjeMVg5hA3WQbHsRnJgyHgvIqs0S6xIZdDP9EWlhZbH91efFf8IJS60vNjLdDZK3yzo0rOM5B3oq7LC+jBjmgheuoR4aG3T1mKvooNHW33vE5V+6f62yvkBan0Z538y9aGjfjPWiiW1zM2TVJyh/iep2N24+qHMgjUodeEbII2OThdhtpaMVCOIjzrK9nT4rpg4qol/N/KD/VPlAtXh9P09K7m9iYYHb7DDWnP6v3Xy4yQIC3evqOomKiJ4y3q6Rr6KkLjYHO5hih1jh5oadEzV/PlAXsy/9si6hQKudnttuOmDVS4SKu/SvduDwThTotI7gIhVAFmo/UlgbIBN8xVRwhkcT4fiBtiXV6xIV4BV38vo7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lt15g26iHnUvltk5PCtY5rV6x/ZztmDfVzHE5uuUOGwfC4OYemSk/TDnmRiq?=
 =?us-ascii?Q?CnJwXU7INzJbtK6qp5RLK1QQ8Zte9RHAZZtMevPq6y9GprbrYZKetjg65jX+?=
 =?us-ascii?Q?wjdMWqSKbQG8pE5FWq2oN0SHjP6mlqQ1gI0KJWv3u1ignSKJKjFcq8AsbcKQ?=
 =?us-ascii?Q?lKZirpK2D2naN9y8ZWicf9kGBUCrY7bV/PDba7x0uPVS1X+W4DIZlPMTcio4?=
 =?us-ascii?Q?wyKSoW6VYd6n3lyPeUJnTMuzzD4KyJqzYKVGIGMz6ecXaDcFSny6wLMtio7q?=
 =?us-ascii?Q?tuzDnVxVkv/y773oAph63xeb6ZTsusMYkKanBe5hzBgBaWYpdIE7jeygBer+?=
 =?us-ascii?Q?P/troirKYKxX/7mxXeQpYwCtR7b4M3vgEiA7ieSXZNoDOHRBMit8xzk/9hql?=
 =?us-ascii?Q?C2L4ceLyCb7YYJa2uvtA/SUyGbIYUZB4pU4SV/i+g182Ro4Mlr23p5iD2CZf?=
 =?us-ascii?Q?E0eEgvHc4HAMTjD2/vsRSv858zWYLiBlHBQDCWBn8rfVTaa/70Cn3S33cL7+?=
 =?us-ascii?Q?fxqGi/dRCEaokQIHSOurP8YI3x+cZPe7fBDj2C72DugTvWWxBF7GO6iswjRt?=
 =?us-ascii?Q?r6WqnbrQliAauQdxZ2Kite+NB6M8BaW6/Wi9BjdB1KULF3Z1L/oNP5N7YCZg?=
 =?us-ascii?Q?Gi/PpNoXoU+QDm+S9U1Xk0oSCApFWhPFHF1jOYiwTmI4HFJehr4a7M9W/8fQ?=
 =?us-ascii?Q?tuhejcBlExZOIynGUsdLmJcOd5zMkTgf4c701XMk5px4HQN4guDO2/rcPpzp?=
 =?us-ascii?Q?yYlm2Fgl/Qfr0vflAgcz8lMM+xBMQIFuyw1xU2ellO9db4N6MKV+m1VCbvxE?=
 =?us-ascii?Q?ht6I5JzLRYTiyD3E6zx/9kgombarRlb6P+6wqt7PB4Ak8TcqPWVN4MsNj8tP?=
 =?us-ascii?Q?B/dma/JkI9CZQ1Ml356lemQrpIudt8jqqCQtzaKasF3iuYJ+QyiXZFzPkJId?=
 =?us-ascii?Q?sMyO7fOiUQ4LVetx8TszTAHqLyEXHt8C0a7lD2bWpIrCd4MrDjVGXBTO1W+R?=
 =?us-ascii?Q?jpp8tgDicda0yF3y72NEMExkKW5GFoxWLaMSyerCr5buzrZpEQBi+KcGzx2+?=
 =?us-ascii?Q?Dgefo8b7xiIq2iEYhU9MQ+c1K8FY+T0dFbT1n0VGS5KoHLfUp3AJdmWJNY4x?=
 =?us-ascii?Q?HXb1zPoCX+EbDT8G5nMqd6kGHj3yFmEgEZ+E/tLzSIUJoPmZIksPrJ8OKqPU?=
 =?us-ascii?Q?2tvEz2swUb/W3tKFvJzxkIa2BXRpp5Y4uZJ34ktzuYNZIrMxLRD4jje+RwIu?=
 =?us-ascii?Q?y1VSlRanghkVRwQ8GZQGg8M5io2ZnymezNpZZkHXCd+0Z1d/AEuGApnivqKh?=
 =?us-ascii?Q?bAbJwjGwtGqOU2p2kNqjsGhyJ24661Q/3bAuN7j0SXATikeW4x3vHu+9MP2a?=
 =?us-ascii?Q?IduIhGNAkPORWoc3FSRwwEB1HEclioYgkLovY203L3XW688SuJsUxZNnYQoF?=
 =?us-ascii?Q?trC1Jeg3a2EpSyCfv74t1uSyq/8MKkrGFk6cmtyFltqKdEoktI5Oe7Un4Gqx?=
 =?us-ascii?Q?uHrLvFeAyVK2VrxDzY81DrBAYp/uigdSdR1yzfxx7Fq/w92wG6LN8F8AubmV?=
 =?us-ascii?Q?FBm3ZFfo3xA9uDYCVipF7/1ZN2AxoAGdUREDXNZZdC8D1aVPTa1lydfZ0aAU?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fef7235-cd91-49a7-30bb-08dc55c0cba1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 22:36:12.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJIroFse6XmIZJx31VaRZLegBIJOCm0KtYuR847GjzscKZ1wz+uSiOyYU1I4Gol0f+dVNA71L2MXyW7TqXPqC3P4DPcKBA1qwRO6miYl0B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5969
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Jonathan noted that when the coordinates for host bridge and switches
> can be 0s if no actual data are retrieved and the calculation continues.
> The resulting number would be inaccurate. Add checks to ensure that the
> calculation would complete only if the numbers are valid.
> 
> While not seen in the wild, issue may show up with a BIOS that reported
> CXL root ports via Generic Ports (via a PCI handle in the SRAT entry).
> 
> Fixes: 14a6960b3e92 ("cxl: Add helper function that calculate performance data for downstream ports")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
