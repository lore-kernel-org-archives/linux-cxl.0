Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47834A795
	for <linux-cxl@vger.kernel.org>; Thu,  2 Apr 2026 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157942; cv=fail; b=kvAyrhx3zNAGXoQB2bLojIhktDKgUkxtoc5hBoclbv1whR0dleILww7z2y75TbJjQnejJaNVF3t9B+b7UglPWxtD+JfkIUn6vkB/Nwy/18BxO3v9rpKhHppflIMFZsOq3YWor6dFYUSlhLKHK4z8gXdj+li03zfBP2a7tLKyyE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157942; c=relaxed/simple;
	bh=/4EekWZz9nqTz3cubysGc/yPjhxe/l4sZZjL4uhnOXQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uT6t10VpZtsO7LRfpr4g+dJivSwFLs4fSty5tEpgz2mUegDD5Yl3CZyzE2ljemcAoJFJmKIgcD8zNv5zFn/kR4fwK2GlT9m1jhK4YkdNGGg9mg3IR5hUja1r3ccEuAii1EiZvms3hpz9MZB1pER715rm6nbmNxPo6zEpwsz4iyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3YCTTrF; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3YCTTrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775157940; x=1806693940;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/4EekWZz9nqTz3cubysGc/yPjhxe/l4sZZjL4uhnOXQ=;
  b=b3YCTTrFP65CMFWF4sAnBDAv5MKN3ru8PbUyNpm9WrtxuZWxGwtLtlrz
   D+x+VKzijhie/k+LxWUOmiPvAY2CvMv/44XkKS52gtBOiBdjsNKJteubg
   ocFy+IAIkpe5AruCqNAfpPDYlyafcWs59ypkkDJVrXpCnFSJwLudQCfya
   wSMUO85O0HSB5I3XD5Sr1B80+yjo9VoW96jNvwjlglmlAOoNW0zcieqwe
   c+53WE7Dr+A+5kRPf5EPBf3vdSYhgVQuB3EW3YXmjP1rm2EBoVSwviGx8
   MteaEozuzfoh8bRw+M/g2M72WtHWwe+a9RGTATBag7XkDvnCMJHFYbreJ
   Q==;
X-CSE-ConnectionGUID: DdVr0f9xSSWTobF4qqBc3g==
X-CSE-MsgGUID: wEbywql5TPaDpEZg7gXtBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="79827719"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="79827719"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 12:25:39 -0700
X-CSE-ConnectionGUID: NGE07zX5TIuBxwyOss6t4A==
X-CSE-MsgGUID: UpbBqJLhSX246wT17WNZcg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 12:25:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 12:25:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 12:25:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.11) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 12:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBNFZcdwNvBnz13xuVGaVU7iY0Gx6n5qU04tq8cGz9z6/y8Cd5nkSbhB2FvSb7G4rjw8QEM7SY0G2OWVZkjDrEwpjZi5Q65lI7TWRHrpcBKgYPDaYoxncTVsy1id7zd6qKqUDowc99B7d0iv3421J/h6aJfMFndWkkL3oR3LN0vJhe5PlPUg8WctsC4g/t3mRhXSqiRtF7Mhxwjzprfe5aoWQd+2Gx9aGmSZipGKwEDVWmmOtEGPI/djRlz/lUVirpBYz0PWLjAhNx/B5cjDU15WCyVC6XMBjigHjzSYn0gzYMm6I53we0tC9iuvz8uC7Q+lk343ePZibj7gRN5YJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffx3KGe219Vk43MCDzD4pl5OzNv+lSX2k4JAaondu48=;
 b=MksJp1UWu2jgGiuFSQpf0RIsekzyS34axVwMugGr1RwjQbRLB7O+upTULSgfqBzvH1WDe+ky23znfab3ppYrG/sEN0EEovaiAugldHZq7P4cQ9G8uDZ+vu9sVbtbiLblKRq92mL9DwnqBhgnwov4PVbuYjec+oJBx7lecbKfkUSxaTRKdEQt0PO1SbyJzJpP9sgeOvTBALHzwhGZOIUZ1YodQiqrNCyHkR0TjPlduDGSn7EaEPZbzX93119Psw35kaM0HAmtU69zFd6G+4Bp8m2XJ+wSTHTvtMepnM80k7srAWJCDZkiQxI7lUUD3D7Uh+Z4tCYvzsoevUuKIcmCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Thu, 2 Apr 2026 19:25:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%6]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 19:25:34 +0000
