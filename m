Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC41DFD8B;
	Tue, 10 Feb 2026 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692685; cv=fail; b=SlXv9jMB5N1lNv2wplW32/E4d8JSFaqOUx9Iap2FGME4nd2Xmp1RURfNItp+bfeTeKJvhCTB/Q9DqQeXD7O1urt/J6Jtz/qVGQRMiKuqNh9Vt8HazhLQIlUAasxcGe31Tl6PMzyp5+PBaB6sdudJHnJHPvSXfEQPOV+ortK3BFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692685; c=relaxed/simple;
	bh=jtG5DmJ3qATy3ZErFmwsugQMcIQt7OWzfyVGsfkENzk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lF+FDPIdGCBI+/lxC5wM1I5xYrkzF9GF2IZKUUokD6ZypbXHZY0YmlpcSnb9lSVb3rC5541KP9y/h/VkbOB3eNr0Fzi3nZ9tQdjgAmMzq0e6U1QxYpLQA1gpeIOiJKapleH/ijxFECwgK37Aq+VQ7JbvbJK4ThK3WrZM+AQgCqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrGWF+Ve; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrGWF+Ve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770692684; x=1802228684;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jtG5DmJ3qATy3ZErFmwsugQMcIQt7OWzfyVGsfkENzk=;
  b=LrGWF+VeCpcsFdOwRv2IW2XKSOFbzapFXb/Qdzvp1CisLFK+W4QgsEBk
   09EoSF4sOf1IyE/a4uX24tYnICJuGL6wAVvor6EGoJ63VabaDgJC/6C/V
   oqBo+YZ0Q/77fakg2wxf4LaVKN0sB5DEUKHe/enAnRgbOOxkUnQ5d55xj
   uV2mGkGHd2CygG3ISH4YuR973XPvRQU/aUHmMFkjJwx2/jf8UgoZUCEWS
   VJYyOD75iZVwWH0ooEX5c+MRBvyDnOtHb1HOn622yO3EH/f9t7IPJ0Ox+
   BMdan1bj8dk4h7VqVH1SswIppxSk6IOmXTx8H+MkWDBfYF3KQkyCNv+GQ
   w==;
X-CSE-ConnectionGUID: F4bxFU9vT4ymBpHOucQ2mw==
X-CSE-MsgGUID: hpF1r+apS3SFLnEZd/VBig==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71882266"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71882266"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 19:04:43 -0800
X-CSE-ConnectionGUID: m13JyTQCQSOl2YgI4GAhdA==
X-CSE-MsgGUID: HpUFQSsDQwe4yZdzfoqOZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="242390919"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 19:04:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 19:04:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 19:04:42 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 19:04:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh111VcOokLErDGKTsYxlVuYKCpE6CcgxXxb/OOjdgUrP0+DUY91inz/TXD8/ZA9FBjxqfApH1G+P4ZuY0IlZgarMHh0h5ZrVIrBtkyWC8rgLzRAfezIzfKF1jtSU2TjGiv8YyBfKHfG6I8EqFYcfBfajH6meF4/xTZ4P7fptec/a01ZPEB/O8TqF2TlNgHNFu0YEH7WDffknQ5fW7n55jTTR+urLZr7VuHbnsaVbI/0PLPQooOYoWlwzkfqQgYIaeX3+sOZdADNXXK/1ourvjSG3iU8nv88NUpcdDLeRKGKu00V6c4E+eFi3ObKNc6er97oueVa8uFMZ2BAhHMHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtG5DmJ3qATy3ZErFmwsugQMcIQt7OWzfyVGsfkENzk=;
 b=beVlijJPLuKucVH/kSO0ZSgMOx1w+shFqUxZs4FVwKdjNtZRiq0pxWJoIxTgbFHyFsLuibuqIN049ie7LJTFCHnUXULtXA/IP/B/pVzGM2OxxBEGkbFn2tP5FKIbZR1BewfWDCzPG2MSeUV5d4/4VcgyEmX8PegBSLBusl0NIUp6EYix701PFUWpUiOqY0nz7RzB9aYh+pdpG53TBmyOH6bPXBk4hStSrFpJ9qSs7h7g1tfRoFVI/xi08qniQoOc+pIcZZGP/FsDDJJWBf4Ew052fitou38LcN89ImOKlt8uK9C4Ry/2PzZRvd2pRevVbT9DaVvKo0ftRMQRmvZcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 03:04:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 03:04:39 +0000
