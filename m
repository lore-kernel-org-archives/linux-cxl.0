Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35671428D
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708568853; cv=fail; b=MkuSeO49Q7k4Lo2NOU2Me8Nn8FzqFqyD0X2HNd9InkHIltyi3vcc73LCXeS9PmzGJvAkkyg38WGJxgFlUiyoiKTlV/czoMu2H7t7KTKBZ+v3WY/rNoRTUb84obEpZZ/ZgHzmtl3uwXPkGg+HI7yLT5P+8SyfeKINsZLMxiL+Zho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708568853; c=relaxed/simple;
	bh=LmMCTqfR21ES3Ue66c8tSZdyUPNm6A4OMJkGuHaLAkQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fIzpaHkLdGWb6sJnM+s/LEwgRzl1kFKopMe3ok/PkEPtQP5rMhg/QdBrwB1j4kALYJx7lup4FhH8kjsvM+GzpvAeyQQf/JJI6aMdgv1e87daJWEejzWC7IWnnnt0SnUqJUIiy0F/chIAATGNeMknR3vdaG1y3hPjFfKnm1OQs0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ju3jbK/c; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ju3jbK/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708568851; x=1740104851;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LmMCTqfR21ES3Ue66c8tSZdyUPNm6A4OMJkGuHaLAkQ=;
  b=Ju3jbK/cgIK+5AsXlEVNveRDBF8JxaQE5fiscCBa1HnHNvo+K8B+Av28
   oCezJ3DASySTK5lxQ/AM3koeaOpZyLhgxGlZ1MlEwJ+Zf7hmkLMOUv3vJ
   N2mKLieWwIbjYspcjszmjpJvMkx3U2IxcAnOUFjJ68zBSteak8l063xs+
   lZo1qSyZNDP1PmJnVFaFdhfrLpe+Ms6HBZVYJ9rMSNlvcbeD5Q/vQ10J+
   XIgRQ0yN0O2QetGTTnQvaiOk+Ro5Erc7ZrijRhaCHPvHgFrEJbGC9dnsQ
   qXo281SkoIaQhgyij84ljxK+8hjt4PjCMZMftPOKAZl4LGFA6cHo6rzyh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2653145"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2653145"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5284568"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 18:27:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 18:27:30 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 18:27:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 18:27:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 18:27:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmO5FOPhrr6D1ORfsDPiahGyYmxYGoHpavMfgclbNg9hZwLjlxgX2pAidh2qAODP32KO+bXo87VbWpx1WL02aCauEjg7hmsXT1PUTGzi6zY1cBVuRYore0+Yf8ebtEfxSpyKM9mZbd8mjSjO2Z9k8lWwuNk1mXmWqdIJB23k5I+m4Im6jkQCq32dfk4s0SfzqXcmz1a3n+JC5NnX9+mSdxe56HSUd+oz0frfgtQL9oDKlra8gziCk1xWzadfYiVy72ql7Vr/5nABiPcWEukwaTJkhW36CF0MghfgayXLI/2/b1HqFGXY07pQopTiW4i2mBO4nJtKgzvh5dEDdvyblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQvSo2wRyrj2DcPmv4SUGM24fB/q3fEVlTVDkt5xxtY=;
 b=GPDiP0T9dr8utWbnHa0fG/SL722iFCnobbQ3CTLFtIO22wzpZo3aSn/uM9OpDnzILanQEtXrh8GvixaxGOLGYZJwAtXhH7UdKauYtK9HtdkfNN8ctQcD8x5N6MCLCvAmiki/N4X35HXviGflKCTbPPy/SYijxiBvnwmQ3nazROEtbsbQHjLjDthpswcqZfe51tJz79WLuj9jTJWdDhNb5m0mhepjt3ePWDsI/GFTqCNU/WrhnJPgiYhPLxjn/pzWNfk7Rj9ZpRvyuUy9CexSBcDm0GspuqjjphXaHORY29v7rR4wdFhjDd60MPI3/o5r8hKj7QLB8KSz4tTwGKtIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.8; Thu, 22 Feb
 2024 02:27:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 02:27:28 +0000
Date: Wed, 21 Feb 2024 18:27:25 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <Jonathan.Cameron@huawei.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>, <dave@stgolabs.net>
Subject: Re: [RFC PATCH 1/5] cxl/core: correct length of DPA field masks
Message-ID: <65d6b10ddfa8d_1138c7294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-4-ruansy.fnst@fujitsu.com>
 <65c718f786340_d2d4294b9@dwillia2-xfh.jf.intel.com.notmuch>
 <92d66f47-3b03-4128-8243-68f917c692f0@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92d66f47-3b03-4128-8243-68f917c692f0@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5017:EE_
