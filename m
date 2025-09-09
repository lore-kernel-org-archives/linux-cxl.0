Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CB4272807
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439207; cv=fail; b=Nqn2ePC05adMJQbIL6vptNQhGrxsgSQvLKcT5EoDkKeHOV3s5Vz9iCxwqHiC24QiOJHh3Adw3kC8VYYx6OY9/e2AqiTc0KpTpabZfT3I2ncEkV36G9jK+x7lTACZid8bjdtdelwYHHjcUTA+v3DDsBondCEfJDfGkNXLs0b7KMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439207; c=relaxed/simple;
	bh=vIPoQXSNeLAKtM8k2FPMaPcC4PaqF5bW6kcc9WmQAu8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kRgKheZp1vF4unuRH87VkhPcp6f1RzhR7QtFsptE5iiEX5zXVSvbiyBjjd6zbU5Xl2R7WUJkzsiQqiAJ0WxTX7dMA1cJSOXZY62yHg9wmZjMkDLa07rcX1VZLeB9LUSJXkfLpjOt+WaRL7LYVdJFa/npQB4dPZujHVR4DgsBYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyfd26QR; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyfd26QR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757439205; x=1788975205;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vIPoQXSNeLAKtM8k2FPMaPcC4PaqF5bW6kcc9WmQAu8=;
  b=lyfd26QRE7ps/mVps8k0VVdTIQlFa33R0qCvZfiZlxkOwt2wTQ2XsAtv
   Su6IgIJOdFSYCHqB9bx9w1WILGJdVb53Qfa/1/qWpKRC2zIVvZS2Isena
   Dm0RZlXCDROF6hyo9zj6Rl2bT+BRX5plQJa6I7iMJb4P7tvm0PDqsgfuv
   P9Isq+m7wqvRAFwP43sORIhpwVwjXjR1Wd8DzKdYLV5rrZlVbasCtp7/a
   C+ORn5iY0VX8HxjXcyRB9uXKLqBfQYjOYTIBn+I7EYnH7H2lQBTjU6S2+
   l5dX4eVb4acmJwXGqZ8uDVQLVO3pmXn5SMbvFMxtoERmCHrOm67HovWpg
   w==;
X-CSE-ConnectionGUID: HqiGmqZVRO+FF2xofk0pOg==
X-CSE-MsgGUID: zaLZ1ST7RqSeIRqtxy1T6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="58774233"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="58774233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 10:33:23 -0700
X-CSE-ConnectionGUID: rwohrmCnTYCn9yFFpuN1NQ==
X-CSE-MsgGUID: xcqYYt++QdGDVspkvLYB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="196828054"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 10:33:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 10:33:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 10:33:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 10:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xL6kqpl0NVt8sN28PGArfwGTkIjFxyZCvKCdDu38TZCpA/cCY31VNyqion2dzuAWVgToMkMAPj+e85mE4kGWxNC5qCww26e2HuI9YASnuHbOZFksP6WkdFD+IqNMSba3iTfVl6AGoSuneR8q/f+Xkbo6DnWuCcAxzI9MQxv/nU2wi7Zzrh+mhUN7XO0qLxh0QVWUcchazp2dCZcIvAFs2LoP9zyeI8glKu4jo3gxBWA/y12h5XBM3q3oILiGXqC6xjrNswyWwpfERlwQARyV8mOzJdwTpzTYc73BPFyMQ2EFF13uno7igfc7pO6TyLUzEVByraKjOdbf3ttTvWp0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/6Z//wbEQLUWAqmW+GNyiLWkPemN8yUJKLgTw7fQaE=;
 b=h95xecT5DHyLJYaZZmkUVwdAkASSP5FB3uw6UOPVraVLzI2/x/Fwp+QXlAWGDUTk3hE4joHKNDkNBkFCYxZEGt6f2nR2YZHBc3pWSdAtkC0i3xPxD5R3PshWCoJVSOnikd9PZNOaQ+p2tJwFlEbCzJd9NVNPbmUo05PWLfiGspzW9nkUDwHxyKCiWaKGKq/wM32zcfRfX0nVUztesB9MFtD2iO4Gv5icOm2HG3ZSOSp4qgwKh98Enhc8NhJucL+/kGAZFNj8Zv/mPbN8UjcKsPla2PUZGYH2RQ+sxc8OGUW6XKu9kTPslQLXbQfLqXmnGJ5c2O2aaTPY7Lk3pvszOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 17:33:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::5a0a:3196:957e:6695%6]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:33:20 +0000
