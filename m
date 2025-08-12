Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C6259CBD;
	Tue, 12 Aug 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957692; cv=fail; b=MJdAaP1giobSvtsz63f2atCoy3SlaeOglwSQ0Py/90PcNCe9MTM8AU5MjKQNi/wCa0REKKVcIDPEo4DsNysi2Td8xF5vE0EI67X83+7UoNr5TsRD95J3KjvVTJQV84PGOoI9rvmCofnIIE0amuOTOaF4psJdwgmeaSAcNep4wK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957692; c=relaxed/simple;
	bh=c0SwuP5gHZdNCCpH4AYsImjOzyn7t4blA63RdNcmBWc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qDXSKso4Jt/OfYCISLclGzghoB8saVHtpN/dKvXQFUyf3UZ/LZnfxGnGCXjlNk8BuXq33fKlS1MDUVGiiObPwe2cV+9za38dRjTUyNERBQBuhobtJ2qtH94uNaEkfQbJpVndlJ2G3zB+1cX5XMSrZbrNgQSnT4tYUM/kl48yRb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djf/+dZA; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djf/+dZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754957691; x=1786493691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c0SwuP5gHZdNCCpH4AYsImjOzyn7t4blA63RdNcmBWc=;
  b=djf/+dZAm45ecyFv3u2FCKQvjrsbRjWcYAc6XxaTxoCCKk0UTNGLA/NJ
   Ty8C6yAY91lqk6zDoKstnwpq2o6Z81WT/xKfcV7WFZqiKHB6lZQ0hwUsP
   uFNa7SyR/HarQ/j/0oBvtG2J4q7Pn3A+2UBu7TwSbpE0dGF3J8qkwHVua
   q3cB/qr9C0S/9fvktmBjUiFSCNbsi68elnpeFQTLQGZe1lC20EYA1NZEm
   lVq6SHCFucSJEiUVxOninz/CelwHc9nlxN8hhnwkLUOZ2y86PASLYCFJ+
   afHRpvc72o/BtEfEZakZnWCpNz0k27wQmBuk72LR3Nw4DsqjOS8udLxFZ
   w==;
