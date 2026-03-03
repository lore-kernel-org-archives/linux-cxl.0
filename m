Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE8199385
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499688; cv=fail; b=pq2wqfHmlAFKMQhsvoqviaEl4WvuPkRwGedCPRwzVHYqRyf+BQUxCHpf6lVc7nZq8dHnlAZSESbZS+BJjCAPgAMd5pXaleZXxVXXGK+pTZmOzQZCZclkwyPR6RDpH+pEyVTZhWdhmuJuU/N1olZGkJ7YRZebXpTqDUNhWXEmlpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499688; c=relaxed/simple;
	bh=A6cm92BOd68fO1wVv/w/eDkdVnSfTTvfh3wjOoqb/yI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=acvS7ECyqfAMe9AHNvMWRxXFeVoajWQgnKB8L5rdmkzLkhfXRdmfjUcHb3LGM8f2cf+Xttf+DfjsOv7LVLJ+fAZHWYISXMhwLw1U+mhHKtQ/W4ChgygEG3hPm4vylzS/LS+gl67IiPkDuULLlD8KesQI8HwnhHTJ/SI937pTCXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipiOud9+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipiOud9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772499686; x=1804035686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A6cm92BOd68fO1wVv/w/eDkdVnSfTTvfh3wjOoqb/yI=;
  b=ipiOud9+7N0QfxECEGS7/ko2yrVL3YktA8jvFzxzqTt11DZF/dCXXgb1
   qQWtcfxtEWPhNmBvWCHAjjnCgkTlF4GAuLg66ZRtWI8ePT5Z1nAWyc1r8
   eAs3+3YKIX/xxvs8hzUCXmBjKCJAhdyMPfNXwdEbuD5UFuDPs6nHZmKew
   oKvGdSzsR0WJgJaDflGyRPPwFhEkfiaFMaH7G/Fw6+/REO8817OGcGG/i
   SGO2nPfuY80otVldoewbD3Ue1V5QxkW0Ce4NPLGAsmrDGx2Af9J8VNJlQ
   usktYpL66b9xceBLaHwQSl/IrUeuaD1MOrUqoZOp6IGlUHg9lqTeDlpd4
   Q==;
X-CSE-ConnectionGUID: pV4AcEriTvO0Y08HIN2dag==
X-CSE-MsgGUID: CN1Og8ZJTMiBLcjvl1dvYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73564566"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73564566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 17:01:25 -0800
X-CSE-ConnectionGUID: V2jPdS0mTAmFZZukLRkTlg==
X-CSE-MsgGUID: WhS2a7ixQEeOSq97wujOUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="222491273"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 17:01:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 17:01:24 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 17:01:24 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 17:01:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hr9rvwURtXy+ERkgQdvxYCOgOykBJit4XUqj8AbN7CY1wBljmG8xy9B2cNwp1ik8+Hjwz9marnBvt16a4OgLTwzltWVTwYuPzsWEsIXLM8OPoV4kp6HkvDaKw4X+d7ZK4MrE7Z+yHyEzvoH7g04+16Hqrbh3e0nCpqQo/tF4ZXOSd3LQPRN8f+VKKUNcYq8ui7zUXL/2isvszTRQegOKJ3HMskF0acPQX4ajaK0Me85XBGIpVTCoACgJshTstyvAF53UkIumm5xzZmkvsVz4GzI3N0McfkPImWiPSvTZUojftXdauM4hO2g/PJjT5wxejwiEfQcqd6pa+otbK6Sf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tru1fRkusIBVBEbDxF4L5vzn1h5Z65JDUJchFuOusTA=;
 b=k3wOmAil3bxyZWBFL1VKFnorY+5YfDcqxA8ltfjiuMOkBZN18eolAW3utzXRCHUDs4DcFop5J1iyQQYI0v48YVQgXo0XbVPurt6goQcnVvdbCi0NYvkt3gtWxcvr3C19hKh+zSw5vEqgjoeEBHkC+Kcaxsea5ktDVmUwpId1KKsJ4lk+k5+K3zBmwhCxKq9dZnzagFaX/n9xt/H2niqbqfL/wbMJoDe9GZqYpWNVIAz6XOmbkmK+zV8FCpprM6MjbqToAB2xsRT+8i4keJgWCpGjWhhmg0vvLOQBKjB3jYi4lO57cVl2SRwazfiI0ujZg80g3+src4Hg0i33i/RDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 01:01:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 01:01:22 +0000
