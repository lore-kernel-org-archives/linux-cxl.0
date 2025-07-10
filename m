Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EB242D77;
	Thu, 10 Jul 2025 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187662; cv=fail; b=dMQWc1T9yVUQ1TJAXjnoiQO6xMEikdTcur/Lmi968rWXAaMUJSegkBFB7eHvfxlrgYU0knpVXwKX2xaG5Deqc/soIUTrKYi0iUaqQwicUlAAVEc9oFxTPmcXq8W+zOUaVyKangAXVuDZMYj1JjQTQb/ZIQikc4oIXAIktoC/0jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187662; c=relaxed/simple;
	bh=KM6MjOKERVqgEQH1ccqVWF+CanryIMw2TZ9r4Q2jQsA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=GJS6OVEukvOlQ+h1ymT8ZLLpyHvfPvzD0g4qufxw/1nNZPhEEQa1ZrvjLf1WWlwKrmzhuL+ftVxfIAxeFLTRW1QKJipz0ca6o3MbTmLVWNy3vIwRAXY+0F0hkKdluJpTwlpmaKVCeuh5sWEprXPPD/jTQdzSRArf5XlSM7s1CWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZ9OPMyI; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZ9OPMyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752187660; x=1783723660;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=KM6MjOKERVqgEQH1ccqVWF+CanryIMw2TZ9r4Q2jQsA=;
  b=lZ9OPMyIHb0fALKjG4oa3KyAA2Jg4P+P11ZgKFkx0ee3yn902nwBLUkA
   swu2MOX5kf47r+DZdhGEopvKiEoVxl+w46S9nC7ik9RM+RWbhAzFOLktV
   Kp99dpG6LJBcgbLq4r6dva3RS09Vt9JXJsiRUYbTJxJg06jXDZR1NKRTy
   GnbZWXhfv4dZajxqw/qWCtSr/QVveRNaCwax0f5tFm/MoteZHGsoTW//l
   VdLJ8SHZ/9eZuhJAiygCdUNkAUUy0uqcLeoKjVHbB3kFM5mPOM/lMZzXp
   Lp+nJRQyaToVJ8LNT+OEvfhenDPcXr2+wnxLwtRaHyxthiwL87SFH1Bk1
   Q==;
