Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CC3644BE
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039943; cv=fail; b=WQcXSAjc3QjCAGrEj7R2qg9R0DpeminqCIF+RmjHcQA07aLR63CousdwCRn1z32DOWUEYVjWISqIvNSquENDwCRVtr8yE7mdBT+IOZQzNOb9Qp/aQlnU9XueFHhMVezmPQHKJQ7iTwJm0AjKO/y8+VumgE0S+WgqE7kadk4DjVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039943; c=relaxed/simple;
	bh=yauiMvrj/UeqBqStbbBmFs9UxlwgZ3jOvXAYtK8OqMw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o1anQroreX2e3sYRD3yYerqK/faqEn2asxj4pixPJAXQS9E5tTmpWUSwSNgDNoVIB1ugqR67mO7z7hWX+abdLOHbynEfPJQLGCsB34sBiP1GmwQsqccm1VQmR3HRJp5QC+PRVfsaMjAwSAGBsF2FeB7c2DJE6ZH10DvPztDMzFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMR8dtwr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMR8dtwr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774039942; x=1805575942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yauiMvrj/UeqBqStbbBmFs9UxlwgZ3jOvXAYtK8OqMw=;
  b=cMR8dtwrwDnuU/zAWI2Uj8TVidNEicZbSWMF1UMC7+SL31wG0b9w3fXT
   4sUzbFC8sJ4gXuGl4yL0/eyVPnroKJcGhLdAB0fXmjj9639mEYS/5JweZ
   63YIzBCZm6XEjqnMckhL7os/miw/7ZLLJQzFxAGMnmp58vxYHLbB8G27W
   fiLErcm80xy/AI67vyQERNYe0ClkD31CGZH2GyG1z2EMJJEEziCZpnphw
   COTlbJr3/qC7otjUAZVo3lA7znLiMLeY/YMMLlX2kTKu4B5IUeseu4Aik
   5JsS3GtJeshWq4yBbaTdiZFdPHv8WsR64i45o5fBUDN2KuxQkPaITyvhA
   A==;
X-CSE-ConnectionGUID: CO/8ugfgQHWvUeYQPH2pdg==
X-CSE-MsgGUID: lXmQ1wWlTJCar5aUs4nRtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="62693123"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="62693123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:52:22 -0700
X-CSE-ConnectionGUID: 09fmvcYFQtK8YVayU4nsCA==
X-CSE-MsgGUID: KGqLYMVCSBKAJYQCwguAmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="253884713"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:52:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 13:52:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 13:52:20 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 13:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGAK4i0e179t2oIj4fKoA53vZK5pf3E4Zv52ago16BYxrgjcgBpccKBL8TA0xXIs7tq8XE1HbRo1a6u4eRHQBJWnCdJAHJVy039WvUxp4cLP4yJiV5JLl4MO7HC8vktTjuv604BE05DNNbVz1ckkm5/hTPPQEgc1xE80ChPY6dDkaHPph7fcBr1Jm0a3d0wDpoIqYAbVscQPoa540A/ohWd7B97iL0nl9bpvYfbHh8qydjBqh/BVFRQUJ7IhpGVxQd8aNdrihxAxNqNaTOv3Wleu5fHI65Ea8LzIY9W3MQphvY3DDQqUZ9FOiC4kbVhFvqoPGAf0IeVa/3zgFxlmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKWbu2p3s1eXngOiEjlx0KbdDSu4h68O3tFJefygU34=;
 b=iYC5vqR/fW5l4/UJsfEVaR3fGCMC5Usr5iHCXDnJhN77tAakQBw3dIkhBQGO0dlcmcBpSfkHgh5MpQ9evooKSAdePI1tZBeX9rnDKPeiCqxvKAsCGpC3Wac6h4Bk9xqCC15hTLAuGR7igCWq/NeF0oMg53iLDR/oKpun7E8sKUB4+UClpdxA7eNkuWcUVFTRl9EAiN6Lj9L5QXy0qMMLlhC17Wk32qogrO6cnOPSjV8Zt8RURuaw4MqQ3bwmv31/XLbqPuY5sZIGtoVuzABH/N1lSpQkKfkqq6u2eYy63e4a0izvrqmG6V+imEbytcm5T5RmjpefpA/md/aW0O7SfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 20:52:13 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::3979:c00f:fdca:b895%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:52:13 +0000
Date: Fri, 20 Mar 2026 13:52:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/6] cxl/pci: Add Back-Invalidate topology enable/disable
Message-ID: <ab2zec-aSUpYVIk1@aschofie-mobl2.lan>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-4-dave@stgolabs.net>
 <fcebf688-ac73-4a72-b4ba-683b3380bce3@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fcebf688-ac73-4a72-b4ba-683b3380bce3@amd.com>
