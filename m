Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9113E898
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133078; cv=fail; b=lgZc3pbzH05EisAizI9AR/jGbv3cmN7F4Zsd/EyS0W2pu3me07OY1lmuk87yebKXLlHUMyrpOUaElQX308VaNY+uu2cuVLMVJMfhsgFFKGbjIwcuDZ8vPOYijGzCNlPMHrfveziG6VUGwBNYaBmjBk1usXhR6y0FMbv37XFeZRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133078; c=relaxed/simple;
	bh=VJIJ4YoWz0PM9wyNiIcT9N5yg15V7HX5w+1Y3zQPKlg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=TbUR2Xwe5l6fM6GTh/8w8xLd7OVW5nLDaJc61+yTvVse0lmFPT/rpskZ2YHz9nk7peyiiQ0tU4MDamURvK2H6erbH3WrQ9jtGodPR+W1fi370MgdXsyX64T+kA+HnZsJyeDzzizt/wgWTEQGoHuUgES/dDPWbLc+Y6S6BE2YIV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A09Su77R; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A09Su77R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755133077; x=1786669077;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=VJIJ4YoWz0PM9wyNiIcT9N5yg15V7HX5w+1Y3zQPKlg=;
  b=A09Su77RAHm7dg++Oh+8Rc0KUD9CtdIOu7op+3XoWFmkajdSX7oqsNHv
   F/sPkdCTxHGeocXTcXnQoySObF4Jfa6uWOSgnlPnlOUQW892qLqEcHod7
   1uiwREl3NrEGiib9Pyfjd+7Fyrf1nJ9k3GUkpthUPP4MReN2fxdzKWPV5
   la9Ur46aD8Ggy1qlqYkFr8L2NQOtw7Kk/cyOeuCFFAOeIL//JOlFW7Z6i
   8rw91alnJzgrkFOI7WF+Nr+/FBAlu9QzXN3biJRRqIvJ/r5updg05vfn5
   jSNPuRRr4MebrHUYB0uxT4JDYmDnV4SKPIOz2yYOEvdc6qrFGyVvdBQmv
   w==;
