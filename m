Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794966458;
	b=2hJDEO0RSV+G4xwin+Fxc8eGAwWCQHh6Hz7srFE0Afo9nLIrIJ3bWpjQXF249oG1q/w/
	 MNEsvOvJO2gymI9WQIUbAunXNcX0ipip3bhLqwEtBwv27ZAUVaIFn5TDWH1rpZstCwWtY
	 uyK2avv1vlOmauIerNvrPrfz5fb6Zviuy0n6EC3J/vCeNNshFpEP0FdOOEwZZOstBWwZS
	 U/RW4MOs8ngqMmp5unbHiLL/9/svoGbiKeT5g6LRIFHJbzcataLLNJo6zgND0hVw7G2ab
	 m7pioHEphxxKbyJwivjnTuhyf0ZCEczNVh/kdptgSCOmQ+tZ7Q/4Vb4XGIhP3TFR+FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=3skKqQmD1HYKZW5iKPB5j7R/O3XliFjvWmB51ER7/40=;
	b=u2Ppb4ifarY7d4ka55Qr6DldTPxLzYW2RzZWJQpXYBKO37u+UK9KwLAiJsIwZvrJHnNB
	 u44LBBdxSEMsIizwGYiC7rO5fAVG3tIPAgQsv12iNBsVmk/4Tk8Z0f4WlgDFK2aC2MTl2
	 T1YaBmL2WD5TOUy0Xs8XmHuMH4chhjM1AROJA+9zgXgC8Gs178CHOKZNKOIfp2XyA7A2D
	 YjEg2Viij+W361J0SPQg6UI5+eGdwxgoUOnwk7KVMMRffMrj006S32xsKwOoN9zaQjhQq
	 GtZladxKySe9vlyzA3y+N4nZe2upZ9vwl0Uj4DQZ/WyrUh7mUBYf2YponUWVs1j0dkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RU90XXUF;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=aAllZqyH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BD606A31C;
	Wed, 18 Nov 2026 01:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 783BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RU90XXUF;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=aAllZqyH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794966458; x=1826502458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DNLkXtJizQ+q0pa+TCMFWiRbNH1B0OowVyOtmkKAmzQ=;
  b=RU90XXUFWF7CHFZqeeVMUlOz8sHdl/P7QLwWIK11hCVCX/AR8qkMVMqP
   mKuMRW64DE4jGo+C0heddXMKY+3UKwgezsdRMyvlPaI7kJwdjgNDgn+t3
   RmV9g1wdt6mE73kWWgwACywDgQ6jMph35E69wlW0VfwonTLK7uuVmMH7y
   vVv1HqIhvoI0fxZyXJX+ob/rtQ0eZJxL+IGr1gTKCe+8zjbG2EzN1P/dW
   cbRwSvObKM8/jKxLPQX840yECm7AldXhX6vvvgyoxQ45DA3PVKIY2Sb1M
   5jfH82EBpKLjQFdIeIYrKsdhxbbjj8Vc2H+OTfq0vvmpd2nF29MXHrjX7
   w==;
