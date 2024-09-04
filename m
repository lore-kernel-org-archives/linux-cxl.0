Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E3181CE1;
	Wed,  4 Sep 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494309; cv=fail; b=ad3i8KjNF0dij169q81NqQDf5/EaJuv4GKAvOdxSndWrOMxFyvf7bfsoRR2GW+rHHTYPGxD9iLtjDqSTa7K5fIg+nv02ItvOMYlQgurtmv70YuG9b8D09Lv1t6wLv1zd3iZE0Or/Fx9J0uZvQozZBuniins4XBLu8Op5aCaGs+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494309; c=relaxed/simple;
	bh=5uuX7DsesivLHBE8h+71kJPtnfXki9yzlXazf4tTVRQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j/i4BbWyNXpNeYda1vKD/ZkqPkztNKxAPlNFpbuBAvDm3Qyy7KjhKC77EU+iiQ3rKI8ZnmF1aNxLPhiShgSbg7nhzAG3YlQAixL8GVJtTUV6nxjUqgJZoFmgLnEYlq8xTKoYDyJyOCRgkv+wpHA2vIan4tI/j8RErYGl4J0ePqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sduy9bDy; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sduy9bDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725494308; x=1757030308;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5uuX7DsesivLHBE8h+71kJPtnfXki9yzlXazf4tTVRQ=;
  b=Sduy9bDy5pOI29Ggr9tOOWVHKFIQf6xQHGeFQxqwWC/ygTxs6YuctmKR
   xbDfT1syYFRrR1oQtkJsbrNMQTNkGF8xAWgUszt2X5gQEo4396yT0HMdy
   fRolRibcHBIIULDuLzkIwuHag3pF94qx1VESgqCiizpU6GnzYYW2oO99k
   jSM0u8JA4U/qb1X4dOgNiZO4w9+mgbbLjtSYclbslNOuHLCGuECdmWFrR
   sGlo6pYXgPaQ843I5Nc8xDcD3w/a5Fx0T7h25VPYoJz3pkPxbLvgsR1B3
   rL7e3lHOKfrDgwWEtxo1JG6lMG/EWJUNhmK5h4U8XPYk4BC/1G4KKYt1K
   A==;
