Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFB238C19
	for <linux-cxl@vger.kernel.org>; Thu, 16 Oct 2025 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593222; cv=fail; b=mlGEQYySjrk1vTWfRY+XlB4YFM8RtZWj6/isFdQbhlkRWjkUVywKccTXLGnC/6iOtbxfxGiPs25a1aSGbktC8R1/0F6kHCsW53UIOD1dXt9U1xXHe/3UwkMCqQwQXmKUy3+7UDBc55ZdNyQkYaZYBwWSL6+6pj7LlLZLAq3Qb+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593222; c=relaxed/simple;
	bh=nYjwe31Mh7ZuC6d8UCkZtkNhRBcc2kD7ZlN3OeqKQAs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r9thJpGb6Xdja6Vk6sEpOQMLYIDEA/3jTnMh2hrpKuPQTCHoqxahNIjsSPTCqBXjIhnWRhRRfMSPN8lTqDehwIe14z/Fzjrab6z94a5qxSOK74sLZvkT057LAzjUU+ArQ1/q8pZPpCAmkSUdCIoOYSW4Rmu3E1KGcXVmu0Q60MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPO2vsBA; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPO2vsBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760593221; x=1792129221;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nYjwe31Mh7ZuC6d8UCkZtkNhRBcc2kD7ZlN3OeqKQAs=;
  b=LPO2vsBA7OXIVWKYv65DNByN6oEDBes1R1ZI80C4zQpLD12o7hGmbjJi
   MGq4xxJ6fCV6aWHo/UJgt9U4mCPkRYsKfLzFjcxWL8UhxecwL41Rv9/ik
   06BI+TNV7uT+vJpzBo3EPYup2JodtZhOuw3+WXETYu3q4Aj7KrGXgBCUv
   gGHUSs5mQDy+U3LO+xd2fM8gml6etLyjqH3PuWqCI/Whsaqmg5rgjoYC2
   lLnBuf149Q6PT25HpjkTYamvzkpEi2KxYYhxcL5+sX4AOx/AoQmlcn/vJ
   QObVLmfzeQ03EBoIn4E42rMg6jUMa1SJrc+GXsg7yKDWXmeBkQRJwbeyr
   A==;