X-ClientProxiedBy: BY3PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d52119-8728-4a9d-b186-08de86c29022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mqKcDObD7TNAwllL686ZM82jXai9InI1RxXA3Owt90RpD9kP/nOiWVHPWduNp2Yj2pm9coY/qZZqV02ew2TnMoVF7b5tpOUcxIeS4uEAAWYfi4czRQvBG/RjprfzdLzz2Q3GyV0BS8of63bP5R9YUX9o/kC4B89ML7i3r/CCOutA0gNacS89vCFTY86LwFWf1Uqrk6GR6SoBDIic7BE+Ht+Qtk7w1Xl2rymtGt3DhF9Nnzu8f95ovm5mAJokmitaK13nCMqRtkX8ME/q0qDiBJEnIbGuw/kK8XgG2Ktm95D6rjfcRVdavEYf+fe09PPSBDtFL8aaoNLCQDV9HlQYfSk1dpS5F2TQrIhbQDXOSOl8Qk4WvqsZz5b4xGwe2MAENMYjjCFeIgHSNK3FLTf00eRfSrM4DrT8sTATmzmF5dQ56n45CxpkdY0dltwYZFBVzrNfgY9uD0+pTaeXB9/KVvivOwjqA0iwiq4/SRS5ICpl//xyvdZuF5Nkm/520Pp2cYGdQQ2rWLaMmQOMFy11TBWX3Se4NZmh8QTx6d2VlupDoWzVNLsVsJn+WUArFuFMpK3I7xWe2Fa9YZjR6hSy2eOEg8fOyaNmxvptzi6hpL2pKihS6Z7IrTJcj+q5aezIeF2zLbPehoSrKF1+0yjz0utUi7Gkmzr8hyGwsyqZwpw+vOh/+0CJ/ooCuyjLacyZlx+YTU6UnlSsCwn4Bj/rbPbZECgEXFBy5v4WOgQndQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TuI4uwVL9sEUZhlX2sXe8RLmXuIfEaX8xKihGWu5ldkxb/5yYTz1KmWzX99?=
 =?us-ascii?Q?zZ8Jwk6pRuWa+FRsTCYVTsZfXLT/NAQi9qIl0FaZQdCB2ObUBHiNGtU839Ez?=
 =?us-ascii?Q?uXE/7SdwGazyKuGanEoEW+chRo+Vt/ScyYrpPUtQXKhpw+IQr4fLPOrA35jl?=
 =?us-ascii?Q?AlDu8b0Yg44FS/euedAQvTYYq9QQkHgAK3/lPsUPhhI79TvVsF9K+gcnyD4O?=
 =?us-ascii?Q?tpuylISRq35sAiX2fuWBKoIfeK3BlDEzKNorKImRKEpfb0QErnZGpXowGvHp?=
 =?us-ascii?Q?dG7rmkR+KduoMTmZ0dPTAbld8oGM/5DMKjb7DFE5/AZkbFg55vzRMEvJuShd?=
 =?us-ascii?Q?Zl1nQ6cCTd3CU0cqXZupKh7/mD+mN4M3Ho7jcIBrTtUfI+o5/K+38V013RgP?=
 =?us-ascii?Q?/ale1tSYvaDdtz6WEPNPxcu36yI4TWQ8FQKTwpMhjZ1yzhJZ+hGlvwWKBMYm?=
 =?us-ascii?Q?XdmXVYgIe9GoCj1nOd4cuXU2VbYcSdMb9+Pr0pOktoM41Zvsso5JOmTwVO/d?=
 =?us-ascii?Q?IRRO3LvWX7isdRZCBlSj1GwlaUC69IvJM1s5LRJ82DR4Olktmf8oLKj9BLbV?=
 =?us-ascii?Q?fK7kcGDvUpqW0Tdv4Gj6yOHbppO/tbELMloTgO/4VlcZ9y5W9Q9jwYlXkHpo?=
 =?us-ascii?Q?Aw11l72RmCd/gx7ttEOJRQg5m3dLP/QNktjxy5Mmt4lEZECx10G2Ede5KEI9?=
 =?us-ascii?Q?SqdvcQVAGQUC3kbfutsp/C6PucC+h3Sx0NBI3guHIpz6kw28Az5B2zQiSqh5?=
 =?us-ascii?Q?s0UOytqe4WzsrinCYoYhLDM0SlyyR+QUHyq0pv2iLYlxFhXcDNIDI1KOXkQK?=
 =?us-ascii?Q?qJVXwwbvQfZz3p3wCpcxZVLbC8gY01PSnx6rnwUXv2g3WWwNaOy/VJoi1WbA?=
 =?us-ascii?Q?GXHd8TVPgGE5tC+Xq160ayPA6onpeuPO2yMnPnl3nxfQwutdAna0f7Sz+DZ3?=
 =?us-ascii?Q?JImSgfTkjyFyVfLSCvkSyqqIlcyp6jYDax+rfUY9LtBXxB76/pWawGy1tmuD?=
 =?us-ascii?Q?QMP5TfhX4A8O7QVYpyW/H4iTM8fhOtB1IAt0MHKrj9b3PgRI7j9f8f1eHNZw?=
 =?us-ascii?Q?TNR4LzVowUFcEQqxruOH32tm07spL5yPcW6sfbxVlUSYu0sKY+L9r/qNXYYF?=
 =?us-ascii?Q?1UqJqCNVWomeFWpehbUt6AEOyNyoPHOI0GPpZGaiAMMBxTQ1pNmhQ9bb9SFK?=
 =?us-ascii?Q?YXYWIiAKCEt4A0EfwPPEYY0Dls0sNZl7XtUVnUVbmok9exk+mA6rZzrUzV5w?=
 =?us-ascii?Q?RYyRXVPuW9mNxQhikiAOs6S1jhColrRD0GxqbWW5v4AtmMG2xPgJy19sLtn9?=
 =?us-ascii?Q?soZc9hr8V05sEsFyoSbxTLFMxxqKUIzeCD+RjRt3t/QNYMRzS4pVtYFSGiYQ?=
 =?us-ascii?Q?z8Sii1jxUsmMA9w8EvNpAmShLB9Hsqr0b31K9YdzSxN70uI33O72cLFigbTt?=
 =?us-ascii?Q?Jo001jbQDZQO3Ov9/I5IlWgZUF/37dqhVEQXipZ1UW/WC1vvb/KOw0nR8Vgg?=
 =?us-ascii?Q?0o5XySWN8pzY1bgx2MR7Pw7dWAtKNxwa4ytwWEfCNXHIX75Z3vA4yqSG8J1s?=
 =?us-ascii?Q?ALcVFI2WGfPsnZOd7CzSTuyN73YYQFaSM6BpA6V1MSKG8Ffy4JB+g2Yo+3z6?=
 =?us-ascii?Q?EWMO5591rYd7oB4UEPgxssrUpwWRsLeE/NFDV5os5sKA58J/dWvGBGuDH3A/?=
 =?us-ascii?Q?3o8plCHkrq6hlgwwrYLvMeh4sLrc/UovJ6m79U6XoWWQ0VVA7Qb46pZKFjjO?=
 =?us-ascii?Q?LBrrLvIIyibVc6Tc6ZPv3+UK+Os9Jj0=3D?=
