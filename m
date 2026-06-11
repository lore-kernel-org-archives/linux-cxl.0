Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D161519B4
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138671; cv=fail; b=Y+SSO42xfdOzZPml/VxGZVgej/5+bpSQCf9J8eTmGkCe8dkcfe/LnYw1uL64KVyKTb/F8FsOL8Iq7l8j/5dNIY3hHGeOfvMqKzm7G45XAUpDXseVyaxzU6mfy37rev+NbAJIh7WPUlBrDblmRa2NX7DtjV3nr0VB5Z+rMW4LV3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138671; c=relaxed/simple;
	bh=gycQAGLClp3UfvBvsOpbQ/WkyQUST96xvJo0BeOKLi8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JTjSXHruZsr3ei7P8g7sXfHGeKb6k9tp7YyZB9kiEFsuW0yeFuMf30W6Cpew7vYxgajuP/hDz2ufkiH3cKEZeEvM+mMixrpmOwyh8gTcHlB1U2jG5lnvj38U4/RMsHvL6aYvLlZBUinticIYVD6siBYbd5pJf4qZ5PnWohWcGEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlZmOvCV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlZmOvCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781138670; x=1812674670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gycQAGLClp3UfvBvsOpbQ/WkyQUST96xvJo0BeOKLi8=;
  b=hlZmOvCVZGzPl1csd1e9loMeoW1lWHb0SJFmXhiRQNc93aD5AqdXzxEM
   1Mm4IL1wtT6sEsXBv1S3cXDCOfEUQq/rx5i3eTW2ZUVPr3Djh+G8jTXbT
   hjaYyUwX9wtsBVExeEvqH8NKFwvJ3H/+G+6ZOGFEODQG/zUrXBU65HhYu
   ivHaGtefzZ26Ha8czNdOpowHPB8p2hMqzFccw34S0C/1BF00/683+eaDK
   oSGaAPMP97tB+z0eMtz0kmT1KzG+Vjju382p0DLwL13V59k1heS+UEjC6
   JIJdQr+hcRAafmWD1VqXtXkoE/Hat/1TurWKCNXvx0bH8yueuXx4KDMfm
   w==;
X-CSE-ConnectionGUID: 7FX9rEsGRhqzHKUwz0sMlA==
X-CSE-MsgGUID: PmvwIm4gQLW03fzH5F35yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82055721"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82055721"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:44:29 -0700
X-CSE-ConnectionGUID: DPRmo13XSRKuohjJNFbCcw==
X-CSE-MsgGUID: Hqrj6JcCSLWZgZQGieXZmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242187129"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:44:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 17:44:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 17:44:28 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 17:44:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIM0mKkBJiM2R6aEPXMHBn8E1ET7wiVC9fSyi9scoJk4MfxGzjmSELKjkWDfRFIi/PDPW6wDjg1j8b5gvbUP7mxoc7HUuwa0EjVLk2ZCVXkaAznSbnRp7/pk1d/+P9Ik65WeEypBtiXHkDjAUTH95osxM9sPlXlKHTwu+KGr0afUfFA0zREUWLZwdJsNCHho1JIY/TrTfbuZ8pJd2A6HGaiMookCk5zx9xIVLpkNjHiI18bCdMPbK+0moOZKv+/UCb1rGttsxh5UbGNgd2WmSrfE/GUj79CM6JpTDhKKl7WLraPpQQF0S2seuRNsmTY+jvNKuHannJoY9YijpWiS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeYEUQZrwET57CeEXUCvZxXI5+zb4XF3SR3LMMmilcs=;
 b=Eav+aTyiI6d36ildUi7e3Qt7gZBqEDo9kJjHgOId988b64bBEOyyKmdiUnbmm9+H87rXsrr+57JsNn539GoLPqEmfjSW/CFN1ROnG0T1P/mZYgdYZHyTKY5lfzaP8qYO4j+Cg0WcZ3oEOlJs5pfU7cLdYbENcV/0lieX5p/d07ukOVHxOSt2m0fUuUm1ZyKYno5ugUbqSZjRYG/bRyESNoHJDIhlEKTnb2sOce6KnlDEdwsUID4DvsEBZZSTDKGyoY7mPlT4UuCQsRLkvtFoSUZb7BbTriD+2NdWRVUl8Rs1h5at69MBPxo+p/dCvTJpxmzLCHekvQabaRym9OKVAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 00:44:19 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 00:44:19 +0000
Date: Wed, 10 Jun 2026 17:44:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/6] cxl/region: Derive port granularity from selector
 bits
