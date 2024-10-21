Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2F1E9088;
	Mon, 21 Oct 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537485; cv=fail; b=Yxl/tbKlhO8ZbbzMeCBOenZ2Ec4+PVAZoq91fMJo3oQOGe8hS5KqxI/ThEJfTCgaOGw2CKUJteCoHzclBzAMyqIXlvDfZBUxrUdG9rIL2SagkUNzfkSi9u4CjnvlmlctQ3Js1kYVGaUVJugVsZPHWDtBXS3mD6ypyxoQVzGBWHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537485; c=relaxed/simple;
	bh=BNSDPb89zV8SzuYJaPCtWiI5ll89jBF95++3NzPrKJk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z9lYU3ITRw81jycEgSnpxh9Gspb7ZOq8PxGA32E7NdT6+10PIbNktNxXhlBfDhicxWrTsVKZ4gDC6s6ujze9nXEsHlcfAa9yOl87Y5Q0swayNMYzFQNgRE0Z2GhKLbnL27h43nidUA5UFQKZXsUc35s09T30Ihn5DSitkE3d0DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ikq1Wq4Y; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ikq1Wq4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729537482; x=1761073482;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BNSDPb89zV8SzuYJaPCtWiI5ll89jBF95++3NzPrKJk=;
  b=Ikq1Wq4YOEvUFmOpJ0CkoCyK6EjWniRvcOJO3ITmKHGxwq6CDNiGaVyP
   mQhR0RCSnXHYcW78nk6R3/G4ID8HPrSBwoL9r9o9wQOzd8QFVDbahWvu9
   UQOR/N2FWDMKYtOJGZu9kGGbSZ2g7gdUtwwM2PpoFnjHkykCNWGzQ9XKd
   4HcXsS+iBdGLXEQk6dDJof8NY8ALJQ70elFwTstVK8gjsZ0bmFr8zL4LC
   63rT5f6AiBGZJBef7ImQOyhU5RDRyeRv+4zi+dWt/5keUDLUdnYeC99H7
   t5ESp4R0VECKlsHwS8kZM+BLd/gYq8Bdl0T5z55kUYhrzMC2CUiavFRCE
   A==;
X-CSE-ConnectionGUID: 0q/Xm2YcTCWLS3ZAJ+qW5A==
X-CSE-MsgGUID: 7X/Eg3/1SMyyRuYZeIXy3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39625056"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="39625056"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 12:04:41 -0700
X-CSE-ConnectionGUID: wTyeg/RlR8ebwYsuG9QFkw==
X-CSE-MsgGUID: n3jVzbw8QKiCJPH2ERWByA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80017626"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 12:04:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 12:04:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 12:04:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 12:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fumWYgXf3solRiuqvbxc/FgAopfSj3W3Pk0+Xh03Ag6ajgzN5Dld5+cZBR9K/bZETEeUH9xINLHpXosrdIouvg1J+fQJuyOmkqGlTdP1oMBxRdH5Z2R8KFR5nqdBCFasxKyRf3UdwfqTATfi3VzCU/T0IOW/BQRvAyxEze5esb2EUv0VzDHzX8otoPxY14ygbiOuWZYm9d+EPipcLlFOLSig74ffXZ34nd/iZPfvG838R/OF1sQTf8ZWCNPE7LyObph/uThw8KKc9pDRuTvboJmgL8Sdf/n65Cf0rLvwPQ/chV8hRfqUfwFIpI3WxBZaxLeBgRmoPYX/VjGRkNwk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPBvt22pTu6TTbIU2MOiiWcmk34xxPeCEkKVGHEPtm0=;
 b=PPPMdHhhwY80BHjuXk3hdH9soKvuxrpEPI/WbExNh807xMvLtev1gTUaReQCaYq/ze/WoKx3a1xWL7B3bKLQujakMFwcOUSSvjFyxUzeS9ps/0aUt8dSdjhZ41v6aPE3eP/nQXteQayHOfReQPXosM7xYLSFYL03SR2zaRrdcOhRYV8BzrZ7QQf9HxMzhlPvLcajETkOMb3sOdaWKcTohkXxk6zrqyxsrfo5M7+gV/32KbAos0b4KAKpAc0EPZGaHXnILsJBhHaoXsVsWoeRpeYswyi54PCj4U3UMVVtaNedVtUZci9+eHRqgxR0g0j7yOuzQjioJuycbA7KrEmwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:04:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 19:04:36 +0000
