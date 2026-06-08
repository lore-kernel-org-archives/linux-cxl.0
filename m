Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84C39E162
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951024; cv=fail; b=lYz0Z7bt8peuYCxWcKiSQW4N9qv7gGTyj7kS/qPyFEnFaboXeBByhogAMao90vWZE0/WNusa8YedjGB4UufC7ezY+dOnB74FeKLKJooBXB+taFfUOg2I/Txkh6sjvni0hdBenqgNRBEwp7/9UvlNj7hURWlNh8fW97VQA8ju36c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951024; c=relaxed/simple;
	bh=/nl9vcnPGv8yPjVDxtx3rM5obVxKBeU7EnhoESgcDx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S5loDamLnDmd/j+h56SzaW/R2O2k4Az9YasMv9x8Qimv/A3qjFoXY94wz+Yg5p1kdkD9RhmfIaAVzHIP2NkLjU1KxGre0lvkvOB2qrJ7m4r9ur1gvfCP8jjNDOmR97zSFYJdppV5RmvHewFbOY2WZ9ydQuE6geVAbQlMRra3+w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7PUuZ2q; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7PUuZ2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780951021; x=1812487021;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/nl9vcnPGv8yPjVDxtx3rM5obVxKBeU7EnhoESgcDx8=;
  b=P7PUuZ2qcWDaMAX0SG9Zh0WjRFESmPv7uudrKctlcqjEX3Idp7UiCDnU
   DneG2tEaV/i1an5T3OvzAz2Kq8Tvl41V/hOzvvWLdBX5NStcigzCb2ZLT
   Wh7nAtInuZzjhrxPCbwUEC5RhiAJeKC5229c9emGVfk8/tOYDXO93wnhv
   MfJymSgdB63/3GkJE40PAKJDLdKT7Aj1Mg/1p0Cc1gEGpvTEfAnmjWoLF
   gdVIMcE2SQZ0pgUOFyWj1h70IrVBsfo3VEHb4sz4GoZkFvm5njIWTue/A
   Ka7Eqs05ce9SlPGXkTnvVlcYPtYjoBX2s07sDNlUpCAYw6h2IlvYodhN3
   w==;
X-CSE-ConnectionGUID: tILumcJSSsi4enaE48VGtw==
X-CSE-MsgGUID: Mf3cxLHtTeWUgw2D1iBfMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99117597"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="99117597"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 13:36:58 -0700
X-CSE-ConnectionGUID: rryboQ6LTOys+kZ3+8rbKw==
X-CSE-MsgGUID: 2lh71VGVRfyH9VaMRuXFrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="244804554"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 13:36:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 13:36:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 13:36:53 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 13:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cv1EOys8U7WWigp3s2xks0q5b6ITWPlBjuTeRjBMFyzhtJHwWAgx90Chs/bpm23moBrxrp4E5Geebx3T/G/IBgzH8Ogq2wigiWjogYgBQTa4jV6jPLBq0K3Td+Wzdq1Us8y8adF/MSYh4gaQf1BX7wCj+Li96RtZmKQd2GpHb1wwDsnymQW2r7KuYswET0Eu8kQE3PZQ79DHE1V9DufSPzIyhrvSXOFRCzS5mxFs8e3clWHl6dVmzKSvABGbdopcnt0zl2WPKpe/vdUw4tfDhBNMXMK1Tt+QjKupAT28AiCxK9clyUVcrN1L1z6Y/qlkKNQ0YJLR/m16Q1o2PlgfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi0I2Ao2cydc4GULhY8szI8iuc/Ol9YPS2JfHL0jAao=;
 b=InvW0Vrn/MLPunJ+E7LFBjLmgbvC1WIuUBhmRqT98Zl6qQUAP9ul/wbG5AgBObu/5wI8PyHQ1MLjhXUNsIRyPERlrxgsaEYAj6Whz3Su3qj493U4JVZjb7PuOgCHhWH7P0/a3wFP3l1Hzoem3dGdRkjeZdJdkKrUjg02lyAI/HPhDBLZo7goHjya3hO4gdOikms7aiRbdNJFD1MIv4yQsqf+uj5UtoHwwc9RNcr1/yPU7lvZcqKuZhXo7HwVD/9DlypEaRB+ItPpIeaYObUfvu7dJv9kZQ3zor8fsJtYGP6ZSH/521fq+ojN0uaQkBtX0FZTavKm2tu7vCbbSdqk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 20:36:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 20:36:50 +0000
