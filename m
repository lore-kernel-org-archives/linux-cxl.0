Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8D155300
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737099191; cv=fail; b=BWfGKEIApg+rEs5dwj4xadeHatUyCBRWca+2jBG72d8E5pAfztik/n2JHYD2U0HkVzR6rdE5rOyMa6hKsmq9xXlWIB4q/9p7QuWvPdEDaX8PbgfCPPj0ujOJnCoX3PFhHWcOHFPe9j5OoqIjFEbEVHmbFzEl/1NmivM/HPWmp2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737099191; c=relaxed/simple;
	bh=J0LTMwDZcSFB9IGwKVnDMt5cg5T1pi+jzC9TYbc8ZMc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NRCIzt4OTgV2t9PDoSPbcyaf3PIXEBgOin0y+afZ249+ilDc2Tp1SJdoiz56VUQElqOAxvUtxux3c+RKDo3RxI9HfD0Us+gj2fWfIV43p1L444bgzlzOQ1MUoo6DTD2tewL4dmYBdHtgrD/ET7oL4w8XKnKnvf6UinGXEkDsPGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJlby+dn; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJlby+dn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737099190; x=1768635190;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J0LTMwDZcSFB9IGwKVnDMt5cg5T1pi+jzC9TYbc8ZMc=;
  b=GJlby+dnLN8ffTGVNeBIRlVFQEUXdkSDOXeGe3tlrfYz2SIEiqYbbwPl
   FnSfnr8czlkO2H5MRj059NWSFuDvYUf0Orcq+9fHiab69XpRCf2sjEck7
   QGYwl6gJKWwzrN8gWglojz6Q8xPW2nfXQiIRaUorCADqYEDc3+kYURyUW
   9fajkxG9BQ+6XrTg2XNTjwZL2I3wEnyNXXLk40bVuNcgH6I8/3ht66hi2
   Af1qGBsWMAVBTINE2kwmJWNPS05aV1HVh7swx9z5oPIVGWiKIilpXXXpV
   Y3RN5dh1jh8bxMko8949o02Sa/sX97pSIY9tmGPEQJ3SKITMAffm2S217
   Q==;
X-CSE-ConnectionGUID: huVyfq9oTT+ltU3XbkYf9w==
X-CSE-MsgGUID: MlbyxAgpRfit3JccpuXezA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48185933"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="48185933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 23:33:06 -0800
X-CSE-ConnectionGUID: jUIcZo5WR+agXZ/Gx+mZAQ==
X-CSE-MsgGUID: RwFHgrjlTQauJocn97gVqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110365266"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 23:33:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 23:33:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 23:33:05 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 23:33:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uk5Dn9TPpDG4fWUnu+jUn54j4yzs0ywsFlzC+IAvyTQtRimfkHboj0ySJqyZK+EX3TMu3tQQ2cjknytgKwJl5DqQJh6s39cynELsOLjKLkFz3tndUjC/NJYJVDtTLi5IFVWOKE3pAhlBlvLW88J6nUGJ9LSWYcyalcnGWJfKwIRZ2AMQpRyQ2VQZ18/PjpWkNAtftbzs+7M/4LF/p5cknrNegMiHcD2Ez8f1B0NxZItkCGix7+g9iSOg2q3j21aGEcJvQMQnuTLCRih4F2RYBPcXCpwInmjgafrZ4L2PlIj02gI0ykaVeKVykMuNb5AvFaza/WB4Pj2iHoCxOk5Nbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKoxMVcp8hs5VL0664ZRv2/SP7QX/php2Q8vU9N3kEc=;
 b=K/EEM6bi1lN49XBTbbeG6X5T5fe7hw9tBhzSKsudsBFJ4aPJWCYAYtDyQWYkbdoTXqH34r44krYcETMJhiNW7K+95ESh4qqGC9nk12bCCLMTxMS/pp0T+OZQYBMGNI9cEh8EMGM/gi0SlQkh+giYqw6/GFRgC4Hs7DQ6NJyRPdshoHPiJeEc7WhuXFzAhM3Z+/Vo8oAqRwKRKTAwxkIdDNP71ZCB/zkUZNDna3rtjuvCQ8oQBBfqIVo63/EnD1hZdFGH7SIuAKKBgeASIjOFJYuxApD1oecNep88okALrpfuumH6Um30LNmI0dXKznkV7XgV4Xbg65g/c+gmuVRNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7041.namprd11.prod.outlook.com (2603:10b6:806:298::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 07:33:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 07:33:02 +0000
Date: Thu, 16 Jan 2025 23:33:00 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
	<dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <hch@infradead.org>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC 1/1] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <678a07ac7c975_20fa29464@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241220164337.204900-1-dave@stgolabs.net>
 <20241220164337.204900-2-dave@stgolabs.net>
 <6789c06b84028_20fa294e4@dwillia2-xfh.jf.intel.com.notmuch>
 <20250117071748.ss4rm7y2mdzdvuaq@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250117071748.ss4rm7y2mdzdvuaq@offworld>
