Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117024167D;
	Thu, 19 Jun 2025 05:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309499; cv=fail; b=aWg/p70HNay4OK0JSju6F1KV1RMwGJmViSlrvPYHNihTMwfsVlmF4szuR7KF66M67tqs2xA7WEX6rmR2JRRVK9FHd/N6bRh0HgMyMYryiSetYt2XPnJsELV49St6D35uwBozaWToILrLkV/Pi+Nuii45BwJFrfVG2l9peToTlMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309499; c=relaxed/simple;
	bh=FzGa1cF5BgK8+3Qn4FIUr4IJUcJZzVT+CQbO8TnhVMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rydePb8Mt1u1fVyHvix87VknpGlfgUREKQV7UJ7QVnsTr7w257TUPwxjMGV9vhux19kEJjH1c2idKS0qPvU/AA8jmfNDel45ERorC1d95QDqyEeEzLJ1W54FWuW2gZ1IBTOzAMxQB/8TxMlmkTJUBxyjBHsQT6r3t6rpnovR1ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLY9p/Vg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLY9p/Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309496; x=1781845496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FzGa1cF5BgK8+3Qn4FIUr4IJUcJZzVT+CQbO8TnhVMw=;
  b=BLY9p/VgEoPkPmcO+ZndbB26xtCSQS42Jgx0PmkDz+pUDTOt01NEPuNw
   tGur6uRzIntcF6E5/VQp/qd5cbXec6DN1EeLgXF9Bcme6zhLDlioiRlym
   PMRoCyiB5uDgHJPjGH982FDc1nNcNZO09mwFyOfUeSgQyWcqJCg51OAwn
   F2OsTazUnIsWrIDPgjCVPwKhl1BKa9HjTuFxukJRTzvr8k9bj6kRbxofI
   VycFufDKErMzaPXgaLGM83zQKCrFYKSPzIQ0O48ffHjdN1U3QUbu1DdN0
   i/IRs8XsRvByZZdr8BTTZVa27z3+I5+AT54AFCgu02TCo4V8fsbxCUR8z
   g==;
X-CSE-ConnectionGUID: H0mQxf1yTK+7zYQzgKCOiw==
X-CSE-MsgGUID: YP0kMqGUTomKIDES6iZg1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702249"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702249"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:55 -0700
X-CSE-ConnectionGUID: E6x8D58IQ1GqU4uBwv2LiQ==
X-CSE-MsgGUID: lMwV3T1UTzSIk72lwdDUzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="181373673"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVoWNTFf6QLLsmCXEzH1yYXIdlhzP3ktglzFdiR4kckQp/g6gK82hyQKq3YXvJuGn3sCiU4Vl7l8IxA6gmh0J8Tk5IC27bzkCo5nFM8MpX7QFZ/5g1j/RTtCpLJq7WjRjLVtLRmltp6QgLSjwmfBZOhfFq8Zu9/LhwmOhjKfscarKZaagPNTsfKRv9FWWUmXgRB5duCb3Hfpr87zIc6w+RkaugB6yw/2QOCBXjSpRtxkgtdmPvxS5im6TDPJjqZG0EZXcl0foKRhG2LYcMQQHyOxA+Wvo12sy2LXfNdlFMS1UVuoXsjBeQs/vilMdTjQlgJv9A4HXy/0GI/aLIFOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnGeI9s0zjM/kbUsos/oi17BSerzhw4gUn9IjEQG4IY=;
 b=JdUYG1BdEhhF7rGY6QgI6wZlyiumApzOlZqlA2MP0zRW4PoylVtyMQXy40tRj7IjNV2qS1OZD40PACRswzeIim9KatV9Hvk5J9g+4ATeEKAWG2IOWTSuJEdWz4G2CznvbSXshnldNL/cbtY6aQ2KOQYqj6oZ1VReW2yKzQghElGYYpcKXnRRbTPXUyPxC31XLd/xLACaFanO7ccFwL5kxnblXvN4JFOYEOpJn/5hYcZxJbEfnR5bhZqxtovWjH6sCmBHpGKocWO5sVii/GmYS8Rs/OLqqo0qcf11UNs1MpT9fV0Ax/43G8ny9s0fkGv5aY1Xt8agWSpEWWYthdcBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:28 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v2 8/8] cxl: Convert to ACQUIRE() for conditional rwsem locking
