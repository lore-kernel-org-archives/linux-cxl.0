Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C73A7F4D;
	Tue, 20 Jan 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768944205; cv=fail; b=kaUph3fFVxNvVr2BLwc6PYlv5OmaXsmoLZ8JxVGPYwGnuO2Xi6OubfL7KfGd1fJMtPvD/a1zRcalbQYLi1bjAeo0alzYSfL0Bw8JWcjzDSPq39lxvQRMqTxEO7BoY8ovJLqRFgFgCNMskVNerzXAJJ6Gs97Ba8mjH0WivWQJowE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768944205; c=relaxed/simple;
	bh=m2oGAx1iDViGP6cD6aEdjDotd/VZ1Qj4I+tm0fp+t1k=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=SinlRlHBKb9ZzgCMjRz7uVdPdHtnxtfDgUltlJqyAuYk77OBGgN/DwmDZE6us88/NsSyuilX+hwJjf/zNPQUfKpqlOnuR8ZOY1gXbF4JM2q8j9Yyil2rdBDfLxdSYE6IUbrISG2CJ+O3PgA+NSIm8ebqLPvvt8cfe4/mZ3Zz9GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjYmTC5m; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjYmTC5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768944204; x=1800480204;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=m2oGAx1iDViGP6cD6aEdjDotd/VZ1Qj4I+tm0fp+t1k=;
  b=bjYmTC5mED0SZtvMAMns0J5HGRLox4cDSmq3jpsGjnaoc0X3iFugcfl3
   Yp6vsUgaiGAaC6wlAMJZ3AvKA1ssihhOun4ajV6D8J5rFSu8aZmWydPBO
   p8oJ6ULHkHB9j4f4IpOJSviZAsYy3fCqaMXmM7dyEzapi0L1Xe0LGxjES
   9Hk03s35M6UxnX9vFRsQhb6QiWUXbpGIji65pts1vIvYjkH3TyaczQnXY
   DDbU1HoTHMuUlONOPNyL7Du3zI122ed2rxo3PV0SnxuyVMuwiGf4QdcpB
   jFgeap+Z4KoQwlsryodbUN2zhhmW9787H5J1GuRuldhUpQ6RDjjUdTuqw
   g==;
X-CSE-ConnectionGUID: MaVbf/+aQAWjzeE+kWSEaQ==
X-CSE-MsgGUID: YuB96+6OQd6WhiCNGly3YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80792482"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="80792482"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:23:23 -0800
X-CSE-ConnectionGUID: 3xvNNSfKRwywmrHay/gSjg==
X-CSE-MsgGUID: owagTrcoTWqcCn+8mkmoFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="211250343"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:23:22 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 13:23:22 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 13:23:22 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 13:23:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGiHB8os/7yTVjlO64c/WAq1uCtBi46jwVjugUfjQJU4IH+lPQw4Go9ABV+g6sZEf7PJcSBnLzYfiYCzLq+9LrJkTp/zwQWrQzedXJey7ziBHvvAy14UxQE+Bc3MZSGBb4OfXpTxZAGJyset6biRGwdu1Fa3K7IDAoCNHqBsGoiquRo9xmZfwqNwNB4DT74h+VuvYmT9d5Als4Kbkp2yljIrqoL64yI1K20TU3XGJJqC78CngSBkglRr3fvpDzvm0CEGpQspM81xglfoh4buG/kkWaD2gCyh/N+bQkwfaoXnkOxtsUHUYQZ8dNY3gLm/d0hIoUU44ZFGKJ6XRRYySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1ADdyqrgENMbajfnAvPjBfabAF7txq5kRoFGl6dhSA=;
 b=WIPmWCmcIk1cpsLMWFSQleKB3yoSOcy5/EtG33fCmgEiXhT2vLYDkm0QGvYAiMYY9M5rkwcmTV/tkjtF+g3ZluArEdHfZ2sOOHG0p8D/FqLp0z4p22uwMW8QKPLbS50O9bF+6T7+zicQp488ea9M51Z7XOOwmZjK0wNZs9ocQz61/xf5zGiLeEW+6T6IWyVHFy5+dlTpXhyEpsDqls/e8J5r1JLo7dtXBdyeTeCHOz4VHLKKaeZ293mHWnXRXQuXfnE2SpSQxya4tIAfA1oeEof5dSPS4dERFzo2Kzdj212cet3dRZ1Zu2A0f/kwWB0KGhB4tOeJXvNWc3kT8cZ8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 21:23:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 21:23:18 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 20 Jan 2026 13:23:17 -0800
