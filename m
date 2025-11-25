Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F6329391;
	Tue, 25 Nov 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088663; cv=fail; b=tsfMpTLbrrmcVeNNlp2OjX79pSRBduq+phNCkN7y8KyKIxrqvni1Kna7rSGWmfUQJ/AdIcCCO7d2bM9KL7PZz11Q5j1xmQqQmTytX51IcFloIeYo8WJWKlCWLvA6gaGLL0PLV3umnHMA+RBSQm8y1R1Z5gn8bzTwhNlsfYCaJvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088663; c=relaxed/simple;
	bh=uhyYf2SoFXiTi96L3+YTmStcx1TqtShW0Q5cc2ny4e8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cxZUzYQESq42u/+0UdqtFPSxi+ldBH0kyVCzPjcckOrob/zmWJCKEq208fQXHK0mA/KbWlzMjI9V5s/ghCDPeVvHqRVNNZjAHMjkyhISuWe7MdCYceWKHWh/QTW5P5t/IMyAVe2T5flzC9q0ge8aPmVmSb+jlXTLS76ZH25CuT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8s51QGA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8s51QGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764088661; x=1795624661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uhyYf2SoFXiTi96L3+YTmStcx1TqtShW0Q5cc2ny4e8=;
  b=a8s51QGAgnR9FWEJDeoCCGv5c6dcH5iqert+I8b6Gq/bslFrl/bEUfYn
   xlR7oon/i9E5qmZSdFjzgV+VQMpWV7g7i+O6/qaEeRHQDLBE3ndQQQiuj
   q7DSTcH5+S8D+elpl4RMQccHMtmTCOJSDMkP7//WWjawt5K5q3nzCR+R0
   0sKwij1xpqrwCrvD52o6w2MJ2SJtAFCexEqRoApqgqfELdNOWSvHhBlZX
   9yrNq4ABXqxhQYoWbc48fQlBEi9Xq7VY6sbJSx7GOfZ6rvlX2J/kL+tzc
   6WLqLA/REl9iFmUR2DKdOIqXLZ2in2F4AY4kAmUApBktEcFtcDIH71BnJ
   A==;
