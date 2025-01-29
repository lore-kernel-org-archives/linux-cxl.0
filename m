Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB71E0DFE;
	Wed, 29 Jan 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738185423; cv=fail; b=fZFmWUvmSxLKkjMbrc910jUEs0FpHqexFYDN8c7lUP6s0NSygMhNCbMAVPSNiL4u3ja7YWd7fqZznUKxIvW1ObTTftAHzsbO5gHp3IPU8jAxPVhaoz9BwiHO6I2NIII2iKscHDJ9su+RjAP0xrvUmtEFl03TmBCGvmziBX/x9Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738185423; c=relaxed/simple;
	bh=yfQhG+Ef1eX9jNy/B/TqhYQrJdMcxklgMCLbFvL7slg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DG91qo7s7aeA7G/fxPJf203lmWPWlqbNrrnPfuSwOzuDSY+GUiba1Q6OoogqRPefqGJjAxu/qJI93NSgUoghsieGK6LP70bdBAxb2D2zBaXyfjH+gPQJhWxjhyTP0WvvMy2UyUKIS98f0Rdz1oLutiBMSMjNhBhUUPkZFgr9bKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7HJzAPW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7HJzAPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738185421; x=1769721421;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yfQhG+Ef1eX9jNy/B/TqhYQrJdMcxklgMCLbFvL7slg=;
  b=B7HJzAPWtILSZioRy1pmKT3t7ib9csiK/D9YCeu5rQIcASjiEU6CzuBv
   YoJkzgedTKGRbOQiofo2XWRaXJ5yqkJ22mTbxw6D9qQk98Xy25Tqyzupd
   Q132G7vFf8zCeudFcui7Kfx5gSz0JP85kq+J7MHYU5VUFJyBUfKM2ukv4
   PZW0W4AUE8PN43Bkar8zI7+uP3YefQa0FHe2SYd1gaFUVkMRiQ5v2+Kp9
   WnM6MxOGUdkjg94R/dOWh2LLBWi0SQ+kIAYhX278E8HKbhambX6qiS2wj
   dQPzjOOboZ46SP+7X6m77iFCGGC8Fy662owMJiL/+FW+LwPWHKKFIFZe8
   Q==;
X-CSE-ConnectionGUID: TBPyT7BiTlSloB5EhpWbrg==
X-CSE-MsgGUID: bO/Jyll3QxGp3ssN7dQUgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="64082210"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="64082210"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 13:17:00 -0800
X-CSE-ConnectionGUID: MU0gVGDwSh2WojufXRjBgQ==
X-CSE-MsgGUID: RksQPCuKQCuUdhFXvKoRDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="109726627"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 13:16:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 13:16:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 13:16:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 13:16:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og6zul3ufHz9P2aHION3FoMcgc/YvJ4c2Bgo3IAAvXDc7XV1IYO4CjVs7Gugo94A4DC7KaZwivYG5SRZFoJ5PCIEfXM8PwMDrOZ+srym+r5pSsg0BjPWvcG6pwlfK1wyP8mwjXg9dfIXKSMB8SMTI6L7Hw7rVVifcjSUyW1Hel0FO6pE25UDjkvkGwVjJ1NzYX5IDVXNqJC/Fk61ARr+DxlWPPzGZMHfmHbA1mxnWWIdJHcy5R/CbVHXD28dkwQsTZJCt1huIBDq8EcuPMwaRDDB0yMOwGVx7NEGNQW1Yj9zb4sqmATqNWJEiwERiNcveI9JNFKoxa3lHuxXwh3/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3+FXq7zd4FVDlSyMlVLPU452uOJqTBfVzeGxaUzAVk=;
 b=UFVuwzSNOYM57rpJWVbISE265mSZhXz7VZa6k8pMPVNLSiUBqGAZ9CSIoBMAE7ea6IPWLQY+QppJHe9kqLKxi7DT0179qCBFPa33nfURm8IBlaeexfaOLGKb4qbdKNaL9O2mma9XxNrBEBCy2Gvr7FFfzu0kkDi7Rb34c33kTwaJw/mOEbPEiMsz/xgv1o0mk17rhbDW2oja5XeJNCBui16gYB2ztNTegC/1x1gVU6eKgKWIoNMFHGU4t9wOVzWRyDgICC28MRCfg7UtUdrCyoXCexbXDQ1OqzKDHlWrmKnf5ps1gRbbf/e76sp9qMXIjgBc7SALe99sfrqYa+VzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 21:16:52 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 21:16:50 +0000
