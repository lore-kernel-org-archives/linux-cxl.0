Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40868D529;
	Tue, 13 May 2025 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107137; cv=fail; b=IR8gIYxnvqO1owM1aEeiI9dkuFxoKXk0mD4oWyJc6BvAbK1Sek5byQpJcoBRf8wQbo2vcdpVKNJzl8EagloI+iVpMzezQpn4fx/5ZYr1KbU1jiG4mC0gthT6UlsZBRwW6fTJSLRr98B/9h7NfUIzXB8aI6bD9RjyA7b1JeKHBys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107137; c=relaxed/simple;
	bh=QvEQTAG2xuYo2U9YLlqAf1UFXsad/dMtrYFJB85C4AY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=nscQKdBImHMCYiJ7+9A6nUHqOrFnAbKjvVgxn0xNjJtCvLgTVxF7SJDfz97IevCZEmYLkPNk1l/fsFN45KercrUEyjg0y//yZVf/ozHYlE3EK5Nv3R/x03UvvL1xT2cD5PBRObzXhF81KNxGbmjhpgKfW5Ig8UyY418PGBivFGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqzg4MYu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqzg4MYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747107136; x=1778643136;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=QvEQTAG2xuYo2U9YLlqAf1UFXsad/dMtrYFJB85C4AY=;
  b=iqzg4MYuuYcPGkTMq/dQoAFB+SSx23a0eBTNfapcp0RG3+X+T5XL9KsH
   7oMUJEEe+3lmv2kr+4depSaF9D8TSLWmTD1jGI/TOyhySVO40r+xmtDUN
   0rh8pOj7iMKAEC3g6sDH2qJ3GDaw+bnSyMJlQzEr+QIh79Fnkx6l/ru9X
   rpkkRySliOlsx7iHdGX51ma2vMPCgXBPqN8/IPszptN+uW53Lb8gVxvNp
   TnY3vbP3xakn81YBF+/sf56iu+dYdJE5wlATtGrJPNecpvYd8IuUEq6Mq
   pt0+L9/TFLH24TnvQqgtc6CchG0nha580XQ9Ntt/CZ08J0pOBsf2xuxxO
   A==;
X-CSE-ConnectionGUID: V/O/IkNuSquFO48YmBkzMg==
X-CSE-MsgGUID: VxZLA0TiQACDP97O3sZJdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52738760"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="52738760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:32:14 -0700
X-CSE-ConnectionGUID: RMbkEU1rSeisv3BDNXJDXQ==
X-CSE-MsgGUID: kODodfsQRyGV73QcKyFD+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138087388"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:32:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 20:32:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 20:32:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 20:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pF2YriqDfbrUUP5fzxUtvDi3RLwWPRoKNyyhYvZoxOksQPy9Xf6P60aaJ9fm1DkJVeIKcHhmgHK4pSYDu5smC3UKmlpLlSqoWg+tjcrJGbnjf9e1/lNGcdhHhtTzuj7hPbYiYcVH6LUMHuzUS43Yot2nfKF9rpHxqoAfaA/T2eQrM3jqPfivEYC72dDQnrqD3NupPRvTdV16LZRuSEgRS8E872zbpwNlBOV9KYeVvvkjq6zDnqa+hxuGjKK1Sv40+knlM14sYQy8dfd7EacshcEA3qQ2/aSTsxSGZM715Cn91QnFnpJvvIDYMsELo90lP9L3ew+I9oH+w7+B4e3C8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y0eCaLwv6xkCLQ6S4K11uOvi5Sna6WzArY1VmZxBT4=;
 b=Z9wBh/aIMzlwPRi9sdPZHKw/MXgRE/sWx4abQuycRmg1VWkkZWYdqMRowT0ff/3gzPz7K+U4DfJDLw9Cb003akYXvgopfGNNBrcQ8r1q7HYi9gtLnBZaozCkq7uITP0kW6nAVqvfiUk9iboTdNhBjwcVXHKPa60Zs8U5c/+d2uZSQKi6XKt0YC2CHLnHliIywK0aEELRwUDdryCGNvnNp04sSdVUpEO1bpHfMoWyEFrTWUxIJifuYMULoHSkmUwn9wMkmnmFaxubiKoB+2BTgrFrmj80mBFkh5uGSD4EsK0xJVZiMaRahX0JWbjvrdU8D1iZPvLi/1IoJD+lYVbX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 03:32:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 03:32:06 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 12 May 2025 20:32:04 -0700