X-CSE-ConnectionGUID: S9D+BKZVRx6QaNbzWh6v6Q==
X-CSE-MsgGUID: nRAnzwl6S+2H//euFLP8EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69974425"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69974425"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 08:37:40 -0800
X-CSE-ConnectionGUID: mIR5eTCyQjuOOsp0vTwwMg==
X-CSE-MsgGUID: CB5EW+uBRAubHvRMQCAkbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="196846000"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 08:37:39 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 08:37:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 08:37:39 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 08:37:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR5dQCNg0XL8K7Na/NEX2AYUqsagm3OU1Y2iCjJAxY0lQnsYSfoCXahIpyfmsVD/Sju6CyYPi53RnHUUH4muaJVAFyikFZfmBpfK4iWeylwVUfBdJqfrkYmAW8YA6Mpfxh5fru+ZeYaYWYzNeNaqLBLNW9rEH2cL13Zgrp1Hjw7FsF2DH/jEzVpCgwNHn+0WjFObOooWvRYn7h1aTmlqrUlIYLm4w9CcaLnsT58Cf4IDnaaXbtEtOVZ1DII9L3rIiflZMAMCLIaWRFYFynETvwlGzBi5KtZgI5C1rUz8mpS2PJc3zkWhP+Fg5X3gOo32X2pzhxRZ1WBdqNoMWaASzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3HQFB/0ERaq1LM/AePUgx7WwL8EiIBiQ0OuZfbqtsI=;
 b=sqWfoMRYhMcc2MwXKuHVfJaKQ0ADOp/ZJgKawEdyWWidtr/JWvIxxOwLbCk9keasYHndz59i7JNmC/c1/CD/4Bn5IVGI4daXNDvT6kF7xSfAHZaI4L+yg0h3OVun81ks+kmWzlbgg1VxjIrhjWijikLwNSmf7/gV8lS7E9tfwL3Gb8qutQdYIIuezdsNxkxM9Ikfg1m6MH/K9HZEb+TmAHPuczb4O2+uZtrMxqcVRUvkvIh/+UhnB1J4eurN6Pulp5VDHdilIhOV2hM2ZEFiFidrltSwoMYR8B/5BDKEScpwD3Hqv8W6HFOw8F1/a0edtxrAQ8s4UPwLFM0fxBupRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB7140.namprd11.prod.outlook.com (2603:10b6:806:2a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 16:37:37 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 16:37:37 +0000
Date: Tue, 25 Nov 2025 08:37:33 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: Robert Richter <rrichter@amd.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aSXbTe7lTbvzgwGe@aschofie-mobl2.lan>
References: <20251114004021.1310661-1-rrichter@amd.com>
 <aReKmdOeHBBDWMuC@aschofie-mobl2.lan>
 <aRs4ILR8EEwnfOtQ@rric.localdomain>
 <aSOxXX7xX4jYqqvF@aschofie-mobl2.lan>
 <aSS7n40Hmiaf7ibc@gourry-fedora-PF4VCD3F>
 <aSUh-9fXFGsK_Z1_@aschofie-mobl2.lan>
 <aSW1MlUSs2jjdVjO@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSW1MlUSs2jjdVjO@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: edaf63e3-eca1-4686-e19f-08de2c40f135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GvsOdX5X1JDbfxBU4T3NreeXVXU7/AMwA2mf5MhLtgOu94ozVQDCWyw/a9zG?=
 =?us-ascii?Q?DEtu5XI2jKFGlZWESp1W+bP367nZKhQsAulFOdnkmLJ/om4hfi66vgOWJdos?=
 =?us-ascii?Q?oyNO2hDNNlj00a8nMVJ3xNmKhoS61CHaL6ufGtxLUK1C2zW9WswWyK4/U+1S?=
 =?us-ascii?Q?tFVRuLgJqLwApFrgixg1NSBySreSWGrmzzbjNZSSsB0pTXPOXHMs3Iy2dxgS?=
 =?us-ascii?Q?ks/8zHH+KYHU0KmjRJU++6aQVpPFLBBqrb5iHgEJd1a5H7p/1P9TjbluQjgF?=
 =?us-ascii?Q?b3va+1THjXhNGfyQYOcK67ol0UFr7y8Hs6T5bInOMVWN9tog8UBU0npJNOxr?=
 =?us-ascii?Q?BTXK8TV3fy6+TDo0AMC5azxAlLXttGBardysJTpprJrIKacqmwDabc1GxqmN?=
 =?us-ascii?Q?rY8Qf7FL2XSqj3ZZcIpG4MFUxGWKcQsqZ3x6rc/AM5wO1hTsCYzndBgMsMh4?=
 =?us-ascii?Q?BBu2ThPD+oJjcdTFfA7ktXgtpPcF0TUanUuGTZW6o6hRmEzGBImkv+PPRSHi?=
 =?us-ascii?Q?F8NvXe8/M9WGKv6mYXVVgT7Ye3x8ilFZq0MAu675RUqz6m6c3qA7I0OV58PO?=
 =?us-ascii?Q?2o03r9aN4JvGrxUO89y7GFT3zcWU5wk1CiXMT+RfNHE9QgHEJptwLoODmT2t?=
 =?us-ascii?Q?1eVUubdghJs6h3vHHdjB3aig79jRUEMLcIjoFMU8W40vB8XCOfEnuzs10t0j?=
 =?us-ascii?Q?u9X9OTtiuW4OPOE3gAq+0PZEWupK6ytzXo0pdj2FTaFg93efTMlHWh52isWz?=
 =?us-ascii?Q?MS2MDLjtbXMZYmHJfxLRGEOu55juJXuOjWiOTR4uEo0MGeudvBXhRXWEBesK?=
 =?us-ascii?Q?g4G04EzmF7LNPYyYpv9ikr7CMUao5Vwl5L5qoJgOFa1VcuR/dJyWmgSRzkSv?=
 =?us-ascii?Q?4XVs4xK6yQSBS0FeScT+gAY1o4Sw34d5qphWl2h6vGCQpHMNkLItijOEr+il?=
 =?us-ascii?Q?667J2lcHH2XUqfND2P6GHTTTX0+eGPR4+/tvnJmpVsBA1oB586nU3QPDI8U6?=
 =?us-ascii?Q?96RBBhUqr2TzQ5wOTX2BotqHIPS+JrF8rjcBKN6B0JdTyhLGTziY05AqZ6Oi?=
 =?us-ascii?Q?3h/h3Ga/WFQ1vPGcA73o7QmrtECU5IjkNeE/GnVdyR0sEULlQe+Wzc2uO89V?=
 =?us-ascii?Q?baA2gJY2B1h9zI+U0KQu+SEc6HwRku43na9rTwvVL/7lXq4lJXS1Ok/voiRU?=
 =?us-ascii?Q?iAenNgzg3BiAYzpACrMGrxUdy2s5q3E/4P6zoO6NnTxu/mO+JiqwxScmeEDB?=
 =?us-ascii?Q?Q6atq2a86znVanQbsgg6C1L06DF3EtmfrEXSHJFlHNLo9sj6jiyQ80LFeQj2?=
 =?us-ascii?Q?FxCC8hTyxh31bsLDAXiJV5RkFFzU9HwOAnSJsl5VSO8uBZaPVnR6Th7uIDke?=
 =?us-ascii?Q?jkNsHoahu5ZfznkwVZsNunpw9a/doWxtSXOIdj4MA+dsfPy6f9fI0Z3HEMH/?=
 =?us-ascii?Q?vwY2mHsghLrS8wMv03yXL4DUPPUDMWGI6E4yLPeOFOcKXXAKooMjRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xov5eNAG6RnNWrmSAybO7izPmGq/qI63trX3r7QmY8k/bMx7NjYf6SC3Xy2H?=
 =?us-ascii?Q?fnh8kfFbhcA1kjQzTxDSc+0Vptqngi3Nb5mUxpzCS6gEAS0/QZrfh5Oa3pl4?=
 =?us-ascii?Q?xn4j+73AiaXQ5XNnhBMOPsULKvDiihzRd98Zt3x4fLt3yMYjiV6rkkPp/K7y?=
 =?us-ascii?Q?I3MutvYc8vW0Pkt8pLY8WlU3gDYsEmZ55Fq0My2JO8+siDR98iHQFU08S3eZ?=
 =?us-ascii?Q?J0cAjgiSSblZq/QSbswNJL3BC+aF+tUxwp3rYvzMLkCHzcgheHULGJEYa2yT?=
 =?us-ascii?Q?hV4Vnp7GQQ5rp8aScGm6m3oLnf4/KFsGR6Lcj5LqPOEZTL/pOUQFLtbO4Uu9?=
 =?us-ascii?Q?RYGPamjX9koUR8+Lcz+22qjyadfj3tuZRlBLI/PkVXD0u1HN2FM6Xy/wak+Z?=
 =?us-ascii?Q?nMjZN4pJlJJhldGG+3yugbPpKn3sktxNf2XcojosQplOoCL13nji/OBbVM/D?=
 =?us-ascii?Q?1UX0J7LvSIRTyXKIh3g4IoJyd3UdaRrLdO2z8vf/pPeBl9zD7CkS+OcO3ijr?=
 =?us-ascii?Q?j3cOJR5Ik+/nPkpFW1O8yvo71YO2SIWio7wLLMSle2bpT4+/eoOCjxCNZLo6?=
 =?us-ascii?Q?aBQNnbOsUyO5Oau12MIy4Rb2O7XZCB3X4CpVhsnF8yC++iMm4c1gNw2Jw5JO?=
 =?us-ascii?Q?3DEWyKKQTRhj/IQZ73WCACvbZI40UcVa7tLXot7k8+e7wdQ11N9O+F8ieP5C?=
 =?us-ascii?Q?MVx1ZnLXjI2abQCfLwfhZaUuymjaN5XHmouCKaYah78AsNLgAojrNsjGkyh2?=
 =?us-ascii?Q?ZTOGPt9bphB1aoiA02zf99nQmpMYkakdm9cTQcecOKzUJbjaXRY2tURbW40T?=
 =?us-ascii?Q?BHnRHRaNCW4Q0K/nx897hoG41NP1Rf5d7EV94iDWEwH6+3GDowX2cTg1Xk+x?=
 =?us-ascii?Q?6CyqWBSVP6QSQkCxNlz69ZxVkqZmSnw9xthbVMoy8cUeYsQ1yB+kWAb56B76?=
 =?us-ascii?Q?MX4qwlVUBrs4AiDrRkL1eHyEMvECnTYShgj8qllqFrPzdcUbXVogYcDG4PND?=
 =?us-ascii?Q?9NnJtiSCbJKmRfJUTnPJL+zJ7Ql6SSlIscBZWC6wQXPpteI5r8CjO1hPK44r?=
 =?us-ascii?Q?dANPPPzg8Nr2fcufYtXqZZ/zBCCyBBMyVjCIYON7zMD3hggzp4uTmY05htzU?=
 =?us-ascii?Q?5aLovj+4FR7tWWPk5vm+r81UcNJQe/4nVDg5zosGTArZH0r+jornh4FSHZQZ?=
 =?us-ascii?Q?s2HTwlcXaP5YuGsl9h+8Z3cRoo/giVC9ANVX7qzWM0Ky6aW66y2JPPtr/ycp?=
 =?us-ascii?Q?R+Z6NlTGOmgejnUOBJVUuP+4fjJsVLRYA1Bw65QIpuJt2d0e0mOI4mBiBLsQ?=
 =?us-ascii?Q?+kX61wa/2HBk6GW/v3f+bqrmDC7byZn7P2Otp2FFRqcOczFT67DJ+1TLNQ7l?=
 =?us-ascii?Q?K4UIMA9RkCZg6Tzx/HH9HWcQvsQux5xYuDvHIO9+5yRJO0eRJr3valfc2nom?=
 =?us-ascii?Q?yMLoOPjRivFWPn0DK7ontMau5vFHPKMbHmMrJrxdgXh9HiwGVzCdHtsta98T?=
 =?us-ascii?Q?nKCahXZB07KN1FYjIRD+ubekdGVdugHvJJtNUboAq2mhdSfdofDYED+edi7T?=
 =?us-ascii?Q?RWDI+dNMAhN3OYr0xKdPF8DTAEa7A0/Q1RXd776sExm9Vql4MGpG6klzblYb?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edaf63e3-eca1-4686-e19f-08de2c40f135
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:37:37.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sMxF6/DvUhqJnYkT5Rhl/+ZYggYgIagmmj+2ZOxONF4kJv03QgloXtWz+g6+Xk9KaoSlOfajIkMn2Oo8+t1vAuHi8n3URwheo1SvN3QmH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7140
X-OriginatorOrg: intel.com

On Tue, Nov 25, 2025 at 08:54:58AM -0500, Gregory Price wrote:
> On Mon, Nov 24, 2025 at 07:26:51PM -0800, Alison Schofield wrote:
> > On Mon, Nov 24, 2025 at 03:10:07PM -0500, Gregory Price wrote:
> > > 
> > > IIRC the to_spa() function wouldn't be populated (will be NULL) if this
> > > is the case, so you wouldn't even be able to call the translation
> > > function.
> > 
> > The hpa_to_spa fn defined as a root decoder ops is an additional layer for
> > arch's needing HPA to SPA translation. It's optional. If there is no
> > hpa_to_spa fn, then it is assumed that the CXL HPA==SPA and that is the
> > 'final answer'  added to the trace log.
> > 
> > Sounds like you are on one of these systems, so maybe you could take a
> > look at what happens. If your devices support, try to inject and/or
> > clear poison and see the resulting kernel trace log. There is an
> > example for that here:
> > https://github.com/pmem/ndctl/blob/main/test/cxl-poison.sh
> > 
> 
> Servers am able to test on are @ 6.16 with cxl .17+.18 backports
> 
> I don't see: /sys/kernel/debug/cxl/$dev/${action}_poison
> in my sysfs
> 
> Have enabled enabling various debug and einj options.
> 
> When were these added? Am i missing build options?

Inject and clear poison are since 6.4.
Need CONFIG_DEBUG_FS, but of course you wouldn't have even seen the
the /sys/kernel/debug path if that were missing.

Could be your devices don't support inject or clear. At init time we set
the bits inidicating what poison opcodes the device supports, see
cxl_set_poison_cmd_enabled().
50d527f52cbf ("cxl/mem: Add debugfs attributes for poison inject and clear")

Devices may support list but not inject and clear. Look for this attribute:
/sys/bus/cxl/devices/memX/trigger_poison_list. If that is present, then a
quicker, maybe fruitful check, may be 'cxl list -M --media-errors'. If you're
lucky ;) your devices come pre-loaded with poison. That cmd will emit the
poisoned DPAs and if part of a region, the SPAs too. cxl-list is getting that
all from the kernel trace log, so if you don't have 'cxl list', just trigger
directly and examine the trace log.

-- Alison


> 
> ~Gregory
