Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215482E762C
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521906; cv=fail; b=XtIM3tLsTPIyADdkgaaYI+n6XOXDSmJysBp7r0OUYUy9Ervg1IsQtQvpDQgTUVCnLvze2Ml1WnJXNPzOH1Xkcn1tfj5GZLFJ+PX1i5y3UwVdOFvBOJCME1uApVkWfB0mu9pSHeuw3R+grSEktNzYjZJzOz2z4WcLXZAo9Pmuag0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521906; c=relaxed/simple;
	bh=0saN0y09vNcVZftVK9boXTkcja+qP3VsKrkckEFRrz4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lLbp5U7g7cuOXfnwZEiuoP1D6L6cDgql5M/PwD+FP50Ycf3qWEz+eOnBTYr6ENFOU8AtbPAt4DiVHno8wevfpARJlwE9t/ounwun5HBFJwKYYy0jS02XkfVzAQZdAczps10siNDvT52cbShzIuWhIaqQQ0p9oPXLGGQHDICAcBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij6fIndN; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij6fIndN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789521906; x=1821057906;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0saN0y09vNcVZftVK9boXTkcja+qP3VsKrkckEFRrz4=;
  b=Ij6fIndNnz+dc4+cyQTxkEwU+i1B1+7AGVBUZUtRkC/q7kgC/4gFM7np
   TbGGU64cXXKQHgeaNP8XM7sh/o3K+Ak0wGJqa2GfDBsgfTkfZ2COP15tq
   Whcyf+A6uSR11zSjNpdPRH6l6DRuxdjvvkI/lQRt6UyM1QsCOvYtiFZ1N
   QqNPNa8QL+D4G2FR71u0rtVUj+K2w8ejOMc8X+R4U02IYV+78izM8tIZ0
   ++9BOTvigd66LwM1xCN/CdLPoZf0DhbaUVjYSAYEUZe2kqklb032IEE9m
   BCvskeukIKNeCmwZM5qBie1sj/9jSPJogXleZuVSD7gpANdiHajjzc7Rd
   A==;
X-CSE-ConnectionGUID: 9Sv149v/SHWf/oebrZ7e6A==
X-CSE-MsgGUID: d6gTTHrhSIu/FnQwMT/p7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89739371"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89739371"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:25:05 -0700
X-CSE-ConnectionGUID: mMpHkBu+RfCraGqVz8xsDQ==
X-CSE-MsgGUID: bUQOeEu+S5SW5A6v7Dp5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276708549"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 18:25:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:25:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 18:25:04 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 18:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gT99RxsFW+JBenaox8pX8yb1D1Dfuni6HskXmLhTUcJajAIav7bNZv5rT+g8V26Gemp4G6dLr3yG1+oSRVN7+FcNNVzshNl56b15KUMybKszNn6QrUEkZie/e0CPcKIeh7alvKmaqNF13e1XbzUiisXgoscVdyHl2br7DI1k+G0NmclYNxgURuI4eLe8A2mVGVNXB3xCUJdffeqzh3JZdkG2x6l6Ygd40sK0+XrERqwsRsZUpmX7x54GjrKJOTsCqMS1OzZstQHGCGBg/8DdltopUfDvSwOsX+j5qhrj26ajwz7yFYRc4db5zgFCHRvO5BCIWJtBxOKsPrx89PSMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah4FBeXOZo5uTv59ZniKLysVOgN3PfRwC/gMS0Vh+gU=;
 b=vpn6u+TvrQeND9yJr/czw/WwbowdKHVVhLOTrihMhd1q2p6vJB3+zAj7HFWY1YfYmDU2jyQaqAx4oYO1jmK1e9aB89rfg/KgXxu2eh2Ua/UJpCXscJHqH52SLHWYOFqoWSpuxgmqhq7q4kqu5UVxZTtoR8jfOAtLb+p1mBmPCdV2tRXfUkFV92icWvOTU3l+BpwdfyFi/XnhmMiE1+59xz4KCOJpMQxRHgkya3bwSyjHfRIKfslaVEZuyUCd9FYB7B3c+JnjL2r95RWJz1eAB7UIPQLtT7XovXWsIR9cH66efkXby7Gp5S9ivlZPFwNN+2DSvwnYI0lDgZYnpsc9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by LV0PR11MB9864.namprd11.prod.outlook.com (2603:10b6:408:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 01:24:47 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:24:47 +0000
Date: Tue, 15 Sep 2026 18:24:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<gourry@gourry.net>, <icheng@nvidia.com>, <ming.li@zohomail.com>,
	<vishal.l.verma@intel.com>, <dave@stgolabs.net>, <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
	<wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
	<habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 1/8] cxl/mbox: Flag support for Dynamic
 Capacity Devices (DCD)
