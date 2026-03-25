Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840A2066DE;
	Wed, 25 Mar 2026 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402291; cv=fail; b=f69YOgfSJtDL/YHSjoc8gaP29ePtVMwdVgOsh2vmTFYtQosaGTIYcdJ42oB0yp6juyfxyMHvBRJww5PL8Alb3Cp3YwbYJCyFgVFRkZgpREPiVV8aSoLImAosMrlzPj83ROwZarEuPw8QHUArlRJjIOpycA1Mud4XLV6zWPwF5wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402291; c=relaxed/simple;
	bh=Ua7qBJkB+gCRPw8SabnXdXbPZdI5PLZSVbw1FejpaOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qZ6PUNmNIUpMAfZlAHpmLnNveq6JpzFJ38t5YSKIlYyn6r3D4emm+fi14xFpoT/eZZFroLwLbGLdB6y+qH7AfQzwqd+pivTjHqZnkYZlVY8Lx3N4qjyLmveJFLBxOVHKLB7e4+guMh26nDH3c7HSNVjamNfkVfE0PjwFU19+l/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyvH/Qno; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyvH/Qno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774402290; x=1805938290;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ua7qBJkB+gCRPw8SabnXdXbPZdI5PLZSVbw1FejpaOg=;
  b=nyvH/QnokXspSw5cktM6juGFXmxpfQR25Iupbf4GDL4qDilmZFXH0cFC
   MZUoo/IGHRdvIxiiyx1O2w4UuycKIqhdMGKQ5SHs4YmMEcESI9OGo97Yx
   jcBUcZJejhbgSUCPMxqTkFStywLTOB++fnliAhUeNuQSVO1CEwu7JvLBT
   1EdDEptybdjFfLa6e1CsjhwVCxBopRxg7Zf7V+vCOjbWG4Y8EzcWP5+VG
   hRxFVuaIDShGc2bSLJEHwD/BxBS6c4hD/swzh5oTxmqEN4UiRoetgjaSD
   HHgSeLMOlGW1P+7ZDtnvWsK3/rJquh9fWv38iwKN7IedoHY0Nj9mbaX5e
   w==;
X-CSE-ConnectionGUID: P0DK584RS/GE8DQv2L6dBg==
X-CSE-MsgGUID: Apnxu1PsT2KGMmf9O1W8Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75319159"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="75319159"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:31:29 -0700
X-CSE-ConnectionGUID: 1HHSQWiHTd6pjeZRlQnSEQ==
X-CSE-MsgGUID: QOi2IJdATwuitpao7/wrLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="223584645"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 18:31:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:31:27 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 18:31:27 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 18:31:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGZr1Jjhkt9bnqHW6U71tp47Jj9heia+Co0tUNoz+XMh8BRNTkChAQG7oeGhlmHsh3wlzsDnHABFu4nphDyBWLv9M7Vco26c32D0syhMZlmYyRzfvnPyyjaNARmnfMkIMCpUgmUSARIZRX+/RrnjqaCP9UO9DfZpeF6sarPNEYtZA3baPmOrk2+mvrAgpA2XBEKsfEx+pyVhIVu8AtAjbpJ4SEy7Bx0RBBSB/nwv9KgfPiN9mxLUCLsv5YbIXUg9i/0DW1jFlV1dxHqJq5r778tDhJ99fzHafZ1FzLJmscOFWyLveikC+aPfsQ2DXB4HV8p9hsFYHkOgXMTcIhOoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3mfxnTBvhirJ3P2Q40eb5nFdPzPs3TeFR9V7I1OLJc=;
 b=co6W+CWa3u/ngthFwQZVf5hLzB+oRpMdc76C5bLoAF+5O+n9OcqufbKyyJzzWKkyFaWZL/yujXWTjzDv4j7PXJUHsLq06S6PpGWJBPpBqeaaArw0Pp4GINOOL433R2c61NLjfjK4q4rHkv05XEep+0N2Scyn2qfbOp367CumgzQ+uDU051K1Z2++GOhcTmxXWWzVU5IH6w/7KT+5dAm3C/HUb76+hF6tnNln2DnF6LHmsJzYOISBX/JAEAQ/COq7yPW6JgzM4fgi6zAErCpIBQPdau8BCbGkEOp2SP5Sm5r4o1JTXOfpxQ+jwxmv/gGVX3KDVDUjMIRj/08hwu91Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA7PR11MB9541.namprd11.prod.outlook.com (2603:10b6:806:4cf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 01:31:25 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::fa8a:90e4:57d4:8026%7]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 01:31:24 +0000
