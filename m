Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B614AD20
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470966; cv=fail; b=aZy42yCJdwcqRIqZbRCxhcUENNxMjdpwhWP0nXVBcWK3CcbpM1YP4zzxTMILPjf6nu5Y2L0NUqFKIRMg8DXQF3A7+QMyBDcuzuxRubN9lHaqxAg80/vDo+pVtOsrz03AnovaAqufJB/xHnP3OFj2OZUVN1F423XX/1GfbOe5NOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470966; c=relaxed/simple;
	bh=gWJwtk0aixVy5sowofvDieI1cuOo+dgzJEPzyMlIoec=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcHJJFIZnz5n8YkK4j0CYMxOJoMvUGqoSvLolN1jjVATT2HzWeTFgjcF/C2SGsYImPuIdD51Wd34TFSN4Fvqe/M/ptWQtcjhdGdmrPnPws6P7PLKxNDh3bRJdkx/XlqVT4lOVkeuDYq8WTlZ4sKoN2GmkQb7VIpnMXgwDwMdSiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAOgwtJT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAOgwtJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739470965; x=1771006965;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gWJwtk0aixVy5sowofvDieI1cuOo+dgzJEPzyMlIoec=;
  b=fAOgwtJTNOPIHRmRLrhPV6A54OGZ1QFCoQn66rrQjZ4EVKBodjXtNNwX
   hY9t9ZL0zLNWv5EbnumHMWa7O/5Day2e1hUcbBJcKYSSBYyk7t+6EcB4+
   Pvfn1Y0NZS7mW8m/qJwvOGwoG0f4r3YPZWDM0YzOgda8xfvb07y2m5EmB
   W8ErEn/3Bc4uBzK9rA2QmQ8QC1pLHXNiEUxFUdb2KJOj1Vx51+t3YzGsA
   gSv7hVnRbhI1R9oemw3sfQE8usZJoG3J1KY7vWTktQeDQ8t9/UrDbzGTU
   9P1UL0CsZCHDQNOXy/bl2YJviry6UBkF/gCuTvpjFVG4/x+0mNN8dBAkE
   A==;
X-CSE-ConnectionGUID: zv0fGcIfT2a1F7sMn7lC8g==
X-CSE-MsgGUID: cWdlg41iSaSmDaXWx/ISEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43960845"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43960845"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:22:41 -0800
X-CSE-ConnectionGUID: m2UBR3yIQD2RgQigEoUDNQ==
X-CSE-MsgGUID: onaov0e1RxSVVwze+xk/9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118232143"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 10:22:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 10:22:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 10:22:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 10:22:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTAgWsQoFywXMB96OXTwBQHzYuElr1bUJvK0YzPx57KhnVuCX1y0BTXhNLGDrmxK0pk8fIhwmqwU9H6WO3REhgO6dPZlGgyKLAPzeXik9Sj0AETo6D7twurxl2x6T03h+613Qxa5T/+Bhfph51Lhqe2ZfH5aGktfGY0QlGlAYd0hOvqqsTwVoq+TwslO3RO9x1mCtf1I2J4v/kqpOWrfsOeOna5s53USj5KA4UP8toxmYkiAe4TAB0f2FmAsygb5lmIelXRZp673tarwfivB5ch5vMsQO8itwhbBTRAqeRrsFb3y+vBASSakMBzug/sNee6n8o8eTd+eoTomLDCh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KDJ7eqEocY/4QwcpLtGXLX0tF4R2sS/wKaF/nGUgq4=;
 b=D38/tGWT3QX9uZfWYYHxbNi82sIUYF+C2UrdUIy/VSbteg7cHlju1IoPzvnJDucj56mH173W3ffIica1QK3Nooi/hKjlfNdFJunOu7Fb+dgTgECl9FC3E+e/kHQnw+xN9edKCJXVbVjtsV6NNhYrn5ZGOw4ZotA1rpQ+bSFEikL3ECEd75UalOGMisoqr+sFq6EFmM+9vTghNIPKyLPK+R7QikLuZ6tgauSWinZb2OrJsEr8kwZMV0qj9m+FFMdxfwaOaYZaQT2vU3sWZHQ/PEedBWLMrFuFwYb6HrGRmN01/TMYuoicymCD+HSbzcFnEJ+Qj+J4XbsZo6uwl0pvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:22:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 18:22:32 +0000
