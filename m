Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0118C05
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617818; cv=fail; b=cg31gCN7H47P0qZOlMckPSVHkbMFCCMxU5fGWKd3XrhP0swD6gPQ3f1otbFR+uUvehwh+U1ufmf2kDU6qzsMY5TcI6mGA7h63b3w7ruSN1zWD5tnqchIWEXLDOdC7tTn0d5t6x8Sq9PDiLxcjrsP+PGdBmbXVPl8QyVwSn+rysY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617818; c=relaxed/simple;
	bh=MySmYRsED72WMgvdhkmEI0K+gnbyoRpZbldfsiG9ex8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tjV9YMhg0bzyvENazp1m+W/T2Bnp16hXw6Hz42AuOWdl6hoJ1T2Z89LQt9ZiVoZ/zxIPb2E1aOMUeRlIueFl0jcsHPu6qmhfwcMxvJtNEa2eLfWXVsCTmUX/ZCnk4H9CT6QZ3jF1xFqFhYodQN4cTI9EY5Kj2zG61qCJGyZcDKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIs5iK20; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIs5iK20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712617817; x=1744153817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MySmYRsED72WMgvdhkmEI0K+gnbyoRpZbldfsiG9ex8=;
  b=LIs5iK20BSeO2oDDon92qlnR7poZAxaFb1tgdjgOq7eeJKwxh7Nb+IDh
   VE6tOkerh3vLQf6TVqoD1V5goawdvfJ03uicQJ9lvkX9RR0MJIyW0dYv5
   D/1xdHhYZaUsxTEhl8CuuoD1ILKxLf/6SvqLFJGqHV0avRbGHGB4zsJFo
   DuzrILffBmfeSp7p8J0q5fWgZYNYtB+Z0UBKlb8qKMSANq18qHyWHy6Ni
   gsx7TsctWrfezpRJ06gRdAdMv+0VVO71t5XaS9JoFppD02PxlSgilU7Nl
   Ek0wd/YsFszUCGHkRrHK2TQAjLFeFmmTxwsYLynN4rN4JwrimyUxAKJAM
   Q==;
X-CSE-ConnectionGUID: fM+kpK54TCCExlsFhWwqiQ==
X-CSE-MsgGUID: x3BPghyoQEWEj0C6qrtxHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="19299131"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19299131"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 16:10:16 -0700
X-CSE-ConnectionGUID: 9HsTQyp1TZW+GEoMRCTDLg==
X-CSE-MsgGUID: ExiHO57vRaqEFi6AyYRySA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="20600294"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 16:10:14 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 16:10:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 16:10:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 16:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adHJqDpAF/XqFHlHaPLiv7Jh85KSrnc6q6zksjJgFM1C7aaMB5j+ZW0BeK5TjiTxEiB4LNc4sRN+5cqMmwZkvtCa+dqW9Pw2nD6se91egwpP2dJzRX0ESs8+CpELWaxzg4D/ZkMDDNNTHgh012j8lvQBZeUjMnRytSCo73dbFg9iflE9sXJrvOXUF2uUn9jHu8/WTG0L8HhpqTYKTkBsMQi5leHivi77mA3ubmJBSk54R6G7SyGd1B5kbalyd2hI3g96U8BGNxyT7W5wHZlk6jHsNKiFPhkycaIwFR2HyhQz45P9PGqktcgsH+iLinlEiY/9dgxiL1HATrQtlyU+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK4RTKdv2Cxmmbt2mW/CA5qWKkLQUQgIvuQi2sPN7jw=;
 b=B2mEbedi1hym92Rn02gda/1BSei0EcFQCuRbQ64hSA6EmJYEMbpJPCX+PkVFrmasBpXXLn9ewSWuIQ/B+IVhbf7kFwEO1VGh2a4X9ywWavKtUEu/2Dj52OQFm+PyyhpXqEQHjX/ArW6ri90MgxPUvw5MS49sZeCuxn3MoVLjG6bk3gPrUEHPUrhASzxgvVYAGuuG12cZA2ZRUC1UM9nThEEA9YeanwXViwxeBJ/WP7a+4/s7ax+2AZc4BZF7cHBnOaNegXet0jlVjspef9/E7CezO/VwAPkWd9VWNb0QCkejn1lLlV1JGUe/bEiGfBQAaPljSJ5Gyd8fKn9rHtnqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 23:10:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 23:10:11 +0000