X-CSE-ConnectionGUID: s9PlpLJASxWhmKfK9mikQQ==
X-CSE-MsgGUID: 9jwV66JIQnCorEe1TFkoMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="82875438"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="82875438"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 17:57:55 -0700
X-CSE-ConnectionGUID: Cmkf4rc0R/GmqI4rGnJd9Q==
X-CSE-MsgGUID: Oi6Zs4biTz65i0N2r5Fovg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197473330"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 17:57:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 Aug 2025 17:57:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 13 Aug 2025 17:57:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 13 Aug 2025 17:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4MPAA/u9T1L4U0r4LCqJSvMMO4XNdIUTAH59tdchX4raiU2SRjDw273k8reObLi4mlSI+y/JbNtn6eYXnM4dWNjlimoa6Ck3uUsFs86vJv94aSArfohDgG+UbX+i3DBxWKuY79yNhaT9q/LG0Eg8Zt5qauj4WbQ9oXGsbjCuN+rGUkvh/2fOK+tOsr72R2iQaaqyERfiE/EDGCkff8u+pOsYyyvQV+uWvJJiDnoPWpEXscEk75YJsZ0VGDynDgXW5LElOY3cQY+lOKUWJrUaWbbbwrql5rDZeXO6YT3yPZhQ7qvvPGbKTOoZTLeWcDcSkx7f1wsU5ubLMt1bpTR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SULaO3Ge7CBhPLcnSQyVRG17sju0MuU1GpA62xcsbI=;
 b=fBtBe7jxekNdvV+KN9LQ291CuObQA8D2ZT7cU9BnPjxhhRUvO/K4oxgwOGllu9JA7JYK7Q/us/XgxwOB2HvtnhIajMnwgAqFrobfXpmgVwKipVypGTXuEI/o1cFVf9O1tIgq+pElsgSkZVeW/QDka+PLBEgUJbXCpqLnF84osWMv3sq8sD0BJeOx3mUXhHAMr8H+hUS8SITGRiHDDA+Gr2j/a1CvFnNm08/dSadX1Kg0bxPlbd54KcpdPJMJa6aRYK0o6uXLo9G9UcIrohL1B5Xa5VxVDSS34ox/hL7vxzdwRvOmjl2xzZ/59FgtydNaWZaPSbtuPR5+6QgKbbYztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6326.namprd11.prod.outlook.com (2603:10b6:8:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 00:57:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 00:57:52 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 13 Aug 2025 17:57:50 -0700
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Message-ID: <689d348e41a66_2709100cb@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250813214218.2917555-1-alison.schofield@intel.com>
References: <20250813214218.2917555-1-alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/port: Validate decoder nr_targets against supported
 ways
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1a17b0-f04d-46da-2a65-08dddacd98a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm9veFhxWEl1Yy9tbFVFMytyKzM3OTZTaGI4Mmd3UEJ1OXhBbVpBcDhsTmFZ?=
 =?utf-8?B?NTR3SjlENkpkb0NRQmZ6cXZQeC9zWXJ6MXdPQjRFRW04eFlxcVV6Y0xHSkRM?=
 =?utf-8?B?T2hDTHR2MEl1Q1poRDBtUlM1VnlrN1NSK3I2NjdTS0dBOTFMUUZGRXVBbXpt?=
 =?utf-8?B?NUpWbkdWajFINUVIdFRxamVnSXhqZldaNU9lT043Q1hGdFhUTFhvRE1TeFFH?=
 =?utf-8?B?VkozRFFFaUJkWW9nTkJkUUcxdzBJenhxT1YwZjZuekV5ajhuTTlzdEJGRkxv?=
 =?utf-8?B?R0hLWjBvdVhxa2NJQlh0Q1FsbmhsOXovYVYzL0krbnYvZkxQNDQya20yQk9q?=
 =?utf-8?B?cXNFQjMrRit3RG9Uc3BiQUQ1TUtncU9taGl1UE5QZFQwL0hzUGFxc0R2b2FL?=
 =?utf-8?B?L2M3eGNBQlZhK3YxRVNwTi9LQnVvTk5keWFMZytac0pFL2p0THBzU3VnNmMw?=
 =?utf-8?B?OWhkc1FraTV4cGZrbnZFMDBldUc2YVNwbDlTZVNjZDlHMXRrVTdDZ3VYM0w1?=
 =?utf-8?B?NDhyWmlUcVhTVGNMYkVBY3Z4d3VUQnY3eTlEY0pxUHlPM2p2MXdvbzkvNzRv?=
 =?utf-8?B?K3dKSjZEL0FCVmwyZlo5MFgwWGNPYURtTXU3dXB1dVBXNDZUQW1DZlY3WkJl?=
 =?utf-8?B?M3Z4OXljVU45L3psNUtUampTS1NsUllyalBpcEw1Wm9TUWhGUVZUOWk4S1pu?=
 =?utf-8?B?d3pvZWVVbDRTcWFFSUxpSnNVMGpuZWdBWEJ2d1I0dEhmbHJILytJWENza0p1?=
 =?utf-8?B?V0piTStWV2hOdGt5a1AvMmNoREFFVFVtQk5WZEtITWVScHp3SC9nYVNKcW1o?=
 =?utf-8?B?cVZES3pRT0NpWk1rR2EvM1FEVGZsOU93YnMzUTNmblNXVUZ1OTUvOGN4VHVo?=
 =?utf-8?B?RFZZWWpuOFc5Mmt3QXVrZUc5ellIelhCZ1dQZm5yTFhlWDYrZ3oyeWhndHk1?=
 =?utf-8?B?NkR3Q3p5OHFDbzIxcUx5MVhDeFpkL1JUVHVCem51TUZmYjJ6WHp4QVlwbThY?=
 =?utf-8?B?RmhtSGphZTNVMkVXbno4dnRsTE9sV3FKTW9OUTVQZENYV3EvSkduQTlJZTRw?=
 =?utf-8?B?d1pMR0IraVF0KytzVDZIajJzYmRTckpWc2JQazNCMzZ4ZWxpdGlDL21obVRN?=
 =?utf-8?B?eXh5dXprL2FlQlZhcDVWbE5TYlhHUWJPZHljZEN2YzJUc3NBSXpqSlBtYUJo?=
 =?utf-8?B?Q3RjOTVzVjl5cGpQbkVtNmkxL3JQMW95N25yajc4aERzeUxLczFjZ3dRUmlV?=
 =?utf-8?B?RDI1YzllUVd3cUVBMVlXSVRoRkVxeFltdWNOeHhBUDRrS1ZWd1o3OVpvVnE1?=
 =?utf-8?B?bmM5a2x0VU1OM0tWVmxHU2kraDZRSndsNDBHTi80TTYzRDVjZUJGdXNQNUpm?=
 =?utf-8?B?UHNzYm41UlNFb0xxUUtXN0lVWDF6Sm44NzRoYm1MVm41UUtzbXFNeU1VVVJs?=
 =?utf-8?B?RTJnZGhsRytzMXE1T3NHQkRxMjdKamNPRFl0Si81UE1wcWVFejB2YmUrc3BB?=
 =?utf-8?B?Wjl2NEpINnVkNXJWdGw1dithNUZ4TUg4QjhSNWhmc1lnRFNkTUFMUHprb0Nz?=
 =?utf-8?B?ek1TNnVTdnQ2UUxBa28rRTZDRkpGQ0Q1ZklkcHFGZFJ6YXpTbUJTamhzanlp?=
 =?utf-8?B?NVlSbkNNWjVqR095U0VGdjQ4ZTFwdDNmZ1NCNjRjdTlVWnhSNUZ6VXVSQVJ1?=
 =?utf-8?B?WkZ1M1ZGL1p4RUl3WldGbmZVQy9JQVRUQmVHTjR5Q3NhaC9iZzEraitTNVds?=
 =?utf-8?B?Z0M3OWFXTWgyejRQT2hnbVVmUkxqZXNsaDhYVmI2YzFpTk5uRjhxOHJ0Tk03?=
 =?utf-8?B?Y01CaWhxbStxRUVod3dSNVc3WXhoSXNyRVFxNDd2Q2Ivd0wyZHluMGF4YU9n?=
 =?utf-8?B?Tzk2OENiNXVmbngyKzlEM0llN2IvQlZDTTQzWG9uZVpvSGk1TElKUmE5VmdB?=
 =?utf-8?Q?5p9N019P7K4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0F2c0ViR2Q3cUhNYnBuY21VYTZ2aEc5QWFhNi9nUWFxUHFKNUllRGgySFha?=
 =?utf-8?B?S0NWdWRSREdBODdmOG91T1BCelhmOWVNY29oa3hqRUtnSlZIWldLVHZyVGZa?=
 =?utf-8?B?aHhUTklMR3JlUnFhV2FXTFpzdjd5V2hvdVBLOUwyQytCZmdrY2ZlWk44dVZQ?=
 =?utf-8?B?aFlSUzFJNDNKV3hTWGEvRFNaYUx1aEJYQytwZ0FORFovNFphSWUxWDNHamYx?=
 =?utf-8?B?UkpwL1VidmhZK1p4TTFMWkR4aDMvRXJHeFBPQ0RsQ1plc0RQbnFYNS9OY1Jk?=
 =?utf-8?B?UWRHakw4eFRndmJUK2V1NDlMMjZWVi9DajRmQ2lqZ09UcHR5WFdNOHpxZnc0?=
 =?utf-8?B?UExzL29OTHNibitwRENsV3ZKaUxBdGx4eXgyTHRBdGxhRGMxYXh0Ry9SMGRq?=
 =?utf-8?B?Y2NRbHk4NkhQY3kxNE9DQTlQVEFhblE4ZVZVM1J0anMxVFlZMWdnY0FBOTBl?=
 =?utf-8?B?MmpyZ25rNGVTMS9iRytkR0Q1bXRVYVpVQzErcDBDNjZIWmh0UmIyQnFjcktt?=
 =?utf-8?B?OEo2NWdLdnN2NFJDR3dlT1RqZmJGZlpQK25FTkpack1IWDVHamZpYkJuV3ZY?=
 =?utf-8?B?Mm9laHorRGNtNXBxcmlsYngwdUY5Q3FmVDl4RGMrZUJ1bkVzMnhwL3Z5OHdD?=
 =?utf-8?B?RmNuNlJBNzJiME9vWGNLU29zRzRpMC9vVzhNSFlpWHlXSVVGUWlMcG5US3V5?=
 =?utf-8?B?SXRnZHRJQUJKd2VxNXlMbkpXY3R6TjJkN0ljL1BDbVFxa2k5cHVkbzJqMEdB?=
 =?utf-8?B?WjQ1TzFNelNwM3M5OGROYmNHZ21ZZUk2Nm5kbXVodTlISi9ibmFwVStZdDVU?=
 =?utf-8?B?QksyOUpOL3pjTDBBa0ZJTGNieFNkVGRHTlEzNjNPMXpIWVZzQXlRVHZmVXVt?=
 =?utf-8?B?eFppaTNseFdFSmtEZTRydHRoUTFjQU5vemZQcnp0TkZiclg4VHpENHNibk9Z?=
 =?utf-8?B?a1AxS1M4Z1F1OUNRbGpwcjFLU2FTdDkxM2hWa3g5bTVpOWc5RmtieFk2Q1Mw?=
 =?utf-8?B?L3gyeFRNUzhPREs3ellpMGdTZ1F6MnRaUzVPbXZLeURqdThsUkhaY0tRRS9w?=
 =?utf-8?B?OENQaldORkQyYjJQR21GK3BBSDNGMlBKTVRlRTI0ejFYMVk2M3RaKzY0Zmgz?=
 =?utf-8?B?RjFSNEFxSm5PZUdvVzg1U2pXQ0d1MlRlakRmYU1RNkhGSkdmdmdJN1FWRDg3?=
 =?utf-8?B?ZkhlYm54ZFZ6d1JpM09zOWdWWUFua0RDNzlPTHJOR2pNZzFkKzhDN3JJNVNE?=
 =?utf-8?B?REtmWkh2Z1hSNllTcUVRZVJwTE10OS82UEJqQzM0eTNISnVnbThKek85OGlr?=
 =?utf-8?B?L01nV2d6VjlIdFloUjlWU3RJaElNQmRZRnUxMEh6bzJFN1FaeGVKNWhpU1la?=
 =?utf-8?B?WDZ5L0J4Z2JKNkpSYmNJZ2xQNGRSYnNKRUYzWUdPYTlSMStQY25uaTBWWmlo?=
 =?utf-8?B?Nm0xa0VPbFNOQ01yYlhmM1k3ejhVNi9uNGozWnk1MndJekUveGU3b2ZBZjJJ?=
 =?utf-8?B?Q1YwNG5Oa2I3WnNYUEVUd3pwdGR0ejRLcGFxN3RPYytKaHFRMUJPdnJkZ0or?=
 =?utf-8?B?MjdRSTVlZ2w1SFViWUYyM0pVU0tHaDVQTTlGZnI4YTNzZG54SG5QMnQrb3hQ?=
 =?utf-8?B?enFEWjU2TTJFRXVLa0lXK1BkNzVHeVRNSGk0MjM4NnVkZWlWeVN2YUgwbFFn?=
 =?utf-8?B?M0NmY3lQTDVKdzZGbldZVFpPN2QyWjdYYW9LbEZHajhEeDZVU25zUnNhWHlW?=
 =?utf-8?B?U0szT2pveWxHbU53N0hDNTc4SkFvZ1dRY0xCMXVsS3JKa2Q0cHUxM21BUUkz?=
 =?utf-8?B?Wm9pN01jYWlTRTd3NnBoTUtCYzZPNmVWb3pMMC9sTE9qME9NR2hiSnpWQXpj?=
 =?utf-8?B?UUN1UDRUOG1NMmtqUmh4bVllL0dRb05LQWdRanFuR254UEFBN1NCMnVMVGxq?=
 =?utf-8?B?akxnankrYjdnYjY3TkZhWVo5cjJBOFJzckJDTStGb21pK0tRZ2NUVnltcVJ1?=
 =?utf-8?B?cFRiazVVKzRXVGZaenZrb0FBc0VqMkFkWEYydHlScU1JMERNNExlZTg5OGMw?=
 =?utf-8?B?bHpRcFVmN2Fyb0NoR2R3SHJSMGlKL0tYWDR4UE9waVR4RVAwSFltYk81L2ti?=
 =?utf-8?B?cGcxZHhnVi9TdUtVQWtTTEtJejZHOFRWU2RzeWdSRUFkSm8vNVVQREIybHpn?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1a17b0-f04d-46da-2a65-08dddacd98a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 00:57:52.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5S+y9nvkOH25U5Kg5rq0Cxt+/0K5tR+GeZizmiIE3eaa1trvtId+7wsK0tN3w+S/lE8yprb6MdITOzYA0E5YZgKY+C/KC7nqFHA57bhuPoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6326
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> nr_targets is the number of downstream ports in a decoder's target
> list. It is limited to the supported interleave ways: 1, 2, 3, 4, 6,
> 8, 12, 16. The existing check only enforces nr_targets <=
> CXL_DECODER_MAX_INTERLEAVE (16), allowing invalid values, like 5, 7,
> etc, to pass through.
> 
> Add is_nr_targets_valid() to check for supported interleave ways using
> ways_to_eiw(). Use it before allocating a decoder to avoid alloc/free
> churn when nr_targets is already known to be invalid.
> 
> This was found by inspection and hardens the code.

Well, now seeing this and trying to answer the risk question in 1/ led
to me to reconsider whether this is a good idea and whether we have a
deeper confusion at play:

1/ "Hardening" needs to come with an actual risk claim. For
   cxl_switch_decoder_alloc() the values come from hardware or ACPI and if
   those are buggy all bets are off. ACPI is already protected by a
   eiw_to_ways() conversion prior to calling cxl_root_decoder_alloc(), and
   hardware is even more accurate than this
   approach because it considers interleave ways capability.

2/ nr_targets != ways. ways_to_eiw() is the wrong validity check for
   switch decoders, nr_targets is a topology limitation, not a
   interleave_ways limitation. As far as I can see nothing breaks if a
   decoder claims to support a target count that is not a valid
   interleave_ways number.

So it was useful to go through this to get that clarified, but the
takeaway from 1/ is "there is insufficient risk" and the takeaway from
2/ is "nothing breaks even if switch decoder target count is 'invalid'".
The valid interleave_ways is a separate region-only property.
