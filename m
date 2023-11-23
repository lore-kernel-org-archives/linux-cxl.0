Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/RfgIIB"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2611F
	for <linux-cxl@vger.kernel.org>; Wed, 22 Nov 2023 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700703194; x=1732239194;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gPPaggknSmoaIJZN7T7A74EvfIn71pIWvH3VMJwtOMs=;
  b=Q/RfgIIBuSHSVOHmvfPRR9+LpOdKHvsGeX8nEMMbqsaKDTOKOicN+cCK
   G7umrCvyycoTnk1rJUDMNIvCS7y/AF4CPBt8wNLTQ+nfociWmdmB+TsRz
   Mt66kaEPkSf2Gl8c2Dxub7CkepFihT3s40ONZeudRmV0AMBhbjXHZ2xl/
   aNDmxjJx7hWQio74rknzKNDjfJsqL3pHfndb4WSaWPguengdhNCV0j2yU
   vwWzriRVQKGDytpiCtCIlGuYt1SNx6+SBKf/YMBfYve74hoSUt4uewBnh
   kOQIqL2BfteY/Xvk2HrCRDjJD6gdHBxcfwPdFM4ku5rVrmW/GL2WNdp2S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478375784"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="478375784"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 17:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="884815752"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="884815752"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 17:33:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 17:33:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 17:33:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 17:33:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG/QwUDzqAOXusSPGeBZ0iZR3BIRHg7FDhWbGdW3zBD22CRIjp7S4j1BPHHucyi/QLTHrQe6zKK9pWEIGmFjsgYe7qddrlsoH0Kmfg3jdRbvS/nxJOQ8fTtMAJy5x1JBg+h2ZAXoFJn9DDi5W3ZIWZVF4+DNM8ShIm+dFqcVp1NmKjLou65Hf1rJGzleAFuFD3mEU41xb9HOqsQf5X1kAXadjKYNCWlsWLkMPzO3t8mvrPoHyFFJZmIszmUy2K8MDlls0GYN3qc3Dj4vjzlYSiI6yGZL5r24ERvkCUghJ81otiqopBBzE7Ym8KafZQtry8j1ho6XZ/MSgePxkUFiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvS1UYKZMNq0u9w6cfOGTGndU4FKYrFwkMyBe82B/0k=;
 b=GLSa90tZalBDMWVu61xRHDejImPzEMgkZGPEoq16qq2F1bt1xgAxbzql0NLUQIUHv2ldYtTHrFGsLQblr/e1hMz7Ifd/51wwBFF6yRXOlKvjuRXZD4KDMCRWJRsYrO92ht1C2IvNLyXy2WiTA+i0o4+2whpheRVdJgKJlNrLiOISy7onfZHbWE/iQrpFwyKkWZf60A9NqNPtZbRv4hToP/txN/MZ68vSb3LcbW3sjUAgFHlm/b7vDEEH9XxItE/EwQd0Yk8Aha98V4F0qftk22EEbzBcnZw9TQ897NGa0reBWj3m7JAfxspDLpdBXmNgUxxxgRfqtk3Rkx4qd+d4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 01:33:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 01:33:11 +0000
Date: Wed, 22 Nov 2023 17:33:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: Convert pioson ops rwsem usages to scope based
 resource management