Date: Wed, 18 Jun 2025 22:04:16 -0700
Message-ID: <20250619050416.782871-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c65719-9168-4b56-aeb6-08ddaeeec4a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?66ya+iNEozipKQ2SlnMzHwAEGbnbqqW3K/uYpWc9rymLilf9PUgmcXw03+Y4?=
 =?us-ascii?Q?EJHif9Zh09FQqKOl7K3NKGwLFKMNbAu8kqE/ZRs6ScRiuSgoRA3wTL00Tezu?=
 =?us-ascii?Q?frLF2XKVr/cyOa389/a9+iGO/un+kra0n7L/9WJdv5F7FSleeCullurV04h5?=
 =?us-ascii?Q?sNRk1p6XLXTTE/iBvNA3sk05IEfv2taI2KZNcMmheznVkzsF6QenzQbgejXg?=
 =?us-ascii?Q?ln+Z5S3AmJCzP6RD8AkM56m2pB4ast5Z+2oLbXVElVy/A58Tr3+sDT29kMwf?=
 =?us-ascii?Q?M7wd18bPuG1umDNV7zJP95aRl5obbwbmMJBPEFkRQ2OCLWiEehJia9tdEtnf?=
 =?us-ascii?Q?MfW/bbw6p9uCfqrSwdGBc2vKAGp8pIsz1q0GP0PE+bStJq6GGWAH/pu9nJU3?=
 =?us-ascii?Q?xqKbEanwNuQLyFDK9YwFBx5bBPHKetauoupQJOBA51AW9+8eXusQB3V/KfV0?=
 =?us-ascii?Q?ILadPO1dI+QamYUDLSF6b8Xm1mBssPj2dsY18fqQtPSfTjsd3x1ZVUqlfBcH?=
 =?us-ascii?Q?uVrQxjpO76VilA36H+PaXrV+2FNMpFBtrs2FHzKR6fsT6tMTZ9KQFUqlIa6B?=
 =?us-ascii?Q?eFjKrk81nX0ImnuZY7ZsVVhVOQPSCqy+9HJ/S2oLQWE/U6G9dQQTM1LdkDkN?=
 =?us-ascii?Q?gNroe5CPd2tDOhjoBGc4pKxiNye40tmsTJuEtJFxkQfkFOk+cs7HgEz9449G?=
 =?us-ascii?Q?4MIY/sJg018DykTv1FJ0lS9U/89HeK3sgrWMWgNtcn6MPh6zuyuEmwEF2Sti?=
 =?us-ascii?Q?bsILTb480wLzpRV9NQ7Ct6m4UI/poMG6bSrq1uEQCkEL6Havfb4eJQXdStpO?=
 =?us-ascii?Q?mctsZPWsdtrxdSSkewG8lFe5pnclepup7DyyPXsSz0TcBpaSfkmSfuOInMly?=
 =?us-ascii?Q?q5WWQY3lkRvYZSbYZBvg2gVpWE1aPrCwB+O/YJ1GrQ9YvuJYHIc3mYIbmGCn?=
 =?us-ascii?Q?eCmz8lsaCggPNGF9s1xEtP0CAM+BME0X6x/ag2yiZUYP3yTvR7oP/K0/UMg7?=
 =?us-ascii?Q?ZSx9GMeNaUfMPPCELXMBGb8OXGzGPft2ZMzEbul+FAfZddtb+sfa/m+W2OM2?=
 =?us-ascii?Q?R5ydPpJublFIqZyVom4cs71F0DOvKRhvVpOfJ9paNRgMz6l+AYDWxe08Ey8V?=
 =?us-ascii?Q?Zib5vq8uZdIaxwIUmfMpOIzrloWiDkEBaHWOdRy6ZM5Pqw3RrQ/wlOLR5eTe?=
 =?us-ascii?Q?guOAWoSbvfB9ErVlrN+oSfF3Cp68iD5K3vcEGj+tF/xNbih68EGe+439Z03O?=
 =?us-ascii?Q?4LbPqH+durp4kROxYV0EstKozjPisFOxzfKftcrYKAWBduuiCsz1JG15HnkM?=
 =?us-ascii?Q?/o3PCuxFgfR7AZrZNNTabqhr/IZUpQ+TEnFPri5NIQ5XTuknrJWUol17fQSm?=
 =?us-ascii?Q?IIEMQwCuJvzGPF3ZKIWn5bcfOLtsCYO2onVyftCaAquYuaFHPKkEB/j8cbQH?=
 =?us-ascii?Q?WotTbpJhJvQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eFIto9/9FIYipaLgosvDZFExHywGuOksk2qfunJVuxV7AmAvlkd0aFbxpZSq?=
 =?us-ascii?Q?BjcpFyVsxPGp1MRnn6IpUV48Wd9i4EmMRj6MbfVKO7pcrOJqnM81iuODIKOz?=
 =?us-ascii?Q?WrcDGM8hYnvy6Wx1xTp9wggCkTYLRgvHkP1Hie4ZBz5IuXukvJcIXJD2LFy5?=
 =?us-ascii?Q?awQzbSQfbs0HHrsuwa0balFGvsfFtye5NW8Y6jRkYy2xpQDMj9sAwhDLroSP?=
 =?us-ascii?Q?eXKvxL9shMBy4ANCYMQIaitP2w/naQevCf6NgDQxKqCsHkaaMnYOi7YmZF3u?=
 =?us-ascii?Q?HsTPmB6/F7keGQAm4Q2lA3TpSFNDf+7bpmL7bjssWOKajqO0KPzPf7BQyY3C?=
 =?us-ascii?Q?5w8jFeLhSUoZreIdI/TBqyUHhJkvSC9yvaD84tY8Tlh3RbPtMQcQd5SZ1RQj?=
 =?us-ascii?Q?AlClKy4p49QThyvnHSTjKHlhOAPIfRSKHv2ULXu/QYFoWYGYPgWLLheHKsth?=
 =?us-ascii?Q?OI3o4hJNdLiWa+ZuDOvk/WYF1We8ADFXVLn5Y2Vcub4vzuGaISQr6WAb0Cnw?=
 =?us-ascii?Q?GiuUtiUPcgtkAZS9uc3ynxabANdkIpruDBas79sz0lhSH8AKyrUi8XTmTD9q?=
 =?us-ascii?Q?z05h10wTiyLnvrrRhmAXAY0KNTUEHBzj91V2PUvCzYgwjUJcO2ZuLPfJRUBb?=
 =?us-ascii?Q?RYZ1pDRaaOLQ7AqcIWkutU4nzNHkKbXlj/9yirQUQ1ZkPMmSTGkNmCViU30M?=
 =?us-ascii?Q?X7Qa79QVdYw96zWA0Ca5PbRo0Yf1q1wSBSWtffN4gea9XqwDKyeQ/TDi5QZy?=
 =?us-ascii?Q?3VEhbILoCOf5HfXm0LIh3HZUCXuTXIILrHpjdA3a1ZcTES0qHFT8/3o9L32l?=
 =?us-ascii?Q?whD2rXnVPPBBWPD1TxgMoPrb+4gXoygFAZp66gsTY5uafB3AL0BW9nZErMXR?=
 =?us-ascii?Q?zXKRtSyxu7UfLkWhECzgog89cXHGm0aqs2uCaFpmT/fd44iEDajPINrF+xeJ?=
 =?us-ascii?Q?WlvUQfo+T28PGGyBwdnoHazBeTg9Z/4aeXq4JyFnc8CSqeWwqpdUN2C4q6B7?=
 =?us-ascii?Q?qZN0WE9epsi8vWrO1VLz3eZ/knbLEjOcLkA9HcKP8fL1jyC7p7+FVCTsF1m3?=
 =?us-ascii?Q?qjdZ+3Wnhf+JGNsVZBPMZc7a7Xrcxx5mxojYAcKzNS39HE9Ck/wc75AoecM0?=
 =?us-ascii?Q?E/jA07VFjjgCHTXtuU02evpsOPJc0KyiB3CW3xtzCrzmxfv/zmcC7Yqj9m5y?=
 =?us-ascii?Q?Hfor7gJr51kJRLBvCxOU+yuWdlOD4yc+6f4ey+7iEnQC1ZbJzurQdqM4HD33?=
 =?us-ascii?Q?BiZmzDunD9RktXMVlsoUllT61Bis4UzO4+o7HGttXnJFDbZxY9SE1al/fMWK?=
 =?us-ascii?Q?hm/4FEALgCevq0JVVF3SMQmt53y0ejBbwAF5bN3Uh/A8luQcU6SgwLdft5Oy?=
 =?us-ascii?Q?WNUI8QD0foRgY8/dLI9fWh/V2FrJfXyUIKJXzRgdJnTne646X5R+Ai5cnuKI?=
 =?us-ascii?Q?quaQgzyvuVbhOBex5f8TdclRlX2VDIhnpS/qVp0dpDtOuXpQuMl0Tpi4XYSq?=
 =?us-ascii?Q?pyWqDVDRMi6gaodKuF1tdnnfaZJiuCdjSPHWEBCmCm0ya7wsOJzyzFLP5yp6?=
 =?us-ascii?Q?b6vNP2Gv9mO3Rrt2bTUt2TLwUq+7I5wTi/RwHmnvtK/Rx7XR9xeK0ju113Mc?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c65719-9168-4b56-aeb6-08ddaeeec4a9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:28.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IvadolWnBZNomoAp4t2Ktu4/PyRM6eBMD3SGhozvi6bYaEbDnPHbid61lbz9Ckqe0VndxnaVOLU21vrZGzOlZVdLkBSAdc5/JTWbbsAI1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
