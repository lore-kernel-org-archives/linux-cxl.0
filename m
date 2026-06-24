Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570ED309EEC;
	Wed, 24 Jun 2026 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272290; cv=fail; b=TYx1Ye2+UP382f+otkwrgXM8JpQ0Jn7EaI9Lb2+kzEtmTUNUlWkWIMt/saaksQ3M2jUcg4LD6E+An7bHdY0mg6h3BvJi659zMSfcwdDb9OaXB1nMUUOruxasSy0LxnkzcGOzxiIWoGci+T1RMoaDyb3T8QSJp7IVq94At+j+OQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272290; c=relaxed/simple;
	bh=FwncDXgPoCTgJqiZxNp9GkhTv+TqdwZvZont0DXaoeY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LyVSuoiZuRzis0Ynnm2xy22HnTPete8dhRwW52YJ3xxytodRSEXgTW+5dYE62SIOT1tLdN3moLjAGBg9h2wAQj/eBW/wQXLXWKsSzlU3Dlhoyt5SYsAl9G4/x0MZQYDPuPysl1J2gi4Qhhc0IzeUzlA+TkKWyxXbrN0pCA5O+oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+jseVxh; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+jseVxh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782272285; x=1813808285;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FwncDXgPoCTgJqiZxNp9GkhTv+TqdwZvZont0DXaoeY=;
  b=a+jseVxhXAe1ib8ZBrHg2VE36kaAK9d9MsTcimvIWmDqpV1RZraR/Oeh
   BZ83sS60rHjSPSc3RoY9aa1ME4C+MVbLmX4JTDlVmpld7lj+AGF2C2P4d
   TkM8+xpyfAO0gzT8xcp+j4Da6np0G9wMUFtV5m1IXdyE3UUPOP600Gkj4
   x49dlp9BkHReGpOtdZ5Jhr6v1C8ahzhCZRqWD1Kxi+S/Q/SLR2YGOHiU1
   oAQQ2ERJdTWrpXhjK4d/4Y9WOdLVGc/7EjWdv/SUAjXSRPmpvSpvk1Ngn
   e+kIspeRSEFMHOb8kpIBpkTmGd1S1LzmTSjWeqWIcHh+SqtwY7uKfp2UY
   Q==;