Message-ID: <aioE4C-FOFk_sYZr@aschofie-mobl2.lan>
References: <4feca2a522e1e380495f22742551dec230ff0618.1780095671.git.alison.schofield@intel.com>
 <20260530002613.682E71F00893@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260530002613.682E71F00893@smtp.kernel.org>
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d28fda-4302-4ec6-c61a-08dec7529283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pFYBgFM8o7VT5818xzHjCGaktRFKYe/7JdF0cYUsu4i8sbebkepKmFE8YNF0VSuQ+ARRFRtnZUsU2ZmcEFtNlanWeWz3HTV1RugOuV88nk2w5hMJXZvAfXdwADL0dYEtThHa1yJq9ZZuOm1pLD+HVW1IzSB4gMeSOhFT6TzNIJlfaNxhFkbN4Af//4sOF9vpnosj5mcBDGe+YbQnRgS31Hf5m4oCiPsVF1ASO+2x2Yl2V4fFzEyZD4AnvWLTb0SMSi9S40J9Yigpmy4XsDZo8DTtNGP12SZNZR/GFD0t+3ClYKGy5S3fKz/5Iszi91h4phlwFtj6loLNrDqwvw1h3WjcAeZIv7B7DMWiTjDI12RHkHpWlfD1LPz7PVgFi/NLnAO0/ZtY7nixK+83U6G/DKjdrjQoM8ytafHm0A2S1olJpIaD41MfPg1gOmGhBrTqh5Y2bgqUpGjLKq4kDdQTfmhxl2o1mKQA3iLFjgNqP9Zl5pD9vUpIqifATGZjWPz2lpZPA4k7URrf4gbO5p5cIzEG59esdSdjYJq3lbumC5m+2u9SVa6EQ7xxFEfQOJfFi6DCKBvp/ZccAqEc3miOTMs0f/UYKumuSS/rrIwvoAnAiXJM/6UIZCEhO932INMfyWfjeH7y5Xj1P7SSfnLvAWI6ZPTXGZVxX6DlYb52C7w51Ss7hVJALkKGJZ7eblQm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8vzaoyzbhJH85EqfFvWfcUlVwkqc6rvcwabkMgjt9j8Hzd7X7F5zb47mVaod?=
 =?us-ascii?Q?jFajy7Bi6NZxJvf1mDps+0tBCgfjk85eNqdzl8xUDy9tVlpRRybVeXDaUY32?=
 =?us-ascii?Q?EHPJe2ZcerU3zW3tCLBh72pw1gP5Er/qsLJJTitFW1/mKxj2cWJP3OzbqP4D?=
 =?us-ascii?Q?fWTR67RnpaZzQzMVtMAQEmukyzjFQXgLa9cbEb/ACXIV3bMiEU8Yo+onNf73?=
 =?us-ascii?Q?j4oRbxXuNIfEKg1rc483W92q0j+3TJGGIQpJrpLpVOnlc5fGBm3F5jQcYN/i?=
 =?us-ascii?Q?0CCnLdX6ZCGzFW2zSccvJXFe/0FlTwnb1YsEFpLlzQKD4sh0g1de1n7mFFfi?=
 =?us-ascii?Q?iFfePEy6FzbZauzUNrqZV0WohSa0uUouO7cIDiGVHbs7Ur2JQnjP8CfcYwqb?=
 =?us-ascii?Q?Wklf0yxP+gc5g7HckwRDmJf6DgHlKIwSX9xLSeOZ6smGzG14sOdF0BaMWcwJ?=
 =?us-ascii?Q?PugmOGAnKnqRCpxlRqnWqa+nUOxYC3GjxWpkRxBjyyFhHLxVlpl9O7Hm4GGr?=
 =?us-ascii?Q?ZRNDEZ5ywMaeWJFEqwlMYH29j/dKUMfglBE7cgyQ8GDYfeFM30cvGOcYwAZJ?=
 =?us-ascii?Q?Y6AjiDjWOMNMB1g6NprH/8f48JEZJ6cG0HuK8hK4vs1jtkAvkYnh48mI64+b?=
 =?us-ascii?Q?o6spkn9A9D6Fhj6NBYYGfyxSE8yfPhG53JVAu6cm+5FSraYNsSLR1DosuiVw?=
 =?us-ascii?Q?8dhntUPc6Ku0Sd1yRLwjLdLKB3Gx1r2VoqGrr+9v0vvxvoCBESND4KkIvL33?=
 =?us-ascii?Q?YUiwNi80ofxUB4ebIQlfIgfLWPcRQyF2w8nC1JzSWgsAPrBGvNEEyNJjSaG/?=
 =?us-ascii?Q?R34GAaoISSjMqXp5mnD1V1Fljgm/zvGcgU26D6flPvQmA02qjJD46l4cxOkz?=
 =?us-ascii?Q?+Cxj4OGKFeFl9NgvRyfr7zPuTMu2q8pBVdFDQsC1Zly8JXhxDOCsKFBA99QJ?=
 =?us-ascii?Q?2j3cvnl/nkuZWG8tr/woYxveRd8+U4CwUMKhR4Akkl30bB+iRtkLnqYSA6B1?=
 =?us-ascii?Q?DZi/nukq4TsMKWd2eFnFEO+x56uZi8unIe9fbWpkGDMIGx1xQq7jtg8SVk/u?=
 =?us-ascii?Q?PRtH6qNIzwxBjI/D2yEShHNWFaArKzxCcUHcvznY9MncVyO2+VurlcsKKYPQ?=
 =?us-ascii?Q?IdCs35iSkUripV5kndujd4sYvj12HLcmiDXAgbEflMdOpvAFNGVhVCnjUkq6?=
 =?us-ascii?Q?JLeBHgK4A8SkNnUC7tKAhqoNi7wMRRnOkJkM5QdJrp92o4ogRCttu5qunyWM?=
 =?us-ascii?Q?N08XfERFHVDg3lyqNSHxUzJ4HBIFYRF6k2UdcGTtQGZD2Oy02jwis5L8H3+S?=
 =?us-ascii?Q?aBHaZyfPFJA82krC5XDQIq0JnqXhKeraJ6qTDzCyVNyQjejaFMHLK6G6wTdI?=
 =?us-ascii?Q?d4nv3K9oNfHR0iV9VDPOkw3O+1RNjuijIhzMUD9GlcbdxQtHBDqAqnD51J9j?=
 =?us-ascii?Q?Glk1ZIqebWmslwcqbpN7yqF+dWuaxc2a0K3/pcp/VJNYXqheMMc0ooXizhPH?=
 =?us-ascii?Q?fLhwx3SqUgeuixfUF+jAZqK5TZqpW0roqCZAYTeCwOa8hCMM7BL/76SoY/5X?=
 =?us-ascii?Q?LBugksrqzoA8ilyuqzsXHrTl55KzEuh7hm/9l2BzXQ0sT+TVyC/LBp6MuKI0?=
 =?us-ascii?Q?36WmJSfr9eZZquPqZ3RwOvMwg5yc13/84YitEwzNs4wG0ofyvU3vzH0lg8a5?=
 =?us-ascii?Q?BOH0yXmod0ZbOJfpcKtThv21ePpRb1gvnGC/vZr/sNOyx2yJLsX591JmbGwJ?=
 =?us-ascii?Q?r9b634YfGU0YwWFXWowypre1VyEzDJA=3D?=