X-CSE-ConnectionGUID: 5fKf50g8THComwUNbrP2nw==
X-CSE-MsgGUID: gZ2X/zgMQ+yEOt8XE6uMhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68594138"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68594138"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:14:50 -0700
X-CSE-ConnectionGUID: TVqNln2ZQUGwrJeRcJdslQ==
X-CSE-MsgGUID: uefY/QOXRZSZv5AUlDp7+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166044752"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 17:14:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 17:14:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 17:14:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 17:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bt3LpiRmgOxnCIQUhihFLPdYT8bk9LHGAiIcHgIl+hESacpOtfCAheMAU5X0BpKELmFfHRWRfNMrumgZruMMx3nm8EHbgcN8dTe0fPHSZ0NU0sHrVxl4+uvUAaQ9jEpDe7YxIQp9ypD6aBwj5emTxpKHgjtCeOVJ0zRh4cNhK2xgqPun+NpamwL9O3BVmpZPeOEI8Qd1KdNmfhLIeaOeG6sOqXGJ5tI1XOTCDYx9OVN0cBTiCT218TzdZqb5Qf+4tL/lJkVOle1RBPfvnb3RD1dKpEISe6ALP3/QdAjW0/ibzUrNIK5Pw+ekaAx2tTce2fPQ6Tj3bozsbjf0i/Nf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkTcYlJ1f3m/ghWumcpyM0L1+GeaX6uK44KijIj988s=;
 b=JVTDV+QOYA0s9v3aV85zXxYGfwrNiuYV3gsUs/tw0zDhx1FEv4N0biEyDXvM/9uw8xxIM7rGeCrGv7kv734Q0mKXr+kWD+5KB58aXlVoyVzGZiZiKnLGqozM5Xft/ITcl5ryugZk5A6yE345YPUXw0XJpVxEQsozbT6xG9MtP/+Uo6Uy8fArLI/utLpdpbrHZwsxehv3BMaCe9X3SqkgjMzFrQ5HMP9xTuFzswy/KWst7qptw+eT84wnDyP5dSxV2+NXTSL5hAj/4fPGOqovxcUsDWDcmtuCBfKDDQiBzx8DBoGOpmy5Es9y3bx/rmiD7ofHy0ia16PFTaevymq7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4664.namprd11.prod.outlook.com (2603:10b6:208:26e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 00:14:42 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 00:14:42 +0000
Date: Mon, 11 Aug 2025 17:14:38 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Use str_plural() to simplify the code
Message-ID: <aJqHbkMX6L2AIe_B@aschofie-mobl2.lan>
References: <20250811122519.543554-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250811122519.543554-1-zhao.xichao@vivo.com>
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4664:EE_
X-MS-Office365-Filtering-Correlation-Id: c14dfa7a-c953-49b4-25f9-08ddd9353c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MJlFZkeUedCJE/b1XoRKde88XAruGSrMO9Bd/7GDlXiV80gun/Hza0zPfKvO?=
 =?us-ascii?Q?1e6Ylaxoblgh8rsTgCwKKM80TkS5m3Ovf78SZ5BdZ/qF2vm5uck/EOncEFvt?=
 =?us-ascii?Q?kMUxF2NxEyU6tB6qb+b2TA+hiZPe/EOotpOOARJOOemB9DhbE2LjloS0A3eY?=
 =?us-ascii?Q?EjDJSaxf3mbYxu4DdFVugc40YdCSFdpeyRBIc2w32L1f7QZ9Ve+Unxu+vzbj?=
 =?us-ascii?Q?FPlBpS2b+vhCel2RUhWJIMsjUW1bPNr0ASM5DOh1ddYjld3mZfdRlEV842d7?=
 =?us-ascii?Q?dKV1O0WXNFkAw0cWhP2/Q3pBDUzXKn4Rr0vgq4PTrofcV78Rz8eTWOHQvCTI?=
 =?us-ascii?Q?Es2GpgqUJCZiroA/Wmrn+EsBeuqcjVcSPTruLdijGjfjVKMCqp1gKGvHI/2x?=
 =?us-ascii?Q?eVhVuVRLaIV2ZVcD48UHTDsaC0S4a9UQGB6q7rbj82iudCGDPf8RuwUukMi+?=
 =?us-ascii?Q?2RJR0InjMXtKotx8zAuqqYkUiKudh0SHlbkPzX+BD8JcBxW/QcBxI0U9lTvr?=
 =?us-ascii?Q?wfJsJnv+YaGDX8Kp7kbHSa2jqMCWQb19BHx2G1RZ9yPsKI6CX32cf6IZGA4a?=
 =?us-ascii?Q?8RXydN57WuHhGeyw8XmclZ0BhV7NkPtqb8m+RcjCsedV4tc/hSAKrO1DYHEW?=
 =?us-ascii?Q?KxoQEoaQMYk/q/QEd+9upT4CsonTLi/K0jN8E2hH60xx6UBWv48Crkd7yDOX?=
 =?us-ascii?Q?4MSjbk/DfdQdTqjiAFTAlGJRI+T7C3wn23gWSj+k2sKN8vcpy9MHEn9KvFlp?=
 =?us-ascii?Q?s9ZVs2XCfa+KZHeDDf0R6nozLWKwoZUnCAHlsYZ34i/wLOBgucun3gELZGpI?=
 =?us-ascii?Q?zkWXH01boM4pRzt4dU4JFZtY8JV/5jemJzkQFbSIkUJa12UuVh+n/iGswtqg?=
 =?us-ascii?Q?H/iOitFOhgXTBMr0qRflpk8JUaxlpiW7QiX9d5vC9J7o5yzuaQ1KXyD2UyOd?=
 =?us-ascii?Q?Hz4vAjhLrBQnEJ3bmUO9JGw9CXMyW42D04DFwWaVCEXO9hDJYYHLOoSc9kng?=
 =?us-ascii?Q?LzFl9vSaWrJ3kk0S189Hc75iUgMJMsbO6hAJ0fOuJQTf0//jRuHi1DQkgyVR?=
 =?us-ascii?Q?burvxPe/QZeDlfTPQdNwhUu1FLhPQjzFoI4Lc0YQdXoWDONzQL5GJHkeDf9E?=
 =?us-ascii?Q?FUOlIlUEFzbWFWLr4+J9zbwQ8sebZUk2iHi7nngKhodfTVW35OvJLKhw6oJf?=
 =?us-ascii?Q?WSohJGCgC1lIO7gUGKlV8bNJQltpaWKU9KBZjgJ4K3E2QbOXPW1LjD9nEBno?=
 =?us-ascii?Q?9KlnjoBenAvTmw/Ct975Ksznu0hz46EcDM87YlF1Rb5DF5Wj41N5VbGaTW3o?=
 =?us-ascii?Q?+7sLUITk3tnQREO2OTSWToYp5c98py7EgzrE8gtSNQi67whslh/SkPbRnZ29?=
 =?us-ascii?Q?d6AuzafDIY0JqausSJZEDS8aUcE9GS/2m8zConZTLMqX7Uirfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+V3jfe+7oKdnUu5+Lr2F6tI7hKIzpjTx1Q6Qhs8d47ubTS07cU0rNWigmPUL?=
 =?us-ascii?Q?Wla5g6l95Sda4ht+H4ub2MB5xTSzcLBCz/RAkyw6sBbVeyXq9RHfTrEvGFeX?=
 =?us-ascii?Q?Fwn3O8mF1QfmDz7f5N+Hfui8QxxAD3txkLTsl0K+jUj31rBCT7yJe1slEgdj?=
 =?us-ascii?Q?btHVzB2N8LHAE4THxXjPgBz9KqLTzuI2PGosg4JOpp8Td16DsJaH1cd9Q3S9?=
 =?us-ascii?Q?ySZBwj9i0WuIygayg0MqxMlHxPYwGBIi781WqV73i57aRFXVaOYEuQVETtI7?=
 =?us-ascii?Q?G+fRn+SejZODY5ZjmjBgPIKDps9O554oYoeEFumnjMmBUItBMrjmKSjaZUJ5?=
 =?us-ascii?Q?hk/ZFcIpaxVnmunZmE0NTscOqUu0K6F5tocGIwVXoT42y6ohrMHymz6CaUmx?=
 =?us-ascii?Q?lVGXQVnG2unOoM1n7Tp+qC4mXwkBGa52iXif4DjXq3jtYSIAIUq+cv6obtS8?=
 =?us-ascii?Q?BRr6vcuw6pNEllophDRsFuQwFExZgOxk2B7/kqkE3zig8wr5cdKat3wMdX7X?=
 =?us-ascii?Q?1Ysd6fsCBhKuOX/25s3F98pozbiHMiWSnOsfKvS58eZAj9SsSiCT9sSj7c2C?=
 =?us-ascii?Q?EoL8YyFSyIFYR6+5cqJtM9PUG6QutOqU2pX+ohHhjosmi8ne/DnkgJ+5DOuN?=
 =?us-ascii?Q?SGzMZwV+3+Scwdn010q9jjq2RPxNW3WnkvpBipJtE1VkCUFWAEGJ4Azj9wyq?=
 =?us-ascii?Q?JW96jEDEEj7z4O0DpLlUqKyMb2Sg1IMfWT9t/zNY1mw5sDC7TQZ9nlxnrWk8?=
 =?us-ascii?Q?Tsoys9347QZ4pcGli77UpBPigy5ZbUb5RE4huZQcoXIPnWaixXFEIJwcIAeU?=
 =?us-ascii?Q?wcY4BsSY8lMiDDNg5rmG0CY+UJwV5xNgh/xvYksCd2bA6JtfT6fLAoKU2Zdy?=
 =?us-ascii?Q?myAJ0HkkcSH45kUWcx9oQ3KOGM+hotKBBAehvo1pJ/LhkWdspDxpRccNjrB3?=
 =?us-ascii?Q?826hgSeWK6/Dk/AymT3ZdfqSp3dwppFB/fZmGqrPpjzVZcYYSRhyKTvDgvAl?=
 =?us-ascii?Q?l58C8RqYDZAAA+yIp5X6w/96B16flGnoHv56JXAcfu3fyRkUHmJrsdBTLtHt?=
 =?us-ascii?Q?SDyXRXWGYZqZVnXlZy/G+l4dJb1/CfKE/HiAwjF8tlaIdVft35zSoyF5XjVE?=
 =?us-ascii?Q?+TVHyrS3RdEAkCsBOpKUSNYoc10fPXaEkMef4Xk1brTX0R1fKx/+B3AErEIg?=
 =?us-ascii?Q?+PbDUegJgs3wIWSSqn6EdV+ps+c3rDq8RdPS6KGmjYyJZ0yUPQjPILE52SwS?=
 =?us-ascii?Q?OLXKIsEuVz7RMnbBFzZSNBixU/tH7zLiQMAfD3z6TAbLI6W0sE9hdNCHNPva?=
 =?us-ascii?Q?HTiJBejdisMFmCsZiwEvXnV0N+XKiYKlCylFu3CO3guWjpJXRQCq2Psci+Ol?=
 =?us-ascii?Q?1T0FzlN8LJ0ZFvIRhGiemHlOM6nod+Ey2Q7kj3L5TE2vsKrZNyA7mzimJNcg?=
 =?us-ascii?Q?U/1PM/0aDj1a8rpQvuhjTGLjucLGIFGXGnMDLTS6fFZuOKpkChZWrPOgl8fJ?=
 =?us-ascii?Q?Lao2wCVzoD+6nrkcc1nnx3EeKNpy6SuV7Kzyt2q3jqQWIpoSCozOJPE/CgeA?=
 =?us-ascii?Q?PkisbO7xo6rwBN8v/iDdNnTSAbGbxkDwI+j9P7CLO3/fQRPf2WE8IQfj6/rF?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c14dfa7a-c953-49b4-25f9-08ddd9353c50
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 00:14:42.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cINKiwpz3wTmd1aAEiQoOhu2wIv5hYnjrX65tclLZr1CB9TtgGYXMyZafoopqKWkCJjvFUqGnkJGFXW4Fvb6895/xxPZrHpFHNmTBEYPMOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4664
X-OriginatorOrg: intel.com

On Mon, Aug 11, 2025 at 08:25:19PM +0800, Xichao Zhao wrote:
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Thanks!
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/hdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e9e1d555cec6..37176c0a781f 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -197,7 +197,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	 */
>  	if (should_emulate_decoders(info)) {
>  		dev_dbg(dev, "Fallback map %d range register%s\n", info->ranges,
> -			info->ranges > 1 ? "s" : "");
> +			str_plural(info->ranges));
>  		cxlhdm->decoder_count = info->ranges;
>  	}
>  
> -- 
> 2.34.1
> 
