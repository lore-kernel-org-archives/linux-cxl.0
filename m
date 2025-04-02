Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55031519A7;
	Wed,  2 Apr 2025 22:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633328; cv=fail; b=dBSiyKxB0gFqjR4nVLcp37khV4jKbNvzRt0G82Z8PrXquTY/4owRaP7npauMoYjWLrlV/QSjUfVby5cimgF0UifzJq856O/BiURTQjVIlQqplztST4qdiUwxJ/vgCJ5RSRZfgoFYl40sW4xhLOTSvcd4x0n97GqvhvTrKaVokvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633328; c=relaxed/simple;
	bh=qDu3C9z2vMjXNmYM6uh1I6lN79pHKNTvq3AKTBZdBNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rIlMVb//rsBjshT7n6TwFs4Q4XLtoLfcTvfhHcowZL6cAigpiSj9bE1WR4Nmcc1HlAujeRaS/T9lVUGU72ZndXjsyyrKp5WThFo0GXRP3JuqwunGpJcgRJ1RWcTTPf4a49n/zWw/RSecX3D4WSAFKMm55A8nFNJaVXtrNKp48x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZ+nBfTe; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZ+nBfTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743633326; x=1775169326;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qDu3C9z2vMjXNmYM6uh1I6lN79pHKNTvq3AKTBZdBNA=;
  b=hZ+nBfTepwDAWyHM/766Myp522FD+kQmrhLo8fJ7Fee1/SLjcZ5Wq/KV
   MmLnwlyAoZXot7YNffx2jHS3FZEZZPtPWPnMOTN2vFvEW0m7Iad3uzqjt
   YD8KVrYSQ9a0ush7ZuxLvRzIvTZR67eYrJiOMRJu38pfyAY0HGogUKJoE
   4gFo84jjrffl3kSL27jN2SWUuUMaIlK2iqyK8kY6Xufo7Q9YJ+Yy2sdHu
   /n5atMaWIvPMpRzyxD73Zlm14TgWlolh/ZunqYvGp2kQLMAFg/qO/kwRz
   vMAJi9voo7TX7leF0zTZLB2m9aeSqWVkgx4oB9m/xIwaZThUDHeq0iZg+
   Q==;
X-CSE-ConnectionGUID: zD/4e6dgQJy3+QGCW61SIA==
X-CSE-MsgGUID: sBOTk1KrSIGJzGh75Mw2Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="56397372"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="56397372"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 15:35:25 -0700
X-CSE-ConnectionGUID: VOWvuEB2RwewDUxfE9PVpA==
X-CSE-MsgGUID: dL1ollpwQd+wxm8TAzRffA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="132035053"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 15:35:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 15:35:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 15:35:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 15:35:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVsDGWr/onMZfMm43NDuVIwpQCfCnE5KLGA/Z40zMyhWDXpfzPZghLa58/84D1g4WDnCbo1JhUx7+Rf0rsvv3DD+Uw/GX7zhhMGwOyoYM85c7oduMeNkFuSj1GhvmBzoXfWPHrryuf4taT1V70VPc6NdCQelh13ZV+sv9rFDq2lHY12yfpIPXWABd2GZLN+/3hsw9WAjm8IJX2L55A1PWgCybu4RUpUd/JdxZlzcdmAf4xKSAsLJzQKnBVMsnSA+7iGrsm3lMK7/SDEdBq12YsWk24nwyER+o9oic7PgTJp6DL5iWqW7babqlWxVOnAmq+pEYRaEd0qVPNE/hHy5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUB5dPaQ5ygnPxFbJxVdIKvG9sxSA6j13Vcy1D9kePE=;
 b=i5ScavDxEoP69KyqmUy7tBm41zkBkCRTOnVpsC6UDqrvPBqkeyoKt+VYfIYBPLVlpTGL0Z1mX3HEqhkTeV3xlI8sDtw+TGIw91dPB9VGbemqx7ejEQ/LupMEnjyg0q5oNejqfnB99Bjjz6U1EwWO21+x76WCmAqUAPa2eZX92u6ec8Nan4evbM2QKqziQ1lcVPzmCAAJfeSxIKBX0k4nhyK9JTb5y7Ovxk02X8UEZbeEk3PKvwpxWozPrIXgTeEgEPQTcmW/PYpu2MsAlghz5QJOzsd7/MBfdDrhg0+HjomplkOZnACUvkXNJPFLA8gvFFSu6NSj8p0lvtVoCT8KiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Wed, 2 Apr
 2025 22:35:22 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 22:35:21 +0000