To: Peter Zijlstra <peterz@infradead.org>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	"Ingo Molnar" <mingo@kernel.org>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Message-ID: <6822bd346a0f4_49706100a6@dwillia2-mobl4.notmuch>
In-Reply-To: <20250512185817.GA1808@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
 <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
 <20250512105026.GP4439@noisy.programming.kicks-ass.net>
 <20250512182559.GB25891@noisy.programming.kicks-ass.net>
 <20250512185817.GA1808@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: a3964ca3-9e1a-4f04-53b6-08dd91cebbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU5URmtaWmRreVBPVGsxVHFDMzNEd3lFeXhEMUlNd1FlbWhudjlZbEVIK3Zs?=
 =?utf-8?B?VG96bjZ6QU1vLzhoUjhpd3BHR0VUM3V2UXNnYW5CdDBQUTUydEZjcGNwRzdr?=
 =?utf-8?B?YlFFZGxlT2lPRzJYTGZXRXdBRjR2MHM3bkY4aEVIdlhuS29DemVqYnhjN1Vo?=
 =?utf-8?B?aVRDcVVpLzh5V0tHckl0RVFFT3ZvQm5TME4wN1hsZW1oNEpsVUNzdEZ6U0JB?=
 =?utf-8?B?U0xqNTE3TDRqNG9JbnN5bURoNytIK09GTUd4cllhRWFhVGdkOTVSQ2pyR1Ez?=
 =?utf-8?B?N3RLZzNzUFA4RCtldzMyNUtaNVF3Y2VIdUFJbDN3QWVvMnQ1Y2o0TDZkaTcr?=
 =?utf-8?B?YmRGencveVNjYWhnaU9zNnNEclgxUVdya3pDREpwUTIyeE40YVpEYkxvcEFR?=
 =?utf-8?B?UHVxZStFYWozUGV2RHdLMUloTHRLcjFUTkgyWC9KN2d1M3k1QTlNTkp2cDd0?=
 =?utf-8?B?ZFBCRlhlb0VBcExaQVVJVWtvZzl6OVFhS1hCa284Wm90NmRQTVhNSmMxMTJZ?=
 =?utf-8?B?MlREWWU5am8zaHd0VUZIMWNDRWJLT2pySDY5bWI2Mi9rMnJtQ1VqMjBmdDFI?=
 =?utf-8?B?aC9DV0tZWTg4RCtRb0kweHAxQVJTcGRXdk1QVjdiZkJta083c2wrMmpmUFcr?=
 =?utf-8?B?VS9RZVRxakpINHZGNFBpQkRWVDhJejFXOGxHZldmM01DSy9wSitDMll0ZDFi?=
 =?utf-8?B?QzRMNHpuVklNZ2hGRjhlN3A3SnhzdDlKSGUxb2UybnZEenpSdnhVVzNZN3ZE?=
 =?utf-8?B?UUx0QVR6M3Urelg4cUNGKzZlSnRWMStjYnBrTkFyRFoxZmtpWWZOMXFZWjJj?=
 =?utf-8?B?WE84ZjVWSE5JS1ZvS3hXbnNPUW5iSDBMelFQd29xanNGbzBmc1A1U09nWkxP?=
 =?utf-8?B?eFByQkRmaytQRzVxdUh6N1c2VEI3NEd4cDJua1NPU3J1LzJVa0NVODM3Y1RM?=
 =?utf-8?B?dGxPSkRXbG9nRC9PWWpxTU9OTUthbWFLbFZ4MjduK2RsS1FZMGhEblAvZDZ1?=
 =?utf-8?B?WTVmTHdobUZQd1N4SVkrMU1IY1U1cWhoVmZBVFdsV3BGUWN4UVp3bUpnKzZw?=
 =?utf-8?B?b1JmRldWYVN1cEltaUM5K1I1WHltZjQraFVJRHUzWk5JeU1tT3RJRThjdk00?=
 =?utf-8?B?bDFZRThoTXRwQmdWVjZneHNHOGtrTkc3aGpTclpmUHhKT2hySHVPTTZyRTFm?=
 =?utf-8?B?RlVlZ21JTVY5QXhDdjNwQWZTSXVBbU5QTTZncmJvSHgxMzVyS2VVS0RmWUJT?=
 =?utf-8?B?ZlFBWmFVL1UzcjhTVVVoZ3RDNnNyNURTaVVxOElHbThlMlM3VmN0R1J2V3hT?=
 =?utf-8?B?K3RXckhKYjdpR21VN2M0MUN3Vzk2NkJ3eVlBYVFpczk0RXdTeFpjK3hkc2M3?=
 =?utf-8?B?YVpGSytZemFVNUI2UmNsK2ZZZXFqSEtTRGx2VjZDT25FTXBYMjZYd0RPZVRk?=
 =?utf-8?B?d0UrbU82UERic1RkMXR2ZWRNVkhTUC9pSU1uSkJRMDgvUmNkUWtjYU8raUtn?=
 =?utf-8?B?azUwZ0ozRWlod1VGRTc3MXUreEsvTFNYTFBhZ21DSS85L1JZVENXRnhNTzFl?=
 =?utf-8?B?dFQwTC9xcGFkZVdxcWY0MFlJVS9HTUVtWUp3SVNqcUZPa3VvSDNNK1JNVlJz?=
 =?utf-8?B?bWdJVzcyVmJ3dHVPN2J1WWY0ZGxNMnJMdmhYNmhidzY1eDZVWXc3Z3o1T3J1?=
 =?utf-8?B?WU53Z2xnV2lEdVYvbk94YzR5Qmc3RUc1K3FmSlkzZXhTZDFRQ2JVVFdOZy9D?=
 =?utf-8?B?ZFNOa1hTakNKS0hnSUIwUDFkZjJGNXJaSTF0Qy9YZS9RdVh0MnFvTXc5cFNh?=
 =?utf-8?B?elJzOGhmSStCMm9ITzExazdwQ2tpN2dNQ2tuTjNDSzZBQTRJU3A3b3NnUHgv?=
 =?utf-8?B?ZEg5VmtJdVZRbEx3Z2hFcXFBeEtnay9TK2poeTFMdW84bnM1WTlnQXFrTGkx?=
 =?utf-8?Q?kt64F/I++Q0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0IwT1BUb2ZmK1RUV3grQStjNkpCSlhKSmxFMExkNC9xeU10VHJZT3JwREty?=
 =?utf-8?B?N0VNc3ZiM1pDRWU0cUh2VmkxRkp6ei9rV1BiY1c0ZGV2Ui9ZMVdrSi8rZDEw?=
 =?utf-8?B?QkFMdmRZbmw4OExWQUErcXJ4SW5Lbi9oQ2ZBTUk1cEtFWWxZM2o1UDhQRy9X?=
 =?utf-8?B?TitlWFgvdGx2Yjl1OUx4b0haSUozeUpIV0JiQ2pwaDFCMy9wWXRkaDlNcWM1?=
 =?utf-8?B?Y1dHWkNZUVFFeFpvVzd2bmNHQjg2MDFsL05pSDFhRkpmdWZWV2ZZa2ZpWWEx?=
 =?utf-8?B?MFl5c00wbi9TTFVaWXoxZnloa2dLQlJjRE1Ja0ZwSFh5WEhJN3J1aHZXRXhG?=
 =?utf-8?B?US9WLzNnWnVKYTlTdUJyMU5qdTNKTE1reHR0MU80Y3ZyVDlFU0htajM2NGhU?=
 =?utf-8?B?RDFPZEtROVJZZHFYaHRQYUlROWc5QmQxNzFTSWF2Y2VHdUh3TkV3Z3VpMXFi?=
 =?utf-8?B?SzNiYjZZWi9jY3dhT0xsa1hjbXJmNG5IR1VGQ0UyYnZQdVlUL294YTVRY0hL?=
 =?utf-8?B?NjRBd3FoZ0R6MEVIZS9ISzBXYjZSZU92amNPbGhINjFZbWQ1Y2tZbCsrUGtt?=
 =?utf-8?B?dTB6Z0pKVXNjMVZyMFhOaFBxYUpjY2xHNVN2YXBhRHQxNzFsSXpEMjdvVUNy?=
 =?utf-8?B?Z01kWkVaQm1vWXBIeTBibWE5bWxYbnVGOUZiVVBNYXVla204VG1yV2FIclNm?=
 =?utf-8?B?OU0wTy9RS3lRZmdycjFVcm9pQVBhMmp4bkV6M2YzclRCeENkZHdEQlhzNVlU?=
 =?utf-8?B?VTZFRG5NRVozNDdXOVB0ZVFnNjM5WHJzKy90S3ZyVnpyb3dSVTZ0L1hDR2NT?=
 =?utf-8?B?QUFBcmpzcTI2Tzdhc010U2twUE5QNWgyN0dUNFdDVHdXK0hwRFhHajNPYXlM?=
 =?utf-8?B?OVFsZ3lManEzbHU1UFBFTHpGdEVOdXVzWFh6VEMvK3dVWFQ5ZWlWcjdKUERX?=
 =?utf-8?B?d2N5aGwvVlJFaE5uZGo4aW82M3NjbTJTQnZkMm5MbnhYeDNOZmlyTU5oQk5a?=
 =?utf-8?B?UHFxZTczejJUTU9ldjNxdEo4UFZBMjhsSjY3YXR6eG1BSlgyUkcrZzJLZklO?=
 =?utf-8?B?WDBsampSb2dTeG1WZjBWeVhEUnpNelhOd0c4dzdBUmpzSDArL2lrc1ZtLyto?=
 =?utf-8?B?NUV5SlNUQ0xtR21URU1iV0JoSTBOYVVLeXBVU2lrb0w4M1hHazBXMU9uMFFY?=
 =?utf-8?B?UlNFU0JHcUhtNnNYNnpnb3hqQkIyalg3UDJwQ0dwQnNvWUN4ZTJHeW1NSGJX?=
 =?utf-8?B?L1E2K0NuclpNS0prUDhLazV3SjF5MWs2TTN2R0gwTHZMWjRIeTZ1Z2FUVnpR?=
 =?utf-8?B?MUZwRnh0OVFXZEtIMGE5MTdhWFZ5T3liVmxTTVlpSVN0dW5xZmlPVTFJYStK?=
 =?utf-8?B?QzNDbUxYcXZHZzVkdFdFU1ZGV3c4Mm1EQXdhcEZ5VjNOK2N2eDJESG0wanA1?=
 =?utf-8?B?QjNVOGdTUDhtdVdQRFYvbXg2WCtIcFZjdEhsUW1uVm9XaE1zNU8rdkdtVjBJ?=
 =?utf-8?B?VFdUSXV5UmVnZGdxN1N4d0o4cFArdkRTanBxSWovUW0vbWZSL2ZNNkw1TlZr?=
 =?utf-8?B?U0NQQmRTRUdmMm44alEvOWxLU1hRNDBiU214czVRaTlhRy9BU1dLZFl6aEsv?=
 =?utf-8?B?YkhpSG5CM2MzakdwZWdzSndodStGWnNDTU9tZ3hJSlh0YjFCOHd5SHFkSCs5?=
 =?utf-8?B?U25zNHpKMFRESm9lMWlUbXV3RUQzQkQyUXFrQ2hOQ0grR2cvNC8wWXJ5ZUIw?=
 =?utf-8?B?bGNody9CWTQ5VE5EK3VTMm85UEhmSUQ5blB0SktmNlRJSFNmTTZXYWd2SHdJ?=
 =?utf-8?B?RGhtTVp3WDNUQ1NLVkF3bkV0dk1MYmVHQ1RlZ09jRUR1QTFKSTJqejVySXdu?=
 =?utf-8?B?M0ZKY2t6c000L0tTdG1aSFJ0T1NTSFF6NUtpVmkveGdyeU1Rd3ROVTNvamhL?=
 =?utf-8?B?Z0JrTXVrMzJHM002YVdEeVMxYnpNU3hvV3Z2R2M1MnUwa3V5Sis4RGtrSlM2?=
 =?utf-8?B?dnk4UkZhNDV4RXRLOExxdG9NSXpzRTRrN04rTXRGTnlQMWlFcVJnR2FiazB0?=
 =?utf-8?B?YjAwMTE2bVU0Tm05aGd4UEZ1Z3V0MXZNYTVIellRMzQ3VkxlbVl2OVV6dHdH?=
 =?utf-8?B?b3ZWaCsrWS8vdHFZTysxOFlrMHhyQkxBVHcxeEx4RXpmWG1lajJlenVsVCs0?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3964ca3-9e1a-4f04-53b6-08dd91cebbfc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 03:32:06.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DykBYUv6W/ByJmGYk+FlYPYC9Cg9PbvKYv2WVVcQl/NHhz1kziJ3KJ0JjM7iQdDni+4YVTMsRTWa0Em6d3S2y6GMeLeEyumb7C4pZHKaYtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Mon, May 12, 2025 at 08:25:59PM +0200, Peter Zijlstra wrote:
> > On Mon, May 12, 2025 at 12:50:26PM +0200, Peter Zijlstra wrote:
> > 
> > > +#define __GUARD_ERR(_ptr) \
> > > +	({ long _rc = (__force unsigned long)(_ptr); \
> > > +	   if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
> > > +	   _rc; })
> > > +
> > 
> > >  #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
> > > -	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
> > > +	DEFINE_CLASS(_name, _type, if (!__GUARD_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
> > >  	DEFINE_CLASS_IS_GUARD(_name)
> > 
> > GCC is 'stupid' and this generates atrocious code. I'll play with it.
> 
> PRE:
>     bf9e:       48 85 db                test   %rbx,%rbx
>     bfa1:       74 1a                   je     bfbd <foo+0x5d>
>     bfa3:       48 81 fb 00 f0 ff ff    cmp    $0xfffffffffffff000,%rbx
>     bfaa:       77 11                   ja     bfbd <foo+0x5d>
> 
> POST:
>     bf9e:       48 8d 43 ff             lea    -0x1(%rbx),%rax
>     bfa2:       48 3d ff ef ff ff       cmp    $0xffffffffffffefff,%rax
>     bfa8:       77 11                   ja     bfbb <foo+0x5b>
> 

FWIW this looks good to me, and the conversion to drop all explicit
locking passed tests. I threw it out on a branch to get some bot
coverage in the meantime.

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=cxl-acquire