Date: Mon, 8 Jun 2026 13:36:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>, Robert Richter
	<rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/6] cxl/test: Add a topology to test mixed-granularity
 regions
Message-ID: <aicn3e9i_QIuJ03K@aschofie-mobl2.lan>
References: <cover.1780095671.git.alison.schofield@intel.com>
 <2ab2466fafa96f07df65ee5f6b4f8511240f4c93.1780095671.git.alison.schofield@intel.com>
 <7532ffb1-fe3f-4033-bd38-79f5dee150ef@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7532ffb1-fe3f-4033-bd38-79f5dee150ef@intel.com>
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ffe276-69db-4a42-aedc-08dec59daac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RfOxZipYBFKrSZdYLc/0hG+fCQojmeYMfetM/57WxYZPoOxVsOPi3VpPjrtW95Kodb+BtHc8vWpzzTOIVJ/SVJjeCH6SRbh4nTy+1B00NpGmW9C9auKwqXeAlaIfPL8ZSSAzeAcEVPy0meZgklGynx+jdDeQHAbZe72OGpVfnmDwbY4fsw/9/FuP/8z3hH4QKGIFwKlZUXPzrlwXvvs/Qz7nwxKBSBYYD2wP6Im1i9g6KwMTnDSsH8wiOMhuHgmRYRfAEFnNjsJWbinJx/uZ3+LLZgutjC4baeBWJORXQWepfYlbahUqs0FbwHdzxU6N0wkmSIvAvmVYX8f999FCCgNfA/ZUixwwiMs3/J4XeCcbZJmOf7C5cbkhvAofjHEUEVxInbJzmdNFqqb8sj1zpvLoPR+Z0cGayCJja5ILaTHTbd74q/7XW5MOQ+SYVGuOtSJMPyJ9Vc4r7I19btgxwm4OAlD4kpLmZ9w9R+sCNuNAnVGiSCS5eM4BFQCvYOsqk05x5MsUX4bO6k3Msth6y2LwJndjF88fbwtgFzPXuJSusBveT8bJihrL9m0kPNuph+yzVoq7ZIrZEG2I9pUzY1ILDDUg55vrP4drBAcj8wNTZqOskRFjKKZaedKSHT3Ep2pzJ4SX2YaGj6yoQdkpf7B94Dqxpj3LfP5iu2Q2YTFpWQm08nCOTos6Xwo7bbVn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVY1Q0RMVngwRzRoTUVqVnBEVmZTSVNwaktodldUa3c0Q28vV1RNb2c4Z002?=
 =?utf-8?B?cWdsRTRiWEdSNXlURGdLaVk4dmZVZTJ1S1IwSFhQWTFKZFBOdzU4djJlMFJ4?=
 =?utf-8?B?M3RtOTA3MzNTU3ZtQ01sa0VCcFk0d3RER3B0Ym9UalRSY1BMMlA2Rm0yNEdv?=
 =?utf-8?B?TjBiSCtFaDZsazNkOVhHQVBJUm9TOGNud1NSdVZRTUxpUFBxeHZML0ZrWVJW?=
 =?utf-8?B?bmczUTRadHE0NnZ3MGJwM3ZjS2dMSlpYOXg3OTV5UmhWckFyanJjVWgwK20w?=
 =?utf-8?B?U215Q0pQcWJsdU5nQ240cHd4Z2dETHpFMzlrbWYxdnF2dEpNeUM4Y1Y2YW5M?=
 =?utf-8?B?S0RPekZGNHJIcCszQzlEOHBXRm1HR0w3OGdzWnlmOXRUUzQrVEs2M3RxcFRs?=
 =?utf-8?B?MXoweXVzRWJQSGNtZGZUeFJYU1NXSSt6MHlyeHlhQ1RYUEFqQ0ljKy8rdmFU?=
 =?utf-8?B?QVNnczgra0s5ZTFvaCthWWVMcnBEM3FucUJ4NjVvUHJUN20rclBTM2tyckFO?=
 =?utf-8?B?MjBnYUFmMjRrSzhHOFgvN3c1cUFkYllSNERGbHMrRkw4N3BhSzVCSHJJL3l6?=
 =?utf-8?B?RERsQ1FjdHpiTmRGNm9XbUxuTDdHVXdvWFN4enQ2R0pUV2w0V1haaEhJN2NV?=
 =?utf-8?B?VnhDQUZGK25HV0JUN0U2UXByMS9KVTRkeWJQN1lWeCtHay9qSm4zdXp6MHI2?=
 =?utf-8?B?RnkwU1BCSGwrOHpSRzNpR29CcVF3L1gwaEZKU2VjbTJOMVJCeElXM3Y5Tzlh?=
 =?utf-8?B?dE1FQWpzRkRxa0RzMnVtWjhhNHFhRDBKbThEaXAvMXl0QjZNQVVDWUhBT29v?=
 =?utf-8?B?UWhBaVM2S3E0bDJvdzlqSlNnZVVVd3RMQzZjcHptMjE3cFZ6dmM2TVZWVlc3?=
 =?utf-8?B?RDlpckNtdlFOT3lFV0lvWHA1TzQ3TE1rbU5KUXdKVFMwem81MWpkbDFwV0tv?=
 =?utf-8?B?cWd1c1BVcm1QMUQzQ0RrSmppekhjZ001ZloxQ214NitMa2tQeU5jcEdVaGI3?=
 =?utf-8?B?eFlvZUs5MjhqVThXdm5NdDc5N2FvSDkycDh5aFppa1Z2UG9ORTVKUmpMd0la?=
 =?utf-8?B?cHR5UThNczJmeHJtM1NoVWF3Uko0ZWhJdVpRU1N2bGhEQ3dYZ1FOS0xpcDdX?=
 =?utf-8?B?bTlLcEZTbStLbTA5N3pKOWw4MUZIejNRakNDRFUyaFNXZlBFVkJtRmVXK2JO?=
 =?utf-8?B?QVRBQ21FRmZYY3AxRjdlNzk1MUR3K1I4SHdua3R6QzZiaGw2MWFCQThqdE5G?=
 =?utf-8?B?alFtdi9uWTRHck1WV1d0WFd4MkJpbDAyN2VRVk1pT2IvRWpWQUhtTnFHYWVV?=
 =?utf-8?B?Zk5Sbmc1TGlqZG0vZTVYUXVndFpMR1BqMWgvd3E4eUpkdjl5QTFOMWNySTZV?=
 =?utf-8?B?Z29qY29oVE1VcHBBb2c1OUJmdTdOb29mR0dQUXU2UStzY0FWZWhVOHVqM2hs?=
 =?utf-8?B?Tjd0MDRkRmd2bFUycTlJRS9Kbm1vZWVheWVOOWVNMjBINzhubUthQUZnQ092?=
 =?utf-8?B?eXJqRUJmZTlWQWJMZXo1QTJsNkJKcE5qMVNKbHpabXNYSmF1U29QUmQ2U09V?=
 =?utf-8?B?Y3Nmd1I3L0tJcXR0RXlhVjNxaERjM3diOWg4aDJTMVVxMnpUcy85UFFiSHVj?=
 =?utf-8?B?bnkrdVpqVHdsMDFrdm9iWFhjb0hNODVKN2xCYzliRXFMN29rUVNIYy9mY2xz?=
 =?utf-8?B?ZWplU1lNd2E1MmJBNi82SzY5S09yeUlmTmsraWVnOUFiRzhEN254SVNaY3Yv?=
 =?utf-8?B?bng0eTd6b2ltZGNkQWRISmMyMVd6RWR5Q0FrYWlzYm83MmRwU1ZycVlJc1Jx?=
 =?utf-8?B?UFdEU3k1aFQxUis0MFFPZS9Rdnh5Sk5UM212YkxCcVQweHlRcHpmTnA4b3VG?=
 =?utf-8?B?VVduMWpCRUFDamxNZU1ibVpGZ21YZTNBd2U0cXdtbzcxMWpOK1p0OGNmVkVD?=
 =?utf-8?B?M2kzbHVXTHFQSGVhL0JZOGhMK3Z1Ym1JUFRyNE9DMnl5bGRsdjR4SitWVHYz?=
 =?utf-8?B?dnB3K0ZjWU90UXpiOEZOZy8vaXpXQzVWdEZMT25jbUltRU1ZUUNUa2V2bUFw?=
 =?utf-8?B?YTVvUUZIL0llL3owc1YxTUpxcWZLamNGQUpucmdqd1NQMjVvaWZKQ3dVK1Bx?=
 =?utf-8?B?RWRHUFhCYXpGZ2M4U0VSZWRMa0lmeGNld2tUTHFHM1Y4L210bURGMFZjWEZn?=
 =?utf-8?B?M1E1MllwNTRqTWlLN0Q0NURhaDdkVlRtS1p3YTVFc1ZwSHoxOFI5ODBkOWlD?=
 =?utf-8?B?RmlsNmd0UjlXUTRXQjV5M0dEVGQyYys4dXBscjJiVjBLS0dMaDF6ZXBpUlpO?=
 =?utf-8?B?NlJVOWpZNWtxYUN2cTFWRk8rQ1NiVFZpRFltcGFqQVhucHJSK2wyL1JacS8r?=
 =?utf-8?Q?QItUbXFfvI/QA3RY=3D?=