Date: Wed, 2 Apr 2025 15:35:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: core/region - ignore interleave granularity when
 ways=1
Message-ID: <67edbba5e09df_1a6d92949@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250402193443.944654-1-gourry@gourry.net>
 <67edb335dea8c_1a6d929437@dwillia2-xfh.jf.intel.com.notmuch>
 <Z-27DR_D47HkuR-6@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z-27DR_D47HkuR-6@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e392c6-f894-4d45-0807-08dd7236a742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/eTTMptB8Sg42GzKn62gwJ3A0bbylAFzXOazgKjPVEoTIUuogG7c9s3MKVo8?=
 =?us-ascii?Q?bMPkDH4Uz84U7ljwoeENB5UWbm9aP0U3rVp8U1OAcKm/qdBd8kHyAJyFmUPB?=
 =?us-ascii?Q?C5Gr6CWjs1bZs8U1SMzaLPlLw1G95OV46I4CGg/bGb/cTrfnqNMr5NVd2L++?=
 =?us-ascii?Q?bM0rpb099KDjqZM3XoVaJ+Dm092cYhOI+FD1L4cMiSzt7FMDDu3O+jSqUetE?=
 =?us-ascii?Q?HbIIDwX18lss6VxExQ4fTV0yvXClFlUlnthVvJo4LYJaiV0kGywowtBzcEYl?=
 =?us-ascii?Q?BNsSa1g0atw1xz18axneTYXNNgPFyb61culSZk4xG36KDa71dMG/JQhnqKkO?=
 =?us-ascii?Q?7+Aj3LP8HSueiPCErG9hM6OlkGKZTvd9Gr3jf16aXYvCfSEGFb88gK0hDXSy?=
 =?us-ascii?Q?jlbUCwsZSaccdidn4X4Ak4vaZE3P2y3N0B/JZES8oUF55oMFGB1JWGOCEpAt?=
 =?us-ascii?Q?Q8WBK/Ndk/dA+p08om341xkItpnb6Blpfh5pAjKn0jejuqsCyLkUWKTSmlbj?=
 =?us-ascii?Q?aEZ8wo2FKSr6v7PHEM6Y3t6h4fIyv16GrbC0QkQSqXVhcAGC/L3YApcqVTT5?=
 =?us-ascii?Q?MgaJ3BBZQF5fTHCCkIE0p4TEtat2duAKsTxm5Pse53hZJzJETA6DzzlBZyam?=
 =?us-ascii?Q?7/clFa/OVMh6nA6PygJ9F9xVILwHcdB/0t+M+Mfd5BbMZ9T2LQzsxpdSC9KI?=
 =?us-ascii?Q?j5ZIwFRy1aRo6bgVRiqymsRsLkahmpK6eaVM6x2RPX622JrmHou/6FHZyxOf?=
 =?us-ascii?Q?BK/ZNuJOu/ovtoXUnGj/DJbW8F0WMSpu927W5xLl6DA9Q/ds76zdGDxCwYm8?=
 =?us-ascii?Q?zVfKTd259uAEQqm1I3jf/feCtltVEOmgTXvpixgZM/XXxbhTR6KBvLsqzzdU?=
 =?us-ascii?Q?PQCgXQsr2yh0mkiilhsi6/3ZJUyLiUSd7y4jJsFoIphXrYANH90GcBzcaxsL?=
 =?us-ascii?Q?rIWVpn4xDAVNt1PMaO7UH5jhOezfEOAdzwiUvZTanbK4draQjGWRhUw+8THT?=
 =?us-ascii?Q?K/M9+ocXPpkTVL1tt3Xsf2iMA0oX+fvCE8zJ3QmhD8Hv07GGoy2jIz1ICb0M?=
 =?us-ascii?Q?UsVL9Kk7i/iBBkLHkdGBG5kbstOeboGCSZHTSa1bJmNad9hZDJTqG7dVApl8?=
 =?us-ascii?Q?ufPXlurarGMLOomPQFCmg0T7IQApgeYGMJBPKhaIVxTtbg6PrSvO3Zuut5l1?=
 =?us-ascii?Q?DACHILTQhc0kFmurzSyvhXd98SCLmcvGwKV8K/OmCaQQ4YmWyVN8TLsO4NCM?=
 =?us-ascii?Q?rdbprnmVw53zGHDB+Ihm5Puu4+KL9QQkmfBk5zNPwKTRuBPz0nVwKK33Grqv?=
 =?us-ascii?Q?tkAFKBK2oEo7RUr4k0UERwGnOsUsoCvqZvkqakKyS4yrUnPGtqdheF1NnmGf?=
 =?us-ascii?Q?UUAIdtIXCpSJUPwD+Wuoz2ST8S78WqGyWe3zxnKHtd7OtSfCuLDAvFzZX6p0?=
 =?us-ascii?Q?OweWRzEMnaE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pm7vpfx1XItnNqKLZftBMYgR/tVBhygpm7Zizr9TilgQGPLteHgB6tJ4B5Fy?=
 =?us-ascii?Q?lyQsPZU2Hg3wJqZZcU8Dr9ciwoEvaLw6Ulu+jLLDxo/H81IagZZ5un7R59Qc?=
 =?us-ascii?Q?dFmSrgxnyVYUjVAs559D0ind6iNqkeWmjjBGqQlgv4Ioqs/aULrsZ7sF0LIZ?=
 =?us-ascii?Q?/75SHVu6Lc/56cRRjvoE7Wu6p4RCYcAA0ADWTcAtbhNsQqIfTXR062/NJhyi?=
 =?us-ascii?Q?mPv7HdLGfByG0N7ulyEJ9vWzl5kHW+8wV14keQutb1avfLpUgTFPeI1TRRsQ?=
 =?us-ascii?Q?pcSgReD8ImStAhAmegFwvdUQmDPxLFQkiFBkugdBkLCv7kXo82ww6FYJN+0W?=
 =?us-ascii?Q?Xjk6VxqUb3wXDLFWFPHj5//y9f8UxjSh3siiEJRAMlO0OA/thvBmJfNEaeVP?=
 =?us-ascii?Q?I3aC/eKZCe2WgGc0aQp0pNik0u+4MCac4NMTTbh+kCg3bt0wV8o1wbrGQmtf?=
 =?us-ascii?Q?qs9n0LVN/RjKMFYSz3lCMY/FPW8cpOTH5K5RHqiKgqhFagV+QTS9gB0W7ycd?=
 =?us-ascii?Q?V8fsomBtAaV4pl/rOnA/MH2Qg/t10HDIHL4xb8HBEiWUetO9dtSTDXRhTzHn?=
 =?us-ascii?Q?1vL9zFMg5oqaMf3mNoQiaSb3a9FyIZIteTM5ukyvD6JrQP66pKSyaQMl0+kp?=
 =?us-ascii?Q?wN+TQgeRucu9IlGN1DyD0BYoTEKnp5vhhUMh35ZPa3J4vTDQSPGUNiw1HJ7T?=
 =?us-ascii?Q?0Fy0X83ED0Vn18G9mwYyA/5iKsbj6JfzGvvLgYOhTU7p2EWlInxs45Y6Avth?=
 =?us-ascii?Q?hZnBR4jCo9qRInWq4N0vxfD9AhYEPtTRcLn/ln9tnMbC+ZUlVduNJv1NSmbi?=
 =?us-ascii?Q?yuup6OlyLfInVgRl39LBrKqIVtRZF5FwBLlhU7YUxZu6C6X0fES9vLKOiobL?=
 =?us-ascii?Q?FLH8asPGBO1UW7JObF328SL80rD9wdnobMzdk81I/TOcRb8R28lUB5Goh1Sg?=
 =?us-ascii?Q?57MA+tBVYVpEV4Eydz9z7x0w4bZop7tlsz4no4CGIW/1W0Qoo1MN/8Qr6WH2?=
 =?us-ascii?Q?trfbm7vYUCeMShko40kjaurJbkeoj69bwzUAYv2Y4ZVycEoZbQIUFwYIAGIK?=
 =?us-ascii?Q?UEmPelV/9IvdWqqLOaCoQDsC3jf6vzHgP583amab/Wp0OeBPN25YFYeD0hNz?=
 =?us-ascii?Q?Yueee7H5F6VAeNcz/F4WxTJX8ZtSVGHh/9VyMpGDOf9FjXDSBsvL2S7aEB68?=
 =?us-ascii?Q?yqo9d6vUpP9C6vjvsAIfnhXkpq6F2gDj4OG5TEQSU8b1ZTVBYbVBfgBxFm3i?=
 =?us-ascii?Q?L6y+Yu29/tL7PZM8ulvf+4gBmKYFS/o14fLKYyp8C6uqTlxLgfkzDLTCuIbn?=
 =?us-ascii?Q?Lynn9IiPCYsXbUvtP74+/aTSECE333aPjkHw0pwPo9JnlXCdXxvaWX7O4c71?=
 =?us-ascii?Q?rlBiVlUfis/sXFXhAf9fBuRqEETxT/GTwpy3bCd35zNFrL3nYU0fmod8dyiQ?=
 =?us-ascii?Q?J7tOpjbQ6plnIr+yLUJIQuO+8n/af/yMVw69P3876rjFEtoQo/ApekfjQoiK?=
 =?us-ascii?Q?sWIxkhiGPYbC9lBwdZ65tYVA2Iu37L4C508PR/giDRmFz2TXribp/349EUol?=
 =?us-ascii?Q?CxJW2e/UhxMrUwKdVONEdBV+enWMFoxdvsSUSPLd43aT6TEI1ja9Qr/7kqbL?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e392c6-f894-4d45-0807-08dd7236a742
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 22:35:21.8812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzEkWRpPjjwEQcSYpnLOUHw9NuzkFpQvtF/9m14jHvmq6WDzMOsE0OH+mgAOxPwnX/uBIjdXInpPi8ituyQYJ1qFeFQKHPnvtZ4ageygQU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Wed, Apr 02, 2025 at 02:59:17PM -0700, Dan Williams wrote:
> > Gregory Price wrote:
> > > When validating decoder IW/IG when setting up regions, the granularity
> > > is irrelevant when iw=1 - all accesses will always route to the only
> > > target anyway - so all ig values are "correct". Loosen the requirement
> > > that `ig = (parent_iw * parent_ig)` when iw=1.
> > 
> > Can you say a bit more here about the real world impact like we chatted
> > about on Discord? Something like:
> > 
> > ---
> > The platform BIOS on "platform-X" specifies a 512-byte
> > interleave-granularity CXL Window when 256-byte is expected. This leads
> > to Linux erroneously rejecting the region configuration of 2 devices
> > attached to an x1 host bridge.
> > ---
> > 
> > That way distros and platform-X folks can flag the importance of this fix.
> 
> Would like this inline or just in the changelog?

Changelog is fine, because this more about routing the fix than
explaining the code.
