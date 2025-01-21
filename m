Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E85918AE2
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737498528; cv=fail; b=omc5XchXqsp/9pz1TUbOcPvuWIs/laLeSoaGpYMgGiVHDqUciswIrlj8jfC//WKJpJ1kgXN/eiUdO0eTxiPUBuag98tjQgMGNJxjVCIWe9etal/BzT+woZ/smrNLxFm15IZj58Y9qvu3M9R8XSVCnm6T8Msrer8F0JItagabFj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737498528; c=relaxed/simple;
	bh=8qINW+cmfOsTTBB4M2OtocLqq6Q4N1tuaGqkX5hcX6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bc9WVzI+RCCzclMhxtOgdGx3xtAVeXa/h7S/pDQ8DMkXR5DG1AlP0WxFTV1CrdmIqiPk/sKCIWjK4WjsqlT37drhmInr/7T21MOH6/pySp3/B1YaEg+/gv/CLW+NT7R9tOYFWzDIEyoWYRRCAUMfj0VH8PzZx7JcqXAxIZYpKN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGUE1I78; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGUE1I78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737498525; x=1769034525;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8qINW+cmfOsTTBB4M2OtocLqq6Q4N1tuaGqkX5hcX6c=;
  b=XGUE1I78PoS9GdYP8naZH5tOkRHQHR2pu9Kqm7Wy6OkZxQo921H0lcVw
   5wx1JQ7nMsA2WHXVkeesG1bDIOoWAnJrFCFTfxGxT6qxuvgFEXKVEa6jo
   Tnv9P9rTiJUY0oJXwep/Qu+qp11MQjiJOamtrVKeZQX/3EbKdon0Gn+bA
   EeVWpi+DiS/a9katpMnDfVpdd+LR+Obvbdfc18oRxVoMRuUH2EfyTDPiH
   1JyLqCtrNbcrY4FiUWqIJLZSqiy5uXYzBlyhSyNo53mJNrLcSRO3k04nQ
   fX8X0ckkcaNDlPGgj7A1D6TmeZgqEYRHMPi97LlVX811ynwuMmAjDRQjy
   w==;
X-CSE-ConnectionGUID: H1b5Jjy2Ro2BT0BO4M8lRw==
X-CSE-MsgGUID: 3UmfUhUdTcupOZgfwIVQJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37821912"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="37821912"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 14:28:45 -0800
X-CSE-ConnectionGUID: k6jxxSA/RRyZtGpbqhIOOQ==
X-CSE-MsgGUID: lAbkNhGoQFGoQtnP8+EHOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="106731453"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 14:28:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 14:28:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 14:28:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 14:28:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLbungFIxgAs+2ZhOIrp8f4EAKdzai8CYvaI/wK2k1IEgEDHT2ZsiOTk/Jf3PJcC7p9ElKzCGHIuuprwyNE0S/StkwzJJnmSweV6Xgv2yuSj59rbP6/gOVzo9LIg9bcY8L8du+rBxDujb+qSO13wrszAoBmh1plZgJynLNvTADD7enmfKxWj/nn3xeu0evD7roGjUP4wFBVzhDt86wkXTVUpQClVqi4pbmsAKA0AkbJ6TVBhN+RXjSFA3Q21uj6j8tgMonSMLBtWTFrYVL2KRePAVGv9vfetFQ1/96RnVL3PlgjFTqrv+I5qOKx60U/a5fL/gObXM53v6vT/AYAP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MR4AO/ZFK020lj0CsaJdvNdMskeIvMHuOJ+KCxAYhk=;
 b=ttgoEOCEig3WjtLzCD224Q5+hMTAthaIo7XY6mL31lxxALsRYmNN66TQQQvqAkKxXVNCa71Rkled50xR0clCVyS/kny1zgYw3x5ZHqywVjGVHG0yEXiXHzoIzyZfqCY/uZIah/iVt7XjSLlBO1xhtzv+CqFyuui90+nuh1IaBKjQOq1KczjjbJH7l48Jy2r8fGrq2YpOOJ+VMI5fHES5Zvk9BIAeVCI6AcHb3HU40kHOwDHusohowtjG1modN47FUfjEvWNYI6kcyppD28ZB7df/vampWZX0Wx5ZhBaPOL+gRzs9rOlflk9e3YeOM9mBAtplHl8PlD/BVMdXj+wVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 22:28:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 22:28:42 +0000