X-CSE-ConnectionGUID: QWNllRxUTcSMSjqI9VNrGw==
X-CSE-MsgGUID: h0tdVhr9R/+3i2tvVugIhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="77025663"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="77025663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 15:47:40 -0700
X-CSE-ConnectionGUID: vfPqamSsQPCtO12noOFd/g==
X-CSE-MsgGUID: H87S3/+PRIaga2WNX+ixOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156310495"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 15:47:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 15:47:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 15:47:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 15:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGbfRieXJGVPp3+QeuAHZi0Sw7NVRYdDfrYzgb7P9oknAn5monJ7WMSPswnLxe/93gz9uQ7mNwzYkcDDmIyBUdMGbW39JG8QWFpwXK7sSaI0XJpJ3EuFFNe/0c6Ei4nuysKcYY7EEEk5AcoePBFVU5f9pjTWlb9618ZIkqKczyUCfgR4IVXxNRNFhN6mguZeWSbXV3iqLyamJIkti0pI6O3xBe1YIi7mx1hMDaCvArr4+OL2rwJhoBQNux56TcrLggQgRTgOkIh8M3PLRVEN8y7IfV9BSOWsXYLGOPTtNVaQTN7mSg8QHzhAa8FwrLAE1ottKf3PYbLsKnghWeSbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaj2hSzDgP445NGbXB/6POOjo6FULHbuUMaikb3/QVI=;
 b=MA91b+1mYWhRA+aotRMElWlf/MHVwSl9RnKZSmHqWPGYRYZE7o+wg3gVPCCbd5J774i7L+XuJiUao9aVDmm/qPK81S42cIOuF8V5uDB2FeyZ9w8OCs81MWngfn8VVUGpKsoWe2m62XLoEsgHAr+jS0Y4tBvgWXVrdBTyBS22N9AK351tRSLbTuRnfjGJ1ab6NGnKrnOk2izHUCvyE4z6a8WjNxtXktItU2BSXZ01g8XeTGciaBMZdTtxyMQhB7A5mM4Xz9HNWXjdg7lWrS0QF7r2iJ3SiY+cG9jRyO9mL3K9o2lWqdGXaTMFjmHbw3CKyYgR49rCA3WXl5ghV9K11Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5169.namprd11.prod.outlook.com (2603:10b6:303:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 22:46:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 22:46:17 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 10 Jul 2025 15:46:15 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, David Lechner
	<dlechner@baylibre.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Message-ID: <687042b7ef13f_588c10013@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250623110544.0000753d@huawei.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-2-dan.j.williams@intel.com>
 <20250623110544.0000753d@huawei.com>
Subject: Re: [PATCH v2 1/8] cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for
 conditional locks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b8b3c9-c8ae-49cd-900e-08ddc0039508
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHZyYkYzbmt5MnhKb2xjYVJnbWR0aGNVOHF6S1A2Zkdyc0hIQmpJaWphNUh4?=
 =?utf-8?B?ZmhDcklRdWtaSHdoVDRoRUF4d2N2MFpsdzRkNUR5Q0tvbWJRTFJ1QmhQZ1lv?=
 =?utf-8?B?aXc2KzNXY3Q4K2IxNDFqOEw0Q2ZEdTMxU2Fzd2pRRkhyc1RKbmRvZDEzdDZO?=
 =?utf-8?B?WlZoeGkwY2dZZFRJemZXeEhxaDRmZExMaXRGdWoraWtLc2RhSzYxMjRJUEd4?=
 =?utf-8?B?RlFZczlDYU8xWEowL2RjTENGK2VWdmppeTNLUVp6QVhiRG52Sng0NGpJbHFz?=
 =?utf-8?B?SVBwVDRVM2Vsam1qNkRkdk1uZVNLR2NRWFF4RFplam0vd1dOZEFrWnF3VWNt?=
 =?utf-8?B?UlRrTjRrRXB6bVBtaFdMc0RQeDArRVZ3Zm94emcyY0VPQ0lId0wzTnJHUkpM?=
 =?utf-8?B?TXRHdG9UWDYvOWJ4SlBOVExEY3N3SWo5RU1VZDdMeXNKc1puWFJOemJTYW5S?=
 =?utf-8?B?SHMwY2xCSkNjMDFJRjNOSmdLNDlFNkZnSlVOU1RaM0JCdmExQVN5R0c3cS9J?=
 =?utf-8?B?YW5GTXdCZWN5LzFXWERkY2t2MVhSRkVlKzkvZ1RVbWlZTGJsQjZ5R05MRXRL?=
 =?utf-8?B?ajFHaFZQUEk1cVFrYTdXb2FqSHpUMVBFL0VxRnVmZFFlYmpSckZyNE1sME1T?=
 =?utf-8?B?Q0RFN1V2aUdKaXZ2NnBOcFJld0FFVjNPUS93NkQzQnhqMGQ3OUFrRWM3NVdW?=
 =?utf-8?B?dDBpYW1WR0RMdG9WTXpjV09ycmw3S0orcGhKbEdUTzFRdVpKb0djS01KNzVB?=
 =?utf-8?B?M3hPMmxaQS9pL1NGbXE0dVgwQ012SlhlaHNKcUoyaXhTdkp2K3VPU0FwZVhH?=
 =?utf-8?B?TS94d1Z4RTdoa0wwZmx5UndpS1lKcmRqamU0Ly83UnNaWFJnN1RhaUN3K2l1?=
 =?utf-8?B?NW5GN2NMOUVnQ1NKR0NQbE5YWGhoNzl6VTMyQWI0R3FiUm0xSWhleXVBN2NB?=
 =?utf-8?B?VWMxVDU0UFN3VHZLalpRM2ZCRS9nNTU5SjdlSVI3RDRBUnFNKzAwZEhmSGM4?=
 =?utf-8?B?Z3BIOXBKZTFwdVJlQ2J0WEdOcVpQZzViSDVuV1lRSzBXR2l4ZXRETGNnczZD?=
 =?utf-8?B?b1J0N2pVOGpsaDdUZDZ0S1ErY2YwNVFQb1dwZ2FTcnh2eVVxVEhhQVpGRVRN?=
 =?utf-8?B?RXNlSXZNZDFtVis3RGVVQ3MvdmF3cGNRSjBFckFrYUVyY0xmcFRKZFYyVVFH?=
 =?utf-8?B?NzhqM2M4azFxSVpZQ1V2eHpzL2ZEbEtqS3ZDV0JGMHpzZmFTYWlLS1NMSjIr?=
 =?utf-8?B?UkRsMzR3T2VwZ2pIUnE4SGVpUUpEczBSR0p3V1pmYXByZDZ1bzZDejUvcWxV?=
 =?utf-8?B?V1ZqbWM0WldITHR3K29mYWtvR01sM2dBMm5ad3BUMWxSMGpWY1Rid2pTTytY?=
 =?utf-8?B?cTNSMC9ZVC9iOWVrdFBhK0MyY0p6d3VXNlQ4a08yZDU2YkpGOFc3Q2tFdWZv?=
 =?utf-8?B?QzcrZXNWL1VJSXd1TFhrRUN3eTRUSkY5QTBtcXYwQUJ0eDZjR3FBZlc4bklB?=
 =?utf-8?B?c1h0ZjVMRkNJajNXT3E4OUo5NEYzZFVsdHg5dUw0d2pLLytKbFMvK2t4SEtW?=
 =?utf-8?B?OXBJS0trQTl5YzNlc0NEVFI4WVZKOCtBcFFqQTQ5V0dOSEJGcnp4MUU4UG9Y?=
 =?utf-8?B?M0NmQWhGRVRiVDQ4VTd5U2hYcnVzWlpOcm5JOHJodUp0OEZLOW40bTZiUlBR?=
 =?utf-8?B?N1pKRlVYMW9RK2ZZbmtSV0dkdDU5VGZPbnU5M25lbFMyMUtpdXlMRS9MVmpJ?=
 =?utf-8?B?OU1wSDcyeW5TQThqTXNHZjRHem5yMWNYSHl3M0pBKzRuRXpOU1BySjNQaHpu?=
 =?utf-8?B?eWdDbnVwY0ZZVkRzTzQrV0pnUzN3TFFlSmZzMUV4dUlFSDl5dTMwbHJFeHg5?=
 =?utf-8?Q?5hcK1nkArtt02?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExTRElQZ0tLZUtaaGtCMy9EUHlBbE56d1BMa0YyeithRENrWktCT05HZUZa?=
 =?utf-8?B?UzJuWU5xNlFHc1BzQXdNRXRIZllwa2ZZdmpEMTRWVldpeHp4aUFDeU5zdFFY?=
 =?utf-8?B?ZWZiRS8vb1NVM1kyNmwyVlhHYzRjTUZsS0hreDVKU1pZZm9aY2U0ZG5xd0Jo?=
 =?utf-8?B?R2hqMUZKUWhSU1hXMHk2bDRnc1EvRnVIZ0lycytLWEdqUndQZjRzWnhvQUor?=
 =?utf-8?B?Mm1WTk9NbVVjQmluQS9BU21EMjlGczhpdms4bi8rRlZuRUN6MHZMblg3aWlK?=
 =?utf-8?B?a0hjVjNBbHhDYzJpVlFvN1NONlZtTzNGaTU4ejhYTVhVcjhyTnRlSFFqOFM3?=
 =?utf-8?B?ZGdGM1N5c0RTeXJWVEVoYlBPQW1GK21BeVBLKzYycThQcWErZnFPMG05c2R6?=
 =?utf-8?B?bDdaSXpEejRETy9neUtSMktHUm5tNUFoZVBIcFhMZGl5UE5lLysybGRWSnJB?=
 =?utf-8?B?a0tZOElsaUdnL1BoVWNPTjM2ZElFYmFtbHRIa2phVWFLUHdCaStnSXNiaHoz?=
 =?utf-8?B?UkpXbEJmMkdBb3ovSnBBd3QxRWhXUkpmY0p2WGtlZ0k3bUoyaU1Wd0FQMkZa?=
 =?utf-8?B?SFhDd1IwMDg4OWltcmpObzJzc0xOaHFybU1SeXlsc2lSTlFCTFYwLzBWMC9K?=
 =?utf-8?B?bmJnMkh6TmtIaVFnZkJLaXd3S2ovUmw0Ym9xRUtJR0RxZytab3htenZJRFFq?=
 =?utf-8?B?QWpLaFpzWFVKVnVMMUtUM1VSdkJhVFVLN0d3VmFoelNmYkNxVVJNenZ5d1I2?=
 =?utf-8?B?M1BqTTZ0RE5sTHA5OEpQRnhwS1Q5ZmthcGozY3k2NnQzNEZmM0k5ZTBQYUdr?=
 =?utf-8?B?Y3ZRZzYvRnJOTE5Fa0ljaTltSGVveHp6aHJpc2s4Y2h3MU5xbGFKR1V6Si9i?=
 =?utf-8?B?Y0xpRHNHa2ozNTUrZkROUDFQQTlZd0wxU3R2NlJFdWxGVTM4M1dGYnp1b0xN?=
 =?utf-8?B?ZTBGU3I5bzlmTDBVRjBEempzNHdGY0xkR2VrbE1OM1RIajBldHpoVFNDR05I?=
 =?utf-8?B?Ni9BblRMQXN1NlpnVVgxajJmcTlMM2p5TGlDVFQ1c2tXbHVxaGl5VW5VOXNH?=
 =?utf-8?B?UFQ2dktEYVVFa3NHNmsyM1ovQ3RhaHRlMTY3VVFudE5xRUxaYzZkL1Z5SU0z?=
 =?utf-8?B?VW1LQWZVdzB3Mnd5cFNKTHlrandXbzVuMGNtWGQxejFRdXJEN04yQlphak5X?=
 =?utf-8?B?S0pPMUl0TGlLQ0pZbGJzN2pyWWRPVmVPcUJ4UWdaWkkrRHI0WTlnMTFSS20x?=
 =?utf-8?B?eUpVOEdWaVhBTnhNZytqc1lrRTE2bE5pRFBneFEyS2ZucFlCV3pLTVM0U1Fi?=
 =?utf-8?B?VUl2RmU5QXNnWW9zcXlnUTYydnJKeW9ieThkZFcyTEp4SStRMW5tMGxmQ2Yv?=
 =?utf-8?B?M3loOVpjdmpTanMrM2FSb1psbU01Z3VYblJweGdWdXRZQ1hYUEpNQXMrWnQr?=
 =?utf-8?B?RmRDcTFxZkJHM1ZBSURJdmZNSi91NzE1WkJlR29GKzhLT0U5RHJQTXhNbjZY?=
 =?utf-8?B?VWhUZzFHdmFKemZBWWdTVzhCYkRpUHA5ZTYxQmJnTVJDWUtnY2JSQ0plcGtl?=
 =?utf-8?B?QjJpZWhFa1RCSmtLdkl5NDdDTmlyVVBLajBLTU03bHV0eHNIWWptakw4ZjdS?=
 =?utf-8?B?OXpPNEJzbWd2RlYvaEhyTG9VR25KdG9LSVJQRXM4b1FTdUpURDlKODVWeDdC?=
 =?utf-8?B?RmdMQUlWb0pHMDJwZ3VwUmVQUkNVWjJwRkF5MmRNOG1wLzNrR0x4OVc5TXNR?=
 =?utf-8?B?WG45a1BKY0ZHTGJ5dnluOXB5S09xZExRSHZUcXN4NU5tVEhlVzlZckNtaER5?=
 =?utf-8?B?VWh2N25vblcrQnZqcklSdkJrZjl3bTN4SERjYU9iVzJTV3poRjd2aVNoTjYx?=
 =?utf-8?B?alV4Tzd5eU5ONStxdEw0bklLVVVjcnhpRjRWSVZEZEtsVUdrbDNUdnZacGNV?=
 =?utf-8?B?WXpuZ1AxSXB5T3MyNDlMWEVBejJaelFPRy9qbzBCckxMeVlnTzlmcFhYODNy?=
 =?utf-8?B?NDV0NE9kSG1DcmoxRmhFR29LKzIrdG93N1BKWmtTWWRXeThOSGNIRjNUd1pY?=
 =?utf-8?B?OUlsMFZYck5LUUZnT2c0SmhwUHRxQldDaVhIS0hPVTFVc2I3N2p0THhkcFBN?=
 =?utf-8?B?VmEzbFpmcjlVVHdMYmYzbDZocSsvWWwvYy94WDdqMk9yZXQ0NTNwWUpocXRv?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b8b3c9-c8ae-49cd-900e-08ddc0039508
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 22:46:17.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJ6anKfX08+8bygOx8YElC1Q2bicPsK4eCpzuKxrLCSTAmENL/2DdkZVwR9BDVFtckWlOhIwsROecwJ8jeVUImeCjFNMjEj5q6Z3jVbdIa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 18 Jun 2025 22:04:09 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > scoped_cond_guard(), automatic cleanup for conditional locks, has a couple
> > pain points:
> > 
> > * It causes existing straight-line code to be re-indented into a new
> >   bracketed scope. While this can be mitigated by a new helper function
> >   to contain the scope, that is not always a comfortable conversion.
> > 
> > * The return code from the conditional lock is tossed in favor of a scheme
> >   to pass a 'return err;' statement to the macro.
> > 
> > Other attempts to clean this up, to behave more like guard() [1], got hung
> > up trying to both establish and evaluate the conditional lock in one
> > statement.
> > 
> > ACQUIRE() solves this by reflecting the result of the condition in the
> > automatic variable established by the lock CLASS(). The result is
> > separately retrieved with the ACQUIRE_ERR() helper, effectively a PTR_ERR()
> > operation.
> > 
> > Link: http://lore.kernel.org/all/Z1LBnX9TpZLR5Dkf@gmail.com [1]
> > Link: http://patch.msgid.link/20250512105026.GP4439@noisy.programming.kicks-ass.net
> > Link: http://patch.msgid.link/20250512185817.GA1808@noisy.programming.kicks-ass.net
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > [djbw: wrap Peter's proposal with changelog and comments]
> > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> This looks like a nice solution.  One trivial style thing inline.
> 
> > ---
> >  include/linux/cleanup.h | 77 ++++++++++++++++++++++++++++++++++-------
> >  include/linux/mutex.h   |  2 +-
> >  include/linux/rwsem.h   |  2 +-
> >  3 files changed, 67 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index 7093e1d08af0..1e1eb35cc225 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > +#define __GUARD_IS_ERR(_ptr) \
> > +	({ unsigned long _rc = (__force unsigned long)(_ptr); \
> > +	   unlikely((_rc-1) >= -MAX_ERRNO-1); })
> 
> Trivial but I'd have added spaces to make this
> 	   unlikely((_rc - 1) >= -MAX_ERRNO - 1); })