Date: Mon, 2 Mar 2026 17:01:18 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Gregory Price
	<gourry@gourry.net>
Subject: Re: [PATCH v3 2/3] cxl/region: Factor out interleave ways setup
Message-ID: <aaYy3tzb_OZKl4NU@aschofie-mobl2.lan>
References: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
 <20260228173603.1125109-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260228173603.1125109-3-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c71add-2d1a-47d0-340d-08de78c062b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: jDObNQlr6u75fe1ypbzR4KMo6pkG1ksk8SD/ltE6Ct7K/oMx/ACdHK8+fSzHDy7t4VJicbuiHjXlHqo00NpeqdZV1HQUqwmSWIcoXwCj3g6lOXhc+ywUn5isTML8ZAvaUg2tCDA2o2m15zmIqaxMH+RR+eeYXX5YsJ8HsV+Isgd+bM8PhJVRFHO36etegq4PNMf1feiDWNuY2FV5TQSqOpMj2aEiLcDy2L0JSGO00RReFb5wF7LYExVXJBM/np122i5rLEofBTFBVbvnYlQna3ssfDp+Lg9r/b2yK2wP5QnqKfa4tOljecEjDlSB4fbRKVABxHs6PVvYwZZ3SnKiH6ot2FiZB6fUeTuIUKS9ye3BQfRCAfuGiBbtmooxlCkoafFKnfYDCazXCeV7w/eKBcprElIvrbB3wsnpPFkUltlf+3boHcbHT2lMgAi3Wzc75YmNOqb4P0+Lh1ROn2xnADBvDnLIykI6/LnEqQihnHFCyuXmueWphQmULYZwYYfvj+My9CZyZCvzMEq5ryLig3BumKBPMusDvWQGs9NhBkfyAAKSh5k6D+B1ShbShpYxnuBniv79vKhHd+Dv2CKlDhip666C+FpHGRDlgINf4IMx3JBvOBXV3y2Wf7iygf9Y8ZRLu9glTKYYvWMvYnB2OVZGw350+9pPkpRikj+5OAIsmhhVK7EL4JLfMgKCNUI3oYMJRA2Mkc2A1AVsE7jfHR2zLswTjUscX03F73d2w1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+DcT2RJF7m/RfpILd5UmEM6dY1SKhldNeVWTm3rXxzOWgET3Rzc66i3RB1VS?=
 =?us-ascii?Q?j35v+t+NdzIUj66kW9RPI2oiND6YCYScYiOcAHHzGObXPqeqpS1f1Ms32CKm?=
 =?us-ascii?Q?TmcMX3JlATwygDbPGOaw2UZsi13ornyfdK2CeI0QNy40XQxHank8M+vx6cAE?=
 =?us-ascii?Q?qp6lR/+wU353bwzgMHct5qYpFX+OYBB5zuxi/gNIft9djK5CdiCkynDRKFNe?=
 =?us-ascii?Q?HrP2vH4vuD15xYmYc/RvNAp3RFZrXzn+/oPkDQIKnApk4Vz5pzyIwgkQ1LHv?=
 =?us-ascii?Q?PM2hS2s/vrWnhN6khOAXNpdQHUY+zlfUIJBVTiOccPu001h8pBOLeZZME3fp?=
 =?us-ascii?Q?v8qAUyzjA+4lJFXoORPVsirS6Fwe65HH4plPsFWVagXY92gJqXt3eHcSb5C5?=
 =?us-ascii?Q?dm4W92lWPN8CwRyJ0v9BuUX+GDqO0YJiXSLIJd0S1U1PQcOTAnENA5AbwahT?=
 =?us-ascii?Q?928n+lwXoRmwBZqKHcMws3hWVtsaKQila4fUX9D8Hgf5kEZ+m5U+o91Y7h5Y?=
 =?us-ascii?Q?eDOXQgx9yS4Y4YIl+JJ4uM3FnwMtfdHT1VofjDx8IWQJlMGEY4BAD+Ni037U?=
 =?us-ascii?Q?CF0/MaDu+/n0jZzITwY1JR2WEbqA/53Pp874YIkqC/pzp+9bhC4CGklw/bJN?=
 =?us-ascii?Q?zardwnovIcbqZRfRb5gKExI3SQYN1F+1y2FrtFP2Wrme1oOVEV6BmvEtVKOW?=
 =?us-ascii?Q?vFELuQ9x3oAq88SE6QWvLKgCuwoz3GIlWaafqojTr0wJ/HfThWRzyswwgNmb?=
 =?us-ascii?Q?gqWcGOJxkCBWzIqTCY57880I4GigSn6NQ3/V97bJ5N1glV1T8c9VZNwwbk32?=
 =?us-ascii?Q?S2gDbInD6vovKVqLfCxAVYTqMHo3xbcl7/93HpBVz2QQ0y8p11VFTolfy8kc?=
 =?us-ascii?Q?v6BT2uAMUG6B84VMwLZWJ9yqYU1OsN1wMEVp/naIy1axgLc0c7HIE0kUY8f+?=
 =?us-ascii?Q?VcQDnK/AIkafjL0AUMm/89JHDfKG7tqk0MrW3foxlGLyCFc0BhUYtwHnDQCo?=
 =?us-ascii?Q?vKfq3zv00XN2cQUSegMKwPBgcYb3y7AZvKTLEvbK/9G1cO2/80JI2t1xt2TX?=
 =?us-ascii?Q?EsZBgNr72hAuzAIkZWw9Cr4bFJJulYySu3+R1+cA7UImTcSGDU7uAR+VPxPV?=
 =?us-ascii?Q?pRMStSD+AJ1dMPA8GTTF1qxRuxQilQpRoKltl32HfrQTtV4uweIjfyS+5+Ew?=
 =?us-ascii?Q?1uWDkBMUiPw1lYt5P9/XEH8RU8JLPtv65ZUz502dVWYFlCBlietXIUZaaBzz?=
 =?us-ascii?Q?5n2ZRRHShTcCZI+2XlgWAOHeQl1hKS6414D9baOak+RyRfnT2vaZGJAQfjgx?=
 =?us-ascii?Q?XG0pLsnWnTXNFBkbXruNuQWvMUZq/FAXWHG0SflmA5PZfKG8XGA39uL8K4LC?=
 =?us-ascii?Q?qWIwq9vt/fkqxlLq512B1vd7mtXz4e6O2UEFxnNdVzPzX4LKts80vIkko97q?=
 =?us-ascii?Q?gFiOX+TZLmJQy40h/o9D+n791vP7u7eRk1EKSKaQq2wA9bzkUdkxl8QZ0Xu2?=
 =?us-ascii?Q?UZWIOcvInzLsItg8BQHUabE2ZVtXZm082M8GH6SNksxorpzZt/AA914Q52By?=
 =?us-ascii?Q?E7JHxB23IbIo3j7G8i69+sjWfEB49c7l5YUmE49ulkYMPRCOLFeaXNQ8ddvM?=
 =?us-ascii?Q?ZXk92CTOP265TK20q+fdbpdGeHABtjghNAv6JIvUHIjmukBb4zlAp84tVVq0?=
 =?us-ascii?Q?wXGiwQtu523HmtvpvPKLEx0mb0LIX/fx92xdgnskCl++xt0sxA+DaKCkBzA/?=
 =?us-ascii?Q?Mh+CcUvnEskzeGZ6eXNOC7PS1yqm//4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c71add-2d1a-47d0-340d-08de78c062b1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 01:01:21.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCfCdQfx8C33KMYiOS/KZfIu1jca8jqKceQNZHpRR/SQqbp15sm4KMsdaDMo0aAFQ2/R40thi4aSiYukN4Qi3VD3er3ThaBBAa6V4N26Gn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534
X-OriginatorOrg: intel.com

On Sat, Feb 28, 2026 at 05:36:02PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices can be triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup for interleave ways.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