Date: Tue, 24 Mar 2026 18:31:21 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <acM66WceYRiQEX_R@aschofie-mobl2.lan>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-2-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260322131638.3636725-2-gourry@gourry.net>
X-ClientProxiedBy: BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA7PR11MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: fc28a3d0-e2d9-48e0-34dd-08de8a0e3a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lnRve4cHK6F5yRpqYxNENzMgYrAGf/FVfWZBTXVr9kinsm7y0G7WYknUy/AkItB7yrpGzJi+dc+wVETakEj8E+dlLInDwTgeHpHDXb9YQ8OvN2quf3seA+cTzmaRbgyvP1g4b+gdo0xw0YHRIMjfK0j8DjSvJT9m7DgZqFt1N01QQEACIXt1tns3ZlOD93l5CXiQ77JiLMU1Bu16vkQHmcYRDEh1X9zPXvLQrqeFHvPI+No8/+m0Na6zX5HjniZkFzhj/G03ylI1bNcMDN0AfPz9LgSXj9QRy78od7PBtlFE3y4I6qs3oqKqGLwkYo8Q64KHWSdNx30L2+rDtxEEHASlfaklsRGQo8giStEaFWi0iKm8Vxc7KR4x0jENkKNgKWKSBwaXRXLEPm1tFMPYVva49Q9EOeyeT3g9QEjIsnU64sT0hM/7WgKCWiUIQqCUyd8Qg0K0Ql5bNVF4FkvwJExznCWJmWugTUApigBJTiPWuzyNQc5soeE2s8r4CW2P4W7uP6iaesOwAXyf6nqc5chf3Hd3dVHdIWAh7Y3CNf8+a8SNNda34CrwTLRicUBvPso4OIczGQzOyVSLEwb41Ku6gFqlqcFBmvq2VLgzFzbI+1rPElkMsvCECXb/nnudtH1ThRQn0qkZK6mg7VInAHxQMtTgFiigXiToUNDt7+vHHTmv5NtzDy0C/UZX4pm4pkqwK8Qig5HcMsg4qCinIVifdBSOKu9Qhqa3WZ8ncuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogt4mkUf/rbrVsOod+HmGYVGk/Tx5R1lsBXEN+475tUHPtFelVXEWeWa8hNf?=
 =?us-ascii?Q?rD5G4O/+KUXPUTuhVDfnYfDO6Q8aUcAQpgU3DgWRCYBKt1nWguxAX4Gg+B1Y?=
 =?us-ascii?Q?KZbRAZY6hk7q8qusq1r7sTSs64LVa4iczJhaJTeusdA6HEPNEyGRJxPgwAr+?=
 =?us-ascii?Q?e58vIWSqMFOp12IBrc6W0ZFlrrvjGq90EYtLJSjAVn6fbHqEieSKAh7zu6mh?=
 =?us-ascii?Q?8VPugWg4/98J7Htp9FA0jfyE94kh/cP0YuGZf5V5rNQrMTg9AuUnxbEqDS99?=
 =?us-ascii?Q?R3zOXQwJr1ZU0bKlLYRIUKHN8wA0GcWgN2xAa785IiEdVZ0oveghyL8ihjzA?=
 =?us-ascii?Q?OV9+PVt+1dDPcwtYlIck9My9Y9EPxzZjrqRw8SmU2nxHTeCOmjuVjz0MLHYJ?=
 =?us-ascii?Q?zfeoN/z8SDWIfcycmKiDce8r73F927VzgVpHc9Dm1I5686Wk/BQH68YJH2d4?=
 =?us-ascii?Q?HteEHYJh+SmRDJ+mFi4cip4W6zIeiMq5EEjm7ypQHtwcgeZp7djD3CW5pVwb?=
 =?us-ascii?Q?WFxbZwpVL5JkhkjUQRUnlRXIZhxQRR0d1XCTzdAx7hHDPuLi+Ao4pcHjaj7K?=
 =?us-ascii?Q?xDgjas4HkNcE6Bs6CCe3YnPBLfceL4zpYt14U0rd0wwhgapeoS/tEUSa4iGX?=
 =?us-ascii?Q?46FGAfxEWCa0krQCslsbjKoD8cQx8pMO+3ex+Ktr70Nal5H5sCT20TLPyiOw?=
 =?us-ascii?Q?Xunpn6l7aJV4jmRivCt2x2lvOGDyIGu+mjI2OXxbJFax6Y8Y+yyndBOBjYjq?=
 =?us-ascii?Q?8N0YvvdwmRiutj05fa39HUMpNPaZDUMhhRBCRu80fc1rlzCDr314ikoetG20?=
 =?us-ascii?Q?jZH28oObpLghJ5Wjy3rz6UWKOvZxeq2CZODWGgSXjV/ze9bdKUC4e4QWYiiG?=
 =?us-ascii?Q?svddHb01X6LDBKvd8mNS4E3lFmcbwRFPHLRUH7EAorpJodydko5kvYud8QpX?=
 =?us-ascii?Q?gBBA0G5L9vwVMsDtbpyBt9vXcDXQ6aDIRovnfnImJKX3ynRd3DlDzQ/Fm6n9?=
 =?us-ascii?Q?3w0ZEMTCS12fortKqOzvOZi9UNVPb2a5IjIOwv3cQ1nFxxW78AMn/MWAurUi?=
 =?us-ascii?Q?6EnK4F4Jb8YyAcUKOz5kfd68j4pvAeug94XS5X7v0LvkNxZRYoUETJr5XxX9?=
 =?us-ascii?Q?vhcI2qyJE+/OHyJYCk1Sk/GLnKM0y/XPxZoNZmbAJrarM5x0HIUg4rAZHF27?=
 =?us-ascii?Q?xubKIAQZK0aDDiwB0mnV23KeRW9TTxkK4asz1WWOWTFr6FaKstCM4qGG7Nqq?=
 =?us-ascii?Q?W3m85dGIBPthu2rcMi3iBi9eWbGx75x1Q3vraoBke1Bs/iXbVrX98wF49L02?=
 =?us-ascii?Q?fDE2gGss4f7EKbiZf69JIkR3LR3rKp2gBaxObK7YxXnq3V+4m1cHZUzw7GIH?=
 =?us-ascii?Q?GcQSHnfHbaHdb5EpETj9skyep2LYtNDcfgLhAyKZP0DNROm1l65AQoRP7QOg?=
 =?us-ascii?Q?U2hEeMcHZmlu/SjlsBtvoqG9GTWxMGaGO4BaXYxB/tY7T+77bnou/GEHsVuC?=
 =?us-ascii?Q?oeXVE4j51Sn33mFQApPYy8a7vaM4ABcZGj2xIOIKJXzWV78xpnQVYKbEYnqV?=
 =?us-ascii?Q?ifEWZkSgR6qv+oTzCF7CAf2TGuG3xzH/F67OOZdeGTswEsfBdfKOBTecrd0P?=
 =?us-ascii?Q?/hLuxCxMn/bw3J1n3kz+GN3u/usZIh/fyXHFcE73cQJ06E9uTgCsQ72rn7TZ?=
 =?us-ascii?Q?nGI4Mg2wcJZKQUQ20bVVvV+lAtfdytUNwAm8smO2vpkmBNTfDPi8BpkfFigW?=
 =?us-ascii?Q?ME1pir84X8q/+89aRjTBxjeufy8QcLw=3D?=