Date: Mon, 8 Apr 2024 16:10:08 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] cxl/core/region: check interleave capability
Message-ID: <661479507b94f_2583ad2942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
 <20240403021747.17260-3-yaoxt.fnst@fujitsu.com>
 <20240403152744.00003b6b@Huawei.com>
 <OSZPR01MB645303D2E199F2AFBC38EACE8D002@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB645303D2E199F2AFBC38EACE8D002@OSZPR01MB6453.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6676:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vRpaRv7nHkxJLDMSkcih6BKlKqXUfK9BETd3/1MYemBlUM5vq4HdtU5gGftQ617KOHEOveqrZAgul/M67VJqcrck5kNdR0tn/GFqeT04oeupDOZe7cvc7xjnJ32iKlSaHlDUk7Ngr8uCQzoWobaDdi26jvNaKc4hGZhGmsyBvBjQ/cU91yQItnZHEpgcXyb/yi0/Pggaa5RVO0NSA7s3itMDYezJMe+XMQ1A9tkCqsV8pw8tQCkQ2+S/LX19qfcwsNMnJ/6Bxm4UGD4yqBZmajzVkf5sY3l0/7X4oiqbKH2i2gqcnf7LHlzd4CTbb25B1AREI9ACtYrt2HUcj7J5W9VlUBSCDRwW8+mfpTS9+uS93lJ514+5QMpq/Tbr6XkMZOAxXZlxsluG0/mBnKlfufWsoznOLL+iMUINaW87OsULDG6zeESN56JOcTDrC+8KLCC3Z7jiS0sZoW9vYJUyg0goXGQaHtE5N/RVc9cDjysRFV4vHzKXWDVZtl0Upu+xOM8Q6+1/IdWd+yOhjrua6DoWl9oF9eh73gEJiHAtB0tnrHYa4wUzhY9Wk4XjGBabhZbTk/viU525S8zQ1I0y3nZSHUQj3HvTaE2r2KUQxMQiTvluqI024kWMPe6tUYhfgNCZjzq8z2c8wSMbHK+dAV0wreh7Uexd4bMQP1hQ3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+0QM10po/cIvlhXs/I2wo0Z8kDOWGILZu1R24YTJw84iGU73WLVoWmAJG9JI?=
 =?us-ascii?Q?uK/I/LCzte7kdOYwaCbt63s3o65JRK94KvxSP2UEHTOD6zNCIz9xrH9JYuJ/?=
 =?us-ascii?Q?l2mrGL6QEsDcnK9Ai2uKQSR0kpCrT3KX7h/DxOV5q9ZmJfxf2ORFfvrh7UOl?=
 =?us-ascii?Q?/fEyk1rPE/N6i/SUJhJwMkIDCnWHjXCRnF7dfe8bVE3fxjaV/66bQZq0eKcG?=
 =?us-ascii?Q?XaGiJSDNTZ/oXGOGKdmPQPKSv38J+h+uW8aaONagA1bOEzF9/Pm9W6qnWPGQ?=
 =?us-ascii?Q?XLXC4wwXt3UImej8cDcVqcMlF4wlj2On1NE6HSuJm8i21TezLtfSwI/S9NC7?=
 =?us-ascii?Q?3jIzrtLDjK0/9uqLQcI1aMCkEk6/N+rBCNyp65Fuxj3ypBBDxWPXbVytEOwF?=
 =?us-ascii?Q?SikaUYzYk9wK7ZBuA1Jdz1w4Cyu2d8FWEkBBuB+2Pt6vHb8oZIDhnEYUzLlH?=
 =?us-ascii?Q?uYRW3IgxSD7TQAY6yLp288JVfdjNyAGtcA/HKu5OHIKDVxWsn9shYwLegQgP?=
 =?us-ascii?Q?aGEX8N8P6n7r4FFRuJHmi5yb5eWf/Mrvn+5o4epCQhhbnCrkfKpurJfYhHB3?=
 =?us-ascii?Q?Synuk+WqOJ3SFf4H6nyRXS/p06kN6F24NLt8OEZGZgV0N+oqb/nz0PeBpo4y?=
 =?us-ascii?Q?emyYkXBYmCVDH6mAX/2C7FoDfEn7gslKJZdmh/YiPPRpxjlUgevwhjv6xx22?=
 =?us-ascii?Q?L+SMmMyXZHq/jhtHPrIi74IXtjMY6jiC7nNJ/KJ6ln2WzozlJpTgjIagSLUg?=
 =?us-ascii?Q?cB0wgV6kIL43RG9lS9Af2ldBoaT6ZUMuan462ZemrvvEPZCYbaMjEK8wI4dh?=
 =?us-ascii?Q?VgA8uXhkeIvLDm66SIPP0lyhp5lAD6KVkfkjQdCODLMJa/aaBTvI6KFpSfJ9?=
 =?us-ascii?Q?2OHU1Gd7mcod5HMrnCu3uJXFM4yknndf9EannycAd2yjEPjFRxzm8/gyvliT?=
 =?us-ascii?Q?azWXunTwHXKjPG4L7LkWJvsh0vE9JsPyi08vlnCDF0I/ZkYifllpHJpFqZBD?=
 =?us-ascii?Q?hUxMipqdKR/at89hMNu+CspX5HRqn270zl+NfbBLUivaDEItV1Qw4sYjaELE?=
 =?us-ascii?Q?FmBt8gB14vVHouBW9YWHOLvd+6CMa6PEiC5r/jhJdel6Nr6vUKidcH1J972V?=
 =?us-ascii?Q?s6gbK/Bpc3NayZ1wGA2UX4qE6GddT3RrmLA3JHqhmZ28N4aAvX8QKbOvR9LJ?=
 =?us-ascii?Q?1OIqaAt+ZGQsm747BpYmWPafAFQKx5TSQ7nguiEkkuQQMHbn3xirBqbK8y+9?=
 =?us-ascii?Q?4t6BqW8ErJXzxNTC1qnmW7jsIgGdBVnNiccjwc5h7rxyh9cThW78vPkhSULY?=
 =?us-ascii?Q?b3cdRieGPmkOlaTXjUZqpcWjkC+or/pZVqAm3fe+j+gnRrSRi6YZfR1PKO2i?=
 =?us-ascii?Q?fTd5dlfCr34jE6OnLvIBuI3BpNLkTwRCTbLJA2PgcfyQk8adfj7pq6tptaxx?=
 =?us-ascii?Q?lQ3VV5ZuFj8y+TJuh8Y+KxJTfywYlcFKNOFgUj+bnXyvYW7jjbPVepYVpFgH?=
 =?us-ascii?Q?oJRGLczqipNc3oJ4nE3LsIwyRnaKL4vCAp4C37PGgikykwMWpkG7EXXL2jMK?=
 =?us-ascii?Q?ZahDhuHG5TWAR/h/ho7tltgjscZDJHZEtV0et8R1SxgJkO2tEzKx1U9AFQlt?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e003f2-3956-4a68-d316-08dc58210a39
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 23:10:10.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeE5zywpAl9v7JqO6VBG7fWRRJYMPCNY1J8+9Y5GyKcUqP5zPiNBgyr8CAR5ACd59G1bj7nknckx4N5FCEAnx5wR2rsm5YiTYRCNNUHFgeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com

Xingtao Yao (Fujitsu) wrote:
[..]
> > > +		dev_dbg(&cxld->dev, "iw: %d is not supported\n", iw);
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	rc = granularity_to_eig(ig, &eig);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	if (!(BIT(eig + 8) & cxlhdm->ig_cap_mask)) {
> > 
> > This seems too simple.  Need to look at the calculations in
> > IMPLEMENTATON NOTE: CXL Host Bridge and Upstream Switch Port Decode
> > Flow.
> > 
> > For a decode of more than 2 ways you need more bits to be supported.
> this is my misunderstanding of interleave bits, I will change this logical.

My expectation is that interleave_mask is an address mask and can only
be validated by multiplying it against interleave_ways. For example, for
power-of-2 interleave_ways:

	region_interleave_mask = GENMASK(eiw - 1 + eig + 8, eig + 8);

...that is the address bits required to decode the interleave, and if
that mask is not fully supported by the device-address mask then the
device can not be attached to that region.

However, above is untested, please double check my math.
