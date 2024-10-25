Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521821A4AA
	for <linux-cxl@vger.kernel.org>; Fri, 25 Oct 2024 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872371; cv=fail; b=naTNrQKTb6PVWFdUOIBKC5Y4W5SZhm+7hYizDSmNtVZR5HqFvyhkwTkZ34u4r75qXE3P45BUFjY7EHFsIc0g0g2X7LIlgrz8pq4ALTWM4U24yR9kjjWdhqdxFu/o8snZhCFGngxMwZZj+T/fQtOCzW4qWTwhpCOjmNN6hno7Sng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872371; c=relaxed/simple;
	bh=2Mb8D8ZsSRsC+C7dh3gSIbbRWTABXgFIEEBT1SopPDg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rUHICR9a+Bvld02jf7RYF2xsn+/cYvUgESCuptxwzL0rzVZ5NkXJ9KR3xrSGuD9Zq30ujgWIxQj6+1zxgvm2aQllT/CBw9YEtWHTuh/lZV+GSnYTCAZ5+q3K5xKnfyG5f1BsgM6KrNmze8A3c3RVJBKWWqOTh00l8N8ZWd5/WCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCFI53UY; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCFI53UY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729872370; x=1761408370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Mb8D8ZsSRsC+C7dh3gSIbbRWTABXgFIEEBT1SopPDg=;
  b=mCFI53UYI/F9/i4nNzlC9//O7V9CJXgNj7agZDMBgIa24y1w7G0wYmuc
   dL8cQmdgh3DVmQo2isD9m6rqJhwvWNJEnk83dxRmAKzrnTbelixl0Rb1T
   FH1T6QZ5meACASuwEZTFGJK+bwQLoUX5gUVv8H5m9gSeOf6WhPm1OkE+a
   OVx/6IkcHmTAkViK+3QQtJ7oYrMyR4Wo/KsX7WKn1Z0lj6BvE1MfEcxlh
   cbWErTyrLM8KPQaI2H0yZfBRGw4I1+cQCjcchI9SB/LtVyyRfniLVtWzZ
   0HENxqBHwqXABkdohKmfHO909MF+wVBgLBFpL/qk7vrToPGhELDLJkUcN
   w==;
X-CSE-ConnectionGUID: Hi8A8dCNS2KbT/ndN4laPw==
X-CSE-MsgGUID: XqWsJ1YJSMGP/ZgKxLkjbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29323085"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29323085"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 09:06:09 -0700
X-CSE-ConnectionGUID: VW8522ZKQ+WIw0Z7j7s0mw==
X-CSE-MsgGUID: j3EYZRWMS/irHrNEVQRPNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="85540604"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 09:06:09 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 09:06:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 09:06:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 09:06:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoRKfTgxTLDC9WT0YegsA4hXXS2JOW5So/4ujyZ8EYqVENsFwvnIu4gRINN5cVhQCbe9b+abn5XceqvOL/UXh3xPyEbRLF5ZHO66cNyn/YkO7NoZjyryhmRQQOETWIkkyLjPsfCyFiQrzkILKT6GN/KBx3543JS81ugMIIePjrqP31JNQDRy+FMItiBjc/8+mE4mLWCJ7hDSqacIWdlcog1tabUbjDMwBM1cRuEXT8y1MFvbzPmDM1SZZpBM0/0oHYnEH93VckL4tLOM9bxHDko4UxIUWc40S2N7DIo3PSAxkdDUclwrn3ykP9p29EHLU4h8wVSfOqi40z+RJX1Djg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfS7Xpsw3kmTlySz/yeM3wsnU3WEy8LMugZrt2dHLvg=;
 b=Pm4DbW/XRfqqN3SGgpmcqrquxknNQT4qdL4B0X/NMMfh08m1M23YkS5xOcBH9bpOwyRdd8TBkXuR+DNFOBOq+vpYhg58RbHVfNd6E43TJeMpVlvzH2Wg8ysFvlPXEtqiJGR8uVDzTOsUlCbe8qAOp6ElcSHr0oVKlOE411gWkUJuzpoZCFclzU7bka78ag9T/AH/x/3g/9FcD3atv4BipytgQe/qz2qBqkPFxkzyO/nohoGa79ZJlNM35epTE9Ts0yqbVmIVDHThEtBDPeQ0utLQq7rkoxf4UmY6LlSnfEYiinAXg6j10TEGs28JwTy2WzF3eCMLVSzbJLmTq52v1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 16:06:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 16:06:05 +0000
