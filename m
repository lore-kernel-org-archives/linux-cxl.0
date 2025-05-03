Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5B182;
	Sat,  3 May 2025 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746237759; cv=fail; b=T5tAOBYeJ/Kn0o3J16yBGCUiEW5C+IYpBfmQipjtUFQd0aKmt93tOVbFKdxfRXsFFGjLsxlK5d3+wHOgw2sXlXcFnyCgwQ/L7O3527L9aM3r2LO+wGbUEQaU+uu4oDeppvZiAH/6VN4FK1UnqDnRnBldP/Cx879HfZpoM69q6ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746237759; c=relaxed/simple;
	bh=W6zzOyJQ4WSzPx8VGCNqw6K7zV/tMmDANK1QPUfUXnw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iSc+ZJy4ICrHhJDqZWmdxng0TyfmnWqCAiUeJnzMQ7YetDqAob2PEgOIlpK5Yt/aNmHmrosyyxVei1fxtrqagdlWJdL8nWWyVqsuaShHavoT+ahtqDnvTC13XvuDvKRm2CSziPQMumP+w4F7PlFS0VU9NcXrLLEGLueRQ5u/ifU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ev2U7ejT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ev2U7ejT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746237756; x=1777773756;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W6zzOyJQ4WSzPx8VGCNqw6K7zV/tMmDANK1QPUfUXnw=;
  b=Ev2U7ejTYsfoAAQOLlrne8If76UYJT4uk3n3tHKBW9xOCiPyfXE0sPsd
   2NxmBceyABiGgLCQRuyeDrIV7ccFG8kZYl2Sv+k4aI0/LUalgjisl8u5l
   gDF1fFXpmv08FesVudL7bX6GviGyW8oZWfS2m8iftXmipSp9hpmR75YPM
   3eUMSiqAjts7xGkleg0Ump2DG3gpe9Zw+UFI5bs9yeUtLCpsIK0r2/mD+
   ONMb6SmuN8tmvhSPRLr4uZUM/qJdr65hURF+2IrynHpCS3a0GXrsQ0PSy
   Y1edPZkImIhD2W4vl8dCmYNYd+xYovQn5c7uIm/soHW9VDTNLzfYkX+n+
   Q==;
X-CSE-ConnectionGUID: kC3XcH2wR/mVzrcZZ3fblg==
X-CSE-MsgGUID: MP4gWbVzTUqaEma9Vst7MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59312080"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="59312080"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 19:02:36 -0700
X-CSE-ConnectionGUID: /e9oxh8GTM2msJUnFFhqlw==
X-CSE-MsgGUID: LdfDoUnDStuaQnqJLbDF/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134525297"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 19:02:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 19:02:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 19:02:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 19:02:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHQTxg3uJVkKnxEtvBZfDckFR5F/CN9TGdbd0zQWVuAMr7NeqWZmjUkGBmoO+DN5HnoN/ky9GmsN2bL6nWuPmR+rUQ8icNprszmPLxiTmzNsu+tLyzluVl+2AJBUl5jQ8poQk32T1s2/BN3YRT8yJN6/tZfot7oGUv68c22Eqo6JNVaoWr+R8k6FVL6UYAaUb27Tg3xxbO2OeKPcpd5Z6YYEaLNBCzK1GN8yNbEh+PA635kd5KlK98xyKU72TvgLRrYkJ4g8hYbDdwfK3AHYSkkcYCcK22NE1vvlgcG9kyShmazALP5PPq5W575PJc4Rq9GrBt8MXkEytoECibsT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJk+WcloiwnyIBdQ1RIHwzDHdzjbeXgM296vb5sIldU=;
 b=IYM7UjsCeO+lQrzJshQ4N+LBj51syJ8Igvdh0eMvcHGD2qN9NQ8GjLEDRUXxnm9C3h//cD8oETpHcE1kJF8FJQPIzmD+5Fj3oWuVo/FT4YrRT0JRrsvQ2Xe7C/nq2tVdJzAVeF+p9D9rFgA+p6TvNLZ9TqWIR8eCFtePXLsqUSxp0YkGDC0YknUPZc1cMkqC2xjulKSn1p+ATfS30q22XoHIs+2c8dmg9sirWFJk9rV3hEwNoc5jHm8Q+tC/o3M1fagU4xG6T2uajlm2hXr092ujVoABBlF0GKoxTkUF5jKgYfSIzu9NohY7YTkXKjrYRw12UaSeO9qU4RJuaqjGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Sat, 3 May
 2025 02:01:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Sat, 3 May 2025
 02:01:46 +0000
