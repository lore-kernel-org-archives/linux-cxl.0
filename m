Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078183B2AA
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146998; cv=fail; b=QWpbTDg+9d3JbdcLsMkpRR7VfIYe/QN2JIXpdeDu0y9cSu0F9t2Aar8W3jWvi9/SWRR0ZTZcxAwj0NevBrOHg8buJ3N0bOV6lZ1fYyGRmkOYlcSIQeiIfeRUHnzZrnrQ+F1QUBlS7N1E//R14Bjr98YI/a+YCXVijFMxyhiJWKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146998; c=relaxed/simple;
	bh=4O3TkigTtkvMAtUltiL7z57xFb0KMepkeex5M6/QO7g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZiHpB5ixK2799GlUNZ9UnENhm8AevPxlmMs0fdxW9cAPJgR5bvcaapwaRybsjZ0g5F1apXp5qY33NYtVQjF3MAYNOuQVTng179NqUbkw2pG5CJBxqLdL1twfGnA+ZRINSilqhQB1McKO5CYu1HbxWdsYLfZXGb5qj9MgmEWBOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TilztVmx; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TilztVmx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786146997; x=1817682997;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4O3TkigTtkvMAtUltiL7z57xFb0KMepkeex5M6/QO7g=;
  b=TilztVmxBYddqNyCMFCzq4enVnpmGsLg0XXnURvM6TkIIPDJ+3dc/YTO
   9zY74u+BaiSVsJK7c+9GM90+Sk0Jc6kTWqDxHKVSRzL9zUE3a8/ITnuVI
   y1SljdF2ndXHGK2BMlOexevDiKdjHK256w96qKR5z+WX8jvx0uoIWhL2c
   JwEOf0eFDKyxn+t1Pvxz3MmzDDzanjD6Efk2f01DqleFscJPIBP/WBawu
   9j9PKNiGdcrILis3/DcNEFNVpGrBqaQNcIur29w93tGt6jRb8HNgXDVxB
   VzOZnQqjmw3o9DUgfUfS2mXXHPWCdJDBP26R3WfpijYgbwiSI9Ghute0R
   w==;
