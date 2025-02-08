Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D58BFF
	for <linux-cxl@vger.kernel.org>; Sat,  8 Feb 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738978190; cv=fail; b=bLkctRzNBKOe4l8jo2C3Ow11m9pUdEzR7DzXEOAhO5mTT0Bl5pMpyOWWCn2o++mtthzCY1C6Yyb8K/6Y+beBZe/9FyRvTP55yZaCv7yg2XHlkziK3Y5G7YNmiSaxyq/goOwVpD1DsAFsvo6cDJtubbY6t0pK+rJUmjOAyvFvqtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738978190; c=relaxed/simple;
	bh=hkUQ49UQPhHQGydTQ+lsXGmJ8ccK8LOqD8gbz2CCiR8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qZ72Q69Mw5OXLSapXaVyRsFPV+9S2UX+RYQi5vrogW/WuHrdoFwShQubp3YrmAU+WLKg/9DyslPnwEFcvA9nFtV2f4emNEfKm1ibz7CHhRijiNpE75m1doAi0qKFRlQnz/HKtoR5aJtC5UFRKW0WoMF4VCTR7ZC9FHKqsZur5qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfKNVxNh; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfKNVxNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738978189; x=1770514189;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hkUQ49UQPhHQGydTQ+lsXGmJ8ccK8LOqD8gbz2CCiR8=;
  b=YfKNVxNh6BKAC5Fuoq6tn8DfXLj3M84iFn3C2H7i8lbkeFQZSabKV+rU
   7OQtqX2uT0tccuvXRnEEIoP+GQh84b9jjjI3mGWgXgUghsvnI0CcDS7/S
   2J2GRcj0ohHk7eL9mxtLrUOnSpGEgbIH02D/WInZPT8743SET1UglZZ6h
   jsb6aaP/XYKMnZgJJP38j28nx5PIC/V/y84ywTMR7dlhM4rA/0Jm53X9E
   l/p/TUoKir7T4Bj309J3s6pB6WetzKmTHEw7jFLctSt2kl7BolnLr4Arh
   WLU47aXuCVstPlH/R1XZO4xbVXhdj4PqJVNZ/nrFXAv0ANHcbOdKfgPKF
   g==;
