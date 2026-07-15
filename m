Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7F3B6C13
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151796; cv=fail; b=Y6Xah2/FV814fwAUndkw7yDaEMzbKcE9nnaickYlVa7Mp7v+ubh/Oh2PZgG73qMINJ0aHjMFMeWVQ1NZ+oGr6zVjkyh9kKK+mv0xG+qfFF+heS2iJ8fdPR2rUQZydMWrktPfM+HMuyP4PUHYIUFTLPV3bqOHKOkaN1R+825ZocE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151796; c=relaxed/simple;
	bh=JLefzajAeY/DtiXqlUnKFSIKloYifoYTEWs7n1d+a+M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F94JBWXlNj4XEy//6lyXBnsB1uH8DFX7RZJcsKeR9EQwSYOi2HLzQPzpfRDxIrNw2fAMz4Bfm0PSCT511qFqRJGUYQMjWnPTI7r3pOOjqNJT7Cc/AT+JGqH2kL2Id+SiXWw8kF33KS55vype+MaPhHZHVQ0syiM8DYvWRs9PeaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exnh7ouA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exnh7ouA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784151795; x=1815687795;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JLefzajAeY/DtiXqlUnKFSIKloYifoYTEWs7n1d+a+M=;
  b=exnh7ouAD43boUbLSO3Lokxe36qKG1rGJMCg8ZNAuoqJgkiqyoFVIRtG
   dcJlfDa/uduHey8ayPHc/D9GoqdA8//Hr+MGA/UjRf8HtXh/hIwLgcLzm
   0umSIyo5DQG08PP3w4QwEnRfG7qd9QfuNOiG89/Mvwkatq27FKkZcxV1y
   qFHqzqsjqVOeHHMO7ZrqhE49q5WPMYNnC8NVVcuNha751FnpWpebTthhY
   +NIpJLohc7yBBW3ilocZ0TbXDeG2TPASi9W8hjkzCa5ywaJSDvQ7TpBkW
   cMJ7O0k5JRX+ZMKJU5yy6UqthF1Rzw/6hvWcqPMmB6+Ps6VqD+QgBaSa7
   w==;
X-CSE-ConnectionGUID: QjwA5fGJQ8atPyI6hqMhtg==
X-CSE-MsgGUID: rJHwtgfkTN2EBcHDhVTPdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110353114"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="110353114"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:43:06 -0700
X-CSE-ConnectionGUID: c4ToA7uLTTyeuWIkMU5gmw==
X-CSE-MsgGUID: ZF1l+WhsQByOHqJ27DCWrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260113584"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:43:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 14:43:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 14:43:05 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 14:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWV4QKu4Xbg8y3NDGmFgo47SVIT02LYaokiq883CWzpSIQgtNX1IB9Rt+k9wV804E8BQ0PPMvnNcY9lQYMnITzWwvvlVyDV3yxBJXz/RGPHLA7Iv+8epaPTfcMJ2RA+gTnNta4I8YbfALsjT1j/WzdfeAr7CCO/IpfXgb5qlVI0u0/iUeuYBrEOgfbcraiAs9W7nLI7L4TQkp2Sqpga2Qbn/JoNRiAyXt7CjZrEh5hXywhNW1l8IWlXKswDHU9cu3HB7pjzGhcuXOqEcpSckR7oMMMEcaIHvSbWFedaolOuCpWFwBagZitaXU6PnF8c3bTeF4tkYAVZITUaC5qDUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V5U9A9AzcJOXRhUlOQrFlF1mR2ax/6P3ZlY/G9kM3k=;
 b=Ca8Y4Nzs8phfF8P+eypd1rO/gvxoGJMFfZuJYgdxBg2LUULRK1bFMOhNrLGRGE5Af7jBJ3srgizshZZQIM+k28pZ4KTr4TAuOfbhRN0lJt4kuE6Tp/7zL1vNL8DE0BbLfT+GJouPSaZ55GS7AEXWMP1A3zI2YyuctRa9pFlgLcxDvYa9j6taIHyrojkfa8IlEehCBATuo/W5BoTAg6EZZe4YiWMoLCHFLRRXfHM0ltePT0zA6l/rkpO/gI1gYWLFzZzxSHHKn8EmYZCYCTFLs1X7KvYaGkxHYqQmnwve33PjTu5nVOu4nBB4nXmp43cCPalE7Z+aRZPcpSjfzytOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 21:43:02 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 21:43:02 +0000
Date: Wed, 15 Jul 2026 14:42:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/hdm: Restore commit_end when decoder enumeration
 fails