Date: Fri, 25 Oct 2024 09:06:02 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: CXL related lockdep splats with 6.12-rc4
Message-ID: <671bc1ea774c7_1bbc6294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <671bb6217b2b1_1b7aea2942f@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <671bb6217b2b1_1b7aea2942f@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 64965ec2-5539-4e4a-73a1-08dcf50eedcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/BGadaHDUYJ6EoxEjynKaihxxv6CfggAXf/UQmTHxFhmV4+wA44Gf8UZDh/G?=
 =?us-ascii?Q?WocyO6UZPvN5WRJMs9/7FA2Hr/T/XRtxQiBQOtPN1JG3sAv2tGPA32NpqyDz?=
 =?us-ascii?Q?RwlT16WH4cqxTssjxhs29sHqmhgUTygl4F4ZkS2v6Lsi549KK8Ik8iK7NQsE?=
 =?us-ascii?Q?Mlwd4gYdj+bzM9rcWohKLNXgreXWkXwnOf4pvcJ0o8yk0bTX1Y3tZT9ioqDi?=
 =?us-ascii?Q?XDFUPOQbulKK/41NV1+elMdgsIqGXJjum0qpY/Rge0b78Lyepr7/DH+4cKXj?=
 =?us-ascii?Q?wAmJzBtVYz+MHn0WByfloFA2T2RaqYVJGqDg/Dfe+TC01a1OB4FK6RFeuDHF?=
 =?us-ascii?Q?hk5rBTCnfq+i6eJEDbB+ksIJI2UP10WdQ771R/CZbes38x9PaGIJgvEBFvbn?=
 =?us-ascii?Q?Pt+s+3ahcprBQC7RqZu4TC4PnIepX1ss5G/ehOrDq94QOAxON8F8+Efmi4RB?=
 =?us-ascii?Q?ARXD115gf9Iu6DDKKa3WkkFngrGiDqB2NvKpg3lVotiCCIRKTOX4AQAC9OvD?=
 =?us-ascii?Q?DEUhEYNVjm7VdB/lz4b1gI40ywxRZT2HvFgdpu1wEpP+meqOdzEUVotkRMlx?=
 =?us-ascii?Q?+iIuEYmmlATYHNOZQMTvYXs5TplUzANJ9wZVD3EYOV2eJx0HMcKDkUxQLuIB?=
 =?us-ascii?Q?duIX0dE7si17FaspuqAHWybjeyjyj88jdT+EvioJvvkH36RHQAOCTWrnrf1y?=
 =?us-ascii?Q?m3WDUBfamYju8uiLKJXFEmkuomgQD2LIlfq2S0yC1+vCpVnKkiQnEc2ON1br?=
 =?us-ascii?Q?8NJvOZWJrlSPtcoADD8DfWlRsn8CpGiB+8AjsvC8Bn5sZzhqoMVvazSyUUQ4?=
 =?us-ascii?Q?WPv+WKZMvUMg5MuD4P6jccPo+mLptIdhNcBccuHjkOBBL9+9dnLbseH8Xg/T?=
 =?us-ascii?Q?dfZjKlGZF9z6hWrGchtmElQV77cB0ZKD5WLL03N0s4IZ1m8TQTKbYUqx1QAT?=
 =?us-ascii?Q?dx9CJGavTALx0BTIP2D5/Ihht5ussoRsGTq7ykDlNxIgrG7SDDOmmu193Emq?=
 =?us-ascii?Q?iPDHnfsdwG1OYwufcmxGSsTZjNHbQVt9AaET6lUUeZuywRfnyvniJCqrqxg7?=
 =?us-ascii?Q?f7dYV0SYw9KPV2jKnEPbnyRMlB+OY53ZI9wRvLe8ffm+3JW/HDmT3vw+W3DK?=
 =?us-ascii?Q?vwe12hhkFmEijJdp20yqCVBFyFBpOPgJ3fPBCqSykIAdbU26z3QKP/cszMwW?=
 =?us-ascii?Q?w6JfoIxWac7XigR4v6KH5ISoz4qTLC9saplgmjPTGFQPO+YeKct2IvaUBL+l?=
 =?us-ascii?Q?+CIrMQOQR/Rq2xd1p/0p+0Sim0Mw/kHS4GdAjBvWmyVdVVuyBDsVwpPzMRac?=
 =?us-ascii?Q?pbaymzeF6LHK5Ttfvr6eL3NU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VoziusdWo+bwy86ann12P+cJjGSYQSEvYTmtv5AlAC3AFjulaYDwWvL10vWx?=
 =?us-ascii?Q?AImVnWsU8xvQUxtqPP4yOraz1VxYVrpApGch/4w/qzUwwh1CLF1DzaEUrsAE?=
 =?us-ascii?Q?r1h3V4/wiD56DykJqDuSl4XIGLMYAvcbKCaJx3CA0ipJdQXgYKZpIlq0+xCs?=
 =?us-ascii?Q?Dg0nwylsRHf42uileshwQQUR28/sDBWeKdHwCc+Yddhs6vZ/NnU3muEzerQW?=
 =?us-ascii?Q?CGYGJY5XFye5E9mNV59axJwfLJ9vJ8OTLHwwz19V1MHExBVKHk2deq2/evMb?=
 =?us-ascii?Q?SIMjB5r6tl+qmqPjEthL20UNDWaC3DiHxRCbF0/PUm8rp4NcHy6Jd2oLV9AY?=
 =?us-ascii?Q?2pVIwvfibZfuaeAuRbR+0SWUX8w3Xz674jjmTFD1vjCiKyonTxcB4b7UQMj7?=
 =?us-ascii?Q?bRkCeR6uVmdDB5X/uNwjvRatLu61VdRVxTdrT3bb8bpdU6GaJGR1yVe73LzE?=
 =?us-ascii?Q?IOwyniHmWmYNMW6xwJJ+npzEHbRlz3QZj/AXEzSzye2CpDOpY1ns8l3wd/9J?=
 =?us-ascii?Q?8SRpKaNqOBzCQyWFK3+41T5PXxmhWP3S0gp+Ho4iCODwx2+kasBnkOoHvVxW?=
 =?us-ascii?Q?livw30lkbWj9PWGfT/N/PEbBDuAoKyQ37/qPEqFLipSrz79MHwxpw6AUD/vf?=
 =?us-ascii?Q?gu2hv8sfm/ND0fTBq4kn9xvg9ZOxc3QEjeJ+nfiNfc1nsNTLZ5r2HvDX9y3x?=
 =?us-ascii?Q?1GvCEfnxr2/+Q9M95P6zoVSD/UAhBO8hXXAgMeoMX9U2TkMWyV0UTr/lsSJf?=
 =?us-ascii?Q?4p4vXchE2ZWP48epSTqle2nh///PzC/8a5VfmS2fU7rwj1Gi1gMi5Ucj2t/E?=
 =?us-ascii?Q?a55e6LxGlEc4yjFeSaYzl7KSPTxKtejvWleOzhFYrkhY7lF7VGbEXBxCDKQM?=
 =?us-ascii?Q?SZg1c41TpVInZSA6kAqksCSJyWgl1dD5Q/beAQ8f1/AK8GdVlg2KzKOA+OBE?=
 =?us-ascii?Q?WVQuQARYGkbwLCitafrdlv9+ElA+9tRfHCfLNgLrguh/hoxPUnlVU8/45X8G?=
 =?us-ascii?Q?fATxZIwQNHMSSKnZqCqDt7bIWWz69qqmBHs66F9dX1+yJrz96HpFJSkI0X3P?=
 =?us-ascii?Q?5Vd5QZVIQpYlsPr/fpF6ekUER3+USaqkNA2+T/56+QSbtaBVx6bAMVRk7RUt?=
 =?us-ascii?Q?Ehbl1gDg2qfSZbL9pWCF+R5olXRhqVQrNBOB2//4DhJzEZPcOgJeUYyYJ+YW?=
 =?us-ascii?Q?u0Q91400S/lRpD9TXiQzSiH7jmwqDPCIjMlSj/8tWye3U5VzOecGzVYmIHEe?=
 =?us-ascii?Q?48MJsp2oN0zFPFrMRp/rhX/QFGEWj2udxHHl1PdO5hAFv/0Vjp5f58ty+EW7?=
 =?us-ascii?Q?ZdFq9+qJ93W5eGtyiB7B3LqS4C1UH2CywCKwX1BCGQvQF7G3ojcbcO/OXLjO?=
 =?us-ascii?Q?R4FXf5r5C2pDu27YnJQznFyuQ2lDuO/ajvdyXPyICZzuaMuEvML75TzlJ5M3?=
 =?us-ascii?Q?eMNzoUEr1yjptVtuBMVGws8/QC1IMoZBq3ZTQP/r+NsmbnVC+PXLaAbYG5W8?=
 =?us-ascii?Q?tLNxWvl7sO4hEU6nnemgyMY7j5M8va4U+HqhwcWKFUDCjk3b9qv4yjKcg5az?=
 =?us-ascii?Q?iGIQnmY558nM6b3X/SLw5p1ekHfY2Pr4YJxEuGC0kwWODm44d6Llt2hQRLYO?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64965ec2-5539-4e4a-73a1-08dcf50eedcf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:06:04.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in1vk+mRAjMtuq2rbgHFqt/8kcKXwwyG+tjdBqbZBWfdnTYPQvwQaCZJZQL8b8a/f4aPdq/U5NBoD+6uTtkQImiNJoupc2g7o+uxlX+r+jU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> I was about to get cxl-fixes soaking last night and hit the following