X-CSE-ConnectionGUID: dHVMU5yPRxeeivIhI5E3XQ==
X-CSE-MsgGUID: SqDUqKT0S+C9a49qR5mK9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73888280"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="73888280"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 22:40:20 -0700
X-CSE-ConnectionGUID: Z4blPVPuSoS1dcjDsP1m8A==
X-CSE-MsgGUID: 1l508bQjROq1LHRN3KwiaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="182301407"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 22:40:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:40:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 22:40:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:40:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z54RTgU69CMGDDD61mlKksyKoQDlDux3Zt2pbCA/5yYygAQv3xBRIyF8dJ+XZ0AUNb68zhpBLy3bwr+AyDzBKeoBZMdPnMuomaIBguMWVVQWot7v6QqRl+isAGaupY79iygGP+eJEYcNsv1NXGAINu1K0To9MraKt6PcLQ3Q9RKiwGt4YqCJ30deVZuvn77RcW3PFxkV8kiUscYcPG18yWYldcANHmejSWbl3JgXR+ER1XLm/qOtHYECrsn+v3NPnoHSsSJkl8BTsDw4kgurQvykp50e9vgSatlJ2fAjgRxhtkeyOSEw+W+6B+PpFoqMmm9tWn1uNkSXHF3AfYkn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVnBuj4oRgUgmQ55lKK5R+6dMXJ73iSSkWgFFgRBb8o=;
 b=rRXuxb4eC1UAqSPZ+BGi9aqYdt8soipV5uTVAb4bVl/PS+Dw2YmGSXqaJH9Z3F3e7tbwoZUIWF5jV/QGMYjjlRNbPMt2eQUBDXEvto6sSi8sNX7Io3cHEWylbdnUflhJJjk8xwwpJf9H0n/zuCe64TRACKVO9Ga8cSRV85yxBbN7S2/E/05LMvXN/HbGxQ4x28W0hgwrYWiSd0pHq0wdas0QfSku+cVakROiMsXc2vMPLDS9MvyQWmyOaVBSwL/LwjNNQ8tVMpl0S7hX41mJF9ga3bVM9pHLZhfOS3D/CJa/Jobp8EH6bwzgDrLoOMnHRJ+Bl1cSrYhS/3dqcC9Bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH3PR11MB8751.namprd11.prod.outlook.com (2603:10b6:610:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 05:40:04 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 05:40:04 +0000
Date: Wed, 15 Oct 2025 22:40:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/region: Add support to indicate region has extended
 linear cache
Message-ID: <aPCFMLDuBNGp7svw@aschofie-mobl2.lan>
References: <20251014182754.1686482-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014182754.1686482-1-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH3PR11MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: e3dd9df1-5c86-4193-7e57-08de0c767483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?71z98g2SifvLw5aINrmqCdbKzk2MU3Pqfl6Ha+Z8ZsQfii7rKRriOME07j0j?=
 =?us-ascii?Q?3r4BsLCRWsF98EjLFNzRBGGHI7bFH7bTc8svPFqw24W+0LnK2KzbN4YHvgFP?=
 =?us-ascii?Q?wAsGsedfcbc6Xb+NrCqBbeFLh/dMHS1Xwa4ZuqKPo0NdEzJ6HXj8Ow3WBQIt?=
 =?us-ascii?Q?J8MFN6gjO9+wWo1lniva0JDdyxG276WMcplSkfDADEmsEYLVGIZN7HLQJ28C?=
 =?us-ascii?Q?jQlL+t7ba7jyMQUp0Moq43enZX3vYJGoY+MJDAbz2G3s3VzEWvKIl1DBe0LO?=
 =?us-ascii?Q?kFz4+12nMYvGjM38jL5J/Api9HyQLr0ZY1pP3wgBAbVBJXcdx8yUzF389wJP?=
 =?us-ascii?Q?hyYC0SKRIsQhiq1LjLRjJSOujMlVGww88o038lO/Hi/H5XmLsPGHP/ssVkcK?=
 =?us-ascii?Q?9qS4ItDHPZHPw+BwAlV49/A8AA8kMk57H7/axBojW4HgOBsl76YYAB7sANSU?=
 =?us-ascii?Q?76n/vBaybiPq3ku/7+sTxnwtb1QlEzFZH/F4yUIS9wl4FuH4sXLzto849Ewg?=
 =?us-ascii?Q?jGdqEY1hHAemaeeu4dFMB6ECyc+fdSCV76+IMrZ+mgwQbImo5iF1eWOnZHIq?=
 =?us-ascii?Q?pExgyxCiuVK5AJM+aRe56s7Ucei9aTSeoVzGBX99BC5tsHxjFivGGPzdTKJq?=
 =?us-ascii?Q?/8PO66AXx71SUAOSPiP+glHxJ5Z3nLP4Y+vXEzaoPg7qYn3EsDpvVi+1lYCM?=
 =?us-ascii?Q?3fEZRIf1sjAyVmDnecJxkYRUA5fQ9xXSaMlEauRscjcCZq1setjU5wnl+7Tl?=
 =?us-ascii?Q?GwTCc1CErFaYsMKBaj++uqCqMmfyOdqJFUiPS4QJRypHS9NLqYH0RI5mPb9E?=
 =?us-ascii?Q?qOUT40+Yyf6hs/RGSf3j8gMedE0kFz6cA32H8+dKT8PXv2d55jWMJSQZo+Wl?=
 =?us-ascii?Q?hca40vko1yTeUOV/GgA7ZVhfp995XscfMQKT3UVpSyAWa1iPrF9170tJuls3?=
 =?us-ascii?Q?W0syurg4Cif4EH0sKuHvNAQLH/Z5XNiLWUOeH23m9BHeamJUtG6EoBwJUoQB?=
 =?us-ascii?Q?h+1Rar+Jsg846eDEUV5k/JgmYYhC3mj8/Slqn7hEJxF7mhjKkrXX2r020RfM?=
 =?us-ascii?Q?5olxd0WRaQm12E9/W+nhDuqWpzH+PWgjiQpbQ1Hb845xuBUH5v3te17dfaB9?=
 =?us-ascii?Q?ljPSbOh0lwrbTrZVrrCulVKHjDU5QWXhr3HGNhWUWYZzTYH9veGK/IcWsMZ6?=
 =?us-ascii?Q?N45WdT6d2550nbXZZ0x0FLmoj/Kgh26nJJBWhVl1Pmn4a9VDEpEtuJUyaAK4?=
 =?us-ascii?Q?faEU7cFeJes3xSvfJywnFFQOHhscuWZYRMY2cuN6P+oSMn1e013r9CUAezAs?=
 =?us-ascii?Q?q4NITHGDpysDRRle+CT0Q2fomd0/1Z4gTcs/8F7zCdiLZimhiOqIwlKO3mmw?=
 =?us-ascii?Q?wCT8I7ijCWuS80E77BK72FAlqeSHwtM4oRCZSGa7iQ8DYHdfysj5ScvKdO3O?=
 =?us-ascii?Q?fL820WxvTRAeRTNC6LOI1W8YuYspIB1g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?haZieQ86nLP8rVRvH15+PCU7H6qPkwKI6Ff2EqgVurRC+Oe6nwQ3UsCk875D?=
 =?us-ascii?Q?T9Ec+SQAeGKSacc5X59NqamIPwn7sdn3mUtCyHKK9leHl7JukR1JwP2HLxD/?=
 =?us-ascii?Q?W2hv4S4x7y57+fSzknz1gIL8kq8pNSH60vYejRMKP1WSfwTYfmKWyRKyzCcb?=
 =?us-ascii?Q?GlDwIGMc3WcjN3SP420cuHzTWqTwPYozQj4MKyK5NT3+mhge49J/BM19xb0L?=
 =?us-ascii?Q?z/iA1U7l2wW0z/rNaYfsm0dCGnq30iXdu+ImThzrcAk5ITJD97tb5fZ8drbM?=
 =?us-ascii?Q?oBlw7oREBpZ3iHj7Ehh8/GQDSu8nw6JFzKkZ+TDTOhouXrE6nIQgLPGJ+xt/?=
 =?us-ascii?Q?N8obxNh3g3Q0b+0DdgTcXkDD87NuhWpCTfZJdy6sl5KqowjUvGerUZboeS6N?=
 =?us-ascii?Q?0rlHqovGidpMyMaYCQOp9J4qqTn/zs88CgAMg2nED1E7CrOLmUCRMWDRnuEA?=
 =?us-ascii?Q?cOoOHChL3Lw0blLemsvhmhQ0mStVNLaBYZVDgQl/XWjJMiljLdkkLD4B1fIb?=
 =?us-ascii?Q?QMhV01w9avzQG+QlnL9acuLGePivug8avWxySH9hkyEklQzluHJGXIqEY0VG?=
 =?us-ascii?Q?XHQRPctK5TWu92NETrc1zX5uAblIMVs0U6N9RgVNYMy6CzjD3i0xmn9Gg71k?=
 =?us-ascii?Q?532eCHC1pa6vg67oSMc7PnVRaL56qQ/K/g5Gk6ezP5EzTZ8FjJT/bowpaxNR?=
 =?us-ascii?Q?e52HlkJShHpZNA4zFrPPNyo1qa3t53o8uT+YGTeL3ioTtYbViXkqrvlFrOI/?=
 =?us-ascii?Q?PKtnKFAYCmM3hFugxnu6ecFSYVU8az1mMx38Sy2wqhQwe2O4EWalJY2WY1i/?=
 =?us-ascii?Q?vP9misSH9As76GCElJnasqeHviN8iW7XaK0r2vUElqfwEKktWjFn0uXTLpcy?=
 =?us-ascii?Q?eXzRocm6vSicfhQapTIHhTlmqTwQa0Vlft0gSbD4gYijjMBS8gRCz7tR86iZ?=
 =?us-ascii?Q?Uj+gAdRrfGPFnmhtEXuMWt9EBCkM9RGmrQSg8PBzmW2RfscL9x+dogPBE20M?=
 =?us-ascii?Q?o0O9zyNg2Vi1kwpOWXFBO1Lx287/qL1zS0bb54goM2VV4cGQNPVKFMXaLHPS?=
 =?us-ascii?Q?9bUPEYWfawRWDyTTQCqhVMpJqnQ8LwcielpbDIWI03Gjn0BbwuHwdAljEjRc?=
 =?us-ascii?Q?T0pVeKz7a+uZd/uqitYrzC7pGor00rgLe0LvLG3zH5kqTHXtvKndyRSg+Xtg?=
 =?us-ascii?Q?UL953Lp0jLGyIgXYJiWmedUhr+Ue/aNZ7TzqVOrXxI9WpAiA4ZsE8zVG7bCy?=
 =?us-ascii?Q?RLxdNlxzXfnyffUrB3RfoMDz8a2odNqHXQuXeCB4TheGbJ1wDaO4Pog0QpKx?=
 =?us-ascii?Q?LDAAUF6p2PYJCcCUNS4WsP/OH/pZA+7t7cEhRkJAjd0yZbo9iZgZZuSq/A+1?=
 =?us-ascii?Q?PtpuA8qeaReeZdQaLZEaY2AQ2pp2lM1ttcI9WofFV8klvxddmNA2x6Wd9pVT?=
 =?us-ascii?Q?U12pdK785JmMsvAeahANbdWxHrGZ5ny515qIBxlawhHsoEWcEKjBnQblnDRz?=
 =?us-ascii?Q?g3C9oIvNHiNJhFntDY+m7XXgKKSnbzvaGB9CYTuy1i+Eg3QShEvkIX35TqzY?=
 =?us-ascii?Q?xIlntEh+IJ1JL+WXK3YXujzsgXhNKCAiOMJseAQV3hZd/p3raCSQcz5wWgvJ?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dd9df1-5c86-4193-7e57-08de0c767483
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:40:03.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Woid1L3NVKv2+VKLkH7QYeetFUzv0E4jrUfI/5NZfmYb7esP9rN9rvpfQhfXxc6zS8RG14fZ0JXZdsCimU3pEUW0Dvgrkuz6pUeOvM205uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8751
X-OriginatorOrg: intel.com

On Tue, Oct 14, 2025 at 11:27:54AM -0700, Dave Jiang wrote:
> Add a region sysfs attribute to show the size of the extended linear
> cache if there is any. The attribute is invisible when the cache
> size is 0, which indicates it does not exist.
> 
> Moved the cxl_region_visible() location in order to pick up the
> new sysfs attribute definition.

Looks good and I saw it in action on a system w ELC.

Needs a description added to Documentation/ABI/testing/sysfs-bus-cxl

snip
> +	 * Don't dispaly extended linear cache attribute if there is no
                 ^display