Message-ID: <655eabd544356_b2e8294b3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
 <169998626910.1958731.10157698499207717733.stgit@djiang5-mobl3>
 <ZVVVH8ITotdk1nyN@aschofie-mobl2>
 <c35ce419-4881-4cb9-999e-d3034ecad8ab@intel.com>
 <ZVV7nYEFHVuXskm2@aschofie-mobl2>
 <655ea6fb1b180_b2e82942@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <655ea6fb1b180_b2e82942@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: abf696a4-09ec-48e4-aa0f-08dbebc427bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbaDITRW0ZI3QoTC74y1VviuCPgOC2/m4R8SuVorIaAtcWFReqMKZRD8EMsiFnWndh9O2XgYU+4GoDPSn2o9E4PHp6rzBLoMA8VioZAtJmrWFWQWKSKrrrePraNQwsXvSGcf1g0ra/OVJnKwao/FfECmP2uAk1mgqCWxLCOoZheBWw0to0S+mhmQEG7/jqCDPphilrAgLnWmQNBqjdhfclL+vAZhfyEml9UV67aQn2xIq8qWeKxkdMiEQ6BX7m9/EkYM1Gwxa++v403ehWaRoOQ3NMEI8tU0wYEnrbT5QYTgOWPcmeTW47sljWVa/UdkAuznuDxkTsn60m9YIIV6WB/J0iENhWEVgvYdOjIjnYWOmGkFkHhsCw3qM8zWyOgmn0tYGN8BA7EDZEHTlMgZLr/j8vturvmWJF4+JN5y0DeyFgt5HA/YW0YBqARr8XqixOZ4uvfXrJMBExGXEb6zyJ/LMdv/z6sTQ7lTYsRaUvGMCgMdqJdYopQhIidjGvRJZeS2bX/bYAxZwZGLQriImiNhmzTiqak59l0knunEs7EOnOuSznOAMtDcAIQ92ORd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(66476007)(6636002)(316002)(66946007)(66556008)(110136005)(86362001)(6486002)(26005)(9686003)(83380400001)(6512007)(478600001)(107886003)(38100700002)(53546011)(6506007)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cyxTY0OpkNA18u2aU9xJF3PIXJ83lVJRk9zv5UpPprwi5JwrE0DjiwO/nqnO?=
 =?us-ascii?Q?tP4TPyMH5Xx+qh/FCL5licKqMmw5jF2F+IFFPSU//MqFnkJqPpAjyAJNdzLG?=
 =?us-ascii?Q?avZHrBCevWRQJ6yK5HcwlD2pJFYDrgEB6ywyKKuqTHi9BpSx60SeioMNy+Fl?=
 =?us-ascii?Q?KV/iy6iTdybGCgiCyDdH2MKkw3DGoMsWgQTBwnKwami33t96ikOO5y5cdARo?=
 =?us-ascii?Q?zj6k++gwTaXbjVUMkc8vqqKbmETXuGe4PQ/GNd5jYc9QlBZ+rmFZD7oMqmXS?=
 =?us-ascii?Q?hSFpheL1MX0TJMcVmmNBqZjRzL6XNyyIZxvMU8qW6bekp/TZMCJ33mdTI7So?=
 =?us-ascii?Q?8vaD5VFUnuaOxalPty5rV4XeQLJ01wDg2DvTyTw2QdP44X/maOZD3QwZC5ww?=
 =?us-ascii?Q?9NLfrww+TWoQDFsbjSWHqMX53yGcdyPR+ZrA3GKmw2pU1OGlP0hfSHfsrkgD?=
 =?us-ascii?Q?4y65HByx0H+LwO3icdii/mHk6z2owpuZwyfqT9erkn36w/3AniKODykgHag3?=
 =?us-ascii?Q?SR2nYWF8I5xkQJ03BdPOj7JOmI0ZXAyCqyvzqgIvioXBn0XkqnSclPi9YOpI?=
 =?us-ascii?Q?YxWdVU6YiVu8XgT7JJxBaKI/bvxS2qZxTF2P3sLKplZjxBthwxAAZbQmHap5?=
 =?us-ascii?Q?cMjPbEokq4pAOg+V12iMTSdMuECgZCtah1tWOMMg1Xa8N5r7uLxNPCBL39cu?=
 =?us-ascii?Q?k/B/M1YqTMTeV4ZWUYrNRmiKDJxB1re17WC0mmEl6g0i+Xjskewcu6fUWH3H?=
 =?us-ascii?Q?X/Iu3+USFXmDxVUTtdVbJ3mqeYMNIbb02lqdNvTdmciwxiUvjpbP7xDCPUhu?=
 =?us-ascii?Q?6fet9WBj3U8IQ7IjSSsDRjg46mEsSMghXAmE8Iea07IC8ri1ID3vdLQFh0Om?=
 =?us-ascii?Q?j/eupJqw1wrjOr1htg97ffAUzol0snAgPO3O9qYPJ6gsjuU6W5b08L584LY0?=
 =?us-ascii?Q?si0gQvpwXvcborgkohnKHI/VcoYTOT5PKgCbH3RarKhLy3DiWABK7+ePkSeA?=
 =?us-ascii?Q?9c8vX/3dCBbHINpah7/RAQ2rbm5/yoJCqDWl0Ao79/zcccLSnACSApXOiCrk?=
 =?us-ascii?Q?XFlhMFjCbIDCaAWNaBlaY14aCUv5+hzlwA9CCFMQudobOPbAVcJUV+031dPZ?=
 =?us-ascii?Q?IJYe84JOVF71ap9Ya34pgwMlzjGmtOIYr/CtDf+IEP+x7zKqUHN/xoTmbMwJ?=
 =?us-ascii?Q?Tmn8Pfts1lL+CAwuf7As7X/nUZ0N/T4PrHeYpgJRovfm/Pj/Njv36apveIul?=
 =?us-ascii?Q?SFvAtfTZtxfQgNT5m/pI6S5qHS6p1zsz2Ol6dee+5IGYN5cFdQqlYwERxb/5?=
 =?us-ascii?Q?WTfGVUjnV1yBEHPu823XPKZBXubSeEqiF4mDJ4ISR/lYzv7hX99U+0X6WqJZ?=
 =?us-ascii?Q?H8n6wKUpwrYQWyduU1W99h/3hjHjG9pceuOxqw7bTzZJ6vbB1f7T+WlcWdXJ?=
 =?us-ascii?Q?MeRfGZ/2jiZ2vHsqn2fN5MNple19j0+e6sCggRt8xgROxjtJL/KcK/nXrwKv?=
 =?us-ascii?Q?Zbu2kopcxpMAXrsRN3kSBwmvPxZkoqSmU5gW0GrZUMfr+WK9H0AnwuN4UTZD?=
 =?us-ascii?Q?0nHXqhT6KOFoTBQ9dFaspWlncr1N3MVCEDvFYhBJSpDMfxZlHraEA315Ca5q?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abf696a4-09ec-48e4-aa0f-08dbebc427bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 01:33:11.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MQ6qYlqy8khDahgE8JON/f8da/zfIJubiwVNqWM+OQHJAyjr9/WXMrT3MMQHZ3hsDsUttTHKBK/Fm2sn/5119PFqyOutE3ivp8HKVFePJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Alison Schofield wrote:
> > On Wed, Nov 15, 2023 at 04:55:11PM -0700, Dave Jiang wrote:
> > > 
> > > 
> > > On 11/15/23 16:32, Alison Schofield wrote:
> > > > On Tue, Nov 14, 2023 at 11:25:20AM -0700, Dave Jiang wrote:
> > > >> Cleanup the rwsem usages in the poison ops to reduce complexity and reduce
> > > >> code lines.
> > > >>
> > > >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > > >> ---
> > > >>
> > > >> Hi Alison, follow on patch to yours. Can't be backported, but nice clean
> > > >> up going forward.
> > > > 
> > > > Tell me more about your backport worry.  Are we expected to avoid using
> > > > the new guard any place where there is a backport possibility?  
> > > 
> > > Given that there's none of the cleanup.h support in stable kernels, I don't see how we can backport the guard() code automatically. Thus your original fix with a fixes tag plus a new cleanup patch follow on w/o backport issues seems necessary. Otherwise a separate backport patch would be needed no?
> > 
> > Sure, it would be needed. I guess I'm looking for why this backport
> > issue is so special. (not being sarcastic). Is there specific guidance
> > not to use the cleanup stuff if we think a patch might be backported?
> > I don't usually consider backportability when adding a Fixes tag to a
> > Patch. Have 'backport folks' asked us not to use it?
> > 
> > I'm imagining the slippery slope of not fixing something the best way
> > because we are worried that backport folks can't figure out how to
> > merge it.
> 
> Upstream should be fixing things "the best way" in the current kernel.
> If the best way requires some work when backporting, so be it.
> 
> The general rule for making backports easier is for when a fix
> identifies additional cleanups. In that scenario the fix should be made
> first and then the cleanups layered on top.
> 
> The cleanup.h helpers are an interesting case because they allow adding
> new locking calls and defining the scope of the lock at the same time. I
> submit that cleanup.h helpers are as easy / difficult to backport as
> open-coded lock / unlock calls.

The other concern here though is mixing a conversion to use cleanup.h
with a cleanup to use scope-based locking, and the fact that the
_interruptible version of the scope based locking is not available until
v6.8. So while I think it is ok to introduce new locking as a fix with
the cleanup.h headers. The old-style should be used when the fix overlaps
a conversion.