X-CSE-ConnectionGUID: sb1ENjVpQGuSM1SZgcjT5Q==
X-CSE-MsgGUID: N7yDqkz7QIGquM6Pe9f9ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3764203"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3764203"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:47:38 -0800
X-CSE-ConnectionGUID: mbyg3FbKQWyCRufFNAIOZw==
X-CSE-MsgGUID: oA63qe6iRMScmON+bo6Z9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10061071"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 17:47:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:47:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 17:47:37 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 17:47:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQKiuDWWtCQEuNPLMePL7wSsJDEiVbo3u4R+CJIl8x+aw/99tncahZavrt2XIKXvESv43tyRvwvwY9L6Qgzxq0rzikOEHnKrqIYdp4LxZ5pXhcf9eidUuoTKYwhasf6xh/FY4eGCsNFz+cf5qfrkRbEOFd21xuceqO/GoqjhnWGA//asrVcBM6DXkeb231cMLjob4uZlEbd/9eQHrnyF6ZEg3duGZ+kmitS5KdPGPdIZ0mZfAjqcj3+RwtuUXzeyFJoCC3N05WCxTxKE2ROPmhvzacCCx+Pi+Nn5nXQ04icN9LcRf+g+mrbAKgT3Zy82fum51Pv8iLz/7rfFW505+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3skKqQmD1HYKZW5iKPB5j7R/O3XliFjvWmB51ER7/40=;
 b=fo7e+kCk0BtZhNhBctW37dKkFHrHmAjc/FMghDSelQKstlOs8MLCNZHm9HzRgoC2CK8+nnh/99KuLWuRWsZM39ydizaxgZUp8I9KNRnODdViFWom49vzgAjZ1MIygCs6h4/Ii9WrYdlSXyblMdvy+HJGAxkmrm4VBtO9ZwltcyTt3UHX39qIdbFBuE2wdZIk6TzXXr4FLoHmAcZr3+qv+5XLUxM2U2OdnpxXzT+JXAG3WkdsMkC5e2eSOvbDBnx6kJFY++dGXSh1XdgUdip4iuZTCuzkOeNSGDfonNsm5BbLBEMGFas7Tw1GeQAecwfD+q2/ydSYyIYtT63Scxpo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3skKqQmD1HYKZW5iKPB5j7R/O3XliFjvWmB51ER7/40=;
 b=aAllZqyHaOf63UZAzboPRLD/0jfF+KxHsEfyYWxAPnmsE5CteBnHmak/Kkn3JizcZlKLn96+fdNl8NWQU8IfmUdjCSDgmC9h38FJZcYXHnL03OWOzqGsA8qzxsQRWNG2vfNbmrvwKT/MUihZzUvM/8vWllDDy4VtaSgz6ZX/CIE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB9773.namprd11.prod.outlook.com (2603:10b6:510:398::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 01:47:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 01:47:34 +0000
Date: Tue, 17 Nov 2026 17:47:30 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Jongwon Lee <ai@linux.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] cxl/edac: Mask DPA flags in the event record
 cache key
