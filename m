Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C881F236C;
	Wed,  2 Apr 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636167; cv=fail; b=fgFg8SLryN/SrKyymt64eFN4Vjkd2Y+Dy3ZsXW6HEYZIn+KbPuLMN47TVFMtbYGTYuaH2s6gvUJawFQ+2hjN7ewtES/fBml1Bk+L/nEwJzjfMRHafuLOFwhYXU7TEC/J43Ou55XWNryh+mpVc4jyjuFpxjhEf4Laq0gXCi3aL2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636167; c=relaxed/simple;
	bh=yPvNdyUmQvzED11fL8/PqdyhyyKjTcAOps5+ozTNbRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4vyahEIrHLJsvljHM6sRnOMPnkV5CV/d/ao8xY/X4o+ufQS+VvzWHP5m8HHjDruVjnSHahPFrCF/wS1pv7vsjBzMHVMr/qsaNo2g9gu7g8x/S9CAV1ohoIAduaXEBMIEx4Ux51yAmDnosspZOikK7WVv23tguObj1NUDuGkB5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZCOfjMo; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZCOfjMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743636165; x=1775172165;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yPvNdyUmQvzED11fL8/PqdyhyyKjTcAOps5+ozTNbRQ=;
  b=nZCOfjMoMsXzsFV4kbUadgLgpUJoAJhCfXwGldOZh+GZXiGvHLo9839G
   OqsIxcdEjhlC7AQXrYLhecFt0BN3SPOl6shxbfQLQcOe6nobt3HCeMPn8
   QT8O+G/b6MQWL9Su49yakZoSyqzj4uKNdSM/RtG0jsY8f2h0PpKXpM7+p
   QfybqC7bLazcaG12NLP6/TEMO0KHnvw5ydU0TSU/g937uBfBsQ5353akN
   RDkbqA4GUwrumzIN/fxOhQlN5Q8elCWxZcbjOoSBaIsY4cNRYOjCvThOt
   HmvDsb6h68OcMGEHZcgLe7nPA0xScG9YsBSLyKr5CRXLKaCGVgc7FbjkH
   w==;