X-Exchange-RoutingPolicyChecked: FhZ9exp5A38ygFLNB0MsrBnkgPn59psrWlgdDYbCtmGdNFvaFRMzLGWOvF0R/KbKqAoEr7ZCs+gQfZ2Y5rCHFXmnQY7/0Xl1j3kboKBWZx25qYiC5KGuu/wOnF/wNiHuRAyuwP/bwai9qIUywyevmcX181igvvPrnDF5Y2gcAy+8R2CrIXnkEckqrKB4j+XJJnUFpHcY0vUFRF0pw/cIzNDBrptBZDV0n5QQINLkzLdEUQTVNuFnarhnM/YrSvY6ouDMzqqHf87yfmqtTTB8TkDBHwrIL8u4p9MeUSVpiNpmsXA2zEgK6kyhy6kZj8JpNU5t98NP8AR2e5wbf9Am8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ffe276-69db-4a42-aedc-08dec59daac5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 20:36:50.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFVGnvWDIRjYXKdCf0IjYV9xw9AdvgLziQTnlfhdBf0kRS1WfFjF6dH+mNKqnOF9cC2jAq3lG9h58YpJJ3tqbxrePER1yfyxHpP3pAdflos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

On Wed, Jun 03, 2026 at 05:04:19PM -0700, Dave Jiang wrote:
> 
> 
> On 5/29/26 5:00 PM, Alison Schofield wrote:
> > Add a cxl_test topology for mixed-granularity region coverage.
> > 
> > modprobe cxl_test mixed_gran_regions=1 creates three host bridges
> > with two switch levels below each bridge and twelve endpoints total.
> > The topology advertises one 2-way root CFMWS for power-of-2
> > mixed-granularity tests and one 3-way root CFMWS for 3-way-family
> > tests.
> > 
> > Leave the default and existing specialty topologies unchanged.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> 
> $ make -j `nproc` M=tools/testing/cxl
> make[1]: Entering directory '/home/djiang5/git/kernel-review/tools/testing/cxl'
>   CC [M]  test/cxl.o
> test/cxl.c: In function ‘cxl_test_init’:
> test/cxl.c:2358:17: error: label ‘err_rch’ used but not defined
>  2358 |                 goto err_rch;
>       |
> 
> Applied against 7.1-rc6.

Thanks, found it!
That's a conflict introduced in a 7.1-rc6 fixup.
This v1 was based on 7.1-rc1. Working on a v2 based on 7.1-rc7.
(Note this is aiming beyond 7.2)