X-CSE-ConnectionGUID: plGlPQF4SJSheCln2nzQ3Q==
X-CSE-MsgGUID: CamFsr8RSqqyeW9c/lrFEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93610618"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="93610618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:38:04 -0700
X-CSE-ConnectionGUID: fPDcjrSNRcOFI3yy+PWe4w==
X-CSE-MsgGUID: HolQ5/MIStqWqxJ/fDl6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273761259"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 20:38:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 20:38:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 20:38:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 20:38:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9RLTWnGFOjFL7c+EKbq/8dgqv4mVouuwzAYyttKqI4sI0aBo0tfLAlcENLvK9H1/MxLwATUrl//WdDToFV/Rmue8Kv1u+tC4nLwTWUFD5HIXmMZUGy2paAO7OV/8BfBMlBy6En9hCOHuIEQiIKxysMfbt/MhXM0RhIFUsyDuzpjU8FugQ/UdyClePO+ddJzKO0tkTXZDbTKxymti95rm+WxkDsCJ0ITJrk2VEs+R1SRx41wzAQpD7jz31Euxgf7hzPcqT4aAZ9gcaDD3snBamd5hgrJ5JRCK0Fpl9ibpRuFQH1KdstCLkONCoofy3/3ZfBBccacme3+owOqHaH6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I12MFHsirhjObYZVloSyLrt0qu/wos3iu9Pt/MNsZC4=;
 b=j5ceJWR3jxje6Y9yOs0RKaZFwGrobohZ8J7AFOdB+ZqShyUYJL4Q9R7d6Fv829+ddXitep26BMZi1gGUsOUbOV484QLOy464WSCJ8Tju4FYfmjvDP59A0q1W59Cxn1yKwXbgseuo447sYEa4kytqIZ3O0QKdCsNc76XLfuO74ZxpZuZa9ZwHPeuZBA4tVC26f2jtaAXLZYF4atOJ2z5Fxpn/envJps2wwias27yX/lqH8Zj0LOM8dA9wLAY0nN8s7jWnt9ObS3jSvobeJg2Iph7tIW36xNdHrrF0RYXfooSMvSW3Iq4j3wMMuk83fOTHp+8V7A4YbinCkznaNZCW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB8516.namprd11.prod.outlook.com (2603:10b6:a03:56c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 03:38:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0139.009; Wed, 24 Jun 2026
 03:38:00 +0000
Date: Tue, 23 Jun 2026 20:37:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Zenghui Yu <zenghui.yu@linux.dev>
CC: <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<djbw@kernel.org>, <gourry@gourry.net>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH] cxl: docs/linux/dax-driver - fix typos
Message-ID: <ajtRE4m4zFd9w-ei@aschofie-mobl2.lan>
References: <20260614161458.88942-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260614161458.88942-1-zenghui.yu@linux.dev>
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 0682b4bc-cba7-48e9-b3a4-08ded1a1fd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jIDn9cRWna/07+nSYQIIYpcvRNnIDncLoTmY1ugAm1x8n8strX2GtiS5oxMM9nMCfsqQA5QJmpbjBMMomR/eE5BX2LraiuX5ZYHcAVBLeQFrrdQUq6kjyrnxNr08Z2st4kS17zVWCjEs5N540MbcrOREsfW3ogKjPquUtr0JYyOD2sERiYN+MoBhrJ0C4HKJmVKmOppeqps0pbH2i5AcvC/ecXSXK2ArrUuukUjJyVUTJ7e/eys8j8LsYAaJa+9oF+qMtgGjjgrr27aaxkRH/fBCApHyhJmU/flGPFnKZcFe6m28wjtsYgjgqJUKlekAsGUYUpMO9mHhliZK2B9UPv6SgVJWSXIIyx5LVv/mLTyiostCT0hkJkjUYSqgY8fvMMz3T7dB99JeZqY/PHYIeU4Mv9qUVbMTu36SysYRwILZyeCT+OEirXl3Y9Sdj1JNTCNX3bJVdiK45dKFb6GGWeJsjj7o1zj2JWXgC1EI5NxgGEbTzFz8IRu9zNnOPZ3DWGVkHLoLHegV5l7kecAcR8/G42EKRACjTLRpo7Tqrl0Y/ldccyEEnmhIMNbM5cWLcbCFoUweWi5rwoV3X9Q+yZtj4WUTfQ6YSXbO2Xm256UDgMvE9XQH33iqt42Dopdklemiznf+ALEh2r/WrBh7OIivrrLnCliz9j/UZbJfXPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LEKr9mFWIIeir6dEDRMry3JkrO9J4CbZ4TiCJz1u1GXrRFLlYJSnuS9QoGJx?=
 =?us-ascii?Q?Lt8rHXviCbXN3fKzK3/tIO3e2z46Hw7poxhJGCSgWXTu26/YvdlFT31M2bI2?=
 =?us-ascii?Q?ysGOQxQqNNFpRxCWTo5pCsDQCsF7TCe0AH0MC1he8+elXhvV8pyJgRe349j5?=
 =?us-ascii?Q?hI77+sve2SSuta3bMHktYRhk5W10cSLZGFfF5Iura0hwpFZkTXiBgQr5cyRX?=
 =?us-ascii?Q?RQji0hmt/CN2X9b2jUq06W9OTMm+P2dq+fe4i/5JCtcgDmsZrrR6ULxoE0cq?=
 =?us-ascii?Q?GPlOjwFEJef+ulsoOkQLvK5cehEFhrAQ+M6ox+fN959Ys1eMexa5EnKdTlkn?=
 =?us-ascii?Q?Howv9wUqnMV136I78NUvy6Cc4WAgtVM10b/ovDGBEHkddqDYTFNY+3IqneOu?=
 =?us-ascii?Q?jPCcxHETWoUxSzY4KhI+qkdriPkleTFvkwvEIKiveB43cC5kmVgn/JCxAMco?=
 =?us-ascii?Q?LFrGi8PzMAx2Pfbnunt8omBe2wZWD18sNi+uAKbnsYIMPd31mL8MHbxKsS+8?=
 =?us-ascii?Q?eLShHBnZRLuhPA68SjcQiVtlEVuCfMtB4dH3SQMAcN6DHbG6fBQ6lucOgTcV?=
 =?us-ascii?Q?JZkqEOrnO8bmHiuZS23ajkRr2UVaWcG+/BDHIcKsk9LfXtJyCMs+Co2SPARV?=
 =?us-ascii?Q?hOBVjzrCB9zVX58P63bilZvZthJGNRvlHspW98PhzijMtDRHCmiPINJn8uP6?=
 =?us-ascii?Q?p77CIhGX0Rl5G4ti9lmTgmNn4/vHeVoHoi49mw6lAPT6uOlTo23jJlUGJk3w?=
 =?us-ascii?Q?TCRh2lg3iiTVmH8DIytTGOsjjsf5u7sTdhrcK7kvou27XDb0C6eVQ+KHv8W9?=
 =?us-ascii?Q?9N7MH/KuiEcK37GpBPBcKfZwz/S15QywO58lN8F6wkdnAa9oBdiUgWbFufoJ?=
 =?us-ascii?Q?kfeYvTXjHUJbDlMhTFyAdjpw5JTtgj0awgcsSMW6TzAtAoyE50M4drK9DVGt?=
 =?us-ascii?Q?/jIVNxtJA1gao4qeobYqD7hrN+9nAIrm0VZXv5mc1pG/Qt56O8oJWzzMuV1t?=
 =?us-ascii?Q?IJmiwdXT7IKb2dSwhD8heTTwmg57LShpz8lH51jeH+e10PeSApsI2Z57w4ke?=
 =?us-ascii?Q?jNJfMJWjKiqeC2KBSbqUGXI/9DUlfflegmQWUqc14DBEhIRR28IbDJQKGQHd?=
 =?us-ascii?Q?DWeZM6pq7JhW8pItgiF3JsfiMgf2ThN9CWz7AejDMeP3zmMChQyUQECSOQve?=
 =?us-ascii?Q?uOIpmgLuP82NQAJhsy6wsF1/lsesFeBhJbi3Qf43wFoKNBY4UJ9T9M9qtztJ?=
 =?us-ascii?Q?ctRkjCsbU1kLOXZ32+GO/JOjmOC217vUSTYN4uuZlebmVp/FSKolRGXuBO1m?=
 =?us-ascii?Q?3Ib4ZA3YeHvNCPeMOzZcydMUsCMI29z7Eaj4loCYta33SkbB91xvU/mQ6hsa?=
 =?us-ascii?Q?0azZybVwGkdAgRZjo/wgdc2i7/fKPVirUTpct3XE78RyF1sHwG0dkMgzJOIW?=
 =?us-ascii?Q?y1NYDClGD97bvxByKpmn2Dky3DWIZpd4Bsq0kZslBc4eLMdot4o1gRuJo+by?=
 =?us-ascii?Q?NoRh7J5b6FOvqi8D/D2NsGjGfL357Os+WU0YIzMbNGGJ1kidXOjmeGTkRKN+?=
 =?us-ascii?Q?QbcKn7J26LfO3z17VYYLxbAgPkIvqzQRKAL4BPCZsYfC1wnif6qCQB4R8LI3?=
 =?us-ascii?Q?vpvE9woWjTAflBvj5IEEjZx+ZvTUgL4cq/2qrrczC80CJcjE8888k1BhygG5?=
 =?us-ascii?Q?aj/cwlTsDTgsMPv5AJan121ousoyi4uUuAmPiKZMOCgMoqbJi16HHmj3ifPM?=
 =?us-ascii?Q?Gtj3y/YlqyPGdwMbgdxtfG4rTWzPkIM=3D?=
