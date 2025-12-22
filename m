Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A02745E;
	Mon, 22 Dec 2025 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766375547; cv=fail; b=KLxxpxj+sBT8Hls9aHQ3XEAqbyrdIHEFX1GHMfxL8752GtpQKfU0rPGziuhbjOXGeUZ/f6XeLm2xvFJaTjSbRVZ5w6TEzfKPkJO4uRcEOqatFd4kr2++CWZuNC1P4EcUWo7PrHI58xMoKh87Bi6dq8+ss8HI0cbyEOBYjRjrcvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766375547; c=relaxed/simple;
	bh=zEb7tfov2qh5fpqV6Zx60JgTUHGVPqxACvmgmQOL18E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s0mQK+oZzEnR6DcL8pwvlWBrUXRzSF4KjXld0aLNmQcMjaeYDdWOipa3BygvvA1Lm2p8Q7j7EODSFSQHmFmf5eHh0rT7Pb9Dn6O8FtVdhu6ExxU+OVCSd/8FxWXd3Y+/MEp5ZbOw7/tI3MwcTLONiFZifJ5tHV3Yz3uu9t5Ol14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOoARsJ4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOoARsJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766375545; x=1797911545;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zEb7tfov2qh5fpqV6Zx60JgTUHGVPqxACvmgmQOL18E=;
  b=aOoARsJ4BZ1rKTK0E/wD9fhn1R9BRJx/QD6JW1DIxeEDvPgexkHkDKYP
   cE+p39CAYvsnnSwfcNvo9+wtZRgVai+j+Ab3iNr9TCg+eLyKucaW+5p1Y
   QDCz3DDyaeVO9WGxTnmLH2I90Y9Z85xXzD57lsFGKPglBpErN+PzvFCK3
   y9JYZ1/ALXrbJ5A3HE2qQLTG47wpcqVySyX07FlS1Y8rJFsFoXFt64cjg
   l6BPsjz9ixTDFm6MuIy71I3vfsoQSjWpU655/VgEkGyHo/wRbwwXpYdjh
   qGoTTXSiKxzLnCxRs70dPT1ltou2lyNXvvRvjhHWqyE57x8eltFAgFuuG
   g==;
X-CSE-ConnectionGUID: YPk9tTPET4iE6vRB4kDXbQ==
X-CSE-MsgGUID: QXT9FVctT5uQQQXdtEyOLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68211956"
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="68211956"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 19:52:25 -0800
X-CSE-ConnectionGUID: inuhX8mqSJqnAEyLxrsAGA==
X-CSE-MsgGUID: z+JKzgJbRyuwWO5enWcA/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="199724345"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 19:52:24 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 21 Dec 2025 19:52:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 21 Dec 2025 19:52:23 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 21 Dec 2025 19:52:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PREJ6WV0KVjCfnwT1ViYXzjiOvbIPqzAS1ptpw7wpIKpsFLyDchDSR5tp7TiK2fMzMLnR1m48s1bc455BlZ1mDTNBcLxGJG/BNzMicgFlxbyk49H1uk2HPEchM3mj/s5PffnUiJ6oGT0ga76abEgqAqpDthQc9bI960wcdN0z8EFsBp5Dm2uK3oJujao7yPv9ftwIll6OH35gkYkj1Eohf9hLQAMo0GmFR7K0Ejdm+DjEkdxH5PbtHZsNAzw9wuTAnuSgBKtVODLtQZCdaU5LWtcM7b1MooYvYxveL7Vr+Vm5+6DARaRgixVRTXcYoqBFDhmFX9Pl8YDhunYPJvxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af3loRlMFPTtWptCSgi2UeWykYlqpnYJP2F+qoEolUU=;
 b=cKX6pW4oqOnOcYVxE68FoykDG41HPQA49tHaoxqyBIUhxnDmiT+iBd9uiVCff5yh89mSxdlwdH7C48bhkd27x4cRbIWU8I8gyLC1hbvmehm9OsYXE9qpE8kW6Aj0abvHrtEdVTIyw/NEA20h9g+/YoPvDTsgLwZf/cvA3Ojt7jHS7Ey0eHkD8yAC/FsouD8orRDtmATsYm9Fro61KEI5ZC57+yCmM1RSUgC78nlWyuRF43WjNIrpNnTzXR9pMfwL1Nq3gx9rtmcBS62vyieALHdV5NXdOQcBxGPehD1z6B1ZgvRFDS7sYNiz6fMCsADa1sID8BsJEaj1ew0Jjx2ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 03:52:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 03:52:20 +0000