X-CSE-ConnectionGUID: jFkCHFgyRaaGqqHpVKLxCw==
X-CSE-MsgGUID: 0iFx23g2SlG9TMciNjfO0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35344016"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="35344016"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 16:58:28 -0700
X-CSE-ConnectionGUID: JBdQtAzpR5OerdA/xr5khA==
X-CSE-MsgGUID: LFicELloRZ++WnH+Pne4kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="102882486"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 16:58:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 16:58:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 16:58:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 16:58:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 16:58:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQjGinKbx14vHkwYo889L4cZxFEkX2urS5XkSIvZnrGqjVEKWDckjGlb8/yEHpiXp00sDRHR/c5rsI2lieGvyNcu5j86DpUMdlq+SRZ23AuDeFgOZX55qMfVECvJmOlLPK72/mEqf1vOmwJVeYgu5+1ZRP72mPiKfTLNVK+N9I95HwVb9S7x1DG6hNv3d0qfNneVZUhvH6KZ6EWLokYH3g224E5DemNriKlPGko/syTGtSCbkuiP/kzRr2xgYb3LSG3o7x5tsFuAAi9t/0MNCTktuKdLuAnuShz/fO0HvluZPDPBtp9+SAftjNs0WhdorNaJSlKuuWM7fjV+tW/13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYKygwTYLpABVzSUPVGzAKUk5U1Iu+bknGEuMAAEdg8=;
 b=AFlpaxY4c1AECYuk6nME+ir/GM8+k1fMUgvOxgXZ+9TvJ4dWWxErzTFLM9iahOG13NRyYNeI8fa2Pp46/vBY9J2dIBspnDjJLp1dxncYd+IHygRHhg7JtfAF0L7ipUjiKIa3BfdPEww35aGtLPUuRkKSJjOrtm/F03O/NEAJpAgDDZ85K0SVFMS5F4136QsiiWs3cJBPUGr0HJaasF7pVi8k5HDclD1EQ9u4BQgXpUQxJsmpUuig3k4AW+bNawT7HqKQRNf6IN7g8a0KMV6c50MJsYHdOL9lh6W0w7ECzMLvJ/0ZbSpVXO9jskvL8QY2xFKJwjoZGQkEx6MF4ywXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6666.namprd11.prod.outlook.com (2603:10b6:303:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 23:58:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 23:58:23 +0000
Date: Wed, 4 Sep 2024 16:58:20 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Alistair Popple <apopple@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:303:2b::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: e8638e12-9910-44b2-b61b-08dccd3d75a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uBEOI/ST7/EQqKx7/4pdA9wqlu8ASgshD9pFR8WqXWDntAy/cAeUM74UF6m/?=
 =?us-ascii?Q?zXmm0BjqPsvAC10ZAvot5jVoZzYlk2XLYs8QgJs9ZXebeHhNr9IHktJTHvtT?=
 =?us-ascii?Q?qkBbtkvWigusq8YWI9lVLlkxL4Z/I/W51Dt1KFVO9Q50OSeZpBth1vgvB2wj?=
 =?us-ascii?Q?o5ZiWXzexMXoHCMs1TZPlPVCgdtcabsNifNp9lzauc37P69liavXCEu0a1VD?=
 =?us-ascii?Q?VaBXKWQrJRVpLIq1Xx+XabHt0OAOzF15OM2KFFyE9T6n0KPdY46cSLwoSwzs?=
 =?us-ascii?Q?fMo7LSK9zpkAQEsVNZC8IyHNtftlxmu6o9RDy+L86kImkZJ3dgJpI5tr5u88?=
 =?us-ascii?Q?IvVuoOI2jqF17CvXOJpV0L2ktDR8+VksuPPDt1HjcQIlRq0wg+7FU5T5dKzv?=
 =?us-ascii?Q?gpVHuET7MjVfUJbS20bC0TNL+gUaB35iGlKn54dP2nfcCzj+ben8yO+i+xGV?=
 =?us-ascii?Q?VoC/rCIP0Wp7TjdslpeWhYkvNhiJr+O5bFK0tXr2sV9hvt0PUQvaC4SgJceG?=
 =?us-ascii?Q?EYfmMnLF+MFMNDM8IY4d7U9LE47syvurPONsEzH2g6heMooKp1Jzc1SGL/Dw?=
 =?us-ascii?Q?nD5jgjjmPS4U/4Ba/7mSe2y+25meB0NRJjZ1UeuYgcQvdQL2Y4JKAg5tpcem?=
 =?us-ascii?Q?pvAn2CaNUiHLjBPUDI8YEgG4OVzYvnncsN7qplMHklGQA3vVHqPaeAK6XBas?=
 =?us-ascii?Q?gr0EiGx6RrbA+UitB8HS/gts4LHk6wltU2h7yd5oC5pEwxJQum4e8bEvyEBE?=
 =?us-ascii?Q?oCb2iUbES4PheodOm7gWa1LEZYKAgJCxu4PcVP7vVqsu12Tl+wEzJw9bh6Qn?=
 =?us-ascii?Q?6IAdfNWBzjceO88uQh9Z15ZR7qq5X6wbHBXfIbILkU1UIVvtBwcOWvJcnM41?=
 =?us-ascii?Q?ry7UCayij/mexSdC3ZAwP/qiRSLSY8Gss1mEwyH+LxyVUGCtWn0xQzmdqrRT?=
 =?us-ascii?Q?HsbwQG2iTkR8Gjx0ggYTxzwHfCNK0ME6QoUkw8KhEePTkqADUr77gqbShp6T?=
 =?us-ascii?Q?T3ryi5TR3nti7CO9mkzf7b3xdHZafIHkOEzuaQSecZvDhpZ/LPbj9a/0sMmV?=
 =?us-ascii?Q?HweIXYZm6Z2DsBamMzBM+2oMmOyIqT05MxxJU3agZUEunVIXNHIfVn2K5Krw?=
 =?us-ascii?Q?j3/rrUVtTauD8LKRy+GWMSrjdXanM1H5JmjmXaxK3SAUk3hM/5w82Ojoz06B?=
 =?us-ascii?Q?P4hs/1XQvEpMimRrJo2XIWZHwZXihspm8vhyLflod9M91GhScB30XSvUJNJs?=
 =?us-ascii?Q?zFiYUs0MsrSQUHxZZKlGc2qET6FPoyfposME5vQskCAX45I/4VpmyZkC9bbF?=
 =?us-ascii?Q?mHXocKHYl78yhTzFwgrZvC/JFd6nB8QuSJBZYZ027JNAcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2+dKFWlKxZ4SNF3qnCcEWFV97TYvIEHCJu8pQN72ZQJJ7YASGej4RupaJ1UU?=
 =?us-ascii?Q?GAGHpwtql4pH7HI/ToyRQCWLy/wjfl6HQ5DvSx9gFkebJVemZwDX4dKRb52h?=
 =?us-ascii?Q?vpPSKyNLcLx+uroV7j4stpCgR6HkL8DcL5q5BDhET8y1nlle9sDe2xIFKeNg?=
 =?us-ascii?Q?wIZv4fhAtOQ9M5SrdufX3+s48+7V5Wpbe4iu7iPrF9u9H1f1vb7w8389goCr?=
 =?us-ascii?Q?hPQ9ws0f7OL0rYvN5VUVQzLf6wTj+8BmWKoGvFzeJ9JFBbjn6537gfG9Wt/H?=
 =?us-ascii?Q?5nyoG+EE4/XA5ESNbH5pCH1M65qM7/tS0XzLc0FEpNkHfHVQhysqh34TabXI?=
 =?us-ascii?Q?MMg8nANtVgzMhYgCx3bv7EzMjdfQFwT8SlR/3cmdmbdNOO5efVY0DqN9ZVi5?=
 =?us-ascii?Q?YZdU/EGMbzNtpgukIKEi1bDe2aOC5kWLUudrBPQ4o9+sq5W32dzdxy112glH?=
 =?us-ascii?Q?15PAI1BVLjhfAOY5WZX9sJIbXmvbiWQorDmHF069L5MAz6AmVCPfy5b35/XG?=
 =?us-ascii?Q?8ppX3UGO7ttwY/7Vf1XCpujnO+q6S8xJAeMSyPf3dCrUt2eoW4uefBPCukEK?=
 =?us-ascii?Q?+xVyvzIDzEo6chDp2KFYfr+AgOXauV3ckQdMfJEsrv+hQr7EL5nCbxsl8lE9?=
 =?us-ascii?Q?gUsIvchFjch8rNiHBUe0TqsxNv3v+LjhlVoZFY29g7rP6E9wJxA/vv6KilN3?=
 =?us-ascii?Q?XrW7nyZghlzeNfX8qTf/bzASFISB9JSAk1rkGPPpUVrrjPhus4LCzyfz3rAE?=
 =?us-ascii?Q?44gtR1AXhmtsTUrwNKTQnyWGFZ92DBLyrvpD0MziK5TXm9kxWPpvif9yk1uT?=
 =?us-ascii?Q?zA0iuQVrkjE2s0kxXYUFH9MXzSG8MF7bSOFv8wJyfB75fK3jGZIq+dnKmFLJ?=
 =?us-ascii?Q?dn7PWbBTf2BOBizqTGa34DW7ERYpbG26W+yfIj77I1ZymUs/tYOvukAfzJ2r?=
 =?us-ascii?Q?tbuFmiFl+cHTf1VO8LPypFQuxwkuHMakAztQBScmzQLe2PEKaIWfvdg5bVKe?=
 =?us-ascii?Q?4BGJjuMzHL/HWIYJdbZfZeTP0HD50l9sCkro38RJkU04Xo2FjQjJ8Q5FZew5?=
 =?us-ascii?Q?XA2295DmmMuFxO2cFNax3vvaUg0UBgGcqwAq//mp4Aypw+XrbXDVKsGrZXpP?=
 =?us-ascii?Q?iLATfPwDYrWhdNi5McKsqGMzskBi1/71s25tsTlawL1uhLRl5PZQxy1xYZGr?=
 =?us-ascii?Q?vBzj1szq/X95fCtZu+9rNAz9IwhmOyX+qKv3jR5nHU1g4aROtk3h7LeJrm0h?=
 =?us-ascii?Q?rMgQ3qkZhR2NurORYCP2NMZNAs3/Tv10/M0vruzFsznuS1J8CC+Li7mnAfcM?=
 =?us-ascii?Q?dgfUxuANzas+se8eiw4nk/A5xwa0pnTe1tgtYeVhM9bTEsktflBXwgzgV530?=
 =?us-ascii?Q?B3hZ1bAyUqraR/1LkbJOZXQU8ImDvMQ/cKg2vnnlwM8F3XZKkCXghoZ/aOQI?=
 =?us-ascii?Q?mha9HHMie42psmFN5XiEXZQL7G7TKGgJU2m/dmZQxNFzX3u+/uuYC2Q3bod+?=
 =?us-ascii?Q?ltk2oO3UM7NjSIPlPClEGUBJ+UQMSW6n1c33lMZF8SY4z0/SO0vFbBFHF2go?=
 =?us-ascii?Q?4eB+BNk6MWKDNnm2bqLDZZCg2kVPxz63GRrekW2yryU+v4gtSl1CXUUJQmNp?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8638e12-9910-44b2-b61b-08dccd3d75a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 23:58:23.1794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtYegFQjCS+mF5WOI6XfJR72F3myxWerDDxZa0WWDd0uvIDDXJhlvaFqq69GeQK8CuKOoFGY9vzjXh5bET63u2ZqHbToq0PjddPCtvI61dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6666
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Hi, Andy,
> 
> Thanks for your comments!
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
[..]
> 
> > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> > message.
> 
> Emm... It appears that it's a common practice to include "Cc" in the
> commit log.

Yes, just ignore this feedback, it goes against common practice. Cc list
as is looks sane to me.