representing the state of the conditional lock.

The goal of this conversion is to complete the removal of all explicit
unlock calls in the subsystem. I.e. the methods to acquire a lock are
solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
unlock is implicit / scope-based. In order to make sure all lock sites are
converted, the existing rwsem's are consolidated and renamed in 'struct
cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
between old-world (explicit unlock allowed), and new world (explicit unlock
deleted).

Cc: David Lechner <dlechner@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/cdat.c   |   6 +-
 drivers/cxl/core/core.h   |  43 +++---
 drivers/cxl/core/edac.c   |  44 +++----
 drivers/cxl/core/hdm.c    |  41 +++---
 drivers/cxl/core/mbox.c   |   6 +-
 drivers/cxl/core/memdev.c |  50 +++----
 drivers/cxl/core/port.c   |  18 +--
 drivers/cxl/core/region.c | 266 +++++++++++++++-----------------------
 drivers/cxl/cxl.h         |  13 +-
 include/linux/rwsem.h     |   1 +
 10 files changed, 206 insertions(+), 282 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 0ccef2f2a26a..c0af645425f4 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -336,7 +336,7 @@ static int match_cxlrd_hb(struct device *dev, void *data)
 	cxlrd = to_cxl_root_decoder(dev);
 	cxlsd = &cxlrd->cxlsd;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	for (int i = 0; i < cxlsd->nr_targets; i++) {
 		if (host_bridge == cxlsd->target[i]->dport_dev)
 			return 1;
@@ -987,7 +987,7 @@ void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
 	bool is_root;
 	int rc;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_rwsem.dpa);
 
 	struct xarray *usp_xa __free(free_perf_xa) =
 		kzalloc(sizeof(*usp_xa), GFP_KERNEL);
