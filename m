Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB2149E13
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350693; cv=fail; b=oPOH7a8rThW9FUDnTQSsxIU7Uos/IpSQDmCuy3vAtiKjzc2J4QnEsrfz4QGccMoNsqIdWiMhqw8Z1YYmIM/7UUYE/lK7L7IalmlPVA6MexiN+gNDs2i5AK0sJLZQ0Wd/73ydJJqnDyrDvm8deL3SjAvgVeKwHQPVoAwDb9fvE2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350693; c=relaxed/simple;
	bh=4mSSXdDYGfybEhPUwoD5qHHRl77HZblZOs/cbg7g1fo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OaVR0SpvJFqqTYm9WgXcUXKxyo6/G5Kkm5qMtYbSHD7o1ZPUiUZ033f7f/JpE5piKl+yqu0JuVHsy7lzWgZQ62UvqDjcYqpULtSN9zkVCFbJ2rJH6Nvs5x67LTZ4eaK5Wwc2/iRpEs1+yOthdJcteDrGLI1IQ9+0jG3SZosNKzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ah+zCi4k; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ah+zCi4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745350691; x=1776886691;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4mSSXdDYGfybEhPUwoD5qHHRl77HZblZOs/cbg7g1fo=;
  b=Ah+zCi4klThK34T6VzkM9QAKbx8ip5xH0XkGV0XkFM0TNfQOQSPeegz4
   tZACXk8s4lWXccd/QtKakgO8bkTGlOy9OgiTIRtHrCiJsBAeffSQYPQY0
   sy0KlsjsAiIfV4OdB66nVy7xbC9CBqqDP0DuLfSGiWRpVSqojX2vIcNBd
   OnWSW5YelFZAa+SQ58y2UVPUV8nIpVylsl7eOSz7ObCMM1Ui/LZZmhiFY
   zQwj5Gw+lnIfgJMmomG9p6sdtU40PIZKFggNt7uNV7kSwhvjFMrv7hPI8
   Cb2yyhwLas8wz1A874MSCapPnJfbnN5gZ/Yg4FMHIuVy1U8oV08QOl1rL
   w==;
X-CSE-ConnectionGUID: IZtWfOLNT9WNTb/bpNoCgA==
X-CSE-MsgGUID: 1vh8qP7PSWCbpZUco0qXrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46043741"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="46043741"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 12:38:10 -0700
X-CSE-ConnectionGUID: a9jPBXB/QlKxd4svAlOtMg==
X-CSE-MsgGUID: DYaS2/+1SkOLy+W3yqg90g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="137093936"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 12:38:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 12:38:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 12:38:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 12:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDPllQQqUb7sDisytwkswn1wAXW2DihR2PiL9opwkF2BdbD7cz7c+45DFry9REnlqO3wYqEprELT0q0fUX0s8b72aGzftaGiMciuH9MRRuU3JIVA7m2vBZA2od2BXPr3lgmuM9s5AR/KSc38sywDDAdhh84iMxn2w0KoIZGqYnFQPwaPbwzuw5ApvMxXqWLLkG4To23TFRTw377/6qMmJZYiowJ3XNv0860oCg9ZKvOE7VKS/VmBvg8VOpIotBaHeRDoGE+tPLY5tC/kkmFbEpmHvpnpiVld0bcl0N/6pSy1q0mN2u2Ng3x2qwvv8/XEYlj8KyTJXZvl1lGWiWzslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8F3RnhCi9jMfnFnPIKrq/6meoi/G1R0ErwjUOIIxgk=;
 b=OfQfAEDyOiEmTcpxMF2cfjZel2LS/Ls5pTrlrTLWZXbXZNhoBTk+tEVwOIOqIdPOX56uOHKJGTrq25+OQ/nFlZAfkS25FT2rQwW/j304xmfzfF7V3lMIURcxT3bDXfRRrwxVT1n9MiwD3kvgP9xsNsfqFgPKthcpsu42gt0VKc7Qk/ZtRIKwsGenuGHHpQi4RwV7MyBF9kUmiHta8e6WSdWJEXQRoOkbhx6kNbMPEnAMhWCRJSWqj8Hw26UdqEXtbsXM9RdElPmBKvXUlG1nxzXaAr87++ifXz2czWbQw/Soh//b4Ww4CeSk7kbf9lRv8vIc4p9Rk5HhkA1bNg0Lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7730.namprd11.prod.outlook.com (2603:10b6:930:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 19:37:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 19:37:46 +0000