Message-ID: <alf-47q8FZl2Zpiw@aschofie-mobl2.lan>
References: <cover.1783974681.git.alison.schofield@intel.com>
 <dd46f240738e3eb2663b23ed79fd9544ff5dccfa.1783974681.git.alison.schofield@intel.com>
 <20260713205821.736541F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713205821.736541F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ1PR11MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 2148e454-1cdf-4029-4396-08dee2ba0bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|4143699003|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XTuS71JAK337RkaF8TXDoaBsujd8JZF5icVoPXybsBucft5kbcsn2TnVazJAu7cmDD51Gb1OgGZ7fUgeEeVR7mJfQNHt7sqp+tWFXXW7MesX7nvvYrU+BPm0FQLY/RENRAs3RP6zNVJFivb6v3ZB68J8LyAJSLE8WDGgbtaQo7z9M2m4mWYvkcg22SWycdoFTojdYTTdBq8p09yhRGkpg8RSq4UUHo/vPWrhtBl5Db+s5KnfFMKNwXRx7WwfBJ/6V0WCOfoqpnKNhvArJWNvlsB99oyx+hJByeUqaz9cSjM39kNS5OFkqIoI0MBY70vZ8qZ7yH+HPofnWrR2CDLNkoj9avwC9wI0blIxTH/I7920G2yCZ1AzKmdKgOHRSB47JWgZL+Qx67D9/7aHrFYz0eVDRPFl7YzCzMzn221scbPrGDmJsDB/r3l8KCsRo6UIpZnb8jms/wSz7zUT2JjT6KY6oxO4V35AUxBYcpdvb7b+J6pAyRvebKr5FyXsXqLddmtEviMIvWzC5Z+UiXNkaTF2S+Zl185KUteij8iBNY8ejGvcZOEVmAUArVT7/IU32EtiOi8muxptLxMecmrrMIeNF5UL2DXJna7G1jzWD2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mkvMnkE3dHa08utx9ClJmRmxt0WUUB+JMINMDW4QJy5V8pllLf7PkoDhNH?=
 =?iso-8859-1?Q?BeAhcm2TXj88ZX0iVHYVVpv+KAEOVvNyu8bX1RMYTO8XlnJPEWPq558V9t?=
 =?iso-8859-1?Q?Ve4vHGpx7zlik8AGNa8NyHvT3Bor0hvvXQprY5GVoee6lciIs2kgfrLMTw?=
 =?iso-8859-1?Q?n+GUSmbf+PiB9PM5USLjR1WwP0UziLriqD5G/LQvYRavIds/LZezzJvBdF?=
 =?iso-8859-1?Q?jfVNg+sL6USWE45wnEa8xgcY8Dc7YryIZcuErKq5GL1mdODOPMtMkpS+y+?=
 =?iso-8859-1?Q?JNiJ7ueufQcxF7+Tc04t8aWSkW1cfjogQ2fCy9R0oRg2n+VNb+iQG9rJzn?=
 =?iso-8859-1?Q?Ug6n/YVwJLfxKtq0lx04l+3nZDU7qpfprgcWjy3xePrwcsIUlXwocT6Bml?=
 =?iso-8859-1?Q?pTKVNz5reSZzKvmGfFAjF6WjmhIPlH11wLBWOYr2ZhqSuSoJtW0/ydwD5x?=
 =?iso-8859-1?Q?CtiWWOk77sFb1j3n4ujMaV1RW269LbTKZiV6j8Rdzw8zBWHPdxBLAJdpFF?=
 =?iso-8859-1?Q?PoKaiDCp+1I275R718qpuIyDfNxaAgV79yS0CtDFtgFCo+In+h8NL2IUUi?=
 =?iso-8859-1?Q?4j1n8vcrZelWzTprvwGbOJv+QFEdTyUfobc743+QHSgRkEt4Vzs12PdvyK?=
 =?iso-8859-1?Q?kiylmQRUUziMYsJJRx9flaW6K0NYpUp5v8lHteZEfOHPxKTevkZ+Fnilqg?=
 =?iso-8859-1?Q?BVIdJETGfOqyz9TsVqysLFFBBRSRRNC9g1IxjpwGYdj2H9Om7fYlIMsKPQ?=
 =?iso-8859-1?Q?2oulx+7jarocppqfG0HUSRWGfZyG2oCNH8wcUQychMvToCCUCfKCdW9l8Y?=
 =?iso-8859-1?Q?aB75/KxMSQqH5amZ3ahKe46nw++cyBce2Tw4ho43vBqIw55hufKgzkD/A7?=
 =?iso-8859-1?Q?SU06s0ON+iMDzhJyGF5FSLFEjRkQ2ojBXEbE8FwDI1Kaf1+0flTOjF16gC?=
 =?iso-8859-1?Q?fP89nj2kU4iv2C6qS/OQhqfGWsK+pWtOCCF5T0BqY67plfrJi+zUnEWgEo?=
 =?iso-8859-1?Q?EIHSAUyBKxdoXgPNScno/ZzThzRCZHGrHEW0ZzzH0VyKCXCgqv7gUCFXmo?=
 =?iso-8859-1?Q?8iJjJT5FSs2JJ9WQ5SEx5UackGBuKUcPjC7cwGVcpiP7Z9dzzq3i0tKo6d?=
 =?iso-8859-1?Q?5zbNgIYQT1CuN0M/Ln5/1G8F+kxHukMxd51oWn5EJPFaFBRWI4M2QGV08t?=
 =?iso-8859-1?Q?ANUfOEbRUqPyT1TIzwz0GzQL32Rm8Vxob5krZR8cwgiZnLY1dLwctQlU47?=
 =?iso-8859-1?Q?FHPJ2bI+FTofiduBi7eQfZUbSdjuQW8GuTZgN9fYbwEe2uOyS7qNUmwBrJ?=
 =?iso-8859-1?Q?+LxC4myXmgfAZkA6FyJRFqlvdsJFjqHTYBmxlbHlxqjKqVrDnVIaSoBZ9d?=
 =?iso-8859-1?Q?bvgXmrhATiaWZ3GQRLUh7IJRsDYKKwn6VKIfQWX5P2qJ8YSZzZroF0mQ+5?=
 =?iso-8859-1?Q?tQZHIEdyPpYN91WwaUO+8mkb8FjLvo1bJ6Db/weiU3+Mkyy87+UZNMOPap?=
 =?iso-8859-1?Q?yuV7YV3PCC8+R/8Z3fz7/wCPQejxeIngdkxQ86vbNUU/9pZkVSzF5q+sZ7?=
 =?iso-8859-1?Q?PndIRENC2Fow2X6/guQvQIsAd2L+QkeoVUsP0GSkZIXbOD6z3eEK5i6UM+?=
 =?iso-8859-1?Q?JoDPlSe4VS+wYrazJyRemdST4sWp6MUpFfd94y9KujHZeDJneVK8MGZtho?=
 =?iso-8859-1?Q?zq31kxfs1+7b/dcce6fY8X/73xl2BCvpAiSpnSaQXGj+pRX0Q8AhTsA/Lk?=
 =?iso-8859-1?Q?3M8PqwdIwkkVjvbs2m7KzEsD1tOsUve3T+7700JnuZLO3/qrFek//rhv85?=
 =?iso-8859-1?Q?oyJohfi/FnGoq5JCJu7BUqO+Hzp7Udw=3D?=