Date: Tue, 21 Jan 2025 14:28:39 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>,
	<hch@infradead.org>, <a.manzanares@samsung.com>, <fan.ni@samsung.com>,
	<anisa.su@samsung.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <67901f97e604d_20fa29489@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250121042531.776377-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250121042531.776377-1-dave@stgolabs.net>
X-ClientProxiedBy: MW4PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:303:b9::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: b70391c5-1df3-4f4d-5c79-08dd3a6af603
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k2K6C2tbS/TLrLKTBrLQYmOeZw5EAjZh83jdA0YKtgyz99gCpu06FZI3L4YT?=
 =?us-ascii?Q?RDTojSB5/uZ0IIY8Chmt3x2O+kVk/OnlqpM3b9P3VvbiBn9UBMq7bBL3R8xg?=
 =?us-ascii?Q?HGEkuB3iJcbwZiLg84pEHG0LnJMaxdFMMt2HqQNJarOTDDTFFx0T/3FlbNXd?=
 =?us-ascii?Q?Iz5ImCD7z/WY7CKqXuJg+qC+qgwmNtSfoBVkMttlf5dBNcRSDklq4gH2lTaq?=
 =?us-ascii?Q?uTbykSGJUyKDqgUYOU3JhzV8Ocl8ZlpRtgawgljT7awaMNI7nBvuyiGwfuCP?=
 =?us-ascii?Q?sAE2XHuISJVm/7dl3AYtIuawtEwng5GubFJNCUkxpHuGWb/rx3qOcGfATiDO?=
 =?us-ascii?Q?ZKMfNTdaEBIZDGujv4VtIV0H6yjnNFh0+fbLl2tIuH7fXMll7yjmgPVEfY/4?=
 =?us-ascii?Q?bD/wF7NUOG8ylndSi8Jm5quQlZjOtLPUaEbDyPLu8OHbKnyoJJok3Lr5HPeo?=
 =?us-ascii?Q?YfF1zaLynDlivIKR7NrURYgbPkdtxKu0Zaezg0v/rDHWkw7vC6xnIjSbdo6n?=
 =?us-ascii?Q?T/XduOsYHbeqNJyuwbBtIrjnamBl8qikgKh5kR94RMpEBm51RkOk8V4A+7Rw?=
 =?us-ascii?Q?wDdOAPOJn7dBXWfNHkuOBX8OEdii65pQYXQPDZPiNiNQ7R9fumhBqWuVrND8?=
 =?us-ascii?Q?+PGbeMln8KzbPPiIkMOW2QpEfmvCLyJQMrzQJy6aAcUbjs2aHTAHL28jWVIK?=
 =?us-ascii?Q?9Z3rcTAGggd6zWBPNL6Jc038Jp0bb9b8gf2hyJey5dg6QpxGjL0BidGUTRCR?=
 =?us-ascii?Q?KDMhQJA79kymwijTS6m6UPJeRIQhe0Vkw2hjyetErk5f6LcH7CP0Oj5agSLo?=
 =?us-ascii?Q?1zBKmik4sOZmDuycy9pfBjyO6SI4VMj8TpIlMgci5DY6h9tcuOdqroSoOYaW?=
 =?us-ascii?Q?j6xk1KgMc6raWRtMZJH7XWU61tITliGfTh1tJfa1ONTQw+OZPRuDbOmDUy2e?=
 =?us-ascii?Q?+LmCpiJ7fUOeLgi6tuiPgoMbC8uk9nJdze8yi2G0fXeD660SWGclvy64gIk6?=
 =?us-ascii?Q?EKOIE8ECZkQWDFrP2HpLSAkyPP2Iaf4anF34dflBJnQZ6mKW88oky6h+cJzp?=
 =?us-ascii?Q?jBrIiP650GTmS0WX6y94PWjr5iq8VOYUNSoc7yLcpcoSCTpObDgXq+Kerti2?=
 =?us-ascii?Q?4sYODaNpdeq1kI3WGUbe0Y1dnwNLa+naGrBZwLupgpg46XpzbxaYPHg+gwnL?=
 =?us-ascii?Q?e4Pu5ZbCVQzbfWn8vFeF1UjoA9fO0xmRNGt2bJ4DebTHn4rKwMJi4zPKri8k?=
 =?us-ascii?Q?1NPHxz6RQnPWy2JRRwVOcqli4kp8tdW359nAjlstx+8kZCqJUDJ11EC3wlGO?=
 =?us-ascii?Q?YzLoW4VrnhtdhLfvunhD9waVlkfMNIjt+zueW7vmRbLkuhUWNpx7YsyvhYzY?=
 =?us-ascii?Q?RXZFGnmN0Ty9OgOaoM56uKJbpgAX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVxI0gF078WAs4GY4AaVV28exAUVqEJ6F9uNriwz+XJuU4FoBtW7Gd92Q7X7?=
 =?us-ascii?Q?F6SedOIZDHz7gSJtfCZsMUvXHf0Q8mi+mFfVqM9O587wtnQRU+s9SBLfPsO7?=
 =?us-ascii?Q?+Q4oBQqbMgkrvRREal7bkcZ1SKc1xnhAxLg0WyXek/N0P3D7GdbhmySF88Am?=
 =?us-ascii?Q?18OUErm6aflzKXp405MeO+6Z7dYy3HJz8m1PrsbbKr1HQ0bZopBoLhmu4mBn?=
 =?us-ascii?Q?YcoRPyW0Xgkqsl+SmnFwXI5LN8/EQfahBnCfkR+D1vfwowHSDUi43DNAPyI+?=
 =?us-ascii?Q?F4fDtaT/asgpdMKCxd+U4/zm0oThiP9qbE2JeRR0FwS9WcToXusa6z39Gk+F?=
 =?us-ascii?Q?TUUsv3pYF8BKge9ETPZzakhCjIbJ55HD8eHcfs9l+fr7wjI46rsKa5pFTDtE?=
 =?us-ascii?Q?lkR2NCtFJ1VrBp949GGI0JtOtZVd8uxhq8XkLJZTpmb5d0yjd9VbnTLd0AwU?=
 =?us-ascii?Q?bqincO/DXMS4f/QoGRbY7mvDW7Nnfph2tBnQlnF4ZiTlNfMz3laE9Pf1O/0E?=
 =?us-ascii?Q?tx6ajePH8X/Ls6jOa2ErXgrvakyHqP8CjzNEUbKlU2e0WYtFbP0vy8xARaDL?=
 =?us-ascii?Q?LfDi6ZzIKyrvEd8PZWu49MCWs8S7u/knqAJK1VGybo4SfoTHNb8rfEeru4t7?=
 =?us-ascii?Q?KWxRkMv/J5K43f046S/eM3jDEO8/IZ4IjQKUTHEJXal79nc+l9jtIJsDpX7B?=
 =?us-ascii?Q?+RuqYEL+SIe7o2WZ4feOPQuV786g1av283m6XxHghMogQUICeSHAhmmABCgR?=
 =?us-ascii?Q?arAvBnNU8C3p8SXWK8wtoh35LEKwS4SIbgY73GM3LxYmas8FFUuWtYex2jBx?=
 =?us-ascii?Q?4rjKm8jJkLcReT7WNYESD4f+Ydd5w8hjkBzWeaG93VdRu+eEBoiwdeMD0bDH?=
 =?us-ascii?Q?0pcbrpusxp6Cc9h8kfk6oKDtjvAv5QqF/mkRgIXRrjFOUjfIfZUuGAPNgXx9?=
 =?us-ascii?Q?9pVwvtknrydEZzHIvxQJ79PXg5K9LcgFGWknqXvJPT2mvn1CwkDUvSJ1e87r?=
 =?us-ascii?Q?ArA8WblCR8aArBLlZNrdCpVjSNhfVAAKGH0sSlqlKw6XRzIUBMt9Z7KFgHm3?=
 =?us-ascii?Q?Av6ECYai/Cv4y+8Jaqx/kBlWyWxWYD9O3zU0TjRiSm9TQaXvIsxGQbl84ArR?=
 =?us-ascii?Q?ixe22w7NCKRcUUxTQsSx3oqQ/maiPq7qNg55hkrzRn1Klto72wKlo3XRhZe4?=
 =?us-ascii?Q?YXc0S7U5k2TxW6Pg1v2rkWip+zsejC/jAq35wxP6hvesyO6LPHuZm+0y36YO?=
 =?us-ascii?Q?hcqG4iBtKPgrYB0pMtDW5+qV9JY1X3mHkafHAvTfM4eFQTeOEKcsNjLT0LtM?=
 =?us-ascii?Q?Vd/TNPRHEBdbs9WCAj2KPI6rLaSl3Wr3IWTEl5cTFpFVEAro6wupuzzRiWVp?=
 =?us-ascii?Q?0qyK0ggdT1rhbvViy64q0ZHM4rM9fQHGILZOve0aLUxql2geILiYjx59bofX?=
 =?us-ascii?Q?WsqiS1tiCHKq3DelXfxDD6cgHP1fOcO/BGLwQXYPaBaItjPdp9HRZ51jVK0T?=
 =?us-ascii?Q?G0mzUlRwqPcLt/iWTY8w0byJeJlXK1jRjn9ERhWHFCR6Qw3NP8emNmz4r4zC?=
 =?us-ascii?Q?dHLZuztv1+CmARzfF93Lh69cFPEjdb1QuShu2B6sK5r2h+pE9Z3StfLE6ope?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b70391c5-1df3-4f4d-5c79-08dd3a6af603
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 22:28:42.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eUbFgDcAfsJr8y53XnSpWlP4FAnEZGL5uDzQ7zSu3x/NrKQaToZA2xS1gy7+rvVUdfJjCOOI4iMY5fASQ5Zj535m79SWUqD6fIuuDAQdXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Add support for GPF flows. It is found that the CXL specification
> around this to be a bit too involved from the driver side. And while
> this should really all handled by the hardware, this patch takes
> things with a grain of salt.
> 
> Upon respective port enumeration, both phase timeouts are set to
> a max of 20 seconds, which is the NMI watchdog default for lockup
> detection. The premise is that the kernel does not have enough
> information to set anything better than a max across the board
> and hope devices finish their GPF flows within the platform energy
> budget.
> 
> Timeout detection is based on dirty Shutdown semantics. The driver
> will mark it as dirty, expecting that the device clear it upon a
> successful GPF event. The admin may consult the device Health and
> check the dirty shutdown counter to see if there was a problem
> with data integrity.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Changes from v2:
>  - Remove RFC tag.
>  - Setup T2MAX to 20 secs, just like T1 (Dan).
>    This simplifies the patch significantly: 1) no longer need to 
>    update upon hot-removal, 2) don't need the device max timeouts. 
>  - Configure dvsec at port enumeration time, not pci_probe (Dan).
>  - Skip RCH.
>  - Cosmetic cleanups (Jonathan)