Date: Thu, 2 Apr 2026 12:25:30 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH v2 1/1] ndctl/cxl: Show region locked status to user
Message-ID: <ac7Cquc8jm3NbaW5@aschofie-mobl2.lan>
References: <20260401124205.1288996-1-ming.li@zohomail.com>
 <ac1snnLIKRO7EzkM@aschofie-mobl2.lan>
 <e29eab5f-2a28-4bd8-838e-041d148cd441@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e29eab5f-2a28-4bd8-838e-041d148cd441@zohomail.com>
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2482a9b1-7c3b-48ea-2ff8-08de90ed9c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0U/ihA8+p00p6Yl2/pu1DUcTS/DAshpDVq+Z2nlCEvf9cxYXaEmbv7VNAdp4pZUCz4S4LDj3OMcJf7tpOdx8xMb3dcrSvY9mrRN5yFEJ+Pn4oOU7XAqm3jMCS/s9zhIsNntckFC12JI2rZEt/2zT4X2h03vPi9qbAUA9kXseMBhLM5OcSY24mX2C4Hjsm0L6QSq486yKVYtUurcGlhtDFgAruTeZ/5rIxCBq6yuboWoe5y3rxv12uJEGT5/1Em8GqZVToUV24n35bq405ksbJEsPdI3EDklSCw36A8EeCDl9G3MAPAGTc/vPTZWg+fKMIVLTe4g072id2e5m5MvObMiLnHWds12402Oz8Rjz+95M+4wJ+6q6LpvYM25FsLFX5hQx0sGTwK40V0HnQ9hxcy0p9zI7QbFI4hK+3ggN8UwA3zifODjcw6meyBBlTK1oRTyPXet0D6DFAwDYHmscWzTzVJ79eDpYG1N3cmHmCTlCDwHqjgYXE3AbBwFqQ8eOrya9w4ZomkyRH8jB/wwEci2CXrWn5cvNrULLf/ij4Sn/yj7utZh53EOj0fg7ereL0zDptslP2H1/KE4E8mKJvlf5Sfg4Au5oodowwl76GcPaLF+qyIPiHwRp2tC70wHtQNMFSAxdCIdfwJZHG0XPwMYOrQiY/AV4NBNnAXX4dcsJdSGb5Wlsx4VQEayQEuIcemI0cNTH75vKZKnrGtNH/lVCK5GqaOz/nlpTgiO9UcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JPeEFpcGc2eXdHMkc0WWZzSmUrMEdpRmxMU3RBZHg4OFRteXIxOTh1UENt?=
 =?utf-8?B?TnRGcHlJaXFLekZBeVpRZWJiRG9QZ2dkd2xCWTU1WmJBenFsRFBUaVIyUWxa?=
 =?utf-8?B?T3dqaXBmRkJ0cGVDODRCM1pMeGJyZ0g4dHpWb1hCeVVpU05SM2pHdTRqK1Q3?=
 =?utf-8?B?aDVieVYybTkwanNMNnlHN1o1WUE4UFNTZ25qTm9NOWJMQ1gxU0VQeklSSHNw?=
 =?utf-8?B?M0FQUnNkVzd4eElZeU8xbjdEZmNuQ2dFZzgwZStJUzd6Ui9DVzh5MEY1d05T?=
 =?utf-8?B?Zmxha2ZVMW40RmZDejRVdUlMcnZyT1ZtTVdQQnBvYUdjb2x2dzJPVmtkL0hF?=
 =?utf-8?B?a3gzcVFjd3VmakJ0VVA5VFFlc04wNmhYek9xa0pkUkx1T3YxeVAzQkVtbktS?=
 =?utf-8?B?YjRpTS8wc3NOc3hLUEJzN2ViQmhXZHpINTUzbmlFM1FjcmFRUVhDSW4rQmwy?=
 =?utf-8?B?TjJGN1kxc1c1VWxCK3hwdEd0RkxQNVdoUCtvMXl6R3ZwQjhrSGpJVE5yK0J6?=
 =?utf-8?B?QXRYTE4yczF1L1JZMmlkbDJib2ltOWw1cmc3ekYyWkJNVEMyRmlmQjdWdHpI?=
 =?utf-8?B?S0JKOXBvRVlPckdtdDRVQ213Q1ZzajFaQjVZZHZxeHJldk1nUHBUQXMrclZv?=
 =?utf-8?B?WWdHNnI0ZkEzZnZZYnJObm5jTFNUWFRqMnJPV1RrTGJnZ2hBcDFJS2ZpYWt4?=
 =?utf-8?B?K2o2QWdwNVJlSmphRkhuVjZCUGNMTDdBdVlZMGdmZlpiUityaFFpYUtzR2k3?=
 =?utf-8?B?VzdMMmpsb3dXTGJ1c1Jsc0dtUldJSzFKWUdYU3huclRINnA0N0RMdXVVaWZ6?=
 =?utf-8?B?VU8xL2xBc2pncDd0M2JocEdyNno4M0JiS3N4QXY5ODZSNStYRDBpYys2YXVN?=
 =?utf-8?B?TjhJTzg3cE45S0JDYmdtaEtkSDdoMFVKN0t2c1pVRHJFN2RDYVJmbWJ5SkJK?=
 =?utf-8?B?SjlUeUFFMWd4S2tEQk04QUZpeEY0ckJTcEx6Qno1WmtoQnpkM2tHdm96VXJE?=
 =?utf-8?B?UE5NY2F4T2ZRMlppaHppNGE2RzhzWEpsWllQVWo0cm9HMklqY3BHNTRkUms0?=
 =?utf-8?B?SnJGSkRwbW1BaVgzU0k1NUFMUTNYekdSOGRIYnNpNHJCbHFRVzY1QWdqWmUv?=
 =?utf-8?B?MzB4L2pVRDNmcFN2eno1Qnc4NG1iZEh4aHB1M0lQMHJ4WnowMUloc3VuWEEz?=
 =?utf-8?B?QnhWYnVPd3lxSVJuVWU3VHFjSnQxaEp3UEhndWd1U25VUmJCQnk3ZjRXUVkv?=
 =?utf-8?B?YTVjUlQvazZZbGhYNEFTcTFab0lxTmlsdE1jUzc0S0U5Q2crSmo5SnhLY05R?=
 =?utf-8?B?Yi84STE3c2ZCK1pKa3RybWJVcDZ5VDRZeXRhaDIwSFcyVHUzbUw5OWhyampG?=
 =?utf-8?B?NUZtbDFTdS9TS3ZXZElCWERCVTh0ZEVheEN1TjVzYUorZ21TSkhDSnJxb1N1?=
 =?utf-8?B?dnMrNnkyZ0FWM2RBSnRYdDJ2bjFPTnM1YlBQOTgyWWN3Rmd6bEppTTFJcVVX?=
 =?utf-8?B?V2xhcW5JYThDNnpXZjEzbE5JMkhJWXdjZjRWSG13MG1uUnJQNGlsQXNnaDRm?=
 =?utf-8?B?aEY1LzU3K1hwVS80bjRPV055UVhIZ0NTN3ZES2pCS0FkNk1jaC9rQnY3VHdY?=
 =?utf-8?B?UHEyWG8rVXByWk1iZDN6MHJaeGFHTk9ndnVveGJFZnhsSExYMEhGUnUzOWdj?=
 =?utf-8?B?Z1FESXJhMzdGVlRnR214bytMNkloYXdzUUpOYlppUW13MzBuMFdrVlpHendG?=
 =?utf-8?B?blJiMmpJaXg1d0k1Sm1PZFg4L3VsSEYxSXozTXNjSUVlMnF6VE8xcFdpMUI0?=
 =?utf-8?B?R0xNamNjNDh2emU0a1BBalN1dGpDa21OS2NLL3dlT1pOd0lrL1VrNm4ySHpz?=
 =?utf-8?B?cmdUWmFOaXQxemJBVzRMWTRBM2Z3bWhHTnZXREZldytLdmZIdVRQSlhMSXJn?=
 =?utf-8?B?c2d1SWZzNEUwOG5VSitpZGtSR0NrNWZrSTZVbE5XV2hXNEZDSDJXWG1WYUZi?=
 =?utf-8?B?RUpyUGQ0MERVLzY2aTBzZUpoSDcrOXB6UE56ZkdCazNQVElPMVZsZ080Nm9F?=
 =?utf-8?B?RTBudlJVYnpBcDkySUJvS1dya2NSVitTNW5ucE9JNVRZM3IreFpaeUdadUYx?=
 =?utf-8?B?T1FnZUJpcy9ETGhwR1FkNHR5RWJzZUtzd2Q1Q0xUM1pDWFJ6LzVodVBHNm90?=
 =?utf-8?B?QXFKdXpvOW03Z3F4VnVYY2NFeXlDMEExV1JIUUpHWTdFMFRMSXVKSmtZa2hq?=
 =?utf-8?B?UUViU1M1TDhiSys2OXNhTXpKWVRBeUFQRnYwK3YwNDJ0elFwcytjb1VvcHEy?=
 =?utf-8?B?U01nQkdLMVJkcHdsdk8zK1E5cFBYOVVaUDNDZnRYOXBtbko3TUFoVW5ETllU?=
 =?utf-8?Q?JD2ScexbXT0Vs5/M=3D?=