Message-ID: <aqnv2mM1DB2kaLuH@aschofie-mobl2.lan>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-3-anisa.su@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-3-anisa.su@samsung.com>
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|LV0PR11MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfa59b7-520c-477d-c0a8-08df13914b70
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|4143699003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: EY3w9T1w+c0HIIW7VEF/b422AndyhJDXUGzRLrcsqlJVPCNr5mPrdC9jBQH3yUlZEjSSzX4Cujb1Ze6iSoy39nC4YH8G2Feqi6sfLGZIG6NozXiBpjcI4Ru65wVW4HQZeJcx4spGUlo5d5KB8e47dseD7QAo9/XdK/CKy5e57T0xbfiagLTh/qCId2wbIrVE19tXU8o78YhvgpHqclUtB4W+tOrYqNIkk+UsYysU8KLEV94fydaMAIHijjN5Zq8bPGuJRBbSlXuR/1GMgIAYEOAHsA2I4zs4Bcks0rpDRfG/M4R4URS7GDY58w/xcA7+M39N0cBivAQBeeRaXSS4IUt/hwWmd294HR7iTycyNQn3J2Ymao625OLQtqtbcvaptOmXJ1YG5+JnRcpyuExzw3uJw63JqK3kSnnf6O3BWw142GZaJt0H8g3YlkYksDAnhhKZhzonAc5EVbLNC1VW9P4egwi2vpYcPitZ6MmEFfwyRc4AatlSagA2uI6L7aeUsAQ3/rrhHX3qZPUgvXqb2J0arZsLhMvpZ44cH3lS8wA3DBjq5ou7XesvE34qpwLig9vuyATcm0qcgXFpOhdOa1HpXieEWpvMyLv1h+Y0BhsZ36U57C/z/IV50izdcqpOxeuNPqdwLFlju6sOzOMJEs83WcTfWcKCTlwqsFen7n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSWKMy0ZQfAMEOGpPxz6FqCp3EeLSUc0yCM01pt4Kzbg7CTh4mCTvmo4GPgN?=
 =?us-ascii?Q?GrCKTBAgCsr/M+WaEBhZzS5uXAYky96ulciDyB2zIKLRP0fAtEF8DaZkHuh3?=
 =?us-ascii?Q?n5p2xNzfFVB2/+/BDm6jAaVApY15je5aGg6wpO2C0D4oJBG+c3y9V2A2PE8T?=
 =?us-ascii?Q?5PelWF/D5MaBFIRWagugG/CHWTxj5srvx2f5Aw0lXq6wiiw38sVr3O1KJYQ4?=
 =?us-ascii?Q?MvLgvhe1JQix/huPZZS3ovsAvl0X2zFOcjAgvcXMQKgDQzmTd7v4wQEA9S1F?=
 =?us-ascii?Q?4Kjdzqbi79LEf2mJRg2H+2uSGJIdn62qO23iAnv9SjCHKUGLLa1PDGOXn/1y?=
 =?us-ascii?Q?EXZ/tEbz8so07Q2c3a2282m/mo4hedu9m3JD9yC7DRJe5idtSocxYgBqgBTE?=
 =?us-ascii?Q?otzpVLeqraSgBqK4MCin4bM/LgVNK8fovul1p8oCaamNoR0ha1Ww/nSuCbNe?=
 =?us-ascii?Q?WGz1VhjWzXMZQBOy5XKFSiJSZuB+YZCy4WxrooK78+HhL+EiVjXnBu7Rcerm?=
 =?us-ascii?Q?2WZ3opnLnriXxD9SLudqiMzyegQ1RpyY14aSGnvUOQcUVLvpiTEFBPfsr44V?=
 =?us-ascii?Q?PDkwJVRvKroBg8dZKOCM8hZHk3ntPxBx//Hg6RSNBADi5LdZBwpE4R2+L/Sy?=
 =?us-ascii?Q?6yr4xlGA8cZTvh7bquriJnalg3go80BsdNrh1mXSerW62f2ClQywwIACGC9p?=
 =?us-ascii?Q?dGYsM1QSRpIDR/ipxU7PYmE8J16INLeiDULycYqWPVRtuGFmQuFd/jpB6cxS?=
 =?us-ascii?Q?+i51cJ/dTQ2abPjRL6C8oB53AD5AxKqJFMUFrHib2xTVS2Rf3IL3c3v3Gixr?=
 =?us-ascii?Q?ekn6Rh417AUQ11DQDLuc22QTOON/srgxj6g57dlO/bAbDnU9goyKWov97quU?=
 =?us-ascii?Q?HVjs0GNRwD+kM4TcPxyOOzfSeNlLu3UvZ3WXNRHjR8P03Lv3pSEWDugdgxvf?=
 =?us-ascii?Q?OzZh7sfxHh2B9/IqbX+BD4RfsxCnxS/er2XU7lBd52yTboQdcMYErILQGwzC?=
 =?us-ascii?Q?UU+vURnyQvZRztnC0hYO+Ymfn7bTbj3TkTGDhp5yDyWHQoh1V9FpDiDoz8sY?=
 =?us-ascii?Q?aDrLwJhv9/eWgdFN+hWvvLfGn76VhBktBGqdfZGrAh/tJrRO5e6osTosBRdg?=
 =?us-ascii?Q?SKFBq0NfS1Gf0IK6odHEMY5JzyfMIYn1b9/DfTwOPTCaWUi8PvDHKVJDXr6H?=
 =?us-ascii?Q?Y1gpgmwa3WHoolv08DBn1t8SU6lXlD3dEwkbwjJS9i3VOqiH8ishiUo69Fu/?=
 =?us-ascii?Q?oW1DkhDmymt+ofLqX04JuAZW9mlHBaA6BwaN/Bkni0wxc2SmU75Q2w67kq7E?=
 =?us-ascii?Q?iWFTMUz1LpBL6xONCX4Y6jrlzZxEBw5IBgWp0nHKW6bv8N1EwaQsAlisp3zQ?=
 =?us-ascii?Q?zBBabgNLxeCQmOUUtOGV0KMDDEi5tChnzu89KZv34gkJalnKao2Rje4jWnIb?=
 =?us-ascii?Q?m+ax2DWuO0PBHY8nOwOMeSMtB1eO06phf4r7/G0o/BlO3/06xsLD8Wjk1vuP?=
 =?us-ascii?Q?SmoGePkRFA1ShdmL2WxYxqrlnbnXFhneFOaeyK/JLMn0WKqeoSMK+U+iz9Dg?=
 =?us-ascii?Q?Einsm7EF4bPgFCPk6F2rEqhn8SUea/Mm4U0mKmskKqbEOZ0u+fwPnIxCjPPX?=
 =?us-ascii?Q?RC6KMdMZEsI6DX2449UNJdc3EHjdwU8yMQBAibOaGu4WvDvlFQw6lzOzbv3z?=
 =?us-ascii?Q?Wg03SKuKIAumbrtV8O54rqK0AuiRRz3y9C0v8dyyjvxiVnFIFAg/BAy9Of2m?=
 =?us-ascii?Q?PpAjTpU+LtVUcxFaiquRDHIzRC04d4w=3D?=