X-Exchange-RoutingPolicyChecked: nfmYYw4WlFZPJpuIRJ7N8CJIhwwRVBjaWwVPPRETzpdIDDCBCrfREoEpppnY43VzQmRGJm9L7DCScXRKViPaDe1ejL71RG/cvA1qn5lC1OVKaWWuBZalroPw7EJt067f2Cd6SpVpOK3sugpwgspvqRGUNR+KzsORXa4CrSx4q/fzQQTx5gbzbmlUypQmD4ncLDpT+eZ4Naik0XUmOI+bE9yZxVneGfzzPmoQYH8pTfiDnMgefN9De4qdrd7ELOBO/edfmEqVUEFizmQXq9lOtIflwyFHWpA+I1ljMJCVlmYZBJK9awKPl2AsUCWfyuhXDdpw0jfDYfr1ynSp+/ZOHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d52119-8728-4a9d-b186-08de86c29022
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:52:13.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUTvAGFMhWyOoCtl/nmIOe88zf5LQQZrlmtYS2/dzcZe4nXAD79YABOnZ1ngFm1M8/oL9t9WKg67yy941UXyqgiF3M47T9prQZJV2sHeo60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com

On Fri, Mar 20, 2026 at 11:20:05AM -0500, Cheatham, Benjamin wrote:
> On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:

Littl bit-

> > +	cxlds->bi = enable;
> > +
> > +	dev_dbg(cxlds->dev, "device %scapable of issuing BI requests\n",
> > +		enable ? "" : "in");
> 
> Nit: It's pretty hard to tell the difference between the enable/disable case when it's only two letters.
> I'd prefer something like:
> 	dev_dbg(cxlds->dev, "%s issuing BI requests\n", enable ? "enabled" : "disabled");
> 
> The device part isn't really important since the dev_dbg() prints the device name anyway.
>

There's a string helper for that:

	dev_dbg(cxlds->dev, "%s issuing BI requests\n",
		str_enabled_disabled(enable));