Overall looks good, but I do have a non-trivial comment at the bottom
that may require another patch spin.

>  Documentation/driver-api/cxl/maturity-map.rst |  2 +-
>  drivers/cxl/core/mbox.c                       | 18 ++++
>  drivers/cxl/core/pci.c                        | 83 +++++++++++++++++++
>  drivers/cxl/core/port.c                       |  2 +
>  drivers/cxl/cxl.h                             |  2 +
>  drivers/cxl/cxlmem.h                          |  5 ++
>  drivers/cxl/cxlpci.h                          | 15 ++++
>  drivers/cxl/pci.c                             | 21 +++--
>  8 files changed, 138 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> index df8e2ac2a320..99dd2c841e69 100644
> --- a/Documentation/driver-api/cxl/maturity-map.rst
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -130,7 +130,7 @@ Mailbox commands
>  * [0] Switch CCI
>  * [3] Timestamp
>  * [1] PMEM labels
> -* [0] PMEM GPF / Dirty Shutdown
> +* [1] PMEM GPF / Dirty Shutdown
>  * [0] Scan Media
>  
>  PMU
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..6b023e81832a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1308,6 +1308,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
>  
> +int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mbox_set_shutdown_state in = {
> +		.state = 1
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_SET_SHUTDOWN_STATE,
> +		.size_in = sizeof(in),
> +		.payload_in = &in,
> +	};
> +
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dirty_shutdown_state, "CXL");
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b3aac9964e0d..d2867ea18448 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1054,3 +1054,86 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +/*
> + * Set max timeout such that vendors will optimize GPF flow to avoid

Maybe:

s/vendors/platforms/

...since it is a concern across a given collection of endpoints, a host,
and its flush energy source?

> + * the implied worst-case scenario delays. On a sane platform, all
> + * devices should always complete GPF within the energy budget of
> + * the GPF flow. The kernel does not have enough information to pick
> + * anything better than "maximize timeouts and hope it works".
> + *
> + * A misbehaving device could block forward progress of GPF for all
> + * the other devices, exhausting the energy budget of the platform.
> + * However, the spec seems to assume that moving on from slow to respond
> + * devices is a virtue. It is not possible to know that, in actuality,
> + * the slow to respond device is *the* most critical device in the
> + * system to wait.
> + */
> +#define GPF_TIMEOUT_BASE_MAX 2
> +#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
> +
> +static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
> +{
> +	u16 ctrl;
> +	int rc, offset, base, scale;
> +
> +	switch (phase) {
> +	case 1:
> +		offset = CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET;
> +		base = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK;
> +		scale = CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK;
> +		break;
> +	case 2:
> +		offset = CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET;
> +		base = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK;
> +		scale = CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
> +	if (rc)
> +		return rc;
> +
> +	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
> +	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
> +		return rc;
> +
> +	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
> +	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
> +
> +	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
> +	if (!rc)
> +		dev_dbg(&pdev->dev, "Port GPF phase %d timeout: %d0 secs\n",
> +			phase, GPF_TIMEOUT_BASE_MAX);
> +
> +	return rc;
> +}
> +
> +int cxl_setup_gpf_port(struct device *dport_dev)
> +{
> +	int dvsec;
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(dport_dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(dport_dev);
> +
> +	if (is_cxl_restricted(pdev))
> +		return 0;

Given this is called from devm_cxl_enumerate_ports() after it is already
clear that @dport_dev is in a VH topology, no need to worry about
RCH/RCD details here.

> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PORT_GPF);

I think this ok for now, but perhaps this should be enumerated once
per-port and cached in 'struct cxl_port', otherwise this can potentially
be called multiple times for shared ports in deeper VH topologies.

> +	if (!dvsec) {
> +		dev_warn(&pdev->dev, "Port GPF DVSEC not present\n");

Could be pci_warn() to use @pdev directly.

> +		return -EINVAL;
> +	}
> +
> +	update_gpf_port_dvsec(pdev, dvsec, 1);
> +	update_gpf_port_dvsec(pdev, dvsec, 2);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_setup_gpf_port, "CXL");

Drop this export. There is no caller outside of the CXL core itself, and
the fact that this assumes being called from a certain point in
devm_cxl_enumerate_ports() means that it is only a helper, not library
call for other drivers.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 78a5c2c25982..1ad6d2e05f09 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1653,6 +1653,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
>  			dev_name(iter), dev_name(dport_dev),
>  			dev_name(uport_dev));
> +
> +		cxl_setup_gpf_port(dport_dev);
>  		struct cxl_port *port __free(put_cxl_port) =
>  			find_cxl_port(dport_dev, &dport);
>  		if (port) {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index fdac3ddb8635..c80c2300dee7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -912,6 +912,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_setup_gpf_port(struct device *dport_dev);

This can move to drivers/cxl/core/core.h

> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..a085374d52d3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -693,6 +693,10 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +struct cxl_mbox_set_shutdown_state {
> +	u8 state;
> +} __packed;
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -829,6 +833,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> +int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 4da07727ab9c..9b229e3b9a9d 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -40,6 +40,12 @@
>  
>  /* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
>  #define CXL_DVSEC_PORT_GPF					4
> +#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
> +#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
> +#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
> +#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
>  
>  /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
>  #define CXL_DVSEC_DEVICE_GPF					5
> @@ -121,6 +127,15 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>  	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>  }
>  
> +/*
> + * Assume that any RCIEP that emits the CXL memory expander class code
> + * is an RCD
> + */
> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> +}