X-Exchange-RoutingPolicyChecked: K/I1moua+6m9LwirFMI3bK7DDUY9UOwAfivAKuhrkPYus2pcXZRaRNnPEKvds9xJg/I4QGnKpWrr/3QUr0MwaQC1nF00xoajUl4EWQvlo5NwTLAe/sMM6FXtUoFROsynfU8VRzkRp1W/qffQW6yxH8kzH223trNKbmgkiw+l+AJs6PGd27EQ+FIlOtinito8ok8Hs5ZjFo7kW/HV7R7AfZNRbmfac9RNnS/7gH0ki3n2CjIS0qXLcx9hDQvGhWm+kUFmgXFPTZBg3QKEqjdeFhpt2oDuBI5wPSC+T1vGBT1bGj5blBBgTjOykQ4KDqkK9x696mKqkFcR9tqgBEcIPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfa59b7-520c-477d-c0a8-08df13914b70
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 01:24:46.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdqyL/0kxz1AwbN1OkAeREGNr4t5FgS2ZilFZnibwlIIAeRHSYQIoTNXEUOHn1u6Y0zLzBBHvRu49wqDFh+U4Q79aT1e93EnHq91F6Nm/SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9864
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 03:15:05AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Per the CXL 4.0 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
> 
> Detect support for the DCD commands while reading the CEL, including:
> 
> 	Get DC Config
> 	Get DC Extent List
> 	Add DC Response
> 	Release DC
> 
> Leave mds->dcd_supported false. Dynamic capacity is only usable once
> the driver can handle Add and Release Capacity events. Detect and log
> the capability here and let the commit which adds DCD event handling set
> the flag.

