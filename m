Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03693559D2;
	Thu, 29 Jan 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708866; cv=fail; b=RdUuSGCh9OOS+gLjzTlEhIxsr2pB+i24CELRa1nh6vkAOdjrkWjVLvcTjQqRC96xcwcWDKctVpZMLa2N0Lg9wrPxI4DcuEwU3uCV0VQA/5yehvS2Wp4x0yl8F26wH15VuN2wEO0jh7v757vWtNa0WM52hVYgs1HIMVT0M2X6o1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708866; c=relaxed/simple;
	bh=xral5LH06mhCjVvXtJBUFfGIU2sgyjK9t6jseni4CAo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fL32TJO0v4sIPohC+6efLmYwDRtGXAbaGhY0hKFH/pd3W7Dn12cxnW80ZrRgI57BEoIxz7nPBdI4My670AOlY+DvTkwJi5qJZHMJpGFyynVd9qerZxZVLqXgfa291clul9EGGKLaqOyMEW2Qe2wSTYE8TEHYDpEISIqBQ1VEyS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzWTPAq6; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzWTPAq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769708864; x=1801244864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xral5LH06mhCjVvXtJBUFfGIU2sgyjK9t6jseni4CAo=;
  b=YzWTPAq61LE/fQRKI8WBU0qF8zmutXEdU/Czv8zjShBU/zOW1a6TutBH
   wp8dvABERSg+rncDRG8dTtS01MtgCOsLLV/G4HJ72WC73x8wf87dZ1wME
   zxwL+epfuGGbNd7TkcMPBisnKhTDFe7rvKWJwukETkTT5IMS1dPsbHvrx
   Ygq8MVJs4cGQFXz+5AJlVoF3hzBoZJxZXRXrO0A0Ns8OrDxnl3wl1TEbi
   Ah+MHBtKJQ8Tjq2GUZnOJm4H2jcd48xbGMFepzvnZkV39t186Vh88D+kh
   /TtFj1Dvr74oBASGNHnV1S3SK0qzAlmd+On3qDL2FWhh62sCj0KfcLjBf
   g==;
