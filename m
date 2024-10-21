Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC85A92F;
	Mon, 21 Oct 2024 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479003; cv=fail; b=mEN/I4Ch1youUDk3k9FA9wII6QQcbTWauJqvXg5MyA6KZY5NREt+gWY6Pts5IunbyZKOBeUKzD63sNEuJx8SXJczvBkZr2RERja2ofnHFH1C/9vpHhFENSXiDJLSG+j+HyGSqhG/ZxEXQYQs/F4VxV8mjvFwzT9sbNzjlApzvrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479003; c=relaxed/simple;
	bh=ZRUt4Es+WvaAikTK6g+qNyEZj+Cry4jR8vFJRKqgsFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IEirEy768o4JMo1oIY9WhxS2XoZysmLHu8kPkGbTHZEHNRI5ukYF61KrlWo4FLD6I3fKOWhR4EM+OnIb8ETaAHjnfXCkiJsiY6w+P5SYE/trwlkyZJ1J9ep+XI9E95ZBcqFVGh6P1TZunGlexk9sXDOoAiEW7eCtvzdHZ9Pz0cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwFuakZW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwFuakZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729479002; x=1761015002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZRUt4Es+WvaAikTK6g+qNyEZj+Cry4jR8vFJRKqgsFU=;
  b=VwFuakZWpmMcKYUt7lAyc5oxOiyTlKw6QU47AGyUF/A2mWQgk63w8LVI
   8QYgqBb0UlYMjgf5uMvxx14br7AqmrmgLwutTeVMjS1WJ7o6o4dlvoC5l
   e90c59u/4GMLmvsPFFd12lp+ONHnqnHbUApyzAzi+Cq7MiNXSSVBCApkL
   z96OSnR3rQ+AJ3Bjgts9MopiYV2Iyr/NcO2d81Lm3AM5GXRIs+yg17pra
   51AM0LMZCL9qiTuJ2DOlNi5+erUs18f3aFOFlIto/ICMNSS0DDUOMh/c/
   nBqXktzijlVVsPjciN5Z3o3C4dMiBfbEghn8EgsJqIs702uyBTEn9VTyq
   Q==;