Date: Mon, 21 Oct 2024 14:04:29 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Petr Mladek <pmladek@suse.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Fan Ni <fan.ni@samsung.com>, Bagas
 Sanjaya <bagasdotme@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] printf: Add print format (%pra) for struct range
Message-ID: <6716a5bd3308_b74f729424@iweiny-mobl.notmuch>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
 <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6715c14e9bbf6_747d6294ed@iweiny-mobl.notmuch>
 <ZxZll3-NZreHlRaI@pathway.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxZll3-NZreHlRaI@pathway.suse.cz>
X-ClientProxiedBy: MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad7d966-b6f6-46da-2ad0-08dcf2033479
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uVvMkRtybIW/Ac6GkIHQ+THAUfIklDyXDYjTppVsbm+yAlcEnSuqLBP2PM3N?=
 =?us-ascii?Q?HK/QwyQ+rTQdSETSHyNIC68G62tDMaxLhM7OqrVXaP9tuwbKymMZbxKlWYQa?=
 =?us-ascii?Q?RyttL/CMFaAJC1CG37UP+W3thyUvypqiJmmNfxAUTzDLsTjhV/q7ps02so8j?=
 =?us-ascii?Q?PrXd2L4JQpT6xezqBv5A2d2JWA72BxAupa6UFMc1GqgKUEdwbW4QaluS+9Kj?=
 =?us-ascii?Q?U7RhuSUpVQjGMme+/+PyJte/pnI0g9tI4OvxOVQzbbnIN+7+HT3cTmS6sMP4?=
 =?us-ascii?Q?KpD9KdSMsPn3nry1f7p2hxmYgFumvbNHots1h4BXo/iJpjU+2JoHX4bppCle?=
 =?us-ascii?Q?8ey60MrddpYXlNTNDGVR6qNdRFs1hlgZeLb/atbuZGklWj4gmqAKZbzxrS01?=
 =?us-ascii?Q?TJlp9rjVVvyEC6dseIG7QYy0Jg5MV2zEgeu2RK2hjoeduGZAmvV/pstoaw02?=
 =?us-ascii?Q?6Z56mwLBxBLTVY6P1+yaEYfqBxMcxWV7LcWdF4g1O8CQn/lNcNrzXT7F/Pss?=
 =?us-ascii?Q?qdiz/K8am32dPrLvbO8Trhz11hVRBczu6hoXlWSkuiwYFaSgHl8/4PjOCFUu?=
 =?us-ascii?Q?XGpk2moe5YKkKuVZ5+uJJNiksvlEpfMSEGvEGNoe5C1SMTDuk9Q38a6+FfEL?=
 =?us-ascii?Q?BPos2tTYo+jFxGnw3ZTi5NQkV6uAMbhHTm17NGG8hRXDphtgBDXCKwp4W7Xc?=
 =?us-ascii?Q?vaSQyDFRpZHZ+IWFKSosji55wuC15cobMoVx8o9RgnoeuSXjWiW5YqeJVNJx?=
 =?us-ascii?Q?qJFCOd+IVSDchCgURL3dw3CnfUf3dycPDpr1Lu7mQW55vEAJX4/h3jXgwVf0?=
 =?us-ascii?Q?1v2DgwYKvMhW8eJQm2BqcSifJ+aTlMrtidlAt6MCpRZCQn4h2tmNvMiOqrBx?=
 =?us-ascii?Q?UZmjEAAlgzIeB2x+uXBBCn4ii7QxHDqQegEgSKfKyGeKaM53n8WGMtB+UP2k?=
 =?us-ascii?Q?c2J4xCkOtoa/jLn5gqZl+pDnOjM7Nhk53GVfU7h9+KefuTBbFSDYKDKAaMEn?=
 =?us-ascii?Q?KazkSxB6keitRZzfScZaenzDf9tDVtaUR9fA0EHU0Tesm3+mogzrFw5EELMs?=
 =?us-ascii?Q?3ycFjla/O/6RMrOQBcuVucMb/pThJa7Pk1si8wjHzDPitM836dASCZ/BMm0o?=
 =?us-ascii?Q?rwhz+cdvAJQUTn3WTL19bpFvf6ysqanNrdKFy7ZHklRym4E5RX4D8i7BuShu?=
 =?us-ascii?Q?YB7Fon2AAgk8LEIKrTUDs09fW8TsoEiX5Tn9QhaB5EtUewOkv1IKewa1Yj2k?=
 =?us-ascii?Q?cG4LnvnQ52KBW3AiUw/Qmta5ghIeb+gkiQxAUxcf0NXu5V+H4Dk54QYqVarI?=
 =?us-ascii?Q?8T0m2fnBQq/MYXfN1LNw0bqQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DO7ZhWyeDvArjz2a1ghL/XguAAEqHV6Sist7STCKIxTkBQc50yRZ6OaA1ckZ?=
 =?us-ascii?Q?YBYxA6rx5PYgx6MeJkzqMFt0BFjuTjRG2BUZf1ZaY1bvcO+Sg/Vs28k6xxgC?=
 =?us-ascii?Q?RhldEg9v/qQalOZxscn7VTqY+ADlrzE+CvgsBGxkganYwrq8lkXhvF5/+n48?=
 =?us-ascii?Q?t/DIpBrum7HUdFOQXpmN43z3FgEmmHuH7SbHaqEcJurXzBv/fNaDd9XlNFSL?=
 =?us-ascii?Q?+3/pAztbbtvYl+MTufgh2PjEXNRhrgYSumQQNsusgdZBMwVqTdOU6g1lIOn6?=
 =?us-ascii?Q?PpTRH3DbGOZSbfMNy3SAlzIB1qb1PzajG12NlSkZXKe+YNZPYNqtMu9Js0ML?=
 =?us-ascii?Q?0OzoHnx+ZCudBNpuzR2yFjEjxxh+IQ2EHtODGtpgQJfktdC6Jc3CEK3/3Rxn?=
 =?us-ascii?Q?WpxXhPBkqBSThqUT1VM0VZZMEaw+vOPHkBHSiNTb+ORxR3GNmT7Il09qL9I4?=
 =?us-ascii?Q?iqaAYoVobT2MUhW6e31f6YTzB+7F9gq7qmIYXMI3lAIDn+duHw8F+10xUz/i?=
 =?us-ascii?Q?iAnhSXx6zAXWvq5ytoP+njbDXgRybfMoLHgG+6wF7vdWhFH9p46nsGayHg0c?=
 =?us-ascii?Q?OvrMZKiUuWoPdZNW1rhwkBxZJXtcy3YD/kgHsY6YAjOnIfrHC6iNzidbjbRn?=
 =?us-ascii?Q?huTmvYosVk9wtNE+Y5G3njQZBofyi5/iBtjlQuvxUBPOLFPavIA6q05SiEyi?=
 =?us-ascii?Q?4vbSnr9z/MNz26+NMWxJOgO+8oRQAw5cLD6AaahfYA4MYnLe8bBGuRV3Yv4Q?=
 =?us-ascii?Q?FKF4+E76q1EmwY/Xrnc/YEt7269SbLbhtrbRvVRlRvhu/wfpoeVvzL914Y7l?=
 =?us-ascii?Q?2HF7iEpxLYV/jvPatfKy/pV4kpMh9qpk5diKoo7wDfHg5leNapkc6nhNsybx?=
 =?us-ascii?Q?1k23aWvrFcsUNogF5KTHAfiimvk/6HTtut9g+nYH6OmuC1BjZAlzf+4I+/Wx?=
 =?us-ascii?Q?UC+S3NjroKxmGhq8KbgU3dVO0q2WskP0TXjsMH2bQTPsMQi88QihphZCTjQO?=
 =?us-ascii?Q?lQFHKXgKB/Jvm+SOWq87enZIVAE8Aywn5N3BlKQgt7ganA7BbOD1JLLFAceR?=
 =?us-ascii?Q?f/AVZRaf6eTK5aDCpx7TgiVORrg55FeDZF1wjm/tqDY9EoaWS2oBES+KptWN?=
 =?us-ascii?Q?Ao/pqc1zByij5p8KWvJ5VgFFTrg2IP/Ej7gjT/rMggbmkYvKLMhEz7rm98n1?=
 =?us-ascii?Q?wr7anUNL4FjwMVzJ0iHzDXuYTzS94+qbP4uQ/T7XF77KKhxjcuVOWhw0Au9I?=
 =?us-ascii?Q?scqhjo75bbujXXL1R1I7ztTeqsqlw0RJxUB/v8YaNBTacaK2fP7quBrxtcEC?=
 =?us-ascii?Q?QDjOiCl6Nki2lUzR55zBLm59xgRDy/RtyhsnUHU9sPmJVnfj30eLrvp/2P0N?=
 =?us-ascii?Q?ts/cTYHsbcdSDnhAHUT1BokTIINEF0K52skBXJSVN8jWrXYB9TuFDcW2uZ3Z?=
 =?us-ascii?Q?KZp8YikVwxf1AZpOtXlmkarmY6gbx/XUAVIminFLBUP6uCccfR3z6aX5rNrj?=
 =?us-ascii?Q?6LspXjl8Gxt2qARxzg2AbB2cXCZerxY5q+LVVYE3RXsMoBAs0lpVAb35q8Jj?=
 =?us-ascii?Q?hyRFn0nrGSEYej1wmdw/HcmdxLbV9T9dJ6BxX60N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad7d966-b6f6-46da-2ad0-08dcf2033479
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:04:36.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfBxRFDiPsP3YX9Ob+Z00tdtmpXAi8ookV6Wt8kQIbg2T46+GjVXxsa4clczpkf9RbSb9nyrmxJIESbYJ3VBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com