Date: Sun, 21 Dec 2025 19:52:17 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Slightly simplify emit_target_list()
Message-ID: <aUjAcQZ5JCxnk7Qp@aschofie-mobl2.lan>
References: <589ee57cfc275c5249885e1eace22e9bf3a9561d.1766326481.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <589ee57cfc275c5249885e1eace22e9bf3a9561d.1766326481.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BY5PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::42) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f639117-18b9-4c1a-8364-08de410d81f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q6b7fWw0Oh9aAirBSEPstvBonov/ZS9mDhxPaOU7CoidfoLz4Ot0iqRW7mH+?=
 =?us-ascii?Q?jC3NsBZMfQQ5gCrTOyLLCNQiWh7MnsB/joczTfXQSWuLDr9QMOJS3jcnHvJl?=
 =?us-ascii?Q?0ANDfT9C9QKlV/oA1ZAzjG2eKZXzebAqpmqz9Gzo3jX45rm6OMr2t3F+JETR?=
 =?us-ascii?Q?1kprHycv13hoEK+eIuciqX24nk4fE5ZbP/OPTev+e3sWL0l4+l2AFtC1W9kh?=
 =?us-ascii?Q?0yal488Ga3A0ZGc/yfLkKjT887Ir+mz3dJH1sq03lVKjEDHgIAWnpheTgOzF?=
 =?us-ascii?Q?xgjqsJ62+F89Ka8OO9pEIuteLb7EQ+HDWuD8SDp2Ozz6ayx2aZl0wnSn3M1e?=
 =?us-ascii?Q?HMBGEHO3QTMXtIkLuH/YYYz1BvTv47I85GIuBAoZeTqHfonXnLdthFI1YDS7?=
 =?us-ascii?Q?fjLLsqySoydoOL9F6I+IWr4nc1B7wdK/ALOweGXqaW+4SkyjjVm1TgfSDkm8?=
 =?us-ascii?Q?2tRVGvlFJBZm6JNGTReqYb27d9rcV2q9A0yK6ngXhq+TxgPTgdbFTEO9fgmz?=
 =?us-ascii?Q?SjvEb/XEWo2wBdxtd3Blqu5fMXLggjKWV4Sm0jK4f3XM04ZatXfIXr4I7J1A?=
 =?us-ascii?Q?8K050OqwMBOV4KBSV9CgpRQsAXusKfBq9GJnODVCkutCZYxhc5zjqpWBFFtW?=
 =?us-ascii?Q?19eMPqUwzPCSjFVfPZfdO68QNbCL+lbdnYeg66wEn/iPyIlFHXWhr+3kd57W?=
 =?us-ascii?Q?m6RlJuo48APPioYEhVfMmr0bl83BvFIkHL8qqwkNeDXz3SBfMca6/V32yakn?=
 =?us-ascii?Q?LthFMEWOn4Vmf1PkkSidlSzBIUD7QfsfpD6M8+pwahk1tRmitbfIPQ6y0Xp6?=
 =?us-ascii?Q?yA5UF4gVb0MsmQ2FYJ0yvHSObOwMl0h7y34FtQnwiT0JxIkpz0CCe8aFvA44?=
 =?us-ascii?Q?qRXfNFjX+niMx5QHtzYdHbvsGlO8Fst+6wXaN+S58SHU1QBiTZS51yo2pjeu?=
 =?us-ascii?Q?swf/7nruA43QERcBwfDGozmoALxcifGsnlhR2EeFmug2dx7NgYBi87qk1HA0?=
 =?us-ascii?Q?rcrDdnUFUQTNGpwbRPwebvgFefRNrPPXP+cg/YjqihrYZAcOJdVVTEEcP0XI?=
 =?us-ascii?Q?SzfqtlKABGnqazEUzqXgof9g64mil5I00XOVbFP7w9Q60K4BhsmUrXeCOs8J?=
 =?us-ascii?Q?0ugBjqKhNKMuN7/27eHVWRjd539NlSQJvRepcXZd2/z5O8VoI8cY7rXGxCk4?=
 =?us-ascii?Q?TQBLJWHr4k5/KJGPEwMiiuhGXCMmysClZ9ss+MI6wZw450GOAjgM7MAOCW1k?=
 =?us-ascii?Q?naUFT4+VOLBZ2B0vjIeCBbpCabbVJR4v9ld6tv/6PvqsRtaidPuOgQ2xSEGO?=
 =?us-ascii?Q?0oCQ21g9osqcdwtA+q4TjqNVMhLWgC0hhYtpKqPQekYP5d0mKG+hUK4Bdz5S?=
 =?us-ascii?Q?7a2w3MdVPg1CBaOgpKKxK+1b5kQSMzBufc65OIdUgGSMNMmrc+mIlicihbNf?=
 =?us-ascii?Q?0NoqoiRKyc6yIQ0Ef8VAygFaRJ4hTcd2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?24Z0KaVhjnChJ70k/gjADvSAFM0LWEjVOI4KxTE6WRoDDziF4b2GhR1fib9U?=
 =?us-ascii?Q?VdzP6IkWa1gwvMjKSychL0HcBnBLmviwLshYFmPSUeR+ZNtcSAxItJhwr53e?=
 =?us-ascii?Q?xDNkZoBCXz/S2uZCzwMt9O9jkTFieHlO4JJPs2PDD8a0dbRAjV4Ney9xqi67?=
 =?us-ascii?Q?OoyguLLEGOkyJw0JEXeIBHVrjVp8iiIUcG5SKox/GBMcq9HCVSgQogh2JYB8?=
 =?us-ascii?Q?KjvlsMY+XGQ8dlpQNLVJdntwuMTifTU9v+uVU+62W0GNSbXe16/BS3lZverI?=
 =?us-ascii?Q?XHgIShi1+ISL4aXVlqd6GHtlaJlkj/bsC5pCNYdFlCvOLcBs/KaIRy7ddOxx?=
 =?us-ascii?Q?egPVL3CFtAoK+cq/S6Gz3IWgJJAkLdkvoAORL90HpffU0EFM0ebPJek0Vxjq?=
 =?us-ascii?Q?L8WcyqTHHD7iLBZaqWwkR8UC29px0TofjZBKaaHCMvIbL8tWCu5s2Ykyo6Jr?=
 =?us-ascii?Q?Xn0ILMNVvr698w1DUQo5FlcqFISuJmHFPYmVOkC0TrKj/+yFZ5DnCLecIPVT?=
 =?us-ascii?Q?KfZ5pf6bqPxCxqE0gG4ektiu+f85/ZSiaT4RYSPxsxnHWVPR67zLscpkq4MK?=
 =?us-ascii?Q?mai2K72xqmsKVEoiK8DWVfdrVtf5PFPCgKwdzkwF66MsYHVjdGhzcr1noRzI?=
 =?us-ascii?Q?mx5WXxPHYZYMeArzF2mUxxCQvYpei5snLWX4Uoqomdbzhums7zLp54vWOolR?=
 =?us-ascii?Q?YrpTKCnAbkx56F/H9z1Su4FxkZvDoGfiLYt7xRVX5VOqbNAkrfF55lpuHRdG?=
 =?us-ascii?Q?Lgk6AMMey/HzUjsNtZ8378oGb/Hn+Qutym+Rh+sW750CrtLFf0TlHzS/lcRn?=
 =?us-ascii?Q?PatPoKj7eC37833U2kjtOybYz8E8q545LV7uRGVfa2Srw/vMTxJWJ3SJzL5C?=
 =?us-ascii?Q?gis8aoICyd4SNK49dzn6Ga2QevfYeyCwZe4gUpyu8zXnqIWkPMmDKrY6Zz1e?=
 =?us-ascii?Q?IJ0AUwwPVSlhaF2oy+mSO2j0BoenbdIDOEpN1nsZ5af65z9/QVIrLJcv23so?=
 =?us-ascii?Q?kV7GjAtobIxkNpTUyLh/4nhnaZuWSEFpeKHWBe2qY2GHQdhlMS4hkhYmQqSG?=
 =?us-ascii?Q?fAx90bmeEx/HJEqGyDmlgOI6P4FSjjDPu0blB/1I5inYLRXrO7y0ernMc4Op?=
 =?us-ascii?Q?WgGOi5Af6d5mLqysZ71LRWqbr9mn6Mei/EJjeegFnazOCDvGnoJo8zjiLUBE?=
 =?us-ascii?Q?iFfGppGf4fy2+/HVpWNtjSYGMEQRLUjqa755Ho0/RI3+8dYc2RHVUz+0CBf0?=
 =?us-ascii?Q?w5YFlgrYsiVBVGNjkBwHS1jKquNQuNmOUzJ2IzJ5X3wAsTGO7hW1XTRbO6KO?=
 =?us-ascii?Q?SfjgboQ8/JKOg1FFfP/SMzZbTe4lz/ThMKNxIW4pntRhpLg21RHVzLZ5kfob?=
 =?us-ascii?Q?eCZ/ENQ3ri4ZbxVRQHCxOKjeWfP3XA5yNPsroRdPJyoy+hWsylUk1lvZ82s0?=
 =?us-ascii?Q?RgtX/kj6tzlfgGhQjv7Z2UkZi11UZaxJf3s9KbPFZTr5egLMiQXAm0EEZRkm?=
 =?us-ascii?Q?m82mxRPi6+36FvE1WInwEKCHiAVldHIFbEGbe2EdjGB+cecE7ULpdp+N2UCF?=
 =?us-ascii?Q?s+oH7mwUhgScuiKS72UoEeXAKLZTsZnBQ8MwRsQu9O2bUj6tt3K3UvPuEb0O?=
 =?us-ascii?Q?lptqSr8Iumw2pBV/RnJ44tF5AJ6XMhzaTcgLNCL+sJr9/GU1NVROkPKhxTAU?=
 =?us-ascii?Q?hGkkh4CwD0qIftf0w7STnHDq605lbasgP7SH1XZ3VxKgZotZUZ7YO5i6ZD68?=
 =?us-ascii?Q?VE8+knJ6WKckuMQG/BkRlwCFei3SMeY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f639117-18b9-4c1a-8364-08de410d81f6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 03:52:20.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8R6iLlXHFsKtqNXsweQHs6rei/ADcO4SIhrcngVRlA7WcooUy6i5da0VQI6FrxKsrVD92OwQ4FRUCAkqGxOE0YqfurWAsN1Zsoen7v1tUMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

On Sun, Dec 21, 2025 at 03:15:04PM +0100, Christophe JAILLET wrote:
> sysfs_emit_at() never returns a negative error code. It returns 0 or the
> number of characters written in the buffer.
> 
> Remove the useless test. This simplifies the logic and saves a few lines of
> code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/cxl/core/port.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..b77c1600beaa 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -151,7 +151,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>  {
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
>  	ssize_t offset = 0;
> -	int i, rc = 0;
> +	int i;
>  
>  	for (i = 0; i < cxld->interleave_ways; i++) {
>  		struct cxl_dport *dport = cxlsd->target[i];
> @@ -162,11 +162,9 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>  
>  		if (i + 1 < cxld->interleave_ways)
>  			next = cxlsd->target[i + 1];
> -		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
> -				   next ? "," : "");
> -		if (rc < 0)
> -			return rc;
> -		offset += rc;
> +		offset += sysfs_emit_at(buf, offset, "%d%s",
> +					dport->port_id,
> +					next ? "," : "");
>  	}
>  
>  	return offset;

Can this can be cleaned up further at the target_list_show() call
site which also checks for an impossible rc < 0 (twice).



> -- 
> 2.52.0
> 
