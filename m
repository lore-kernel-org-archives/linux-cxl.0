Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2923A0
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789623; cv=fail; b=nfExZHQnfGn0fidse1uU28KKHpEcuH63XwMekAfDD75wcsmrCbdH7uGdPR0nQdPIl9X8C7xacxh77lTHFVBmqQSqulUb8ga1/A9/6ic3SOsPlIghvwjiD6TrNKiC+5BPnDsamkTwy1z3hifQ0yNvT9l8+l6lwSqKrqt4MHvXDP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789623; c=relaxed/simple;
	bh=u4qdzPu+anHx0uTdmmAn1Ut96XKWBp6vOF8zvBCNR9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JUWcnBj8iE5kTnvg9dCQjIlS5XTI1tH3A1AY/0EG6cxSoEXBW+qg39Yg87mHgp0QkI3HrlTALTEAhvZhNZJxGbIPrkkGJAWpI3729Qqer7RStHH2VlFZd7TLeznG0EufwoSY/HSpCZVcwNukt86ICuzrZp72N6iTCBq1Al8SfKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoeaGFpK; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoeaGFpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733789621; x=1765325621;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u4qdzPu+anHx0uTdmmAn1Ut96XKWBp6vOF8zvBCNR9k=;
  b=eoeaGFpKjV7YfcSZ9Jjn+OuYFNMQvROiBt9w9V98z8JQYQO9M2s14NhR
   UiO2TWuiCSMKUcZ2TgGRxmTL8BU3/1mR4/xNg6CNcv42dt2no6dbAiRRR
   RWhT6VnJDCrxTgHcrzh+mopJCAUcPKLPkL39ZIIzGne14HB9jODy2Zt0W
   p64eJysCBvTrO/Ia4m54h0G8zlvSf55qfn9Iqo9dSlD1YPtPJ5Tnc5sok
   SSshx3fFNKjI6J44A5XJXxQWxAfbAVgIW50iPYYRTZSRNGzCA8EWS4jSH
   Blm2XjJVS5sbhRNKuwMk6PlIOHm/Wm2ngRV/HFTsSp20Vk2L5BdhnlH0D
   Q==;