Per above, no need to move this since it is not needed by
cxl_setup_gpf_port().

> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 6d94ff4a4f1a..bad142095279 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -465,15 +465,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	return 0;
>  }
>  
> -/*
> - * Assume that any RCIEP that emits the CXL memory expander class code
> - * is an RCD
> - */
> -static bool is_cxl_restricted(struct pci_dev *pdev)
> -{
> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
> -}
> -
>  static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  				  struct cxl_register_map *map,
>  				  struct cxl_dport *dport)
> @@ -1038,6 +1029,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (cxl_pci_ras_unmask(pdev))
>  		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
>  
> +	/*
> +	 * Set dirty shutdown now, with the expectation that the device
> +	 * clear it upon a successful GPF flow. The exception to this
> +	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
> +	 */
> +	if (resource_size(&cxlds->pmem_res)) {
> +		rc = cxl_dirty_shutdown_state(mds);
> +		if (rc)
> +			dev_warn(&pdev->dev,
> +				 "GPF: could not dirty shutdown state\n");

I think the proper place for this call is in cxl_nvdimm_probe(). That
happens after the device has succeeded cxl_mem_probe() and successfully
enumerated pmem capacity, but before the kernel commits to using pmem
through the nvdimm subsystem.

Had shutdown_state been part of cxl_nvdimm_probe() since day one, the
policy could have been: "if cxl_dirty_shutdown_state() fails,
cxl_nvdimm_probe() fails". However, I know that would regress cxl-test
and qemu if not devices in the wild that do not meet that spec mandatory
requirement where Linux has been lenient for a long while now.

The two options are:
1/ Rip the band-aid, fail cxl_nvdimm_probe() and require device
   implementations to catch up

2/ Continue leniency, advertise whether dirty-tracking is enabled in
   sysfs (via cxl_nvdimm_driver dev_groups?) and document that pmem devices
   without dirty-tracking should only be used for debug/development, not
   production.

Perhaps to make progress on this patch, split the GPF settings to its
own patch, and follow-on with one that adds dirty-state tracking
capability to sysfs, likely with the dirty-shutdown count as well.

I.e. a deployment that cares about pmem consistency relative to
power-loss should care both that the kernel is dirtying pmem before
writing to it, and communicating whether any dirty-shutdowns have been
detected by the device. I expect that sysfs patch might be 6.15 material
(especially with the dirty-count additions) where these GPF fixups could
slot in for v6.14, but that is up to Dave.
