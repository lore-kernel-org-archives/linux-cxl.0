Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7F182B7;
	Sat, 10 May 2025 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746839539; cv=fail; b=BjJ0vMrN//NrifR23dONxtMq2XjhLFxgtBxZhZhzudopDyRLlggn8WXZf+ZZDBLwTKTXsbWCf50sS+zbXSD9VbQBmPBWKIggkZTMsS1CPisimTh07igR0ph8pP/9ypeCuzNXkaS7qwfZkyzqoGAGKW4weAJxoLAYbqgolZhWAcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746839539; c=relaxed/simple;
	bh=aUho8RgHnU+6cm1IV9GQL/oZI0S8cKM8wF4yJrjWyHM=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=JvwmowL/BQDp/KXLVlN8BCle8O3AurXEo9wCUotUptnw0nI4Qe1MTWEqwos8bony3DaxIv6kYQUMceyXu0J33VJrlf87TK7UbI1mCIdypiqDCIY/dhFrUxeAF4OudyNIBKhtWbtkdQIcUSYuCMPcHWUFOQPLqB3OEgZ9qLCLQnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFMcu0UU; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFMcu0UU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746839538; x=1778375538;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=aUho8RgHnU+6cm1IV9GQL/oZI0S8cKM8wF4yJrjWyHM=;
  b=nFMcu0UUEI7ugefIJS294zSclT7NmwxVcDiUb5ybhjE8dc6RYyp4zW2v
   EYmKx8ejQKYLvaGznvnaQOSRqaj+SNgcmqiVMzyFieyeFpVblo1VUF6Yk
   96qxYxISwHMCKmDx3f1ZgzgQ6UHBFc0LKN/dc9I7nqA6pBRTozpbjvEna
   k0oXWtDlv+mxj6c0BYifgVO5xJMPFVZHQWPOi7fZ3m4km9PpKeIkq5wFA
   s0xhaJPL9DMSihX3kHyLUkI9c0l/2+MTzd2QN3nuysXr1oyTRUeDI16iJ
   WjixHNUxLvq+xrc/vhWUCrOyaxCvyEU2YJVYumhYR8r0jkZYn4s7nBHbW
   w==;
X-CSE-ConnectionGUID: +966vRSxQhqqfc2L8CVfmQ==
X-CSE-MsgGUID: iE/4szabT2OZUivHJFQzyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48833731"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="48833731"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 18:12:17 -0700
X-CSE-ConnectionGUID: mqi0xd1VTPSrqlq+f8KP6w==
X-CSE-MsgGUID: ztN6wsqvSWeBvBobJqvs6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="136697505"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 18:12:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 18:12:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 18:12:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 18:12:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbOvLN5kGrEd64XyvgQ62RjH8UST+TuYqyJrm0yCjEhsFUI1oxq1yqV15Z7gbB1l221z30rFkQJE45uP8ne71Uqsx8cfNKGq5SNotyAP6A9JyB49oZCaW8kEFsB3MbFldrSymhUeX9D65Eccx6c8o35K6X4QiOv59+ZrDo3YhJvQhRxdm0A4ysTatd451n3MBjqjKyI7Qxxg3+9ToWMrsTHN1TEl83CfvjRnsXD4VJIoEhyO04IkjhMC5eRKXn9otkcAXSuZiN+2jzK7ya3aT/8ZykF3o4sKOGdDmyxHru6JToco3eJfK/eY3naqGD5PIIpBhDiQ3ifOxoZGwRqS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I5LmLMqkzspAb05SMSL6chWUwvf3/7EU9jd93IuguI=;
 b=nUL8YLYkvl+8B4zZma59go52lWobuWhsVLSAqHgYNa67QI/VBwwOah0N2AgkzoZSe+lra7/8/KojpfEjSHNMHonQb2z5yr3Ko/gb3K0PKCC7evqjHOkd/B0VfIHH3qh+bEwrULcmFJgxqWE/UoGCXxU2IMtiEz8rXKRDHmIy5YFh2PK/BlrSYUX0TA25nW/ABQmD2OTVrFFV+V3iHUJeQit/EFYvBMRp1GgCRgdY5GhUi3JPFc2D8fCzhdzOg5ZvfO9zjgoS2QNh+OVU5SHjMmdh/4kbVWMe7HovvQL9IcfDd6qgcIildiraCIWqgcx2juXKfWnkGaSLI0XWtLrFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Sat, 10 May
 2025 01:12:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8722.020; Sat, 10 May 2025
 01:12:12 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 9 May 2025 18:11:49 -0700