X-CSE-ConnectionGUID: wkkpMCF0SoWlHbkUk4Ivug==
X-CSE-MsgGUID: 4bgNkm+BQJa+3bL+Q3VxDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29042470"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="29042470"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 19:50:01 -0700
X-CSE-ConnectionGUID: 4B+mSNVzRXi2UDaoZXpNzw==
X-CSE-MsgGUID: GkMFjwlsQGK3oMO496fQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="84446954"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2024 19:50:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Oct 2024 19:50:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 20 Oct 2024 19:49:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 20 Oct 2024 19:49:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 20 Oct 2024 19:49:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhNY1Twv0xuOFrLbHrCUyPPc3QJt8Ddygo/F+7PPMVWmqzkBU9FVDJ3x4jGE9eU9c/MrqfzVs4wOVO/U5ALBIOvl+gNFkTxI2dugAI+uBPFeoUG7/PaDrrT4nPGvI9ToQwrFasZhBf8jTPyhZzxY083siUG6PgvN7UMb/11DCd0jTneDJpnTCu0+92kySb4JQ+ou0S6Z+rY7gemKw08Eg+hi7ORoKRQzh+DE0iH4FfrKabrEi4L6dAwnJnX8ZutmDeLytkUeUt8fYp0uspawsQVHMr0QjSZrxrTuZvBHX7BdsNWHbn4RHp4M1k6E/O1FqSu4KgP66lNeY24Rs7W+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1HbS5viNU0WuRpm5mQQ9lGDHNe3M19emqQ0+PALU+Q=;
 b=HhONo3eVf1VmShyDtDc5UBjCFKHW+JFS8cysaUmZwQWxsybFRXULKlXiy11RE5l2oQO7OUAHNTi6kqWs7VOpVGbZgUkmG1Zz1hhZ6SfQBpxKnSPDouTWJdU/S4JQV2U6+FDuFlAIh4xlGMZdxJcTlRXEPEHrWQte9w29vr7tstbE8mpsaoavBI8Zz/yjO0lnJexeMJwtZ9u1J20S0MuXwJnif15jRJuEKCc1XcTwyZcsEKwHSdehjRRK6XK39GEXLWqDQjh1Sz4ri+D40TN7xhAEZK7jrcE4URyJ1tXdvC6qE9JS1h+dQ8aHFvUhKPvu6yubeDz0eeOEgnk0+kqa2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4622.namprd11.prod.outlook.com (2603:10b6:806:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 02:49:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 02:49:56 +0000
Date: Sun, 20 Oct 2024 21:49:50 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>
CC: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/3] printf: Add print format (%pra) for struct range
Message-ID: <6715c14e9bbf6_747d6294ed@iweiny-mobl.notmuch>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
 <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f244ab-6325-4591-1686-08dcf17b0c17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HFbC2YQ0sgEFtTnrSFh79LI5G7AZsypGCW3SWOBf89lOq54ji3wdD7NcBpsS?=
 =?us-ascii?Q?K0S/QgN9LFrXEEkb1e1ahZkVNVoJRp6fp8RN4BtfzgN/ED48zistR8NaMkC4?=
 =?us-ascii?Q?92zy+SOGhkCywYVNbFtbCN5PDUJs0MYfFyQDfIffpPIr+vAYrGr9fOeEyXE5?=
 =?us-ascii?Q?dZ1XiFHKuLSWIMLBCnRkBiHzRuOZkx8D9j4EK5A8WHvH+cK4jXZVnlSc6Aqt?=
 =?us-ascii?Q?ZuX9WZHdBtBvrwq2cmpIBFTynbeAdPht1KC9ThyyhNZHQWHT6JtJNlma0kJH?=
 =?us-ascii?Q?g1C8HJH985Y41ztU7jTY5L0z8rBjVqzAyiRyM55LKNom/yxHRqh0KowOuX4t?=
 =?us-ascii?Q?rvyHExh5gxWE32slUOAkvz4mHeArlf3qdw5r1sTSZnpCI0XbZ86cpF0Pn0cZ?=
 =?us-ascii?Q?RCf+aD2vRP9tS+SQqQqCILI+BHzGPIK14oZVj/qr936s5IqsXbwnkHB3Eh/S?=
 =?us-ascii?Q?5ajybuy+UMRdwKdXrWmuJUUbpFrWmJCr6ilmQSsxDzq8ng7cgTxn+9HmOhjZ?=
 =?us-ascii?Q?apa0Rx3SXNeXmh7J2NWFxK13TZvj7cM48dw0CX8+mHb/OwKKZpX5cTNDUGHe?=
 =?us-ascii?Q?nm5qMz9eO4RclsfiEouaAeg8PZBKI93vysZoJ31V1gf1nK0IRBAtsCjIQvyu?=
 =?us-ascii?Q?HlmIq9fNfgHJwc9aMT03wneKbdlkHCNa3vVx3+83IHhVesm681A0KY1ZX+qo?=
 =?us-ascii?Q?EFrVmy2QyCPpLDUvGxIXbysAF4O9JYNTz5JRX9n2nXWIBwWStUXSNMutXw2k?=
 =?us-ascii?Q?OEbxPJTkpKJCGbkjjwT9kxLWCOPE561Vyyfk8Zgo8sjMrOsHqp7Kd7w1aUr+?=
 =?us-ascii?Q?3PTQ63Ic6aAi4zkn9zwPoaX8P5KL1O01RcNbc0JF4m/sVW2z0xLTMgZaiUXb?=
 =?us-ascii?Q?41oIDSkCcaCLhrHiK6mXpXJ4F0zLrHaQD/Q2Y/8gM2uARtIW5OfWzMpQxbhI?=
 =?us-ascii?Q?UvIGzotHI0FvtXOE5cTQbsVhS6gqQUSpPMNNfTCkZX1HAg3Zbt2AzkoOE3fB?=
 =?us-ascii?Q?AgMiNOgY9yeo9+NpnFe2uMRafPa9oyl2tN2CfBgD9atfsEnLBGhdlBJaSmCy?=
 =?us-ascii?Q?o5GFiS6zwwtfklXrQpKtL5fPD3BW9Dd6pgyGYG7ITdumPjokyOqmGOhUPpYX?=
 =?us-ascii?Q?D3E1CHIO+Ej52kKESHyPeCS7WFyGlGciVBLLrdRcdHWHQhbLzzljn2oEc6v/?=
 =?us-ascii?Q?Z38ouJkZ2Fm5y2ZKaIcS7oFP2QUAQ5g8GxNQs9zGlDnG/l2jSO+ZlzjVr/ou?=
 =?us-ascii?Q?a3A7o4f2C0thJm1UxYGQ3QV+1hrmul7np0KxtB89mPb8SonJfW7kanZo4A52?=
 =?us-ascii?Q?y0SktPPanYQ5tL7sn6wzA/ZSiy9dohyCfeq0KFdf9AX+NGy/axx5mVelInzW?=
 =?us-ascii?Q?F0j+cJ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NiYTvlQcn9LA3Oz//pq1+ZtR8xn9AlqVNtAm7m0Kve144NRSRf9xdOaO0YFX?=
 =?us-ascii?Q?tUSlqYK3USC2vFQpdr3yvPnWiJYlXyIVe/SvX3Z636Co64/TzwT6gsyghr/C?=
 =?us-ascii?Q?dwwcSobwOCnGKxOsuVVijXM1pg1kbt9/XYbDPYYLWgkcRyiKXBKdnTNCv9Wn?=
 =?us-ascii?Q?wo5ZNd+WvsA9Lcljofne6GDsF6H2w2CVXJvz8AE/j0xkWK6wMYGTfvPoHzPf?=
 =?us-ascii?Q?vs5oaGZ1rFwBKkueV/R/sDRDJraR2b1eV4Q8al0Ef/JJa7ZMihnNVle+Ce1R?=
 =?us-ascii?Q?g69lw++YgLhc/5RSMAC4ksKbIlax+Ig3puNcXBD7G4La06XPW2n1if2CAZkV?=
 =?us-ascii?Q?myqkY5SJ4mMpgctdrbqSl9NCHr8NEvE59R+ZHPeCi9ARaW48ktKx1NeYM56T?=
 =?us-ascii?Q?+HlE0m78eX1b7kyYLyfyfPZe/AHGlt0L6thq3xOGSxel/EsJ4ULfnPiHXfQn?=
 =?us-ascii?Q?GX+9hn2q8VAcJ84CTCKDCtFoIOiue7mc7K95jGfESuzFsnqpXh3xt5+/TEZa?=
 =?us-ascii?Q?2ehZKyiwBiSuk7WACz3hVJwtQWveriWbRNBwOh3hcUSaathuB01DaJ3cQ0zN?=
 =?us-ascii?Q?+aFJwC/TiEieGAL9bMJE2gAuxotLm0CLDFBB/UBU7L1StmVb3ba/53SqkScZ?=
 =?us-ascii?Q?rcTP6m/OPl1vYhs4A7EV0RVSPPacyuKKzk7xZJPy7qk5erkAYtxxLCofw25i?=
 =?us-ascii?Q?iquilqfmuuwoo/L/WK2W/pwq2MVy/bqavi4WtZk6fimS3SYFFMO8/slsKiAn?=
 =?us-ascii?Q?BolW+mWQURHS5O+1YMrAfzsNvIbGHD8eWTPhR74NhjF0fiVgszWVE0+uNud4?=
 =?us-ascii?Q?0GdNYNE3E3BqF1PEZzUtEur70UmwMBPH2w9ObkyPaUQ57AGApF4YGHqSJ1Vq?=
 =?us-ascii?Q?qXQnn2VI3P2rcOXQvJuztajgeq7QxtcGHPFL5geMiXj1lttkh0yb6HB0Bl0e?=
 =?us-ascii?Q?kbfv4h+1y87/wCbFyggcoeT/tyZ20cpiQ95g1/609d/EkcXRVz3gkhfwDtUw?=
 =?us-ascii?Q?2Ezt2QCZOTeM3/xSNnA2JuAWFQIf5AspWVraF1sOsnKzigz1a+6uzPvKwtH8?=
 =?us-ascii?Q?peWbawcCdOYWtV57+zpff0vXGRTjZR7/NjmsoTml8GyQcHaH7tkiEHSat12H?=
 =?us-ascii?Q?8S/3jIvGtLaM0Lj8FiBGPkAkBLUnKe3arZ2n8dtPrsljZMPlgcyABWKQWI1X?=
 =?us-ascii?Q?k8NkfjJxiXAKYnRuPtkTzhh2vZbJTR9eU+r6kdl8NBNb7cVzaN7ZRfCtSl0B?=
 =?us-ascii?Q?tEmN0CbriTPVOlW1c1mJZyPia2zk0vgrElaU6tgbblrNhp1iCK9lvppmPM7M?=
 =?us-ascii?Q?vWJxiaVc/OwSaD78ixsKmAVl+OTFYiVsDo9XqV/iH/W5e7GL8rGleKETlNy+?=
 =?us-ascii?Q?OJXileoalQElCwHoHSbcM/FRuYdjUBbNHyHWQiHQGun+XyC4jkCa2OPkkbGt?=
 =?us-ascii?Q?6KpEGrpP/L+fGtKKre5vgqf3O2D0/6+H5w4ir1p4riP/68Y6xQDzR4Isy+Db?=
 =?us-ascii?Q?A32GkheQtczGjP5WNyJJLYvSPEnVyyQPH1t+I/vMBAR/gVFmiJz6hrigJGzr?=
 =?us-ascii?Q?arFsf8M0BC8NTwXveybLqH1buAiGATsbFj0H7vn4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f244ab-6325-4591-1686-08dcf17b0c17
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 02:49:56.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N64fFFZKUapv53rfRWmYakTHTv3y/slM8VgLqfBsr3eemMU0Kk1fMsDgcoZCYafLAP81Jr5I2wkc2ingdgsnRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> > diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> > index 14e093da3ccd..e1ebf0376154 100644
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -231,6 +231,19 @@ width of the CPU data path.
> >  
> >  Passed by reference.
> >  
> > +Struct Range
> > +------------
> > +
> > +::
> > +
> > +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> > +	%pra    [range 0x0000000060000000]
> > +
> > +For printing struct range.  struct range holds an arbitrary range of u64
> > +values.  If start is equal to end only print the start value.
> 
> I was going to say "why this special case that does not exist for the
> %pr case?", but then checked the code and found it *does* do this for %pr.
> So if you're going to document this special case for %pra might as well
> update the documentation for %pr too.
> 
> Alternatively, drop the new %pra documentation for this corner case as
> accommodating the U64_MAX size range case is arguably a mistake in the
> caller.
> 
> Either way, just make it consistent.

I've dropped the special case in the documentation.
Ira