Date: Mon, 9 Feb 2026 19:04:35 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix port enumeration failure
Message-ID: <aYqgQ3QgaedMhNny@aschofie-mobl2.lan>
References: <20260207133512.306128-1-ming.li@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260207133512.306128-1-ming.li@zohomail.com>
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 3804913c-ae25-41f8-b3c6-08de68512164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l+eUtFmNq4UeFLfdbm/WGXKE5n6yAg9is/WFbnec/LFkMcfSaqSfxSU9ylrO?=
 =?us-ascii?Q?q0rtEJae/zXSIK9KKSEpIqBr7WZkHiFaNFnR9zIKCXzF4b1GnswSJyIQnGNS?=
 =?us-ascii?Q?ifIvLJajkDtpMe1Gjx2287V3HAh9qFkcL5tbU7DIXf4VA3R0RE+KzCnqJsHY?=
 =?us-ascii?Q?+2SvUE1r+HtYNjRsoBNNmZjNyU4f45Uxl4CwDN9tmxKxUd1anE2OEkOf0dOC?=
 =?us-ascii?Q?qYZyiorKKoktrkIU93I+XlV3UuUD1j/cF/1B5UcBnp6qgUHPpcQ0ZlHil5sU?=
 =?us-ascii?Q?eexxrrYZZ/ULO+SZ6LcoT1u1xYt3OV3c8jalHBRmaQZBECdnv1tCC89BV9Rl?=
 =?us-ascii?Q?ruaO/eSLVkAoslPXZ5nF8XW1OoOfhoUbrLTiL7K0OZvKhwQk6UpWWtMO1Jzf?=
 =?us-ascii?Q?cBVABanK+fK1rltbkEjBSlqOH1HvNjAeS3CdzBjnRY992pqNbvwG0OlS5qzM?=
 =?us-ascii?Q?GKoIV/ywHKJ1IwZxdvOQ56jDEHTRuH6hSMpJdd65EjEYf1caqq/zQ44fQNiJ?=
 =?us-ascii?Q?dHSxJw7RZX5f5PJ7naNQMRqtjATJ6ut1uhy2NqpqWkFxT9Xk7b7bcgkDIKz0?=
 =?us-ascii?Q?J5paBWqvtbq95xK806qOEhIns2ft7NPr0wXsAhaDrve6d88qlFMhV8+saurY?=
 =?us-ascii?Q?cYNX0SUBXi1FG2OoGU4vAiW6zext6yExbK5Ki+CceOamTWAwmqfQVPrdvr2K?=
 =?us-ascii?Q?3mhSOjoLiaUSAnGeRC9e55WrabEdNdf3GdyNvR+ISrUCKbuIzxzR0+FGL72h?=
 =?us-ascii?Q?6kQH2PjNxShuQvylvp001POBe+PPJ0sUprLAsX2qtsfhhvPvjw1555LRNlqe?=
 =?us-ascii?Q?syIj4+0e8BbMFQcb7vR6wumVnEnny7Q9FR+1OqsVlGJdKiaow5iZogacD8Zm?=
 =?us-ascii?Q?Wror6ZN5xALwAfUzl+/0tLjiveAiL9AMmKwXuDUGK3xGIIzerDg3OxVvrW+t?=
 =?us-ascii?Q?NNctsu/pU2HZ1QLJEfoPx+dlmuByWttQ4VSQNZjkmE+hL3r4B9fW9SmtPMUu?=
 =?us-ascii?Q?aVHNE/8XyHrYM+1vvh6l0zmPygP/+6XXOHK7OOCx+2NEcirT8qcRldWvXNmr?=
 =?us-ascii?Q?hf7ACoJwj0zBUySw5TjoTxggxVSjZGqfRumgA+UeJfuFjPSCg/pcO0lc4oyS?=
 =?us-ascii?Q?BJ3ZBwla8e/eVNCvfWPPQCywnGxLQG3T+VrHWI4aiLTMY7bZIQH/MxERZcsS?=
 =?us-ascii?Q?VXgfS+AK7Dq8bPoUi6iDgZn8kPf0Eah8iuNolgpc4rxah2WkCKs8ViobOdJ4?=
 =?us-ascii?Q?90/QK3hF0+E3p6rz3a2q/7eEc4lfPrHj349HzYmw2NpUhKcW3PVuobgdQtNs?=
 =?us-ascii?Q?GHpcryoMKgr/mvRIAdmOFjSZe9HVWF4DF7LcxTKo1fe9Wt9voSB7AvA/ZBBg?=
 =?us-ascii?Q?+fYvwvPiU6tuV0scllMQ3pu1esGESOc03CPkYZdERBl6dJRHW5X2taMrKJm5?=
 =?us-ascii?Q?Jq92PFdP4q9UDr2uV1pKq8WC30KPCM5gkjEkrOya/ToLEkn+2cGKtwxD7XJE?=
 =?us-ascii?Q?NGR8juCjWZBaG5ACaUbUJppNZV2oelGJzPZIck+MHNx73gYGe1mdoK4ifWwj?=
 =?us-ascii?Q?YSrFrpLWL51rghfHxww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8g7Apai0r8pj969i0RIqw5y/FKdrpjRwFVefyx6CxTZEZ009kJf0KSio+UA3?=
 =?us-ascii?Q?de27rRcP82ODCAao7ocXyBqDx0t4m7bWijWUcFd4OZ+FRjrVsEogOV0sHmEK?=
 =?us-ascii?Q?48lqhZ02kGf6p4YC4uV59KWbbZlCyJsAR8jrRssuQZZFDVbGntV8/61kpYzR?=
 =?us-ascii?Q?CbRDZm5uK6O5CK3k0MW1uQFnbUByl7toI8e+ioscFMpN+Fl6Vo2wvGSwd/z/?=
 =?us-ascii?Q?Tv1RbESqDNUEFnnTVaXdazsNa3KJb0n9pxrAjf4hHtBRzl5SyIjyV52c4IAc?=
 =?us-ascii?Q?oEG8egGkKvhkPKtJuJoomqp2x/9gHNhh68hsnDWf5IpBypybPB4QydA8gc+j?=
 =?us-ascii?Q?5r2PHt8gcUDJsiwKudyvaz/jX8JJNNTNhANCpazKir4SPCUHz1MxttylRldW?=
 =?us-ascii?Q?lacHzMUtkj1x8cGfO6NU4o93QqXIQtAiEdIaDhvxZuxFoQW7R8bgoxiO//NS?=
 =?us-ascii?Q?brkJSc+x6PmcJTAMpeCFEKuf/mO641+i0bcuH3HmJ5gwVj9CpvUoSIS8UjPW?=
 =?us-ascii?Q?oDinNPysXyrY6esxoFKcvpW02S61Ejdj9y3mDraTxhhROfJZz5a8v/paOYeZ?=
 =?us-ascii?Q?a76RJmJp8VF0fzx6tYdmetBt4i8+oF+1LR+M2R5ViEoUgyxvzRtbSE3ntWWF?=
 =?us-ascii?Q?wwiERv8wGXb7pYj21OVGkX/d/3ogQG51VlldO+J1C39xLfDVcec59ttN+cau?=
 =?us-ascii?Q?AnSw3Fi9/pxqsGCqRo3yT+w8NTA6dkbBlWrlnx7HzmUxrAO+aHPQTszv0Aor?=
 =?us-ascii?Q?1SxHxCceyAIh3eRI4opWv28sJzzByvTNX6YcleFk+Urbq1kpPk4NNnf4YfK2?=
 =?us-ascii?Q?XJImX6xmMddmjq9FMjXvz6GYxLGdhwxT5iTIeOYTn95OSF+Q+bYQ8NbE2MMD?=
 =?us-ascii?Q?AO55TdgMFoiyBVBry1tECDzoL854WE6BHJIhDUC9DWzCDHhIho3qgd15uU/O?=
 =?us-ascii?Q?aQpWr2KCud2WRYQLRByeyW8vx6Mzz6xwdK2P3Zt4XfpXLBx4s/7R9AvdwP26?=
 =?us-ascii?Q?u1azGWIfsxcRS/f0Heizpz5KbIK/xjgI62pWaxJ3mvdj8L6oUo78HZhhshBS?=
 =?us-ascii?Q?JH2kXwLNjOxZjvfRS7Ye+iWK3LU05C9hSIjHPwwPxptoRruIq2toohquelVM?=
 =?us-ascii?Q?0ymm2OmSV+2T1GSK94872pXJQrIjX5+66YN1LXaLwOfYmUWcydzc/KYSK0PG?=
 =?us-ascii?Q?FMzU/MjsWaVPtSoDAN5BqZa36ZKLhM+7I4Soa6yYmlm/NyHqWPZz2/3tDAHv?=
 =?us-ascii?Q?6yYB0admL6IlNFxbTgFz/xFPe7fGoI9xNs8sSR7srE4zQJ2oRtRbxmskqGo4?=
 =?us-ascii?Q?BxU6hFweHuvIeSCHo+ADtiQmf9x3EcxcYONraLhQmk8Fo1LVSVrvSzFbEtBB?=
 =?us-ascii?Q?B7E9DYo134kfM8KqIcOXArsxYhsIEtNWP1Zy/gqHOPtpTHWIjByBxLYMoS9Y?=
 =?us-ascii?Q?nVaEU9pQYct82YlNFNlSpdlsISRvmveLYIShtLrRxyM7/opLViNydaJkUmMc?=
 =?us-ascii?Q?1gAA2aLebmHlCDhUyn5ExQw3+xrrlMoaidSTDwzBuhGq1A8Ee5fQvVQBAA97?=
 =?us-ascii?Q?TOCs1dqbCCMz/YOEYmhjPYb4Z4JTHeooS9FXNn45Jq4GTxyZd16Xin7jCyEB?=
 =?us-ascii?Q?Ja8Ihv81ov2T14uq8fJzbAJRK2/YlfhV3A27h2nfWSjL/emD4mVZs0rxV5VB?=
 =?us-ascii?Q?PxNze1tlyHdF2sZssfLEaMDwb0WXl8NqF3nFW1x/aca0/RH4WRBNqy08vhMn?=
 =?us-ascii?Q?KjQ2mwd80xxQXrbm0ZBtkJ12+snvcUg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3804913c-ae25-41f8-b3c6-08de68512164
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 03:04:39.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaX8YlsxNGFUMoJzgjvZmI9BQnPxGOVqaY25/b3XCyy2MduR/CqU9YSMW+n6cJ7Udyah4DViC9ZNGmC2Gnm6kFP0oql4YpVyWxT0hX08jTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
X-OriginatorOrg: intel.com

On Sat, Feb 07, 2026 at 09:35:10PM +0800, Li Ming wrote:
> I ran CXL mock testing with next branch, I usually hit the following
> call trace.

Hi Ming,
I started hitting this after you first posted, however it takes me a
long time to hit it. Do you have a method to reproduce that is better
than running on repeat as I do? Thanks!
-- Alison

snip