X-Exchange-RoutingPolicyChecked: qTEcewZUUymHcAtpxziJ0dxPuDYeV/OG9SUvhNJ/njQMxDWaAQSBVhZ3T808h6rZb05JaoSp9r+rMpf94HcKP19XXPCGBEr6aAX4D2qxeBLZ0kDhvw2ZStTjvxqazTHGEsrxaStwyt/aCYIRjBGLlRMt6CD/94nssyXfoyAYlbV71D/k4QTARr9jPXMvLLhwunIqfP6qfaKTJtQQMEfMyk4CxnWllTshDVzQ/uqid4GstibnFvvzg/3TWrn5tZ8sWGqh4kY8GXWHRVT5krNEHSx+IRaTAl4yxcXmW139Ibxyz2YJwRNhzA5QdnPhAzCX0nw4pnYjwiQ7TJQgabByoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2482a9b1-7c3b-48ea-2ff8-08de90ed9c74
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:25:34.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgS2n9/8+nRkVScbo+9JhUVJRiNsKY7hRo5SJLnx/f+oDeJSq7bxrjNLyx2IdksF3KAuC+oIVfJOFvPnmjCHnfpWmw48PW6Msig4P6xCLyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

On Thu, Apr 02, 2026 at 06:29:26PM +0800, Li Ming wrote:
> 
> 在 2026/4/2 03:06, Alison Schofield 写道:
> > On Wed, Apr 01, 2026 at 08:42:05PM +0800, Li Ming wrote:
> > > A region is not allowed to be destroyed if it is in locked status.
> > > cxl destroy-region command will fail and ask user to try it again as
> > > root, but it is not the real reason and it will confuse user if user is
> > > already a root user. This patch will show the region locked status in
> > > region information and output an explicit log to user that operation is
> > > not permitted like below.
> > > 
> > > Before the patch:
> > > cxl list -ir region0
> > > [
> > >    {
> > >      "region":"region0",
> > >      "resource":53955526656,
> > >      "size":536870912,
> > >      "type":"ram",
> > >      "interleave_ways":2,
> > >      "interleave_granularity":256,
> > >      "decode_state":"commit",
> > >      "state":"disabled",
> > >      "qos_class_mismatch":true
> > >    }
> > > ]
> > > 
> > > cxl destroy-region region0
> > > libcxl: write_attr: failed to write 0
> > >   to /sys/bus/cxl/devices/root0/decoder0.0/region0/commit: Operation not permitted hint: try running as root or using sudo
> > > cxl region: destroy_region: region0: failed to reset decode: Operation not permitted
> > > cxl region: decoder_region_action: region0: failed: Operation not permitted
> > > cxl region: region_action: one or more failures, last failure: Operation not permitted
> > > cxl region: cmd_destroy_region: destroyed 0 regions
> > > 
> > > After the patch:
> > > cxl list -ir region0
> > > [
> > >    {
> > >      "region":"region0",
> > >      "resource":53955526656,
> > >      "size":536870912,
> > >      "type":"ram",
> > >      "interleave_ways":2,
> > >      "interleave_granularity":256,
> > >      "decode_state":"commit",
> > >      "state":"disabled",
> > >      "locked":true,
> > >      "qos_class_mismatch":true
> > >    }
> > > ]
> > > 
> > > cxl destroy-region region0
> > > cxl region: destroy_region: region0: Cannot destroy a locked region.
> > > cxl region: decoder_region_action: region0: failed: Operation not permitted
> > > cxl region: region_action: one or more failures, last failure: Operation not permitted
> > > cxl region: cmd_destroy_region: destroyed 0 regions
> > Sorry Ming, I missed previously-
> > 
> > This always emits "locked":false on kernels without the new sysfs
> > attribute. Please make it skip the emit in that case.
> 
> Hi Alison, the case you mentioned requires an extra interface implementation
> for checking the new sysfs attribute exists. Or a new variable to represent
> if the new attribute exists.
> 
> How about just skpping the emit when locked == false? It works for both no
> the new sysfs attribute and the region is not locked cases.