Date: Wed, 29 Jan 2025 15:16:46 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <679a9abe292a4_210e3e294d@iweiny-mobl.notmuch>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
 <783abee1-e06d-45bf-2dc9-920c729978de@amd.com>
 <679a582927d8b_1e2dd62943e@iweiny-mobl.notmuch>
 <074f421c-1f2b-b92e-3e92-c3974f9f471f@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <074f421c-1f2b-b92e-3e92-c3974f9f471f@amd.com>
X-ClientProxiedBy: MW4PR04CA0302.namprd04.prod.outlook.com
 (2603:10b6:303:82::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0e52bc-d39b-4cf3-0858-08dd40aa3f02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5R37yR/nEsznwCyu05FHvFD8b88l/xLkwq3+3zmc2IrOhZPaF/odba1wQp7m?=
 =?us-ascii?Q?1QaAc3sbzHfN4EghPqzoZ3MwSF+xczStmJGTZl0/S6vGTIf97wQAHtjtWljq?=
 =?us-ascii?Q?HHTVpvE5VA+Nudn0NXvgVLE/iRUqa6Y6h6JOrNmaGlg9oAYLVNaKjdm0c+ak?=
 =?us-ascii?Q?BhEtmoAhWzgvS4QMXmdKt9arvaJvrDbQ4aBgMBDOCt7NwoJgXlGFMOR75c7y?=
 =?us-ascii?Q?hMMuFZfGL+PBnxS22DnKEDEWW9/4qiHyCBffauvWjdhyyzj1Q7Sd9CDGIkae?=
 =?us-ascii?Q?7RHpWrvpk8oD4WQRL3y8+eon70cyd5CXM1T9jG1DQkNrbPb0dKolfCe7AsD1?=
 =?us-ascii?Q?cj5532UOSyAWcOnYSlD3jThrmU1wvfQG2pph0iRj1vJ3i5PNUz+8gNB33XB1?=
 =?us-ascii?Q?BJ5nlqsb+FeCw1JPocl+kMiPvXXGOjfbplr1IrILZ/5IKax0WE+83M5SC8NQ?=
 =?us-ascii?Q?C4/xEp6TL+uM7MIkMizdPIQll9Lps6Am66TdkMlv96dxO6FbyzC0SfieQNRQ?=
 =?us-ascii?Q?ZgD5HxGH4W/7CmFcUyD+nOu8jIO26ZmANO437tQeFXkidzcDUPnO0YkKVhKe?=
 =?us-ascii?Q?lyIC3vOiUSHyz7Vurzc9qH2ZFPlGi2quLbECAOwiQDxBoJ2d29uL6DTj1Pcq?=
 =?us-ascii?Q?TwJJsCtatSsaIxgGsLxwYkaCEVVWarihEEjAnp44XCi/Q5aOe3mplVtpDXrd?=
 =?us-ascii?Q?Bs0rHa3LJS5EFKpoRikL+c8S+YCqgZFV+gowDARKJAQp4eea1vfE5VYrTV3b?=
 =?us-ascii?Q?52zbxeQfyGIMtrpjTMKdE7SPhFvfeI1VteVgZu0ib3N9sqj03F3YsSAIIDCZ?=
 =?us-ascii?Q?mI6WomsLlGkxTlkyJCeaMbtjQNrz8Jn+1Dozfi0BBxB1b7fAkOXkEDD3NIjo?=
 =?us-ascii?Q?XD28nUDHlrIqJ3cqQ5MXyX4lTqhuYLq3v1B/iqiTf9HDKbyNjP5QAJoNdjiF?=
 =?us-ascii?Q?NK9gRCC5QtQ1XUa3bTp93pBNCWGVev8NED8lnFvXDBuAamMdK9bjrtvQh4fB?=
 =?us-ascii?Q?kcH7m2k9FbCz4SyD7Sr8cT61qpL4dsLNt5169xjr07hs54rHxs+QYpNRVusU?=
 =?us-ascii?Q?8dfiWzckD4rglfrJ55YDkKcgBgEvrxtYRCytL15J11yZrg+yK1psgkxmQMe9?=
 =?us-ascii?Q?ztxb/0NhNOCE17TevCfF4V2jviIDr9OnWnfUnDdnk7B+u3bJKTu8UTUUjeHQ?=
 =?us-ascii?Q?/3xDfke56Xpo5pYs4IMxHIKkJiJOU2qozPaNEmlrAaum4hEjhIyDSeXm0OzD?=
 =?us-ascii?Q?LLnZLMB1IMVQmyaARYCkPyjRPtnjpbcwiXuUpIKnxSbuwmY5nP9ELiZ8od1T?=
 =?us-ascii?Q?oWdVoUubsE6IP4xQi3iqJKRwc/2mV0TQoFrDNXNN09EYGjstZ6omEPHTDDuB?=
 =?us-ascii?Q?TPYT9vqw8yAJF4c8yI1Aa+zZvnAr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y2brovHwHtWh+MTiZtSuMChNmSxTBEO7cHlxZkjFj6EoTLpzkt0IYbSiCVJq?=
 =?us-ascii?Q?zSAxCwtewfTqM1R4ZSK5KxYLz31QwM4l6J8S/D+4Q7HqMI5Ne5pDiG4xrcv4?=
 =?us-ascii?Q?Oqki2z23YdvnnRTuC4hIC8gHrLzkYyAa+RlKNIEi8Wk9LTqyk6XNJvGUxmVi?=
 =?us-ascii?Q?82qeohf3U1TyvmQpM+sCSAeRmPjfjNlRuqlFhR7JukQc0h+OmWs9DPoPPJRs?=
 =?us-ascii?Q?dJaBbpRvG0jkzrtgFse4dejojr0Zlq9E2WKSFESMP1zussHRGanMWbYSaZA6?=
 =?us-ascii?Q?HWr1m/OTHdWxi8aINXm4q9YLTji7bKXICFHAyjwQdZEEHBpuWB4kCig/e8V4?=
 =?us-ascii?Q?VRBupjb4l+y3ISfkvZZD6fIWchS+cdoDVBvDnAblxJ0lBoP6ozmdkX2uOBGr?=
 =?us-ascii?Q?Lp/ITQAyIX71+rfxNFLfwflnk1Sce8e1aJsvxq1+TbXkQAgxZvjRsBqm5VOj?=
 =?us-ascii?Q?g62IZ7i9VZj08GlP4WA/nILM72HQM5GyTd/YxOJeiBmOu349okD72yBqV5qi?=
 =?us-ascii?Q?/Vj23dywfCMfSpkHDnRAvoAxOF2YrFOni4X7jLn1uAFpzEPwr0WiV5e8tACT?=
 =?us-ascii?Q?ghlUUGaWQ3pqDwz6Af+mL38SdF+kMg/vvFw8m+EUm3Um+On1dVUOU/zoqo5D?=
 =?us-ascii?Q?RTIAqGvdpy98YchIDbaWkjY7ThU7uYgMOOQ1uVb3sAEIU6OoP8va48oxy/9v?=
 =?us-ascii?Q?8/JoxzuPW1fUf0q1RzAXA21Xd9fRRhHz3Ir5gMsEtboeN+SV1KgKJ8UMb4gt?=
 =?us-ascii?Q?2X4bpBGVffvhnGNTo5TtX3ne84RDVyPpWnPwXqsdvDnbvy7Is2yfNPctXcU4?=
 =?us-ascii?Q?CM2jP+z1Dn7C40yd3NTFNmYJsGPt4D8+MrgMmiYfYRVOz8s8M/tlhXwLh28T?=
 =?us-ascii?Q?vhfEY4OrQhKZajwmv8dV+0vt+7aLC4lGO+yN/fiAEXRE454oQbVzGKWBkUXl?=
 =?us-ascii?Q?Jgm0JtdtARxvhuabcLgCPVXd9r19ES69rKtqiYz9kX/prslq2INA1zsrAR1Y?=
 =?us-ascii?Q?Lsc5PTYUhSY0WKJqMhfaIwx3mXxsA2NABOvqDZOFAaV4Qfmn3iejvZeq7V8/?=
 =?us-ascii?Q?EjibRkaq5ejmoKFGqVPYwJ4blO+VBwDA4s5bqsjdckJW4UNYGreaGuwKMMNY?=
 =?us-ascii?Q?ij6rISyI7AD2kTD774UzRFy6XPP1cEcCFsFWro5PufUs5TJ6fPHU+i4jmVlS?=
 =?us-ascii?Q?MibQKPRvXDsvZLdaK9Xzlli2HVaC/rx1svNYKRJx9TOhIm574GewHfcVncuw?=
 =?us-ascii?Q?EpVySaynfPr/N1561wyKZ0+dfagFZAnChR+D5/6VUwrIiaSTBfFBoqFtLsW8?=
 =?us-ascii?Q?r+yhsgXSTt3TxbD2tDTIPbAw2bwc8d0InaNS8I3yiKoZcOoeP+vNRRc0bzNg?=
 =?us-ascii?Q?SJol8/H9tqNMoOfbQaBLhTXH+f9ZOGgAObhY1zVZaT6Ki4Ox0G6T4VWPogjG?=
 =?us-ascii?Q?cULtLh78/JflrCxABPg94baoKkSwPLvFeggoUf31Ln5W+vVyypXTCrRiivJi?=
 =?us-ascii?Q?h4iVyi92FBAwGNxYflFghqdNAXA3IhuaYVSFof7/J2wbsmP8OMDH9YYmzZbh?=
 =?us-ascii?Q?c4iVC8e6hZ5+jYfZ9JCFstLMcZyu/j6+KQpaDCY9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0e52bc-d39b-4cf3-0858-08dd40aa3f02
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 21:16:50.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1FrTgCqY2I/UsYCiqCTATUMVUWv4X7VUbPztkkGSuPNbLokBfXtJoWnLBZPErsW7CppZA8GD4B7Vj7OZ1Ty3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> <snip>
> 
> >
> >> FWIW, I had (as part of current in-progress v10) similar struct than
> >> used here for Type2 initialization when there is no mailbox.
> >>
> >>
> >> I had added a specific function for initialising that struct, but my
> >> idea now with this change is to have cxl_mem_dev_info initialized by the
> >> driver before calling cxl_dev_state_identify,
> > Why is the accelerator calling cxl_dev_state_identify?  I did not see that
> > in v9.  My idea was that was a mailbox only call which is only needed for
> > memdevs.  And cxl_add_partition() can be called by accelerators as a
> > convenience function to aid in creating cxl_dpa_info.  (This and cxl_test
> > needed that function shared so it just got left in mbox.c)
> 
> 
> No in v9 ... that predates Dan's DPA patches.
> 
> 
> Type2 without an mbox needs to give those values obtained from 
> CXL_MBOX_OP_IDENTIFY. I'm using an struct for passing those values to 
> cxl_dev_state_identify for having same function serving Type2 with and 
> without mbox.

But in the case of no mbox where does the type2 get those values from
within cxl_dev_state_identify()?

The idea with this patch change is to only call cxl_dev_state_identify IFF
the device has a mailbox.  Are you saying the same thing?

> I could have another function instead and calling that one 
> for Type2 with mbox. My idea is to keep similar initialization than 
> Type3 pci driver.

Agreed.  But without an mbox I'm hoping you don't need to call
cxl_dev_state_identify at all if you don't need to query the device...  ie
don't have a mailbox.

> 
> 
> >> and inside that function
> > I'm not clear which 'that function' you are referring to here.
> 
> 
> cxl_dev_state_identify
> 
> 
> >> checking if total_bytes already != 0 for avoiding call the mbox command
> >> for getting the info. This will support both cases for Type2, with and
> >> without mailbox.
> > I think I agree with you except the != 0 to avoid mailbox commands.
> >
> > Unless I am miss-understanding Dan we need to get to a place where mailbox
> > commands stop filling in structures unless those work for both type 2 and
> > 3 __and__ are optional.  Because putting in special checks for the type
> > within a cxl/core/mailbox call is wrong IMO.
> 
> 
> As I said, I can avoid that check with a wrapper for Type2, then only 
> Type2 with mbox and supporting that command (is it mandatory if an 
> mbox?) will end up calling cxl_dev_state_identify.

Even if type 2 has a mailbox the partition information may or may not need
to be in the identify command.

Why force any type 2 to call that mailbox command?

Ira