X-Exchange-RoutingPolicyChecked: egn0JGMtM4gScdarZN5qCIe43ZcNhSi6/r4C69RwGJEMKSi6nDd5xyaobvHEvIrXYIm6d5Ij6ZqKy/4hlJ8tv3e870ttNluzvepOxUXTEDcohWk1/rWNYQm9aTWGfmR6VDZ8BI+UeGr3lgHDa3J2/hJbWgvGRK8/dfIWsr1g/P6j4L5Q5IcicGNPQTq5mUCqCV9ZwUhqe21pZvZ2o5IV9svRx891JfoZr+J3yfhMRrwnIO140ClyezTaDeSgoJrITwsiC5HZlcTtYcTyQMFLgUrVl0HlkwwzAJmBf8NS/g1K2omq3kyF9rmbmbi5X6H+o+dP3xXph/bnrV29ikfhvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0682b4bc-cba7-48e9-b3a4-08ded1a1fd16
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 03:38:00.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6x9xqy6TYWob9ZVtEX1yPEFQvzWdflKGAfBFzT8NudW3rVr4ncX710J0wBU8iQb/2IO4Lj0bB4J4N1VkB2I3TK2JTLAQ7/zC5LX+zKeTHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8516
X-OriginatorOrg: intel.com

On Mon, Jun 15, 2026 at 12:14:58AM +0800, Zenghui Yu wrote:
> Fix two obvious typos in the "kmem conversion" section.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

Thanks,
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