X-ClientProxiedBy: MW4PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:303:b9::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd47769-651e-4c7d-08bd-08dd36c92cfc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?46ra8P9Bz167I82UNJ1pylNR9Py9zNx40+krGHJ9E0+gfh1MVECw01bWzNSj?=
 =?us-ascii?Q?Px9cmk6KeukloygeCMJlkggINBoVC28yvURDDtby9D0pUOpOBQlmrno8bM4N?=
 =?us-ascii?Q?yHUbRUYPRwUTBZgAxtQYZca65OK/ERiLeVrwcdFhlJ1VGCiKG4f8PbqgldqT?=
 =?us-ascii?Q?LopJfCCamLRUXw3paERo5JsiAKMbbPyFHbLTdNIX0rkC1pGCvc/3DRcikmXh?=
 =?us-ascii?Q?qrP7EoSltm5CucX5pcu7UDZEd4mFZy0Eciutt5eiqMy3Pskn2xsFMck4y6fp?=
 =?us-ascii?Q?uXJWl1VBGEoj2x+HSYxg831/++aEv8Rg6GzdVJ/ZvWbs2nc1Zv8Q0/u4v9ts?=
 =?us-ascii?Q?3m8H0yTdpV0nvToLTiErQO/XS3AR7JMYdrvpebQvHG5U+4H+gf57OwIaCV3S?=
 =?us-ascii?Q?B3btrCDJ0p0+8urRmsT7BJheW1/BVSpHRFEmaX4aL9tbn6Kpr/FqlghQ5vi2?=
 =?us-ascii?Q?MMCN7zGqGGMzYnJmpoNsFSGd+XHydjc2XklJwieiKVKJJi8ZAdfRC3RYXQ3Z?=
 =?us-ascii?Q?8ik+SRrfAqT3+DSx/wXYZ70fo3X2sekfXhwkWRjCuCAJtsmdaKcbskXT/stE?=
 =?us-ascii?Q?oU4LaZbAxZe1OrfIYQLU1yF6K+XJsUxm5eRbUdeGcovscTdH6oujP60EHZYp?=
 =?us-ascii?Q?v2JRWw6f5Xhbs9h4qseBZVO/hhzXkIaUTwwQncoh+TUs3PtygiXvIaxcJkzm?=
 =?us-ascii?Q?Nf32SuicScvad8cqhNHTN3jX3AKzoq/K0i1u0o/oklv9QnGuNBONnjRKmzeE?=
 =?us-ascii?Q?X39iWTikG36OCfBMcADGkO/gYqJiMryHE0M16cZEE2erXXUOiWjhZJR/yixS?=
 =?us-ascii?Q?PTJ3Bio+BKsRkz4YvnrH3TOYVB9EcMYIqpxbvvxTNLdYiicCptD+2YpdlJK7?=
 =?us-ascii?Q?3eU/2E21iCKhP+aO8wM26QJu7pVZ9Tu9mCRwjF75pmOFj9Uq+tE67pWh3C22?=
 =?us-ascii?Q?JO8/qnDugRy04pnkezJb9a/F9wJzME6GvtVwMP95goXK68EVteUQKvkNFic7?=
 =?us-ascii?Q?qq4ggRaMANyE+OIVhTa/VG6Nn6kEB1jDTyEv1F+C/Ow1tyIk/YDZ61Ojy3Tw?=
 =?us-ascii?Q?PPxfs9mNxRGwvaOCruW4bx6fhf1QLrsfxjZDWuNMWKNh9GZK2cfdhN0SvTC2?=
 =?us-ascii?Q?lbHlUpqFAutPYnuAK7vWbGOnINSd99t2Oua6MncCG0du/Br2ovvzhj2u/ebH?=
 =?us-ascii?Q?Bf7Z6REu7n2z6mq+aZ7LdK7QOjbGPW+elewf+BKBijwe8rzFXm1ZNRiQUlFX?=
 =?us-ascii?Q?xkSxT5iuuopjUEeECkSI/hR0KLhqiMzpmpz9SdBt4CQvrC0BTWbFQWM+CHoX?=
 =?us-ascii?Q?pMzFKSBId5VoNVnQiB3gMWcBsIa/meurm2In+xGQtkbMOd74z9v7wxotyKn3?=
 =?us-ascii?Q?AmAG7MuqJfWRzg/vKhSAXzGMpkbm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+lww+dRgIKtYw+fYenXrTypFQ6+OUc6eO0mNiK3tK66sN7DYf9pGA9PU8WJ?=
 =?us-ascii?Q?uktM8strYYjXpfDocSO2DD742s258MAydJAzleZSfkPJkfxY5evIQ+753Lu2?=
 =?us-ascii?Q?luaLx2sIIZd47bmFE+JnIoNsgbA3xA+hLVCnhYen8h4PcigIAe2rwTQN8X7L?=
 =?us-ascii?Q?ftBihy1hT9czRbPdk1BoDoM9s3LmtsnLo6fVHyJsty8Pogf8ritAR81vLg1e?=
 =?us-ascii?Q?LUwUAAsEwGgkscEHEEptUGUlnRWTCci94LlTWypEGnKn4dN+WRt3o1KskVI0?=
 =?us-ascii?Q?Viiwk7IjYlE4J45GbR1dfn7VwbYYDA5tyOD6HRUSM25+spWnPC0sMDcUdcL0?=
 =?us-ascii?Q?uZV1r/H5A+Lg2UBUV/4G0mGUM2/m+/cJYEHKnI/UvS57Ls3dgBMPevkeboVX?=
 =?us-ascii?Q?X77FspZaRjU/4B+ejOJkxRgJmCH+1xx6onLv9RBQgOOgIMniVl47aZNYHcxA?=
 =?us-ascii?Q?pZVezUf9OzHiRKQHxuF2ipShizlubRnbeWqu1bTX69maA5cz4eWBcD+387ug?=
 =?us-ascii?Q?dOaXrvTlsxJhZjPmD+6LsbhwPB5RASlqVl9GwN6AamEQYc/3JZKhwnsxU7uA?=
 =?us-ascii?Q?WEIL3TqL9Y1DvCVVKKD3SfpgBzsRWzpGUDhXzpH6BmpjgdLR+XLMKKi/GPpm?=
 =?us-ascii?Q?BMvIt7I+CKDuQZFgLojODWM2+9pjX3CxcsmIUhNqnBILoIvp4p6Vl7ja6nzU?=
 =?us-ascii?Q?pcWGOseawiZOkDQhRSHfKbUdJ0+wmcvVWN1aEedKLQ71Vw/VpdiwQJR/tFdw?=
 =?us-ascii?Q?Ax1q4kQDVmZYmao4I5hApTiu8wgwwH/xRNCG9ruKRWgn0oOX2lUvdPcnwFKM?=
 =?us-ascii?Q?hlWZe4YW/oqGNWHEeeU6u0iH2IYxbkSrlpKrMX3H8LINyfIww6DxALEv8/2k?=
 =?us-ascii?Q?uG34exbxLA2REmdws5TZGJp+XAazzCH5Dlz6obVMlJwlUPDd177X3bX2Js+z?=
 =?us-ascii?Q?AJCVVffXXVip/OOgammKFyHZhCqg48+fzJ78wnBKMOuBK+8ivrRrndPtU+TT?=
 =?us-ascii?Q?XhB+QQSfnZhRRnG6eQNDuJdjXvpPcvAjlDYt20vnLn2tBEoJogph12V1sCVs?=
 =?us-ascii?Q?/sk7iwagp5vzRn2YW/bHaRSoLVs4stCgjo6ISYLittE2Z+go39z3WjcM13gS?=
 =?us-ascii?Q?g5QgNQuHEN72WyANcQTxTKuFG9M0KMbuuWhwJveltUCihahrRc32hrjNr3KQ?=
 =?us-ascii?Q?8QemTrq1cn8nRS/KzZ68hJl28EzdbwNu6pa3kNtF9qsfG8Ic1rWYxYPlGNFH?=
 =?us-ascii?Q?I0VXcaJ24p4Oze4LLr2qTvAUWnLa2+tyCuhLnj352Gf1+LWZN+TwLOZXH3rp?=
 =?us-ascii?Q?MDKMrwDYg5d5d7j/7JHdNeqtBO44KQRMnCdBTAHM7gWevpUO6eRf9zclT1ae?=
 =?us-ascii?Q?VpgHXwWFD/3IGHepR6aag2JtXpYVv2vlttj+HoJSMAzrmPMHWvoq556Z8p22?=
 =?us-ascii?Q?dpGUx9VDARTUQlQCxDPOIyK61oOvHKnW3UQ0e5Qc+wOb7y0FfMfh61mUii5Q?=
 =?us-ascii?Q?PLUIgExheRIjL8kjF8jnPToBRL1ZRXs1goZI2nM5uzFMMqF3Czu7PUzvFIjg?=
 =?us-ascii?Q?nQm45afIqLPpY2TwlXUQ0mgCY6K5xajYWOhYbleybPsBzsqwZ0Wdkq2geREZ?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd47769-651e-4c7d-08bd-08dd36c92cfc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:33:02.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oeUDOFc4qIBicVTkIopWnUfzbB9A1z5HNRejRcQKzdw4md0Li9nOhEhtmeSyEBRLApKbCGDczi8Wng39cb8dv+9szA9rVbF8Lwsut0KC3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7041
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> On Thu, 16 Jan 2025, Dan Williams wrote:
> 
> >Davidlohr Bueso wrote:
> >> +int cxl_pci_update_gpf_port(struct pci_dev *pdev,
> >> +			    struct cxl_memdev *cxlmd, bool remove)
> >> +{
> >
> >If the timers are just maximized then I don't think there is any need to
> >pass in @cxmld.
> 
> The max for T1 is 20 secs, true; but the max for T2 is based on the max of
> all the devices T2 in the hierarchy, so this call still needs @cxlmd.

...but you can't get any more "max" than the hardware maximum, right?
Just assume a topology full of T1MAX == T1_HW_MAX and T2MAX = T2_HW_MAX
devices and skip the calculation recommendations.