X-CSE-ConnectionGUID: lpdEq/d7TNWesNVqC/TYzg==
X-CSE-MsgGUID: nRK3FPBcQa6vnUGG90KJFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34170899"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34170899"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 16:13:40 -0800
X-CSE-ConnectionGUID: rFKQa22KRouaO7IOjJKY5w==
X-CSE-MsgGUID: +vb0Nn9XSgSkxN2fEfIFVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="100045151"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 16:13:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 16:13:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 16:13:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 16:13:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCNneh5gQ/6FHgMbNFRWnbdCZ4go12nAJdIorLCCr8H3vY2o5gnJRVl9PDDSkaUIZLDEljY98/aEnvYu95HAp79mgALjSK5NlYlOZ47R+n7RPnoUUNSexUpEe4SxMbws2hhMDkg0+CzcLuK+gMHgEZ0u3zNxWIlpHUKHlqoAoFzZryaNScsl5L7OtPuupzj2YgDWvbEXWloVK8YhQZT2/OUZMkc6v2hyWAE9SuOkxT67KtNaCpJ/8eiT3BFkynx+MlLHz0djWDEC6JqVhZY/NF0PMC7SlSVnML63ZguWV4ZtI8qFfSxLQtYonZEiGnzfefIjq6TTLBAlX4M/7Yw99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuWAKX/sFYiXGFn/OOks7IEBxl4rGaEGYO6MuJAPxuY=;
 b=g6b44lkMhKk+fIRF1fRojAcoxHq4+5SxnCROVWVNkUtXNTQyLBlq2F68fu5YIwG5dFrJgnx1/3Myy9J/YXw9WO+rwT2EKTp8jhWskbKwQNro5C6XDxceSJx2Dgbj+YKdQwZIl0M/g63elJgOxQXWajEh31+wKGfGJbhQr2rJQrqLZZ0VBTN3Mdp5qApP9wjsQnSxzVGCHUdf3xLlKDxVAPCqz2xEeKDFZ5XW1lPH4kKKtAMJ06Qx7zI9scP+n4ZSTEQEmXMywEXWYMUQYtPJQ8FAtMivqwDXLaYfpVPWiMnCAYLO51nJ0+CA6mc0iA3V+7uzhJCb64z3TlEi8FB+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5016.namprd11.prod.outlook.com (2603:10b6:510:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 00:13:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 00:13:35 +0000
Date: Mon, 9 Dec 2024 16:13:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: CXL Deadlock in 6.13
Message-ID: <675787ad8bc1_25073294b0@dwillia2-xfh.jf.intel.com.notmuch>
References: <67578028f3ced_18523729431@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67578028f3ced_18523729431@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a48aa9-8815-469f-180b-08dd18af7d05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i4unUn4skg1xQ2z6ZKJVTFBBt9QHLYeqcd7egjiHWFDtI+62VzKurOdepSP9?=
 =?us-ascii?Q?0uFDH0kw2nzOgvpR7hl9DvgB1OIyyZtsdpm6qwBgORqPZk1K8+phGMSj3fZ/?=
 =?us-ascii?Q?3zrmEQ0+Ck1Ns2Vhec6DFDoATM/195R+I6a0oekFN6G21UzHtsMMW/D1Gty9?=
 =?us-ascii?Q?EI0RwCiYCKdOH78l2K951txVGoHqoNsVrTJH4fwhUl0fImppWpYipdpy6Ub3?=
 =?us-ascii?Q?Si0Qlu3e8YpimisVRNHiPqgS7dA5IGarK2bd618pvWXHIpwKY/5w0/CblZdO?=
 =?us-ascii?Q?jwx3bf3ESMVGXbwgrwuKA4Fn49nN8cCzttdekwd9DFwESskSUopYy50+cL2D?=
 =?us-ascii?Q?QoCvBo+UrjfpBrBgIQbRFBjZqc3DFtZ/GyN5zVYRKX58f1I5c24AtF3o46PK?=
 =?us-ascii?Q?MnTpvjVeooXfj0LTJKQU99d0WEdTAjizwfUyQ0/IznTb/YkFmu6YoVTgIGf8?=
 =?us-ascii?Q?zEAONwcW0Qzff5KZpOcA3BBLrMPaJzQenVSEFhfT6no9DBp3wiRY10KNLbg3?=
 =?us-ascii?Q?BptjzEkpi2C1uypD6j0OuE2qyyec+UvA6PxqI0sv7XV/Y6DmskQH169vo7f1?=
 =?us-ascii?Q?6H9OXVaxIe5g7q61tXTS6WwCEREYs1uaxi9b4IhIaes+GUWCYlpLpvuNVyUr?=
 =?us-ascii?Q?YfAm90ThncbDv4KJ+umP0+kO1wjEZIEosZzf77zNszpMUxXmqYaciZJ5c2ki?=
 =?us-ascii?Q?x5sl4SqlJ2LQTvo/YEjDT1NrDzg2aieaYprLJqhbu7AuLfdUL5KSZNnRQLaJ?=
 =?us-ascii?Q?J0HY+VqzQZbqjW87H3qN3Z0Vz/AkfeiNR25lXSSzKYYdSowQZbWDb0L5yDg2?=
 =?us-ascii?Q?aSmBG0vpVYU7ZRRUnm0ACZwqIBQc8kCB5sYONSwm9DFJEBU0I2laY9VMs7Wl?=
 =?us-ascii?Q?MZF3YxmuYc8S55gunHJtTmVb0grgU+GfZMn2Y8QDDwriSNIm9O13adO3Gj4z?=
 =?us-ascii?Q?YpOtCZT1F8a54K3OH53ehqBlrPjA9KvLXuLyH+nXQ792Fc++6j9VF8KqpFFg?=
 =?us-ascii?Q?ifE/ksVJsoeQ6YhSCFTm7IRbw14N3NHJWnhGTmuFeQXzuMEVyy+1CgMgjBRc?=
 =?us-ascii?Q?7A8w0Mzv+mGAPKOgr3Om4YDZeDHKGhEWM+Mhb23OSGRCzymE8zClgdpZCXT/?=
 =?us-ascii?Q?uljD99G2XrzBXZuiVeIFrqFWBA/ZYJj024Vb+tIfBaAHZCS8EekpMG/kXORK?=
 =?us-ascii?Q?+ycGri3Zc0mGmbX8ngFimBMjXCkvswTEn482U2BhHMsvfBCH0nElgskCOoZO?=
 =?us-ascii?Q?bB6Qn/VflqiZorEK09YS5Rb4oy7pLyR7ntkkWNe13YK9bOoD0U4vgUTSllhg?=
 =?us-ascii?Q?VDMHa75pXQyVTGOlG+N+Z/H1LHcj6Rarp6/scn29Z8tXP5C5UpmbgI1qw00c?=
 =?us-ascii?Q?zHDUn/k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jQwtsjpnwghSVvq3yiJwTiKxOT7mT+2udNZzD4LqaI8ogcoTY4dfGFhnNtd?=
 =?us-ascii?Q?gv699uY6k7uVoXrWdpE1qoLAk97Gu8TSHrQJmUsOydH2/MMq77Y0HcFptNjM?=
 =?us-ascii?Q?KA/9tap3qxkjvnnratbGGa4Jm2EVRqkX+M2frh4HvzCJKf0LRM477tyvpdpC?=
 =?us-ascii?Q?poI2zMB+pFEp/2UYrt7q2NL+m3gTUH9l35hi0aczv/3SVzPLFWtFPMGLBTqV?=
 =?us-ascii?Q?qUWGYrl0L2gHniNm6t0jbFdG77+3tqd4GdbNfTzyi66gy8iweoT7HhQwbW1o?=
 =?us-ascii?Q?dvhsXyqBs++KJMY8OfSe2ebx5QyJhz6sBoUErVWb0qmk4cEhKCJunEnsHg69?=
 =?us-ascii?Q?lDv23xtwImHhUWQEGTonBKcTEru+O+I04SF9AWi2SmqDP/5vllT5c/y0ofsX?=
 =?us-ascii?Q?Imob+JXNssEx8/kstWV7dFebyfdwgAIQya21bhOwWSErIH6CAuzJArxXbBQG?=
 =?us-ascii?Q?BO7+6O81wiz616Fhsh7D5Lr82Up1/BmBi+J189NBgp0ZL5bzkPws5N64Q8z7?=
 =?us-ascii?Q?F39VA9eRxN4AXDBsLIlp9983e6zvFkD1tl4DFeFywQ1FZnoKLwaikuGYC2uZ?=
 =?us-ascii?Q?8/oT1tAyvxKKasJVGk917I6dOo+8epE3chkoM1l0ypy3fEAffQnMZ1AxHA5z?=
 =?us-ascii?Q?KL2kU71YyMB0B4EqdY59QtC5jcHRXi9Vu1d2tXC7+IzuPSp3kXbH9uhQi/7f?=
 =?us-ascii?Q?ePGTFP2e9TzcyslfoV2CrIulKFdhkH4O8sFy6GgB4VYSf497nJL7n3SpzD9J?=
 =?us-ascii?Q?TUemHtbDX7gpUrRIMFFs+/odCDPEWgVz90wHMQXVGePhfEW9Nwm1ec1bJir4?=
 =?us-ascii?Q?6qaN0mC/j4Zy5pnmjwg4rgNRdn06zJ/mxdvrZtdtdYVHf5xpTR6XAZzHyitx?=
 =?us-ascii?Q?FETsCioHldrGV3veUIIAtKjpo4z3M+TlwABt49GiFkeUYQqwI1IrvDXYL3Tp?=
 =?us-ascii?Q?DkNCP5zMNzWwvFxLO8oIJKdLUpDAucOurQVxlIGmMYH/dXiQ+SSK7b9b5lBC?=
 =?us-ascii?Q?b7cwWtVb59/X3fwaOqNGcQlOlIcDM2EkvGw06dyYJWMz+ICH1+7Ws3IaJIqZ?=
 =?us-ascii?Q?C8z0IpOJl/r5aZoAoSyd5MMzbTLL3ymHuqezyJsnyvCdTWLrwzHg4nE8J4Z0?=
 =?us-ascii?Q?tANSkdqjQQ9QeSGmM41OHLa7XCyExy3XQos7SWSIHXj4gV/aErYurh6DwmVF?=
 =?us-ascii?Q?9pQr4zuK6u0ZtEWluOR+urcoNhzOPxRr8PCeMt4+rl2ocu/SbxE07M3JdrF8?=
 =?us-ascii?Q?V70L/61/lkkPeX8uwV4Su4cEC6i0j3ROVCsWsa3wwSmxexRkCvfFtuy8IEeo?=
 =?us-ascii?Q?qHImzYgvM/O1KRScW3rBFAJlm0bLVhrJAPc/nILLtxV8sHEoak5vJzMXVs+a?=
 =?us-ascii?Q?m+IgrB0M/EcdUP1xM6pPnEr+FFCCEY+vSzeB+v9dCjjzKRqFqV79MdPaFh78?=
 =?us-ascii?Q?/oPk/y2F7CJxgc49l7Pb+WdDgqusXrWr0x5Tr3vhFThGJP8poCpEBJxjqmqM?=
 =?us-ascii?Q?ks6CIwFrvoOyJEAX1YUbW/Mwj0ihtg42TfPBJMGngIFJxSwT1oUls8xZk9gJ?=
 =?us-ascii?Q?OEaaN200Eq0AXdk/xBKr8bgX7BLRpNLD2JOBpaIH12kJdJu4IwJhPyh+iUHa?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a48aa9-8815-469f-180b-08dd18af7d05
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 00:13:35.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jyFQ7aR7GXQg91NNkfRQinQM4yUTGGJN8b2XPS+39OEo+5pubET+CYMDFaj+Tb/LhxhO+e2g8Sxj52ryNs/U67wFIgyjK38zShOGyuXjFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5016
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> I've been noticing a deadlock with the DCD patch series rebased on 6.13.
> I bisected this a couple of times and each time I bisect the issue I land
> on a patch which 1) does not appear to have anything to do with locking
> and 2) was different from the last bisect result!
> 
> After narrowing down what was failing in DCD I got cxl-create-region.sh to
> fail.  After looping it on 6.13 master[0] I got the following deadlock.[1]
> 
> Also NOTE the WARNING from device_lock_set_class() in cxl/acpi.c.
> 
> Any clue what has changed for 6.13?

Yes, this was expected fallout from this:

http://lore.kernel.org/672016f35ed5d_bc69d2946a@dwillia2-xfh.jf.intel.com.notmuch

...i.e. the lockdep splat is theoretical while the regression the
attempted fix caused was impacting real use cases.