Message-ID: <av0Dsjq2ii61zAhj@aschofie-mobl2.lan>
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-4-ai@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108022022.3352-4-ai@linux.com>
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f54d7f2-9f2e-43f0-d175-08df4515ea9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9jDptNwdaJLlfPw48O4JRsbkGQj8raR1zuH5lb05xOUc2tDEFwwpFlmsdQFa4ALecDjLtfi7UzfxJ0Woe5NqdZLJt8av3kySf7ZZtEeWpXTcbgyHi+c50E9Gn/BuYFZBwm9hvXHybgJ0W0LWsleg4gKrsGjdUAa85mXB5fIzxwd6XsymN0jcA89zkq3JMgfCHJHmKhPlFmH4LqH3ncalt+gqijiG9O6jaf9Fg0EMBWjHO3SARCYwjHpq+GNRqqa2T3EOh7j1guABj7QcjxsOtmH6BjKVMt/3/dfFa/c9J8aAxnmqK3nCZgNCoemyp0UEbLyAm7D9PqwvjxDXRad0tSeEZurPTu9CbXOguNwZ4ckz3akrJcgZTj+euKIix2MpTUnRZmncpx2CBHALK29Q/D+87VvVTmGl1yL79h9yOtxQ3EJw/GdIMbcVR1xgsOKXBf1H9Ka1Q9tfjCpUrCAnLOeCxUssfOGKTAeFoYPnvjl2/raAAO7WfnMLGEnrGfFQb3uDllo7Rzkt+/Oim8Y9u6hpB83S1Rr9aQ5c6NmQL/KMmmmANvY04yqulJF/dIEx2QLkmKKqvTLNO8bCRIpX4jFoOpJvlyrUNaH7ZZdFeKswGFawkeS/uKFJEuTnEjuzxJ5Gbk62TZLuv2xh80R3MzwWXgaOCk1baeV5f7odGlY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jkfhfd7ivDqY01uhsLpL08GrURrjVJsOxU9T8aqBKAnP8kWeEgkRS/onqpUd?=
 =?us-ascii?Q?0w2ynqe+BiNYaJc+k+9dACMFXR4ko4SUB3uVXY8T5vrhBYU4OWCMuaBmF64L?=
 =?us-ascii?Q?qXhECgV+KNFtUyA7LLegEldDWmcAflfiRbQF8NtE73f3l/JbRAa0MoslnD2d?=
 =?us-ascii?Q?r2FabNTxGcXKaEqevKaewZ2oLwhQGSSLTEkHbb/qwc1osxZrV1ktMVwf37R+?=
 =?us-ascii?Q?ohv1tozcXds5URYPsHoMedxXfue8phxMa3jZYSEzwI0GuNktbAPAeIDUMqsF?=
 =?us-ascii?Q?n1fLsm0pzuINlZmLatDMMsQ2DInrNTEFlE9jsT7PjvJEHdRUFhwBX5NxbP3I?=
 =?us-ascii?Q?+KTQwwfpkq3jK0MPcAV6Nd2AUXzJqZyg5OxFUJAWWR4g8vF7OIOJaSchapVP?=
 =?us-ascii?Q?TQKMVWBU+fPTYnuWNSjksoCxuH1/4fFWdYIBbMVmk6v4KOpKtt+PSEPs1Qip?=
 =?us-ascii?Q?EeFQlyKB7qH4xOBrPy1s9TeL1TkfOOrWE0nm7tfaYkbvreRpQUw2pUTg9Cl3?=
 =?us-ascii?Q?iy9hlkwYVXwlSqBgj0N3lDnlk8kWgoCT/qC/+iPX+96KlnKozgSUkLVbtqIo?=
 =?us-ascii?Q?Kn50ibvY05CRyJM1z69apLm7OBncXZyTH6xNPQ9s6CiEdOzow9WLUyRNNkoY?=
 =?us-ascii?Q?qXRp3zhQnD8Dh1wK4Sc9qAtajE5KlmsOhgdrNwPyPILbecFP/9Py6OjEXL8Y?=
 =?us-ascii?Q?s+gV79zub2GNA6CvTOZxmp0T2yncMsQfqOLlirCp52SQG8ewaGnk/PmgTxdT?=
 =?us-ascii?Q?Xo26MRH1NerBj50+PmRlqcCZFOZlAd7kjcfZ/LeR3YgxBSCQiLhlx8yEtWXe?=
 =?us-ascii?Q?HVPLqmx7DGBtNNg7OejlwVsN5uH05k7qCwIcqPOB/jHMoIZu1M/CVIEiP/bJ?=
 =?us-ascii?Q?DlBgXZIQ7oY2lX7QDIYLC+E7MN9xd2qqDPS+cqJ5MiHkI30zkREdNvD6XTv8?=
 =?us-ascii?Q?3pgcSEwCsWigV+YDcysOpRkgLm68Rzs2MsG1fGN04wrOQmXFBPIQUe9aqvxz?=
 =?us-ascii?Q?pkrG/IPCipDPlMSxcXZY6jqjiWIhWpb1Ylvbk4yayav/sbBcYoLJjDEH5/Zk?=
 =?us-ascii?Q?jUMSEoY8hCZZiiz5w2Skh+b24hksNqjdNWZbD1EJZBggSXlk6+iCemfBViby?=
 =?us-ascii?Q?iUP1vVCvcit0u3QLqDmANmkhSRQ5NAfPLdzkoJwXwglbh1BzgX7UawDsWBXe?=
 =?us-ascii?Q?p7X8I4ULJWPBtlY3euGkp829OCfMCokHh0gBOyWNKV9VhFhNbpvgykpcEhQg?=
 =?us-ascii?Q?TgaLHJoA4aoTotJdtbBDhl/41yvOepWoVgqqIbfy0YQK7e/nDogNZz0pyxH+?=
 =?us-ascii?Q?sr3oioh6aVtA1LkPDwuYZNNJbmu/+TwlDzZJ11dkuqUTgX2S9OYjPDyJN16Z?=
 =?us-ascii?Q?60Pusqlwdr62udB13KkPKJwPxixWMUneLTt7UKbBEDLkniUKTJnxHlpWAXhm?=
 =?us-ascii?Q?6o8Ahn8By2Be+EHXfHYtQWIA1tfwWzZ9d/zd3MQUXwhicrFJvcRPujaRlLHd?=
 =?us-ascii?Q?+gsuoyYSQQLiqzfpr820/sHH2nAuNBqQWviv2i/LBeumrCbdjlD+e5BAmIQS?=
 =?us-ascii?Q?bk4ohJQ33ZXJUw+N23x0BoqlnDhC7tMrHOKJn2uhNobKqmQYomMSr/cRJ3VJ?=
 =?us-ascii?Q?kqCry+DaGc+Cm0mZfBK43WLsq/o1NCAj0p6wnL0Cf48mqK5zGrZdt2M7ktZG?=
 =?us-ascii?Q?eOYS8ucIggX3ZzRetUNP05JxNpt4GOOPwzZZbNLDXqlh0+fjyMfC3opOtEoJ?=
 =?us-ascii?Q?zGrnn8z4ggVrMweYZg8xQsO3Fu2fsFo=3D?=