To: Robert Richter <rrichter@amd.com>, Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, "Borislav
 Petkov" <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, John Allen <john.allen@amd.com>
Message-ID: <696ff24580c31_1d6f100e4@dwillia2-mobl4.notmuch>
In-Reply-To: <aW5AvfcjLkSP2j42@rric.localdomain>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0201.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: d33e85c0-dad3-4aa9-9b59-08de586a216d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGZsbjZWK2tYRHRlcjRLTmc4dzZ2T216clZ3NlcrbHloeEJ2ZG9NK2JWQWdJ?=
 =?utf-8?B?SDRxUEMwRnpFdmloQXRJZVRxTlBNSVdZYzN6MUY5dGpFdm5DOGVjQVNweVhB?=
 =?utf-8?B?NEE2SUlLNkw4MnZUVzArMzhFVUxRcmVBeUVqVTFxa2QzN2k5ZVNSTjB2NWR3?=
 =?utf-8?B?Y01OR0Z3NTY2SXJPMWZVSlV3anpVT1pGbkJPTGhTNm1kcElKaUpLK0Rkekha?=
 =?utf-8?B?M25GSEs5NXVENlB5Ly9mWFAvTy9kZEFlcUpwemU3b2xrb0xEMHgwRm0yK0Y3?=
 =?utf-8?B?TEsrdWZ1emVHY2xzTlhlWW51MXltcnNIMGt6Vnl0eks2NnNXdXB2VzBVRTBy?=
 =?utf-8?B?L2E3WFR0WVlaREFRRWxlUkR6N0NDeC8zVWF4MTdIdDVFWHlQRVgwREJNdVpp?=
 =?utf-8?B?bGd5bGdjRlBsajB2bk12cjRUT3IvVG1mTlkzd3BvNjFXbEpaUFVWNVNjcFVQ?=
 =?utf-8?B?Vi9VeWtJYU5oQWpuekZJWEJ6dHlxUmsvc2Z1eU9PeGpHQkllZlFSekZLTVl4?=
 =?utf-8?B?cVkxd0ZFeEo0K1psWEovQThEdUNEaE9UNExURi9vOXh2S3JBdDZkam1lQjRj?=
 =?utf-8?B?T1JRYUZDS1FTbGhGV3BQTkNNb25vVXh6dVlYa3RBVDZnRkJSYkFyNDJEYTJp?=
 =?utf-8?B?NWxqT0QrSG41blpqRmhmTWxCVkhOZ3k2dS9wejVZVldoOWorRm5QQlhKT01p?=
 =?utf-8?B?WjZtaG1SS3ROemFraDhpUVNrQmZHNFZhRHU0aGZ3eUtVbmZFY0pYeTlBVUJD?=
 =?utf-8?B?VXpiTlErZkNibUF3bzZtK0RNaGhhMmxtSWhOQ1JkVDdXdVp4YjF4TE90UUZP?=
 =?utf-8?B?RXVkdXBZb1dkcVdmcmZGa3lTcDBNKzBmdThYckpuM0ozMGZmWW0wRzhLSUky?=
 =?utf-8?B?R3NTbGMxckthTnpKUEpWNFZtU1VEMDlyYVlkTENoeVltTS9ES0F4ZENVcGdN?=
 =?utf-8?B?czRjcFgrY1orYk1TcFBYS1A5Vmx5SGU4bUdhMkRtZmE5OXdBemZ1ZkRJVmJU?=
 =?utf-8?B?bkxOdGVOZlBhckJIY0FSdkJGb0Q5WlNobE1QUTRZMlQxOUp0QlFBemNPL2tG?=
 =?utf-8?B?N1hBR040WE90SlY5UGorYXdIakZCWjhFQW40amQ1MnNMOUZZckRpZGI0V1ov?=
 =?utf-8?B?UlJDZG5wU0RLRE1GRXZlTHFjRm9kclJVQXlHOFhDdW10TlBvM00yeGpheHEx?=
 =?utf-8?B?UTlVYVlySXRHZ216N3g3aVQzYzJLdzhDbGJSTHBBUnM3UjBXQnJ0M2ljTFlp?=
 =?utf-8?B?b3FsdDJhUmJ0dmE0V1ZYRzlVdklESU1wR0ZraWJSZEN2VnBlRXE3TlBmTGI2?=
 =?utf-8?B?aGE1TVNSMDhINnNNWmk0QVI5OXQxaUQzY09tYnpLM1BqVHNVdFJyaHZ4V1NO?=
 =?utf-8?B?TTlBWUozVlpUaGVVVkUxcHBBMktyRHZJcmRtZGZDSVh1U1hJOXlrdHdBMGw3?=
 =?utf-8?B?R1RuUVM4cjZGeEJyRnJEV3NUdWk2WXRRSzVoRk1oUkpsb3dlVndBdWJkNllz?=
 =?utf-8?B?a24xVzdFSTRiYjRFVVRYMGszeWxUaUFxYUNxM1cvaDdLNjlNeTI0TDliNWgw?=
 =?utf-8?B?NVFIbzMvQ0M4NEd6TjBqbGpIQTFuN09oZU8ySDNmV0FDMTd2bWpaKzQ4OEV4?=
 =?utf-8?B?alpOZy91eTA2SU5OOUZtNjhlS2tDLzd5Q0dCNjlaWmplSG1vZHNIMENNa1dT?=
 =?utf-8?B?Q0F5c0xscmFtanBzWGxmRmhFRkgwaTNCYllhZHNMMmN4ak1ac0FqUjUrMTJi?=
 =?utf-8?B?Nnlwa0pSOTI1RG8zMDlxY21pMkpxeUxoeUI4YjUxYUdST1I4d2t5b1NwTS8v?=
 =?utf-8?B?MjZqVHRVaHA3ajlFb2pzdmlGb280WnYzajJrdkJhWkNjVzcveDdESGhHYU5a?=
 =?utf-8?B?YlpzUVQrR0dHdURRVDNkcWhKL09tNEVmN3FiU2lWN3JqZGtsM0Q1MUx5S1JO?=
 =?utf-8?B?WUQyYWJ0dlpiU04xZEI4b3JNS01pRkIxZkIzeXFCWHl6cXNDVG1LOHdnKzR3?=
 =?utf-8?B?MVI1aWhlbnlZcTlrajRSaXVBVy9xWXRsaVpPMnpmK1FtWU9nZTRZaStYSjdx?=
 =?utf-8?B?Zlppb1hybzdUb2oxY0tUb2gyN2tqRVplSmZ4bjhtZW4yYWhYR2hndnlIWUlo?=
 =?utf-8?Q?oN/jcj3GJfWlH+WQn1typ3st5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGo5dzdPTTZIY1kxeTE1NVNXT3V4U3ZyVC9ScXNlUnJqNkZmeHJSU3FJUFFi?=
 =?utf-8?B?Y25kLzh4bWJEYjhrSGhjeUhEL2hJM3FWUC92NWVMeWFoaklXZ2o2bVp4NkQz?=
 =?utf-8?B?WkNVRUdUdHJUK1h1Q2xUMStnVlRMYW9xVlNuaEVGVVVsbVRXQS9pTUptTFpL?=
 =?utf-8?B?aDBUV01sRkNMQVVBZitDdkRMb3VraG5zK2ttL1h0NDZvZ3dYbGdNVkY3aFlM?=
 =?utf-8?B?TWdBK1lDVHdqeVdHVk04dmRjcEdmV21ieTRUdGRHY0Y0cUxHeEo3T2NmWERj?=
 =?utf-8?B?OTA3SWNkTkFaWTg5ZjVNQ0FuOTJnQmlWRGJQd3VTYWRVY1pTVXBmRzZkQkIz?=
 =?utf-8?B?aEZsdGt0RWk2STM1dVJwK2NpVGttYzIwTlhybGw2VEh5T2NXTk9oeEtkeXZH?=
 =?utf-8?B?V3dsZnFVSzRqcEJnZVlRZEhVb3RydlpzY0xsQVNmYXdYLyt4R3k3RE5ZRXFJ?=
 =?utf-8?B?Zkx1YmxDTGlYM1VBamlocXpnQWVpMmNBc25iTzNDaVpBTW5lVUhZdVhIT0dB?=
 =?utf-8?B?bitlWmdGNUtWVzJQMG04Y3hRaVYrQVoybit0bXkxekZkQ1Jadm9iYThJR1FY?=
 =?utf-8?B?dXVaWGZ4OWF1QVpLdGwwZUZsYnVCemJFdkZJaWJ3UGFYek5vK0hQcmV4THgx?=
 =?utf-8?B?YWtpbDZucXVSbys5M0dwK0g4WGlvc1VHaEVzaWhWUmx1T1VlOExMWkRFeW9F?=
 =?utf-8?B?NjNLZlpTMEtuTTJTYm50WTVKQlFCc3ZHMVBFbGJQaXM0em1uU1dEdVBBS3VQ?=
 =?utf-8?B?TCsrb08wUFk1WFR5WitVYXEyZVZMYjlxZEYyOTVmd1Z2RmlPVEZybVd1NU4w?=
 =?utf-8?B?dkxPbUR5bEx4Q1ZNaXFwZ3ZsYmdpZ0RMalUzcUlPNUt6cTN4aWo3WENxM1dl?=
 =?utf-8?B?a05TaGc5MWZXRERTcEhFdFUzK3F3RG5YSjNtcjh5emQybld1VU5CdkxqRjdp?=
 =?utf-8?B?dTNYVjdUWmNyVWN0YmtuVWQ3QnBtNlVYQkxhMzl1MGNVcVdTZjRobWhXbDMx?=
 =?utf-8?B?MFZVNWJJWUllRmdFR3Uzdkt2QnFIb0JneFFxVEVYS2ZLMnFzY0o4bytPMUJO?=
 =?utf-8?B?WUpxd2IwQlMyanlNeWpHbUt3eGdJN3BZTkNPL3NhVEJUUUF4Mk54OE5YczV4?=
 =?utf-8?B?dloxUUZBeklta0pxQ3JQWHdndFQ3M1BKMzJZSnl5bWRwUDJ2QUNTbXJmSDgr?=
 =?utf-8?B?T3F5MHNST0RQSFNNSndyK0FIOG1wa2N6V3g2WGdTdE5pUU01OTd1WmVYU2Vw?=
 =?utf-8?B?bVIrZHJuRnhEU0V6Mnd1aEJVbW5wTnRQRm9zLzNuUFdsamVoNTFIamorOG5v?=
 =?utf-8?B?TFo4Uy9NUDV1VkM3RjhhNlNIbTBCd0U0ZzYzK1NhckJqTFBPM3lQWjc2cmRZ?=
 =?utf-8?B?ek1Mc1UyUEhxYU84dnFha2plUCtlQWZ3a2duN1BodDJWTUVkN05DUmw3K1Iw?=
 =?utf-8?B?L3pWRTFEallWYTE3RXJFZVJtUWQvbkpsZkFTbEJlUWFNaCtteVJvMmI4K1ZD?=
 =?utf-8?B?elBVUk1SMWFSOUlvK3pnVTJYbG9YQ1ZIYWk1cTBHeWd4dVhGUkN6R0hWZitV?=
 =?utf-8?B?dHgyN0V1d1BOZy9SMTBUU2EvWXBLazQrSERpRnhrZ1d6TGg5K2JpaUhBS05w?=
 =?utf-8?B?emFQRFAxZlJ1QXU3cDZpU20yd1hNZUIvdXMva2dobTZ6ZW9NMGtoMSt5Z3RU?=
 =?utf-8?B?c3VncFY4OFd0cDJ3ZUNQbmJTTGRwWS9QNmFsdFRMUVRnTEs1THlXMlNXeU5k?=
 =?utf-8?B?blBJQXdVN1pHc3dhWEYrNXBvZVRzaytZSnNvNWlibjV6aUMzMWNNZGkrVFNW?=
 =?utf-8?B?UmxUOHlIYWwxL1YxL1hiZVYxK0U2Zys5a0NpODA0enlkV0J6WWVPYXhuN1dY?=
 =?utf-8?B?bHM1dVJRdlVhVkxjK3AxclQ0SUZEUmU5T2VIc3BjeXNabmJpQUJ4dFNuT2lB?=
 =?utf-8?B?ZmRON2hZYkpuWTRqOXcrRVNwRU53VFBqaGZJeExGSkNJYnRqeGdKVlI2NFVa?=
 =?utf-8?B?Q0ZpM09EWVBEWXluZHNCRWpQS1B3UDlMSTAxcEtkaFZEYmFKdDR1eW1PRExR?=
 =?utf-8?B?S1dpVzloZHozRytLeHNjazFvN3BSNDFKSmZYYTE5MHNGcVAyZlAzMDJsK1Yv?=
 =?utf-8?B?bHFuc3VlUjlhbzRhMGZuVnN6L09JVnBualUwVXpqbEY1anBkZTVIZkRPMVRj?=
 =?utf-8?B?TUMvQW5GdVFiL2p1b3VGWGxNWmVIMXZYd0k2TkJXNHpBOXdWbUkzc2pNcUNP?=
 =?utf-8?B?RlZZaDBQZzFTYUcrYjVKeDRNQ0NWR2FUMzcxblFYWXpTdGV2T2FCRDBHblpK?=
 =?utf-8?B?R24wSzIxYlNBWUpZZ2R3SzYrTlJFaFFuTS83ZThiSnRRTkRkYUR0d3dHUmdr?=
 =?utf-8?Q?FU9BwcEbLcHBkmWc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d33e85c0-dad3-4aa9-9b59-08de586a216d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 21:23:18.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woyjbpBp9tNDyOliYfAHYrsSfOMpT44QZuhFTSmtRt/DwuQtG3/j63FHpmRYUraSBU6Px4Rbnw6enR0GQT5dmGADMolGl0OGSCeTsXu1xfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-OriginatorOrg: intel.com