X-Exchange-RoutingPolicyChecked: i0qOV+MwcgaMpjKwdyIg7J+UonNOwUwODPcJCrhOsULhodKgrKUJKG2LW0QhK76vAkwnXH/hs4bd2stnkWsMJU4gnWRJlFzMgNLEYISosu2uLsfV9RK+QtqhxpSjuUgcAeAQIE94JJTseVbNwLhbgG/g1hI8KDMyXryb9sJMXFeX8m2UnXjy1k3xbY+aPfQa15xNtZFGXX3tRG9lNcMshB2xpqCgMOaLuBkBVbLldbRJdu/XPfiT5nfaWz6DaiTnTdcRRpAQqUmCW4yTeI2/r5vFd47JpZZ9T4Dw2P8naNq4nwmuHWp/7wvlr91Rh939kXEjzz8wuhrXyvcWwrVyYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2148e454-1cdf-4029-4396-08dee2ba0bda
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 21:43:02.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWMAycFM8GSOtjzKleze1s3nYM/Mcq1dZPI8TUEzMCSZR3fnT7U7sYzYVA57yqJJkJ5RpFA1yK5r9Rt2G6DOIwbaXWYrrD+lY2U7WjxJRzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com

On Mon, Jul 13, 2026 at 08:58:20PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Transient reset of `port->commit_end` allows concurrent bypass of safety checks in `cxl_mem_sanitize`, potentially destroying active memory.

Fixed in v2.
Moved reset from before the loop to the failure patch only.
Success path does not touch commit_end so no transient state exists.

> --
> 
> --- Patch [3]: [PATCH 3/3] cxl/hdm: Restore commit_end when decoder enumeration fails ---
> commit 0d7f87c9ca0ba7b9bbdd31e5ea90994445b1c9b5
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/hdm: Restore commit_end when decoder enumeration fails
> 
> This commit resets port->commit_end to -1 before enumerating decoders so
> the commit state is rebuilt from the decoders actually committed on each
> probe. This prevents previous enumeration failures from causing subsequent
> probes to fail.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 75d17120233da..0145d3db31070 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -1178,6 +1178,10 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >  
> >  	cxl_settle_decoders(cxlhdm);
> >  
> > +	/* Reset to the none committed baseline for a fresh enumeration */
> > +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> > +		port->commit_end = -1;
> 
> [Severity: High]
> Does this scoped_guard drop the lock too early?
> 
> Because scoped_guard only holds the lock for the following single statement,
> the rwsem_write lock is released immediately after setting port->commit_end
> to -1. This leaves the transient -1 state exposed to readers without protection
> while the loop below performs the hardware enumeration.
> 
> Could a concurrent reader like cxl_mem_sanitize() acquire the read lock
> during this window, observe a temporarily empty committed decoder count
> (since cxl_num_decoders_committed() evaluates the exposed -1), and 
> erroneously bypass its safety checks to securely erase actively mapped memory?
> 
> > +
> >  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> >  		int rc, target_count = cxlhdm->target_count;
> >  		struct cxl_decoder *cxld;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783974681.git.alison.schofield@intel.com?part=3