> lockdep splat.[1]
> 
> It is intermittent, occurring about 3 times so far, while running all the
> cxl-tests (nfit and cxl).
> 
> I've been able to hit it with 6.12-rc4 __without__ the cxl fixes patches.
> 
> So I'm thinking it is something in the device handling which has changed
> or missed in rc1 testing.  The intermittent nature (I can't even narrow
> down which cxl-test test fails.  :-/) is making this hard to track.
> 
> It seems to hit during the firmware-update.sh test (which is not even a
> direct cxl test.)  But not always and may depend on a previous test
> causing a lock state to trigger.
> 
> I don't know if this has appeared because of a config change or what
> because I have been testing since rc1.  Config is in [2].
> 
> I've also been able to hit what looks like a similar splat in [3].  But
> I've not seen that reproduce.
> 
> Any ideas on what might be happening would be appreciated.

Going forward do look at using gist.github.com to share dumps.

This is tripping over the online firmware activation unit test in
nfit_test which is strictly an NVDIMM path. The fact that running that
against the full CXL unit test finds this multi-stage lockdep splat is
interesting but also not too surprising.

This is part of the reason I only run:

    meson test -C build --suite cxl

...for CXL work, besides the long running NVDIMM tests that do not add
much value to CXL regression.

Online NVDIMM firmware activation handles this difficult side of effect
of memory going offline in a way that could cause DMA timeouts and other
problems. So the solution attempts to suspend all devices over the
activation event. Given the violence of suspend some deployments choose
to just live with the blip in memory response and hope nothing times
out. So, I would say we should probably document
"test/firmware-update.sh" as a low-value test and hope that CXL never
needs to deal with devices going silent to memory cycles in problematic
ways over firmware activation events.