I see my v12 bitmap issue addressed, thanks -

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> ---
> Changes:
> 1. Commit message: explain why mds->dcd_supported is left
>    false and when it's re-enabled in the commit message.
> 
> 2. mbox.c: drop the single use cxl_verify_dcd_cmds() helper and test
>    bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX) directly. Reported by
>    Alison Schofield.
> ---
>  drivers/cxl/core/mbox.c | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 20 ++++++++++++++++++++
>  2 files changed, 59 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01..199bb986d674 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -171,6 +171,33 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
>  	}
>  }
>  
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48
> +
> +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> +}
> +
> +static void cxl_set_dcd_cmd_enabled(u16 opcode, unsigned long *cmd_mask)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, cmd_mask);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, cmd_mask);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static bool cxl_is_poison_command(u16 opcode)
>  {
>  #define CXL_MBOX_OP_POISON_CMDS 0x43
> @@ -759,6 +786,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_cel_entry *cel_entry;
>  	const int cel_entries = size / sizeof(*cel_entry);
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
>  	struct device *dev = mds->cxlds.dev;
>  	int i, ro_cmds = 0, wr_cmds = 0;
>  
> @@ -787,11 +815,22 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  			enabled++;
>  		}
>  
> +		if (cxl_is_dcd_command(opcode)) {
> +			cxl_set_dcd_cmd_enabled(opcode, dcd_cmds);
> +			enabled++;
> +		}
> +
>  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
>  			enabled ? "enabled" : "unsupported by driver");
>  	}
>  
>  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
> +	/*
> +	 * Disabled until event handling implemented.
> +	 */
> +	if (bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX))
> +		dev_dbg(dev, "Device supports DCD; capability disabled\n");
> +	mds->dcd_supported = false;
>  }
>  
>  static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..0c8e23276dc6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -252,6 +252,20 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/*
> + * CXL r4.0 Section 8.2.10.9 - Memory Device Command Sets. See Table 8-308.
> + *
> + * The 48h Command Set (Opcodes 4800h - 4803h) defines the device-enabled DCD
> + * commands.
> + */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
>  /* Device enabled poison commands */
>  enum poison_cmd_enabled_bits {
>  	CXL_POISON_ENABLED_LIST,
> @@ -427,6 +441,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @partition_align_bytes: alignment size for partition-able capacity
>   * @active_volatile_bytes: sum of hard + soft volatile
>   * @active_persistent_bytes: sum of hard + soft persistent
> + * @dcd_supported: all DCD commands are supported
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -445,6 +460,7 @@ struct cxl_memdev_state {
>  	u64 partition_align_bytes;
>  	u64 active_volatile_bytes;
>  	u64 active_persistent_bytes;
> +	bool dcd_supported;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> @@ -505,6 +521,10 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> -- 
> 2.43.0
> 