Robert Richter wrote:
[..]
> > Indeed. But those very constraints also make me wonder why we would ever
> > bother with PRM at all, and not simply require a native driver. Then you
> > actually *know* what the thing does and can debug/fix it without having
> > to rely on BIOS updates and whatnot.
> 
> an address translation driver needs the configuration data from the
> Data Fabric, which is only known to firmware but not to the kernel.
> Other ways would be necessary to expose and calculate that data, if it
> is even feasible to make this information available.

If it is just data is it amenable to put into a table?

Look at the complexity of the XOR addressing mode already defined in the
CEDT.CFMWS table, is the complexity significantly different than that?
 
> So using PRM looks reasonable to me as this abstracts the logic and
> data behind a method, same as doing a library call. Of course, you
> don't want to trust that, but that could be addressed running it
> unprivileged.

PRM should always be a last resort relative to an open specification
with a native driver implementation.

At a minimum Peter's feedback reiginited my simmering concerns with PRM
as a system-software design tool, and this should be a test case for
what Linux is willing and not willing to accept moving forward.

> > Worse, you might have to deal with various incompatible buggy PRM
> > versions because BIOS :/
> 
> The address translation functions are straight forward. I haven't
> experienced any issues here. If there would be any, this will be
> solvable, e.g. by requiring a specific minimum version or uuid to run
> PRM.