X-Exchange-RoutingPolicyChecked: nwW+rE/k9xL0HpEGTrQw8Dv2RAKsmshmPzn8PJACfDXB5SCV+jdE+ijeWFYhyxIejrj9ATtZomVafs/AVapwDY5yi7NrQQccHFy8KTEmguNfWBXMVDvbvVmYtyfs843aGeLSfsREBMyxXJ34pmlPfYbAaMGw8qy1nrGiittSBrF1ASAh7cRsQiE/p2mtWPVPATLiIxexPxj1FTLLQZHLlpH3uyyRydMhetWJ6Jqh6q/Ln8wVVJ+phyOz6t0OH8ayebZ8JfUWVyWUyojdkpNSBUw2RtWjDHajiA9uy3f/lt1Xb8wK3ma8pNebOAuwKubBSguuphH273n2boUwmwKjxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc28a3d0-e2d9-48e0-34dd-08de8a0e3a68
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 01:31:24.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwvWDmGGLjFsvlBOHPexsph6mqgb6RJ3aj6xZ9s57UCARTVyK6zrG1g4shCKL4kI0i+3+V1CIYbG16M35Fy0QtTxx9w9xZXCeOMcBBnOHJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9541
X-OriginatorOrg: intel.com

On Sun, Mar 22, 2026 at 09:16:36AM -0400, Gregory Price wrote:
> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the pmem region driver logic from region.c into
> region_pmem.c make it clear that this code only applies to pmem regions.
> 
> No functional changes.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