Date: Tue, 22 Apr 2025 12:37:43 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 1/4] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
Message-ID: <6807f007c6e3f_71fe29431@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250404230049.3578835-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:303:16d::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e0935f-c903-4604-fb79-08dd81d52855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eBpeoaI/zwjYIBRdvVDpQ6JOBrMSGTuAjjXT8485MDCjXMb8yP57mtK8AynL?=
 =?us-ascii?Q?d3cJxjuo/j7BI+6+vsjq8OpBdruYTgp6UKZQlEHKDp+OTTZFgRdA7HWa3+Uu?=
 =?us-ascii?Q?ssHHKGUaVGGuFRKO6GM4tIp+8KHdVEeBzJpamzfVW4InAOOkiiqPRorezhqM?=
 =?us-ascii?Q?RutLO2q5i0PvySmDVyDHNH37l/c2hSXKwNmXd4IrAvuUn0i1SgS/nhXNej1q?=
 =?us-ascii?Q?5zO6i4vGmOL+9a0Cnl5sYOCp97yjhAEtQ2TyaWJ0ApbyQjBnEd5uAPn0kIVG?=
 =?us-ascii?Q?ZQAzuSAx1/2hsUeOPISY0C8FxNhmWRLakzzTTjY56qD2bxD2XvSarQnErlwA?=
 =?us-ascii?Q?T6ns67VU5Qmla0Gl1TvQniXjKaqseaGR0cry9VN0QjgFsk5Z8848uitzVOga?=
 =?us-ascii?Q?clFATsv/icnUuShek+ZiztzpHp6R7fuO3I4EKgfJB4bBC79wpOmoLVAZoX2V?=
 =?us-ascii?Q?Gf9rX2/NOo0vnxBI396rdDGkdIoU39saq6YuBc7TlYsefgIETVi8PGDlmrsC?=
 =?us-ascii?Q?eqVYKJk2bmxdRTIvCmaUM5VfHQhBJAaE+bUwJJv1CmX1fjHYrTDl6GvgUV3U?=
 =?us-ascii?Q?yr7Uwz5CyJRTq/52beWgo9sic8WSG43CcO51xTfT7g0c5+wJS+OdDbyYwrd+?=
 =?us-ascii?Q?Oo6FE1NecZ9v7yufeAXLjUNZWndIqa95SqsdUFvH8Uhm7sxSRGEz3omxH9yB?=
 =?us-ascii?Q?f1qQKwaz+RQ9j0VcgOpiw/bIIceFG22y8KIe0kWrj33poAr+8KjhcaRO27kB?=
 =?us-ascii?Q?AiSSBsYg4j0GIy0zKg54xw67BIyeAF929QAotdATD4jse6MYuuMibZTiedhZ?=
 =?us-ascii?Q?3OejNjViZKoiSjsQmxEZd7eQx/3OjjAonKL+4wSxm6s/n83QNM25A/N13sU8?=
 =?us-ascii?Q?/FdWX7PYNZffj2eU62wP++OWaZ0dk9kN2+I92EkbjSwVa62p5Y97Krua5WiQ?=
 =?us-ascii?Q?PACuo+rJS6AtqnHogd5N45t/qAb3o5m6NnhUplQ6OVzijEtPk3oKDriWskIP?=
 =?us-ascii?Q?n9QZDI0Fa+BlMyylqZ+F9uzz+p2h2gA26Na1M7mj2wsxUqdGVsXGtH3B/5YT?=
 =?us-ascii?Q?36WxV4MRewOGfuBRKYDg8atPtNwL4dH5r6DJnoeMVSSeSH2Zh25J3HeTFQOu?=
 =?us-ascii?Q?wUn1LWDKcPouUXHIbLWIAkw3hEI1neTXddZejhpusTAg/q4oCkkztGZ2DOnN?=
 =?us-ascii?Q?0zlAqr5U/PGEYNX9yxsQ7pna4xj89qKU+6x1nzdGB7pmJDBGEQ79s5v1XdYH?=
 =?us-ascii?Q?6BnC4KyqQrUsTT9sFR4a/F8f96Or3wZXFW5YFuIl5OkG2LNpL0wi95pr/52Q?=
 =?us-ascii?Q?x3JUVFMt3SintKh24EbZKhHfx2m9OVsSmnV5HQjbrsGOx88KfB0xlLqIs3Oe?=
 =?us-ascii?Q?AlaJ34cKeqS2Tui5ZZq2l43wfPezQP+yIxNXkCR4pql2YBqBcAlw1Zhia1sh?=
 =?us-ascii?Q?3tcNR+r4q7I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ijYjgh1sugIPbFfVo2dYqEc+GoB+fnz6D8Yum7LCEIeOKmnEEmIzZq30npHV?=
 =?us-ascii?Q?7QcdDGIGTQroBnQY+nWYftY3yj66sEfdcEl+X8hlUO7HoodS5S19NIZ7x8m+?=
 =?us-ascii?Q?o2o2PqYzeFA+Y9uN9kVG7aNX2lOCrPdSeVmXTrShwvSN3vjS/NqTyMP529R+?=
 =?us-ascii?Q?ElYhQxUHy7YEw/gOPQW1jJxCEzWLOJ3pCV4oEJgYNbP9X8wwCdtcX3i+mF4w?=
 =?us-ascii?Q?DK7m3Wkp2y7jGqB/SAVfio7HPvxuoCsprI/B7LeXrUkxnXmhE2TFRZZimlzA?=
 =?us-ascii?Q?6j8JubiH1x03nKpDuZifvq1DnsjKFU4BeYD5NhFHfguxLnfvVb5aHgfHebnk?=
 =?us-ascii?Q?wlZWCLszzKDcxfzybb+omK3XanVYGXUo/3APJekQiwmifFaeXfEN0weEZaUD?=
 =?us-ascii?Q?xcAUcbDz7MEAeYvu3Mp5TBcLbklxDpsj9u78iguSPcJ5jhTeZPCNIVwNk8Tw?=
 =?us-ascii?Q?CIks6jPGQgNYr+iPWcu6s7xlB1vlzh3u7eSorgqpq0o/JMwxCfIpX+YwW9Mf?=
 =?us-ascii?Q?0nOEOL93zrCa9zPN61SFeKHvbOQXIyyfOPLZ4jc7zeVGDifldmlX6jqIhSdz?=
 =?us-ascii?Q?yO2HaVxffvznpvArwLCo0Gd2mIBRcChlGu79+oyheEldq+OUq1h+IT6asPKf?=
 =?us-ascii?Q?KBJ3K2JLgHFW29f4naoAR2drincKGiidtLSv/xOBuaonT4t8ihM4YgeNPBY7?=
 =?us-ascii?Q?yVvEyqOijyI8ZgUOhqbVvPnntsjyYIuX5iBaFUNzQtQqP6Fw+zULEGlZbli9?=
 =?us-ascii?Q?X5wmKpGiXpvJXZuA4fn/4WT4ZRIFPkhUjzVybqniPgoKgtXDFr/fpKVMxthV?=
 =?us-ascii?Q?Jlbz3Kw5wjs+sWWpE4DUFRIUoeZ+C7eugVwaQzCCBkdfllYNWFQYssZlnk6l?=
 =?us-ascii?Q?yfiExWM0BCGn6nJXfs+U53akv2mQ3nyCwsIVtquFMj8+01qaTS9NZnzuBj1Z?=
 =?us-ascii?Q?Reimu1PXp1w23ng1/gY8Z5iBBc1VeyyoWEFQNZk5RsTTxkOKYonGknjyPw8d?=
 =?us-ascii?Q?tvEPRAzfJWB+OIR/BDVNJuC6q5nYPZY7xhj+cUdf9kUAjBQbdu3wlMGUxJeJ?=
 =?us-ascii?Q?8TkRgNox0tD8yYX0dGySENEL5vJHpvr3ON4cJS/TpenyBKWRC0qohE7ww9IZ?=
 =?us-ascii?Q?Y/v2CEXWMOBF+SI2T8WQWP9usgV8OompUBU3ULObAIUk8gPHbmhpeH8f0hXk?=
 =?us-ascii?Q?YQTWaEcANVhPQN0cdz9g4J7/yYJjJqyzEkq7+QIt/mwL3z9C9OG+rqq/c70y?=
 =?us-ascii?Q?N0zKpsOsMmQjjueigRX3EO/tcVMHtUTUmOJj+whn920nUxZ1c+yRjS5er22M?=
 =?us-ascii?Q?EFJmcQJwg6X6mvAQjdCh/QgoZpYqyF+J4qF7+gm58mNLV+CNoQj2Uew6EiBO?=
 =?us-ascii?Q?nsED0ttoCfnaFoaE7gckfHzO1VVLnbqjmG/AfdSdWiQDhYKi+B2cwfJLja9v?=
 =?us-ascii?Q?+qVY/VbJPjKh7mfxlYlJq3TxKSvepVCzMEbh694DgOVjfvuhamvG5InRDMgO?=
 =?us-ascii?Q?TD04O/iexIxbznQmKtj9r6Lg4fqZKuion/xINnMhYCwG2/bqoGO+b9OGBWXL?=
 =?us-ascii?Q?pUmmqi8fg0NcQ/h1Xjn/M2GWjT2o794EJ6694MUX+lbDt4Rpeao75XnsmPZo?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e0935f-c903-4604-fb79-08dd81d52855
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 19:37:46.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9QKRKMGAoC74kE6Ympi5CtejBt+knsCK+eaL0xuDZA835oH3SwtUg0HQMpLvMd+j3Ge5BKOT2VRKkHnUM/o/BE5rWx8rQD4/+4rHbvg4o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7730
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_id to maintain compatibility and
> introduce a dport->id as the enumeration id.