Can you publish the source to the PRM handler?

[..]
> > The whole usermodehelper stuff creates a whole extra thread, sets
> > everything up and drops into userspace. Perhaps that is the easiest
> > solution. Basically you set the thread's mm to efi_mm, populate
> > task_pt_regs() with the right bits and simply drop into 'userspace'.
> > 
> > Then it can complete by terminating itself (sys_exit()) and the calling
> > context reaps the thing and continues.
> 
> I can help with testing and also work on securing the PRM calls.
> Thanks Ard for also looking into this.
> 
> > 
> > > Would that allay your concerns?
> > 
> > Yeah, running it as userspace would be fine; we don't trust that.
> > 
> > But again; a native driver is ever so much better than relying on PRM.
> > 
> > In this case it is AMD doing a driver for their own chips, they know how
> > they work, they should be able to write this natively.
> 
> Since a native driver introduces additional issues, as explained
> above, I would prefer to use PRM for address translation and instead
> ensure the PRM call is secure.

How is this case outside of the typical issues that kernel and its ABI
are meant to abstract?

> Dan, Dave, regarding this series, the cxl driver just uses existing
> PRM kernel code and does not implement anything new here. Is there
> anything that would prevent this series from being accepted? We are
> already at v10 and review is complete:
> 
> https://patchwork.kernel.org/project/cxl/list/?series=1042412
> 
> I will follow up with working on unprivileged PRM calls. I think, that
> will be the best solution here.

The PRM to ring3 work is important for the PRM handlers that are
converting existing SMM flows to use PRM. For new DSMs the answer to the
"why not a native driver?" question needs to be clear.

That said, I am also interested in the PRM to ring3 work and did some
investigation there especially when the threat of runtime updates to PRM
handlers was being proposed. I think it is an important capability that
might also get some reuse with the confidential computing case for some
interactions with platform security services, but that is separate from
the primary question of enabling wider deployment of PRM solutions.