Date: Tue, 9 Sep 2025 10:33:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] cxl/acpi: Make the XOR calculations available for
 testing
Message-ID: <aMBk3TNzy_UJya7g@aschofie-mobl2.lan>
References: <cover.1756446925.git.alison.schofield@intel.com>
 <1474b223f2b50da36f36f07820a8708fcbb8441a.1756446925.git.alison.schofield@intel.com>
 <1d0080dc-484f-4929-a633-152b9e2a3328@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d0080dc-484f-4929-a633-152b9e2a3328@intel.com>
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: bcead97a-f9cf-4ba6-094c-08ddefc6f840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/aC0zAIy27sNbtVttGT7+VGCE33x8VWUSZPN0mc2I0XXudgi+1AY2QvuxjR8?=
 =?us-ascii?Q?2c0s2yELBAdWbJwXVm8X8RGFv4H0G69QlMejc5dQCy/k3EV78Em7Rp7EOAyV?=
 =?us-ascii?Q?I1mFJBzsz+7qJwejCt/dgT6EgLowV7lJR7PCSk07yEkpODEHzTBTy6MPqCO7?=
 =?us-ascii?Q?4At9U6jTR6oaOO2DXuR90PaxhIqv1xAC8zu3SgL+09LeK40f0HIg5qCAGYEa?=
 =?us-ascii?Q?XsnyCpZt9taIa2tTCEnHfYct97+99G7dgKmUB8FPyykjNE5L6Xu1q89iv6aO?=
 =?us-ascii?Q?brg7H/TvYWFd3tFEQpyKKBHpFibZi9MmA6r7vMx3ZyayWsRcCJaZAOHSBqZy?=
 =?us-ascii?Q?GQgB83jJ4sMqxn1zvz5tSaCclzd03klWRGU9VSazwXxHqOuZJHjqPr31X8Zy?=
 =?us-ascii?Q?ICxTjUi3NJ6PLTIXVat3VwXUW0Rb8hPOd/QPIbkRL29RKrCf+Hk6deqVStsL?=
 =?us-ascii?Q?ykicbZeb7krarvJG1M0SGHTz3QyEBUfBdjQkiD17Daq49/Z0NFacV1VqyfBB?=
 =?us-ascii?Q?OkW/1IMs5vJrMjfFADsZIOClLpcJPIBes+BivyLVS4TXneXvf28zYdKLWIVm?=
 =?us-ascii?Q?KTvnI/6MlO4VONONGB80Z2CvEYeu1NJa0F2M8CtAn2D/biiwwjqdWJMcrBtI?=
 =?us-ascii?Q?IVLJFeIydQ9mMrBBi2/SN9YuFd6fnlMBHeOz1JzgfTZqfK0v8bWP7tqUSJaZ?=
 =?us-ascii?Q?DXNi38LRvPQZpWlrUO1TFt8R4hz9gIfbf9skTpv7jp08TEIXB8JIxzrNSEc+?=
 =?us-ascii?Q?tEHKj8rvqSlybbKdXMRME202QXl+TrnHG9wz8jglzIaok2jS+Q79zqXvU8qi?=
 =?us-ascii?Q?cSn2S2eS5G8sCPPKuxGk1w8SWl9jaHZcAyE4N0ElvTMDR85IVefFwbBeJPqL?=
 =?us-ascii?Q?KSIh5VBSFaSAccinUD53uQKDgydv+vUEaDsFVUVbyTfhjS0DIYWwThr5NvtT?=
 =?us-ascii?Q?4gQiSS4VJC0GogOuNwoizH/RPT7Tm6la0gaStakAWi4x3TePEfHh+UDO3W7K?=
 =?us-ascii?Q?tRd50xIUNGRxF1DfRX5PSCYAcSHruwNo2CGC4BJdOCw9VIygw93nfbAsN8UN?=
 =?us-ascii?Q?Yk4WtMQIWZ36Brjw6uyCV1sI3wcE/xVSHy+7cvF1GJy/vfHULN3xVghx8UcA?=
 =?us-ascii?Q?yJla7q0degYuLWsn1ltlWPqOzRH548/VweH5NyeF4JhMi00Qy2616WM9AIB7?=
 =?us-ascii?Q?MzI1apdHtD71g1Q5bOu3NA3CmjWc5pmLlIqtyq7mWShfF+C43IkX5H6cKjPK?=
 =?us-ascii?Q?F2YXawbmwt3eP8Y+lgi1bovZnn82f+wX/qPSHOhfo7evKvmATQOR9MrE0C9w?=
 =?us-ascii?Q?cmwYx/mbTKT3YJ/1vuPP4QAfVEYdZOqx11JY/GSjJU0pQoLCk0W0F4taQ9Cg?=
 =?us-ascii?Q?EjuDvH+SeJbD3Du/y7OB1L/hIHSBUlvcTudpxCFybcexsg5f6BzGw9JsY+I8?=
 =?us-ascii?Q?G+zszNTl+Ss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DP6NHg++DqqRRCCmF7Ho09U3LIdRALSIIymWgxXXCNqzkx0g/UlhUy9rtkT?=
 =?us-ascii?Q?7RvRTyaKG5P3vZtNYFPBpCQeRl9rf/6ly54X15+UFISYtCzHUNCsdfAfXnaV?=
 =?us-ascii?Q?qdDVHXM0e0rDeUd4PIkfFHN0/8VqgDWsIPZVtOaV3s1N577QpKGsM7Tau/DC?=
 =?us-ascii?Q?nqY+7fYnEuEt+/A7DT91d4+CKATVw1o1DFzbcIuo1kYZykQEtiKUD+CfOxKy?=
 =?us-ascii?Q?rPyESCVACE+NctQsa1Ac/f6O0zoKjY/EGLqZdai1IhA+KWiOzdZAGGnDDA77?=
 =?us-ascii?Q?heGBKg7+f6Qf+9LpbkR3CDdjbpWcZ89lB5lPv0SroDmMeoEkjjFxbB9C72Cg?=
 =?us-ascii?Q?cSaOVYmwMPNHw3+8kEzbj/xv+9CwjiNstahhD6sLXYnztNYIoMiN3aMMUXuo?=
 =?us-ascii?Q?6NQnOa53CLc/nVlSLsoKLZrzuLqH8/l2j1aRgPAH2ouUJK9V2bmyD96eHuGl?=
 =?us-ascii?Q?OlTaRByQG7hB085nIkn9jLK9F+17ZptdTr/7llJW7ZnX+NYQHWTsIC/hRj63?=
 =?us-ascii?Q?Atz7VLIy1K0kOr+7cEmt4pspf4WcO76AiW+PfWrhGCn1Hra9PryrbGuxYn6c?=
 =?us-ascii?Q?4eZN1n8jCTi0qauozEHBtwY5HObkeBHMHoK04ymjIad7QxYy9genc/DHGTJu?=
 =?us-ascii?Q?iPD/4mGAeIFsc8/J1hod7XQ+18Hrgl8dtLhuMU75Y6c+VIe1e9War3BAmDdF?=
 =?us-ascii?Q?7fQmEgwqvRc+zR9KoKxCG/RvWK0zt/zU6KGhqPy6BXwQWqX6m7YApuFnrfA1?=
 =?us-ascii?Q?DQttDtD4J7Q5UY3Qa/9v2IJIJlW2ZTXC7CQ4Pe2oZy9rw0HQfZUeAXB86omD?=
 =?us-ascii?Q?s9d/pJTl88fsU3Daa3vj1+xD3o8y/bJMEWDxQh5mFUPgUc3jlNNuq/ygwaDz?=
 =?us-ascii?Q?gbh6ofKJF/2RtaMwyAjYXxQBg8EDHP/hqb4Te71+cYTZJYcZ9Zc/nlNvQGW6?=
 =?us-ascii?Q?VAui4/6rHFj27kTlpnEoKIaPgNGDD++mdKf9kC09JKBSFyi1ehhNilVMZqM2?=
 =?us-ascii?Q?4f0X9RgJ4ANdjnYDHGMzwSO6+3wVxRBEO+o0lix4qXUi/UDy9fduDvJy1QOS?=
 =?us-ascii?Q?Od/cqeWqN63qJoFjskPpkTGJ+iwDgjCB9RGzXVMdZEq8ZPZWuamLr4wCn9nl?=
 =?us-ascii?Q?napLrP/y1jDL+xrDHMShjlBNqI/9Mrv346xhnpopJVNKelNNQ5mhmrjGt5n9?=
 =?us-ascii?Q?CbrRL0ylKbVIQoLAGWHmPHjyQLwbZSaPr16nUxwJrswkzDXGAH/fAH1Mhwz+?=
 =?us-ascii?Q?iEW2bojuWLGEV/jf5YTayxBggYwBrAxJ5W6DbRYmaBPoqZERLMhQuQ1lmE2j?=
 =?us-ascii?Q?mguFoKshr+6/xIp6YmczoNIvU1fDbtmu1R8qAgjWIRC+ByX8D6fnymRAQNJb?=
 =?us-ascii?Q?qCEYfRCNb7zbUfnB1ymQaeGScYEjDXh3Itbp/7iWR84sviQ9jmniZEoqOwDL?=
 =?us-ascii?Q?vlkKnGTR8XNTUdCcmVzgr7k1B+VhUGpD9jnNQEq7Q6BrdpjhXzU8fHnGLIIO?=
 =?us-ascii?Q?9Y3BIT0Puxdyu3vl3oOJBWn1e8GEDCprfUk+CrNwEkkDHMMJhr7UaCaZdDY3?=
 =?us-ascii?Q?wSp1hfmlsPpxiM9dhHIQvVvDU7moAQP6YyqISb/Btw5BkNm/QyMl7+QD40zt?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcead97a-f9cf-4ba6-094c-08ddefc6f840
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 17:33:20.6374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZQPD8ufRyMI//E/uxuzocPcBEUhUMoYf/usMpTujdqsEuDdTSBJCxfIaFO+dAjztDI/bCcE7bZI+Pb61ogbhzOihSJ6MhJa4AI6dSlyQpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com

On Thu, Sep 04, 2025 at 04:21:01PM -0700, Dave Jiang wrote:
> 
> 
> On 8/29/25 12:21 AM, Alison Schofield wrote:

snip

> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 1c5bb1e887cd..78e639a529c2 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1616,4 +1616,11 @@ static inline bool acpi_node_backed_by_real_pxm(int nid)
> >  }
> >  #endif
> >  
> > +#if IS_ENABLED(CONFIG_CXL_ACPI)
> > +struct cxl_cxims_data {
> > +	int nr_maps;
> > +	u64 xormaps[] __counted_by(nr_maps);
> > +};
> > +#endif
> 
> Maybe move this to drivers/cxl/cxl.h instead?

Will do.

> 
> > +
> >  #endif	/*_LINUX_ACPI_H*/
> 