I think ->port_id is now a poor choice for a name given the potential
confusion of "which one of these ->id ->port_id is the one read from the
hardware?". So I like ->id is the name for the logical id, but lets do a
lead-in patch renaming ->port_id to ->port_num since that is the
hardware name for this i.e.:

#define  PCI_EXP_LNKCAP_PN      0xff000000 /* Port Number */

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c | 40 +++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h       |  4 ++++
>  2 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0fd6646c1a2e..e90e55bc11ac 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -159,7 +159,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>  
>  		if (i + 1 < cxld->interleave_ways)
>  			next = cxlsd->target[i + 1];
> -		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
> +		rc = sysfs_emit_at(buf, offset, "%d%s", dport->id,
>  				   next ? "," : "");
>  		if (rc < 0)
>  			return rc;
> @@ -739,6 +739,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  		dev->parent = uport_dev;
>  
>  	ida_init(&port->decoder_ida);
> +	ida_init(&port->dport_ida);
>  	port->hdm_end = -1;
>  	port->commit_end = -1;
>  	xa_init(&port->dports);
> @@ -1044,14 +1045,14 @@ void put_cxl_root(struct cxl_root *cxl_root)
>  }
>  EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
>  
> -static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> +static struct cxl_dport *find_dport(struct cxl_port *port, int port_id)