X-MS-Office365-Filtering-Correlation-Id: d53a5844-c0a7-4cc9-f889-08dc334dd033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vI9HHTPTTYp8E3/F9EYEW1tFDzulWJHRjVgHKKhBtL0mnfRA5qpCHBSv4LlQVTnumZQTqmvge/lwnxC133MTidBMrt4wKBi3QkiNeT4SkFO4MTtMNJJqYoKVw7+6vHag186vKae/gSziMEiCpOWwzG6N0qfSi84+vRJlNDyvDZ7axoqjwCs1Xbq2mEujwjmxlcMr1gf3ClRukIFLB5bLuhTuTflF50c3px/FedAyYcq70AaItYeKk6P+sriNUAsObAZYPGTJ175z9vKXUelZBHuwY73fQPH0A0jXK3n+ALnSTNLLz5eIKCahMcTSJYBD0KkWpcN6El5E+GW1uWxqRM7Qzydt3TQ0NYf0x6k7WQQQU2kGIIp9/EgNWZgm77CmvPi8mqG/kzvUVyiz2IlIEwVpZF4G1HoMm9fMDru3DA/j8kIdq6DTlm+Iq4/dzVzJwVP/4PohXvtm/xp4koVwDrgBz70qTphAoxvnjLsmz5gxDK5gXx2SERYzY5AhZGgW9Nl3xPMtjZs69PiOI1uvSmbLRwGQHgsxmwgDvtF+Jg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0tkQlBoYVZKd3VqVjdKWUJzS2RkamlnUFBQd0tyMGQ2N2ZMMTV6aGIrYkhw?=
 =?utf-8?B?QitOSWRscS95N2x0aE8vTkFhR0FGem1EdGM2T2laTFhuTjMyYms0bThlZEFS?=
 =?utf-8?B?VHA5ek9lZzJ5QkNKckpmZ2NyNGNJTWpBbHhtTkRhMnZEUHBoK3JQeklVN1dM?=
 =?utf-8?B?ZmNMT3h6b2t1aENhZDFrZHdkRDk1K1lqZ2lHRHc5bElJa3RKaHhCL2srZVVh?=
 =?utf-8?B?VTZ6TnZ5emZualUzVDRpdmllTjdVbjNMYVBLSzRJTUgxc3JqSlhSS2xLdnUw?=
 =?utf-8?B?TVhGb2o2UmFaMlN3NllHMmN0VEgrMWRyQ3g1UitGbm1PQllncVptNUdONEF0?=
 =?utf-8?B?c3FyK2hXWXQyRmtPdnZQdWdueU9FdmhZUlhtSW1tZ3dxQ0dnWVVFbHpvL2Zj?=
 =?utf-8?B?QnhwTmxFLzZscjh4b2dybW0wWExWSUhiZWVGVWxZK2duYUl3aWFkc2VPL1R4?=
 =?utf-8?B?bnBwc1pEQ3hDTHYwRi80N3ZEbzh5cEpSY05UWm5IRzNBWDlPNEVxMU1zSzlh?=
 =?utf-8?B?Z1F6V0JCNFZIb1Ewanp6YWxGdnZ4MW5JbmNRb21sK2ZVRzhXN09RMXg2TnYz?=
 =?utf-8?B?dFBzU1NKQlFFTlg5WDZiWFloQVk5ekFRRUpDZlBGT3FhTmw1OFVNSlg1d01m?=
 =?utf-8?B?V3FBTXJtajh2RldUVzBGSFRSa0xGREVqQTA0anZNWk5wZ2lkODl2OE42YUc2?=
 =?utf-8?B?VkVvSk9yY05ZM1QyTmkzQmZ1VXBpdHRqZjZyTkh3TG9UenBIak42enVtbFNk?=
 =?utf-8?B?QVNWeDJ3NjJXYXY5cnJPb1VtT1plQlpFNnNKN2dEbURtTGtYcnY1YU0rcEl2?=
 =?utf-8?B?RUU5dS9WZ0c3eW16amhoOGN1QzBUcFhlazVYWnNTL0tRL1kwZkg5WlBKRnhx?=
 =?utf-8?B?M25sWDNyTzdhSk1aaGQ3U1doOEU5MW9jbTdrVTBvT2M3U01QNlNtbDFtTUow?=
 =?utf-8?B?YUdURWdYdDEweHp6cFV6RC83V25WK0J2aVcxNU8yeFlWU2YrbTBxc2p0VGM5?=
 =?utf-8?B?WVB2enhTWHdnQzRkY1JhbitUYUpPcm52SVc1UHBoaTF1U21ySkdSR2N0Z1NO?=
 =?utf-8?B?OUlGSXcxSWlJakczcGhnelNRSWJ5N3hUb3dOdFI0SzE1UDN0U2c0dWFLV1V3?=
 =?utf-8?B?eit2NkMxQ0dxRm9KdkhLR0owTjdkcmhOdENaVUUyZXVNSHczd0tjZVZCUEpC?=
 =?utf-8?B?U0h6aDJPdWc4NTlzUzJrQjBXemlVMlh2OFNqN285QWZrUlFsQ2ZmamZZdGh5?=
 =?utf-8?B?eFc2Ry9YK1VhMHFWWTNiZjJTd2sveU8xcThrcTlRdlY0bGVMUDRvb2owaHRv?=
 =?utf-8?B?dVVKSmtuaGoxWkR2ZHJXOUtPb3gra1NxdjBHbitKbFFHQTZvcUNXS0d6dmll?=
 =?utf-8?B?V3haVS9wZGFjNFEzQSs5NlplUDY0OExwOXJUbmtiTnQzUnFWRVBCdmwrYW50?=
 =?utf-8?B?czJNUmsrcmFrSVdNejU1em54amVTTkh1anRtY1c3aUxzZFVoSEN4ckxsUHRL?=
 =?utf-8?B?NURpNmpPZFBkSnF1VnBLWHc0Y0lUR2hwQy9zL2dkREdIMnkwMGRpTG9vTURJ?=
 =?utf-8?B?YUxucmhRM3pKSHVmTmVkbTE5NTIxdFRIcGViNE1oZjYyaWFrNEtzRDEwU2Er?=
 =?utf-8?B?ODJ2MlZGek14UDc2RWJmOFM3enZDVUxhYlhlaThIKzM0ZzdiUDJ0bndoUSt3?=
 =?utf-8?B?b0NqSk1VRlRQdnhaRmtuaXV4ZHNuZmdkUHRVVWNjV09wTTc5UGdWR3NHV0Ex?=
 =?utf-8?B?OWlyZkZtK2E0Mkl3UVhlbUNuRmFReENxSWVCbHY3ejk0dlZMZDdLY2doc0hq?=
 =?utf-8?B?eUNYdjlYUWdURHQ2WXI0dHVJZTA1ZjZyVFpLclVseWZtWUs3MjdTNEhMVkFR?=
 =?utf-8?B?SjE4WlZKL3VFcGI4bCtuSGRYcUh4YXdBN0FqODJTclg2OEdLR2FHZWMwSCtM?=
 =?utf-8?B?MEhCcUZmd2NkcDMwLzBLTHY1ZGRrMjJseC95cmdQZnIxRklJTXdaQzlzTUhv?=
 =?utf-8?B?QU9WanIxdmRncVFJT1ZTcFNFMlhnZW15UWdsNjViY2lTUTdFNlAwSkVMa2V2?=
 =?utf-8?B?RENKVjc1a0JvZ2ozbkFsNGVnbTlpRW5ra3FsY1o2OUh1NmFrTUVTQjVxaWhR?=
 =?utf-8?B?c2pQdEdDZUc0a3FGa1FhV003ZnJqa2ljeDdxbnh4aWZkdStSejV5aTE3c0Ni?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d53a5844-c0a7-4cc9-f889-08dc334dd033
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 02:27:27.9843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmj2ox7brDsQiP4R1c8iQMdETrgPAxz0ZQl99ZVB5SKYqcDdeRMk38dMTDk9q7lBnsj8hcoAtHltDDnhiVgApGKJ8P7SVg2ulMfWk6Fy9lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com