Skipping the JSON emit when locked == false papers over cxl-cli output
while leaving libcxl unable to distinguish "attribute absent" from
"attribute present and false". Since libcxl is a public interface for
other tools, it must not collapse those states.

How about a tri-state approach exposed like this in libcxl.h:

enum cxl_region_locked_state {
        CXL_REGION_LOCKED_UNKNOWN = 0,
        CXL_REGION_UNLOCKED,
        CXL_REGION_LOCKED,
};

enum cxl_region_locked_state
cxl_region_locked_state(struct cxl_region *region);

Then cxl-list can omit field if UNKNOWN.

> 
> 
> Ming
> 
> > 
> > > Signed-off-by: Li Ming <ming.li@zohomail.com>
> > > ---
> > > v2:
> > > * Move lock status checking to the beginning of destroy_region().
> > >    (Alison)
> > > ---
> > >   cxl/json.c         |  4 ++++
> > >   cxl/lib/libcxl.c   | 11 +++++++++++
> > >   cxl/lib/libcxl.sym |  5 +++++
> > >   cxl/lib/private.h  |  1 +
> > >   cxl/libcxl.h       |  1 +
> > >   cxl/region.c       |  6 ++++++
> > >   6 files changed, 28 insertions(+)
> > > 
> > > diff --git a/cxl/json.c b/cxl/json.c
> > > index a0dc343..3bbe07a 100644
> > > --- a/cxl/json.c
> > > +++ b/cxl/json.c
> > > @@ -1077,6 +1077,10 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
> > >   			json_object_object_add(jregion, "state", jobj);
> > >   	}
> > > +	jobj = json_object_new_boolean(cxl_region_is_locked(region));
> > > +	if (jobj)
> > > +		json_object_object_add(jregion, "locked", jobj);
> > > +
> > >   	if (flags & UTIL_JSON_MEDIA_ERRORS) {
> > >   		jobj = util_cxl_poison_list_to_json(region, NULL, flags);
> > >   		if (jobj)
> > > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > > index 5e8deb6..ce2b364 100644
> > > --- a/cxl/lib/libcxl.c
> > > +++ b/cxl/lib/libcxl.c
> > > @@ -472,6 +472,11 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
> > >   	return is_enabled(path);
> > >   }
> > > +CXL_EXPORT bool cxl_region_is_locked(struct cxl_region *region)
> > > +{
> > > +	return region->locked;
> > > +}
> > > +
> > >   CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
> > >   {
> > >   	struct cxl_decoder *root_decoder = cxl_region_get_decoder(region);
> > > @@ -689,6 +694,12 @@ static void *add_cxl_region(void *parent, int id, const char *cxlregion_base)
> > >   	if (sysfs_read_attr(ctx, path, buf) == 0)
> > >   		region->module = util_modalias_to_module(ctx, buf);
> > > +	sprintf(path, "%s/locked", cxlregion_base);
> > > +	if (sysfs_read_attr(ctx, path, buf) < 0)
> > > +		region->locked = false;
> > > +	else
> > > +		region->locked = strtoul(buf, NULL, 0);
> > > +
> > >   	cxl_region_foreach_safe(decoder, region_dup, _r)
> > >   		if (region_dup->id == region->id) {
> > >   			list_del_from(&decoder->regions, &region_dup->list);
> > > diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> > > index 797e398..7c586f4 100644
> > > --- a/cxl/lib/libcxl.sym
> > > +++ b/cxl/lib/libcxl.sym
> > > @@ -315,3 +315,8 @@ global:
> > >   	cxl_memdev_clear_poison;
> > >   	cxl_debugfs_exists;
> > >   } LIBCXL_10;
> > > +
> > > +LIBCXL_12 {
> > > +global:
> > > +	cxl_region_is_locked;
> > > +} LIBCXL_11;
> > > diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> > > index 582eebf..d074122 100644
> > > --- a/cxl/lib/private.h
> > > +++ b/cxl/lib/private.h
> > > @@ -189,6 +189,7 @@ struct cxl_region {
> > >   	u64 start;
> > >   	u64 size;
> > >   	u64 cache_size;
> > > +	bool locked;
> > >   	unsigned int interleave_ways;
> > >   	unsigned int interleave_granularity;
> > >   	enum cxl_decode_state decode_state;
> > > diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> > > index a853ab6..6ff58de 100644
> > > --- a/cxl/libcxl.h
> > > +++ b/cxl/libcxl.h
> > > @@ -353,6 +353,7 @@ int cxl_region_clear_all_targets(struct cxl_region *region);
> > >   int cxl_region_decode_commit(struct cxl_region *region);
> > >   int cxl_region_decode_reset(struct cxl_region *region);
> > >   bool cxl_region_qos_class_mismatch(struct cxl_region *region);
> > > +bool cxl_region_is_locked(struct cxl_region *region);
> > >   #define cxl_region_foreach(decoder, region)                                    \
> > >   	for (region = cxl_region_get_first(decoder); region != NULL;           \
> > > diff --git a/cxl/region.c b/cxl/region.c
> > > index 207cf2d..8a85522 100644
> > > --- a/cxl/region.c
> > > +++ b/cxl/region.c
> > > @@ -837,6 +837,12 @@ static int destroy_region(struct cxl_region *region)
> > >   	unsigned int ways, i;
> > >   	int rc;
> > > +	if (cxl_region_is_locked(region)) {
> > > +		log_err(&rl, "%s: Cannot destroy a locked region.\n",
> > > +			devname);
> > > +		return -EPERM;
> > > +	}
> > > +
> > >   	/* First, unbind/disable the region if needed */
> > >   	if (cxl_region_is_enabled(region)) {
> > >   		if (param.force) {
> > > -- 
> > > 2.43.0
> > > 