To: Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	"Ingo Molnar" <mingo@kernel.org>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Message-ID: <681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch>
In-Reply-To: <20250509104028.GL4439@noisy.programming.kicks-ass.net>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
 <20250507072145.3614298-2-dan.j.williams@intel.com>
 <20250507093224.GD4439@noisy.programming.kicks-ass.net>
 <681bce2193f38_1229d6294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20250508110043.GG4439@noisy.programming.kicks-ass.net>
 <681d8ce06c869_1229d6294e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250509104028.GL4439@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH 1/7] cleanup: Introduce DEFINE_ACQUIRE() a CLASS() for
 conditional locking
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 7344dd05-64a0-4563-fc85-08dd8f5fb188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eU1xZklkNUQrQ0xLVE1sUytkWDBveGo0anl5eGRQb0ZDdE0zK1Bnd2YxTGdT?=
 =?utf-8?B?dmxVZlhtSHpDcVVHQzJRZWk2bXFycDJzblhxQkJ4ZCsxM3FUc2l2Y3dWYW55?=
 =?utf-8?B?MkJQZUxqdDBUS0t5cDgxQnIyS056R0YrSlB6ZWxDbHBRdEk0aUJtRHZ4Qyt0?=
 =?utf-8?B?ZFZzd3oyTHJ2bitvdWVVbWVFZ0Y0TjZZaVJPclpCcEZ2N2lsbXRleGlqamF1?=
 =?utf-8?B?YzZ6UlFSQStudi9rVFowVnJhK3lOM0FTd1Bjc3JOSzQ2aHBDUkJNMlF0L0pE?=
 =?utf-8?B?b0psUm5xTHU3YTVwNVM3cWhpTzFRWk1JbHU0UFJINjR3a1MvbkF6MFhoNko1?=
 =?utf-8?B?MGxpMjZlSXdZRUxkYkFQd3hHQ0xRcjMxQVM2dnVubkhhQkZNNGRBQlhFdGN4?=
 =?utf-8?B?V200cGcyNU0yblpuazBFTkpsV0xlWlVJNCt3Z2ZGampmS0NxWENPdUs5blFE?=
 =?utf-8?B?Z3V5Q1NXVWNWWGpGbFBwZkdGbk9ydWh2dzMxYVdiQ29uVGxEQlpUc05OcHNY?=
 =?utf-8?B?SFJ2VHRVbXVmYmZxU2R2TXlIdTZzaTZzSy9tZ3ZlYlRsK3RtNWlHWEFHUldF?=
 =?utf-8?B?OSthNFZVcTd6dU5yc2hyZDFScENTdkxoWjJBRi8xeVVxQkVKbVU2M09hR29V?=
 =?utf-8?B?c29KVE8vTlZiMzk5RUs4MVZtckorTUhZYUgzNmoxakQwa2NDRkliV2phc1hO?=
 =?utf-8?B?QUxhcWZPU1BHMVJhbEp5Rmo3cUtPMEVvVmR4Y1p0ZEEvcThHYUpJTmFXYU1t?=
 =?utf-8?B?Z2xqSWdwYXhMQm5Kbm5QZW5oUHp1Vko1R3VTOWliZ0lQMVp0WWRMSytqZzVJ?=
 =?utf-8?B?UUhCSUhmV3lxY1gxWjZCRDYzbi9FNzFYaWpmQTRydTNPemMrSTNkVForYnAy?=
 =?utf-8?B?WFVCbS9HbkNsdStWVHZGTE4ycHNEUGIxdVZDS2lCMDgrT1pWMURYbHRObWx0?=
 =?utf-8?B?L0ZIS0cxSG16UWNvZkpVTFA1OVZWMVE3M2tJRUx6OWVRa3lhZzBYeTNHbk9L?=
 =?utf-8?B?b0tGSEtVRlN0SVhQUnZKK3cxaldZQUtzUzhTVGtVOVZMaFV6VDBaM1oxVDNJ?=
 =?utf-8?B?NzZGWVdmNTZpTFVwTkplSVFvck9vWG8rd1I0OTVnTTU2cFpxZnIvOE44RHVu?=
 =?utf-8?B?UDJJUXUrYlk0dlNaYm9xMmxhdnM3VTZFZ0E4TDlQQ0hwdG1HeTJ2bWVtaTN3?=
 =?utf-8?B?RnBFazFkSlhoQUNlOEU4Mk9qLytaYkFmR2owbWhEQWVHUkhiek9aNWJPQStn?=
 =?utf-8?B?b09HaXRTd1JJakpBTlVGWGhCWE8zblNGNTlSM3RLMXlVZjluZzdrV3BYdHg0?=
 =?utf-8?B?Skk0SU4yWlBPcWZGa1Yxa1JsSkc0SmVFRFJ5WGd6cmpxdjRPcityb1p3YWZG?=
 =?utf-8?B?YVhST1l1YVQ2SExGVnM5RExxNVg0ekc1dFR5QTUrYzNWSlhVWG1ZSlF4eEZh?=
 =?utf-8?B?Y2h5TjNFSjMzK2x4cjZlQ0Njc0l4RGZnODNmajIxSFpPaHFGK2tWbC9sWnhS?=
 =?utf-8?B?UDltT2NSbG8vR2YxOWEzb2E4Nk1lazBKWlZ4MmREblYxUlptOUVMOFU2OVA0?=
 =?utf-8?B?MXhJL2tIV0xDU0d3YmpvMUNDbUcvUXdGRURmc01rcFl2YTg1VXljalNsd3ZG?=
 =?utf-8?B?OURwQSt3S3NTM0xpRzdYVGhuenM4akdjMUpWR3RMVFZWRDhwWklTMzd3OWZU?=
 =?utf-8?B?cEFGVEhsNzZOSE11bXFXWnhnYXFZM0VxcWJDWHBJRUp4QnNYaU5rSVlvWWlV?=
 =?utf-8?B?dTJqSC9EQmZUcnduWk9yb01wdzh4enRLdis5ZU9mQVZYOEVRaWRwYzE4bmho?=
 =?utf-8?B?LytxRlVwaGRlQVhtcWlJYk03L0dFdnpKOUdsWHRoNHlKK0VXWGtvc0ZGdEtJ?=
 =?utf-8?B?d0dldUZnNGlPTnNNejNRQklSekx3aXZyNG5oak5CR1VXZUdlTldYd3o4SGhP?=
 =?utf-8?Q?VZER29H5MLk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDZmLzRtNExCZTFrdjF3b1Q4Z1QrMzU4bnpxYjZTUWZqYk95UlRmdmdWZnNU?=
 =?utf-8?B?Rm9XM01Lazh0ejVNVTZnNG5Pbi9TU2x0Q3QxM3ZuT0Q4aGIyYUhFdm1XbWY5?=
 =?utf-8?B?eXJSMVhMK3A3MGR5elhvSTVkek1qbk5zY1JPVGVGYXZmVXQ1VnMvNFNiUkYz?=
 =?utf-8?B?M3d5azFKMTJQVi8vNGRGUkgrNUJub2FrcTRxYzZUenljWk5pRzA1UDgvRnA0?=
 =?utf-8?B?YU1qUXAvL2NnMzlkWXB2NEtxMGlmUXpqK1gycEo0SmlFQlBnTkpZbnlrS1lH?=
 =?utf-8?B?L0pGT2NZQlZOc2V2cW14bmFzMWl2cktRNlBBdFZGRDVnZkgzY1Q1NUE4QWNa?=
 =?utf-8?B?ZzIxMnFldTBab1dvYzR3a2cyejFIM0pvU0dFclgwVnRCbG5tN2JEU2RWNzhI?=
 =?utf-8?B?UU9sWmVkRGhCb2dNQUttNGJuTEU0Y3p5elVTd0I0QU9tRDc4eGFVMnY4Y3du?=
 =?utf-8?B?RFJjNlpWaWhHZXhGdjBhUlQ5OWdWa01hRElTQkNSUEZzMy9mUmNVb2M4M25k?=
 =?utf-8?B?N0FKa042SC95L0FZNHF0Rm9lNVJ1alpxZm1pWmROWEQzTnFtRlFWaFpUMWk3?=
 =?utf-8?B?K3pLUWowVk5nYmJLdFpGNXZIaTc1Z08yVmdCZEtaQ3BQRjUxZU53bGRxNlY4?=
 =?utf-8?B?RkdNWXhhaDBOQ1J6RFRobElxTFg2UXpWWWdIM2l0ZmFIWUtyeHdpT3VOeDUx?=
 =?utf-8?B?VlAxUzluOEUwaWc2UTc3R0NZdndRY3BEUXRrODZaTXpyTXRtVnYzSCtuV2RG?=
 =?utf-8?B?UjdHeVdCektKb2VnV09zeFA1bmpoeTBIRm54eDVVQlhLYXdUZ1FyS1gwN0Fs?=
 =?utf-8?B?c1crbE5sQ2ZUWHBSa3NIWWI2VFJyQ1diUmhaaExHNDBMNmk2a09IUXlKYzFy?=
 =?utf-8?B?dVhmNG14eWVPWUQ1QTVScmN3YjBmY2xtVVNGcEdQS3kwcHpLdFBNZFF3WjNY?=
 =?utf-8?B?MlZBdTZUQWt6Q25WdFNnN3RiKzd4YXBWVHpaY3BpbnVOTmcxd2pBWm5xSFo4?=
 =?utf-8?B?V04zMU5ybVlCSndKbUlrY2tzc2I5NERkMGhlZXJkS2ZMb2lpd3VXRThtRGdB?=
 =?utf-8?B?V0xxWjNza0Vkc0N1bW9vYkRHcVRFNkRPYXN6UmF1SWZlb1p6eVdLZ2c3TFl2?=
 =?utf-8?B?cmpVaGxpSTdOcGJQZjNWRDIzME9hUjJYMFhKY0dwcUFZQ1Z4enpYLzg0cEhr?=
 =?utf-8?B?ZlBhQ0gzR21SNUpVQjh4ZXZ1OVZiVzJmTUFtemtjMm9pcEcwcStDMHMrayti?=
 =?utf-8?B?K3pEZ1BCampUYk5CYXB1ajBqa3YwV3Ayd0lBS3RUNXdnRCtObTEzclliVW5J?=
 =?utf-8?B?aDQwSmJWZlp5aWZFTUZEZ2lVdTdKdXdlWkgzYnNTWWh2dXdEOEZka2tLaCtm?=
 =?utf-8?B?ZGhqeXdwc2NYc2JkaWtZRk1tcnVoWEVFM0ZPQ3BmZnRsWGVXRVNoNngxR3R5?=
 =?utf-8?B?WE14RGVTS3h0MklTb2I2QllZdVo2T1g1bDFYWWpLZjNZNWRIUFpBRTV5cmlr?=
 =?utf-8?B?ekRXamdTamJ6MTZyTHg3eVRqMGNrNkVnM200Zk5QQ0dqQitqMjlaTU9MZGcr?=
 =?utf-8?B?ZFRXQXFCdm10aUgxdzhRT1RDdXF5YlFVcnA4SzV1WVdBNG9WWkx5dWplaVo0?=
 =?utf-8?B?c3ZxK3k0TGZoNVVSYkRnbVEzcUJ0anVVNzgwd1RTYUsrYjRTbHh4QXV6cS9R?=
 =?utf-8?B?QnlLZ3hEYlF2QzN1VTJSTlRkcHIvelFneHdpZ0toSkg4YUliTUFJcEVBSDVO?=
 =?utf-8?B?TmFuVnREcS9PU0h3R0pONHNGeHQxUWZIcjlPeGJ3YkpSU2hmU2gxQ0F1UFhV?=
 =?utf-8?B?bEJXRkFQK0lmVXpHWFZ5WjZqWFZ5WTNuUGF1VCtLZEtGSHp4VkVxaWtwZDlx?=
 =?utf-8?B?TTgzMEt6elNkVlZZWGFMRzdNKy90bFNQYWloTkM0UE9ma3JHV0dnU04vS3Qz?=
 =?utf-8?B?d2lBejFDQ0s5ajI2aG9FOVM0M3lqbXkwRWtVSFEwWS9ncUN5MFhWQVh5WHZL?=
 =?utf-8?B?UjJzSGg1OWduVkxud3pXdnc0ZzUvNis1K3U5bW4vK2hINFluRWk2ZmJoUjVo?=
 =?utf-8?B?U0N4Nmt0bXN1WVZqemVOV3M2a0orVEVHdGo5SmROQVZQZDlLcTE1SUE4alFT?=
 =?utf-8?B?WWdZMlViMUFya0F4Z1Fybm1Bc0t0SEZ1YkRWU0g2aUtxak5hZEk5bDhGTmdR?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7344dd05-64a0-4563-fc85-08dd8f5fb188
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 01:12:12.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k0LLYlVBxkeqbGoX+cTLPNsLGFQBOfEp2CR3GqbnMBoozQrgdNFbIbvVTuJX1rYF2yutrExSK04V3Il5JoqJ3d8M2/wdofFMNKDzrFZ/vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com