X-CSE-ConnectionGUID: tz9OkbT7RPmZOZxlQoviUQ==
X-CSE-MsgGUID: IP+sRs+ASzeZhsy6xvWxUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44283777"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="44283777"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:22:44 -0700
X-CSE-ConnectionGUID: tPC94g2FTQWRi+bwQkm64w==
X-CSE-MsgGUID: fz17GURJS/GmIzvnf2k8+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="127694213"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:22:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 16:22:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 16:22:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 16:22:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwDYrzmN8lZDuquKUmbmVIumUXPU5jYmWkUNrlP69SzFLZW+vtvFv8LrpbUhJoHKbU5wYhb9PYrdnd4BOpQdXeK4s8FHIbHTtZjv21cU7PP7VJ4TnNBWW+HBa66WskYYemUTmAFksOnTy1BvdrRM3liWV9JTLo+Hq9OYNiSVpVhpz7T46c83XSoNq5Gc1olBuBCzSeWZtdhCG7BfeF/ZspwZt3aPZRSKSQphU9uNi4ekzrLmYCKp7thHk9pY5VI7xXMW4EXYatT5hkAe+EE/+S0OJODK9djVTB9VSAI5IezjNVocbxGREyNnLHYubw72otDu+xImm09T2iWzjXexFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olgp9w4e8Ofc6sJkMZWesKJ7kJtP4tgtyISjP5JaM3A=;
 b=sTmWZN2KpYb37QvE0hXrU9bR+urkjtwzmNdyUoizo3W7WkeAgB2BPBPr6lTpoV3R79aQROJ6HF/rjqSU11aNT/b3idIC+xxInvTX8zqHEOeeNT54QAxBiWb5UOBPiNiJ0Aq7w8S0jyISj1Rtihek48OVwZE5ne8xx1eEcvh/KReNsk3G11taJ88lB5I9PeX1qpaMH1sNyJclmmQp/OAMyWzoOvfI3d4ERyJVt+3cTAuwvyFKXwE2zu2Eza1BJWKdPbMzWwsmEJEDIbkfYmM8vVpwGESy8e62WRdxiKeQDsFLz/AIAN4kWoarHIN20rfwqV0eNVHKoecs/454q5+a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7280.namprd11.prod.outlook.com (2603:10b6:8:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 23:22:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 23:22:26 +0000
Date: Wed, 2 Apr 2025 16:22:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Dan Williams <dan.j.williams@intel.com>
CC: <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
	<yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>, <sj@kernel.org>,
	<linux-mm@kvack.org>, <kernel-team@meta.com>, <linux-kernel@vger.kernel.org>,
	<gourry@gourry.net>, <ying.huang@linux.alibaba.com>,
	<jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<minchan@kernel.org>, <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
Message-ID: <67edc6af95e8e_1c2c62941a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250402204416.3435994-1-nphamcs@gmail.com>
 <67edaef8da732_1a6d9294e4@dwillia2-xfh.jf.intel.com.notmuch>
 <CAKEwX=PBp4i4DmCf_7r+Sk6ekB9ckgZEpuR-x4f0CTc00-d+BQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PBp4i4DmCf_7r+Sk6ekB9ckgZEpuR-x4f0CTc00-d+BQ@mail.gmail.com>
X-ClientProxiedBy: MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 5003074a-adae-4eab-e5d8-08dd723d3b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlViMjBTQXBwMHpvNFJLNWIvZ2ZxeVJsdnQwZmh4alo4dmRPVC9CTEpmNUJi?=
 =?utf-8?B?RUk1dGd5bnZZVThOODN3WDUrcC94WWtlQ3lIeEFUdjhIZzNtVGozdEJ6R2xp?=
 =?utf-8?B?OUx6eFArdlhGVzFFN3F2bTR0VFUydU9QelNuOTVBcEpSUVJmcGtSSEh2R2Mv?=
 =?utf-8?B?Q1VhdnE4S3BSK01aT3ljdlN4czdLOVdjZ2xuRVZJVGkyWjByZTRvd09kZkpL?=
 =?utf-8?B?dEt1akIyRlpqYSsvN3FxUGZEQXllaWtERUZYeDdBaDBIc2ZFR1YzNlQwelJQ?=
 =?utf-8?B?VzhnUVArTmwya09SemRtWEJTQ1UzSjBPemsvRDV1MFo2Mk1rZFppM2ZnWHgv?=
 =?utf-8?B?Y2pIQmQxMFpKZlpvR0xHL0cwUUhySUhlb2FsUE1VbTAyVVpPZDFWSjEzeEs2?=
 =?utf-8?B?eFoxS05Pa04xNm5WSG5BUE5OSjJvRW9pbmpVVDRyaDBndFV0S0VmeGFmTVoz?=
 =?utf-8?B?YUo5VlBFVEVzQlUwL29hbnRuVWVPbmlQR0Q1bC9mZmtnQ0VqUWxVdVBIZjc0?=
 =?utf-8?B?S2NOMFJpYkprMDJkcG9yYUMycDlFQ08wMHNQMFhDR2lKbEF3TVBBcklOQWRZ?=
 =?utf-8?B?eGtuYUhHRU1jb1YwUVVVZFNnOUZUUVJTaEFQb09SRFFIZjFtTG5tV1VRUWhO?=
 =?utf-8?B?U3FldHBZb1VRZUJKUE9oZVpIdEpITnYxZkg2V09iR1k0OUo0cnBKZWlBY0lD?=
 =?utf-8?B?aWpaZHlTOElEdU92akYzczgzcmZEd1A0S0VJUTBseUhXUHg5LzV2bFZwTnhP?=
 =?utf-8?B?S3htYlVjUFhCTWU4RjVuTThzeE5jWHVGOVFTODFiTUNLSzNRTkZIVkFIOVRh?=
 =?utf-8?B?My9rRk1jWjhCc2cvUWVWUUEyN2h5SWtsL1RraW5KdHdXYjVhU0tCZFNxSHhw?=
 =?utf-8?B?bTM5THNsbVJVS2EyUEptekNLSHUyKzRjbnQycS9QdHZWcmpKVzFVenA5ZDg0?=
 =?utf-8?B?dFQvYWxNT3RrRldPeWhEQVI3YVlqelovU1IvcmJ6WGJGOTdkNUw3Z1J4ZTFQ?=
 =?utf-8?B?SzloWDgvT3lEeWdYNE9UckJta1NrOXIxa0xqTVFmSXp3RUFzSVFQTVprYXV0?=
 =?utf-8?B?ZG9aU3B2ZDArUGZHMWNmYTA5VVhIbWxxSEtNRFdQT0F2Sm01Y0s2TC95b2tu?=
 =?utf-8?B?TVh4RlJTNGd6ZTljcEdUNFFtL2h1S2J2YjE0clFBOWdnMnRCelFseUNxbDll?=
 =?utf-8?B?ZjhMUUNjcWFlejRpb1lHK1o0dFhFSGMvR1UxQk43Z0JvaFBXbndLLysrNDRm?=
 =?utf-8?B?d1p2TTY4d2NjS01zMGNzYjZTU0tmekZOeGF1OUxlS2p5RjQrYVR5K1hrNU9z?=
 =?utf-8?B?TkdTaXUwWmdvMFM5TzFkWFc1eXlwOFJWaCt1TlBNc3JuWUZsZGdZWlp2VVUz?=
 =?utf-8?B?dVU3QmRwL1F2OXpsRXZ4RGFQMGI1akRkYzV0VXllRngwL2xkRjZDOXV3RmF5?=
 =?utf-8?B?ckkzT1ZFZGlueXZVbm1SMWFmNkgwL0R3MURJa3BCa2QyMDlKakNVcGtMY01O?=
 =?utf-8?B?cVlsVTdYZkVNQ2hBMUtVOGI4WXlUOU0xUUY0MUZRUjdNOTRmR2pXWUhjMGpH?=
 =?utf-8?B?aE9GM1dQUnZWdldKRmVLd21BM1U2WHAwRW1sWVBGMzJuOUxDbjMrdzBkQUJT?=
 =?utf-8?B?ME4rVzUwQUdoNTNEL05CREpTbUZ4RVZVRGovQTFsSHpyMndjWHBIUFEvNkda?=
 =?utf-8?B?RFpIc0xDdkJtS28wS2E3ZEVxT1FKclFZWk5tWUc1M2wrL3ZteVhnUENJTlky?=
 =?utf-8?B?MFo4TzBEYitlNjVKeFlEUnJMMnVxaHR4ZHZxVlNPeVNBbEFaZjd6eTdNWFNk?=
 =?utf-8?B?SDU3cC9jSlhXaGZ5QjArRzN5aXhuQWFBdVBvdER6YkZjbm1NYWF2Z3B0dmIy?=
 =?utf-8?Q?LL4C63YwtkbYF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3VoZHdUVFZXalNBTS93UFRlUUdxcXp5c0xPWGlGVHN6RmVnb3FCaVZnS3RX?=
 =?utf-8?B?YUh2STJ6WENHTG5RMEV3Rlhid1I1THFxNG12b01VU0hjZ2p5ekF3WFJ1Mzcv?=
 =?utf-8?B?WjYwdXBSTE45SkJReHVpZGhvQmx4bk92Z0lROG55SDZDR3hqNlE3eGxxODlD?=
 =?utf-8?B?NFlNTzgzLzdFSGlXOXAxUGZrcWpqbnRHSlovY1g3VmFZSmdBVTdtK2piSlAv?=
 =?utf-8?B?SC9pdFZiMmNNNmFGaHZBVUQxbXJVeERmQTJjbkpMdzZzcE5RaHlqMEZwQzNw?=
 =?utf-8?B?WVYzWWtQQVpYa21PYVoxSnNOZXliSjRHaU1QRG1GSW43ZytaZTh1bGFnN0ZW?=
 =?utf-8?B?VTlZUTJSVGhDZXNDZG05dHUvNDhVak0wMGZHbzhWd2llWEplUUs5R3dGaHNz?=
 =?utf-8?B?UUJMejJsQ0ZKN3NIdjk2TkorUVJuQzQ1ZHVsdG5qMHM5UVlvb3VrZHR1QVhQ?=
 =?utf-8?B?Y1p5RUwrdStMdHV2aktrK1NOOE1SNENoYTc4Z0N5WTF5N1lMdkVXbGFMZnRQ?=
 =?utf-8?B?akxVTDNxTEtsdUZGMjZ4Z21weDgrSzQzRms3ZDhTNXRSQXpIOWRrVDJVbFln?=
 =?utf-8?B?UkdYc3h0eS83aHBXcnRZbVdqQWNvazFwc0dYVzFGWDdwMjVUMTVvMjAwekI1?=
 =?utf-8?B?KzhyeE9oK1ZjSTlRVkw1OU9BVmNjcFpZQ2pzb1IyS085RDFMaUVOeVNLTFVR?=
 =?utf-8?B?NXFqUUNmdVFRTmd6SnVqcXo3T0drSXl3dDIzdVJlcG5nWUZTSHAxZ0c5Mnc3?=
 =?utf-8?B?ZHJsS2NLOGVObk1UT1drRW1JcEtpMmdnZWMvRjE0M1lWNlhoK3NZZzZJdUdK?=
 =?utf-8?B?UkFJNjhWb1lOMlRnb0VZSzdVd2d0SFIveUdvcEtSdWlKbDBiSmY0bUxyeEQ4?=
 =?utf-8?B?aTdYQnlTVXgzSGNIUDFnaUhYMnkrMnYxMGFHejNlMXJtbG9udFhJbXp2L0Qz?=
 =?utf-8?B?NUIzRExwdEhTa3RlUjQwbXp2TWRmQ0svbitJTGQweDVEV01EU1lwQll4aWdV?=
 =?utf-8?B?REFXUXdQSmRDbUMyQy9uSnV0ZGw1TlpDZm5Bd0tTcDl5ck5wM1hVMldja0N1?=
 =?utf-8?B?bnhoUDlqMWVGMEhId2ZVLzVlV3lVb0xWNmFDTXZ4Q2k3WnpyeGU5Tm5UbUNt?=
 =?utf-8?B?eWI0dEtPcWRKOHcrdTRvSEFJV0t6dy9DY0dhT3hmUzlqQktjcmRwT3IrczBV?=
 =?utf-8?B?Rmc5amFyTExCaUJnUFcrZ2dSTStyOEduT05HNDV3L3JpK09oZ3pxTmpWOXJ4?=
 =?utf-8?B?M1ZHWC9qMHkySjBXRXYzMkVtSFlmRHlnbDNCZnZZMG8yZDR2dE0xbzJrNlND?=
 =?utf-8?B?bldUNUZIZENLRkFNL2M3WEJmd3lLcWxzbnNBWFk1dFRROVRHMktPN1ZVNkdX?=
 =?utf-8?B?R0pJUThVYXM5WkhZbWtKVjJFUEp5bW1CNWFMb3hIUGVqTGJMa1hueEt6b2ov?=
 =?utf-8?B?T1Y5cWR5NGUva25hRWNFdVJoWUNLTlQ3aEdDL05wWnlTQUg3ZWtCV2dGdkhW?=
 =?utf-8?B?aUNaZ0Z0MTZNS2QzQkdGZnVZQXZ5SUFROFJHaU9FS3loY3RPK3Vla1RQanVz?=
 =?utf-8?B?anhlSW5BbEk1YVBKOVRyK1cxRlNlR3JIM0xrL1Zrd3ljckl1Z2RKTk1KUXVL?=
 =?utf-8?B?aUZabktEL3dFQXVGcmtjdXgzTVk4RWl3TGc2ZUlrUlFISzBHS2g0dTRtNUZn?=
 =?utf-8?B?bzQ3SnAxcTFBeTlKRGFKaDRTYVFPenIxcXAzS0hqT25aeFdZSnc4UXc2ZUZy?=
 =?utf-8?B?N0luWisxRStLRnY0bkhRbnBGa210NmdMa1hTRlZYcTBjL2kvU0tRdUk4Wmxx?=
 =?utf-8?B?aWVTREdMNFY3eDl5OFg2N3hKTlI5VVU2b1NrbnZoTU9pTU4vdUphUlpzNTRD?=
 =?utf-8?B?SG42MER2bHhCS1JScWp4dzFpRFl5WU9mWWZYQ1QrNS8wRUpQd0lkOWhPWlNj?=
 =?utf-8?B?UjM5ME5uazFDYzUveHZhSkZISndScWlQRDJCQmJGcEFYVzNHa1Bnb0U3T0cw?=
 =?utf-8?B?aUFIaDQrOUdVUm85Y1NhSGZnTVFPVlhpYXpMclJ5dTNlcmtmOTlNR3JmV3NW?=
 =?utf-8?B?WHFSKytYUzcxdFlJVHhIc2hYeFlLM1l4TVR0Qk1qRXVDVHVaUlp6eWFITXpr?=
 =?utf-8?B?NEltTEoxUm9ZeDRJQ00wSDVHa3dMdUMyZVdwRFNUZktrRERQZEdSc2xwRnIy?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5003074a-adae-4eab-e5d8-08dd723d3b01
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 23:22:26.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSyo8TS7jKthVUf0S2ca/b5hAJGdeulRsIlJnXOicO4ao1V1W3DjPNOeVhr5o1APD107hZAYmIpdI6CvzGei8lgtGRPxKuCtJeiv73Nqyqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7280
X-OriginatorOrg: intel.com

Nhat Pham wrote:
> On Wed, Apr 2, 2025 at 2:41 PM Dan Williams <dan.j.williams@intel.com> wrote>
> >
> > Why do the work to pass in @nid only to hardcode 0 to
> > alloc_pages_node()?
> 
> That 0 is the order, i.e we want a single page here :)
> 
> The node id is the first argument of alloc_pages_node. I made the same
> mistake in one of the earlier versions of this patch series (which,
> fortunately I did not send out) - hopefully this time I'm correct :)

Oops, sorry for the noise. My eyes were so trained on @nid as the final
argument in all the other conversions that I overlooked that.

You can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>