@@ -1057,7 +1057,7 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 {
 	struct cxl_dpa_perf *perf;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_rwsem.dpa);
 
 	perf = cxled_get_dpa_perf(cxled);
 	if (IS_ERR(perf))
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8a65777ef3d3..ed7d08244542 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -5,6 +5,7 @@
 #define __CXL_CORE_H__
 
 #include <cxl/mailbox.h>
+#include <linux/rwsem.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -107,8 +108,20 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 #define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
 #define PCI_CAP_EXP_SIZEOF		0x3c
 
-extern struct rw_semaphore cxl_dpa_rwsem;
-extern struct rw_semaphore cxl_region_rwsem;
+struct cxl_rwsem {
+	/*
+	 * All changes to HPA (interleave configuration) occur with this
+	 * lock held for write.
+	 */
+	struct rw_semaphore region;
+	/*
+	 * All changes to a device DPA space occur with this lock held
+	 * for write.
+	 */
+	struct rw_semaphore dpa;
+};
+
+extern struct cxl_rwsem cxl_rwsem;
 
 DEFINE_CLASS(
 	cxl_decoder_detach, struct cxl_region *,
@@ -117,22 +130,22 @@ DEFINE_CLASS(
 		put_device(&_T->dev);
 	},
 	({
-		int rc = 0;
-
 		/* when the decoder is being destroyed lock unconditionally */
-		if (mode == DETACH_INVALIDATE)
-			down_write(&cxl_region_rwsem);
-		else
-			rc = down_write_killable(&cxl_region_rwsem);
-
-		if (rc)
-			cxlr = ERR_PTR(rc);
-		else {
+		if (mode == DETACH_INVALIDATE) {
+			guard(rwsem_write)(&cxl_rwsem.region);
 			cxlr = cxl_decoder_detach(cxlr, cxled, pos, mode);
-			get_device(&cxlr->dev);
+		} else {
+			int rc;
+
+			ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+			if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+				cxlr = ERR_PTR(rc);
+			else
+				cxlr = cxl_decoder_detach(cxlr, cxled, pos,
+							  mode);
 		}
-		up_write(&cxl_region_rwsem);
-
+		if (!IS_ERR_OR_NULL(cxlr))
+			get_device(&cxlr->dev);
 		cxlr;
 	}),
 	struct cxl_region *cxlr, struct cxl_endpoint_decoder *cxled, int pos,
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 2cbc664e5d62..f1ebdbe222c8 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -115,10 +115,9 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
 						flags, min_cycle);
 	}
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return ret;
 
 	cxlr = cxl_ps_ctx->cxlr;
 	p = &cxlr->params;