This also feels like it needs a rename (find_dport_{by_num,by_id}) to
avoid future confusion where someone gets confused about whether a dport
is looked up logically or physically. Even looking at this now in
isolation I do not have the context to say whether logical or physical
lookup is required.

>  {
>  	struct cxl_dport *dport;
>  	unsigned long index;
>  
>  	device_lock_assert(&port->dev);
>  	xa_for_each(&port->dports, index, dport)
> -		if (dport->port_id == id)
> +		if (dport->port_id == port_id)
>  			return dport;
>  	return NULL;
>  }
> @@ -1105,6 +1106,7 @@ static void cxl_dport_remove(void *data)
>  	struct cxl_port *port = dport->port;
>  
>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
> +	ida_free(&port->dport_ida, dport->id);
>  	put_device(dport->dport_dev);
>  }
>  
> @@ -1114,7 +1116,7 @@ static void cxl_dport_unlink(void *data)
>  	struct cxl_port *port = dport->port;
>  	char link_name[CXL_TARGET_STRLEN];
>  
> -	sprintf(link_name, "dport%d", dport->port_id);
> +	sprintf(link_name, "dport%d", dport->id);
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> @@ -1126,7 +1128,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	char link_name[CXL_TARGET_STRLEN];
>  	struct cxl_dport *dport;
>  	struct device *host;
> -	int rc;
> +	int id, rc;
>  
>  	if (is_cxl_root(port))
>  		host = port->uport_dev;
> @@ -1139,29 +1141,41 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> -	    CXL_TARGET_STRLEN)
> +	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return ERR_PTR(id);
> +
> +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", id) >=
> +	    CXL_TARGET_STRLEN) {
> +		ida_free(&port->dport_ida, id);
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> -	if (!dport)
> +	if (!dport) {
> +		ida_free(&port->dport_ida, id);

Rather than sprinkle ida_free() throughout this function, just make
allocation do all the allocations in one go, something like:

static struct cxl_dport *cxl_alloc_dport(struct cxl_port *port, ...)
{
	struct cxl_dport *dport __free(kfree) = kzalloc(&port->dev, sizeof(*dport), GFP_KERNEL);

	if (!dport)
		return NULL;
	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
	if (id < 0)
		return NULL;
	
	dport->dport_dev = dport_dev;
	dport->port_id = port_id;
	dport->port = port;
	dport->id = id;

	return no_free_ptr(dport);
}

dport = cxl_alloc_dport(...)
if (!dport)
	return -ENOMEM;
rc = devm_add_action_or_reset(&port->dev, free_dport, dport);
if (rc)
	return rc;