Date: Fri, 2 May 2025 19:01:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <peterz@infradead.org>, David Lechner <dlechner@baylibre.com>, "Fabio M.
 De Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ingo Molnar
	<mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH] cleanup: Introduce "acquire"/"drop" cleanup helpers
 for interruptible locks
Message-ID: <6815790674f6d_1d6a2949d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250502234818.1744432-1-dan.j.williams@intel.com>
 <CAHk-=wgRPDGvofj1PU=NemF6iFu308pFZ=w5P+sQyOMGd978fA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgRPDGvofj1PU=NemF6iFu308pFZ=w5P+sQyOMGd978fA@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:303:83::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 292ef58f-3156-4f14-65bb-08dd89e67556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HK8lrzdh1pdQCztUVXOrxAieFv0fekc3dWlhjsRR+4Ag9FgqUg965SBdTM27?=
 =?us-ascii?Q?Ku27UMsQbLETkT6IbyhV9zz/NCGOszyBfwKnhktwJFiVut9wEGWcf+JDvSfM?=
 =?us-ascii?Q?EyLOdfQXxP2mQ+y4kRhe1LsMOHSP7jUbSF7rETH+nRXuczMeAy9RIlwP6591?=
 =?us-ascii?Q?lxQ9ByqxeuJ90gcT8yqH1V+JFiYSuz+GqyLlpu1+B1snJjqBe3h07iUusEfo?=
 =?us-ascii?Q?H7W2uvb6X6lwNtiuaEyYybmthN5naJxfQgcuYzL67EYlc+u3mOX3uUjM5lXV?=
 =?us-ascii?Q?92q4yWfnCs6Xg15xVEN2WKVT/QkDmrN9y1SHe3hJQXAOGoCBc4nQipwSS5RJ?=
 =?us-ascii?Q?DRasJmLNnxBNA4eqsu8+jz2ZrvdGalAxRnhl/M8NzPuw4iXBU3WsJ+/q4K7y?=
 =?us-ascii?Q?VnvF9Bje1lV46n0UNrDdJZYpo2BO568cmNqmsJKVNvnC5x5amOVXthifIG0R?=
 =?us-ascii?Q?h1xQh3XyZ1SZcN8lbaiZ8P2G+DJCZ5kCMz562VyATGqparJkJA46ogD0N7xU?=
 =?us-ascii?Q?FO614aLA46RFWTInr/lMVxXr98mwbglUBjhrmAgDsUd8PbCEd4n4iX7pTkj2?=
 =?us-ascii?Q?rspdd63IhPj0+NSvdQGbiwEGzyB1yqRGVW1IwigC7HSKJhLvzqtU9BA3T7CK?=
 =?us-ascii?Q?su/j2HyWhjGxfVqaTGDS+Gce7QzlEkzZPm9c/qMSyKYBFRbodxdmSYyojvDt?=
 =?us-ascii?Q?Mbyan89yCyycYnh9Ot7U0zoNhJuUMtdjCfOx2q1e2xtj20vEm0wdxch6Q+K3?=
 =?us-ascii?Q?d7llP8c7B9ns1HuIUHyo3RF+jn+whBWm6+yfnSLFleU29IyFyeh8DGG7oerN?=
 =?us-ascii?Q?FQ+JynIueo6lqha4cWXICGP2dQYc7JflC43PVK9tf8aViUPKeC5mQmPcmhWb?=
 =?us-ascii?Q?ONtvnxIdYDJHmyTzq6G2AfUNcVbwea46fkZ8wrdG/DbrnC0ffQlSlG/WYGsf?=
 =?us-ascii?Q?+dGK0d38dAIt/HqCH4kvqVU+HMP4rkXr0T5YOodK/EX51HEULpGJ+/tGAZBs?=
 =?us-ascii?Q?iBfILWDvFJHhdmouMeA6sqpUhAuo8UjqO+RTWP9lWhoUlkR1yj4G0T8LVlf/?=
 =?us-ascii?Q?UmWTAUny0nc7e9f+EFMLTXdehg1mklmLrP7IHr/g5K2Bm9xDRJKhNy7NkaGP?=
 =?us-ascii?Q?YlD2ZFDOeFoC8myq/CmqJKRqNAy2eFLkeZHPz8CL9G0pp6w/stshs8sUex7K?=
 =?us-ascii?Q?62bIBV3BjnlvUrwPQNl/Wv+XCpKicTmgbF/5AD/u7FobY72XuZCHtmeeKZYX?=
 =?us-ascii?Q?9OdRbfB/sJmyuRe8saWIsPmKTvRc/3B31yad+oasu7BNXPcQD6XNmFHoqN5L?=
 =?us-ascii?Q?Qxs57yXXdcWcQHsBJR1AuKPKKnJA8e71YOgmkByjAhMR4SJkqByWgbrOMQJu?=
 =?us-ascii?Q?pxER6U/bN9aOaGwuD76zf6E+3QTktm4KiVexhOcSOhdjDXhlRm2C7bFLCU/w?=
 =?us-ascii?Q?kJ0ZPI89hjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H6pzJzO7YPHUzCdWe2/c20OnzLKB2JDS6pIuXVXKxXivZIQ040QjftMCprU2?=
 =?us-ascii?Q?iopytC1xN2mDAZuKHW7Kvzt0KGUzzQ98jSAhIOJH29C2NrS9MsnsufaWEa55?=
 =?us-ascii?Q?kMQB1FGAGJreif9/c7Jw+iR9mLP5yuBM8vICIVnKpIhg3LmFpaASgSt/W8XH?=
 =?us-ascii?Q?BOkd2Tz83XzymfhzCe45h9hl3qAl2JNxykrIrL5+oCGaprY4v+z43g8tGhVj?=
 =?us-ascii?Q?T6yfWkVr/tJFUZxH1rzuk6K+03OFft31BQDT8v6Kz8g6BLgEoIPPsdVaYeVV?=
 =?us-ascii?Q?vGqSIiLDOYgxwLU81W1ZFirukj8STg6u/5bOteNtFyqKMQjqp5WH0mMhqBmr?=
 =?us-ascii?Q?gfh9Xuh4LkaeFXGTHvT6qvaMKxeK1Tb0vVaGANOd3Z6Lh1/plXdMZ0ZmDham?=
 =?us-ascii?Q?wEXZ4cMT6K+Fd4F6rYm8M1jHv1rlQP8Ewdq7OEfpNQoltbRij3eztrq3DzJA?=
 =?us-ascii?Q?67ecw9XrwzJIBdBfNW2n1FJ3anY/vBu6/GRgKqGeaKT0rwWFLoL1kUFB0xX0?=
 =?us-ascii?Q?jKpNI4zDdSmg10L5g+flwl9UYx+oKPNumheN5T6Mm+DgFZ7vIOdBpiJZ3t/1?=
 =?us-ascii?Q?F5gzd5XdbZgqTGX4/VkwbBstdZwA3DamNMwTNEkD/cilLk87cCriFAcqyVT1?=
 =?us-ascii?Q?PL6VoGi+81nfUPkFiGL/PEYXns5iVlSaFnyJ4ELKMG8xPNQtbQCE6f3M68P9?=
 =?us-ascii?Q?OPj2a6xo43as1Sqk0jq4VMdHnKkG/8lx8sFqe5QBCHYE4khiKgR2pQI/aXmh?=
 =?us-ascii?Q?JT0pfAP2qciThjdTAeqUkditHRnmxw5C7BFrdUJWGWO3x39hr50LsS9OkLbv?=
 =?us-ascii?Q?hr7tqbzArrXxvYShKefpFBF1bBd/JGpOwDV3/ubpSYL1CYp79yf60dnZqTza?=
 =?us-ascii?Q?S/B2gZAx/clafxQypKsaRbxRNHHMEGxKGHGW61hAjtUqwe2LhidQu/q10PQE?=
 =?us-ascii?Q?9UIE75bw3dmAOaOBdEsoKvVGqjacR5kckTHfubfU9iuDwKHISqQVpgKZFx1I?=
 =?us-ascii?Q?FIPjtrJguuWjxCXVlMuvyz6ZzZ8pCsSqQ4700U3ugGxStcv1JCbgoihnZ5mi?=
 =?us-ascii?Q?q+Y3Myeutg+AJA8JlG5ymTJpiyexPC44C9Fo7VMohMUh+oQUazBR65ObIISc?=
 =?us-ascii?Q?uw2vFSJHFcDE8w5o2GXyZ9f9yFcaNN8J0i92X+V07RnWk/Wet7o+fBo8nUuU?=
 =?us-ascii?Q?d+sFrZ8JowLlvobCZp/nK6F8BylGInGA3K2mY/quAXRPJdbpSxktNeZ+xugR?=
 =?us-ascii?Q?7KmTT8Px9QuUeyA4Ue89GGIw7T8AfMvymYXQW3rkcpOxCCggP/56mwa6gMT6?=
 =?us-ascii?Q?oXk8UXcoiWmAHVPJ8WF0FiPCC05LSzzJPUYi8lTP9OJMLRnBwFZsGxCzCcPW?=
 =?us-ascii?Q?ryWYxhFBite2H93xIEUsZ1udNJPK6PRBTrzYBWXS/Ep8oNjlxZwRRr41rfI0?=
 =?us-ascii?Q?lB1cRxhTyhg0sCDvke2zWbYAmhfkkAGnpwQ+8jvp4xYrpWu6ZG+CZE/PXeKK?=
 =?us-ascii?Q?D156jlfPT2X7P0PMzOrxACZCTDNR2mpzTVSPLrPOkdSF6yG9tNcSOXx+2fn8?=
 =?us-ascii?Q?iUZV/BlB2P3Y5WbYSJs3+8p0rMcyCv4NjI4s+GK+zS7TwCRhdsuGsKSaZor3?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 292ef58f-3156-4f14-65bb-08dd89e67556
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2025 02:01:46.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lSf8gkwHf6ocqn6fzcc1OANowuBkaB2blboc5eDSqDBOgcpvuyPL/dkR1Ru8/VXvkk3BQJWg2P/5aWWfXV/sOIGrodpXExFF8xFCqxABSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com