Petr Mladek wrote:
> On Sun 2024-10-20 21:49:50, Ira Weiny wrote:
> > Dan Williams wrote:
> > > Ira Weiny wrote:
> > 
> > [snip]
> > 
> > > > diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> > > > index 14e093da3ccd..e1ebf0376154 100644
> > > > --- a/Documentation/core-api/printk-formats.rst
> > > > +++ b/Documentation/core-api/printk-formats.rst
> > > > @@ -231,6 +231,19 @@ width of the CPU data path.
> > > >  
> > > >  Passed by reference.
> > > >  
> > > > +Struct Range
> > > > +------------
> > > > +
> > > > +::
> > > > +
> > > > +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> > > > +	%pra    [range 0x0000000060000000]
> > > > +
> > > > +For printing struct range.  struct range holds an arbitrary range of u64
> > > > +values.  If start is equal to end only print the start value.
> > > 
> > > I was going to say "why this special case that does not exist for the
> > > %pr case?", but then checked the code and found it *does* do this for %pr.
> > > So if you're going to document this special case for %pra might as well
> > > update the documentation for %pr too.
> > > 
> > > Alternatively, drop the new %pra documentation for this corner case as
> > > accommodating the U64_MAX size range case is arguably a mistake in the
> > > caller.
> > > 
> > > Either way, just make it consistent.
> > 
> > I've dropped the special case in the documentation.
> 
> I would actually prefer the opposite and update the %pr documentation.
> 
> The behavior might be surprising and people should beware of it,
> for example when writing a parser for the output.

Works for me.  I added a patch to enhance %pr and left in the %pra doc.

Ira