Looks like even though I pushed out a stable commit with this nobody has
pulled this into linux-next so I can fold in this fixup and send out a
new version.

> 
> > +
> >  #define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
> >  	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
> > -	{ return (void *)(__force unsigned long)*(_exp); }
> > +	{ void *_ptr = (void *)(__force unsigned long)*(_exp); \
> > +	  if (IS_ERR(_ptr)) { _ptr = NULL; } return _ptr; } \
> > +	static inline int class_##_name##_lock_err(class_##_name##_t *_T) \
> > +	{ long _rc = (__force unsigned long)*(_exp); \
> > +	  if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
> > +	  return _rc; }

I will also take the opportunity to let clang-format add more whitespace
to this to make it more readable:

-#define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
-       static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-       { return (void *)(__force unsigned long)*(_exp); }
+#define __GUARD_IS_ERR(_ptr)                                       \
+       ({                                                         \
+               unsigned long _rc = (__force unsigned long)(_ptr); \
+               unlikely((_rc - 1) >= -MAX_ERRNO - 1);             \
+       })
+
+#define __DEFINE_GUARD_LOCK_PTR(_name, _exp)                                \
+       static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T) \
+       {                                                                   \
+               void *_ptr = (void *)(__force unsigned long)*(_exp);        \
+               if (IS_ERR(_ptr)) {                                         \
+                       _ptr = NULL;                                        \
+               }                                                           \
+               return _ptr;                                                \
+       }                                                                   \
+       static inline int class_##_name##_lock_err(class_##_name##_t *_T)   \
+       {                                                                   \
+               long _rc = (__force unsigned long)*(_exp);                  \
+               if (!_rc) {                                                 \
+                       _rc = -EBUSY;                                       \
+               }                                                           \
+               if (!IS_ERR_VALUE(_rc)) {                                   \
+                       _rc = 0;                                            \
+               }                                                           \
+               return _rc;                                                 \
+       }