Date: Thu, 13 Feb 2025 10:22:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Saeed Mahameed <saeed@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <jgg@nvidia.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 10/15] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <67ae3865d033a_2d1e29498@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-11-dave.jiang@intel.com>
 <Z61dsxVDH1yZAfEY@x130>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z61dsxVDH1yZAfEY@x130>
X-ClientProxiedBy: MW4PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:303:b7::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: cab51423-0d23-4270-b166-08dd4c5b61a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/YyS7VenGo6iKFNTy1oEFEU6MFsEbcvXXXHSwf+61l38n0flP6u7IUsZcrBR?=
 =?us-ascii?Q?BXxswM5gE2rcNGtS9hElwX36WETpAiFO/Gh2TFg3WXEpaXfLo1E/jLsU2gmc?=
 =?us-ascii?Q?Qz98OlQht/ebkpKBq+q5HjeFmRz0nWZ33OcIoWIMOebJ5waJ46mSRpaA6TNV?=
 =?us-ascii?Q?lgltJv4vcXRR5VA1u+Ff1fcTYilFP+bGc7u5usjhE89rlw3K1epJVgTPMo70?=
 =?us-ascii?Q?/EwY5HRG1qw9CPqJw9L9OgGsKDDxHtfi6J/VBfdMVcF+dtmBZ8wSdihW2wXt?=
 =?us-ascii?Q?wDZZhwu8t8qGrk1kczJFDkdYlwp7q6cE65RBTd9571qabb2k5Bxy6vB/QA0Y?=
 =?us-ascii?Q?5x9hkNOr3UsOnuh0xYIQIRurE6c/cYCcnjoss8OPhmfD1mIUnv5Un4hI1bcG?=
 =?us-ascii?Q?xMih7t2JEQWLTR+9lBmYbqAybV32ASkhHWxvRj2f6X+XsAkQfyhNbs/bQ7YU?=
 =?us-ascii?Q?pOZJMspypHpskFeRoi+Bv1jjJT9N/mYSd0oSBEftYkR1kqbAoPCgShGaDgm6?=
 =?us-ascii?Q?4ObVRe+g4pXzG4+YD9JtKBeatJsNacTIqQl0lZ+xFpYHH+7AxO4j8kcKQuAL?=
 =?us-ascii?Q?39IV4MVK2bD2AgcNULTmBVQk4H9E49WxZfVpmhYcfJU6hInsaOutBrL30LHx?=
 =?us-ascii?Q?jXQXg7p1vFLJNSHalGBiPpKyI5zzMjEBNEM8N0EBM9EVkwxKad6DP0DlMLNr?=
 =?us-ascii?Q?rdhqDfflyvDhFksQPjxzzx1p+FXN311MVjzThPA8ZqVFn8Bvf5PrN8KFMJDj?=
 =?us-ascii?Q?+BdTs1giSOGdCGV0TsXYH+pDosc4Ztws/zfZ6g6mmnsL5SA8tsKd8Z2Vkag0?=
 =?us-ascii?Q?p53rz2uoencffeqoVscWaAfj87MW7UW95DnNxSQMPAzdGeXLTXiaue3lXyl9?=
 =?us-ascii?Q?PY9zXCnIhrv5gfD3ef5dA1VveTgjQ9YjWm+dJz7fWp3WzfA+/iuvDToH9BTq?=
 =?us-ascii?Q?DWw4aAQmj2TBJ+kPR+Q9haZ0SYANcYGP33L+4aJbE+WWCuIIg69VWwxmv6kp?=
 =?us-ascii?Q?vb/nZ0bWtfn2eJWiJCd0Q2WUvoTjjnvZzddOWG1XWKEK5ClEB64cMDi4I6d8?=
 =?us-ascii?Q?V6hqN4UO5QpptTpTn6Iqjc1Mq/LmPX1/rgG3CE50tUfT1qY2EAeQIHD+Hg2z?=
 =?us-ascii?Q?BDzo8HxzPLg0NDv4CohEhkxFKOqZIEC7X041GasNmvpN6s7B4amVGMqrpGBK?=
 =?us-ascii?Q?+AGSbYd7F5Kon5Xp43z/ZBc6A933CNgA+18EUBDzebIyON8B5rsG6rFC67E3?=
 =?us-ascii?Q?kNNQ3PJv1fE53ez5lhFaakCEnenunpxolxeM1Zqf69ePs6BOkqVpwRllQogI?=
 =?us-ascii?Q?gwXf58FeWqFxqGh44gy9YaFZ2nB5qU/uJTCkwKwGXS57S+unHQbXu98AR1lo?=
 =?us-ascii?Q?meADPjbU/SWcAWRg3TGyJ0rT56lM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7XB1I3BgOdZdjDOylw3053fwxf/3K3SAQjY7vla91NGi1H4TpZMCdWtU1FH?=
 =?us-ascii?Q?3AdytET5W2Gny/TJgdIdHXdXahSRFWzVITmziMib0VBqdJ6sbrh4/J41BuaL?=
 =?us-ascii?Q?9M1TwQBCW/qA8hYrDe7o/SnhJc4lRXvQYIiZWdscHNzmf37oY7mUvJ78wli5?=
 =?us-ascii?Q?GIHoMofo8vTUtOGLY5K044mOSVyGOYw3AIJ6AHqUQCZiDmh0Q0PF33Qh/+6W?=
 =?us-ascii?Q?6pwgpfr8qJ0bH07nVfVuxUzLE8izFDcRtFU2CJHbqTttqWc5cIvBu/8BU1nM?=
 =?us-ascii?Q?p/1Z/UAQSiOjjYHM++0f9ytM0rr3ZxugzvOqiJHLA+kfv9N9FHTov9vyRr+n?=
 =?us-ascii?Q?FKJRTra18jneIpp/HzyqMx/AWvwDiaE5gbCrlyBcraeNLbQbErEYwl/vSWKx?=
 =?us-ascii?Q?3P2ggaHL2ohV9ZKzS2KT776F91mllhcXAFlHEBi10fLQueSVYjO+1Jt6rc/f?=
 =?us-ascii?Q?TSd9OBnDjAD1BvnGn5gUPpdMD2t+h2FEZpxroeZS+wMgnN3oAvIoVksDGyzT?=
 =?us-ascii?Q?pOjAN3yircYgLD60sE2t8DManjhkJmMDE9YVy6n0b1s//vLfFgjJn8G4Q/ok?=
 =?us-ascii?Q?R8IGuOapVKdh18TiuOnpZos5eCvJwDWBB+LXWTALFu4IKqmnhGWl/QutCEgj?=
 =?us-ascii?Q?IB0wlVwffKDx9mrDf8aRqXAln4x+JwFDBGvyb4afbmV1lYNgXWe1JyOFUHLW?=
 =?us-ascii?Q?Klyq3yl54Vu/FGAPn3sz4juqVseq5NO2A5AVhwtkA6bKvEZsTh0sWg3kIO0o?=
 =?us-ascii?Q?8lLDnlLls+j99KMKkpTJsqADt5n0fQN99Os+HcCywQ1IOG87484oxu+QJaDA?=
 =?us-ascii?Q?dSIJ291B1bTKMXVpK+UwdUx+mTPhNIC6uUY3uHdu6/1Lx8jMeTdv/38equbB?=
 =?us-ascii?Q?ff6xNyj3s/Z3TCZ5JH0b6Sh/daq7dnuEeIRhBrr0UYr2eFwD1uCYpIHn1Wa0?=
 =?us-ascii?Q?lOfSyQJ0PPoZ862ri2ug9VWHtW3iLkR6q+9Yw9NoA7j71eZEwHmDsXGRBedD?=
 =?us-ascii?Q?1tnTkBV0o1niRPBfKfNvO9IRTknfIdbvTnyqZXFRA2TRvw4X6KTX2U/NIDiO?=
 =?us-ascii?Q?12jBtw5Y0zRTNieYwTf8dsg2EECPzVRzguvC3iV9CSW3m48+jEYqNHJqGwfj?=
 =?us-ascii?Q?FSyQmocooIZr9GVMkMK6PlIYkRaCezgg6OT4PcCcLSyWbfPBbf+gt2oXq2zU?=
 =?us-ascii?Q?OqPSgttl42SK9wykpJMs/ONL2vyZ4a6Kjc9+PDQLB2Hkr5xNn3W0j+z3RlDN?=
 =?us-ascii?Q?owEWppuMgLGVdylm2Toon5/srCx5s3UDEgfGEEpFrR/mQ2GJWG3M+mJm7I7U?=
 =?us-ascii?Q?lNk3ar4OZG3QQ3ZQFQaDbG3UhR1QzOAwEz9lCMhICa/HK+NTvTVKwbyZeghb?=
 =?us-ascii?Q?LfSSKLM87nMLxde5w4IgBDbmkipSj48pWL8a+7ngsPUEVjqrg8REpRjOwFDe?=
 =?us-ascii?Q?NsgwxQKcYTgxzgp/ovtIJ4z1RZHJY4K9XmfKtsjf1Ke81CDwF/maA04ro5VW?=
 =?us-ascii?Q?7hR0E/sZoAqgm+2I9DiKQDtTuktXhaXjt7B0qC+gAofxXrbGZjP0tWRtdTet?=
 =?us-ascii?Q?Tv9bhuw2GDVJhvuKhmbxzkJZEU61NF/MuKmPtkEWbRx5p2Kmg3bcCiM7LbsC?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cab51423-0d23-4270-b166-08dd4c5b61a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:22:32.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghw41A3oAL0c8uhB0ZPljBywkbotF0tWmaZbSJ3vXtYVeh/IowiBPJHV73U9uI0qlIYAhymtxz0OBqRkNQhNa8/M/Q9Ef3ThJq1tbw83jKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-OriginatorOrg: intel.com