Linus Torvalds wrote:
[..]
> So I don't think you should take that early off-the-cuff remark of
> mine as some kind of solid advice.
> 
> I don't know what the best solution is, but it's almost certainly not
> this "write out a lot of boiler plate".
[..]
> 
> Your patch may end up fixing some of that failure of cond_guard(), but
> at the same time I note that your patch is horribly broken. Look at
> your change to drivers/cxl/core/mbox.c: you made it use
> 
> +       struct mutex *lock __drop(mutex_unlock) =
> +               mutex_intr_acquire(&mds->poison.lock);
> 
> but then you didn't remove the existing unlocking, so that function still has
> 
>         mutex_unlock(&mds->poison.lock);
> 
> at the end. So I think the patch shows that it's really easy to just
> mess up the conversion, and that this is certainly not a way to "fix"
> things.

So, I didn't hear a hard "no" in the above, which lead me to try again
with the incremental changes below, to remove the boilerplate and to
force any conversions to the new scheme to opt-in to a new type such that
you can not make the same mutex_unlock() mistake.

I do note that the original guard() helpers do not protect against that
mistake.

I will stop here though if this is not moving towards viability.

-- 8< --
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e3e851813c2a..cec9dfb22567 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1394,8 +1394,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int nr_records = 0;
 	int rc;
 