X-Exchange-RoutingPolicyChecked: 5Aa5EOChHNEDwhIsMI0+4dXdiAT+8OUbShnDPQec8XDBhpg6splzmKVNhTc744Htbb+TYv+XvLLKrDW3HBakRyte+aCkBir2lVJHkZtoDVDwsF+hxOcyFnIkWAqJm/B1l3bRNTFb+2lSpZagaIr5BDqjsFkARCSnGyHlFjodlwEWcpXnfsPSvwgBFacW4Ra+9ia3vZZQOakLib7o8cz/bNH6XZBQrNoHkxer09xhk7LRENzSf7GsWo0Zzqw0Zya0RhoH2xpc2HTnVomdP+uytUVNzBHggi5Bvj2DeAz1jUbMjZE+LilOLLYVRJSZLyK/R23yosGDW3ZThYNXGhudag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f54d7f2-9f2e-43f0-d175-08df4515ea9a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 01:47:34.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INtdrEc2EEHjGEiArBZLwVkvp+YQ5lQtidC/LmKbR8o5Ll7LFcox7V7RZgEg6iMos1dFlGU6sSdCCtq8Q9dPV/TCVNfagD5+z/VGRbJ+bas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9773
X-OriginatorOrg: intel.com

On Sun, Nov 08, 2026 at 11:20:25AM +0900, Jongwon Lee wrote:
> The low bits of the DPA field in General Media and DRAM event records
> are flags. Bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace
> events print the DPA with CXL_DPA_MASK applied, while
> cxl_store_rec_gen_media() and cxl_store_rec_dram() use the raw value as
> the xarray key.
> 
> User space takes the DPA from the trace event and writes it to the
> mem_repair dpa attribute. If the record has any flag set, xa_load() does
> not find it and the repair fails with -EINVAL.
> 
> Use the masked DPA as the key. Records marked NOT_REPAIRABLE are still
> rejected, because the lookup skips them.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>  drivers/cxl/core/edac.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 42683b7c54..f627c73ff6 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,6 +918,16 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
>  
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
> + * Records are looked up by the DPA user space writes back, which comes from
> + * the trace event and has the flags masked off, so key them the same way.
> + */
> +static inline unsigned long cxl_rec_dpa(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}
> +
>  static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
>  {
>  	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> @@ -1131,8 +1141,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_gen_media,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> @@ -1161,8 +1170,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  		return -ENOMEM;
>  
>  	old_rec = xa_store(&array_rec->rec_dram,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
>  	if (xa_is_err(old_rec)) {
>  		kfree(rec);
>  		return xa_err(old_rec);
> -- 
> 2.55.0
> 