X-CSE-ConnectionGUID: /5omjqN3SfGapfltATOTaw==
X-CSE-MsgGUID: Pca94h2sScmbAwVuKiaugg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50613771"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50613771"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:29:49 -0800
X-CSE-ConnectionGUID: LmvUZc6xSMCFepIuD3AKcg==
X-CSE-MsgGUID: dvuGUgYiR+OPI8ej8dF8Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112311703"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 17:29:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 17:29:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 17:29:47 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 17:29:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEfYzy89JMatFgwdIiOVorNsQR15/5opD65cZjeW7OUqKrPcAdThlrAtItkcVoMlWhQUFmDSpgICiy5qJnmKafm+9Hfk4HMARx3bY0Lci3BaM2g7/trDznDkPie2yLx9n8iTOJa26qJVHckKDdeBtEg6V6g/tTMoALN42MJltM+/IqNhxHBxs8M3nefBrQrNfRy/b2fgiRCwTHXijNY5YqBY1kYhoaZ63aPPwICrGpcUnqmJBkefb3G3v80x1pcXf4S2ABrwxKpCQbkijqj8+YqUg3CWKVMfEGUASADEuqyLq7AJDCzTIT2B7WS2Y5og4rNTKkEqNFOiQRfTQ7aVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhTuti5hnR9ODvrxu0/M4O4J4grb7wKc7Rv66aaQjes=;
 b=tSYW07pBYz6dwY2U0aMFdvcHZ/9kxINgAFLlzG2GdeauAGs/vdWehS4+wOl2vwARa8/XUi95ug8a8aMcJ3IUH3+WZerC8CMWqMkIq3YJfsveHpiDQQF/WWPL/j3W0eNEsXNXj7jmevjcKYji77cd2UyOowu/W2Wws99dyovWaxLLUF/PadMnYAuxS6EOWpcAvgv+Yhz5364sJ1q9cLW/C7M70W4q99b2n84OYE2hn1UPzWBfWKjl3P5inlcWnuRPafP7C7rm1aWW8goDfD+r29WnCq4yweNbsX0NV1hNDTEpkB7AeWFm4HVgAdbO7dMYuxtJIv+rPKtHeZGZ2cz2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8276.namprd11.prod.outlook.com (2603:10b6:510:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Sat, 8 Feb
 2025 01:29:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Sat, 8 Feb 2025
 01:29:04 +0000
Date: Fri, 7 Feb 2025 17:29:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v4 10/15] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67a6b35e2bdd5_2d1e294fc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-11-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207233914.2375110-11-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e53691-4314-4386-9cc3-08dd47dff962
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ltXpTlY1DjgF5+U8/a7h3tmZmGcZtDQTsQ8zdRtzDkimQM8apDt0QwRfAZ8I?=
 =?us-ascii?Q?IFRMgzFE7pYgyv24yLRNesfblmFKVJrluY4H5sFI/sefKs5PjK3y4bjTA8SJ?=
 =?us-ascii?Q?gTg1JHcIJOlbizmfHrSV6nG18DN5HR3OLM2oTnIFKzxFRYSbk1bQCHemb/kR?=
 =?us-ascii?Q?Ii3QeXS3qWQsNRcNuhba7WaF+os0GV8N5PRneNS5YhwEdcgBzHlWpFoCr4Oh?=
 =?us-ascii?Q?VqAplnHX733I/SKfWCw/S4XiAVQxrLgRUSMlFS6E8Vxiqnxl14pzRMl1MgkF?=
 =?us-ascii?Q?91eTkQKcM/pP9qKxiPjO5/JaOggpR8oPUZFDVNIulQnISTlPucQWkZjsuJmo?=
 =?us-ascii?Q?WZbdXht3I+QKVZfLvqoNffttdQDfsXkcnuOv2QcYSZtDtX27Z/j+SAL3RJor?=
 =?us-ascii?Q?I6ANqE9VIgB6HWhGwN5atMgjhaIS59Pl+9U6ekJBmJoUQ3Mx69XjC2sgOFG8?=
 =?us-ascii?Q?9ZHFzbayr7wl+s5xU1A1ft8vM9kG7nS/pTNjCUl0CoI21Me4fDvFkPxEQ3G+?=
 =?us-ascii?Q?tms3E/DbdzVNVVXgzk4+cqOozHryxabI9wPX6bXnKrwjTKUxEnI2l76ij0OH?=
 =?us-ascii?Q?fGXpXtPI0bm6EGcJhLKrP4pfiv7T+DqxrYBkXIHo1XcjBKd/hN6L8ZPZbFUT?=
 =?us-ascii?Q?VtDHH9c8XhAeOa8BMV9VsBRHzWctpxSamdDfhMRdnEBjjGbZHaqzkGA+KZuw?=
 =?us-ascii?Q?rYVFkdnvo2rp3LFgMYB6M8TUfp4aDWrvThQ7HIJKIky3DhfoHN2veXy/CWuc?=
 =?us-ascii?Q?LpwCIAXIocLWg1w64qP5Wv61iK0+saZqO5M4wRIjDz5wikhVF4adan239SyA?=
 =?us-ascii?Q?8GRPHcz3IktjFOQATwwYEXU7wet4pchaz27jEvMWq1GiqzGyPpnEuoVgw8p6?=
 =?us-ascii?Q?KqE0h01eTrBNR8A9LwRRpJFY91u+T1BiFfaeP7XIutqeY6OB8RLB/FlMGYCG?=
 =?us-ascii?Q?7P+HQz/yEy6s5kTHW6oY2rlhZ1f4qXLtHPfsbWE2U3h6AuBp3xEW49xx3sQh?=
 =?us-ascii?Q?hYsDo7G0+pZYmhys3P2zWQS2Kkq0gXqu65/YNoD8gERELxe3hxGavjAlTItb?=
 =?us-ascii?Q?NTmexFAnfZatjcyYgd5NjrjrVA20W7tGSns6mDdLZm/wxQOyUTXvUOVBbO3j?=
 =?us-ascii?Q?Sxb+vK7RfY68U5HmFL1rj3dwAkIOQ1Z+Pxo1PY6LrMYHNmwagV278XdccsfU?=
 =?us-ascii?Q?ioFp0TWRbKsPW5kim0PSo/LXqroZu/mOMWsjgtJPLvDDYRdwSXKW8AHIUJ59?=
 =?us-ascii?Q?9cOFg9ISrnssn+6l/9ErfHJjqNp2Bbus/TYvFb6thyi5RWwuy8fH7VoF+Ph0?=
 =?us-ascii?Q?8ZphTfi6mi3E3/9PF6C8+Bc4bIVwRa0JsxPwjua9CX1q6dO29LQ49Bvn82Qk?=
 =?us-ascii?Q?pAwq+kHEm54egcPegg74+doFCdSK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Y7LqMqD9pVWaKE7F0EFlrQo3afH3T6rjMJuwml8tivN/2/MwVzGNvETtvMN?=
 =?us-ascii?Q?7JMkTJ+xu6S8lUOfwvqVWrf/vGPuDFUwDQ9f+XDV6BUOsR0p/sOY8tL89UCv?=
 =?us-ascii?Q?YwOskx47/uiiAFhvXlao5oqgLNPl3FJfiCIp6XiJF9AeTR4W7/+qwJtze5UX?=
 =?us-ascii?Q?SA0C56eGpboGl8rCWXbeqt/WZsSK46XL/CLL+9StM3G3iT1F5BF5jiBDhDOR?=
 =?us-ascii?Q?sQd3T6rrGXQk35yAwO2wdU+xrQAJTvs7EoWt3jUZBfdI027a8Z7TGT37O/kt?=
 =?us-ascii?Q?r4UwYCJJXIrE99eo8yTX+a8LBrlDVhFmx8T6x2TtTSSe23dzNikels0uLB0z?=
 =?us-ascii?Q?Q6hz/QGC76W7PMP00vwEeyysCMrIlP/GKmhK9gbdrsTaUcf/HAvx5OmKwvnH?=
 =?us-ascii?Q?8mO8+1F1o5pT21Lzx24MZiYyCXM4QikeNyl3qPh2rrrjVMWKi4v8d/t9rnAv?=
 =?us-ascii?Q?djwA5DxM4S8pwqX0YK/3A/m+6StXwwRgb7G5WMEODwUKXRQHut1Atp7qEtFM?=
 =?us-ascii?Q?zCr30MOoZ/Wp7I6LWVje2hstgsnERBuXqgVgEuwk7VxVy+ZwcHfIYtYWfyGY?=
 =?us-ascii?Q?wdTSgbRgGnPwknuct42ILiG9MCYdWNkniauNzl6LSyNjpL3EO2u4jzlfJnNi?=
 =?us-ascii?Q?hcqxZJyInMDCe48j6QRrpBvtw/VWOFyXWxnAnr8pO+dSpcqGo+ij+jyyFWGh?=
 =?us-ascii?Q?+EDZKWaLK0qTcKV4eqnNglEcRbe3yIspgKfDqJMnwcJ65nEUV6vAN/2qJgS6?=
 =?us-ascii?Q?r9mwXLVbZBGaLOmeV5H+T8VZ4NFkBWpta3kbQ1c7qnH32yTQ3XAYtsHK18Yo?=
 =?us-ascii?Q?eXHGRYHcHJpfNQkkx+YIa7XjF6ljEid/XGl//bY3KraxuZX2+36SDyZD6JHv?=
 =?us-ascii?Q?CYxIH3R+sclyluDXYs0lsQ7iWzaGplbt1yZChV8iyuyTLnDO5wLO7WS3bd1a?=
 =?us-ascii?Q?v44vuDohtAiI2IZMIfIOhZoRw85SNr0HHIzFc4d6mA09DixFTVVpsHUMslhR?=
 =?us-ascii?Q?DreMeeoLDvRp8FEEY1kjuRQcnfjpH+/zN8G9KoSSrOQDzfdrFkK23T1z8ycb?=
 =?us-ascii?Q?VNIruZ2opeIgdWDl816DIQuNyDtbLaRvhwWDOUKfPnNvGF3KbkhXpY5/LJmq?=
 =?us-ascii?Q?GzDcBUumQZzdbo5SHt+rfJ+F3WlalrAduiols+pb6AqxbjTozDPXk7FMXoEb?=
 =?us-ascii?Q?jfyMU2WBSqL1Mgl80T4Xh9eOejID97P5Zxz3NCEZlvPUa2QNxb8+0S/2RPCq?=
 =?us-ascii?Q?DXPl79qkirLWpVUV9LDnBqGKkJasuUKdIYqsYfR7dByjy8PM0NRnCDGv3DW/?=
 =?us-ascii?Q?phOt+JZ7er9cSlcAYnl4wrPmVAxCXQpGYCf0aEwlV5nikwe0S/4WRwf3now6?=
 =?us-ascii?Q?NVVfgimKSHp2yg0ehSPF/7GyyoSK3YsEJmbXs+nyicZeSokhbVY8oVViofIF?=
 =?us-ascii?Q?b4111ScvXTiJuQqtV0xebcXwuAWnHCMrRP4mxxz30CpGKBYQV4ibQLOVR51v?=
 =?us-ascii?Q?j6Ut2tQts6xtfrcFfcK8Tnb9TJwyU0375dY4MWQswKy/uBotN8gWSfl+QA2F?=
 =?us-ascii?Q?xts2komvNvZCIrRn3na9YPHI7LnnQEzMOEtlXBBtgd+aCyqmKugILBHQDdfy?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e53691-4314-4386-9cc3-08dd47dff962
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 01:29:04.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMnwVztQfqlaL9YFsT0ZTOZK3Jp/XoK1NSbAmNlllUXCY47HmjtmjmRFzcuk64z6n5XYc7OC0lRvKzgsLlnDKYX/a58rT41WzUU9QssROEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8276
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> to a device. The cxl fwctl driver will start by supporting the CXL
> Feature commands: Get Supported Features, Get Feature, and Set Feature.
> 
> The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> it indicates the security scope of the call. The Get Supported Features
> and Get Feature calls can be executed with the scope of
> FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> of the Feature reported by Get Supported Features call for the specific
> Feature.
> 
> Only "Get Supported Features" is supported in this patch. Additional
> commands will be added in follow on patches. "Get Supported Features"
> will filter the Features that are exclusive to the kernel. The flag
> field of the Feature details will be cleared of the "Changeable"
> field and the "set feat size" will be set to 0 to indicate that
> the feature is not changeable.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This looks good now.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