X-CSE-ConnectionGUID: pyfKRVhDQy+zUezsE7dOYA==
X-CSE-MsgGUID: w5RV2U46SVGsburTZrK24A==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90642264"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="90642264"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:56:37 -0700
X-CSE-ConnectionGUID: Tr5aQ6sEQQW1DYBfVVhq+Q==
X-CSE-MsgGUID: GlDERY6BRimKvP5Cuz76Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="292426901"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:56:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:56:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:56:35 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJCIInpecjo152Qi3cmlHY49Fizu39k13y33RJdDRUQjcVxeT3o8Tcqn0TgfuScmTV9VD7xdkWyaHwlvs2kwCR6hdAf6S1ma1l/++g4ckGwhTQU1eHrVceD948Qk8y9v4EMD1Ay4zhcpTOUyCKvPCx/lV70ROdU6uPOB+NdvL9anZ6BbO4k/KoVvovKhqGUf+L4nhN29TRsHNjRzWvOMKCQGPEPTVf9nrgFCHrDX0b1DjsyH6MdT1nrKWAdgwAw6UvOj4fdHWCmqiRQ287hbSssexLX7U3yK+lVax4gWijYtAl53fUjCmeTpC4kfnE5c53aR9sOIY53zDs/IEUHDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlHmQIxapI9aq/552AOsYxgktdXSsVBKzNlKW9KUxUA=;
 b=hNKvL7V031tOVmmu1KqvvPTB0hCN9erNG+W2vB19s8r8PggjCbwBD0LrEBa8J2vwdUw+V1VSUiv1FE3MK9JproTnsmgPXxawTLWI7ljb8fPE/s547/nhpn6JOeiXyY51Hp210rN31sZ6mOHpHWFx6/+vleCStivBqk4nwTE91sErUGBOSmd3ShFIpH8Q6tK/Cx2fWtzq5qqKDOMTTxSV1yd3rJypkKZbG6CIMjPRWoJ7VWiT9/QpMswVutAlCvD5ia0K4J+56pRnKTJEhhnS8X4JUCVDzzKiSa2d/T376nVSFePiZ8Ut7e++Qrx1VrCtf+zKUqJAgwQdRXgNlBr4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DSSPR11MB9617.namprd11.prod.outlook.com (2603:10b6:8:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 23:56:32 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 23:56:32 +0000
Date: Fri, 7 Aug 2026 16:56:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>
Subject: Re: [PATCH v4 3/4] cxl/hdm: Make switch decoder target parsing
 endian-safe
Message-ID: <anZwrPrrnnomgKB0@aschofie-mobl2.lan>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <f98abc5edccc4fed9250d29df76ac677e3e51702.1784595445.git.alison.schofield@intel.com>
 <20260722020749.1826e787@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722020749.1826e787@jic23-huawei>
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DSSPR11MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: a522a556-c8e4-45a8-f875-08def4df8157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Us5uCXykSHEdH/WQKjeGqmLL7lpXL3DKrXt212Qztg3djkgXyYY6+fZz/PD9UBMN3TSToG6KZsZj1ht82019zJqLp4L2PqL+Wm5ygWB0ucvgvuY4zxPre9K+QJi1km8gsaokB7DUEk+Hpq5V6rUgQD711sD9m8mtmaZUKg7Rifesrdn4nBN2lhHkb0wgNWGDLzptgMe6XLCzrD+UJF13yC8j5howqACVA2bPCx2/NR/rUu4zZR2eDraPGDDf9VZFP39LUJaWwHpRwhVoeBv9Y5dFRzyUA7/h4SYnLkHtY0YOnOKeh5SCsHSI4mhvwnlmI2ez7sPRfJnWL6WzgFDqOB0S+hHcfMb/HZUTM1tVJm8O+w9AmSXSEDSzacrQZ2V9nlmDZAOBIUZKJ2sNdhxT0eAsqQIAcF7MtW5O57G8nAvno5QhJebiz/F8swIs8QLjya2K8x+61pwsH+w8+cG5BvvUIIFzM0YNOXi25dDeFl73atBuyy52BC7BA2knMBrzXPcHcbwmdn4lIyYHADh8wiS69G4s4+IOOR9YTiJItsdZ1Jkwppk4YAqlKn6aPd1gzayvElEG7ueJWQadKBX0T2eCXO8rlOoAMNLGLi2pOe7Kj5PTDf8mvYWVIGYXLUdaSJtO7xup6UliPcbAxslIYw1uq/05gE7yS7G7FNYDs6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FlknFtF6vxOzsCVzKTtgxdGOIUmckUT5EyuTMb7Hm7URB+cX5bKfNTjX6qpQ?=
 =?us-ascii?Q?Ms3QW2NBVdu388oIYZ9KcgL86LXkWll/6FNnBRgk7eFGvlaRnVHvnhoVriPx?=
 =?us-ascii?Q?9fn397wM/Eb93uobZZbZ7s9BBPbxTxYf714Xh7LthcHGRWY35566kToqe/l9?=
 =?us-ascii?Q?iZXcmfROhPwfnEEZx2hKPN9Wetfj9Ye86U76Zigh6IHS6BbmmdeqNyzsJ5ID?=
 =?us-ascii?Q?6K/B+pVrfP17DHwRkyyvwpBiz3M4jU+jwGGW8Edivg7CM0u4HOc00HAPpe4/?=
 =?us-ascii?Q?Cd2fEtxqKXw/m0iZD5Bq42v7MtwV/qA1dEV14L9wIClWNnNc2GJoEMDo5vqM?=
 =?us-ascii?Q?I7Uiq1aHCATIokMnw8bPjGef5pDnPRWLAFMOsZmN+XaE4MkT8Z07hW9HXbqH?=
 =?us-ascii?Q?ymYaNVsBReOwuuyuvwjSEBJgMS2f889rzVI0d/5lDUxpPladdoVeSJN97vUj?=
 =?us-ascii?Q?VGiBU4IQ3/kr01ody5cHlIQNZPQ/+YBnO48msP96fTzxqbey6MIbpEt5tTk0?=
 =?us-ascii?Q?8yV+mvjU15A2VdeyWdRVVzgjh6RfLJuIby4Da7Hvft6P9SbFteDCLSKOcq9T?=
 =?us-ascii?Q?rIu5aLbvroMYkV1F2sNV3pZPlBKXYFBWTW3ZwR4UgJo7ZeffRkQtYZJsct00?=
 =?us-ascii?Q?ywJfWdndjeFr8nfqueQRoe/NMznXNvvmzmR1Y+re4cm3yMfeA2DrYHyWejA2?=
 =?us-ascii?Q?/y7NS6EgO2CmrLjFf48Z09cUiWxRz6BUHbvyJjUFT58GlRN3IPOUfUykif3L?=
 =?us-ascii?Q?uhLxVSGKcc4FvUlIFyidAP8OcOG5JDR2g4bqQ2k2g+zDVzpnxeQmLT6/L14s?=
 =?us-ascii?Q?7GfE1YLICkyK50H7ntCSjwL9EXPu5/Okua54fCj0lL3ffvZOSmkXzwfuDOCO?=
 =?us-ascii?Q?Mil49xvCdG/hTcFu0nFi8Zlt57e7x+xBpmaE30iDbse7KVlxzRiUFxkykpMa?=
 =?us-ascii?Q?pgq68m/ulp/tvcnxE6uAgET2QCRjxROU8+E/HMkDWvXmSDLDZZ9DIZEz4S+x?=
 =?us-ascii?Q?4Ph8nybZ8C9iua6O0S3r9Wy6e39jCMGbH6bqx5/c1YUt864s8EXNTxHxovEr?=
 =?us-ascii?Q?eHAlstuCEvP2Nnf3bbq5fnYpVBHvDIcR4DjMUFF3OsWGYX0IywfjC4F0wgdr?=
 =?us-ascii?Q?VpJROgb/uxsaM52mFw/R880sI3+vDaseWdQ9o5MHa3BffoKNkBFoc2IjO+T/?=
 =?us-ascii?Q?CVHNuDCDM47jxwnd/oGpUEGdlSdUIXjkqdkbigHCw2F6xY9PEvHBWI68NsxH?=
 =?us-ascii?Q?RU646BXzJ314hEyGp9c+skSfVxjpZfJtx19eyU2PoSynSPcn/IPzzZK+1XIk?=
 =?us-ascii?Q?eJ30rA/zzq+dVgOwv4w9topOZFonoa450x8MyBsedenLf1fOuXOd02N6yPDF?=
 =?us-ascii?Q?ENqDMzfVe0qY3rJCGtRLAvpUMHqf6LHNEmbhvq/iHVGS8lf1Du1WKkJEtt5y?=
 =?us-ascii?Q?oEUPmKsB2QFC+HYjjPcd5kQv4DVm0nc4IMdERH7ldkhOwy5t2PWJ1i4rLoE0?=
 =?us-ascii?Q?/BILR9ds/P2RCwrO31R8PwfBi/wEIX9LU2IImjnGfCF1JLL58zDQ5f4LeVQB?=
 =?us-ascii?Q?RjPeQC49S56ak0vXLuzxcgV0BkM+bproxCEZ0ULUEB/mPchU152n23ve37LD?=
 =?us-ascii?Q?VdPLG2n96uFu+ZpLNESLJT/U0gmtI64pGWmHFUjsscW7055uzAhIYn/8Gusy?=
 =?us-ascii?Q?8n0WfmqzxLKV/qrMKdnYLz+CTDR83Ok9WPFp1SHd3ZocdVJFXPT0yiYhbfqm?=
 =?us-ascii?Q?MIVSE67a0/n+0K/RyeeW9/yz9YNf70Y=3D?=
X-Exchange-RoutingPolicyChecked: gwg9ueWJO8pT2bzN2zl3IlqbKzuTGOt8Nkz8MUjeNv8B9ELZ08SqOuea16koa1wnvF0QMzrQS8Phuj7GgSjgqY6uAevwySd8QPj3mbydToVdAYZkgsn83gEIYyVBqeHhM65IPa7gOONANuHDVaRNtR5QAl4RPyyG2j548xVN1EOPDjxrVEuvGFUzpinMTCAJTUxNJMOaYm3Puvnrp5qzp6sHnd+u1JaOxh5bPeRQzuMgQ9JOoF3Dx1g+sOxS+S8n19cxvT0iLXS2kTLFDwn+foOFeVmXhvBj4kZCEP3HHTq1rkiV9pJ2iS+l5HDzwDhe6FL3xXokixuw3bBRdJy5KQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a522a556-c8e4-45a8-f875-08def4df8157
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:56:32.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4McJxLvPh7bXJaOoNbVpP3bQ1zNTOK3F6YX/qdWPiBNElvESPQyOw6s+fAzWxhP/AcPoqn/9IZ/KnxDNUMWP6cSV6UzLjlqe9YZiKNG1mXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9617
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 02:07:49AM +0100, Jonathan Cameron wrote:
> On Mon, 20 Jul 2026 18:59:39 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > Switch decoder target IDs are stored one per byte, starting with
> > target 0 in the least significant byte. The current code accesses
> > those bytes in memory order, which only matches register order on
> > little-endian hosts.
> > 
> > On big-endian hosts, the target IDs are reversed and the decoder is
> > associated with the wrong downstream ports.
> > 
> > Extract each target ID from the register value with an explicit shift
> > and mask so the target mapping is independent of host endianness.
> > 
> > Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> > Reviewed-by: Richard Cheng <icheng@nvidia.com>
> > Reviewed-by: Li Ming <ming.li@zohomail.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Suggestion for explicitly handling the endian issue inline.

Done in v5.


> I'm also fine if you stick with what you have here.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
Dropped all the Reviewed-by: tags for that change though. :(