-	struct mutex *lock __drop(mutex_unlock) =
-		mutex_intr_acquire(&mds->poison.lock);
+	CLASS(mutex_intr_acquire, lock)(&mds->poison.lock);
 	if (IS_ERR(lock))
 		return PTR_ERR(lock);
 
@@ -1431,7 +1430,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		}
 	} while (po->flags & CXL_POISON_FLAG_MORE);
 
-	mutex_unlock(&mds->poison.lock);
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
@@ -1467,7 +1465,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
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
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 9fef4077604c..9684f0438364 100644
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
@@ -202,15 +204,23 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
 DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
-DEFINE_DROP(mutex_unlock, struct mutex *, if (!IS_ERR_OR_NULL(_T)) mutex_unlock(_T))
-static inline __must_check struct mutex *mutex_intr_acquire(struct mutex *lock)
-{
-	int ret = mutex_lock_interruptible(lock);
-
-	if (ret)
-		return ERR_PTR(ret);
-	return lock;
-}
+struct mutex_acquire {
+	struct mutex mutex;
+};
+
+DEFINE_CLASS(mutex_intr_acquire, struct mutex_acquire *,
+		if (!IS_ERR_OR_NULL(_T)) mutex_unlock(&_T->mutex),
+		({
+			struct mutex_acquire *__lock;
+			int __ret = mutex_lock_interruptible(&acq->mutex);
+
+			if (__ret)
+				__lock = ERR_PTR(__ret);
+			else
+				__lock = (struct mutex_acquire *) &acq->mutex;
+			__lock;
+		}),
+		struct mutex_acquire *acq)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