[ add Ira and Davidlohr ]

Shiyang Ruan wrote:
> 
> 
> 在 2024/2/10 14:34, Dan Williams 写道:
> > Shiyang Ruan wrote:
> >> The length of Physical Address in General Media Event Record/DRAM Event
> >> Record is 64-bit, so the field mask should be defined as such length.
> > 
> > Can you include this user visible side-effect of this change. Looks like
> > this could cause usages of CXL_DPA_FLAGS_MASK to return an incorrect
> > result?
> 
> Ok.  Will change it to this:
> 
> The length of Physical Address in General Media Event Record/DRAM Event 
> Record is 64bit, per CXL Spec r3.0 - 8.2.9.2.1.1, Table 8-43.  Currently 
> CXL_DPA_FLAGS_MASK is defined as int (32bit), then CXL_DPA_MASK is a int 
> too, it will be 0x00000000FFFFFFC0 while using "->dpa & CXL_DPA_MASK" to 
> obtain real physical address (to drop flags in lower bits), in this case 
> the higher 32bit of ->dpa will be lost.
> 
> To avoid this, define CXL_DPA_FLAGS_MASK as 64bit: 0x3FULL.

That part was clear, what is missing is the impact. For example, this
bug only impacts the output of the dpa field in the cxl_general_media
and cxl_dram tracepoints, but no other part of the CXL code.

So in this case the impact of the bug is low, but in the worst case an
wrong size mask could compromise the security / integrity of the system.

So I would expect a changelog like this to make the importance of the
fix clear and to notify the original stakeholders where the bug was
introduced.

---
The length of Physical Address in General Media Event Record/DRAM Event
Record is 64-bit, so the field mask should be defined as such length.
Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
mask off the upper-32-bits of DPA addresses. The cxl_poison event is
unaffected.

If userspace was doing its own DPA-to-HPA translation this could lead to
incorrect page retirement decisions, but there is no known consumer
(like rasdaemon) of this event today.

Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
Cc: <stable@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>
---