@@ -154,10 +153,9 @@ static int cxl_scrub_set_attrbs_region(struct device *dev,
 	struct cxl_region *cxlr;
 	int ret, i;
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return ret;
 
 	cxlr = cxl_ps_ctx->cxlr;
 	p = &cxlr->params;
@@ -1332,16 +1330,15 @@ cxl_mem_perform_sparing(struct device *dev,
 	struct cxl_memdev_sparing_in_payload sparing_pi;
 	struct cxl_event_dram *rec = NULL;
 	u16 validity_flags = 0;
+	int ret;
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return ret;
 
-	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
-	if (!dpa_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return ret;
 
 	if (!cxl_sparing_ctx->cap_safe_when_in_use) {
 		/* Memory to repair must be offline */
@@ -1779,16 +1776,15 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
 	struct cxl_memdev_ppr_maintenance_attrbs maintenance_attrbs;
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_mem_repair_attrbs attrbs = { 0 };
+	int ret;
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return ret;
 
-	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
-	if (!dpa_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return ret;
 
 	if (!cxl_ppr_ctx->media_accessible || !cxl_ppr_ctx->data_retained) {
 		/* Memory to repair must be offline */
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e9cb34e30248..865a71bce251 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,7 +16,10 @@
  * for enumerating these registers and capabilities.
  */
 
-DECLARE_RWSEM(cxl_dpa_rwsem);
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
 
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			   int *target_map)
@@ -214,7 +217,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 {
 	struct resource *p1, *p2;
 
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
 	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
 		__cxl_dpa_debug(file, p1, 0);
 		for (p2 = p1->child; p2; p2 = p2->sibling)
@@ -266,7 +269,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	struct resource *res = cxled->dpa_res;
 	resource_size_t skip_start;
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
 	/* save @skip_start, before @res is released */
 	skip_start = res->start - cxled->skip;
@@ -281,7 +284,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 static void cxl_dpa_release(void *cxled)
 {
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	__cxl_dpa_release(cxled);
 }
 
@@ -293,7 +296,7 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
 	devm_remove_action(&port->dev, cxl_dpa_release, cxled);
 	__cxl_dpa_release(cxled);
 }
@@ -361,7 +364,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct resource *res;
 	int rc;
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
 	if (!len) {
 		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
@@ -470,7 +473,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 {
 	struct device *dev = cxlds->dev;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 
 	if (cxlds->nr_partitions)
 		return -EBUSY;
@@ -516,9 +519,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	int rc;
 
-	down_write(&cxl_dpa_rwsem);
-	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
-	up_write(&cxl_dpa_rwsem);
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
+		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
 
 	if (rc)
 		return rc;
@@ -529,7 +531,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 {
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
 	if (cxled->dpa_res)
 		return resource_size(cxled->dpa_res);
 
@@ -540,7 +542,7 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 {
 	resource_size_t base = -1;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_rwsem.dpa);
 	if (cxled->dpa_res)
 		base = cxled->dpa_res->start;
 
@@ -552,7 +554,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct device *dev = &cxled->cxld.dev;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	if (!cxled->dpa_res)
 		return 0;
 	if (cxled->cxld.region) {
@@ -582,7 +584,7 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	struct device *dev = &cxled->cxld.dev;
 	int part;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
 		return -EBUSY;
 
@@ -614,7 +616,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	struct resource *p, *last;
 	int part;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder attached to %s\n",
 			dev_name(&cxled->cxld.region->dev));
@@ -842,9 +844,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	down_read(&cxl_dpa_rwsem);
-	setup_hw_decoder(cxld, hdm);
-	up_read(&cxl_dpa_rwsem);
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		setup_hw_decoder(cxld, hdm);
 
 	port->commit_end++;
 	rc = cxld_await_commit(hdm, cxld->id);
@@ -882,7 +883,7 @@ void cxl_port_commit_reap(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	/*
 	 * Once the highest committed decoder is disabled, free any other
@@ -1030,7 +1031,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
-		guard(rwsem_write)(&cxl_region_rwsem);
+		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 81b21effe8cf..92cd3cbdd8ec 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -909,8 +909,8 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		 * translations. Take topology mutation locks and lookup
 		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
 		 */
-		guard(rwsem_read)(&cxl_region_rwsem);
-		guard(rwsem_read)(&cxl_dpa_rwsem);
+		guard(rwsem_read)(&cxl_rwsem.region);
+		guard(rwsem_read)(&cxl_rwsem.dpa);
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
@@ -1265,7 +1265,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	/* synchronize with cxl_mem_probe() and decoder write operations */
 	guard(device)(&cxlmd->dev);
 	endpoint = cxlmd->endpoint;
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	/*
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..f5fbd34310fd 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -232,15 +232,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
-	}
 
 	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
@@ -249,8 +247,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		/* Regions mapped, collect poison by endpoint */
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -292,19 +288,17 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
-	}
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	inject.address = cpu_to_le64(dpa);
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -314,7 +308,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -327,11 +321,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
 
@@ -347,19 +338,17 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
-	}
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	/*
 	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
@@ -378,7 +367,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -391,11 +380,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0f1629856380..58764d8a935b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -30,18 +30,12 @@
  * instantiated by the core.
  */
 
-/*
- * All changes to the interleave configuration occur with this lock held
- * for write.
- */
-DECLARE_RWSEM(cxl_region_rwsem);
-
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
 int cxl_num_decoders_committed(struct cxl_port *port)
 {
-	lockdep_assert_held(&cxl_region_rwsem);
+	lockdep_assert_held(&cxl_rwsem.region);
 
 	return port->commit_end + 1;
 }
@@ -176,7 +170,7 @@ static ssize_t target_list_show(struct device *dev,
 	ssize_t offset;
 	int rc;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	rc = emit_target_list(cxlsd, buf);
 	if (rc < 0)
 		return rc;
@@ -196,7 +190,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	/* without @cxl_dpa_rwsem, make sure @part is not reloaded */
+	/* without @cxl_rwsem.dpa, make sure @part is not reloaded */
 	int part = READ_ONCE(cxled->part);
 	const char *desc;
 
@@ -235,7 +229,7 @@ static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *at
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
 	return sysfs_emit(buf, "%#llx\n", (u64)cxl_dpa_resource_start(cxled));
 }
 static DEVICE_ATTR_RO(dpa_resource);
@@ -560,7 +554,7 @@ static ssize_t decoders_committed_show(struct device *dev,
 {
 	struct cxl_port *port = to_cxl_port(dev);
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	return sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
 }
 
@@ -1722,7 +1716,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	if (xa_empty(&port->dports))
 		return -EINVAL;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 010964aa5489..a2ba19151d4f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -141,16 +141,12 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region_params *p = &cxlr->params;
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 	if (cxlr->mode != CXL_PARTMODE_PMEM)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%pUb\n", &p->uuid);
 }
 
 static int is_dup(struct device *match, void *data)
@@ -162,7 +158,7 @@ static int is_dup(struct device *match, void *data)
 	if (!is_cxl_region(match))
 		return 0;
 
-	lockdep_assert_held(&cxl_region_rwsem);
+	lockdep_assert_held(&cxl_rwsem.region);
 	cxlr = to_cxl_region(match);
 	p = &cxlr->params;
 
@@ -192,27 +188,22 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 	if (uuid_is_null(&temp))
 		return -EINVAL;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &region_rwsem)))
 		return rc;
 
 	if (uuid_equal(&p->uuid, &temp))
-		goto out;
+		return len;
 
-	rc = -EBUSY;
 	if (p->state >= CXL_CONFIG_ACTIVE)
-		goto out;
+		return -EBUSY;
 
 	rc = bus_for_each_dev(&cxl_bus_type, NULL, &temp, is_dup);
 	if (rc < 0)
-		goto out;
+		return rc;
 
 	uuid_copy(&p->uuid, &temp);
-out:
-	up_write(&cxl_region_rwsem);
 
-	if (rc)
-		return rc;
 	return len;
 }
 static DEVICE_ATTR_RW(uuid);
@@ -354,20 +345,17 @@ static int queue_reset(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
 
 	/* Already in the requested state? */
 	if (p->state < CXL_CONFIG_COMMIT)
-		goto out;
+		return 0;
 
 	p->state = CXL_CONFIG_RESET_PENDING;
 
-out:
-	up_write(&cxl_region_rwsem);
-
-	return rc;
+	return 0;
 }
 
 static int __commit(struct cxl_region *cxlr)
@@ -375,19 +363,17 @@ static int __commit(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
 
 	/* Already in the requested state? */
 	if (p->state >= CXL_CONFIG_COMMIT)
-		goto out;
+		return 0;
 
 	/* Not ready to commit? */
-	if (p->state < CXL_CONFIG_ACTIVE) {
-		rc = -ENXIO;
-		goto out;
-	}
+	if (p->state < CXL_CONFIG_ACTIVE)
+		return -ENXIO;
 
 	/*
 	 * Invalidate caches before region setup to drop any speculative
@@ -395,16 +381,15 @@ static int __commit(struct cxl_region *cxlr)
 	 */
 	rc = cxl_region_invalidate_memregion(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	rc = cxl_region_decode_commit(cxlr);
-	if (rc == 0)
-		p->state = CXL_CONFIG_COMMIT;
+	if (rc)
+		return rc;
 
-out:
-	up_write(&cxl_region_rwsem);
+	p->state = CXL_CONFIG_COMMIT;
 
-	return rc;
+	return 0;
 }
 
 static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
@@ -437,10 +422,10 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	device_release_driver(&cxlr->dev);
 
 	/*
-	 * With the reset pending take cxl_region_rwsem unconditionally
+	 * With the reset pending take cxl_rwsem.region unconditionally
 	 * to ensure the reset gets handled before returning.
 	 */
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 
 	/*
 	 * Revalidate that the reset is still pending in case another
@@ -461,13 +446,10 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region_params *p = &cxlr->params;
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->state >= CXL_CONFIG_COMMIT);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%d\n", p->state >= CXL_CONFIG_COMMIT);
 }
 static DEVICE_ATTR_RW(commit);
 
@@ -491,15 +473,11 @@ static ssize_t interleave_ways_show(struct device *dev,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->interleave_ways);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if (ACQUIRE_ERR(rwsem_read_intr, &rwsem))
+		return ACQUIRE_ERR(rwsem_read_intr, &rwsem);
+	return sysfs_emit(buf, "%d\n", p->interleave_ways);
 }
 
 static const struct attribute_group *get_cxl_region_target_group(void);
@@ -534,23 +512,21 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc)
+	if (rc) {
 		p->interleave_ways = save;
-out:
-	up_write(&cxl_region_rwsem);
-	if (rc)
 		return rc;
+	}
+
 	return len;
 }
 static DEVICE_ATTR_RW(interleave_ways);
@@ -561,15 +537,11 @@ static ssize_t interleave_granularity_show(struct device *dev,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
-
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->interleave_granularity);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if (ACQUIRE_ERR(rwsem_read_intr, &rwsem))
+		return ACQUIRE_ERR(rwsem_read_intr, &rwsem);
+	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
 static ssize_t interleave_granularity_store(struct device *dev,
@@ -602,19 +574,15 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	p->interleave_granularity = val;
-out:
-	up_write(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+
 	return len;
 }
 static DEVICE_ATTR_RW(interleave_granularity);
@@ -625,17 +593,14 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
 	u64 resource = -1ULL;
-	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if (ACQUIRE_ERR(rwsem_read_intr, &rwsem))
+		return ACQUIRE_ERR(rwsem_read_intr, &rwsem);
+
 	if (p->res)
 		resource = p->res->start;
-	rc = sysfs_emit(buf, "%#llx\n", resource);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%#llx\n", resource);
 }
 static DEVICE_ATTR_RO(resource);
 
@@ -663,7 +628,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	struct resource *res;
 	u64 remainder = 0;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	/* Nothing to do... */
 	if (p->res && resource_size(p->res) == size)
@@ -705,7 +670,7 @@ static void cxl_region_iomem_release(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 
 	if (device_is_registered(&cxlr->dev))
-		lockdep_assert_held_write(&cxl_region_rwsem);
+		lockdep_assert_held_write(&cxl_rwsem.region);
 	if (p->res) {
 		/*
 		 * Autodiscovered regions may not have been able to insert their
@@ -722,7 +687,7 @@ static int free_hpa(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (!p->res)
 		return 0;
@@ -746,15 +711,14 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
 
 	if (val)
 		rc = alloc_hpa(cxlr, val);
 	else
 		rc = free_hpa(cxlr);
-	up_write(&cxl_region_rwsem);
 
 	if (rc)
 		return rc;
@@ -770,15 +734,12 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	u64 size = 0;
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
 	if (p->res)
 		size = resource_size(p->res);
-	rc = sysfs_emit(buf, "%#llx\n", size);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%#llx\n", size);
 }
 static DEVICE_ATTR_RW(size);
 
@@ -804,26 +765,20 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
 
 	if (pos >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
 			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	cxled = p->targets[pos];
 	if (!cxled)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
-out:
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
 }
 
 static int check_commit_order(struct device *dev, void *data)
@@ -938,7 +893,7 @@ cxl_port_pick_region_decoder(struct cxl_port *port,
 	/*
 	 * This decoder is pinned registered as long as the endpoint decoder is
 	 * registered, and endpoint decoder unregistration holds the
-	 * cxl_region_rwsem over unregister events, so no need to hold on to
+	 * cxl_rwsem.region over unregister events, so no need to hold on to
 	 * this extra reference.
 	 */
 	put_device(dev);
@@ -1129,7 +1084,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	unsigned long index;
 	int rc = -EBUSY;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	cxl_rr = cxl_rr_load(port, cxlr);
 	if (cxl_rr) {
@@ -1239,7 +1194,7 @@ static void cxl_port_detach_region(struct cxl_port *port,
 	struct cxl_region_ref *cxl_rr;
 	struct cxl_ep *ep = NULL;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	cxl_rr = cxl_rr_load(port, cxlr);
 	if (!cxl_rr)
@@ -2150,7 +2105,7 @@ struct cxl_region *cxl_decoder_detach(struct cxl_region *cxlr,
 {
 	struct cxl_region_params *p;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (!cxled) {
 		p = &cxlr->params;
@@ -2212,19 +2167,19 @@ static int attach_target(struct cxl_region *cxlr,
 			 struct cxl_endpoint_decoder *cxled, int pos,
 			 unsigned int state)
 {
-	int rc = 0;
-
-	if (state == TASK_INTERRUPTIBLE)
-		rc = down_write_killable(&cxl_region_rwsem);
-	else
-		down_write(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+	int rc;
 
-	down_read(&cxl_dpa_rwsem);
-	rc = cxl_region_attach(cxlr, cxled, pos);
-	up_read(&cxl_dpa_rwsem);
-	up_write(&cxl_region_rwsem);
+	if (state == TASK_INTERRUPTIBLE) {
+		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)) == 0) {
+			guard(rwsem_read)(&cxl_rwsem.dpa);
+			rc = cxl_region_attach(cxlr, cxled, pos);
+		}
+	} else {
+		guard(rwsem_write)(&cxl_rwsem.region);
+		guard(rwsem_read)(&cxl_rwsem.dpa);
+		rc = cxl_region_attach(cxlr, cxled, pos);
+	}
 
 	if (rc)
 		dev_warn(cxled->cxld.dev.parent,
@@ -2493,7 +2448,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/*
-	 * No need to hold cxl_region_rwsem; region parameters are stable
+	 * No need to hold cxl_rwsem.region; region parameters are stable
 	 * within the cxl_region driver.
 	 */
 	region_nid = phys_to_target_node(cxlr->params.res->start);
@@ -2516,7 +2471,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 	int region_nid;
 
 	/*
-	 * No need to hold cxl_region_rwsem; region parameters are stable
+	 * No need to hold cxl_rwsem.region; region parameters are stable
 	 * within the cxl_region driver.
 	 */
 	region_nid = phys_to_target_node(cxlr->params.res->start);
@@ -2665,17 +2620,13 @@ static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
 
 	if (cxld->region)
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
-	else
-		rc = sysfs_emit(buf, "\n");
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
+	return sysfs_emit(buf, "\n");
 }
 DEVICE_ATTR_RO(region);
 
@@ -3014,7 +2965,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	struct device *dev;
 	int i;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	if (p->state != CXL_CONFIG_COMMIT)
 		return -ENXIO;
 
@@ -3026,7 +2977,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	cxlr_pmem->hpa_range.start = p->res->start;
 	cxlr_pmem->hpa_range.end = p->res->end;
 
-	/* Snapshot the region configuration underneath the cxl_region_rwsem */
+	/* Snapshot the region configuration underneath the cxl_rwsem.region */
 	cxlr_pmem->nr_mappings = p->nr_targets;
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
@@ -3103,7 +3054,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	if (p->state != CXL_CONFIG_COMMIT)
 		return ERR_PTR(-ENXIO);
 
@@ -3303,7 +3254,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	if (p->res && p->res->start == r->start && p->res->end == r->end)
 		return 1;
 
@@ -3363,7 +3314,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	struct resource *res;
 	int rc;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
@@ -3499,10 +3450,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
-	down_read(&cxl_region_rwsem);
-	p = &cxlr->params;
-	attach = p->state == CXL_CONFIG_COMMIT;
-	up_read(&cxl_region_rwsem);
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		p = &cxlr->params;
+		attach = p->state == CXL_CONFIG_COMMIT;
+	}
 
 	if (attach) {
 		/*
@@ -3527,7 +3478,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 	if (!endpoint)
 		return ~0ULL;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 
 	xa_for_each(&endpoint->regions, index, iter) {
 		struct cxl_region_params *p = &iter->region->params;
@@ -3569,30 +3520,23 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc) {
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem))) {
 		dev_dbg(&cxlr->dev, "probe interrupted\n");
 		return rc;
 	}
 
 	if (p->state < CXL_CONFIG_COMMIT) {
 		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
 		dev_err(&cxlr->dev,
 			"failed to activate, re-commit region and retry\n");
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
-out:
-	up_read(&cxl_region_rwsem);
-
-	if (rc)
-		return rc;
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f1695c96abc..50799a681231 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -469,7 +469,7 @@ enum cxl_config_state {
  * @nr_targets: number of targets
  * @cache_size: extended linear cache size if exists, otherwise zero.
  *
- * State transitions are protected by the cxl_region_rwsem
+ * State transitions are protected by cxl_rwsem.region
  */
 struct cxl_region_params {
 	enum cxl_config_state state;
@@ -912,15 +912,4 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 #endif
 
 u16 cxl_gpf_get_dvsec(struct device *dev);
-
-static inline struct rw_semaphore *rwsem_read_intr_acquire(struct rw_semaphore *rwsem)
-{
-	if (down_read_interruptible(rwsem))
-		return NULL;
-
-	return rwsem;
-}
-
-DEFINE_FREE(rwsem_read_release, struct rw_semaphore *, if (_T) up_read(_T))
-
 #endif /* __CXL_H__ */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c810deb88d13..cbafdc12e743 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -244,6 +244,7 @@ DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
 
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
+DEFINE_GUARD_COND(rwsem_write, _kill, down_write_killable(_T), _RET == 0)
 
 /*
  * downgrade write lock to read lock
-- 
2.49.0