X-Exchange-RoutingPolicyChecked: hPvDCL54oeBvacjo/UeaaiagFsPMrhW24ovmDkxf6OhVebPhB6uM+34ct1C+1GM1bOblZhTuJnzjEKsX6cjGEZ3OpWXQ/WHXDkUWpMVz+trcOa0cGZcCc/BoBqhdh5rLssAPaNT+q6S9RYlHshRvYpsGrXBmIbkhKfbRwN0EMjxAAyMZcAiwkFsD9FULYMmI2RbKGL0p/KMhu++ELPHnGN2N9USFq9Z9nE5Ee3ZhxePMkcEUOwzc/4WX4zTZYKJjicruCP+GxIgHNFaXDdUtl13bOFNeUn2Qe0l/AyVPYPvlFYDXe3THrSQupRALGlmMFEI7sngygPW4P/3D0Iuciw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d28fda-4302-4ec6-c61a-08dec7529283
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 00:44:19.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtcqvNlx1k1WprJQe3PqFGUPJbyyFhMhRTKjHukRJAObwY+MG3UhDQCcOoiST89dSaKFSrj01W75pVWJ9JHrLRBjaT6SPwrKVO7WLIRHQ9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com

On Sat, May 30, 2026 at 12:26:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Passthrough decoders (`iw == 1`) in deep topologies fail to configure because calculated `ig` exceeds software limits, breaking valid configurations.
> --

A fix for this pre-existing issue is posted for review:
https://lore.kernel.org/all/e8cd395fc7cee8d126449db9d7fd8b37ddd43459.1781136281.git.alison.schofield@intel.com/

And, oops, it looks like you've already found issue w that.