Saeed Mahameed wrote:
> On 11 Feb 11:28, Dave Jiang wrote:
> >fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
> >to a device. The cxl fwctl driver will start by supporting the CXL
> >Feature commands: Get Supported Features, Get Feature, and Set Feature.
> >
> >The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
> >it indicates the security scope of the call. The Get Supported Features
> >and Get Feature calls can be executed with the scope of
> >FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
> >of the Feature reported by Get Supported Features call for the specific
> >Feature.
> >
> >Only "Get Supported Features" is supported in this patch. Additional
> >commands will be added in follow on patches. "Get Supported Features"
> >will filter the Features that are exclusive to the kernel. The flag
> >field of the Feature details will be cleared of the "Changeable"
> >field and the "set feat size" will be set to 0 to indicate that
> >the feature is not changeable.
> >
> >Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >Reviewed-by: Dan Williams <dan.j.williams@intel.com>
[..]
> >+	/*
> >+	 * If the Feature setting causes immediate configuration change
> >+	 * then we need the full write permission policy.
> >+	 */
> >+	if (effects & imm_mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
> >+		return true;
> 
> I am not sure the security policy here is coherent with the documentation
>   * @FWCTL_RPC_DEBUG_WRITE_FULL: Write access to all debug information
> 
>  From the documentation these features settings in CXL should only be for
> debug purposes, a bit confusing, same for below.

Have another read through the FWCTL documentation. The reason the term
"debug write" is used is due to the expectation that FWCTL manipulates
ancillary functionality of the device. It is "debug" because FWCTL
Feature support can be disabled without losing access to the primary
capabilties of the device.

For the same way debugfs enables some non-debug flows, but is
disabled in kernel lockdown scenarios, FWCTL enables some non-debug
flows and is disabled in kernel lockdown scenarios.