X-CSE-ConnectionGUID: KUbjVfDCT5ykjJ3K1+17MQ==
X-CSE-MsgGUID: 7ulLQDAjRjGq3UW0m98p2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70930225"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70930225"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 09:47:44 -0800
X-CSE-ConnectionGUID: GVh0fC6OS5Sbvstdge0ANw==
X-CSE-MsgGUID: neu8FIfPSr2pS0i/Lc/+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208880932"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 09:47:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 09:47:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 09:47:43 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 09:47:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCITRtPiG5h5tMoJfRwgdRzXKtnPtcMx02f4TODdvoYrKNUoAXlNbGlb58b2x0SXw30J/ZZ0mT2tcrv4pLH+paLYLRXEsAEXoNP+BpInRWnfRq81SS1fVg0uC7fyX9+Fy9S8/U3lGKt/mI45OVuN14rUWVZqnBATaxqiPIXAKtpP5YD+kuGFbfDe49ROXk6ioWUe0v8rKASVpmoRvRerAvGoA0rt0F9uVCg0tImv73VvV+gtALd5/sQqfBiv/zfGialt3B8xXtFSQ2MFUyCOlhBmxxeG54aOlOKs21eL2SqDTl+mgITsWOYvkYCeAGC6qg4CyNKuF5FWfpF4yYgFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfFzy2yE2k2WsuJDMisdDdFn6AfB4tzWV9JAecgek0A=;
 b=ReuVr1C5NZxWqm/RoCePLKrxzD+hYUgDezy7MbguC3x8oI7ZIqeZ3CrQgVD1gSO5JjoNDKJrOmPfVX7IHmGZQMBaC+fg9DfOpsSZmwM9dSmQqF31DYlNZ+vjNz9r95j+g+I7PQYqwP1VWbFkBYXJNw3jDRmob2qonovebk+ApAPlYFxEzJxSn7KhcvTGF3m0jBvcS8IulpWqudsaPaD+BIK+rMGNiOQ7IqzCNZvlB9z4RD3jIko013TtN34mOevL7uAzdRmeSYjopLPGbrMTtOf08xb2o+thrLJVQcJfOuA+aHAwzfUOhJ7KAm0pTMvIiOCPSSHnubfs684XnTSKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7210.namprd11.prod.outlook.com (2603:10b6:208:440::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 17:47:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 17:47:39 +0000
Date: Thu, 29 Jan 2026 09:47:35 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming.li@zohomail.com>, <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@linux.alibaba.com>
Subject: Re: [PATCH] cxl: Fix premature commit_end increment on decoder
 commit failure
Message-ID: <aXudN_vAy7frUcWM@aschofie-mobl2.lan>
References: <20260129064552.31180-1-yuxiong.wang@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260129064552.31180-1-yuxiong.wang@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ee1fab-54b0-4b60-3fa7-08de5f5e7f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HuzKwOXcen0esqHRIekOSAdfsCR2DPL7o13EhNRTlDCSrAGhyP0PPKfmbaSN?=
 =?us-ascii?Q?8/cFG5EgY6oiC9f4N+vfXrUyglem6f0Y9TCpGdxF9/Dv5jmL2Y6GDUGhaXw7?=
 =?us-ascii?Q?Zr2BThqb6HdliEL5QRlxChbMMWpWFiXttnWDJ0o0KptCfotHQObi/75T//iR?=
 =?us-ascii?Q?pvVYi+sYd1Dbl0A1EJyNQbxKcx2Impta4UOjPvxyfu5ERV/JoHuVliTilVp5?=
 =?us-ascii?Q?HSb6naAtE12GpKVyS4yBg5U24O0fKU1kQGAdN0gyk8yx7utLGxHPBu6nO5VI?=
 =?us-ascii?Q?YpulJWZCs9382LMiDudjDQyDEE2zXCbictw4qejAfiJAh+QWD25RSOlDe8KZ?=
 =?us-ascii?Q?MHxJJfgFvoJvpHJZ8MLUCt6JPpNI0f1SC5Lk9dMGatlupJc9HP3jZFdH+0rd?=
 =?us-ascii?Q?/T9OR8I1pVQSJv3PMKw7M8w6f8davTyIZqrbOYK08Wt4y0Q22nUsyKX8suyj?=
 =?us-ascii?Q?NwKhWWHow7HNB+niiMTmRGa7KBKzlcakvhUs3yJ04qSGkNi8PnQexF60RVVI?=
 =?us-ascii?Q?zwckW+AZYPvIEPGOSOn6RuuVGYyMDZ4uzN4+9Vh3ZIM492roJQUGKjfpFo7d?=
 =?us-ascii?Q?DfsUZv85BWHKcID9GHHF0DajMFLHsDbipbakGXpLSo1MTl6ecaFAa7uDaCOh?=
 =?us-ascii?Q?PbX0N4/8cRzPy9EpgGCT4zugoK0dvCX6zsQ6+bv7pwGknk23A8WoVYxwE+Fv?=
 =?us-ascii?Q?716UAOzIeUjn0pGwgTuGc6Rkt26hAJ2nxVtBQdBAqHW+1QQM/BYnDL1jPTcU?=
 =?us-ascii?Q?LdulZaCKzQFh9uPccmRsHeHBX8Jm2EpfGU70BdPpbNvzpMGk8Oe//6g8Foye?=
 =?us-ascii?Q?xqIcxlUOCHMBgRCzDHQTa+VebscTIyo+d8bvPMupQtXp1fI46+4/ejndeDlY?=
 =?us-ascii?Q?yi8h27xgHfsxSHUpdRbhTMN309PLcUM6FyEI6ylzsUYlELzE0c3G5KI0d1Bw?=
 =?us-ascii?Q?0TjwNPeormzi9A83JkKPIK2LPrNzeo4N6C5BF8LMEb7HMulIMxHP0D8cnhno?=
 =?us-ascii?Q?zAxrA/2tBlVBQ4Ou8IHEDyAc3nypNos9aJCsxDKOiojWokgy19nto5uX9R9Q?=
 =?us-ascii?Q?rC3qdBS2dusz3cSEncQ40UHYYL6QpIE/0t3iLzFMdTO0iNZWFiCDKMv6H48a?=
 =?us-ascii?Q?8sWUDskuY2Zsma823scBh2pZ+OBZCgNZk3DToX4XNpZyTXO1Wf7/RAOvMfmg?=
 =?us-ascii?Q?a+FOn0pFtP09U8N6qdxnHQGBkTTwy3m5t12EJaGt5s1yZXlu84qehWcaw970?=
 =?us-ascii?Q?EEWELN0bwW3ZQTeAmPWRwquo1Xfaf5LCLuLPJwc55x+ieZ4Fj8v52yzx0YGJ?=
 =?us-ascii?Q?lc2LFMLxBL6PDsosm2t46mu9qKjYdjA9cixK/Uj9dQ1Abfmt/anHBtwqstTR?=
 =?us-ascii?Q?ejP5lMfJjqBIYBkWWNQKVYu4q08J0OJCGwZv1zmnY1zzIaw2aH5EIVysnI96?=
 =?us-ascii?Q?ptG89b75Gabkqx+jIur7MY71gIWBozjS9ieoY6CzuSJizVC9toX6zAnES9b9?=
 =?us-ascii?Q?hxjzkfUJli+uoWbkueD6lzqhN+SRhju1lqBAdHj7+ZrHGMPkiw+vjALtk7om?=
 =?us-ascii?Q?3Dl3oKb/UNPlMz8p9aNkTSiPRx4RKC3uJYJCZTGu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ZY+Iu4H5Kous+vV3vVCJO4o/9uaqbmZlWmX4qglrJoObp8owMGWswpEVmuZ?=
 =?us-ascii?Q?55+NygN4wkoCKVbD+a/l6fjPs0jWUXbNMkyH5Zuv+rMri/iyufCPIfLzcTWB?=
 =?us-ascii?Q?P/Y8IKv3TgelKx3LSh9sBGAqBD5149a27QG2duxti4I7CjNMhtldO68jgfGd?=
 =?us-ascii?Q?+xzJw/+UqU4TVjOJkfEO/2fnASeG7KaZjvWAo74rAHEeooQF+JFknMkyWQMA?=
 =?us-ascii?Q?2K4PW7weSpPKx8x1+2CNKbxyXL51E+41se7PbqIT1JZfqvrMXQlwekAeSuO0?=
 =?us-ascii?Q?exa7ob7oDjWG1wqiCQMv+BroGbkIspsxO+d3PNlgHcOLZc5zTWzFAv6Hjkt/?=
 =?us-ascii?Q?DV89ipfsBQfgGSIGB2YmoRCF2Kkyc/f7egY6h4RrU50HtbGXRhAfX8rJloA/?=
 =?us-ascii?Q?Y6yc6nEbZyWpMPz9jv45OFDeoZ7EOj82BHxC+7OrHWDqXOMyuEQJ/s8o8s2A?=
 =?us-ascii?Q?phnli9w9CawEVXjfoz9wrnIqz8x2QLNefFu4es7pQTWvS/+2ZLwfrrYV1OkW?=
 =?us-ascii?Q?HAmEh3GdYhPvMB9cdPlPFc5NuWVsR0AJrNgJVzWwsI0K16BKTQ+T5s0P2BSN?=
 =?us-ascii?Q?s/JLo4zXN/yhoNDX56/JynuGTxUKFFVawUpBNGQYToDutJx0HcS+uALqtHTg?=
 =?us-ascii?Q?4E+aKT5maaTXmHmAYqyXSZRssFAZb7ucLGK+trRxkIb5/LD4GGkOGAW/H9/p?=
 =?us-ascii?Q?NNyVgiBelIkjj7Ypm+/OgU6HfJq6JQyq5EsGT1YTUAmy4Yar2gqZJ1pY7Cea?=
 =?us-ascii?Q?cNBjQTyKsY8QLsMr2tDkFx5gZ43EPN+LMVPFROA3s2MQKx9ngeLmRg98+G0F?=
 =?us-ascii?Q?SrZWoECONloh2a6nPBqYbR37UWzDzDFHbXyzAaYb7JwuBe+75bs6pRVHwMUA?=
 =?us-ascii?Q?xPqQxRSX3U5+GxUtLQR0OMXyktHej+gu/+kvlwzrkmNyBwMdBbWgYhb5trl8?=
 =?us-ascii?Q?PzOVaEFYu9k3ahzM8uh6VrkFUHmt7PBXVe3OBtpjWLbu6BHQVduaYsMSUGcI?=
 =?us-ascii?Q?KxW976RMiInilKU44bbQa/nMcPoNbCuuMFO0qi8wiXa8HTUxfrj+8sdu7j+Z?=
 =?us-ascii?Q?W/TfXTy/R87UpEcsdvk2JX/fWhslwHACljqxLaEW0lspdZx+2o8Fub6efW7e?=
 =?us-ascii?Q?PtUXYAcgGHXx2WX1R+/0fwCxhXyMPAMZ+tHD4kDIG2dQUOBvqD9+uhIXwcQK?=
 =?us-ascii?Q?XJIx91JnYlxlgST1ecr3HjE8y7YRzCb0LIcd/Xg2NBJXFGzLnd1xR/iHLTzt?=
 =?us-ascii?Q?YPJZ8FKze0cjG9GDQSWBUWxUhX/PW9ibj4W8qtf7+c4QnDvZ2MIV54laJwqp?=
 =?us-ascii?Q?0aLM7UIHygXHeNOL5DWRtQgGYRTbLthPmYpWNOiB+LBiET4Ykw502R9NpDKc?=
 =?us-ascii?Q?8IUnSZMYMYy59es2rT4YaMlR/bzHo/r3vockmiI923fqQZleN7dmqa47t+LU?=
 =?us-ascii?Q?HAvJoY50N2D+Gs4ww7sZkuijcdIpWj+Ysc74LlaLdvEFA00Y0chwWe5/c59K?=
 =?us-ascii?Q?sEsLq/Oe8lcwoROlSO+stBkh2/36h/rIg93CdiCg9skmUoQQ2lSI2sVpy7pZ?=
 =?us-ascii?Q?aMonl4VKeEWI8e4Bwe8Mikay3UZHSEAIqVEVapbAZsuupP3j1OwWDGqA4nsW?=
 =?us-ascii?Q?l4q6E5+sLmT8fzn7bFCpNgcTqKxYQzy6hm/xai9zY5zLezPIECpAMtlm4WX2?=
 =?us-ascii?Q?s7BYqz+RSUns2oN0gANDWDDD6T0MYRdpkYkB3RRW1DEH9wiQI6T2YEjTU/OY?=
 =?us-ascii?Q?d4wzMpbRezIkfagPK4wOEZhiCpTeZIc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ee1fab-54b0-4b60-3fa7-08de5f5e7f0e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:47:39.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUEYf6KgzIcJBDUAemIM0bo/hoC1g3xUt255FN8AeEGZBvVqVbRpsZVKsnfr9S5uzNuxIMwgLhpHcyLFUK/8Sgg01e4SjO180fHo71a5O9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7210
X-OriginatorOrg: intel.com

On Thu, Jan 29, 2026 at 02:45:52PM +0800, Yuxiong Wang wrote:
> In cxl_decoder_commit(), commit_end is incremented before verifying whether the
> commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
> after a successful commit. As a result, if the commit fails, commit_end has been
> incremented and cxld->reset() has no effect since the flag is not set, so commit_end
> remains incorrectly incremented. The inconsistency between commit_end and
> CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
> operations.
> 
> Fix this by incrementing commit_end only after confirming the commit succeeded.
> Also, remove the ineffective cxld->reset() call. According to CXL 3.2 Spec 8.2.4.20.12

DaveJ - Maybe s/3.2/4.0 above on applying please.

It's the same section either way but lets encourage new references to use the
latest version of CXL Spec.


> Committing Decoder Programming, since cxld_await_commit() has cleared the decoder
> commit bit on failure, no additional reset is required.
> 
> Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
> Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> ---
> Change log:
>  * Added CXL 3.2 Spec 8.2.4.20.12 Committing Decoder Programming statement. Thanks
>    Alison.
>  * Collected reviewed-by. Thanks Dave and Alison.
> RFC Link: https://lore.kernel.org/linux-cxl/aXqKC-bscufh1ggq@aschofie-mobl2.lan/
> ---
>  drivers/cxl/core/hdm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index eb5a3a7640c6..912f648a6b7a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -844,14 +844,13 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>  		setup_hw_decoder(cxld, hdm);
>  
> -	port->commit_end++;
>  	rc = cxld_await_commit(hdm, cxld->id);
>  	if (rc) {
>  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
>  			dev_name(&cxld->dev), rc);
> -		cxld->reset(cxld);
>  		return rc;
>  	}
> +	port->commit_end++;
>  	cxld->flags |= CXL_DECODER_F_ENABLE;
>  
>  	return 0;
> -- 
> 2.50.1 (Apple Git-155)
> 