Peter Zijlstra wrote:
> On Thu, May 08, 2025 at 10:04:32PM -0700, Dan Williams wrote:
> > Peter Zijlstra wrote:
> > [..]
> > > > So the proposal is, if you know what you are doing, or have a need to
> > > > switch back and forth between scope-based and explicit unlock for a give
> > > > lock, use the base primitives. If instead you want to fully convert to
> > > > scope-based lock management (excise all explicit unlock() calls) *and*
> > > > you want the compiler to validate the conversion, switch to the _acquire
> > > > parallel universe.
> > > 
> > > As with all refactoring ever, the rename trick always works. But I don't
> > > think that warrants building a parallel infrastructure just for that.
> > > 
> > > Specifically, it very much does not disallow calling mutex_unlock() on
> > > your new member. So all you get is some compiler help during refactor,
> > > and again, just rename the lock member already.
> > > 
> > > Also, if we ever actually get LLVM's Thread Safety Analysis working,
> > > that will help us with all these problems:
> > > 
> > >   https://lore.kernel.org/all/20250304092417.2873893-1-elver@google.com/
> > 
> > That looks lovely.
> > 
> > > But the compiler needs a little more work go grok C :-)
> > 
> > Ok, here is a last shot that incorporates all the feedback:
> > 
> > 1/ Conceptually no need for a new CLASS() save for the fact that
> >    __guard_ptr() returns NULL on failure, not an ERR_PTR().
> > 
> > 2/ The rename trick is not true type safety, especially if it leads to
> >    parallel universe of primitives, but it is a useful trick.
> > 
> > 3/ "IS_ERR(__guard_ptr(mutex_intr)(lock))" is a mouthful, would be nice
> >    to have something more succint while maintaining some safety.
> > 
> > That leads me to a scheme like the following:
> > 
> >     DEFINE_GUARD_ERR(mutex, _intr, mutex_lock_interruptible(_T))
> >     ...
> >     ACQUIRE(mutex_intr, lock)(&obj->lock);
> >     if (IS_ERR(lock))
> >        return PTR_ERR(lock);
> 
> Urgh.. can you live with something like this?
> 
> ---
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d72764056ce6..6b0ca400b393 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1394,8 +1394,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	int nr_records = 0;
>  	int rc;
>  
> -	rc = mutex_lock_interruptible(&mds->poison.lock);
> -	if (rc)
> +	ACQUIRE(mutex_intr, lock)(&mds->poison.poison_lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
>  		return rc;

Yes, I can live with that, and I like the compactness of the resulting
cleanup.h macros better than my attempt.

Although, how about this small ergonomic fixup for more symmetry between
ACQUIRE() and ACQUIRE_ERR()?

---
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6b0ca400b393..e5d2171c9a48 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1395,7 +1395,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 	int rc;
 
 	ACQUIRE(mutex_intr, lock)(&mds->poison.poison_lock);
-	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
+	if ((rc = ACQUIRE_ERR(mutex_intr, lock)))
 		return rc;
 
 	po = mds->poison.list_out;
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 17d4655a6b73..b379ff445179 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -335,7 +342,7 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	CLASS(_name, _var)
 
 #define ACQUIRE_ERR(_name, _var) \
-	({ long _rc = PTR_ERR(__guard_ptr(_name)(_var)); \
+	({ long _rc = PTR_ERR(__guard_ptr(_name)(&(_var))); \
 	   if (!_rc) _rc = -EBUSY; \
 	   if (!IS_ERR_VALUE(_rc)) _rc = 0; \
 	   _rc; })


---

Also, I needed the following to get this to compile:

---

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 17d4655a6b73..052bbad6ac68 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -305,8 +305,15 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, true); \
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
+/*
+ * For guard with a potential percpu lock, the address space needs to be
+ * cast away.
+ */
+#define IS_ERR_OR_NULL_ANY(x) \
+IS_ERR_OR_NULL((const void *)(__force const unsigned long)(x))
+
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (!IS_ERR_OR_NULL(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	DEFINE_CLASS(_name, _type, if (!IS_ERR_OR_NULL_ANY(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	DEFINE_CLASS_IS_GUARD(_name)
 
 #define DEFINE_GUARD_COND_4(_name, _ext, _lock, _cond) \
@@ -401,7 +408,7 @@ typedef struct {							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
-	if (!IS_ERR_OR_NULL(_T->lock)) { _unlock; }			\
+	if (!IS_ERR_OR_NULL_ANY(_T->lock)) { _unlock; }			\
 }									\
 									\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
